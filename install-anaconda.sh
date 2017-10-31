#!/bin/bash

set -e

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$message"
    echo "##################################"
}

function pre-installation () {
    print-banner "Getting anaconda installation script"
    mkdir -p $HOME/.temp
    wget https://repo.continuum.io/archive/Anaconda2-5.0.1-Linux-x86_64.sh \
        -O $HOME/.temp/conda.sh
    chmod +x $HOME/.temp/conda.sh
}

function main () {
    print-banner "Installing anaconda"
    cd $HOME/.temp
    ./conda.sh
}

function post-installation () {
    print-banner "Installing numba and cudatoolkit"
    conda install numba cudatoolkit
    rm -rf $HOME/.temp
}

if  [ "$UID" -eq 0 ] ; then
    echo "Please do not run as root"
else
    pre-installation
    main "$@"
    post-installation
fi