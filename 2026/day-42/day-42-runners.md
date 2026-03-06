# Day 42 – Runners: GitHub-Hosted & Self-Hosted



------------------------------------------------------------------------

# Task 1 & Task 2



## Workflow File

Create the file:

.github/workflows/githubhosted.yml

``` yaml
name: Github Hosted Runner

on:
    push:
        branches: [main]
    
jobs:
    ubuntu-latest:
        runs-on: ubuntu-latest
        steps:
            - name: OS name is
              run: |
                cat /etc/os-release
                lsb_release -a
            
            - name: Check Host Name
              run: echo "Host name is $(hostname)"

            - name: Current user running the job
              run: echo "Current user is $(whoami)"

            - name: Check preinstalled software
              run: |
                echo "Checking pre-installed software on ubuntu-latest runner"
                echo "Docker version: $(docker --version)" || echo "Docker is not installed"
                echo "Python version: $(python --version)" || echo "Python is not installed"
                echo "Node.js version: $(node --version)" || echo "Node.js is not installed"
                echo "Git version: $(git --version)" || echo "Git is not installed"

    windows-latest:
        runs-on: windows-latest
        steps:
            - name: OS name is
              run: systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
            
            - name: Check Host Name
              run: echo "Host name is %COMPUTERNAME%"

            - name: Current user running the job
              run: echo "Current user is %USERNAME%"      
     
    
    macos-latest:
        runs-on: macos-latest
        steps:
            - name: OS name is
              run: sw_vers
            
            - name: Check Host Name
              run: echo "Host name is $(hostname)"

            - name: Current user running the job
              run: echo "Current user is $(whoami)"          
```



------------------------------------------------------------------------

# Notes

## What is a GitHub-hosted runner?

A **GitHub-hosted runner** is a temporary virtual machine provided by
GitHub that runs workflow jobs defined in GitHub Actions.

Each time a workflow runs:

1.  GitHub creates a fresh virtual machine
2.  The workflow jobs execute on that machine
3.  After the job finishes, the machine is destroyed

This ensures every run starts with a **clean environment**.

------------------------------------------------------------------------

## Who manages GitHub-hosted runners?

GitHub-hosted runners are **fully managed by GitHub**.

GitHub is responsible for:

-   Creating the virtual machines
-   Maintaining the infrastructure
-   Installing common development tools
-   Destroying the machines after workflow completion

Developers **do not need to manage servers or infrastructure**.

------------------------------------------------------------------------



# Documentation

Full list of pre-installed software:

https://github.com/actions/runner-images

------------------------------------------------------------------------

# Notes

## Why does it matter that runners come with tools pre-installed?

1.  **Faster Workflow Execution**
    -   No need to install common tools every time the workflow runs.
2.  **Simpler CI/CD Pipelines**
    -   Workflows remain short and easier to maintain.
3.  **Consistent Environment**
    -   Every run starts with the same environment.
4.  **Saves Build Time**
    -   Installing tools manually would increase pipeline runtime.

------------------------------------------------------------------------

# Key Takeaway

GitHub-hosted runners provide **ready-to-use CI/CD environments**,
allowing developers to focus on **building, testing, and deploying
software instead of managing infrastructure**.
