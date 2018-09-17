FROM ghdl/ghdl:ubuntu18-mcode

RUN apt-get update && apt-get install -y --no-install-recommends git make gcc g++ swig python3-dev python3.6 libpython3.6 python3-tqdm python3-numpy ca-certificates libglib2.0.0

# clean up
RUN echo "${BUILD_PACKAGES}" | xargs apt-get purge --yes \
 && apt-get autoremove --purge --yes \
&& rm -rf /var/lib/apt/lists/*


RUN ln -s /usr/bin/python3 /usr/bin/python



ADD quartus /quartus
ENV PATH="/quartus/bin/:${PATH}"

RUN /usr/local/lib/ghdl/vendors/compile-altera.sh -a --src /quartus/eda/sim_lib --out /quartus_sim_lib

# Install COCOTB
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