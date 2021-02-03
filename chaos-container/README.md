Example of running this container:

(Credit to https://medium.com/@rothgar/how-to-debug-a-running-docker-container-from-a-separate-container-983f11740dc6)


Get a terminal session which is attached to the same PID and network namespace
as container, `container name`:

```
$ docker run -ti --pid=container:<container name>
  --net=container:<container name> \
  --cap-add sys_admin \
  --cap-add sys_ptrace \
  bash
```

Inject a fault using `strace`:

(Credit to https://medium.com/@manav503/using-strace-to-perform-fault-injection-in-system-calls-fcb859940895
and https://livebook.manning.com/book/chaos-engineering/)

```
# strace -f -p 61 -e trace=write -e fault=write:error=EAGAIN
```

Inject a latency:

Example: https://salvatoresecurity.com/exploiting-race-conditions-with-strace/#:~:text=One%20way%20that%20strace%20allows,call%20gets%20put%20to%20sleep.
