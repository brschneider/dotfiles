# Dank Material Shell Troubleshooting & Diagnostics

## Diagnostic Checklist

1. **Run Built-in Diagnostics**:
   ```bash
   dms doctor
   ```
   Checks Quickshell version, polkit, blur support, optional dependencies (`matugen`, `cava`, `khal`, `adw-gtk3`), and config file health.

2. **Check Systemd User Service**:
   ```bash
   systemctl --user status dms.service
   journalctl --user -u dms.service -e --no-pager
   ```

3. **Restart DMS**:
   ```bash
   dms restart
   ```
   Or force kill and restart:
   ```bash
   dms kill && systemctl --user restart dms.service
   ```

4. **Verify IPC Server**:
   ```bash
   dms ipc call settings get
   ```

5. **Backup & Restore**:
   ```bash
   dms backup export /path/to/backup.tar.gz
   dms backup import /path/to/backup.tar.gz
   ```
