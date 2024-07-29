# engine-stressor: memory-exhaustion

## Table of Contents

- [How to monitor the usage of memory my base container is consuming?](#how-to-monitor-the-usage-of-memory-my-base-container-is-consuming)
- [Why not capture the memory consumption running a command inside the container?](#why-not-capture-the-memory-consumption-running-a-command-inside-the-container)
- [Why does increasing the `THRESHOLD_PERCENT` to 90 and having a `MEMORY_LIMIT` of 512 cause the system to get stuck and then proceed after 1 minute?](#why-does-increasing-the-threshold_percent-to-90-and-having-a-memory_limit-of-512-cause-the-system-to-get-stuck-and-then-proceed-after-1-minute)

## How to monitor the usage of memory my base container is consuming?

To monitor the memory usage of Podman during the stress-ng stress test, open a second terminal and run:

```sh
watch sudo podman stats --no-stream --format "{{.MemPerc}}" memory_eater_base_container
```

## Why not capture the memory consumption running a command inside the container?

Running the command like `ps eo cmd,%mem,%cpu --sort=%mem` inside the container is NOT recommended. It would only show resource usage from the container's perspective, which might not give a complete picture of the container's impact on the host system.

## Why does increasing the `THRESHOLD_PERCENT` to 90 and having a `MEMORY_LIMIT` of 512 cause the system to get stuck and then proceed after 1 minute?

When your system memory resources are low, and the memory usage reaches 90% or more, the operating system and Podman might not be able to allocate the necessary resources to continue tasks. This can prevent actions such as triggering new nested containers or stopping containers until some memory is freed.

For example, after 60 seconds have passed (1 minute) from the stress-ng timeout, the system may free up enough memory to allow these tasks to proceed.

## Example Test Output
```
======================
engine-stressor demo
======================

INFO: Cleaning previous engine-stressor container volume settings...
INFO: Cleaning previous engine-stressor container network settings...
INFO: Triggering 5 containers with engine-stressor...
INFO: creating cgroup engine_stressor with total memory limit 1G...
INFO: cgroup engine_stressor created and configured.

INFO: =======================================================
INFO: [0;32mVERBOSE MODE IS ON[0m
INFO: =======================================================
INFO: env NETWORK_NAME is my_network
INFO: env PACKAGER_INSTALLER is dnf
INFO: env PACKAGER_INSTALLER_EXTRA_FLAGS is 
INFO: env VOLUME_NAME is my_volume
INFO: env NUMER_OF_CONTAINERS is 5
INFO: env IMAGE_NAME_CONTAINER is quay.io/podman/stable
INFO: env IMAGE_COMMAND is sleep 3600

INFO: creating volume my_volume
PASS: volume my_volume created.
INFO: creating network my_network
PASS: network my_network created.
INFO: Starting initial container memory_eater_base_container
time="2024-07-29T00:40:46-04:00" level=warning msg="StopSignal SIGTERM failed to stop container memory_eater_base_container in 10 seconds, resorting to SIGKILL"
acf3cc4e20691a325f90573fc9aa8f845611199618c276961533cb5cc8a67ba6
INFO: Started container memory_eater_base_container successfully
INFO: Current memory usage of memory_eater_base_container: 1.01%
INFO: Current memory usage of memory_eater_base_container: 4.77%
INFO: Current memory usage of memory_eater_base_container: 7.32%
INFO: Current memory usage of memory_eater_base_container: 10.59%
INFO: Current memory usage of memory_eater_base_container: 15.75%
INFO: Current memory usage of memory_eater_base_container: 22.01%
INFO: Current memory usage of memory_eater_base_container: 29.39%
INFO: Current memory usage of memory_eater_base_container: 21.05%
INFO: Current memory usage of memory_eater_base_container: 21.05%
INFO: Current memory usage of memory_eater_base_container: 21.26%
INFO: Current memory usage of memory_eater_base_container: 25.42%
INFO: Current memory usage of memory_eater_base_container: 35.24%
INFO: Memory usage of memory_eater_base_container exceeded threshold of 30%
INFO: Creating additional containers inside memory_eater_base_container
INFO: Running nested container memory_eater_base_container_nested_1 inside memory_eater_base_container with image quay.io/podman/stable
INFO: podman run -d --name "memory_eater_base_container_nested_1" --privileged quay.io/podman/stable sleep infinity
Trying to pull quay.io/podman/stable:latest...
Getting image source signatures
Copying blob sha256:5e29d3cba7b0e100a87e6a3d0c4cf92e4d436d7875d64f06822f8b4c2cdfcc2f
Copying blob sha256:46e071b495a498f679543d9edaa295b288ad325fc437713bc9e0b28ca93b8f78
Copying blob sha256:5c6fa8d895a137bdb1f14b908435240bfa4b15ed640f5cefbb4c1dab5f059cc0
Copying blob sha256:9136d892bd582687d6c990f7b7911c1bd26b3c0b4f3b498e8e72c8c1e67fc889
Copying blob sha256:9a417b0495fafb914c0800d23b00bcce3fafdb9d3641c77ed42ccbff323e538c
Copying blob sha256:4b35eebb046609bfd4289f067c1ee1c113f996941044c039bde9624b390055eb
Copying blob sha256:050ac451a4e920d93ad0781bfc4766e13a99626b167f4bc38bea64ae7f5dff38
Copying blob sha256:5e7bc2fa42d31cfad20a00c318201f321eeb04daae82b0b0e4de36d216788c71
Copying blob sha256:b3dc13e55b38d9c7b0d1a678273f51a51163a0407cced8cc238af83c29853905
Copying blob sha256:86c0fd92a28122c6d6d819fb9f7f4afd7a4bf701be3d1ae6ce92293800c5c1f5
Copying config sha256:ef4246bfde90c78e540f19f7d1aa43084e7bd34d331d93a5deb2268d7f6a365b
Writing manifest to image destination
c8d61d23ffc15ce8cedcd2d0fb42dddd21684d9986e98ecc83ccdb8e34ff3e14
INFO: Started nested container memory_eater_base_container_nested_1 inside memory_eater_base_container
INFO: Running nested container memory_eater_base_container_nested_2 inside memory_eater_base_container with image quay.io/podman/stable
INFO: podman run -d --name "memory_eater_base_container_nested_2" --privileged quay.io/podman/stable sleep infinity
f84deb10b9cbfe3f97aba7c444e7045e84361cdfee587f55a870b2965d59f374
INFO: Started nested container memory_eater_base_container_nested_2 inside memory_eater_base_container
INFO: Running nested container memory_eater_base_container_nested_3 inside memory_eater_base_container with image quay.io/podman/stable
INFO: podman run -d --name "memory_eater_base_container_nested_3" --privileged quay.io/podman/stable sleep infinity
7d24026848112a4edebcf5e510ed00904b97c8af93cb994c8f973dd5b4bea5e1
INFO: Started nested container memory_eater_base_container_nested_3 inside memory_eater_base_container
INFO: Running nested container memory_eater_base_container_nested_4 inside memory_eater_base_container with image quay.io/podman/stable
INFO: podman run -d --name "memory_eater_base_container_nested_4" --privileged quay.io/podman/stable sleep infinity
c7300e7e1b330cec6139a50bf87421d39c7911bbb76f022d405277c6d20b2c49
INFO: Started nested container memory_eater_base_container_nested_4 inside memory_eater_base_container
INFO: Running nested container memory_eater_base_container_nested_5 inside memory_eater_base_container with image quay.io/podman/stable
INFO: podman run -d --name "memory_eater_base_container_nested_5" --privileged quay.io/podman/stable sleep infinity
f836df4d3929c2b2bae23bc75bc6b4904ca21e5137fe246b42f86839ba55ec5d
INFO: Started nested container memory_eater_base_container_nested_5 inside memory_eater_base_container
INFO: All nested containers started successfully
INFO: Cleaning up nested containers
time="2024-07-29T04:41:26Z" level=warning msg="StopSignal SIGTERM failed to stop container memory_eater_base_container_nested_1 in 10 seconds, resorting to SIGKILL"
memory_eater_base_container_nested_1
memory_eater_base_container_nested_1
INFO: Nested container memory_eater_base_container_nested_1 stopped and removed successfully
time="2024-07-29T04:41:36Z" level=warning msg="StopSignal SIGTERM failed to stop container memory_eater_base_container_nested_2 in 10 seconds, resorting to SIGKILL"
memory_eater_base_container_nested_2
memory_eater_base_container_nested_2
INFO: Nested container memory_eater_base_container_nested_2 stopped and removed successfully
time="2024-07-29T04:41:46Z" level=warning msg="StopSignal SIGTERM failed to stop container memory_eater_base_container_nested_3 in 10 seconds, resorting to SIGKILL"
memory_eater_base_container_nested_3
memory_eater_base_container_nested_3
INFO: Nested container memory_eater_base_container_nested_3 stopped and removed successfully
time="2024-07-29T04:41:57Z" level=warning msg="StopSignal SIGTERM failed to stop container memory_eater_base_container_nested_4 in 10 seconds, resorting to SIGKILL"
memory_eater_base_container_nested_4
memory_eater_base_container_nested_4
INFO: Nested container memory_eater_base_container_nested_4 stopped and removed successfully
time="2024-07-29T04:42:07Z" level=warning msg="StopSignal SIGTERM failed to stop container memory_eater_base_container_nested_5 in 10 seconds, resorting to SIGKILL"
memory_eater_base_container_nested_5
memory_eater_base_container_nested_5
INFO: Nested container memory_eater_base_container_nested_5 stopped and removed successfully
INFO: Cleaning up container memory_eater_base_container
time="2024-07-29T00:42:17-04:00" level=warning msg="StopSignal SIGTERM failed to stop container memory_eater_base_container in 10 seconds, resorting to SIGKILL"
memory_eater_base_container
INFO: Container memory_eater_base_container stopped successfully
memory_eater_base_container
INFO: Container memory_eater_base_container removed successfully
PASS: Memory exhaustion test completed successfully

PASS: A total of 5 containers were created. The batch size for parallel container creation is 16.
```
