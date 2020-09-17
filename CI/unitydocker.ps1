
$UNITY_VERSION = $args[0]
$PROJECT_PATH = $args[1]
# $UNITY_USERNAME = $args[2]
# $UNITY_PASSWORD = $args[3]
# $TEST_PLATFORM = $args[4]

docker run -it --rm -e "WORKDIR=/root/project" -v "${PROJECT_PATH}:/root/project" gableroux/unity3d:$UNITY_VERSION