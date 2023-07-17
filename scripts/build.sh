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
