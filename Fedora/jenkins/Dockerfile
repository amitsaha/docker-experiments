FROM fedora:21
RUN yum clean all
RUN yum -y install jenkins
EXPOSE 8080
CMD ["/usr/libexec/jenkins/jenkins","start"]
