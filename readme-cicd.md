# Pre-requisite to Github Actions
- Git
- YML
- Bash (Basic)
- Docker

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
- https://notes.kodekloud.com/docs/GIT-for-Beginners/GIT-Course-Introduction/GIT-Course-Introduction/page

## Local and Remote Repositories
Kodekloud link:
- https://notes.kodekloud.com/docs/GIT-for-Beginners/GIT-Introduction/Local-and-Remote-Repositories/page

A typical local repository in Git is composed of three primary areas:
| Component | Description |
| -- | -- |
| Working Directory	| Contains the active files where you make changes. Git monitors these files but does not track their state. |
| Staging Area | Temporary storage where files are added after changes. Once reviewed, these files are prepped for a commit. |
| Committed Files	| Files that have been saved into the repository’s history via commits. |

*** I think code editors like Vscode combines Working Directory & Staging Area to see changes graphically ***

Question: What is Working Area?

Answer: It's probably the same as Working Directory

## Demo Initialize a GIT Repository
Kodekloud link:
- https://notes.kodekloud.com/docs/GIT-for-Beginners/GIT-Introduction/Demo-Initialize-a-GIT-Repository/page#committing-multiple-changes

It is best practice to commit unrelated changes separately. Keeping commits atomic makes it easier to understand your project’s history and revert changes as necessary. For example, if one commit contains both a front page addition and an unrelated bug fix, it can be difficult to isolate one change without affecting the other.

^
I have been doing a lot of bad commits, need to keep commits atomic

Kodekloud link:
- https://notes.kodekloud.com/docs/GIT-for-Beginners/GIT-Introduction/Demo-Initialize-a-GIT-Repository/page#committing-specific-files

^
It looks like git is based around file changes. 

^
I think there has to be a GUI equivalent including or excluding files from stage changes

## Initialize Remote Repositories
https://notes.kodekloud.com/docs/GIT-for-Beginners/Initialize-Remote-Repositories/Initialize-Remote-Repositories/page

Below are some examples of connection strings from popular platforms:
- https://github.com/kodekloudhub/stories.git
- https://gitlab.com/kodekloudhub/stories.git
- https://bitbucket.org/kodekloudhub/stories.git

# GitHub Actions Certification
*** There's a bit too much information for simple ci/cd project automation ***

Kodekloud link:
- https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Introduction/Introducing-Github-Actions/page#introducing-github-actions

## Basics of CI CD
Kodekloud link:
- https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Introduction/Basics-of-CI-CD/page
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

*** Pull Request, Review, Approve is under the same step for Github workflow ***

TLDR: Create Issue -> New Branch from Issue -> Create Pull Request (Compare branch to main) -> Merge Pull Request -> Close Issue

Question: How does continuous deployment handle UAT, SIT, PROD?

## (Skip, Optional) Create Explore GitHub Account
Kodekloud link:
- https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Introduction/Create-Explore-GitHub-Account/page

## What are Actions
Kodekloud link:
- https://notes.kodekloud.com/docs/GitHub-Actions-Certification/GitHub-Actions-Core-Concepts/What-are-Actions/page

## GitHub Action Core Components
Kodekloud link:
- https://notes.kodekloud.com/docs/GitHub-Actions-Certification/GitHub-Actions-Core-Concepts/GitHub-Action-Core-Components/page

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

## Understanding DevOps Pipeline
*** This section goes into detail to understand CI / CD ***

Kodekloud link:
- https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Continuous-Integration-with-GitHub-Actions/Understanding-DevOps-Pipeline/page#continuous-delivery-cdel

(My notes) In my 2tier app, Because I don't own the source code for mariadb-server, apache2, etc I was able to skip stages like: 
- Install Dependencies
- Dependency Vulnerability
- Unit Tests & Coverage
- Static Code Analysis
- Image Vulnerability Scan
- Push to Registry

I only ever did
- Containerization

Question: But does it cover multiple repositories for CI / CD?

Question: Is there an example of deply to SIT, UAT, PROD?

Answer: Yes, below kodekloud notes is an example
- https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Reusable-Workflows-and-Reporting/Understanding-Reusable-Workflows/page#sample-ci-workflow-for-a-node-js-app

^
Try to follow to self hosted for your project, then follow the above:
- https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Self-Hosted-Runner/Types-of-Runners/page

