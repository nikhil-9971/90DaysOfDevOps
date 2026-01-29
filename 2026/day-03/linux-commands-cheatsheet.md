Day -03_Linux Commands Practice

Document Owner_ Nikhil Trivedi
Date of Document Creation_29-01-2026


### Process Management

- `ps aux` → Shows **all running processes** with user & resource usage
- `ps -ef` → Full detailed list of running processes
- `top` → **Live view** of CPU & memory usage
- `htop` → Better, interactive version of `top`
- `pgrep nginx` → Finds **PID of nginx process**
- `pidof nginx` → Another way to get process PID
- `pstree` → Shows **parent–child process relationship**
- `kill PID` → Stops process **gracefully**
- `kill -9 PID` → **Force stops** process (last option)
- `killall nginx` → Stops **all nginx processes**
- `command &` → Runs command in background
- `jobs` → Shows background jobs
- `fg` / `bg` → Move job to foreground/background
- `uptime` → Shows system load
- `free -h` → Memory usage (human-readable)

---

### File System

- `pwd` → Shows current directory
- `ls -la` → Lists files with permissions & hidden files
- `cd` → Change directory
- `touch` → Create empty file
- `mkdir` → Create directory
- `rm` → Delete file
- `rm -rf`-> Delete Directory
- `cp` → Copy files
- `mv` → Move or rename files
- `cat` → View file content
- `echo` -> Quick update in file
- `vi`-> vi is a editor which use write content/Intrection (How to use-> i(insert mode)->write content-> ESC(Command mode)-> :wq(save & exit)
- `less` → Read file page by page
- `head` → First 10 lines of file
- `tail` → Last 10 lines of file
- `tail -f` → **Live log monitoring**
- `find` → Search files by name
- `grep` → Search text inside files
- `chmod` → Change permissions
- `chown` → Change file owner

---

### Networking

- `ip a` → Show IP addresses
- `ip r` → Show routing table
- `ping` → Check server connectivity
- `traceroute` → Find network path issues
- `ss -tulnp` → Show open ports & services
- `netstat` → Older port-check tool
- `lsof -i :80` → Check what uses port 80
- `nslookup` / `dig` → DNS troubleshooting
- `curl` → Test APIs & web services
- `wget` → Download files
