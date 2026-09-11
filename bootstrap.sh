#!/usr/bin/env bash
set -eo pipefail

echo "========================================="
echo "   Bootstrapping Workstation with Dotfiles"
echo "========================================="

# 1. Ensure git and chezmoi are installed
if ! command -v pacman >/dev/null 2>&1; then
    echo "Error: This script is intended for Arch / CachyOS systems."
    exit 1
fi

echo "==> Ensuring git and chezmoi are installed..."
sudo pacman -S --needed --noconfirm git chezmoi

# 2. Initialize and apply dotfiles
DOTFILES_REPO="https://github.com/brschneider/dotfiles.git"

echo "==> Initializing and applying chezmoi from $DOTFILES_REPO..."
chezmoi init --apply "$DOTFILES_REPO"

echo "========================================="
echo "   Bootstrapping Complete! 🎉"
echo "========================================="
