import numpy as np

from pyha.common.hwsim import HW
from pyha.common.sfix import resize, Sfix, right_index, left_index, fixed_wrap


# Decent cordic overview
# http://www.andraka.com/files/crdcsrvy.pdf

class CordicAtom(HW):
    def __init__(self):
        self.x = Sfix()
        self.y = Sfix()
        self.phase = Sfix()

    def main(self, i, x, y, phase, phase_adj):
        direction = y < 0
        if direction:
            self.next.x = resize(x - (y >> i), size_res=x)
            self.next.y = resize(y + (x >> i), size_res=y)
            self.next.phase = resize(phase - phase_adj, size_res=phase)
        else:
            self.next.x = resize(x + (y >> i), size_res=x)
            self.next.y = resize(y - (x >> i), size_res=y)
            self.next.phase = resize(phase + phase_adj, size_res=phase)

        return self.x, self.y, self.phase

    def get_delay(self):
        return 1

    def model_main(self, ai, ax, ay, aphase, aphase_adj):
        res = []
        for i, x, y, phase, phase_adj in zip(ai, ax, ay, aphase, aphase_adj):
            sign = 1 if y < 0 else -1
            x, y, phase = x - sign * (y * (2 ** -i)), y + sign * (x * (2 ** -i)), phase - sign * phase_adj
            res.append([x, y, phase])
        return res


class CordicCoreAlt(HW):
    def __init__(self, iterations):
        self.iterations = iterations

        self.iterations = iterations
        self.phase_lut = [np.arctan(2 ** -i) for i in range(self.iterations)]
        self.phase_lut_fix = [Sfix(x, 0, -17) for x in self.phase_lut]

        self.pipeline = [CordicAtom() for _ in range(self.iterations)]

    def main(self, c, phase):
        nx = c.real
        ny = c.imag
        np = phase
        for i, atom in enumerate(self.next.pipeline):
            nx, ny, np = atom.main(i, nx, ny, np, self.phase_lut_fix[i])

        return nx, ny, np

    def get_delay(self):
        return self.iterations

    def model_main(self, c, phase):
        def cord_model(c, phase):
            x = c.real
            y = c.imag
            for i, adj in enumerate(self.phase_lut):
                sign = 1 if y < 0 else -1
                x, y, phase = x - sign * (y * (2 ** -i)), y + sign * (x * (2 ** -i)), phase - sign * adj
            return x, y, phase

        return [cord_model(x, xx) for x, xx in zip(c, phase)]




class CordicCore(HW):
    def __init__(self, iterations):
        self.iterations = iterations

        self.iterations = iterations + 1
        self.phase_lut = [np.arctan(2 ** -i) for i in range(self.iterations)]
        self.phase_lut_fix = [Sfix(x, 0, -17) for x in self.phase_lut]

        # pipeline registers
        self.x = [Sfix()] * self.iterations
        self.y = [Sfix()] * self.iterations
        self.phase = [Sfix()] * self.iterations

    # def rotate(self, i, x, y, phase):
    #     direction = y < 0
    #     if direction:
    #         next_x = resize(x - (y >> i), size_res=x)
    #         next_y = resize(y + (x >> i), size_res=y)
    #         next_phase = resize(phase - self.phase_lut_fix[i], size_res=phase)
    #     else:
    #         next_x = resize(x + (y >> i), size_res=x)
    #         next_y = resize(y - (x >> i), size_res=y)
    #         next_phase = resize(phase + self.phase_lut_fix[i], size_res=phase)
    #
    #     return next_x, next_y, next_phase
    #
    # def rot(self, i, x, y, p, adj):
    #     direction = y < 0
    #     if direction:
    #         xn = x - (y >> i)
    #         yn = y + (x >> i)
    #         pn = p - adj
    #     else:
    #         xn = x + (y >> i)
    #         yn = y - (x >> i)
    #         pn = p + adj
    #     return resize(xn, x), resize(yn, y), resize(pn, p)

    def main(self, c, phase):
        self.next.x[0] = resize(c.real, left_index=left_index(c.real) + 1, right_index=right_index(c.real))
        self.next.y[0] = resize(c.imag, left_index=left_index(c.imag) + 1, right_index=right_index(c.imag))
        self.next.phase[0] = phase

        for i in range(len(self.phase_lut_fix) - 1):
            self.next.x[i+1], self.next.y[i+1], self.next.phase[i+1] = \
                self.pipeline_step(i, self.x[i], self.y[i], self.phase[i], self.phase_lut_fix[i])

        return self.x[-1], self.y[-1], self.phase[-1]

    def pipeline_step(self, i, x, y, p, p_adj):
        direction = y < 0
        if direction:
            next_x = resize(x - (y >> i), size_res=x, overflow_style=fixed_wrap)
            next_y = resize(y + (x >> i), size_res=y, overflow_style=fixed_wrap)
            next_phase = resize(p - p_adj, size_res=p, overflow_style=fixed_wrap)
        else:
            next_x = resize(x + (y >> i), size_res=x, overflow_style=fixed_wrap)
            next_y = resize(y - (x >> i), size_res=y, overflow_style=fixed_wrap)
            next_phase = resize(p + p_adj, size_res=p, overflow_style=fixed_wrap)

        return next_x, next_y, next_phase

    def get_delay(self):
        return self.iterations

    def model_main(self, c, phase):
        def cord_model(c, phase):
            x = c.real
            y = c.imag
            for i, adj in enumerate(self.phase_lut):
                sign = 1 if y < 0 else -1
                x, y, phase = x - sign * (y * (2 ** -i)), y + sign * (x * (2 ** -i)), phase - sign * adj
            return x, y, phase

        return [cord_model(x, xx) for x, xx in zip(c, phase)]


class ToPolar:
    def model_main(self, c, phase):
        abs_list = []
        phase_list = []
        inital_rotation = False
        for x, y in zip(x_list, y_list):
            # initial rotation
            # shift input to 1 or 4 quadrant (because CORDIC only works in pi range)
            phase = 0
            if x < 0 and y > 0:  # 2 quadrant
                x, y, phase = -x, -y, np.pi
            elif x < 0 and y < 0:  # 3 quadrant
                x, y, phase = -x, -y, -np.pi

            x, _, phase = self.kernel(x, y, phase, mode='VECTOR')

            abs_list.append(x * 1 / 1.646760)
            phase_list.append(phase)
        return abs_list, phase_list
