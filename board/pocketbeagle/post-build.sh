#!/bin/sh
# post-build.sh for BeagleBoard.org PocketBeagle and BeagleBone
# 2018, Jason Kridner <jdk@ti.com>

BOARD_DIR="$(dirname $0)"

# copy the boot files to the target rootfs
mkdir -p $TARGET_DIR/boot
cp $BOARD_DIR/uEnv.txt $TARGET_DIR/boot/uEnv.txt
cp $BINARIES_DIR/*.dtb $TARGET_DIR/boot/
cp $BINARIES_DIR/zImage $TARGET_DIR/boot/
