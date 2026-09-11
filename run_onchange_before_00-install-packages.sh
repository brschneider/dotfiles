#!/usr/bin/env bash
set -eo pipefail

# Hashes used to detect changes:
# pkglist-native.txt hash: {{ include "pkglist-native.txt" | sha256sum }}
# pkglist-aur.txt hash: {{ include "pkglist-aur.txt" | sha256sum }}
# pkglist-flatpak.txt hash: {{ include "pkglist-flatpak.txt" | sha256sum }}

CHEZMOI_DIR="{{ .chezmoi.sourceDir }}"

echo "==> Checking & installing package lists..."

# 1. Hardware-specific: Microsoft Surface detection & linux-surface kernel
dmi_vendor=$(cat /sys/devices/virtual/dmi/id/sys_vendor 2>/dev/null || true)
dmi_product=$(cat /sys/devices/virtual/dmi/id/product_name 2>/dev/null || true)

if echo "$dmi_vendor $dmi_product" | grep -qi "surface"; then
    echo "==> Microsoft Surface hardware detected ($dmi_product)!"
    if ! pacman-key --list-keys 56C464BAAC421453 >/dev/null 2>&1; then
        echo "==> Importing linux-surface key..."
        curl -s https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc \
            | sudo pacman-key --add -
        sudo pacman-key --finger 56C464BAAC421453
        sudo pacman-key --lsign-key 56C464BAAC421453
    fi

    if ! grep -q "^\[linux-surface\]" /etc/pacman.conf; then
        echo "==> Adding [linux-surface] repository to /etc/pacman.conf..."
        sudo bash -c 'cat >> /etc/pacman.conf << '\''EOF'\''

[linux-surface]
Server = https://pkg.surfacelinux.com/arch/
EOF'
        sudo pacman -Sy
    fi

    echo "==> Ensuring linux-surface kernel, headers, and iptsd are installed..."
    sudo pacman -S --needed --noconfirm linux-surface linux-surface-headers iptsd

    # Ensure linux-surface is the default Limine boot option if Limine is used
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

# 2. Native packages via pacman
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
