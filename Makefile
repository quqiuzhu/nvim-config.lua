project=vim
target=mynvim
github_dir=/Users/quqiuzhu/Documents/github/
ifeq ($(shell uname), Linux)
		github_dir=/data/github/
endif

build:
	docker build -f Dockerfile -t ${target}:latest .

dev:
	@docker run -it --rm --name=nvim \
	--network=host  \
	-v ${PWD}:/root/.config/nvim \
	-v ${github_dir}:/root/github/ \
	-w /root/github/ \
	${target}:latest bash

.PHONY: build dev
