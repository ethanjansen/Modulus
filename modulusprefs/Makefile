TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ModulusPrefs

ModulusPrefs_FILES = $(wildcard *.m)
ModulusPrefs_FRAMEWORKS = UIKit
ModulusPrefs_PRIVATE_FRAMEWORKS = Preferences
ModulusPrefs_INSTALL_PATH = /Library/PreferenceBundles
ModulusPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
