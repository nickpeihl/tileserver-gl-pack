VERSION = 1.0.0
IMAGE = push.docker.elastic.co/tileserver-gl-pack/tileserver-gl-pack:${VERSION}

.PHONY: build
build:
	docker build -t ${IMAGE} .

.PHONY: run
run: build
	docker run -it --rm ${IMAGE}

.PHONY: publish
publish: build
	docker push ${IMAGE}
