
CG_TOOL_ROOT := $(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS

GEN_OPTS__FLAG := --cmd_file="configPkg/compiler.opt" 
GEN_CMDS__FLAG := -l"configPkg/linker.cmd" 

ORDERED_OBJS += \
$(OBJS) \
$(GEN_CMDS__FLAG) \
-l"$(TI_SDK_PATH)/source/ti/devices/cc26x0r2/driverlib/bin/ccs/driverlib.lib" \
-l"$(TI_SDK_PATH)/kernel/tirtos/packages/ti/dpl/lib/dpl_cc26x0r2.aem3" \
-l"$(TI_SDK_PATH)/source/ti/drivers/lib/drivers_cc26x0r2.aem3" \
-l"$(TI_SDK_PATH)/source/ti/drivers/rf/lib/rf_singleMode_cc26x0r2.aem3" \
-l"$(TI_SDK_PATH)/source/ti/display/lib/display.aem3" \
-l"$(TI_SDK_PATH)/source/ti/grlib/lib/ccs/m3/grlib.a" \
-l"/workspace/ble5_simple_peripheral_cc2640r2lp_stack_library/FlashROM_Library/ble_r2.symbols" \
-l"/workspace/ble5_simple_peripheral_cc2640r2lp_stack_library/FlashROM_Library/lib_linker.cmd" \
-l"/workspace/ble5_simple_peripheral_cc2640r2lp_stack_library/FlashROM_Library/ble5_simple_peripheral_cc2640r2lp_stack_library.lib" \
-l"$(TI_SDK_PATH)/source/ti/ble5stack/common/cc26xx/ccs/cc26xx_app.cmd" \
-llibc.a \

-include ../makefile.init

RM := rm -rf
RMDIR := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include Application/subdir_vars.mk
-include Drivers/ECC/subdir_vars.mk
-include Drivers/TRNG/subdir_vars.mk
-include ICall/subdir_vars.mk
-include ICallBLE/subdir_vars.mk
-include PROFILES/subdir_vars.mk
-include Startup/subdir_vars.mk
-include TOOLS/subdir_vars.mk
-include TOOLS/defines/subdir_vars.mk
-include Application/subdir_rules.mk
-include Drivers/ECC/subdir_rules.mk
-include Drivers/TRNG/subdir_rules.mk
-include ICall/subdir_rules.mk
-include ICallBLE/subdir_rules.mk
-include PROFILES/subdir_rules.mk
-include Startup/subdir_rules.mk
-include TOOLS/subdir_rules.mk
-include TOOLS/defines/subdir_rules.mk
-include objects.mk

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
EXE_OUTPUTS += \
ble5_simple_peripheral_cc2640r2lp_app.out 

EXE_OUTPUTS__QUOTED += \
"ble5_simple_peripheral_cc2640r2lp_app.out" 


# All Target
all: linting all_original

all_original: $(OBJS) $(CMD_SRCS) $(GEN_CMDS)
	@$(MAKE) --no-print-directory -Onone "ble5_simple_peripheral_cc2640r2lp_app.out"

dependents:
	-cd /workspace/ble5_simple_peripheral_cc2640r2lp_stack_library/FlashROM_Library && $(MAKE) clean all

# Tool invocations
ble5_simple_peripheral_cc2640r2lp_app.out: $(OBJS) $(CMD_SRCS) $(GEN_CMDS) /workspace/ble5_simple_peripheral_cc2640r2lp_stack_library/FlashROM_Library/ble5_simple_peripheral_cc2640r2lp_stack_library.lib
	@echo 'Building target: "$@"'
	@echo 'Invoking: Arm Linker'
	"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file="/workspace/ble5_simple_peripheral_cc2640r2lp_app/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/build_components.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/factory_config.opt" --cmd_file="/workspace/ble5_simple_peripheral_cc2640r2lp_stack_library/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi -z -m"ble5_simple_peripheral_cc2640r2lp_app.map" --heap_size=0 --stack_size=256 -i"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/lib" -i"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --reread_libs --define=CC26X0ROM=2 --diag_suppress=16002-D --diag_suppress=10247-D --diag_suppress=10325-D --diag_suppress=10229-D --diag_suppress=16032-D --diag_wrap=off --display_error_number --warn_sections --xml_link_info="ble5_simple_peripheral_cc2640r2lp_app_linkInfo.xml" --rom_model -o "ble5_simple_peripheral_cc2640r2lp_app.out" $(ORDERED_OBJS)
	@echo 'Finished building target: "$@"'
	@echo ' '
	@$(MAKE) --no-print-directory post-build

# Other Targets
clean:
	../clean.sh
	-@echo 'Finished clean'
	-@echo ' '

linting:
	../../linting/format_check.sh ../
	-@echo 'Finished linting'
	-@echo ' '

post-build:
	-$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armhex -order MS --memwidth=8 --romwidth=8 --intel -o ble5_simple_peripheral_cc2640r2lp_app.hex ble5_simple_peripheral_cc2640r2lp_app.out
	-@echo ' '

.PHONY: all clean dependents linting
.SECONDARY:
/workspace/ble5_simple_peripheral_cc2640r2lp_stack_library/FlashROM_Library/ble5_simple_peripheral_cc2640r2lp_stack_library.lib:

-include ../makefile.targets

