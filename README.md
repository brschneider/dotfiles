# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## New Machine Setup (Single Command)

On a fresh CachyOS install (select **Desktop Environment: None** during install, reboot into TTY and log in), run:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/brschneider/dotfiles/main/bootstrap.sh)"
```

This single command will:
1. Prompt for `sudo` and run the Dank Material Shell installer (`curl -fsSL https://install.danklinux.com | sh -s -- -c hyprland -t alacritty -y`).
2. Install `git` and `chezmoi`.
3. Pull and apply these dotfiles via chezmoi.
4. Install all native, AUR, and Flatpak apps.
5. Setup `greetd` + `dms-greeter` and user `dms.service`.
6. Restore DMS plugins and Hyprland AI skills.


## What this configures
- **Native packages (`pacman`)**: Restores packages from `pkglist-native.txt` (includes critical Wayland/laptop components like `brightnessctl`, `qt6-5compat`, `uwsm`, `libnewt`, `greetd`)
- **AUR packages (`yay`)**: Restores packages from `pkglist-aur.txt` (includes `dsearch-bin`, `greetd-dms-greeter-bin`, etc.; installs `yay` automatically if missing)
- **Flatpaks**: Restores apps from `pkglist-flatpak.txt`
- **Configs**: Hyprland (with fallback terminal bind `SUPER+RETURN`), Dank Material Shell, Ghostty, Antigravity, etc.
- **Plugins & Skills**: Dank Material Shell plugins and Hyprland AI skills
- **Services**: Automatically configures `dms-greeter`, enables `greetd.service`, and enables user `dms.service`

