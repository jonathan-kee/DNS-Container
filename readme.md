# Docker Setup
- Bind9 (Master)
- Bind9 (Slave)
- Nginx (Web Server)

# Download an image without starting a container:
1) docker image pull ubuntu/bind9
^
The servers would be missing the configuration

2) docker image pull nginx:stable-alpine3.23-perl

# Run web server in detached mode, map free host port 8080 to the container’s port 80
*** for -p, docker host is left of :  ,docker container is right of : ***

docker run -d -p 8080:80 nginx:stable-alpine3.23-perl
*** verbose command ***
docker run --name nginx --detach -p 8080:80 nginx:stable-alpine3.23-perl

# Run Bind9 (Master) in detached mode, map free host port 30053 to the container’s port 53
docker run -d -p 30053:53 ubuntu/bind9

# Run Bind9 (Slave) in detached mode, map free host port 30054 to the container’s port 53
docker run -d -p 30054:53 ubuntu/bind9

# Show all containers (running, exited, crashed)
docker ps -a

# Example of one of popular docker images 
docker run \
        --name=bind9 \
        --restart=always \
        --publish 53:53/udp \
        --publish 53:53/tcp \
        --publish 127.0.0.1:953:953/tcp \
        --volume /etc/bind \
        --volume /var/cache/bind \
        --volume /var/lib/bind \
        --volume /var/log \
        internetsystemsconsortium/bind9:9.18

# How to add configuration to Bind9 servers
https://labs.iximiuz.com/challenges/edit-file-in-running-container
https://labs.iximiuz.com/challenges/edit-file-in-running-slim-container

# Project Architecture
1) ubuntu-host
2) node01
3) node02
4) node03

# Tutorial
- on node01
- Install bind with below commands
sudo apt update 
sudo apt install bind9 bind9utils -y

- Start the service
sudo systemctl start named
systemctl status named

- Explanation
The BIND9 system service file is located at /lib/systemd/system/named.service. This file contains the service unit configuration that the system uses to manage the BIND9 DNS server (named) process, including how to start, stop, and restart the service, as well as its dependencies and resource limits.

- To configure BIND with zone file.
1. Make sure you are on node01
2. A zone file containing the DNS records.
Note: To complete this task, ensure you have a note of the IP address of node01 and node02. You can get IP address by running the ifconfig eth0 command on respective nodes.

- Step 1: Create the Zone File
sudo vi /etc/bind/db.multinode.kodekloud.lab

- Next, add the following content to the zone file:
$TTL 604800
@       IN      SOA     node01.multinode.kodekloud.lab. admin.multinode.kodekloud.lab. (
                    1     ; Serial
                    604800         ; Refresh
                    86400          ; Retry
                    2419200        ; Expire
                    604800 )       ; Negative Cache TTL

@       IN      NS      node01.multinode.kodekloud.lab.
@       IN      NS      node02.multinode.kodekloud.lab.

node01  IN      A       <ip of node01>
node02  IN      A       <ip of node02>

- On node01 node, configure BIND to use our new zone file:

1. A declaration in named.conf.local to instruct BIND to load this zone, effectively configuring the machine as a local resolver.

Zone file location would be - /etc/bind/db.multinode.kodekloud.lab
Type: master

- Please execute the following command to open the local BIND configuration file:
sudo vi /etc/bind/named.conf.local

- Once the file is open, insert the following lines:
zone "multinode.kodekloud.lab" {
    type master;
    file "/etc/bind/db.multinode.kodekloud.lab";
};

After adding the lines, save the changes and exit the editor.

- on node2:
1. First, SSH into node02:
ssh node02

2. Install and start BIND9 using the following commands:
sudo apt update
sudo apt install bind9 bind9utils -y
sudo systemctl start named

Explanation
As with our primary DNS server, it is essential to install BIND9 on node02 to handle DNS requests. Having two DNS servers enhances the availability of our DNS service, ensuring continued operation even if one server encounters issues.

# QNA
1) Do I want to do port mapping for Bind9? What is Bind9 DNS port?

2) Do I want to do port mapping for Nginx? What is Nginx Http port? 

3) You can actually run Ubuntu Container, then install Bind9, Nginx seperately I think

4) I am not sure if non default ports like 8080, 30053, 30054 will break the demonstration

5) Can docker simulate different ip addresses? Or must I use VMs like Vagrant?
^
I think have to dive into docker networking
^
I think we start with 1 Bind9, 1 Nginx, otherwise it would be confusing.