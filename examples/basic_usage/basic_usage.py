from pyha import Hardware, Sfix


class Mult(Hardware):
    def __init__(self, coef):
        # constants
        self.COEF = coef
        self.DELAY = 1

        self.outreg = Sfix(left=0, right=-17)

    def main(self, input):
        self.outreg = input * self.COEF
        return self.outreg


def test_basic():
    dut = Mult(coef=0.5)
    inputs = [0.1, 0.2, 0.3, 0.2, 0.1]
    expect = [0.05, 0.1, 0.15, 0.1, 0.05]

    sims = simulate(dut,
                     inputs,
                     dir_path='/home/gaspar/git/pyha/examples/basic_usage/conversion')
