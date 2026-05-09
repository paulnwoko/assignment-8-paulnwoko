################################################################################
#
# ldd
#
################################################################################

LDD_VERSION = d5aedd122b76010360eeb50b89f120a8ed765329
#LDD_SOURCE = ldd-$(LDD_VERSION).tar.xz
LDD_SITE = git@github.com:paulnwoko/assignment-7-paulnwoko.git
LDD_SITE_METHOD = git
LDD_LICENSE = GPL-2.0
LDD_LICENSE_FILES = COPYING

LDD_MODULE_SUBDIRS = misc-modules scull
LDD_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)

# This command runs after the kernel modules are installed.
# It copies the loading/unloading scripts to the target's /usr/bin
define LDD_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/scull/scull_load $(TARGET_DIR)/usr/bin/scull_load
	$(INSTALL) -D -m 0755 $(@D)/scull/scull_unload $(TARGET_DIR)/usr/bin/scull_unload
	$(INSTALL) -D -m 0755 $(@D)/misc-modules/module_load $(TARGET_DIR)/usr/bin/module_load
	$(INSTALL) -D -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/usr/bin/module_unload
endef

# We use the generic-package post-install hooks to trigger the install
LDD_POST_INSTALL_TARGET_HOOKS += LDD_INSTALL_STAGING_CMDS

$(eval $(kernel-module))
#$(eval $(autotools-package))
$(eval $(generic-package))
