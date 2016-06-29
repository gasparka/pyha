import cocotb
import numpy as np
from cocotb.clock import Clock
from cocotb.result import TestFailure, ReturnValue
from cocotb.triggers import RisingEdge, Timer, FallingEdge

from common.sfix import Sfix
from common.sfixed import to_sfixed_real, to_real


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
def link_to_model(dut, input, model):
    model_out = [float(model.main(Sfix(x, 0, -17))) for x in input]

    hdl_out = yield run_dut(dut, input, 18)

    # plt.plot(hdl_out)
    # plt.plot(model_out)
    # plt.show()
    if (model_out != hdl_out).any():
        raise TestFailure()
