#!/bin/bash

mysql_install_db
chown -R mysql:mysql /var/lib/mysql

cp /etc/my.cnf /etc/my.cnf-orig
cat /etc/my.cnf-orig | awk '
        {print $0};
        /\[mysqld\]/ {
            print "character-set-server=utf8";
        }' > /etc/my.cnf


/usr/bin/mysqld_safe & 
sleep 10

# setup Beaker DB
echo "CREATE DATABASE beaker;" | mysql
echo "GRANT ALL ON beaker.* TO 'beaker'@'localhost' IDENTIFIED BY 'beaker';" | mysql


admin="admin"
password="admin"
su -s /bin/sh apache -c "beaker-init -u \"$admin\" -p \"$password\" -e \"$email\""
killall mysqld
sleep 10
