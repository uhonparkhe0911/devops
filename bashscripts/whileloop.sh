#!/bin/bash

counter=0

while [ $counter -lt 8 ]
do
    echo "Looping..."
    echo "Value of counter is $counter"
    counter=$(( $counter + 1))
    sleep 2
done

echo "Out of loop...."