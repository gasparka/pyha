#!/usr/bin/env bash


virtualenv -p /usr/bin/python3.6 venv
source ./venv/bin/activate
cd venv

git clone https://github.com/petspats/pyha
cd pyha
pip install .

