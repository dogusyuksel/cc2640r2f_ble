REPO_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

TI_ROOT ?= $(REPO_ROOT)/thirdparty/ti_cc2640r2f_sdk
CCS_PATH ?= $(TI_ROOT)/ccs1281
APP_PATH ?= $(REPO_ROOT)/firmware/ble5_simple_peripheral_cc2640r2lp_app
STACK_LIBRARY_PATH ?= $(REPO_ROOT)/firmware/ble5_simple_peripheral_cc2640r2lp_stack_library
XDCTOOLS_JAVA_HOME ?= /usr/lib/jvm/default-java

APP_BUILD_DIR := $(APP_PATH)/FlashROM_StackLibrary
STACK_BUILD_DIR := $(STACK_LIBRARY_PATH)/FlashROM_Library

export CCS_PATH
export REPO_ROOT
export APP_PATH
export STACK_LIBRARY_PATH
export XDCTOOLS_JAVA_HOME

.PHONY: all firmware stack-library rebuild-fw clean clean-fw clean-stack-library show-paths

all: firmware

firmware: stack-library
	$(MAKE) -C "$(APP_BUILD_DIR)" all

stack-library:
	$(MAKE) -C "$(STACK_BUILD_DIR)" all

rebuild-fw: clean-fw firmware

clean: clean-fw

clean-fw:
	$(MAKE) -C "$(APP_BUILD_DIR)" clean

clean-stack-library:
	$(MAKE) -C "$(STACK_BUILD_DIR)" clean

show-paths:
	@echo "REPO_ROOT=$(REPO_ROOT)"
	@echo "CCS_PATH=$(CCS_PATH)"
	@echo "APP_PATH=$(APP_PATH)"
	@echo "STACK_LIBRARY_PATH=$(STACK_LIBRARY_PATH)"
	@echo "XDCTOOLS_JAVA_HOME=$(XDCTOOLS_JAVA_HOME)"
