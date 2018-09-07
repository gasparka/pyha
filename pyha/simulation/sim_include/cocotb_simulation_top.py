import cocotb                                   # pragma: no cover
import numpy as np                              # pragma: no cover
from cocotb.binary import BinaryValue           # pragma: no cover
from cocotb.clock import Clock                  # pragma: no cover
from cocotb.result import ReturnValue           # pragma: no cover
from cocotb.triggers import RisingEdge, Timer   # pragma: no cover
from tqdm import tqdm                           # pragma: no cover
import sys                                      # pragma: no cover
import warnings                                 # pragma: no cover
warnings.filterwarnings('ignore')               # pragma: no cover


@cocotb.coroutine               # pragma: no cover
def reset(dut, duration=10000): # pragma: no cover
    dut.log.debug("Resetting DUT")
    dut.rst_n = 0
    yield Timer(duration)
    yield RisingEdge(dut.clk)
    dut.rst_n = 1
    dut.log.debug("Out of reset")


@cocotb.coroutine                       # pragma: no cover
def run_dut(dut, in_data, out_count):   # pragma: no cover
    # dut.enable = 1
    # dut.in0 = 0
    cocotb.fork(Clock(dut.clk, 5000).start())
    yield reset(dut)

    ret = []
    # print('Input data: {}'.format(in_data))
    count = 0
    for x in tqdm(in_data, file=sys.stderr):
        # print(count)
        count += 1
        # put input
        # print('Processing slice: {}'.format(x))
        for i, xi in enumerate(x):
            # print('Set {} to {}'.format('in' + str(i), str(xi)))
            v = getattr(dut, 'in' + str(i))
            bval = BinaryValue(str(xi), len(xi))
            v.setimmediatevalue(bval)

        yield RisingEdge(dut.clk)

        # collect output
        tmp = []
        for i in range(out_count):
            var = 'out' + str(i)
            # val = getattr(dut, var).value.signed_integer
            val = str(getattr(dut, var).value)
            # print(val)
            tmp.append(val)
        ret.append(tmp)

    # print('Finish, ret: {}'.format(ret))
    raise ReturnValue(ret)


@cocotb.test()      # pragma: no cover
def test_main(dut): # pragma: no cover
    import os
    in_data = np.load(os.getcwd() + '/input.npy')

    output_vars = int(os.environ['OUTPUT_VARIABLES'])
    hdl_out = yield run_dut(dut, in_data, output_vars)

    np.save(os.getcwd() + '/output.npy', hdl_out)
