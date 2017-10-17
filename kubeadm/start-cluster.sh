#!/bin/bash
set -e

function main () {
    sudo kubeadm init \ 
        --skip-preflight-checks \
        --pod-network-cidr 192.168.0.0/16 \
        --service-cidr 10.96.0.0/12
}

if  [ "$UID" -ne 0 ] ; then
    echo "Please run as root"
else
    main "$@"
fi