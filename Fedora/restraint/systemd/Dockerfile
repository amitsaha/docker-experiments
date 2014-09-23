# Runs restraint under systemd
# Based off: http://developerblog.redhat.com/2014/05/05/running-systemd-within-docker-container/

FROM registry.hub.docker.com/fedora:20
MAINTAINER Beaker Developers <beaker-devel@lists.fedoraproject.org>
RUN curl -o /etc/yum.repos.d/restraint.repo https://bpeck.fedorapeople.org/restraint/fc20.repo
RUN yum -y install systemd; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ "\$i" == systemd-tmpfiles-setup.service ] || rm -f "\$i"; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
# Install the harness
RUN yum -y install restraint restraint-rhts
EXPOSE 8081
CMD ["/usr/sbin/init"]
