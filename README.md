Git-Sync
===

Dockerfile to generate image that can be used for syching one repo to another.


For now this is a one way sync from $GIT_SOURCE_URL to $GIT_MIRROR_URL so it's very basic.


## Use
### Dependencies
* For scanning run `brew install trivy`
* For linting docker files `brew install hadolint`


### Local
```
make build
make run GIT_SOURCE_URL=$GIT_SOURCE_URL GIT_MIRROR_URL=$GIT_MIRROR_URL
```

* To run security scan `make scan`
* To lint the Dockerfile `make lint`
