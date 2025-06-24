#!/bin/bash

#Update OS with latest patches (Optional)
sudo apt update
sudo apt upgrade

#install nginx
sudo apt install nginx -y

#Create nginx conf file
cat <<EOT > vproapp
upstream vproapp {
 server app01:8080;
}
server {
  listen 80;
location / {
  proxy_pass http://vproapp;
}
}
EOT

#Remove default nginx conf
mv vproapp /etc/nginx/sites-available/vproapp
rm -rf /etc/nginx/sites-enabled/default

#Create link to activate website
ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp

#Restart nginx service 
sudo systemctl restart nginx
