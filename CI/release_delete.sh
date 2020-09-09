#!/usr/bin/env bash

set -e
set -x

RELEASE_ID=$1

RESPONSE=$(
    curl \
        -X DELETE \
        -H "Accept: application/vnd.github.v3+json" \
        -H "Authorization: token $API_TOKEN" \
        https://api.github.com/repos/$OWNER/$REPO/releases/$RELEASE_ID
  )

echo $RESPONSE