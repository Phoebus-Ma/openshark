#!/bin/sh

TOP_DIR=$PWD

cp -rf ${TOP_DIR}/system/skeleton/* ${TOP_DIR}/output/rootfs

cd ${TOP_DIR}/output/rootfs/dev
sudo mknod -m 664 tty1 c 4 1
sudo mknod -m 664 tty2 c 4 2
sudo mknod -m 664 tty3 c 4 3
sudo mknod -m 664 tty4 c 4 4
sudo mknod -m 664 console c 5 1
sudo mknod -m 664 null c 1 3

cp -raf ${TOP_DIR}/output/sources/busybox-1.36.1/_install/* ${TOP_DIR}/output/rootfs
