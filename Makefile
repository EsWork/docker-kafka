all: build

build:
	@docker build --tag=eswork/kafka .
release: build
	@docker build --tag=eswork/kafka:$(shell cat VERSION) .