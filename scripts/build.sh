#!/bin/sh

TOP_DIR=$PWD

name=$(cat ${TOP_DIR}/packages/busybox/busybox.json | jq -r '.name')

if [ -n "${TOP_DIR}/dl/busybox/${name}" ]; then
    if [ ! -d "${TOP_DIR}/output/sources/busybox-1.36.1" ]; then
        tar -xf ${TOP_DIR}/dl/busybox/${name} -C ${TOP_DIR}/output/sources
    fi

    cp ${TOP_DIR}/packages/busybox/busybox-qemu.config ${TOP_DIR}/output/sources/busybox-1.36.1/.config
    cd ${TOP_DIR}/output/sources/busybox-1.36.1/
    make -j2 && make install
else
    echo "the package does not exist."
fi


# Create file.
cd ${TOP_DIR}/output/rootfs
mkdir -p dev lib home root etc sys opt mnt tmp proc
mkdir -p etc/init.d
touch etc/init.d/rcS
chmod a+x etc/init.d/rcS
echo "echo \"----hello world----\"" > ${TOP_DIR}/output/rootfs/etc/init.d/rcS

cd ${TOP_DIR}/output/rootfs/dev
sudo mknod -m 664 tty1 c 4 1
sudo mknod -m 664 tty2 c 4 2
sudo mknod -m 664 tty3 c 4 3
sudo mknod -m 664 tty4 c 4 4
sudo mknod -m 664 console c 5 1
sudo mknod -m 664 null c 1 3

cp -raf ${TOP_DIR}/output/sources/busybox-1.36.1/_install/* ${TOP_DIR}/output/rootfs

cd ${TOP_DIR}/output/target
dd if=/dev/zero of=rootfs.img bs=1M count=128
mkfs.ext4 rootfs.img

sudo mount -t ext4 rootfs.img /mnt
sudo cp -raf ${TOP_DIR}/output/rootfs/* /mnt
sync
sudo umount /mnt

name=$(cat ${TOP_DIR}/kernel/linux.json | jq -r '.name')

if [ -n "${TOP_DIR}/dl/linux/${name}" ]; then
    if [ ! -d "${TOP_DIR}/output/sources/linux-6.1.38" ]; then
        tar -xf ${TOP_DIR}/dl/linux/${name} -C ${TOP_DIR}/output/sources
    fi

    cd ${TOP_DIR}/output/sources/linux-6.1.38/
    make x86_64_defconfig
    make -j2 && cp arch/x86/boot/bzImage ${TOP_DIR}/output/target
else
    echo "the package does not exist."
fi

cp ${TOP_DIR}/packages/qemu/start-qemu-x86_64.sh ${TOP_DIR}/output/target
