#!/bin/bash

DATABASE_PASS="admin123"

#Update OS with latest patches
sudo dnf update -y

#Set Repository
sudo dnf install epel-release -y

#Install Maria DB package
sudo dnf install git mariadb-server -y

#Starting and enabling maria db server
sudo systemctl start mariadb
sudo systemctl enable mariadb

#Set DB name and users
sudo mysql -u root -p"$DATABASE_PASS"

sudo mysql -u root -p"$DATABASE_PASS" -e "create database accounts"
sudo mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on accounts.* TO 'admin'@'localhost' identified by 'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on accounts.* TO 'admin'@'%' identified by 'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

#Download source code & initialize database
cd /tmp/
git clone -b main https://github.com/hkhcoder/vprofile-project.git
sudo mysql -u root -p"$DATABASE_PASS" accounts < /tmp/vprofile-project/src/main/resources/db_backup.sql
sudo mysql -u root -p"$DATABASE_PASS" accounts

#Restart maria db server
sudo systemctl restart mariadb

#Starting the firewall and allowing the mariadb to access from port no 3306
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --add-port=3306/tcp --permanent
sudo firewall-cmd --reload
sudo systemctl restart mariadb