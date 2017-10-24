#!/bin/bash

set -e

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$message"
    echo "##################################"
}

function main () {
    print-banner "Updating apt sources list"
    sudo apt-get update
    print-banner "Install packages for apt by https"
    sudo apt-get install -y \
                    apt-transport-https \
                    ca-certificates \
                    software-properties-common
    print-banner "Installing git"
    sudo apt-get install -y git
    print-banner "Installing Vim"
    sudo apt-get install -y vim
    print-banner "Installing curl"
    sudo apt-get install -y curl
    print-banner "Installing htop"
    sudo apt-get install -y htop
    print-banner "Installing bash-completion"
    sudo apt-get install -y bash-completion
    print-banner "Installing figlet,cowsay"
    sudo apt-get install -y figlet cowsay
    print-banner "Installing unzip"
    sudo apt-get install -y unzip
    print-banner "Installing pip"
    sudo apt-get install -y python-pip
    print-banner "Installing docker"
    #docker's official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    #get the stable version of docker
    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
    #finally installing docker
    sudo apt-get update && sudo apt-get install -y docker-ce docker-engine
    print-banner "Activating Docker as non-root user"
    sudo usermod -aG docker $(whoami)
}

if  [ "$UID" -ne 0 ] ; then
    echo "Please run as root"
else
    main "$@"
fi