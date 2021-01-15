Git-Sync
===

Dockerfile to generate image that can be used for syching one repo to another.


For now this is a one way sync from $GIT_SOURCE_URL to $GIT_MIRROR_URL so it's very basic.


## Use

### Local
```
make build
make run GIT_SOURCE_URL=$GIT_SOURCE_URL GIT_MIRROR_URL=$GIT_MIRROR_URL
```
