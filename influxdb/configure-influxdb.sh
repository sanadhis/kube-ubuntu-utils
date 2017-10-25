#!/bin/bash

set -e

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$message"
    echo "##################################"
}

function configure-admin () {
    print-banner "Registering admin user"
    local username="$1"
    local password="$2"    
    influx -execute "CREATE USER ${username} WITH PASSWORD '${password}' WITH ALL PRIVILEGES"
}

function configure-heapster-user () {
    print-banner "Registering heapster user to read and write"
    local username="$1"
    local password="$2"    
    influx -execute "CREATE USER ${username} WITH PASSWORD '${password}'"
    influx -execute "GRANT ALL ON k8s to ${username}"
}

function configure-grafana-user () {
    print-banner "Registering grafana user to read only"
    local username="$1"
    local password="$2"    
    influx -execute "CREATE USER ${username} WITH PASSWORD '${password}'"
    influx -execute "GRANT READ ON k8s to ${username}"
}

function configure-k8s-db () {
    print-banner "Creating k8s database"
    local username="$1"
    local password="$2"    
    influx -username ${username} -password ${password} -execute "CREATE DATABASE k8s"
    influx -username ${username} -password ${password} -execute \
        "CREATE RETENTION POLICY \"default\" ON k8s DURATION INF REPLICATION 1 DEFAULT"
}

print-banner "Input username and password for admin"
read -p "Enter USERNAME": admin_username
read -p "Enter PASSWORD": admin_password
configure-admin "$admin_username" "$admin_password"

print-banner "Input username and password for heapster"
read -p "Enter USERNAME": heapster_username
read -p "Enter PASSWORD": heapster_password
configure-heapster-user "$heapster_username" "$heapster_password"

print-banner "Input username and password for grafana"
read -p "Enter USERNAME": grafana_username
read -p "Enter PASSWORD": grafana_password
configure-grafana-user "$grafana_username" "$grafana_password"

print-banner "Copy Configuration File to Enable Authentication"
sudo cp templates/influxdb.conf /etc/influxdb/influxdb.conf

print-banner "Restarting influxdb service"    
sudo service influxdb restart

configure-k8s-db "$admin_username" "$admin_password"
