#!/bin/bash

update_repo () {
   cd $1
   git clean -fd
   git checkout *
   git pull
   cd -
}

if [ ! -d "ti_cc2640r2f_sdk" ];
then
    git clone https://github.com/dogusyuksel/ti_cc2640r2f_sdk.git ti_cc2640r2f_sdk
else
    update_repo "ti_cc2640r2f_sdk"
fi

if [ ! -d "docker" ]; then
    git clone https://github.com/dogusyuksel/embedded_docker.git docker
else
    update_repo "docker"
fi

if [ ! -d "linting" ]; then
    git clone https://github.com/dogusyuksel/embedded_linting.git linting
else
    update_repo "linting"
fi

if [ ! -d "openocd" ]; then
    git clone https://github.com/STMicroelectronics/OpenOCD.git openocd
else
    update_repo "openocd"
fi

exit 0