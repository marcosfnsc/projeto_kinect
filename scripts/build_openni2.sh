#!/usr/bin/env bash

[ ! -d "third_party/OpenNI2" ] && git clone --depth 1 --branch v2.2.0-debian https://github.com/structureio/OpenNI2.git third_party/OpenNI2

cd third_party/OpenNI2
echo "compiling OpenNI2"
make
