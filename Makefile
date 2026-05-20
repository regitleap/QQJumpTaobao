ARCHS = arm64 arm64e
TARGET = iphone:clang:15.0:14.0
INSTALL_TARGET_PROCESSES = QQ Tim

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = QQJumpTaobao

QQJumpTaobao_FILES = Tweak.x
QQJumpTaobao_CFLAGS = -fobjc-arc -Wall
QQJumpTaobao_FRAMEWORKS = UIKit WebKit CoreServices

include $(THEOS)/makefiles/common.mk
