DOCKERHUB_REPONAME=ghcr.io/bearfield
CONTAINER_NAME=terraform
TAG_NAME=test.1.9

MAKEFILE_DIR=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))
WORK_DIR=$(MAKEFILE_DIR)
BASE_IMAGE_NAME=ghcr.io/bearfield/debian-fish:bookworm

.PHONY: base-pull
base-pull:
	docker pull $(BASE_IMAGE_NAME)

.PHONY:test.build
test.build: base-pull
	cd $(WORK_DIR)
	docker build --tag=$(DOCKERHUB_REPONAME)/$(CONTAINER_NAME):$(TAG_NAME) ./docker

.PHONY:test.rmi
test.rmi:
	docker rmi $(DOCKERHUB_REPONAME)/$(CONTAINER_NAME):$(TAG_NAME)

.PHONY:test
test: test.build test.rmi