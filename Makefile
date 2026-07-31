REPO_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

TI_ROOT ?= $(REPO_ROOT)/thirdparty/ti_cc2640r2f_sdk
CCS_PATH ?= $(TI_ROOT)/ccs1281
APP_PATH ?= $(REPO_ROOT)/firmware/ble5_simple_peripheral_cc2640r2lp_app
STACK_LIBRARY_PATH ?= $(REPO_ROOT)/firmware/ble5_simple_peripheral_cc2640r2lp_stack_library
XDCTOOLS_JAVA_HOME ?= /usr/lib/jvm/default-java

APP_BUILD_DIR := $(APP_PATH)/FlashROM_StackLibrary
STACK_BUILD_DIR := $(STACK_LIBRARY_PATH)/FlashROM_Library
TI_ARM_CGT := $(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS
VENDORED_SDK_PATH := $(REPO_ROOT)/firmware/vendor/simplelink_cc2640r2_sdk_5_30_01_11

REQUIRED_FW_FILES := \
	$(TI_ARM_CGT)/bin/armcl \
	$(TI_ARM_CGT)/bin/armar \
	$(TI_ARM_CGT)/bin/armhex \
	$(CCS_PATH)/xdctools_3_62_01_16_core/xs \
	$(VENDORED_SDK_PATH)/source/ti/devices/cc26x0r2/driverlib/bin/ccs/driverlib.lib \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/dpl/lib/dpl_cc26x0r2.aem3 \
	$(VENDORED_SDK_PATH)/source/ti/drivers/lib/drivers_cc26x0r2.aem3 \
	$(VENDORED_SDK_PATH)/source/ti/drivers/rf/lib/rf_singleMode_cc26x0r2.aem3 \
	$(VENDORED_SDK_PATH)/source/ti/grlib/lib/ccs/m3/grlib.a \
	$(VENDORED_SDK_PATH)/source/ti/ble5stack/blelib/cc26x0r2/ctrl/hci_pxxx.a \
	$(VENDORED_SDK_PATH)/source/ti/ble5stack/blelib/cc26x0r2/ctrl/ll_pxxx.a \
	$(VENDORED_SDK_PATH)/source/ti/ble5stack/blelib/cc26x0r2/hci_tl/hci_tl_none.a \
	$(VENDORED_SDK_PATH)/source/ti/ble5stack/blelib/cc26x0r2/host/att_pxxx.a \
	$(VENDORED_SDK_PATH)/source/ti/ble5stack/blelib/cc26x0r2/host/gap_pxxx.a \
	$(VENDORED_SDK_PATH)/source/ti/ble5stack/blelib/cc26x0r2/host/gatt_pxxx.a \
	$(VENDORED_SDK_PATH)/source/ti/ble5stack/blelib/cc26x0r2/host/l2cap_pxxx.a \
	$(VENDORED_SDK_PATH)/source/ti/ble5stack/blelib/cc26x0r2/host/profiles_pxxx.a \
	$(VENDORED_SDK_PATH)/source/ti/ble5stack/blelib/cc26x0r2/host/smp_pxxx.a \
	$(VENDORED_SDK_PATH)/source/ti/ble5stack/blelib/cc26x0r2/host/sm_pxxx.a \
	$(VENDORED_SDK_PATH)/source/ti/ble5stack/symbols/cc26x0r2/pxxx.symbols \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/elf/M3.xdc \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/elf/package/ti_targets_arm_elf.class \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/rtsarm/Settings.xdc \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/rtsarm/lib/ti.targets.arm.rtsarm.aem3 \
	$(VENDORED_SDK_PATH)/tools/ble5stack/lib_search/lib_search \
	$(VENDORED_SDK_PATH)/tools/ble5stack/lib_search/lib_search.py

export CCS_PATH
export REPO_ROOT
export APP_PATH
export STACK_LIBRARY_PATH
export XDCTOOLS_JAVA_HOME

.PHONY: all check-fw-deps firmware stack-library rebuild-fw clean clean-fw clean-stack-library show-paths

all: firmware

check-fw-deps:
	@missing=0; \
	for file in $(REQUIRED_FW_FILES); do \
		if [ ! -e "$$file" ]; then \
			echo "Missing firmware dependency: $$file"; \
			missing=1; \
		fi; \
	done; \
	for tool in "$(TI_ARM_CGT)/bin/armcl" "$(TI_ARM_CGT)/bin/armar" "$(TI_ARM_CGT)/bin/armhex" "$(CCS_PATH)/xdctools_3_62_01_16_core/xs" "$(VENDORED_SDK_PATH)/tools/ble5stack/lib_search/lib_search"; do \
		if [ -e "$$tool" ] && [ ! -x "$$tool" ]; then \
			echo "Firmware tool is not executable: $$tool"; \
			missing=1; \
		fi; \
	done; \
	if [ "$$missing" -ne 0 ]; then \
		echo "Run: git submodule update --init --recursive"; \
		exit 1; \
	fi

firmware: check-fw-deps stack-library
	$(MAKE) -C "$(APP_BUILD_DIR)" all

stack-library: check-fw-deps
	$(MAKE) -C "$(STACK_BUILD_DIR)" all

rebuild-fw: clean-fw clean-stack-library firmware

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
