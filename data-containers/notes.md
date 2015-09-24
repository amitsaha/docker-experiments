###VOLUME command

- Different for every new container started, files are stored in a directory on the host, persisted.

```
"Mounts": [
        {
            "Name": "260e4d6b911cd16b0558ef39ced9ef57704ef965305e8358db175d3d24c4c4c7",
            "Source": "/var/lib/docker/volumes/260e4d6b911cd16b0558ef39ced9ef57704ef965305e8358db175d3d24c4c4c7/_data",
            "Destination": "/data",
            "Driver": "local",
            "Mode": "",
            "RW": true
        }
    ],

```