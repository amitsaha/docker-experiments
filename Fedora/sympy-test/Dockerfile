FROM fedora:latest
RUN yum -y install git
ADD ./run-tests.sh /tmp/run-tests.sh
ENTRYPOINT ["/tmp/run-tests.sh"]