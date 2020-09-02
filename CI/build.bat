echo Building for %BUILD_TARGET%

set BUILD_PATH=%PROJECT_PATH%/Builds/%BUILD_TARGET%/

"%UNITY_EXECUTABLE%" ^
-projectPath "%PROJECT_PATH%" ^
-quit ^
-batchmode ^
-buildTarget %BUILD_TARGET% ^
-customBuildTarget %BUILD_TARGET% ^
-customBuildName %BUILD_NAME% ^
-customBuildPath "%BUILD_PATH%" ^
-executeMethod BuildCommand.PerformBuild ^
-logFile dev/stdout

set UNITY_EXIT_CODE=%ERRORLEVEL%

if %UNITY_EXIT_CODE%==0 echo "Run succeeded, no failures occurred"
if %UNITY_EXIT_CODE%==2 echo "Run succeeded, some tests failed"
if %UNITY_EXIT_CODE%==3 echo "Run failure (other failure)"

exit %UNITY_EXIT_CODE%