#!/bin/bash

vm=$1
# останавливаем ВМ и удаляем её
for i in destroy "undefine --nvram"
do
virsh -c qemu:///system $i $vm
done
# Удаляем её виртуальный жесткий диск
rm -f $HOME/$1.qcow2
