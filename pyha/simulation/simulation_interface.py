import logging
import os
import shutil
import sys
from contextlib import suppress
from copy import deepcopy
from pathlib import Path
from tempfile import TemporaryDirectory

import numpy as np
from tqdm import tqdm

from pyha import Hardware
from pyha.common.complex import default_complex
from pyha.common.context_managers import RegisterBehaviour, SimulationRunning, SimPath, AutoResize
from pyha.common.fixed_point import Sfix, default_sfix
from pyha.common.util import get_iterable, np_to_py
from pyha.conversion.python_types_vhdl import init_vhdl_type
from pyha.simulation.vhdl_simulation import VHDLSimulation

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('sim')


def convert_input_types(args, to_types=None, silence=False, input_callback=None):
    if not silence:
        logger.info(f'Converting simulation inputs to hardware types...')

    def convert_arg(default_type, arg, i):
        # args_orig = deepcopy(args[i])
        t = default_type
        if to_types is not None:
            t = to_types[i]

        ret = [t(x) for x in arg]
        # if not silence:
        #     l = pd.DataFrame({'original': args_orig, 'converted': ret})
        #     logger.debug(f'Converted {i}. input:\n {l}')
        return ret

    args = list(args)

    def is_list(x):
        return isinstance(x, (list, np.ndarray))

    with SimPath('inputs'):
        for i, arg in enumerate(args):
            arg = get_iterable(arg)

            if to_types is not None and not is_list(arg[0]):
                args[i] = convert_arg(None, arg, i)
            elif any(isinstance(x, (float, np.floating)) for x in arg):
                args[i] = convert_arg(default_sfix, arg, i)

            elif any(isinstance(x, (complex, np.complexfloating)) for x in arg):
                args[i] = convert_arg(default_complex, arg, i)

            elif isinstance(arg[0], Hardware):
                for x in arg:
                    x._pyha_floats_to_fixed()

            elif is_list(arg[0]):
                # input is 2D array -> turn into packets (1D list of Stream objects)
                args[i] = convert_input_types(arg, silence=True, to_types=to_types)  # dont apply input callback here..

    if input_callback:
        for i in range(len(args)):
            args[i] = input_callback(args[i])

    return args


def transpose(args):
    try:
        return [x for x in zip(*args)]
    except TypeError:
        return [args]


def have_ghdl():
    try:
        Path(shutil.which('ghdl'))
        return True
    except:
        return False


def have_quartus():
    try:
        Path(shutil.which('quartus_map'))
        return True
    except:
        return False


def process_outputs(delay_compensate, ret, output_callback=None):
    # skip the initial pipeline outputs
    try:
        ret = ret[delay_compensate:]
    except TypeError:  # this happened when ret is single element
        pass

    if output_callback:
        try:
            ret = output_callback(ret)
        except TypeError:  # this happened when ret is single element
            pass

    # transpose
    try:
        if isinstance(ret[0], tuple):
            ret = [list(x) for x in zip(*ret)]
    except:
        pass
    return ret


_ran_gate_simulation = False


def get_ran_gate_simulation():
    global _ran_gate_simulation
    return _ran_gate_simulation


def set_ran_gate_simulation(val):
    global _ran_gate_simulation
    _ran_gate_simulation = val


