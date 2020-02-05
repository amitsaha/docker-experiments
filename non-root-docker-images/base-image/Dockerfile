FROM centos:8
RUN yum -y update && \
    yum -y install gcc make curl python3
ENV APPLICATION_USER app
ENV APPLICATION_GROUP app

RUN groupadd -g 10000 app && \
    useradd -u 10000 -g app -d /home/app -m -s /sbin/nologin app


