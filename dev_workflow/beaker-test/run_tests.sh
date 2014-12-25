#!/bin/bash
# ./run-tests /path/to/beaker <test(s) to run>

set -e

uid=`id -u`
user=`id -un`

rm -rf beaker
cp -r $1 .

cat <<EOF > start.sh
#!/bin/bash
./setup_db.sh
cd IntegrationTests
./run-tests.sh $2

EOF
chmod +x start.sh

cat <<EOF > Dockerfile

FROM beaker-tests_f21
RUN useradd -u $uid $user
ADD beaker /home/$user/beaker
ADD start.sh /home/$user/beaker/start.sh
ADD setup_db.sh /home/$user/beaker/setup_db.sh
WORKDIR /home/$user/beaker/
EOF
imagename=beaker-tests-run-`date +%s`
docker build -t $imagename .
docker run -t $imagename ./start.sh

# cleanup
rm -rf beaker
rm Dockerfile
rm start.sh
