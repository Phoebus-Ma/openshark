#!/bin/sh

TOP_DIR=$PWD
DL_DIR=${TOP_DIR}/dl
SOURCE_DIR=${TOP_DIR}/output/sources
NAME_KEY='.name'

# Get json file path.
if [ "linux" = "$1" ]; then
    PKG_DIR=${TOP_DIR}/kernel
else
    PKG_DIR=${TOP_DIR}/packages/$1
fi

JSON_FILE=${PKG_DIR}/$1.json

# Get json keyword value.
if [ -f ${JSON_FILE} ]; then
    PAC_NAME=$(cat ${JSON_FILE} | jq -r ${NAME_KEY})
else
    echo "the "${JSON_FILE}" does not exist."
    exit 1
fi

# Strip file suffix.
NAME=${PAC_NAME%*.tar.*}

# Package source dir
BUILD_DIR=${SOURCE_DIR}/${NAME}

# Decompressing the package.
if [ -f "${DL_DIR}/$1/${PAC_NAME}" ]; then
    if [ ! -d "${BUILD_DIR}" ]; then
        tar -xf ${DL_DIR}/$1/${PAC_NAME} -C ${SOURCE_DIR}
    fi
else
    echo "the package does not exist."
fi

# Build the package.
$source ${PKG_DIR}/build.sh ${TOP_DIR} ${BUILD_DIR}
