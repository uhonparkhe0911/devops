#!/bin/bash

TOMURL="https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.26/bin/apache-tomcat-10.1.26.tar.gz"
MAVENURL="https://archive.apache.org/dist/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip"

#Update OS with latest patches
sudo dnf update -y 

#Set Repository
sudo dnf install epel-release -y

#Install Dependencies
dnf -y install java-17-openjdk java-17-openjdk-devel
dnf install git wget unzip zip -y

#Download and untar TOMCAT package
cd /tmp/
wget $TOMURL -O tomcatbin.tar.gz
EXTOUT=`tar xzvf tomcatbin.tar.gz`
TOMDIR=`echo $EXTOUT | cut -d '/' -f1`

#Add tomcat user
useradd --shell /sbin/nologin tomcat

#Copy data to tomcat home directoryt
rsync -avzh /tmp/$TOMDIR/ /usr/local/tomcat/

#Make tomcat user owner of tomcat home dire
chown -R tomcat.tomcat /usr/local/tomcat
rm -rf /etc/systemd/system/tomcat.service

#Create tomcat service file
cat <<EOT >  /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat
After=network.target

[Service]
User=tomcat
Group=tomcat
WorkingDirectory=/usr/local/tomcat
Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_PID=/var/tomcat/%i/run/tomcat.pid
Environment=CATALINA_HOME=/usr/local/tomcat
Environment=CATALINA_BASE=/usr/local/tomcat
ExecStart=/usr/local/tomcat/bin/catalina.sh run
ExecStop=/usr/local/tomcat/bin/shutdown.sh
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOT

#Reload systemd files
systemctl daemon-reload

#Start and enable tomcat service
systemctl start tomcat
systemctl enable tomcat


#Starting the firewall and allowing the port 8080 to access the tomcat
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --add-port=8080/tcp --zone=public --permanent
sudo firewall-cmd --reload

#Maven Setup
cd /tmp/
wget $MAVENURL -O apache-maven-3.9.9-bin.zip
unzip apache-maven-3.9.9-bin.zip
cp -r apache-maven-3.9.9 /usr/local/maven3.9
export MAVEN_OPTS="-Xmx1048m"

#Download source code
git clone -b local https://github.com/hkhcoder/vprofile-project.git

#Build code
cd vprofile-project
/usr/local/maven3.9/bin/mvn install

#Deploy artifact
systemctl stop tomcat
sleep 20
rm -rf /usr/local/tomcat/webapps/ROOT*
cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
systemctl start tomcat
sleep 20
systemctl stop firewalld
systemctl disable firewalld
systemctl restart tomcat
