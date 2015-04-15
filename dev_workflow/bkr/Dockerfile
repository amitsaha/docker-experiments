FROM fedora:21
ADD addrepo.sh /addrepo.sh
RUN /addrepo.sh
RUN yum -y install beaker-client
ADD bkr /bkr
ENTRYPOINT ["/bkr"]