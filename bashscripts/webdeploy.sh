#!/bin/bash

USR="devops"
TMPDIR="/tmp"
HOSTSFILE="remhosts"
EXECFILE=$1

for host in $( cat $HOSTSFILE )
do
    echo "######################################"
    echo "Copying websetup file to $host"
    scp "$EXECFILE" "$USR@$host:$TMPDIR"
    echo "Executing the file on $host"
    ssh $USR@$host sudo $TMPDIR/$EXECFILE
    echo "######################################"
    echo
done