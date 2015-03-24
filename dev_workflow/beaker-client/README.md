bkr client
==========

Fedora 21 Docker image with the beaker client, ``bkr`` installed which will update the beaker client to the latest nightly on startup. Potentially useful for trying out new ``bkr`` commands.

Example
=======

```
docker run -t amitsaha/bkr policy-grant --help
```

Issues
======

- Passwords displayed in plain text
- Password login doesn't seem to be working
