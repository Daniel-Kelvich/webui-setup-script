build:
	docker build -f Dockerfile -t auto1111 .

run:
	docker run --rm -it --init \
		--gpus=all \
		--ipc=host \
		--user=root \
		-p 7860:7860 \
		-v $(CURDIR):/app \
		--entrypoint /bin/bash \
		auto1111

setup:
	bash webui.sh -f --listen --xformers