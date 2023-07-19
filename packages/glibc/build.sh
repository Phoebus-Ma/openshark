#!/bin/sh

cd $2

# Patching
patch -Np1 -i $1/packages/glibc/glibc-2.37-fhs-1.patch

# Create build folder.
mkdir build _install
cd build

# Config.
../configure                    \
    --prefix=$2/_install        \
    --host=x86_64-linux-gnu     \
    --build=x86_64-linux-gnu    \
    --enable-kernel=3.2         \
    --enable-shared             \
    --disable-werror

# Build.
make -j4

# Install.
make install

# Copying.
cd $2/_install
cp -raf bin sbin lib include $1/output/rootfs/usr

# Strip.
rm $1/output/rootfs/usr/lib/*.a
rm $1/output/rootfs/usr/lib/*.o
rm -rf $1/output/rootfs/usr/lib/audit
rm -rf $1/output/rootfs/usr/lib/gconv

rm $1/output/rootfs/usr/lib/libc.so
rm $1/output/rootfs/usr/lib/libm.so
strip $1/output/rootfs/usr/lib/*.so*
