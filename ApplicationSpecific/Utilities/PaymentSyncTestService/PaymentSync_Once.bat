@echo off
echo Started Batch Execution ...
set TestServicePath= "C:\automation\TestingService\TestService\Once"
set SilkPath= "C:\Program Files\Silk\SilkTest\partner.exe"
set OptionSetPath= "C:\automation\ApplicationSpecific\Includes\quickendesktopoptionset.opt"
set ProjectPath= "C:\automation\FrameworkSpecific\STFTFramework\STFTFramework.vtp"
set PaymentSyncUtilityPath= "C:\automation\ApplicationSpecific\Scripts\PaymentSync.t"


if %ERRORLEVEL% NEQ 0 goto Last   

for /f "tokens=* delims= " %%a in ('dir %TestServicePath% /b/ad') do IF EXIST %TestServicePath%\%%a\PaymentSyncMFCU.xls %SilkPath% -q -opt %OptionSetPath% -proj %ProjectPath% -r %PaymentSyncUtilityPath% %%a

:Last
echo ...Finished Batch Execution, Errors - %ERRORLEVEL%