#!/bin/bash

if [ ! -d $dfs_namenode_name_dir ]; then
  echo "Namenode name directory not found: $namedir"
  exit 2
fi

if [ -z "$CLUSTER_NAME" ]; then
  echo "Cluster name not specified"
  exit 2
fi

echo "remove lost+found from $dfs_namenode_name_dir"

echo $HADOOP_CONF_DIR

ls $HADOOP_CONF_DIR

rm -r $dfs_namenode_name_dir/lost+found

if [ "`ls -A $dfs_namenode_name_dir`" == "" ]; then
  echo "Formatting namenode name directory: $dfs_namenode_name_dir"
  $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -format $CLUSTER_NAME
fi

$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode