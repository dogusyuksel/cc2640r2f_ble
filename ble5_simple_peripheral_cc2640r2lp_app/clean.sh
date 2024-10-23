#!/bin/bash

source="./"

if [ "$#" -eq 1 ]; then
    source=$1
fi

files=$(find $source -name '*.d' -o -name '*.obj' -o -name '*.d_raw' -o -name '*.aem3')
while IFS= read -r line; do
    echo "deleting $line"
    rm -rf $line
done <<< "$files"

exit 0