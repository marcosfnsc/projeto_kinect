#!/usr/bin/env bash

git config --global advice.detachedHead false # disable checkout message
[ ! -d "third_party/OpenNI2"      ] && ./scripts/build_openni2.sh
[ ! -d "third_party/libfreenect2" ] && ./scripts/build_libfreenect2.sh
[ ! -d "third_party/opencv"        ] && ./scripts/build_opencv.sh

echo "compiling the project"
cmake -B build
cmake --build build
