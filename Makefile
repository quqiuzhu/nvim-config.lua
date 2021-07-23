project=vim
target=mynvim

build:
	docker build -f Dockerfile -t ${target}:latest .

dev:
	@docker run -it --rm --name=vim \
	--network=host  \
	-v ${PWD}:/root/.config/nvim \
	-v /data:/data \
	-w /root/.config/nvim \
	${target}:latest bash

.PHONY: build dev
