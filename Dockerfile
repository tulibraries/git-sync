FROM  harbor.k8s.temple.edu/library/alpine:3.12

USER root

RUN apk -U add git; \
  apk upgrade libcrypto.so.1.1 libssl.so.1.1

COPY git-sync.sh  /bin/git-sync

USER nobody

CMD ["git-sync"]
