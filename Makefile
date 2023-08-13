project=nvim
target=quqiuzhu/nvim
version=v0.9.1

commit:
	cp -rf .commit-msg .git/hooks/commit-msg

fmt:
	lua-format -i lua/*/*.lua

build:
	docker build --network host --build-arg HTTPS_PROXY=http://proxy.sensetime.com:3128 -f ./.devcontainer/Dockerfile -t ${target}:${version} ./.devcontainer

dev:
	@docker run -it --rm --name=nvim \
	--network=host  \
	-v ${PWD}:/root/.config/nvim \
	-v ${dir}:/data/ \
	-w /data/ \
	${target}:${version} bash

.PHONY: build dev commit
