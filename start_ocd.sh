#!/bin/bash

openocd -f /thirdparty/openocd/tcl/interface/xds110.cfg -f /thirdparty/openocd/tcl/board/ti_cc26x0_launchpad.cfg

# then in another terminal, run below
# gdb-multiarch <your_code>.out
# target extended-remote localhost:3333
# load comamnd can be used to fw update

exit 0
