import logging
import os
import shutil
import subprocess
import sys
from contextlib import suppress
from copy import deepcopy
from pathlib import Path
import numpy as np
from tqdm import tqdm
from wurlitzer import pipes
from pyha import Hardware
from pyha.common.complex import default_complex
from pyha.common.context_managers import RegisterBehaviour, SimulationRunning, SimPath, AutoResize
from pyha.common.fixed_point import Sfix, default_sfix
from pyha.common.util import get_iterable, np_to_py, is_float, is_complex
from pyha.conversion.conversion import Converter
from pyha.conversion.type_transforms import init_vhdl_type
from pyha.synthesis.quartus import make_quartus_project, QuartusDockerWrapper

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('sim')

_simulator_quartus = None


def get_simulator_quartus():
    global _simulator_quartus
    return _simulator_quartus


def set_simulator_quartus(val):
    global _simulator_quartus
    _simulator_quartus = val


def convert_input_types(args, to_types=None, silence=False):
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
            elif any(is_float(x) for x in arg):
                args[i] = convert_arg(default_sfix, arg, i)

            elif any(is_complex(x) for x in arg):
                args[i] = convert_arg(default_complex, arg, i)

            elif isinstance(arg[0], Hardware):
                for x in arg:
                    x._pyha_floats_to_fixed()

            elif is_list(arg[0]):
                # input is 2D array -> turn into packets (1D list of Stream objects)
                args[i] = convert_input_types(arg, silence=True, to_types=to_types)  # dont apply input callback here..

    return args


def transpose(args):
    try:
        return [x for x in zip(*args)]
    except TypeError:
        return [args]


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

def pyha_to_python(simulation_output):
    """ Convert simulation output (e.g fixed-point value) to Python value (e.g. float).
     It can be possible that model returns multiple values!
     """

    def handle_one(output):
        try:
            # some Pyha type?
            return output._pyha_to_python_value()
        except AttributeError:
            # not Pyha type. For example maybe an builtin e.g int
            return output

    if isinstance(simulation_output, tuple):
        ret = tuple(handle_one(x) for x in simulation_output)
    else:
        ret = handle_one(simulation_output)

    return ret


