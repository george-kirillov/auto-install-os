#!/bin/bash

BUILD=iso
IMAGE=$1
TMPDIR="$(mktemp -d)"

rm -rf $BUILD/
mkdir $BUILD/

# Монтируем образ и копируем файлы
sudo mount -o loop $IMAGE $TMPDIR/
rsync -av $TMPDIR/ $BUILD/
chmod -R u+w $BUILD/
# Подчищаем
sudo umount $TMPDIR
rmdir $TMPDIR
