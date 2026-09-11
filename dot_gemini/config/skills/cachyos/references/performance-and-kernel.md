# CachyOS Performance Tuning & Kernel Management

## Custom Performance Kernels

CachyOS includes custom kernel packages featuring CPU scheduler optimizations:
- **`linux-cachyos`**: Default kernel with BORE (Burst-Oriented Response Enhancer) scheduler.
- **`linux-cachyos-sched-ext`**: Kernel with extensible scheduler framework (`scx`) allowing userspace schedulers like `scx_rusty`, `scx_lavd`, or `scx_bpfland`.
- **`cachyos-kernel-manager`**: GUI/TUI tool to install, configure, or rebuild kernels with tailored schedulers and LTO options.

## System Performance Services

1. **`ananicy-cpp`**:
   Auto-nice daemon that automatically prioritizes foreground interactive apps, games, audio, and Wayland compositors (Hyprland).
   ```bash
   systemctl status ananicy-cpp
   ```

2. **`systemd-oomd`**:
   Out-of-memory daemon managing memory pressure via PSI (Pressure Stall Information).

3. **Paste & Bug Reporting**:
   - `cachyos-bugreport.sh`: Generates complete system diagnostic logs.
   - `paste-cachyos <file>`: Uploads logs to CachyOS pastebin for sharing.
