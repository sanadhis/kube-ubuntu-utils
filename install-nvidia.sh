#!/bin/bash

set -e

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$message"
    echo "##################################"
}

function pre-installation () {
    print-banner "Removing existing NVIDIA packages"
    sudo apt-get --purge remove nvidia*
    print-banner "Ensuring development kernel"
    sudo apt-get install linux-headers-$(uname -r)
    print-banner "Downloading installer (*.deb)"
    ### Working for Nvidia GeForce Titan X
    wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb \
        -O /tmp/cuda.deb
}

function main () {
    print-banner "Installing Nvidia Cuda Driver"
    sudo dpkg -i /tmp/cuda.deb
    print-banner "Accepting key"    
    sudo apt-key add /var/cuda-repo-9-0-local/7fa2af80.pub
    print-banner "Updating apt list"
    sudo apt-get update
    print-banner "Installing Nvidia Cuda Driver"
    sudo apt-get install cuda
}

function nvidia-docker () {
    print-banner "Downloading nvidia-docker"
    wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
    print-banner "Installing Nvidia Docker"
    sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb
}

if  [ "$UID" -ne 0 ] ; then
    echo "Please run as root"
else
    pre-installation
    main "$@"
    nvidia-docker
fi