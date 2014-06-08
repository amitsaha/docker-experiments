Docker container for Python scientific/education libraries/tools
----------------------------------------------------------------

Included software
=================

(Python 2 and Python 3)

- scipy
- numpy
- matplotlib
- SymPy
- IPython
- IDLE

Building and Running the container
==================================

Build the container using::

    $ docker build -t fedora-python-edu .

Run the container::

    $ docker run -P -d -t python-fedora-edu

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

Start using::

    [test@af9f37b1b790 ~]$ python3
    Python 3.3.2 (default, Mar  5 2014, 08:21:05) 
    [GCC 4.8.2 20131212 (Red Hat 4.8.2-7)] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import matplotlib.pyplot as plt
    >>> plt.plot([1, 2, 4])
    [<matplotlib.lines.Line2D object at 0x7f3400979750>]
    >>> plt.show()
    # Graph should appear

Next plans
==========

- May be start the IPython notebook instead of SSH server? 
  (Choose Python 2 or Python 3 at runtime)
