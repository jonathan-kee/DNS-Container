# Project Highlights
[Different Environments like uat, sit, prod](../../screenshots/DifferentEnvironments.png)
![Different Environments like uat, sit, prod](../../screenshots/DifferentEnvironments.png)

# Installation Guide
Follow the official github documentation:
- https://docs.github.com/en/actions/how-tos/manage-runners/self-hosted-runners/add-runners#adding-a-self-hosted-runner-to-a-repository

Follow below for personalized installation:
- https://github.com/jonathan-kee/DNS-Container/settings/actions/runners/new?arch=arm64&os=linux

# Vagrant After Setup & Provisioning 
1) cd linux/selfhost-runner
2) vagrant up --provider vmware_desktop
3) vagrant ssh Server1
4) cd actions-runner
5) ./run.sh

# Run Github Actions
Link to Github Actions workflow:
- https://github.com/jonathan-kee/DNS-Container/actions/workflows/2tier.yml

- Click Run Workflow

# Setup DNS with Docker on Host computer
1) Open docker desktop on Host computer

2) docker run --detach \
        --name=dns \
        --restart=always \
        --publish 53:53/udp \
        --publish 53:53/tcp \
        --publish 127.0.0.1:953:953/tcp \
        --volume /etc/bind \
        --volume /var/cache/bind \
        --volume /var/lib/bind \
        --volume /var/log \
        ubuntu/bind9

# Test Connection & note down IPv4 Address
*** Try to set static ip 172.17.0.2 ***

- docker exec -it dns sh
- ip a
- exit

ip a output:
172.17.0.2/16 

# Node01 (Bind9 DNS Master)
cd 2tier

## Copy over zone file
docker cp \
    ./dns/node01/db.company \
    dns:/etc/bind/db.company

## Configure BIND to use our new zone file
docker cp \
    ./dns/node01/named.conf.local \
    dns:/etc/bind/named.conf.local

## Configure BIND options
docker cp \
    ./dns/node01/named.conf.options \
    dns:/etc/bind/named.conf.options

## Restart DNS servers
docker restart dns

## Clear Host DNS cache
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder

## Test Host DNS connection
dig uat.company
dig sit.company
dig prod.company

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

Question: After Github Actions Checkout, where is the source code located?
Answer /home/vagrant/actions-runner/_work/DNS-Container/DNS-Container

Question: Will write workflow file be different now that self hosted?
Answer: I think the best way to find out is to write pwd command, so that your path is precise

*** It's kind of interesting to see theory (from kodekloud's foundation) come to life, because I was aware of the theory at the beginning ***
*** Before you jump to any conclusion, try to setup the DNS container outside the vm first, could be networking issue ***
*** Try to setup DNS now ***
^
Is the DNS outside the VM or inside the VM?
^
If I do port mapping, it does not matter I guess.

Question: What is port 53 & 953 for Bind9 DNS?

Question: The thing that confuses me about the Bind9 DNS files are the mix of different IP addreses like 172.17.0.3 for the Nameserver & 127.0.0.1 for the Apache server.

Question: What is the command vagrant did the port mapping?
Answer: vagrant port