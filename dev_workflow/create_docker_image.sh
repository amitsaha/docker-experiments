#!/bin/bash
# ./create_docker_image.sh <image_name> <docker image>
uid=`id -u`
user=`id -un`

cat <<EOF > Dockerfile

FROM $2

RUN useradd -u $uid $user
USER $uid

EOF

docker build -t $1 .
mv Dockerfile Dockerfile.$1
echo "$1 created"
