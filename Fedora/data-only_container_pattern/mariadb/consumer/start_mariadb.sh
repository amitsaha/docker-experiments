#!/bin/bash

if [[ -d /var/lib/mysql/mysql ]]; then 
    echo "MariaDB already configured"
else
    mysql_install_db --datadir=/var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql/
    /usr/bin/mysqld_safe &
    # Are we up yet?
    mysqladmin --silent --wait=30 ping || exit 1
    # Grant rights for root user from everywhere
    echo "GRANT ALL ON *.* TO root@'%'" | mysql
    killall mysqld; sleep 10
fi

/usr/bin/mysqld_safe
