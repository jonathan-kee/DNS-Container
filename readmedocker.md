# Project Architecture
1) ubuntu-host (Nginx Web Server)
2) node01 (Bind9 DNS Master / Name Server)
3) node02 (Bind9 DNS Slave / Name Server)
4) node03 (DNS Client / Resolvers)

# Project Architecture's IP addresses & Ports
Container Name | IP Address | Port
- nginx  | 172.17.0.4/16 | 80
- node01 | 172.17.0.2/16 | 53
- node02 | 172.17.0.3/16 | 53
- client | 172.17.0.5/16 | xx

# Private Network DNS naming
## Fully Qualified Domain
nginx.test.

## Top Level Domain
test

## Sub Domains
nginx

## Forward Lookup Zone documentation

## Reverse Lookup Zone documentation

# QNA Private Network DNS naming
- From my understanding, the DNS server for test. is responsbile to provide the records to resolve nginx.test. subdomain

- A regular lookup is also sometimes called a forward lookup. Windows Server uses the term Forward Lookup Zones for normal zones and Reverse Lookup Zones for zones that map IP addresses to names.

^

This is reffering to the zone file, so db.test is most likely the forward zone file.

# Docker setup
## Pull Images
- docker image pull internetsystemsconsortium/bind9:9.20

- docker image pull nginx:stable-alpine3.23-perl

docker image pull ubuntu

^
Ubuntu No Utilities

docker image pull busybox

^
No Curl

- docker image pull yauritux/busybox-curl


# Run Images
*** I removed the mapping of host port to container port to avoid breakage from client / resolver query the DNS server / Nameserver ***

docker run --detach \
        --name=node01 \
        --restart=always \
        --volume /etc/bind \
        --volume /var/cache/bind \
        --volume /var/lib/bind \
        --volume /var/log \
        internetsystemsconsortium/bind9:9.20

docker run --detach \
        --name=node02 \
        --restart=always \
        --volume /etc/bind \
        --volume /var/cache/bind \
        --volume /var/lib/bind \
        --volume /var/log \
        internetsystemsconsortium/bind9:9.20

docker run --name nginx --detach nginx:stable-alpine3.23-perl

docker run --name client -it --detach busybox

^
Need -it for it to stay running

^
No curl

docker run --name client -it --detach --dns=172.17.0.2 --dns-search=test yauritux/busybox-curl

# Setup Ansible to Test Connection


# Test Connection & Note down IPv4 Address
## SSH into Ubuntu-host (Nginx Web Server)
1) docker exec -it nginx sh
2) ip a
3) exit
4) nginx 172.17.0.4/16
172.17.0.3

##
1) docker exec -it node01 sh
2) ip a
3) exit
4) node01 172.17.0.2/16

##
1) docker exec -it node02 sh
2) ip a
3) exit
4) node02 172.17.0.3/16

## 
1) docker exec -it client sh
2) ip a
3) exit
4) client 172.17.0.5/16
172.17.0.4/16

## SSH into Ubuntu-host (Nginx Web Server)
docker exec -it nginx sh

ping -c 1 172.17.0.2

ping -c 1 172.17.0.3

ping -c 1 172.17.0.4

ping -c 1 172.17.0.5

# Node01 (Bind9 DNS Master)
## Copy over zone file
docker cp \
    ./node01/db.test \
    node01:/etc/bind/db.test

## Configure BIND to use our new zone file
docker cp \
    ./node01/named.conf.local \
    node01:/etc/bind/named.conf.local

## Configure BIND options
*** The template can allow zone transfer of Master to Slave ***

docker cp \
    ./node01/named.conf.options \
    node01:/etc/bind/named.conf.options

# Node02 (Bind9 DNS Slave)
## Configure BIND to use our new zone file
docker cp \
    ./node02/named.conf.local \
    node02:/etc/bind/named.conf.local


# Ubuntu-host (Nginx Web Server)
*** This section requires no configuration ***

# Node03 (DNS Client)
## Replace existing /etc/resolv.conf
docker cp \ 
    ./node03/resolv.conf \
    client:/etc/resolv.conf

## Test NSLookup if can query DNS Server
nslookup test

## Test curl if can reach Nginx Server
curl nginx.test

curl 172.17.0.3

# Restart Containers09
docker restart nginx node01 node02 client
docker restart nginx node01 client

## Make sure to use static address