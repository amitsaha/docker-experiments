# Runs beaker server + lab controller under systemd
# Using the instructions at http://developerblog.redhat.com/2014/05/05/running-systemd-within-docker-container/
# to run systemd

FROM registry.hub.docker.com/fedora:20
MAINTAINER Beaker Developers <beaker-devel@lists.fedoraproject.org>
RUN curl -o /etc/yum.repos.d/beaker-server-lc.repo https://beaker-project.org/yum/beaker-server-Fedora.repo
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

RUN yum -y install openssh-server beaker-server beaker-lab-controller mariadb-server MySQL-python tftp-server mod_ssl psmisc
RUN systemctl enable beakerd beaker-proxy beaker-provision beaker-watchdog httpd mariadb tftp.socket

ADD ./startup.sh /startup.sh

# password: password
RUN echo 'root:root' | chpasswd
# Most likely best reference: https://bugzilla.redhat.com/show_bug.cgi?id=966807
RUN /usr/bin/sed -e '/session    required     pam_loginuid.so/ s/^#*/#/' -i /etc/pam.d/sshd

# Expose ports for httpd, beaker-proxy, tftp
EXPOSE 80 8000 69 22
CMD ["/startup.sh"]
