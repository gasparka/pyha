import logging
import os
import shutil
from contextlib import suppress
from copy import deepcopy
from pathlib import Path
from tempfile import TemporaryDirectory

import numpy as np
import pandas as pd
from pyha import Hardware
from pyha.common.complex import default_complex
from pyha.common.context_managers import RegisterBehaviour, SimulationRunning, SimPath
from pyha.common.fixed_point import Sfix, default_sfix
from pyha.common.util import get_iterable, np_to_py
from pyha.conversion.python_types_vhdl import init_vhdl_type
from pyha.simulation.vhdl_simulation import VHDLSimulation

pd.options.display.max_rows = 32

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('sim')


def convert_input_types(args, to_types=None, silence=False):
    if not silence:
        logger.info(f'Converting simulation inputs to hardware types...')

    def convert_arg(default_type, arg, i):
        args_orig = deepcopy(args[i])
        t = default_type
        if to_types is not None:
            t = to_types[i]
        ret = [t(x) for x in arg]
        if not silence:
            l = pd.DataFrame({'original': args_orig, 'converted': ret})
            logger.debug(f'Converted {i}. input:\n {l}')
        return ret

    args = list(args)
    with SimPath('inputs'):
        for i, arg in enumerate(args):
            arg = get_iterable(arg)
            if any(isinstance(x, float) for x in arg):
                args[i] = convert_arg(default_sfix, arg, i)

            elif any(isinstance(x, (complex, np.complexfloating)) for x in arg):
                args[i] = convert_arg(default_complex, arg, i)

            elif to_types is not None:
                args[i] = convert_arg(None, arg, i)

            elif isinstance(arg[0], Hardware):
                for x in arg:
                    x._pyha_floats_to_fixed()

    return args


def transpose(args):
    return [x for x in zip(*args)]


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


def process_outputs(delay_compensate, ret):
    # skip the initial pipeline outputs
    try:
        ret = ret[delay_compensate:]
    except TypeError:  # this happened when ret is single element
        pass

    # transpose
    try:
        if isinstance(ret[0], tuple):
            ret = [list(x) for x in zip(*ret)]
    except:
        pass
    return ret


