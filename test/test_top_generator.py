import textwrap

import pytest
from common.sfix import Sfix
from conversion.top_generator import inout_saver


@pytest.fixture
def basic_obj():
    class A:
        @inout_saver
        def __call__(self, a, b, c):
            return a * 5, True, Sfix(0.0, 5, -8)

    dut = A()
    dut(2, Sfix(1.0, 2, -17), False)
    return dut


def test_top_vhdl_entity(basic_obj):
    dut = basic_obj()

    expect = textwrap.dedent("""\
        entity  top is
          port (
            clk, rst_n: in std_logic;

            -- inputs
            in0: in std_logic_vector(31 downto 0);
            in1: in std_logic_vector(19 downto 0);
            in2: in std_logic;

            -- outputs
            out0: out std_logic_vector(31 downto 0);
            out1: out std_logic;
            out2: out std_logic_vector(13 downto 0);
          );
        end entity;""")

    res = TopGenerator(dut)

    assert expect == res._
    print(obj.__call__)
    # print(simulated_obj('tereloom'))


def test_decorator(basic_obj):
    class A:
        @inout_saver
        def __call__(self, a, b, c):
            return a * 5, True, Sfix(0.0)

    dut = A()
    dut(2, Sfix(1.0), False)
    assert type(dut.__call__._last_call['args'][1]) == int
    assert type(dut.__call__._last_call['args'][2]) == Sfix
    assert type(dut.__call__._last_call['args'][3]) == bool

    assert type(dut.__call__._last_call['return'][0]) == int
    assert type(dut.__call__._last_call['return'][1]) == bool
    assert type(dut.__call__._last_call['return'][2]) == Sfix


def test_decorator_kwargs():
    class A:
        @inout_saver
        def __call__(self, a, b, c):
            return a * 5, True, Sfix(0.0)

    dut = A()
    dut(b=2, c=Sfix(1.0), a=False)
    assert type(dut.__call__._last_call['kwargs']['b']) == int
    assert type(dut.__call__._last_call['kwargs']['c']) == Sfix
    assert type(dut.__call__._last_call['kwargs']['a']) == bool

    assert type(dut.__call__._last_call['return'][0]) == int
    assert type(dut.__call__._last_call['return'][1]) == bool
    assert type(dut.__call__._last_call['return'][2]) == Sfix
