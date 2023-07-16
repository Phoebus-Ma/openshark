#!/bin/sh

name=$(cat ./packages/busybox/busybox.json | jq -r '.name')
url=$(cat ./packages/busybox/busybox.json | jq -r '.download.file')


if [ -n "${url}" ]; then
    if [ ! -f "dl/busybox/""${name}" ]; then
        wget -P dl/busybox ${url}
    fi
elif [ -z "${url}" ]; then
    echo "search from default repo."
else
    echo "Failed in package."
fi


name=$(cat ./kernel/linux.json | jq -r '.name')
url=$(cat ./kernel/linux.json | jq -r '.download.file')


if [ -n "${url}" ]; then
    if [ ! -f "dl/linux/""${name}" ]; then
        wget -P dl/linux ${url}
    fi
elif [ -z "${url}" ]; then
    echo "search from default repo."
else
    echo "Failed in package."
fi