def simulate(model, *args, simulations=None, conversion_path=None, input_types=None):
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
        if not Path(conversion_path).exists():
            os.makedirs(conversion_path)

    out = {}
    model = deepcopy(model)  # make sure we dont mess up original model
    with SimulationRunning.enable():
        if 'MODEL' in simulations:
            logger.info(f'Running "MODEL" simulation...')

            if not hasattr(model, 'model_main'):
                logger.info('SKIPPING **MODEL** simulations -> no "model_main()" found')
            else:
                r = model.model_main(*args)
                r = np_to_py(r)
                if isinstance(r, tuple):
                    r = list(r)

                out['MODEL'] = r
                logger.info(f'OK!')


        if 'MODEL_SIM' in simulations:
            logger.info(f'Running "MODEL_SIM" simulation...')
            with RegisterBehaviour.force_disable():
                with Sfix._float_mode:
                    tmpmodel = deepcopy(model)
                    # tmpmodel._pyha_floats_to_fixed(silence=True)
                    #
                    tmpargs = deepcopy(args)
                    # tmpargs = convert_input_types(tmpargs, input_types, silence=True)
                    tmpargs = transpose(tmpargs)

                    ret = []
                    for x in tmpargs:
                        ret.append(deepcopy(tmpmodel.main(*x)))  # deepcopy required or 'subsub' modules break
                        # tmpmodel._pyha_update_registers()

                    ret = process_outputs(0, ret)
                    # convert outputs to Python types, for example fixed to floats
                    # ret = [init_vhdl_type('-', x, x)._pyha_to_python_value() for x in ret]

            out['MODEL_SIM'] = ret
            logger.info(f'OK!')

        if 'MODEL_PYHA' in simulations:
            logger.info(f'Running "MODEL_PYHA" simulation...')
            with RegisterBehaviour.force_disable():
                with Sfix._float_mode:
                    tmpmodel = deepcopy(model)
                    tmpmodel._pyha_floats_to_fixed(silence=True)

                    tmpargs = deepcopy(args)
                    tmpargs = convert_input_types(tmpargs, input_types, silence=True)
                    tmpargs = transpose(tmpargs)

                    ret = []
                    for x in tmpargs:
                        ret.append(deepcopy(tmpmodel.main(*x)))  # deepcopy required or 'subsub' modules break
                        tmpmodel._pyha_update_registers()

                    ret = process_outputs(0, ret)
                    # convert outputs to Python types, for example fixed to floats
                    ret = [init_vhdl_type('-', x, x)._pyha_to_python_value() for x in ret]

            out['MODEL_PYHA'] = ret
            logger.info(f'OK!')

        # prepare inputs and model for hardware simulations
        if 'PYHA' in simulations or 'RTL' in simulations or 'GATE' in simulations:
            logger.info(f'Converting model to hardware types ...')
            model._pyha_floats_to_fixed()
            args = convert_input_types(args, input_types)
            args = transpose(args)

            delay_compensate = 0
            with suppress(AttributeError):
                delay_compensate = model.DELAY

            for i in range(delay_compensate):  # add samples to flush the pipeline
                args.append(args[0])

        if 'PYHA' in simulations:
            logger.info(f'Running "PYHA" simulation...')
            tmpargs = deepcopy(args)  # pyha MAY overwrite the inputs...

            ret = []
            for input in tmpargs:
                output = deepcopy(model.main(*input)) # deepcopy required or 'subsub' modules break
                ret.append(output)
                model._pyha_update_registers()

            ret = process_outputs(delay_compensate, ret)

            try:
                # convert outputs to Python types, for example fixed to floats
                ret = [init_vhdl_type('-', x, x)._pyha_to_python_value() for x in ret]
            except AttributeError:
                pass

            out['PYHA'] = ret
            logger.info(f'OK!')

        # From this point on we assume ARGS and MODEL have been transformed
        if 'RTL' in simulations:
            logger.info(f'Running "RTL" simulation...')
            if 'PYHA' not in simulations:
                raise Exception('You need to run "PYHA" simulation before "RTL" simulation')
            elif 'PYHA_SKIP_RTL' in os.environ:
                logger.warning('SKIPPING **RTL** simulations -> "PYHA_SKIP_RTL" environment variable is set')
            elif Sfix._float_mode.enabled:
                logger.warning('SKIPPING **RTL** simulations -> Sfix._float_mode is active')
            elif not have_ghdl():
                logger.warning('SKIPPING **RTL** simulations -> no GHDL found')
            else:
                vhdl_sim = VHDLSimulation(Path(conversion_path), model, 'RTL')
                ret = vhdl_sim.main(*args)

                out['RTL'] = process_outputs(delay_compensate, ret)
                logger.info(f'OK!')

        if 'GATE' in simulations:
            logger.info(f'Running "GATE" simulation...')
            if 'PYHA' not in simulations:
                raise Exception('You need to run "PYHA" simulation before "GATE" simulation')
            elif 'PYHA_SKIP_GATE' in os.environ:
                logger.warning('SKIPPING **GATE** simulations -> "PYHA_SKIP_GATE" environment variable is set')
            elif Sfix._float_mode.enabled:
                logger.warning('SKIPPING **GATE** simulations -> Sfix._float_mode is active')
            elif not have_quartus():
                logger.warning('SKIPPING **GATE** simulations -> no Quartus found')
            elif not have_ghdl():
                logger.warning('SKIPPING **GATE** simulations -> no GHDL found')
            else:

                vhdl_sim = VHDLSimulation(Path(conversion_path), model, 'GATE')
                ret = vhdl_sim.main(*args)

                out['GATE'] = process_outputs(delay_compensate, ret)
                logger.info(f'OK!')

    logger.info('Simulations completed!')
    return out


def hardware_sims_equal(simulation_results):
    """
    Strictly compare that hardware simulations (PYHA, RTL, GATE) are exactly equal.

    :param simulation_results: Output of 'simulate' function
    :returns: True if equal
    """
    # make a copy without the 'MODEL' simulation
    sims = {k: v for k, v in simulation_results.items() if k != 'MODEL' and k != 'MODEL_PYHA'}
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
        elif 'PYHA_MODEL' in simulation_results.keys():
            expected = simulation_results['PYHA_MODEL']
            logger.info(f'Using "PYHA_MODEL" as golden output')
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
            pass
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
