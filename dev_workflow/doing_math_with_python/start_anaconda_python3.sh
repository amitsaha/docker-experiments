#!/bin/bash
user=`id -un`
docker run -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -ti amitsaha/python3_anaconda bash
