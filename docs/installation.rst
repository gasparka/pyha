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


Support for RTL-level simulations
---------------------------------

For running RTL simulations, you must install GHDL and CocoTB. Currently it is required that
both of them reside inside the cloned Pyha folder. CocoTB must be installed from private fork.

Install GHDL:

.. code-block:: console

    # !! this writes to your .bashrc
    sudo sh scripts/install_ghdl.sh

Install Cocotb:

.. code-block:: console

    sudo apt-get install git make gcc g++ swig
    sh scripts/install_cocotb.sh


Support for GATE-level simulations
----------------------------------

For this step you need to install `Intel Quartus`_ toolset and generate support libraries
for the GHDL. Make sure that you enable Cyclone IV support when installing Quartus.

After you have Quartus installed you can build GHDL support libraries:

.. code-block:: console

    python scripts/compile_quartus_lib.py

.. _Intel Quartus: http://dl.altera.com/?edition=lite

