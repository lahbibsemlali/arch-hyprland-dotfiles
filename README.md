# My Hyprland Dotfiles

Minimal, reproducible Arch Linux + Hyprland setup with modular configs and helper scripts.

## Preview

![Desktop Preview](assets/desktop-preview.jpg)

## What This Repo Manages

- package manifests (`pacman` + AUR)
- install/bootstrap scripts
- Hyprland, Waybar, Wofi, Kitty, Dunst configs
- shell setup (`zsh`, `eza`, `fzf`, `zoxide`, `fastfetch`)
- wallpaper curation and rotation scripts

## Repository Structure

- `configs/` symlinked to `~/.config` via stow
- `configs/home/` symlinked to `~` (for dotfiles like `.zshrc`)
- `packages/` package lists used by install scripts
- `scripts/` bootstrap and utility scripts
- `wallpapers/` local wallpaper library (images ignored by git)

## Quick Start

```bash
git clone <your-repo-url> ~/my-dotfiles
cd ~/my-dotfiles
bash scripts/install-packages.sh
bash scripts/stow-configs.sh
bash scripts/setup-shell.sh   # optional (set zsh as default shell)
```

## Key Scripts

- `scripts/bootstrap.sh` install + stow in one command
- `scripts/install-packages.sh` install from `packages/pacman.txt` and `packages/aur.txt`
- `scripts/stow-configs.sh` link configs into your home directory
- `scripts/setup-shell.sh` set default shell to zsh
- `scripts/import-dharmx-walls.sh` import curated wallpaper subsets

## Wallpapers

### Import curated wallpapers

1. Edit categories in `wallpapers/sources/dharmx-categories.txt`
2. Import a small subset:

```bash
PER_CATEGORY=4 bash scripts/import-dharmx-walls.sh
```

### Set and rotate wallpapers

- Set a specific wallpaper:
  - `~/.config/hypr/scripts/set-wallpaper.sh /absolute/path/to/image.jpg`
- Set a random wallpaper:
  - `~/.config/hypr/scripts/set-random-wallpaper.sh`
- Keybind:
  - `SUPER + SHIFT + W` picks a random wallpaper

## Notes

- Keep all changes in this repo, then commit/push.
- Scripts are designed to be rerun safely.
