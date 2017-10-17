#!/bin/bash

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$1"
    echo "##################################"
}

function tune-kubernetes-config () {
    print-banner "Bridge IPv4 traffic to iptables chains"
    sudo systcl net.bridge.bridge-nf-call-iptables=1
    print-banner "Disabling Swap"
    # To do
}

function main () {
    print-banner "Updating apt sources list"
    sudo apt-get update
    print-banner "Installing ebtables ethtool"
    sudo apt-get install ebtables ethtool
    print-banner "Installing kubernetes: kubelet kubeadm kubectl"
    # add kubernetes' official key
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
    cat <<EOF >/etc/apt/sources.list.d/kubernetes.list \
    deb http://apt.kubernetes.io/ kubernetes-xenial main \
    EOF
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
}

if  [ "$UID" -ne 0 ] then ;
    echo "Please run as root"
else
    main "$@"
fi