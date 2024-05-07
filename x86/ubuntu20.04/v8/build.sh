#!/bin/bash

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

export PATH=`pwd`/depot_tools:"$PATH"
fetch v8
cd v8
./build/install-build-deps.sh
sudo apt-get install ninja-build

gclient sync

./tools/dev/v8gen.py x64.release
ninja -C ./out.gn/x64.release
./tools/dev/v8gen.py x64.debug
ninja -C ./out.gn/x64.debug

# tools/dev/gm.py x64.release
# tools/dev/gm.py x64.debug