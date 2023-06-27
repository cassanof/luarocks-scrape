#!/bin/bash

# don't crash if a command fails
# set +e

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
    echo "** Exiting **"
    exit 1
}

# check if ./package_names.txt exists
if [ ! -f ./package_names.txt ]; then
    echo "package_names.txt not found!"
    exit 1
fi

pushd ./downloaded
while read line; do
    echo "Downloading $line"
    luarocks download --source $line
    # if $? == 1 then: reurun without --source
    if [ $? -eq 1 ]; then
        echo "Failed to download $line with --source, trying without"
        luarocks download $line
        if [ $? -eq 1 ]; then
            echo "Failed to download $line without --source"
        else
            echo "Successfully downloaded $line without --source"
        fi
    fi
done < ../package_names.txt
popd

