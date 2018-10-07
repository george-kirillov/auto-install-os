#!/bin/bash

vm=$1
# останавливаем ВМ и удаляем её
for i in destroy undefine
do
virsh -c qemu:///system $i $vm
done
# Удаляем её виртуальный жесткий диск
rm -f /var/lib/libvirt/images/$1.qcow2
