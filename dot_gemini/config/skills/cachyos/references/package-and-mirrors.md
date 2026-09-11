# CachyOS Package Management & Repositories

CachyOS provides optimized repositories compiled specifically for modern CPU instruction sets:
- `x86-64-v3` (AVX, AVX2, BMI1, BMI2, FMA)
- `x86-64-v4` (AVX-512)

## Mirror Ranking

Before updating or when experiencing slow downloads:

```bash
sudo cachyos-rate-mirrors
```
This tests and ranks the fastest CachyOS and Arch mirrors and writes them to `/etc/pacman.d/cachyos-mirrorlist`.

## System Updates

```bash
# Update native packages & AUR
yay -Syu
# Or pacman directly:
sudo pacman -Syu
```

## GUI Tools
- `cachyos-pi`: CachyOS Package Installer (quick installer for gaming, development environments, and browsers).
- `cachyos-hello`: First-steps welcome app for quick tweaks and repo configurations.
