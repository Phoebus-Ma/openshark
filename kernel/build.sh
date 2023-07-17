#!/bin/sh

echo $1
echo $2

cd $2

make x86_64_defconfig
make -j2
cp arch/x86/boot/bzImage $1/output/target
