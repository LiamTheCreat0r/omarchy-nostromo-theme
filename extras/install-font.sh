#!/bin/sh
# NOSTROMO — register the bundled Blex Mono (IBM Plex Mono) Nerd Font.
#
# Run after the theme is applied:
#   ~/.local/state/omarchy/current/theme/extras/install-font.sh
#
# Copies the two bundled faces into ~/.local/share/fonts, refreshes the
# fontconfig cache, and points the system monospace alias at Blex Mono with
# `omarchy font set`. That command rewrites ~/.config/fontconfig/fonts.conf and
# restarts the shell. Safe to run again.
set -eu

FAMILY="BlexMono Nerd Font Mono"
theme_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
source_dir="$theme_dir/fonts"
font_dir="${XDG_DATA_HOME:-$HOME/.local/share}/fonts"

if ! command -v omarchy >/dev/null 2>&1; then
  echo "omarchy not found; this script is for Omarchy 4." >&2
  exit 1
fi

for face in BlexMonoNerdFontMono-Regular.ttf BlexMonoNerdFontMono-Bold.ttf; do
  if [ ! -f "$source_dir/$face" ]; then
    echo "Missing $source_dir/$face" >&2
    echo "Run this from an installed theme or a full checkout of the repo." >&2
    exit 1
  fi
done

mkdir -p "$font_dir"
install -m 644 "$source_dir/BlexMonoNerdFontMono-Regular.ttf" "$font_dir/"
install -m 644 "$source_dir/BlexMonoNerdFontMono-Bold.ttf" "$font_dir/"
fc-cache -f >/dev/null

if ! fc-list -f '%{family}\n' | grep -Fqi "$FAMILY"; then
  echo "fontconfig does not see '$FAMILY' after installing it." >&2
  exit 1
fi

if fc-match -f '%{family}\n' monospace | grep -Fqi "$FAMILY"; then
  echo "'$FAMILY' is already the monospace font."
  exit 0
fi

omarchy font set "$FAMILY"
echo "monospace now resolves to: $(fc-match -f '%{family}' monospace)"
