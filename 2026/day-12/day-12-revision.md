# Day 12 – Breather & Revision (Days 01–11)

## 1. Which 3 commands save you the most time right now, and why?

### a) `sudo chown -R owner:group directory`

* `-R` means recursive.
* Changes ownership of the parent directory and all its child files and directories.
* Very useful when managing large directory structures.

### b) `sudo chmod 775 file/directory`

* Grants full permissions to owner and group.
* Allows read and execute permission for others.
* Commonly used for shared directories in teams.

### c) `systemctl list-units --type=service`

* Lists all active services running on the system.
* Helpful for quickly checking which services are currently loaded.

---

## 2. How do you check if a service is healthy?

### Commands:

```bash
sudo systemctl status <service>
journalctl -u <service> -n 50
```

* `systemctl status` shows service state (active, failed, inactive).
* `journalctl` displays recent logs for troubleshooting.

---

## 3. How do you safely change ownership and permissions without breaking access?

### Ownership change example:

```bash
sudo chown user:group directory
```

### Safe permission example:

```bash
sudo chmod 755 directory
```

* Avoid using `chmod 777` as it gives full access to everyone and is insecure.
* Always follow the principle of least privilege.

---

## 4. What will you focus on improving in the next 3 days?

* Revising previously covered Linux concepts.
* Completing daily DevOps tasks consistently.
* Learning Python for DevOps and strengthening Python fundamentals.

---
