#!/bin/bash

if [ ! -d $dfs_datanode_data_dir ]; then
  echo "Datanode data directory not found: $dfs_datanode_data_dir"
  exit 2
fi

$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR datanode
