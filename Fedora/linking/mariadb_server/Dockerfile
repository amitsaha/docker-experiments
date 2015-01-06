FROM fedora:21
RUN yum -y install mariadb-server hostname psmisc
ADD start.sh /root/start.sh
EXPOSE 3306
CMD /root/start.sh