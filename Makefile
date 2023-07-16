
VERSION=0.1

ARCH	?= amd64

HOSTCC	= gcc
HOSTCXX	= g++

DL_PATH=dl
OUTPUT=output

$(shell if [ ! -d ${DL_PATH} ]; then mkdir -p ${DL_PATH}; fi )
$(shell if [ ! -d ${OUTPUT}"/sources" ]; then mkdir -p ${OUTPUT}"/sources"; fi )
$(shell if [ ! -d ${OUTPUT}"/target" ]; then mkdir -p ${OUTPUT}"/target"; fi )
$(shell if [ ! -d ${OUTPUT}"/rootfs" ]; then mkdir -p ${OUTPUT}"/rootfs"; fi )

dl-packages:
	# ./scripts/download.sh
	# ./scripts/build.sh