^
Try to follow setup Rocky VM using Vagrant

^
Try to adapt the CI pipeline for my current 2tier app

^
I have to transfer the docker artifact to the VM, I also have to install docker in the VM as well.

^
I don't think you have to transfer because Github Actions Checkout will clone the repo, you can build the artifact in the vm.

^
Follow below docker installation guide for Rocky:
https://docs.docker.com/engine/install/centos/#install-using-the-repository

Question: For self hosted, how to I prevent it from requesting github.com?

## Types of Runners
https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Self-Hosted-Runner/Types-of-Runners/page

### 2. Install and Configure the Runner
# Run these commands on your machine:
# Create and enter a directory for the runner
mkdir actions-runner && cd actions-runner

# Download the runner package (update version as needed)
curl -o actions-runner.tar.gz \
  https://github.com/actions/runner/releases/download/v2.309.0/actions-runner-linux-x64-2.309.0.tar.gz

# Extract the files
tar xzf actions-runner.tar.gz

# Configure with your repo URL and token
./config.sh --url https://github.com/sidd-harth/repository \
            --token AP3V5NDFAQIMO

# Follow the prompts:
# • Runner group: [press Enter for Default]
# • Runner name: linux-gpu-runner
# • Labels: gpu

# After setup, you’ll see:
# Start the runner
./run.sh

### 3. Target Your Self-Hosted Runner in Workflows
# Add the labels you chose to the runs-on field:
jobs:
  build:
    runs-on: [self-hosted, Linux, gpu]
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3
      # …additional steps…

## Installing a Self-Hosted Runner
https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Self-Hosted-Runner/Installing-a-Self-Hosted-Runner/page

*** He is installed the runner in a Virtual Machine ***
*** I might use Vagrant for this ***

### Step 2: Download and Extract the Runner
# Create a directory and enter it
mkdir actions-runner && cd actions-runner

# Download the latest runner package
curl -L -o actions-runner-linux-x64-2.310.2.tar.gz \
  https://github.com/actions/runner/releases/download/v2.310.2/actions-runner-linux-x64-2.310.2.tar.gz

# (Optional) Validate the SHA-256 checksum
echo "bf28a83175a60e551fa6e31b9e2ece6bf280278f949f3  actions-runner-linux-x64-2.310.2.tar.gz" \
  | sha256sum -c -

# Extract the archive
tar xzf actions-runner-linux-x64-2.310.2.tar.gz

# Verify extracted files
ls -1

# You should see:
bin
config.sh
env.sh
externals
run-helper.cmd.template
run.sh
safe_sleep.sh

### Step 3: Configure the Runner
./config.sh --url https://github.com/<OWNER>/<REPO> --token YOUR_TOKEN_HERE

During setup, you will:
- Choose a runner group (default: default for repo-level).
- Name your runner (e.g., prod-ubuntu-runner).
- Assign labels (default: self-hosted, Linux, X64; you can add prod, main).
- Confirm or change the working directory (default: _work).
​
### Step 4: Verify Registration (Offline)

### Step 5: Start the Runner

### Step 6: Verify Runner Status (Online)

