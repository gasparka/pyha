import textwrap

import pytest
from common.sfix import Sfix
from conversion.top_generator import inout_saver, TopGenerator


@pytest.fixture
def basic_obj():
    class A:
        @inout_saver
        def __call__(self, a, b, c):
            return a * 5, True, Sfix(0.0, 5, -8)

    dut = A()
    dut(2, Sfix(1.0, 2, -17), False)
    dut(-57, Sfix(1.0, 2, -17), True)
    dut(-57, Sfix(1.0, 2, -17), c=True)
    return dut


def test_entity_basic(basic_obj):
    dut = basic_obj
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

    assert expect == res.make_entity()


def test_variables_output(basic_obj):
    dut = basic_obj
    expect = textwrap.dedent("""\
                variable var_out0: integer;
                variable var_out1: boolean;
                variable var_out2: sfixed(5 downto -8);""")

    res = TopGenerator(dut)

    assert expect == res.output_variables()


def test_variables_input(basic_obj):
    dut = basic_obj
    expect = textwrap.dedent("""\
                variable var_in0: integer;
                variable var_in1: sfixed(2 downto -17);
                variable var_in2: boolean;""")

    res = TopGenerator(dut)

    assert expect == res.input_variables()


def test_input_type_conversion(basic_obj):
    dut = basic_obj
    expect = textwrap.dedent("""\
                var_in0 := to_integer(to_signed(in0));
                var_in1 := to_sfixed(in1, 2, -17);
                var_in2 := in2;""")

    res = TopGenerator(dut)

    assert expect == res.input_type_conversions()

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
