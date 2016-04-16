[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	QuickenSKUOSLayer.inc
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This file contains the functions which handles the following dependencies.
	[ ] // OS specific dependencies (i.e. XP, Vista and Windows 7)
	[ ] // SKU specific dependencies (i.e. RPM, HAB, Premier, Deluxe etc)
	[ ] // Goal is to run any Test case on any OS and SKU combination
	[ ] //
	[ ] // DEPENDENCIES:	Includes.inc
	[ ] //
	[ ] // DEVELOPED BY:	Chandan Abhyankar
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 04/Jan/11	Chandan Abhyankar	Created
	[ ] //	 02/Feb/11	Chandan Abhyankar	Modified
[ ] // *********************************************************
[ ] 
[ ] // *********************************************************
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: LoadOSDependency()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will load Operating System specific paths. This is used to run automation on XP/Vista and Windows 7 O/S.
	[ ] //
	[ ] // PARAMETERS:		None		
	[ ] //
	[ ] // RETURNS:			INTEGER		PASS		If operation is passed
	[ ] //										FAIL		If operation is failed
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 22, 2010	Mamta Jain created
[ ] // ==========================================================
[-] public INTEGER LoadOSDependency()
	[-] do
		[ ] INTEGER iFunctionResult
		[ ] //STRING sAllUserQuickenDirPath, sQuickenIniPath, sInstallerDirPath, sIntuitDirPath
		[ ] 
		[-] if (OPERATING_SYSTEM == "Windows 7" || OPERATING_SYSTEM == "Windows Vista" || OPERATING_SYSTEM == "Windows 8" || OPERATING_SYSTEM == "Windows NT (unknown)")
			[ ] SYS_SetEnv ("AllUserQuickenDirPath",ALLUSERSPROFILE + "\Intuit\Quicken")
			[ ] SYS_SetEnv ("QuickenIniPath", ALLUSERSPROFILE + "\Intuit\Quicken\Config\Quicken.ini")
			[ ] SYS_SetEnv ("InstallerDirPath", ALLUSERSPROFILE + "\Intuit\Quicken\Log\installer")
			[ ] SYS_SetEnv ("IntuitDirPath", USERPROFILE + "\Intuit")
			[ ] SYS_SetEnv ("Desktop" , "C:\Users\Public\Desktop")
			[ ] iFunctionResult = PASS
			[ ] 
		[-] if (OPERATING_SYSTEM == "Windows XP")
			[ ] SYS_SetEnv ("AllUserQuickenDirPath", ALLUSERSPROFILE + "\Application Data\Intuit\Quicken")
			[ ] SYS_SetEnv ("QuickenIniPath", ALLUSERSPROFILE + "\Application Data\Intuit\Quicken\Config\Quicken.ini")
			[ ] SYS_SetEnv ("InstallerDirPath", ALLUSERSPROFILE + "\Application Data\Intuit\Quicken\Log\installer")
			[ ] SYS_SetEnv ("IntuitDirPath", USERPROFILE + "\Application Data\Intuit")
			[ ] SYS_SetEnv ("Desktop" , ALLUSERSPROFILE + "\Desktop")
			[ ] iFunctionResult = PASS
	[+] except
		[ ] iFunctionResult = FAIL
	[ ] return iFunctionResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: LoadSKUDependency()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will load Quicken SKU specific values. This is used to run automation on different SKUs.
	[ ] //
	[ ] // PARAMETERS:		None		
	[ ] //
	[ ] // RETURNS:			STRING				PASS		If operation is passed, Returns current installed SKU name
	[ ] //										FAIL		If operation is failed
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 Feb 15, 2010	Mamta Jain created
	[ ] // 	Mar  31, 2011	Udita Dube Updated
	[ ] // 	Nov  19, 2013	Udita Dube Updated
[ ] // ==========================================================
[-] public STRING LoadSKUDependency()
	[ ] INTEGER iFunctionResult,i
	[ ] STRING sActual
	[ ] BOOLEAN bMatch
	[ ] LIST OF STRING lsSKUName,lsSKU
	[ ] HINIFILE hIni
	[ ] SKU_TOBE_TESTED = "RPM"
	[ ] LoadOSDependency()
	[ ] 
	[ ] lsSKUName={"Rental Property Manager", "Home & Business", "Premier", "Deluxe", "Starter Edition"}
	[ ] lsSKU={"RPM","HAB","PREMIER","DELUXE","QNUE"}
	[ ] 
	[-] do
		[ ] 
		[-] //// Remove the TSMs
			[ ] 
			[ ] DeleteDir(sTSMDir)
			[ ] // Open File
			[ ] sQuickenIniFile=SYS_GetEnv("QuickenIniPath") 
			[ ] 
			[ ] hIni = SYS_IniFileOpen (sQuickenIniFile)
			[ ] // Set Values for keys
			[ ] sActual = IniFileGetValue(hIni, "Quicken", "version")
			[ ] // Close File
			[ ] SYS_IniFileClose (hIni)
			[ ] 
			[-] for(i=1;i<=ListCount(lsSKU);i++)
				[ ] bMatch = MatchStr("*{lsSKUName[i]}*", sActual)
				[-] if(bMatch)
					[ ] SKU_TOBE_TESTED=lsSKU[i]
					[ ] break
			[ ] 
			[ ] 
			[-] if (SKU_TOBE_TESTED == "RPM")
				[ ] sExpectedAboutQuicken = "Quicken {QUICKEN_YEAR_INFO} Rental Property Manager"
				[ ] sQuickenAttributesWorksheet = "Quicken_Attributes_RPM"
				[ ] sNavigationData = "RPMNavigation"
				[ ] iFunctionResult = PASS
				[ ] 
			[ ] 
			[-] else if (SKU_TOBE_TESTED == "HAB")
				[ ] sExpectedAboutQuicken = "Quicken {QUICKEN_YEAR_INFO} Home & Business"
				[ ] sQuickenAttributesWorksheet = "Quicken_Attributes_Hab"
				[ ] sNavigationData = "HABNavigation"
				[ ] iFunctionResult = PASS
				[ ] 
			[ ] 
			[-] else if (SKU_TOBE_TESTED == "PREMIER")
				[ ] sExpectedAboutQuicken = "Quicken {QUICKEN_YEAR_INFO} Premier"
				[ ] sQuickenAttributesWorksheet = "Quicken_Attributes_Premier"
				[ ] sNavigationData = "PREMIERNavigation"
				[ ] iFunctionResult = PASS
			[ ] 
			[-] else if (SKU_TOBE_TESTED == "DELUXE")
				[ ] sExpectedAboutQuicken = "Quicken {QUICKEN_YEAR_INFO} Deluxe"
				[ ] sQuickenAttributesWorksheet = "Quicken_Attributes_Deluxe"
				[ ] sNavigationData = "DELUXENavigation"
				[ ] iFunctionResult = PASS
			[ ] 
			[-] else if (SKU_TOBE_TESTED == "QNUE")
				[ ] sExpectedAboutQuicken = "Quicken {QUICKEN_YEAR_INFO} Starter Edition"
				[ ] sQuickenAttributesWorksheet = "Quicken_Attributes_QNUE"
				[ ] sNavigationData = "QNUENavigation"
				[ ] iFunctionResult = PASS
		[-] // else
			[ ] // ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
		[ ] 
	[-] except
		[ ] SKU_TOBE_TESTED="Not Set"
		[ ] ExceptLog()
		[ ] iFunctionResult = FAIL
	[ ] return SKU_TOBE_TESTED
	[ ] 
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: LoadControlsDataXLSPath()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will load Controls Tab specific values defined in TestService.
	[ ] //
	[ ] // PARAMETERS:		None		
	[ ] //
	[ ] // RETURNS:			INTEGER		PASS		If operation is passed
	[ ] //										FAIL		If operation is failed
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	May 03, 2011	Chandan Abhyankar
	[ ] 
[ ] // ==========================================================
[+] public STRING LoadControlsDataXLSPath(STRING sExcelName)
	[ ] INTEGER i
	[ ] LIST OF ANYTYPE  lsControlsData,lsExcelData
	[ ] STRING sControlsWorksheet = "Controls"
	[ ] //STRING sRunControllerData = ROOT_PATH + "\" + "TestingService\TestService\Run_Controller\Controls.xls"
	[ ] LIST OF STRING lsArgs = GetArgs ()
	[ ] print("lsprint is {lsArgs}")
	[ ] ListPrint (lsArgs)
	[ ] 
	[ ] sXLSDataPath = "Not Found"
	[ ] 
	[-] if(ListCount(lsArgs))
		[-] do
			[ ] STRING sXLSDataPath = ROOT_PATH + "\" + "TestingService\TestService\Once\{lsArgs[1]}\{sExcelName}.xls"
			[ ] 
			[ ] // Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sXLSDataPath, sControlsWorksheet)
			[ ] 
			[ ] // Fetch 1st row from the given sheet
			[-] // for(i = 1; i<= ListCount(lsExcelData); i++)
				[ ] lsControlsData = lsExcelData[1]
				[ ] 
				[ ] // Check First row of Controls.XLS with supplied Input parameter
				[-] // if ((lsControlsData[1] == lsArgs[1]) && (ListCount(lsArgs)))
					[ ] SYS_SetEnv ("TesterName",lsControlsData[1])
					[ ] SYS_SetEnv ("EmailAddress",lsControlsData[2])
					[ ] SYS_SetEnv ("Platform",lsControlsData[3])
					[ ] SYS_SetEnv ("OutputLocation",lsControlsData[4])
					[ ] SYS_SetEnv ("RunFrequency",lsControlsData[5])
					[ ] 
					[-] if (lsControlsData[5] == "Once")
						[ ] sXLSDataPath  = ROOT_PATH + "\" + "TestingService\TestService\Once\{lsArgs[1]}\{sExcelName}.xls"
					[-] else
						[ ] sXLSDataPath = ROOT_PATH + "\" + "TestingService\TestService\Nightly\{lsArgs[1]}\{sExcelName}.xls"
					[ ] 
					[ ] return sXLSDataPath
				[-] // else
					[ ] // //continue
		[-] except
			[ ] LogError("Error occured for 'LoadControlsDependency")
	[ ] 
	[-] else
		[ ] sXLSDataPath = AUT_DATAFILE_PATH + "\" + "DataDrivenXLS\{sExcelName}.xls"
		[ ] //sXLSDataPath = "D:\Quicken\TestingService\TestService\Once\Govind\{sExcelName}.xls"
	[ ] return sXLSDataPath
