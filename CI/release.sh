#!/usr/bin/env bash

set -e
set -x

OWNER=rorazoro
REPO=Unity3D-Jenkins
VERSION=v0.1.0
BRANCH=master
NAME="Test Name"
BODY="Test Message"
PRERELEASE=true

#Create new release
API_JSON=$(
    printf ''
)

generate_post_data()
{
  cat <<EOF
{
    "tag_name": "$VERSION",
    "target_commitish": "$BRANCH",
    "name": $NAME,
    "body": $BODY,
    "prerelease": $PRERELEASE
}
EOF
}

curl -v -i\
  -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/$OWNER/$REPO/releases \
  -d "$(generate_post_data)"
