$BUILD_NAME = $args[0]
$UNITY_LICENSE_CONTENT = $args[1]
$BUILD_TARGET = $args[2]
$IMAGE_NAME = $args[3]

docker run -e "BUILD_NAME=${BUILD_NAME}" -e "UNITY_LICENSE_CONTENT=${UNITY_LICENSE_CONTENT}" -e "BUILD_TARGET=${BUILD_TARGET}" -w /project/ -v "${pwd}:/project/" $IMAGE_NAME /bin/bash -c "/project/ci/before_script.sh && /project/ci/build.sh"