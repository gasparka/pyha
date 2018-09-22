import matplotlib.pyplot as plt
import numpy as np

from pyha.common.util import is_float, is_complex
from pyha.cores.util import SQNR
from pyha.simulation.tracer import Tracer

figsize = (9.75, 5)


def plot_time_domain(simulations, name='Time domain'):
    simulations["MODEL"] = np.array(simulations["MODEL"])
    simulations["HARDWARE"] = np.array(simulations["HARDWARE"])
    if is_float(simulations["MODEL"][0]):
        fig, ax = plt.subplots(2, sharex="all", figsize=figsize, gridspec_kw={'height_ratios': [4, 2]})

        if name:
            fig.suptitle(name, fontsize=14, fontweight='bold')
        ax[0].plot(simulations["MODEL"], label='MODEL')
        ax[0].plot(simulations["HARDWARE"], label='HARDWARE')
        ax[0].set(title=f'SQNR={SQNR(simulations["MODEL"], simulations["HARDWARE"]):.2f} dB')
        ax[0].set_xlabel('Sample')
        ax[0].set_ylabel('Magnitude')
        ax[0].grid(True)
        ax[0].legend(loc='upper right')

        ax[1].plot(simulations["MODEL"] - simulations["HARDWARE"], label='Error')
        ax[1].grid(True)
        ax[1].legend(loc='upper right')
    elif is_complex(simulations["MODEL"][0]):
        fig, ax = plt.subplots(2, 2, sharex="all", sharey='row', figsize=figsize,
                               gridspec_kw={'height_ratios': [4, 2]})

        if name:
            fig.suptitle(name, fontsize=14, fontweight='bold')
        ax[0][0].plot(simulations["MODEL"].real, label='MODEL')
        ax[0][0].plot(simulations["HARDWARE"].real, label='HARDWARE')
        ax[0][0].set(title=f'REAL SQNR={SQNR(simulations["MODEL"].real, simulations["HARDWARE"].real):.2f} dB')
        ax[0][0].set_xlabel('Sample')
        ax[0][0].set_ylabel('Magnitude')
        ax[0][0].grid(True)
        ax[0][0].legend(loc='upper right')

        ax[1][0].plot(simulations["MODEL"].real - simulations["HARDWARE"].real, label='Error')
        ax[1][0].grid(True)
        ax[1][0].legend(loc='upper right')

        ax[0][1].plot(simulations["MODEL"].imag, label='MODEL')
        ax[0][1].plot(simulations["HARDWARE"].imag, label='HARDWARE')
        ax[0][1].set(title=f'IMAG SQNR={SQNR(simulations["MODEL"].imag, simulations["HARDWARE"].imag):.2f} dB')
        ax[0][1].set_xlabel('Sample')
        ax[0][1].set_ylabel('Magnitude')
        ax[0][1].grid(True)
        ax[0][1].legend(loc='upper right')

        ax[1][1].plot(simulations["MODEL"].imag - simulations["HARDWARE"].imag, label='Error')
        ax[1][1].grid(True)
        ax[1][1].legend(loc='upper right')

    plt.tight_layout(rect=[0, 0, 1, 0.95])
    plt.show()


def plot_frequency_domain(simulations, name='Frequency domain', window=plt.mlab.window_hanning, xlim=None, ylim=None):
    simulations["MODEL"] = np.array(simulations["MODEL"])
    simulations["HARDWARE"] = np.array(simulations["HARDWARE"])
    gain = 1.0
    fig, ax = plt.subplots(2, sharex="all", figsize=figsize, gridspec_kw={'height_ratios': [4, 2]})

    if name:
        fig.suptitle(name, fontsize=14, fontweight='bold')

    spec_model, freq, _ = ax[0].magnitude_spectrum(simulations["MODEL"] * gain,
                                                   window=window,
                                                   scale='dB', label='MODEL')
    spec_pyha, _, _ = ax[0].magnitude_spectrum(simulations["HARDWARE"] * gain,
                                               window=window,
                                               scale='dB',
                                               label='HARDWARE')

    ax[0].set(title=f'SQNR={SQNR(simulations["MODEL"], simulations["HARDWARE"]):.2f} dB')
    ax[0].grid(True)
    ax[0].legend(loc='upper right')

    ax[1].plot(freq, 20 * np.log10(spec_model) - 20 * np.log10(spec_pyha), label='Error')
    ax[1].grid(True)
    ax[1].legend(loc='upper right')

    plt.tight_layout(rect=[0, 0, 1, 0.95])
    if xlim:
        plt.xlim(xlim)

    if ylim:
        ax[0].set_ylim(ylim)
        ax[1].set_ylim(ylim)

    plt.show()


def plot_frequency_response(simulations, name='Frequency response', xlim=None, ylim=None):
    simulations["MODEL"] = np.array(simulations["MODEL"])
    simulations["HARDWARE"] = np.array(simulations["HARDWARE"])
    gain = len(simulations["MODEL"])
    window = plt.mlab.window_none
    if is_complex(simulations["MODEL"][0]):
        gain *= 0.707

    simulations["MODEL"] *= gain
    simulations["HARDWARE"] *= gain
    plot_frequency_domain(simulations, name, window, xlim, ylim)


def plot_imshow(simulations, rows, transpose=False, name=None):
    simulations["MODEL"] = np.array(simulations["MODEL"])
    simulations["HARDWARE"] = np.array(simulations["HARDWARE"])
    fig, ax = plt.subplots(1, 2, figsize=figsize, sharex='all', sharey='all')


    if name:
        fig.suptitle(name, fontsize=14, fontweight='bold')

    from skimage.exposure import exposure

    inp = np.reshape(simulations["MODEL"], (-1, rows))
    if transpose:
        inp = inp.T

    p2, p98 = np.percentile(inp, (2, 98))
    inp = exposure.rescale_intensity(inp, in_range=(p2, p98))

    ax[0].imshow(inp, interpolation='nearest', aspect='auto', origin='lower')
    ax[0].set(title=f'MODEL')
    ax[0].set_xlabel('Time')
    ax[0].set_ylabel('Magnitude')

    inp = np.reshape(simulations["MODEL"], (-1, rows))
    if transpose:
        inp = inp.T

    p2, p98 = np.percentile(inp, (2, 98))
    inp = exposure.rescale_intensity(inp, in_range=(p2, p98))

    ax[1].imshow(inp, interpolation='nearest', aspect='auto', origin='lower')
    ax[1].set(title=f'PYHA, SQNR={SQNR(simulations["MODEL"], simulations["HARDWARE"]):.2f} dB')
    ax[1].set_xlabel('Time')
    ax[1].set_ylabel('Magnitude')

    plt.tight_layout(rect=[0, 0, 1, 0.95])
    plt.show()


def plot_trace():
    traces = Tracer.get_sorted_traces()
    for i, (k, v) in enumerate(traces.items()):
        plot_time_domain(v, name=k)


def plot_trace_input_output(plotter=plot_time_domain):
    its = list(Tracer.get_sorted_traces().items())
    plotter(its[0][1], name=its[0][0])
    plotter(its[-1][1], name=its[-1][0])
    # return traces[0], traces[-1]
