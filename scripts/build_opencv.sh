#!/usr/bin/env bash

[ ! -d "third_party/opencv" ] && git clone --depth 1 --branch 4.7.0 https://github.com/opencv/opencv.git third_party/opencv

cd third_party/opencv
echo "compiling opencv"
mkdir -p build && cd build
cmake \
  .. \
  -G Ninja \
  -DBUILD_JAVA=off \
  -DBUILD_PERF_TESTS=OFF \
  -DBUILD_PROTOBUF=OFF \
  -DBUILD_TESTS=OFF \
  -DBUILD_opencv_java_bindings_generator=OFF \
  -DBUILD_opencv_js_bindings_generator=OFF \
  -DBUILD_opencv_python_bindings_generator=OFF \
  -DBUILD_opencv_python_tests=OFF
cmake --build .
