#!/usr/bin/env bash
set -euo pipefail

THRESHOLD=15
DIM_TO=30
STATE_DIR="${HOME}/.cache/hypr"
STATE_FILE="${STATE_DIR}/battery-guard-triggered"

mkdir -p "${STATE_DIR}"

get_battery_path() {
  for p in /sys/class/power_supply/BAT*; do
    [[ -d "${p}" ]] && { echo "${p}"; return 0; }
  done
  return 1
}

BAT_PATH="$(get_battery_path || true)"
if [[ -z "${BAT_PATH}" ]]; then
  exit 0
fi

while true; do
  CAPACITY="$(<"${BAT_PATH}/capacity")"
  STATUS="$(<"${BAT_PATH}/status")"

  if [[ "${STATUS}" == "Discharging" && "${CAPACITY}" -le "${THRESHOLD}" ]]; then
    if [[ ! -f "${STATE_FILE}" ]]; then
      notify-send -u critical -a "battery" \
        "Battery low (${CAPACITY}%)" \
        "Brightness reduced to ${DIM_TO}%."

      if command -v brightnessctl >/dev/null 2>&1; then
        brightnessctl -q set "${DIM_TO}%"
      fi

      : > "${STATE_FILE}"
    fi
  else
    rm -f "${STATE_FILE}"
  fi

  sleep 30
done
