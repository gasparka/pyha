import numpy as np

from pyha.common.hwsim import HW
from pyha.common.sfix import Sfix, resize, fixed_truncate, fixed_wrap


class PhaseAccumlator(HW):
    def __init__(self):
        self.acc = Sfix()
        self.step = Sfix()
        self.step_ppi = Sfix()
        self.step_npi = Sfix()


    def main(self, step):
        self.next.step = step
        self.next.step_npi = resize(step - 2.0 * np.pi, size_res=step, overflow_style=fixed_wrap,
                                    round_style=fixed_truncate)
        self.next.step_ppi = resize(step + 2.0 * np.pi, size_res=step, overflow_style=fixed_wrap,
                                    round_style=fixed_truncate)

        acc = resize(self.acc + self.step, size_res=step, overflow_style=fixed_wrap, round_style=fixed_truncate)
        acc_over_pi = resize(self.acc + self.step_npi, size_res=step, overflow_style=fixed_wrap,
                             round_style=fixed_truncate)
        acc_under_pi = resize(self.acc + self.step_ppi, size_res=step, overflow_style=fixed_wrap,
                              round_style=fixed_truncate)

        self.next.acc = acc
        if acc > np.pi:
            self.next.acc = acc_over_pi
        elif acc < -np.pi:
            self.next.acc = acc_under_pi

        return self.acc

    # def main(self, step):
    #     acc = resize(self.acc + step, size_res=step, overflow_style=fixed_wrap,  round_style=fixed_truncate)
    #     acc_over_pi = resize(self.acc + step - 2.0 * np.pi, size_res=step, overflow_style=fixed_wrap,  round_style=fixed_truncate)
    #     acc_under_pi = resize(self.acc + step + 2.0 * np.pi, size_res=step, overflow_style=fixed_wrap, round_style=fixed_truncate)
    #
    #     self.next.acc = acc
    #     if acc > np.pi:
    #         self.next.acc = acc_over_pi
    #     elif acc < -np.pi:
    #         self.next.acc = acc_under_pi
    #
    #     return self.acc

    def get_delay(self):
        return 2

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
