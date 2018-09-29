### pack.sh — скрипт для упаковки образа
#!/bin/bash

IMAGE=$1
BUILD=iso

# модифицируем стандартный iso кастомными файлами
cp preseed.cfg $BUILD/preseed/preseed.seed
cp txt.cfg $BUILD/isolinux/
cp lang $BUILD/isolinux/

# Вычисляем контрольные суммы
rm $BUILD/md5sum.txt
(cd $BUILD/ && find . -type f -print0 | xargs -0 md5sum | grep -v "boot.cat" | grep -v "md5sum.txt" > md5sum.txt)

# Запаковываем содержимое iso/ в образ
mkisofs -r -V "Ubuntu OEM install" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o $IMAGE $BUILD/
#mkisofs -U -A "Ubuntu OEM install" -V "Ubuntu OEM install" -volset "Ubuntu OEM install" -J -joliet-long -r -v -T -o $IMAGE -b $BUILD/isolinux/isolinux.bin -c $BUILD/isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e $BUILD/boot/grub/efi.img -no-emul-boot .
