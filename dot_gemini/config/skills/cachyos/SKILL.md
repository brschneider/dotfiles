---
name: cachyos
description: >-
  Use this skill when administering, tuning, troubleshooting, or updating
  a CachyOS Linux system. Covers CachyOS hardware detection (`chwd`),
  kernel manager (`cachyos-kernel-manager`, BORE scheduler, sched-ext),
  mirror ranking (`cachyos-rate-mirrors`), pacman/yay package management,
  performance daemons (ananicy-cpp, systemd-oomd), and bug reporting (`cachyos-bugreport.sh`).
version: 1.0.0
---

# CachyOS System Administration Skill

CachyOS is a high-performance Arch Linux-based distribution with optimized x86-64-v3/v4 package repos and low-latency kernels.

## Quick Reference

- **Hardware Detection & Drivers**: `chwd` (`chwd --list-installed`, `sudo chwd -a`)
- **Kernel Management**: `cachyos-kernel-manager`, `chwd-kernel`
- **Mirror Ranking**: `sudo cachyos-rate-mirrors`
- **Package Updates**: `yay -Syu` or `sudo pacman -Syu`
- **Diagnostics & Bug Reports**: `cachyos-bugreport.sh`, `paste-cachyos`
- **System Welcome & App Installer**: `cachyos-hello`, `cachyos-pi`

## Sub-documentation References

- Hardware & Driver Management: [references/hardware-and-drivers.md](./references/hardware-and-drivers.md)
- Package Repositories & Mirrors: [references/package-and-mirrors.md](./references/package-and-mirrors.md)
- Performance Tuning & Kernels: [references/performance-and-kernel.md](./references/performance-and-kernel.md)
