# Day 09 Challenge – Users & Groups Management

## 📌 Objective
Learn and practice Linux user management, group management, directory permissions, and ownership handling.

---

## 👤 Users Created
- tokyo
- berlin
- professor
- nairobi

---

## 👥 Groups Created
- developers
- admins
- project-team

---

## 🔗 Group Assignments
- **developers** → tokyo, berlin  
- **admins** → berlin, professor  
- **project-team** → nairobi, tokyo  

---

## 📁 Directories Created
- `/opt/dev-project`
- `/opt/dev-team-workspace`

---

## 🔐 Permissions Applied
- Group permission: **775**
- Correct group ownership assigned

### Permission Meaning (775)
| Owner | Group | Others |
|------|-------|--------|
| rwx  | rwx   | r-x    |

---

## 🧾 Commands Used

### 🔹 Create User with Home Directory
```bash
sudo useradd -m tokyo
sudo passwd tokyo
-m creates the home directory under /home/

🔹 Create Groups
sudo groupadd developers
sudo groupadd admins
sudo groupadd project-team

🔹 Add Users to Groups
sudo usermod -aG developers tokyo
sudo usermod -aG developers berlin
sudo usermod -aG admins berlin
sudo usermod -aG admins professor
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo
-aG safely appends user to group without removing existing groups

🔹 Create Directories
sudo mkdir /opt/dev-project
sudo mkdir /opt/dev-team-workspace

🔹 Change Group Ownership
sudo chown :developers /opt/dev-project
sudo chown :project-team /opt/dev-team-workspace

🔹 Set Directory Permissions
sudo chmod 775 /opt/dev-project
sudo chmod 775 /opt/dev-team-workspace


🔁 Switching Users (Important Concept)

su - tokyo
pwd
/home/tokyo


🔑 Key Difference

su user → changes user only

su - user → changes user, home directory, and environment

📘 What I Learned

How to create users and groups
How to assign users to multiple groups
How to manage directory permissions
How to change group ownership
Difference between su and su -
Real-world Linux permission troubleshooting
