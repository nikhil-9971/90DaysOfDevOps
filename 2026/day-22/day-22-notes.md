# Day 22 -Introduction to Git: Your First Repository

## Git Command which have practiced

````bash

-git init- Make a git repository
-git add .- Add all untracked file
-git add <file> -Add this untracked file
-git reset <file>- unstage a file while retaining the changes in working directory
-git commit - "Message" - Write a commit message.
-git status- check what add and current branch
-git config --global user.name-> Adding custom user name
-git config --global user.email-> Adding custom user email
-git branch- Check list of branch
-git rm- delete the file from project and stage the removal for commit
-git checkout -b <custome branch name> -> for adding branch 
-git checkout <branch name>- > To switch another branch
-git switch <branch name>-To switch another branc
-git log-> Checking commit History
-git log --oneline-> Showing compact commit history
-git push-Transmit local branch commits to the remote repository branch
-git pull-fetch and merge any commits from the tracking remote branch
-git clone <url> - retrieve an entire repository from a hosted location via URL

````

## 1. git add vs git commit

**git add**
- Ye changes ko staging area me bhejta hai  
- Matlab Git ko bol rahe ho: “Ye changes next commit me dalne hain”
- Abhi history me save nahi hota

**git commit**
- Ye staged changes ko permanently save karta hai  
- Ek snapshot ban jata hai project ka
- History me entry ban jati hai

Short me:  
git add = prepare  
git commit = save

---

## 2. Staging area kya hota hai? Direct commit kyu nahi?

Staging area ek beech ka step hai.

Iska kaam:
- Decide karna kaunse changes commit me jayenge
- Clean commits banane me help karta hai

Direct commit isliye nahi hota kyunki:
- Kabhi 5 files change hoti hain, but 2 hi commit karni hoti hain
- Kabhi partial changes commit karne hote hain

Isliye Git control deta hai.

---

## 3. git log kya dikhata hai?

git log se commit history dikhti hai.

Isme hota hai:
- Commit ID
- Kisne commit kiya
- Date/time
- Commit message

Extra:
- git log --oneline → short view

---

## 4. .git folder kya hota hai? Delete kar diya toh?

.git folder Git ka main data hota hai.

Isme hota hai:
- Saari commits
- Branch info
- Config
- History

Agar .git delete kar diya:
- Git tracking band ho jayegi
- History gayab
- Folder normal ban jayega
- Wapas recover mushkil (agar remote pe nahi hai toh)

⚠️ .git delete = version control khatam

---

## 5. Working directory vs staging vs repository

**Working Directory**
- Jahan tum files edit karte ho
- Normal project folder

**Staging Area**
- Temporary jagah
- git add ke baad files yahan aati hain

**Repository**
- Jahan commits permanently save hoti hain
- Ye .git folder ke andar hota hai

---

## Flow samajhne ke liye

Working Directory → git add → Staging → git commit → Repository

