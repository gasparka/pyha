============
Installation
============

.. note:: Pyha works only on Python 3.6 and currently is developed/tested on Ubuntu 14/16.

To install pyha:

.. code-block:: bash

    git clone https://github.com/petspats/pyha
    cd pyha
    pip install .


RTL-level simulations
---------------------

GHDL and Cocotb are required to run RTL simulations.

Install GHDL:

.. code-block:: bash

    wget https://github.com/tgingold/ghdl/releases/download/2016-09-14/ghdl-0.34dev-mcode-2016-09-14.tgz -O /tmp/ghdl.tar.gz
    mkdir ghdl
    tar -C ghdl -xvf /tmp/ghdl.tar.gz

    # add GHDL to path
    echo 'export PATH=$PWD/ghdl/bin/:$PATH' >> ~/.bashrc
    source ~/.bashrc

Cocotb must be installed from fork (it includes some Python3.6 overwrites), it must also reside inside Pyha repo.
Install Cocotb:

.. code-block:: bash

    # make sure you are inside Pyha directory
    sudo apt-get install git make gcc g++ swig
    git clone https://github.com/petspats/cocotb


GATE-level simulations
----------------------

Install `Intel Quartus`_ ,make sure that you enable Cyclone IV support.

After installing, you can build GHDL support libraries:

.. code-block:: bash

    python scripts/compile_quartus_lib.py

This script should end like this:

.. code-block:: bash

    --------------------------------------------------------------------------------
    Compiling Altera Quartus libraries [FAILED]

    Process finished with exit code 0

.. _Intel Quartus: http://dl.altera.com/?edition=lite

