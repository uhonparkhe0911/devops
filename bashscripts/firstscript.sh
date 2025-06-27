#!/bin/bash

### This script prints system information and the current date

echo "Welcome to my first script!"
echo "######################################"
echo "Current date and time: $(date)"
echo 

### Checking system uptime
echo "######################################"
echo "The uptime of the system is: "
uptime
echo 

### Checking Memory utilization
echo "######################################"
echo "Memory utilization: "
free -m
echo

### Checking disk utilization
echo "######################################"
echo "Disk utilization: "
df -h
