#!/bin/bash

source="./"

if [ "$#" -eq 1 ]; then
    source=$1
fi

files=$(find $source -name '*.d' -o -name '*.xs' -o -name '*.dot' -o -name '*.obj' -o -name '*.d_raw' -o -name '*.map' -o -name '*.hex' -o -name '*.out' -o -name '*.out')
while IFS= read -r line; do
    echo "deleting $line"
    rm -rf $line
done <<< "$files"

rm -rf $APP_PATH"/FlashROM_StackLibrary/configPkg"

exit 0