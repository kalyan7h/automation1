[ ] // *********************************************************
[+] // FILE NAME:	Install.inc
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This file contains all the generic functions required for Quicken Install module.
	[ ] //
	[ ] // DEPENDENCIES:	Includes.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 27/June/11 Udita Dube  Created
[ ] // *********************************************************
[ ] 
[ ] // *********************************************************
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] use "msw32.inc"
	[+] // dll "shell32.dll"
		[ ] // HINSTANCE ShellExecute (in HWND hwnd,in STRING lpOperation,in STRING lpFile,in STRING lpParameters,in STRING lpDirectory, in INT nShowCmd) alias "ShellExecuteW"
	[ ] 
	[ ] // *********************************************************
[ ] // *********************************************************
[ ] 
[ ] // Window declarations
[+] window FileDlg QuickenInstallWizard
	[+] multitag "Quicken 201* - Install Wizard"
		[ ] "$MessageBox[1]"
	[+] PushButton Next
		[+] multitag "Next >"
			[ ] "#1"
			[ ] "$1"
			[ ] "@(336,338)"
	[+] PushButton Cancel
		[+] multitag "Cancel"
			[ ] "#2"
			[ ] "$2"
			[ ] "@(442,338)"
	[+] PushButton Back
		[+] multitag "< Back"
			[ ] "^or financial information will be sent to Intuit.[2]"
			[ ] "#3"
			[ ] "$1017"
			[ ] "@(237,336)"
	[+] CheckBox AcceptLicense
		[+] multitag "I agree to the terms of the license agreement and acknowledge receipt of the"
			[ ] "#1"
			[ ] "$1080"
			[ ] "@(245,252)"
	[+] CustomWin LicenseWindow
		[+] multitag "[BitMap]#1"
			[ ] "[BitMap]$1006"
			[ ] "[BitMap]@(253,30)"
		[+] StaticText PleaseReadTheFollowingLice
			[+] multitag "Please read the following license agreement carefully."
				[ ] "^License Agreement"
				[ ] "#2"
				[ ] "$1011"
				[ ] "@(162,44)"
		[+] StaticText LicenseAgreement
			[+] multitag "License Agreement"
				[ ] "#1"
				[ ] "$1010"
				[ ] "@(99,21)"
	[+] PushButton Install
		[+] multitag "Install"
			[ ] "$1"
			[ ] "@(336,338)"
			[ ] "^Note: We recommend turning off your anti-virus program while you install Quicken. This is because anti-virus programs can somet|#2"
	[+] PushButton Done
		[+] multitag "Done"
			[ ] "#1"
			[ ] "$1"
			[ ] "@(442,338)"
	[+] CustomWin InstallationDone
		[+] multitag "[BitMap]#1"
			[ ] "[BitMap]$1006"
			[ ] "[BitMap]@(253,156)"
		[+] CheckBox LaunchQuicken
			[+] multitag "Launch Quicken 201*"
				[ ] "^The wizard has successfully installed Quicken 201?.  Click Done to close this wizard."
				[ ] "#1"
				[ ] "$1030"
				[ ] // "@(328,185)"
		[+] StaticText TheWizardHasSuccessfullyIn
			[+] multitag "The wizard has successfully installed Quicken 201?.  Click Done to close this wizard."
				[ ] "^Installation Complete"
				[ ] "#2"
				[ ] "$1013"
				[ ] "@(351,112)"
		[+] StaticText InstallationComplete
			[+] multitag "Installation Complete"
				[ ] "#1"
				[ ] "$1010"
				[ ] "@(350,38)"
	[ ] 
	[+] CustomWin BitMap1
		[+] multitag "[BitMap]#1"
			[ ] "[BitMap]$132"
			[ ] "[BitMap]@(253,156)"
	[+] StaticText WelcomeToQuicken2012Text
		[+] multitag "Welcome to Quicken 201?!"
			[ ] "#1"
			[ ] "$1108"
			[ ] "@(338,36)"
	[+] StaticText LetSGetStartedClickNext
		[+] multitag "Let's get started. Click ?Next? to continue."
			[ ] "#4"
			[ ] "$1053"
			[ ] "@(341,255)"
	[+] CustomWin NoteThisProgramIsProtect2
		[+] multitag "[BitMap]?Note: This program is protected by copyright law and ?  international treaties."
			[ ] "[BitMap]#2"
			[ ] "[BitMap]$1012"
			[ ] "[BitMap]@(253,313)"
[+] window MainWin Installer
	[ ] tag "[DialogBox]Quicken 201* - Install Wizard"
