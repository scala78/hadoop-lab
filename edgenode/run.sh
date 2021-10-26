#!/bin/bash

# mkdir -p /home/hadoop
# chown -R hadoop:hadoop /home/hadoop

HADOOP_HOME_DIR=${HOME_DIR}/hadoop

mkdir -p ${HADOOP_HOME_DIR} \
    && chown -R hadoop:hadoop ${HADOOP_HOME_DIR}

cp /.profile ${HADOOP_HOME_DIR}/

mkdir -p ${HADOOP_HOME_DIR}/.ssh \
  && ssh-keygen -t rsa -P '' -f ${HADOOP_HOME_DIR}/.ssh/id_rsa \
  && cat ${HADOOP_HOME_DIR}/.ssh/id_rsa.pub >> ${HADOOP_HOME_DIR}/.ssh/authorized_keys \
  && chmod 600 ${HADOOP_HOME_DIR}/.ssh/authorized_keys \
  && chown -R hadoop:hadoop ${HADOOP_HOME_DIR}

# chmod 600 ${HADOOP_HOME_DIR}/.ssh/config \
#     && chown -R hadoop:hadoop ${HADOOP_HOME_DIR}

service ssh restart

while true; do sleep 10m ; echo "infinite loop"; done


