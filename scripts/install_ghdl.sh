# install gnat runtime, adding repo is needed for Ubuntu > 14
sudo bash -c 'echo deb http://ee.archive.ubuntu.com/ubuntu precise main universe > /etc/apt/sources.list.d/pyha_tmp.list'
sudo apt update
sudo apt-get install -y gnat-4.6-base, libgnat-4.6
sudo rm -f /etc/apt/sources.list.d/pyha_tmp.list

# download ghdl
wget https://github.com/tgingold/ghdl/releases/download/2016-09-14/ghdl-0.34dev-mcode-2016-09-14.tgz -O /tmp/ghdl.tar.gz
mkdir ghdl
tar -C ghdl -xvf /tmp/ghdl.tar.gz
export PATH=$PATH:$PWD/ghdl/bin/
