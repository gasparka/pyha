import textwrap
from pathlib import Path

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, ComplexSfix
from pyha.conversion.conversion import Conversion
from pyha.simulation.simulation_interface import assert_sim_match, SIM_HW_MODEL, SIM_RTL, SIM_GATE


class TestRegister:
    def setup(self):
        class A(HW):
            def __init__(self):
                self.reg = ComplexSfix(0.5 + 1.2j, 1, -12)

            def main(self, x):
                self.reg = x
                return self.reg

        self.dut = A()
        self.dut.main(ComplexSfix(0.5 + 1.2j, 1, -12))




    def test_simulate(self):
        x = [0.5 + 0.1j, 0.5 - 0.09j, -0.5 + 0.1j, 0.14 + 0.1j, 0.5 + 0.89j]
        expected = [0.5 + 1.2j, 0.5 + 0.1j, 0.5 - 0.09j, -0.5 + 0.1j, 0.14 + 0.1j]

        assert_sim_match(self.dut, expected, x, types=[ComplexSfix(left=1, right=-12)], rtol=1e-3, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])




class TestRegisterIQ:
    """ This assigns to I and Q separately -> there were pointer problems here.. """

    def setup(self):
        class A4(HW):
            def __init__(self):
                self.reg = ComplexSfix(0 + 0j, 1, -18)
                self.DELAY = 1

            def main(self, x0):
                self.reg.real = x0.real
                self.reg.imag = x0.imag
                return self.reg

        self.dut = A4()


    def test_comp_reg_delay(self):
        next = ComplexSfix(1 + 1j, 1, -18)
        assert id(self.dut.reg.real) != id(self.dut.reg._pyha_next['real'])
        assert id(self.dut.reg.imag) != id(self.dut.reg._pyha_next['imag'])

        self.dut.main(next)

        assert id(self.dut.reg.real) != id(self.dut.reg._pyha_next['real'])
        assert id(self.dut.reg.imag) != id(self.dut.reg._pyha_next['imag'])

        self.dut._pyha_update_self()

        # assert id(self.dut.reg.real) != id(self.dut.reg._pyha_next['real'])
        # assert id(self.dut.reg.imag) != id(self.dut.reg._pyha_next['imag'])

        next = ComplexSfix(2 + 2j, 1, -18)
        self.dut.main(next)

        assert self.dut.reg._pyha_next['real'].val == next.real.val
        assert self.dut.reg._pyha_next['imag'].val == next.imag.val

        assert self.dut.reg.real != next.real
        assert self.dut.reg.imag != next.imag

    def test_comp_reg_simulate(self):
        inputs = [0.5 + 0.1j, 0.5 - 0.09j, +0.5 + 0.1j, 0.14 + 0.1j, 0.5 + 0.89j]
        expect = [0.5 + 0.1j, 0.5 - 0.09j, +0.5 + 0.1j, 0.14 + 0.1j, 0.5 + 0.89j]

        assert_sim_match(self.dut, expect, inputs, types=[ComplexSfix(left=1, right=-18)], rtol=1e-3, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])

    def test_comp_reg_simulate2(self):
        # -real made cocotb code fail
        inputs = [-0.5 - 0.1j, -0.5 + 0.1j, +0.5 - 0.1j]
        expect = [-0.5 - 0.1j, -0.5 + 0.1j, +0.5 - 0.1j]

        assert_sim_match(self.dut, expect, inputs, types=[ComplexSfix(left=1, right=-18)], rtol=1e-3, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])


class TestComplexReturn:
    def setup(self):
        class A5(HW):
            def __init__(self):
                self.reg0 = ComplexSfix()

            def main(self, x0, x1, x2, x3):
                self.reg0 = ComplexSfix(x0, x1)
                ret = ComplexSfix(x2, x3)
                return self.reg0, ret

        self.dut = A5()
        self.dut.main(Sfix(-0.24, 0, -18), Sfix(-0.24, 0, -18), Sfix(-0.24, 0, -32), Sfix(-0.24, 0, -32))
        self.dut._pyha_update_self()

        self.dut.main(Sfix(-0.24, 0, -18), Sfix(-0.24, 0, -18), Sfix(-0.24, 0, -32), Sfix(-0.24, 0, -32))
        self.dut._pyha_update_self()

    def test_complex_types_generation(self):
        conv = Conversion(self.dut)
        expect = textwrap.dedent("""\
                library ieee;
                    use ieee.fixed_pkg.all;

                package ComplexTypes is
                type complex_sfix0_18 is record
                    real: sfixed(0 downto -18);
                    imag: sfixed(0 downto -18);
                end record;
                function ComplexSfix(a, b: sfixed(0 downto -18)) return complex_sfix0_18;

                type complex_sfix0_32 is record
                    real: sfixed(0 downto -32);
                    imag: sfixed(0 downto -32);
                end record;
                function ComplexSfix(a, b: sfixed(0 downto -32)) return complex_sfix0_32;

                end package;

                package body ComplexTypes is
                function ComplexSfix(a, b: sfixed(0 downto -18)) return complex_sfix0_18 is
                begin
                    return (a, b);
                end function;

                function ComplexSfix(a, b: sfixed(0 downto -32)) return complex_sfix0_32 is
                begin
                    return (a, b);
                end function;

                end package body;
                """)

        files = conv.write_vhdl_files(Path('/tmp/'))
        with files[0].open('r') as f:
            next(f)
            assert expect == f.read()

    def test_complex_inits_return_simulate(self):
        x = [[-0.24, -0.24, -0.24, -0.24], [-0.24, -0.24, -0.24, -0.24], [-0.24, -0.24, -0.24, 0.1234],
             [-0.24, -0.24, -0.24, 0.1234]]
        expected = [
            [0.000000 + 0.j, -0.240002 - 0.240002j, -0.240002 - 0.240002j, -0.240002 - 0.240002j],
            [-0.240000 - 0.24j, -0.240000 - 0.24j, -0.240000 - 0.24j, 0.1234 + 0.1234j]
        ]

        assert_sim_match(self.dut,
                         expected, *x,
                         types=[Sfix(left=0, right=-18), Sfix(left=0, right=-18), Sfix(left=0, right=-32),
                                Sfix(left=0, right=-32)],
                         rtol=1e-3, simulations=[SIM_HW_MODEL, SIM_RTL, SIM_GATE])

