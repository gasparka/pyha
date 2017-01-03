import textwrap

import pytest

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, ComplexSfix
from pyha.conversion.conversion import get_conversion
from pyha.conversion.extract_datamodel import DataModel


def test_py_implementation():
    a = ComplexSfix()
    assert a.real == Sfix(0.0, 0, 0, overflow_style='SATURATE')
    assert a.imag == Sfix(0.0, 0, 0, overflow_style='SATURATE')

    a = ComplexSfix(0)
    assert a.real == Sfix(0.0, 0, 0, overflow_style='SATURATE')
    assert a.imag == Sfix(0.0, 0, 0, overflow_style='SATURATE')

    a = ComplexSfix(0.5 + 1.2j, 1, -12)
    assert a.real == Sfix(0.5, 1, -12, overflow_style='SATURATE')
    assert a.imag == Sfix(1.2, 1, -12, overflow_style='SATURATE')

    a = ComplexSfix(0.699 + 0.012j, 0, -4)
    assert a.real.val == 0.6875
    assert a.imag.val == 0
    assert a.init_val == 0.699 + 0.012j
    assert a.left == 0
    assert a.right == -4


@pytest.fixture
def reg():
    class A(HW):
        def __init__(self):
            self.reg = ComplexSfix()

        def main(self, x):
            self.next.reg = x
            return self.reg

    dut = A()
    dut.main(ComplexSfix(0.5 + 1.2j, 1, -12))
    dut.main(ComplexSfix(0.5 + 1.2j, 1, -12))
    return dut


def test_reg_datamodel(reg):
    datamodel = DataModel(reg)
    assert datamodel.locals['main']['x'] == ComplexSfix(0.5 + 1.2j, 1, -12)
    assert datamodel.self_data['reg'] == ComplexSfix(0, 1, -12)  # 0 is init value


def test_reg_conversion_datamodel(reg):
    conv = get_conversion(reg)

    expect = textwrap.dedent("""\
            type register_t is record
                reg: complex_sfix1_12;
            end record;

            type self_t is record
                reg: complex_sfix1_12;
                \\next\\: register_t;
            end record;""")
    dm = conv.get_datamodel()
    assert expect == dm


def test_reg_conversion_typedefs(reg):
    conv = get_conversion(reg)

    expect = textwrap.dedent("""\
            type complex_sfix1_12 is record
                real: sfixed(1 downto -12);
                imag: sfixed(1 downto -12);
            end record;""")

    dm = conv.get_typedefs()
    assert expect == dm


    # pass



    # list of complex!
