#!/bin/bash

set -e
base_image="beakerproject/beaker-development-centos-6"

cat <<EOF > Dockerfile
FROM centos:centos6.6
RUN yum -y install wget
RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN rpm -Uvh epel-release-6*.rpm
RUN yum -y install yum-utils createrepo createrepo_c git python-unittest2 mysql-server mysql openldap-servers python-pip
RUN pip install --upgrade selenium
ADD install_deps.sh /root/install_deps.sh
RUN /root/install_deps.sh
EOF

docker build -t $base_image .
echo "$base_image built"
rm Dockerfile
