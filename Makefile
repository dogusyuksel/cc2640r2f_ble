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
XDC_XS := $(CCS_PATH)/xdctools_3_62_01_16_core/xs
XDC_PACKAGE_PATH := $(VENDORED_SDK_PATH)/source;$(VENDORED_SDK_PATH)/kernel/tirtos/packages;$(VENDORED_SDK_PATH)/source/ti/ble5stack

REQUIRED_FW_FILES := \
	$(TI_ARM_CGT)/bin/armcl \
	$(TI_ARM_CGT)/bin/armar \
	$(TI_ARM_CGT)/bin/armhex \
	$(XDC_XS) \
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
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/package.xdc \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/package.xs \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/ITarget.xdc \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/ITarget.xs \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/package/ti_targets.class \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/elf/M3.xdc \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/elf/IArm.xs \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/elf/package.xs \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/elf/package/ti_targets_arm_elf.class \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/rtsarm/Settings.xdc \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/rtsarm/package.xs \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/rtsarm/lib/ti.targets.arm.rtsarm.aem3 \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/sysbios/rom/cortexm/cc26xx/r2/golden/CC26xx/rom_sysbios_config.obj \
	$(VENDORED_SDK_PATH)/tools/ble5stack/lib_search/lib_search \
	$(VENDORED_SDK_PATH)/tools/ble5stack/lib_search/lib_search.py

export CCS_PATH
export REPO_ROOT
export APP_PATH
export STACK_LIBRARY_PATH
export XDCTOOLS_JAVA_HOME
export XDC_PACKAGE_PATH

.PHONY: all check-fw-deps diagnose-fw-xdc firmware stack-library rebuild-fw clean clean-fw clean-stack-library show-paths

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
	if [ "$$missing" -eq 0 ]; then \
		probe=$$(mktemp /tmp/cc2640r2-xdc.XXXXXX.xs); \
		printf '%s\n' 'xdc.module("ti.targets.arm.elf.M3");' 'print("resolved ti.targets.arm.elf.M3");' > "$$probe"; \
		if ! "$(XDC_XS)" --xdcpath="$(XDC_PACKAGE_PATH)" -f "$$probe" >/dev/null 2>&1; then \
			echo "Firmware XDC target package cannot be resolved: ti.targets.arm.elf.M3"; \
			echo "XDC path: $(XDC_PACKAGE_PATH)"; \
			missing=1; \
		fi; \
		rm -f "$$probe"; \
	fi; \
	if [ "$$missing" -ne 0 ]; then \
		echo "Run: git submodule update --init --recursive"; \
		exit 1; \
	fi

diagnose-fw-xdc:
	@echo "REPO_ROOT=$(REPO_ROOT)"
	@echo "CCS_PATH=$(CCS_PATH)"
	@echo "TI_ARM_CGT=$(TI_ARM_CGT)"
	@echo "XDC_XS=$(XDC_XS)"
	@echo "XDC_PACKAGE_PATH=$(XDC_PACKAGE_PATH)"
	@echo "XDCTOOLS_JAVA_HOME=$(XDCTOOLS_JAVA_HOME)"
	@echo
	@echo "app configuro command:"
	@grep -n -- '--xdcpath' "$(REPO_ROOT)/firmware/build/cc2640r2f_app.mk" || true
	@echo
	@echo "required XDC target package files:"
	@missing=0; \
	for file in \
		"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/package.xdc" \
		"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/package.xs" \
		"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/ITarget.xs" \
		"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/package/ti_targets.class" \
		"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/elf/package.xdc" \
		"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/elf/package.xs" \
		"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/elf/IArm.xs" \
		"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/elf/M3.xdc" \
		"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/elf/package/ti_targets_arm_elf.class" \
		"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/rtsarm/Settings.xdc" \
		"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/rtsarm/package.xs" \
		"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/targets/arm/rtsarm/lib/ti.targets.arm.rtsarm.aem3" \
		"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/sysbios/rom/cortexm/cc26xx/r2/golden/CC26xx/rom_sysbios_config.obj"; do \
		if [ -e "$$file" ]; then \
			ls -l "$$file"; \
		else \
			echo "MISSING $$file"; \
			missing=1; \
		fi; \
	done; \
	if [ "$$missing" -ne 0 ]; then exit 1; fi
	@echo
	@echo "XDC target resolve:"
	@probe=$$(mktemp /tmp/cc2640r2-xdc.XXXXXX.xs); \
	printf '%s\n' 'xdc.module("ti.targets.arm.elf.M3");' 'print("resolved ti.targets.arm.elf.M3");' > "$$probe"; \
	"$(XDC_XS)" --xdcpath="$(XDC_PACKAGE_PATH)" -f "$$probe"; \
	status=$$?; \
	rm -f "$$probe"; \
	exit $$status

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
