# Docker Setup
- Bind9 (Master)
- Bind9 (Slave)
- Nginx

# Download an image without starting a container:
1) docker image pull ubuntu/bind9
^
The servers would be missing the configuration

2) docker image pull nginx:stable-alpine3.23-perl

# Run web server in detached mode, map free host port 8080 to the container’s port 80
*** for -p, docker host is left of :  ,docker container is right of : ***

docker run -d -p 8080:80 nginx:stable-alpine3.23-perl

# Run Bind9 (Master) in detached mode, map free host port 30053 to the container’s port 53
docker run -d -p 30053:53 ubuntu/bind9

# Run Bind9 (Slave) in detached mode, map free host port 30054 to the container’s port 53
docker run -d -p 30054:53 ubuntu/bind9

# QNA
1) Do I want to do port mapping for Bind9? What is Bind9 DNS port?

2) Do I want to do port mapping for Nginx? What is Nginx Http port? 

3) You can actually run Ubuntu Container, then install Bind9, Nginx seperately I think

4) I am not sure if non default ports like 8080, 30053, 30054 will break the demonstration