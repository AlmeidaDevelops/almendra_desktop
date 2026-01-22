# AI Context: Dotfiles & Sway Setup

## Overview
User had a clean Ubuntu system and lost their Sway configuration after a kernel update. We set up a dotfiles management system using `stow` and `git` to prevent this from happening again.

## Current State
- **Root Directory**: `~/dotfiles`
- **Management Tool**: GNU Stow
- **Version Control**: Git (local repository initialized)
- **Dependencies**: See [packages.txt](file:///home/alm/dotfiles/packages.txt) for the full list of required system packages.

## Components Installed & Configured
- **WindowManager**: Sway
- **Status Bar**: Waybar
- **App Launcher**: Wofi
- **Notifications**: Mako
- **Shell**: Bash (linked: `.bashrc`, `.profile`)
- **Themes**: New `themes` folder for different Sway looks

## Key File Locations (Simlinks)
- `~/.config/sway/config` -> `~/dotfiles/sway/.config/sway/config`
- `~/.config/waybar/config` -> `~/dotfiles/waybar/.config/waybar/config`
- `~/.config/mako/config` -> `~/dotfiles/mako/.config/mako/config`

## Tools for Maintenance
- `~/dotfiles/sync.sh`: Script to add, commit, and push all changes.

## Next Steps for AI
1. When resuming, focus on `~/dotfiles`.
2. check `sync.sh` for status updates.
3. Help user refine the Sway/Waybar/Mako CSS and configurations.
4. Assist in setting up a GitHub remote for the repository.

## Installation / Replication
To replicate this setup on a fresh Ubuntu system:
1. Clone the repository: `git clone <repo-url> ~/dotfiles`
2. Install all dependencies: `sudo apt update && xargs sudo apt install -y < ~/dotfiles/packages.txt`
3. Use `stow` to link configurations: `cd ~/dotfiles && stow sway waybar wofi mako bash`

## Important Reminders
- **Themes**: Centralize all Sway visual themes in `~/dotfiles/themes`. Each theme should be in its own subdirectory.
- **Organization**: Keep the dotfiles structure clean and use `stow` for management.

## Troubleshooting & Fixes
- **Waybar/Portal Timeout**: If Waybar doesn't appear or D-Bus timeouts occur, ensure `xdg-desktop-portal-wlr` is installed and `dbus-update-activation-environment` is called in the Sway config.
- **Portal Config**: A specific `~/.config/xdg-desktop-portal/sway.conf` was created to prioritize the `wlr` and `gtk` portals in Sway.
