Quickly test a sympy branch
===========================

You have docker setup and want to run the sympy tests in Fedora::
  docker build -t sympy-test .

Start the container passing the sympy branch as the "argument"::
  docker run -t sympy-test 0.7.6


