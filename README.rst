====
pyha
====

.. image:: https://img.shields.io/pypi/v/pyha.svg
    :target: https://pypi.python.org/pypi/pyha

.. image:: https://img.shields.io/travis/gasparka/pyha.svg
    :target: https://travis-ci.org/gasparka/pyha

.. image:: https://pyup.io/repos/github/gasparka/pyha/shield.svg
    :target: https://pyup.io/repos/github/gasparka/pyha/
    :alt: Updates

.. image:: https://coveralls.io/repos/github/gasparka/pyha/badge.svg?branch=develop
    :target: https://coveralls.io/github/gasparka/pyha?branch=develop

* Free software: Apache Software License 2.0

Install
-------

From pip:

``pip install --user pyha``

RTL/NETLIST level simulations require `Docker <https://docs.docker.com/install/>`_ :

``curl -fsSL get.docker.com -o get-docker.sh | sh``

Follow the instructions to add yourself to the 'docker' group.


Features
--------

* Describe hardware in Python and convert to VHDL
* Cycle-accurate and fast simulator
* Debuggable in Python – very useful as Python and VHDL sources are highly correlated
* Simple testing framework by pairing pytest and cocotb
* Builtin fixed-point and complex types


Quick start
-----------

Take a look at the cores implemented in Pyha, each of them have a Notebook to ease the experimentation.
For example, start with the moving-average core:

`Python source <https://github.com/gasparka/pyha/blob/develop/pyha/cores/filter/moving_average/moving_average.py>`_

`Notebook <https://github.com/gasparka/pyha/blob/develop/pyha/cores/filter/moving_average/moving_average.ipynb>`_

`VHDL conversion <https://github.com/gasparka/pyha/blob/develop/pyha/cores/filter/moving_average/example_conversion/src/MovingAverage_0.vhd>`_

And then see how the 'dc-removal' is built by reusing the 'moving-average' component:

`Python source <https://github.com/gasparka/pyha/blob/develop/pyha/cores/filter/dc_removal/dc_removal.py>`_

`Notebook <https://github.com/gasparka/pyha/blob/develop/pyha/cores/filter/dc_removal/dc_removal.ipynb>`_

`VHDL conversion <https://github.com/gasparka/pyha/blob/develop/pyha/cores/filter/dc_removal/example_conversion/src/DCRemoval_0.vhd>`_

Documentation
-------------

Under construction!