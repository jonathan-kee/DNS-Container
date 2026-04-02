# Docker setup
## Pull Images
docker image pull internetsystemsconsortium/bind9:9.20
docker image pull nginx:stable-alpine3.23-perl
docker image pull ubuntu

# Run Images
docker run \
        --name=node01 \
        --restart=always \
        --publish 53:53/udp \
        --publish 53:53/tcp \
        --publish 127.0.0.1:953:953/tcp \
        --volume /etc/bind \
        --volume /var/cache/bind \
        --volume /var/lib/bind \
        --volume /var/log \
        internetsystemsconsortium/bind9:9.20

docker run \
        --name=node02 \
        --restart=always \
        --publish 53:53/udp \
        --publish 53:53/tcp \
        --publish 127.0.0.1:953:953/tcp \
        --volume /etc/bind \
        --volume /var/cache/bind \
        --volume /var/lib/bind \
        --volume /var/log \
        internetsystemsconsortium/bind9:9.20

docker run --name nginx --detach -p 8080:80 nginx:stable-alpine3.23-perl

docker run --name client --detach ubuntu

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
