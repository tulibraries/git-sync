# Defaults
IMAGE_NAME ?= git-sync
REPO_NAME ?= tulibraies/$(IMAGE_NAME)
GIT_MIRROR_URL ?= https://github.com/tulibraries/$(REPO_NAME)
GIT_SOURCE_URL ?= https://git.temple.edu/tulibraries/$(REPO_NAME)
VERSION ?= 0.1.3
DOCKERHUB ?= harbor.k8s.temple.edu/tulibraries
CI ?= foo

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

secure:
	trivy $(DOCKERHUB)/$(IMAGE_NAME):$(VERSION)

shell:
	@docker run\
		--env GIT_SOURCE_URL=$(GIT_SOURCE_URL) \
		--env GIT_MIRROR_URL=$(GIT_MIRROR_URL) \
		--rm -it \
		--user=root \
		--entrypoint=sh \
		$(IMAGE_NAME)

deploy: secure
	@docker push $(DOCKERHUB)/$(IMAGE_NAME):$(VERSION) \
	# This "if" statement needs to be a one liner or it will fail.
	# Do not edit indentation
	@if [ $(VERSION) != latest ]; then \
		docker push $(DOCKERHUB)/$(IMAGE_NAME):latest; \
		fi
