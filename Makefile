.PHONY: build
build:
	docker build . -t nyurik/tileserver-gl-pack -f Dockerfile

.PHONY: run
run: build
	docker run -it --rm tileserver-gl-pack

.PHONY: publish
publish: build
	docker push nyurik/tileserver-gl-pack
