include $(TOPDIR)/rules.mk

PKG_NAME:=7zz
PKG_VERSION:=24.09
PKG_RELEASE:=1

ifeq ($(ARCH),aarch64)
  PKG_ARCH:=7z_arm64
  PKG_HASH:=2b8bd8073b0d4327d9f2b34a1bd8e2c044df8baaa4d5f072920ea309ccb5dfee
else ifeq ($(ARCH),arm)
  PKG_ARCH:=7z_arm
  PKG_HASH:=38bb20468e53436e499f8359da8c4a749a78e961e57237e689ff4f56ff2cc7de
else ifeq ($(ARCH),i386)
  PKG_ARCH:=7z_i386
  PKG_HASH:=7a44bf955c93ec5caf0fe90bf2f65451fec53ed55b1d3288cbda065dc91cb9d0
else ifeq ($(ARCH),x86_64)
  PKG_ARCH:=7z_amd64
  PKG_HASH:=52a55958c075e427e0fc30c814bc97edce717312a3c97fde3db543c5344735cf
else
  PKG_HASH:=dummy
endif

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(ARCH_PACKAGES)
PKG_SOURCE_URL:=https://github.com/kkstone/7zz-openwrt/releases/download/V$(PKG_VERSION)/$(PKG_ARCH)?
UNPACK_CMD=$(CP) $(DL_DIR)/$(PKG_SOURCE) $(PKG_BUILD_DIR)/$(PKG_NAME)

PKG_LICENSE:=AGPL-3.0-only
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=kkstone <kkstone@isakura.top>

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Compression
  TITLE:=File archiver with a high compression ratio
  URL:=https://7-zip.org/
  DEPENDS:=@(aarch64||arm||i386||x86_64)
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/bin
        $(LN) 7zz $(1)/usr/bin/7z
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
