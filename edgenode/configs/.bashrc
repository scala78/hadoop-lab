HADOOP_VERSION="3.2.2"
export HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
export HADOOP_CONF_DIR=/etc/hadoop
export PATH=$HADOOP_HOME/bin/:$PATH
export SPARK_HOME=/opt/spark
export SPARK_CONF_DIR=/etc/spark
export PATH=$SPARK_HOME/bin/:$PATH
export LD_LIBRARY_PATH=$HADOOP_HOME/lib/native:$LD_LIBRARY_PATH