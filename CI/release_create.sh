#!/usr/bin/env bash

set -e
set -x

VERSION=$1
BRANCH=$2
NAME="Test Name"
BODY="Test Message"
PRERELEASE=$3

generate_post_data()
{
  cat <<EOF
{
    "tag_name": "$VERSION",
    "target_commitish": "$BRANCH",
    "name": "$VERSION",
    "body": "",
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