#!/bin/bash

set -e

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$message"
    echo "##################################"
}

function main () {
    local packages="$@"
    print-banner "Updating apt sources list"
    sudo apt-get update
    for package in $packages
    do
        print-banner "Installing ${package}"
        sudo apt-get install -y $package
    done
}

if  [ "$UID" -ne 0 ] ; then
    echo "Please run as root"
else
    main "$@"
fi
