#!/bin/sh

echo $1
echo $2

cp $1/packages/busybox/busybox-qemu.config $2/.config
cd $2
make -j2 && make install
