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