APP_NAME=fopina/github-runner

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build the image
	docker build -t $(APP_NAME):local docker

shell: ## Creates a shell inside the container for debug purposes
	docker run -it $(APP_NAME):local bash

tag:  ## Re-tag image for publishing
	docker tag $(APP_NAME):local $(APP_NAME):$(TAG)

push:  ## push specific tag
	docker push $(APP_NAME):$(TAG)

testenv:  # run with local test env
	docker run -it -e RUNNER_LABELS="tester" --env-file .env $(APP_NAME):local
