###############################################################################
# Copyright (c) 2013 Potential Ventures Ltd
# Copyright (c) 2013 SolarFlare Communications Inc
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of Potential Ventures Ltd,
#       SolarFlare Communications Inc nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL POTENTIAL VENTURES LTD BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
###############################################################################
#can set PyDev remote breakpoints
# PYTHONPATH :=/home/gkarm/eclipse/plugins/org.python.pydev_4.5.3.201601211913/pysrc:${PYTHONPATH}
#set 32 bit python :)
# export PATH :=/opt/pym32/bin:$(PATH)
# export PYTHONHOME := /opt/pym32/bin
# altera modelsim wont simulate vhdl toplevel
TOPLEVEL_LANG = verilog

SIM = modelsim
#32 bit modelsim
ARCH = i686
export GUI=0
export COCOTB_LOG_LEVEL=INFO

ifneq ($(TOPLEVEL_LANG),verilog)

all:
	@echo "Skipping example due to TOPLEVEL_LANG=$(TOPLEVEL_LANG) not being verilog"
clean::

else

# PWD=$(shell pwd)
# $(info PWD is $(PWD))
COCOTB= ${HOME}/git/cocotb/
# $(info COCOTB is $(COCOTB))


WPWD=$(shell pwd)
PYTHONPATH := $(WPWD)/../model:$(PYTHONPATH)
$(info PYTHONPATH is $(PYTHONPATH))


$(info WPWD=$(WPWD))
$(info SIM_BUILD=$(SIM_BUILD))


VHDL_SOURCES += $(WPWD)/../average.vhd
VHDL_SOURCES += $(WPWD)/../top.vhd


# VCOM_ARGS = -mixedsvvh -2008
VERILOG_SOURCES = $(WPWD)/../top.sv

VCOM_ARGS += -2008

# have to have this generic just for Verilog..quite bullshit solution
# VSIM_ARGS = -gGENERIC_DATA_WIDTH=$(GENERIC_DATA_WIDTH)
TOPLEVEL := top_sv
MODULE   := cocotb_hdl_tests

include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim

endif
