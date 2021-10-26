ARG VERSION=latest
FROM scala78/hadoop-base:${VERSION}
LABEL org.opencontainers.image.authors="Dmitrii V<dsv@scala78.ru>" 


HEALTHCHECK CMD curl -f http://localhost:8998/ || exit 1

RUN curl -O https://downloads.apache.org/maven/KEYS \ 
    && gpg --import KEYS

ENV MVN_URL https://dlcdn.apache.org/maven/maven-3/3.8.3/binaries/apache-maven-3.8.3-bin.zip

RUN set -x \
    && curl -fSL "$MVN_URL" -o /tmp/mvn.zip \
    && curl -fSL "$MVN_URL.asc" -o /tmp/mvn.zip.asc \
    && gpg --verify /tmp/mvn.zip.asc \
    && unzip /tmp/mvn.zip -d /opt/ \
    && rm /tmp/mvn.zip*
ENV PATH /opt/apache-maven-3.8.3/bin:${PATH}

ENV LIVY_HOME /opt/livy
ENV LIVY_CONF_DIR ${LIVY_HOME}/conf
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      python3-cloudpickle \
      python3-requests \
      python3-requests-kerberos \
      python3-flake8 \
      python3-flaky \
      python3-pytest \
      python3-pytest-runner\
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && git clone https://github.com/apache/incubator-livy.git \
    && cd incubator-livy \
    && mvn clean package -B -V -e \
        -Pspark-3.0 \
        -Pthriftserver \
        -DskipTests \
        -DskipITs \
        -Dmaven.javadoc.skip=true \
    && unzip /tmp/incubator-livy/assembly/target/apache-livy-*-bin.zip -d /opt \
    && ln -s /opt/apache-livy-*-bin ${LIVY_HOME} \
    && rm -r /tmp/incubator-livy \
    && rm -rf ~/.m2/repository

# ENV LIVY_VERSION 0.7.1
# ENV LIVY_URL https://downloads.apache.org/incubator/livy/${LIVY_VERSION}-incubating/apache-livy-${LIVY_VERSION}-incubating-bin.zip
# ENV LIVY_HOME /opt/livy
# ENV LIVY_CONF_DIR ${LIVY_HOME}/conf
# RUN set -x \
#     && curl -fSL "$LIVY_URL" -o /tmp/livy.zip \
#     && curl -fSL "$LIVY_URL.asc" -o /tmp/livy.zip.asc \
#     && gpg --verify /tmp/livy.zip.asc \
#     && unzip /tmp/livy.zip -d /opt/ \
#     && rm /tmp/livy.zip* \ 
#     && ln -s /opt/apache-livy-${LIVY_VERSION}-incubating-bin ${LIVY_HOME}


RUN mkdir ${LIVY_HOME}/logs

COPY  configs/* ${LIVY_CONF_DIR}/

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8998

CMD ["/run.sh"]
