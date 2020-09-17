# $BUILD_NAME = 'TestBuild'
# $UNITY_LICENSE_CONTENT = ""
# $BUILD_TARGET = 'StandaloneWindows64'
# $IMAGE_NAME = 'gableroux/unity3d:2020.1.5f1'

docker run -e "BUILD_NAME" -e "UNITY_LICENSE_CONTENT" -e "BUILD_TARGET" -w /project/ -v "${pwd}:/project/" $IMAGE_NAME /bin/bash -c "/project/ci/before_script.sh && /project/ci/build.sh"