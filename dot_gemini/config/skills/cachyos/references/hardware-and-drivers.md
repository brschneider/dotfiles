# CachyOS Hardware & Driver Management (`chwd`)

CachyOS provides `chwd` (CachyOS Hardware Detection) to manage drivers (GPU, CPU microcode, Wi-Fi, audio) automatically or manually.

## Key Commands

| Action | Command |
|--------|---------|
| List installed profiles | `chwd --list-installed` |
| List available profiles | `chwd --list` |
| Autoconfigure hardware | `sudo chwd -a` |
| Install specific driver | `sudo chwd -i <profile>` |
| Remove driver profile | `sudo chwd -r <profile>` |
| Kernel management | `cachyos-kernel-manager` or `chwd-kernel` |

## Graphics Drivers (Wayland & Hyprland)

- **AMD / Intel**: Supported out of the box with Mesa and Vulkan (`vulkan-radeon` / `vulkan-intel`).
- **NVIDIA**: Profile installation via `sudo chwd -i nvidia` installs the proper proprietary driver matching the active CachyOS kernel, configuring DRM kernel modesetting (`nvidia_drm.modeset=1`) for Wayland compositors like Hyprland.
