#!/bin/bash

hadoop fs -mkdir hdfs://namenode:9000/spark-logs

$SPARK_HOME/sbin/start-history-server.sh
