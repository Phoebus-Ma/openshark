#!/bin/sh

TOP_DIR=$PWD
DL_DIR=${TOP_DIR}/dl
NAME_KEY='.name'
DL_FILE_KEY='.download.file'

# Get json file path.
if [ "linux" = "$1" ]; then
    JSON_FILE=${TOP_DIR}/kernel/$1.json
else
    JSON_FILE=${TOP_DIR}/packages/$1/$1.json
fi

# Get json keyword value.
if [ -f ${JSON_FILE} ]; then
    PKG_NAME=$(cat ${JSON_FILE} | jq -r ${NAME_KEY})
    URL=$(cat ${JSON_FILE} | jq -r ${DL_FILE_KEY})
else
    echo "the "${JSON_FILE}" does not exist."
    exit 1
fi

# Download package.
if [ -n "${URL}" ]; then
    if [ ! -f "${DL_DIR}/$1/${PKG_NAME}" ]; then
        wget -P ${DL_DIR}/$1 ${URL}
    fi
elif [ -z "${URL}" ]; then
    echo "search from default repo."
else
    echo "Failed in package."
fi
