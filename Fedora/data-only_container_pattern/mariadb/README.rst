Build the data container
========================

First, build the container and run it once::

    $ cd data_container
    $ docker build -t mariadb-data-container .
    $ docker run --name mariadb-data-container -t mariadb-data-container

This should run the container and exit. Let's inspect the volumes::

    $ docker inspect --format='{{json .Volumes}}' mariadb-data-container | python -mjson.tool
    {
	 "/var/lib/mysql": "/var/lib/docker/vfs/dir/53f522f2034acbef8bc14ea36e8c56685891e8416c010a2d3fe8dbb64c5815a3",
 	 "/var/log/mariadb": "/var/lib/docker/vfs/dir/69d6aa634654e8bed5bd60f8fe8a65512e7c5c2a83d3f3dda9b98eeedf24825b"
    }

The job of the data container is done now.

Build the consumer container
============================

Let's build the mariadb server container::

    $ docker build -t mariadb-server .  

Start the MariaDB server container
==================================

We will now start the mariadb server container using the ``--volumes-from`` option
to specify that we want to use the volumes from the ``mariadb-data-container`` we 
built above::

   $ docker run -P -d --volumes-from mariadb-data-container -t mariadb-server 
   ..
   $ docker ps
   CONTAINER ID        IMAGE                   COMMAND               CREATED             STATUS              PORTS                     NAMES
   f81263946b3e        mariadb-server:latest   "/start_mariadb.sh"   17 seconds ago      Up 2 seconds        0.0.0.0:49162->3306/tcp   compassionate_heisenberg

   $ docker inspect --format='{{json .Volumes}}' f81263946b3e | python -mjson.tool
     {
       "/var/lib/mysql": "/var/lib/docker/vfs/dir/53f522f2034acbef8bc14ea36e8c56685891e8416c010a2d3fe8dbb64c5815a3",
       "/var/log/mariadb": "/var/lib/docker/vfs/dir/69d6aa634654e8bed5bd60f8fe8a65512e7c5c2a83d3f3dda9b98eeedf24825b"
     }


Connect to the mariadb server and create a database::

    $ mysql -h 127.0.0.1 -P 49162 -u root
    Welcome to the MariaDB monitor.  Commands end with ; or \g.
    Your MariaDB connection id is 1
    Server version: 5.5.39-MariaDB MariaDB Server

    Copyright (c) 2000, 2014, Oracle, Monty Program Ab and others.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    MariaDB [(none)]> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | mysql              |
    | performance_schema |
    | test               |
    +--------------------+
    4 rows in set (0.00 sec)

    MariaDB [(none)]> create database mydb;
    Query OK, 1 row affected (0.00 sec)
  
Create another connection and another database::

    $ mysql -h 127.0.0.1 -P 49162 -u root
    Welcome to the MariaDB monitor.  Commands end with ; or \g.
    Your MariaDB connection id is 2
    Server version: 5.5.39-MariaDB MariaDB Server

    Copyright (c) 2000, 2014, Oracle, Monty Program Ab and others.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    MariaDB [(none)]> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | mydb               |
    | mysql              |
    | performance_schema |
    | test               |
    +--------------------+
    5 rows in set (0.00 sec)

    MariaDB [(none)]> create database mydb1;
    Query OK, 1 row affected (0.01 sec)

    MariaDB [(none)]> 


Now that we have created a couple of databases, let's stop the container and
restart it::

    $ docker run -P -d --volumes-from mariadb-data-container --name mariadb-server -t mariadb-server 
    ac188d18854a587d383e29017228f5ded22fcb5bc8f32fe4dc10d2352e50cc69
    $ docker ps
    CONTAINER ID        IMAGE                   COMMAND               CREATED             STATUS              PORTS                     NAMES
    ac188d18854a        mariadb-server:latest   "/start_mariadb.sh"   7 seconds ago       Up 2 seconds        0.0.0.0:49163->3306/tcp   mariadb-server      
    $ mysql -h 127.0.0.1 -P 49163 -u root
    Welcome to the MariaDB monitor.  Commands end with ; or \g.
    Your MariaDB connection id is 1
    Server version: 5.5.39-MariaDB MariaDB Server

    Copyright (c) 2000, 2014, Oracle, Monty Program Ab and others.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    MariaDB [(none)]> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema |
    | mydb               |
    | mydb1              |
    | mysql              |
    | performance_schema |
    | test               |
    +--------------------+
    6 rows in set (0.00 sec)

The databases have persisted which was the whole point.