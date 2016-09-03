#!/usr/bin/env python2
# -*- coding: utf-8 -*-
##################################################
# GNU Radio Python Flow Graph
# Title: Top Block
# Generated: Wed Jul 13 12:56:40 2016
##################################################

if __name__ == '__main__':
    import ctypes
    import sys

    if sys.platform.startswith('linux'):
        try:
            x11 = ctypes.cdll.LoadLibrary('libX11.so')
            x11.XInitThreads()
        except:
            print
            "Warning: failed to XInitThreads()"

import sip
import sys

import numpy as np
from PyQt4 import Qt
from gnuradio import analog
from gnuradio import blocks
from gnuradio import gr
from gnuradio import qtgui
from gnuradio.filter import firdes
from gnuradio.qtgui import Range, RangeWidget


class top_block(gr.top_block, Qt.QWidget):
    def __init__(self):
        gr.top_block.__init__(self, "Top Block")
        Qt.QWidget.__init__(self)
        self.setWindowTitle("Top Block")
        try:
            self.setWindowIcon(Qt.QIcon.fromTheme('gnuradio-grc'))
        except:
            pass
        self.top_scroll_layout = Qt.QVBoxLayout()
        self.setLayout(self.top_scroll_layout)
        self.top_scroll = Qt.QScrollArea()
        self.top_scroll.setFrameStyle(Qt.QFrame.NoFrame)
        self.top_scroll_layout.addWidget(self.top_scroll)
        self.top_scroll.setWidgetResizable(True)
        self.top_widget = Qt.QWidget()
        self.top_scroll.setWidget(self.top_widget)
        self.top_layout = Qt.QVBoxLayout(self.top_widget)
        self.top_grid_layout = Qt.QGridLayout()
        self.top_layout.addLayout(self.top_grid_layout)

        self.settings = Qt.QSettings("GNU Radio", "top_block")
        self.restoreGeometry(self.settings.value("geometry").toByteArray())

        ##################################################
        # Variables
        ##################################################
        self.samp_rate = samp_rate = 1e3
        self.deviation = deviation = samp_rate / 3
        self.data_freq = data_freq = 20

        ##################################################
        # Blocks
        ##################################################
        self._deviation_range = Range(0, samp_rate, 1, samp_rate / 3, 200)
        self._deviation_win = RangeWidget(self._deviation_range, self.set_deviation, "deviation", "counter_slider",
                                          float)
        self.top_layout.addWidget(self._deviation_win)
        self._data_freq_range = Range(0, samp_rate / 2, 1, 20, 200)
        self._data_freq_win = RangeWidget(self._data_freq_range, self.set_data_freq, "data_freq", "counter_slider",
                                          float)
        self.top_layout.addWidget(self._data_freq_win)
        self.qtgui_time_sink_x_0 = qtgui.time_sink_f(
            1024,  # size
            samp_rate,  # samp_rate
            "",  # name
            2  # number of inputs
        )
        self.qtgui_time_sink_x_0.set_update_time(0.10)
        self.qtgui_time_sink_x_0.set_y_axis(-1, 1)

        self.qtgui_time_sink_x_0.set_y_label("Amplitude", "")

        self.qtgui_time_sink_x_0.enable_tags(-1, True)
        self.qtgui_time_sink_x_0.set_trigger_mode(qtgui.TRIG_MODE_FREE, qtgui.TRIG_SLOPE_POS, 0.0, 0, 0, "")
        self.qtgui_time_sink_x_0.enable_autoscale(False)
        self.qtgui_time_sink_x_0.enable_grid(False)
        self.qtgui_time_sink_x_0.enable_control_panel(False)

        if not True:
            self.qtgui_time_sink_x_0.disable_legend()

        labels = ["", "", "", "", "",
                  "", "", "", "", ""]
        widths = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        colors = ["blue", "red", "green", "black", "cyan",
                  "magenta", "yellow", "dark red", "dark green", "blue"]
        styles = [1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1]
        markers = [-1, -1, -1, -1, -1,
                   -1, -1, -1, -1, -1]
        alphas = [1.0, 1.0, 1.0, 1.0, 1.0,
                  1.0, 1.0, 1.0, 1.0, 1.0]

        for i in xrange(2):
            if len(labels[i]) == 0:
                self.qtgui_time_sink_x_0.set_line_label(i, "Data {0}".format(i))
            else:
                self.qtgui_time_sink_x_0.set_line_label(i, labels[i])
            self.qtgui_time_sink_x_0.set_line_width(i, widths[i])
            self.qtgui_time_sink_x_0.set_line_color(i, colors[i])
            self.qtgui_time_sink_x_0.set_line_style(i, styles[i])
            self.qtgui_time_sink_x_0.set_line_marker(i, markers[i])
            self.qtgui_time_sink_x_0.set_line_alpha(i, alphas[i])

        self._qtgui_time_sink_x_0_win = sip.wrapinstance(self.qtgui_time_sink_x_0.pyqwidget(), Qt.QWidget)
        self.top_layout.addWidget(self._qtgui_time_sink_x_0_win)
        self.qtgui_sink_x_0 = qtgui.sink_c(
            1024,  # fftsize
            firdes.WIN_BLACKMAN_hARRIS,  # wintype
            0,  # fc
            samp_rate,  # bw
            "",  # name
            True,  # plotfreq
            True,  # plotwaterfall
            True,  # plottime
            True,  # plotconst
        )
        self.qtgui_sink_x_0.set_update_time(1.0 / 10)
        self._qtgui_sink_x_0_win = sip.wrapinstance(self.qtgui_sink_x_0.pyqwidget(), Qt.QWidget)
        self.top_layout.addWidget(self._qtgui_sink_x_0_win)

        self.qtgui_sink_x_0.enable_rf_freq(False)

        self.blocks_throttle_0 = blocks.throttle(gr.sizeof_gr_complex * 1, samp_rate, True)
        self.blocks_file_sink_0_0 = blocks.file_sink(gr.sizeof_float * 1,
                                                     "/home/gaspar/git/hwpy/misc/gr_fm_demod/data.32f", False)
        self.blocks_file_sink_0_0.set_unbuffered(False)
        self.blocks_file_sink_0 = blocks.file_sink(gr.sizeof_gr_complex * 1,
                                                   "/home/gaspar/git/hwpy/misc/gr_fm_demod/mod_samples.32fc", False)
        self.blocks_file_sink_0.set_unbuffered(False)
        self.analog_sig_source_x_0 = analog.sig_source_f(samp_rate, analog.GR_COS_WAVE, data_freq, 1, 0)
        self.analog_quadrature_demod_cf_0 = analog.quadrature_demod_cf(samp_rate / (2 * np.pi * deviation))
        self.analog_frequency_modulator_fc_0 = analog.frequency_modulator_fc(2 * np.pi * deviation / samp_rate)

        ##################################################
        # Connections
        ##################################################
        self.connect((self.analog_frequency_modulator_fc_0, 0), (self.analog_quadrature_demod_cf_0, 0))
        self.connect((self.analog_frequency_modulator_fc_0, 0), (self.blocks_throttle_0, 0))
        self.connect((self.analog_quadrature_demod_cf_0, 0), (self.qtgui_time_sink_x_0, 0))
        self.connect((self.analog_sig_source_x_0, 0), (self.analog_frequency_modulator_fc_0, 0))
        self.connect((self.analog_sig_source_x_0, 0), (self.blocks_file_sink_0_0, 0))
        self.connect((self.analog_sig_source_x_0, 0), (self.qtgui_time_sink_x_0, 1))
        self.connect((self.blocks_throttle_0, 0), (self.blocks_file_sink_0, 0))
        self.connect((self.blocks_throttle_0, 0), (self.qtgui_sink_x_0, 0))

    def closeEvent(self, event):
        self.settings = Qt.QSettings("GNU Radio", "top_block")
        self.settings.setValue("geometry", self.saveGeometry())
        event.accept()

    def get_samp_rate(self):
        return self.samp_rate

    def set_samp_rate(self, samp_rate):
        self.samp_rate = samp_rate
        self.set_deviation(self.samp_rate / 3)
        self.analog_frequency_modulator_fc_0.set_sensitivity(2 * np.pi * self.deviation / self.samp_rate)
        self.analog_quadrature_demod_cf_0.set_gain(self.samp_rate / (2 * np.pi * self.deviation))
        self.analog_sig_source_x_0.set_sampling_freq(self.samp_rate)
        self.blocks_throttle_0.set_sample_rate(self.samp_rate)
        self.qtgui_sink_x_0.set_frequency_range(0, self.samp_rate)
        self.qtgui_time_sink_x_0.set_samp_rate(self.samp_rate)

    def get_deviation(self):
        return self.deviation

    def set_deviation(self, deviation):
        self.deviation = deviation
        self.analog_frequency_modulator_fc_0.set_sensitivity(2 * np.pi * self.deviation / self.samp_rate)
        self.analog_quadrature_demod_cf_0.set_gain(self.samp_rate / (2 * np.pi * self.deviation))

    def get_data_freq(self):
        return self.data_freq

    def set_data_freq(self, data_freq):
        self.data_freq = data_freq
        self.analog_sig_source_x_0.set_frequency(self.data_freq)


def main(top_block_cls=top_block, options=None):
    from distutils.version import StrictVersion
    if StrictVersion(Qt.qVersion()) >= StrictVersion("4.5.0"):
        style = gr.prefs().get_string('qtgui', 'style', 'raster')
        Qt.QApplication.setGraphicsSystem(style)
    qapp = Qt.QApplication(sys.argv)

    tb = top_block_cls()
    tb.start()
    tb.show()

    def quitting():
        tb.stop()
        tb.wait()

    qapp.connect(qapp, Qt.SIGNAL("aboutToQuit()"), quitting)
    qapp.exec_()


if __name__ == '__main__':
    main()
