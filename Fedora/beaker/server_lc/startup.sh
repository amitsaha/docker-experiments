#!/bin/bash

if [[ -d /var/lib/mysql/beaker ]]; then 
    echo "Beaker database already configured"
else
    mysql_install_db --datadir=/var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql/
    cp /etc/my.cnf /etc/my.cnf-orig
    cat /etc/my.cnf-orig | awk '
        {print $0};
        /\[mysqld\]/ {
            print "character-set-server=utf8";
        }' > /etc/my.cnf

    /usr/bin/mysqld_safe &
    # Are we up yet?
    mysqladmin --silent --wait=30 ping || exit 1
    # Grant rights for root user from everywhere
    echo "GRANT ALL ON *.* TO root@'%'" | mysql
    # setup Beaker DB
    echo "CREATE DATABASE beaker;" | mysql
    echo "GRANT ALL ON beaker.* TO 'beaker'@'localhost' IDENTIFIED BY 'beaker';" | mysql
    admin="admin"
    password="admin"
    email="root@localhost"
    su -s /bin/sh apache -c "beaker-init -u \"$admin\" -p \"$password\" -e \"$email\""
    killall mysqld; sleep 10
fi

# We need this owned by apache
chown -R apache:apache /var/www/
# systemd
exec /sbin/init

