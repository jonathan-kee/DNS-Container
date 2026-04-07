# Project Architecture
1) ubuntu-host (Nginx Web Server)
2) node01 (Bind9 DNS Master / Name Server)
3) node02 (Bind9 DNS Slave / Name Server)
4) node03 (DNS Client / Resolvers)

# Project Architecture's IP addresses & Ports
Container Name | IP Address     | Port
- nginx        | 172.17.0.4/16  | 80
- node01       | 172.17.0.2/16  | 53
- node02       | 172.17.0.3/16  | 53
- client       | 172.17.0.5/16  | xx

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

A resolver may: 
- Have its own cache, and it might be running on the host itself 
- Running on the local router / gateway 
- Combined with a network’s local name server.

^
In my case the DNS server is located locally, instead of a router, I guess I can simulate a router with a resolver.

- Question: Where is the Linux local DNS resolver cache located?

- Question: How do I set up Internal & External DNS?

“How do all these DNS servers know to refresh the records they store in their cache with fresh information from the authoritative name servers?” That is controlled by a time to live (TTL) field on every DNS record. This field indicates the number of seconds that administrators want DNS resolvers to hold records in their caches before removing the cached record.

- Question: How to setup Dynamic DNS (DDNS) for Bind9 on containers?

# Record Explanation
- Start of Authority (SOA) Every zone requires an SOA record that defines the primary name server in charge of the zone. 

- NS An NS record points to the server that holds the records (zone) for a part of the DNS tree. The NS record in Figure 9.22 shows the primary name server for totalhome. My network could have a secondary name server to provide redundancy. This secondary name server is also authoritative for the totalhome domain. 

- A Individual hosts each get their own unique A record. A records are the workhorse records in the zone that hold the IPv4 addresses for hosts.

- AAAA AAAA records (“quad A” when spoken) are the equivalent of A records, but they hold IPv6 addresses. 

- CNAME A CNAME record acts like an alias and holds an FQDN, not an IP address. 

- PTR A PTR record reverses the functions of A or AAAA records. PTR records are found only in reverse lookup zones; they use an IP address for their names and hold the FQDN of a host at that address. One quirk of PTR records is that a PTR record can only point a single IP address to a single FQDN. In contrast, A or AAAA records can have many FQDNs pointing to a single IP address.

*** 
PTR is a one to one relationship for FQDNs pointing to a single IP address
A or AAAA is one to many relationship for FQDNs pointing to a single IP address
****

- MX SMTP servers use MX records exclusively to determine where to send mail. They hold the FQDN of the server that handles mail for the domain. 

- SRV is like custom records

- TXT A TXT record is a freeform type of record that can be used for … anything. TXT records allow any text to be added to a zone. 

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

# Trouble Shooting
## ping
Example from Comptia Network+ book:
- ipconfig / flushdns
- ping www.totalsem.com

## ipconfig / all
Example from Comptia Network+ book:
-  ipconfig / all

## nslookup
Example from Comptia Network+ book:
- nslookup www.totalsem.com 8.8.8.8
- nslookup

interactive mode:
- type server dns.google

## dig (domain information groper)
Example from Comptia Network+ book:
- dig -x 192.168.4.251


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

## Test Dig if can query DNS Server

## Test curl if can reach Nginx Server
curl nginx.test

curl 172.17.0.3

# Restart Containers09
docker restart nginx node01 node02 client
docker restart nginx node01 client

## Make sure to use static address