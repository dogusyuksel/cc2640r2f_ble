################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
build-1103652863:
	@$(MAKE) --no-print-directory -Onone -f TOOLS/subdir_rules.mk build-1103652863-inproc

build-1103652863-inproc: ../TOOLS/app_ble.cfg
	@echo 'Building file: "$<"'
	@echo 'Invoking: XDCtools'
	"/workspace/ti_cc2640r2f_sdk/ccs1281/xdctools_3_62_01_16_core/xs" --xdcpath="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source;/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/kernel/tirtos/packages;/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack;" xdc.tools.configuro -o configPkg -t ti.targets.arm.elf.M3 -p ti.platforms.simplelink:CC2640R2F -r release -c "/workspace/ti_cc2640r2f_sdk/ccs1281/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS" --compileOptions "-mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path=\"/workspace/ble5_simple_peripheral_cc2640r2lp_app\" --include_path=\"/workspace/ble5_simple_peripheral_cc2640r2lp_app/Application\" --include_path=\"/workspace/ble5_simple_peripheral_cc2640r2lp_app/Startup\" --include_path=\"/workspace/ble5_simple_peripheral_cc2640r2lp_app/PROFILES\" --include_path=\"/workspace/ble5_simple_peripheral_cc2640r2lp_app/Include\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/controller/cc26xx/inc\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/inc\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/rom\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/common/cc26xx\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/inc\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/target\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common/cc26xx\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/inc\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/heapmgr\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/src/inc\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/osal/src/inc\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/saddr\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/sdata\" --include_path=\"/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/devices/cc26x0r2\" --include_path=\"/workspace/ti_cc2640r2f_sdk/ccs1281/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include\" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi " "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

configPkg/linker.cmd: build-1103652863 ../TOOLS/app_ble.cfg
configPkg/compiler.opt: build-1103652863
configPkg: build-1103652863


