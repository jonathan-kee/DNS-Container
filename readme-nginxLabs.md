*** There is no final project for Nginx For Beginners course ***

# Lab: Install NGINX & Configure Hello World Page

## Question 2
sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx
systemctl status nginx

## Question 3 
To be able to add firewall rules for our server, install ufw and start the service.

sudo apt update
sudo apt install ufw -y

sudo systemctl enable ufw
sudo systemctl start ufw

systemctl status ufw

ufw --version

## Question 4
