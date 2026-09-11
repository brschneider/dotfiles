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

# Refresh sudo credentials upfront and keep alive in background
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
SUDO_KEEPALIVE_PID=$!
trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true' EXIT

# 2. Detect Microsoft Surface devices and configure linux-surface kernel
is_surface=false
dmi_vendor=$(cat /sys/devices/virtual/dmi/id/sys_vendor 2>/dev/null || true)
dmi_product=$(cat /sys/devices/virtual/dmi/id/product_name 2>/dev/null || true)

if echo "$dmi_vendor $dmi_product" | grep -qi "surface"; then
    is_surface=true
fi

if [ "$is_surface" = true ]; then
    echo "==> Microsoft Surface hardware detected ($dmi_product)!"
    echo "==> Configuring linux-surface repository and kernel..."

    # Import and sign repository key if not already present
    if ! pacman-key --list-keys 56C464BAAC421453 >/dev/null 2>&1; then
        echo "==> Importing linux-surface key..."
        curl -s https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc \
            | sudo pacman-key --add -
        sudo pacman-key --finger 56C464BAAC421453
        sudo pacman-key --lsign-key 56C464BAAC421453
    fi

    # Add [linux-surface] repo to /etc/pacman.conf if not present
    if ! grep -q "^\[linux-surface\]" /etc/pacman.conf; then
        echo "==> Adding [linux-surface] repository to /etc/pacman.conf..."
        sudo bash -c 'cat >> /etc/pacman.conf << '\''EOF'\''

[linux-surface]
Server = https://pkg.surfacelinux.com/arch/
EOF'
        sudo pacman -Sy
    fi

    # Install linux-surface kernel, headers, and iptsd touch daemon
    echo "==> Installing linux-surface kernel, headers, and iptsd..."
    sudo pacman -S --needed --noconfirm linux-surface linux-surface-headers iptsd

    # Set linux-surface as default Limine boot option if Limine is used
    limine_default="/etc/default/limine"
    if [ -f "$limine_default" ] || command -v limine-update >/dev/null 2>&1; then
        echo "==> Setting linux-surface as the default Limine boot option..."
        if [ -f "$limine_default" ]; then
            if ! grep -q "\*surface" "$limine_default"; then
                sudo sed -i -E 's/BOOT_ORDER="([^"]*)"/BOOT_ORDER="*surface, \1"/' "$limine_default"
            fi
        else
            echo 'BOOT_ORDER="*surface, *, *lts, *fallback, Snapshots"' | sudo tee -a "$limine_default" >/dev/null
        fi

        if command -v limine-update >/dev/null 2>&1; then
            echo "==> Updating Limine boot entries..."
            sudo limine-update || true
        fi
    fi
fi

# 3. Install Dank Material Shell (DMS) + Hyprland + Alacritty if not already installed
if ! command -v dms >/dev/null 2>&1; then
    echo "==> Installing Dank Material Shell (DMS)..."
    curl -fsSL https://install.danklinux.com | sh -s -- -c hyprland -t alacritty -y
else
    echo "==> DMS already installed, skipping installer."
fi

# 4. Ensure git and chezmoi are installed
echo "==> Ensuring git and chezmoi are installed..."
sudo pacman -S --needed --noconfirm git chezmoi

# 5. Initialize and apply dotfiles
DOTFILES_REPO="https://github.com/brschneider/dotfiles.git"

echo "==> Initializing and applying chezmoi from $DOTFILES_REPO..."
chezmoi init --apply --force "$DOTFILES_REPO"

echo "========================================="
echo "   Bootstrapping Complete! 🎉"
echo "========================================="

# 6. Launch Hyprland / DMS session
if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ]; then
    echo "==> Starting Hyprland with Dank Material Shell..."
    if command -v uwsm >/dev/null 2>&1; then
        exec uwsm start hyprland-uwsm.desktop || exec Hyprland
    elif command -v Hyprland >/dev/null 2>&1; then
        exec Hyprland
    elif command -v hyprland >/dev/null 2>&1; then
        exec hyprland
    elif systemctl is-enabled greetd.service >/dev/null 2>&1; then
        echo "==> Starting greetd service..."
        sudo systemctl start greetd.service
    fi
else
    echo "==> Graphical session already active ($WAYLAND_DISPLAY). Reloading configuration..."
    if command -v hyprctl >/dev/null 2>&1; then
        hyprctl reload || true
    fi
    if command -v dms >/dev/null 2>&1; then
        dms restart || true
    fi
fi
