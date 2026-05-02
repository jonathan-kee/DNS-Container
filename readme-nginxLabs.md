*** There is no final project for Nginx For Beginners course ***
*** I don't think you have to know everything to setup your first project ***

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

# Lab: Configure URL Redirects & Rewrites
cd /etc/nginx

## Question 1
Welcome to the NGINX lab. In this lab, you will be able to redirect HTTP to HTTPS traffic and rewrite rules to adjust domain URLs.

To access NGINX UI, click on the NGINX UI tab located on the top right corner above the terminal.

## Question 2
1) Navigate to the Nginx system directory by executing the following command:
cd /etc/nginx

2) Inspect the configuration file located in the sites-available folder named diner.

3) Confirm that the website is functioning correctly by running the following command:
curl --head -H "Host: diner.com" localhost

## Question 3
1) Note that while the website should be operational, the output of the above command does not redirect to HTTPS.

2) Remove the current configuration, execute the following command to remove current configuration:
sudo rm /etc/nginx/sites-enabled/diner

## Question 4
1) Inspect the file named diner-https located in the /etc/nginx/sites-available/ directory.

2) Note that this configuration contains two server blocks: one for HTTP on Port 80 and another for HTTPS on Port 443.

3) Within the server { listen 80; } block, add configuration to redirect the requests from http requests to https.

sudo nano /etc/nginx/sites-available/diner-https

server {
    listen 80;
    server_name diner.com;
    return 301 https://$host$request_uri;
}
server {
    listen 443 ssl;
    server_name diner.com;
    ssl_certificate /etc/ssl/certs/diner.com.pem;
    ssl_certificate_key /etc/ssl/certs/diner.com-key.pem;
    root /var/www/diner;
    index index.html index.htm index.nginx-debian.html;
    location / {
        try_files $uri $uri/ =404;
    }
}

## Question 5 
There are already TLS Certificates installed in this server so no need to worry about installing them or configuring anything else.

## Question 6 
1) Verify the syntax of the configuration file located at /etc/nginx/sites-available/diner-https by executing the following command:
sudo nginx -t

2) Create a symbolic link to enable the diner-https configuration
sudo ln -s /etc/nginx/sites-available/diner-https /etc/nginx/sites-enabled/

3) If the syntax check indicates that everything is correct, proceed to reload the Nginx server with the following command:
sudo nginx -s reload

4) To confirm the redirection is functioning as intended, run the following command:
curl -I -H "Host: diner.com" localhost

You should receive a response message stating 301 Moved Permanently.

5) Additionally, run this command to observe the redirection behavior:
curl -IL -H "Host: diner.com" localhost

Note: The redirect rule is set up to redirect all HTTP requests to HTTPS. This can be observed from the output. You can see the line below from output

Location: https://diner.com/

## Question 7
Now, let's focus on the rewrite module.
1) Inspect the file located at "/etc/nginx/sites-available/example". It is a straight forward file that contains the directive root /var/www/html;.

2) Navigate to the "/var/www/html/" directory to examine its contents. Within this folder, you will find a directory named images, which contains numerous JPG files.

## Question 8 
Enable and reload the example website in Nginx, and browse to a specific image on the site.

Enable this example website by running
sudo ln -s /etc/nginx/sites-available/example /etc/nginx/sites-enabled/

Reload it by running
sudo nginx -s reload

On top of the terminal, there is an nginx icon click on it

You should see a fairly simple HTML website with lots boxes and images.

Try to browse to an image by adding to the URL the following
/images/pic10.jpg

and you can try a few other images like pic08.jpg

## Question 9
Using the rewrite module, we can have Nginx rewrite the URLs so that instead of seeing images/ we’ll see pics/. This is useful in case users have saved bookmarks and it’s a safe approach into making adjustments to a website without breaking the flow.

## Question 10
Return to the terminal and navigate to the directory /var/www/html. Rename the folder images to pics.

