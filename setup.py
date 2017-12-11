#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys

from pip.req import parse_requirements
from setuptools import setup, find_packages

if sys.version_info < (3, 6):
    sys.exit('Sorry, Python < 3.6 is not supported')


with open('README.rst') as readme_file:
    readme = readme_file.read()


# parse_requirements() returns generator of pip.req.InstallRequirement objects
install_reqs = parse_requirements('requirements.txt', session=False)
requirements = [str(ir.req) for ir in install_reqs]

def package_files(directory):
    paths = []
    for (path, directories, filenames) in os.walk(directory):
        if 'build' in path.split('/'):
            continue

        if '.git' in path.split('/'):
            continue
        for filename in filenames:
            paths.append(os.path.join('..', path, filename))
    return paths


extra_files = package_files('cocotb/')
extra_files.extend(['../common/vhdl_includes/pyha_util.vhdl'])
extra_files.extend(['/home/gaspar/git/pyha/pyha/simulation/sim_include/*'])
extra_files.extend(package_files('fphdl/'))

setup(
    name='pyha',
    version='0.0.5-2',
    description="Pyha",
    long_description=readme,
    author="Gaspar Karm",
    author_email='gkarm@live.com',
    url='https://github.com/petspats/pyha',

    packages=find_packages(),
    package_data={'pyha': extra_files},

    include_package_data=True,
    install_requires=requirements,
    license="Apache Software License 2.0",
    zip_safe=False,
    keywords='pyha',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: Apache Software License',
        'Natural Language :: English',
        'Programming Language :: Python :: 3.6',
    ],
)
