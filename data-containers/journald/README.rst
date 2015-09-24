Build the data container
========================

First, build the container and run it once::

    $ cd data_container
    $ docker build -t journald-data-container .
    $ docker run --name journald-data-container -t journald-data-container

This should run the container and exit. Let's inspect the volumes::

    $ docker inspect --format='{{json .Volumes}}' journald-data-container | python -mjson.tool
    {
          "/var/log/journal": "/var/lib/docker/vfs/dir/f5fda25c37aa6f2e3f440b790b26e4aeddd2555be74ffb28f22650b4c0fa39b7"
    }

The job of the data container is done now.

Build the consumer container
============================

Let's build the httpd server container::

    $ docker build -t systemd-httpd .

Start the httpd server container
==================================

We will now start the httpd server container using the ``--volumes-from`` option
to specify that we want to use the volumes from the ``journald-data-container`` we 
built above::

   $ docker run --priveleged -P -d --volumes-from journald-data-container -t systemd-httpd

   $ docker ps
   CONTAINER ID        IMAGE                  COMMAND             CREATED             STATUS              PORTS                   NAMES
   8d9a797c9c4b        systemd-httpd:latest   "/usr/sbin/init"    5 seconds ago       Up 3 seconds        0.0.0.0:49164->80/tcp   hopeful_meitner 

   $ docker inspect --format='{{json .Volumes}}'  goofy_hoover | python -mjson.tool

   {
        "/sys/fs/cgroup": "/var/lib/docker/vfs/dir/2ae181e62ea6260659b40d440b45daeb80ad28f2388bf7806e03cf8404a85db0",
        "/var/log/journal": "/var/lib/docker/vfs/dir/f5fda25c37aa6f2e3f440b790b26e4aeddd2555be74ffb28f22650b4c0fa39b7"
   }

We will now enter the container using ``nsenter`` and view the journal entries for httpd::

  $ docker inspect --format {{.State.Pid}} goofy_hoover
  13072
  $ sudo nsenter --target 13072 --mount --uts --ipc --net --pid

   # journalctl 
   ..
   -- Logs begin at Sat 2014-10-25 11:24:08 UTC, end at Sat 2014-10-25 11:24:22 UTC. --
   Oct 25 11:24:08 b9f04ea10553 systemd[1]: Starting The Apache HTTP Server...
   Oct 25 11:24:12 b9f04ea10553 httpd[54]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.29. Set the 'Ser
   Oct 25 11:24:12 b9f04ea10553 systemd[1]: Started The Apache HTTP Server.

Let's exit the container now and restart::

  $ docker stop goofy_hoover 
  goofy_hoover
  $ docker run --privileged -P -d --volumes-from journald-data-container -t systemd-httpd 
  4b669e2768754a95f3990f55f129720d86155b69d9d8ed5340de6ec138d6869f
  $ docker ps
  CONTAINER ID        IMAGE                  COMMAND             CREATED             STATUS              PORTS                   NAMES
  4b669e276875        systemd-httpd:latest   "/usr/sbin/init"    5 seconds ago       Up 2 seconds        0.0.0.0:49166->80/tcp   elegant_yonath      
  $ docker inspect --format {{.State.Pid}} elegant_yonath
  13477
  $ sudo nsenter --target 13477 --mount --uts --ipc --net --pid
  [root@4b669e276875 /]# journalctl -u httpd


  # journalctl -u httpd
  -- Logs begin at Sat 2014-10-25 11:24:08 UTC, end at Sat 2014-10-25 11:27:36 UTC. --
  Oct 25 11:24:08 b9f04ea10553 systemd[1]: Starting The Apache HTTP Server...
  Oct 25 11:24:12 b9f04ea10553 httpd[54]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.29. Set the 'Ser
  Oct 25 11:24:12 b9f04ea10553 systemd[1]: Started The Apache HTTP Server.
  Oct 25 11:27:23 4b669e276875 httpd[32]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.30. Set the 'Ser
  Oct 25 11:27:23 4b669e276875 systemd[1]: Started The Apache HTTP Server.

The journal entries have persisted.
