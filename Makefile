.PHONY: all build

all: build

build:
	docker build -t "hectcastro/basho-otp" .
