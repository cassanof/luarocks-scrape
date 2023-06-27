#!/bin/bash


pushd ./unpacked
# in ../downloaded
for f in ../downloaded/*.rock; do
  echo "Unpacking $f"
    luarocks unpack ../downloaded/$f
done
popd
