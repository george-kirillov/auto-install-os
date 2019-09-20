#!/usr/bin/env bash
# This script need for repack UEFI Bootable ISO.

# Define variables
OSVERSION=18.04.3
IMAGE_DIR=../images/custom
IMAGE=ubuntu-$OSVERSION-server-amd64-custom.iso
BUILD=../iso

# создаём каталог для postinstall.sh
if [ ! -d "$BUILD/extra" ]; then
  mkdir $BUILD/extra
fi

# модифицируем стандартный iso кастомными файлами
cp ../custom_files/custom_preseed.cfg $BUILD/preseed/preseed.seed
cp ../custom_files/custom_grub.cfg $BUILD/boot/grub/grub.cfg
cp ../custom_files/lang $BUILD/isolinux/lang
cp ../custom_files/isolinux.cfg $BUILD/isolinux/isolinux.cfg
cp ../custom_files/txt.cfg $BUILD/isolinux/txt.cfg
cp -r ../custom_files/extra/* $BUILD/extra/

# создаём каталог для кастомного образа
if [ ! -d "$IMAGE_DIR" ]; then
  mkdir $IMAGE_DIR
fi

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
  -o $IMAGE_DIR/$IMAGE \
  $BUILD
