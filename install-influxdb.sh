#!/bin/bash

set -e

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$message"
    echo "##################################"
}

function ensure-dependencies () {
    print-banner "Ensuring dependencies"    
    ./dependencies.sh "apt-transport-https" "curl"
}

function add-influxdb-repo-conf () {
    print-banner "Adding configuration for influxdb repository"    
    curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
    source /etc/lsb-release
    echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
}

function main () {
    print-banner "Updating apt sources list"
    sudo apt-get update
    print-banner "Installing Influxdb"
    sudo apt-get install influxdb
    print-banner "Starting influxdb service"    
    sudo service influxdb start
}

if  [ "$UID" -ne 0 ] ; then
    echo "Please run as root"
else
    ensure-dependencies
    add-influxdb-repo-conf
    main "$@"
fi