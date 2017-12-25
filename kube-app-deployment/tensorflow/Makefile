all: build push

DOCKER_REPO?=sanadhis/dl-docker
VERSION?=gpu-py3

PWD:=$(shell pwd)

build:
	docker build -t $(DOCKER_REPO):$(VERSION) -f Dockerfile $(PWD)

push:
	docker push $(DOCKER_REPO):$(VERSION)