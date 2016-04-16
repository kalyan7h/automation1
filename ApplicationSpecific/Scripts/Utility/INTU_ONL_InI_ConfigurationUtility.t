[+] // FILE NAME:	<INTU_ONL_InI_ConfigurationUtility.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This Utility update Intu_ONL initialization (.ini) file as per the data provided through .xls file under windows directory
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //
	[ ] // Developed on: 		8/4/2011
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 April 8, 2011	Udita Dube  Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[-] // Global variables used for Smoke Test cases
	[ ] public LIST OF ANYTYPE  lsExcelData
	[ ] INTEGER i,iCount
	[ ] public LIST OF STRING lsTestData
	[ ] public STRING sConfFile = "IntuONLInI.xls"
	[ ] public STRING sConfWorksheet = "Intu_ONL.ini"
[ ] 
[ ] 
[+] //############# INTU_ONL.ini Configuration Change Utility #################################
	[ ] // ********************************************************
	[+] // TestCase Name:IntuONLInIConfigurationUtility()
		[ ] //
		[ ] // Description: 				
		[ ] // This Utility update Intu_ONL initialization (.ini) file as per the data provided through .xls file under windows directory
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if .ini file updated successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 8/4/2011  Created By	Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[-] testcase IntuONLInIConfigurationUtility () appstate none
	[ ] 
	[-] // Variable declaration
		[ ] STRING sConf_FilePath, sValue, sBlock, sKey,sInISource
		[ ] HINIFILE hIni
		[ ] sConf_FilePath = sDestinationonliniFile
		[ ] sInISource= AUT_DATAFILE_PATH + "\InI_File\" + sConfWorksheet
	[ ] 
	[-] if(!SYS_FileExists(sConf_FilePath))
		[ ] CopyFile(sInISource,sConf_FilePath)
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
				[-] else
					[ ] sValue = ""
				[ ] 
				[ ] // Open File
				[ ] hIni = SYS_IniFileOpen (sConf_FilePath)
				[ ] // Set Values for keys
				[ ] SYS_IniFileSetValue (hIni, sBlock , sKey, sValue)
				[ ] // Close File
				[ ] SYS_IniFileClose (hIni)
			[-] else
				[ ] ReportStatus("Validate {sConfWorksheet} file exists",FAIL,"File - {sConfWorksheet} not found")
				[ ] 
			[ ] 
			[ ] 
		[-] except
			[ ] ExceptLog()
			[ ] continue
		[ ] 
		[ ] 
	[ ] 
[ ] //################################################################################
[ ] 
[ ] 
