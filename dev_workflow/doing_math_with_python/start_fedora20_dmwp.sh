#!/bin/bash
user=`id -un`
docker run -v /home/$user:/home/$user -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -ti amitsaha/fedora20_dmwp bash
