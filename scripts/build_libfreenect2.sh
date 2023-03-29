#!/usr/bin/env bash

OpenNI2_LIBRARY_DIR="$PWD/third_party/OpenNI2"
OpenNI2_INCLUDE_DIRS="$PWD/third_party/OpenNI2/include"

[ ! -d "third_party/libfreenect2" ] && git clone --depth 1 --branch v0.2.1 https://github.com/OpenKinect/libfreenect2.git third_party/libfreenect2

cd third_party/libfreenect2
echo "compiling libfreenect2"
mkdir -p build && cd build
cmake \
  .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DENABLE_CXX11=ON \
  -DENABLE_OPENCL=OFF \
  -DENABLE_CUDA=OFF \
  -DENABLE_TEGRAJPEG=OFF \
  -DBUILD_EXAMPLES=OFF \
  -DOpenNI2_LIBRARY=$OpenNI2_LIBRARY_DIR \
  -DOpenNI2_INCLUDE_DIRS=$OpenNI2_INCLUDE_DIRS \
  -DCMAKE_INSTALL_PREFIX=$PWD/..
make
