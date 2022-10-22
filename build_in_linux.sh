#!/usr/bin/env bash

[ ! -d "third_party/OpenNI2"      ] && git clone --depth 1 --branch v2.2.0-debian https://github.com/structureio/OpenNI2.git      third_party/OpenNI2
[ ! -d "third_party/freeglut"     ] && git clone --depth 1 --branch v3.4.0        https://github.com/FreeGLUTProject/freeglut.git third_party/freeglut
[ ! -d "third_party/libfreenect"  ] && git clone --depth 1 --branch v0.6.4        https://github.com/OpenKinect/libfreenect.git   third_party/libfreenect
[ ! -d "third_party/libfreenect2" ] && git clone --depth 1 --branch v0.2.1        https://github.com/OpenKinect/libfreenect2.git  third_party/libfreenect2
