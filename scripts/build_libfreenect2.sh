#!/usr/bin/env bash

[ ! -d "third_party/libfreenect2" ] && git clone --depth 1 --branch v0.2.1        https://github.com/OpenKinect/libfreenect2.git  third_party/libfreenect2

cd third_party/libfreenect2
echo "compiling libfreenect2"
cmake \
  -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DENABLE_CXX11=ON \
  -DENABLE_OPENCL=OFF \
  -DENABLE_CUDA=OFF \
  -DENABLE_TEGRAJPEG=OFF \
  -DBUILD_EXAMPLES=OFF \
  -DBUILD_SHARED_LIBS=OFF \
  -DCMAKE_INSTALL_PREFIX=.
cmake --build .
