FROM fedora:20	
MAINTAINER Amit Saha <amitsaha.in@gmail.com>

RUN yum -y update; yum clean all
RUN yum -y install @base-x openssh-server

# password: password
RUN useradd --groups wheel -m -d /home/test -p aajfMKNH1hTm2 test

# Most likely best reference: https://bugzilla.redhat.com/show_bug.cgi?id=966807
RUN /usr/bin/sed -e '/session    required     pam_loginuid.so/ s/^#*/#/' -i /etc/pam.d/sshd
EXPOSE 22
RUN /usr/sbin/sshd-keygen
ENTRYPOINT ["/usr/sbin/sshd", "-D"]