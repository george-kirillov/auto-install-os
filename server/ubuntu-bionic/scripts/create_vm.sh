#!/bin/bash

vm=$1

virt-install \
--name $vm \
--ram 4096 \
--boot uefi \
--disk path=/var/lib/libvirt/images/$1.qcow2,bus=virtio,size=15 \
-c ../images/custom/ubuntu-18.04.1-custom-server-amd64.iso \
--vcpus 4 \
--os-type linux \
--os-variant generic \
--accelerate \
--network network=default,model=virtio \
--connect=qemu:///system --vnc --noautoconsole -v
# для того что бы работала опция --initrd-inject путь к iso надо указывать через опцию -l
# в случае же с установкой без --initrd-inject (когда preseed.cfg в составе iso) используй -с
