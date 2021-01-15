build:
	--tag harbor.k8s.temple.edu/tulibraries/git-sync:$(VERSION) \
	@docker  build  --tag git-sync .

# Defaults
GIT_MIRROR_URL ?= https://github.com/tulibraries/Press-6
GIT_SOURCE_URL ?= https://git.temple.edu/tulibraries/Press-6
VERSION ?= latest

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
	docker push 
