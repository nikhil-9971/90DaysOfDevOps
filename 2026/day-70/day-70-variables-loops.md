# Day 70 — Variables, Facts, Conditionals & Loops

## 📁 Directory Structure

```
ansible-project/
├── inventory.ini
├── ansible.cfg
├── group_vars/
│   └── web.yml
├── host_vars/
│   ├── worker-ubuntu.yml
│   └── control-node-ubuntu.yml
├── playbooks/
│   ├── variables-demo.yml
│   ├── facts-demo.yml
│   ├── conditionals-demo.yml
│   └── loops-demo.yml
```

---

## ⚙️ Variable Precedence (with examples)

Order (highest → lowest):

1. Extra vars (`-e`)
2. Task vars
3. Host vars
4. Group vars
5. Play vars
6. Defaults

### Example:
- group_vars/web.yml:
```
http_port: 80
```

- host_vars/worker-ubuntu.yml:
```
http_port: 8080
```

👉 Result:
```
worker-ubuntu → 8080 (host_vars overrides group_vars)
```

---

## 🧠 Five Useful Ansible Facts

### 1. ansible_os_family
Used to choose package manager (apt/yum)

### 2. ansible_distribution
Used for OS-specific configs

### 3. ansible_memtotal_mb
Used for resource-based decisions

### 4. ansible_default_ipv4.address
Used in service configs (Nginx, apps)

### 5. ansible_hostname
Used for logging and identification

---

## 🔀 Conditional Playbook Example

```
- name: Install nginx on Ubuntu
  apt:
    name: nginx
    state: present
  when: ansible_os_family == "Debian"

- name: Install httpd on RedHat
  yum:
    name: httpd
    state: present
  when: ansible_os_family == "RedHat"
```

### 📸 Screenshot (Expected)
- Ubuntu → nginx task runs ✅
- RedHat → httpd task runs ✅
- Other task → skipped ⏭️

---

## 🔁 Loop Playbook Example

```
- name: Create users
  user:
    name: "{{ item }}"
    state: present
  loop:
    - deploy
    - monitor
    - appuser
```

### 📸 Screenshot (Expected)
- Shows multiple iterations:
```
(item=deploy)
(item=monitor)
(item=appuser)
```

---

## 📊 Server Report Output (Task 6)

```
Hostname: worker-ubuntu
OS: Ubuntu 22.04
RAM: 1024MB
IP: 100.x.x.x

Hostname: control-node-ubuntu
OS: Ubuntu 22.04
RAM: 2048MB
IP: 54.x.x.x
```

---

## 🚀 Summary

- Used group_vars and host_vars effectively
- Understood variable precedence
- Used facts for dynamic playbooks
- Implemented conditionals and loops
- Generated server report dynamically
