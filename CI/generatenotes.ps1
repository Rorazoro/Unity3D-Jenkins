$ARTIFACTS = $args[0]

# fetch tags, to be sure we have all the require info
git fetch --tags

# collect the commits since the last tag
$GIT_TAG = git describe --tags --abbrev=0
# Write-Output $GIT_TAG

$GIT_RELEASE_NOTES = git log "$GIT_TAG..HEAD" --pretty=format:"%h %s"
Write-Output $GIT_RELEASE_NOTES  > "$ARTIFACTS\commitlog.txt"