[ ] 
[ ] // *************************************************************************************
[ ] // FILE NAME:	Classes.INC
[-] // VERSION:		STFT.0.1
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This include file contains the base WinClass definitions required for
	[ ] // all AUT object classes.
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Bhagwat B. Kolde
	[ ] //					Software Test Automation Engineer
	[ ] //					Persistent
	[ ] //
	[ ] // PROJECT:			IV AND V COE
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 10/Oct/06	Bhagwat B. Kolde  Created
[ ] // *************************************************************************************
[ ] 
[ ] // ==========================================================
[-] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
[ ] // ==========================================================
[ ] 
[ ] // ==========================================================
[-] // CONSTANTS DECLARATIONS
	[ ] private type OBJECT is WINDOW		// declarations for ResLogClass
	[ ] OBJECT Log = ResLogClass()			// results logging object creation
	[ ] 
	[ ] STRING TXT_PATH = APP_PATH + "\Data\TestReport\SMARTLogger.txt"
	[ ] 
	[ ] private type OBJECT_STEPS is WINDOW
	[ ] OBJECT_STEPS objSteps = Step()
	[ ] 
	[ ] // type OBJECT_SUITES is WINDOW
	[ ] // OBJECT_SUITES objSuites = Suite()
	[ ] 
	[ ] private type OBJECT_ACCESS is WINDOW
	[ ] OBJECT_ACCESS objAccess = AccessDB()
	[ ] 
	[ ] private type OBJECT_TC is WINDOW
	[ ] OBJECT_TC objTCs = TestCase()
	[ ] 
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] // ==========================================================
[-] // GENERIC WINDOW CLASSES DECLARATIONS
	[ ] 
	[+] winclass ResLogClass   ///Modified for logging steps results
		[ ] // =========================================================
		[+] // CLASS NAME:	ResLogClass (User defined)
			[ ] //
			[ ] // DESCRIPTION:
			[ ] //   This window class used to log the messages in result file. The message may be,
			[ ] //	1) Simple message 			[Log.Message("<Str>")]
			[ ] //	2) Error message 			[Log.Error("<Str>")]
			[ ] //	3) Testcase Fail message 	[Log.Message("<Str>")]
			[ ] //	4) Testcase Pass message 	[Log.Message("<Str>")]
			[ ] //	4) Testcase Warning 		[Log.Message("<Str>")]
			[ ] //
			[ ] // 
			[ ] //
			[ ] // DEVELOPED BY:	Bhagwat B. Kolde
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] //		Bhagwat Kolde 	Created.
			[ ] //								
		[ ] // =========================================================
		[ ] 
		[ ] INTEGER	iIndent	= 0			// indentation for ResListOpen and ResListClose    
		[ ] 
		[ ] STRING	sFileNametxt = "{ROOT_PATH}\ApplicationSpecific\Data\TestReport\SMARTLogger.txt"	// text log file 
		[ ] 
		[ ] STRING	sFileNamexls = "{ROOT_PATH}\ApplicationSpecific\Data\TestData\TestDriver.xls"	// xls log file
		[ ] 
		[ ] BOOLEAN	bAppendMode  = FALSE
		[ ] 
		[ ]  INTEGER SUITE_ID
		[ ] 
		[+] VOID Fail(STRING sStepDescName, STRING sMsg)
			[ ] // =========================================================
			[-] // METHOD NAME: Fail()
				[ ] // DESCRIPTION:
				[ ] //   This method used to log FAIL message in result file.
				[ ] // 
				[ ] // PARAMETERS:		STRING sMsg:Message to be logged in result file as FAILED
				[ ] //					
				[ ] // RETURNS:			NULL
				[ ] //
				[ ] // REVISION HISTORY:
				[ ] //	 Jan 10, 2007	Bhagwat Kolde created
			[ ] // =========================================================
			[ ] // to log FAIL message in result file.
			[ ] this.Post("LogFailed",sStepDescName, sMsg)
			[ ] 
		[ ] 
		[+] VOID Pass(STRING sStepDescName, STRING sMsg)
			[ ] // =========================================================
			[-] // METHOD NAME: Pass()
				[ ] // DESCRIPTION:
				[ ] //   This method used to log PASS message in result file.
				[ ] // 
				[ ] // PARAMETERS:		STRING sMsg:Message to be logged in result file as PASSED
				[ ] //					
				[ ] // RETURNS:			NULL
				[ ] //
				[ ] // REVISION HISTORY:
				[ ] //	 Jan 10, 2007	Bhagwat Kolde created
			[ ] // =========================================================
			[ ] 
			[ ] // to log PASS message in result file.
			[ ] this.Post("LogPassed", sStepDescName,  sMsg)
			[ ] 
		[ ] 
		[-] VOID Error(STRING sStepDescName, STRING sMsg)
			[ ] // =========================================================
			[-] // METHOD NAME: Error()
				[ ] // DESCRIPTION:
				[ ] //   This method used to log ERROR message in result file.
				[ ] // 
				[ ] // PARAMETERS:		STRING sMsg:Message to be logged in result file as ERROR
				[ ] //					
				[ ] // RETURNS:			NULL
				[ ] //
				[ ] // REVISION HISTORY:
				[ ] //	 Jan 10, 2007	Bhagwat Kolde created
			[ ] // =========================================================
			[ ] 
			[ ] // to log ERROR message in result file.
			[ ] this.Post("LogError",sStepDescName,  sMsg)
			[ ] 
		[ ] 
		[-] VOID Warning(STRING sStepDescName, STRING sMsg)
			[ ] // =========================================================
			[-] // METHOD NAME: Warning()
				[ ] // DESCRIPTION:
				[ ] //   This method used to log WARNING message in result file.
				[ ] // 
				[ ] // PARAMETERS:		STRING sMsg:Message to be logged in result file as WARNING
				[ ] //					
				[ ] // RETURNS:			NULL
				[ ] //
				[ ] // REVISION HISTORY:
				[ ] //	 Jan 10, 2007	Bhagwat Kolde created
			[ ] // =========================================================
			[ ] 
			[ ] // to log WARNING message in result file.
			[ ] this.Post("LogWarning", sStepDescName, sMsg)
			[ ] 
		[ ] 
		[+] VOID Message(STRING sStepDescName, STRING sMsg)
			[ ] // =========================================================
			[-] // METHOD NAME: Message()
				[ ] // DESCRIPTION:
				[ ] //   This method used to log MESSAGE message in result file.
				[ ] // 
				[ ] // PARAMETERS:		STRING sMsg:Message to be logged in result file as MESSAGE
				[ ] //					
				[ ] // RETURNS:			NULL
				[ ] //
				[ ] // REVISION HISTORY:
				[ ] //	 Jan 10, 2007	Bhagwat Kolde created
			[ ] // =========================================================
			[ ] 
			[ ] // to log MESSAGE in result file.
			[ ] this.Post("LogMessage", sStepDescName, sMsg)
			[ ] 
		[ ] 
		[-] private VOID Post(STRING LogType, STRING sStepDescName, STRING sMsg optional)
			[ ] // =========================================================
			[+] // METHOD NAME: Post()
				[ ] // DESCRIPTION:
				[ ] //   This is private method used for result log class
				[ ] // 
				[ ] // PARAMETERS:		STRING LogType
				[ ] //					STRING sMsg optional : Message to log in result file
				[ ] //					
				[ ] // RETURNS:			NULL
				[ ] //
				[ ] // REVISION HISTORY:
				[ ] //	 Jan 10, 2007	Bhagwat Kolde created
			[ ] // =========================================================
			[ ] STRING sResult
			[ ] STRING sMsgLine
			[ ] STRING sStepName, sShot = ""
			[ ] 
			[ ] //Generates Step ID for using in Steps Table
			[ ] //sStepName = objSteps.generateStepName()
			[ ] 
			[-] if (sMsg == NULL)
				[ ] sMsg = BLANK_STR
			[-] switch LogType
				[-] case "LogFailed"
					[ ] LogError("*** FAILED:  {sMsg}")
					[ ] sResult = "FAILED"
					[ ] //sShot = objSteps.captureSnapShot(sStepName)
					[ ] 
				[-] case "LogPassed"
					[ ] Print("*** PASSED:  {sMsg}")
					[ ] sResult = "PASSED"
					[ ] 
				[-] case "LogError"
					[ ] LogError("*** ERROR:   {sMsg}")
					[ ] sResult = "ERROR"
					[ ] //sShot = objSteps.captureSnapShot(sStepName)
					[ ] 
				[-] case "LogWarning"
					[ ] LogWarning ("*** WARNING: {sMsg}")
					[ ] sResult = "WARNING"
					[ ] 
				[-] default
					[ ] Print(sMsg)
					[ ] sResult = "INFO"
					[ ] 
			[ ] //Saves the Step details and result to the Steps table in TestDB.mdb
			[ ] //objSteps.saveStepTable(sResult, sStepName, sStepDescName,sShot, sMsg)
		[ ] 
		[-] VOID ResListOpen(STRING sName)
			[ ] // =========================================================
			[-] // METHOD NAME: ResListOpen()
				[ ] // DESCRIPTION:
				[ ] //   this method is used to open separate section in result file.
				[ ] // 
				[ ] // PARAMETERS:		STRING sName: Name of section
				[ ] //					
				[ ] // RETURNS:			NULL
				[ ] //
				[ ] // REVISION HISTORY:
				[ ] //	 Jan 10, 2007	Bhagwat Kolde created
			[ ] // =========================================================
			[ ] ResOpenList(sName)
			[ ] STRING	sIndent  = Replicate(CHR_TAB, this.iIndent)
			[ ] HFILE	hFile = NULL
			[-] if (IsSet(this.sFileNametxt))
				[ ] hFile = FileOpen(this.sFileNametxt, FM_APPEND)
				[ ] FileWriteLine(hFile, "{TimeStr()}{sIndent}	{sName}")
				[ ] FileClose(hFile)
			[ ] this.iIndent ++
			[ ] 
			[ ] 
		[ ] 
		[+] VOID ResListClose()
			[ ] // =========================================================
			[-] // METHOD NAME: ResListClose()
				[ ] // DESCRIPTION:
				[ ] //   this method is used to close opened section in result file.
				[ ] // 
				[ ] // PARAMETERS:		NULL
				[ ] //					
				[ ] // RETURNS:			NULL
				[ ] //
				[ ] // REVISION HISTORY:
				[ ] //	 Jan 10, 2007	Bhagwat Kolde created
			[ ] // =========================================================
			[ ] 
			[ ] // to close separate section in result file 
			[ ] ResCloseList()
			[-] if (this.iIndent > 0)
				[ ] this.iIndent --
			[ ] 
			[ ] 
		[ ] 
		[-] private void TestCaseStart()
			[ ] // =========================================================
			[-] // METHOD NAME: TestCaseStart()
				[ ] // DESCRIPTION:
				[ ] //   This method used to do required setups when script enter.
				[ ] // 
				[ ] // PARAMETERS:		NULL
				[ ] //					
				[ ] // RETURNS:			NULL
				[ ] //
				[ ] // REVISION HISTORY:
				[ ] //	 Jan 10, 2007	Bhagwat Kolde created
			[ ] // =========================================================
			[ ] 
			[ ] // to log script execution details in .txt file while starting script.
			[ ] // This function will be called in ScriptEnter()
			[ ] // 
			[ ] STRING	sLine
			[ ] STRING	sLineSeparate = Replicate ("=", 60)
			[ ] // HFILE	hFile
			[ ] // this.iIndent = 0
			[-] // if (!IsSet(this.sFileNametxt))
				[ ] // LogError("Log FileName is not set. Unable to Start Log file. Test results will be logged to .RES file only.") 
				[ ] // return
			[-] // if (SYS_FileExists(this.sFileNametxt))
				[-] // if (!this.bAppendMode)
					[ ] // SYS_RemoveFile(this.sFileNametxt)
			[-] do
				[-] LIST OF STRING	lsHeader = {...}
					[ ] sLineSeparate
					[ ] // logging information in result file
					[ ] "==	TEST CASE:		{sTCId}"
					[ ] "==	OBJECTIVE:		{sTCDesc}"
					[ ] "==	PRIORITY:		{sPriority}"
					[ ] "==	DEVELOPER:		{DEVELOPER}"
					[ ] sLineSeparate
					[ ] BLANK_STR
					[ ] 
				[ ] // open Log file
				[ ] // hFile = FileOpen(this.sFileNametxt, FM_APPEND)
				[ ] // write/print Log header
				[-] for each sLine in lsHeader
					[ ] // FileWriteLine (hFile, sLine)	// writing in text file
					[ ] Print(sLine)					// printing in result file
				[ ] // close Log file
				[ ] // FileClose(hFile)
				[ ] //sTCName= sTCId
				[ ] sTCName= GetTestCaseName()
				[ ] //Generate TestCase ID
				[ ] //sTestCaseId = objTCs.generateTCId()
				[ ] Print("In TC Start {sTestCaseId}")
				[ ] 
			[-] except
				[ ] // do nothing
				[ ] ExceptLog()
				[ ] 
			[ ] 
			[ ] 
		[ ] 
		[-] private Void ScriptStart() 
			[ ] // =========================================================
			[+] // METHOD NAME: ScriptStart()
				[ ] // DESCRIPTION:
				[ ] //   This method used to do required setups when script enter.
				[ ] // 
				[ ] // PARAMETERS:		NULL
				[ ] //					
				[ ] // RETURNS:			NULL
				[ ] //
				[ ] // REVISION HISTORY:
				[ ] //	 Jan 10, 2007	Bhagwat Kolde created
			[ ] // =========================================================
			[ ] 
			[ ] // to log script execution details in .txt file while starting script.
			[ ] // This function will be called in ScriptEnter()
			[ ] // 
			[ ] STRING	sLine
			[ ] STRING	sLineSeparate = Replicate ("=", 90)
			[ ] HFILE	hFile
			[ ] this.iIndent = 0
			[ ] Integer SuiteID = 0
			[+] if (!IsSet(this.sFileNametxt))
				[ ] LogError("Log FileName is not set. Unable to Start Log file. Test results will be logged to .RES file only.") 
				[ ] //return SuiteID
			[-] if (SYS_FileExists(this.sFileNametxt))
				[-] if (!this.bAppendMode)
					[ ] //SYS_RemoveFile(this.sFileNametxt)
			[-] do
				[-] LIST OF STRING	lsHeader = {...}
					[ ] sLineSeparate
					[ ] // logging information in result file
					[ ] "===  TEST SCRIPT:		{GetProgramName()}"
					[ ] "===  SCRIPT STARTED:	{DateStr()} {TimeStr()}"
					[ ] "===  PRODUCT NAME:		{PRODUCT_NAME}"
					[ ] "===  MILE STONE:		{CURRENT_BUILD}"
					[ ] "===  LOG FILE (.txt):   {this.sFileNametxt}"		
					[ ] 
					[ ] sLineSeparate
					[ ] BLANK_STR
					[ ] 
				[ ] // open Log file
				[ ] hFile = FileOpen(this.sFileNametxt, FM_APPEND)
				[ ] // write/print Log header
				[-] for each sLine in lsHeader
					[ ] FileWriteLine (hFile, sLine)	// writing in text file
					[ ] Print(sLine)					// printing in result file
				[ ] // close Log file
				[ ] FileClose(hFile)
				[ ] //SuiteID = objSuites.createSuite(SUITE_NAME)  - calling it from TestPlanEnter
			[-] except
				[ ] // do nothing
				[ ] ExceptLog()
				[ ] FileClose(hFile)
			[ ] 
		[ ] 
		[-] private void ScriptEnd()
			[ ] // =========================================================
			[-] // METHOD NAME: ScriptEnd()
				[ ] // DESCRIPTION:
				[ ] //   This method used to do required setups when script ends.
				[ ] // method logs script execution details in .txt file at script exist.
				[ ] // 
				[ ] // PARAMETERS:		NULL
				[ ] //					
				[ ] // RETURNS:			NULL
				[ ] //
				[ ] // REVISION HISTORY:
				[ ] //	 Jan 10, 2007	Bhagwat Kolde created
			[ ] // =========================================================
			[ ] 
			[ ] STRING	sLine
			[ ] STRING	sLineSeparate = Replicate ("=", 90)
			[ ] HFILE	hFile
			[ ] this.iIndent = 0
			[ ] INTEGER iTotalTCs = GetTestsPassedCount() + GetTestsFailedCount()
			[-] if (!IsSet(this.sFileNametxt))
				[ ] return
			[-] do
				[-] LIST OF STRING	lsFooter = {...}
					[ ] BLANK_STR
					[ ] sLineSeparate
					[ ] // logging information in result file
					[ ] "===  TEST SCRIPT:		{GetProgramName()}"
					[ ] "===  SCRIPT ENDED:		{DateStr()} {TimeStr()}"
					[ ] "===  TOTAL EXECUTED:   	{iTotalTCs}"
					[ ] "===  TOTAL PASSED:   	{GetTestsPassedCount()}"
					[ ] "===  PASSING PERC:		{(GetTestsPassedCount()*100)/iTotalTCs} %"
					[ ] "===  TOTAL FAILED:   	{GetTestsFailedCount()}"
					[ ] "===  FAILING PERC:		{(GetTestsFailedCount()*100)/iTotalTCs} %"
					[ ] sLineSeparate
					[ ] BLANK_STR
				[ ] // open Log file
				[ ] hFile = FileOpen(this.sFileNametxt, FM_APPEND)
				[ ] // write/print Log footer
				[-] for each sLine in lsFooter
					[ ] FileWriteLine(hFile, sLine)
					[ ] Print(sLine)
				[ ] // close Log file
				[ ] FileClose(hFile)
				[ ] 
			[-] except
				[ ] // do nothing
				[ ] ExceptLog()
				[ ] FileClose(hFile)
			[ ] 
		[ ] 
		[+] VOID Banner(STRING sMsg, STRING sBannerChar optional, INTEGER iWidth optional)
			[ ] // =========================================================
			[-] // METHOD NAME: Banner()
				[ ] // DESCRIPTION:
				[ ] //   this method is used to create Banner for specified message in result file
				[ ] // 
				[ ] // PARAMETERS:		STRING sMsg: Message in banner
				[ ] //					STRING sBannerChar optional: Char to print banner
				[ ] //					INTEGER iWidth optional : width for banner creation
				[ ] //					
				[ ] // RETURNS:			NULL
				[ ] //
				[ ] // REVISION HISTORY:
				[ ] //	 Jan 10, 2007	Bhagwat Kolde created
			[ ] // =========================================================
			[ ] 
			[ ] // 
			[ ] STRING	sLine
			[ ] STRING	sChar = "="
			[ ] 
			[-] if (iWidth == NULL)
				[ ] iWidth = 80
			[-] if (sBannerChar != NULL)
				[ ] sChar = sBannerChar
			[ ] STRING	sLineSeparate = Replicate (sChar, iWidth)
			[-] LIST OF STRING	lsBanner = {...}
				[ ] BLANK_STR
				[ ] sLineSeparate
				[ ] "{sChar}{sChar}	{sMsg}" // banner message after spaces
				[ ] sLineSeparate
				[ ] BLANK_STR
			[-] for each sLine in lsBanner
				[ ] this.Post("LogMessage", sLine)
		[ ] 
	[ ] 
	[-] winclass FileDlg : DialogBox
		[ ] 
		[-] StaticText FileNameText
			[ ] msw tag "File Name:"
			[ ] // pm tag "Open filename:"
		[-] TextField FileName
			[ ] msw tag "File Name:"
			[ ] // pm tag "Open filename:"
		[-] ListBox FileList
			[ ] msw tag "File Name:"
			[ ] // pm tag "File:"
		[-] ListBox DirList
			[ ] msw tag "#2"
			[ ] // pm tag "Directory:"
		[-] PopupList FileType
			[ ] tag "#1"
			[ ] // pm tag "Type of file:"
			[ ] msw9x tag "* type:" //
		[-] StaticText DrivesText
			[ ] msw tag "Drives:"
			[ ] // pm tag "Drive:"
		[-] PopupList Drives
			[ ] msw tag "Drives:"
			[ ] // pm tag "Drive:"
		[ ] 
		[-] StaticText DirectoriesText
			[ ] tag "Directories:"
		[-] StaticText CurrentDir
			[ ] tag "#3"
		[-] StaticText ListFilesOfTypeText
			[ ] tag "List Files of Type:"
		[ ] 
		[-] PushButton OK
			[ ] tag "OK"
		[-] PushButton Cancel
			[ ] tag "Cancel"
		[-] PushButton Info
			[ ] tag "Info"
		[-] PushButton SelectAll
			[ ] tag "Select All"
		[-] PushButton Network
			[ ] tag "Network"
		[ ] 
		[ ] WINDOW wDismiss = Cancel
		[ ] 
		[-] VerifyFilter (LIST OF STRING lsExpected)
			[ ] LIST OF STRING lsFileTypes = this.FileType.GetContents ()
			[ ] Verify (lsFileTypes, lsExpected)
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[-] winclass OpenDlg : FileDlg
		[-] PushButton Open
			[ ] tag OpenButtonTag ()
		[ ] 
		[ ] // This is the generic menu item to invoke the Open dialog.  If
		[ ] // the application uses something other than File.Open...  then this
		[ ] // variable needs to be over written.
		[ ] 
		[ ] WINDOW wInvoke = MainWin ("~ActiveApp").Menu ("File").MenuItem ("Open")
		[ ] 
		[+] STRING OpenButtonTag ()
			[ ] STRING sTag = "OK"
			[ ] 
			[ ] // This code, before the NT version was fixed, handled
			[ ] // the problem with the NT using 16 bit dialogs.
			[ ] // if GetGuiType() == msw95 && !IsWinNT()
			[+] // if GetGuiType () == msw95
				[ ] // sTag = "Open"
			[ ] 
			[ ] return (sTag)
		[ ] 
		[+] OpenFile (STRING sFileName)
			[ ] // Set a trap so that the "save changes?" messagebox gets dismissed.
			[ ] MessageBox.SetTrap("No")
			[ ] Invoke ()
			[ ] sleep (1)
			[ ] MessageBox.ClearTrap ()
			[ ] 
			[ ] FileName.SetText (sFileName)
			[ ] Open.Click ()
		[ ] 
	[ ] 
	[-] winclass SaveAsDlg : FileDlg
		[ ] 
		[-] PushButton Save
			[ ] tag SaveButtonTag ()
		[ ] 
		[ ] // This is the generic menu item to invoke the Open dialog.  If
		[ ] // the application uses something other than File.Open...  then this
		[ ] // variable needs to be over written.
		[ ] WINDOW wInvoke = MainWin ("~ActiveApp").Menu ("File").MenuItem ("Save As")
		[ ] 
		[-] STRING SaveButtonTag ()
			[ ] STRING sTag = "OK"
			[ ] 
			[ ] // This code, before the NT version was fixed, handled
			[ ] // the problem with the NT using 16 bit dialogs.
			[ ] // if GetGuiType() == msw95 && !IsWinNT()
			[+] // if GetGuiType () == msw95 //Commented by Poonam
				[ ] // sTag = "Save"
			[ ] 
			[ ] return (sTag)
		[ ] 
		[-] hidecalls SaveFile (STRING sFileName)
			[ ] Invoke ()
			[ ] FileName.SetText (sFileName)
			[ ] MessageBox.SetTrap ("Yes")
			[ ] Save.Click ()
			[ ] MessageBox.ClearTrap ()
		[ ] 
	[ ] 
	[-] winclass PathDlg : DialogBox
		[ ] 
		[-] StaticText FileNameText
			[ ] tag "File Name:"
		[-] ComboBox FileName
			[ ] tag "File Name:"
		[-] PushButton OK
			[ ] tag "OK"
		[-] PushButton Cancel
			[ ] tag "Cancel"
		[-] PushButton Browse
			[ ] tag "Browse"
		[-] PushButton Edit
			[ ] tag "Edit"
		[-] PushButton Help
			[ ] tag "Help"
		[ ] 
		[-] hidecalls SetPath (STRING sFileName)
			[ ] Invoke ()
			[ ] FileName.SetText (sFileName)
			[ ] OK.Click ()
		[ ] 
	[ ] 
	[-] winclass FontDlg : DialogBox
		[ ] 
		[-] StaticText FontText
			[ ] tag "Font:"
		[-] ComboBox Font
			[ ] tag "Font:"
		[-] StaticText FontStyleText
			[ ] tag "Font style:"
		[-] ComboBox FontStyle
			[ ] tag "Font style:"
		[-] StaticText SizeText
			[ ] tag "Size:"
		[-] ComboBox Size
			[ ] tag "Size:"
		[-] PushButton OK
			[ ] tag "OK"
		[-] PushButton Cancel
			[ ] tag "Cancel"
		[-] StaticText Effects1Text
			[ ] tag "Effects[1]"
		[-] CheckBox Strikeout
			[ ] tag "Strikeout"
		[-] CheckBox Underline
			[ ] tag "Underline"
		[-] StaticText ColorText
			[ ] tag "Color:"
		[-] PopupList Color
			[ ] tag "Color:"
		[-] StaticText SampleText
			[ ] tag "Sample"
		[-] StaticText Effects2Text
			[ ] tag "Effects[2]"
		[-] StaticText ScriptText
			[ ] tag "Script:"
		[-] PopupList Script
			[ ] tag "Script:"
		[ ] 
		[-] hidecalls SetFont (STRING sFontName, STRING sFontStyle, STRING sFontSize)
			[ ] this.Font.Select (sFontName)
			[ ] this.FontStyle.Select (sFontStyle)
			[ ] this.Size.Select (sFontSize)
			[ ] this.OK.Click ()
		[ ] 
	[ ] 
	[-] winclass NewDlg : DialogBox
		[ ] 
		[-] PushButton OK
			[ ] tag "OK"
		[-] PushButton Cancel
			[ ] tag "Cancel"
		[-] RadioList FileType
			[ ] tag "#1"
		[ ] 
		[-] hidecalls New (STRING sFileType)
			[ ] 
			[ ] Invoke ()
			[ ] FileType.Select (sFileType)
			[ ] OK.Click ()
		[ ] 
		[ ] 
	[ ] 
	[-] winclass AboutDlg : DialogBox
		[ ] tag "About *"
		[ ] 
		[-] StaticText AppName
			[ ] tag "#1"
		[-] StaticText Version
			[ ] tag "Version*"
		[-] PushButton OK
			[ ] tag "OK"
		[ ] 
		[ ] WINDOW wDismissButton = OK
		[ ] 
		[-] hidecalls STRING GetVersionNumber ()
			[ ] STRING sTemp = Version.GetCaption ()
			[ ] 
			[ ] sTemp = StrTran (sTemp, "Version ", "")
			[ ] 
			[ ] sTemp = Trim (sTemp)
			[ ] 
			[ ] return (sTemp)
		[ ] 
		[-] hidecalls VerifyVersionNumber (STRING sExpected)
			[ ] STRING sActual = this.GetVersionNumber ()
			[ ] 
			[-] do
				[ ] Verify (sActual, sExpected)
			[-] except
				[-] if (GetField (sActual, '.', 1) != GetField (sExpected, '.', 1))
					[ ] LogError ("VerifyVersionNumber: Major Version Numbers do not match")
				[-] if (GetField (sActual, '.', 2) != GetField (sExpected, '.', 2))
					[ ] LogError ("VerifyVersionNumber: Minor Version Numbers do not match")
				[-] if (GetField (sActual, '.', 3) != GetField (sExpected, '.', 3))
					[ ] LogWarning ("VerifyVersionNumber: Build numbers do not match")
			[ ] 
		[ ] 
		[-] hidecalls STRING GetAppName ()
			[ ] return (this.AppName.GetCaption ())
		[ ] 
		[-] hidecalls VerifyAppName (STRING sExpected)
			[ ] Verify (this.GetAppName (), sExpected)
		[ ] 
		[-] hidecalls Verify (STRING sExpectedName, STRING sExpectedNumber)
			[ ] BOOLEAN bFailed = False
			[ ] 
			[ ] Invoke ()
			[ ] 
			[-] do
				[ ] this.VerifyAppName (sExpectedName)
			[-] except
				[ ] bFailed = True
				[ ] LogError (ExceptData ())
			[ ] 
			[-] do
				[ ] this.VerifyVersionNumber (sExpectedNumber)
			[-] except
				[ ] bFailed = True
				[ ] LogError (ExceptData ())
			[ ] 
			[ ] Dismiss ()
			[ ] 
			[-] if bFailed
				[ ] raise 123, "Error verifying About Dialog {this}"
		[ ] 
	[ ] 
[ ] // ==========================================================
