set -e
set -x

echo "Archiving Builds"

mkdir -p "$ARTIFACTS"
cd Builds

for i in */; do zip -r "${i%/}.zip" "$i"; mv "${i%/}.zip" "$ARTIFACTS"; done

cd ..