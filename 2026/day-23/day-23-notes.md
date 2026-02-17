# Day 23 — Git Branching & GitHub Workflow Notes

---
# Task 1: Understanding Branches

## What is a branch in Git?
A branch is an independent line of development in Git.  
It lets you work on features or fixes without affecting the main code.

**Simple:** Branch = Parallel version of your project.

---

## Why do we use branches instead of committing everything to main?
- Keeps main stable
- Safe experimentation
- Parallel development
- Easy testing before merge
- Fewer conflicts

---

## What is HEAD in Git?
HEAD is a pointer to the current branch or latest commit.

**Meaning:** Where you currently are in Git timeline.

---

## What happens when you switch branches?
- Files update to match that branch
- Some files appear/disappear
- Uncommitted changes may block switching

---
#  Task 2: Branching Commands

## List all branches
```bash
git branch
```

## Create feature-1 branch
```bash
git checkout -b feature-1
```

## Switch to feature-1
```bash
git switch feature-1
```

## Create and switch branch together
```bash
git switch -c feature-2
```

## git switch vs git checkout
| git switch | git checkout |
|-----------|-------------|
| New command | Old command |
| Branch switching only | Multi-purpose |
| Safer | Confusing sometimes |

---

## Commit on feature-1 only
```bash
git switch feature-1
echo "Feature work" > file1.txt
git add .
git commit -m "file1 commit"
```

## Verify commit not on main
```bash
git switch main
ls
```

---

## Delete branch
```bash
git branch -d feature-2
```

---
#  Task 3: Push to GitHub

## Create GitHub repo
- Name: devops-git-practice
- No README

## Add remote
```bash
git remote add origin git@github.com:nikhil-9971/devops-git-practice.git
```

## Push main
```bash
git push -u origin main
```

## Push feature branch
```bash
git push origin feature-1
```

## origin vs upstream
| Term | Meaning |
|------|--------|
| origin | Your repo |
| upstream | Original repo (fork source) |

---
#  Task 4: Pull from GitHub

## Make change on GitHub
Edit file using GitHub editor (Adding more command) and commit.

## Pull changes locally
```bash
git pull origin main
```

---

## git fetch vs git pull
| git fetch | git pull |
|----------|---------|
| Downloads changes | Downloads + merges |
| Safe | Auto update |
| No working dir change | Updates files |

---
# 🍴 Task 5: Clone vs Fork

## Clone a public repo
```bash
git clone https://github.com/nikhil-9971/git-command-repo.git
```

## Fork and clone
1. Click Fork on GitHub
2. Clone your fork:
```bash
git clone https://github.com/your-username/repo.git
```

---

## Clone vs Fork
| Clone | Fork |
|------|------|
| Local copy | GitHub copy |
| No ownership | Your own repo |
| Used for usage | Used for contribution |

---

## When to use clone vs fork?
- Clone → Personal use
- Fork → Open source contributions

---

## Sync fork with original repo
Add upstream:
```bash
git remote add upstream https://github.com/original/repo.git
```

Fetch updates:
```bash
git fetch upstream
```

Merge updates:
```bash
git merge upstream/main
```

---
