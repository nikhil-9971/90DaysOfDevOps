# 🚀 Day 10 – Linux File Permissions Challenge

## 📂 Files Created

We created **3 files**:

* `devOps.txt`
* `notes.txt`
* `script.sh`

---

## 🔐 Permission Changes

| File         | Before       | After        |
| ------------ | ------------ | ------------ |
| `devOps.txt` | `-rw-rw-r--` | `-r--r--r--` |
| `notes.txt`  | `-rw-rw-r--` | `-rw-r-----` |
| `script.sh`  | `-rw-r--r--` | `-rwxr-xr-x` |

---

## 🧾 Commands Used

### 🔹 Task 1: Create Files

```bash
touch devOps.txt
echo "Hello Friend" > notes.txt
vim script.sh
```

Inside **vim**:

```text
i
echo "Hello DevOps"
Esc
:wq
```

---

### 🔹 Task 2: Read Files

```bash
cat notes.txt
vim -R script.sh
head -n 10 /etc/passwd
tail -n 10 /etc/passwd
```

---

### 🔹 Task 3: Check Initial Permissions

```bash
ls -l devOps.txt notes.txt script.sh
```

Output:

```text
-rw-rw-r-- 1 ubuntu ubuntu  0 Feb  2 16:14 devOps.txt
-rw-rw-r-- 1 ubuntu ubuntu 21 Feb  2 16:17 notes.txt
-rw-r--r-- 1 ubuntu ubuntu 13 Feb  2 16:18 script.sh
```

---

### 🔹 Task 4: Modify Permissions

```bash
chmod +x script.sh
chmod 444 devOps.txt
chmod 640 notes.txt
mkdir project
chmod 755 project
```

Verify:

```bash
ls -l
```

```text
-r--r--r-- 1 ubuntu ubuntu  0 Feb  2 16:14 devOps.txt
-rw-r----- 1 ubuntu ubuntu 21 Feb  2 16:17 notes.txt
-rwxr-xr-x 1 ubuntu ubuntu 13 Feb  2 16:18 script.sh
```

Directory permissions:

```bash
ls -ld project
```

```text
drwxr-xr-x 2 ubuntu ubuntu 4096 Feb  2 16:35 project
```

---

### 🔹 Task 5: Test Permissions

❌ Writing to a read-only file:

```bash
echo "Hi Friend" > devOps.txt
```

Error:

```text
-bash: devOps.txt: Permission denied
```

❌ Executing script without execute permission:

```bash
chmod -x script.sh
./script.sh
```

Error:

```text
-bash: ./script.sh: Permission denied
```

---

## 📘 What I Learned

1. How to create files using `touch`, `echo`, and `vim`
2. How to set permissions for files and directories using `chmod`
3. Why execute (`x`) permission is required to run a script


