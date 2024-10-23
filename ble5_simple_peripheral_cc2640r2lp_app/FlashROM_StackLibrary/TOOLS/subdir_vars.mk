
# Add inputs and outputs from these tool invocations to the build variables 
CFG_SRCS += \
../TOOLS/app_ble.cfg 

GEN_CMDS += \
./configPkg/linker.cmd 

GEN_FILES += \
./configPkg/linker.cmd \
./configPkg/compiler.opt 

GEN_OPTS += \
./configPkg/compiler.opt 


