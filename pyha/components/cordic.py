import numpy as np

from pyha.common.hwsim import HW
from pyha.common.sfix import resize, Sfix, right_index, left_index


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
        # grow inputs 1 bit because abs(1+1i) = 1.4 and another for CORDIC gain
        self.next.x[0] = resize(c.real, left_index=left_index(c.real) + 2, right_index=right_index(c.real))
        self.next.y[0] = resize(c.imag, left_index=left_index(c.imag) + 2, right_index=right_index(c.imag))
        self.next.phase[0] = phase

        for i in range(len(self.phase_lut_fix) - 1):
            self.next.x[i + 1], self.next.y[i + 1], self.next.phase[i + 1] = \
                self.pipeline_step(i, self.x[i], self.y[i], self.phase[i], self.phase_lut_fix[i])

        return self.x[-1], self.y[-1], self.phase[-1]

    def pipeline_step(self, i, x, y, p, p_adj):
        direction = y < 0
        # if direction:
        #     next_x = resize(x - (y >> i), size_res=x, overflow_style=fixed_wrap)
        #     next_y = resize(y + (x >> i), size_res=y, overflow_style=fixed_wrap)
        #     next_phase = resize(p - p_adj, size_res=p, overflow_style=fixed_wrap)
        # else:
        #     next_x = resize(x + (y >> i), size_res=x, overflow_style=fixed_wrap)
        #     next_y = resize(y - (x >> i), size_res=y, overflow_style=fixed_wrap)
        #     next_phase = resize(p + p_adj, size_res=p, overflow_style=fixed_wrap)
        if direction:
            next_x = resize(x - (y >> i), size_res=x)
            next_y = resize(y + (x >> i), size_res=y)
            next_phase = resize(p - p_adj, size_res=p)
        else:
            next_x = resize(x + (y >> i), size_res=x)
            next_y = resize(y - (x >> i), size_res=y)
            next_phase = resize(p + p_adj, size_res=p)
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

        # return [cord_model(x, xx) for x, xx in zip(c, phase)]
        return cord_model(c, phase)


class ToPolar(HW):
    def __init__(self):
        self.core = CordicCore(17)

    def main(self, c):
        phase = Sfix(0., 2, -17)
        if c.real < 0. and c.imag > 0.:  # 2 quadrant
            c.real = resize(-c.real, size_res=c.real)
            c.imag = resize(-c.imag, size_res=c.imag)
            phase = Sfix(np.pi, 2, -17)
            # x, y, phase = -x, -y, np.pi
        elif c.real < 0. and c.imag < 0.:  # 3 quadrant
            c.real = resize(-c.real, size_res=c.real)
            c.imag = resize(-c.imag, size_res=c.imag)
            phase = Sfix(-np.pi, 2, -17)

        ret = self.core.main(c, phase)
        return ret[0] * (1 / 1.646760), ret[2]

    def get_delay(self):
        return self.core.iterations

    def model_main(self, cin):
        # abs_list = []
        # phase_list = []
        retl = []
        inital_rotation = False
        for c in cin:
            # initial rotation
            # shift input to 1 or 4 quadrant (because CORDIC only works in pi range)
            phase = 0
            if c.real < 0 and c.imag > 0:  # 2 quadrant
                c = -c
                phase = np.pi
                # x, y, phase = -x, -y, np.pi
            elif c.real < 0 and c.imag < 0:  # 3 quadrant
                c = -c
                phase = -np.pi
                # x, y, phase = -x, -y, -np.pi

            x, _, phase = self.core.model_main(c, phase)

            retl.append([x * 1 / 1.646760, phase])
            # abs_list.append(x * 1 / 1.646760)
            # phase_list.append(phase)
        # return abs_list, phase_list
        return retl


class Exp(HW):
    def __init__(self, iterations=18):
        self.iterations = iterations
        self.phase_lut = [np.arctan(2 ** -i) for i in range(iterations)]

    def kernel(self, x, y, phase, mode='ROTATE'):
        if mode == 'ROTATE':
            comp = lambda y, phase: -1 if phase < 0 else 1
        elif mode == 'VECTOR':
            comp = lambda y, phase: 1 if y < 0 else -1
        else:
            raise Exception('Mode is shit!')

        for i, adj in enumerate(self.phase_lut):
            sign = comp(y, phase)
            x, y, phase = x - sign * (y * (2 ** -i)), y + sign * (x * (2 ** -i)), phase - sign * adj
        return x, y, phase

    def model_main(self, phase_list):
        sign = 1
        res = []
        wrap_acc = 0
        start_x = 1 / 1.646760

        for phase_acc in phase_list:
            phase_acc += wrap_acc

            if phase_acc > np.pi / 2:  # cordic only works from -pi/2 to pi/2
                wrap_acc -= np.pi
                start_x = -start_x
                # sign *= -1  # need to sign invert 2,3 quadrant
                phase_acc -= np.pi
            elif phase_acc < -np.pi / 2:
                wrap_acc += np.pi
                start_x = -start_x
                # sign *= -1  # need to sign invert 2,3 quadrant
                phase_acc += np.pi

            x, y, _ = self.kernel(x=start_x, y=0, phase=phase_acc, mode='ROTATE')
            # res.append([sign * x, sign * y])
            res.append(x + y * 1j)

        return res
