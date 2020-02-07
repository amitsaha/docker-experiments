FROM centos:8
RUN yum -y update && \
    yum -y install gcc make curl python3
ENV APPLICATION_USER app
ENV APPLICATION_GROUP app

# Thanks serghei for 44444
RUN groupadd -g 44444 app && \
    useradd -u 44444 -g app -d /home/app -m -s /sbin/nologin app


