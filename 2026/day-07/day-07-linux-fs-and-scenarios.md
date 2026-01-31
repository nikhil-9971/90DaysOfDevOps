Day 07 – Linux File System Hierarchy & Scenario-Based Practice

Task1- Linux File System Hierarchy (the most important directories)

/        → Root of everything
/bin     → Essential user commands (ls, cp, mv)
/sbin    → System/admin commands (reboot, ip, fsck)
/etc     → Configuration files (MOST IMPORTANT)
/var     → Logs & variable data
/home    → User home directories
/root    → Root user’s home
/tmp     → Temporary files
/usr     → Installed software & binaries
/opt     → Optional / third-party apps



Scenario 1: Service Not Starting

A web application service called 'myapp' failed to start after a server reboot.
What commands would you run to diagnose the issue?
Write at least 4 commands in order.

Step 1 $ systemctl status myapp (to Check myapp status is is running or not)
Step 2 $ systemctl is-enabled myapp (To know if it will start automatically after reboot)
Step 3 $ systemctl journal -u myapp -n 50 (to check log in 50 lines)


Scenario 2: High CPU Usage

Your manager reports that the application server is slow.
You SSH into the server. What commands would you run to identify
which process is using high CPU?

Check -> top or htop

Commmand-> ps aux --sort=-%cpu | head -10

Scenario 3: Finding Service Logs

A developer asks: "Where are the logs for the 'docker' service?"
The service is managed by systemd.
What commands would you use?

# Check service status first
systemctl status docker

# View last 50 lines of logs
journalctl -u docker -n 50

# Follow logs in real-time
journalctl -u docker -f

Scenario 4: File Permissions Issue

A script at /home/user/backup.sh is not executing.
When you run it: ./backup.sh
You get: "Permission denied"

What commands would you use to fix this?

Step 1: Check current permissions
Command: ls -l /home/user/backup.sh
Look for: -rw-r--r-- (notice no 'x' = not executable)

Step 2: Add execute permission
Command: chmod 664 /home/user/backup.sh

Step 3: Verify it worked
Command: ls -l /home/user/backup.sh
Look for: -rwxr-xr-x (notice 'x' = executable)

Step 4: Try running it
Command: ./backup.sh

