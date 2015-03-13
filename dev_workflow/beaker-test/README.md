## Run Beaker's Integration Tests in a Docker container

This may be relevant to you if you are working on (or are looking to
start working on) **Beaker** (https://beaker-project.org/dev/guide/writing-a-patch.html).

## Using it

Docker images based off Fedora 21
(``beakerproject/beaker-development-fedora-21``), CentOS 6.6
(``beakerproject/beaker-development-centos-6``) and CentOS 7
((``beakerproject/beaker-development-centos-7``)) are available from the
docker hub account of the Beaker project
(https://hub.docker.com/u/beakerproject/).

To run the tests on Fedora 21:

```
cd Fedora21
./run_tests.sh /path/to/beaker bkr.inttest.client.test_job_logs
```

To run the tests on CentOS 6:
```
cd CentOS6
./run_tests.sh /path/to/beaker bkr.inttest.client.test_job_logs
```

To run the tests on CentOS 7:
```
cd CentOS7
./run_tests.sh /path/to/beaker bkr.inttest.client.test_job_logs
```

If the second argument is not specified, the entire test suite is run.

The tests should start running after mariadb server has been
configured and started. We do no use a persistent data volume for the
data because we want multiple container instances running simultaneously
without interfering with each other.

Once the tests have completed running, you will be back to your host:

```
..
..
141224 19:55:32 mysqld_safe Logging to '/var/log/mariadb/mariadb.log'.
141224 19:55:32 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
mysqld is alive
+ env BEAKER_CONFIG_FILE=server-test.cfg PYTHONPATH=../Common:../Server:../LabController/src:../Client/src:../IntegrationTests/src python -c '__requires__ = ["Cherry    Py < 3.0"]; import pkg_resources; from nose.core import main; main()' bkr.inttest.client.test_job_logs
  
----------------------------------------------------------------------
Ran 9 tests in 251.235s

OK
```

 
The local copy of your beaker is now in the docker image, you
can continue working on your host's working copy making other changes,
running other tests, etc.

## Use cases

- Work on the beaker code base, running different tests simultaneously
- Run tests on different distros

## Notes

The ``run_tests.sh`` creates a temporary sub-directory of the form
``beaker-in-dockerXX`` from the directory you invoked the
``run_tests.sh`` script from. It is not cleaned up after the test run is
complete. The container executing the tests (named as
``beaker-tests-run-xx``) are also not cleaned up.
