[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<QuickenConfig.INC>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This configuration file is used for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	None
	[ ] //
	[ ] // DEVELOPED BY:	Chandan Abhyankar
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 06/Dec/10 Chandan Abhyankar	Created
	[ ] 
[ ] // *********************************************************
[ ] // Machine related information on which Quicken Automation is executed
[ ] public const STRING OPERATING_SYSTEM = SYS_GetName ( )
[ ] public const STRING COMPUTER_NAME = SYS_GetEnv ( "COMPUTERNAME")
[ ] public const STRING PROGRAMFILES = SYS_GetEnv ( "PROGRAMFILES")
[ ] public const STRING USERNAME = SYS_GetEnv ("USERNAME")
[ ] public const STRING ALLUSERSPROFILE = SYS_GetEnv ("ALLUSERSPROFILE")
[ ] public const STRING USERPROFILE = SYS_GetEnv ("USERPROFILE")
[ ] public STRING OS_BIT = SYS_GetEnv("PROCCESSOR_IDENTIFIER")	// Get the info. about OS bit i.e. 32 or 64 bit
[ ] public STRING LOCAL_LOG ="C:\Documents and Settings\{USERNAME}\Application Data\Intuit\Quicken\Log"
[ ] public STRING LOCAL_QUICKEN ="C:\Documents and Settings\{USERNAME}\Application Data\Intuit\Quicken"
[ ] // This indicates root directory for Automation
[ ] public const STRING	AUTOMATION_ROOT	= ROOT_PATH
[ ] 
[ ] // This indicates root directory where Quicken Desktop is installed
[ ] public const STRING	QUICKEN_ROOT	= PROGRAMFILES+"\Quicken"		
[ ] 
[ ] public const STRING sCmdLine ="{QUICKEN_ROOT}\qw.exe"
[ ] 
[ ] public const STRING	WINDOWS = "C:\Windows"
[ ] //Commented by Mukesh suggested by Udita  - Date 08/10/2012
[ ] //public const STRING  QUICKEN_CONFIG = ALLUSERSPROFILE+"\Intuit\Quicken\Config"
[ ] public const STRING  QUICKEN_CONFIG = SYS_GetEnv ("QuickenIniPath")
[ ] 
[ ] 
[ ] // The directory where automation Quicken QDF, XLS data files are stored
[ ] public const STRING AUT_DATAFILE_PATH = ROOT_PATH + "\ApplicationSpecific\Data\TestData"
[ ] public const STRING XLS_DATAFILE_PATH = AUT_DATAFILE_PATH +  "\DataDrivenXLS"
[ ] public const STRING XLS_REPORT_PATH= ROOT_PATH + "\ApplicationSpecific\Results"
[ ] 
[ ] 
[ ] // The Quicken Country
[ ] public const STRING QUICKEN_COUNTRY = "USA"
[ ] 
[ ] 
[ ] // This indicates the SKU to be tested by Automation
[ ] public STRING SKU_TOBE_TESTED 
[ ] 
[ ] // This indicates the year information for Quicken e.g. for QW2012 its 2012. QW2013 its 2013 so on
[ ] public const STRING QUICKEN_YEAR_INFO = "2016"
[ ] 
[ ] // File Selection for Performance testdata  file
[ ] public const STRING PerformanceDataFile = "LARGE_DATA_FILE"
[ ] //public const STRING PerformanceDataFile = "BASIC_DATA_FILE"
[ ] 
[ ] //Data sync Sign- In password
[ ] public const STRING sPassword ="a123456b"
[ ] 
