[+] // FILE NAME:	<QuickenInI_ConfigurationUtility.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This Utility update Quicken initialization (.ini) file as per the data provided through .xls file
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //
	[ ] // Developed on: 		4/4/2011
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 April 4, 2011	Udita Dube  Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] // Global variables used for Smoke Test cases
	[ ] public LIST OF ANYTYPE  lsExcelData
	[ ] INTEGER i,iCount
	[ ] public LIST OF STRING lsTestData
	[ ] public STRING sConfFile = "QuickenInI.xls"
	[ ] public STRING sConfWorksheet = "Quicken.ini"
[ ] 
[ ] 
[+] //############# Quicken.ini Configuration Change Utility ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:QuickenInIConfigurationUtility()
		[ ] //
		[ ] // Description: 				
		[ ] // This Utility update Quicken initialization (.ini) file as per the data provided through .xls file
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 4/4/2011  Created By	Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[-] testcase QuickenInIConfigurationUtility () appstate none
	[ ] 
	[-] // Variable declaration
		[ ] STRING sConf_FilePath, sValue, sBlock, sKey
		[ ] HINIFILE hIni
		[ ] sConf_FilePath = QUICKEN_CONFIG + "\" + sConfWorksheet
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sConfFile, sConfWorksheet)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[-] for(i=1;i<=iCount;i++)
		[ ] 
		[ ] lsTestData=lsExcelData[i]
		[ ] 
		[-] do
			[ ] 
			[-] if (FileExists(sConf_FilePath))
				[ ] sBlock=lsTestData[1]
				[ ] sKey=lsTestData[2]
				[-] if(lsTestData[3]!= NULL)
					[ ] sValue=lsTestData[3]
				[ ] 
				[ ] // Open File
				[ ] hIni = SYS_IniFileOpen (sConf_FilePath)
				[ ] // Set Values for keys
				[ ] SYS_IniFileSetValue (hIni, sBlock , sKey, sValue)
				[ ] // Close File
				[ ] SYS_IniFileClose (hIni)
			[+] else
				[ ] ReportStatus("Validate {sConfWorksheet} file exists",FAIL,"File - {sConfWorksheet} not found")
				[ ] 
			[ ] 
			[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] continue
		[ ] 
		[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
