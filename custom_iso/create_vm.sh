#!/bin/bash

vm=$1

virt-install \
--name $vm \
--ram 2048 \
--boot uefi \
--disk path=/var/lib/libvirt/images/$1.qcow2,bus=virtio,size=15 \
-c /home/george/git-repo/install_os_ilo/custom_iso/ubuntu-16.04.4-server-amd64_custome.iso \
--vcpus 2 \
--os-type linux \
--os-variant generic \
--accelerate \
--network network=dead_net,model=virtio \
--connect=qemu:///system --vnc --noautoconsole -v