#!/usr/bin/env bash
set -eo pipefail

echo "========================================="
echo "   Bootstrapping Workstation with Dotfiles"
echo "========================================="

# 1. Ensure basic prerequisites
if ! command -v pacman >/dev/null 2>&1; then
    echo "Error: This script is intended for Arch / CachyOS systems."
    exit 1
fi

# Refresh sudo credentials upfront
sudo -v

# 2. Install Dank Material Shell (DMS) + Hyprland + Alacritty if not already installed
if ! command -v dms >/dev/null 2>&1; then
    echo "==> Installing Dank Material Shell (DMS)..."
    curl -fsSL https://install.danklinux.com | sh -s -- -c hyprland -t alacritty -y
else
    echo "==> DMS already installed, skipping installer."
fi

# 3. Ensure git and chezmoi are installed
echo "==> Ensuring git and chezmoi are installed..."
sudo pacman -S --needed --noconfirm git chezmoi

# 4. Initialize and apply dotfiles
DOTFILES_REPO="https://github.com/brschneider/dotfiles.git"

echo "==> Initializing and applying chezmoi from $DOTFILES_REPO..."
chezmoi init --apply "$DOTFILES_REPO"

echo "========================================="
echo "   Bootstrapping Complete! 🎉"
echo "========================================="
