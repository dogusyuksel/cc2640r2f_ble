include $(dir $(lastword $(MAKEFILE_LIST)))cc2640r2f_toolchain.mk

APP_CMD_FILES := \
	--cmd_file="$(APP_PATH)/TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_app_FlashROM_StackLibrary.opt" \
	$(BLE_CONFIG_CMD_FILES)

APP_COMMON_FLAGS := $(CC2640_COMMON_FLAGS)

APP_LOCAL_INCLUDE_DIRS := \
	$(APP_PATH) \
	$(APP_PATH)/Application \
	$(APP_PATH)/Startup \
	$(APP_PATH)/PROFILES \
	$(APP_PATH)/Include

APP_BLESTACK_INCLUDE_DIRS := \
	$(VENDORED_BLESTACK)/controller/cc26xx/inc \
	$(VENDORED_BLESTACK)/inc \
	$(VENDORED_BLESTACK)/rom \
	$(VENDORED_BLESTACK)/common/cc26xx \
	$(VENDORED_BLESTACK)/icall/inc \
	$(VENDORED_BLESTACK)/target \
	$(VENDORED_BLESTACK)/hal/src/target/_common \
	$(VENDORED_BLESTACK)/hal/src/target/_common/cc26xx \
	$(VENDORED_BLESTACK)/hal/src/inc \
	$(VENDORED_BLESTACK)/heapmgr \
	$(VENDORED_BLESTACK)/icall/src \
	$(VENDORED_BLESTACK)/icall/src/inc \
	$(VENDORED_BLESTACK)/osal/src/inc \
	$(VENDORED_BLESTACK)/services/src/saddr \
	$(VENDORED_BLESTACK)/services/src/sdata

APP_DRIVER_INCLUDE_DIRS := \
	$(VENDORED_DEVICES)/cc26x0r2 \
	$(TI_ARM_CGT)/include

APP_INCLUDE_DIRS := \
	$(APP_LOCAL_INCLUDE_DIRS) \
	$(APP_BLESTACK_INCLUDE_DIRS) \
	$(APP_DRIVER_INCLUDE_DIRS)

APP_INCLUDE_FLAGS := $(addprefix --include_path=,$(APP_INCLUDE_DIRS))
APP_COMPILE_FLAGS := $(APP_CMD_FILES) $(APP_COMMON_FLAGS) $(APP_INCLUDE_FLAGS)
APP_XDC_COMPILE_OPTIONS := $(APP_COMMON_FLAGS) $(APP_INCLUDE_FLAGS)

APP_OUTPUT := ble5_simple_peripheral_cc2640r2lp_app.out
APP_HEX_OUTPUT := ble5_simple_peripheral_cc2640r2lp_app.hex

CFG_SRCS += ../TOOLS/app_ble.cfg

GEN_CMDS += ./configPkg/linker.cmd

GEN_FILES += \
	./configPkg/linker.cmd \
	./configPkg/compiler.opt

GEN_OPTS += ./configPkg/compiler.opt

APP_OBJECTS := \
	./board_key.obj \
	./simple_peripheral.obj \
	./common_jobs.obj \
	./ExtFlash.obj \
	./printf.obj \
	./util.obj \
	./devinfoservice.obj \
	./gatt_uuid.obj \
	./gattservapp_util.obj \
	./simple_gatt_profile.obj \
	./ECCROMCC26XX.obj \
	./TRNGCC26XX.obj \
	./board.obj \
	./ccfg_app_ble.obj \
	./main.obj \
	./ble_user_config.obj \
	./icall_api_lite.obj \
	./icall.obj \
	./icall_cc2650.obj \
	./icall_user_config.obj