def simulate(model, *args, simulations=None, conversion_path=None, input_types=None, input_callback=None,
             output_callback=None, discard_last_n_outputs=None):
    """
    Run simulations on model.

    :param model: Object derived from ``Hardware``. Must have ``main`` function with input/outputs.
    :param *x: Inputs to the 'main' function.
    :param conversion_path: Where the VHDL sources are written, default is temporary directory.
    :param input_types: Force inputs types, default for floats is Sfix[0:-17].
    :param simulations: List of simulations to execute:
    * ``'MODEL'`` passes inputs directly to ``model_main`` function. If ``model_main`` does not exist, uses the ``main`` function by turning off register- and fixed point effects.
    * ``'PYHA'`` cycle accurate simulator in Python domain, debuggable.
    * ``'RTL'`` converts sources to VHDL and runs RTL simulation by using GHDL simulator.
    * ``'GATE'`` runs VHDL sources trough Quartus and uses the generated generated netlist for simulation. Use to gain ~full confidence in your design. It is slow!

    :returns: Dict of output lists for each simulation. Select the output like ``out['MODEL']``.
    Example:

    .. code-block:: python

        # simple pass-through module
        class T(Hardware):
            def main(self, a, b):
                return a, b

        outs = simulate(T(),         # object to simulate
                [1,     2,      3],  # inputs to 'a'
                [0.1,   0.2,    0.3],# input to 'b'. Note: Pyha converts floats to Sfix
                simulations=['MODEL', 'PYHA', 'RTL', 'GATE'] # list of simulations to run
        )

        # contents of 'out':
        # Note: returned Sfix values are converted back to float
        {
        'MODEL':[[1, 2, 3], [0.1,                 0.2,                0.3]],
        'PYHA': [[1, 2, 3], [0.09999847412109375, 0.1999969482421875, 0.3000030517578125]],
        'RTL':  [[1, 2, 3], [0.09999847412109375, 0.1999969482421875, 0.3000030517578125]],
        'GATE': [[1, 2, 3], [0.09999847412109375, 0.1999969482421875, 0.3000030517578125]]
        }

    """
    set_ran_gate_simulation(False)

    def types_from_pyha_to_python(pyha_types):
        returns = pyha_types  # can be the case for builtins ie. int
        if isinstance(pyha_types, tuple):  # multiple return
            pyvals = []
            for val in pyha_types:
                try:
                    pval = val._pyha_to_python_value()
                except AttributeError:
                    pval = val

                pyvals.append(pval)

            returns = tuple(pyvals)
        else:
            try:
                returns = pyha_types._pyha_to_python_value()
            except AttributeError:
                pass
        return returns

    if simulations is None:
        if hasattr(model, 'model_main'):
            simulations = ['MODEL', 'PYHA', 'RTL', 'GATE']
        else:
            simulations = ['MODEL_PYHA', 'PYHA', 'RTL', 'GATE']

    # by default write conversion src to tmpdir
    if conversion_path is None or 'TRAVIS' in os.environ:
        conversion_path = TemporaryDirectory().name
    else:
        conversion_path = str(Path(conversion_path).expanduser())  # turn ~ into path
        try:
            shutil.rmtree(conversion_path)  # clear folder
        except:
            pass
        try:
            os.makedirs(conversion_path)
        except:
            pass
    out = {}

    if 'MODEL' in simulations:
        float_model = deepcopy(model)

    if 'MODEL_PYHA' in simulations:
        model_pyha = deepcopy(model)  # used for MODEL_PYHA (need to copy before SimulationRunning starts)

    if 'PYHA' in simulations or 'RTL' in simulations or 'GATE' in simulations:
        logger.info(f'Converting model to hardware types ...')
        model._pyha_floats_to_fixed()  # this must run before 'with SimulationRunning.enable():'

    # # Speed up simulation if VHDL conversion is not required!
    if 'RTL' not in simulations and 'GATE' not in simulations:
        from pyha.common.core import PyhaFunc
        PyhaFunc.bypass = True
        logger.info(f'Enabled fast simulation (model cannot be converted to VHDL)')
    else:
        from pyha.common.core import PyhaFunc
        PyhaFunc.bypass = False

    with SimulationRunning.enable():
        if 'MODEL' in simulations:
            logger.info(f'Running "MODEL" simulation...')

            if not hasattr(float_model, 'model_main'):
                logger.info('SKIPPING **MODEL** simulations -> no "model_main()" found')
            else:
                r = float_model.model_main(*args)

                try:
                    if r.size != 1:
                        r = r.squeeze()
                except:
                    pass

                # r = np_to_py(r)
                if isinstance(r, tuple):
                    r = list(r)

                out['MODEL'] = r
                logger.info(f'OK!')

        if 'MODEL_PYHA' in simulations:
            logger.info(f'Running "MODEL_PYHA" simulation...')
            with RegisterBehaviour.force_disable():
                with Sfix._float_mode:
                    tmpmodel = model_pyha
                    tmpmodel._pyha_floats_to_fixed(silence=True)

                    tmpargs = deepcopy(args)
                    tmpargs = convert_input_types(tmpargs, input_types, silence=True, input_callback=input_callback)
                    tmpargs = transpose(tmpargs)

                    ret = []
                    for input in tmpargs:
                        returns = tmpmodel.main(*input)
                        returns = types_from_pyha_to_python(returns)
                        ret.append(returns)
                        tmpmodel._pyha_update_registers()

                    ret = process_outputs(0, ret, output_callback)
            out['MODEL_PYHA'] = ret
            logger.info(f'OK!')

        # prepare inputs and model for hardware simulations
        if 'PYHA' in simulations or 'RTL' in simulations or 'GATE' in simulations:
            if hasattr(model, '_pyha_simulation_input_callback'):
                args = model._pyha_simulation_input_callback(args)
                args = transpose([args])
            else:
                args = convert_input_types(args, input_types, input_callback=input_callback)
                args = transpose(args)

            delay_compensate = 0
            with suppress(AttributeError):
                delay_compensate = model.DELAY

            # duplicate input args to flush pipeline
            target_len = len(args) + delay_compensate
            args += args * int(np.ceil(delay_compensate / len(args)))
            args = args[:target_len]

        if 'PYHA' in simulations:
            logger.info(f'Running "PYHA" simulation...')
            tmpargs = args  # pyha MAY overwrite the inputs...

            ret = []
            with RegisterBehaviour.enable():
                with AutoResize.enable():
                    for input in tqdm(tmpargs, file=sys.stdout):
                        returns = model.main(*input)
                        returns = types_from_pyha_to_python(returns)
                        ret.append(returns)
                        model._pyha_update_registers()

            # ret = process_outputs(delay_compensate, ret, output_callback)
            try:
                ret = process_outputs(delay_compensate, ret, output_callback=model._pyha_simulation_output_callback)
            except AttributeError:
                ret = process_outputs(delay_compensate, ret)

            out['PYHA'] = ret
            logger.info(f'OK!')

        # From this point on we assume ARGS and MODEL have been transformed to fixed point
        if 'RTL' in simulations:
            logger.info(f'Running "RTL" simulation...')
            if 'PYHA' not in simulations:
                raise Exception('You need to run "PYHA" simulation before "RTL" simulation')
            elif 'PYHA_SKIP_RTL' in os.environ:
                logger.warning('SKIPPING **RTL** simulations -> "PYHA_SKIP_RTL" environment variable is set')
            elif Sfix._float_mode.enabled:
                logger.warning('SKIPPING **RTL** simulations -> Sfix._float_mode is active')
            # TODO: test for docker instead...
            # elif not have_ghdl():
            #     logger.warning('SKIPPING **RTL** simulations -> no GHDL found')
            else:
                vhdl_sim = VHDLSimulation(Path(conversion_path), model, 'RTL')
                ret = vhdl_sim.main(*args)

                try:
                    out['RTL'] = process_outputs(delay_compensate, ret, output_callback=model._pyha_simulation_output_callback)
                except:
                    out['RTL'] = process_outputs(delay_compensate, ret)
            logger.info(f'OK!')

        if 'GATE' in simulations:
            logger.info(f'Running "GATE" simulation...')
            logger.warning('SKIPPING **GATE** simulations -> this is temporary, until GATE simulation dependencies make it to the Docker image!')
            # if 'PYHA' not in simulations:
            #     raise Exception('You need to run "PYHA" simulation before "GATE" simulation')
            # elif 'PYHA_SKIP_GATE' in os.environ:
            #     logger.warning('SKIPPING **GATE** simulations -> "PYHA_SKIP_GATE" environment variable is set')
            # elif Sfix._float_mode.enabled:
            #     logger.warning('SKIPPING **GATE** simulations -> Sfix._float_mode is active')
            # elif not have_quartus():
            #     logger.warning('SKIPPING **GATE** simulations -> no Quartus found')
            # elif not have_ghdl():
            #     logger.warning('SKIPPING **GATE** simulations -> no GHDL found')
            # else:
            # set_ran_gate_simulation(True)
            # vhdl_sim = VHDLSimulation(Path(conversion_path), model, 'GATE')
            # ret = vhdl_sim.main(*args)
            #
            # try:
            #     out['GATE'] = process_outputs(delay_compensate, ret,
            #                                   output_callback=model._pyha_simulation_output_callback)
            # except:
            #     out['GATE'] = process_outputs(delay_compensate, ret)
            #
            # logger.info(f'OK!')

    if discard_last_n_outputs:
        for key, value in out.items():
            out[key] = value[:-discard_last_n_outputs]

    logger.info('Simulations completed!')
    return out


def get_resource_usage():
    assert get_ran_gate_simulation()
    return VHDLSimulation.last_logic_elements, VHDLSimulation.last_memory_bits, VHDLSimulation.last_multiplier


def hardware_sims_equal(simulation_results):
    """
    Strictly compare that hardware simulations (PYHA, RTL, GATE) are exactly equal.

    :param simulation_results: Output of 'simulate' function
    :returns: True if equal
    """
    # make a copy without the 'MODEL' simulation
    logger.info(f'Testing hardware simulations equality...')
    sims = {k: v for k, v in simulation_results.items() if 'MODEL' not in k}
    return sims_close(sims, rtol=1e-16, atol=1e-16)


def sims_close(simulation_results, expected=None, rtol=1e-04, atol=(2 ** -17) * 4, skip_first_n=0):
    """
    Compare the results of ``simulate`` function.

    :param simulation_results: Output of 'simulate' function
    :param expected: 'Golden output' to compare against. If None uses the output of ``MODEL`` or ``PYHA``.
    :param rtol: 1e-1 = 10% accuracy, 1e-2= 1% accuracy...
    :param atol: Tune this when numbers close to 0 are failing assertions. Default assumes that inputs are in range of [-1,1].
    :param skip_first_n: Skip comparing first N elements
    :returns: True if equal(defined by rtol and atol)
    """
    logger.info(f'sims_close(rtol={rtol}, atol={atol})')
    if expected is None:
        if 'MODEL' in simulation_results.keys():
            expected = simulation_results['MODEL']
            logger.info(f'Using "MODEL" as golden output')
        elif 'MODEL_PYHA' in simulation_results.keys():
            expected = simulation_results['MODEL_PYHA']
            logger.info(f'Using "MODEL_PYHA" as golden output')
        else:
            expected = simulation_results['PYHA']
            logger.info(f'Using "PYHA" as golden output')

    expected = np_to_py(get_iterable(expected))[skip_first_n:]

    expected = init_vhdl_type('root', expected, expected)
    result = True
    for sim_name, sim_data in simulation_results.items():
        sim_data = get_iterable(sim_data)
        sim_data = sim_data[skip_first_n:][:len(expected.elems)]
        sim_data = init_vhdl_type(sim_name, sim_data, sim_data)
        eq = sim_data._pyha_is_equal(expected, sim_name, rtol, atol)
        if eq:
            logger.info(f'{sim_name} OK!')
        else:
            logger.info(f'{sim_name} FAILED!')
            result = False

    return result


def assert_equals(simulation_results, expected=None, rtol=1e-04, atol=(2 ** -17) * 4, skip_first_n=0):
    """ Legacy """
    assert sims_close(simulation_results, expected, rtol, atol, skip_first_n)


def assert_sim_match(model, expected, *x, types=None, simulations=None, rtol=1e-04, atol=(2 ** -17) * 4, dir_path=None,
                     skip_first=0):
    """ Legacy """
    sims = simulate(model, *x, simulations=simulations, conversion_path=dir_path, input_types=types)
    assert sims_close(sims, expected, atol=atol, rtol=rtol, skip_first_n=skip_first)
