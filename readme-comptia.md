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