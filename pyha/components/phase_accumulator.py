import numpy as np

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, resize


class PhaseAccumlator(HW):
    def __init__(self):
        self.acc = Sfix(0.0, 2, -32)

    def main(self, step):
        acc = resize(self.acc + step, size_res=self.acc)
        acc_over_pi = resize(self.acc + step - 2 * np.pi, size_res=self.acc)
        acc_under_pi = resize(self.acc + step + 2 * np.pi, size_res=self.acc)

        self.next.acc = acc
        if acc > np.pi:
            self.next.acc = acc_over_pi
        elif acc < -np.pi:
            self.next.acc = acc_under_pi

        return self.acc

    def get_delay(self):
        return 1

    def model_main(self, phase_inc):
        ret = []
        acc = 0.0
        for step in phase_inc:
            acc += step
            if acc > np.pi:
                acc -= 2 * np.pi
            elif acc < -np.pi:
                acc += 2 * np.pi
            ret.append(acc)
        return ret
