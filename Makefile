
VERSION=0.1

ARCH	?= amd64

HOSTCC	= gcc
HOSTCXX	= g++

TOP_DIR=$(PWD)
DL_DIR=$(TOP_DIR)/dl
OUTPUT=$(TOP_DIR)/output


$(shell if [ ! -d ${DL_DIR} ]; then mkdir -p ${DL_DIR}; fi )
$(shell if [ ! -d ${OUTPUT}"/sources" ]; then mkdir -p ${OUTPUT}"/sources"; fi )
$(shell if [ ! -d ${OUTPUT}"/target" ]; then mkdir -p ${OUTPUT}"/target"; fi )
$(shell if [ ! -d ${OUTPUT}"/rootfs" ]; then mkdir -p ${OUTPUT}"/rootfs"; fi )

PACKAGE_LIST=busybox linux glibc

all:
	$(TOP_DIR)/scripts/mkrootfs.sh

	@$(foreach item, $(PACKAGE_LIST), \
		$(TOP_DIR)/scripts/download.sh $(item); \
		$(TOP_DIR)/scripts/build.sh $(item); \
	)

	$(TOP_DIR)/scripts/pack.sh
