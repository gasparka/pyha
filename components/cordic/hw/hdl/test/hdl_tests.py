# Simple tests for an adder module

import cocotb
import numpy as np
from cocotb.clock import Clock
from cocotb.result import ReturnValue
from cocotb.triggers import RisingEdge, Timer, FallingEdge


@cocotb.coroutine
def reset(dut, duration=10000):
    dut.log.debug("Resetting DUT")
    dut.rst_n = 0
    yield Timer(duration)
    yield RisingEdge(dut.clk)
    dut.rst_n = 1
    dut.log.debug("Out of reset")

@cocotb.coroutine
def run_dut(dut, in_data, out_count):
    cocotb.fork(Clock(dut.clk, 5000).start())
    yield reset(dut)

    ret = []
    # print('Input data: {}'.format(in_data))
    for x in in_data:

        # put input
        # print('Processing slice: {}'.format(x))
        for i, xi in enumerate(x):
            # print('Set {} to {}'.format('x' + str(i+1), xi))
            setattr(dut, 'x' + str(i + 1), xi.astype(int))

        # NOTICE: need to have both yields to match simulation.
        yield RisingEdge(dut.clk)
        yield FallingEdge(dut.clk)

        # collect output
        tmp = []
        for i in range(out_count):
            var = 'y' + str(i + 1)
            val = getattr(dut, var).value.signed_integer
            # print('Got out {} = {}'.format(var, val))
            tmp.append(val)
        ret.append(tmp)

    # print('Finish, ret: {}'.format(ret))
    raise ReturnValue(ret)

@cocotb.test()
def test_main(dut):
    import os
    in_data = np.load(os.getcwd() + '/../input.npy')
    in_data = np.transpose(in_data)
    # print(in_data)

    output_vars = int(os.environ['OUTPUT_VARIABLES'])
    hdl_out = yield run_dut(dut, in_data, output_vars)
    hdl_out = np.transpose(hdl_out)
    # print(hdl_out)

    np.save(os.getcwd() + '/../output.npy', hdl_out)
