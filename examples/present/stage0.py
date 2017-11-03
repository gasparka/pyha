from pyha.common.hwsim import Hardware


class Demo(Hardware):
    """ Demo class, multiply and add coef to input """

    def __init__(self, coef):
        self.coef = coef

        # registers
        self.mult = Sfix()
        self.add = Sfix()

        # constants
        self.coef_f = Sfix(coef, 0, -17)

        self.DELAY = 1

    def multiply(self, input):
        """ Mulitply 'input' with self.coef """
        self.next.mult = resize(input * self.coef_f, size_res=input,
                                       round_style=fixed_truncate)
        return self.mult

    def adder(self, input):
        """ Add 'input' and self.coef """
        self.next.add = resize(input + self.coef_f, size_res=input)
        return self.add

    def main(self, input):
        mult = self.multiply(input)
        add = self.adder(input)
        return mult, add