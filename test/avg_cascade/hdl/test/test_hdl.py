# Simple tests for an adder module
import cocotb
import matplotlib.pyplot as plt
import numpy as np
from cocotb.clock import Clock
from cocotb.result import ReturnValue
from cocotb.triggers import RisingEdge, Timer, FallingEdge

from common.sfix import Sfix
from common.sfixed import to_sfixed_real, to_real
from test.avg_cascade.casc import Casc


@cocotb.coroutine
def reset(dut, duration=10000):
    dut.log.debug("Resetting DUT")
    dut.rst_n = 0
    yield Timer(duration)
    yield RisingEdge(dut.clk)
    dut.rst_n = 1
    dut.log.debug("Out of reset")


@cocotb.coroutine
def run_dut(dut, x, data_width):
    cocotb.fork(Clock(dut.clk, 5000).start())
    yield reset(dut)

    x = np.copy(x)
    x = to_sfixed_real(x, data_width)

    yr = []
    for xi in x:
        dut.x = xi.astype(int)
        # FIXME: NOTICE, need to have both yields to match simulation.
        yield RisingEdge(dut.clk)
        yield FallingEdge(dut.clk)
        yr.append(float(dut.y.value.signed_integer))

    yr = to_real(np.array(yr), data_width)
    raise ReturnValue(yr)


@cocotb.coroutine
def link_to_model(dut, input):
    cocotb.fork(Clock(dut.clk, 5000).start())
    yield reset(dut)

    av = Casc(4, 2)
    model_out = [float(av.main(Sfix(x, 0, -17))) for x in input]

    hdl_out = yield run_dut(dut, input, 18)

    plt.plot(hdl_out)
    plt.plot(model_out)
    plt.show()
    np.testing.assert_almost_equal(model_out, hdl_out)
    # if (model_out != hdl_out).any():
    #     raise TestFailure()


@cocotb.test()
def test_main(dut):
    inp = np.random.uniform(-1, 1, 256)
    yield link_to_model(dut, inp)

# @cocotb.test()
# def test_pos_avg(dut):
#     """ DUT gives the same avg when inputs positive """
#     x = [i for i in range(128)]
#     yield link_to_model(dut, x)
#
#
# @cocotb.test()
# def test_neg_avg(dut):
#     """ DUT gives the same avg when inputs negative """
#     x = [i for i in range(0, -128, -1)]
#     yield link_to_model(dut, x)
#
#
# @cocotb.test()
# def test_pos_sum_overflow(dut):
#     """ DUT should never overflow +SUM """
#     windowPow = int(os.environ['GENERIC_WINDOW_POW'])
#     dataWidth = int(os.environ['GENERIC_DATA_WIDTH'])
#
#     maxElems = 2 ** windowPow
#     maxInput = (2 ** (dataWidth - 1)) - 1
#     x = [maxInput for _ in range(maxElems + 10)]
#
#     yield link_to_model(dut, x)
#
#
# @cocotb.test()
# def test_neg_sum_overflow(dut):
#     """ DUT should never overflow -SUM """
#     windowPow = int(os.environ['GENERIC_WINDOW_POW'])
#     dataWidth = int(os.environ['GENERIC_DATA_WIDTH'])
#
#     maxElems = 2 ** windowPow
#     minInput = (2 ** (dataWidth - 1))
#     x = [-minInput for _ in range(maxElems + 10)]
#
#     yield link_to_model(dut, x)
#
#
# @cocotb.test()
# def test_sin(dut):
#     """ Sine input, DUT matches model """
#     x = 1024 * np.sin(2 * np.pi * 10 * np.arange(256) / float(60))
#     x = x.astype(int)
#     yield link_to_model(dut, x)
