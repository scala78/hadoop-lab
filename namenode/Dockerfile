FROM scala78/hadoop-base:master


HEALTHCHECK CMD curl -f http://localhost:9870/ || exit 1

ENV dfs_namenode_name_dir=/hadoop/dfs/name
RUN mkdir -p ${dfs_namenode_name_dir}
VOLUME ${dfs_namenode_name_dir}

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 9870

CMD ["/run.sh"]
