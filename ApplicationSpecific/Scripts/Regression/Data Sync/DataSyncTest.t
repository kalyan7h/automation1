[ ] // *********************************************************
[+] // FILE NAME:	<DataSyncTest.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains ....
	[ ] //
	[ ] // DEPENDENCIES:	includes.inc
	[ ] //
	[ ] // DEVELOPED BY:	Govind Babhulgaonkar
	[ ] //
	[ ] // Developed on: 		21/01/2014
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Jan 21, 2013	Govind Babhulgaonkar		Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[-] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc"
[ ] // ==========================================================
[ ] 
[ ] 
[-] //=====================Variable Declaration =====================================
	[ ] // Global variables used for Data Sync Test
	[ ] public STRING sFileName="StageMiniTestAutomation"
	[ ] public STRING sDataFilepath = AUT_DATAFILE_PATH + "\DataSyncTestData"
	[ ] public STRING sBaseExcelSheet = XLS_DATAFILE_PATH + "\DataSyncBaseSheet.xls"
	[ ] public STRING sWriteLocationExcelSheet = sDataFilepath + "\DataSyncResults.xls"
	[ ] public STRING sReadLocationExcelSheet = XLS_DATAFILE_PATH + "\DataSyncResults.xls"
	[ ] public STRING sVaultPassword = "qwerty"
	[ ] public STRING sDataSyncTestResultsDir = "C:\DataSyncTestResults"
	[ ] public STRING sNewFileName,sDataFileToMove, sSyncFileToMove,sOFXLogFileToMove
	[ ] public boolean bMatch
	[ ] 
