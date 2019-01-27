################################################################################
#
# bb.org-overlays
#
################################################################################

BBORG_OVERLAYS_VERSION = bf78cbb6a505b8fdbb637e387bd54cb03710bfc3
BBORG_OVERLAYS_SITE = $(call github,beagleboard,bb.org-overlays,$(BBORG_OVERLAYS_VERSION))
BBORG_OVERLAYS_INSTALL_STAGING = YES
BBORG_OVERLAYS_LICENSE = GPLv2
BBORG_OVERLAYS_LICENSE_FILES = LICENSE

define BBORG_OVERLAYS_BUILD_CMDS
	$(MAKE) DTC=$(HOST_DIR)/usr/bin/dtc $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define BBORG_OVERLAYS_INSTALL_STAGING_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) DESTDIR=$(STAGING_DIR) prefix=/usr -C $(@D) install
endef

define BBORG_OVERLAYS_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) DESTDIR=$(TARGET_DIR) prefix=/usr -C $(@D) install
endef

$(eval $(generic-package))
