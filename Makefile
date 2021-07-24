project=vim
target=mynvim

build:
	docker build -f Dockerfile -t ${target}:latest .

dev:
	@docker run -it --rm --name=nvim \
	--network=host  \
	-v ${PWD}:/root/.config/nvim \
	-v /Users/quqiuzhu/Documents/github:/root/github \
	-w /root/.config/nvim \
	${target}:latest bash

.PHONY: build dev
