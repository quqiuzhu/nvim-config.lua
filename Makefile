project=vim
target=quqiuzhu/nvim
default_dir=/Users/quqiuzhu/Documents/
ifeq ($(shell uname), Linux)
		default_dir=/data/
endif
dir ?= ${default_dir}

commit:
	cp -rf .commit-msg .git/hooks/commit-msg

build:
	docker build -f ./docker/Dockerfile -t ${target}:latest ./docker

dev:
	@docker run -it --rm --name=nvim \
	--network=host  \
	-v ${PWD}:/root/.config/nvim \
	-v ${dir}:/data/ \
	-w /data/ \
	${target}:latest bash

.PHONY: build dev commit
