# Addtional resources to learn Git
*** Level 24 about bisect is poorly explained ***

Link to the Git exercises
https://gitgame-4f0eb.web.app/
^
Continue Level 24
^
Try to recap all the commands below
^
Try to compare if it has touch all the topics form Kodekloud's Git for beginners
https://notes.kodekloud.com/docs/GIT-for-Beginners/GIT-Course-Introduction/GIT-Course-Introduction/page

## Level 15 (Was stuck here for awhile)
Additional learning resource:
https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase

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