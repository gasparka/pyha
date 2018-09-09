import logging
import subprocess
import sys, os
import time
import matplotlib.pyplot as plt
import numpy as np
from tqdm import tqdm
from wurlitzer import pipes

from pyha.common.context_managers import SimulationRunning, RegisterBehaviour, AutoResize
from pyha.conversion.conversion import Converter
from pyha.conversion.type_transforms import init_vhdl_type
from pyha.cores.util import snr

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('sim')


class Tracer:
    traced_objects = []

    def __init__(self, func, tracer_type, owner=None, label=None):
        self.label = label
        self.owner = owner
        self.tracer_type = tracer_type
        self.func = func

        self.input = []
        self.output = []
        self.return_time = None
        self.call_time = None
        if owner not in Tracer.traced_objects:
            Tracer.traced_objects.append(owner)

    def __call__(self, *args, **kwargs):
        if self.call_time is None:
            self.call_time = time.time()

        res = self.func(*args, **kwargs)

        if self.return_time is None:
            self.return_time = time.time()

        try:
            if self.tracer_type == 'model_main':
                self.input = np.array(args[0])
                self.output = np.array(res)
                self.return_time = time.time()
            elif self.tracer_type == 'main':
                if args[0].valid:
                    self.input.append(args[0].data._pyha_to_python_value())

                if res.valid:
                    self.output.append(res.data._pyha_to_python_value())
        except IndexError:
            pass
        return res

    @classmethod
    def get_sorted_traces(cls):
        class Tmp:
            def __init__(self, data_model, data_pyha, label, time):
                self.type = type
                self.data_model = data_model
                self.data_pyha = data_pyha[:len(data_model)]
                self.dir = dir
                self.time = time
                self.label = label

        ll = []
        for x in cls.traced_objects:
            try:
                model = x.model_main
                main = x.main
                if not model.call_time or not main.call_time:
                    logger.info(f'TRACE: Skipping {model.label} because model or main was not called...')
                    continue
                ll.append(Tmp(model.input, main.input, f'In: {model.label}', model.call_time))
                ll.append(Tmp(model.output, main.output, f'Out: {model.label}', model.return_time))
            except AttributeError as e:
                print(e)
                continue

        time_sorted = sorted(ll, key=lambda x: x.time)

        ll = [time_sorted[0]]  # always include first input
        for x in time_sorted:
            if not np.array_equal(x.data_model, ll[-1].data_model):
                ll.append(x)

        ret = {x.label: np.array([x.data_model, x.data_pyha]) for x in ll}
        return ret


class Plotter:
    def __init__(self):
        pass

    def plot(self, simulations, mode='time', name=''):
        MODEL, PYHA = 0, 1
        if mode == 'time':
            if isinstance(simulations[MODEL][0], float):
                fig, ax = plt.subplots(2, sharex="all", figsize=(17, 7), gridspec_kw={'height_ratios': [4, 2]})

                if name:
                    fig.suptitle(name, fontsize=14, fontweight='bold')
                ax[0].plot(simulations[MODEL], label='MODEL')
                ax[0].plot(simulations[PYHA], label='PYHA')
                ax[0].set(title=f'SNR={snr(simulations[MODEL], simulations[PYHA]):.2f} dB')
                ax[0].set_xlabel('Sample')
                ax[0].set_ylabel('Magnitude')
                ax[0].grid(True)
                ax[0].legend()

                ax[1].plot(simulations[MODEL] - simulations[PYHA], label='Error')
                ax[1].grid(True)
                ax[1].legend()

        elif mode == 'frequency' or mode == 'frequency_response':
            gain = 1.0
            if mode == 'frequency_response':
                gain = len(simulations[MODEL])

            fig, ax = plt.subplots(2, sharex="all", figsize=(17, 7), gridspec_kw={'height_ratios': [4, 2]})

            if name:
                fig.suptitle(name, fontsize=14, fontweight='bold')

            spec_model, freq, _ = ax[0].magnitude_spectrum(simulations[MODEL]*gain, window=plt.mlab.window_none,
                                                           scale='dB', label='MODEL')
            spec_pyha, _, _ = ax[0].magnitude_spectrum(simulations[PYHA]*gain, window=plt.mlab.window_none, scale='dB',
                                                       label='PYHA')
            ax[0].set(title=f'SNR={snr(simulations[MODEL], simulations[PYHA]):.2f} dB')
            ax[0].grid(True)
            ax[0].legend()

            ax[1].plot(freq, spec_model - spec_pyha, label='Error')
            ax[1].grid(True)
            ax[1].legend()

        plt.show()


