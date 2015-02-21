#!/bin/bash
uid=`id -u`
user=`id -un`

cat <<EOF > Dockerfile

FROM fedora:$1
RUN yum -y install python3-pip gcc gcc-c++ @base-x openssh-server python3-matplotlib python3-matplotlib-tk python3-sympy python3-scipy python3-numpy python3-mock python3-nose python3-ipython
RUN pip-python3 install matplotlib-venn

# password: password
RUN useradd --groups wheel -m -d /home/$user -p aajfMKNH1hTm2 $user

# Most likely best reference: https://bugzilla.redhat.com/show_bug.cgi?id=966807
RUN /usr/bin/sed -e '/session    required     pam_loginuid.so/ s/^#*/#/' -i /etc/pam.d/sshd
EXPOSE 22
RUN /usr/sbin/sshd-keygen
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
EOF

docker build -t fedora$1_dmwp .
rm Dockerfile
