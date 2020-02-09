FROM amitsaha/centos-8-nonroot

ENV PROM_RELEASE 2.15.2

WORKDIR /tmp
RUN curl --location -o prometheus-bin.tar.gz https://github.com/prometheus/prometheus/releases/download/v$PROM_RELEASE/prometheus-$PROM_RELEASE.linux-amd64.tar.gz && \
    tar -zxvf prometheus-bin.tar.gz  && \
    mkdir /usr/local/bin/prometheus && \
    cp -r /tmp/prometheus-$PROM_RELEASE.linux-amd64/* /usr/local/bin/prometheus/
ADD prometheus.yml /etc/prometheus.yml

ADD app.sh /app.sh
RUN chmod +x /app.sh
ADD startup.py /startup.py
RUN chmod +x /startup.py

VOLUME /data

USER $APPLICATION_USER
CMD ["/app.sh"]
