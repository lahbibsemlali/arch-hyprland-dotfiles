# My Hyprland Dotfiles

Minimal, reproducible Arch Linux + Hyprland setup.

Everything is managed from this repository:
- package lists
- install scripts
- config files

## Structure

- `packages/` package manifests
- `scripts/` install/bootstrap scripts
- `configs/` application config files mirrored into `~/.config`

## Quick Start

1. Clone this repo:
   - `git clone <your-repo-url> ~/my-dotfiles`
   - `cd ~/my-dotfiles`
2. Run the installer:
   - `bash scripts/install-packages.sh`
3. Link configs:
   - `bash scripts/stow-configs.sh`

## Notes

- Scripts are idempotent where possible.
- Keep changes in this repo, then push to GitHub.
