.. highlight:: shell

============
Installation
============

.. note:: Pyha works only on Python 3.6 and currently is developed/tested on Ubuntu 12/14/16.

To install pyha:

.. code-block:: console

    git clone https://github.com/petspats/pyha
    cd pyha
    pip install -r requirements.txt


RTL-level simulations
---------------------

GHDL and Cocotb are required to run RTL simulations.
Currently both of them must reside inside the cloned Pyha folder.
CocoTB must be installed from fork (it includes some Python3.6 overwrites).

Install GHDL:

.. code-block:: console

    # !! this writes to your .bashrc
    sudo sh scripts/install_ghdl.sh

Install Cocotb:

.. code-block:: console

    sudo apt-get install git make gcc g++ swig
    sh scripts/install_cocotb.sh


GATE-level simulations
----------------------

Install `Intel Quartus`_ ,make sure that you enable Cyclone IV support.

After installing, you can build GHDL support libraries:

.. code-block:: console

    python scripts/compile_quartus_lib.py

.. _Intel Quartus: http://dl.altera.com/?edition=lite

