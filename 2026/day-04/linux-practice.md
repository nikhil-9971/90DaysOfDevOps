# Day 04 – Linux Practice: Processes and Services

## Process Checks

### Command: ps aux
Observed running processes with PID, CPU and memory usage.

### Command: top
Observed live CPU and memory usage.
Noticed top resource-consuming processes.

---

## Service Checks (SSH)

### Command: systemctl status ssh
SSH service is active and running.
PID and start time verified.

### Command: systemctl list-units --type=service --state=running
Listed running system services.

---

## Log Checks

### Command: journalctl -u ssh
Checked recent SSH logs.
No critical errors found.

### Command: tail -n 20 /var/log/syslog
Reviewed recent system logs.








