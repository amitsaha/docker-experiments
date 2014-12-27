FROM fedora:21
RUN yum -y install redis
VOLUME /var/lib/redis
EXPOSE 6379
CMD ["/usr/bin/redis-server", "/etc/redis.conf", "--daemonize", "no", "--bind", "0.0.0.0"]