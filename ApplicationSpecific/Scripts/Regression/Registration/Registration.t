[ ] 
[+] // FILE NAME:	<Registration.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script will fill the registration form
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Puja Verma
	[ ] //
	[ ] // Developed on: 		13/12/2011
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 13, 2011	Puja Verma  Created
	[ ] // *********************************************************
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] //GLOBAL Variable
	[ ] // public STRING sArchiveLocation = "\\ps7088\TestingService"
	[ ]  public STRING sTestServiceSource="\\mtvfs04\QPFG\Public\Registration\TestingService\TestService"
	[ ] public HANDLE hDB
	[ ]  public HANDLE hSQL 
	[ ] public STRING sSheetname="Registration"
	[ ] public STRING sQDFFileName="Quicken Registration"
	[ ] public STRING sTabName1 ="Build location"
	[ ] public STRING sRegistration = LoadControlsDataXLSPath("sXLname")
	[ ] public STRING sWorksheet="Registration details"
	[ ] BOOLEAN bWorksheet
	[ ] Datetime dTime = GetDateTime()
	[ ] String sDate = FormatDateTime(dTime, "mm_dd_yy")
	[ ] STRING sLogFileName= LOG_FOLDER + DELIMITER +  "QuickenDesktop" + "_"+ sDate + ".log"
	[ ] LIST OF STRING lsArgs =  GetArgs ()
	[ ] STRING sZipCode="{ROOT_PATH}\Quicken\zip"
	[ ] INTEGER i
	[ ]  LIST OF ANYTYPE lsExcelData
	[ ] public  STRING InstallerFolder="{ROOT_PATH}\Installer"
	[ ] 