APP_LINK_LIBS := \
	-l"$(VENDORED_DEVICES)/cc26x0r2/driverlib/bin/ccs/driverlib.lib" \
	-l"$(VENDORED_SDK_PATH)/kernel/tirtos/packages/ti/dpl/lib/dpl_cc26x0r2.aem3" \
	-l"$(VENDORED_SDK_PATH)/source/ti/drivers/lib/drivers_cc26x0r2.aem3" \
	-l"$(VENDORED_SDK_PATH)/source/ti/drivers/rf/lib/rf_singleMode_cc26x0r2.aem3" \
	-l"$(STACK_LIBRARY_PATH)/FlashROM_Library/ble_r2.symbols" \
	-l"$(STACK_LIBRARY_PATH)/FlashROM_Library/lib_linker.cmd" \
	-l"$(STACK_LIBRARY_PATH)/FlashROM_Library/ble5_simple_peripheral_cc2640r2lp_stack_library.lib" \
	-l"$(VENDORED_BLESTACK)/common/cc26xx/ccs/cc26xx_app.cmd" \
	-llibc.a

APP_LINK_FLAGS := \
	$(APP_CMD_FILES) \
	$(APP_COMMON_FLAGS) \
	-z \
	-m"ble5_simple_peripheral_cc2640r2lp_app.map" \
	--heap_size=0 \
	--stack_size=256 \
	-i"$(TI_ARM_CGT)/lib" \
	-i"$(TI_ARM_CGT)/include" \
	--reread_libs \
	--define=CC26X0ROM=2 \
	--diag_suppress=16002-D \
	--diag_suppress=10247-D \
	--diag_suppress=10325-D \
	--diag_suppress=10229-D \
	--diag_suppress=16032-D \
	--diag_wrap=off \
	--display_error_number \
	--warn_sections \
	--xml_link_info="ble5_simple_peripheral_cc2640r2lp_app_linkInfo.xml" \
	--rom_model

define COMPILE_APP_C
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	$(ARMCL) $(APP_COMPILE_FLAGS) --preproc_with_compile --preproc_dependency="$(basename $(@F)).d_raw" --obj_directory="./" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: "$<"'
	@echo ' '
endef

app-xdc-config:
	@$(MAKE) --no-print-directory -Onone app-xdc-config-inproc

app-xdc-config-inproc: ../TOOLS/app_ble.cfg
	@echo 'Building file: "$<"'
	@echo 'Invoking: XDCtools'
	$(XDC_XS) --xdcpath="$(XDC_PACKAGE_PATH)" xdc.tools.configuro -o configPkg -t ti.targets.arm.elf.M3 -p ti.platforms.simplelink:CC2640R2F -r release -c "$(TI_ARM_CGT)" --compileOptions "$(APP_XDC_COMPILE_OPTIONS)" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

configPkg/linker.cmd: app-xdc-config ../TOOLS/app_ble.cfg
configPkg/compiler.opt: app-xdc-config
configPkg: app-xdc-config

%.obj: ../Application/%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_APP_C)

%.obj: ../PROFILES/%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_APP_C)

%.obj: ../Startup/%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_APP_C)

ECCROMCC26XX.obj: $(VENDORED_BLESTACK)/common/cc26xx/ecc/ECCROMCC26XX.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_APP_C)

TRNGCC26XX.obj: $(VENDORED_BLESTACK)/hal/src/target/_common/TRNGCC26XX.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_APP_C)

board.obj: $(VENDORED_BLESTACK)/target/board.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_APP_C)

ble_user_config.obj: $(VENDORED_BLESTACK)/icall/app/ble_user_config.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_APP_C)

icall_api_lite.obj: $(VENDORED_BLESTACK)/icall/app/icall_api_lite.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_APP_C)

icall.obj: $(VENDORED_BLESTACK)/icall/src/icall.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_APP_C)

icall_cc2650.obj: $(VENDORED_BLESTACK)/icall/src/icall_cc2650.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_APP_C)

icall_user_config.obj: $(VENDORED_BLESTACK)/icall/src/icall_user_config.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	$(COMPILE_APP_C)
