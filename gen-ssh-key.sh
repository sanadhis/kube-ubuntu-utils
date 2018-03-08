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
    touch $HOME/.ssh/authorized_keys
    PUBKEY=$(cat $HOME/.ssh/id_rsa.pub); grep -q "$PUBKEY" $HOME/.ssh/authorized_keys || echo "$PUBKEY" >> $HOME/.ssh/authorized_keys
}

if  [ "$UID" -eq 0 ] ; then
    echo "Please run as non-root"
else
    main "$@"
fi
