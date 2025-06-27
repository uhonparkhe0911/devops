#!/bin/bash

# Variable Declaration
PACKAGE="httpd wget unzip"
SVC="httpd"
TEMPFILES="/tmp/webfiles"
#URL="https://www.tooplate.com/zip-templates/2098_health.zip"
#ART_NAME="2098_health"


### Installing Dependencies
echo "###############################################"
echo "Installing packages"
echo "###############################################"
sudo yum install $PACKAGE -y > /dev/null


### Start & Enable Service
echo "###############################################"
echo "Star & Enable httpd service"
echo "###############################################"
sudo systemctl start $SVC
sudo systemctl enable $SVC

### Create Temp Directory
echo "###############################################"
echo "Starting Artifact Deployment"
echo "###############################################"
mkdir -p $TEMPFILES
cd $TEMPFILES
echo 
wget $1
sudo unzip $2.zip > /dev/null
sudo cp -r $2/* /var/www/html
echo 

### Bounce service
echo "###############################################"
echo "Restarting httpd service"
echo "###############################################"
sudo systemctl restart $SVC
echo 


### Cleanup
echo "###############################################"
echo "Removing Temporary files"
echo "###############################################"
rm -rf $TEMPFILES
echo 