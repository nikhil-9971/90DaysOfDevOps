# 🧠 Day 11 Challenge – Linux Ownership & Groups

## 📁 Files & Directories Created

| No | Name                | Type      |
| -- | ------------------- | --------- |
| 1  | devops-file.txt     | File      |
| 2  | team-notes.txt      | File      |
| 3  | project-config.yaml | File      |
| 4  | app-logs            | Directory |
| 5  | heist-project       | Directory |
| 6  | vault               | Directory |
| 7  | plans               | Directory |
| 8  | gold.txt            | File      |
| 9  | strategy.conf       | File      |
| 10 | bank-hiest          | Directory |
| 11 | access-codes.txt    | File      |
| 12 | blueprints.pdf      | File      |
| 13 | escape-plan.txt     | File      |

---

## 👤 Ownership Changes Performed

| Resource            | Before        | After                 |
| ------------------- | ------------- | --------------------- |
| devops-file.txt     | ubuntu:ubuntu | tokyo:ubuntu          |
| team-notes.txt      | ubuntu:ubuntu | ubuntu:heist-team     |
| project-config.yaml | ubuntu:ubuntu | professors:heist-team |
| app-logs            | ubuntu:ubuntu | berlin:heist-team     |
| heist-project       | ubuntu:ubuntu | professors:planners   |
| vault               | ubuntu:ubuntu | professors:planners   |
| plans               | ubuntu:ubuntu | professors:planners   |
| gold.txt            | ubuntu:ubuntu | professors:planners   |
| strategy.conf       | ubuntu:ubuntu | professors:planners   |
| bank-hiest          | ubuntu:ubuntu | ubuntu:ubuntu         |
| access-codes.txt    | ubuntu:ubuntu | tokyo:vault-team      |
| blueprints.pdf      | ubuntu:ubuntu | berlin:tech-team      |
| escape-plan.txt     | ubuntu:ubuntu | nairobi:vault-team    |

---

## 🖥️ Commands Used

### 🔹 Basic File & Directory Operations

```bash
ls -l
touch devops-file.txt
ls -l devops-file.txt
```

### 🔹 Change Ownership (User Only)

```bash
sudo chown tokyo devops-file.txt
```

### 🔹 Create File & Assign Group

```bash
touch team-notes.txt
sudo groupadd heist-team
sudo chown :heist-team team-notes.txt
```

### 🔹 Change Owner & Group Together

```bash
touch project-config.yaml
sudo chown professors:heist-team project-config.yaml
```

### 🔹 Directory Ownership

```bash
mkdir app-logs
sudo chown berlin:heist-team app-logs
```

### 🔹= Recursive Ownership

```bash
mkdir -p heist-project/vault
mkdir -p heist-project/plans
touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf
sudo groupadd planners
sudo chown -R professors:planners heist-project
ls -lR heist-project/
```

### 🔹 Bank Heist Scenario

```bash
sudo groupadd vault-team
sudo groupadd tech-team
mkdir bank-hiest
touch bank-hiest/access-codes.txt
touch bank-hiest/blueprints.pdf
touch bank-hiest/escape-plan.txt

sudo chown tokyo:vault-team bank-hiest/access-codes.txt
sudo chown berlin:tech-team bank-hiest/blueprints.pdf
sudo chown nairobi:vault-team bank-hiest/escape-plan.txt
ls -lR bank-hiest/
```

---

## 📚 What I Learned

1. How to change file and directory ownership using `chown`
2. How to apply ownership changes recursively using `-R`
3. How to change **owner and group together in a single command**


