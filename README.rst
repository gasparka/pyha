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
* Install: ``pip install pyha``
* Additional requirements: Docker for RTL/GATE level simulations

Features:

* Describe hardware in Python and convert to synthesizable VHDL
* Cycle-accurate and fast simulator
* Debuggable in Python – very useful as Python and VHDL sources are highly correlated
* Simple testing framework by pairing pytest and cocotb

Currently documentation is in progress, meanwhile you can take a look at the collection of
cores written in Pyha. All the cores have a Notebook that should ease the experimentation.

For a quick demo, take a look at the moving-average core.

`Python source <https://github.com/gasparka/pyha/blob/develop/pyha/cores/filter/moving_average/moving_average.py>`_

`Notebook <https://github.com/gasparka/pyha/blob/develop/pyha/cores/filter/moving_average/moving_average.ipynb>`_

`VHDL conversion <https://github.com/gasparka/pyha/blob/develop/pyha/cores/filter/moving_average/example_conversion/src/MovingAverage_0.vhd>`_

And then stack some moving-averages to build the dc-removal core:

`Python source <https://github.com/gasparka/pyha/blob/develop/pyha/cores/filter/dc_removal/dc_removal.py>`_

`Notebook <https://github.com/gasparka/pyha/blob/develop/pyha/cores/filter/dc_removal/dc_removal.ipynb>`_

`VHDL conversion <https://github.com/gasparka/pyha/blob/develop/pyha/cores/filter/dc_removal/example_conversion/src/DCRemoval_0.vhd>`_

