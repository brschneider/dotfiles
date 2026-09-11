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

# 2. Enable user dms.service
if systemctl --user list-unit-files dms.service >/dev/null 2>&1; then
    systemctl --user daemon-reload
    if ! systemctl --user is-enabled dms.service >/dev/null 2>&1; then
        echo "Enabling user dms.service..."
        systemctl --user enable dms.service
    fi
fi

echo "==> Services successfully configured."
