FROM registry.hub.docker.com/fedora:22
MAINTAINER amitsaha.in@gmail.com
RUN dnf -y install mariadb-server psmisc

ADD ./start_mariadb.sh /start_mariadb.sh
RUN chmod 755 /start_mariadb.sh

EXPOSE 3306
ENTRYPOINT ["/start_mariadb.sh"]