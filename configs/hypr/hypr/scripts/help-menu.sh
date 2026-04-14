#!/usr/bin/env bash
set -euo pipefail

CFG="${HOME}/.config/hypr/keybinds.conf"

if [[ ! -f "${CFG}" ]]; then
  notify-send -a hyprland "Help Menu" "Missing ${CFG}"
  exit 1
fi

map_mod() {
  case "$1" in
    '$mod') echo "SUPER" ;;
    '$mod SHIFT') echo "SUPER+SHIFT" ;;
    '$mod CTRL') echo "SUPER+CTRL" ;;
    '$mod ALT') echo "SUPER+ALT" ;;
    *) echo "$1" ;;
  esac
}

build_lines() {
  awk '
    BEGIN { FS="," }
    /^[[:space:]]*bind(el|l|m)?[[:space:]]*=/ {
      line=$0
      sub(/^[[:space:]]*bind(el|l|m)?[[:space:]]*=[[:space:]]*/, "", line)
      n=split(line, a, ",")
      if (n < 3) next
      mods=a[1]; gsub(/^[[:space:]]+|[[:space:]]+$/, "", mods)
      key=a[2];  gsub(/^[[:space:]]+|[[:space:]]+$/, "", key)
      cmd=""
      for (i=3; i<=n; i++) {
        part=a[i]
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", part)
        cmd = (cmd=="" ? part : cmd ", " part)
      }
      if (mods == "") combo=key
      else combo=mods "+" key
      print combo "  ->  " cmd
    }
  ' "${CFG}" \
  | sed -e 's/\$mod /SUPER /g' -e 's/\$mod/SUPER/g' \
  | sort -u
}

build_lines | wofi --show dmenu --prompt "Hypr keybinds" --width 900 --height 500 >/dev/null
