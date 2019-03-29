#!/usr/bin/env bash

# Define variables
BUILD=../iso
OSVERSION=18.04.2
IMAGE=../images/origin/xubuntu-$OSVERSION-desktop-amd64.iso
TMPDIR="$(mktemp -d)"

# create clean work space
rm -rf $BUILD/
mkdir $BUILD/

# Check availability local iso image
if ! [[ -e "$IMAGE" ]]; then
wget -P ../images/origin/ https://mirror.yandex.ru/ubuntu-cdimage/xubuntu/releases/18.04/release/xubuntu-18.04.2-desktop-amd64.iso
fi

# Mount image & copy files
sudo mount -o loop $IMAGE $TMPDIR/
rsync -av $TMPDIR/ $BUILD/
chmod -R u+w $BUILD/
# Cleanup
sudo umount $TMPDIR
rmdir $TMPDIR
