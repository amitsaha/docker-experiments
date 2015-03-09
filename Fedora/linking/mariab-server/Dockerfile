FROM fedora:21
RUN yum -y install mariadb-server mariadb psmisc
ADD start.sh /start.sh
EXPOSE 3306
CMD /start.sh