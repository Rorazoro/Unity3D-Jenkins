$ARTIFACTS = $args[0]

# fetch tags, to be sure we have all the require info
git fetch --tags

# collect the commits since the last tag
if (git tag -l) {
    $GIT_TAG = git describe --tags --abbrev=0
    $GIT_RELEASE_NOTES = git log "$GIT_TAG..HEAD" --pretty=format:"%h %s"
}
else {
    $GIT_RELEASE_NOTES = git log --pretty=format:"%h %s"
}

Out-File -FilePath "$ARTIFACTS\commitlog.txt" -InputObject $GIT_RELEASE_NOTES -Encoding utf8