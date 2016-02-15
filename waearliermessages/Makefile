ARCHS = armv7 arm64
include theos/makefiles/common.mk



BUNDLE_NAME = WAEarlierMessages
WAEarlierMessages_FILES = WAEarlierMessages.mm
WAEarlierMessages_INSTALL_PATH = /Library/PreferenceBundles
WAEarlierMessages_FRAMEWORKS = UIKit
WAEarlierMessages_PRIVATE_FRAMEWORKS = Preferences
WAEarlierMessages_CFLAGS = -Wno-error
include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/WAEarlierMessages.plist$(ECHO_END)
