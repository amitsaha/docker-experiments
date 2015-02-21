FROM amitsaha/f21systemd

RUN yum -y install jenkins
RUN yum -y install initscripts #because jenkins needs /etc/init.d/functions
RUN systemctl enable jenkins
EXPOSE 8080
CMD ["/usr/sbin/init"]