# Kubernetes in Ubuntu: Utils & Packages

> Packages I personally think should exist when using Ubuntu to Develop application/system
> Basic settings and script to have kubernetes running everywhere as long as the OS is Xenial (16.04).

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
- unzip (zip and extract)
- pip (package manager via pip)
- docker (containerized now!)

# Kubernetes

## Packages for Kubernetes
- kubelet (kubernetes' core)
- kubectl (kubernetes's main command line tool)
- kubeadm (most flexible tool to bring up kubernetes cluster in seconds)
- kubernetes-cni (installed automatically when you install above three)
- addiitonal config for kubectl-> allowing autocompletion
- prerequisites config -> disable swap and enable ipv4 forward for iptables

## Fixing Swap Problem in Kubelet
If you are unwilling to disable swap in your machine, you can set kubelet to compromise with your setting by adding this environment to kubelet:
  
  ```bash
  $ /usr/bin/kubelet --fail-swap-on=false
  ```
Edit your systemctl kubelet.service
  
  ```bash
  $ sudo systemctl edit -l kubelet.service
  ```
If you are using kubeadm to bring up the cluster, you can simply copy the 10-kubeadm.conf in templates/ to /etc/systemd/system/kubelet.service.d/10-kubeadm.conf