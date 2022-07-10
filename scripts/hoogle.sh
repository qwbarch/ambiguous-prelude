#!/bin/bash
nohup hoogle server --local &>/dev/null &

# If running thie script from WSL, ignore opening the browser.
if ! [[ -n "$IS_WSL" || -n "$WSL_DISTRO_NAME" ]]; then
  xdg-open localhost:8080
fi
