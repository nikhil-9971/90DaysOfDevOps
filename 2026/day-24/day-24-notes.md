# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

## Task 1: Git Merge

### What is a Fast-Forward Merge?

A fast-forward merge happens when:
- The main branch has not moved ahead
- Git simply moves the branch pointer forward

There is no new merge commit created.

Example:
main → A
feature → A → B → C

After merge:
main → A → B → C

No extra commit created.


### When does Git create a Merge Commit?

Git creates a merge commit when:
- Both branches have new commits
- Histories have diverged

Example:
main → A → M1
feature → A → F1

Merge creates:

        → F1
A → M1 → Merge Commit

This preserves full branch history.


### What is a Merge Conflict?

A merge conflict happens when:
- The same line in the same file is modified in both branches.

Git cannot decide which version to keep.

Conflict markers look like:



Manual resolution is required.


------------------------------------------------------------

## Task 2: Git Rebase

### What does Rebase actually do?

Rebase:
- Takes your commits
- Replays them on top of another branch
- Rewrites commit history

It changes commit hashes.


### How is history different from a Merge?

Merge:
- Creates merge commits
- Keeps branch structure visible

Rebase:
- Creates linear history
- No merge commits
- Looks like everything happened in sequence


### Why should you never rebase pushed commits?

Because:
- Rebase rewrites commit history
- Other developers may already be using the old history
- It can break collaboration and cause conflicts

Golden Rule:
Never rebase shared/public branches.


### When to use Rebase vs Merge?

Use Rebase:
- Before pushing
- To keep history clean
- For local feature branch updates

Use Merge:
- In team collaboration
- For preserving full history
- For shared branches


------------------------------------------------------------

## Task 3: Squash Commit vs Merge Commit

### What does Squash Merging do?

Squash:
- Combines multiple commits into one single commit
- Adds only one commit to main
- Flattens feature branch history


### How many commits were added to main?

Only 1 commit (even if feature had multiple commits).


### When to use Squash Merge?

- Small features
- Cleanup messy commits
- Open-source PRs
- Clean commit history required


### When to use Regular Merge?

- Large features
- Team collaboration
- When detailed history is important


### Trade-Off of Squashing

Pros:
- Clean history
- Easy to read log

Cons:
- Individual commit details lost
- Harder debugging
- Cannot track step-by-step development


------------------------------------------------------------

## Task 4: Git Stash

### What happens when switching branches with uncommitted changes?

- Git may block the switch
- It asks to commit or stash changes


### What is git stash?

It temporarily saves uncommitted changes and cleans the working directory.


### Difference between `git stash pop` and `git stash apply`

git stash pop:
- Applies changes
- Removes stash from list

git stash apply:
- Applies changes
- Keeps stash in list


### When to use stash in real-world?

- Urgent hotfix required
- Context switching
- Pulling updates before committing
- Temporary experiment without commit


------------------------------------------------------------

##  Task 5: Cherry Picking

### What does Cherry-Pick do?

Cherry-pick:
- Copies a specific commit
- Applies it to another branch
- Does not merge entire branch


### When to use Cherry-Pick?

- Hotfix to production
- Backport bug fixes
- Selective commit transfer
- Applying fix without full merge


### What can go wrong?

- Merge conflicts
- Duplicate commits
- Missing dependency commits
- Messy history
- Harder debugging

