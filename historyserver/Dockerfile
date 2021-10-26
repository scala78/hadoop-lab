ARG VERSION=latest
FROM scala78/hadoop-base:${VERSION}

LABEL org.opencontainers.image.authors="Dmitrii V<dsv@scala78.ru>" 

HEALTHCHECK CMD curl -f http://localhost:8188/ || exit 1

ENV timeline_store_path=/hadoop/yarn/timeline
RUN mkdir -p ${timeline_store_path}
VOLUME ${timeline_store_path}

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8188

CMD ["/run.sh"]
