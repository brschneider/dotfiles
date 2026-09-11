#!/usr/bin/env bash
set -eo pipefail

# Hashes used to detect changes:
# pkglist-native.txt hash: {{ include "pkglist-native.txt" | sha256sum }}
# pkglist-aur.txt hash: {{ include "pkglist-aur.txt" | sha256sum }}
# pkglist-flatpak.txt hash: {{ include "pkglist-flatpak.txt" | sha256sum }}

CHEZMOI_DIR="{{ .chezmoi.sourceDir }}"

echo "==> Checking & installing package lists..."

# 1. Native packages via pacman
if [ -f "$CHEZMOI_DIR/pkglist-native.txt" ]; then
    echo "==> Synchronizing native packages (pacman)..."
    sudo pacman -S --needed --noconfirm - < "$CHEZMOI_DIR/pkglist-native.txt"
fi

# 2. AUR packages via yay
if [ -f "$CHEZMOI_DIR/pkglist-aur.txt" ]; then
    if ! command -v yay >/dev/null 2>&1; then
        echo "==> 'yay' not found, installing yay..."
        tmpdir=$(mktemp -d)
        git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
        (cd "$tmpdir/yay" && makepkg -si --noconfirm)
        rm -rf "$tmpdir"
    fi
    echo "==> Synchronizing AUR packages (yay)..."
    yay -S --needed --noconfirm - < "$CHEZMOI_DIR/pkglist-aur.txt"
fi

# 3. Flatpaks
if [ -f "$CHEZMOI_DIR/pkglist-flatpak.txt" ] && command -v flatpak >/dev/null 2>&1; then
    echo "==> Synchronizing Flatpaks..."
    while IFS= read -r app || [ -n "$app" ]; do
        [ -z "$app" ] && continue
        if ! flatpak info "$app" >/dev/null 2>&1; then
            echo "Installing flatpak: $app"
            flatpak install -y flathub "$app" || true
        fi
    done < "$CHEZMOI_DIR/pkglist-flatpak.txt"
fi

echo "==> Package synchronization complete."
