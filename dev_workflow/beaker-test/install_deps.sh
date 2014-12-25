#!/bin/bash

# add the beaker-server-testing repo
pushd /etc/yum.repos.d/
cat >/etc/yum.repos.d/beaker-server-testing.repo <<"EOF"
[beaker-server-testing]
name=Beaker Server -Fedora$releasever - Testing
baseurl=http://beaker-project.org/nightlies/develop/Fedora$releasever/
enabled=1
gpgcheck=0

EOF

popd

# Find the dependencies
yum deplist beaker-server beaker-lab-controller beaker-integration-tests beaker-client beaker | grep 'provider' | grep -v 'beaker*' | awk '{print $2'} | sort -u > beaker_deplist

# Install them
while read line
do
    yum -y install `yum info $line | grep 'Name' | awk '{print $3}'`
done <beaker_deplist
