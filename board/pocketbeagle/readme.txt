BeagleBoard.org PocketBeagle and BeagleBone

Description
===========

This configuration will build a complete image for BeagleBoard.org
PocketBeagle, BeagleBone and several BeagleBoard Compatible BeagleBone
boards. The board type is identified by the on-board EEPROM. The kernel
used is the official BeagleBoard.org one based on mainline and select
TI and community out-of-tree patches.

How to build it
===============

Select the default configuration for the target:
$ make pocketbeagle_defconfig

Optional: modify the configuration:
$ make menuconfig

Build:
$ make

Result of the build
===================
output/images/
├── am335x-abbbi.dtb
├── am335x-boneblack.dtb
├── am335x-boneblack-wireless.dtb
├── am335x-bone.dtb
├── am335x-bonegreen.dtb
├── am335x-bonegreen-wireless.dtb
├── am335x-evm.dtb
├── am335x-evmsk.dtb
├── am335x-pocketbeagle.dtb
├── am335x-sancloud-bbe.dtb
├── MLO
├── rootfs.cpio
├── rootfs.cpio.uboot
├── rootfs.cpio.xz
├── rootfs.ext2
├── rootfs.ext4
├── rootfs.tar
├── sdcard.img
├── u-boot.img
├── u-boot-spl.bin
├── uEnv.txt
└── zImage

To copy the image file to the sdcard use dd:
$ dd if=output/images/sdcard.img of=/dev/XXX

To boot via USB, use https://github.com/jadonk/node-beagle-boot

Tested hardware
===============
PocketBeagle (rev A2)
