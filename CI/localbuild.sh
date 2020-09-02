set -e
set -x

export UNITY_EXECUTABLE="/mnt/d/Program Files/Unity Editors/2020.1.4f1/Editor/Unity.exe"
export PROJECT_PATH="/mnt/e/My Code/PersonalProjects/Unity/Unity3D-Jenkins"
export BUILD_NAME="Unity3D-Jenkins"

export BUILD_TARGET="StandaloneWindows64"
bash build.sh

export BUILD_TARGET="StandaloneLinux64"
bash build.sh

export BUILD_TARGET="WebGL"
bash build.sh