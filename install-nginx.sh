#!/bin/bash

set -e

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$message"
    echo "##################################"
}

function add-nginx-apt-stanza () {
    nginxStanza="/etc/apt/sources.list.d/nginx.list"
    print-banner "Add nginx apt list to $nginxStanza"    
    releaseCode=$(lsb_release -cs)
    echo "deb http://nginx.org/packages/ubuntu/ $releaseCode nginx" > $nginxStanza
    echo "deb-src http://nginx.org/packages/ubuntu/ $releaseCode nginx" >> $nginxStanza
}

function main () {
    add-nginx-apt-stanza
    print-banner "Updating apt sources list"
    sudo apt-get update && \
        apt-get -y install nginx
}

if  [ "$UID" -ne 0 ] ; then
    echo "Please run as root"
else
    main "$@"
fi