#!/bin/bash
set -vx

# install gnat runtime, adding repo is needed for Ubuntu < 14
echo deb http://cz.archive.ubuntu.com/ubuntu precise main universe precise main universe > /etc/apt/sources.list.d/pyha_tmp.list
apt-get update
apt-get install -y gnat-4.6-base libgnat-4.6
rm -f /etc/apt/sources.list.d/pyha_tmp.list

# download ghdl
wget https://github.com/tgingold/ghdl/releases/download/2016-09-14/ghdl-0.34dev-mcode-2016-09-14.tgz -O /tmp/ghdl.tar.gz
mkdir ghdl
tar -C ghdl -xvf /tmp/ghdl.tar.gz

#export PATH=$PATH:$PWD/ghdl/bin/
#echo 'export PATH=$PATH:$PWD/ghdl/bin/' >> ~/.bashrc
#source $HOME/.bashrc
