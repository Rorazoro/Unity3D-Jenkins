set -e
set -x

export PROJECT_PATH=/mnt/e/My Code/PersonalProjects/Unity/Unity3D-Jenkins
export ARTIFACTS=$PROJECT_PATH/_artifacts

bash ./CI/archive.sh