def simulate(model, *args, simulations=None, conversion_path=None, input_types=None,
             pipeline_flush='self.DELAY', trace=False):
    """
    Run simulations on model.

    :param model: Object derived from ``Hardware``. Must have ``main`` function with input/outputs.
    :param *x: Inputs to the 'main' function.
    :param conversion_path: Where the VHDL sources are written, default is temporary directory.
    :param input_types: Force inputs types, default for floats is Sfix[0:-17].
    :param simulations: List of simulations to execute:
    * ``'MODEL'`` passes inputs directly to ``model`` function. If ``model`` does not exist, uses the ``main`` function by turning off register- and fixed point effects.
    * ``'HARDWARE'`` cycle accurate simulator in Python domain, debuggable.
    * ``'RTL'`` converts sources to VHDL and runs RTL simulation by using GHDL simulator.
    * ``'NETLIST'`` runs VHDL sources trough Quartus and uses the generated generated netlist for simulation. Use to gain ~full confidence in your design. It is slow!

    :returns: Dict of output lists for each simulation. Select the output like ``out['MODEL']``.

    Args:
        model: Object derived from *Hardware*. Must have a *main* function.
        *args: Simulation inputs, a list for each argument of the *main* function.
        simulations: List of simulations to execute:
            * 'MODEL'    : executes the *model* function.
            * 'HARDWARE' : executes the *main* function for each input sample i.e. each sample is tied to a clock cycle.
                           Uses a cycle-accurate simulator implemented in Python.
                           TIP: use a debugger to step trough the simulation.
            * 'RTL'      : converts to VHDL and executes with GHDL simulator. Slow!
            * 'NETLIST'  : converts VHDL sources to a 'Quartus netlist' and simulates with GHDL. Painfully slow!

        conversion_path:
        input_types:
        pipeline_flush:
        trace:

    Returns:
        dict:

    """
    from pyha.simulation.tracer import Tracer
    Tracer.traced_objects.clear()
    set_simulator_quartus(None)

    if simulations is None:
        if hasattr(model, 'model'):
            simulations = ['MODEL', 'HARDWARE', 'RTL', 'NETLIST']
        else:
            simulations = ['MODEL_PYHA', 'HARDWARE', 'RTL', 'NETLIST']

    if 'MODEL' in simulations:
        if not hasattr(model, 'model'):
            logger.info('SKIPPING **MODEL** simulations -> no "model()" found')
            simulations.remove('MODEL')

    if 'RTL' in simulations:
        if 'HARDWARE' not in simulations:
            logger.warning('SKIPPING **RTL** simulations -> You need to run "HARDWARE" simulation before "RTL" simulation')
            simulations.remove('RTL')
        elif 'PYHA_SKIP_RTL' in os.environ:
            logger.warning('SKIPPING **RTL** simulations -> "PYHA_SKIP_RTL" environment variable is set')
            simulations.remove('RTL')
        elif Sfix._float_mode.enabled:
            logger.warning('SKIPPING **RTL** simulations -> Sfix._float_mode is active')
            simulations.remove('RTL')

        # TODO: test for docker instead...
        # elif not have_ghdl():
        #     logger.warning('SKIPPING **RTL** simulations -> no GHDL found')

    if 'NETLIST' in simulations:
        if 'HARDWARE' not in simulations:
            logger.warning(
                'SKIPPING **GATE** simulations -> You need to run "HARDWARE" simulation before "NETLIST" simulation')
            simulations.remove('NETLIST')
        elif 'PYHA_SKIP_GATE' in os.environ:
            logger.warning('SKIPPING **GATE** simulations -> "PYHA_SKIP_GATE" environment variable is set')
            simulations.remove('NETLIST')
        elif Sfix._float_mode.enabled:
            logger.warning('SKIPPING **GATE** simulations -> Sfix._float_mode is active')
            simulations.remove('NETLIST')

    if trace:
        simulations = ['MODEL', 'HARDWARE']
        logger.info(f'Tracing is enabled, running "MODEL" and "HARDWARE" simulations')
        model._pyha_insert_tracer(label='self')

    out = {}
    if 'MODEL' in simulations:
        logger.info(f'Running "MODEL" simulation...')

        r = model.model(*args)

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
                tmpmodel = deepcopy(model)
                tmpmodel._pyha_floats_to_fixed(silence=True)

                tmpargs = deepcopy(args)
                tmpargs = convert_input_types(tmpargs, input_types, silence=True)
                tmpargs = transpose(tmpargs)

                ret = []
                for input in tmpargs:
                    returns = tmpmodel.main(*input)
                    returns = pyha_to_python(returns)
                    ret.append(returns)
                    tmpmodel._pyha_update_registers()

                ret = process_outputs(0, ret)
        out['MODEL_PYHA'] = ret
        logger.info(f'OK!')

    if 'HARDWARE' in simulations:
        if 'RTL' in simulations or 'NETLIST' in simulations:
            logger.info(f'Simulaton needs to support conversion to VHDL -> major slowdown')
            model._pyha_enable_function_profiling_for_types()

        model._pyha_floats_to_fixed()
        if hasattr(model, '_pyha_simulation_input_callback'):
            args = model._pyha_simulation_input_callback(args)
        else:
            args = convert_input_types(args, input_types)
            args = transpose(args)


        delay_compensate = 0
        if pipeline_flush == 'self.DELAY':
            with suppress(AttributeError):
                delay_compensate = model.DELAY

            # duplicate input args to flush pipeline
            target_len = len(args) + delay_compensate
            args += args * int(np.ceil(delay_compensate / len(args)))
            args = args[:target_len]

        logger.info(f'Running "HARDWARE" simulation...')
        ret = []
        valid_samples = 0
        with SimulationRunning.enable():
            with RegisterBehaviour.enable():
                with AutoResize.enable():
                    for input in tqdm(args, file=sys.stderr):
                        returns = model.main(*input)
                        returns = pyha_to_python(returns)
                        if returns is not None:
                            valid_samples += 1
                            ret.append(returns)
                        model._pyha_update_registers()

                    if pipeline_flush == 'auto' and valid_samples != len(out['MODEL']):
                        args = list(args)
                        logger.info(
                            f'Flushing the pipeline to collect {len(out["MODEL"])} valid samples (currently have {valid_samples})')
                        hardware_delay = 0
                        while valid_samples != len(out["MODEL"]):
                            hardware_delay += 1
                            returns = model.main(*args[-1])
                            returns = pyha_to_python(returns)
                            if returns is not None:
                                valid_samples += 1
                                ret.append(returns)
                            model._pyha_update_registers()
                            args.append(
                                args[-1])  # collect samples needed to flush the system, so RTL and GATE sims work also!
                        logger.info(f'Flush took {hardware_delay} cycles.')

        out['HARDWARE'] = process_outputs(delay_compensate, ret)
        logger.info(f'OK!')

    if 'RTL' in simulations or 'NETLIST' in simulations:
        converter = Converter(model, output_dir=conversion_path).to_vhdl()
        if 'NETLIST' in simulations:
            make_quartus_project(converter)

    if 'RTL' in simulations:
        logger.info(f'Running "RTL" simulation...')
        ret = run_ghdl_cocotb(*args, converter=converter)
        out['RTL'] = process_outputs(delay_compensate, ret)
        logger.info(f'OK!')

    if 'NETLIST' in simulations:

        logger.info(f'Running "NETLIST" simulation...')
        quartus = QuartusDockerWrapper(converter.base_path)
        set_simulator_quartus(quartus)

        ret = run_ghdl_cocotb(*args, converter=converter, netlist=quartus.get_netlist())
        out['NETLIST'] = process_outputs(delay_compensate, ret)
        logger.info(f'OK!')

    logger.info('Simulations completed!')
    return out


