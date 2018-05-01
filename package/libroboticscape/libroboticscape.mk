################################################################################
#
# libroboticscape
#
################################################################################

LIBROBOTICSCAPE_VERSION = v0.4.2
LIBROBOTICSCAPE_SITE = $(call github,StrawsonDesign,Robotics_Cape_Installer,$(LIBROBOTICSCAPE_VERSION))
LIBROBOTICSCAPE_INSTALL_STAGING = YES
LIBROBOTICSCAPE_LICENSE = MIT
LIBROBOTICSCAPE_LICENSE_FILES = LICENSE

define LIBROBOTICSCAPE_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/library
endef

define LIBROBOTICSCAPE_INSTALL_STAGING_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) DESTDIR=$(STAGING_DIR) prefix=/usr -C $(@D)/library install
endef

define LIBROBOTICSCAPE_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) DESTDIR=$(TARGET_DIR) prefix=/usr -C $(@D)/library install
endef

$(eval $(generic-package))
