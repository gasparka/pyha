.. highlight:: shell

============
Installation
============
This notes apply to Ubuntu 14.04 and 16.04.

Stable release
--------------

Pyha requires Python 3.6, you can install it by running:

.. code-block:: console

    $ sudo add-apt-repository ppa:jonathonf/python-3.6
    $ sudo apt-get update
    $ sudo apt-get install python3.6

To install pyha, run this command in your terminal:

.. code-block:: console

    pip install pyha

.. note::

    At this point you can use most of the Pyha features, you can continue to
    install more support for RTL and GATE simulations.

Dependencies for RTL-level simulations
--------------------------------------

Pyha supports running RTL simulations from generated VHDL sources. This requires installation of:

- GHDL
- CocoTB

Dependencies for GATE-level simulations
---------------------------------------

GATE-level simulations allow you to verify that your design is synthesysing correctly to the
Intel FPGAs. For this step you need to install Intel Quartus toolset and generate support libraries
for the GHDL.

The sources for pyha can be downloaded from the `Github repo`_.

.. _Github repo: https://github.com/petspats/pyha
.. _tarball: https://github.com/petspats/pyha/tarball/master
