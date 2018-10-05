#!/bin/sh
# post-build.sh for BeagleBoard.org PocketBeagle and BeagleBone
# 2018, Jason Kridner <jdk@ti.com>

BOARD_DIR="$(dirname $0)"

# copy the boot files to the target rootfs
cp $BOARD_DIR/uEnv.txt $TARGET_DIR/
cp $BOARD_DIR/beaglerc.sh $TARGET_DIR/etc/rc.local
mkdir -p $TARGET_DIR/boot
cp $BINARIES_DIR/*.dtb $TARGET_DIR/boot/
cp $BINARIES_DIR/zImage $TARGET_DIR/boot/
cd $TARGET_DIR/boot/
ln -s am335x-boneblack.dtb board.dtb
echo "$(git show -s --format='Buildroot beagle-tester %h %ci')" > $TARGET_DIR/etc/dogtag
