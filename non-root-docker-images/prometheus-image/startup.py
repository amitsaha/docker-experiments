#!/usr/bin/python3

import subprocess
import os
import sys
import signal

child_process = None
def sig_handler(signum, frame):
    print("Got signal: ", signum)
    if child_process:
        child_process.send_signal(signum)

# Setup signal handlers
signal.signal(signal.SIGINT, sig_handler)
signal.signal(signal.SIGTERM, sig_handler)


# App startup
dstat = os.stat("/data")
if dstat:
    if os.access("/data", os.X_OK):
        child_process = subprocess.Popen(["/usr/local/bin/prometheus/prometheus", "--config.file", "/etc/prometheus.yml", "--storage.tsdb.path",  "/data"])
        child_process.wait()
    else:
        print("Invalid permissions for /data")
        print(dstat)
        sys.exit(1)
else:
    print("/data does not exist")
    sys.exit(1)
