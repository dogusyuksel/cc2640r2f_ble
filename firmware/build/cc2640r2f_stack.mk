include $(dir $(lastword $(MAKEFILE_LIST)))cc2640r2f_toolchain.mk

PYTHON ?= python3
LIB_SEARCH := $(PYTHON) $(VENDORED_SDK_PATH)/tools/ble5stack/lib_search/lib_search.py

STACK_OUTPUT := ble5_simple_peripheral_cc2640r2lp_stack_library.lib

STACK_CMD_FILES := \
	--cmd_file="$(STACK_LIBRARY_PATH)/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_stack_library_FlashROM_Library.opt" \
	$(BLE_CONFIG_CMD_FILES)

STACK_COMMON_FLAGS := $(CC2640_COMMON_FLAGS)

STACK_LOCAL_INCLUDE_DIRS := \
	$(STACK_LIBRARY_PATH)

STACK_BLESTACK_INCLUDE_DIRS := \
	$(VENDORED_BLESTACK)/controller/cc26xx/inc \
	$(VENDORED_BLESTACK)/inc \
	$(VENDORED_BLESTACK)/rom \
	$(VENDORED_BLESTACK)/common/cc26xx \
	$(VENDORED_BLESTACK)/common/cc26xx/npi/stack \
	$(VENDORED_BLESTACK)/icall/inc \
	$(VENDORED_BLESTACK)/hal/src/target/_common \
	$(VENDORED_BLESTACK)/hal/src/target/_common/cc26xx \
	$(VENDORED_BLESTACK)/hal/src/target \
	$(VENDORED_BLESTACK)/hal/src/inc \
	$(VENDORED_BLESTACK)/icall/src \
	$(VENDORED_BLESTACK)/icall/src/inc \
	$(VENDORED_BLESTACK)/osal/src/common \
	$(VENDORED_BLESTACK)/npi/src \
	$(VENDORED_BLESTACK)/osal/src/inc \
	$(VENDORED_BLESTACK)/services/src/aes/cc26xx \
	$(VENDORED_BLESTACK)/services/src/nv/cc26xx \
	$(VENDORED_BLESTACK)/services/src/nv \
	$(VENDORED_BLESTACK)/services/src/saddr

STACK_SDK_INCLUDE_DIRS := \
	$(VENDORED_DEVICES)/cc26x0r2 \
	$(VENDORED_DEVICES)/cc26x0r2/inc \
	$(VENDORED_SDK_PATH)/source \
	$(VENDORED_SDK_PATH)/kernel/tirtos/packages \
	$(CCS_PATH)/xdctools_3_62_01_16_core/packages \
	$(TI_ARM_CGT)/include

STACK_INCLUDE_DIRS := \
	$(STACK_LOCAL_INCLUDE_DIRS) \
	$(STACK_BLESTACK_INCLUDE_DIRS) \
	$(STACK_SDK_INCLUDE_DIRS)

STACK_INCLUDE_FLAGS := $(addprefix --include_path=,$(STACK_INCLUDE_DIRS))
STACK_COMPILE_FLAGS := $(STACK_CMD_FILES) $(STACK_COMMON_FLAGS) $(STACK_INCLUDE_FLAGS)

STACK_OBJECTS := \
	./OSAL/osal.obj \
	./OSAL/osal_bufmgr.obj \
	./OSAL/osal_cbtimer.obj \
	./OSAL/osal_clock.obj \
	./OSAL/osal_list.obj \
	./OSAL/osal_memory_icall.obj \
	./OSAL/osal_pwrmgr.obj \
	./OSAL/osal_snv_wrapper.obj \
	./OSAL/osal_timers.obj \
	./PROFILES/gap.obj \
	./PROFILES/gapbondmgr.obj \
	./PROFILES/gattservapp_util.obj \
	./PROFILES/sm_ecc.obj \
	./TOOLS/onboard.obj \
	./ROM/common_rom_init.obj \
	./ROM/rom_init.obj \
	./Startup/ble_user_config.obj \
	./Startup/icall_startup.obj \
	./Startup/osal_icall_ble.obj \
	./ICallBLE/ble_dispatch_JT.obj \
	./ICallBLE/ble_dispatch_lite.obj \
	./ICallBLE/icall_lite_translation.obj \
	./Host/gatt_uuid.obj \
	./HAL/Common/hal_assert.obj \
	./HAL/Target/CC2650/Drivers/hal_flash_wrapper.obj \
	./HAL/Target/CC2650/Drivers/hal_rtc_wrapper.obj \
	./HAL/Target/CC2650/Drivers/hal_trng_wrapper.obj \
	./HAL/Target/CC2650/_common/mb_patch.obj \
	./NPI/npi.obj

