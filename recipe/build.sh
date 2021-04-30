#!/usr/bin/env bash

set -ex

mkdir build
cd build

# clear variables that are not necessary thanks to CMAKE_ARGS but prevent
# in-tree native build of generate_codebook (picked up by CMAKE without flags)
unset AR
unset CC
unset LD
unset NM
unset RANLIB
unset STRIP

cmake_config_args=(
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=$PREFIX
    -DCMAKE_INSTALL_LIBDIR=lib
    -DBUILD_SHARED_LIBS=ON
)

cmake -G "Ninja" ${CMAKE_ARGS} .. "${cmake_config_args[@]}"
cmake --build . --config Release -- -j${CPU_COUNT}
cmake --build . --config Release --target install
