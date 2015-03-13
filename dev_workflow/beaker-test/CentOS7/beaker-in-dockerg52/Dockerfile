FROM beakerproject/beaker-development-centos-7
RUN useradd -u 1000 asaha
ADD beaker /home/asaha/beaker
ADD start.sh /home/asaha/beaker/start.sh
ADD setup_db.sh /home/asaha/beaker/setup_db.sh
WORKDIR /home/asaha/beaker/
