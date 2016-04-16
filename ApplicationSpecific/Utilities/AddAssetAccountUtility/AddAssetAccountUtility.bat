set SilkPath= "C:\Program Files\Silk\SilkTest\partner.exe"
set OptionSetPath= "D:\Quicken\ApplicationSpecific\Includes\quickendesktopoptionset.opt"
set ProjectPath= "D:\Quicken\FrameworkSpecific\STFTFramework\STFTFramework.vtp"
set AddAssetAccountUtilityPath= "D:\Quicken\ApplicationSpecific\Scripts\AddAssetAccount.t"

%SilkPath% -q -opt %OptionSetPath% -proj %ProjectPath% -r %AddAssetAccountUtilityPath%