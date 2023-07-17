#!/bin/sh

TOP_DIR=$PWD

cd ${TOP_DIR}/output/target
dd if=/dev/zero of=rootfs.ext4 bs=1M count=128
mkfs.ext4 rootfs.ext4

sudo mount -t ext4 rootfs.ext4 /mnt
sudo cp -raf ${TOP_DIR}/output/rootfs/* /mnt
sync
sudo umount /mnt

cp ${TOP_DIR}/scripts/start-qemu/start-qemu-x86_64.sh ${TOP_DIR}/output/target
