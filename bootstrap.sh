#!/usr/bin/env bash

apt-get update
apt-get install -y build-essential automake git libncurses5-dev texinfo
apt-get install -y libreadline-dev flex bison libx11-dev libxrandr-dev 
apt-get install -y qemu libvirt-bin

mkdir -p ~/os/toolchain
if [ ! -d ~/os/pintos/src ]; then
  git clone https://github.com/jhu-cs318/pintos.git ~/os
fi
if ! hash pintos 2>/dev/null; then
  echo "Building pintos utility tools..."
  cd ~/os/pintos/src/utils
  make
  cp backtrace pintos Pintos.pm pintos-gdb pintos-set-cmdline pintos-mkdisk setitimer-helper squish-pty squish-unix /usr/local/bin
  mkdir /usr/local/misc
  cp ../misc/gdb-macros /usr/local/misc
  echo "Copied pintos utility tools to /usr/local/bin"
else
  echo "Pintos utility tools already built"
fi

if ! hash bochs-dbg 2>/dev/null; then
  echo "Building patched Bochs..."
  cd ~/os/pintos/src
  misc/bochs-2.6.2-build.sh /usr/local
else
  echo "Bochs already built"
fi

if ! hash i386-elf-gdb 2>/dev/null; then
  echo "Building i386-elf-gdb..."
  cd ~/os/pintos/src
  misc/toolchain-build.sh --prefix /usr/local ~/os/toolchain gdb
  if hash i386-elf-gdb 2>/dev/null; then
    echo "Successfully built and installed i386-elf-gdb to /usr/local/bin"
  else
    echo "Failed to build i386-elf-gdb"
  fi
else
  echo "i386-elf-gdb already built"
fi

if ! hash i386-elf-objdump 2>/dev/null; then
  echo "Building i386 binutils..."
  cd ~/os/pintos/src
  misc/toolchain-build.sh --prefix /usr/local ~/os/toolchain binutils
  if hash i386-elf-objdump 2>/dev/null; then
    echo "Successfully built and installed i386 binutils to /usr/local/bin"
  else
    echo "Failed to build i386 binutils"
  fi
else
  echo "i386 binutils already built"
fi

if ! hash i386-elf-gcc 2>/dev/null; then
  echo "Building i386-elf-gcc..."
  cd ~/os/pintos/src
  misc/toolchain-build.sh --prefix /usr/local ~/os/toolchain gcc
  if hash i386-elf-gcc 2>/dev/null; then
    echo "Successfully built and installed i386-elf-gcc to /usr/local/bin"
  else
    echo "Failed to build i386-elf-gcc "
  fi
else
  echo "i386-elf-gcc already built"
fi

echo "Pintos development toolchains are ready"
