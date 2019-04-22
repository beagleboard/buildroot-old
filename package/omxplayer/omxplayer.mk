################################################################################
#
# omxplayer
#
################################################################################

OMXPLAYER_VERSION = 2ee17b22a6149a043a2e402580504f282c615373
OMXPLAYER_SITE = $(call github,popcornmix,omxplayer,$(OMXPLAYER_VERSION))
OMXPLAYER_LICENSE = GPL-2.0+
OMXPLAYER_LICENSE_FILES = COPYING

OMXPLAYER_DEPENDENCIES = \
	host-pkgconf alsa-lib boost dbus ffmpeg freetype libidn libusb pcre \
	rpi-userland zlib

OMXPLAYER_EXTRA_CFLAGS = \
	-DTARGET_LINUX -DTARGET_POSIX \
	`$(PKG_CONFIG_HOST_BINARY) --cflags bcm_host` \
	`$(PKG_CONFIG_HOST_BINARY) --cflags freetype2` \
	`$(PKG_CONFIG_HOST_BINARY) --cflags dbus-1`

# OMXplayer has support for building in Buildroot, but that
# procedure is, well, tainted. Fix this by forcing the real,
# correct values.
OMXPLAYER_MAKE_ENV = \
	SDKSTAGE=$(STAGING_DIR) \
	$(TARGET_CONFIGURE_OPTS) \
	STRIP=true \
	CFLAGS="$(TARGET_CFLAGS) $(OMXPLAYER_EXTRA_CFLAGS)"

define OMXPLAYER_BUILD_CMDS
	$(OMXPLAYER_MAKE_ENV) $(MAKE) -C $(@D) omxplayer.bin
endef

define OMXPLAYER_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/omxplayer.bin $(TARGET_DIR)/usr/bin/omxplayer.bin
        $(INSTALL) -m 755 $(@D)/omxplayer $(TARGET_DIR)/usr/bin/omxplayer
        mkdir -p $(TARGET_DIR)/usr/omxplayer/
        $(INSTALL) -m 755 $(@D)/dbuscontrol.sh $(TARGET_DIR)/usr/omxplayer/dbuscontrol.sh
        mkdir -p $(TARGET_DIR)/usr/share/fonts/truetype/freefont/
        $(INSTALL) -m 644 $(@D)/fonts/FreeSans.ttf $(TARGET_DIR)/usr/share/fonts/truetype/freefont/
        $(INSTALL) -m 644 $(@D)/fonts/FreeSansOblique.ttf $(TARGET_DIR)/usr/share/fonts/truetype/freefont/
endef

$(eval $(generic-package))
