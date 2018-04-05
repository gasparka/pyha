============
Installation
============

Pyha requires Python >= 3.6 (default for Ubuntu 17.10 or `Anaconda`_)

.. code-block:: bash

    pip install pyha

Or from sources:

.. code-block:: bash

    git clone --recursive https://github.com/gasparka/pyha
    cd pyha
    pip install -e .
    pytest              # optionally run the test suite



RTL simulation (optional)
-------------------------

`Cocotb`_ (included with Pyha) dependencies:

.. code-block:: bash

    sudo apt-get install make gcc g++ swig

Install `GHDL`_ and **add it to the path**. On Ubuntu run:

.. code-block:: bash

    sh /scripts/install_ghdl.sh


GATE simulation (optional)
--------------------------

In addition to the RTL simulation requirements, install the `Intel Quartus`_ with support for Cyclone IV and **add** ``INSTALL_DIR/quartus/bin`` to path.

Compile Quartus libraries into ``GHDL_PATH/lib/ghdl/altera`` by running:

.. code-block:: bash

    python /scripts/compile_quartus_lib.py
    # expected output: Compiling Altera Quartus libraries [FAILED]


.. arch: /usr/lib/ghdl/vendors/compile-intel.sh -a --src /home/gaspar/intelFPGA_lite/17.1/quartus/eda/sim_lib
.. sudo cp -r altera /usr/lib/ghdl

.. _Intel Quartus: http://dl.altera.com/?edition=lite
.. _GHDL: https://github.com/tgingold/ghdl
.. _Cocotb: https://github.com/potentialventures/cocotb
.. _Anaconda: https://www.anaconda.com/download/