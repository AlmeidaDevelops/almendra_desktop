# AI Context: Dotfiles & Sway Setup

## Overview
User had a clean Ubuntu system and lost their Sway configuration after a kernel update. We set up a dotfiles management system using `stow` and `git` to prevent this from happening again.

## Current State
- **Root Directory**: `~/dotfiles`
- **Management Tool**: GNU Stow
- **Version Control**: Git (local repository initialized)

## Components Installed & Configured
- **WindowManager**: Sway
- **Status Bar**: Waybar
- **App Launcher**: Wofi
- **Notifications**: Mako
- **Shell**: Bash (linked: `.bashrc`, `.profile`)

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
