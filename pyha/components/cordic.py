from enum import Enum

import numpy as np

from pyha.common.const import Const
from pyha.common.hwsim import HW
from pyha.common.sfix import resize, Sfix, right_index, left_index, fixed_wrap, fixed_truncate, ComplexSfix


# Decent cordic overview
# readable paper -> http://www.andraka.com/files/crdcsrvy.pdf
# vhdl implementation -> https://github.com/Nuand/bladeRF/blob/master/hdl/fpga/ip/nuand/synthesis/cordic.vhd

class CordicMode(Enum):
    VECTORING, ROTATION = range(2)


class Cordic(HW):
    def __init__(self, iterations, mode):
        self.mode = Const(mode)
        self.iterations = iterations

        # + 1 is basically for initial step registers it also helps pipeline code
        self.iterations = iterations + 1
        self.phase_lut = [float(np.arctan(2 ** -i) / np.pi) for i in range(self.iterations)]
        self.phase_lut_fix = Const([Sfix(x, 0, -24) for x in self.phase_lut])

        # todo: this would fail GATE simulation, no errors, quick RTL inspection looks OK
        # self.phase_lut_fix = Const(self.phase_lut)

        # pipeline registers
        self.x = [Sfix()] * self.iterations
        self.y = [Sfix()] * self.iterations
        self.phase = [Sfix()] * self.iterations

        self._delay = self.iterations

    def main(self, x, y, phase):
        self.initial_step(phase, x, y)

        for i in range(len(self.phase_lut_fix) - 1):
            self.next.x[i + 1], self.next.y[i + 1], self.next.phase[i + 1] = \
                self.pipeline_step(i, self.x[i], self.y[i], self.phase[i], self.phase_lut_fix[i])

        return self.x[-1], self.y[-1], self.phase[-1]

    def initial_step(self, phase, x, y):
        self.next.x[0] = x
        self.next.y[0] = y
        self.next.phase[0] = phase
        if self.mode == CordicMode.ROTATION:
            if phase > 0.5:
                # > np.pi/2
                self.next.x[0] = resize(-x, size_res=x)
                self.next.phase[0] = resize(phase - 1.0, size_res=phase)
            elif phase < -0.5:
                # < -np.pi/2
                self.next.x[0] = resize(-x, size_res=x)
                self.next.phase[0] = resize(phase + 1.0, size_res=phase)

        elif self.mode == CordicMode.VECTORING:
            if x < 0.0 and y > 0.0:
                # vector in II quadrant -> initial shift by PI to IV quadrant (mirror)
                self.next.x[0] = resize(-x, size_res=x)
                self.next.y[0] = resize(-y, size_res=y)
                self.next.phase[0] = Sfix(1.0, phase)
            elif x < 0.0 and y < 0.0:
                # vector in III quadrant -> initial shift by -PI to I quadrant (mirror)
                self.next.x[0] = resize(-x, size_res=x)
                self.next.y[0] = resize(-y, size_res=y)
                self.next.phase[0] = Sfix(-1.0, phase)

    def pipeline_step(self, i, x, y, p, adj):
        if self.mode == CordicMode.ROTATION:
            direction = p > 0
        elif self.mode == CordicMode.VECTORING:
            direction = y < 0

        if direction:
            next_x = resize(x - (y >> i), size_res=x, overflow_style=fixed_wrap)
            next_y = resize(y + (x >> i), size_res=y, overflow_style=fixed_wrap)
            next_phase = resize(p - adj, size_res=p, overflow_style=fixed_wrap)
        else:
            next_x = resize(x + (y >> i), size_res=x, overflow_style=fixed_wrap)
            next_y = resize(y - (x >> i), size_res=y, overflow_style=fixed_wrap)
            next_phase = resize(p + adj, size_res=p, overflow_style=fixed_wrap)
        return next_x, next_y, next_phase


    def model_main(self, x, y, phase):
        # this model uses (y * (2 ** -i)) for shift right. meaning it loses no precision for this operation
        # for that reason model and hw_model will not be perfectly matched, can expect 1e-4 to 1e-5 rtol/atol
        # actually not 100% sure that is the reason for strange behaviour
        def cord_model(x, y, phase):
            if self.mode == CordicMode.ROTATION:
                if phase > 0.5:
                    x = -x
                    phase -= 1.0
                elif phase < -0.5:
                    x = -x
                    phase += 1.0
            elif self.mode == CordicMode.VECTORING:
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
                if self.mode == CordicMode.ROTATION:
                    sign = 1 if phase > 0 else -1
                elif self.mode == CordicMode.VECTORING:
                    sign = 1 if y < 0 else -1
                x, y, phase = x - sign * (y * (2 ** -i)), y + sign * (x * (2 ** -i)), phase - sign * adj
            return x, y, phase

        return [cord_model(xx, yy, pp) for xx, yy, pp in zip(x, y, phase)]


