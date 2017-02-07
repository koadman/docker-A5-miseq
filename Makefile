env    = PATH=./env/bin:${PATH}
image  = biobox_testing/a5_miseq

ssh: .image env
	docker run \
		--tty \
		--interactive \
		--volume=$(shell pwd)/biobox_verify/input:/bbx/input:ro \
		--volume=$(shell pwd)/biobox_verify/output:/bbx/output:rw \
		--entrypoint=/bin/bash \
		$(image)

test: .image env
	@$(env) biobox verify short_read_assembler $(image) --verbose

build: .image

.image: $(shell find image -type f) Dockerfile
	@docker build --tag $(image) .
	@touch $@

env:
	@virtualenv $@
	@$@/bin/pip install biobox_cli
