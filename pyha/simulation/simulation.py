import logging
import subprocess
import sys, os
import time
from contextlib import suppress

import matplotlib.pyplot as plt
import numpy as np
from tqdm import tqdm
from wurlitzer import pipes

from pyha import default_sfix, default_complex, Hardware
from pyha.common.context_managers import SimulationRunning, RegisterBehaviour, AutoResize, ContextManagerRefCounted, \
    SimPath
from pyha.common.util import get_iterable
from pyha.conversion.conversion import Converter
from pyha.conversion.type_transforms import init_vhdl_type
from pyha.synthesis.quartus import make_quartus_project, QuartusDockerWrapper

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('sim')


class Simulator:
    MODEL, PYHA, RTL, NETLIST = 0, 1, 2, 3

    def __init__(self, model, trace=False, extra_simulations=[], output_dir=None, pipeline_flush=0):
        self.pipeline_flush = pipeline_flush
        self.output_dir = output_dir
        self.extra_simulations = extra_simulations
        self.model = model
        self.trace = trace
        self.out = np.array([])  # shape is determined by the return size of model simulation
        self.hardware_delay = 0
        self.trace_data = None
        self.quartus = None

    def _handle_output(self, model_output):
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
                    return model_output.data._pyha_to_python_value()
                else:
                    return []
            except AttributeError:
                try:
                    # not DataValid, some Pyha type?
                    return model_output._pyha_to_python_value()
                except AttributeError:
                    # not Pyha type. For example maybe an bultin e.g int
                    return model_output

    def run(self, *inputs):
        Tracer.traced_objects.clear()
        if self.trace:
            self.model._pyha_insert_tracer(label='self')
        elif 'RTL' in self.extra_simulations or 'NETLIST' in self.extra_simulations:
            logger.info(f'Simulaton needs to support conversion to VHDL -> major slowdown')
            self.model._pyha_enable_function_profiling_for_types()

        with SimulationRunning.enable():
            logger.info(f'Running "MODEL" simulation...')
            if not hasattr(self.model, 'model_main'):
                logger.info('SKIPPING **MODEL** simulations -> no "model_main()" found')
                self.out = np.ndarray(shape=(4, len(inputs[0])), dtype=np.object)
            else:
                model_result = np.array(self.model.model_main(*inputs))
                self.out = np.ndarray(shape=((4,) + model_result.shape), dtype=model_result.dtype)
                self.out[Simulator.MODEL] = model_result

            logger.info(f'Running "PYHA" simulation...')
            if hasattr(self.model, '_pyha_simulation_input_callback'):
                inputs = self.model._pyha_simulation_input_callback(inputs)
            else:
                args = convert_input_types(inputs, None)

                def transpose(args):
                    try:
                        return [x for x in zip(*args)]
                    except TypeError:
                        return [args]

                inputs = transpose(args)

            self.inputs_and_flush = inputs
            if self.pipeline_flush:
                # duplicate input args to flush pipeline
                target_len = len(inputs) + self.pipeline_flush
                inputs += inputs * int(np.ceil(self.pipeline_flush / len(inputs)))
                self.inputs_and_flush = inputs[:target_len]

            valid_samples = 0
            tick_counter = 0
            with RegisterBehaviour.enable():
                with AutoResize.enable():
                    for input in tqdm(self.inputs_and_flush, file=sys.stderr):
                        returns = self.model.main(*input)
                        returns = self._handle_output(returns)
                        if returns != [] and tick_counter >= self.pipeline_flush:
                            self.out[Simulator.PYHA][valid_samples] = returns
                            valid_samples += 1
                        else:
                            lol = 1
                            pass

                        self.model._pyha_update_registers()
                        tick_counter += 1

                    if valid_samples != len(self.out[Simulator.MODEL]):
                        logger.info(
                            f'Flushing the pipeline to collect {len(self.out[Simulator.MODEL])} valid samples (currently have {valid_samples})')
                        hardware_delay = 0
                        while valid_samples != len(self.out[Simulator.MODEL]):
                            hardware_delay += 1
                            returns = self.model.main(*inputs[-1])
                            returns = self._handle_output(returns)
                            if returns != []:
                                self.out[Simulator.PYHA][valid_samples] = returns
                                valid_samples += 1
                            self.model._pyha_update_registers()
                            tick_counter += 1

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
            if len(arguments) == 1:
                l = [init_vhdl_type('-', arguments[0], arguments[0])._pyha_serialize()]
            # l = [init_vhdl_type('-', arguments, arguments)._pyha_serialize()]
            else:
                l = [init_vhdl_type('-', arg, arg)._pyha_serialize() for arg in arguments]
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

        res = [self._handle_output(x) for x in outp][self.pipeline_flush:]
        return np.array(res).flatten()

    def plot_trace(self, mode=None, skip_first_n=0, inout_only=False, **kwargs):
        if not mode:
            mode = {'Input': 'time', 'Output': 'time'}
        for i, (k, v) in enumerate(self.trace_data.items()):
            if i == 0:
                if not mode['Input']:
                    pass
                Plotter().plot(v[:, skip_first_n:], mode['Input'], name='Input', **kwargs)
            elif i == len(self.trace_data) - 1:
                if not mode['Output']:
                    pass
                Plotter().plot(v[:, skip_first_n:], mode['Output'], name='Output', **kwargs)
            elif not inout_only:
                Plotter().plot(v[:, skip_first_n:], mode='time', name=k, **kwargs)

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
