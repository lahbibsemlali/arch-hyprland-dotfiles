#!/usr/bin/env bash
set -euo pipefail

if ! command -v cliphist >/dev/null 2>&1; then
  notify-send -a clipboard "Clipboard" "Install cliphist first (sudo pacman -S cliphist)"
  exit 1
fi

if ! command -v wofi >/dev/null 2>&1; then
  notify-send -a clipboard "Clipboard" "Install wofi first"
  exit 1
fi

# Show the clipboard history using wofi, and copy the selected item back to the clipboard
cliphist list | wofi --dmenu --prompt "Clipboard" --width 720 --height 420 | cliphist decode | wl-copy

# Notify the user
if [ $? -eq 0 ]; then
  notify-send -a clipboard "Clipboard" "Copied selection"
fi