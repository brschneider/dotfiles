#!/bin/bash
# Hash of plugins.lock.json: {{ include "dot_config/DankMaterialShell/plugins.lock.json" | sha256sum }}

if command -v dms >/dev/null 2>&1; then
    echo "Restoring DMS plugins from lockfile..."
    dms plugins restore "$HOME/.config/DankMaterialShell/plugins.lock.json"
fi

SKILLS_DIR="$HOME/.gemini/config/skills"
mkdir -p "$SKILLS_DIR"
if [ ! -d "$SKILLS_DIR/hyprland" ]; then
    echo "Cloning hyprland AI skill..."
    git clone --depth 1 https://github.com/marceloeatworld/hyprland-ai-skill.git "$SKILLS_DIR/hyprland"
fi
