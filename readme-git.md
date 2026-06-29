# Resources to learn
Github's Project Management tool like Trello, Jira:
https://github.com/jonathan-kee/examTopicScraper/projects?query=is%3Aopen

Very useful feature for Github:
https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/linking-a-pull-request-to-an-issue

Scrum with GitHub Projects (Very good introduction to Github Projects):
https://www.youtube.com/watch?v=06AWiNvjlQU&list=PLGxFXI4dC2siB2ENZ6OhagfwSId5FcWmY

Github Workflow for Issues and Pull Requests
https://www.youtube.com/watch?v=d3N2yeAaLkc
^
1) Create Issues 
2) Issue can become a branch or link a pull request to the Issue
3) Issue become a new branch, compare branch to main and create a pull request
4) Creating a pull request will link to the issue
5) Merge Pull request will also close the issue

TLDR: Create Issue -> New Branch from Issue -> Create Pull Request (Compare branch to main) -> Merge Pull Request -> Close Issue

GitHub Foundations Certification Course (Most detailed explanation on Issues & Pull Request)
https://www.youtube.com/watch?v=Jdc0i7RcBv8

Learn about Github Issue before moving into Github projects:
https://docs.github.com/en/issues/tracking-your-work-with-issues/learning-about-issues/quickstart

Github projects training course:
https://learn.microsoft.com/en-us/training/modules/manage-work-github-projects/

Question: So how does Github Issues, Github Projects fit into CI / CD?

*** Project Idea, have text to speech for recordings / meetings, then translate it Github Projects UI ***

# How Github platform relates to CI / CD
Link to Kodekloud notes about CI / CD:
https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Introduction/Basics-of-CI-CD/page

A typical feature workflow looks like this:
1) Developer creates a feature branch from main. (You should create an issue first, then a branch from the issue)
2) Changes are committed to the feature branch.
3) A pull request (PR) is opened against main.
4) Team members review and approve the PR. (Merging a pull request will close the issue)
5) Merging to main triggers deployment to the production environment (manually or via scripts).

Core Steps in a CI Pipeline
| Step | Purpose | Example Tool |
| -- | -- | -- |
| Checkout Code | Retrieve branch commits | Git
| Dependency Install | Install libraries and dependencies | npm, Maven
| Static Analysis | Enforce code standards | ESLint, SonarQube
| Unit Tests | Verify individual functions/modules | Jest, JUnit
| Build Artifact | Package application binaries or containers | Docker, Gradle
| Vulnerability Scan | Detect known security issues | Trivy, Snyk

*** (My notes) It looks like Core Steps in CI are runned before Merging a pull request like ***

Workflow:
1) A developer pushes to feature branch A and opens a PR.
2) The CI pipeline runs static analysis, unit tests, builds artifacts, and scans for vulnerabilities.
3) Failed steps provide immediate feedback. The developer iterates until the pipeline passes.
4) Upon approval, merging into main triggers a full CI run on the integrated codebase.
5) Parallel feature branch B undergoes the same CI checks; after merging, CI validates that A and B coexist without regressions.

Automating tests and scans early in your workflow reduces costly fixes later and accelerates your release cadence.