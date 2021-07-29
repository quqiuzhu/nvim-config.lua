project=vim
target=quqiuzhu/nvim
default_dir=/Users/quqiuzhu/Documents/
ifeq ($(shell uname), Linux)
		default_dir=/data/
endif
dir ?= ${default_dir}

build:
	docker build -f Dockerfile -t ${target}:latest .

dev:
	@docker run -it --rm --name=nvim \
	--network=host  \
	-v ${PWD}:/root/.config/nvim \
	-v ${dir}:/data/ \
	-w /data/ \
	${target}:latest bash

.PHONY: build dev
