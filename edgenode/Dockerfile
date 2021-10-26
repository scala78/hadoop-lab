ARG VERSION=latest
FROM scala78/hadoop-base:${VERSION}

LABEL org.opencontainers.image.authors="Dmitrii V<dsv@scala78.ru>" 

ENV HOME_DIR /home
RUN mkdir -p ${HOME_DIR}
VOLUME ${HOME_DIR}

ADD configs/.bashrc .profile

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 22

CMD ["/run.sh"]