STACK_DEP_FILES := $(patsubst %.obj,%.d,$(STACK_OBJECTS)) $(patsubst %.obj,%.d_raw,$(STACK_OBJECTS))

define COMPILE_STACK_C
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	@mkdir -p "$(@D)"
	$(ARMCL) $(STACK_COMPILE_FLAGS) --preproc_with_compile --preproc_dependency="$(@D)/$(basename $(<F)).d_raw" --obj_directory="$(@D)" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: "$<"'
	@echo ' '
endef

HAL/Common/hal_assert.obj: $(VENDORED_BLESTACK)/hal/src/common/hal_assert.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

HAL/Target/CC2650/Drivers/hal_flash_wrapper.obj: $(VENDORED_BLESTACK)/hal/src/target/_common/hal_flash_wrapper.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

HAL/Target/CC2650/Drivers/hal_rtc_wrapper.obj: $(VENDORED_BLESTACK)/hal/src/target/_common/hal_rtc_wrapper.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

HAL/Target/CC2650/Drivers/hal_trng_wrapper.obj: $(VENDORED_BLESTACK)/hal/src/target/_common/hal_trng_wrapper.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

HAL/Target/CC2650/_common/mb_patch.obj: $(VENDORED_BLESTACK)/hal/src/target/_common/cc26xx/mb_patch.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

Host/gatt_uuid.obj: $(VENDORED_BLESTACK)/host/gatt_uuid.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

ICallBLE/ble_dispatch_JT.obj: $(VENDORED_BLESTACK)/icall/stack/ble_dispatch_JT.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

ICallBLE/ble_dispatch_lite.obj: $(VENDORED_BLESTACK)/icall/stack/ble_dispatch_lite.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

ICallBLE/icall_lite_translation.obj: $(VENDORED_BLESTACK)/icall/src/icall_lite_translation.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

NPI/npi.obj: $(VENDORED_BLESTACK)/common/cc26xx/npi/stack/npi.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

OSAL/osal.obj: $(VENDORED_BLESTACK)/osal/src/common/osal.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

OSAL/osal_bufmgr.obj: $(VENDORED_BLESTACK)/osal/src/common/osal_bufmgr.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

OSAL/osal_cbtimer.obj: $(VENDORED_BLESTACK)/osal/src/common/osal_cbtimer.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

OSAL/osal_clock.obj: $(VENDORED_BLESTACK)/osal/src/common/osal_clock.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

OSAL/osal_list.obj: $(VENDORED_BLESTACK)/osal/src/common/osal_list.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

OSAL/osal_memory_icall.obj: $(VENDORED_BLESTACK)/osal/src/common/osal_memory_icall.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

OSAL/osal_pwrmgr.obj: $(VENDORED_BLESTACK)/osal/src/common/osal_pwrmgr.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

OSAL/osal_snv_wrapper.obj: $(VENDORED_BLESTACK)/osal/src/mcu/cc26xx/osal_snv_wrapper.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

OSAL/osal_timers.obj: $(VENDORED_BLESTACK)/osal/src/common/osal_timers.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

PROFILES/gap.obj: $(VENDORED_BLESTACK)/host/gap.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

PROFILES/gapbondmgr.obj: $(VENDORED_BLESTACK)/host/gapbondmgr.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

PROFILES/gattservapp_util.obj: $(VENDORED_BLESTACK)/host/gattservapp_util.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

PROFILES/sm_ecc.obj: $(VENDORED_BLESTACK)/host/sm_ecc.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

ROM/common_rom_init.obj: $(VENDORED_BLESTACK)/rom/r2/common_rom_init.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

ROM/rom_init.obj: $(VENDORED_BLESTACK)/rom/r2/rom_init.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

Startup/ble_user_config.obj: $(VENDORED_BLESTACK)/icall/stack/ble_user_config.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

Startup/icall_startup.obj: $(VENDORED_BLESTACK)/common/cc26xx/icall_startup.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

Startup/osal_icall_ble.obj: $(STACK_LIBRARY_PATH)/Startup/osal_icall_ble.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)

TOOLS/onboard.obj: $(VENDORED_BLESTACK)/common/cc26xx/onboard.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_STACK_C)
