# Dank Material Shell (DMS) IPC Reference

DMS communicates with running instances using `dms ipc call <component> <method> [args...]`.

## Common IPC Calls

| Component | Method | Example Command | Description |
|-----------|--------|-----------------|-------------|
| `control-center` | `toggle`, `open`, `hide` | `dms ipc call control-center toggle` | Toggle Quick Settings & Control Center |
| `dash` | `toggle`, `open`, `close` | `dms ipc call dash toggle` | Toggle App Dashboard |
| `dash` | `toggle` `wallpaper` | `dms ipc call dash toggle wallpaper` | Open Dash on Wallpaper picker tab |
| `hypr` | `toggleOverview` | `dms ipc call hypr toggleOverview` | Open/close workspace overview grid |
| `hypr` | `toggleBinds` | `dms ipc call hypr toggleBinds` | Open keybindings cheatsheet |
| `launcher` | `toggle`, `open`, `openWith` | `dms ipc call launcher toggle` | Application runner / launcher |
| `powermenu` | `toggle`, `open`, `close` | `dms ipc call powermenu toggle` | Power & session menu (shutdown, reboot, etc.) |
| `theme` | `toggle`, `dark`, `light` | `dms ipc call theme toggle` | Switch between Dark and Light mode |
| `wallpaper` | `next`, `prev`, `set <path>` | `dms ipc call wallpaper next` | Cycle or set current desktop wallpaper |
| `lock` | `lock`, `status` | `dms ipc call lock lock` | Lock Wayland session |
| `notifications` | `toggle`, `clearAll`, `toggleDoNotDisturb` | `dms ipc call notifications toggle` | Notification center & history |
| `spotlight` | `toggle`, `open` | `dms ipc call spotlight toggle` | Spotlight quick finder / command runner |
| `clipboard` | `toggle`, `open` | `dms ipc call clipboard toggle` | Clipboard history manager |
| `color-picker`| `toggleInstant` | `dms ipc call color-picker toggleInstant` | Screen color picker tool |
| `dock` | `toggle`, `toggleAutoHide` | `dms ipc call dock toggle` | Toggle desktop dock visibility |
| `mpris` | `playPause`, `next`, `previous` | `dms ipc call mpris playPause` | Media playback controls |
| `night` | `toggle`, `setTargetTemp` | `dms ipc call night toggle` | Blue light filter / night mode |
| `window-rules`| `toggle` | `dms ipc call window-rules toggle` | DMS window rule manager GUI |

## IPC Syntax in Hyprland Lua

When binding DMS IPC calls in `~/.config/hypr/dms/binds.lua`:

```lua
-- Standard command execution via DMS dispatcher
hl.bind("SUPER + TAB", hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("dms ipc call powermenu toggle"))
hl.bind("SUPER + Y", hl.dsp.exec_cmd("dms ipc call dash toggle wallpaper"))
```
