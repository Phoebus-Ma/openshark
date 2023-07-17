#!/bin/sh

qemu-system-x86_64 \
    -M pc \
    -kernel bzImage \
    -drive file=rootfs.ext4,if=virtio,format=raw \
    -append "rootwait root=/dev/vda rw console=tty1 console=ttyS0" \
    -net nic,model=virtio \
    -net user \
    -nographic
