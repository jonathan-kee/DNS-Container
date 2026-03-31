# Docker Setup
- Bind9 (Master)
- Bind9 (Slave)
- Nginx

# Download an image without starting a container:
1) docker image pull ubuntu/bind9
^
The servers would be missing the configuration

2) docker image pull nginx:stable-alpine3.23-perl

# QNA
1) Do I want to do port mapping for Bind9? What is Bind9 DNS port?
2)  Do I want to do port mapping for Nginx? What is Nginx Http port? 