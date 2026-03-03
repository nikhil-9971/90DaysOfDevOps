# Day 39 -- CI/CD Concepts

------------------------------------------------------------------------

## Task 1: The Problem

### Scenario:

5 developers pushing code to same repo and manually deploying to
production.

### What can go wrong?

-   Code conflicts
-   Broken builds
-   Untested code reaching production
-   Different environments (dev vs prod mismatch)
-   Human deployment mistakes
-   No rollback strategy

### What does "It works on my machine" mean?

It means the application runs correctly in the developer's local
environment, but fails in staging or production due to differences in:

-   OS
-   Dependencies
-   Environment variables
-   Database versions
-   Network configurations

This is a real problem because production must be predictable and
reproducible.

### How many times a day can a team safely deploy manually?

Usually 1--2 times at most due to risk and coordination overhead.

------------------------------------------------------------------------

## Task 2: CI vs CD

### Continuous Integration (CI)

Continuous Integration is the practice of automatically building and
testing code every time developers push changes to a shared repository.

It catches: - Syntax errors - Build failures - Failing tests -
Integration issues

Example: A developer pushes code → GitHub Actions runs tests
automatically.

------------------------------------------------------------------------

### Continuous Delivery (CD)

Continuous Delivery ensures that code is always in a deployable state.
After CI passes, the application is prepared and packaged for release.

Deployment requires manual approval.

Example: After tests pass, Docker image is built and pushed to registry,
but deployment to production requires human approval.

------------------------------------------------------------------------

### Continuous Deployment

Continuous Deployment automatically deploys code to production after CI
passes --- no manual approval required.

Used by teams with strong automated testing and high confidence in
releases.

Example: A SaaS product auto-deploys to production every time tests
pass.

------------------------------------------------------------------------

## Task 3: Pipeline Anatomy

### Trigger

Event that starts the pipeline (push, pull request, schedule).

### Stage

Logical group of jobs (Build, Test, Deploy).

### Job

A unit of work inside a stage.

### Step

A single command inside a job.

### Runner

Machine that executes jobs (GitHub-hosted or self-hosted).

### Artifact

Output produced by a job (Docker image, binary, test report).

------------------------------------------------------------------------

## Task 4: Pipeline Diagram

Scenario: Developer pushes code → App tested → Docker image built →
Deploy to staging

    Push Code
       │
       ▼
    [ CI ]
    Build → Test → Lint
       │
       ▼
    [ CD ]
    Docker Build → Push → Deploy to Staging

------------------------------------------------------------------------

## Task 5: Explore in the Wild

Repository Explored: FastAPI

Folder: `.github/workflows/`

### What triggers it?

-   push
-   pull_request

### How many jobs?

Multiple jobs including test, lint, and build.

### What does it do?

-   Installs dependencies
-   Runs tests
-   Runs lint checks
-   Ensures code quality before merge

------------------------------------------------------------------------

## Key Realizations

-   CI/CD is a practice, not just a tool.
-   A failing pipeline is not bad --- it protects production.
-   Automation increases speed and reduces human error.

------------------------------------------------------------------------

## Summary

CI increases confidence. CD increases speed. Automation reduces risk.
