[ ] 
[ ] // *************************************************************************************
[ ] // FILE NAME:	GenLib.INC
[+] // VERSION:		STFT.0.1
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This include file contains library functions for Logging/Reporting mechanism.
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Chandan Abhyankar
	[ ] //					Software Test Automation Engineer
	[ ] //					Persistent
	[ ] //
	[ ] // PROJECT:			IV AND V COE
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 07/Dec/10 Chandan Abhyankar  Created
[ ] // *************************************************************************************
[ ] 
[-] //Create a log file, with test name and date stamp under defaule LOG folder and returns the file handler
	[+] public HFILE GetLogger()
		[+] if(!SYS_DirExists(LOG_FOLDER))
			[ ] SYS_MakeDir(LOG_FOLDER)
		[ ] Datetime dTime = GetDateTime()
		[ ] String sDate
		[ ] FILESHARE fShare
		[ ]  fShare = FS_DENY_WRITE 
		[ ] sDate = FormatDateTime(dTime, "mm_dd_yy")
		[ ] //String logFileName = LOG_FOLDER + DELIMITER + GetTestCaseName()+ "_"+ sDate + ".log"
		[ ] String logFileName = LOG_FOLDER + DELIMITER +  "QuickenDesktop" + "_"+ sDate + ".log"
		[ ] //Print ("Logs are stored at :"+logFileName)
		[ ] HFILE TheHandle = FileOpen(logFileName, FM_APPEND)
		[ ] return TheHandle
[-] //Logs the givem message to a given log file
	[+] public void logMessage(HFILE fileHandle, Anytype logMessage)
		[ ] FileWriteLine(fileHandle, logMessage)
		[ ] 
[-] //Writes the Log header for a test case to a given file
	[+] public VOID WriteHeader()
		[ ] 
		[ ] // This is set to PASSED at the start of test case
		[ ] CURRENT_TEST_STATUS = PASSED
		[ ] 
		[ ] HFILE hFileHandle
		[ ] hFileHandle = GetLogger()
		[ ] //FileWriteLine(hFileHandle, "*_______________________________________________________________*")
		[ ] FileWriteLine(hFileHandle, "############### STARTING THE TEST CASE  "+ GetTestCaseName() + " ###############")
		[ ] FileClose(hFileHandle)
		[ ] sleep(1)
[-] //Writes the Log footer for a test case to a given file
	[+] public void WriteFooter(String sTestStatus)
		[ ] HFILE hFileHandle
		[ ] hFileHandle = GetLogger()
		[-] if (sTestStatus == "PASS")
			[ ] FileWriteLine(hFileHandle, "############### TEST CASE  "+ GetTestCaseName() + " is PASSED ###############")
		[-] else
			[ ] FileWriteLine(hFileHandle, "############### TEST CASE  "+ GetTestCaseName() + " is FAILED ###############")
		[ ] FileWriteLine(hFileHandle,"---------------------------------------------------------------------")
		[ ] FileClose(hFileHandle)
		[ ] sleep(1)
[-] //Returns true if the expected and actual values are true, exits from a testcase if not matched
	[+] public BOOLEAN AssertTrue(BOOLEAN bActual)
		[ ] BOOLEAN bFunctionResult
		[-] do 
			[ ] Verify(TRUE, bActual)
			[ ] bFunctionResult = TRUE
		[-] except
			[ ] bFunctionResult = FALSE
			[ ] LogException("Actual is not same as Expected")
		[ ] return bFunctionResult
[-] //Returns true if the expected and actual values are false, exits from a testcase if not matched
	[+] public BOOLEAN AssertFalse(BOOLEAN bActual)
		[ ] BOOLEAN bFunctionResult
		[+] do 
			[ ] Verify(FALSE, bActual)
			[ ] bFunctionResult = TRUE
		[+] except
			[ ] bFunctionResult = FALSE
			[ ] LogException("Actual is not same as Expected")
		[ ] return bFunctionResult
[-] //Returns true if the expected and actual values are equal, exits from a testcase if not matched
	[+] public BOOLEAN AssertEquals(Anytype Expected, Anytype Actual)
		[ ] BOOLEAN bFunctionResult
		[+] do 
			[ ] Verify(Expected, Actual)
			[ ] bFunctionResult = TRUE
		[+] except
			[ ] bFunctionResult = FALSE
			[ ] LogException("Expected - {Expected} , Actual -  {Actual} is not same.")
		[ ] return bFunctionResult
		[ ] 
