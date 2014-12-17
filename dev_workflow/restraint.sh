#!/bin/bash
# ./restraint.sh <image_name> <docker_base_image>
set -e
uid=`id -u`
user=`id -un`

cat <<EOF > Dockerfile

FROM $2

RUN yum -y install make glib2 glib2-devel glibc-devel libarchive-devel libsoup-devel gcc pkgconfig gettext libselinux-devel openssl-devel perl-XML-Parser selinux-policy-devel zlib-devel git git-daemon tar thttpd
RUN yum -y install yum-utils gdb emacs-nox
RUN debuginfo-install -y bzip2-libs-1.0.6-14.fc21.x86_64 glib2-2.42.1-1.fc21.x86_64 libacl-2.2.52-7.fc21.x86_64 libarchive-3.1.2-10.fc21.x86_64 libattr-2.4.47-9.fc21.x86_64 libffi-3.1-6.fc21.x86_64 libselinux-2.3-5.fc21.x86_64 libsoup-2.48.1-1.fc21.x86_64 libxml2-2.9.1-6.fc21.x86_64 lzo-2.08-3.fc21.x86_64 openssl-libs-1.0.1j-1.fc21.x86_64 pcre-8.35-8.fc21.x86_64 sqlite-3.8.6-2.fc21.x86_64 xz-libs-5.1.2-14alpha.fc21.x86_64 zlib-1.2.8-7.fc21.x86_64 glibc-2.20-5.fc21.x86_64

RUN useradd -u $uid $user
USER $uid

EOF

docker build -t $1 .
mv Dockerfile Dockerfile.$1
echo "$1 created. Entering: /home/$user"
docker run -v /home/$user:/home/$user -ti $1 bash
