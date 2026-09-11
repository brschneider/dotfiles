# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## New Machine Setup (Single Command)

To provision a fresh CachyOS / Arch machine with all packages, apps, Hyprland configs, DMS plugins, and AI skills:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/brschneider/dotfiles/main/bootstrap.sh)"
```

Or clone and apply manually:

```bash
sudo pacman -S --needed git chezmoi
chezmoi init --apply https://github.com/brschneider/dotfiles.git
```

## What this configures
- **Native packages (`pacman`)**: Restores packages from `pkglist-native.txt` (includes critical Wayland/laptop components like `brightnessctl`, `qt6-5compat`, `uwsm`, `libnewt`, `greetd`)
- **AUR packages (`yay`)**: Restores packages from `pkglist-aur.txt` (includes `dsearch-bin`, `greetd-dms-greeter-bin`, etc.; installs `yay` automatically if missing)
- **Flatpaks**: Restores apps from `pkglist-flatpak.txt`
- **Configs**: Hyprland (with fallback terminal bind `SUPER+RETURN`), Dank Material Shell, Ghostty, Antigravity, etc.
- **Plugins & Skills**: Dank Material Shell plugins and Hyprland AI skills
- **Services**: Automatically configures `dms-greeter`, enables `greetd.service`, and enables user `dms.service`