[-] testcase Test01_OpenFileSignUpAndSync() appstate none 
	[-] // Variable declaration
		[ ] INTEGER iOpenDataFile, i, j
		[ ] STRING sIntuitId, sPwd, sSecAnswer, sZip
		[ ] LIST OF ANYTYPE lsAccountAndBalances, lsAccountAndBalancesRead,sAccountAndBalancesPostSync
		[ ] sIntuitId="gbDSAutomationMini@intuit.com"
		[ ] sPwd="qwe123"
		[ ] sSecAnswer = "PiggyDog"
		[ ] sZip = "94086"
	[-] // Do Stage-Mini Setup	
		[ ] //SetUp_StageMiniConfig()
	[-] // Copy the test data file
		[ ] sNewFileName = CopyTestdataFile(sDataFilepath, sFileName)
	[-] // Launch Quicken
		[ ] LaunchQuicken()
	[-] // Open Data File
		[-] if(QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] Waitforstate(QuickenWindow,TRUE,SHORT_SLEEP)
			[ ] // Open Data File
			[ ] iOpenDataFile = OpenDataFile(sNewFileName,sDataFilepath)
			[ ] ReportStatus("Open Data File {sNewFileName}.QDF",iOpenDataFile,"Data File {sNewFileName}.QDF opened successfully.")
		[-] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist.") 
			[ ] 
	[-] // Register Quicken or Sign up for IAM
		[ ] RegisterQuickenConnectedServices(sIntuitId, sPwd,NULL,sSecAnswer,NULL,NULL,NULL,NULL,NULL,NULL,NULL,sVaultPassword)
	[-] // Turn ON the preference to show cents in account bar balances
		[ ] TurnONShowCentsInAccountBarPreference()
	[-] // Read account bar values
		[ ] lsAccountAndBalances = GetAccountNamesAndBalances()
	[-] // Copy the excel base sheet from base location to write location
		[ ] CopyFile(sBaseExcelSheet, sWriteLocationExcelSheet)
	[-] // Write the account bar values to an excel sheet
		[-] for (i=1;i<=ListCount(lsAccountAndBalances);i++)
			[ ] WriteExcelTable("DataSyncTestData\DataSyncResults", "AccountAndBalances", lsAccountAndBalances[i])
	[-] // Go to Mobile & Alerts tab
		[ ] NavigateQuickenTab("Mobile Alerts")
	[-] // SignUp for Mobile & Alerts
		[ ] MobileSignUpAndSync(sIntuitId, sPwd,sZip, sVaultPassword)
	[-] // Copy the excel sheet from write location to read location
		[ ] CopyFile(sWriteLocationExcelSheet, sReadLocationExcelSheet)
	[-] // Read the values from the excel sheet
		[ ] lsAccountAndBalancesRead = ReadExcelTable("DataSyncResults", "AccountAndBalances")
	[-] // Read account bar values post Sync
		[ ] sAccountAndBalancesPostSync = GetAccountNamesAndBalances()
	[-] // Compare the values
		[ ] bMatch = ListCompare(lsAccountAndBalancesRead, sAccountAndBalancesPostSync, FALSE)
		[-] if (bMatch==TRUE)
			[ ] ReportStatus("Compare the account balances before and after sync", PASS, "Balance for all Accounts before and after sync MATCH")
		[-] else
			[ ] ReportStatus("Compare the account balances before and after sync", FAIL, "Balance for all Accounts before and after sync DO NOT MATCH")
	[-] // Close Quicken
		[ ] CloseQuicken()	
	[-] // Data Sync test Clean up
		[ ] DataSyncTestCleanUp ()
		[ ] 
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: ReadINIValue()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will open an INI file and return the value for a key/string.
	[ ] //
	[ ] // PARAMETERS:		STRING 	sFileName		Name of the file to be read
	[ ] //						STRING 	sSection		Name of the [Section] where key/string resides
	[ ] //						STRING 	sName			Name of the String/key for which the value needs to be read
	[ ] //
	[ ] // RETURNS:			STRING		The Value for the key/string
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	Jan 17, 2014	Govind Babhulgaonkar	Created
[ ] // ==========================================================
[+] public STRING ReadINIValue(STRING sFileName,STRING sSection, STRING sKey, STRING sLocation optional)
	[ ] 
	[-] // Variable declaration
		[ ] STRING sFile
		[ ] HINIFILE hIni
		[ ] STRING sValue
	[-] //Read the value
		[ ] sFile = 	sLocation + "\" + sFileName
		[ ] hIni = IniFileOpen(sFile)
		[ ] sValue = IniFileGetValue(hIni, sSection, sKey)
		[ ] IniFileClose (hIni)
		[-] if (sValue=="")
			[ ] print("The section {sSection} not found !!")
			[ ] return sValue
		[-] else
			[ ] print("Section : [{sSection}], {sKey} = {sValue}")
			[ ] return sValue
			[ ] 
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: CopyTestdataFile()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function copies the base test data file and renames it with current date, time value.
	[ ] // This file is saved with test results at the end of script execution for further inspection.
	[ ] // PARAMETERS:		STRING 	sTestDataFilePath		Path of the Base test data file
	[ ] //						STRING 	sTestDataFileName		Name of the Base test data file
	[ ] //
	[ ] // RETURNS:			STRING		sFunctionResult			The name of renamed data file
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	Feb 17, 2014	Govind Babhulgaonkar	Created
[ ] // ==========================================================
[+] public STRING CopyTestdataFile(string sTestDataFilePath, string sTestDataFileName)
	[+] // Variable declaration
		[ ] STRING sTestDataFileNewName,sTime, sDate
		[ ] STRING iCopyResult, sFunctionResult=NULL
		[ ] DATETIME DayAndTime
	[+] do
		[-] if (QuickenWindow.Exists())
			[ ] QuickenWindow.Kill()
			[ ] WaitForState(QuickenWindow,False,5)
		[ ] // get current date and time
		[ ] DayAndTime = GetDateTime ()
		[ ] // format current date and time
		[ ] sTime = FormatDateTime(DayAndTime, "hhnnssAM/PM")
		[ ] sDate = FormatDateTime(DayAndTime, "mmddyy")
		[ ] Print("Script started at {sTime} on {sDate}.")
		[ ] sTestDataFileNewName = sTestDataFileName + sDate + sTime
		[ ] sFunctionResult = sTestDataFileNewName
		[ ] sTestDataFileNewName = sTestDataFilePath + "\" + sTestDataFileNewName + ".QDF"
		[ ] sTestDataFileName = sTestDataFilePath + "\" + sTestDataFileName + ".QDF"
		[ ] CopyFile(sTestDataFileName, sTestDataFileNewName)
	[+] except
		[ ] ExceptLog()
		[ ] sFunctionResult=NULL
	[ ] return sFunctionResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: DataSyncTestCleanUp()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will move the Quicken data file, OFX log file and Sync log file along with it from..
	[ ] // ..the working directory to a result location specified in the script.
	[ ] // PARAMETERS:		NONE
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS	If all the files are moved successfully
	[ ] //									FAIL  	if any error occurs
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	Feb 18, 2014	Govind Babhulgaonkar	Created
[ ] // ==========================================================
[+] public INTEGER DataSyncTestCleanUp ()
	[+] // Variable declaration
		[ ] BOOLEAN bResult1, bResult2, bResult3
		[ ] INTEGER iFunctionResult=FAIL
	[ ] do
	[+] // Move data file and logs to results folder
		[ ] MakeDir(sDataSyncTestResultsDir)
		[ ] sDataFileToMove = sNewFileName + ".QDF"
		[ ] sSyncFileToMove = sNewFileName + "_SyncLog.dat"
		[ ] sOFXLogFileToMove = sNewFileName + "OFXLOG.DAT"
		[ ] bResult1 = MoveFile (sDataFilepath+"\"+sDataFileToMove, sDataSyncTestResultsDir+"\"+sDataFileToMove)
		[ ] bResult2 = MoveFile (sDataFilepath+"\"+sSyncFileToMove, sDataSyncTestResultsDir+"\"+sSyncFileToMove)
		[ ] bResult3 = MoveFile (sDataFilepath+"\"+sOFXLogFileToMove, sDataSyncTestResultsDir+"\"+sOFXLogFileToMove)
		[-] if (!bResult1)
			[ ] Log.Error("","FAILED TO MOVE FILE : {sDataFileToMove}") 
		[-] if (!bResult2)
			[ ] Log.Error("","FAILED TO MOVE FILE : {sSyncFileToMove}") 
		[-] if (!bResult3)
			[ ] Log.Error("","FAILED TO MOVE FILE : {sOFXLogFileToMove}") 
		[-] if (bResult1 && bResult2 && bResult3)
			[ ] Log.Message("","MOVED ALL FILES SUCCESSFULLY!") 
			[ ] iFunctionResult=PASS
		[-] else
			[ ] Log.Message("","ERROR WHILE MOVING FILES!!") 
			[ ] iFunctionResult=FAIL
	[+] except
		[ ] ExceptLog()
		[ ] iFunctionResult=FAIL
	[ ] return iFunctionResult
