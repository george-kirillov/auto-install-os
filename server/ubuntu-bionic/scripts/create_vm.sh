#!/bin/bash

vm=$1
vhdsize=15
OSVERSION=18.04.3

echo "What mode to use?"
read -p "(uefi/bios): " answer
if [[ $answer == "uefi" ]]; then
  mode="uefi"
elif [[ "$answer" == "bios" ]]; then
  mode="hd,cdrom,menu=on"
else
  echo "No mode selected! nothing to do!"
  exit 0
fi

virt-install \
--name $vm \
--ram 2048 \
--boot $mode \
--disk path=$HOME/$1.qcow2,bus=virtio,size=$vhdsize \
-c ../images/custom/ubuntu-$OSVERSION-server-amd64-custom.iso \
--vcpus 2 \
--os-type linux \
--os-variant ubuntu18.04 \
--accelerate \
--network network=default,model=virtio \
--connect=qemu:///system --vnc --noautoconsole -v
# для того что бы работала опция --initrd-inject путь к iso надо указывать через опцию -l
# в случае же с установкой без --initrd-inject (когда preseed.cfg в составе iso) используй -с
