# How to play with Minikube v1.0.0 and Istio v1.0.6 without VM Driver in Ubuntu Xenial 16.10 on AWS EC2
This is just a note to myself so that I can remember how I solve the problem with [minikube v1.0.0](https://kubernetes.io/docs/setup/minikube/)

## Scenario
Suppose that I want to test [istio 1.0.6](https://istio.io/about/notes/1.0.6/) (not the recent version obviously) for some discreet reasons. Ideally using Kubernetes in one machine setup will be wonderful since I don't want to pay for multiple machines in ec2. Thus, using minikube may be the best solution for this condition.

## Prerequisites
1. Order a single t2 instance in AWS (or other cheap option somewhere else). I suggest at least the 2-vCPU and 8GB-memory VM. 
2. Steady mental and health.

## Steps
1. Install Docker **18.06**. Minikube v1.0.0 does not support the newer version of Docker. Follow this: [link](https://docs.docker.com/install/linux/docker-ce/ubuntu/). During the install steps, skip step 2 and go to 3b to install version 18.06 of docker:
```bash
sudo apt-get install docker-ce=18.06.0~ce~3-0~ubuntu containerd.io
```

2. Install Minikube version 1.0.0 for Linux. Follow [this](https://kubernetes.io/docs/tasks/tools/install-minikube/).

3. Install Kubectl for Linux. Follow [this](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

4. Start minikube. For whatever reason, by default minikube v1.0.0 use different subnets. So we have to configure some proxy properties when starting minikube:
```bash
sudo minikube start --cpus 2 --memory 2048 --disk-size 10g --kubernetes-version v1.11.0 --vm-driver=none --docker-env no_proxy="localhost,127.0.0.1,192.168.39.1/24,10.96.0.0/12"
```
Notes:
* Use sudo because it runs directly in the OS space (we put --vm-driver=none)
* We actually don't need to explicitly configure cpu and memory to 2 vCPUs and 2048 MB memory because it is a default value. Feel free to increase these but do not put smaller values
* The default disk-size is 20g, but for testing purpose there is no need to allocate such size.
* Specify --kubernetes-version to use different version of kubernetes' core (kubeadm and kubelet)
* Pass those random proxy settings, if minikube hangs during the start process, add these arguments: 
```bash
--docker-env http_proxy=http://proxy.dog.com:80 --docker-env https_proxy=http://proxy.dog.com:80
```

5. Voila! That should make it running. Now install helm and tiller. Follow this [link](https://helm.sh/docs/using_helm/#installing-helm).

6. Install istio v1.0.6. Follow this [link](https://archive.istio.io/v1.0/docs/setup/kubernetes/helm-install/). Read carefully the installation steps especially prior to helm versioning.

7. Done!.