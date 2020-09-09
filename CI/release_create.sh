#!/usr/bin/env bash

set -e
set -x

VERSION=$1
BRANCH=$2
NAME=$3
BODY=$4
PRERELEASE=$5

generate_post_data()
{
  cat <<EOF
{
    "tag_name": "$VERSION",
    "target_commitish": "$BRANCH",
    "name": "$NAME",
    "body": "$BODY",
    "prerelease": $PRERELEASE
}
EOF
}

RESPONSE=$(
    curl \
        -H "Accept: application/vnd.github.v3+json" \
        -H "Authorization: token $API_TOKEN" \
        https://api.github.com/repos/$OWNER/$REPO/releases \
        -d "$(generate_post_data)"
  )

echo $RESPONSE