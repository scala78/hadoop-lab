FROM scala78/hadoop-base:master

LABEL org.opencontainers.image.authors="Dmitrii V<dsv@scala78.ru>" 

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8042

CMD ["/run.sh"]
