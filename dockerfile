FROM ubuntu AS base

# Install FirewallD
RUN sudo yum install -y firewalld
RUN sudo systemctl start firewalld
RUN sudo systemctl enable firewalld
RUN sudo systemctl status firewalld

# Install MariaDB (Missing the configuration for vi command)
RUN sudo yum install -y mariadb-server
RUN sudo vi /etc/my.cnf
RUN sudo systemctl start mariadb
RUN sudo systemctl enable mariadb

# Configure firewall for Database
RUN sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp
RUN sudo firewall-cmd --reload

# Configure Database (I think you put the commands below into a SQL file)
$ mysql
MariaDB > CREATE DATABASE ecomdb;
MariaDB > CREATE USER 'ecomuser'@'localhost' IDENTIFIED BY 'ecompassword';
MariaDB > GRANT ALL PRIVILEGES ON *.* TO 'ecomuser'@'localhost';
MariaDB > FLUSH PRIVILEGES;

# Load Product Inventory Information to database
cat > db-load-script.sql <<-EOF
USE ecomdb;
CREATE TABLE products (id mediumint(8) unsigned NOT NULL auto_increment,Name varchar(255) default NULL,Price varchar(255) default NULL, ImageUrl varchar(255) default NULL,PRIMARY KEY (id)) AUTO_INCREMENT=1;

INSERT INTO products (Name,Price,ImageUrl) VALUES ("Laptop","100","c-1.png"),("Drone","200","c-2.png"),("VR","300","c-3.png"),("Tablet","50","c-5.png"),("Watch","90","c-6.png"),("Phone Covers","20","c-7.png"),("Phone","80","c-8.png"),("Laptop","150","c-4.png");

EOF

# Run sql script
RUN sudo mysql < db-load-script.sql

# Install required packages
RUN sudo yum install -y httpd php php-mysqlnd
RUN sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
RUN sudo firewall-cmd --reload

# Configure httpd
RUN sudo sed -i 's/index.html/index.php/g' /etc/httpd/conf/httpd.conf

# Download code
RUN sudo yum install -y git
RUN sudo git clone https://github.com/kodekloudhub/learning-app-ecommerce.git /var/www/html/

# Create and Configure the .env File
cat > /var/www/html/.env <<-EOF
DB_HOST=localhost
DB_USER=ecomuser
DB_PASSWORD=ecompassword
DB_NAME=ecomdb
EOF

# Update index.php
COPY index.php

# Test
RUN curl http://localhost