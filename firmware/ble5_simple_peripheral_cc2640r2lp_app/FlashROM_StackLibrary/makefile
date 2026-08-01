
GEN_OPTS__FLAG := --cmd_file="configPkg/compiler.opt" 
GEN_CMDS__FLAG := -l"configPkg/linker.cmd" 

include ../../build/cc2640r2f_app.mk

RM := rm -rf
RMDIR := rm -rf

OBJS += $(APP_OBJECTS)

STACK_LINK_INPUTS := \
$(STACK_LIBRARY_PATH)/FlashROM_Library/ble_r2.symbols \
$(STACK_LIBRARY_PATH)/FlashROM_Library/lib_linker.cmd \
$(STACK_LIBRARY_PATH)/FlashROM_Library/ble5_simple_peripheral_cc2640r2lp_stack_library.lib

ORDERED_OBJS += $(OBJS) $(GEN_CMDS__FLAG) $(APP_LINK_LIBS)

# Add inputs and outputs from these tool invocations to the build variables 
EXE_OUTPUTS += \
$(APP_OUTPUT) 

EXE_OUTPUTS__QUOTED += \
"$(APP_OUTPUT)" 


# All Target
all: all_original

all_original: $(OBJS) $(CMD_SRCS) $(GEN_CMDS)
	@$(MAKE) --no-print-directory -Onone "$(APP_OUTPUT)"

dependents:
	-cd $(STACK_LIBRARY_PATH)/FlashROM_Library && $(MAKE) clean all

# Tool invocations
$(APP_OUTPUT): $(OBJS) $(CMD_SRCS) $(GEN_CMDS) $(STACK_LINK_INPUTS)
	@echo 'Building target: "$@"'
	@echo 'Invoking: Arm Linker'
	$(ARMCL) $(APP_LINK_FLAGS) -o "$(APP_OUTPUT)" $(ORDERED_OBJS)
	@echo 'Finished building target: "$@"'
	@echo ' '
	@$(MAKE) --no-print-directory post-build

# Other Targets
clean:
	../clean.sh
	-@echo 'Finished clean'
	-@echo ' '

post-build:
	-$(ARMHEX) -order MS --memwidth=8 --romwidth=8 --intel -o $(APP_HEX_OUTPUT) $(APP_OUTPUT)
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:
$(STACK_LINK_INPUTS): stack-link-inputs

stack-link-inputs:
	$(MAKE) -C "$(STACK_LIBRARY_PATH)/FlashROM_Library" all