class NCO(HW):
    def __init__(self, cordic_iterations=16):
        self.cordic = Cordic(cordic_iterations, CordicMode.ROTATION)
        self.phase_acc = Sfix()
        self._delay = self.cordic.iterations + 1

    def main(self, phase_inc):
        self.next.phase_acc = resize(self.phase_acc + phase_inc, size_res=phase_inc, overflow_style=fixed_wrap,
                                     round_style=fixed_truncate)

        start_x = Sfix(1.0 / 1.646760, 1, -17)  # gets rid of cordic gain, could add amplitude modulation here
        start_y = Sfix(0.0, 1, -17)  # 1 bit for gains, remove later

        x, y, phase = self.cordic.main(start_x, start_y, self.phase_acc)
        xr = resize(x, 0, -17)
        yr = resize(y, 0, -17)
        retc = ComplexSfix(xr, yr)
        return retc

    def model_main(self, phase_list):
        p = np.cumsum(phase_list * np.pi)
        return np.exp(p * 1j)


class ToPolar(HW):
    # """ Internal sizes are referenced to input 'c' size.
    # Output is abs and angle. Abs is gain corrected and sized to 'c' size.
    # Angle is sized to 'c' size.
    # """

    def __init__(self):
        self.core = Cordic(13, CordicMode.VECTORING)
        self.out_abs = Sfix()
        self.out_angle = Sfix()

        self._delay = self.core.iterations + 1

    def main(self, c):
        phase = Sfix(0.0, 0, -24)

        # give 1 extra bit, as there is stuff like CORDIC gain.. in soem cases 2 bits may be needed!
        # there will be CORDIC gain + abs value held by x can be > 1
        # remove 1 bit from fractional part, to keep 18 bit numbers
        x = resize(c.real, left_index(c.real) + 1, right_index(c.real) + 1, round_style=fixed_truncate)
        y = resize(c.imag, left_index(c.imag) + 1, right_index(c.imag) + 1, round_style=fixed_truncate)

        abs, _, angle = self.core.main(x, y, phase)

        # get rid of CORDIC gain and extra bits
        self.next.out_abs = resize(abs * (1.0 / 1.646760), c.imag, round_style=fixed_truncate)
        self.next.out_angle = resize(angle, c.imag, round_style=fixed_truncate)
        return self.out_abs, self.out_angle

    def model_main(self, cin):
        # note that angle in -1..1 range
        rabs = [np.abs(x) for x in cin]
        angle = [np.angle(x) / np.pi for x in cin]
        return rabs, angle


class Angle(HW):
    def __init__(self):
        self.core = ToPolar()
        self._delay = self.core._delay

    def main(self, c):
        _, angle = self.core.main(c)
        return angle

    def model_main(self, cin):
        # note that angle in -1..1 range
        return [np.angle(x) / np.pi for x in cin]


class Abs(HW):
    def __init__(self):
        self.core = ToPolar()
        self._delay = self.core._delay

    def main(self, c):
        abs, _ = self.core.main(c)
        return abs

    def model_main(self, cin):
        # note that angle in -1..1 range
        return [np.abs(x) for x in cin]
