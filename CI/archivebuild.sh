set -e
set -x

echo "Building for $BUILD_TARGET"

export ARTIFACTS=_artifacts/

cd ..
mkdir -p $ARTIFACTS
cd Builds
for i in */; do zip -r "${i%/}.zip" "$i"; mv "${i%/}.zip" ../$ARTIFACTS; done