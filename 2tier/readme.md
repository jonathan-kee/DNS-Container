# 2 Tier Setup
Docker build command:
- docker build --tag 2tier:latest .

Docker run command:
- docker run --detach \
        --name=2tier \
        --privileged \
        --restart=always \
        --publish 127.0.0.1:80:80/tcp \
        --publish 127.0.0.1:3306:3306/tcp \
        2tier:latest bash -c "tail -f /dev/null"

I have to run the below commands after Docker run to work:
- docker exec -it 2tier bash
- bash start.sh
- ss -tulpn

# DNS setup
*** The port mapping I follow internetsystemsconsortium/bind9 ***

docker run --detach \
        --name=dns \
        --restart=always \
        --publish 53:53/udp \
        --publish 53:53/tcp \
        --publish 127.0.0.1:953:953/tcp \
        --volume /etc/bind \
        --volume /var/cache/bind \
        --volume /var/lib/bind \
        --volume /var/log \
        ubuntu/bind9

[Configure Client DNS](../screenshots/ConfigureClientDNS.png)
![Configure Client DNS](../screenshots/ConfigureClientDNS.png)

- Take note of previous IPv4 & IPv6 addresses like 192.168.1.254, etc
- Add 127.0.0.1 for localhost because of docker Bind9 DNS

# Test Connection & note down IPv4 Address
- docker exec -it dns sh
- ip a
- exit

ip a output:
172.17.0.3/16

- docker exec -it 2tier sh
- ip a
- exit

ip a output:
172.17.0.2/16 

*** Make appropriate changes to the dns configuration files ***

# Node01 (Bind9 DNS Master)
## Copy over zone file
docker cp \
    ./dns/node01/db.test \
    dns:/etc/bind/db.test

## Configure BIND to use our new zone file
docker cp \
    ./dns/node01/named.conf.local \
    dns:/etc/bind/named.conf.local

## Configure BIND options
docker cp \
    ./dns/node01/named.conf.options \
    dns:/etc/bind/named.conf.options

## Restart DNS servers
docker restart dns

# QNA
Question: How do I configure my computer to connect to container dns? At the same time also connect to the internet?

Answer: MacOS has the GUI, but I think Linux admistration will be different

Question: Should I do a port mapping for the bind9 DNS container? Then configure my local computer to point a localhost DNS server?

Answer: Yes, after setup bind9 DNS container, make local computer point to itself which is 127.0.0.1

- docker build --tag 2tier:latest .

^

The issue you're hitting is a classic Docker "gotcha": Each RUN command in a Dockerfile executes in a completely new, temporary container.

When you ran RUN service mariadb start in Step 5, it started the database, but as soon as that step finished, the temporary container was shut down. By the time you reached Step 7, MariaDB was no longer running, which is why you got the "Can't connect to local server" error.