# this happened when i added test_conversion.py file. It somehow
# breaks test in test_covert.py.
# datamodel related
# Reason, firs test sets the datamodel and the later does not clear
# it first, because it does not use convert method!
import textwrap

import pytest
from pyha.common.hwsim import HW
from pyha.conversion.conversion import Conversion
from pyha.conversion.converter import convert
from redbaron import RedBaron


@pytest.fixture
def dut():
    class Dummy(HW):
        def main(self, a):
            return a

    o = Dummy()
    # train object
    o(1)
    o(2)
    return Conversion(o)

# commenting this out, makes later test pass!
def test_lol(dut):
    pass


@pytest.fixture
def converter():
    class Conv:
        def __call__(self, code):
            red = RedBaron(code)
            return convert(red[0], caller=self)

    return Conv()


def test_def_argument(converter):
    code = textwrap.dedent("""\
        def a(b):
            pass""")

    expect = textwrap.dedent("""\
        procedure a(b: unknown_type) is

        begin

        end procedure;""")
    conv = converter(code)
    assert str(conv) == expect
