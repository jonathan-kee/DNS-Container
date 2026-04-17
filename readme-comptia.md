Github link:
https://github.com/dockur/windows?tab=readme-ov-file
^
Apparently MacOs does not support kvm, so I have to try out Vagrant

docker command for Windows Server 2019
docker run -it --rm --name windows -e "VERSION=2019" -p 8006:8006 --device=/dev/kvm --device=/dev/net/tun --cap-add NET_ADMIN -v "${PWD:-.}/windows:/storage" --stop-timeout 120 docker.io/dockurr/windows

Youtube playlist on Vagrant
https://www.youtube.com/playlist?list=PLhW3qG5bs-L9S272lwi9encQOL9nMOnRa

# Vagrant tutorial
Youtube link part 1:
https://www.youtube.com/watch?v=czMCO1w-xQU&list=PLhW3qG5bs-L9S272lwi9encQOL9nMOnRa

0) Install Vagrant

1) "vagrant init" for the Vagrantfile

2) Providers for virtual machines like Virtualbox, VMWare, AWS Cloud, Google Cloud, Azure, OpenStack

3) Give information about the machine and image to use

4) Which provisioner to use like Ansible, Puppet, Chef, Salt, Scripts

5) "vagrant up" will setup the virtual machines

Youtube link part 2:
https://www.youtube.com/watch?v=7DLfOGt8YvA&list=PLhW3qG5bs-L9S272lwi9encQOL9nMOnRa&index=2

1) Install Vagrant https://vagrantup.com/downloads Check vagrant is installed 
vagrant --version

2) Select a VM Provider. Vagrant has direct support for VirtualBox, Hyper-V, Docker
Install VirtualBox https://www.virtualbox.org/wiki/Downloads

3) Create a new folder for Vagrant project

4) On terminal or command line navigate to the folder and initiate vagrant project 
vagrant init 

This will create a new Vagrantfile in the folder. Vagrantfile is a configration file that defines the settings for your virtual machine

5) Choose a box to use https://app.vagrantup.com/boxes/search
A box is a pre-configured virtual machine image that you can use as a starting point for your virtual machine

6) Add configuration of the box in vagrantfile
For example, you could use the "ubuntu/bionic64" box by adding the following line to your Vagrantfile:
config.vm.box = "ubuntu/bionic64"

We can also directly add configuration for the virtual machine using the following commands

vagrant init centos/7 (if vagrantfile does not already exists)
vagrant box add centos/7 (will add box to vagrant, but will not create Vagrant file)

7) Start virtual machine using command 
vagrant up

This will create a new virtual machine using the box you selected and start it. 
The first time. Vagrant will download the box from the internet

8) SSH into the virtual machine 
vagrant ssh

*** Continue 26:00, it's about Vagrant commands ***

Youtube link part 3:
https://www.youtube.com/watch?v=349ul4Wuj9I&list=PLhW3qG5bs-L9S272lwi9encQOL9nMOnRa&index=3

What is "Provision the virtual machine"?
Provisioning a virtual machine means process of setting up and configuring a virtual machine with the
necessary software and resources needed for a particular task or application

Settings on the VM to a desired state for a project or task

Provisioning can be done manually by logging into the VM and making the necessary changes, or
it can be automated using configuration management tools like Ansible, Chef, or Puppet

Automated provisioning can save time and ensure consistency across multiple VMs or environments

Vagrant allows for easy provisioning of VMs using configuration files called "Vagrantfiles" 
which specify the desired state of the VM

*** Continue 11:30, it's about provisioning virtual machine ***

How to Provision the virtual machine

Can add the provision steps:
1. Within Vagrantfile 
2. In a new file and provide location in Vagrantfile

Step 1 - Open Vagrantfile and add config.vm.provision block, add it to your Vagrantfile

Step 2 - Choose a provisioner. Vagrant supports several provisioners, including Shell, Ansible, Puppet, and Chef
config.vm.provision "shell", inline: <<-SHELL
    # Add your provisioning commands here
SHELL

Step 3 - Add the commands you need to setup the VM (Install, Update, Configure)
config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install apache2 -y
SHELL

Step 4 - Save Vagrantfile and start virtual machine "vagrant up" or "vagrant reload" (to restart machine)

Vagrant will read the Vagrantfile, and run the provisioning commands specified in the config.vm.provision block
From now onwards whenever you make any changes in the provision script can run command vagrant provision
This will only update the new changes (Ensure the VM is up when running this command)

Step 5 - Access your virtual machine
vagrant ssh

*** Continue 16:00 ***

Can add the provision steps:
1. Within Vagrantfile 
2. In a new file and provide location in Vagrantfile

To use Provision Script from external file:
Step 1 - Create a new file (e.g. provision.sh) and add the scripts to provision the VM

Step 2 - Provide location of the file Vagrantfile 
config.vm.provision :shell, path: "provision.sh"

Step 3 - If VM is already up can run the command vagrant provision

Youtube link part 4:
https://www.youtube.com/watch?v=bIJCN57N0Kc&list=PLhW3qG5bs-L9S272lwi9encQOL9nMOnRa&index=5

Website for vagrantfile generation:
https://vagrantfile-generator.vercel.app/

Youtube link part 5:
https://www.youtube.com/watch?v=Q6qL2tU1d-8&list=PLhW3qG5bs-L9S272lwi9encQOL9nMOnRa&index=6

Vagrant Network Configuration
Vagrant offers the following three network options:
1. Port forwarding
2. Private network (host-only network)
3. Public network (bridged network)

Today we will learn:
How to do port forwarding in Vagrant
How to access an application running on VM from the Host machine browser

Port Forwarding
Networking allows access to the Virtual Machine from outside (like from the host system)
Vagrant by default forwards port 22 from the guest machine (VM) to an open port in the host machine
Users can also forward a specific port of your choice using vagrantfile

Step 1 - Open vagrantfile and add this line
config.vm.network "forwarded_port", guest: 80, host:8080

Users can now access the webserver running in VM by navigating to http://localhost:8080 on your host machine

Step 2 - Add provision script to install and start Apache Server on the VM

Step 3 - Restart VM with updated Vagrantfile 
vagrant reload --provision

Step 4 - On the host machine open browser and goto http://localhost:8080

What if port 8080 is busy

Step 5 - Add auto-correction "option auto_correct: true" in Vagrantfile
By default, Vagrant will choose auto-correction port between port 2200 and port 2250
You can also choose your own custom range

config.vm.usable_port_range = (2200..2250)

Youtube link part 6:
https://www.youtube.com/watch?v=qKyqv4G64Yc&list=PLhW3qG5bs-L9S272lwi9encQOL9nMOnRa&index=6

Sharing between Host and Guest (VM)
Today we will learn:
How to Share folders between the host and the virtual machine
By default the folder where you have Vagrantfile is shared to the /vagrant folder on the VM

Step 1 - Open Vagrantfile and add
config.vm.synced_folder "/path/to/host/folder", "/path/to/guest/folder"

Step 2 - Save the file and goto the file location on Terminal and run command 
vagrant up 

Step 3 - SSH into the VM 
vagrant ssh

Step 4 - Navigate to the guest folder that you specified in the Vagrantfile
