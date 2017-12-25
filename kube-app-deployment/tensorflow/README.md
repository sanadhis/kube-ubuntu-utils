# Issue with Tensorflow-GPU-Python3 in Kubernetes
Note: Installing libcudnn is necessary for Tensorflow (version > 1.3.0) to utilize the GPU. Follow the given links to setup libcudnn.
**By reading this, it is assumed that you have already had working Tensorflow before in Kubernetes, so you may familiar with NVIDIA/cuda Driver, NVIDIA-DOCKER Plugin, Shared HostPath of Kubernetes, and Reserving GPU Resources in Kubernetes.**

The procedure was checked and updated on 11th Dec 2017
* Working for tensorflow: 1.4.0-gpu-py3
* Working for the latest version: latest-gpu-py3 (build 9th Dec 2017)
* Working for my custom and bundled deep learning images. [Repo](https://hub.docker.com/r/sanadhis/dl-docker/)

View available tensorflow images on official page: [tensorflow](https://hub.docker.com/r/tensorflow/tensorflow/tags/)

## Links
* [libcudnn-1](https://stackoverflow.com/questions/42013316/after-building-tensorflow-from-source-seeing-libcudart-so-and-libcudnn-errors/45787225#45787225)

* [libcudnn-2](https://askubuntu.com/questions/767269/how-can-i-install-cudnn-on-ubuntu-16-04)
