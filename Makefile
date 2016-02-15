ARCHS = armv7 arm64
include theos/makefiles/common.mk


TWEAK_NAME = WAEarlierMessages
WAEarlierMessages_FILES =  UIAlert+Blocks.m Tweak.xm
WAEarlierMessages_FRAMEWORKS = UIKit Social Accounts Twitter
WAEarlierMessages_CFLAGS = -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WhatsApp"

SUBPROJECTS += waearliermessages
include $(THEOS_MAKE_PATH)/aggregate.mk
