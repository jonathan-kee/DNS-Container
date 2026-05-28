# Pre-requisite to Github Actions
- Git
- YML

# Addtional resources to learn Git
*** Level 24 about bisect is poorly explained ***

*** I just know bisect is good for testing purposes ***

Link to the Git exercises:
- https://gitgame-4f0eb.web.app/

Link to more Git resources:
- https://learngitbranching.js.org/?locale=en_US
- https://notes.kodekloud.com/docs/GIT-for-Beginners/GIT-Course-Introduction/GIT-Course-Introduction/page
- https://www.atlassian.com/git/tutorials

## gitgame, Level 15 (Was stuck here for awhile)
Additional learning resource:
- https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase

git log
git branch

git branch output:
main
* feature-header

git rebase main

Choose Head or manually edit it to Head

git add styles.css
git rebase --continue

# GIT for Beginners
Kodekloud link:
https://notes.kodekloud.com/docs/GIT-for-Beginners/GIT-Course-Introduction/GIT-Course-Introduction/page

## Local and Remote Repositories
https://notes.kodekloud.com/docs/GIT-for-Beginners/GIT-Introduction/Local-and-Remote-Repositories/page

A typical local repository in Git is composed of three primary areas:
Component	                Description

Working Directory	        Contains the active files where you make changes. Git monitors these files but does not track their state.
Staging Area	            Temporary storage where files are added after changes. Once reviewed, these files are prepped for a commit.
Committed Files	            Files that have been saved into the repository’s history via commits.

*** I think code editors like Vscode combines Working Directory & Staging Area to see changes graphically ***

Question: What is Working Area?
Answer: It's probably the same as Working Directory

## Demo Initialize a GIT Repository
https://notes.kodekloud.com/docs/GIT-for-Beginners/GIT-Introduction/Demo-Initialize-a-GIT-Repository/page#committing-multiple-changes

It is best practice to commit unrelated changes separately. Keeping commits atomic makes it easier to understand your project’s history and revert changes as necessary. For example, if one commit contains both a front page addition and an unrelated bug fix, it can be difficult to isolate one change without affecting the other.
^
I have been doing a lot of bad commits, need to keep commits atomic

https://notes.kodekloud.com/docs/GIT-for-Beginners/GIT-Introduction/Demo-Initialize-a-GIT-Repository/page#committing-specific-files
^
It looks like git is based around file changes. 
^
I think there has to be a GUI equivalent including or excluding files from stage changes

## Initialize Remote Repositories
https://notes.kodekloud.com/docs/GIT-for-Beginners/Initialize-Remote-Repositories/Initialize-Remote-Repositories/page

Below are some examples of connection strings from popular platforms:
https://github.com/kodekloudhub/stories.git
https://gitlab.com/kodekloudhub/stories.git
https://bitbucket.org/kodekloudhub/stories.git

# GitHub Actions Certification
*** There's a bit too much information for simple ci/cd project automation ***

Kodekloud link:
https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Introduction/Introducing-Github-Actions/page#introducing-github-actions

## Basics of CI CD
Kodekloud link:
https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Introduction/Basics-of-CI-CD/page
^
Below are the concepts I am not familiar:
- Pull Request (I think it's a specific GIT platform feature, not part of GIT)
- Review
- Approve
- Deploy
- Static Analysis like ESLint, SonarQube to Enforce code standards
- Vulnerability Scan like Trivy, Snyk to Detect known security issues
- Integration tests
- End to End tests
^
You can actually use AI to review code in the CI

Question: How does continuous deployment handle UAT, SIT, PROD?

## (Skip, Optional) Create Explore GitHub Account
Kodekloud link:
https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Introduction/Create-Explore-GitHub-Account/page

## What are Actions
Kodekloud link:
https://notes.kodekloud.com/docs/GitHub-Actions-Certification/GitHub-Actions-Core-Concepts/What-are-Actions/page

## GitHub Action Core Components
Kodekloud link:
https://notes.kodekloud.com/docs/GitHub-Actions-Certification/GitHub-Actions-Core-Concepts/GitHub-Action-Core-Components/page

## Understanding DevOps Pipeline
Kodekloud link:
https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Continuous-Integration-with-GitHub-Actions/Understanding-DevOps-Pipeline/page#continuous-delivery-cdel

### 1. Workflows
A workflow is a configurable automated process defined by a YAML file. It listens for one or more events in your repository and runs one or more jobs.
Key elements in the example above:
name: My Awesome App
A custom label visible in the Actions tab.
on: push
Defines the event(s) that trigger the workflow. You can specify multiple events and filters.
You can also trigger workflows via:
pull_request
schedule (cron jobs)
workflow_dispatch (manual run)
For more triggers, see Events that trigger workflows.

### 2. Jobs
A job is a collection of steps executed on the same runner. By default, jobs run in parallel, but you can coordinate them using dependencies.

jobs:
  unit-testing:
    name: Unit Testing
    runs-on: ubuntu-latest
    steps:
      # Individual steps go here...

- Job identifier (unit-testing): used to set dependencies.
- runs-on: selects the runner environment (ubuntu-latest, windows-latest, etc.).

If you need to share data between jobs, use artifacts or caches.

### 3. Steps