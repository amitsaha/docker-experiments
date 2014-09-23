FROM fedora:20	
MAINTAINER Amit Saha <amitsaha.in@gmail.com>

RUN curl -o /etc/yum.repos.d/restraint.repo https://bpeck.fedorapeople.org/restraint/fc20.repo
RUN yum -y update; yum clean all
RUN yum -y install openssh-server restraint


# password: password
RUN useradd --groups wheel -m -d /home/test -p aajfMKNH1hTm2 test

# Most likely best reference: https://bugzilla.redhat.com/show_bug.cgi?id=966807
RUN /usr/bin/sed -e '/session    required     pam_loginuid.so/ s/^#*/#/' -i /etc/pam.d/sshd
RUN /usr/sbin/sshd-keygen
EXPOSE 8081
ENTRYPOINT ["/usr/bin/restraintd"]
