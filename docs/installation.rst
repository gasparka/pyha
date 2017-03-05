============
Installation
============

.. note:: Pyha works only on Python 3.6 and currently is developed/tested on Ubuntu 14/16.

To install pyha:

.. code-block:: bash

    pip install pyha


RTL-level simulations
---------------------

GHDL and Cocotb are required to run RTL simulations.

Install GHDL:

.. code-block:: bash

    wget https://github.com/tgingold/ghdl/releases/download/2016-09-14/ghdl-0.34dev-mcode-2016-09-14.tgz -O /tmp/ghdl.tar.gz
    mkdir ghdl
    tar -C ghdl -xvf /tmp/ghdl.tar.gz

    # add GHDL to path
    echo export PATH=$PWD/ghdl/bin/:$PATH >> ~/.bashrc
    source ~/.bashrc

Cocotb must be installed from fork (it includes some Python3.6 overwrites).
Install Cocotb:

.. code-block:: bash

    sudo apt-get install git make gcc g++ swig
    git clone https://github.com/petspats/cocotb

    # set COCOTB path
    echo export COCOTB=$PWD/cocotb >> ~/.bashrc
    source ~/.bashrc


GATE-level simulations
----------------------

Install `Intel Quartus`_ ,make sure that you enable Cyclone IV support.

After installing, you can build GHDL support libraries:

.. code-block:: bash

    python scripts/compile_quartus_lib.py

It is normal that is 'fails':

.. code-block:: bash

    --------------------------------------------------------------------------------
    Compiling Altera Quartus libraries [FAILED]

.. _Intel Quartus: http://dl.altera.com/?edition=lite


At this point you can **optionally** run tests, be warned that it takes up to 30 minutes.

.. code-block:: bash

    pytest tests/
