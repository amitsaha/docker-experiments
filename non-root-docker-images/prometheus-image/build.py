#!/usr/bin/python3

import subprocess
print(str(subprocess.check_output(["docker", "build", "-t", "amitsaha/prometheus", "."])))
