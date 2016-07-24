import numpy as np


class CORDIC(object):
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

    def __call__(self, *args, **kwargs):
        return self.kernel(*args, **kwargs)
    # NB THIS IS BETTER FOR HARDWARE
    # def exp(self, phase_inc, samples):
    #     phase_acc = 0
    #     sign = 1
    #     res = []
    #     for _ in range(samples):
    #         # phase_acc += phase_inc
    #         if phase_acc > np.pi / 2:  # cordic only works from -pi/2 to pi/2
    #             phase_acc -= np.pi
    #             sign *= -1  # need to sign invert 2,3 quadrant
    #
    #         x, y, _ = self.kernel(x=1 / 1.646760, y=0, phase=phase_acc)
    #         res += [sign * x + sign * y * 1j]
    #         phase_acc += phase_inc
    #
    #     return res

    def exp(self, phase_list):
        # remove 1j from input. just to make calling comatible wiht numpy
        phase_list = [x / 1j for x in phase_list]
        # phase_list /= 1j
        sign = 1
        res = []
        wrap_acc = 0

        for phase_acc in phase_list:
            phase_acc += wrap_acc

            if phase_acc > np.pi / 2:  # cordic only works from -pi/2 to pi/2
                wrap_acc -= np.pi
                sign *= -1  # need to sign invert 2,3 quadrant
                phase_acc -= np.pi
            elif phase_acc < -np.pi / 2:
                wrap_acc += np.pi
                sign *= -1  # need to sign invert 2,3 quadrant
                phase_acc += np.pi

            x, y, _ = self.kernel(x=1 / 1.646760, y=0, phase=phase_acc, mode='ROTATE')
            res += [sign * x + sign * y * 1j]

        return res

    def to_polar(self, x_list, y_list):
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

    def angle(self, xy):
        _, phase = self.to_polar(xy.real, xy.imag)
        return phase
