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

# Learn container networking
https://labs.iximiuz.com/tutorials/container-networking-from-scratch#creating-the-second-container-repeating-the-same-steps
^
Maybe I should really just install a ubuntu container, then install bind9, nginx in the ubuntu container.
^
Go to Understanding Docker network types (drivers) Section

# Project Architecture
1) ubuntu-host (Nginx Web Server)
2) node01 (Bind9 DNS Master)
3) node02 (Bind9 DNS Slave)
4) node03 (DNS Client)

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

- Step 5: Configure Secondary DNS Settings
- Task 1: Configure Primary (node01 node) to Allow Transfers
1. SSH into node01
2. Edit the BIND options file /etc/bind/named.conf.options
3. Add the following content after placing the IP of node02 as indicated below:
   options {
       directory "/var/cache/bind";
       allow-transfer { <REPLACE_WITH_node02_IP;> };
       recursion yes;
       allow-recursion { any; };
       listen-on { any; };
   };

- Task 2: Configure Secondary Server (node02)
1. SSH into node02:
2. Edit named.conf.local file /etc/bind/named.conf.local
3. Add the following configuration after placing the IP of node01 as indicated below:
   zone "multinode.kodekloud.lab" {
       type slave;
       file "/var/cache/bind/db.multinode.kodekloud.lab";
       masters { <REPLACE_WITH_node01_IP;> };
   };

- Restart BIND on Both Servers
sudo systemctl reload named

- What is the Response code in the dig output on node02?
dig @localhost node01.multinode.kodekloud.lab

In Section 2 of the course, we explored the importance of obtaining a complete copy of all DNS records from the primary DNS server when setting up a secondary DNS server. This process is accomplished through zone transfers, which can be categorized into two types: AXFR (full zone transfer) and IXFR (incremental zone transfer). The primary server controls which servers are authorized to receive these copies through the allow-transfer directive. Conversely, the secondary server uses the masters directive to indicate the source from which to retrieve the DNS records.

- Task: Install Web Server on ubuntu-host
Install a web server, which is crucial for testing the functionality of CNAME records. The web server will serve the content that the CNAME resolves to.

Instructions:
1. SSH into ubuntu-host.
2. Execute the following commands:
sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx

- Task: Add Web Server DNS Records
On the node01, follow these steps to edit your zone file and add the web server:
1. Open the zone file with the following command:
sudo vi /etc/bind/db.multinode.kodekloud.lab

2. Add the following records to the file after replacing the with ip address of the ubuntu-host node, ensuring that you increment the serial number:
; Web Server Records
ubuntu-host         IN      A       <REPLACE_WITH_ubuntu-host_IP>
www             IN      CNAME   ubuntu-host
webserver       IN      CNAME   ubuntu-host

3. Restart the DNS service with the command:
sudo systemctl reload named

- Task: Configure DNS Client
In this step, you will configure the DNS client on node03 to utilize the DNS servers that were set up earlier (node01 and node02). This configuration will enable node03 to resolve domain names such as www.multinode.kodekloud.lab to the corresponding IP addresses based on the DNS records you have established.

You can test the accessibility to nginx server by running the below command on node03.
curl www.multinode.kodekloud.lab

Note: open a new terminal window by clicking on the + button at the terminal, access node03 by ssh node03 command.

Note: You need to replace existing /etc/resolv.conf

1. On node03, open the resolv.conf file using the following command:
sudo vi /etc/resolv.conf

2. Add the following lines to the file:
nameserver REPLACE_WITH_NODE01_IP
nameserver REPLACE_WITH_NODE02_IP
search multinode.kodekloud.lab

-In this step, on node03 you will test the failover functionality of our DNS setup. By stopping the BIND service on the primary server (node01), you will simulate a failure. The goal is to confirm that the secondary DNS server (node02) can still resolve DNS queries, thereby ensuring redundancy in our DNS infrastructure.

1. Execute the command:
dig node01.multinode.kodekloud.lab

Observe the IP address of the nameserver.
1. Stop the BIND service on node01.
2. Execute the command:
dig node01.multinode.kodekloud.lab

Observe the IP address of the server.


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