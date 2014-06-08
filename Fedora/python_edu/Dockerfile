FROM fedora:20	
MAINTAINER Amit Saha <amitsaha.in@gmail.com>

RUN yum -y update; yum clean all
RUN yum -y install @base-x openssh-server

# password: password
RUN useradd --groups wheel -m -d /home/test -p aajfMKNH1hTm2 test

# python 2
RUN yum -y install python python-tools python-matplotlib python-matplotlib-qt4 python-matplotlib-tk python-sympy scipy 
RUN yum -y install python-ipython python-ipython-notebook

# python 3
RUN yum -y install python3 python3-tools python3-matplotlib python3-matplotlib-qt4 python3-matplotlib-tk python3-sympy python3-scipy
RUN yum -y install python3-ipython python3-ipython-notebook

# Most likely best reference: https://bugzilla.redhat.com/show_bug.cgi?id=966807
RUN /usr/bin/sed -e '/session    required     pam_loginuid.so/ s/^#*/#/' -i /etc/pam.d/sshd

EXPOSE 22
RUN /usr/sbin/sshd-keygen
ENTRYPOINT ["/usr/sbin/sshd", "-D"]