[ ] //FUNCTIONS
[ ] 
[ ] // This Function use for cleanup and result save in derire location.
[+]  Quicken_RegistrationClean() 
	[ ] //VARIABLES
	[ ] STRING  sDate, sNewTarget, sFolderName, sNewLogPath, sNewDataXLSPath,sEmailCmd,sEmailId, XLSDataTestServicePath, sTestServiceArchieveLocation
	[ ] BOOLEAN bCopyStatus, bExists, bResult
	[ ] STRING sUserName, sSource = AUT_DATAFILE_PATH + "\" + sQDFFileName + ".QDF"	
	[ ] sEmailCmd = "Perl {APP_PATH}\Tools\EmailUtility\Email.pl"		
	[ ] XLSDataTestServicePath  = sTestServiceSource  + "\" + "TestService\Once\{lsArgs[1]}\{sSheetname}.xls"
	[ ] 
	[ ] // Read the data from Controls TAB
	[ ] //LoadControlsDataXLSPath()
	[ ] sEmailId = SYS_GetEnv ("EmailAddress")
	[ ] print(sEmailId)
	[ ] sUserName = SYS_GetEnv ("TesterName")
	[ ] print(sUserName)
	[ ] sTestServiceArchieveLocation = SYS_GetEnv("OutputLocation")
	[ ] print(sTestServiceArchieveLocation)
	[ ] 
	[-] if(QuickenAutomationInterface.Exists() == TRUE)
		[ ] QuickenAutomationInterface.Close()
	[ ] 
	[+] if(QuickenMainWindow.Exists(SHORT_SLEEP) == TRUE)
		[ ] QuickenMainWindow.Exit()
	[ ] 
	[ ] // Copy Logs to Location
	[ ] sDate = FormatDateTime(dTime, "mmm d")			// change the format of date to "ddmm"
	[ ] sFolderName = sTestServiceArchieveLocation + "\" + sDate + "_" + lsArgs[1] + "_Archieve"
	[ ] sleep(SHORT_SLEEP)		
	[+] if(!SYS_DirExists(sFolderName))
		[ ] SYS_MakeDir(sFolderName)
	[ ] 
	[ ] sNewTarget = sFolderName + DELIMITER  + sQDFFileName + ".QDF"
	[ ] sNewLogPath = sFolderName + DELIMITER  + "QuickenDesktop" + "_"+ sDate + ".log"
	[ ] sNewDataXLSPath = sFolderName + DELIMITER  + sSheetname + ".xls"
	[ ] 
	[ ] // Copy Log file to Archieve location
	[-] if(FileExists(LOCAL_QUICKEN + DELIMITER+"Result"))
		[ ] bCopyStatus = CopyDir(LOCAL_QUICKEN + DELIMITER+"Result", sNewLogPath)
		[-] if(bCopyStatus == TRUE)
			[ ] ReportStatus("Log Copy", PASS, "Log File -  {sNewLogPath} is copied successfully")
		[-] else
			[ ] ReportStatus("Log Copy", FAIL, "Log File -  {sNewLogPath} is not copied successfully")
	[ ] bExists = SYS_DirExists(LOCAL_QUICKEN + DELIMITER+"Result")
	[+] if(bExists==TRUE)
		[ ] DeleteDir(LOCAL_QUICKEN + DELIMITER+"Result")
	[ ] // Copy QDF file to Archieve location
	[+] if(FileExists(sSource) == TRUE)
			[ ] bCopyStatus = CopyFile(sSource, sNewTarget)
			[-] if(bCopyStatus == TRUE)
				[ ] ReportStatus("Data File Copy ", PASS, "Data file -  {sNewTarget} is copied successfully")
			[-] else
				[ ] ReportStatus("Data File Copy ", FAIL, "Data file -  {sNewTarget} is not copied successfully")
	[-] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sSource} is not available")
	[ ] 
	[ ] // Copy XLS file to Archieve location
	[+] // if(FileExists(XLSDataTestServicePath))
		[ ] // bCopyStatus = CopyFile(XLSDataTestServicePath, sNewDataXLSPath)
		[-] // if(bCopyStatus == TRUE)
			[ ] // ReportStatus("XLS Copy", PASS, "XLS File -  {sNewDataXLSPath} is copied successfully")
		[-] // else
			[ ] // ReportStatus("XLS Copy", FAIL, "XLS File -  {sNewDataXLSPath} is not copied successfully")
	[ ] 
	[ ] // Delete Smoke Data file from Testing Services
	[-] if(SYS_GetEnv("RunFrequency") == "Once")
		[-] if(FileExists(XLSDataTestServicePath))
			[ ] //bResult = DeleteFile(XLSDataTestServicePath)
			[-] // if (bResult == TRUE)
				[ ] // ReportStatus("Delete TestService Source Data", PASS, "TestService Data - {XLSDataTestServicePath} is deleted") 
			[-] // else
				[ ] // ReportStatus("Delete TestService Source Data", FAIL, "TestService Data - {XLSDataTestServicePath} is not deleted") 
		[-] // else
			[ ] // ReportStatus("TestService Data File", FAIL, "TestService Data - {XLSDataTestServicePath} is not present") 
	[ ] // Sys_Execute(sZipCode)
	[ ] // 
	[ ] // Call Email Utility
	[ ] SYS_Execute(sEmailCmd + " " +sTestServiceArchieveLocation + " " + sUserName + " " + sEmailId )
	[ ] 
