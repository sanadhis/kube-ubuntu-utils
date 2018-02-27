#!/bin/bash

set -e

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$message"
    echo "##################################"
}

function main () {
    print-banner "creating keygen on default location"
    ssh-keygen -t rsa -b 4096 -f $HOME/.ssh/id_rsa -q -N ""
    print-banner "adding ssh key to own self"
    PUBKEY=$(cat ~/.ssh/id_rsa.pub); grep -q "$PUBKEY"  ~/.ssh/authorized_keys || echo "$PUBKEY" >> ~/.ssh/authorized_keys
}

if  [ "$UID" -e 0 ] ; then
    echo "Please run as non-root"
else
    ensure-dependencies
    add-influxdb-repo-conf
    main "$@"
fi
