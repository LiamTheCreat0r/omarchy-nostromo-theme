#!/bin/sh
# NOSTROMO — toggle the optional CRT shader.
# Bound from ~/.config/hypr/looknfeel.lua:
#   o.bind("SUPER + SHIFT + F12", "Toggle CRT shader",
#          "~/.local/state/omarchy/current/theme/extras/toggle-crt.sh")
set -eu

shader="$HOME/.local/state/omarchy/current/theme/extras/crt.frag"
current=$(hyprctl getoption decoration:screen_shader -j | jq -r '.str // ""')

if [ -n "$current" ]; then
  hyprctl keyword decoration:screen_shader ""
else
  hyprctl keyword decoration:screen_shader "$shader"
fi
