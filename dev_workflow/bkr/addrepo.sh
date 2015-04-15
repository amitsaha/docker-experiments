#!/bin/bash

pushd /etc/yum.repos.d/
cat >/etc/yum.repos.d/beaker-client-testing.repo <<"EOF"
[beaker-client-testing]
name=Beaker Client -Fedora$releasever - Testing
baseurl=http://beaker-project.org/nightlies/develop/Fedora$releasever/
enabled=1
gpgcheck=0

EOF

popd
