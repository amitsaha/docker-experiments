Container running Apache via systemd
====================================

Build the image::

    $ docker build -t systemd-apache .

Run the container::

    $ docker run --privileged -P -d -t systemd-httpd

    $ docker ps
    CONTAINER ID        IMAGE                  COMMAND             CREATED             STATUS              PORTS                   NAMES
    bdf25e56898c        systemd-httpd:latest   "/usr/sbin/init"    5 seconds ago       Up 3 seconds        0.0.0.0:49155->80/tcp   pensive_ptolemy

Send a request::

   $ curl 127.0.0.1:49155

Get inside the container and check on systemd/journal, etc::

   $ docker inspect --format {{.State.Pid}} pensive_ptolemy
   30652
   $ sudo nsenter --target 30652 --mount --uts --ipc --net --pid
   [sudo] password for asaha: 
   [root@bdf25e56898c /]# journalctl -u httpd
   -- Logs begin at Thu 2014-10-23 06:02:44 UTC, end at Thu 2014-10-23 06:02:59 UTC. --
   Oct 23 06:02:45 bdf25e56898c httpd[32]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.8. Set the 'ServerName' directive globa   lly to
   Oct 23 06:02:45 bdf25e56898c systemd[1]: Started The Apache HTTP Server.
   [root@bdf25e56898c /]# systemctl status httpd
   httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled)
   Active: active (running) since Thu 2014-10-23 06:02:45 UTC; 7min ago
   Main PID: 32 (httpd)
   Status: "Total requests: 1; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /system.slice/docker-bdf25e56898ce15b9f56e442ab8c03a5d6e3537a24fdef3a06bd4e87410f9c7f.scope/system.slice/httpd.service
           ├─32 /usr/sbin/httpd -DFOREGROUND
           ├─61 /usr/sbin/httpd -DFOREGROUND
           ├─62 /usr/sbin/httpd -DFOREGROUND
           ├─64 /usr/sbin/httpd -DFOREGROUND
           ├─65 /usr/sbin/httpd -DFOREGROUND
           └─66 /usr/sbin/httpd -DFOREGROUND

	   Oct 23 06:02:45 bdf25e56898c httpd[32]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.8. Set the 'ServerName' direct...this message
	   Oct 23 06:02:45 bdf25e56898c systemd[1]: Started The Apache HTTP Server.
	   Hint: Some lines were ellipsized, use -l to show in full.

