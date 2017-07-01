import textwrap
from unittest import TestCase

from pyha.common.hwsim import HW, PyhaInt, PyhaBool

# todo: redistribute these tests to normal files
from pyha.common.sfix import Sfix
from pyha.conversion.conversion import get_conversion


class TestHW:
    def test__pyha_get_conversion_vars_int(self):
        class T(HW):
            def __init__(self):
                self.i = 0

            def main(self, i):
                self.i = i

        dut = T()
        dut.main(1)
        dut._pyha_update_self()
        ret = dut._pyha_get_conversion_vars()

        expect = [PyhaInt('i', 1, 0)]

        assert ret == expect

    def test__pyha_get_conversion_vars_bool(self):
        class T(HW):
            def __init__(self):
                self.i = False

            def main(self, i):
                self.i = i

        dut = T()
        dut.main(True)
        dut._pyha_update_self()
        ret = dut._pyha_get_conversion_vars()

        expect = [PyhaBool('i', True, False)]

        assert ret == expect


