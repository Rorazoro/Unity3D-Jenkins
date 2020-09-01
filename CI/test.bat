@echo off
echo "Testing for "%TEST_PLATFORM%
"%UNITY_PATH%" ^
-logFile ^
-batchmode ^
-nographics ^
-projectPath "%WORKSPACE%" ^
-runTests ^
-testPlatform %TEST_PLATFORM% ^
-testResults "%TEST_RESULTS%\%TEST_PLATFORM%-results.xml" ^
REM -enableCodeCoverage ^
REM -coverageResultsPath "%WORKSPACE%/%TEST_PLATFORM%-coverage" ^
REM -coverageOptions "generateAdditionalMetrics;generateHtmlReport;generateHtmlReportHistory;generateBadgeReport;assemblyFilters:+Assembly-CSharp" ^
-debugCodeOptimization
set UNITY_EXIT_CODE=%ERRORLEVEL%

if %UNITY_EXIT_CODE%==0 echo "Run succeeded, no failures occurred"
if %UNITY_EXIT_CODE%==2 echo "Run succeeded, some tests failed"
if %UNITY_EXIT_CODE%==3 echo "Run failure (other failure)"

exit %UNITY_EXIT_CODE%