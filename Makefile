# Defaults
IMAGE_NAME ?= git-sync
REPO_NAME ?= tulibraies/$(IMAGE_NAME)
GIT_MIRROR_URL ?= https://github.com/tulibraries/$(REPO_NAME)
GIT_SOURCE_URL ?= https://git.temple.edu/tulibraries/$(REPO_NAME)
VERSION ?= 0.1.2
DOCKERHUB ?= harbor.k8s.temple.edu/tulibraries

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

security:
	trivy $(DOCKERHUB)/$(IMAGE_NAME):$(VERSION)

shell:
	@docker run\
		--env GIT_SOURCE_URL=$(GIT_SOURCE_URL) \
		--env GIT_MIRROR_URL=$(GIT_MIRROR_URL) \
		--rm -it \
		--user=root \
		--entrypoint=sh \
		$(IMAGE_NAME)

deploy: security
	docker push $(DOCKERHUB)/$(IMAGE_NAME) --all-tags
