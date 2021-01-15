#!/bin/sh

set -ue

pull_origin() {
  if [ ! -d /tmp/origin ];
  then
    git clone $GIT_SOURCE_URL /tmp/origin
    cd /tmp/origin

    git remote add mirror $GIT_MIRROR_URL
  fi

  cd /tmp/origin
  git pull origin
}

push_mirror() {
  cd /tmp/origin
  git push mirror
}

while true
do
  PULL=$(pull_origin)

  if [ "$PULL" != "Already up to date." ];
  then
    push_mirror
  else
    echo $PULL
  fi

  sleep "${SLEEP_INTERVAL:=1}"
done
