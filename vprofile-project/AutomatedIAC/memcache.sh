#!/bin/bash

#Update OS with latest patches
sudo dnf update -y

#Set Repository
sudo dnf install epel-release -y

#Install memcache
sudo dnf install memcached -y

#Starting and enabling memcached
sudo systemctl start memcached
sudo systemctl enable memcached

#Update the memcached configuration to listen on all network interfaces instead of just localhost
sudo cp /etc/sysconfig/memcached /etc/sysconfig/memcached.bak
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/sysconfig/memcached

#Restart memcached
sudo systemctl restart memcached

#Starting the firewall and allowing the port 11211 to access memcached
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --add-port=11211/tcp
sudo firewall-cmd --runtime-to-permanent
sudo firewall-cmd --add-port=11111/udp
sudo firewall-cmd --runtime-to-permanent
sudo memcached -p 11211 -U 11111 -u memcached -d
