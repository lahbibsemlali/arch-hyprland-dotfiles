#!/usr/bin/env bash
set -euo pipefail

SETTER="${HOME}/.config/hypr/scripts/set-wallpaper.sh"
STATE_DIR="${HOME}/.cache/hypr"
STATE_FILE="${STATE_DIR}/last-wallpaper"

mkdir -p "${STATE_DIR}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Try common wallpaper locations, pick first with image files.
candidate_dirs=(
  "${HOME}/my-dotfiles/wallpapers"
  "${HOME}/my-dotfiles/wallpapers/Wallpaper"
  "${HOME}/.config/hypr/wallpapers"
  "${SCRIPT_DIR}/../../../../wallpapers"
  "${SCRIPT_DIR}/../../../../wallpapers/Wallpaper"
)

WALL_DIR=""
for d in "${candidate_dirs[@]}"; do
  if [[ -d "${d}" ]] && find "${d}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | read -r _; then
    WALL_DIR="${d}"
    break
  fi
done

if [[ -z "${WALL_DIR}" ]]; then
  notify-send -a "hyprpaper" "Wallpaper" "No wallpaper directory found"
  exit 1
fi

mapfile -t WALLS < <(find "${WALL_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \))

if [[ "${#WALLS[@]}" -eq 0 ]]; then
  notify-send -a "hyprpaper" "Wallpaper" "No wallpapers found in ${WALL_DIR}"
  exit 1
fi

LAST=""
if [[ -f "${STATE_FILE}" ]]; then
  LAST="$(<"${STATE_FILE}")"
fi

if [[ "${#WALLS[@]}" -eq 1 ]]; then
  PICK="${WALLS[0]}"
else
  PICK="${LAST}"
  while [[ "${PICK}" == "${LAST}" ]]; do
    PICK="${WALLS[RANDOM % ${#WALLS[@]}]}"
  done
fi

"${SETTER}" "${PICK}"
printf '%s\n' "${PICK}" > "${STATE_FILE}"

NAME="$(basename "${PICK}")"
notify-send -a "hyprpaper" -h string:x-dunst-stack-tag:wallpaper "Wallpaper" "${NAME}"
