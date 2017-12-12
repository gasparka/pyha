====
pyha
====


.. warning:: Ongoing work on the first release. Many things will change, not advised to use this tool at the moment.

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


..
    .. image:: https://landscape.io/github/petspats/pyha/develop/landscape.svg?style=flat
   :target: https://landscape.io/github/petspats/pyha/develop
   :alt: Code Health

.. image:: https://codeclimate.com/github/petspats/pyha/badges/gpa.svg
   :target: https://codeclimate.com/github/petspats/pyha
   :alt: Code Climate

* Free software: Apache Software License 2.0
* Documentation: https://pyha.readthedocs.io.

=======
Install
=======

.. code-block:: bash

    pip install pyha

.. warning::

    Pyha requires Python >= 3.6, which is default for Ubuntu 17.10. Another good option is to use `Anaconda`_.


For RTL simulation (optional)
-----------------------------

`Cocotb`_ dependencies:

.. code-block:: bash

    sudo apt-get install make gcc g++ swig

You also need to install `GHDL`_ and **add it to the path**, for Ubuntu use:

.. code-block:: bash

    sh /scripts/install_ghdl.sh


For GATE simulation (optional)
------------------------------

In addition to the RTL requirements, you need to install the `Intel Quartus`_ suite and add
``/intelFPGA_lite/XXX/quartus/bin`` to path.

Lastly, run

.. code-block:: bash

    python /scripts/compile_quartus_lib.py

This compiles Altera libraries into ``GHDL_PATH/lib/ghdl/altera``.



.. _Intel Quartus: http://dl.altera.com/?edition=lite
.. _GHDL: https://github.com/tgingold/ghdl
.. _Cocotb: https://github.com/potentialventures/cocotb
.. _Anaconda: https://www.anaconda.com/download/