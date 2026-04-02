# Docker setup
## Pull Images
docker image pull internetsystemsconsortium/bind9:9.20
docker image pull nginx:stable-alpine3.23-perl
docker image pull ubuntu

# Run Images
*** I removed the mapping of host port to container port to avoid breakage ***

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

docker run --name client --detach ubuntu

# Test Connection & note down IPv4 Address
# # SSH into Ubuntu-host (Nginx Web Server)
docker exec -it nginx sh
ip a
ping -c 1 node01
ping -c 1 node02
ping -c 1 node03

# Node01 (Bind9 DNS Master)
## Copy over zone file
docker cp \
    ./node01/db.multinode.kodekloud.lab \
    node01:/etc/bind/db.multinode.kodekloud.lab

## Configure BIND to use our new zone file
docker cp \
    ./node01/named.conf.local \
    node01:/etc/bind/named.conf.local

## Configure BIND options
docker cp \
    ./node01/named.conf.local \
    node01:/etc/bind/named.conf.options

# Node02 (Bind9 DNS Slave)
## Configure BIND to use our new zone file
docker cp \
    ./node02/named.conf.local \
    node02:/etc/bind/named.conf.local

# Ubuntu-host (Nginx Web Server)

# Node03 (DNS Client)
## Replace existing /etc/resolv.conf
docker cp \ 
    ./node03/resolv.conf \
    node03:/etc/resolv.conf

## Test the accessibility to nginx server
curl www.multinode.kodekloud.lab
