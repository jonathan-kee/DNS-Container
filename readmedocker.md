# Docker setup
## Pull Images
docker image pull internetsystemsconsortium/bind9:9.20
docker image pull nginx:stable-alpine3.23-perl
docker image pull ubuntu
^
Ubuntu no utilities

docker image pull busybox
^
No curl

docker image pull yauritux/busybox-curl


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

docker run --name client -it --detach busybox
^
Need -it for it to stay running
^
No curl

docker run --name client -it --detach --dns=172.17.0.2 --dns=172.17.0.3 --dns-search=test yauritux/busybox-curl

# Test Connection & note down IPv4 Address
## SSH into Ubuntu-host (Nginx Web Server)
docker exec -it nginx sh
ip a
exit
nginx 172.17.0.4/16

docker exec -it node01 sh
ip a
exit
node01 172.17.0.2/16

docker exec -it node02 sh
ip a
exit
node02 172.17.0.3/16

docker exec -it client sh
ip a
exit
client 172.17.0.5/16

## SSH into Ubuntu-host (Nginx Web Server)
docker exec -it nginx sh
ping -c 1 172.17.0.4
ping -c 1 172.17.0.2
ping -c 1 172.17.0.3
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
docker cp \
    ./node01/named.conf.options \
    node01:/etc/bind/named.conf.options

# Node02 (Bind9 DNS Slave)
## Configure BIND to use our new zone file
docker cp \
    ./node02/named.conf.local \
    node02:/etc/bind/named.conf.local

# Restart DNS servers
docker restart node01 node02 client

# Ubuntu-host (Nginx Web Server)

# Node03 (DNS Client)
## Replace existing /etc/resolv.conf
docker cp \ 
    ./node03/resolv.conf \
    client:/etc/resolv.conf

## Test the accessibility to nginx server
curl www.multinode.kodekloud.lab