1) Navigate to /var/www/html directory
cd /var/www/html

2) Rename the folder images to pics
sudo mv images pics

## Question 11
Open the website in your browser and observe that the images are not functioning properly. This is an ideal opportunity to utilize the rewrite module.

## Question 12
Update example Nginx configuration file in /etc/nginx/sites-available/ to rewrite the location of content to pics folder.

Navigate to /etc/nginx/sites-available/ directory by below command
cd /etc/nginx/sites-available/

Use VIM to open example file and add the regex code rewrite ^/images/(.*)$ /pics/$1 permanent; in the location block as shown below, save the file and exit.
sudo nano /etc/nginx/sites-available/example

server {
    listen 80;
    server_name example.com;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    location / {
        rewrite ^/images/(.*)$ /pics/$1 permanent;
        try_files $uri $uri/ =404;
    }
}

## Question 13
Browse to any image (there are only 13 jpg files so keep that in mind) and you should see that Nginx is rewriting the requested /images/pic02.jpg to /pics/pic02.jpg.

Note: You can access the website from Nginx ICON on the terminal.

# Lab: Load Balancer

## Question 1
Welcome to the NGINX lab. In this lab, you will be Load balance traffic.

To access NGINX UI, click on the NGINX UI tab located on the top right corner above the terminal.

## Question 2
1) Navigate to the Nginx system directory by executing the following command:
cd /etc/nginx

2) Inspect the configuration file located in the sites-available folder named apache-app.

3) Confirm that the website is functioning correctly by running the following command:
curl -I -H "Host: apache.example.com" http://localhost

## Question 3
In this Lab, there are three nodes.
1) nginx - Nginx server
2) node01 - Apache server
3) node02 - Apache server

You can access node01 and node02 via SSH.

For example:
ssh node01

On the terminal bar, click on the + button, open new terminal and login into node01 and node02 using

ssh node01
ssh node02

- These nodes are running Apache with a simple HTML website
- To verify these Apache Web Servers are running correctly, run

curl localhost

- Both servers should respond with an HTML page
- Run ip a command and note ip address of eth0 interface.

## Question 4
Get Nginx’s IP address by running

ip a

inside the nginx node check for ip address of eth0

IP should start with 192.23x.x.x

Make a note of Ip address
192.168.126.194/32

## Question 5
1) In the nginx node, navigate to nginx’s config folder by changing directory to /etc/nginx/sites-available/ and open the apache-app file

2) Open the apache-app file by executing the following command:
sudo nano sites-available/apache-app

3) Inside this file, add the following configuration above the server { listen 80; } block:

upstream apache_example {
    server <IP of node01>:80;
    server <IP of node02>:80;
}

server {
    listen 80;
    server_name apache.example.com;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    location / {
        try_files $uri $uri/ =404;
        proxy_pass http://apache_example;
    }
}

4) Next, add the proxy_pass directive inside the location / block as follows:

location / {
    # First attempt to serve request as file, then
    # as directory, then fall back to displaying a 404.
    try_files $uri $uri/ =404;
    proxy_pass http://apache_example;
}

5) Check syntax by running
sudo nginx -t

and if all looks good, reload by running

sudo nginx -s reload

## Question 6
- On the right-hand corner of the lab terminal, click NGINX, and you should see the HTML website

- If you keep refreshing, you should see this switch between NODE01 HTML5 UP and NODE02 HTML5 UP

- Now you have configured a round robin Nginx Load Balancer that distributes traffic to 2 backend Apache Web Servers.

## Question 7
Follow the steps below to implement the weighted round robin algorithm in your Nginx configuration:

1) Open the Nginx configuration file for the Apache application located at
sudo nano /etc/nginx/sites-available/apache-app

2) Update the upstream {} block with the following weights for the nodes:
- node01: weight=9
- node02: weight=1

upstream apache_example {
    server 192.230.X.X:80 weight=9;
    server 192.230.X.X:80 weight=1;
 }