[+] //Logs exception to log file and exits from a testcase
	[+] public void logExceptionAndExit()
		[ ] CURRENT_TEST_STATUS = FAILED
		[ ] logMessage(LOG_FILE_HANDLE, ExceptData())
		[ ] List of CALL lsCalls = ExceptCalls()
		[ ] CALL call
		[-] for each call in lsCalls
			[ ] logMessage(LOG_FILE_HANDLE, "Module : {call.sModule}")
			[ ] logMessage(LOG_FILE_HANDLE, "Function : {call.sFunction}")
			[ ] logMessage(LOG_FILE_HANDLE, "Line : {call.iLine}")
		[ ] 
		[ ] logMessage(LOG_FILE_HANDLE, "ERROR: Called from {call.sFunction} in {call.sModule} at Line {call.iLine}")
		[ ] writeFooter(CURRENT_TEST_STATUS)
		[ ] raise 1, "ERROR: Called from {call.sFunction} in {call.sModule} at Line {call.iLine}"
		[ ] 
		[ ] //DefaultTestCaseExit(true)
		[ ] 
		[ ] 
[ ] //Utility functions
[ ] ///Logs Result to Silk Result file and User Defined log file       
[+] // public VOID ReportStatus(Anytype sStepName, INTEGER iFunctionStatus, Anytype sDescription)
	[ ] // STRING sStatusValue
	[ ] // HFILE hFileHandle
	[ ] // hFileHandle = GetLogger()
	[ ] // 
	[ ] // 
	[+] // switch (iFunctionStatus)
		[-] // case PASS
			[ ] // sStatusValue = "PASS"
			[ ] // Log.Pass(sStepName, "Pass : " +  sDescription )
		[-] // case FAIL
			[ ] // sStatusValue = "FAIL"           
			[ ] // Log.Fail(sStepName,"Fail : " +  sDescription)
			[ ] // CURRENT_TEST_STATUS = "FAIL"
		[-] // case ABORT
			[ ] // Log.Fail("ABORT","Test Execution is aborted")
			[ ] // raise 1, "ERROR: Overall Test Execution needs to be  Aborted"
			[ ] // CURRENT_TEST_STATUS = "FAIL"
			[ ] // @("$StopRunning") ()
			[ ] // 
		[-] // case WARN
			[ ] //  sStatusValue = "WARN"        
			[ ] //  Log.Warning(sStepName,sDescription)
		[-] //  default
			[ ] //  Log.Message(sStepName,sDescription)
	[ ] // //This statemente writes to user defined log file
	[+] // if (hFileHandle != NULL)
		[ ] // logMessage(hFileHandle, "------------------------------")
		[ ] // logMessage(hFileHandle, "Step {sStepName} ")
		[ ] // logMessage(hFileHandle, "Status: {sStatusValue}")
		[ ] // logMessage(hFileHandle, "Description: {sDescription}")
		[ ] // logMessage(hFileHandle,  "------------------------------")
		[ ] // 
		[ ] // FileClose(hFileHandle)
		[ ] // sleep(1)
		[ ] // 
