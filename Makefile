DOCKER := $(shell command -v docker)

IMAGE_TAG := st3ga/dumputils:local-test

.PHONY: default
default: build-run

.PHONY: build-run
build-run:
ifndef DOCKER
	@echo "Docker is not available. Please install docker"
	@exit 1
endif
	docker build -f Dockerfile -t $(IMAGE_TAG) .
	docker run --rm --name dumputils-test -h dumputils-test -it $(IMAGE_TAG)