def run_ghdl_cocotb(*inputs, converter=None, netlist=None, verbose=False):
    """ RTL simulator with GHDL and COCOTB. This requires that MODEL and PYHA simulations already ran.
    Inputs to the simulator are 'pipeline compensated' from PYHA simulation.
    """
    indata = []
    for arguments in inputs:
        if len(arguments) == 1:
            l = [init_vhdl_type('-', arguments[0], arguments[0])._pyha_serialize()]
        else:
            l = [init_vhdl_type('-', arg, arg)._pyha_serialize() for arg in arguments]
        indata.append(l)

    np.save(str(converter.base_path / 'input.npy'), indata)

    # make sure output file does not exist
    out_path = str(converter.base_path / 'output.npy')
    if os.path.exists(out_path):
        os.remove(out_path)

    if netlist:
        src = '.' + netlist[len(str(converter.base_path)):]  # need relative path!
        ghdl_args = '-P/quartus_sim_lib/ --ieee=synopsys --no-vital-checks'
    else:
        src = ' '.join(converter.get_vhdl_sources_relative())
        ghdl_args = '--std=08'

    cmd = f"docker run " \
          f"-u `id -u` " \
          f" -v {converter.base_path}:/simulation gasparka/ghdl_cocotb_quartuslibs make " \
          f"VHDL_SOURCES=\"{src}\" " \
          f"OUTPUT_VARIABLES=\"{str(len(converter.get_top_module_outputs()))}\" " \
          f"GHDL_ARGS=\"{ghdl_args}\" "

    with pipes(stdout=sys.stdout if verbose else None, stderr=sys.stderr):
        # Weirdness: running in Pycharm 'pytest -s' gets somehow stuck in wurlizer...
        subprocess.run(cmd, shell=True)

    print('\n', file=sys.stderr)

    out = np.load(out_path)
    outp = out.astype(object).T

    for i, row in enumerate(outp):
        for j, val in enumerate(row):
            outp[i][j] = converter.get_top_module_outputs()[i]._pyha_deserialize(val)

    outp = np.squeeze(outp)  # example [[1], [2], [3]] -> [1, 2, 3]
    outp = outp.T.tolist()

    # convert second level lists to tuples if dealing with 'multiple returns'
    if len(converter.get_top_module_outputs()) > 1:
        for i, row in enumerate(outp):
            try:
                outp[i] = tuple(outp[i])
            except TypeError:  # happened when outp[i] is single float
                outp[i] = [outp[i]]

    # skip Nones (invalid packets)
    try:
        outp = [x for x in outp if x is not None]
    except TypeError: # outp not a list?
        pass

    return outp


