#!/usr/bin/env bash
set -euo pipefail

if ! command -v wl-clipboard-history >/dev/null 2>&1; then
  notify-send -a clipboard "Clipboard" "Install wl-clipboard-history-git first"
  exit 1
fi

if ! command -v fzf >/dev/null 2>&1; then
  notify-send -a clipboard "Clipboard" "Install fzf first"
  exit 1
fi

exec kitty --class clipboard-picker --title Clipboard -e sh -lc '
if ! pgrep -x wl-clipboard-history >/dev/null 2>&1; then
  wl-clipboard-history -t >/dev/null 2>&1 &
  sleep 0.2
fi

list="$(wl-clipboard-history -l 376)"
if [ -z "$list" ]; then
  echo "Clipboard history empty."
  echo "Copy something first. Keep tracker running: wl-clipboard-history -t"
  read -r -n1 -p "Press any key..."
  exit 0
fi

sel="$(printf "%s\n" "$list" | fzf \
  --header "Enter copy | Esc quit" \
  --bind "enter:accept")"

[ -z "$sel" ] && exit 0
idx="$(printf "%s\n" "$sel" | awk "{print \$1}")"

if printf "%s" "$idx" | grep -Eq "^[0-9]+$"; then
  wl-clipboard-history -p "$idx" | wl-copy
else
  printf "%s" "$sel" | wl-copy
fi

notify-send -a clipboard "Clipboard" "Copied selection"
'
