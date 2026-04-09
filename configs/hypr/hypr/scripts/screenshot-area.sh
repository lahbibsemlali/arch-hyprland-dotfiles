#!/usr/bin/env bash
set -euo pipefail

DIR="${HOME}/Pictures/Screenshots"
mkdir -p "${DIR}"

FILE="${DIR}/shot-$(date +%Y%m%d-%H%M%S).png"
TMP_FILE="$(mktemp --suffix=.png)"
GEOM="$(slurp)"

if [[ -z "${GEOM}" ]]; then
  rm -f "${TMP_FILE}"
  exit 0
fi

grim -g "${GEOM}" "${TMP_FILE}"

CHOICE="$(
  printf "Copy\nSave\nCopy + Save\n" \
    | wofi --dmenu --prompt "Screenshot"
)"

case "${CHOICE}" in
  "Copy")
    wl-copy < "${TMP_FILE}"
    notify-send -a "screenshot" "Screenshot copied" "Clipboard updated"
    rm -f "${TMP_FILE}"
    ;;
  "Save")
    mv "${TMP_FILE}" "${FILE}"
    notify-send -a "screenshot" "Screenshot saved" "$(basename "${FILE}")"
    ;;
  "Copy + Save")
    wl-copy < "${TMP_FILE}"
    mv "${TMP_FILE}" "${FILE}"
    notify-send -a "screenshot" "Screenshot saved + copied" "$(basename "${FILE}")"
    ;;
  *)
    rm -f "${TMP_FILE}"
    ;;
esac
