#!/bin/bash
# vim: set ft=sh:
# Description: Clones the engine-stressor repository, installs and run it.

# Include BeakerLib environment

# shellcheck source=/dev/null
. /usr/share/beakerlib/beakerlib.sh || exit 1

REPO="https://github.com/containers/engine-stressor"

rlJournalStart
    rlPhaseStartSetup
        rlLogInfo "Ensuring Podman is installed"
        if ! command -v podman &> /dev/null; then
            rlLogInfo "Podman is not installed. Installing Podman."
            rlRun "sudo dnf install -y podman" 0 "Install Podman"
        fi

        rlLogInfo "Cloning the repository"
        rlRun "git clone $REPO" 0 "Clone the engine-stressor repository"

        rlLogInfo "Navigating to the cloned repository directory"
        rlRun "cd engine-stressor" 0 "Change to the repository directory"

        rlLogInfo "Installing dependencies"
        rlRun "sudo make install" 0 "Execute sudo make install"
    rlPhaseEnd

    rlPhaseStartTest
        rlLogInfo "Running engine-stressor with specified parameters"
        rlRun 'sudo -E bash -c "TOTAL_MEMORY_FOR_THE_NAMESPACE=\"1G\" \
            LIST_CURRENT_STATE=true \
            VERBOSE=true \
            CLEANUP=false \
            TIMEOUT_PODMAN_STOP_CONTAINER=5 \
            NETWORK_NAME=\"my-network\" \
            VOLUME_NAME=\"my-volume\" \
            IMAGE_NAME_CONTAINER=\"quay.io/centos-sig-automotive/automotive-osbuild\" \
            IMAGE_COMMAND=\"sleep 3600\" \
            NUMBER_OF_CONTAINERS=\"100\" \
            ./engine-stressor"' 0 "Run engine-stressor with the specified environment variables"

        rlAssert0 "engine-stressor ran successfully" $? # Assert to check if the previous command ran successfully
    rlPhaseEnd

    rlPhaseStartCleanup
        rlLogInfo "Cleaning up"
        rlRun "cd .."
        rlRun "rm -rf engine-stressor" 0 "Remove cloned repository"
        rlRun "podman network rm my-network --force"
        rlRun "podman volume rm my-volume --force"
    rlPhaseEnd
rlJournalEnd
