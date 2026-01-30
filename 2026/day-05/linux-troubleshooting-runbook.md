# Day 05 – Linux Troubleshooting Runbook

## Target Service
SSH

---

## Environment
- uname -a: Checked kernel and architecture
- OS: Ubuntu Linux

---

## Snapshot: CPU & Memory
- top: CPU usage normal, no spikes
- free -h: Sufficient free memory available

---

## Snapshot: Disk & IO
- df -h: Root disk usage under safe limits
- du -sh /var/log: Logs size normal

---

## Snapshot: Network
- ss -tulpn: SSH listening on port 22
- ping test successful

---

## Logs Reviewed
- journalctl -u ssh: No recent errors
- auth.log: Normal login activity

---

## Quick Findings
System is healthy. SSH service running normally.

---

## If This Worsens (Next Steps)
1. Restart SSH service
2. Enable debug logging
3. Check CPU/memory for spikes during load
