#!/bin/bash
cd ..
nix build .\#x86_64-w64-mingw32:hello-project:exe:hello-project
#chmod -R o+rwx ./result
sudo cp package.json ./result/bin/package.json
sudo cp index.js ./result/bin/index.js
#sudo ./node_modules/.bin/electron-builder --windows zip --x64 --project ./result/bin
#sudo ./node_modules/.bin/electron-builder --windows zip --x64
sudo ./node_modules/.bin/electron-packager --platform=win32 --arch=x64 --overwrite ./result/bin
