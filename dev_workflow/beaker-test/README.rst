Run Beaker's Integration Tests in a Docker container
====================================================

This may be relevant to you if you are working on (or are looking to
start working on) `beaker's
<https://beaker-project.org/dev/guide/writing-a-patch.html>`__ code.

Using it
--------

Build the base image based on Fedora 21 with all the dependencies::

    ./build_base_image.sh

Start a container using the above image specifying the local beaker
directory and (optionally) the tests we want to run::

    ./run_tests.sh /path/to/beaker bkr.inttest.client.test_job_logs

If the second argument is not specified, the entire test suite is run.

The tests should start running after mariadb server has been
configured and started. We do no use a persistent data volume for the
data because we want multiple container instances running simultaneously
without interfering with each other.

Once the tests have completed running, you will back to your host::
    ..
    ..
    141224 19:55:32 mysqld_safe Logging to '/var/log/mariadb/mariadb.log'.
    141224 19:55:32 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
    mysqld is alive
    + env BEAKER_CONFIG_FILE=server-test.cfg PYTHONPATH=../Common:../Server:../LabController/src:../Client/src:../IntegrationTests/src python -c '__requires__ = ["Cherry    Py < 3.0"]; import pkg_resources; from nose.core import main; main()' bkr.inttest.client.test_job_logs
  
    ----------------------------------------------------------------------
    Ran 9 tests in 251.235s

    OK

The local copy of your beaker is now in the docker image, you
can continue working on your host's working copy making other changes,
running other tests, etc.

Use cases
---------

- Work on the beaker code base, running different tests simultaneously
- (Future): Run tests on different distros
