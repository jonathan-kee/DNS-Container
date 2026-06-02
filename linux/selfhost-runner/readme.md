# Installation Guide
Follow the official github documentation:
https://docs.github.com/en/actions/how-tos/manage-runners/self-hosted-runners/add-runners#adding-a-self-hosted-runner-to-a-repository

Follow below for personalized installation:
https://github.com/jonathan-kee/DNS-Container/settings/actions/runners/new?arch=arm64&os=linux

# Vagrant After Setup & Provisioning 
cd linux/selfhost-runner
vagrant up --provider vmware_desktop
vagrant ssh Server1
cd actions-runner
./run.sh

# Vagrant Setup & Provisioning
You need to enable the setting below for vmware to work:
Privacy & Security -> Full Disk Access -> vagrant-vmware-utility

cd linux/selfhost-runner
vagrant up --provider vmware_desktop
vagrant provision
vagrant ssh Server1
sudo chown -R vagrant:vagrant /home/vagrant/actions-runner
cd actions-runner
./config.sh --url https://github.com/<OWNER>/<REPO> --token YOUR_TOKEN_HERE

*** Enter registration process details ***

./run.sh

# My registration process
Runner Registration
Enter the name of the runner group to add this runner to: [press Enter for Default] 

Enter the name of runner: [press Enter for Server1] prod-rocky-runner

This runner will have the following labels: 'self-hosted', 'Linux', 'ARM64' 
Enter any additional labels (ex. label-1,label-2): [press Enter to skip] 

√ Runner successfully added

Runner settings

Enter name of work folder: [press Enter for _work] 

√ Settings Saved.

# QNA
## https://notes.kodekloud.com/docs/GitHub-Actions-Certification/Self-Hosted-Runner/Installing-a-Self-Hosted-Runner/page#step-3-configure-the-runner
./config.sh --url https://github.com/<OWNER>/<REPO> --token YOUR_TOKEN_HERE
^
Where to I get the --token from?
^
This is specified from following github installation guide
^
You should not commit & push the token to a public repo, might be a security issue

## https://notes.kodekloud.com/docs/GitHub-Actions-Certification/GitHub-Actions-Core-Concepts/workflow-dispatch-Input-Options/page

Question: What is workflow dispatch?
Answer: It looks like a form builder that helps build conditional logic for CI / CD

The three notes below are related to better understand the concepts:
- https://notes.kodekloud.com/docs/GitHub-Actions-Certification/GitHub-Actions-Core-Concepts/Access-workflow-context-information/page
- https://notes.kodekloud.com/docs/GitHub-Actions-Certification/GitHub-Actions-Core-Concepts/Using-if-expression-in-Jobs/page
- https://notes.kodekloud.com/docs/GitHub-Actions-Certification/GitHub-Actions-Core-Concepts/workflow-dispatch-Input-Options/page

Question: What does the below mean?
runs-on: [self-hosted, linux, prod]
Answer: Based on below notes, prod is a custom label, I have to configure my runner to have that custom label too.

The four notes below are related to better understand the concepts:
https://docs.github.com/en/actions/how-tos/manage-runners/self-hosted-runners/apply-labels#creating-a-custom-label
https://docs.github.com/en/actions/how-tos/manage-runners/self-hosted-runners/use-in-a-workflow

https://docs.github.com/en/actions/how-tos/manage-runners/self-hosted-runners/use-in-a-workflow#using-default-labels-to-route-jobs
You can use your workflow's YAML to send jobs to a combination of these labels. In this example, a self-hosted runner that matches all three labels will be eligible to run the job:

runs-on: [self-hosted, linux, ARM64]

https://docs.github.com/en/actions/how-tos/manage-runners/self-hosted-runners/use-in-a-workflow#using-custom-labels-to-route-jobs
You can create custom labels and assign them to your self-hosted runners at any time. Custom labels let you send jobs to particular types of self-hosted runners, based on how they're labeled.

For example, if you have a job that requires a specific type of graphics hardware, you can create a custom label called gpu and assign it to the runners that have the hardware installed. A self-hosted runner that matches all the assigned labels will then be eligible to run the job.

This example shows a job that combines default and custom labels:

runs-on: [self-hosted, linux, x64, gpu]

- gpu - This custom label has been manually assigned to self-hosted runners with the GPU hardware installed.

These labels operate cumulatively, so a self-hosted runner must have all four labels to be eligible to process the job.

Question: How to see the GUI for VM
Answer: https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/configuration#gui-vs-headless