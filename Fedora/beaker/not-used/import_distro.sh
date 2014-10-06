#!/bin/bash

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/*; exec /usr/sbin/apachectl -D FOREGROUND &


# import a distro
# Now we can log in to Beaker using our admin credentials and do a few things.
# Normally these steps would be done using a web browser.
tmpdir=$(mktemp -d)
trap "popd; rm -rf $tmpdir; exit" INT TERM EXIT
pushd $tmpdir
curl -c tmpcookie -d user_name=$admin -d password=$password -d login=1 http://localhost/bkr/login || exit 1
# Add ourselves as a lab controller.
curl -b tmpcookie -d fqdn=$(hostname -f) -d lusername=host/localhost.localdomain -d lpassword=password -d email=root@localhost.localdomain -d Save=1 http://localhost/bkr/labcontrollers/save || exit 1

/usr/bin/beaker-proxy
beaker-import http://mirror.aarnet.edu.au/pub/fedora/linux//releases/20/Fedora/x86_64/os/
beaker-repo-update

killall httpd
killall beaker-proxy
sleep 10
