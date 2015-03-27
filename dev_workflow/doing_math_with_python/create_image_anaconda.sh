#!/bin/bash
uid=`id -u`
user=`id -un`

cat <<EOF > Dockerfile

FROM fedora
RUN yum -y install tar bzip2 wget

# password: password
RUN useradd --groups wheel -u $uid -p aajfMKNH1hTm2 $user
USER $user
RUN cd /tmp; wget http://repo.continuum.io/anaconda3/Anaconda3-2.1.0-Linux-x86_64.sh; bash Anaconda3-2.1.0-Linux-x86_64.sh -b
ENV PATH /home/$user/anaconda3/bin:$PATH 
WORKDIR /home/$user
EOF

docker build -t amitsaha/python3_anaconda .
