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
    unzip \
    git \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    wget \
    krb5-multidev \
    && rm -rf /var/lib/apt/lists/*

ENV PYTHON_VERSION=3.8.12
RUN set -x \
    && cd /tmp \
    && curl -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz \
    && tar xf Python-${PYTHON_VERSION}.tar.xz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations \
    && make \
    && make install \
#    && rm /usr/bin/python /usr/bin/python3 \
    && ln -s /usr/local/bin/python3 /usr/bin/python \
    && ln -s /usr/local/bin/python3 /usr/bin/python3 \
    && /usr/local/bin/python3.8 -m pip install --upgrade pip \
    && pip3 install "cloudpickle >= 0.5.3" requests requests-kerberos "flake8  >= 3.8.0" "flaky >= 3.7.0" "pytest >= 5.4.2" "pytest-runner >= 5.2.0" "packaging >= 20.9" "pyparsing == 2.4.6" "six == 1.16.0"\
    && rm -rf /tmp/Python*
      
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
  chmod 600 ~/.ssh/authorized_keys
COPY configs/config /root/.ssh
RUN chmod 600 /root/.ssh/config

RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS \ 
&& gpg --import KEYS

ARG HADOOP_VERSION 3.3.1
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
ARG SPARK_VERSION 3.2.0
ARG SPARK_HADOOP_VERSION 3.2
ENV SPARK_BINARY spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}
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
RUN ln -s /opt/${SPARK_BINARY} /opt/spark


ENV SPARK_HOME=/opt/spark
ENV SPARK_CONF_DIR=/etc/spark

ENV USER=root
ENV PATH $SPARK_HOME/bin/:$PATH
ENV LD_LIBRARY_PATH $HADOOP_HOME/lib/native:$LD_LIBRARY_PATH

COPY  configs/* ${HADOOP_CONF_DIR}/
COPY  configs/spark-defaults.conf ${SPARK_CONF_DIR}/
ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

RUN addgroup --gid 1000 hadoop \
    && adduser --gid 1000 --uid 1000 --disabled-password -q hadoop \
    && usermod -aG sudo hadoop \
    && echo 'hadoop:hadoop' | chpasswd


ENTRYPOINT ["/entrypoint.sh"]
