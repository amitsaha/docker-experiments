#!/bin/bash

set -e

base_image="beakerproject/beaker-development-fedora-21"

cat <<EOF > Dockerfile
FROM fedora:21
RUN yum -y install wget yum-utils createrepo createrepo_c git python-unittest2 mariadb-server mariadb openldap-servers python-pip
RUN pip install --upgrade selenium
ADD install_deps.sh /root/install_deps.sh
RUN /root/install_deps.sh
EOF

docker build -t $base_image .
echo "$base_image built"
rm Dockerfile
