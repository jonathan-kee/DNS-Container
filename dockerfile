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
RUN sudo mysql < db-configure.sql

# Run sql script
RUN sudo mysql < db-load-script.sql

# Install required packages
RUN sudo yum install -y httpd php php-mysqlnd
RUN sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
RUN sudo firewall-cmd --reload

# Configure httpd
RUN sudo sed -i 's/index.html/index.php/g' /etc/httpd/conf/httpd.conf

# Download code
# You can fork the repository, than make changes to the index.php so the below code would be unnessary
RUN sudo yum install -y git
RUN sudo git clone https://github.com/kodekloudhub/learning-app-ecommerce.git /var/www/html/

# Create and Configure the .env File
# Copy syntax is from -> to 
COPY ./2tier/.env /var/www/html/

# Update index.php
COPY index.php

# Test
RUN curl http://localhost