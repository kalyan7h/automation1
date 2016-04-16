
@echo off
echo Started Batch Execution ...
set TestServiceNightlyPath= "D:\Quicken\TestingService\TestService\Nightly"
set SilkPath= "C:\Program Files\Silk\SilkTest\partner.exe"
set OptionSetPath= "D:\Quicken\ApplicationSpecific\Includes\quickendesktopoptionset.opt"
set ProjectPath= "D:\Quicken\FrameworkSpecific\STFTFramework\STFTFramework.vtp"
set UtilityPath= "D:\Quicken\ApplicationSpecific\Scripts\Registration.t"

set TestServiceSource= "\\mtvfs04\QPFG\Public\Registration\TestingService"
set TestServiceDestination= "D:\Quicken\TestingService"

echo Test Service Source Location is - %TestServiceSource%
echo Destination is - %TestServiceDestination%

IF EXIST %TestServiceDestination% rmdir %TestServiceDestination% /s/q

XCOPY %TestServiceSource% %TestServiceDestination% /E/K/Y/I

if %ERRORLEVEL% NEQ 0 goto Last   

for /f "tokens=* delims= " %%a in ('dir %TestServiceNightlyPath% /b/ad') do IF EXIST %TestServiceNightlyPath%\%%a\Registration.xls %SilkPath% -q -opt %OptionSetPath% -proj %ProjectPath% -r %UtilityPath% %%a 

:Last
echo ...Finished Batch Execution, Errors - %ERRORLEVEL%