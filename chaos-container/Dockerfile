FROM debian:latest
RUN apt-get -y update && apt-get -y install strace iptables dsniff procps lsof
CMD ["strace", "-p", "1"]
