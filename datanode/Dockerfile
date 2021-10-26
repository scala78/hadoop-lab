ARG VERSION=latest
FROM scala78/hadoop-base:${VERSION}

LABEL org.opencontainers.image.authors="Dmitrii V<dsv@scala78.ru>" 

HEALTHCHECK CMD curl -f http://localhost:9864/ || exit 1

ENV dfs_datanode_data_dir=/hadoop/dfs/data
RUN mkdir -p ${dfs_datanode_data_dir}
VOLUME ${dfs_datanode_data_dir}

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 9864

CMD ["/run.sh"]
