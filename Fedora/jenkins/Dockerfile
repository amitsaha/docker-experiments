FROM amitsaha/f21systemd

RUN yum -y install jenkins tito
RUN systemctl enable jenkins
EXPOSE 8080

CMD ["/usr/sbin/init"]