[ ] 
[+] public VOID ReportStatus(Anytype sStepName, INTEGER iFunctionStatus, Anytype sDescription)
	[ ] STRING sStatusValue
	[ ] HFILE hFileHandle
	[ ] // hFileHandle = GetLogger()
	[ ] 
	[ ] 
	[-] switch (iFunctionStatus)
		[+] case PASS
			[ ] sStatusValue = "PASS"
			[ ] Log.Pass(sStepName, "Pass : " +  sDescription )
		[+] case FAIL
			[ ] sStatusValue = "FAIL"           
			[ ] Log.Fail(sStepName,"Fail : " +  sDescription)
			[ ] CURRENT_TEST_STATUS = "FAIL"
		[+] case ABORT
			[ ] Log.Fail("ABORT","Test Execution is aborted")
			[ ] raise 1, "ERROR: Overall Test Execution needs to be  Aborted"
			[ ] CURRENT_TEST_STATUS = "FAIL"
			[ ] @("$StopRunning") ()
			[ ] 
		[+] case WARN
			[ ] sStatusValue = "WARN"        
			[ ] Log.Warning(sStepName,sDescription)
		[+] default
			[ ] Log.Message(sStepName,sDescription)
	[ ] 
	[ ] //This statemente writes to user defined log file
	[+] // if (hFileHandle != NULL)
		[ ] // logMessage(hFileHandle, "------------------------------")
		[ ] // logMessage(hFileHandle, "Step {sStepName} ")
		[ ] // logMessage(hFileHandle, "Status: {sStatusValue}")
		[ ] // logMessage(hFileHandle, "Description: {sDescription}")
		[ ] // logMessage(hFileHandle,  "------------------------------")
		[ ] // 
		[ ] // FileClose(hFileHandle)
		[ ] // sleep(1)
		[ ] // 
	[ ] 
	[ ] ReportStatusToExcel(sStepName,iFunctionStatus,sDescription)
	[ ] 
[+] public VOID ReportStatusToExcel(Anytype sStepName, INTEGER iFunctionStatus, Anytype sDescription)
	[ ] STRING sDB ,sWorksheet , sFunctionStatus ,sIntermediateScriptName
	[ ] STRING sTestCaseId , sIntermediateTestCaseId ,sScriptName ,sPath , sNull
	[ ] INTEGER iCount ,iListCount ,iCounter , sTCStatus
	[ ] BOOLEAN bMatch ,bMatch1
	[ ] 
	[ ] bMatch =FALSE
	[ ] bMatch1 =FALSE
	[ ] sNull=NULL
	[ ] sDB ="TestExecutionResult"
	[ ] sWorksheet ="TestResult"
	[ ] 
	[ ] //sPath =XLS_REPORT_PATH                       //Copy into Results folder
	[ ] sPath =AUT_DATAFILE_PATH                       //Copy into Test Data folder
	[ ] 
	[ ] 
	[ ] LIST OF ANYTYPE lsResult , lsExistingResult ,lsData
	[ ] 
	[+] if (iFunctionStatus==FAIL)
		[ ] sFunctionStatus="FAIL"
	[+] else 
		[ ] sFunctionStatus="PASS"
		[ ] 
	[-] do
		[ ] 
		[ ] sIntermediateScriptName = GetProgramName()
		[ ] sIntermediateTestCaseId = GetTestCaseName()
		[ ] 
		[ ] 
		[ ] lsExistingResult = ReadExcelTable(sDB, sWorksheet ,sPath)
		[ ] iListCount = ListCount (lsExistingResult)
		[ ] 
		[ ] 
		[-] if (iListCount <1)
			[ ] sScriptName=sIntermediateScriptName
			[ ] sTestCaseId = sIntermediateTestCaseId
			[ ] 
			[ ] 
		[-] else
			[ ] //ScriptName
			[+] for (iCount =iListCount ; iCount >=1 ; --iCount)
				[ ] lsData =NULL
				[ ] lsData =lsExistingResult[iCount]
				[-]  if (lsData[1]==NULL)
					[ ] lsData[1]=""
				[ ] bMatch = MatchStr("" , lsData[1])
				[ ] bMatch1= MatchStr("{sIntermediateScriptName}" ,  lsData[1])
				[-] if (bMatch || bMatch1 )
					[ ] iCounter =iCount
					[ ] sScriptName=""
					[-] for (iCounter =iCount ; iCounter >=1 ; --iCounter)
						[ ] lsData =lsExistingResult[iCounter]
						[-]  if (lsData[1]==NULL)
							[ ] lsData[1]=""
						[ ] 
						[ ] bMatch= MatchStr("{sIntermediateScriptName}" ,  lsData[1])
						[-] if (bMatch )
							[ ] sScriptName=""
							[ ] break
						[ ] 
					[ ] 
					[ ] break
			[+] if (bMatch ==FALSE)
				[ ] sScriptName=sIntermediateScriptName
			[ ] 
			[ ] //TestCaseName
			[+] for (iCount =iListCount ; iCount >=1 ; --iCount)
				[ ] lsData =NULL
				[ ] lsData =lsExistingResult[iCount]
				[-]  if (lsData[2]==NULL)
					[ ] lsData[2]=""
				[ ] bMatch = MatchStr("{sNull}" , lsData[2])
				[ ] bMatch1= MatchStr("{sIntermediateTestCaseId}" ,  lsData[2])
				[-] if (bMatch || bMatch1 )
					[ ] iCounter =iCount
					[ ] sTestCaseId=""
					[-] for (iCounter =iCount ; iCounter >=1 ; --iCounter)
						[ ] lsData =lsExistingResult[iCounter]
						[-]  if (lsData[2]==NULL)
							[ ] lsData[2]=""
						[ ] 
						[ ] bMatch= MatchStr("{sIntermediateTestCaseId}" ,  lsData[2])
						[-] if (bMatch )
							[ ] sTestCaseId=""
							[ ] break
						[ ] 
					[ ] 
					[ ] break
			[-] if (bMatch ==FALSE)
				[ ] sTestCaseId = sIntermediateTestCaseId
			[ ] 
		[ ] 
		[ ] sStepName =StrTran (sStepName , "'" ,"")
		[ ] sDescription =StrTran (sDescription , "'" ,"")
		[ ] ListAppend (lsResult ,sScriptName)
		[ ] ListAppend (lsResult ,sTestCaseId)
		[ ] ListAppend (lsResult ,sStepName)
		[ ] ListAppend (lsResult , sFunctionStatus)
		[ ] ListAppend (lsResult ,sDescription)
		[ ] WriteExcelTable(sDB ,sWorksheet ,lsResult)
	[+] except
		[ ] 
		[ ] ExceptLog()
