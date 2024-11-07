#
_XDCBUILDCOUNT = 
ifneq (,$(findstring path,$(_USEXDCENV_)))
override XDCPATH = /workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source;/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/kernel/tirtos/packages;/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack
override XDCROOT = /workspace/ti_cc2640r2f_sdk/ccs1281/xdctools_3_62_01_16_core
override XDCBUILDCFG = ./config.bld
endif
ifneq (,$(findstring args,$(_USEXDCENV_)))
override XDCARGS = 
override XDCTARGETS = 
endif
#
ifeq (0,1)
PKGPATH = /workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source;/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/kernel/tirtos/packages;/workspace/ti_cc2640r2f_sdk/simplelink_cc2640r2_sdk_5_30_01_11/source/ti/ble5stack;/workspace/ti_cc2640r2f_sdk/ccs1281/xdctools_3_62_01_16_core/packages;..
HOSTOS = Linux
endif
