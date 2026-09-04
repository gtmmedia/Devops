# Git Homework Tasks

This submission demonstrates `git commit -a -m`, `git commit -m`, branch history, and cherry-picking a specific commit into `main`.

## Task 1: `git commit -a -m` versus `git commit -m`

`git commit -a -m "message"` stages and commits modifications to already tracked files. It does not include new untracked files.

`git commit -m "message"` commits the files currently staged with `git add`. New files must be staged first.

### Commands and output

```bash
git init -b main
git config user.name "Git Homework Student"
git config user.email "student@example.com"
echo "version 1" > tracked.txt
git add tracked.txt
git commit -m "Add tracked file"
echo "version 2" > tracked.txt
echo "new file" > untracked.txt
git status --short
```

Output:

```text
 M tracked.txt
?? untracked.txt
```

Run `git commit -a -m`:

```bash
git commit -a -m "Update tracked file"
git status --short
```

Output:

```text
[main 590809f] Update tracked file
1 file changed, 1 insertion(+), 1 deletion(-)
?? untracked.txt
```

The modified tracked file was committed, but `untracked.txt` remained untracked. Now stage the new file and use `git commit -m`:

```bash
git add untracked.txt
git commit -m "Add untracked file"
git status --short
```

Output:

```text
[main 46b5537] Add untracked file
1 file changed, 1 insertion(+)
create mode 100644 untracked.txt
```

The clean status confirms that the staged file was committed.

## Task 2: Git cherry-pick

The exercise uses three commits on `main` before branching, which satisfies the required two-to-four main-branch commits.

### View the main history

```bash
git log --oneline --decorate -3
```

Output:

```text
46b5537 (HEAD -> main) Add untracked file
590809f Update tracked file
33840a7 Add tracked file
```

### Create a feature branch and make two commits

```bash
git switch -c feature/cherry-pick
echo "feature commit one" > feature-one.txt
git add feature-one.txt
git commit -m "Feature commit one"
echo "feature commit two" > feature-two.txt
git add feature-two.txt
git commit -m "Feature commit two"
git log --oneline --decorate --all
```

The selected commit was identified with:

```bash
git rev-parse --short HEAD
```

Output:

```text
9748a4d
```

### Cherry-pick into main

```bash
git switch main
git cherry-pick 9748a4d
git log --oneline --decorate -6
cat feature-two.txt
```

Output:

```text
[main e81719e] Feature commit two
1 file changed, 1 insertion(+)
create mode 100644 feature-two.txt

e81719e (HEAD -> main) Feature commit two
46b5537 Add untracked file
590809f Update tracked file
33840a7 Add tracked file

feature commit two
```

The selected feature commit is now part of `main`, and `feature-two.txt` is available there.

## Verification checklist

- `git commit -a -m` was tested with a modified tracked file.
- The same command was shown to skip an untracked file.
- `git commit -m` was tested after staging a new file.
- Three commits were created on `main` before branching.
- Two commits were created on `feature/cherry-pick`.
- `git log` was used to identify commit history.
- One specific feature commit was cherry-picked into `main`.
- The cherry-picked file was read from `main` to verify the change.