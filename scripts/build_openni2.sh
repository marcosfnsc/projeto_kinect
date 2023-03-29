#!/usr/bin/env bash

[ ! -d "third_party/OpenNI2" ] && git clone --depth 1 --branch v2.2.0-debian https://github.com/structureio/OpenNI2.git third_party/OpenNI2

cd third_party/OpenNI2

curl https://aur.archlinux.org/cgit/aur.git/plain/0002-Change-path-of-config-files-to-etc-openni2.patch\?h\=openni2 --output 0002-Change-path-of-config-files-to-etc-openni2.patch
curl https://aur.archlinux.org/cgit/aur.git/plain/0003-Use-system-wide-libjpeg.patch\?h\=openni2                    --output 0003-Use-system-wide-libjpeg.patch
curl https://aur.archlinux.org/cgit/aur.git/plain/0005-change-default-ni-drivers-path.patch\?h\=openni2             --output 0005-change-default-ni-drivers-path.patch
curl https://aur.archlinux.org/cgit/aur.git/plain/0013-Fix-GCC6-compilation.patch\?h\=openni2                       --output 0013-Fix-GCC6-compilation.patch
curl https://aur.archlinux.org/cgit/aur.git/plain/0014-fix-format-overflow-for-GCC7.patch\?h\=openni2               --output 0014-fix-format-overflow-for-GCC7.patch
curl https://aur.archlinux.org/cgit/aur.git/plain/0015-Initialize-variable-for-gcc7.patch\?h\=openni2               --output 0015-Initialize-variable-for-gcc7.patch
curl https://aur.archlinux.org/cgit/aur.git/plain/libopenni2.pc?h=openni2                                           --output libopenni2.pc

# apply patches
patch -Np1 -i "0002-Change-path-of-config-files-to-etc-openni2.patch"
patch -Np1 -i "0003-Use-system-wide-libjpeg.patch"
patch -Np1 -i "0005-change-default-ni-drivers-path.patch"
patch -Np1 -i "0013-Fix-GCC6-compilation.patch"
patch -Np1 -i "0014-fix-format-overflow-for-GCC7.patch"
patch -Np1 -i "0015-Initialize-variable-for-gcc7.patch"

echo "compiling OpenNI2"
make
