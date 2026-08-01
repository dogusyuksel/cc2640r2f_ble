
GEN_OPTS__FLAG := 
GEN_CMDS__FLAG := 

RM := rm -rf
RMDIR := rm -rf

include ../../build/cc2640r2f_stack.mk

OPT_SRCS += \
../TOOLS/defines/ble5_simple_peripheral_cc2640r2lp_stack_library_FlashROM_Library.opt

OBJS += $(STACK_OBJECTS)

ORDERED_OBJS += \
$(OBJS) \

# Add inputs and outputs from these tool invocations to the build variables 
LIB_OUTPUTS += \
$(STACK_OUTPUT)

LIB_SEARCH_OUTPUTS += \
ble_r2.symbols \
lib_linker.cmd

LIB_OUTPUTS__QUOTED += \
"$(STACK_OUTPUT)"

LIB_SEARCH_OUTPUTS__QUOTED += \
"ble_r2.symbols" \
"lib_linker.cmd"


# All Target
all:
	@$(MAKE) --no-print-directory pre-build
	@$(MAKE) --no-print-directory main-build

# Main-build Target
main-build: $(STACK_OUTPUT)

# Tool invocations
$(STACK_OUTPUT): $(OBJS)
ifneq ($(strip $(ORDERED_OBJS)),)
	@echo 'Building target: "$@"'
	@echo 'Invoking: Arm Archiver'
	$(ARMAR) r "$(STACK_OUTPUT)" $(ORDERED_OBJS)
	@echo 'Finished building target: "$@"'
	@echo ' '
endif

# Other Targets
clean:
	-@chmod u+w $(LIB_SEARCH_OUTPUTS__QUOTED) 2>/dev/null || true
	-$(RM) $(LIB_OUTPUTS__QUOTED)
	-$(RM) $(LIB_SEARCH_OUTPUTS__QUOTED)
	-$(RM) $(OBJS) $(STACK_DEP_FILES)
	-@echo 'Finished clean'
	-@echo ' '

pre-build:
	@chmod u+w $(LIB_SEARCH_OUTPUTS__QUOTED) 2>/dev/null || true
	$(LIB_SEARCH) --opt $(STACK_LIBRARY_PATH)/TOOLS/build_config.opt --lib-dir $(VENDORED_BLESTACK)/blelib/cc26x0r2 --cmd $(STACK_LIBRARY_PATH)/FlashROM_Library/lib_linker.cmd --xml $(VENDORED_SDK_PATH)/tools/ble5stack/lib_search/lib_search.xml --sym-dir $(VENDORED_BLESTACK)/symbols/cc26x0r2
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:
