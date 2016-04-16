[ ] 
[ ] // *************************************************************************************
[ ] // FILE NAME:	Recovery.INC
[+] // VERSION:		STFT.0.1
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This include file contains the AUT recovery library functions.
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Chandan Abhyankar
	[ ] //					Persistent
	[ ] //
	[ ] // PROJECT:			Quicken Desktop
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 15/Dec/11	Chandan Abhyankar	Created
[ ] // *************************************************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Classes.inc" 	
[ ] // ==========================================================
[ ] 
[ ] // ==========================================================
[-] // RECOVERY LIBRARY FUNCTIONS
	[ ] 
	[+] VOID ErrorHandler(ANYTYPE aLog optional, WINDOW wObj, STRING sError)
		[ ] // ==========================================================
		[+] // FUNCTION: ErrorHandler()
			[ ] // 
			[ ] // DESCRIPTION:
			[ ] // This function is called to handle an exception that has occurred in one of the
			[ ] // DoVerify...() functions. If the aLog parameter is specified as a BOOLEAN value of
			[ ] // TRUE, or if aLog contains a string value, then an error message containing sError
			[ ] // and the string contents of aLog will be logged, along with the exception data.
			[ ] // 
			[ ] // PARAMETERS:		ANYTYPE		aLog		(optional)
			[ ] // WINDOW		wObj		object specifier
			[ ] // STRING		sError
			[ ] // 
			[ ] // RETURNS:			NULL
			[ ] // 
			[ ] // REVISION HISTORY:
			[ ] // Jan 10, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] STRING sErrMsg	= BLANK_STR
		[+] if (aLog != NULL)
			[+] if (TypeOf(aLog) == STRING) || (aLog == TRUE)
				[+] if (TypeOf(aLog) == STRING)
					[ ] sErrMsg = aLog
				[ ] LogException("{sError} of {wObj}{sErrMsg}")
		[ ] 
	[ ] 
	[+] VOID LogException(STRING sError)
		[ ] // ==========================================================
		[+] // FUNCTION: LogException()
			[ ] // 
			[ ] // DESCRIPTION:
			[ ] // This function is called by error and exception handlers to log an error message
			[ ] // along with any associated exception data.
			[ ] // 
			[ ] // PARAMETERS:		STRING	sError	error message
			[ ] // 
			[ ] // RETURNS:			NULL
			[ ] // 
			[ ] // REVISION HISTORY:
			[ ] // Jan 12, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] CURRENT_TEST_STATUS = FAILED
		[ ] Log.ResListOpen("*** FAIL *** - Error(s) detected while verifying {sError}.")
		[ ] ExceptLog()
		[ ] Log.ResListClose()
		[ ] 
	[ ] 
	[+] VOID ScriptEnter()
		[ ] 
		[ ] // ==========================================================
		[+] // FUNCTION: ScriptEnter()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //		This function used to do script enter setups for script.
			[ ] //
			[ ] // PARAMETERS:		NULL
			[ ] //
			[ ] // RETURNS:			NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 14, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] Log.ScriptStart()
		[ ] CleanupResults()
		[ ] DisableDebugMode()
	[ ] 
	[+] VOID ScriptExit(BOOLEAN bException)
		[ ] //Print("Inside Script Exit")
		[ ] // // ==========================================================
		[+] // // FUNCTION: ScriptExit()
			[ ] // //
			[ ] // // DESCRIPTION:
			[ ] // //		This function used to do script exit setups for script.
			[ ] // //
			[ ] // // PARAMETERS:		BOOLEAN	bException
			[ ] // //
			[ ] // // RETURNS:			NULL
			[ ] // 
			[ ] // // REVISION HISTORY:
			[ ] // //	 Feb 15, 2007	Bhagwat Kolde created
		[ ] // // ==========================================================
		[+] if bException
			[ ] ExceptLog()
		[ ] 
		[ ] Log.ScriptEnd()
		[ ] 
		[ ] 
	[ ] 
	[-] VOID TestCaseEnter()
		[ ] // ==========================================================
		[+] // FUNCTION: TestCaseEnter()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //		This function used to implement Execution Dependency mechansim.
			[ ] //		If primary test case is failed then dependent test cases are not executed..
			[ ] //
			[ ] // PARAMETERS:		None
			[ ] //
			[ ] // RETURNS:			NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 02, 2011	Chandan Abhyankar	created
		[ ] // ==========================================================
		[ ] 
		[ ] STRING sScriptName, sCaption
		[ ] BOOLEAN bFound, bMatch, bFlag, bCaption
		[ ] INTEGER iSize
		[ ] 
		[ ] // Get Script name and TestCase name
		[ ] sScriptName = GetProgramName()
		[ ] sTestCaseId = GetTestCaseName()
		[ ] LoadOSDependency()
		[ ] DisableDebugMode()
		[ ] //If the testcase is executed in autolab machine, set the ROOT_PATH global variable to "C:\automation"
		[+] if (IsAutolabMode ())
			[ ] ROOT_PATH="C:\automation"
		[ ] 
		[ ] // Testcase Result Header
		[ ] WriteHeader()
		[ ] 
		[ ] SKU_TOBE_TESTED = LoadSKUDependency()
		[ ] 
		[+] if (SKU_TOBE_TESTED == "PREMIER" || SKU_TOBE_TESTED == "DELUXE")
			[ ] bFlag = TRUE
		[+] else
			[ ] bFlag = FALSE
		[ ] 
		[+] if(bFlag == TRUE)
			[ ] bMatch = MatchStr("*Business*", sTestCaseId) 
			[+] if (bMatch == TRUE)
				[ ] ReportStatus(sTestCaseId, WARN, "Testcase - {sTestCaseId} is not executed as Quicken {SKU_TOBE_TESTED} version doesn't have Business account")
				[ ] CreateTCResultFile(sTestCaseStatusFile,"{sTestCaseId} - NOT RUN")
				[ ] exit
		[ ] 
		[ ] bFound = MatchStr("*Smoke*", sScriptName)
		[+] if (bFound == TRUE)
			[ ] iSize = ArraySize(SmokeTCsDependency)
			[ ] CheckExecutionDependency(SmokeTCsDependency, iSize)
			[ ] 
		[ ] bFound = MatchStr("*BAT*", sScriptName)
		[+] if (bFound == TRUE)
			[ ] iSize = ArraySize(BatTCsDependency)
			[ ] CheckExecutionDependency(BatTCsDependency, iSize)
		[ ] bFound = MatchStr("*Performance*", sScriptName)
		[+] if (bFound == TRUE)
			[ ] iSize = ArraySize(PerformanceTCsDependency)
			[ ] CheckExecutionDependency(PerformanceTCsDependency, iSize)
			[ ] 
		[ ] 
		[ ] // Call Application state
		[ ] SetAppState()
		[ ] 
	[ ] 
	[+] VOID DisableDebugMode()
		[ ] 
		[ ] HINIFILE hIni
		[ ] 
		[ ] hIni = IniFileOpen("C:\ProgramData\Intuit\Quicken\Config\QUICKEN.ini")
		[ ] STRING sValue = IniFileGetValue(hIni, "Testing", "DbC")
		[ ] 
		[+] if (sValue == "")
			[ ] IniFileSetValue(hIni, "Testing", "DbC", "0")
		[ ] 
		[ ] IniFileClose(hIni)
		[ ] 
	[ ] 
	[+] VOID TestCaseExit(BOOLEAN bException)
		[ ] //Print("Inside Test Case Exit")
		[ ] // ==========================================================
		[+] // FUNCTION: TestCaseExit()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //		This function used to do test case enter setups for testcase.
			[ ] //
			[ ] // PARAMETERS:		BOOLEAN bException
			[ ] //
			[ ] // RETURNS:			NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Feb 15, 2007	Bhagwat Kolde created
		[ ] // ==========================================================
		[ ] INTEGER iNumErrors = GetTestCaseErrorCount()
		[ ] 
		[+] if (iNumErrors > 0 || bException == TRUE)
			[ ] //Browser.CloseWindows() --Commented by poonam
			[ ] ExceptLog()
		[ ] UpdateResults()
		[ ] 
		[ ] // Testcase Result Footer
		[ ] WriteFooter(CURRENT_TEST_STATUS)
		[ ] 
		[ ] // 05/21/2015 KalyanG: Added the conditions to handle opened dialogs and windows
		[+] if (QuickenWindow.Exists(2))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // dismiss the callout holder if exists
			[+] do
				[+] if (Desktop.Find("//Control[@caption='Callout Holder']//PushButton[@caption='close']").Exists())
					[ ] Desktop.Find("//Control[@caption='Callout Holder']//PushButton[@caption='close']").click()
					[ ] sleep(2)
			[+] except
				[ ] // do nothing
			[ ] 
			[ ] // get all window handles of opened windows and dismiss
			[ ] integer i
			[ ] list of WINDOW lw = QuickenWindow.GetCloseWindows()
			[ ] 
			[+] do
				[+] for i =1 to Listcount(lw)
					[ ] lw[i].setActive()
					[ ] lw[i].Close()
					[ ] sleep(2)
					[ ] 
					[+] if (dialogBoxToDismiss.Exists(5))
						[ ] dialogBoxToDismiss.buttonYes.Click()
						[ ] sleep(1)
			[+] except
				[ ] // do nothing
			[ ] 
		[ ] 
	[ ] 
	[+] VOID UpdateResults()
		[ ] // ============================================
		[+] // FUNCTION: UpdateResults(STRING sTCId)
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //  This function used to update log file for (1)test case result as PASSED/FAILED,
			[ ] 
			[ ] // PARAMETERS:	NULL
			[ ] //
			[ ] // RETURNS:		NULL
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //	 Nov 11, 2010	Chandan Abhyankar	created
			[ ] 
		[ ] // ============================================
		[ ] string sMsg
		[ ] STRING	sSQL 					// query strored here 
		[ ] HSQL		hSQL					// query handle
		[ ] STRING	sTCResult = "FAIL"		// by default setting testcase status as FAIL
		[ ] // column names in test driver
		[ ] STRING sTC_RESULT_COL="Result"
		[ ] STRING sTC_NAME_COL ="TCId"
		[ ] STRING sTC_LAST_RUN_COL="LastRun"
		[ ] STRING sTC_BMP_PATH_COL="BmpFilePath"
		[ ] STRING SUITEID_COL = "SUITEID"
		[ ] // required variables
		[ ] WINDOW wActiveWin
		[ ] HANDLE hHandle
		[ ] 
		[ ] sTestCaseId = GetTestCaseName()
		[ ] STRING BMP_FILE = "{ROOT_PATH}\ApplicationSpecific\Bitmaps"
		[ ] 
		[+] if (GetTestCaseErrorCount() > 0)
			[ ] // capturing window for faild testcase
			[+] do
				[ ] 
				[ ] 
				[+] if MessageBox.Exists()
					[ ] MessageBox.CaptureBitmap("{BMP_FILE}\{sTestCaseId}.bmp")
					[ ] MessageBox.Close()
					[ ] 
				[ ] 
				[+] // else if DialogBox.Exists()
					[ ] // DialogBox.CaptureBitmap("{BMP_FILE}\{sTestCaseId}.bmp")
					[ ] // DialogBox.Close()
				[ ] 
				[+] else
					[ ] wActiveWin=Desktop.GetActive()
					[ ] wActiveWin.CaptureBitmap("{BMP_FILE}\{sTestCaseId}.bmp")
				[ ] sTCResult = "FAIL"
			[+] except
				[ ] // if no active window found, logging message to test driver.
				[ ] sTCResult = "FAIL"
		[+] else if (GetTestCaseErrorCount() == 0)
			[ ] // if no error in current testcase, setting status as PASS
			[ ] sTCResult="PASS"
		[ ] 
		[+] if(sTCResult == "FAIL")
			[ ] sMsg= "Failed"
		[+] else
			[ ] sMsg= "Pass"
		[ ] 
		[ ] AddTestCase(GetProgramName(),GetTestCaseName(),sTCResult,sMsg)
		[ ] 
		[ ] // This is used to log Test Case result in TestCaseResult.txt
		[ ] CreateTCResultFile(sTestCaseStatusFile,"{sTestCaseId} - {sTCResult}")
		[ ] 
		[ ] 
	[ ] 
	[+] VOID CSVLogger()
		[ ] INTEGER i,j
		[ ] FILESHARE 				fShare
		[ ] LIST OF LIST OF STRING 	llsExelData
		[ ] STRING 					sCSVLogFileName	=	CSV_PATH
		[ ] BOOLEAN 				bExclusiveWrite	=	TRUE
		[ ] HFILE 					hCSVLoger
		[ ] STRING 					sLine
		[+] LIST OF STRING 			lsHeaderFields	=	{...}
			[ ] "Feature"  //Feature, 
			[ ] "TCId"  //TCId, 
			[ ] "TCDesc"  //TCDesc, 
			[ ] "TestData"  //TestData, 
			[ ] "TDDesc"  //TDDesc, 
			[ ] "Priority"  //Priority, 
			[ ] "Result"  //Result, 
			[ ] "LastRun"  //LastRun, 
			[ ] "BmpFilePath"  //BmpFilePath,
			[ ] 
		[ ] STRING sTmp,sTmp1,sTmp2
		[ ] LIST OF STRING lsDataVals
		[ ] 
		[+] if (bExclusiveWrite == TRUE)
			[ ] fShare = FS_DENY_WRITE
		[+] else 
			[ ] fShare = FS_DENY_NONE
		[ ] 
		[ ] llsExelData=ReadExcelTable(EXL_PATH,"RunTestData")
		[+] for i=1 to ListCount(llsExelData)
			[+] for j=1 to ListCount(llsExelData[i])
				[+] if llsExelData[i][j] == NULL
					[ ] llsExelData[i][j] =""
		[ ] hCSVLoger = FileOpen (sCSVLogFileName, FM_WRITE,fShare)
		[ ] 
		[ ] ListInsert(llsExelData,1,lsHeaderFields)
		[ ] 
		[+] for i=1 to ListCount(llsExelData)
			[ ] FileWriteValue (hCSVLoger,llsExelData[i])
		[ ] FileClose(hCSVLoger)
		[ ] 
		[ ] hCSVLoger = FileOpen (sCSVLogFileName, FM_READ,fShare)
		[ ] 
		[+] while FileReadLine (hCSVLoger, sLine)
			[ ] sTmp = StrTran(sLine,""{","")
			[ ] sTmp1 = StrTran(sTmp,"}","")
			[ ] sTmp2 = StrTran(sTmp1,Space(1),Space(0))
			[ ] ListAppend(lsDataVals,sTmp2)
		[ ] FileClose(hCSVLoger)
		[ ] 
		[ ] hCSVLoger = FileOpen (sCSVLogFileName, FM_WRITE,fShare)
		[+] for i=1 to ListCount(lsDataVals)
			[ ] FileWriteLine(hCSVLoger,lsDataVals[i])
			[ ] 
		[ ] FileClose(hCSVLoger)
		[ ] 
	[ ] 
	[+] void setCurrentSuiteID(INTEGER CUR_SUITE_ID)
		[ ] HFILE theHandle = FileOpen("{LOG_FOLDER}\SuiteId.txt", FM_WRITE)
		[ ] FileWriteLine(theHandle, Str(CUR_SUITE_ID))
		[ ] FileClose(theHandle)
	[ ] 
	[+] INTEGER getCurrentSuiteID()
		[ ] String tempStr
		[ ] HFILE theHandle = FileOpen("{LOG_FOLDER}\SuiteId.txt", FM_READ)
		[ ] FileReadLine(theHandle, tempStr)
		[ ] FileClose(theHandle)
		[+] if ( tempStr != "" || tempStr != NULL)
			[ ] //CURRENT_SUITE_ID = Val(tempStr)
		[ ] return CURRENT_SUITE_ID
		[ ] 
		[ ] 
	[ ] 
	[+] void setCurrentTestRunID(String run_id)
		[ ] HFILE theHandle = FileOpen("{LOG_FOLDER}\TestRunId.txt", FM_WRITE)
		[ ] FileWriteLine(theHandle, run_id)
		[ ] FileClose(theHandle)
	[ ] 
	[+] String getCurrentTestRunID()
		[ ] String tempStr
		[ ] HFILE theHandle = FileOpen("{LOG_FOLDER}\TestRunId.txt", FM_READ)
		[ ] FileReadLine(theHandle, tempStr)
		[ ] FileClose(theHandle)
		[+] if ( tempStr != "" || tempStr != NULL)
			[ ] CURRENT_TEST_RUN_ID = tempStr
		[ ] return CURRENT_TEST_RUN_ID
	[ ] 
[ ] // ==========================================================
