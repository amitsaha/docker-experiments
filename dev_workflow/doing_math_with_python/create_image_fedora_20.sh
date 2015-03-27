#!/bin/bash
uid=`id -u`
user=`id -un`

cat <<EOF > Dockerfile

FROM fedora:20
RUN yum -y install python3-pip gcc gcc-c++ @base-x openssh-server python3-matplotlib python3-matplotlib-tk python3-matplotlib-qt4 python3-scipy python3-numpy python3-mock python3-nose python3-ipython
RUN yum -y install emacs-nox python3-tools
RUN pip-python3 install matplotlib-venn==0.11 sympy==0.7.6

# password: password
RUN useradd -u $uid $user -d /home/$user -p aajfMKNH1hTm2
USER $user
WORKDIR /home/$user
CMD bash
EOF

docker build -t amitsaha/fedora20_dmwp .
rm Dockerfile
