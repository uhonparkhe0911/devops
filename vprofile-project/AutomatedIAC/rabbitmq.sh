#!/bin/bash

#Update OS with latest patches
sudo dnf update -y

#Set Repository
sudo dnf install epel-release -y

#Install dependencies
sudo dnf install wget centos-release-rabbitmq-38 -y
sudo dnf install rabbitmq-server --enablerepo=centos-rabbitmq-38 -y

#Starting and enabling rabbitmq
sudo systemctl start rabbitmq-server
sudo systemctl enable rabbitmq-server --now

#Setup access to user test and make it admin
sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator
rabbitmqctl set_permissions -p / test ".*" ".*" ".*"
sudo systemctl restart rabbitmq-server

#Starting the firewall and allowing the port 5672 to access rabbitmq
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --add-port=5672/tcp
sudo firewall-cmd --runtime-to-permanent

sudo systemctl enable rabbitmq-server

