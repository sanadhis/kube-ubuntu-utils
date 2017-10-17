#!/bin/bash
set -e

function config-kubectl () {
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
}

function install-pod-network () {
    # use Calico
    kubectl apply -f https://docs.projectcalico.org/v2.6/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml
}

function taint-node () {
    kubectl taint nodes --all node-role.kubernetes.io/master-
}

function kubectl-autocompletion () {
    echo "source <(kubectl completion bash)" >> ~/.bashrc
}

if [ "$UID" -eq 0 ] ; then
    echo "Please Do not Run as Sudo"
    echo "You will be prompted your password, and it's good"
else
    config-kubectl
    install-pod-network
    taint-node
    kubectl-autocompletion
fi
