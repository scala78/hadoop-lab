FROM scala78/hadoop-base:master

LABEL org.opencontainers.image.authors="Dmitrii V<dsv@scala78.ru>" 

ENV home_dir=/home
RUN mkdir -p ${home_dir}
VOLUME ${home_dir}

RUN mkdir -p /home/hadoop \
    && chown -R hadoop:hadoop /home/hadoop

ADD configs/.bashrc .profile

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 22

CMD ["/run.sh"]
