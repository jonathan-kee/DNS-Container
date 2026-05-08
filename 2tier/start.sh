#!/bin/bash
service mariadb start
mysql < /db-configure.sql
mysql < /db-load-script.sql
service apache2 start