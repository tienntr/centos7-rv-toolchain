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
# Use system python3 because rh-python3 doesn't have corresponding `-devel`` package
GDB_TARGET_FLAGS_EXTRA=--with-python=/usr/bin/python3 make -j "$NPROC"

echo Build QEMU
make -j "$NPROC" build-sim SIM=qemu

echo Build Spike
make -j "$NPROC" build-sim SIM=spike

echo Configure Linux toolchain
./configure "--prefix=$PREFIX" --with-cmodel=medany --enable-llvm

echo Build Linux toolchain
make -j "$NPROC" linux
