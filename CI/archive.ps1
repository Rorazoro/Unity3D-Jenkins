$PROJECT_PATH = $args[0]
$ARTIFACTS = $args[1]

Write-Output "Archiving Builds"

if (!(Test-Path "$ARTIFACTS")) {
    New-Item -Path "$ARTIFACTS" -ItemType "directory"
}

$BUILDS = Get-ChildItem -Path "$PROJECT_PATH/Builds" -Directory

foreach ($d in $BUILDS) {
    Compress-Archive -Path $d.FullName -DestinationPath "$ARTIFACTS/$($d.Name).zip" -Force
}