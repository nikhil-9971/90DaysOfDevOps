# Day 25 – Advanced Git: Reset, Revert & Branching Strategies

------------------------------------------------------------

## Task 1: Git Reset

### What happens with different reset types?

After making 3 commits (A → B → C):

---

### git reset --soft HEAD~1
- Moves HEAD back one commit
- Keeps changes in staging area
- Changes are ready to re-commit

👉 Commit removed, changes preserved (staged)

---

### git reset --mixed HEAD~1 (default)
- Moves HEAD back one commit
- Unstages changes
- Changes remain in working directory

👉 Commit removed, changes still in files (not staged)

---

### git reset --hard HEAD~1
- Moves HEAD back one commit
- Deletes changes from staging + working directory

👉 Commit removed + changes permanently deleted ❌

---

### Difference between --soft, --mixed, and --hard

--soft → Keep changes staged  
--mixed → Keep changes unstaged  
--hard → Delete everything

---

### Which one is destructive?

git reset --hard is destructive because:
- It permanently deletes uncommitted changes
- Cannot be easily recovered

---

### When to use each?

--soft:
- Fix last commit message
- Combine commits

--mixed:
- Undo commit but keep changes for editing

--hard:
- Discard bad changes
- Clean local branch

---

### Should you use reset on pushed commits?

❌ No (generally avoid)

Because:
- It rewrites history
- Breaks collaboration
- Causes conflicts for other developers

Use only on local commits.


------------------------------------------------------------

## Task 2: Git Revert

After commits: X → Y → Z

Reverting Y:


---

### What happens?

- A new commit is created
- It reverses the changes introduced by commit Y
- Original commit Y remains in history

---

### Is commit Y still in history?

✅ Yes

Revert does NOT delete history.  
It adds a new commit that undoes the changes.

Example history:
X → Y → Z → Revert-Y

---

### How is git revert different from git reset?

Reset:
- Removes commits
- Rewrites history

Revert:
- Adds a new commit
- Preserves history

---

### Why is revert safer for shared branches?

Because:
- No history rewriting
- No force push required
- Safe for collaboration

---

### When to use revert vs reset?

Use revert:
- On shared branches
- After pushing commits
- In production repositories

Use reset:
- Local commits only
- Cleaning up commit history
- Before pushing


------------------------------------------------------------

## Task 3: Reset vs Revert Comparison

| Feature | git reset | git revert |
|--------|-----------|------------|
| What it does | Moves branch pointer backward | Creates new commit that undoes changes |
| Removes commit from history? | Yes | No |
| Rewrites history? | Yes | No |
| Safe for pushed branches? | No | Yes |
| Requires force push? | Often yes | No |
| When to use | Local cleanup | Shared repositories |


------------------------------------------------------------

## Task 4: Branching Strategies

### 1️⃣ GitFlow

#### How it works
- Multiple long-lived branches:
  - main (production)
  - develop (integration)
  - feature branches
  - release branches
  - hotfix branches

#### Flow (text diagram)
main ← release ← develop ← feature  
hotfix → main

#### Used in
- Enterprise software
- Structured release cycles

#### Pros
- Clear release management
- Stable production

#### Cons
- Complex
- Heavy process


---

### 2️⃣ GitHub Flow

#### How it works
- Single main branch
- Feature branches for changes
- PR → review → merge → deploy

#### Flow
main → feature branch → PR → merge → deploy

#### Used in
- SaaS products
- Continuous deployment teams

#### Pros
- Simple
- Fast delivery
- Easy collaboration

#### Cons
- Requires strong testing
- Less structured releases


---

### 3️⃣ Trunk-Based Development

#### How it works
- Everyone commits to main (trunk)
- Very short-lived branches
- Frequent commits

#### Flow
main ← small branches (merged quickly)

#### Used in
- High-performing DevOps teams
- Google, Netflix-style engineering

#### Pros
- Fast integration
- Less merge conflicts
- CI/CD friendly

#### Cons
- Requires strong automation
- Risky without tests


------------------------------------------------------------

## 🔹 Final Answers

### Which strategy for a startup shipping fast?
👉 GitHub Flow or Trunk-Based Development  
Reason: Speed and simplicity.

---

### Which strategy for a large team with scheduled releases?
👉 GitFlow  
Reason: Structured release management.

---

### Which one does an open-source project use?
Most modern open-source projects use:
👉 GitHub Flow

Example:
- Kubernetes
- React
- Node.js

They rely on PR-based workflows and main branch integration.


------------------------------------------------------------
