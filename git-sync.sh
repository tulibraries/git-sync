#!/bin/sh

set -ue

pull_origin() {
  if [ ! -d /tmp/origin ];
  then
    git clone $GIT_SOURCE_URL /tmp/origin
    cd /tmp/origin

    git remote add mirror $GIT_MIRROR_URL
    push_mirror
  fi

  cd /tmp/origin
  git pull origin --ff-only
}

push_mirror() {
  cd /tmp/origin
  git push mirror -f
}

while true
do
  PULL=$(pull_origin)

  if [ "$PULL" != "Already up to date." ];
  then
    push_mirror
    echo $PULL
  fi

  sleep "${SLEEP_INTERVAL:=1}"
done
