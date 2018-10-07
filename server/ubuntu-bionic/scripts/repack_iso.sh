#!/usr/bin/env bash
# This script need for repack UEFI Bootable ISO.

# Define variables
IMAGE=$1
BUILD=../iso

# модифицируем стандартный iso кастомными файлами
cp custom_files/custom_preseed.cfg $BUILD/preseed/preseed.seed
cp custom_files/custom_grub.cfg $BUILD/boot/grub/grub.cfg
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
  -o $1 \
  $BUILD