def assert_simulations_equal(simulations, rtol=1e-05, atol=1e-30):
    """
    Compare the results of ``simulate`` function.

    :param simulations: Output of 'simulate' function
    :param rtol: 1e-1 = 10% accuracy, 1e-2= 1% accuracy...
    :param atol: Tune this when numbers close to 0 are failing assertions. Default assumes that inputs are in range of [-1,1] and 18 bits.
    """
    from numpy.testing import assert_allclose
    if 'MODEL' in simulations and 'HARDWARE' in simulations:
        assert_allclose(simulations['HARDWARE'], simulations['MODEL'], rtol, atol)

    # hardware simulations must be EXACTLY equal
    if 'RTL' in simulations:
        assert_allclose(simulations['RTL'], simulations['HARDWARE'], rtol=1e-32, atol=1e-32)

    if 'NETLIST' in simulations:
        assert_allclose(simulations['NETLIST'], simulations['HARDWARE'], rtol=1e-32, atol=1e-32)


def hardware_sims_equal(simulation_results):
    """
    TODO: LEGACY
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
    TODO: LEGACY
    Compare the results of ``simulate`` function.

    :param simulation_results: Output of 'simulate' function
    :param expected: 'Golden output' to compare against. If None uses the output of ``MODEL`` or ``PYHA``.
    :param rtol: 1e-1 = 10% accuracy, 1e-2= 1% accuracy...
    :param atol: Tune this when numbers close to 0 are failing assertions. Default assumes that inputs are in range of [-1,1] and 18 bits.
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
            expected = simulation_results['HARDWARE']
            logger.info(f'Using "HARDWARE" as golden output')

    expected = np_to_py(get_iterable(expected))[skip_first_n:]

    expected = init_vhdl_type('root', expected, expected)
    result = True
    for sim_name, sim_data in simulation_results.items():
        sim_data = get_iterable(sim_data)
        sim_data = sim_data[skip_first_n:]
        sim_data = init_vhdl_type(sim_name, sim_data, sim_data)
        eq = sim_data._pyha_is_equal(expected, sim_name, rtol, atol)
        if eq:
            logger.info(f'{sim_name} OK!')
        else:
            logger.info(f'{sim_name} FAILED!')
            result = False

    return result


    # if expected is None:
    #     if 'MODEL' in simulation_results.keys():
    #         expected = simulation_results['MODEL']
    #     elif 'MODEL_PYHA' in simulation_results.keys():
    #         expected = simulation_results['MODEL_PYHA']
    #         logger.info(f'Using "MODEL_PYHA" as golden output')
    #     else:
    #         expected = simulation_results['HARDWARE'] # make sure expected always exists
    # expected = np_to_py(get_iterable(expected))
    # expected = init_vhdl_type('root', expected, expected)
    #
    # if 'HARDWARE' in simulation_results.keys():
    #     logger.info(f'Testing that HARDWARE and MODEL are close(atol={atol}, rtol={rtol})')
    #     hardware = init_vhdl_type('HARDWARE', get_iterable(simulation_results['HARDWARE']))
    #     assert hardware._pyha_is_equal(expected, 'HARDWARE', rtol, atol)
    #
    # if 'RTL' in simulation_results.keys():
    #     logger.info(f'Testing that RTL is *exactly* equal to HARDWARE')
    #     rtl = init_vhdl_type('RTL', get_iterable(simulation_results['RTL']))
    #     assert rtl._pyha_is_equal(hardware, 'RTL', rtol=1e-30, atol=1e-30)
    #
    # if 'NETLIST' in simulation_results.keys():
    #     logger.info(f'Testing that NETLIST is *exactly* equal to HARDWARE')
    #     netlist = init_vhdl_type('NETLIST', get_iterable(simulation_results['NETLIST']))
    #     assert netlist._pyha_is_equal(hardware, 'NETLIST', rtol=1e-30, atol=1e-30)
    #
    # return True


def assert_equals(simulation_results, expected=None, rtol=1e-04, atol=(2 ** -17) * 4, skip_first_n=0):
    """ Legacy """
    assert sims_close(simulation_results, expected, rtol, atol, skip_first_n)


def assert_sim_match(model, expected, *x, types=None, simulations=None, rtol=1e-04, atol=(2 ** -17) * 4, dir_path=None,
                     skip_first=0):
    """ Legacy """
    sims = simulate(model, *x, simulations=simulations, conversion_path=dir_path, input_types=types)
    assert sims_close(sims, expected, atol=atol, rtol=rtol, skip_first_n=skip_first)
