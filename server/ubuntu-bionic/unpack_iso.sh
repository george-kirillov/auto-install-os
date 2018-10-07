#!/usr/bin/env bash

# Define variables
BUILD=iso
OSVERSION=18.04.1
IMAGE=ubuntu-$OSVERSION-server-amd64.iso
TMPDIR="$(mktemp -d)"

# create clean work space
rm -rf $BUILD/
mkdir $BUILD/

# Check availability local iso image
if ! [[ -e "ubuntu-$OSVERSION-server-amd64.iso" ]]; then
wget http://cdimage.ubuntu.com/releases/$OSVERSION/release/ubuntu-$OSVERSION-server-amd64.iso
fi

# Mount image & copy files
sudo mount -o loop $IMAGE $TMPDIR/
rsync -av $TMPDIR/ $BUILD/
chmod -R u+w $BUILD/
# Cleanup
sudo umount $TMPDIR
rmdir $TMPDIR
