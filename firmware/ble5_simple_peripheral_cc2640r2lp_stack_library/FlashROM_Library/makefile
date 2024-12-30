
CG_TOOL_ROOT := $(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS

GEN_OPTS__FLAG := 
GEN_CMDS__FLAG := 

ORDERED_OBJS += \
$(OBJS) \

-include ../makefile.init

RM := rm -rf
RMDIR := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include HAL/Common/subdir_rules.mk
-include HAL/Target/CC2650/Drivers/subdir_rules.mk
-include HAL/Target/CC2650/_common/subdir_rules.mk
-include Host/subdir_rules.mk
-include ICallBLE/subdir_rules.mk
-include NPI/subdir_rules.mk
-include OSAL/subdir_rules.mk
-include PROFILES/subdir_rules.mk
-include ROM/subdir_rules.mk
-include Startup/subdir_rules.mk
-include TOOLS/subdir_rules.mk
-include TOOLS/defines/subdir_rules.mk
-include objects.mk

OPT_SRCS += \
../TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_stack_library_FlashROM_Library.opt

OBJS += \
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

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
LIB_OUTPUTS += \
ble5_simple_peripheral_cc2640r2lp_stack_library.lib 

LIB_OUTPUTS__QUOTED += \
"ble5_simple_peripheral_cc2640r2lp_stack_library.lib" 


# All Target
all:
	@$(MAKE) --no-print-directory pre-build
	@$(MAKE) --no-print-directory main-build

# Main-build Target
main-build: ble5_simple_peripheral_cc2640r2lp_stack_library.lib

# Tool invocations
ble5_simple_peripheral_cc2640r2lp_stack_library.lib: $(OBJS)
ifneq ($(strip $(ORDERED_OBJS)),)
	@echo 'Building target: "$@"'
	@echo 'Invoking: Arm Archiver'
	"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armar" r "ble5_simple_peripheral_cc2640r2lp_stack_library.lib" $(ORDERED_OBJS)
	@echo 'Finished building target: "$@"'
	@echo ' '
endif

# Other Targets
clean:
	-$(RM) $(LIB_OUTPUTS__QUOTED)
	-$(RM) "HAL/Common/hal_assert.obj" "HAL/Target/CC2650/Drivers/hal_flash_wrapper.obj" "HAL/Target/CC2650/Drivers/hal_rtc_wrapper.obj" "HAL/Target/CC2650/Drivers/hal_trng_wrapper.obj" "HAL/Target/CC2650/_common/mb_patch.obj" "Host/gatt_uuid.obj" "ICallBLE/ble_dispatch_JT.obj" "ICallBLE/ble_dispatch_lite.obj" "ICallBLE/icall_lite_translation.obj" "NPI/npi.obj" "OSAL/osal.obj" "OSAL/osal_bufmgr.obj" "OSAL/osal_cbtimer.obj" "OSAL/osal_clock.obj" "OSAL/osal_list.obj" "OSAL/osal_memory_icall.obj" "OSAL/osal_pwrmgr.obj" "OSAL/osal_snv_wrapper.obj" "OSAL/osal_timers.obj" "PROFILES/gap.obj" "PROFILES/gapbondmgr.obj" "PROFILES/gattservapp_util.obj" "PROFILES/sm_ecc.obj" "ROM/common_rom_init.obj" "ROM/rom_init.obj" "Startup/ble_user_config.obj" "Startup/icall_startup.obj" "Startup/osal_icall_ble.obj" "TOOLS/onboard.obj" 
	-$(RM) "HAL/Common/hal_assert.d" "HAL/Target/CC2650/Drivers/hal_flash_wrapper.d" "HAL/Target/CC2650/Drivers/hal_rtc_wrapper.d" "HAL/Target/CC2650/Drivers/hal_trng_wrapper.d" "HAL/Target/CC2650/_common/mb_patch.d" "Host/gatt_uuid.d" "ICallBLE/ble_dispatch_JT.d" "ICallBLE/ble_dispatch_lite.d" "ICallBLE/icall_lite_translation.d" "NPI/npi.d" "OSAL/osal.d" "OSAL/osal_bufmgr.d" "OSAL/osal_cbtimer.d" "OSAL/osal_clock.d" "OSAL/osal_list.d" "OSAL/osal_memory_icall.d" "OSAL/osal_pwrmgr.d" "OSAL/osal_snv_wrapper.d" "OSAL/osal_timers.d" "PROFILES/gap.d" "PROFILES/gapbondmgr.d" "PROFILES/gattservapp_util.d" "PROFILES/sm_ecc.d" "ROM/common_rom_init.d" "ROM/rom_init.d" "Startup/ble_user_config.d" "Startup/icall_startup.d" "Startup/osal_icall_ble.d" "TOOLS/onboard.d" 
	-@echo 'Finished clean'
	-@echo ' '

pre-build:
	-$(TI_SDK_PATH)/source/ti/ble5stack/../../../tools/ble5stack/lib_search/lib_search    --opt /workspace/firmware/ble5_simple_peripheral_cc2640r2lp_stack_library/TOOLS/build_config.opt    --lib-dir $(TI_SDK_PATH)/source/ti/ble5stack/blelib/cc26x0r2    --cmd /workspace/firmware/ble5_simple_peripheral_cc2640r2lp_stack_library/FlashROM_Library/lib_linker.cmd    --xml $(TI_SDK_PATH)/source/ti/ble5stack/../../../tools/ble5stack/lib_search/lib_search.xml    --sym-dir $(TI_SDK_PATH)/source/ti/ble5stack/symbols/cc26x0r2
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets

