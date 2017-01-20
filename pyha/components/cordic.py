from enum import Enum

import numpy as np

from pyha.common.hwsim import HW
from pyha.common.sfix import resize, Sfix, right_index, left_index, fixed_wrap, fixed_truncate, ComplexSfix


# Decent cordic overview
# http://www.andraka.com/files/crdcsrvy.pdf

class CordicMode(Enum):
    VECTORING, ROTATION = range(2)



class Cordic(HW):
    def __init__(self, iterations, mode):
        self.mode_const = mode
        self.iterations = iterations

        # +1 due to pipelining code..will act as output register
        # todo: this implies that i have input registers...why?
        self.iterations = iterations + 1
        self.phase_lut = [np.arctan(2 ** -i) / np.pi for i in range(self.iterations)]
        self.phase_lut_fix = [Sfix(x, 0, -24) for x in self.phase_lut]

        # pipeline registers
        self.x = [Sfix()] * self.iterations
        self.y = [Sfix()] * self.iterations
        self.phase = [Sfix()] * self.iterations

    def main(self, x, y, phase):
        if self.mode_const == CordicMode.ROTATION:
            self.next.y[0] = y
            if phase > 0.5:
                # > np.pi/2
                self.next.x[0] = resize(-x, size_res=x)
                self.next.phase[0] = resize(phase - 1.0, size_res=phase)
            elif phase < -0.5:
                # < -np.pi/2
                self.next.x[0] = resize(-x, size_res=x)
                self.next.phase[0] = resize(phase + 1.0, size_res=phase)
            else:
                # phase in [-0.5, 0.5] (-np.pi/2, np.pi/2)-> no action needed
                self.next.x[0] = resize(x, size_res=x)
                self.next.phase[0] = resize(phase, size_res=phase)

        elif self.mode_const == CordicMode.VECTORING:
            # need to increase x and y size by 2 as there will be CORDIC gain + abs value held by x can be > 1
            if x < 0.0 and y > 0.0:
                # vector in II quadrant -> initial shift by PI to IV quadrant (mirror)
                self.next.x[0] = resize(-x, left_index(x) + 2, right_index(x))
                self.next.y[0] = resize(-y, left_index(y) + 2, right_index(y))
                self.next.phase[0] = Sfix(1.0, phase)
            elif x < 0.0 and y < 0.0:
                # vector in III quadrant -> initial shift by -PI to I quadrant (mirror)
                self.next.x[0] = resize(-x, left_index(x) + 2, right_index(x))
                self.next.y[0] = resize(-y, left_index(y) + 2, right_index(y))
                self.next.phase[0] = Sfix(-1.0, phase)
            else:
                # vector in I or IV quadrant -> no action needed
                self.next.x[0] = resize(x, left_index(x) + 2, right_index(x))
                self.next.y[0] = resize(y, left_index(y) + 2, right_index(y))
                self.next.phase[0] = phase

        for i in range(len(self.phase_lut_fix) - 1):
            self.next.x[i + 1], self.next.y[i + 1], self.next.phase[i + 1] = \
                self.pipeline_step(i, self.x[i], self.y[i], self.phase[i], self.phase_lut_fix[i])

        return self.x[-1], self.y[-1], self.phase[-1]

    def pipeline_step(self, i, x, y, p, p_adj):
        if self.mode_const == CordicMode.ROTATION:
            direction = p > 0
        elif self.mode_const == CordicMode.VECTORING:
            direction = y < 0

        if direction:
            next_x = resize(x - (y >> i), size_res=x)
            next_y = resize(y + (x >> i), size_res=y)
            next_phase = resize(p - p_adj, size_res=p, overflow_style=fixed_wrap)
        else:
            next_x = resize(x + (y >> i), size_res=x)
            next_y = resize(y - (x >> i), size_res=y)
            next_phase = resize(p + p_adj, size_res=p, overflow_style=fixed_wrap)
        return next_x, next_y, next_phase

    def get_delay(self):
        return self.iterations

    def model_main(self, x, y, phase):
        # this model uses (y * (2 ** -i)) for shift right. meaning it loses no precision for this operation
        # for that reason model and hw_model will not be perfectly matched, can expect 1e-4 to 1e-5 rtol/atol
        def cord_model(x, y, phase):
            if self.mode_const == CordicMode.ROTATION:
                if phase > 0.5:
                    x = -x
                    phase -= 1.0
                elif phase < -0.5:
                    x = -x
                    phase += 1.0
            elif self.mode_const == CordicMode.VECTORING:
                if x < 0.0 and y > 0.0:
                    # vector in II quadrant -> initial shift by PI to IV quadrant (mirror)
                    x = -x
                    y = -y
                    phase = 1.0
                elif x < 0.0 and y < 0.0:
                    # vector in III quadrant -> initial shift by -PI to I quadrant (mirror)
                    x = -x
                    y = -y
                    phase = -1.0

            for i, adj in enumerate(self.phase_lut):
                if self.mode_const == CordicMode.ROTATION:
                    sign = 1 if phase > 0 else -1
                elif self.mode_const == CordicMode.VECTORING:
                    sign = 1 if y < 0 else -1
                x, y, phase = x - sign * (y * (2 ** -i)), y + sign * (x * (2 ** -i)), phase - sign * adj
            return x, y, phase

        return [cord_model(xx, yy, pp) for xx, yy, pp in zip(x, y, phase)]


class NCO(HW):
    def __init__(self, cordic_iterations=16):
        self.cordic = Cordic(cordic_iterations, CordicMode.ROTATION)
        self.phase_acc = Sfix()

    def main(self, phase_inc):
        self.next.phase_acc = resize(self.phase_acc + phase_inc, size_res=phase_inc, overflow_style=fixed_wrap,
                                     round_style=fixed_truncate)

        start_x = Sfix(1.0 / 1.646760, 0, -17)  # gets rid of cordic gain, could add amplitude modulation here
        start_y = Sfix(0.0, 0, -17)
        x, y, phase = self.next.cordic.main(start_x, start_y, self.phase_acc)
        retc = ComplexSfix(x, y)
        return retc

    def get_delay(self):
        r = self.cordic.iterations + 1
        return r

    def model_main(self, phase_list):
        p = np.cumsum(phase_list * np.pi)
        return np.exp(p * 1j)


class ToPolar(HW):
    def __init__(self):
        self.core = Cordic(17, CordicMode.VECTORING)
        self.out_abs = Sfix()
        self.out_angle = Sfix()

    def main(self, c):
        phase = Sfix(0.0, 0, -17)

        abs, _, angle = self.next.core.main(c.real, c.imag, phase)
        self.next.out_abs = resize(abs * (1.0 / 1.646760), size_res=abs)
        self.next.out_angle = angle
        return self.out_abs, self.out_angle

    def get_delay(self):
        r = self.core.iterations + 1
        return r

    def model_main(self, cin):
        # note that angle in -1..1 range
        return [[abs(x), np.angle(x) / np.pi] for x in cin]