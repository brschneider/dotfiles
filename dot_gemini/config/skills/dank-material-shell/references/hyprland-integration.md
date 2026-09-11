# Dank Material Shell (DMS) - Hyprland Lua Integration

DMS is deeply integrated with Hyprland through modular Lua configuration files in `~/.config/hypr/dms/` (tracked in chezmoi at `~/.local/share/chezmoi/dot_config/hypr/dms/`).

## Architecture & Configuration Files

In `~/.config/hypr/hyprland.lua`, DMS modules are loaded at runtime:

```lua
require("dms/colors")
require("dms/layout")
require("dms/cursor")
require("dms/outputs")
require("dms/windowrules")
require("dms/binds")
require("dms/binds-user")
```

### Module Responsibilities

1. **`binds.lua`**:
   - Manages core compositor keybindings, application shortcuts, workspace navigation, and DMS IPC triggers.
   - User customizations should ideally go in `binds-user.lua` to avoid being overwritten during automated DMS setup updates.

2. **`colors.lua`**:
   - Generated dynamic colors derived from the active wallpaper via `matugen` Material You theming.
   - Provides active/inactive border colors, titlebar accents, and widget highlights.

3. **`windowrules.lua`**:
   - Contains Hyprland window and layer rules for DMS surfaces.
   - Ensures DMS popups, launcher, dash, dock, and control center blur and float appropriately:
     ```lua
     hl.window_rule({ match = { class = "^(dms-.*)$" }, float = true })
     ```

4. **`layout.lua` & `outputs.lua`**:
   - Screen geometry, monitor scaling, gaps, and window layout configuration synced with DMS display preferences.

## Restarting and Reloading

- **Reload Hyprland Config**:
  `hyprctl reload`
- **Restart DMS UI & Backend**:
  `dms restart` or `systemctl --user restart dms.service`
