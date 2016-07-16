import matplotlib.pyplot as plt
import numpy as np

from components.cordic.model.cordic import CORDIC

loom = CORDIC()

# reference signal
samp_rate = 1e3
time_end = 2
time = np.linspace(0, time_end, samp_rate * time_end, endpoint=False)  # NB! NOTICE ENDPOINT, TO MATCH GNURADIO

freq = 1
phase_angle = 2 * np.pi * freq * time * 1j
ref = np.exp(phase_angle)


def cordic_exp(phase, phase_lut):
    y = 0
    x = 1 / 1.646760
    for i, adj in enumerate(phase_lut):
        sign = -1 if phase < 0 else 1
        x, y, phase = x - sign * (y * (2 ** -i)), y + sign * (x * (2 ** -i)), phase - sign * adj

    return x + 1j * y


cordic_len = 18
phase_lut = [np.arctan(2 ** -i) for i in range(cordic_len)]

res = []
phase_angle = 2 * np.pi * freq * time

# plt.plot(phase_angle)
# plt.show()


phase_angle = [(x + np.pi / 2) % np.pi - np.pi / 2 for x in phase_angle]

# plt.plot(phase_angle)
# plt.show()
fs = 100
phase_incremet = 2 * np.pi * freq / fs

ph = 0
sign = 1
for x in range(fs * 10):
    ph += phase_incremet
    if ph > np.pi / 2:
        ph -= np.pi
        sign *= -1

    res.append(sign * cordic_exp(ph, phase_lut))

plt.plot([x.real for x in res])
plt.plot([x.imag for x in res])
plt.show()

pass
