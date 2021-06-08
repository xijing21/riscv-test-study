#!/bin/bash
#update for error 'pathspec jw did not match any file(s) known to git'
apt-get  install git build-essential tcl expect flex texinfo bison libpixman-1-dev libglib2.0-dev pkg-config zlib1g-dev ninja-build autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk  gperf libtool patchutils bc  libexpat-dev python

git clone https://github.com/riscv/riscv-gnu-toolchain 
cd riscv-gnu-toolchain
git submodule update --init
cd riscv-gcc
git remote add jw https://github.com/pz9115/riscv-gcc.git
git fetch jw
git checkout jw/riscv-gcc-10.2.0-rvb
cd ../riscv-binutils
git remote add jw https://github.com/pz9115/riscv-binutils-gdb.git
git fetch jw
git checkout jw/riscv-binutils-experiment

# test:
cd ..
./configure --prefix="$PWD/opt-riscv/" --enable-multilib=true

# you can use make -j* to make speed up
make report-gcc-newlib -j $(nproc)
make report-binutils-newlib -j $(nproc)