#!/bin/bash

$LIVY_HOME/bin/livy-server start

while true; do sleep 10m ; echo "infinite loop"; done