#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo "[1/2] Installing packages..."
bash "${REPO_ROOT}/scripts/install-packages.sh"

echo "[2/2] Linking configs..."
bash "${REPO_ROOT}/scripts/stow-configs.sh"

echo "Bootstrap complete."