[ ] 
[ ] 
[ ] // Global variables
[ ] public STRING sQuickenYearInfo = QUICKEN_YEAR_INFO
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: Check_Quicken_Existing()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will verify that Quicken is installed or not
	[ ] //
	[ ] // PARAMETERS:		None
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS = If Quicken exists 
	[ ] //									FAIL = if Quicken not exist
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	June 29, 2011	Udita Dube Created
[ ] // ==========================================================
[+] public BOOLEAN Check_Quicken_Existing(STRING sExePath optional)
	[ ] // Variable declaration
	[ ] BOOLEAN bActual, bResult
	[ ] 
	[-] if(sExePath== NULL)
		[ ] bActual = SYS_FileExists (sExe)
		[+] if( bActual)
			[ ] bResult = TRUE
		[+] else
			[ ] bResult = FALSE
	[-] else
		[ ] bActual = SYS_FileExists (sExePath)
		[-] if( bActual)
			[ ] bResult = TRUE
		[-] else
			[ ] bResult = FALSE
		[ ] 
	[ ] 
	[ ] return bResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: Quicken_Install()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will install Quicken by wizard
	[ ] //
	[ ] // PARAMETERS:		None
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS = If Quicken installed successfully
	[ ] //									FAIL = if any error occurs while installation
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	June 29, 2011	Udita Dube Created
[ ] // ==========================================================
[+] public INTEGER Quicken_Install()
	[ ] 
	[ ] // Variable declaration
	[ ] BOOLEAN bFound
	[ ] STRING sSetupExe,sLatest, sCaption, sExpectedQuicken
	[ ] STRING sLicenseAgreement = "License Agreement"
	[ ] sExpectedQuicken = "Quicken {sQuickenYearInfo}"
	[ ] 
	[-] do
		[ ] sLatest = GetLatestBuild()										// get latset build no.
		[ ] sSetupExe= INSTALL_BUILD_PATH + "\" + sLatest + "\{SKU_TOBE_TESTED}\DISK1\Setup.exe"
		[ ] 
		[-] if(SYS_FileExists (sSetupExe))
			[ ] Installer.Start(sSetupExe)
			[-] if(QuickenInstallWizard.Exists(LONG_SLEEP))
				[ ] QuickenInstallWizard.SetActive()
				[ ] QuickenInstallWizard.Next.Click()
				[-] if("License Agreement"==QuickenInstallWizard.LicenseWindow.LicenseAgreement.GetText())
					[ ] QuickenInstallWizard.SetActive()
					[ ] QuickenInstallWizard.AcceptLicense.Check()
					[ ] QuickenInstallWizard.Next.Click()
					[ ] QuickenInstallWizard.SetActive()
					[ ] QuickenInstallWizard.Next.Click()
					[ ] QuickenInstallWizard.SetActive()
					[ ] QuickenInstallWizard.Install.Click()
					[ ] sleep(EXTRA_LONG_SLEEP)
					[ ] QuickenInstallWizard.SetActive()
					[-] if(QuickenInstallWizard.Done.Exists(8800))
						[ ] QuickenInstallWizard.Done.Click()
						[ ] 
						[+] if(ProductRegistration.Exists(SHORT_SLEEP))
							[ ] ProductRegistration.Close()
						[ ] QuickenWindow.SetActive()
						[ ] QuickenMainWindow.VerifyEnabled(TRUE, 40)
						[ ] sCaption = QuickenMainWindow.GetCaption ()
						[ ] 	
						[ ] bFound = MatchStr("*{sExpectedQuicken}*", sCaption)
						[+] if(bFound == TRUE)
							[ ] iFunctionResult = PASS
						[+] else
							[ ] iFunctionResult = FAIL
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Installation successful page", FAIL, "Installation successful page not found") 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify License window", FAIL, "License window not found") 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify wizard exists", FAIL, "Wizard is not available")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Setup.exe Existence", ABORT, "Setup.exe does not exist") 
			[ ] iFunctionResult = ABORT
			[ ] 
		[ ] 
		[ ] 
	[+] except
		[ ] ExceptLog()
		[ ] iFunctionResult = ABORT
	[ ] 
	[ ] return iFunctionResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: Quicken_Install_Silently(List of STRING lsSKU optional)
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will install Quicken Silently
	[ ] //
	[ ] // PARAMETERS:		List of STRING lsSKU  {"RPM","HAB"}
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS = If Quicken installed successfully
	[ ] //							FAIL = if any error occurs while installation
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	Feb 05, 2014	Udita Dube Created
[ ] // ==========================================================
[+] public INTEGER Quicken_Install_Silently(List of STRING lsSKU optional)
	[ ] 
	[ ] // Variable declaration
	[ ] BOOLEAN bFound,bMatch
	[ ] INTEGER i,j
	[ ] LIST OF STRING lsSKUName
	[ ] STRING sLatest, sCaption, sExpectedQuicken,sActual,sCmdLine ,sSKUPath,sSource
	[ ] sExpectedQuicken = "Quicken {sQuickenYearInfo}"
	[ ] sCmdLine= "%ProgramFiles%\Quicken\qw.exe"
	[ ] lsSKUName={"Rental Property Manager", "Home & Business", "Premier", "Deluxe", "Starter Edition"}
	[ ] // lsSKU={"RPM","HAB","PREMIER","DELUXE","QNUE"}
	[ ] 
	[ ] 
	[ ] // If lsSKU is not provided then it installs the already installed SKU
	[-] if(lsSKU==NULL)
		[ ] lsSKU={"{SKU_TOBE_TESTED}"}
	[ ] 
	[-] for(i=1;i<=ListCount(lsSKU);i++)
		[-] do
			[ ] sLatest = GetLatestBuild()										// get latset build no.
			[ ] sSKUPath = INSTALL_BUILD_PATH + "\" + sLatest + "\{lsSKU[i]}"
			[ ] 
			[ ] sSource = sSKUPath + "\DISK1\Setup.exe"
			[ ] SYS_Execute(sSource + " /s")			// command for installing quicken
			[ ] 
			[ ] App_Start(sCmdLine)
			[+] if (QuickenTSM.Exists(20))
				[ ] QuickenTSM.SetActive()
				[ ] QuickenTSM.RemindMeLater.Uncheck()
				[ ] QuickenTSM.Close()
				[ ] 
			[+] if(QuickenUpgrade.Exists(SHORT_SLEEP))
				[ ] QuickenUpgrade.SetActive()
				[ ] QuickenUpgrade.Cancel.Click()
			[+] if(QuickenWindow.Exists(10))
				[ ] QuickenWindow.SetActive()
				[ ] sActual= QuickenWindow.GetCaption()
			[+] for(j=1;j<=ListCount(lsSKU);j++)
				[ ] bMatch = MatchStr("*{lsSKUName[j]}*", sActual)
				[+] if(bMatch)
					[ ] ReportStatus("Quicken SKU {lsSKU[i]} is installed",PASS,"Quicken SKU {lsSKU[i]} is installed successfully")
					[ ] iFunctionResult=PASS
					[ ] break
				[+] else if(j==ListCount(lsSKU))
					[ ] ReportStatus("Quicken SKU {lsSKU[i]} is installed",FAIL,"Quicken SKU {lsSKU[i]} is not installed successfully, Actual - {sActual}, Expected - {lsSKUName[j]}")
					[ ] iFunctionResult=FAIL
					[ ] 
			[ ] 
			[ ] QuickenWindow.Kill()
		[+] except
			[ ] ExceptLog()
			[ ] iFunctionResult = ABORT
	[ ] 
	[ ] return iFunctionResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: Validate_Dsk_Icon()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // Validates the existence of the desktop icon based on SKU
	[ ] //
	[ ] // PARAMETERS:		STRING     sSKU        Name of the SKU
	[ ] //                                      BOOLEAN bExists     TRUE / FALSE
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS = If quicken icon displayed on desktop
	[ ] //									FAIL = if quicken icon not displayed on desktop
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	June 29, 2011	Udita Dube Created
[ ] // ==========================================================
[+] public INTEGER Validate_Dsk_Icon(STRING sSKU, BOOLEAN bExists)
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN bFound
		[ ] STRING sShortcutName
		[ ] const DESKTOP = Sys_GetEnv("Desktop")
	[ ] 
	[+] do
		[ ] 
		[ ] // Construct Shortcut name as per SKU
		[+] if(sSKU == "QNUE")
			[ ] sShortcutName= "Quicken " + SKU_QNUE + " " + sQuickenYearInfo + ".lnk"
			[ ] 
		[+] else if (sSKU == "Deluxe")
			[ ] sShortcutName= "Quicken " + SKU_DELUXE + " " + sQuickenYearInfo + ".lnk"
			[ ] 
		[+] else if (sSKU == "Premier")
			[ ] sShortcutName= "Quicken " + SKU_PREMIER + " " + sQuickenYearInfo + ".lnk"
			[ ] 
		[+] else if (sSKU == "HAB")
			[ ] sShortcutName= "Quicken " + SKU_HAB + " " + sQuickenYearInfo + ".lnk"
			[ ] 
		[+] else if (sSKU == "RPM")
			[ ] sShortcutName= "Quicken " + SKU_RPM + " " + sQuickenYearInfo + ".lnk"
		[+] else
			[ ] 
		[ ] 
		[ ] // Check existence of Quicken shortcut which is displayed on desktop
		[ ] bFound=SYS_FileExists(DESKTOP+ "\" + sShortcutName)
		[+] if(bFound == bExists)
			[ ] iFunctionResult = PASS
		[+] else
			[ ] iFunctionResult = FAIL
		[ ] 
	[+] except
		[ ] iFunctionResult = FAIL
	[ ] 
	[ ] return iFunctionResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: Validate_Start_Menu()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // Validates the existence of the start menu quicken items
	[ ] //
	[ ] // PARAMETERS:		STRING      sSKU        Name of the SKU
	[ ] //                                      BOOLEAN  bExists     TRUE / FALSE
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS = If quicken items are availabe / not available in start menu
	[ ] //									FAIL = if quicken items not available / available in start menu
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	June 30, 2011	Udita Dube Created
[ ] // ==========================================================
[+] public INTEGER Validate_Start_Menu(STRING sSKU, BOOLEAN bExists)
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN  bFound
		[ ] LIST of FILEINFO lsContent
		[ ] INTEGER i,iCount
		[ ] ARRAY[3] OF STRING Files_array
		[ ] 
		[ ] const STRING START_MENU = "C:\Documents and Settings\All Users\Start Menu\Programs"
		[ ] const STRING QUICKEN_VERSION = "Quicken "+ sQuickenYearInfo
		[ ] 
		[ ] Files_array[1] = "Billminder.lnk"
		[ ] Files_array[2] = QUICKEN_VERSION + ".lnk"
		[ ] Files_array[3] = "Quicken Online Backup.lnk"
	[ ] 
	[+] do
		[ ] 
		[+] if(bExists == TRUE)
			[ ] 
			[ ] lsContent = SYS_GetDirContents(START_MENU + QUICKEN_VERSION)
			[ ] print(lsContent)
			[ ] iCount = ListCount (lsContent)
			[ ] 
			[+] for(i=1;i<=iCount;i++)
				[ ] 
				[+] if(sSKU == "QNUE")
					[ ] 
					[+] if(iCount>2)
						[ ] ReportStatus("Validate Number of Files under Start Menu", FAIL, "Number of files under Start Menu are more. Please Verify.") 
						[ ] 
					[ ] //bFound=SYS_FileExists(START_MENU + QUICKEN_VERSION + "\" + Files_array[i])
					[+] if(MatchStr(Files_array[i+1], lsContent[i].sName))
						[ ] iFunctionResult = PASS
					[+] else
						[ ] ReportStatus("Validate Files under Start Menu", PASS, "Expected File: {Files_array[i+1]} and Actual File: {lsContent[i].sName}") 
						[ ] iFunctionResult = FAIL
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[+] if(iCount>3)
						[ ] ReportStatus("Validate Number of Files under Start Menu", FAIL, "Number of files under Start Menu are more. Please Verify.") 
						[ ] 
					[+] if(MatchStr(Files_array[i], lsContent[i].sName))
						[ ] iFunctionResult = PASS
					[+] else
						[ ] ReportStatus("Validate Files under Start Menu", PASS, "Expected File: {Files_array[i+1]} and Actual File: {lsContent[i].sName}") 
						[ ] iFunctionResult = FAIL
						[ ] 
					[ ] 
		[+] else
			[ ] lsContent = SYS_GetDirContents(START_MENU)
			[ ] iCount = ListCount (lsContent)
			[ ] print(lsContent)
			[+] for(i=1;i<=iCount;i++)
				[+] if(lsContent[i].sName != QUICKEN_VERSION)
					[ ] iFunctionResult = PASS
				[+] else
					[ ] ReportStatus("Validate Quicken folder under Start Menu", FAIL, "Quicken folder is available at {START_MENU + QUICKEN_VERSION}") 
					[ ] iFunctionResult = FAIL
					[ ] break
					[ ] 
		[ ] 
		[ ] 
	[+] except
		[ ] iFunctionResult = FAIL
	[ ] return iFunctionResult
[ ] // ==========================================================
[+] // FUNCTION: Validate_Registry()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // Validates the existence of the registry items
	[ ] //
	[ ] // PARAMETERS:		BOOLEAN  bExists     TRUE / FALSE
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS = If registry entries are availabe / not available 
	[ ] //									FAIL = if registry entries are not available / available 
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	July 5, 2011	Udita Dube Created
[ ] // ==========================================================
[+] public INTEGER Validate_Registry( BOOLEAN bExists)
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN  bRegistry1,bRegistry2,bMatch
		[ ] INTEGER iKey1,iKey2
		[ ] STRING sPath1, sItem1,sValue,sPath2,sItem2, sEntry1,sEntry2
		[ ] 
		[ ] // First Registry Entry for Quicken
		[ ] iKey1=HKEY_LOCAL_MACHINE
		[ ] sPath1 = "SOFTWARE\Intuit\Quicken"
		[ ] sItem1 = "ExePath"
		[ ] 
		[ ] // Second Registry entry for Quicken
		[ ] iKey2 = HKEY_CLASSES_ROOT
		[ ] sPath2 = "Installer\Products\BB4DD4306D0FFCE40B46E8933EFE0767"			// "BB4DD4306D0FFCE40B46E8933EFE0767" value is specif to the Quicken version 2013 need to change if the version is upgraded
		[ ] sItem2 = "ProductName"
		[ ] 
		[+] if(bExists == TRUE)
			[ ] sEntry1= "Registry Entry is present"
			[ ] sEntry2 = "Registry Entry is not present"
		[+] else
			[ ] sEntry1= "Registry Entry is not present"
			[ ] sEntry2 = "Registry Entry is present"
	[ ] 
	[+] do
		[ ] 
		[ ] // Check registry values exists in the registry 
		[ ] bRegistry1 = RegValueExists(iKey1,sPath1,sItem1)
		[ ] // Get other registry value which has product name
		[ ] bRegistry2 = RegValueExists(iKey2,sPath2,sItem2)
		[+] if(bRegistry2 == TRUE)
			[ ] sValue = SYS_GetRegistryValue (iKey2, sPath2, sItem2)
			[ ] bMatch = MatchStr("Quicken {sQuickenYearInfo}", sValue)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Registry Entry", PASS, "Registry entry 'Quicken {sQuickenYearInfo}' found in the registry")
				[ ] iFunctionResult = PASS
			[+] else
				[ ] ReportStatus("Validate Registry Entry", FAIL, "Registry entry Actual: {sValue} is not matching with Expected: Quicken {sQuickenYearInfo}")
				[ ] iFunctionResult = FAIL
			[ ] 
		[ ] 
		[ ] 
		[+] if (bRegistry1 == bExists && bRegistry2 == bExists)
			[ ] ReportStatus("Validates the existence of the registry items", PASS, "Quicken {sEntry1} at {iKey1}\{sPath1} and {iKey2}\{sPath2}") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Validates the existence of the registry items", FAIL, "Quicken {sEntry2} at {iKey1}\{sPath1} and {iKey2}\{sPath2}") 
			[ ] iFunctionResult = FAIL
		[ ] 
		[ ] 
	[+] except
		[ ] iFunctionResult = FAIL
	[ ] return iFunctionResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: Validate_Installed_Files()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // Validates the existence of the installed files
	[ ] //
	[ ] // PARAMETERS:		STRING      sSKU        Name of the SKU
	[ ] //                                      BOOLEAN  bExists     TRUE / FALSE
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS = If installed files validation successfully
	[ ] //									FAIL = if installed files validation not done
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	July 5, 2011	Udita Dube Created
[ ] // ==========================================================
[+] public INTEGER Validate_Installed_Files(STRING sSKU, BOOLEAN bExists)
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN  bActual,bFile,bMatch
		[ ] STRING sLatest,sSource,sLine,sAllUserQuickenDirPath
		[ ] HFILE hFile
		[ ] 
		[ ] LoadOSDependency()
		[ ] sAllUserQuickenDirPath=SYS_GetEnv("AllUserQuickenDirPath")
		[ ] sLatest = GetLatestBuild()		
		[ ] sSource = INSTALL_BUILD_PATH + "\" + sLatest + "\logs\qa_"+ lower(sSKU)+".txt"
		[ ] //sSource = INSTALL_BUILD_PATH + "\" + sLatest + "\logs\"+ lower(sSKU)+".txt"
		[ ] 
	[ ] 
	[+] do
		[ ] 
		[ ] // Check registry values exists in the registry 
		[ ] bActual = SYS_FileExists (sSource)
		[+] if(bActual == TRUE)
			[ ] hFile = SYS_FileOpen (sSource, FM_READ)
			[ ] // Read file line by line
			[+] while (FileReadLine (hFile, sLine))
				[ ] // Construct the path for each line
				[+] if(MatchStr("*ALLUSERSDIR*",sLine))
					[ ] sLine = StrTran (sLine, "%ALLUSERSDIR%", sAllUserQuickenDirPath)
				[+] else if (MatchStr("*COMMONDIR*",sLine))
					[ ] sLine = StrTran (sLine, "%COMMONDIR%", "C:\Program Files\Common Files")
				[+] else if (MatchStr("*QID*",sLine))
					[ ] sLine = StrTran (sLine, "%QID%", "C:\Program Files\Quicken")
				[+] else if (MatchStr("*SYSTEMDIR*",sLine))
					[ ] sLine = StrTran (sLine, "%SYSTEMDIR%", "C:\Windows\System32")
				[+] else
					[ ] 
				[ ] // Verify file existece on hard disk
				[ ] bFile = SYS_FileExists (sLine)
				[+] if(bFile == FALSE)
					[ ] bMatch = FALSE
					[ ] ReportStatus("Validate installed files", FAIL, "{sLine} is not found") 
					[ ] 
				[ ] 
			[ ] FileClose (hFile)
			[+] if( bMatch  == bExists)
				[ ] iFunctionResult = PASS
			[+] else
				[ ] iFunctionResult = FAIL
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[ ] 
	[+] except
		[ ] iFunctionResult = FAIL
	[ ] return iFunctionResult
[ ] 
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: Validate_About_Quicken()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // Validates the About Quicken window
	[ ] //
	[ ] // PARAMETERS:		STRING  sSKU     Name of the SKU
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS = If Quicken version and SKU information are right
	[ ] //									FAIL = if Quicken version and SKU information are wrong
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	July 4, 2011	Udita Dube Created
	[ ] //     Nov 24,2011  Puja Verma Edited
[ ] // ==========================================================
[-] public INTEGER Validate_About_Quicken(STRING sSKU)
	[ ] 
	[+] // Variable declaration
		[ ] STRING sActualAboutQuicken,sExpected, sName
		[ ] INTEGER iPos
		[ ] 
		[+] if(sSKU == "RPM" || sSKU == "rpm")
			[ ] sName = SKU_RPM
		[+] else if (sSKU == "HAB" || sSKU == "hab")
			[ ] sName = SKU_HAB
		[+] else if (sSKU == "Deluxe" || sSKU == "deluxe")
			[ ] sName = SKU_DELUXE
		[+] else if (sSKU == "Premier" || sSKU == "premier")
			[ ] sName = SKU_PREMIER
		[+] else if (sSKU == "QNUE" || sSKU == "qnue")
			[ ] sName = SKU_QNUE
		[+] else
			[ ] sName = sSKU
		[ ] 
		[ ] 
		[ ] sExpected = "Quicken {sQuickenYearInfo} {sName}"
		[ ] 
	[ ] 
	[-] do
		[ ] 
		[ ] // Active Quicken Screen
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Help > About Quicken
		[ ] QuickenWindow.Help.Click()
		[ ] QuickenWindow.Help.AboutQuicken.Select()
		[ ] // Get Quicken's Actual Year information
		[ ] //sActualAboutQuicken= AboutQuicken.QuickenVersion.GetText()
		[ ] 
		[ ] // Verify that actual year information is correct
		[ ] iPos= StrPos(sExpected, sActualAboutQuicken)
		[+] if( iPos != 0)
			[ ] ReportStatus("Validate About Quicken", PASS, "SKU and Year information - {sExpected} is correct") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Validate About Quicken", FAIL, "Actual SKU and Year - {sActualAboutQuicken} is not matching with Expected  - {sExpected}") 
			[ ] iFunctionResult = FAIL
		[ ] // Close About Quicken window
		[ ] AboutQuicken.Close()
		[ ] 
		[ ] 
	[-] except
		[-] if(AboutQuicken.Exists())
			[ ] AboutQuicken.Close()
		[ ] iFunctionResult= FAIL
		[ ] 
	[ ] 
	[ ] return iFunctionResult
[ ] 
[ ] 
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: Quicken_Install_Validate()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will validate installation of Quicken by:
	[ ] // Validate existence of the desktop icon based on SKU
	[ ] // Validate existence of the start menu quicken items
	[ ] // Validate existence in registry
	[ ] // Validate installed files
	[ ] // Validate About Quicken
	[ ] //
	[ ] // PARAMETERS:		STRING 	sSKU   Name of the SKU
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS = If Quicken installation validated successfully
	[ ] //									FAIL = if any error occurs while validation
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	July 04, 2011	Udita Dube Created
[ ] // ==========================================================
[-] public INTEGER Quicken_Install_Validate(STRING sSKU)
	[ ] 
	[-] // Variable declaration
		[ ] INTEGER iValidateDskIcon, iValidateStartMenu,iValidateAboutQuicken, iValidateRegistry, iValidateInstalledFiles
	[ ] 
	[-] do
		[ ] 
		[ ] // Validate the existence of the desktop icon based on SKU
		[ ] iValidateDskIcon = Validate_Dsk_Icon(sSKU, TRUE)
		[+] if (iValidateDskIcon == PASS)
			[ ] ReportStatus("Validate the existence of the desktop icon", PASS, "Quicken Desktop icon exists") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Validate the existence of the desktop icon", FAIL, "Desktop icon does not exist") 
			[ ] iFunctionResult = FAIL
		[ ] 
		[ ] // Validates the existence of the start menu quicken items
		[ ] iValidateStartMenu= Validate_Start_Menu(sSKU, TRUE)
		[+] if (iValidateStartMenu == PASS)
			[ ] ReportStatus("Validate the existence of the start menu quicken items", PASS, "Start menu quicken items exist") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Validate the existence of the start menu quicken items", FAIL, "Start menu quicken items do not exist") 
			[ ] iFunctionResult = FAIL
		[ ] 
		[ ] // Validates the existence of the registry items
		[ ] iValidateRegistry= Validate_Registry(TRUE)
		[+] if (iValidateRegistry == PASS)
			[ ] ReportStatus("Validate the existence of the registry items", PASS, "Validation of Quicken registry is done successfully") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Validate the existence of the registry items", FAIL, "Validation of Quicken registry is failed") 
			[ ] iFunctionResult = FAIL
		[ ] 
		[ ] // Validates the existence of the installed files on the hard disk
		[ ] iValidateInstalledFiles= Validate_Installed_Files(sSKU,TRUE)
		[+] if (iValidateInstalledFiles == PASS)
			[ ] ReportStatus("Validate the existence of installed files on the hard disk", PASS, "Installed files are available on the hard disk") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Validate the existence of installed files on the hard disk", FAIL, "All Installed files are not available on the hard disk") 
			[ ] iFunctionResult = FAIL
		[ ] 
		[ ] 
		[ ] // //Validates About Quicken window
		[ ] // iValidateAboutQuicken= Validate_About_Quicken(sSKU)
		[+] // if (iValidateAboutQuicken == PASS)
			[ ] // ReportStatus("Validate About Quicken", PASS, "Validation of Quicken SKU and Year information is done successfully") 
			[ ] // iFunctionResult = PASS
		[+] // else
			[ ] // ReportStatus("Validate About Quicken", FAIL, "Validation of Quicken SKU and Year information is failed") 
			[ ] // iFunctionResult = FAIL
		[ ] 
		[ ] 
	[+] except
		[ ] iFunctionResult = FAIL
	[ ] 
	[ ] return iFunctionResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: Quicken_Uninstall()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will uninstall Quicken silently
	[ ] //
	[ ] // PARAMETERS:		None
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS = If Quicken uninstalled successfully
	[ ] //									FAIL = if any error occurs while uninstallation
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	July 04, 2011	Udita Dube Created
[ ] // ==========================================================
[+] public INTEGER Quicken_Uninstall()
	[ ] 
	[-] // Variable declaration
		[ ] LIST OF STRING lsDir,lsFile
		[ ] HFILE hFile
		[ ] BOOLEAN bAssert, bActual, bDeleteStatus
		[ ] INTEGER iDeleteStatus
		[ ] STRING sSource, sLatest, sLine, sProductId ="" 
		[ ] // sAllUserQuickenDirPath=SYS_GetEnv("AllUserQuickenDirPath")
		[ ] // sQuickenIniPath=SYS_GetEnv("QuickenIniPath")
		[ ] // sInstallerDirPath=SYS_GetEnv("InstallerDirPath")
		[ ] // sIntuitDirPath=SYS_GetEnv("IntuitDirPath")
		[ ] 
	[ ] 
	[-] do
		[ ] 
		[ ] LoadOSDependency()
		[ ] // Get latset build no.
		[ ] sLatest = GetLatestBuild()									
		[ ] sSource = INSTALL_BUILD_PATH + "\" + sLatest + "\{SKU_TOBE_TESTED}\DISK1\Setup.ini"
		[ ] 
		[ ] // Check if Quicken is installed on Machine or Not
		[ ] bActual = Check_Quicken_Existing ()
		[+] if( bActual == FALSE)
			[ ] Log.Warning("Uninstall Quicken","qw.exe is not available on machine. So no need to uninstall Quicken")
			[ ] iFunctionResult = FAIL
			[ ] return iFunctionResult 
		[+] else
			[+] if (FileExists(sSetUpDestPath) == TRUE)
				[ ] DeleteFile(sSetUpDestPath)
			[ ] CopyFile(sSource, sSetUpDestPath) 						// copy Setup.ini from source dir to c:\
			[ ] 
			[ ] hFile = FileOpen (sSetUpDestPath, FM_READ) 
			[ ] FileReadLine (hFile, sLine)
			[ ] 
			[+] while(FileReadLine (hFile, sLine))
					[+] if (MatchStr ("*ProductCode*", sLine)) 
						[ ] sProductId = SubStr(sLine,13) 										// only the code of the product is returned
						[+] if (MatchStr ("*}*", sProductId) && (MatchStr ("*"{*", sProductId)) && (sProductId != "") )
							[ ] SYS_Execute("msiexec.exe /X"+ sProductId+ " /Q")				// Command for uninstalling Quicken
			[ ] FileClose (hFile)
			[ ] 
		[ ] 
		[ ] // Load O/S specific Paths and Variables
		[ ] LoadOSDependency()
		[ ] 
		[ ] bActual = SYS_FileExists (sExe)
		[ ] bAssert = AssertFalse(bActual)							// Verify qw.exe File in Quicken Folder
		[+] if(bAssert == TRUE)
			[ ] ReportStatus("Uninstall Quicken", PASS, "Quicken is uninstalled successfully") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Uninstall Quicken", FAIL, "Quicken is not uninstalled properly") 
			[ ] iFunctionResult = FAIL
		[ ] 
		[ ] bDeleteStatus = DeleteDir(sAllUserQuickenDirPath)
		[+] if (bDeleteStatus == TRUE)
			[ ] ReportStatus("Delete Quicken All User profile", PASS, "Quicken All User profile -  {sAllUserQuickenDirPath} is deleted") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Delete Quicken All User profile", FAIL, "Quicken All User profile -  {sAllUserQuickenDirPath} is not deleted") 
			[ ] iFunctionResult = FAIL
		[ ] 
		[ ] bDeleteStatus = DeleteDir(sIntuitDirPath)
		[+] if (bDeleteStatus == TRUE)
			[ ] ReportStatus("Quicken User profile", PASS, "Quicken User profile - {sIntuitDirPath} is deleted") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Quicken User profile", FAIL, "Quicken User profile - {sIntuitDirPath} is not deleted") 
			[ ] iFunctionResult = FAIL
		[ ] 
		[ ] bDeleteStatus = DeleteDir(QUICKEN_ROOT)		// Deleting folders related to Quicken				
		[+] if (bDeleteStatus == TRUE)
			[ ] ReportStatus("Delete Quicken Dir", PASS, "Quicken Dir - {QUICKEN_ROOT} is deleted") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Delete Quicken Dir", FAIL, "Quicken Dir - {QUICKEN_ROOT} is not deleted") 
			[ ] iFunctionResult = FAIL
		[ ] 
		[ ] lsDir= GetDirTree(INSTALL_BUILD_PATH + "\" + sLatest+ "\{SKU_TOBE_TESTED}")
		[ ] lsFile= GetDirectoryListing(INSTALL_BUILD_PATH + "\" + sLatest+ "\{SKU_TOBE_TESTED}")
		[ ] ListDelete(lsDir, 1)
		[ ] 
		[ ] // Comparing total directories in source folder
		[+] if(SKU_TOBE_TESTED=="QNUE")
			[ ] bAssert = AssertEquals(21, ListCount(lsDir))			
		[+] else
			[ ] bAssert = AssertEquals(18, ListCount(lsDir))			// Comparing total directories in source folder
		[+] if ( bAssert == TRUE)
			[ ] ReportStatus("Validate Directory count from Installation Build", PASS, "Actual Directory count - {ListCount(lsDir)} is matching with Expected - 18") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Validate Directory count from Installation Build", FAIL, "Actual Directory count - {ListCount(lsDir)} is not matching with Expected - 18")
			[ ] iFunctionResult = FAIL 
		[ ] 
		[ ] // Comparing total files in source folder
		[+] if(SKU_TOBE_TESTED=="QNUE")
			[ ] bAssert = AssertEquals(61, ListCount(lsFile))			
		[+] else
			[ ] bAssert = AssertEquals(51, ListCount(lsFile))		// Comparing total files in source folder
		[+] if ( bAssert == TRUE)
			[ ] ReportStatus("Validate File count from Installation Build", PASS, "Actual File count - {ListCount(lsFile)} is matching with Expected - 51")
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Validate File count from Installation Build", FAIL, "Actual File count - {ListCount(lsFile)} is not matching with Expected - 51")
			[ ] iFunctionResult = FAIL
		[ ] 
		[ ] 
	[+] except
		[ ] iFunctionResult = FAIL
	[ ] 
	[ ] return iFunctionResult
[ ] 
[ ] // ==========================================================
[+] // FUNCTION: Quicken_Uninstall_Validate()
	[ ] //
	[ ] // DESCRIPTION:
	[ ] // This function will validate uninstallation of Quicken by:
	[ ] // No existence of the desktop icon based on SKU
	[ ] // No existence of the start menu quicken items
	[ ] // No existence in registry
	[ ] //
	[ ] // PARAMETERS:		STRING 	sSKU   Name of the SKU
	[ ] //
	[ ] // RETURNS:			INTEGER	PASS = If Quicken uninstallation validated successfully
	[ ] //									FAIL = if any error occurs while validation
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	July 04, 2011	Udita Dube Created
[ ] // ==========================================================
[+] public INTEGER Quicken_Uninstall_Validate(STRING sSKU)
	[ ] 
	[-] // Variable declaration
		[ ] INTEGER iValidateDskIcon, iValidateStartMenu,iValidateRegistry
	[ ] 
	[-] do
		[ ] 
		[ ] // Validate the existence of the desktop icon based on SKU
		[ ] iValidateDskIcon = Validate_Dsk_Icon(sSKU, FALSE)
		[+] if (iValidateDskIcon == PASS)
			[ ] ReportStatus("Validate the existence of the desktop icon", PASS, "Desktop icon does not exist after Quicken uninstallation") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Validate the existence of the desktop icon", FAIL, "Desktop icon exists even after uninstallation of Quicken") 
			[ ] iFunctionResult = FAIL
		[ ] 
		[ ] //Validates the existence of the start menu quicken items
		[ ] iValidateStartMenu= Validate_Start_Menu(sSKU, FALSE)
		[+] if (iValidateStartMenu == PASS)
			[ ] ReportStatus("Validate the existence of the start menu quicken items", PASS, "Start menu quicken items do not exist after Quicken uninstallation") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Validate the existence of the start menu quicken items", FAIL, "Start menu quicken items exist even after uninstallation of Quicken") 
			[ ] iFunctionResult = FAIL
		[ ] 
		[ ] // Validates the existence of the registry items
		[ ] iValidateRegistry= Validate_Registry(FALSE)
		[+] if (iValidateRegistry == PASS)
			[ ] ReportStatus("Validate the existence of the registry items", PASS, "Validation of Quicken registry is done successfully") 
			[ ] iFunctionResult = PASS
		[+] else
			[ ] ReportStatus("Validate the existence of the registry items", FAIL, "Validation of Quicken registry is failed") 
			[ ] iFunctionResult = FAIL
		[ ] 
		[ ] 
		[ ] 
	[+] except
		[ ] iFunctionResult = FAIL
	[ ] 
	[ ] return iFunctionResult
[ ] 
