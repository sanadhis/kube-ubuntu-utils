#!/bin/bash

set -e

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$message"
    echo "##################################"
}

function main () {
    print-banner "Download GNU Parallel for Xenial amd64"
    wget http://launchpadlibrarian.net/188755637/parallel_20141022+ds1-1_all.deb \
        -O /tmp/gnu-parallel.deb
    print-banner "Install and ensure sysstat"
    sudo apt-get update && \
            sudo apt-get install sysstat
    print-banner "Installing gnu-parallel"
    sudo dpkg -i /tmp/gnu-parallel.deb
}

if  [ "$UID" -ne 0 ] ; then
    echo "Please run as root"
else
    main "$@"
fi