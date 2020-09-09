#!/usr/bin/env bash
set -ex

# fetch tags, to be sure we have all the require info
git fetch --tags

# collect the commits since the last tag
export GIT_RELEASE_NOTES="$(git log $(git describe --tags --abbrev=0)..HEAD --pretty=format:"%h %s")"

echo $GIT_RELEASE_NOTES > "commitlog.txt"