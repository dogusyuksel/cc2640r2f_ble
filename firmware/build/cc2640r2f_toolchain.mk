REPO_ROOT ?= $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/../..)
TI_ROOT ?= $(REPO_ROOT)/thirdparty/ti_cc2640r2f_sdk
CCS_PATH ?= $(TI_ROOT)/ccs1281
override APP_PATH := $(REPO_ROOT)/firmware/app
override STACK_LIBRARY_PATH := $(REPO_ROOT)/firmware/stack
XDCTOOLS_JAVA_HOME ?= /usr/lib/jvm/default-java
export XDCTOOLS_JAVA_HOME

TI_ARM_CGT ?= $(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS
override VENDORED_SDK_PATH := $(REPO_ROOT)/firmware/vendor/ti_cc2640r2
VENDORED_BLESTACK := $(VENDORED_SDK_PATH)/source/ti/ble5stack
VENDORED_DEVICES := $(VENDORED_SDK_PATH)/source/ti/devices
XDC_PACKAGE_PATH ?= $(VENDORED_SDK_PATH)/source;$(VENDORED_SDK_PATH)/kernel/tirtos/packages;$(VENDORED_BLESTACK)

ARMCL := "$(TI_ARM_CGT)/bin/armcl"
ARMAR := "$(TI_ARM_CGT)/bin/armar"
ARMHEX := "$(TI_ARM_CGT)/bin/armhex"
XDC_XS := "$(CCS_PATH)/xdctools_3_62_01_16_core/xs"

BLE_CONFIG_CMD_FILES := \
	--cmd_file="$(VENDORED_BLESTACK)/config/build_components.opt" \
	--cmd_file="$(VENDORED_BLESTACK)/config/factory_config.opt" \
	--cmd_file="$(STACK_LIBRARY_PATH)/TOOLS/build_config.opt"

CC2640_CPU_FLAGS := \
	-mv7M3 \
	--code_state=16 \
	-me \
	-O4 \
	--opt_for_speed=0

CC2640_COMMON_FLAGS := \
	$(CC2640_CPU_FLAGS) \
	--define=DeviceFamily_CC26X0R2 \
	-g \
	--c99 \
	--gcc \
	--diag_warning=225 \
	--diag_suppress=48 \
	--diag_wrap=off \
	--display_error_number \
	--gen_func_subsections=on \
	--abi=eabi
