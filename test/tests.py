import matplotlib.pyplot as plt
import numpy as np
from scipy import signal

c = np.ones(32) / 32
c2 = np.convolve(c, c, mode='full')
c3 = np.convolve(c2, c, mode='full')
c4 = np.convolve(c3, c, mode='full')
c5 = np.convolve(c4, c, mode='full')
c6 = np.convolve(c5, c, mode='full')
c7 = np.convolve(c6, c, mode='full')
c8 = np.convolve(c7, c, mode='full')

w1, h1 = signal.freqz(c, worN=1024)
w2, h2 = signal.freqz(c2, worN=1024)
w3, h3 = signal.freqz(c3, worN=1024)
w4, h4 = signal.freqz(c4, worN=1024)
w5, h5 = signal.freqz(c5, worN=1024)
w6, h6 = signal.freqz(c6, worN=1024)
w7, h7 = signal.freqz(c7, worN=1024)
w8, h8 = signal.freqz(c8, worN=1024)

plt.plot(w1/np.pi, 20*np.log10(h1))
plt.plot(w2/np.pi, 20*np.log10(h2))
plt.plot(w3/np.pi, 20*np.log10(h3))
plt.plot(w4/np.pi, 20*np.log10(h4))
plt.plot(w5/np.pi, 20*np.log10(h5))
plt.plot(w6/np.pi, 20*np.log10(h6))
plt.plot(w7/np.pi, 20*np.log10(h7))
plt.plot(w8/np.pi, 20*np.log10(h8))
plt.show()