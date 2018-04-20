from pyha import Hardware, simulate, sims_close
from pyha.common.float import Float


def test_float():
    class Dut(Hardware):
        def __init__(self):
            self.counter = Float(0.5)

        def main(self, inp):
            print(self.counter)
            return self.counter, inp

    dut = Dut()
    inp = list(range(128))

    sims = simulate(dut, inp, simulations=['PYHA', 'RTL'])
    assert sims_close(sims)