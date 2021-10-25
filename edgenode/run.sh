#!/bin/bash

# mkdir -p /home/hadoop
# chown -R hadoop:hadoop /home/hadoop

cp /.profile /home/hadoop/

service ssh restart

while true; do sleep 10m ; echo "infinite loop"; done


