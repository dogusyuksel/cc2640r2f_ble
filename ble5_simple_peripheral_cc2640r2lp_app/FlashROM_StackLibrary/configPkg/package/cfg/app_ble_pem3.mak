#
#  Do not edit this file.  This file is generated from 
#  package.bld.  Any modifications to this file will be 
#  overwritten whenever makefiles are re-generated.
#
#  target compatibility key = ti.targets.arm.elf.M3{1,0,20.2,7
#
ifeq (,$(MK_NOGENDEPS))
-include package/cfg/app_ble_pem3.oem3.dep
package/cfg/app_ble_pem3.oem3.dep: ;
endif

package/cfg/app_ble_pem3.oem3: | .interfaces
package/cfg/app_ble_pem3.oem3: package/cfg/app_ble_pem3.c package/cfg/app_ble_pem3.mak 
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) clem3 $< ...
	$(ti.targets.arm.elf.M3.rootDir)/bin/armcl -c  -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Application" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Startup" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/PROFILES" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Include" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/controller/cc26xx/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/rom" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/common/cc26xx" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/target" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/heapmgr" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/osal/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/saddr" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/sdata" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/devices/cc26x0r2" --include_path="/workspace/ti_cc2640r2f_sdk/ccs1281/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi  -qq -pdsw225 -ms --fp_mode=strict --endian=little -mv7M3 --abi=eabi -eo.oem3 -ea.sem3   -Dxdc_cfg__xheader__='"configPkg/package/cfg/app_ble_pem3.h"'  -Dxdc_target_name__=M3 -Dxdc_target_types__=ti/targets/arm/elf/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_20_2_7 -O2  $(XDCINCS) -I$(ti.targets.arm.elf.M3.rootDir)/include  -fs=./package/cfg -fr=./package/cfg -fc $<
	$(MKDEP) -a $@.dep -p package/cfg -s oem3 $< -C   -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Application" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Startup" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/PROFILES" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Include" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/controller/cc26xx/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/rom" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/common/cc26xx" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/target" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/heapmgr" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/osal/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/saddr" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/sdata" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/devices/cc26x0r2" --include_path="/workspace/ti_cc2640r2f_sdk/ccs1281/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi  -qq -pdsw225 -ms --fp_mode=strict --endian=little -mv7M3 --abi=eabi -eo.oem3 -ea.sem3   -Dxdc_cfg__xheader__='"configPkg/package/cfg/app_ble_pem3.h"'  -Dxdc_target_name__=M3 -Dxdc_target_types__=ti/targets/arm/elf/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_20_2_7 -O2  $(XDCINCS) -I$(ti.targets.arm.elf.M3.rootDir)/include  -fs=./package/cfg -fr=./package/cfg
	-@$(FIXDEP) $@.dep $@.dep
	
package/cfg/app_ble_pem3.oem3: export C_DIR=
package/cfg/app_ble_pem3.oem3: PATH:=$(ti.targets.arm.elf.M3.rootDir)/bin/:$(PATH)

package/cfg/app_ble_pem3.sem3: | .interfaces
package/cfg/app_ble_pem3.sem3: package/cfg/app_ble_pem3.c package/cfg/app_ble_pem3.mak
	@$(RM) $@.dep
	$(RM) $@
	@$(MSG) clem3 -n $< ...
	$(ti.targets.arm.elf.M3.rootDir)/bin/armcl -c -n -s --symdebug:none -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Application" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Startup" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/PROFILES" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Include" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/controller/cc26xx/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/rom" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/common/cc26xx" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/target" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/heapmgr" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/osal/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/saddr" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/sdata" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/devices/cc26x0r2" --include_path="/workspace/ti_cc2640r2f_sdk/ccs1281/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi  -qq -pdsw225 --endian=little -mv7M3 --abi=eabi -eo.oem3 -ea.sem3   -Dxdc_cfg__xheader__='"configPkg/package/cfg/app_ble_pem3.h"'  -Dxdc_target_name__=M3 -Dxdc_target_types__=ti/targets/arm/elf/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_20_2_7 -O2  $(XDCINCS) -I$(ti.targets.arm.elf.M3.rootDir)/include  -fs=./package/cfg -fr=./package/cfg -fc $<
	$(MKDEP) -a $@.dep -p package/cfg -s oem3 $< -C  -n -s --symdebug:none -mv7M3 --code_state=16 -me -O4 --opt_for_speed=0 --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Application" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Startup" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/PROFILES" --include_path="/workspace/ble5_simple_peripheral_cc2640r2lp_app/Include" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/controller/cc26xx/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/rom" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/common/cc26xx" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/target" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/target/_common/cc26xx" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/hal/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/heapmgr" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/icall/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/osal/src/inc" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/saddr" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack/services/src/sdata" --include_path="/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/devices/cc26x0r2" --include_path="/workspace/ti_cc2640r2f_sdk/ccs1281/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC26X0R2 -g --c99 --gcc --diag_warning=225 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi  -qq -pdsw225 --endian=little -mv7M3 --abi=eabi -eo.oem3 -ea.sem3   -Dxdc_cfg__xheader__='"configPkg/package/cfg/app_ble_pem3.h"'  -Dxdc_target_name__=M3 -Dxdc_target_types__=ti/targets/arm/elf/std.h -Dxdc_bld__profile_release -Dxdc_bld__vers_1_0_20_2_7 -O2  $(XDCINCS) -I$(ti.targets.arm.elf.M3.rootDir)/include  -fs=./package/cfg -fr=./package/cfg
	-@$(FIXDEP) $@.dep $@.dep
	
package/cfg/app_ble_pem3.sem3: export C_DIR=
package/cfg/app_ble_pem3.sem3: PATH:=$(ti.targets.arm.elf.M3.rootDir)/bin/:$(PATH)

clean,em3 ::
	-$(RM) package/cfg/app_ble_pem3.oem3
	-$(RM) package/cfg/app_ble_pem3.sem3

app_ble.pem3: package/cfg/app_ble_pem3.oem3 package/cfg/app_ble_pem3.mak

clean::
	-$(RM) package/cfg/app_ble_pem3.mak