### Step 7: Use Your Self-Hosted Runner in Workflows
Add this to any workflow file (.github/workflows/*.yml) to target your runner:

jobs:
  build:
    runs-on: self-hosted
    steps:
      # …

Ensure your self-hosted runner has all required tools and permissions for your workflows.

(Continue) ## Running Workflow on Self-Hosted Runner
*** It's a bit werid that I have to go to the Github UI screen to run the job ***
https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Self-Hosted-Runner/Running-Workflow-on-Self-Hosted-Runner/page

Configure GitHub Actions to run on a self-hosted runner for customizable CI/CD using your own infrastructure.

Leverage your own infrastructure for faster, customizable CI/CD by configuring GitHub Actions to run on a self-hosted runner. In this guide, we’ll:

1) Verify your runner registration
2) Start the runner service
3) Update a workflow to target your self-hosted runner
4) Commit and push changes
5) Trigger and monitor the job
6) Inspect logs both in GitHub and on the runner VM
​
(Continue) ## Exploring Self Hosted Runner
https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Self-Hosted-Runner/Exploring-Self-Hosted-Runner/page

### 1. Directory Layout
Start the runner in one terminal:
root@ubuntu-host:~/actions-runner$ ./run.sh

Open a second terminal to inspect the directory structure:
root@ubuntu-host:~$ cd actions-runner/
root@ubuntu-host:~/actions-runner$ ls -l
total 183128
drwxr-xr-x  4 1001 127    16384 Oct 18 18:27 bin/
-rwxr-xr-x  1 root root     266 Oct 24 14:50 config.sh*
drwxr-xr-x  1 root root    4096 Oct 24 14:48 .credentials/
drwxr-xr-x  1 root root    4096 Oct 24 14:48 .credentials_rsaparams/
drwxr-xr-x  4 root root    4096 Oct 24 14:49 _diag/
-rw-r--r--  1 root root      17 Oct 24 14:48 .env
drwxr-xr-x  4 1001 127    4096 Oct 24 14:48 externals/
-rw-r--r--  1 root root     259 Oct 24 14:48 run-helper.sh.template*
-rwxr-xr-x  1 root root     382 Oct 24 14:50 run-helper.sh*
-rw-r--r--  1 root root     718 Oct 24 14:50 .runner
-rwxr-xr-x  1 root root    2537 Oct 24 15:26 run.sh*
drwxr-xr-x  6 root root    4096 Oct 24 14:48 _work/

Directory             Purpose
bin/                  Runner executables
config.sh             Configuration script
.credentials/         Authentication material
_work/                Workflow checkout & runtime files
externals/            External dependencies

- _diag/ : Contains both runner and worker logs.
- _work/ : Hosts the workspace where jobs execute.

### 2. Inspecting Diagnostic Logs (_diag)
Use tree to view the log layout:

root@ubuntu-host:~/actions-runner$ tree _diag/
_diag/
├── blocks
└── pages
    ├── Runner_20231024-144833-utc.log
    ├── Runner_20231024-145143-utc.log
    └── Worker_20231024-152375-utc.log

2 directories, 3 files

Display the contents of a runner log:
root@ubuntu-host:~/actions-runner$ cat _diag/pages/Runner_20231024-145143-utc.log
[2023-10-24 14:51:43Z INFO HostContext] Well known directory 'Root': '/root/actions-runner'
[2023-10-24 14:51:43Z INFO RunnerServer] EstablishSvsConnection with 60 seconds timeout.
[2023-10-24 14:51:43Z INFO GitHubActionsService] Starting operation Location.GetConnectionData
...

If you encounter connectivity or authentication issues, always start with the latest entries in _diag/pages/Runner_*.log and _diag/pages/Worker_*.log.

### 3. Exploring the Workflow Workspace (_work)

#### 3.1 Before Any Job Runs
By default, the workspace is mostly empty:
root@ubuntu-host:~/actions-runner$ tree _work/
_work/
└── actions-1
    └── actions-1

7 directories, 1 file

#### 3.2 Preparing a Long-Running Workflow
To observe changes in _work/ during execution, use a simple workflow that sleeps:

name: Self-Hosted Runner Demo
on:
  workflow_dispatch:

jobs:
  demo:
    runs-on: [self-hosted, linux]
    steps:
      - name: Echo and Pause
        run: |
          echo "Runner is active"
          sleep 1500s

Commit and trigger via Run workflow in the GitHub UI.
Using sleep 1500s keeps the job alive long enough to explore file changes. Remember to cancel or stop the runner when done.

#### 3.3 Monitoring Job Start
In the runner terminal you’ll see:

root@ubuntu-host:~/actions-runner$ ./run.sh
Current runner version: '2.310.2'
2023-10-24 14:52:57Z: Running job: demo
# (job will remain active)

#### 3.4 After Job Initialization
Re-execute the tree command:
root@ubuntu-host:~/actions-runner$ tree _work/
_work/
├── actions-1
│   ├── actions-1
│   ├── PipelineMapping
│   │   └── your-org-demo-1
│   │       └── actions-1
│   │           └── PipelineFolder.json
└── _temp
    ├── 06abcca7-d09b-406e-ba2e-f87e625ac8db.sh
    ├── _github_workflow/event.json
    └── runner_file_commands
        ├── add_path_*.txt
        ├── save_state_*.txt
        ├── set_env_*.txt
        ├── set_output_*.txt
        └── step_summary_*.txt

9 directories, 8 files

##### 3.4.1 PipelineFolder.json
Metadata about your repo and workspace:

{
  "repositoryName": "your-org/demo-repo",
  "workspaceDirectory": "actions-1/actions-1",
  "lastRunOn": "2023-10-24T15:34:10Z",
  "repositories": {
    "your-org/demo-repo": {
      "repositoryPath": "actions-1/actions-1",
      "lastRunOn": "2023-10-24T15:23:59Z"
    }
  }
}


##### 3.4.2 Generated Shell Script
Your run: commands are translated into a shell script:

root@ubuntu-host:~/actions-runner$ cat _work/_temp/06abcca7-d09b-406e-ba2e-f87e625ac8db.sh
echo "Runner is active"
sleep 1500s

##### 3.4.3 Workflow Event Payload
The full event that triggered the job lives in event.json:

{
  "inputs": null,
  "ref": "refs/heads/main",
  "repository": {
    "clone_url": "https://github.com/your-org/demo-repo.git",
    "default_branch": "main",
    ...
  }
}

##### 3.4.4 Runner File Commands
Commands such as ::set-env and ::add-path are materialized into files under runner_file_commands. 
The runner engine reads these to adjust environment variables, outputs, and step summaries.

### 4. Real-Time Diagnostics
While the job is running, new logs continuously populate _diag:

root@ubuntu-host:~/actions-runner$ tree _diag/
_diag/
├── blocks
│   ├── ..._1.log
│   └── ..._2.log
└── pages
    ├── ..._1.log
    └── ..._2.log

Live snippet from a worker log:
[2023-10-24 15:34:11Z INFO ProcessInvokerWrapper] Starting process:
[2023-10-24 15:34:11Z INFO ProcessInvokerWrapper] File name: '/usr/bin/bash'
[2023-10-24 15:34:11Z INFO ProcessInvokerWrapper] Arguments: '-e /root/actions-runner/_work/_temp/06abcca7-d09b-406e-ba2e-f87e625ac8db.sh'
[2023-10-24 15:35:11Z INFO JobServerQueue] Stop aggressive web console lines queue.

### 5. Cleanup
When you’ve finished inspecting logs and workspace files, stop the runner:

# In the runner terminal:
^C
Stopping runner...

This terminates the current job and shuts down the service.

### 6. Summary
- _diag/: Central location for runner and worker diagnostics.
- _work/: Contains your repo checkout, generated scripts, event payloads, and runner file commands.
- Monitoring these folders in real time is essential for debugging connectivity, authentication, and workflow execution on self-hosted runners.

## (Skip) ⭐Monitor, troubleshoot, and update self-hosted runners

## Uninstalling Self Hosted Runner
https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Self-Hosted-Runner/Uninstalling-Self-Hosted-Runner/page 

### Removal Methods at a Glance
Method              Scope                                   Description
UI Removal          Repository, Organization, Enterprise    Permanently deletes the runner from GitHub.
CLI Cleanup         Runner VM                               Unregisters the runner and removes local configuration.
Temporary Disable   Runner VM                               Marks the runner offline without full uninstall.

### 1. Removing a Runner via GitHub UI
1. In your repository, go to Settings > Actions > Runners.
2. Locate the runner and click Remove.

Removing a runner is permanent. If MFA is enabled, you’ll be prompted for a code to confirm deletion.

For organization or enterprise-level runners:
1. Navigate to Settings > Actions > Runners in your org/enterprise dashboard.
2. Select the runner you wish to uninstall and click Remove.

After confirmation, GitHub permanently deletes the runner entry.

### 2. Cleaning Up the Runner Machine
Once removed from GitHub, unregister the runner on the VM:
./config.sh remove --token YOUR_RUNNER_TOKEN

Replace YOUR_RUNNER_TOKEN with the token from your initial configuration. This command:
- Unregisters the runner from GitHub
- Deletes local configuration files

If you see permission errors, retry with elevated privileges (e.g., sudo on Linux).

Alternatively, use Force remove in the GitHub UI to uninstall the runner application completely.

### 3. Temporarily Disabling a Runner
To pause job execution without full removal:
1. Shut down the VM or stop the runner service/script.
2. The runner will show as offline and won’t accept new jobs.

GitHub automatically deletes any self-hosted runner that remains offline for more than 30 days, preventing stale entries.