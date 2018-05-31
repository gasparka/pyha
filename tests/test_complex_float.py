import numpy as np

from pyha import Hardware, simulate, sims_close
from pyha.common.float import Float, ComplexFloat


class TestInit:
    def test_loopback(self):
        class Dut(Hardware):
            def main(self, i):
                return i

        input = [0.123 - 0.234j]
        dut = Dut()
        sims = simulate(dut, input, input_types=[ComplexFloat()], simulations=['PYHA',
                                                                        'RTL',
                                                                        # 'GATE'
                                                                        ],
                        conversion_path='/home/gaspar/git/pyha/playground')
        assert sims_close(sims, rtol=1e-9, atol=1e-9)