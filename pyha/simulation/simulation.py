import logging
import subprocess
import sys, os
import time
import matplotlib.pyplot as plt
import numpy as np
from tqdm import tqdm
from wurlitzer import pipes

from pyha.common.context_managers import SimulationRunning, RegisterBehaviour, AutoResize, ContextManagerRefCounted
from pyha.conversion.conversion import Converter
from pyha.conversion.type_transforms import init_vhdl_type
from pyha.synthesis.quartus import make_quartus_project, QuartusDockerWrapper

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('sim')


class Tracer:
    traced_objects = []
    _enable = ContextManagerRefCounted()

    @staticmethod
    def is_enabled():
        return len(Tracer.traced_objects)

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

        tmp = []
        for x in cls.traced_objects:
            try:
                model = x.model_main
                main = x.main
                if not model.call_time or not main.call_time:
                    logger.info(f'TRACE: Skipping {model.label} because model or main was not called...')
                    continue
                tmp.append(Tmp(model.input, main.input, f'In: {model.label}', model.call_time))
                tmp.append(Tmp(model.output, main.output, f'Out: {model.label}', model.return_time))
            except AttributeError as e:
                print(e)
                continue

        time_sorted = sorted(tmp, key=lambda x: x.time)

        # remove duplicate traces e.g. input of a block is same as previous output!
        tmp = [time_sorted[0]]  # always include first input
        for x in time_sorted:
            if not np.array_equal(x.data_model, tmp[-1].data_model) or not np.array_equal(x.data_pyha, tmp[-1].data_pyha):
                tmp.append(x)

        ret = {x.label: np.array([x.data_model, x.data_pyha]) for x in tmp}
        return ret


class Plotter:
    def __init__(self):
        pass

    def plot(self, simulations, mode='time', name=''):
        from pyha.cores.util import snr
        MODEL, PYHA = 0, 1
        figsize = (9.75, 5)
        if mode == 'time':
            if isinstance(simulations[MODEL][0], float):
                fig, ax = plt.subplots(2, sharex="all", figsize=figsize, gridspec_kw={'height_ratios': [4, 2]})

                if name:
                    fig.suptitle(name, fontsize=14, fontweight='bold')
                ax[0].plot(simulations[MODEL], label='MODEL')
                ax[0].plot(simulations[PYHA], label='PYHA')
                ax[0].set(title=f'SNR={snr(simulations[MODEL], simulations[PYHA]):.2f} dB')
                ax[0].set_xlabel('Sample')
                ax[0].set_ylabel('Magnitude')
                ax[0].grid(True)
                ax[0].legend(loc='upper right')

                ax[1].plot(simulations[MODEL] - simulations[PYHA], label='Error')
                ax[1].grid(True)
                ax[1].legend(loc='upper right')
            elif isinstance(simulations[MODEL][0], complex):
                fig, ax = plt.subplots(2, 2, sharex="all", figsize=figsize, gridspec_kw={'height_ratios': [4, 2]})

                if name:
                    fig.suptitle(name, fontsize=14, fontweight='bold')
                ax[0][0].plot(simulations[MODEL].real, label='MODEL')
                ax[0][0].plot(simulations[PYHA].real, label='PYHA')
                ax[0][0].set(title=f'REAL SNR={snr(simulations[MODEL].real, simulations[PYHA].real):.2f} dB')
                ax[0][0].set_xlabel('Sample')
                ax[0][0].set_ylabel('Magnitude')
                ax[0][0].grid(True)
                ax[0][0].legend(loc='upper right')

                ax[1][0].plot(simulations[MODEL].real - simulations[PYHA].real, label='Error')
                ax[1][0].grid(True)
                ax[1][0].legend(loc='upper right')

                ax[0][1].plot(simulations[MODEL].imag, label='MODEL')
                ax[0][1].plot(simulations[PYHA].imag, label='PYHA')
                ax[0][1].set(title=f'IMAG SNR={snr(simulations[MODEL].imag, simulations[PYHA].imag):.2f} dB')
                ax[0][1].set_xlabel('Sample')
                ax[0][1].set_ylabel('Magnitude')
                ax[0][1].grid(True)
                ax[0][1].legend(loc='upper right')

                ax[1][1].plot(simulations[MODEL].imag - simulations[PYHA].imag, label='Error')
                ax[1][1].grid(True)
                ax[1][1].legend(loc='upper right')

        elif mode == 'frequency' or mode == 'frequency_response':
            gain = 1.0
            window = plt.mlab.window_hanning
            if mode == 'frequency_response':
                gain = len(simulations[MODEL])
                window = plt.mlab.window_none
                if isinstance(simulations[MODEL][0], complex):
                    gain *= 0.707


            fig, ax = plt.subplots(2, sharex="all", figsize=figsize, gridspec_kw={'height_ratios': [4, 2]})

            if name:
                fig.suptitle(name, fontsize=14, fontweight='bold')

            spec_model, freq, _ = ax[0].magnitude_spectrum(simulations[MODEL] * gain,
                                                           window=window,
                                                           scale='dB', label='MODEL')
            spec_pyha, _, _ = ax[0].magnitude_spectrum(simulations[PYHA] * gain,
                                                       window=window,
                                                       scale='dB',
                                                       label='PYHA')
            ax[0].set(title=f'SNR={snr(simulations[MODEL], simulations[PYHA]):.2f} dB')
            ax[0].grid(True)
            ax[0].legend(loc='upper right')

            ax[1].plot(freq, 20*np.log10(spec_model) - 20*np.log10(spec_pyha), label='Error')
            ax[1].grid(True)
            ax[1].legend(loc='upper right')

        plt.tight_layout(rect=[0, 0, 1, 0.95])
        plt.show()


