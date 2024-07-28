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
