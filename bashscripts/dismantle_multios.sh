#!/bin/bash

yum --help &> /dev/null

if [ $? -eq 0 ]
then
    #Remove the httpd service
    echo "Executing dismantle.sh on Centos machine"
    sudo systemctl stop httpd
    sudo systemctl diable httpd
    sudo rm -rf /var/www/html/*
    sudo yum remove httpd wget unzip -y
else
    #Remove apache2 service
    echo "Executing dismantle.sh on Ubuntu machine"
    sudo systemctl stop apache2
    sudo systemctl diable apache2
    sudo rm -rf /var/www/html/*
    sudo apt remove apache2 wget unzip -y
fi

