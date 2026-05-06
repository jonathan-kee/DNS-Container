# Kodeloud's 2 Tier Application Architecture
*** LAMP stack (Linux, Apache, Mariadb, PHP) ***
1) CentOS (Install firewalld)
2) MariaDB (database)
3) PHP (frontend & backend)
4) Apache (reverse-proxy)

Repository for Kodeloud's 2 Tier Application:
https://github.com/kodekloudhub/learning-app-ecommerce/tree/master
^
I am guessing you can run a linux docker container then provision it following the README instruction

Guide on building a dockerfile:
https://labs.iximiuz.com/challenges/docker-write-first-dockerfile

*** I think Artifacts like Java's jar, Php code should be copied over to the docker image *** 
*** Before building the docker image, try to run the commands in the docker image first ***

Problems I faced when building the image file: 
- Feeding sql commands to my-sql cli
^
Because you are still in the building phase, this might a Bash issue instead of a docker command issue like below:
https://labs.iximiuz.com/challenges/docker-101-container-run-interactive

Example to pass data to a running container:
cat ~/avatar.png | \
  docker run -i redis \
    redis-cli -h 172.16.0.3 -x set avatar:user123

- Copying over configuration files like .env
^
I think copying over is a docker issue

# Project Architecture
*** Follow Kodekloud's 2 Tier Applications because currently lacking frontend & backend ***
1) reverse-proxy (Nginx) / (2 Tier's Apache)
2) frontend (React) / (2 Tier's PHP)
3) backend (Fastify) / (2 Tier's PHP)
4) database (Postgres) / (2 Tier's MariaDB)
5) node01 (Bind9 DNS Master / Name Server)
6) node02 (DNS Client / Resolvers)

# Project Architecture's IP addresses & Ports
*** Make sure to use static address, otherwise will break in future ***

Container Name    | IP Address     | Port
- reverse-proxy   | 172.17.0.1/16  | 443    (HTTPS) (Don't HTTP over internet)
- frontend        | 172.17.0.2/16  | 80     (HTTP)
- backend         | 172.17.0.3/16  | 80     (HTTP)
- database        | 172.17.0.4/16  | 5432   (DB)
- dns             | 172.17.0.5/16  | 53     (DNS)
- client          | 172.17.0.6/16  | xx

# Docker setup
## Docker Run Documentation:
https://docs.docker.com/reference/cli/docker/container/run/

## Reverse-Proxy
docker run --name nginx --detach nginx:stable-alpine3.23-perl

## DNS 
docker run --detach \
        --name=dns \
        --restart=always \
        --volume /etc/bind \
        --volume /var/cache/bind \
        --volume /var/lib/bind \
        --volume /var/log \
        ubuntu/bind9

## Frontend
*** Probably have to create your own image in real world project ***

## Backend
*** Probably have to create your own image in real world project ***

## Database
docker run --name database --env POSTGRES_PASSWORD=mysecretpassword --detach postgres

## Client
*** Remove --dns-search=test (This one is working) ***
docker run --name client -it --detach --dns=172.17.0.2 yauritux/busybox-curl