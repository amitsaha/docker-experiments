#!/bin/bash

set -e
base_image="beakerproject/beaker-development-centos-7"

cat <<EOF > Dockerfile
FROM centos:centos7
RUN yum -y install wget
RUN wget https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum -y install epel-release-7-5.noarch.rpm
RUN yum -y install yum-utils createrepo createrepo_c git python-unittest2 mariadb-server mariadb openldap-servers python-pip
RUN pip install --upgrade selenium
ADD install_deps.sh /root/install_deps.sh
RUN /root/install_deps.sh
EOF

docker build -t $base_image .
echo "$base_image built"
rm Dockerfile
