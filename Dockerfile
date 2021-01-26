FROM  harbor.k8s.temple.edu/library/alpine:3.13

USER root

RUN apk --no-cache -U add git=2.30.0-r0

COPY git-sync.sh  /bin/git-sync

USER nobody

CMD ["git-sync"]
