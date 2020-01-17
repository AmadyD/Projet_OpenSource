#!/usr/bin/env bash

# Updating packages
sudo apt-get update

# ---------------------------------------
#          MySQL Setup
# ---------------------------------------

# Setting MySQL root user password root/root
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'


# Installing packages
sudo apt-get install -y mysql-server mysql-client

# Allow External Connections on your MySQL Service
sudo sed -i -e 's/bind-addres/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i -e 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root'; FLUSH privileges;"
sudo service mysql restart
# create client database
mysql -u root -proot -e "CREATE DATABASE myDB;"

sudo apt-get -y install apache2

sudo service apache2 restart

sudo apt-get install -y phpmyadmin

sudo -E apt-get -q -y install zabbix-server-mysql zabbix-frontend-php

sudo mysqladmin -u root password root
sudo sh -c "echo 'DBHost=localhost' >> /etc/zabbix/zabbix_server.conf"
sudo sh -c "echo 'DBName=zabbix' >> /etc/zabbix/zabbix_server.conf"
sudo sh -c "echo 'DBUser=zabbix' >> /etc/zabbix/zabbix_server.conf"
sudo sh -c "echo 'DBPassword=zabbix' >> /etc/zabbix/zabbix_server.conf"
sudo sh -c "echo 'php_value date.timezone America/Fortaleza' >> /etc/zabbix/apache.conf"
sudo service apache2 restart
sudo apt-get install -y zabbix-agent
sudo service zabbix-agent start