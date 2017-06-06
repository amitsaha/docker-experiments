FROM mysql:5.6
RUN apt-get update
# Add custom config
COPY custom.cnf /etc/mysql/conf.d/custom.cnf
RUN mysql_install_db --user=mysql
COPY setup.sql /var/tmp/setup.sql
RUN service mysql start && mysql -e 'source /var/tmp/setup.sql' && killall mysqld && rm /var/tmp/setup.sql

EXPOSE 3306
CMD ["mysqld", "--user=mysql"]
