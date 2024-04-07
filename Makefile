include .env
USE_SUDO := $(shell which docker >/dev/null && docker ps 2>&1 | grep -q "permission denied" && echo sudo)
DOCKER := $(if $(USE_SUDO), sudo docker, docker)
DOCKER_COMPOSE := $(if $(USE_SUDO), sudo docker-compose, docker-compose)

build-gpu:
	$(DOCKER) build . --tag $(IMAGE_TAG)

build-cpu:
	$(DOCKER) build . --file Dockerfile-cpu --tag $(IMAGE_TAG)

llama-2-13b:
	cd models && ../get_model.sh $@

mistral-7b:
	cd models && ../get_model.sh $@

solar-10b:
	cd models && ../get_model.sh $@

up-gpu:
	$(DOCKER_COMPOSE) --env-file .env -f docker-compose.yml -f docker-compose.gpu.yml up

up-cpu:
	$(DOCKER_COMPOSE) --env-file .env -f docker-compose.yml -f docker-compose.cpu.yml up

down:
	$(DOCKER_COMPOSE) down
