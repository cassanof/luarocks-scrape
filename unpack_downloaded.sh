#!/bin/bash


# for every file in ./downloaded unpack with luarocks
pushd ./downloaded
for f in *; do
    luarocks unpack $f
done
popd
