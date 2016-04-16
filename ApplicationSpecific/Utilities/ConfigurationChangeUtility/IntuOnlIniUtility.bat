set SilkPath= "C:\Program Files\Silk\SilkTest\partner.exe"
set OptionSetPath= "D:\Quicken\ApplicationSpecific\Includes\quickendesktopoptionset.opt"
set ProjectPath= "D:\Quicken\FrameworkSpecific\STFTFramework\STFTFramework.vtp"
set QuickenInI_ConfigurationUtilityPath= "D:\Quicken\ApplicationSpecific\Scripts\INTU_ONL_InI_ConfigurationUtility.t"

%SilkPath% -q -opt %OptionSetPath% -proj %ProjectPath% -r %QuickenInI_ConfigurationUtilityPath%