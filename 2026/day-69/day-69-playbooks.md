# Day 69 --- Ansible Playbooks and Modules

## 🧾 1. First Playbook (Annotated)

``` yaml
---
- name: Install and start Nginx on web servers   # PLAY: defines target group
  hosts: web                                     # Runs on 'web' group
  become: true                                   # Run as root (sudo)

  tasks:                                         # List of tasks
    - name: Install Nginx                        # TASK
      apt:                                       # MODULE
        name: nginx                              # Argument
        state: present                           # Ensure installed

    - name: Start and enable Nginx
      service:
        name: nginx
        state: started
        enabled: true

    - name: Create custom index page
      copy:
        content: "<h1>Deployed by Ansible</h1>"
        dest: /var/www/html/index.html
```

------------------------------------------------------------------------

## ⚙️ 2. Essential Modules

### 1. apt

Installs or removes packages.

### 2. service

Manages services (start, stop, enable).

### 3. copy

Copies files from control node to servers.

### 4. file

Creates directories and sets permissions.

### 5. command

Runs simple commands (no shell features).

### 6. shell

Runs commands with shell features like pipes.

### 7. lineinfile

Edits a single line in a file.

------------------------------------------------------------------------

## 📸 3. Playbook Run Output

### First Run (Changed)

\[ Screenshot Placeholder \] - Tasks show "changed"

### Second Run (Idempotency)

\[ Screenshot Placeholder \] - Tasks show "ok"

------------------------------------------------------------------------

## 🔁 4. Idempotency Proof

First Run: - Installs packages → changed

Second Run: - Already installed → ok

------------------------------------------------------------------------

## 🔄 5. Handlers (Before vs After)

### Without Handler

-   Service restarts every time ❌

### With Handler

-   Restarts only when config changes ✅

Example:

``` yaml
notify: Restart Nginx
```

Handler runs only when triggered.

------------------------------------------------------------------------

## 🔍 6. Flags Difference

### --check

-   Dry run (no changes)

### --diff

-   Shows file differences

### -v / -vv / -vvv

-   Debugging output levels

------------------------------------------------------------------------

## ✅ Conclusion

-   Playbooks automate infrastructure
-   Modules perform tasks
-   Handlers optimize execution
-   Idempotency ensures consistency
-   Flags help safe deployment
