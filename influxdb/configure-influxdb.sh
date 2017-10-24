#!/bin/bash

set -e

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$message"
    echo "##################################"
}

function configuring-admin () {
    print-banner "Registering admin user"
    local username="$1"
    local password="$2"    
    influx -execute "CREATE USER ${username} WITH ${password} WITH ALL PRIVILEGES"
}

function configuring-heapster-user () {
    print-banner "Registering heapster user to read and write"
    local username="$1"
    local password="$2"    
    influx -execute "CREATE USER ${username} WITH ${password}"
    influx -execute "GRANT [READ,WRITE,ALL] ON _k8s to ${username}"
}

function configuring-grafana-user () {
    print-banner "Registering grafana user to read only"
    local username="$1"
    local password="$2"    
    influx -execute "CREATE USER ${username} WITH ${password}"
    influx -execute "GRANT [READ] ON _k8s to ${username}"
}

if  [ "$UID" -ne 0 ] ; then
    echo "Please run as root"
else
    print-banner "Input username and password for admin"
    read -p "Enter USERNAME PASSWORD": admin_username admin_password
    configuring-admin "$admin_username" "$admin_password"

    print-banner "Input username and password for heapster"
    read -p "Enter USERNAME PASSWORD": heapster_username heapster_password
    configuring-admin "$heapster_username" "$heapster_password"
    
    print-banner "Input username and password for grafana"
    read -p "Enter USERNAME PASSWORD": grafana_username grafana_password
    configuring-admin "$grafana_username" "$grafana_password"
fi
