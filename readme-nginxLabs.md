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
Now that we've created our Hello World site, we need to remove the default NGINX welcome page. Navigate to NGINX system directory and remove it

sudo rm /etc/nginx/sites-enabled/default

## Question 8
In the /etc/nginx/sites-enabled/ directory, create a symbolic link for our new Hello World configuration file. 

sudo ln -s /etc/nginx/sites-available/helloworld /etc/nginx/sites-enabled/

You can test the configuration by running:

sudo nginx -t

If there are no errors with the NGINX configuration, proceed to reload NGINX using the following command

sudo nginx -s reload

## Question 9
Now, enable ufw if it is not enabled. Add two firewall rules to allow ports 22 and 80 over TCP protocol

Make sure to enable the 22/tcp port on ufw before validating your work by clicking the Check button below

To enable ufw, run:
sudo ufw enable

To check ufw status, run:
sudo ufw status

To create the firewall rules, run:
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp

## Question 10
curl localhost

# Lab: Configure Multiple Sites

## Question 1
Verify Nginx is running by running systemctl status nginx

systemctl status nginx

If it’s not running start it by running systemctl start nginx

systemctl start nginx

## Question 2
Test Nginx by running "curl localhost" and you should get the Welcome to Nginx message

## Question 3
Navigate to Nginx system directory /etc/nginx

Create a new configuration inside the sites-available folder and call it example1

Inside this file add the following configuration:

cd /etc/nginx/sites-available 

sudo bash -c 'cat <<"EOF" > /etc/nginx/sites-available/example1
server {
    listen 80;
    server_name example1.com;
    root /var/www/example1;

    # Add index.php to the list if you are using PHP
    index index.html index.htm index.nginx-debian.html;

    location / {
        # First attempt to serve request as file, then
        # as directory, then fall back to displaying a 404.
        try_files $uri $uri/ =404;
    }
}
EOF'

## (Skip) Question 4

## Question 5
Navigate to /var/www and create a new directory called example1

Now create a new file called index.html inside /var/www/example1/

Add simple HTML code inside the index.html

sudo mkdir -p /var/www/example1
sudo touch /var/www/example1/index.html
echo "<h1> Example 1! </h1>" | sudo tee /var/www/example1/index.html > /dev/null

## (Skip) Question 6

## Question 7
Now, create copy of /etc/nginx/sites-available /example1 and rename the copied dir to /etc/nginx/sites-available/example2

Make sure to rename the contents inside example2 accordingly.

Create another copy of /var/www/example1/ and rename the copied dir to /var/www/example2/

Make sure to modify the contents inside index.html accordingly, as we did earlier for example1.

cd /etc/nginx/sites-available 

sudo bash -c 'cat <<"EOF" > /etc/nginx/sites-available/example2
server {
    listen 80;
    server_name example2.com;
    root /var/www/example2;

    # Add index.php to the list if you are using PHP
    index index.html index.htm index.nginx-debian.html;

    location / {
        # First attempt to serve request as file, then
        # as directory, then fall back to displaying a 404.
        try_files $uri $uri/ =404;
    }
}
EOF'

sudo mkdir -p /var/www/example2
sudo touch /var/www/example2/index.html
echo "<h1> Example 2! </h1>" | sudo tee /var/www/example2/index.html > /dev/null

## Question 8
Navigate to Nginx system directory and remove the Welcome to Nginx Page

Now create a symbolic link for both example configurations.

Run below commands to complete the task:
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/example1 /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/example2 /etc/nginx/sites-enabled/
sudo systemctl restart nginx

## Question 9
Check Nginx configuration by running "sudo nginx -t"

If there are no errors proceed to reloading Nginx by running "sudo nginx -s reload"

## Question 10
Enable UFW if it’s not enabled already.

Add Firewall Rules for Ports 22 and 80

Enable ufw:
sudo ufw enable

Add firewall rules:
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp

Check the firewall status
sudo ufw status verbose

## Question 11
Check if website is running:

curl -sI -H "Host: example1.com" http://localhost
curl -sI -H "Host: example2.com" http://localhost