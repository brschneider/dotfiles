#!/usr/bin/env bash
set -eo pipefail

echo "==> Configuring and enabling system services..."

# 1. Enable and configure greetd with dms-greeter if installed
if command -v dms-greeter >/dev/null 2>&1; then
    echo "Configuring dms-greeter..."
    sudo dms-greeter enable 2>/dev/null || true
    sudo dms-greeter sync 2>/dev/null || true
fi

if systemctl list-unit-files greetd.service >/dev/null 2>&1; then
    if ! systemctl is-enabled greetd.service >/dev/null 2>&1; then
        echo "Enabling greetd.service..."
        sudo systemctl enable greetd.service
    fi
fi

# 2. Enable user dms.service and reload user systemd daemons
systemctl --user daemon-reload

if systemctl --user list-unit-files dms.service >/dev/null 2>&1; then
    if ! systemctl --user is-enabled dms.service >/dev/null 2>&1; then
        echo "Enabling user dms.service..."
        systemctl --user enable dms.service
    fi
fi

# 3. Enable GNOME Keyring daemon socket/service if present
if systemctl --user list-unit-files gnome-keyring-daemon.socket >/dev/null 2>&1; then
    if ! systemctl --user is-enabled gnome-keyring-daemon.socket >/dev/null 2>&1; then
        echo "Enabling user gnome-keyring-daemon.socket..."
        systemctl --user enable gnome-keyring-daemon.socket
    fi
fi

# 4. Enable wl-clip-persist.service if present
if systemctl --user list-unit-files wl-clip-persist.service >/dev/null 2>&1; then
    if ! systemctl --user is-enabled wl-clip-persist.service >/dev/null 2>&1; then
        echo "Enabling user wl-clip-persist.service..."
        systemctl --user enable wl-clip-persist.service
    fi
# 5. Apply font preferences (JetBrains Mono)
if command -v gsettings >/dev/null 2>&1; then
    echo "==> Applying desktop font preferences..."
    gsettings set org.gnome.desktop.interface font-name 'JetBrains Mono 11' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 11' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface document-font-name 'JetBrains Mono 11' 2>/dev/null || true
fi

# 6. Refresh font cache
if command -v fc-cache >/dev/null 2>&1; then
    echo "==> Refreshing font cache..."
    fc-cache -f >/dev/null 2>&1 || true
fi

echo "==> Services and system configurations successfully applied."