class Simulator:
    def __init__(self, model, trace=False, extra_simulations=None, output_dir=None):
        self.output_dir = output_dir
        self.extra_simulations = extra_simulations
        self.model = model
        self.trace = trace
        self.out = np.array([])  # shape is determined by the return size of model simulation
        self.hardware_delay = 0
        self.trace_data = None


    def run(self, *inputs):

        if self.trace:
            Tracer.traced_objects.clear()
            self.model._pyha_insert_tracer(label='self')
        elif 'RTL' in self.extra_simulations or 'NETLIST' in self.extra_simulations:
            logger.info(f'Simulaton needs to support conversion to VHDL -> major slowdown')
            self.model._pyha_enable_function_profiling_for_types()

        with SimulationRunning.enable():
            logger.info(f'Running "MODEL" simulation...')
            model_result = self.model.model_main(*inputs)
            self.out = np.ndarray(shape=((4,) + model_result.shape))
            self.out[0] = model_result

            logger.info(f'Running "PYHA" simulation...')
            inputs = self.model._pyha_simulation_input_callback(inputs)
            valid_samples = 0
            with RegisterBehaviour.enable():
                with AutoResize.enable():
                    for input in tqdm(inputs, file=sys.stderr):
                        returns = self.model.main(input)
                        if returns.valid:
                            self.out[1][valid_samples] = returns.data._pyha_to_python_value()
                            valid_samples += 1
                        self.model._pyha_update_registers()

                    logger.info(
                        f'Flushing the pipeline to collect {len(self.out[1])} valid samples (currently have {valid_samples})')
                    hardware_delay = 0
                    while valid_samples != len(self.out[1]):
                        hardware_delay += 1
                        returns = self.model.main(inputs[-1])
                        if returns.valid:
                            self.out[1][valid_samples] = returns.data._pyha_to_python_value()
                            valid_samples += 1
                        self.model._pyha_update_registers()

                    self.hardware_delay = hardware_delay
                    logger.info(f'Hardware delay is {self.hardware_delay}')

        self.inputs = inputs
        if self.trace:
            self.trace_data = Tracer.get_sorted_traces()

        if 'RTL' in self.extra_simulations:
            self.converter = Converter(self.model, self.output_dir)
            logger.info(f'Running "RTL" simulation...')
            self.out[2] = self._run_ghdl_cocotb()

        return self

    def _run_ghdl_cocotb(self, netlist=None, verbose=False):
        """ RTL simulator with GHDL and COCOTB. This requires that MODEL and PYHA simulations already ran.
        Inputs to the simulator are 'pipeline compensated' from PYHA simulation.
        """
        indata = []
        for arguments in self.inputs:
            # if len(arguments) == 1:
                # l = [init_vhdl_type('-', arguments[0], arguments[0])._pyha_serialize()]
            l = [init_vhdl_type('-', arguments, arguments)._pyha_serialize()]
            # else:
                # l = [init_vhdl_type('-', arg, arg)._pyha_serialize() for arg in arguments]
            indata.append(l)

        np.save(str(self.converter.base_path / 'input.npy'), indata)

        # make sure output file does not exist
        out_path = str(self.converter.base_path / 'output.npy')
        if os.path.exists(out_path):
            os.remove(out_path)

        if netlist:
            src = '.' +  netlist[len(str(self.converter.base_path)):] # need relative path!
            ghdl_args = '-P/quartus_sim_lib/ --ieee=synopsys --no-vital-checks'
        else:
            src = ' '.join(self.converter.get_vhdl_sources_relative())
            ghdl_args = '--std=08'

        cmd = f"docker run " \
              f"-u `id -u` " \
              f" -v {self.converter.base_path}:/pyha_simulation gasparka/pyha_simulation_env make " \
              f"VHDL_SOURCES=\"{src}\" " \
              f"OUTPUT_VARIABLES=\"{str(len(self.converter.get_top_module_outputs()))}\" " \
              f"GHDL_ARGS=\"{ghdl_args}\" "

        with pipes(stdout=sys.stdout if verbose else None, stderr=sys.stderr):
            subprocess.run(cmd, shell=True)

        out = np.load(out_path)
        outp = out.astype(object).T

        for i, row in enumerate(outp):
            for j, val in enumerate(row):
                outp[i][j] = self.converter.get_top_module_outputs()[i]._pyha_deserialize(val)

        outp = np.squeeze(outp)  # example [[1], [2], [3]] -> [1, 2, 3]
        outp = outp.T.tolist()

        # convert second level lists to tuples if dealing with 'multiple returns'
        if len(self.converter.get_top_module_outputs()) > 1:
            for i, row in enumerate(outp):
                try:
                    outp[i] = tuple(outp[i])
                except TypeError:  # happend when outp[i] is single float
                    outp[i] = [outp[i]]

        return np.array([x.data for x in outp if x.valid])

    def plot_trace(self, mode=None):
        if not mode:
            mode = {'Input': 'time', 'Output': 'time'}
        for i, (k, v) in enumerate(self.trace_data.items()):
            if i == 0:
                Plotter().plot(v, mode['Input'], name='Input')
            elif i == len(self.trace_data)-1:
                Plotter().plot(v, mode['Output'], name='Output')
            else:
                Plotter().plot(v, mode, name=k)

