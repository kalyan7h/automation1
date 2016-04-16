set SilkPath= "C:\Program Files\Silk\SilkTest\partner.exe"
set OptionSetPath= "D:\Quicken\ApplicationSpecific\Includes\quickendesktopoptionset.opt"
set ProjectPath= "D:\Quicken\FrameworkSpecific\STFTFramework\STFTFramework.vtp"
set AddBusinessAccountUtilityPath= "D:\Quicken\ApplicationSpecific\Scripts\AddBusinessAccount.t"

%SilkPath% -q -opt %OptionSetPath% -proj %ProjectPath% -r %AddBusinessAccountUtilityPath%