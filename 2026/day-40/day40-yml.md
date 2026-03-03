Day 40 – Your First GitHub Actions Workflow

Final hello.yml

```bash

name: Hello Workflow

on:
    push:
        branches: [main]

jobs:
    greet:
        runs-on: ubuntu-latest
        steps:
            - name: checkout code
              uses: actions/checkout@v4

            - name: say hello
              run: echo "Hello from GitHub Actions!"
           
            - name: Print current date and time
              run: echo "Current date and time $(date)" 
            
            - name: Print the name of the branch that triggered the workflow
              run: echo "This workflow was triggered by a push to the branch $GITHUB_REF"

            - name: List files in the repository
              run: ls -la 
             
            - name: Print the runner's operating system
              run: echo "This workflow is running on $RUNNER_OS"  

```

Task03-anatomy

# Task 3 -- Understand the Anatomy (GitHub Actions Workflow)

------------------------------------------------------------------------

## on:

Defines what event triggers the workflow.

Example:

``` yaml
on:
  push:
    branches: [main]
```

This means the workflow runs whenever code is pushed to the main branch.

------------------------------------------------------------------------

## jobs:

Defines the work that will be executed.

A workflow can contain multiple jobs.

Example:

``` yaml
jobs:
  greet:
```

Here, `greet` is the name of the job.

------------------------------------------------------------------------

## runs-on:

Specifies which machine (runner) executes the job.

Example:

``` yaml
runs-on: ubuntu-latest
```

This tells GitHub to use a Linux virtual machine.

------------------------------------------------------------------------

## steps:

A job is divided into steps. Steps run sequentially from top to bottom.

If one step fails, the job stops (unless continue-on-error is used).

------------------------------------------------------------------------

## uses:

Runs a pre-built action created by someone else.

Example:

``` yaml
uses: actions/checkout@v4
```

This action checks out your repository code into the runner.

------------------------------------------------------------------------

## run:

Executes a shell command directly on the runner.

Example:

``` yaml
run: echo "Hello from GitHub Actions!"
```

Used for installing dependencies, running tests, building Docker images,
etc.

------------------------------------------------------------------------

## name: (on a step)

Provides a human-readable label for a step.

Example:

``` yaml
- name: say hello
```

This is shown in the GitHub Actions UI for readability and debugging.

------------------------------------------------------------------------

## Simple Mental Model

Workflow ├── Trigger (on) └── Jobs └── Runner (runs-on) └── Steps ├──
uses (prebuilt action) └── run (shell command)

------------------------------------------------------------------------

