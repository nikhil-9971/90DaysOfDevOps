# Day 71 - Roles, Templates, and Vault

## 1. Webserver Role Directory Structure
```
roles/
  webserver/
    tasks/main.yml
    handlers/main.yml
    templates/
      nginx.conf.j2
      vhost.conf.j2
      index.html.j2
    vars/main.yml
    defaults/main.yml
```

---

## 2. Jinja2 Templates

### nginx.conf.j2
- Dynamic user
- Worker processes auto
- Configurable keepalive and gzip

### vhost.conf.j2
- Dynamic port and server name
- App-specific root and logs

### Example Rendered Output
```
server {
    listen 80;
    server_name ip-172-31-33-209;

    root /var/www/terraweek-app;
}
```

---

## 3. Role Execution
- Installed Nginx
- Deployed configs
- Created web root
- Started service

(Screenshot placeholder)

---

## 4. Ansible Galaxy Role Usage
```
ansible-galaxy install geerlingguy.nginx
```

Used in playbook:
```
roles:
  - geerlingguy.nginx
```

---

## 5. Vault Workflow

### Create
```
ansible-vault create group_vars/all.yml
```

### Edit
```
ansible-vault edit group_vars/all.yml
```

### View
```
ansible-vault view group_vars/all.yml
```

### Encrypt
```
ansible-vault encrypt file.yml
```

### Decrypt
```
ansible-vault decrypt file.yml
```

---

## 6. Encrypted Vault File Example
```
$ANSIBLE_VAULT;1.1;AES256
616263643...
```

(Screenshot placeholder)

---

## 7. When to Use What

### Roles
- Reusable configurations
- Large projects

### Playbooks
- Orchestration
- Combine multiple roles

### Ad-hoc Commands
- Quick tasks
- One-time operations

---

## Summary
- Roles improve structure and reuse
- Templates enable dynamic configs
- Vault secures sensitive data
