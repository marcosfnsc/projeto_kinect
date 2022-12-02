#!/usr/bin/env bash

[ ! -d "third_party/OpenNI2"      ] && git clone --depth 1 --branch v2.2.0-debian https://github.com/structureio/OpenNI2.git      third_party/OpenNI2
[ ! -d "third_party/freeglut"     ] && git clone --depth 1 --branch v3.4.0        https://github.com/FreeGLUTProject/freeglut.git third_party/freeglut
[ ! -d "third_party/libfreenect"  ] && git clone --depth 1 --branch v0.6.4        https://github.com/OpenKinect/libfreenect.git   third_party/libfreenect
[ ! -d "third_party/libfreenect2" ] && git clone --depth 1 --branch v0.2.1        https://github.com/OpenKinect/libfreenect2.git  third_party/libfreenect2

WORKDIR=$PWD

## compile libfreenect
cd third_party/libfreenect
echo "compiling libfreenect"
cmake \
  -DBUILD_REDIST_PACKAGE=OFF \
  -DBUILD_OPENNI2_DRIVER=ON \
  -DBUILD_PYTHON3=ON \
  -DOpenGL_GL_PREFERENCE=GLVND .

# Fix cython3 path
sed -i 's/CYTHON_EXECUTABLE:FILEPATH=CYTHON_EXECUTABLE-NOTFOUND/CYTHON_EXECUTABLE:FILEPATH=\/usr\/bin\/cython3/g' CMakeCache.txt

make

cd $WORKDIR

## compile libfreenect2
cd third_party/libfreenect2
echo "compiling libfreenect2"
cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DENABLE_CXX11=ON \
  -DENABLE_OPENCL=ON \
  -DENABLE_CUDA=OFF \
  -DENABLE_TEGRAJPEG=OFF \
  -DBUILD_EXAMPLES=ON
make
