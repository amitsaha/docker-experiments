#!/bin/bash
uid=`id -u`
user=`id -un`

cat <<EOF > Dockerfile

FROM fedora:$1
RUN yum -y install tar bzip2 wget  openssh-server @base-x

# Most likely best reference: https://bugzilla.redhat.com/show_bug.cgi?id=966807
RUN /usr/bin/sed -e '/session    required     pam_loginuid.so/ s/^#*/#/' -i /etc/pam.d/sshd
EXPOSE 22
RUN /usr/sbin/sshd-keygen
ENTRYPOINT ["/usr/sbin/sshd", "-D"]

# password: password
RUN useradd --groups wheel -u $uid -p aajfMKNH1hTm2 $user
USER $user
RUN cd /tmp; wget http://repo.continuum.io/anaconda3/Anaconda3-2.1.0-Linux-x86_64.sh; bash Anaconda3-2.1.0-Linux-x86_64.sh -b

EOF

docker build -t fedora$1_dmwp_anaconda .
