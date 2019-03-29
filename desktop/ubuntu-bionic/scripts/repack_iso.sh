#!/usr/bin/env bash
# This script need for repack UEFI Bootable ISO.

# Define variables
env=$1
IMAGE_DIR=../images/custom/
IMAGE=xubuntu-18.04.2-desktop-amd64-custom.iso
BUILD=../iso

# определение для какой среды создаётся образ kvm или железо
# делается это для того что бы правильно указать имя дискового устройства.
if [[  -z "$env" ]] && [[ "$env"!="hw" ]] && [[ "$env"!="kvm" ]]; then
  echo "argument must to be define! use "kvm" or "hw" value"
elif [[ "$env" = "hw" ]]; then
  sed -i -e 's/vda/sda/g' ../custom_files/custom_preseed.cfg
elif [[ "$env" = "kvm" ]]; then
  sed -i -e 's/sda/vda/g' ../custom_files/custom_preseed.cfg
fi

if [ ! -d "$IMAGE_DIR" ]; then
  mkdir $IMAGE_DIR
fi

# модифицируем стандартный iso кастомными файлами
cp ../custom_files/custom_preseed.cfg $BUILD/preseed/preseed.seed
cp ../custom_files/custom_grub.cfg $BUILD/boot/grub/grub.cfg
# Вычисляем контрольные суммы
rm $BUILD/md5sum.txt
(cd $BUILD/ && find . -type f -print0 | xargs -0 md5sum | grep -v "boot.cat" | grep -v "md5sum.txt" > md5sum.txt)

# Запаковываем содержимое iso/ в образ
xorriso -as mkisofs \
  -c isolinux/boot.cat \
  -b isolinux/isolinux.bin \
  -no-emul-boot \
  -boot-load-size 4 \
  -boot-info-table \
  -eltorito-alt-boot \
  -e boot/grub/efi.img \
  -no-emul-boot \
  -isohybrid-gpt-basdat \
  -o $IMAGE_DIR$IMAGE \
  $BUILD
