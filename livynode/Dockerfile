FROM scala78/hadoop-base:master


HEALTHCHECK CMD curl -f http://localhost:8998/ || exit 1

RUN curl -O https://downloads.apache.org/incubator/livy/KEYS \ 
&& gpg --import KEYS

ENV LIVY_VERSION 0.7.1
ENV LIVY_URL https://downloads.apache.org/incubator/livy/${LIVY_VERSION}-incubating/apache-livy-${LIVY_VERSION}-incubating-bin.zip
ENV LIVY_HOME /opt/livy
ENV LIVY_CONF_DIR ${LIVY_HOME}/conf
RUN set -x \
    && curl -fSL "$LIVY_URL" -o /tmp/livy.zip \
    && curl -fSL "$LIVY_URL.asc" -o /tmp/livy.zip.asc \
    && gpg --verify /tmp/livy.zip.asc \
    && unzip /tmp/livy.zip -d /opt/ \
    && rm /tmp/livy.zip* \ 
    && ln -s /opt/apache-livy-${LIVY_VERSION}-incubating-bin ${LIVY_HOME}


RUN mkdir ${LIVY_HOME}/logs

COPY  configs/* ${LIVY_CONF_DIR}/

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8998

CMD ["/run.sh"]