[ ] 
[ ] 
[ ] 
[ ] //Checks whether the required message is present in a given string
[+] public boolean findErrInText(String whatToFind, String whereToFind)
	[+] if(StrPos(whatToFind, whereToFind) > 0)
		[ ] logMessage(LOG_FILE_HANDLE, "Found the required string in a given Text")
		[ ] return true
	[ ] return false
[ ] 
[ ] // ==========================================================
[+] // LIST OF STRING Split(STRING sTargetString,STRING sDelimiter)
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will split one string through delimiter and return list of string
	[ ] //
	[ ] // PARAMETERS:		STRING 	sTargetString			String to split
	[ ] //						STRING     sDelimiter		Delimiter on which string should split
	[ ] //
	[ ] // RETURNS:			LIST OF STRING			
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	Jan 20, 2011 		Udita Dube	Created
[ ] // ==========================================================
[+] public LIST OF STRING Split(STRING sTargetString,STRING sDelimiter)
	[ ] LIST OF STRING lsReturn
	[-] while (StrPos(sDelimiter,sTargetString) > 0)
		[ ] ListAppend(lsReturn,Left(sTargetString, StrPos(sDelimiter,sTargetString)-1))
		[ ] sTargetString = SubStr(sTargetString, StrPos(sDelimiter,sTargetString)+Len(sDelimiter))
	[-] if Len(sTargetString) > 0
		[ ] ListAppend(lsReturn,sTargetString)
	[ ] return lsReturn
[ ] 
[ ] // ==========================================================
[+] // public INTEGER MatchList(STRING sPattern, LIST OF STRING lsInput)    
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will search a string in list of string
	[ ] // To match one string with  any item in list of strings. If it returns 0 means item not found in list
	[ ] //
	[ ] // PARAMETERS:		STRING 			  sPattern		String to search
	[ ] //						LIST OF STRING     lsInput		List of string in which search needs to be done
	[ ] //
	[ ] // RETURNS:			INTEGER	Position of the searched string in list of string		
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	Jan 21, 2011 		Udita Dube	Created
[ ] // ==========================================================
[+] public INTEGER MatchList(STRING sPattern, LIST OF STRING lsInput)  
	[-]  //Variable declaration  
		[ ]  INTEGER iCount, iItem    
		[ ]  INTEGER iReturn = 0    
	[ ] 
	[ ]  iCount = ListCount(lsInput)
	[-] for(iItem=1; iItem<= iCount; iItem++)
		[-]  if (MatchStr(trim(sPattern),trim(lsInput[iItem])))          
			[ ] iReturn = iItem  
			[ ] break    
		[-] else
			[ ] continue  
	[ ] return iReturn
