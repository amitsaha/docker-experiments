Setup the data volumes
======================

First let's build the data container::

    cd data_container
    docker build -t beaker-data-container .

Start the container once::

    docker run --name beaker-data-container -t beaker-data-container

Build the server/lc container
=============================
::
    cd server_lc
    docker build -t beaker-server-lc .

Start the container with the data volumes setup earlier
=======================================================

We will start a privileged container::

   docker run -P --privileged -d --volumes-from beaker-data-container-1 beaker-server-lc

.. more to come
