Docker container with base X packages and SSH server installed
--------------------------------------------------------------

Building and Running the container
==================================

Build the container using::

    $ docker build -t fedora-ssh-x .

Run the container::

    $ docker run -P -d -t fedora

Find the mapped port on the host::

    $ docker port af9f37b1b790 22
    0.0.0.0:49153

(where `af9f37b1b790` is the container ID)

Logging into the container
==========================

Find the IP of the `docker0` interface and ssh to it passing the above
mapped port::

    $ ssh -X test@172.17.42.1 -p 49153
    test@172.17.42.1's password:  # password

Start using!
