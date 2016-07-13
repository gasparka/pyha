#!/usr/bin/env python

import math

from gnuradio import audio
from gnuradio import gr, blocks, analog, filter


# Processing file captured on a USRP N210 with WBX using command:
# uhd_rx_cfile -a "addr=192.168.11.2" -g 25 -f 93.3M --samp-rate=500k \
#    -N 5000000 philly_93.3Mhz.32fc

class mytb(gr.top_block):
    def __init__(self, filename, fs):
        gr.top_block.__init__(self)

        # Read in data from file
        self.src = blocks.file_source(gr.sizeof_gr_complex, filename)

        fm_bw = 200e3  # 200 kHz bands
        resamp = fm_bw / fs  # output rate = input rate * resamp

        # This block builds a resampler with rate resamp that
        # passes the entire useful channel after resampling
        self.resampler = filter.pfb.arb_resampler_ccf(resamp)

        # Set up the demodulator to translate an FM signal of a known
        # sample rate (fm_bw) and deviation into an amplitude series.
        deviation = 75e3
        gain = fm_bw / (2 * math.pi * deviation)
        self.demod = analog.quadrature_demod_cf(gain)

        # Resample again to audio rates
        # Filter here to supress out of band noise
        audio_rate = 44.1e3
        audio_pass = 1e3
        audio_tw = 1e3
        audio_atten = 60
        audio_resamp = audio_rate / fm_bw
        audio_taps = filter.firdes.low_pass_2(1,
                                              fm_bw,  # Sample rate at input
                                              audio_pass,  # passband
                                              audio_tw,  # transition width
                                              audio_atten)  # Stopband attenuation
        self.lpf = filter.pfb.arb_resampler_fff(audio_resamp, audio_taps)

        # Using pulseaudio device in Linux. Will have to play around
        # with this on your system (plughw:0,0 is another good choise
        # in Linux).
        device = "pulse"
        self.snk = audio.sink(int(audio_rate), device)

        # Connect up the blocks
        self.connect(self.src, self.resampler, self.demod)
        self.connect(self.demod, self.lpf, self.snk)


def main():
    filename = "philly_93.3Mhz.32fc"
    rate = 500e3

    # Create top block and run it till completion.
    tb = mytb(filename, rate)
    tb.run()


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        pass
