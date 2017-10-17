# Ubuntu Utils & Packages

> Packages I personally think should exist when using Ubuntu to Develop application/system

## Maintainer

- Sanadhi Sutandi ([@sanadhis](https://github.com/sanadhis))

## Usage

1. Clone this repository
2. Run the script in terminal:

  ```bash
  $ cd ubuntu-utils/
  $ ./install.sh
  ```
  
## Packages
- apt-transport-https, ca-certificates, software-properties-common (apt via HTTPS)
- vim, curl (obviously need these ones)
- htop (monitor your resources utilization)
- figlet, cowsay (for fun, you know it)
- pip (package manager via pip)
- docker (containerized now!)

## Packages for Kubernetes
- kubelet (kubernetes' core)
- kubectl (kubernetes's main command line tool)
- kubeadm (most flexible tool to bring up kubernetes cluster in seconds)
- kubernetes-cni (installed automatically when you install above three)
- addiitonal config for kubectl-> allowing autocompletion
- prerequisites config -> disable swap and enable ipv4 forward for iptables