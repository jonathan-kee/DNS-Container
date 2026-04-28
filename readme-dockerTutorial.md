Youtube video
https://www.youtube.com/watch?v=tIlNfB2Vk8s

192.168.1.8 is the IP address his DNS server is running

# install bind9 image
docker image pull ubuntu/bind9

We need two types of zone files

paulpjoby.com ---> 192.168.1.100

named.conf.options is the default file

Below is commendted in named.conf.options
 forwarders {
  8.8.8.8;
  9.9.9.9;
 };


 named.conf.local in which we will be specifying the domain name and also the reverse
 domain zone file

The below can be anyname, as long as full path to the file:
file "/etc/bind/forward.paulpjoby.com";

In reverse zone file, ptr record helps translate ip address to fully qualified domain name
The below can be anyname, as long as full path to the file:
file "/etc/bind/reverse.paulpjoby.com";

You need first 4 octets of Ip address, in-addr-arpa is template standard naming:
zone "1.168.192.in-addr-arpa" 

In forward zone file, @ denotes the origin, not sure what it means by that

The full command (I skip the -v arguments):
sudo docker run --name bind9-dns-server --rm -it --net host ubuntu/bind9

# Run Images
*** I removed the mapping of host port to container port to avoid breakage ***

docker run --detach \
        --name=node01 \
        --restart=always \
        --volume /etc/bind \
        --volume /var/cache/bind \
        --volume /var/lib/bind \
        --volume /var/log \
        ubuntu/bind9

docker run --name client -it --detach --dns=172.17.0.2 --dns-search=test yauritux/busybox-curl

# Remove --dns-search=test (This one is working)
docker run --name client -it --detach --dns=172.17.0.2 yauritux/busybox-curl

docker run --name nginx --detach nginx:stable-alpine3.23-perl

# Test Connection & note down IPv4 Address
docker exec -it node01 sh
ip a
exit
node01 172.17.0.2/16

docker exec -it client sh
ip a
exit
client 172.17.0.3/16

docker exec -it nginx sh
ip a
exit
nginx 172.17.0.4/16

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

# Restart DNS servers
docker restart node01 client

# Test NSLookup if can query DNS Server
nslookup test

# Test curl if can reach Nginx Server
curl nginx.test
curl 172.17.0.4