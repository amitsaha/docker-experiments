
/usr/sbin/httpd

# Now we can log in to Beaker using our admin credentials and do a few things.
# Normally these steps would be done using a web browser.
tmpdir=$(mktemp -d)
trap "popd; rm -rf $tmpdir; exit" INT TERM EXIT
pushd $tmpdir
curl -c tmpcookie -d user_name=$admin -d password=$password -d login=1 http://localhost/bkr/login || exit 1
# Add ourselves as a lab controller.
curl -b tmpcookie -d fqdn=beaker-server-lc.beaker -d lusername=host/localhost.localdomain -d lpassword= -d email=root@localhost.localdomain -d Save=1 http://localhost/bkr/labcontrollers/save || exit 1

cat <<EOF > `pwd`/lab-controller.conf
HUB_URL="http://localhost/bkr"
AUTH_NAME="password"
USERNAME="host/localhost.localdomain"
PASSWORD=""
TFTP_ROOT="/var/lib/tftpboot"

EOF

BEAKER_PROXY_CONFIG_FILE=`pwd`/lab-controller.conf /usr/bin/beaker-proxy -f; sleep 10

curl http://localhost:8000
beaker-import http://fedora.mirror.uber.com.au/fedora/linux//releases/20/Fedora/x86_64/os/
beaker-repo-update

# Fetch and upload some useful task RPMs.
# wget $rpms
# for task in *.rpm; do
#     curl -b tmpcookie --form task_rpm=@$task http://localhost/bkr/tasks/save || exit 1
# done
popd
rm -rf $tmpdir

killall httpd mysqld
sleep 10
