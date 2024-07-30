#!/bin/bash

set -eu

cd "$SRC"

echo Clean up prefix directory
shopt -s dotglob
rm -rf "${PREFIX:?}"/*

# Default number of parallel make jobs is number of processor
NPROC=${NPROC:-$(nproc)}

echo Configure multilib Newlib toolchain
./configure "--prefix=$PREFIX" --with-cmodel=medany --enable-multilib --enable-libsanitizer --enable-qemu-system

echo Build multilib Newlib toolchain
if [ -f /etc/centos-release ]; then
    # Use system python3, rh-python38 doesn't have `-devel` package
    GDB_FLAGS=--with-python=/usr/bin/python3
else
    GDB_FLAGS=
fi
GDB_TARGET_FLAGS_EXTRA=$GDB_FLAGS make -j "$NPROC"

echo Build QEMU
make -j "$NPROC" build-sim SIM=qemu

echo Build Spike
make -j "$NPROC" build-sim SIM=spike

echo Configure Linux toolchain
./configure "--prefix=$PREFIX" --with-cmodel=medany --enable-llvm

echo Build Linux toolchain
make -j "$NPROC" linux
