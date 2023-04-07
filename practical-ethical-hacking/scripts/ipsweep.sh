#!/bin/bash

if [ "$1" == "" ]
then 
echo "You forgot an IP!"
echo "./ipsweep.sh 192.168.1"

else
for ip in `seq 1 254`; do 
ping $1.$ip -c 1 | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
done
fi
