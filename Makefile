INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = armv7 arm64 arm64e
TARGET = iphone:clang::7.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Stonks

Stonks_FILES = Tweak.x
Stonks_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
