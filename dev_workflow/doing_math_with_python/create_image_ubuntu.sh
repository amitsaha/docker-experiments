#!/bin/bash
uid=`id -u`
user=`id -un`

cat <<EOF > Dockerfile

FROM ubuntu:$1
RUN apt-get -y install python3-pip gcc g++ @base-x openssh-server python3-matplotlib python3-matplotlib-tk python3-sympy python3-scipy python3-numpy python3-mock python3-nose
RUN pip3 install matplotlib-venn

# password: password
RUN useradd --groups wheel -m -d /home/$user -p aajfMKNH1hTm2 $user

# Most likely best reference: https://bugzilla.redhat.com/show_bug.cgi?id=966807
#RUN /usr/bin/sed -e '/session    required     pam_loginuid.so/ s/^#*/#/' -i /etc/pam.d/sshd
EXPOSE 22
RUN /usr/sbin/sshd-keygen
EOF

docker build -t ubuntu$1_dmwp_base .

# Now build the image we will work with
cat <<EOF > Dockerfile

FROM fedora$1_dmwp_base

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
EOF

docker build -t fedora$1_dmwp .
