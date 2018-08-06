FROM ghdl/ghdl:ubuntu18-mcode

# Install COCOTB
RUN apt-get install -y git make gcc g++ swig python3-dev python3.6 libpython3.6 python3-tqdm python3-numpy
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN git clone https://github.com/potentialventures/cocotb
WORKDIR cocotb/examples/endian_swapper/tests
RUN make SIM=GHDL TOPLEVEL_LANG=vhdl

# add and build Quartus 17.1 simulation libs
ADD quartus_sim_lib /quartus_sim_lib
RUN /usr/local/lib/ghdl/vendors/compile-altera.sh -a --src /quartus_sim_lib/ --out /quartus_sim_lib/

WORKDIR /pyha_simulation
ENV COCOTB /cocotb
ENV SIM_BUILD /pyha_simulation
ENV TOPLEVEL_LANG vhdl
ENV SIM ghdl
ENV PYTHONPATH /pyha_simulaton
ENV TOPLEVEL top
ENV MODULE cocotb_simulation_top

