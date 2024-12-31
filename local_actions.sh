#!/bin/bash

# important!! first call must have '-b' option
./docker_ctl.sh -b -s -c 'cd /workspace && source environment && cd firmware/ble5_simple_peripheral_cc2640r2lp_app && make -C ./FlashROM_StackLibrary/ clean && make -C ./FlashROM_StackLibrary/ all'

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Error Occured"
fi
exit $retVal
