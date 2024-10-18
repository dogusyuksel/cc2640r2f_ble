################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
Startup/board.obj: /workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/target/board.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"/workspace/ti_cc2640r2f_sdk/ccs1281/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file="/workspace/ble5_simple_peripheral_cc2640r2lp_app/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/config/build_components.opt" --cmd_file="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/config/factory_config.opt" --cmd_file="/workspace/ble5_simple_peripheral_cc2640r2lp_stack_library/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Application" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Startup" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/PROFILES" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Include" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/controller/cc26xx/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/rom" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/common/cc26xx" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/target" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/heapmgr" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/osal/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/saddr" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/sdata" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/devices/cc26x0r2" --include_path="/workspace/ti_cc2640r2f_sdk/ccs1281/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="Startup/$(basename $(<F)).d_raw" --obj_directory="Startup" $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '

Startup/%.obj: ../Startup/%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"/workspace/ti_cc2640r2f_sdk/ccs1281/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file="/workspace/ble5_simple_peripheral_cc2640r2lp_app/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/config/build_components.opt" --cmd_file="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/config/factory_config.opt" --cmd_file="/workspace/ble5_simple_peripheral_cc2640r2lp_stack_library/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Application" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Startup" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/PROFILES" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Include" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/controller/cc26xx/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/rom" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/common/cc26xx" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/target" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/heapmgr" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/osal/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/saddr" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/sdata" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/devices/cc26x0r2" --include_path="/workspace/ti_cc2640r2f_sdk/ccs1281/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="Startup/$(basename $(<F)).d_raw" --obj_directory="Startup" $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '


