bkr client
==========

Fedora 21 Docker image with the beaker client, ``bkr`` installed which
will update the beaker client to the latest nightly on
startup. Potentially useful for trying out new ``bkr`` commands.
Example
=======

```
$ docker run -ti amitsaha/bkr job-list --hub=https://beaker.server.com --username asaha

....


--> Running transaction check
---> Package beaker-client.noarch 0:19.4-0.git.109.fc3396d.fc19 will be updated
---> Package beaker-client.noarch 0:19.4-0.git.112.ed6b232.fc19 will be an update
--> Processing Dependency: beaker-common = 19.4-0.git.112.ed6b232.fc19 for package: beaker-client-19.4-0.git.112.ed6b232.fc19.noarch
--> Running transaction check
---> Package beaker-common.noarch 0:19.4-0.git.109.fc3396d.fc19 will be updated
---> Package beaker-common.noarch 0:19.4-0.git.112.ed6b232.fc19 will be an update
--> Finished Dependency Resolution

Dependencies Resolved
..
..
Updated:
  beaker-client.noarch 0:19.4-0.git.112.ed6b232.fc19
Enter your password:

  ["J:7637", "J:7636"
..

```

Issues
======

- Only supports password based login