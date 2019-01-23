#!/bin/sh
# post-image.sh for BeagleBoard.org PocketBeagle and BeagleBone
# 2014, Marcin Jabrzyk <marcin.jabrzyk@gmail.com>
# 2016, Lothar Felten <lothar.felten@gmail.com>
# 2018, Jason Kridner <jdk@ti.com>

BOARD_DIR="$(dirname $0)"

GENIMAGE_CFG="${BOARD_DIR}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
GIT_VERSION="$(git describe --abbrev=6 --dirty --always --tags)"

rm -rf "${GENIMAGE_TMP}"

genimage \
    --rootpath "${TARGET_DIR}" \
    --tmppath "${GENIMAGE_TMP}" \
    --inputpath "${BINARIES_DIR}" \
    --outputpath "${BINARIES_DIR}" \
    --config "${GENIMAGE_CFG}"

dd if=${BINARIES_DIR}/MLO of=${BINARIES_DIR}/sdcard.img bs=128k count=1 seek=1 conv=notrunc
dd if=${BINARIES_DIR}/u-boot.img of=${BINARIES_DIR}/sdcard.img bs=384k count=2 seek=1 conv=notrunc

# GamePup
${HOST_DIR}/usr/bin/mkenvimage -r -s 131072 -o ${BINARIES_DIR}/gamepup.env <<'EOF'
fdtfile=am335x-pocketbeagle-gamepup.dtb
loadaddr=0x82000000
fdtaddr=0x88000000
bootcmd=mmc dev 0;load mmc 0:1 ${loadaddr} /boot/zImage;load mmc 0:1 ${fdtaddr} boot/${fdtfile};bootz ${loadaddr} - ${fdtaddr}
bootargs=console=ttyS0,115200n8 root=/dev/mmcblk0p1 ro rootfstype=ext4 rootwait
EOF
dd if=${BINARIES_DIR}/gamepup.env of=${BINARIES_DIR}/sdcard.img bs=128k count=1 seek=16 conv=notrunc
dd if=${BINARIES_DIR}/gamepup.env of=${BINARIES_DIR}/sdcard.img bs=128k count=1 seek=17 conv=notrunc
xz -c ${BINARIES_DIR}/sdcard.img > ${BINARIES_DIR}/beagle-tester-${GIT_VERSION}-gamepup.img.xz

# TechLab
${HOST_DIR}/usr/bin/mkenvimage -r -s 131072 -o ${BINARIES_DIR}/techlab.env <<'EOF'
fdtfile=am335x-pocketbeagle-techlab.dtb
loadaddr=0x82000000
fdtaddr=0x88000000
bootcmd=mmc dev 0;load mmc 0:1 ${loadaddr} /boot/zImage;load mmc 0:1 ${fdtaddr} boot/${fdtfile};bootz ${loadaddr} - ${fdtaddr}
bootargs=console=ttyS0,115200n8 root=/dev/mmcblk0p1 ro rootfstype=ext4 rootwait
EOF
dd if=${BINARIES_DIR}/techlab.env of=${BINARIES_DIR}/sdcard.img bs=128k count=1 seek=16 conv=notrunc
dd if=${BINARIES_DIR}/techlab.env of=${BINARIES_DIR}/sdcard.img bs=128k count=1 seek=17 conv=notrunc
xz -c ${BINARIES_DIR}/sdcard.img > ${BINARIES_DIR}/beagle-tester-${GIT_VERSION}-techlab.img.xz

# BeagleBone Black
${HOST_DIR}/usr/bin/mkenvimage -r -s 131072 -o ${BINARIES_DIR}/boneblack.env <<'EOF'
fdtfile=am335x-boneblack.dtb
loadaddr=0x82000000
fdtaddr=0x88000000
bootcmd=mmc dev 0;load mmc 0:1 ${loadaddr} /boot/zImage;load mmc 0:1 ${fdtaddr} boot/${fdtfile};bootz ${loadaddr} - ${fdtaddr}
bootargs=console=ttyS0,115200n8 root=/dev/mmcblk0p1 ro rootfstype=ext4 rootwait
EOF
dd if=${BINARIES_DIR}/boneblack.env of=${BINARIES_DIR}/sdcard.img bs=128k count=1 seek=16 conv=notrunc
dd if=${BINARIES_DIR}/boneblack.env of=${BINARIES_DIR}/sdcard.img bs=128k count=1 seek=17 conv=notrunc
xz -c ${BINARIES_DIR}/sdcard.img > ${BINARIES_DIR}/beagle-tester-${GIT_VERSION}-boneblack.img.xz

# BeagleBone Black Wireless
${HOST_DIR}/usr/bin/mkenvimage -r -s 131072 -o ${BINARIES_DIR}/boneblack-wireless.env <<'EOF'
fdtfile=am335x-boneblack-wireless.dtb
loadaddr=0x82000000
fdtaddr=0x88000000
bootcmd=mmc dev 0;load mmc 0:1 ${loadaddr} /boot/zImage;load mmc 0:1 ${fdtaddr} boot/${fdtfile};bootz ${loadaddr} - ${fdtaddr}
bootargs=console=ttyS0,115200n8 root=/dev/mmcblk0p1 ro rootfstype=ext4 rootwait
EOF
dd if=${BINARIES_DIR}/boneblack-wireless.env of=${BINARIES_DIR}/sdcard.img bs=128k count=1 seek=16 conv=notrunc
dd if=${BINARIES_DIR}/boneblack-wireless.env of=${BINARIES_DIR}/sdcard.img bs=128k count=1 seek=17 conv=notrunc
xz -c ${BINARIES_DIR}/sdcard.img > ${BINARIES_DIR}/beagle-tester-${GIT_VERSION}-boneblack-wireless.img.xz

rm -f ${BINARIES_DIR}/sdcard.img

