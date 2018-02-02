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
    softwares=( "git" "vim" "curl" "htop" "bash-completion" \
               "figlet" "unzip" "python-pip" )
    for software in ${softwares[@]}
    do
        print-banner "Installing $software"
        sudo apt-get install -y $software
    done
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
    sudo apt-get update && sudo apt-get install -y docker-ce #docker-engine
    print-banner "Activating Docker as non-root user"
    sudo usermod -aG docker $(whoami)
}

if  [ "$UID" -ne 0 ] ; then
    echo "Please run as root"
else
    main "$@"
fi