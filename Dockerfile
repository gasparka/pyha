FROM ghdl/ghdl:ubuntu18-mcode

# Install COCOTB
RUN apt-get install -y git make gcc g++ swig python3-dev python3.6 libpython3.6 python3-tqdm python3-numpy
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN git clone https://github.com/potentialventures/cocotb
WORKDIR cocotb/examples/endian_swapper/tests
RUN make SIM=GHDL TOPLEVEL_LANG=vhdl

WORKDIR /pyha_simulation
ENV COCOTB /cocotb
ENV SIM_BUILD /pyha_simulation
ENV TOPLEVEL_LANG vhdl
ENV SIM ghdl
ENV GHDL_ARGS --std=08
ENV PYTHONPATH /pyha_simulaton
ENV TOPLEVEL top
ENV MODULE cocotb_simulation_top

