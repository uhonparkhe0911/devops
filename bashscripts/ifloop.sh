#!/bin/bash

VALUE=$(ip addr show | grep -v LOOPBACK | grep -ic mtu)

if [ "$VALUE" -eq 1 ] 
then
    echo "One Active Network Interface Found."
elif [ "$VALUE" -gt 1 ]
then
    echo "Multiple Active Interfaces Found."
else
    echo "No Active Interfaces Found."
fi