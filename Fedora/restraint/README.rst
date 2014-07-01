Restraint daemon in a docker container
--------------------------------------

Building and Running the container
==================================

Build the container using::

    $ docker build -t fedora-restraint

Run the container::

    $ docker run -P -d -t fedora-restraint

Find the mapped port on the host::

    $ docker port af9f37b1b790 8081
    0.0.0.0:49153

(where `af9f37b1b790` is the container ID)

Logging into the container
==========================

Use restraint client to execute tests::

    $ restraint --remote http://127.0.0.1:49153 --job /root/restraint-job.xml 