[ ] 
[ ] //This function will perform the setup and unstall the quicken from control panel.
[+] InstallSetup(STRING sSKU)
	[+] // Variable declaration
		[ ] BOOLEAN bActual
		[ ] HFILE hFile
		[ ] STRING sSource, sLatest, sLine, sProductId ="" 
		[ ] // Get latset build no.
		[ ] //sLatest = GetLatestBuild()									
		[ ] sSource = INSTALL_BUILD_PATH + "\" + "{sSKU}\DISK1\Setup.ini"
		[ ] 
	[ ] 
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] // Check if Quicken is installed on Machine or Not
	[ ] bActual = Check_Quicken_Existing ()
	[-] if( bActual == TRUE)
		[-] if (FileExists(sSetUpDestPath) == TRUE)
			[ ] DeleteFile(sSetUpDestPath)
		[ ] CopyFile(sSource, sSetUpDestPath) 						// copy Setup.ini from source dir to c:\
		[ ] 
		[ ] hFile = FileOpen (sSetUpDestPath, FM_READ) 
		[ ] FileReadLine (hFile, sLine)
		[ ] 
		[-] while(FileReadLine (hFile, sLine))
				[-] if (MatchStr ("*ProductCode*", sLine)) 
					[ ] sProductId = SubStr(sLine,13) 										// only the code of the product is returned
					[-] if (MatchStr ("*}*", sProductId) && (MatchStr ("*"{*", sProductId)) && (sProductId != "") )
						[ ] SYS_Execute("msiexec.exe /X"+ sProductId+ " /Q")				// Command for uninstalling Quicken
		[ ] FileClose (hFile)
		[ ] 
	[-] else
		[ ] // Do nothing as Quicken is already uninstalled
[ ] 
[ ] //This Function will install the SKU as per mentioned
[+] INTEGER InstallQuicken (STRING sSKU)
	[ ] BOOLEAN bFound
	[ ] STRING sSetupExe,sLatest, sCaption, sExpectedQuicken
	[ ] STRING sLicenseAgreement = "License Agreement"
	[ ] sExpectedQuicken = "Quicken {sQuickenYearInfo}"
	[ ] 
	[-] do
		[ ] sSetupExe= INSTALL_BUILD_PATH + "\" + "{sSKU}\DISK1\Setup.exe"
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
					[ ] sleep(50)
					[ ] //QuickenInstallWizard.Done.VerifyEnabled(TRUE,180 )
					[ ] QuickenInstallWizard.SetActive()
					[ ] 
					[-] if(QuickenInstallWizard.Done.Exists(99000))
						[ ] QuickenInstallWizard.Done.SetFocus()
						[ ] QuickenInstallWizard.Done.Click()
						[ ] 
						[+] if(ProductRegistration.Exists(SHORT_SLEEP))
							[ ] ProductRegistration.Close()
						[ ] QuickenMainWindow.SetActive()
						[ ] QuickenMainWindow.VerifyEnabled(TRUE, 40)
						[ ] sCaption = QuickenMainWindow.GetCaption ()
						[ ] 	
						[ ] bFound = MatchStr("*{sExpectedQuicken}*", sCaption)
						[-] if(bFound == TRUE)
							[ ] iFunctionResult = PASS
						[-] else
							[ ] iFunctionResult = FAIL
					[-] else
						[ ] ReportStatus("Verify Installation successful page", FAIL, "Installation successful page not found") 
				[-] else
					[ ] ReportStatus("Verify License window", FAIL, "License window not found") 
			[-] else
				[ ] print("Wizard not exists")
		[-] else
			[ ] ReportStatus("Verify Setup.exe Existence", ABORT, "Setup.exe does not exist") 
			[ ] iFunctionResult = ABORT
	[-] except
		[ ] ExceptLog()
		[ ] iFunctionResult = ABORT
	[ ] return iFunctionResult
	[ ] 
[ ] 
[ ] //This Function will copy the build from mtvfos04 in local
[+] public STRING INSTALLER_BUILD_PATH_Function()
		[-] if SYS_DirExists(InstallerFolder)
			[ ] DeleteDir(InstallerFolder)
		[-] do
			[ ] // connect to the database
			[ ] hDB = DB_Connect ("{XLS_CONNECT_PREFIX}{sRegistration}{DB_CONNECT_SUFFIX}")
			[ ] //execute a SQL statement
			[ ] hSQL = DB_ExecuteSQL (hDB, "{SQL_QUERY_START}[{sWorksheet}$]")//while there are still rows to retrieve
			[ ] bWorksheet=TRUE
			[ ] 
		[-] except
			[ ] ReportStatus("Worksheet verification", WARN, "Worksheet {sWorksheet} not found") 
			[ ] 
		[-] if(bWorksheet==TRUE)
			[ ] lsExcelData=ReadExcelTable(sRegistration, sTabName1)
			[+] for(i=1;i<=ListCount(lsExcelData);i++)
				[ ] lsData=lsExcelData[i]
				[ ] MakeDir(InstallerFolder)
				[-] if SYS_DirExists(lsData[1])				
					[ ] CopyDir(lsData[1],InstallerFolder)		// copy build from mtvfso4
				[ ] return lsData[1]
				[ ] print(lsData[1])
[ ] 
[+] //############# Quicken Registration  ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Quicken_Registration()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Fill the registration form
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while filling form					
		[ ] //						Fail		If any error occurs
		[ ] //
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 13, 2011	Puja Verma  Created
	[ ] // ********************************************************
	[ ] 
[+] testcase Quicken_Registration () appstate none
	[+] //VARIABLES
		[ ] STRING sWindowTitleName="//MainWin[@caption='Quicken 201*']"
		[ ] STRING sQuickenIniPath 
		[ ] // STRING sExcelName ="Registration"
		[ ]  STRING sTabName ="Registration details"
		[ ] HINIFILE hIni
		[ ] LIST OF STRING lsContentValue
		[ ] string sCmdLine = "{QUICKEN_ROOT}\qw.exe"
		[ ] STRING sFilePath = "{LOCAL_LOG}\lbtlog.txt"
		[ ] //STRING sFilePath1="{LOCAL_LOG}\btlog1.txt"
		[ ] Datetime CurrentTimeStamp = GetDateTime ( )
		[ ] //STRING sFilePath2
		[ ] BOOLEAN bExists
		[ ] STRING sSetting=""
		[ ] STRING SysName=SYS_GetName ( )
		[ ] STRING sZipCode="D:\Quicken\zip"
		[ ] STRING sTempFolder
		[ ] STRING sResultFolder
		[ ] 
	[ ] //Prerequisite
	[ ] //copy latest build from mtvfso4 to  local
	[ ] // INSTALLER_BUILD_PATH_Function()
	[+] LIST OF STRING lsSKU = {...}
		[ ] "RPM"
		[ ] // "HAB"
		[ ] // "Premier"
		[ ] // "Deluxe"
		[ ] // "QNUE"
	[ ] STRING sSKU
	[-] for each sSKU in lsSKU 
		[ ] //perform setup for insatllation
		[ ] // InstallSetup(sSKU)
		[ ] // //install Quicken
		[-] // InstallQuicken (sSKU)
			[+] if (OPERATING_SYSTEM == "Windows 7" || OPERATING_SYSTEM == "Windows Vista")
				[ ]  sQuickenIniPath =ALLUSERSPROFILE + "\Intuit\Quicken\Config\Quicken.ini"
				[ ] 
			[+] if (OPERATING_SYSTEM == "Windows XP")
				[ ]   sQuickenIniPath =ALLUSERSPROFILE + "\Application Data\Intuit\Quicken\Config\Quicken.ini"
			[ ] //On Lbtlog Flag
		[ ] hIni = SYS_IniFileOpen (sQuickenIniPath)
		[ ] SYS_IniFileSetValue (hIni, "Internet","lbtlog", "1")
		[ ] //SYS_IniFileSetValue (hIni, "Internet","STAR", sSetting)
		[ ] IniFileClose (hIni)
		[ ] 
		[ ] // Read data from excel sheet
		[+] // do
			[ ] // // connect to the database
			[ ] // hDB = DB_Connect ("{XLS_CONNECT_PREFIX}{sRegistration}{DB_CONNECT_SUFFIX}")
			[ ] // //execute a SQL statement
			[ ] // hSQL = DB_ExecuteSQL (hDB, "{SQL_QUERY_START}[{sWorksheet}$]")//while there are still rows to retrieve
			[ ] // 
			[ ] // bWorksheet=TRUE
			[ ] // 
		[+] // except
			[ ] // ReportStatus("Worksheet verification", WARN, "Worksheet {sWorksheet} not found") 
			[ ] // 
		[ ] // 
		[-] // if(bWorksheet==TRUE)
			[ ] lsExcelData=ReadExcelTable(sSheetname, sTabName)
			[ ] // Fetch data  from the given sheet
			[-] for(i=1;i<=ListCount(lsExcelData);i++)
				[ ] lsData=lsExcelData[i]
				[+] if (QuickenMainWindow.Exists ())
					[ ] QuickenMainWindow.Exit()
					[ ] sleep(2)
				[ ] //Deleting the local log folder
				[ ] bExists = SYS_DirExists(LOCAL_LOG)
				[+] if(bExists==TRUE)
					[ ] DeleteDir(LOCAL_LOG)
				[ ] // Click on Product registration
				[ ] QuickenRegistration()
				[+] if(ProductRegistrationPopup.Exists(5))
					[ ] ProductRegistrationPopup.CancelButn.Click()
					[ ] ClearRegistration_2012()
				[ ] //If already registered then Clear the product registartion
				[-] else
					[ ] ClearRegistration_2012()
				[-] if(i==1)
					[ ] QuickenMainWindow.Tools.OneStepUpdate.Pick()
				[-] else
					[ ] QuickenMainWindow.Help.RegisterQuicken.Pick()
				[-] if(ProductRegistrationPopup.Exists(20))
					[ ] ProductRegistrationPopup.RegisterNow.Click()
				[ ] // Filling the product registration form
				[ ] sleep(20)
				[ ] //First Name 
				[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_firstName_firstName_TextBox']").DomClick(1, {21, 14})
				[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_firstName_firstName_TextBox']").SetText(lsData[1])
				[ ] //Last  Name 
				[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_lastName_lastName_TextBox']").SetText(lsData[2])
				[ ] //Address
				[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_address1_address1_TextBox']").SetText(lsData[3])
				[ ] //Second line address
				[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_address2_address2_TextBox']").SetText(lsData[4])
				[ ] //City
				[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_city_city_TextBox']").SetText(lsData[5])
				[ ] //State
				[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//SELECT[@id='CustomerInfoFieldGroupControl_state_state_HtmlSelect']").Select(lsData[6])
				[ ] //Postal Code
				[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_postalCode_postalCode_TextBox']").SetText(lsData[7])
				[ ] //Email Address
				[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_emailAddress_emailAddress_TextBox']").SetText(lsData[8])
				[ ] //Confrim email address
				[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_confirmEmailAddress_confirmEmailAddress_TextBox']").SetText(lsData[9])
				[ ] //day phone number
				[+] if(lsData[10]!=NULL)  
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_dayPhoneNumber_dayPhoneNumber_TextBox']").SetText(lsData[10])
				[ ] //Day extension
				[+] if(lsData[11]!=NULL)
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_dayPhoneExt_dayPhoneExt_TextBox']").SetText(lsData[11])
				[ ] //Evening Phone number
				[+] if(lsData[12]!=NULL )
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_evePhoneNumber_evePhoneNumber_TextBox']").SetText(lsData[12])
				[ ] //Evening Extension
				[+] if(lsData[13]!=NULL)
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_eveningPhoneExt_eveningPhoneExt_TextBox']").SetText(lsData[13])
					[ ] 
				[ ] //Company
				[+] if(lsData[14]!=NULL)
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='CustomerInfoFieldGroupControl_companyName_companyName_TextBox']").SetText(lsData[14])
				[ ] // Survey data below...
				[ ] //Select : "Where did you buy this Quicken product?"
				[+] if(Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//SELECT[@id='MainSurveyFieldGroupControl_Survey_A_280_3530_Survey_A_280_3530_HtmlSelect']").Exists(10))
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//SELECT[@id='MainSurveyFieldGroupControl_Survey_A_280_3530_Survey_A_280_3530_HtmlSelect']").Select(lsData[15])
				[ ]  //Selecting the Check boxes according to selection for field : "Prior to purchasing this Quicken product, which of the following methods were you using for managing your money? (Check all that apply)"
				[-] if(lsData[16]=="Yes")
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='MainSurveyFieldGroupControl_Survey_A_280_3531_Survey_A_280_3531_CheckBoxList_1']").Select(1)
				[-] if(lsData[17]=="Yes")
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='MainSurveyFieldGroupControl_Survey_A_280_3531_Survey_A_280_3531_CheckBoxList_2']").Select(1)
				[-] if(lsData[18]=="Yes")
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='MainSurveyFieldGroupControl_Survey_A_280_3531_Survey_A_280_3531_CheckBoxList_3']").Select(1)
				[-] if(lsData[19]=="Yes")
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='MainSurveyFieldGroupControl_Survey_A_280_3531_Survey_A_280_3531_CheckBoxList_4']").Select(1)
				[-] if(lsData[20]=="Yes")
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='MainSurveyFieldGroupControl_Survey_A_280_3531_Survey_A_280_3531_CheckBoxList_5']").Select(1)
				[-] if(lsData[21]=="Yes")
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='MainSurveyFieldGroupControl_Survey_A_280_3531_Survey_A_280_3531_CheckBoxList_6']").Select(1)
				[-] if(lsData[22]=="Yes")
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='MainSurveyFieldGroupControl_Survey_A_280_3531_Survey_A_280_3531_CheckBoxList_7']").Select(1)
				[-] if(lsData[23]=="Yes")
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='MainSurveyFieldGroupControl_Survey_A_280_3531_Survey_A_280_3531_CheckBoxList_8']").Select(1)
				[-] if(lsData[24]=="Yes")
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='MainSurveyFieldGroupControl_Survey_A_280_3532_Survey_A_280_3532_CheckBoxList_0']").Select(1)
				[ ] //Selecting the Check boxes according to selection for field : "Which of the following statements describe how you plan to use Quicken? (Check all that apply)"
				[-] if(lsData[25]=="Yes")
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='MainSurveyFieldGroupControl_Survey_A_280_3532_Survey_A_280_3532_CheckBoxList_0']").Select(1)
				[-] if(lsData[26]=="Yes")
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='MainSurveyFieldGroupControl_Survey_A_280_3532_Survey_A_280_3532_CheckBoxList_1']").Select(1)
				[-] if(lsData[27]=="Yes")
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='MainSurveyFieldGroupControl_Survey_A_280_3532_Survey_A_280_3532_CheckBoxList_2']").Select(1)
				[ ] //Click "Register" button
				[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='RegisterButton']").Click()
				[ ] sleep(2)
				[-] do
					[ ] sleep(10)
					[ ] //Verifying Confirmation message of  Registration
					[-] if(Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//TD[@textContents='Thank You*']").Exists(3))
						[ ] STRING t = Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//TD[@textContents='Thank You*']").GetText()
						[ ] print(t)
						[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='WindowCloser']").Select()
						[ ] ReportStatus("{lsData[1]}  {lsData[2]}  Registration ",PASS," {lsData[1]}  {lsData[2]} Registration has completed succesfully !!!")
					[-] if(MessageBox.No.Exists(10))
						[ ] MessageBox.No.Click()
						[ ] 
					[-] if(QuickenMainWindow.Exists())
						[ ] QuickenMainWindow.Exit()
						[ ] sleep(2)
					[ ] //Creating temparory result Folder
					[ ] sTempFolder="{LOCAL_QUICKEN}\Result\{SysName} {sSKU}{lsData[1]} {lsData[2]} {CurrentTimeStamp}"
					[ ] MakeDir(sTempFolder)
					[ ] //Copying the logs
					[-] if SYS_DirExists(LOCAL_LOG)				
						[ ] CopyDir(LOCAL_LOG,sTempFolder)		
					[ ] 
				[-] except
					[ ] STRING sIncorrectData=Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//DIV[@id='ValidationSummary1']").GetText()
					[ ] Desktop.Find(sWindowTitleName).Find("//MainWin[@caption='Quicken Registration']").Find("//BrowserWindow").Find("//INPUT[@id='WindowCloser']").Select()
					[ ] print(sIncorrectData)
					[ ] ReportStatus(" Registration ",FAIL ," {lsData[1]}  {lsData[2]} Registration has not completed successfully due to incorrect test data {sIncorrectData}!!!")
					[ ] 
		[ ] //Creating final result folder with all the registration.
	[ ] //SYS_MoveFile(sLogFileName,LOCAL_QUICKEN + DELIMITER+"Result"+ DELIMITER +"ResultLog"+ SysName)//+ sSKU)
	[ ] //Clean up function which  copy the result folder in required location
	[ ] // Quicken_RegistrationClean() 
	[ ] 
[ ] //#############################################################
[ ] 
[ ] 
