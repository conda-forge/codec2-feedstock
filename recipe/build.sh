#!/usr/bin/env bash

set -ex

mkdir build
cd build

if [[ "$target_platform" == "win-64" ]]; then
  export PREFIX=${PREFIX}/Library
fi

# clear variables that are not necessary thanks to CMAKE_ARGS but prevent
# in-tree native build of generate_codebook (picked up by CMAKE without flags)
# but preserve CC and CXX first as a CMAKE arg
CMAKE_ARGS="${CMAKE_ARGS} -DCMAKE_C_COMPILER=$CC -DCMAKE_CXX_COMPILER=$CXX -DCMAKE_C_FLAGS=\'$CFLAGS\' -DCMAKE_CXX_FLAGS=\'$CXXFLAGS\'"
unset AR
unset CFLAGS
unset CXXFLAGS
unset LD
unset NM
unset RANLIB
unset STRIP
# set CC and CXX variables to build env compilers so in-tree native build of
# generate_codebook picks up the right compilers (not used for regular build
# because we set CMAKE_C(XX)_COMPILER
CC="$CC_FOR_BUILD"
CXX="$CXX_FOR_BUILD"

cmake_config_args=(
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=$PREFIX
    -DCMAKE_INSTALL_LIBDIR=lib
    -DCMAKE_PREFIX_PATH=$PREFIX
    -DBUILD_SHARED_LIBS=ON
)

if [[ "$target_platform" == "win-64" ]]; then
    cmake_config_args+=(
        -DCMAKE_GNUtoMS=ON
    )
fi

cmake -G "Ninja" ${CMAKE_ARGS} .. "${cmake_config_args[@]}"
cmake --build . --config Release -- -j${CPU_COUNT}
