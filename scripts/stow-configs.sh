#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
CONFIGS_DIR="${REPO_ROOT}/configs"

if ! command -v stow >/dev/null 2>&1; then
  echo "GNU stow is required. Install it first (pacman -S stow)."
  exit 1
fi

if [[ ! -d "${CONFIGS_DIR}" ]]; then
  echo "Missing configs directory: ${CONFIGS_DIR}"
  exit 1
fi

cd "${CONFIGS_DIR}"
for dir in */; do
  pkg="${dir%/}"
  echo "Linking ${pkg} into ~/.config/${pkg}"
  stow -v -R -t "${HOME}/.config" "${pkg}"
done

echo "Config symlinks updated."
