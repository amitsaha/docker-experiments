#!/bin/bash
# ./run-tests /path/to/beaker <test(s) to run>

set -e

base_image="beakerproject/beaker-development-fedora-21"

uid=`id -u`
user=`id -un`

workdir=`mktemp --dir beaker-in-dockerXXX`
pushd $workdir
cp -r $1 beaker

cat <<EOF > setup_db.sh
#!/bin/bash

if [[ -d /var/lib/mysql/beaker ]]; then 
    echo "Beaker database already configured"
else
    mysql_install_db --datadir=/var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql/
    cp /etc/my.cnf /etc/my.cnf-orig
    cat /etc/my.cnf-orig | awk '
        {print \$0};
        /\[mysqld\]/ {
            print "character-set-server=utf8";
        }' > /etc/my.cnf

    /usr/bin/mysqld_safe &
    # Are we up yet?
    mysqladmin --silent --wait=30 ping || exit 1
    # Grant rights for root user from everywhere
    echo "GRANT ALL ON *.* TO root@'%'" | mysql
    # setup Beaker DB
    echo "CREATE DATABASE beaker_test;" | mysql
    echo "GRANT ALL ON beaker_test.* TO 'beaker'@'localhost' IDENTIFIED BY 'beaker';" | mysql
    echo "CREATE DATABASE beaker_migration_test;" | mysql
    echo "GRANT ALL ON beaker_migration_test.* TO 'beaker'@'localhost' IDENTIFIED BY 'beaker';" | mysql
fi

EOF

cat <<EOF > start.sh
#!/bin/bash
./setup_db.sh
cd IntegrationTests
./run-tests.sh $2

EOF

chmod +x start.sh setup_db.sh

cat <<EOF > Dockerfile
FROM $base_image
RUN useradd -u $uid $user
ADD beaker /home/$user/beaker
ADD start.sh /home/$user/beaker/start.sh
ADD setup_db.sh /home/$user/beaker/setup_db.sh
WORKDIR /home/$user/beaker/
EOF
imagename=beaker-tests-run-`date +%s`
docker build -t $imagename .
docker run -t $imagename ./start.sh

# cleanup
popd
echo "$workdir can be cleaned up"
