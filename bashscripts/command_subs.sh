#!/bin/bash

echo "Welcome $USER on $HOSTNAME"
echo "########################################"

FREERAM=$(free -m | grep Mem | awk ' {print $4}')
LOAD=$(uptime | awk ' {print $9}')
ROOTFREE=$(df -h | grep /dev/sda1 | awk ' {print $4}')


echo "#####################################"
echo "Available FREE RAM is $FREERAM MB"
echo "#####################################"
echo "Current Load Average of the system is $LOAD"
echo "#####################################"
echo "Free ROOT partition size is $ROOTFREE"