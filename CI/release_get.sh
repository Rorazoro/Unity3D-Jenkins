#!/usr/bin/env bash

set -e
set -x

VERSION=$1

RESPONSE=$(
    curl \
        -H "Accept: application/vnd.github.v3+json" \
        -H "Authorization: token $API_TOKEN" \
        https://api.github.com/repos/$OWNER/$REPO/releases/tags/$VERSION
  )

echo $RESPONSE