#!/bin/bash

git clone -b $1 https://github.com/sympy/sympy
pushd sympy
./setup.py test
popd
