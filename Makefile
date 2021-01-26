# Defaults
IMAGE_NAME ?= git-sync
PROJECT ?= tulibraries
REPO_NAME ?= $(PROJECT)/$(IMAGE_NAME)
GIT_MIRROR_URL ?= https://github.com/$(PROJECT)/$(REPO_NAME)
GIT_SOURCE_URL ?= https://git.temple.edu/$(PROJECT)/$(REPO_NAME)
VERSION ?= 0.3.0
HARBOR ?= harbor.k8s.temple.edu
DOCKERHUB ?= $(HARBOR)/$(PROJECT)
CI ?= false

build:
	@docker  build  \
		--tag $(DOCKERHUB)/$(IMAGE_NAME):latest \
		--tag $(DOCKERHUB)/$(IMAGE_NAME):$(VERSION) \
		--tag $(IMAGE_NAME):latest \
		--tag $(IMAGE_NAME):$(VERSION) \
		--no-cache .

run:
	@docker run\
		--env GIT_SOURCE_URL=$(GIT_SOURCE_URL) \
		--env GIT_MIRROR_URL=$(GIT_MIRROR_URL) \
		$(IMAGE_NAME)

lint:
	@if [ $(CI) == false ]; \
		then \
			hadolint ./Dockerfile; \
		fi

scan:
	@if [ $(CI) == false ]; \
		then \
			trivy $(DOCKERHUB)/$(IMAGE_NAME):$(VERSION); \
		fi

shell:
	@docker run\
		--env GIT_SOURCE_URL=$(GIT_SOURCE_URL) \
		--env GIT_MIRROR_URL=$(GIT_MIRROR_URL) \
		--rm -it \
		--user=root \
		--entrypoint=sh \
		$(IMAGE_NAME)

deploy: scan
	@docker push $(DOCKERHUB)/$(IMAGE_NAME):$(VERSION) \
	# This "if" statement needs to be a one liner or it will fail.
	# Do not edit indentation
	@if [ $(VERSION) != latest ]; \
		then \
			docker push $(DOCKERHUB)/$(IMAGE_NAME):latest; \
		fi
