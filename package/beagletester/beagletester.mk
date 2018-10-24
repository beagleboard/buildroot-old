################################################################################
#
# beagle-tester
#
################################################################################

BEAGLETESTER_VERSION = a80488af8d7aec65a733cacc3dee90c888af1e57
BEAGLETESTER_SITE = $(call github,jadonk,beagle-tester,$(BEAGLETESTER_VERSION))
BEAGLETESTER_INSTALL_STAGING = YES
BEAGLETESTER_LICENSE = GPLv2
BEAGLETESTER_LICENSE_FILES = LICENSE

define BEAGLETESTER_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define BEAGLETESTER_INSTALL_STAGING_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) DESTDIR=$(STAGING_DIR) prefix=/usr -C $(@D) install
endef

define BEAGLETESTER_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) DESTDIR=$(TARGET_DIR) prefix=/usr -C $(@D) install
endef

$(eval $(generic-package))
