$UNITY_EXECUTABLE = $args[0]
$PROJECT_PATH = $args[1]
$BUILD_TARGET = $args[2]
$BUILD_NAME = $args[3]

Write-Output "Building for $BUILD_TARGET"

$BUILD_PATH = "$PROJECT_PATH/Builds/$BUILD_TARGET/"

Start-Process -FilePath $UNITY_EXECUTABLE -ArgumentList @"
    -projectPath "$PROJECT_PATH"
    -quit
    -batchmode
    -buildTarget $BUILD_TARGET
    -customBuildTarget $BUILD_TARGET
    -customBuildName $BUILD_NAME
    -customBuildPath "$BUILD_PATH"
    -executeMethod BuildCommand.PerformBuild
    -logFile buildlog.log
"@

# Wait for Editor.log to be created.
while (!(Test-Path "${BUILD_TARGET}_buildlog.log")) {
    Start-Sleep -m 10
}

# Output Editor.log until Unity is done.
Get-Content -Path "${BUILD_TARGET}_buildlog.log" -Tail 1 -Wait | Where-Object {
    Write-Host $_

    if ($_ -match "Application will terminate with return code") {
        exit
    }
}