3) Save the changes to the file. To check the syntax, run the command:
sudo nginx -t

4) If there are no errors, proceed to reload Nginx with the following command:
nginx -s reload

## Question 8
keep refreshing the website that you opened in the previous step. You should see that 9 times out of 10 the first node listed will display.

## Question 9
Let’s experiment with another algorithm by with the ip_hash algorithm.

1. Open the apache-app file in Nginx configuration file located in /etc/nginx/sites-available/
sudo nano /etc/nginx/sites-available/apache-app

- Remove weights assigned in previous step.
- Add ip_hash to the upstream {} block.

upstream apache_example {
    ip_hash;
    server 192.234.xxx.xx:80;
    server 192.234.xxx:xx:80;
  }

2. Check syntax by running
sudo nginx -t

and if all looks good, reload by running

sudo nginx -s reload

## Question 10
keep refreshing the website that you opened in the previous step. You will keep hitting the same node over and over again because of the sticky sessions also known as ip_hash.

## Question 11
let’s create an issue in one of the Apache Web Servers to see how Nginx handles it.

SSH into node01
ssh node01

and run the following command to stop Apache on node01
sudo systemctl stop apache2

Now refresh the website you opened in previous step, you will see the website is served from node02.

Nginx will detect that one of the nodes is not responding when it does its health check and therefore will not redirect traffic to it.

# Lab: Reverse Proxy

## Question 1
Welcome to the NGINX lab. In this lab, you will be configuring reverse proxy.

To access NGINX UI, click on the NGINX UI tab located on the top right corner above the terminal.

## Question 2
In this Lab, there are three nodes.

1) nginx - Nginx server
2) node01 - Flask server
3) node02 - Flask server

You can access node01 and node02 via SSH.

For example:
ssh node01

On the terminal bar, click on the + button, open new terminal and login into node01 and node02 using

ssh node01
ssh node02

- These nodes are running a simple Flask application.
- To verify these Flask applications are running correctly run below command:

curl localhost:5000

- Both servers should respond with a simple Hello, Human!
- Run "ip a" command and note the IP address of eth0 interface.

## Question 3
In the Nginx node, please navigate to the Nginx configuration folder by changing the directory to /etc/nginx/sites-available. Then, open the helloworld file by executing the below command.

cat helloworld

Observe the default configuration.

server {
  listen 80;
  server_name helloworld.com;
  root /var/www/html;
  index index.html index.htm index.nginx-debian.html;
  
  location / {
    proxy_pass http://hello_world;
  }
}

## Question 4
Get Nginx’s IP address of node01 and node02 by running

Node01:
ssh node01 "ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+\.\d+\.\d+\.\d+' | head -1"

Node01 Output:
192.168.25.65

Node02:
ssh node02 "ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+\.\d+\.\d+\.\d+' | head -1"

Node02 Output:
192.168.84.190

Note the IP address we need them for next question.

## Question 5
1. Navigate to the Nginx configuration folder by changing the directory to /etc/nginx.

2. Open the helloworld file by executing the following command:
sudo nano sites-available/helloworld

3. Inside this file, add the following configuration above the server { listen 80; } block:

upstream hello_world {
    server 192.168.25.65:5000;
    server 192.168.84.190:5000;
}

server {
  listen 80;
  server_name helloworld.com;
  root /var/www/html;
  index index.html index.htm index.nginx-debian.html;

  location / {
    proxy_pass http://hello_world;
  }
}

4) Check syntax by running
sudo nginx -t

and if all looks good, reload by running

sudo nginx -s reload

## Question 6
On the right-hand corner of the lab terminal, click NGINX, and You should see the Hello, Human! Response from the Flask applications

# Lab: HTTPS

# Lab: HTTP Headers

# Lab: Authentication

# Lab: Blocking Traffic

# Lab: Rate Limmiting

# Lab: Caching

# Lab: Compression