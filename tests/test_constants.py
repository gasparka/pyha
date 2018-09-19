from pyha import Hardware, simulate, sims_close


def test_basic():
    class T(Hardware):
        def __init__(self):
            self.CONST = 1
            self.reg = 2

        def main(self, dummy):
            return self.CONST, self.reg

    dut = T()
    sims = simulate(dut, [0, 1], simulations=['MODEL_PYHA', 'HARDWARE', 'RTL', 'GATE'], conversion_path='/home/gaspar/git/pyha/playground')
    assert sims_close(sims)