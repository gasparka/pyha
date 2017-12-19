====
pyha
====

.. warning::
    Ongoing work on the first release. Many things will change, not advised to use this tool at the moment.

.. image:: https://img.shields.io/pypi/v/pyha.svg
    :target: https://pypi.python.org/pypi/pyha

.. image:: https://img.shields.io/travis/gasparka/pyha.svg
    :target: https://travis-ci.org/gasparka/pyha

.. image:: https://readthedocs.org/projects/pyha/badge/?version=develop
    :target: http://pyha.readthedocs.io/en/develop/?badge=develop
    :alt: Documentation Status

.. image:: https://pyup.io/repos/github/gasparka/pyha/shield.svg
    :target: https://pyup.io/repos/github/gasparka/pyha/
    :alt: Updates

.. image:: https://coveralls.io/repos/github/gasparka/pyha/badge.svg?branch=develop
    :target: https://coveralls.io/github/gasparka/pyha?branch=develop


* Free software: Apache Software License 2.0
* Documentation: https://pyha.readthedocs.io.

=======
Install
=======

Pyha requires Python >= 3.6 (default for Ubuntu 17.10 or `Anaconda`_)

.. code-block:: bash

    pip install pyha


For RTL simulation (optional)
-----------------------------

`Cocotb`_ (included with Pyha install) dependencies:

.. code-block:: bash

    sudo apt-get install make gcc g++ swig

Install `GHDL`_ and **add it to the path**, for Ubuntu use:

.. code-block:: bash

    sh /scripts/install_ghdl.sh


For GATE simulation (optional)
------------------------------

In addition to the RTL requirements, you need to install the `Intel Quartus`_  and **add ``.../quartus/bin`` to path**.

Compile Quartus libraries into ``GHDL_PATH/lib/ghdl/altera`` by running:

.. code-block:: bash

    python /scripts/compile_quartus_lib.py

.. _Intel Quartus: http://dl.altera.com/?edition=lite
.. _GHDL: https://github.com/tgingold/ghdl
.. _Cocotb: https://github.com/potentialventures/cocotb
.. _Anaconda: https://www.anaconda.com/download/