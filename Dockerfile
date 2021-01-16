FROM  harbor.k8s.temple.edu/library/alpine:3.12

USER root

RUN apk -U add git openssl

COPY git-sync.sh  /bin/git-sync

USER nobody

CMD ["git-sync"]
