---
name: dank-material-shell
description: >-
  Use this skill when configuring, customizing, troubleshooting, or controlling
  Dank Material Shell (DMS) for Wayland/Hyprland. Covers DMS CLI (`dms`),
  IPC commands (`dms ipc call`), Matugen Material 3 dynamic theming,
  modular Hyprland Lua binds (`dms/binds.lua`), widget settings (`settings.json`),
  and plugins.
version: 1.0.0
---

# Dank Material Shell (DMS) Skill

DMS is a modern, Material 3-inspired desktop shell built on Quickshell and Go for Wayland compositors (specifically integrated with Hyprland).

## Quick Reference

- **CLI Management**: `dms`
- **IPC Commands**: `dms ipc call <component> <method> [args]`
- **System Health**: `dms doctor`
- **Restart Shell**: `dms restart` (or `systemctl --user restart dms.service`)
- **Config Root**: `~/.config/DankMaterialShell/`
- **Hyprland Integration**: `~/.config/hypr/dms/`

## Key Workflows

### 1. Triggering DMS Panels from Hyprland Lua
In `~/.config/hypr/dms/binds.lua` or `binds-user.lua`:
```lua
hl.bind("SUPER + TAB", hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("dms ipc call powermenu toggle"))
hl.bind("SUPER + Y", hl.dsp.exec_cmd("dms ipc call dash toggle wallpaper"))
```

### 2. Theming & Wallpapers
- Switch themes dynamically:
  ```bash
  dms ipc call theme toggle    # Switch light/dark
  dms ipc call wallpaper next  # Cycle wallpaper & re-run matugen palette
  ```

### 3. Sub-documentation References
- IPC Methods: [references/ipc.md](./references/ipc.md)
- Hyprland Integration: [references/hyprland-integration.md](./references/hyprland-integration.md)
- Diagnostics & Troubleshooting: [references/troubleshooting.md](./references/troubleshooting.md)
