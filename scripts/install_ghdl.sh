#!/bin/bash
set -evx


# download ghdl
wget https://github.com/tgingold/ghdl/releases/download/2016-09-14/ghdl-0.34dev-mcode-2016-09-14.tgz -O /tmp/ghdl.tar.gz
mkdir ghdl
tar -C ghdl -xvf /tmp/ghdl.tar.gz
export PATH=$PATH:$PWD/ghdl/bin/
