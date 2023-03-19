#!/usr/bin/env bash

./scripts/build_libfreenect2.sh

echo "compiling the project"
cmake -B build
cmake --build build
