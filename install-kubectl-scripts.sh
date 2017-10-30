#!/bin/bash
set -e

args1="$1"

function print-banner () {
    local message="$1"
    echo "$message"
}

function main() {
    scripts=$(ls kubectl-scripts)
    currentDir=$(pwd)
    for script in $scripts
    do
        print-banner "$currentDir/kubectl-scripts/$script --> /usr/local/bin/$script"
        sudo ln -sf $currentDir/kubectl-scripts/$script /usr/local/bin/$script
    done
}

if  [ "$UID" -ne 0 ] ; then
    echo "Please run as root"
else
    main "$@"
fi
