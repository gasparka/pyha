#!/bin/bash
set -vx

apt-get install git make gcc g++ swig python-dev
# TODO: create PR and use original cocotb repo!
git clone https://github.com/petspats/cocotb
