#!/bin/bash
# ./restraint.sh <image_name> <docker_base_image>
uid=`id -u`
user=`id -un`

cat <<EOF > Dockerfile

FROM $2

RUN yum -y install make glib2 glib2-devel glibc-devel libarchive-devel libsoup-devel gcc pkgconfig gettext libselinux-devel openssl-devel perl-XML-Parser selinux-policy-devel zlib-devel git git-daemon tar thttpd
RUN yum -y install emacs-nox
RUN useradd -u $uid $user
USER $uid

EOF

docker build -t $1 .
mv Dockerfile Dockerfile.$1
echo "$1 created. Entering: /home/$user"
docker run -v /home/$user:/home/$user -ti $1 bash
