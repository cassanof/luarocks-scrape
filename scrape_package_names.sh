#!/bin/bash

OUT="package_names.txt"

luarocks search "" | grep -v "^[\ ]"  | sed -e '1,/----------/d'  | sed '/^$/d' | grep -v "Binary and pure-Lua" | grep -v "\----------" > $OUT
