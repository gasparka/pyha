#!/bin/bash
set -vx

# install gnat runtime, adding repo is needed if not ran on  Ubuntu 16 (Xenial)
sudo sh -c 'echo deb http://cz.archive.ubuntu.com/ubuntu xenial main universe > /etc/apt/sources.list.d/pyha_tmp.list'
sudo apt-get update
sudo apt-get install -y libgnat-4.9

# get rid of the xenial repo
sudo rm -f /etc/apt/sources.list.d/pyha_tmp.list
sudo apt-get update

# download ghdl
wget https://github.com/tgingold/ghdl/releases/download/v0.34/ghdl-v0.34-mcode-ubuntu.tgz -O /tmp/ghdl.tar.gz
mkdir ghdl
tar -C ghdl -xvf /tmp/ghdl.tar.gz

# add ghdl to your path
echo 'export PATH=$PATH:'"$PWD/ghdl/bin/" >> ~/.bashrc

