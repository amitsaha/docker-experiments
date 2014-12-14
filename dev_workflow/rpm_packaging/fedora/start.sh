#!/bin/bash
# ./create_docker_image.sh <image_name> <docker image>
uid=`id -u`
user=`id -un`
group=`id -ug`

cat <<EOF > fix_perms_bash.sh
chown $user:$group /home/$user/rpmbuild
/bin/bash
EOF

cat <<EOF > Dockerfile

FROM fedora:21

RUN useradd -u $uid $user
VOLUME /home/$user/rpmbuild
RUN chown -R $user:$user /home/$user/rpmbuild
CMD true
EOF

docker build -t fedora_packaging_data .
echo "fedora_packaging_data created"
docker run --name fedora_packaging_data fedora_packaging_data

cat <<EOF > Dockerfile

FROM fedora:21

RUN yum -y install pyp2rpm emacs-nox fedora-packager

RUN useradd -u $uid $user

VOLUME /home/$user/rpmbuild

# do this later: http://fedoraproject.org/wiki/Using_the_Koji_build_system#Fedora_Account_System_.28FAS2.29_Setup
ADD fix_perms_bash.sh /tmp/fix_perms_bash.sh
CMD /tmp/fix_perms_bash.sh
WORKDIR /home/$user
EOF

docker build -t fedora_packaging .
echo "fedora_packaging created. starting docker container."
docker run --volumes-from fedora_packaging_data -ti fedora_packaging
