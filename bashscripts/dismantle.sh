#!/bin/bash


#Remove the httpd service
sudo systemctl stop httpd
sudo systemctl diable httpd
sudo rm -rf /var/www/html/*
sudo yum remove httpd wget unzip -y
