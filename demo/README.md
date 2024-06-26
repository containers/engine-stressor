Clone the git repo and make install 

```bash
$ git clone https://github.com/containers/engine-stressor
$ pushd engine-stressor
    $ sudo make install
      Installation complete.
$ popd
```

Run the demo
```bash
$ sudo ./run-example
======================
engine-stressor demo
======================

INFO: Cleaning previous engine-stressor container volume settings...
INFO: Cleaning previous engine-stressor container network settings...
INFO: Triggering 5 containers with engine-stressor...
INFO: done
```

List resources
```bash
$ sudo ./list_demo_resources
======================
engine-stressor demo
======================

INFO: listing podman process(es)...
CONTAINER ID  IMAGE                                                    COMMAND     CREATED        STATUS        PORTS       NAMES
4faaeb42393a  quay.io/centos-sig-automotive/automotive-osbuild:latest  sleep 3600  2 seconds ago  Up 3 seconds              test_container_3
aa0350fc7a5e  quay.io/centos-sig-automotive/automotive-osbuild:latest  sleep 3600  2 seconds ago  Up 3 seconds              test_container_1
ee231542754b  quay.io/centos-sig-automotive/automotive-osbuild:latest  sleep 3600  2 seconds ago  Up 3 seconds              test_container_2
...

INFO: listing podman network(s)...
NETWORK ID    NAME             DRIVER
756536f5720a  my_network       bridge
2f259bab93aa  podman           bridge
d02257247752  podmanDualStack  bridge

INFO: listing podman volume(s)...
DRIVER      VOLUME NAME
local       my_volume

INFO: listing resource from cgroup engine_stressor...
  - cgroup name: engine_stressor
  - path: /sys/fs/cgroup/engine_stressor
  - slice: /sys/fs/cgroup/engine_stressor.slice
  - Current cgroup memory max:  1 GB
```

Cleanup
```
$ sudo ./cleanup_resources_demo
======================
engine-stressor demo
======================

INFO: removing podman resources from the demo...
INFO: removing podman volume used during the demo..
INFO: removing podman network used during the demo..
INFO: removing podman containers used during the demo..
```
