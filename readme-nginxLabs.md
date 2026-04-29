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
Navigate to the NGINX system directory located at /etc/nginx. Create a new configuration file inside the sites-available folder and call it helloworld

cd /etc/nginx/sites-available
sudo touch helloworld

## Quesiton 5
Add the following content to the helloworld file you have just created:

sudo nano /etc/nginx/sites-available/helloworld

server {
        listen 80;
        server_name helloworldcom;
        root /var/www/helloworld;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
        }
}

## Question 6
cd /var/www
sudo mkdir helloworld

cd helloworld
sudo touch index.html
echo '<h1> Hello World! </h1>' | sudo tee -a index.html

## Question 7