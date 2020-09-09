#!/usr/bin/env bash

set -e
set -x

RELEASE_ID=$1
FILE_PATH=$2
ASSET_NAME=${FILE_PATH##*/}

RESPONSE=$(
    curl \
        -H "Content-Type: application/zip" \
        -H "Accept: application/vnd.github.v3+json" \
        -H "Authorization: token $API_TOKEN" \
        https://uploads.github.com/repos/$OWNER/$REPO/releases/$RELEASE_ID/assets?name=$ASSET_NAME \
        --data-binary @$FILE_PATH
  )

echo $RESPONSE