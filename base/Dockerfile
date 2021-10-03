FROM debian:9

LABEL org.opencontainers.image.authors="Dmitrii V<dsv@scala78.ru>" 

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      openjdk-8-jdk \
      net-tools \
      curl \
      netcat \
      gnupg \
      libsnappy-dev \
      ssh \
      openssh-server \
    && rm -rf /var/lib/apt/lists/*
      
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
  chmod 600 ~/.ssh/authorized_keys
COPY configs/config /root/.ssh
RUN chmod 600 /root/.ssh/config

RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS \ 
&& gpg --import KEYS

ENV HADOOP_VERSION 3.2.2
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH $HADOOP_HOME/bin/:$PATH

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
ENV SPARK_VERSION 3.1.2
ENV SPARK_BINARY spark-${SPARK_VERSION}-bin-hadoop3.2
ENV SPARK_URL https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/${SPARK_BINARY}.tgz
RUN curl -O https://dist.apache.org/repos/dist/release/spark/KEYS \ 
&& gpg --import KEYS

RUN set -x \
    && curl -fSL "$SPARK_URL" -o /tmp/spark.tar.gz \
    && curl -fSL "$SPARK_URL.asc" -o /tmp/spark.tar.gz.asc \
    && gpg --verify /tmp/spark.tar.gz.asc \
    && tar -xvf /tmp/spark.tar.gz -C /opt/ \
    && rm /tmp/spark.tar.gz

RUN ln -s /opt/${SPARK_BINARY}/etc/hadoop /etc/spark
RUN mkdir /opt/${SPARK_BINARY}/logs
RUN ln -s /opt/spark /opt/${SPARK_BINARY}


ENV SPARK_HOME=/opt/spark
ENV SPARK_CONF_DIR=/etc/spark

ENV USER=root
ENV PATH $SPARK_HOME/bin/:$PATH

COPY  configs/* ${HADOOP_CONF_DIR}/
COPY  configs/spark-defaults.conf ${SPARK_CONF_DIR}/
ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]
