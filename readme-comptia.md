Github link:
https://github.com/dockur/windows?tab=readme-ov-file
^
Apparently MacOs does not support kvm, so I have to try out Vagrant

docker command for Windows Server 2019
docker run -it --rm --name windows -e "VERSION=2019" -p 8006:8006 --device=/dev/kvm --device=/dev/net/tun --cap-add NET_ADMIN -v "${PWD:-.}/windows:/storage" --stop-timeout 120 docker.io/dockurr/windows

Youtube playlist on Vagrant
https://www.youtube.com/playlist?list=PLhW3qG5bs-L9S272lwi9encQOL9nMOnRa

# Vagrant tutorial
0) Install Vagrant

1) "vagrant init" for the Vagrantfile

2) Providers for virtual machines like Virtualbox, VMWare, AWS Cloud, Google Cloud, Azure, OpenStack

3) Give information about the machine and image to use

4) Which provisioner to use like Ansible, Puppet, Chef, Salt, Scripts

5) "vagrant up" will setup the virtual machines