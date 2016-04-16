[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	QuickenToolsLib.inc
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This file contains all the generic functions required for different quicken tools (e.g. qwauto, intuonl etc).
	[ ] //
	[ ] // DEPENDENCIES:	Includes.inc
	[ ] //
	[ ] // DEVELOPED BY:	Chandan Abhyankar
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 03/Jan/11 Chandan Abhyankar	Created
[ ] // *********************************************************
[ ] 
[ ] // *********************************************************
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: SetUp_AutoApi()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will copy the autoapi.dll file to Quicken directory. 
	[ ] // this is a pre-requisite for using QwAuto tool.
	[ ] //
	[ ] // PARAMETERS:		none
	[ ] //
	[ ] // RETURNS:			INTEGER	0	File is copied
	[ ] //									1	File is not copied
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 05, 2010	Mamta Jain created
[ ] // ==========================================================
[+] public INTEGER SetUp_AutoApi()
	[ ] 
	[+] do
		[ ] INTEGER iFunctionResult
		[+] if(DirExists(QUICKEN_ROOT) == FALSE)
			[ ] SYS_MakeDir (QUICKEN_ROOT)
		[+] if(FileExists(sAutoApiDestinationPath) == FALSE)
			[ ] CopyFile(sAutoApiSourcePath, sAutoApiDestinationPath)
		[ ] iFunctionResult = PASS
	[+] except
		[ ] iFunctionResult = FAIL
	[ ] return iFunctionResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: StartQwAuto()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will start QwAuto if it is not open.
	[ ] //
	[ ] // PARAMETERS:		none
	[ ] //
	[ ] // RETURNS:			INTEGER	0 = If started or active
	[ ] //									1 = If not started
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 06, 2010	Mamta Jain created
[ ] // ==========================================================
[+] public INTEGER StartQwAuto()
	[ ] INTEGER iFunctionResult
	[+] do
		[ ] 
		[+] if(!QuickenAutomationInterface.Exists())
			[ ] QuickenAutomationInterface.Start(sQwAutoPath)
			[ ] 
		[+] if (QuickenAutomationInterface.Exists(MEDIUM_SLEEP))
			[ ] QuickenAutomationInterface.SetActive()
			[ ] iFunctionResult = PASS
		[+] else
			[ ] iFunctionResult = FAIL
	[+] except
		[ ] iFunctionResult = FAIL
		[ ] logExceptionAndExit()
	[ ] return iFunctionResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: QwAutoExecuteCommand()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will fire a query sCommand.
	[ ] // and will reurn the result of the query and close the window.
	[ ] 
	[ ] //
	[ ] // PARAMETERS:		STRING 	sCommand		command
	[ ] //									sHandle			handle of the Window/Listbox
	[ ] //									sThird 				can be row no., search string..
	[ ] //									sFourth			can be column no.
	[ ] //
	[ ] // RETURNS:			STRING	Result of the fired query
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 10, 2010	Mamta Jain created
	[ ] //	 Feb 12, 2014	Govind Babhulgaonkar	updated	
[ ] // ==========================================================
[+] public STRING QwAutoExecuteCommand(STRING sCommand, STRING sHandle, STRING sThird optional, STRING sFourth optional)
	[ ] 
	[ ] INTEGER iStartToolStatus
	[ ] STRING sOutputString = ""
	[ ] 
	[+] do
		[ ] SetUp_AutoApi()
		[ ] iStartToolStatus = StartQwAuto()
		[ ] 
		[+] if(iStartToolStatus == PASS)
			[+] if(sThird == NULL)
				[ ] sThird = ""
			[+] if (sFourth == NULL)
					[ ] sFourth = ""
			[ ] QuickenAutomationInterface.CommandString.SetText ("{sCommand},  {sHandle}, {sThird}, {sFourth}")
			[ ] QuickenAutomationInterface.ProcessCommand.Click()
			[ ] 
			[ ] QuickenAutomationInterface.VerifyEnabled(TRUE,20)
			[ ] sOutputString = QuickenAutomationInterface.CommandOutput.GetText()
			[ ] 
			[ ] sleep(SHORT_SLEEP)
			[ ] 
			[ ] QuickenAutomationInterface.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("Invoke QWAUTO Tool", FAIL, "QWAUTO Tool is not launched") 
	[+] except
		[ ] raise 1, "ERROR: Command execution failed in Qw Auto" 
	[ ] 
	[ ] return sOutputString
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: SetUpLocalFile()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will copy the qa_acc32.dll file to Quicken directory.  (e.g. C:\Program Files\Quicken)
	[ ] // this is a pre-requisite for using intuonl Tool.
	[ ] //
	[ ] // PARAMETERS:		none
	[ ] //
	[ ] // RETURNS:			INTEGER	0	Setup is complete
	[ ] //									1	Setup is failed
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 23, 2010	Chandan Abhyankar created
[ ] // ==========================================================
[+] public INTEGER SetUpLocalFile()
	[ ] 
	[ ] INTEGER iFunctionResult
	[ ] 
	[+] do
		[ ] //Added by Mukesh Sep12 2012
		[ ] LoadOSDependency()
		[ ] sleep(2)
		[+] if(DirExists(QUICKEN_ROOT) == FALSE)
			[ ] SYS_MakeDir (QUICKEN_ROOT)
		[+] if(FileExists(sAccDllDestinationPath) == FALSE)
			[ ] CopyFile(sAccDllSourcePath, sAccDllDestinationPath)
		[ ] 
		[ ] sDestinationonliniFile=SYS_GetEnv ("AllUserQuickenDirPath")+"\Config\Intu_onl.ini"
		[ ] 
		[+] if(FileExists(sDestinationonliniFile) == FALSE)
			[ ] CopyFile(sIntuonlSourcePath, sDestinationonliniFile)
			[ ] 
		[ ] //Added by Mukesh Sep12 2012
		[+] // // Delete file intu_onl.ini located in WIndows directory
			[ ] // DeleteFile(SYS_GetEnv("WINDIR") + "\\intu_onl.ini")
		[ ] // 
		[ ] iFunctionResult = PASS
	[+] except
		[ ] iFunctionResult = ABORT
		[ ] 
	[ ] return iFunctionResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: ConfigureIntuonl( LIST OF STRING lsIntuonlConfiguration)
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will invoke intuonl Tool and configure it as per supplied parameters.
	[ ] //
	[ ] // PARAMETERS:		STRINGS	Different settings required for Tool
	[ ] //  These settings are stored in intu_onl.ini file
	[ ] // STRING sLocalFile	0 for live mode, 1 for localfile mode
	[ ] //
	[ ] // STRING branding	0 for uncheck, 1 for never update, 2 for always update
	[ ] //
	[ ] // STRING profile		0 for uncheck, 1 for never update, 2 for always update	
	[ ] //
	[ ] // STRING skipsync	0 for don't skip, 1 for skip sync session
	[ ] //
	[ ] // STRING forceer		0 for uncheck, 1 for check
	[ ] //
	[ ] // STRING erflag		0 for no er, 1 for 1st session, 2 for 1st banking session
	[ ] //				3 for 1st billpay session
	[ ] //
	[ ] // RETURNS:			INTEGER	0 = If operation is successful
	[ ] //									1 = If operation is failed
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 06, 2010	Mamta Jain created
[ ] // ==========================================================
[+] public INTEGER ConfigureIntuonl( STRING sLocalFile,STRING sBranding, STRING sProfile, STRING sSkipSync,STRING sForceer,STRING sErflag )
	[ ] 
	[ ] LIST OF STRING lsIntuonlConfiguration
	[+] do
		[ ] INTEGER iFunctionResult
		[ ] iFunctionResult = PASS
		[ ] 
		[ ] lsIntuonlConfiguration = {sLocalFile, sBranding, sProfile, sSkipSync, sForceer, sErflag}
		[ ] 
		[ ] CreateIntuonl(lsIntuonlConfiguration)
	[ ] 
	[ ] 
	[+] except
		[ ] iFunctionResult = FAIL
		[ ] 
	[ ] 
	[ ] return iFunctionResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: CreateIntuonl( LIST OF STRING lsIntuonlConfiguration)
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will invoke intuonl Tool and configure it as per supplied parameters. At the end it creates intuonl_ini file.
	[ ] // intuonl_ini file is stores in Windows directory
	[ ] //
	[ ] // PARAMETERS:		LIST OF STRINGS	Different settings required for Tool
	[ ] //  These settings are stored in intu_onl.ini file
	[ ] //			["localfile"]			0 for uncheck, 1 for check
	[ ] //			["ofxsend"]			0 for no, 1 for yes (default = 1)
	[ ] //			["connlog"]			0 for no, 1 for yes (default = 1)
	[ ] //			["olclocal"]			0 for no, 1 for yes (default = 0)
	[ ] //			["nopromqbp"]		0 for no, 1 for yes (default = 0)
	[ ] //			["signonpin"]		0 for no, 1 for yes (default = 1)
	[ ] //			["forceer"]			0 for no, 1 for yes (default = 0)
	[ ] //			["erflag"]			0 for none, 1 for 1st session,
	[ ] //								2 for 1st banking session,
	[ ] //								3 for 1st billpay session
	[ ] //			["signonver"]		0 for no, 1 for yes (default = 0)
	[ ] //			["signonverstr"]	signon version string
	[ ] //			["anonsignon"]		0 for no, 1 for yes (default = 0)
	[ ] //			["skipssl"]			0 for no, 1 for yes (default = 1)
	[ ] //			["skiplog"]			0 for no, 1 for yes (default = 0)
	[ ] //			["skipsyncwrap"]	0 for no, 1 for yes (default = 0)
	[ ] //			["skipsync"]		0 for no, 1 for yes (default = 0)
	[ ] //			["nogoodfund"]	0 for no, 1 for yes (default = 0)
	[ ] //			["noacctinfo"]		0 for no, 1 for yes (default = 0)
	[ ] //			["brandenv"]		0 for no, 1 for yes (default = 0)
	[ ] //			["brandenvstr"]		branding environment string
	[ ] //			["branding"]		0 for uncheck, 1 for never, 2 always
	[ ] //								3 for custom time
	[ ] //			["brandtime"]		number for days to expire
	[ ] //			["profile"]			0 for uncheck, 1 for never, 2 always
	[ ] //								3 for custom time
	[ ] //			["profiletime"]		number for days to expire
	[ ] //
	[ ] //
	[ ] // RETURNS:			INTEGER	0 = If operation is successful
	[ ] //									1 = If operation is failed
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 06, 2010	Mamta Jain created
[ ] // ==========================================================
[+] public INTEGER CreateIntuonl( LIST OF STRING lsIntuonlConfiguration )
	[ ] 
	[ ] INTEGER iFunctionResult
	[ ] iFunctionResult = FAIL
	[ ] 
	[+] do
		[ ] 
		[+] if(!Intuonl.Exists())
			[ ] //SYS_Execute(sIntuonlPath)
			[ ] ShellExecute (0, "open", sIntuonlPath, "", "", 1)
		[ ] Intuonl.VerifyEnabled(TRUE, 20)
		[ ] Intuonl.SetActive()
		[+] if (lsIntuonlConfiguration[1] == "0")
			[ ] Intuonl.UseLocalfileTool.SetState(FALSE)
		[+] else
			[ ] Intuonl.UseLocalfileTool.SetState(TRUE)
		[ ] 
		[+] if (lsIntuonlConfiguration[2] == "0")
			[ ] Intuonl.BrandingEnv.SetState(FALSE)
		[+] else
			[ ] Intuonl.BrandingEnv.SetState(TRUE)
		[ ] 
		[+] if (lsIntuonlConfiguration[3] == "0")
			[ ] Intuonl.UpdateProfile.SetState(FALSE)
		[+] else
			[ ] Intuonl.UpdateProfile.SetState(TRUE)
		[ ] 
		[+] if (lsIntuonlConfiguration[4] == "0")
			[ ] Intuonl.SkipSyncSession.SetState(FALSE)
		[+] else
			[ ] Intuonl.SkipSyncSession.SetState(TRUE)
		[ ] 
		[+] if (lsIntuonlConfiguration[5] == "0")
			[ ] Intuonl.ForceErrRecovery.SetState(FALSE)
		[+] else
			[ ] Intuonl.ForceErrRecovery.SetState(TRUE)
			[ ] 
			[+] switch(lsIntuonlConfiguration[6])
					[+] case "1"
						[ ] Intuonl.ConnectionAndRequests1.Select("First session")
					[+] case "2"
						[ ] Intuonl.ConnectionAndRequests1.Select("First banking session")
					[+] case "3"
						[ ] Intuonl.ConnectionAndRequests1.Select("First billpay session")
					[+] default
						[ ] Intuonl.ConnectionAndRequests1.Select("No error recovery")
		[ ] 
		[ ] Intuonl.OK.Click()
		[ ] sleep(SHORT_SLEEP)
		[ ] 
		[+] if (Intuonl.Exists() == TRUE)
			[ ] Intuonl.close()
			[ ] 
		[ ] 
		[ ] iFunctionResult = PASS
		[ ] 
	[ ] 
	[+] except
		[ ] iFunctionResult = FAIL
		[ ] 
	[ ] return iFunctionResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: EnterFakeResponseFile( STRING sResposeFile)
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will invoke intuonl Tool and configure it as per supplied parameters. At the end it creates intuonl_ini file.
	[ ] // intuonl_ini file is stores in Windows directory
	[ ] //
	[ ] // PARAMETERS:		STRING	Response.DAT file used by Local File Testing
	[ ] //
	[ ] // RETURNS:			INTEGER	0 = If operation is successful
	[ ] //									1 = If operation is failed
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 06, 2010	Mamta Jain created
[ ] // ==========================================================
[+] public INTEGER EnterFakeResponseFile( STRING sResposeFile)
	[ ] INTEGER iFunctionResult
	[ ] BOOLEAN sFileExistStatus
	[ ] 
	[ ] sFileExistStatus = FileExists(sResposeFile)
	[+] if (sFileExistStatus == TRUE)
		[ ] FakeResponse.Exists(180)
		[ ] //FakeResponse.VerifyEnabled(TRUE, 120)
		[ ] FakeResponse.SetActive()
		[ ] FakeResponse.LocalFileSource.SetText(sResposeFile)
		[ ] FakeResponse.Continue.Click()
		[ ] iFunctionResult = PASS
		[ ] 
	[+] else
		[ ] ReportStatus("Fake Respose for LocalFile Testing", FAIL, "File - {sResposeFile} is not available") 
		[ ] iFunctionResult = FAIL
		[ ] 
	[ ] return iFunctionResult
	[ ] 
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: SetUp_StageMiniConfig()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will copy the autoapi.dll file to Quicken directory. 
	[ ] // this is a pre-requisite for using QwAuto tool.
	[ ] //
	[ ] // PARAMETERS:		none
	[ ] //
	[ ] // RETURNS:			INTEGER	0	File is copied
	[ ] //									1	File is not copied
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 05, 2013	Mukesh created
	[ ] //  Oct 08, 2014  Udita updated
[ ] // ==========================================================
[+] public INTEGER SetUp_StageMiniConfig(STRING sEnv optional)
	[ ] INTEGER iFunctionResult
	[ ] STRING sStageBullseyeURLSourcePath,sStageintu_onlSourcePath
	[ ] 
	[ ] // sEnv = Stage-mini
	[ ] // sEnv = Stage
	[ ] print(SYS_GetEnv("AllUserQuickenDirPath"))
	[ ] 
	[ ] 
	[+] do
		[+] if(IsNull(sEnv))
			[ ] 
			[+] if(DirExists(QUICKEN_ROOT) == FALSE)
				[ ] SYS_MakeDir (QUICKEN_ROOT)
			[+] if(FileExists(sBullseyeURLDestinationPath) == FALSE)
				[ ] CopyFile(sBullseyeURLSourcePath, sBullseyeURLDestinationPath)
			[+] if(FileExists(sintu_onlpreprodDestinationPath) == FALSE)
				[ ] CopyFile(sintu_onlpreprodSourcePath, sintu_onlpreprodDestinationPath)
				[ ] 
			[+] if(FileExists(sAccDllDestinationPath) == FALSE)
				[ ] CopyFile(sAccDllSourcePath, sAccDllDestinationPath)
				[ ] 
		[+] else
			[ ] 
			[ ] sStageBullseyeURLSourcePath=sAutomationToolsPath + "\{sEnv}\BullseyeURL.ini"
			[ ] sStageintu_onlSourcePath=sAutomationToolsPath + "\{sEnv}\intu_onl.ini"
			[ ] sAccDllSourcePath=sAutomationToolsPath + "\{sEnv}\qa_acc32.dll"
			[ ] 
			[ ] sBullseyeURLDestinationPath="C:\ProgramData\Intuit\Quicken\Inet\Common\Localweb\Bullseye\BullseyeURL.ini"
			[ ] sintu_onlpreprodDestinationPath="C:\ProgramData\Intuit\Quicken\Config\intu_onl.ini"
			[ ] sAccDllDestinationPath="C:\Program Files\Quicken\qa_acc32.dll"
			[ ] 
			[ ] print(sStageBullseyeURLSourcePath)
			[ ] print(sStageintu_onlSourcePath)
			[ ] print(sAccDllSourcePath)
			[ ] print(sBullseyeURLDestinationPath)
			[ ] print(sintu_onlpreprodDestinationPath)
			[ ] print(sAccDllDestinationPath)
			[ ] 
			[ ] 
			[ ] 
			[+] if(DirExists(QUICKEN_ROOT) == FALSE)
				[ ] SYS_MakeDir (QUICKEN_ROOT)
			[+] if(FileExists(sBullseyeURLDestinationPath) == FALSE)
				[ ] CopyFile(sStageBullseyeURLSourcePath, sBullseyeURLDestinationPath)
			[+] else
				[ ] DeleteFile(sBullseyeURLDestinationPath)
				[ ] sleep(1)
				[ ] CopyFile(sStageBullseyeURLSourcePath, sBullseyeURLDestinationPath)
				[ ] 
			[+] if(FileExists(sintu_onlpreprodDestinationPath) == FALSE)
				[ ] CopyFile(sStageintu_onlSourcePath, sintu_onlpreprodDestinationPath)
				[ ] 
			[+] else
				[ ] DeleteFile(sintu_onlpreprodDestinationPath)
				[ ] sleep(1)
				[ ] CopyFile(sStageintu_onlSourcePath, sintu_onlpreprodDestinationPath)
			[+] if(FileExists(sAccDllDestinationPath) == FALSE)
				[ ] CopyFile(sAccDllSourcePath, sAccDllDestinationPath)
			[+] else
				[ ] DeleteFile(sAccDllDestinationPath)
				[ ] sleep(1)
				[ ] CopyFile(sAccDllSourcePath, sAccDllDestinationPath)
				[ ] 
		[ ] iFunctionResult = PASS
	[+] except
		[ ] ExceptLog()
		[ ] iFunctionResult = FAIL
	[ ] 
	[ ] 
	[ ] return iFunctionResult
[ ] 
[ ] 
