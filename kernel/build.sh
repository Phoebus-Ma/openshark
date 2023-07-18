#!/bin/sh

cd $2

make x86_64_defconfig
make -j4
cp arch/x86/boot/bzImage $1/output/target
