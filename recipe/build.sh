#!/usr/bin/env bash

set -ex

mkdir build
cd build

# translate compiler activation script's CMAKE_ARGS to toolchain file
# (this is so an in-project native build can work by not inheriting the args)
eval echo "$CMAKE_ARGS" | sed -e 's/-D/set(/g;s/ /)\'$'\n''/g;s/=/ /g;$ s/$/)/g' > host_toolchain.cmake

cmake_config_args=(
    -DCMAKE_TOOLCHAIN_FILE=host_toolchain.cmake
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=$PREFIX
    -DCMAKE_INSTALL_LIBDIR=lib
    -DBUILD_SHARED_LIBS=ON
)

cmake .. "${cmake_config_args[@]}"
cmake --build . --config Release -- -j${CPU_COUNT}
cmake --build . --config Release --target install
