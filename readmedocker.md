# Node01
## Copy over zone file
docker cp \
    ./node01/db.multinode.kodekloud.lab \
    bind9:/etc/bind/db.multinode.kodekloud.lab

## Configure BIND to use our new zone file
docker cp \
    ./node01/named.conf.local \
    bind9:/etc/bind/named.conf.local

