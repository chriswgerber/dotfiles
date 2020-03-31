#!/bin/sh

SOURCE_DIR=$(git config --path --get init.templatedir)/
DEST_DIR=`git rev-parse --show-toplevel`/.git/

echo "Copying from ${SOURCE_DIR} to ${DEST_DIR}"
rsync -av --progress ${SOURCE_DIR} ${DEST_DIR}
