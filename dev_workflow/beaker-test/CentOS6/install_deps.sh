#!/bin/bash

# add the beaker-server-testing repo
pushd /etc/yum.repos.d/
cat >/etc/yum.repos.d/beaker-server-testing.repo <<"EOF"
[beaker-server]
name=Beaker Server - CentOS6
baseurl=https://beaker-project.org/nightlies/develop/RedHatEnterpriseLinux6/
enabled=1
gpgcheck=0

EOF

cat >/etc/yum.repos.d/others.repo <<"EOF"
[beaker-server-others]
name=Beaker Server - others - CentOS6
baseurl=https://beaker-project.org/yum/server-testing/CentOS6/
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

