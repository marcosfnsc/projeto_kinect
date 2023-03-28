#!/usr/bin/env bash

[ ! -d "third_party/OpenNI2"      ] && ./scripts/build_openni2.sh
[ ! -d "third_party/libfreenect2" ] && ./scripts/build_libfreenect2.sh
[ ! -d "third_party/oencv"        ] && ./scripts/build_opencv.sh

echo "compiling the project"
cmake -B build
cmake --build build