class Simulator:
    MODEL, PYHA, RTL, NETLIST = 0, 1, 2, 3
    def __init__(self, model, trace=False, extra_simulations=[], output_dir=None):
        self.output_dir = output_dir
        self.extra_simulations = extra_simulations
        self.model = model
        self.trace = trace
        self.out = np.array([])  # shape is determined by the return size of model simulation
        self.hardware_delay = 0
        self.trace_data = None
        self.quartus = None

    def run(self, *inputs):
        def handle_output(model_output):
            if isinstance(model_output, tuple):  # multiple return
                try:
                    # DataValid?
                    return [val.data._pyha_to_python_value() for val in model_output if val.valid]
                except AttributeError:
                    try:
                        # not DataValid, some Pyha type?
                        return [val._pyha_to_python_value() for val in model_output]
                    except AttributeError:
                        # not Pyha type. For example maybe an bultin e.g int
                        return model_output
            else:
                try:
                    # DataValid?
                    if model_output.valid:
                        return [model_output.data._pyha_to_python_value()]
                    else:
                        return []
                except AttributeError:
                    try:
                        # not DataValid, some Pyha type?
                        return [model_output._pyha_to_python_value()]
                    except AttributeError:
                        # not Pyha type. For example maybe an bultin e.g int
                        return [model_output]

        Tracer.traced_objects.clear()
        if self.trace:
            self.model._pyha_insert_tracer(label='self')
        elif 'RTL' in self.extra_simulations or 'NETLIST' in self.extra_simulations:
            logger.info(f'Simulaton needs to support conversion to VHDL -> major slowdown')
            self.model._pyha_enable_function_profiling_for_types()

        with SimulationRunning.enable():
            logger.info(f'Running "MODEL" simulation...')
            model_result = np.array(self.model.model_main(*inputs))
            if model_result.ndim == 1: # single return channel -> need to expand_dims
                model_result = np.expand_dims(model_result, axis=0)
                self.out = np.ndarray(shape=((4,) + model_result.shape), dtype=model_result.dtype)
            self.out[Simulator.MODEL] = model_result

            logger.info(f'Running "PYHA" simulation...')
            inputs = self.model._pyha_simulation_input_callback(inputs)
            valid_samples = 0
            with RegisterBehaviour.enable():
                with AutoResize.enable():
                    for input in tqdm(inputs, file=sys.stderr):
                        returns = self.model.main(*input)
                        returns = handle_output(returns)
                        if returns:
                            self.out[Simulator.PYHA, :, valid_samples] = returns
                            valid_samples += 1

                        self.model._pyha_update_registers()

                    logger.info(
                        f'Flushing the pipeline to collect {len(self.out[Simulator.MODEL, -1])} valid samples (currently have {valid_samples})')
                    hardware_delay = 0
                    while valid_samples != len(self.out[Simulator.MODEL, -1]):
                        hardware_delay += 1
                        returns = self.model.main(*inputs[-1])
                        returns = handle_output(returns)
                        if returns:
                            self.out[Simulator.PYHA, :, valid_samples] = returns
                            valid_samples += 1
                        self.model._pyha_update_registers()

                    self.hardware_delay = hardware_delay
                    logger.info(f'Hardware delay is {self.hardware_delay}')

        self.inputs_and_flush = np.array(inputs.tolist() + [inputs[-1]] * self.hardware_delay)
        if self.trace:
            self.trace_data = Tracer.get_sorted_traces()

        if 'RTL' in self.extra_simulations:
            self.converter = Converter(self.model, self.output_dir).to_vhdl()
            logger.info(f'Running "RTL" simulation...')
            self.out[Simulator.RTL] = self._run_ghdl_cocotb()

        if 'NETLIST' in self.extra_simulations:
            if not self.converter:
                self.converter = Converter(self.model, self.output_dir).to_vhdl()

            logger.info(f'Running "NETLIST" simulation...')
            make_quartus_project(self.converter)
            self.quartus = QuartusDockerWrapper(self.converter.base_path)
            self.out[Simulator.NETLIST] = self._run_ghdl_cocotb(netlist=self.quartus.get_netlist())

        return self

    def _run_ghdl_cocotb(self, netlist=None, verbose=False):
        """ RTL simulator with GHDL and COCOTB. This requires that MODEL and PYHA simulations already ran.
        Inputs to the simulator are 'pipeline compensated' from PYHA simulation.
        """
        indata = []
        for arguments in self.inputs_and_flush:
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
            src = '.' + netlist[len(str(self.converter.base_path)):]  # need relative path!
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

        print('\n', file=sys.stderr)

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

    def plot_trace(self, mode=None, skip_first_n=0, inout_only=False):
        if not mode:
            mode = {'Input': 'time', 'Output': 'time'}
        for i, (k, v) in enumerate(self.trace_data.items()):
            if i == 0:
                Plotter().plot(v[:, skip_first_n:], mode['Input'], name='Input')
            elif i == len(self.trace_data) - 1:
                Plotter().plot(v[:, skip_first_n:], mode['Output'], name='Output')
            elif not inout_only:
                Plotter().plot(v[:, skip_first_n:], mode='time', name=k)

    def assert_equal(self, rtol=1e-05, atol=1e-30):
        """
        Compare the results of ``simulate`` function.

        :param simulations: Output of 'simulate' function
        :param rtol: 1e-1 = 10% accuracy, 1e-2= 1% accuracy...
        :param atol: Tune this when numbers close to 0 are failing assertions. Default assumes that inputs are in range of [-1,1] and 18 bits.
        """
        from numpy.testing import assert_allclose
        logger.info(f'Testing that PYHA and MODEL are close(atol={atol}, rtol={rtol})')
        assert_allclose(self.out[Simulator.PYHA], self.out[Simulator.MODEL], rtol, atol)

        # hardware simulations must be EXACTLY equal
        if 'RTL' in self.extra_simulations:
            logger.info(f'Testing that RTL is *exactly* equal to PYHA')
            assert_allclose(self.out[Simulator.RTL], self.out[Simulator.PYHA], rtol=1e-32, atol=1e-32)

        if 'NETLIST' in self.extra_simulations:
            logger.info(f'Testing that NETLIST is *exactly* equal to PYHA')
            assert_allclose(self.out[Simulator.NETLIST], self.out[Simulator.PYHA], rtol=1e-32, atol=1e-32)