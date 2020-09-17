
docker run -e $BUILD_NAME -e $UNITY_LICENSE_CONTENT -e $BUILD_TARGET -w /project/ -v $(pwd):/project/ $IMAGE_NAME /bin/bash -c "/project/ci/before_script.sh && /project/ci/build.sh"