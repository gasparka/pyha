#!/usr/bin/env python
# -*- coding: utf-8 -*-
from pip.req import parse_requirements
from setuptools import setup, find_packages

# read the docs dont have 3.6 lol...
# import sys
# if sys.version_info < (3, 6):
#     sys.exit('Sorry, Python < 3.6 is not supported')


with open('README.rst') as readme_file:
    readme = readme_file.read()


# parse_requirements() returns generator of pip.req.InstallRequirement objects
install_reqs = parse_requirements('requirements.txt', session=False)
requirements = [str(ir.req) for ir in install_reqs]

test_requirements = [

]

setup(
    name='pyha',
    version='0.0.4',
    description="Pyha",
    long_description=readme,
    author="Gaspar Karm",
    author_email='gkarm@live.com',
    url='https://github.com/petspats/pyha',

    # package_dir={'':'pyha'},
    packages=find_packages(),
    package_data={'pyha': ['common/vhdl_includes/pyha_util.vhd',
                           'common/vhdl_includes/fixed_pkg/*',
                           'requirements.txt',
                           'cocotb/*']},
    # py_modules=["pyha"],

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
    test_suite='tests',
    tests_require=test_requirements,
)
