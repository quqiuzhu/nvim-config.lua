image:
	docker build -f Dockerfile --network host -t nvim-image

dev:
	docker run -it --rm --name=nvim \
	--network=host  \
	-v ${PWD}:/root/.config/nvim \
	-w /root/.config/nvim \
	nvim-image nvim

.PHONY: image dev