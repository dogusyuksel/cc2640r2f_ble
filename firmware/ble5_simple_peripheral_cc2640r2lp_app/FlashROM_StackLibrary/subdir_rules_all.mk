
%.obj: ../Application/%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file=$(APP_PATH)"/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/build_components.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/factory_config.opt" --cmd_file=$(STACK_LIBRARY_PATH)"/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path=$(APP_PATH) --include_path=$(APP_PATH)"/Application" --include_path=$(APP_PATH)"/Startup" --include_path=$(APP_PATH)"/PROFILES" --include_path=$(APP_PATH)"/Include" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/controller/cc26xx/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/rom" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/target" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/heapmgr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/osal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/saddr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/sdata" --include_path="$(TI_SDK_PATH)/source/ti/devices/cc26x0r2" --include_path="$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" --obj_directory="./" $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '

%.obj: ../PROFILES/%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file=$(APP_PATH)"/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/build_components.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/factory_config.opt" --cmd_file=$(STACK_LIBRARY_PATH)"/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path=$(APP_PATH) --include_path=$(APP_PATH)"/Application" --include_path=$(APP_PATH)"/Startup" --include_path=$(APP_PATH)"/PROFILES" --include_path=$(APP_PATH)"/Include" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/controller/cc26xx/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/rom" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/target" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/heapmgr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/osal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/saddr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/sdata" --include_path="$(TI_SDK_PATH)/source/ti/devices/cc26x0r2" --include_path="$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" --obj_directory="./" $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '

ECCROMCC26XX.obj: $(TI_SDK_PATH)/source/ti/ble5stack/common/cc26xx/ecc/ECCROMCC26XX.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file=$(APP_PATH)"/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/build_components.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/factory_config.opt" --cmd_file=$(STACK_LIBRARY_PATH)"/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path=$(APP_PATH) --include_path=$(APP_PATH)"/Application" --include_path=$(APP_PATH)"/Startup" --include_path=$(APP_PATH)"/PROFILES" --include_path=$(APP_PATH)"/Include" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/controller/cc26xx/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/rom" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/target" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/heapmgr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/osal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/saddr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/sdata" --include_path="$(TI_SDK_PATH)/source/ti/devices/cc26x0r2" --include_path="$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" --obj_directory="./" $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '

TRNGCC26XX.obj: $(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common/TRNGCC26XX.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file=$(APP_PATH)"/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/build_components.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/factory_config.opt" --cmd_file=$(STACK_LIBRARY_PATH)"/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path=$(APP_PATH) --include_path=$(APP_PATH)"/Application" --include_path=$(APP_PATH)"/Startup" --include_path=$(APP_PATH)"/PROFILES" --include_path=$(APP_PATH)"/Include" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/controller/cc26xx/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/rom" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/target" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/heapmgr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/osal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/saddr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/sdata" --include_path="$(TI_SDK_PATH)/source/ti/devices/cc26x0r2" --include_path="$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" --obj_directory="./" $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '

board.obj: $(TI_SDK_PATH)/source/ti/ble5stack/target/board.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file=$(APP_PATH)"/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/build_components.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/factory_config.opt" --cmd_file=$(STACK_LIBRARY_PATH)"/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path=$(APP_PATH) --include_path=$(APP_PATH)"/Application" --include_path=$(APP_PATH)"/Startup" --include_path=$(APP_PATH)"/PROFILES" --include_path=$(APP_PATH)"/Include" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/controller/cc26xx/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/rom" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/target" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/heapmgr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/osal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/saddr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/sdata" --include_path="$(TI_SDK_PATH)/source/ti/devices/cc26x0r2" --include_path="$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" --obj_directory="./" $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '

%.obj: ../Startup/%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file=$(APP_PATH)"/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/build_components.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/factory_config.opt" --cmd_file=$(STACK_LIBRARY_PATH)"/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path=$(APP_PATH) --include_path=$(APP_PATH)"/Application" --include_path=$(APP_PATH)"/Startup" --include_path=$(APP_PATH)"/PROFILES" --include_path=$(APP_PATH)"/Include" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/controller/cc26xx/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/rom" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/target" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/heapmgr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/osal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/saddr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/sdata" --include_path="$(TI_SDK_PATH)/source/ti/devices/cc26x0r2" --include_path="$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" --obj_directory="./" $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '

ble_user_config.obj: $(TI_SDK_PATH)/source/ti/ble5stack/icall/app/ble_user_config.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file=$(APP_PATH)"/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/build_components.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/factory_config.opt" --cmd_file=$(STACK_LIBRARY_PATH)"/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path=$(APP_PATH) --include_path=$(APP_PATH)"/Application" --include_path=$(APP_PATH)"/Startup" --include_path=$(APP_PATH)"/PROFILES" --include_path=$(APP_PATH)"/Include" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/controller/cc26xx/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/rom" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/target" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/heapmgr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/osal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/saddr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/sdata" --include_path="$(TI_SDK_PATH)/source/ti/devices/cc26x0r2" --include_path="$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" --obj_directory="./" $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '

icall_api_lite.obj: $(TI_SDK_PATH)/source/ti/ble5stack/icall/app/icall_api_lite.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file=$(APP_PATH)"/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/build_components.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/factory_config.opt" --cmd_file=$(STACK_LIBRARY_PATH)"/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path=$(APP_PATH) --include_path=$(APP_PATH)"/Application" --include_path=$(APP_PATH)"/Startup" --include_path=$(APP_PATH)"/PROFILES" --include_path=$(APP_PATH)"/Include" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/controller/cc26xx/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/rom" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/target" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/heapmgr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/osal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/saddr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/sdata" --include_path="$(TI_SDK_PATH)/source/ti/devices/cc26x0r2" --include_path="$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" --obj_directory="./" $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '

icall.obj: $(TI_SDK_PATH)/source/ti/ble5stack/icall/src/icall.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file=$(APP_PATH)"/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/build_components.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/factory_config.opt" --cmd_file=$(STACK_LIBRARY_PATH)"/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path=$(APP_PATH) --include_path=$(APP_PATH)"/Application" --include_path=$(APP_PATH)"/Startup" --include_path=$(APP_PATH)"/PROFILES" --include_path=$(APP_PATH)"/Include" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/controller/cc26xx/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/rom" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/target" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/heapmgr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/osal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/saddr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/sdata" --include_path="$(TI_SDK_PATH)/source/ti/devices/cc26x0r2" --include_path="$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" --obj_directory="./" $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '

icall_cc2650.obj: $(TI_SDK_PATH)/source/ti/ble5stack/icall/src/icall_cc2650.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file=$(APP_PATH)"/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/build_components.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/factory_config.opt" --cmd_file=$(STACK_LIBRARY_PATH)"/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path=$(APP_PATH) --include_path=$(APP_PATH)"/Application" --include_path=$(APP_PATH)"/Startup" --include_path=$(APP_PATH)"/PROFILES" --include_path=$(APP_PATH)"/Include" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/controller/cc26xx/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/rom" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/target" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/heapmgr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/osal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/saddr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/sdata" --include_path="$(TI_SDK_PATH)/source/ti/devices/cc26x0r2" --include_path="$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" --obj_directory="./" $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '

icall_user_config.obj: $(TI_SDK_PATH)/source/ti/ble5stack/icall/src/icall_user_config.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" --cmd_file=$(APP_PATH)"/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/build_components.opt" --cmd_file="$(TI_SDK_PATH)/source/ti/ble5stack/config/factory_config.opt" --cmd_file=$(STACK_LIBRARY_PATH)"/TOOLS/build_config.opt"  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path=$(APP_PATH) --include_path=$(APP_PATH)"/Application" --include_path=$(APP_PATH)"/Startup" --include_path=$(APP_PATH)"/PROFILES" --include_path=$(APP_PATH)"/Include" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/controller/cc26xx/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/rom" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/target" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/hal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/heapmgr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/icall/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/osal/src/inc" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/saddr" --include_path="$(TI_SDK_PATH)/source/ti/ble5stack/services/src/sdata" --include_path="$(TI_SDK_PATH)/source/ti/devices/cc26x0r2" --include_path="$(CCS_PATH)/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="$(basename $(<F)).d_raw" --obj_directory="./" $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '
