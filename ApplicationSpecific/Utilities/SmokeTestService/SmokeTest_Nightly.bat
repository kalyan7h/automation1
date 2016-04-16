@echo off
echo Started Batch Execution ...
set TestServiceNightlyPath= "D:\Quicken\TestingService\TestService\Nightly"
set SilkPath= "C:\Program Files\Silk\SilkTest\partner.exe"
set OptionSetPath= "D:\Quicken\ApplicationSpecific\Includes\quickendesktopoptionset.opt"
set ProjectPath= "D:\Quicken\FrameworkSpecific\STFTFramework\STFTFramework.vtp"
set SmokeUtilityPath= "D:\Quicken\ApplicationSpecific\Scripts\SmokeTest.t"

set TestServiceSource= "\\ps7088\TestingService"
set TestServiceDestination= "D:\Quicken\TestingService"

echo Test Service Source Location is - %TestServiceSource%
echo Destination is - %TestServiceDestination%

IF EXIST %TestServiceDestination% rmdir %TestServiceDestination% /s/q

XCOPY %TestServiceSource% %TestServiceDestination% /E/K/Y/I

if %ERRORLEVEL% NEQ 0 goto Last   

for /f "tokens=* delims= " %%a in ('dir %TestServiceNightlyPath% /b/ad') do IF EXIST %TestServiceNightlyPath%\%%a\SmokeTestData.xls %SilkPath% -q -opt %OptionSetPath% -proj %ProjectPath% -r %SmokeUtilityPath% %%a

:Last
echo ...Finished Batch Execution, Errors - %ERRORLEVEL%