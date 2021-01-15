# Defaults
IMAGE_NAME ?= git-sync
REPO_NAME ?= tulibraies/$(IMAGE_NAME)
GIT_MIRROR_URL ?= https://github.com/tulibraries/$(REPO_NAME)
GIT_SOURCE_URL ?= https://git.temple.edu/tulibraries/$(REPO_NAME)
VERSION ?= latest
DOCKERHUB ?= harbor.k8s.temple.edu/tulibraries

build:
	@docker  build  \
		--tag $(DOCKERHUB)/$(IMAGE_NAME):$(VERSION) \
		--tag $(IMAGE_NAME):$(VERSION) \
		--no-cache .

run:
	@docker run\
		--env GIT_SOURCE_URL=$(GIT_SOURCE_URL) \
		--env GIT_MIRROR_URL=$(GIT_MIRROR_URL) \
		git-sync

shell:
	@docker run\
		--env GIT_SOURCE_URL=$(GIT_SOURCE_URL) \
		--env GIT_MIRROR_URL=$(GIT_MIRROR_URL) \
		--rm -it \
		--user=root \
		--entrypoint=sh \
		git-sync

deploy:
	docker push $(DOCKERHUB)/$(IMAGE_NAME):$(VERSION)
