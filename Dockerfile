FROM  harbor.k8s.temple.edu/library/alpine:3.12

USER root

RUN apk add git

COPY git-sync.sh  /bin/git-sync

USER nobody

CMD ["git-sync"]
