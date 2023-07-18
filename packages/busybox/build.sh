#!/bin/sh

cp $1/packages/busybox/busybox-qemu.config $2/.config
cd $2
make -j4 && make install

cp -raf $2/_install/* $1/output/rootfs
