Github link:
https://github.com/dockur/windows?tab=readme-ov-file

docker command for Windows Server 2019
docker run -it --rm --name windows -e "VERSION=2019" -p 8006:8006 --device=/dev/kvm --device=/dev/net/tun --cap-add NET_ADMIN -v "${PWD:-.}/windows:/storage" --stop-timeout 120 docker.io/dockurr/windows
