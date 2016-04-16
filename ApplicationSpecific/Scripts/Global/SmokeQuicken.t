[ ] 
[ ] 
[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<SmokeQuicken.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Smoke test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube/ Mamta Jain	
	[ ] //
	[ ] // Developed on: 		21/12/2010
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 21, 2010	Udita Dube  Created
[ ] // *********************************************************
[ ] 
[+] // Global variables used for Smoke Test cases
	[ ] public STRING sFileName = "Smoke Test"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] //public STRING sMFCUAccountId = "91058196"
	[ ] public STRING sMFCUAccountId = "12345"
	[ ] public STRING sCheckingAccount = "Checking XX9609"
	[ ] public STRING sSavingsAccount = "Savings XX9601"
	[ ] 
	[ ] public STRING sHandle,sActual ,sAccountName ,sDateStamp ,sSourceFile ,sVersion , sLocation ,sActualText ,sFilePath
	[ ] public BOOLEAN bMatch, bExist  ,bResult
	[ ] public INTEGER iSwitchState, iSelect,iNavigate, i,iResult ,iCount  ,iAddAccount ,iCounter
	[ ] 
	[ ] public STRING sPopUpWindow = "PopUp"
	[ ] public STRING sMDIWindow = "MDI"
	[ ] 
	[ ] // public STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] public LIST OF ANYTYPE  lsAccountData,lsExcelData
	[ ] public LIST OF STRING lsAddAccount, lsQuickenAttributes, lsReminderData, lsTransactionData,lsCategoryData,lsAddSavingGoal,lsEditSavingGoal
	[ ] public STRING sSmokeData = "SmokeTestData"
	[ ] public STRING sAccountWorksheet = "Account"
	[ ] public STRING sBillWorksheet = "Bill"
	[ ] public STRING sCheckingTransactionWorksheet = "Checking Transaction"
	[ ] public STRING sOtherAccountSheet = "Other Accounts"
	[ ] public STRING sPaycheckSheet = "Paycheck Reminder"
	[ ] public STRING sInvestingTransactionWorksheet = "Investing Transaction"
	[ ] public STRING sRegistrationWorksheet = "RegistrationDetails"
	[ ] public STRING sSavingGoals = "Saving Goal"
	[ ] public STRING sCategoryWorksheet = "Category"
	[ ] public STRING sExpenseCategoryDataSheet = "ExpenseCategoryData"
	[ ] public STRING sManualLoanSheet = "ManualLoanAccount"
	[ ] public STRING sReminderSheet = "Reminder"
	[ ] public STRING sRegCustomerVendorTransactions= "CustomerVendorTransactions"
	[ ] INTEGER iListCount  ,iConversionResult , iZip ,iPhoneNumber
	[ ] //OIP specific decalration
	[ ] public STRING sEmailID,  sSecurityQuestion, sSecurityQuestionAnswer, sName, sLastName, sAddress, sCity, sState, sZip,sBoughtFrom,sPhoneNumber , sCityStateZip
	[ ] public LIST OF ANYTYPE lsRegistrationData
	[ ] STRING sDate=ModifyDate(0,"m/d/yyyy")
	[ ] 
[+] // Global Function
	[+] public VOID DisableAddingDownloadedTransactionsToRegisters()
		[ ] 
		[+] if (!QuickenWindow.Exists())
			[ ] raise -1, "QuickenWindow does not exist"
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] INTEGER iResult=SelectPreferenceType("Downloaded Transactions")
		[+] if (iResult != PASS)
			[ ] ReportStatus("Verify 'Downloaded Transactions on preferences dialog", FAIL, "Downloaded Transactions not available on preferences dialog.") 
		[ ] 
		[ ] Preferences.SetActive()
		[+] if(Preferences.AutomaticallyAddDownloadedT.Exists(5))
			[ ] 
			[ ] // Check the checkbox if it is unchecked
			[+] if(Preferences.AutomaticallyAddDownloadedIT.IsChecked())
				[ ] Preferences.AutomaticallyAddDownloadedT.Uncheck()
				[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Checkbox is unchecked") 
				[ ] 
			[+] else
				[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Checkbox is already unchecked") 
				[ ] 
			[ ] 
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,False,2)
		[+] else
			[ ] raise -1,"AutomaticallyAddDownLoadedTransaction checkbox not found"
		[ ] 
	[+] public VOID exitQuicken()
		[ ] 
		[+] if (QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.File.Exit.Click()
			[ ] 
			[ ] // dismiss the callout holder if exists
			[+] do
				[+] if (Desktop.Find("//Control[@caption='Callout Holder']//PushButton[@caption='close']").Exists(5))
					[ ] Desktop.Find("//Control[@caption='Callout Holder']//PushButton[@caption='close']").click()
					[ ] sleep(2)
			[+] except
				[ ] // do nothing
			[ ] 
			[+] if (QuickenWindow.QuickenBackup.Exists(3))
				[ ] QuickenWindow.QuickenBackup.Exit.Click()
				[ ] sleep(2)
			[ ] 
			[ ] // if quicken still exists...then kill the process as last option.. before killing disconnect open agent
			[+] if (QuickenWindow.Exists(2))
				[ ] DisconnectAll()  
				[ ] Connect("(local)",CLASSIC_AGENT)  
				[ ] QuickenWindow.Kill()
[ ] 
[+] // ==========================================================
	[+] public Integer NavigateToRegistrationOIPStep(LIST OF ANYTYPE lsRegistrationData)
		[+] // Variable Declaration
			[ ] sEmailID = trim(lsRegistrationData[1])
			[ ] sSecurityQuestion = trim(lsRegistrationData[3])	
			[ ] sSecurityQuestionAnswer = trim(lsRegistrationData[4])	
			[ ] sName = trim(lsRegistrationData[5])	
			[ ] sLastName = trim(lsRegistrationData[6])	
			[ ] sAddress = trim(lsRegistrationData[7])	
			[ ] sCity = trim(lsRegistrationData[8])	
			[ ] sState= trim(lsRegistrationData[9])
			[ ] sZip = trim(lsRegistrationData[10])	
			[ ] iZip = VAL(sZip)
			[ ] sZip =Str(iZip)
			[ ] 
			[ ] sBoughtFrom = trim(lsRegistrationData[11])	
			[ ] sPhoneNumber = trim(lsRegistrationData[12])
			[ ] iPhoneNumber = VAL(sPhoneNumber)
			[ ] sPhoneNumber =Str(iPhoneNumber)
			[ ] sPhoneNumber= "+1 "+sPhoneNumber
			[ ] sCityStateZip= sCity + " " +sState +" " +sZip
		[ ] 
		[ ] 
		[+] do
			[ ] // 11/05/2015  KalyanG: 2015 R6 enhancement, added below condition to handle the screen change
			[+] if (QuickenIAMMainWindow.IAMUserControl.IAMContentControl.linkCreateOneHere.Exists())
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.linkCreateOneHere.Click()
			[ ] 
			[ ] //Register Datafile
			[+] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.EmailID.Exists(20))
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.EmailID.SetText(sEmailID)
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Password.SetText(sPassword)
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.ConfirmPassword.SetText(sPassword)
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.SecurityQuestion.Select(val(sSecurityQuestion))
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.SecurityQuestionAnswer.SetText(sSecurityQuestionAnswer)
				[ ] sleep(2)
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
				[ ] sleep(5)
			[ ] //Handle if ID already exists
			[+] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.ExistingUserName.Exists(30))
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Password.SetText(sPassword)
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
				[ ] 
			[+] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Exists(60))
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Name.SetText(sName)
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.LastName.SetText(sLastName)
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Address.SetText(sAddress)
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.City.SetText(sCity)
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.State.Select(sState)
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Zip.SetText(sZip)
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.MobileNumber.SetText(sPhoneNumber)
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Select(sBoughtFrom)
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
				[ ] 
				[ ] sleep(5)
				[ ] 
				[ ] 
			[ ] //Password Vault condition in case of Registered User
			[+] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Exists(60))
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseMobileOption.Check()
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
			[ ] 
			[ ] iFunctionResult = PASS
			[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] iFunctionResult = FAIL
			[ ] 
		[ ] 
		[ ] return iFunctionResult
	[ ] 
	[ ] 
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
[ ] // ==========================================================
[-] main()
	[ ] 
	[ ] print(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.linkSignInWithDifferentID.Exists())
	[ ] 
[ ] 
[+] //############# Smoke SetUp #####################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 SmokeSetUp()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the Smoke Test.QDF if it exists. It will setup the necessary pre-requisite for Smoke tests
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 6, 2010		Mamta Jain created	
		[ ] // Jan 25, 2011		Udita Dube	updated
	[ ] // ********************************************************
	[ ] 
[+] testcase SmokeSetUp () appstate none
	[ ] 
	[ ] INTEGER iSetupAutoAPI
	[ ] 
	[ ] 
	[ ] sleep(MEDIUM_SLEEP)
	[ ] 
	[ ] 
	[+] if(FileExists(sTestCaseStatusFile))
		[ ] DeleteFile(sTestCaseStatusFile)
	[ ] 
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
	[ ] //############# commented by mukesh suggested by Udita - 13/08/2012#################################################
	[ ] STRING sConf_FilePath
	[ ] //commented by mukesh suggested by Udita - 10/08/2012
	[ ] //sConf_FilePath = QUICKEN_CONFIG + "\Quicken.ini"
	[ ] sConf_FilePath = SYS_GetEnv("QuickenIniPath") 
	[ ] handle hIni
	[ ] 
	[ ] 
	[+] // update ini file
		[+] if (FileExists(sConf_FilePath))
			[ ] // Open File
			[ ] hIni = SYS_IniFileOpen (sConf_FilePath)
			[ ] // Set Values for keys
			[ ] SYS_IniFileSetValue (hIni, "autopatch" , "PatchFatalError", "1")
			[ ] // Close File
			[ ] SYS_IniFileClose (hIni)
	[ ] 
	[ ] //############# commented by mukesh suggested by Udita - 13/08/2012#################################################
	[ ] 
	[ ] //########commented by mukesh suggested by Govind - 14/08/2012 #######To disable Qcards######################//
	[ ] sConf_FilePath=NULL
	[ ] sConf_FilePath=SYS_GetEnv("AllUserQuickenDirPath") + "\Inet\Common\Localweb\QCards\Overview_UserDefinedView_1\Deck1\Overview_UserDefinedView_1.ini"
	[ ] 
	[+] // update ini file
		[+] if (FileExists(sConf_FilePath))
			[ ] // Open File
			[ ] hIni = SYS_IniFileOpen (sConf_FilePath)
			[ ] // Set Values for keys
			[ ] SYS_IniFileSetValue (hIni, "2013" , "NumFiles", "0")
			[ ] // Close File
			[ ] SYS_IniFileClose (hIni)
			[ ] 
	[ ] sConf_FilePath=NULL
	[ ] sConf_FilePath=SYS_GetEnv("AllUserQuickenDirPath") + "\Inet\Common\Localweb\QCards\Quicken_AccountTransactions\Deck1\Quicken_AccountTransactions.ini"
	[ ] 
	[+] // update ini file
		[+] if (FileExists(sConf_FilePath))
			[ ] // Open File
			[ ] hIni = SYS_IniFileOpen (sConf_FilePath)
			[ ] // Set Values for keys
			[ ] SYS_IniFileSetValue (hIni, "2013" , "NumFiles", "0")
			[ ] // Close File
			[ ] SYS_IniFileClose (hIni)
			[ ] 
		[ ] 
	[ ] 
	[ ] //########commented by mukesh suggested by Govind - 14/08/2012 #######To disable Qcards######################//
	[ ] 
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[+] //############# Create New Data file ##############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_NewDataFileCreation()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will create New Data File
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if data file is created without any errors						
		[ ] // 							Fail	if any error occurs
		[ ] //							Abort	if data file with same name already exists
		[ ] // 
		[ ] // REVISION HISTORY: 	21/12/2010  	Created By	Udita Dube
		[ ] // 
	[ ] // ********************************************************
[-] testcase Test01_NewDataFileCreation () appstate  QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCreateDataFile,iRegistration
	[ ] 
	[ ] 
	[-] // Quicken is launched then create data file
		[ ] 
		[ ] // ----------Create Data File---------
		[ ] iCreateDataFile = DataFileCreate_OII(sFileName)
		[ ] 
		[ ] 
		[ ] // -------Report Staus If Data file Created successfully--------
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Verify Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[+] if (QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] //----Deselect Manual Backup Reminder option in Preferences to prevent Backup prompts----
				[ ] QuickenWindow.Edit.Click()
				[ ] QuickenWindow.Edit.Preferences.Select()
				[+] if(Preferences.Exists(5))
					[ ] Preferences.SelectPreferenceType1.ListBox.Select(5)
					[ ] Preferences.ManualBackupReminder.Uncheck()
					[ ] Preferences.OK.Click()
					[ ] WaitForState(Preferences,FALSE,5)
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Preferences window is present", FAIL, "Preferences window not found")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
			[ ] 
		[ ] // -------Report Staus If Data file is not Created -------
		[+] else if (iCreateDataFile ==FAIL)
			[ ] ReportStatus("Verify Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
[ ] //################################################################################
[ ] 
[+] //############## Verify Start Up Preferences-UI for New User  ######################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test02_VerifyStartUpUIPreferencesForNewUser()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will verify Start Up Preferences-UI for New User  
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Start Up Preferences-UI for New User are as expected	
		[ ] //							Fail	      if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] //Date                             Sept 16, 2014	
		[ ] //Author                          Mukesh 	
		[ ] 
	[ ] //*********************************************************
[+] testcase Test02_VerifyStartUpUIPreferencesForNewUser() appstate none
	[+] // Variable declaration
		[ ] sActualText="1"
		[ ] STRING sStartupPreferenceOption="Startup"
	[ ] 
	[ ] // Report Staus If Data file Created successfully
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] //Select preferences dialog
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Edit.Click()
		[ ] QuickenWindow.Edit.Preferences.Select()
		[ ] 
		[ ] 
		[+] if (Preferences.Exists(5))
			[ ] Preferences.SetActive()
			[ ] //Verify Startup option is by default selected.
			[+] if (Preferences.StartupPreferencesText.Exists())
				[ ] ReportStatus("Verfiy Startup option is displayed by deafult on Preferences dialog." , PASS ,"Startup option is displayed by deafult on Preferences dialog.")
				[ ] 
				[ ] //Verfiy Startup Location section on Preferences dialog is available
				[+] if (Preferences.StartupLocationGroup.Exists())
					[ ] ReportStatus("Verfiy Startup Location section on Prefernces dialog is available." , PASS ,"Startup Location section on Prefernces dialog is available.")
					[ ] //Verfiy 'Home' is selected by default in 'On startup open to:' list on Preferences dialog
					[ ] //The actual is retrived as " +RPH" so will communicate with microfocus to get right values
					[ ] // sActualText=Preferences.OnStartupOpenTo.GetSelText() 
					[+] // if (trim(sActualText)=="Home")
						[ ] // ReportStatus("Verfiy 'Home' is selected by default in 'On startup open to:' list on Preferences dialog." , FAIL ,"'Home' is selected by default in 'On startup open to:' list on Preferences dialog.")
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verfiy 'Home' is selected by default in 'On startup open to:' list on Preferences dialog." , FAIL ,"'Home' is NOT selected by default in 'On startup open to:' list on Preferences dialog the actual selected item is :{sActualText}.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verfiy Startup Location section on Prefernces dialog is available." , FAIL ,"Startup Location section on Prefernces dialog is NOT available.")
				[ ] 
				[ ] //Verfiy Startup Actions section on Preferences dialog is available
				[+] if (Preferences.StartupActionsGroup.Exists())
					[ ] ReportStatus("Verfiy Startup Actions section on Prefernces dialog is available." , PASS ,"Startup Actions section on Prefernces dialog is available.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verfiy Startup Actions section on Prefernces dialog is available." , FAIL ,"Startup Actions section on Prefernces dialog is NOT available.")
				[ ] 
				[ ] //Verfiy Quicken Colors section on Preferences dialog is available
				[+] if (Preferences.QuickenColorsGroup.Exists())
					[ ] ReportStatus("Verfiy Quicken Colors section on Prefernces dialog is available." , PASS ,"Quicken Colors section on Prefernces dialog is available.")
				[+] else
					[ ] ReportStatus("Verfiy Quicken Colors section on Prefernces dialog is available." , FAIL ,"Quicken Colors section on Prefernces dialog is NOT available.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verfiy Startup option is displayed by deafult on Preferences dialog." , FAIL ,"Startup option is NOT displayed by deafult on Preferences dialog.")
			[ ] //Close Preferences Window
			[ ] Preferences.SetActive()
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences, false,1)
		[+] else
			[ ] ReportStatus("Verify Preference dialog.", FAIL, "Preference dialog didn't appear or Navigation option not found.")
		[ ] 
		[ ] 
		[ ] 
	[ ] // Report Staus If Data file is not Created 
	[+] else 
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken is not available") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] //#############  Verify Quicken File Attributes ####################################### 
	[ ] // ********************************************************
	[+] // TestCase Name:	 		Test03_QuickenFileAttributes()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify  File Attributes after launching Quicken.
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 21/12/2020  	Created By	Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test03_QuickenFileAttributes () appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] LIST OF STRING lsActualFileAttribute, lsFileAttributes
		[ ] STRING sActualAboutQuicken,sExpectedAttribute
		[ ] INTEGER iPos
	[+] // Expected values of Quicken File Attributes
		[ ] lsFileAttributes = {"Accounts", "Categories", "Memorized Payee", "Securities", "Transactions" }
		[ ] LoadSKUDependency()
		[ ] //sQuickenAttributesWorksheet="Quicken_Attributes_RPM"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sQuickenAttributesWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsQuickenAttributes=lsExcelData[1]
	[ ] 
	[ ] // Quicken is launched then Verify File Attributes
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] // Active Quicken Screen
		[ ] QuickenWindow.SetActive()
		[ ] // Maximize quicken window, if needed
		[ ] QuickenWindow.Maximize()
		[ ] 
		[+] // //About Quicken Window has been changed
			[ ] // // Navigate to Help > About Quicken
			[ ] // QuickenMainWindow.Help.AboutQuicken.Pick()
			[ ] // // Get Quicken's Actual Year information
			[ ] // sActualAboutQuicken= AboutQuicken2012.QuickenVersion.GetText()
			[ ] // // Verify that actual year information is correct
			[ ] // iPos= StrPos(sExpectedAboutQuicken, sActualAboutQuicken)
			[+] // if( iPos != 0)
				[ ] // ReportStatus("Verify About Quicken", PASS, "SKU and Year information - {sExpectedAboutQuicken} is correct") 
			[+] // else
				[ ] // ReportStatus("Verify About Quicken", FAIL, "Actual SKU and Year - {sActualAboutQuicken} is not matching with Expected  - {sExpectedAboutQuicken}") 
			[ ] // // Close About Quicken window
			[ ] // AboutQuicken2012.Close()
		[ ] 
		[ ] // Taking all File Attributes of Quicken
		[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
		[ ] 
		[ ] // Verification of Actual File Attributes
		[+] for (i=1;i<=ListCount(lsActualFileAttribute);i++)
			[ ] sExpectedAttribute=str(Val(lsQuickenAttributes[i]))
			[+] if(sExpectedAttribute == lsActualFileAttribute[i])
				[ ] ReportStatus("Verify {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i]}") 
			[+] else
				[ ] ReportStatus("Verify {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i]}")
				[ ] 
				[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //################################################################################
[ ] 
[+] //############## Create New Checking Account #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_AddCheckingAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add Checking Account - Checking01.
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if checking account is added without any errors						
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	21/12/2020  	Created By	Udita Dube
		[ ] // 
	[ ] // ********************************************************
[+] testcase Test04_AddCheckingAccount () appstate SmokeBaseState
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER  iAddAccount
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] 
	[ ] 
	[ ] // Quicken is launched then Add Checking Account
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is created successfully")
		[+] else
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] //  Verify that Account is shown on account bar
		[+] if(iAddAccount==PASS)
				[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,str(0))
				[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
				[+] else
					[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
		[+] else
			[ ] ReportStatus("Verify Checking Account", FAIL, "Verification has not been done as Checking Account -  {lsAddAccount[2]}  is not created")
			[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //################################################################################
[ ] 
[+] //############# Stay on Top of Bill #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_CreateBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add new bill and Verify name and amount in Home tab
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while creating bill							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 22, 2010		Mamta Jain created	
		[ ] // 	  Apr  06, 2011		Udita Dube  updated
		[ ] //       Sep 23, 2011       Udita Dube  updated
	[ ] // ********************************************************
[+] testcase Test05_CreateBill () appstate SmokeBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] BOOLEAN bPayee, bAmount
		[ ] STRING sExpectedAmount
		[ ] INTEGER iAdd
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sBillWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsReminderData=lsExcelData[1]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
		[+] if (iNavigate == PASS)
			[+] if(MDIClient.Home.VScrollBar.Exists(5))
				[ ] MDIClient.Home.VScrollBar.ScrollToMax()
			[ ] MDIClient.Home.TextClick("Get Started" ,1)
			[+] if (StayOnTopOfMonthlyBills.Exists(5))
				[ ] 
				[ ] StayOnTopOfMonthlyBills.SetActive ()
				[ ] StayOnTopOfMonthlyBills.AddABill.Click ()
				[ ] 
				[ ] lsReminderData[3]=sDateStamp
				[ ] 
				[ ] iAdd = AddBill(lsReminderData[1],lsReminderData[2] , lsReminderData[3], lsReminderData[4], lsReminderData[5],lsReminderData[6], lsReminderData[7])
				[+] if (iAdd == PASS)
					[ ] 
					[ ] sExpectedAmount= Str(Val(lsReminderData[2]))
					[ ] 
					[ ] ReportStatus("Create new Bill ", iAdd, "New Bill with Payee Name {lsReminderData[1]} and amount {sExpectedAmount} created")
					[ ] 
					[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
					[+] if (AddBiller.Exists(5))
						[ ] AddBiller.SetActive()
						[ ] AddBiller.btnClose.Click()
						[ ] sleep(1)
					[ ] 
					[ ] StayOnTopOfMonthlyBills.SetActive()
					[ ] StayOnTopOfMonthlyBills.Next.Click()
					[ ] StayOnTopOfMonthlyBills.Done.Click()
					[ ] 
					[ ] 
					[ ] sHandle = Str(MDIClient.Home.ListBox1.GetHandle ())
					[ ] iListCount=MDIClient.Home.ListBox1.GetItemCount()
					[+] for (iCount=0 ; iCount< iListCount+1 ; ++iCount)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(iCount))
						[ ] bPayee = MatchStr("*{lsReminderData[1]}*", sActual)
						[ ] bAmount = MatchStr("*{sExpectedAmount}*", sActual)
						[+] if (bPayee == TRUE && bAmount == TRUE)
							[ ] break
					[+] if (bPayee == TRUE && bAmount == TRUE)
						[ ] ReportStatus("Verify Payee name and Amount ", PASS, "Bill is displayed on Home Tab with Payee - {lsReminderData[1]} and Amount - {sExpectedAmount}")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Payee name and Amount ", FAIL, "Bill with Payee - {lsReminderData[1]} and Amount - {sExpectedAmount} is not displayed")
						[ ] 
				[+] else
					[ ] ReportStatus("Create new Bill ", iAdd, "New Bill is not created")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify StayOnTopOfMonthlyBills dialog. ", FAIL, "StayOnTopOfMonthlyBills dialog didn't appear.")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Home tab state", iNavigate, "Home tab is not active") 
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
	[ ] 
[ ] //################################################################################
[ ] 
[+] //########## Create Automatic Budget  ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_TrackSpendingGoal()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will create Monthly spending goal for 5 categories
		[ ] // and Verify spending goal in Home tab
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while creating Spending goal							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 27, 2010		Mamta Jain created	
		[ ] //       May 20, 2012       Udita Dube updated
	[ ] //*********************************************************
[+] testcase Test06_TrackSpendingGoal() appstate SmokeBaseState
	[ ] 
	[+] //  Variable Declaration
		[ ] BOOLEAN bMatch
		[ ] STRING sHandle, sActual, sExpected,sAmount,sCategory,sBudget
	[+] //  Variable Definition
		[ ] sCategory = "#2"
		[ ] sAmount = "20"
		[ ] sBudget = "Test Budget"
		[ ] sExpected = "$20"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
		[+] if(iNavigate == PASS)
			[ ] sleep(5)
			[ ] ExpandAccountBar()
			[+] if(MDIClient.Home.VScrollBar.Exists(5))
				[ ] MDIClient.Home.VScrollBar.ScrollToMax()
			[ ] MDIClient.Home.TextClick("Get Started" ,1)
			[ ] 
			[ ] sleep(SHORT_SLEEP)
			[ ] 
			[+] if(CreateANewBudget.Exists(5))
				[ ] CreateANewBudget.SetActive()
				[ ] CreateANewBudget.BudgetName.SetText(sBudget)
				[ ] CreateANewBudget.OK.Click()
				[+] if(DlgBudgetMessageBox.Exists(3))
					[ ] DlgBudgetMessageBox.SetActive()
					[ ] DlgBudgetMessageBox.OKButton.Click()
					[ ] 
				[ ] 
				[+] if(Budget.Exists(5))
					[ ] Budget.AddCategoryToBudget.Click()
					[ ] 
					[+] if(SelectCategoriesToBudget.Exists(5))
						[ ] SelectCategoriesToBudget.SetActive()
						[ ] // Select Category from Select Categories to Budget window
						[ ] SelectCategoriesToBudget.ChooseTheCategories.QWListViewer.ListBox.Select(sCategory)
						[ ] SelectCategoriesToBudget.OK.Click()
						[ ] WaitForState(SelectCategoriesToBudget, false ,1)
						[ ] 
						[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
						[ ] iNavigate = NavigateQuickenTab(sTAB_PLANNING,sTAB_BUDGET)
						[ ] sleep(SHORT_SLEEP)
						[ ] // Enter Budget amount
						[ ] Budget.ListViewer.ListBox.Amount.SetText(sAmount)
						[ ] QuickenMainWindow.Typekeys(KEY_ENTER)
						[ ] // // ########Verify Total Spending #######
						[ ] sActual= Budget.Panel.TotalSpending.GetCaption()
						[ ] bMatch = MatchStr("*{sExpected}*", sActual)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Verify Total Spending ", PASS, "Total Spending is 20")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Total Spending ", FAIL, "Total Spending is {sActual} displayed")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Select Categories to Budget window", FAIL, "Select Categories to Budget window is not available")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Budget window", FAIL, "Budget window is not available")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Creat a New Budget Window ", FAIL, "Create a New Budget window is not opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Home tab state ", iNavigate, "Home tab is not active")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############### Create Other Checking Account ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_AddOtherCheckingAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add another Checking Account - Checking02
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if checking account is added without any errors						
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	22/12/2020  	Created By	Udita Dube
		[ ] // 
	[ ] // ********************************************************
[+] testcase Test07_AddOtherCheckingAccount () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iAddAccount
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsAddAccount=lsExcelData[2]
	[ ] 
	[ ] // Quicken is launched then Add Checking Account
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Create Checking Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
		[+] else
			[ ] ReportStatus("Create Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is NOT created")
		[ ] 
		[ ] //  Verify that Account is shown on account bar
		[+] if(iAddAccount==PASS)
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"1")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Verify Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
			[+] else
				[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
		[+] else
			[ ] ReportStatus("Verify Checking Account", FAIL, "Verification has not been done as Checking Account -  {lsAddAccount[2]}  is not created")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Open first checking register ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_OpenFirstCheckingRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will turn on the pop up register mode and invoke first account from account bar
		[ ] // and check whether it is opened in new window.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking account							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 23, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test08_OpenFirstCheckingRegister () appstate SmokeBaseState
	[ ] 
	[+] //Variable Declaration
		[ ] BOOLEAN bAssert
		[ ] STRING sCaption
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive ()
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[+] if (iSwitchState==PASS)
			[ ] QuickenWindow.SetActive ()
			[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING,1)
			[ ] 
			[+] if( BankingPopUp.Exists(10))
				[ ] ReportStatus("Invoke Account from account bar", PASS, "{lsAddAccount[2]} account invoked in New window")
				[ ] 
				[ ] BankingPopUp.SetActive ()
				[ ] sCaption = BankingPopUp.GetCaption ()
				[ ] BankingPopUp.SetActive()
				[ ] BankingPopUp.Close ()
				[ ] 
				[ ] bAssert = AssertEquals(lsAddAccount[2], sCaption)
				[+] if (bAssert == TRUE)
					[ ] ReportStatus("Verify caption", PASS, "Caption - {lsAddAccount[2]} is displayed")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify caption", FAIL, "Correct caption - {sCaption} does not matches with Expected - {lsAddAccount[2]}")
					[ ] 
			[+] else
				[ ] ReportStatus("Invoke Account from account bar", FAIL, "{lsAddAccount[2]} account is not invoked")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up", FAIL, "Popup mode couldn't be enabled")
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############### Add Payment Checking Transaction using Popup Register ON ##############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_AddPaymentCheckingTransaction()
		[ ] //
		[ ] // Description: 				This Test Case is for adding payment transaction for Checking account with Popup Register mode ON
		[ ] // 
		[ ] // PARAMETERS:			none
		[ ] //
		[ ] // Returns:			        	Pass 		if payment transaction is added successfully and ending balance is correct						
		[ ] //						 	Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 27/12/2020  	Created By	Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test09_AddPaymentCheckingTransaction () appstate SmokeBaseState
	[+] // Variable declaration
		[ ] STRING sActual, sPayBalance
		[ ] INTEGER iAddTransaction
		[ ] BOOLEAN bBalanceCheck
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sCheckingTransactionWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransactionData=lsExcelData[1]
	[ ] 
	[ ] // Quicken is launched then add Payment transaction to Checking account
	[+] if (QuickenWindow.Exists(5) )
		[ ] QuickenWindow.SetActive()
		[ ] // This will click  first Banking account on AccountBar
		[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, 1)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", PASS, "Account {lsTransactionData[10]} is selected") 
			[ ] // Add Payment Transaction to Checking account
			[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
			[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
			[+] if(BankingPopUp.Exists(3))
				[ ] BankingPopUp.SetActive()
				[ ] BankingPopUp.Close()
				[ ] sleep(2)
		[+] else
			[ ] ReportStatus("Select Account", FAIL, "Account {lsTransactionData[10]} is NOT selected") 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add New Transaction", FAIL, "Quicken is not available") 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Open second checking register ##########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test10_OpenSecondCheckingRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will turn on the pop up register mode and invoke second account from account bar
		[ ] // and check whether it is opened in new window.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking account							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 24, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test10_OpenSecondCheckingRegister () appstate SmokeBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] BOOLEAN bAssert
		[ ] STRING sCaption
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsAddAccount=lsExcelData[2]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] UsePopupRegister("ON")			// turning on pop up register mode
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2] , ACCOUNT_BANKING)
		[ ] 
		[+] if(BankingPopUp.Exists(10))
			[ ] ReportStatus("Invoke Account from account bar", PASS, "{lsAddAccount[2]} account invoked")
			[ ] BankingPopUp.SetActive ()
			[ ] sCaption = BankingPopUp.GetCaption ()
			[ ] BankingPopUp.Close ()
			[ ] bAssert = AssertEquals(lsAddAccount[2], sCaption)
			[+] if (bAssert == TRUE)
				[ ] ReportStatus("Verify caption", PASS, "Correct caption - {lsAddAccount[2]} is displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify caption", FAIL, "Caption {sCaption} is not matching with Expected - {lsAddAccount[2]}")
				[ ] 
		[+] else
			[ ] ReportStatus("Invoke Account from account bar", FAIL, "{lsAddAccount[2]} account is not invoked")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //############### Add Deposit Checking Transaction using Popup Register ON ###############
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test11_AddDepositCheckingTransaction()
		[ ] //
		[ ] // Description: 				
		[ ] // This Test case is for adding deposit transaction for Checking account (with Popup Register mode ON)
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			        	Pass 		if deposit transaction is added successfully and ending balance is correct						
		[ ] //							Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 28/12/2020  	Created By	Udita Dube
		[ ] //	  
	[ ] //*********************************************************
[+] testcase Test11_AddDepositCheckingTransaction () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sActual, sExpectedEndingBalance
		[ ] INTEGER iAddTransaction
		[ ] BOOLEAN bBalanceCheck
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sCheckingTransactionWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsTransactionData=lsExcelData[2]
	[ ] 
	[ ] // Quicken is launched then add Deposit transaction to Checking account
	[+] if (QuickenWindow.Exists(5) == True)
		[ ] QuickenWindow.SetActive()
		[ ] // Turn ON Popup mode
		[ ] iSwitchState = UsePopupRegister("ON")
		[ ] ReportStatus("Verify Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[ ] // This will click  second Banking account on AccountBar
		[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, 2)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", iSelect, "Account {lsTransactionData[10]} is selected") 
			[ ] // Add Deposit Transaction to Checking account
			[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
			[+] if (iAddTransaction==PASS)
				[ ] ReportStatus("Add Transaction", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
			[+] else
				[ ] ReportStatus("Add Transaction", FAIL, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} couldn't be added") 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select Account", iSelect, "Account {lsTransactionData[10]} is NOT selected") 
		[ ] 
		[ ] 
		[+] if(BankingPopUp.Exists())
			[ ] BankingPopUp.SetActive()
			[ ] sActual = BankingPopUp.EndingBalance.OnlineBalance.GetText()
			[ ] BankingPopUp.Close()
		[ ] // 
		[ ] // Verify Ending balance after transaction is added
		[ ] sExpectedEndingBalance=str((val(lsTransactionData[9])),7,2)
		[ ] sExpectedEndingBalance = Stuff (sExpectedEndingBalance, 2, 0, ",")
		[+] if(iAddTransaction==PASS)
			[ ] 
			[ ] bBalanceCheck = AssertEquals(sExpectedEndingBalance, sActual)
			[+] if (bBalanceCheck == TRUE)
				[ ] ReportStatus("Verify Ending Balance", PASS, "Ending Balance -  {sActual} is correct") 
			[+] else
				[ ] ReportStatus("Verify Ending Balance", FAIL, "Actual -  {sActual} is not matching with Expected - {sExpectedEndingBalance}") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Checking Transaction", FAIL, "Verification has not been done as Transaction -  {lsTransactionData[2]}  is not added")
			[ ] 
	[+] else
		[ ] ReportStatus("Add New Transaction", FAIL, "Quicken is not available") 
	[ ] 
[ ] //###############################################################################
[ ] 
[+] //############### Create Investment Account ########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test12_AddBrokerageAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add Investment (Brokerage) Account - Brokerage 01
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if brokerage account is added with correct Market vale						
		[ ] //							Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	22/12/2020  	Created By	Udita Dube
		[ ] // 											Updated by 	Mamta Jain
	[ ] //*********************************************************
[+] testcase Test12_AddBrokerageAccount () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 4th row from the given sheet
	[ ] lsAddAccount=lsExcelData[4]
	[ ] 
	[ ] // Quicken is launched then Add Brokerage Account
	[+] if (QuickenWindow.Exists(5) == True)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Add Investment Accounts
		[ ] iAddAccount = AddManualBrokerageAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],lsAddAccount[5],lsAddAccount[6])
		[+] if(iAddAccount==PASS)
			[ ] ReportStatus("Add Brokerage Account", iAddAccount, "Brokerage Account -  {lsAddAccount[2]} is created successfully")
			[ ] 
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer4.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch )
				[ ] ReportStatus("Verify Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
			[+] else
				[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "Actual -  {sActual} is not matching with Expected - {lsAddAccount[2]}") 
		[+] else
			[ ] ReportStatus("Verify Brokerage Account", FAIL, "Verification of account has not been done as Brokerage Account is not created")
			[ ] 
		[ ] 
		[ ] //  Verify that Account is shown on account bar
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] // //############### Verify Download Transaction Tab for Brokerage Account #################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test13_VerifyDownloadTransactionTab()
		[ ] // // 
		[ ] // // DESCRIPTION:			
		[ ] // // This Testcase verifies that "Download Transaction" Tab is available on Brokerage Account window
		[ ] // // 
		[ ] // // PARAMETERS:			None
		[ ] // // 
		[ ] // // RETURNS:				Pass 		if "Download Transaction" Tab is available on Brokerage Account window						
		[ ] // //							Fail		if any error occurs 
		[ ] // // 
		[ ] // // REVISION HISTORY:	23/12/2020  	Created By	Udita Dube
		[ ] // // 
	[ ] // //*********************************************************
[+] testcase Test13_VerifyDownloadTransactionTab () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN bEnable
		[ ] STRING sActualAccName
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 4th row from the given sheet
	[ ] lsAddAccount=lsExcelData[4]
	[ ] 
	[ ] // If Quicken is launched then verify Brokerage Account window
	[+] if (QuickenWindow.Exists(5) )
		[ ] QuickenWindow.SetActive()
		[ ] UsePopupRegister("OFF")
		[ ] 
		[ ] // This will click  first Investment account on AccountBar
		[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
		[ ] //AccountBarSelect(ACCOUNT_INVESTING, 1)	
		[+] // if (iSelect==FAIL)
			[ ] // ReportStatus("Account select from account bar", iSelect, "Select Account {lsAddAccount[2]}") 
		[ ] 
		[ ] sleep(2)
		[ ] 
		[ ] // Verification for Account window Title
		[ ] sActualAccName=QuickenWindow.GetCaption()
		[ ] 
		[+] if( MatchStr("*{lsAddAccount[2]}*", sActualAccName))
			[ ] ReportStatus("Verify account window title", PASS, "Account window title  {lsAddAccount[2]} is correct") 
			[ ] 
			[ ] // Verify that Download Transaction tab is available
			[ ] bEnable=BrokerageAccount.wTransaction.DownloadTransactionsTab.Exists(5)
			[ ] 
			[ ] // Report Status
			[+] if (bEnable == TRUE)
				[ ] ReportStatus("Verification of Download Transaction Tab", PASS, " Download Transaction Tab is present on Brokerage Account window") 
			[+] else
				[ ] ReportStatus("Verification of Download Transaction Tab", FAIL, " Download Transaction Tab is not available on Brokerage Account window") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify account window title", FAIL, "Actual -  {sActualAccName} is not matching with Expected - {lsAddAccount[2]}") 
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] // //#############################################################################
[ ] // 
[+] // //############### Buy Transaction in Brokerage Account ###############################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test14_InvestmentBuyTransaction()
		[ ] // // 
		[ ] // // DESCRIPTION:			
		[ ] // // This Testcase verifies "Cash Balance" after Buy transaction from Brokerage Account
		[ ] // // 
		[ ] // // PARAMETERS:			None
		[ ] // // 
		[ ] // // RETURNS:				Pass 		if Cash Balance after Buy transaction is correct	
		[ ] // //							Fail		if any error occurs 
		[ ] // // 
		[ ] // // REVISION HISTORY:	24/12/2020  	Created By	Udita Dube
		[ ] // // 
	[ ] // //*********************************************************
[+] testcase Test14_InvestmentBuyTransaction  () appstate none //SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iAddTransaction, iCount
		[ ] STRING sActualCashBalance,sExpectedCashBalance
		[ ] LIST OF STRING lsRow
		[ ] 
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 4th row from the given sheet
	[ ] lsAddAccount=lsExcelData[4]
	[ ] 
	[ ] lsExcelData=NULL
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sInvestingTransactionWorksheet)
	[ ] // Fetch 1th row from the given sheet
	[ ] lsTransactionData=lsExcelData[1] 
	[ ] ListDelete(lsTransactionData,5)
	[ ] ListInsert(lsTransactionData,5,sDate)
	[ ] // If Quicken is launched then verify Brokerage Account window
	[+] if (QuickenWindow.Exists() == True)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iSelect = AccountBarSelect(ACCOUNT_INVESTING, 1)	
		[ ] sleep(5)
		[+] if (iSelect==PASS)
			[ ] 
			[ ] ReportStatus("Account select from account bar", PASS, " Account {lsAddAccount[2]} selected.") 
			[ ] 
			[ ] //Buy Transaction with all data
			[ ] iAddTransaction= AddBrokerageTransaction(lsTransactionData)
			[ ] 
			[ ] //  Verify that Cash Balance
			[+] if(iAddTransaction==PASS)
				[ ] ReportStatus("Add Brokerage Transaction: {lsTransactionData[2]}", PASS, "{lsTransactionData[2]} Transaction is added") 
				[ ] iCount=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()
				[ ] 
				[ ] sHandle = Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for (iCount =0 ; iCount<20 ;++iCount)
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] sExpectedCashBalance=str(val(lsTransactionData[11]),NULL,2)
					[ ] sExpectedCashBalance=stuff(sExpectedCashBalance,2,0,",")
					[ ] bMatch = MatchStr("*{sExpectedCashBalance}*",sActual)
					[+] if (bMatch)
						[ ] break
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify Cash Balance", PASS, "Cash Balance {sActual} is correct")
				[+] else
					[ ] ReportStatus("Verify Cash Balance", FAIL, "Actual -  {sActual} is not matching with Expected - {sExpectedCashBalance}")
			[+] else
				[ ] ReportStatus("Verify that Total Market Value", FAIL, "Verification has not been done as transaction - {lsTransactionData[2]} is not added ") 
				[ ] 
		[+] else
			[ ] ReportStatus("Account select from account bar", FAIL, " Account {lsAddAccount[2]} couldn't be selected.") 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] // //############### Sell Transaction in Brokerage Account ################################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test15_InvestmentSellTransaction()
		[ ] // // 
		[ ] // // DESCRIPTION:			
		[ ] // // This Testcase verifies the Market Value after sell transaction from Brokerage Account
		[ ] // // 
		[ ] // // PARAMETERS:			None
		[ ] // // 
		[ ] // // RETURNS:				Pass 		if Market Value after Sell transaction is correct					
		[ ] // //							Fail		if any error occurs 
		[ ] // // 
		[ ] // // REVISION HISTORY:	24/12/2020  	Created By	Udita Dube
		[ ] // // 
	[ ] // //*********************************************************
[+] testcase Test15_InvestmentSellTransaction () appstate SmokeBaseState
	[+] //Variable declaration
		[ ] INTEGER iAddTransaction, iCount
		[ ] STRING sActualCashBalance,sExpectedCashBalance
		[ ] LIST OF STRING lsRow
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sInvestingTransactionWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsTransactionData=lsExcelData[2]
	[ ] ListDelete(lsTransactionData,5)
	[ ] ListInsert(lsTransactionData,5,sDate)
	[ ] 
	[ ] // If Quicken is launched then verify Brokerage Account window
	[+] if (QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] // This will click  first Investment account on AccountBar
		[ ] iSelect = AccountBarSelect(ACCOUNT_INVESTING, 1)	
		[ ] 
		[+] if (iSelect==PASS)
			[ ] ReportStatus("Account select from account bar", iSelect, " Account {lsTransactionData[4]} selected.") 
			[ ] iAddTransaction= AddBrokerageTransaction(lsTransactionData)
			[ ] sleep(3)
			[ ] QuickenWindow.SetActive()
			[ ] //  Verify that Cash Balance
			[+] if(iAddTransaction==PASS)
				[ ] ReportStatus("Add Brokerage Transaction: {lsTransactionData[2]}", iAddTransaction, "{lsTransactionData[2]} Transaction is added") 
				[ ] sHandle = Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for (iCount =0 ; iCount<20 ;++iCount)
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount))
					[ ] sExpectedCashBalance=str(val(lsTransactionData[11]),NULL,2)
					[ ] sExpectedCashBalance=stuff(sExpectedCashBalance,2,0,",")
					[ ] bMatch = MatchStr("*{sExpectedCashBalance}*",sActual)
					[+] if (bMatch)
						[ ] break
					[ ] 
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify Cash Balance", PASS, "Cash Balance {sActual} is correct")
				[+] else
					[ ] ReportStatus("Verify Cash Balance", FAIL, "Actual -  {sActual} is not matching with Expected - {sExpectedCashBalance}")
			[+] else
				[ ] ReportStatus("Verify that Total Market Value", FAIL, "Verification has not been done as transaction - {lsTransactionData[1]} is not added ") 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify selecting investing account  from account bar", FAIL, " Account: {lsTransactionData[4]} couldn't beselected.") 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[ ] 
[ ] // //#############################################################################
[ ] 
[+] // //############### Verify Quicken File Attributes #######################################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test16_VerifyQuickenFileAttributes()
		[ ] // //
		[ ] // // Description: 				
		[ ] // // This testcase will verify  File Attributes. Confirm the following - Accounts -3, Categories – 162, Memorized Payees – 2, Securities – 5 and Transactions – 7
		[ ] // // 
		[ ] // // PARAMETERS:			None
		[ ] // //
		[ ] // // Returns:			        	Pass 		if attributes verification is done successfully 							
		[ ] // //							Fail		if any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:	 24/12/2020  	Created By	Udita Dube
		[ ] // //	  
	[ ] // //*********************************************************
[+] testcase Test16_VerifyQuickenFileAttributes () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] LIST OF STRING lsActualFileAttribute,lsFileAttributes
		[ ] STRING sExpectedAttribute
		[ ] STRING sLineRead
		[ ] STRING sCurrentVersion
		[ ] STRING sInstallPath="\\ppud9121\QA_builds_from_Onsite\QW14"
		[ ] STRING sReleasePath=QUICKEN_ROOT+ "\Release.txt"
		[ ] 
	[+] // Expected values of Quicken File Attributes
		[ ] lsFileAttributes = {"Accounts", "Categories", "Memorized Payee", "Securities", "Transactions" }
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sQuickenAttributesWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsQuickenAttributes=lsExcelData[2]
	[ ] 
	[+] //Verify if Quicken Version is the latest
		[+] //Get Current Version
			[ ] HFILE OutputFileHandle
			[ ] sys_execute("dir {sInstallPath} /b /o:-d > c:/LatestBuild.txt")
			[ ] OutputFileHandle = FileOpen ("c:/LatestBuild.txt", FM_READ)
			[ ] FileReadLine (OutputFileHandle, sCurrentVersion )
			[ ] FileClose(OutputFileHandle)
		[ ] 
		[ ] 
		[+] // //Verify latest Build with Installed Build
			[ ] // HFILE FileHandle = FileOpen (sReleasePath, FM_READ)   //Opens txt file
			[ ] // FileReadLine(FileHandle,sLineRead)
			[+] // if (sLineRead==sCurrentVersion)
				[ ] // //If version in Release matches with value stored in Current
				[ ] // ReportStatus("Verify Quicken Release Version", PASS, "Installed version is latest  " +sLineRead)
				[ ] // 
			[+] // else 
				[ ] // //If version in Release does not match with value stored in Current
				[ ] // ReportStatus("Verify Quicken Release Version", FAIL, "Installed version is NOT latest " +sLineRead)
				[ ] // Print("Latest Version is" +sCurrentVersion)
	[ ] 
	[ ] 
	[ ] 
	[ ] // Quicken is launched then Verify File Attributes
	[+] if (QuickenWindow.Exists() == True)
		[ ] 
		[ ] // Active Quicken Screen
		[ ] QuickenWindow.SetActive()
		[ ] // Taking all File Attributes of Quicken
		[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
		[ ] 
		[ ] // Verification of Actual File Attributes
		[+] for (i=1;i<=ListCount(lsActualFileAttribute);i++)
			[ ] sExpectedAttribute=str(val(lsQuickenAttributes[i]))
			[+] if(sExpectedAttribute == lsActualFileAttribute[i])
				[ ] ReportStatus("Check File Attributes", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i]}") 
			[+] else
				[ ] ReportStatus("Check File Attributes", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i]}")
				[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] // //#############################################################################
[ ] // 
[ ] // 
[+] // //########## Turn OFF UI Navigation elements ######################################## 
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test17_UINavigationOff()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Uncheck navigation related elements and 
		[ ] // // check their effects
		[ ] // //
		[ ] // // PARAMETERS:	none
		[ ] // //
		[ ] // // RETURNS:			Pass 		If no error occurs while navigation							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //	  Dec 23, 2010		Mamta Jain created	
	[ ] // //*********************************************************
	[ ] // 
[+] testcase Test17_UINavigationOff() appstate none
	[ ] 
	[+] // Variable Declaration
		[ ] INTEGER iMode
		[ ] BOOLEAN bEnable, bPlanningMenuExist
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] QuickenWindow.SetActive()
		[ ] iMode = SetViewMode(VIEW_STANDARD_MENU)		// Select standard menu
		[ ] ReportStatus("Set to Standard View", iMode, "Standard menu select")
		[ ] sleep(2)
		[ ] iMode = UsePopupRegister("OFF")				// use pop up register mode is turned off
		[ ] ReportStatus("Disable Pop up", iMode, "Pop up register mode disabled")
		[ ] sleep(2)
		[ ] iMode = ShowToolBar("OFF")						// show tool bar mode is turned off
		[ ] ReportStatus("Disable Show Tool bar", iMode, "Show tool bar menuitem disabled")
		[ ] sleep(2)
		[ ] bEnable = QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.Exists(5)	// checking tool bar is displayed or not
		[+] if(bEnable == FALSE)
			[ ] ReportStatus("Verify Tool bar", PASS, "Tool bar is not displayed")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Tool bar", FAIL, "Tool bar is still displayed")
			[ ] 
		[ ] // checking menu items are present or not as standard menu is selected
		[ ] 
		[+] if ( QuickenWindow.Planning.Exists(5)== FALSE)
			[ ] ReportStatus("Verify menus unavailability", PASS, "Planning Menu is not present")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify menus unavailability", FAIL, "Planning Menu is present")
			[ ] 
		[ ] 
		[ ] AccountBarSelect(ACCOUNT_BANKING,1)						// on clicking any account from account bar, check new window is opened or not
		[ ] bExist =  BankingPopUp.Exists()
		[+] if (bExist == FALSE)
			[ ] ReportStatus("Verify Pop up", PASS, "New window is not opened")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop up", FAIL, "New window is opened")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] // //##############################################################################
[ ] 
[+] // //########## Turn ON UI Navigation elements ##########################################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test18_UINavigationOn()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Check navigation related elements and
		[ ] // // check their effect
		[ ] // //
		[ ] // // PARAMETERS:	none
		[ ] // //
		[ ] // // RETURNS:			Pass 		If no error occurs while navigation							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //	  Dec 23, 2010		Mamta Jain created	
	[ ] // //*********************************************************
	[ ] // 
[+] testcase Test18_UINavigationOn() appstate none
	[+] // Variable Declaration
		[ ] INTEGER iMode
		[ ] BOOLEAN bEnable,  bPlanningMenuExist
	[ ] LaunchQuicken()
	[ ] sleep(10)
	[+] if(QuickenWindow.Exists(20))
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] iMode = SetViewMode(VIEW_CLASSIC_MENU)		// Select Classic menu
		[ ] ReportStatus("Set View to Classic View", iMode, "Classic menu select")
		[ ] sleep(2)
		[ ] iMode = UsePopupRegister("ON")				// use pop up register mode is turned on
		[ ] ReportStatus("Enable Pop up register mode", iMode, "Pop up register mode enabled")
		[ ] sleep(2)
		[ ] iMode = ShowToolBar("ON")						// show tool bar mode is turned off
		[ ] ReportStatus("Enable Show Tool Bar menuitem", iMode, "Show tool bar enabled")
		[ ] sleep(5)
		[ ] QuickenWindow.SetActive()
		[ ] bEnable = QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.Exists()	// checking availability of Tool bar
		[+] if(bEnable == TRUE)
			[ ] ReportStatus("Verify Tool Bar Availability", PASS, "Tool bar is displayed")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Tool Bar Availability", FAIL, "Tool bar is not displayed")
			[ ] 
		[ ] // checking menu items are present or not as classic menu is selected
		[ ] 
		[+] if ( QuickenWindow.Planning.Exists(5))
			[ ] ReportStatus("Verify menus availability", PASS, "Menus are displayed")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify menus availability", FAIL, "Menus are not displayed")
			[ ] 
		[ ] 
		[ ] AccountBarSelect(ACCOUNT_BANKING,1)						// on clicking any account from account bar, check new window is opened or not
		[ ] bExist =  BankingPopUp.Exists(5)
		[ ] 
		[+] if (bExist == TRUE)
			[ ] ReportStatus("Verify Pop up", PASS, "New window is opened")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop up", FAIL, "New window is not opened")
			[ ] 
			[ ] 
		[ ] BankingPopUp.SetActive()
		[ ] BankingPopUp.Close()
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] // //##############################################################################
[ ] 
[ ] 
[+] // //########## Manage Bill and Income reminders   ######################################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test19_ShortcutKeyBillandIncomeReminder()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will invoke Bill and Income Reminder window using short cut keys.
		[ ] // //
		[ ] // // PARAMETERS:	none
		[ ] // //
		[ ] // // RETURNS:			Pass 		If no error occurs while opening window							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //	  Dec 23, 2010		Mamta Jain created	
	[ ] // //*********************************************************
[+] testcase Test19_ShortcutKeyBillandIncomeReminder() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] BOOLEAN bEnable
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] QuickenWindow.TypeKeys("<Ctrl-j>")
		[ ] bEnable = BillAndIncomeReminders.Exists(5)
		[+] if (bEnable == TRUE)
			[ ] BillAndIncomeReminders.Maximize()
			[ ] ReportStatus("Verify Shortcut key Ctrl-J", PASS, "Manage Bill and Income Reminder Window is displayed using Short cut Key") 
			[ ] BillAndIncomeReminders.Close()
		[+] else
			[ ] ReportStatus("Verify Shortcut key Ctrl-J", FAIL, "Manage Bill and Income Reminder Window is not displayed") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] // //##############################################################################
[ ] // 
[+] // //########## Open Account List from Tools Menu  ###################################### 
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test20_OpenAccountList()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will invoke Account list from Tools menu and check window title
		[ ] // // Also check previously added accounts
		[ ] // //
		[ ] // // PARAMETERS:	none
		[ ] // //
		[ ] // // RETURNS:			Pass 		If no error occurs while invoking account list							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //	  Dec 24, 2010		Mamta Jain created
		[ ] // // 	  Jan 31, 2011		Udita Dube  updated
	[ ] // //*********************************************************
[+] testcase Test20_OpenAccountList() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] BOOLEAN bAssert
		[ ] STRING sCaption,sExpected
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
		[+] if(iNavigate == PASS)
			[ ] bExist = AccountList.Exists(5)
			[+] if(bExist== TRUE)
				[ ] AccountList.Maximize()
				[ ] sCaption = AccountList.GetCaption()
				[ ] bAssert = AssertEquals(TOOLS_ACCOUNT_LIST, sCaption)
				[+] if(bAssert == TRUE)
					[ ] ReportStatus("Verify window title", PASS, "Window title -  {sCaption} is correct") 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify window title", FAIL, "Window title -  {sCaption}is not correct")
					[ ] 
				[ ] 
				[ ] 
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
				[ ] 
				[ ] // ####### Verify Accounts in Account List window #####################
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
				[ ] bMatch = MatchStr("*{lsExcelData[1][2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify First Account", PASS, "{lsExcelData[1][2]} account is present") 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify First Account", FAIL, "{lsExcelData[1][2]} account is not present") 
					[ ] 
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "4")
				[ ] bMatch = MatchStr("*{lsExcelData[2][2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify second Account", PASS, "{lsExcelData[2][2]} account is present") 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify second Account", FAIL, "{lsExcelData[2][2]} account is not present") 
					[ ] 
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "8")
				[ ] bMatch = MatchStr("*{lsExcelData[4][2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify third Account", PASS, "{lsExcelData[4][2]} account is present") 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify third Account", FAIL, "{lsExcelData[4][2]} account is not present") 
					[ ] 
				[ ] 
				[ ] AccountList.Close ()
			[+] else
				[ ] ReportStatus("Verify Account List window", FAIL, "Account List  window is not opened") 
		[+] else
			[ ] ReportStatus("Verify Account List Window", iNavigate, "Account List window is not invoked from Tools menu") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] // //##############################################################################
[ ] // 
[+] // //########## Open Category List from Tools Menu  #####################################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test21_OpenCategoryList()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will invoke Category list from Tools menu and check window title
		[ ] // //
		[ ] // // PARAMETERS:	none
		[ ] // //
		[ ] // // RETURNS:			Pass 		If no error occurs while invoking category list							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //	  Dec 24, 2010		Mamta Jain created	
	[ ] // //*********************************************************
[+] testcase Test21_OpenCategoryList() appstate SmokeBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] BOOLEAN bAssert
		[ ] STRING sCaption
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iNavigate = NavigateQuickenTools(TOOLS_CATEGORY_LIST)
		[+] if(iNavigate == PASS)
			[ ] bExist = CategoryList.Exists(5)
			[+] if(bExist== TRUE)
				[ ] ReportStatus("Verify Category List window", PASS, "Category List window is opened") 
				[ ] 
				[ ] sCaption = CategoryList.GetCaption()
				[ ] bAssert = AssertEquals(TOOLS_CATEGORY_LIST, sCaption)
				[+] if(bAssert == TRUE)
					[ ] ReportStatus("Verify window title", PASS, "Window title-  {sCaption} is found") 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify window title", FAIL, "Window title -  {sCaption}is not matching with Expected - {TOOLS_CATEGORY_LIST}") 
					[ ] 
				[ ] CategoryList.Close ()
			[+] else
				[ ] ReportStatus("Verify Category List window", FAIL, "Category List window is not opened") 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Category List Window", iNavigate, "Category List window is not invoked from Tools menu") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] // //##############################################################################
[ ] 
[+] //########## Open Memorized Payee List from Tools Menu  ##############################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test22_OpenMemorizedPayeeList()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Memorized Payee List from Tools menu and check window title
		[ ] // Also check previously added payees.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking Memorized Payee List 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 24, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test22_OpenMemorizedPayeeList() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] BOOLEAN  bAssert
		[ ] INTEGER  iCount
		[ ] STRING sCaption,sExpected
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sCheckingTransactionWorksheet)
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] //Navigate to Tools > Memorized Payee list
			[ ] iNavigate = NavigateQuickenTools(TOOLS_MEMORIZE_PAYEE_LIST)
			[+] if(iNavigate == PASS)
				[ ] MemorizedPayeeList.SetActive()
				[+] //Verify the Memorized Payee list window exists
					[ ] bExist = MemorizedPayeeList.Exists(5)
					[+] if(bExist == TRUE)
						[ ] ReportStatus("Verify Memorized Payee List window", PASS, "Memorized Payee List window is opened") 
						[ ] MemorizedPayeeList.SetActive()
						[ ] sCaption = MemorizedPayeeList.GetCaption()
						[ ] bAssert = AssertEquals(TOOLS_MEMORIZE_PAYEE_LIST, sCaption)
						[+] if(bAssert == TRUE)
							[ ] ReportStatus("Verify Memorized Payee List window title", PASS, "Window title -  {sCaption} is correct") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Memorized Payee List window title", FAIL, "Window title -  {sCaption}is not correct") 
							[ ] 
						[ ] 
						[ ] //Verify the contents in Memorized Payee List
						[ ] iCount = ListCount(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetContents())
						[+] if(iCount != 0)
							[ ] sHandle = Str(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetHandle ())
							[ ] 
							[ ] //--------Verify Payee in Payee List window --------
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
							[ ] bMatch = MatchStr("*{lsExcelData[1][6]}*", sActual)
							[+] if(bMatch == TRUE)
								[ ] ReportStatus("Verify First Payee", PASS, "Payee name - {lsExcelData[1][6]} is displayed") 
							[+] else
								[ ] ReportStatus("Verify First Payee", FAIL, "Actual Payee name - {sActual}, Expected Payee name - {lsExcelData[1][6]}") 
								[ ] 
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
							[ ] 
							[ ] bMatch = MatchStr("*{lsExcelData[2][6]}*", sActual)
							[+] if(bMatch == TRUE)
								[ ] ReportStatus("Verify second Payee", PASS, "Payee name - {lsExcelData[2][6]} is displayed") 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify second Account", FAIL, "Actual Payee name - {sActual}, Expected Payee name - {lsExcelData[2][6]}") 
								[ ] 
						[+] else
							[ ] ReportStatus("Verify Count of Payees", PASS, "Count of Payees - {iCount}")
							[ ] 
						[ ] MemorizedPayeeList.Close ()
					[+] else
						[ ] ReportStatus("Verify Memorized Payee List window", FAIL, "Memorized Payee List window is not opened") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Memorized Payee List Window", iNavigate, "Memorized Payee List window is not invoked from Tools menu") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //############### Run Net worth report ###############################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 		Test23_RunNetWorthReport()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Test Case  is to open graph report for Net Worth and verifies the window title
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Net Worth Report opens successfully with expected window title					
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	28/12/2020  	Created By	Udita Dube
		[ ] // 
	[ ] //*********************************************************
[+] testcase Test23_RunNetWorthReport () appstate SmokeBaseState
	[+] // Variable declaration
		[ ] BOOLEAN bWindowTitle
		[ ] INTEGER  iReportSelect
		[ ] STRING sActual
		[ ] STRING sExpWindowTitle= "Net Worth"
	[ ] 
	[ ] // If Quicken is launched then run Net Worth Report 
	[+] if (QuickenWindow.Exists(5) )
		[ ] 
		[ ] // Set Activate main window
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Open Net Worth Report
		[ ] //iReportSelect = OpenReport(lsReportCategory[10], sREPORT_NETWORTH)		// OpenReport("Graphs", "Net Worth")
		[ ] QuickenWindow.Reports.Click()
		[ ] QuickenWindow.Reports.Graphs.Click()
		[ ] QuickenWindow.Reports.Graphs.NetWorth.Click()
		[ ] 
		[ ] //ReportStatus("Run {sREPORT_NETWORTH} Report", iReportSelect, "Run Report successful") 
		[ ] 
		[ ] sleep(2)
		[ ] 
		[ ] bExist =NetWorthReports.Exists(5)
		[ ] 
		[ ] // Verify Net Worth window is Opened
		[+] if(bExist == TRUE)
			[ ] 
			[ ] // Set Activate Net Worth window
			[ ] NetWorthReports.SetActive()
			[ ] 
			[ ] // Maximize Net Worth Report window
			[ ] NetWorthReports.Maximize()
			[ ] 
			[ ] // Get window caption
			[ ] sActual = NetWorthReports.GetCaption()
			[ ] 
			[ ] // Verify window title
			[ ] bWindowTitle = AssertEquals(sExpWindowTitle, sActual)
			[ ] 
			[ ] // Report Status if window title is as expected
			[+] if (bWindowTitle == TRUE)
				[ ] ReportStatus("Verify Report Window Title", PASS, "Window Title -  {sActual} is correct") 
			[ ] // Report Status if window title is wrong
			[+] else
				[ ] ReportStatus("Verify Report Window Title", FAIL, "Window Title  -  {sActual} is not matching with Expected - {sExpWindowTitle}") 
			[ ] 
			[ ] // Close Net Worth Report window
			[ ] NetWorthReports.Close()
			[ ] 
		[ ] // Report Status if Net Worth window is not available
		[+] else
			[ ] ReportStatus("Verification of {sExpWindowTitle} window", FAIL, "{sExpWindowTitle} window not found") 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] //###############################################################################
[ ] // 
[+] // //############### Run Spending by Category report ######################################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 		Test24_RunSpendingByCategoryReport()
		[ ] // // 
		[ ] // // DESCRIPTION:			
		[ ] // // This Tesecase is to open graph report for Spending By Category and verifies categories and its values
		[ ] // // 
		[ ] // // PARAMETERS:			None
		[ ] // // 
		[ ] // // RETURNS:				Pass 		if Spending By Category Report opens successfully with expected categories and  values					
		[ ] // //							Fail		if any error occurs 
		[ ] // // 
		[ ] // // REVISION HISTORY:	28/12/2020  	Created By	Udita Dube
		[ ] // // 
	[ ] // //*********************************************************
[+] // testcase Test24_RunSpendingByCategoryReport () appstate SmokeBaseState
	[ ] // 
	[+] // // Variable declaration
		[ ] // BOOLEAN bWindowTitle,bMatch1,bMatch2
		[ ] // INTEGER  iReportSelect
		[ ] // STRING sCategoryValue1,sCategoryValue2,sExpectedCategory1,sValue1,sValue2,sExpWindowTitle
	[+] // // Expected values
		[ ] // sExpWindowTitle= "Spending by Category"
		[ ] // sExpectedCategory1="Financial"
	[ ] // 
	[ ] // // Read data from excel sheet
	[ ] // lsExcelData=ReadExcelTable(sSmokeData, sCheckingTransactionWorksheet)
	[ ] // 
	[ ] // // If Quicken is launched then run Spending by Category Report
	[+] // if (QuickenWindow.Exists(5) == True)
		[ ] // 
		[ ] // // Set Activate main window
		[ ] // QuickenWindow.SetActive()
		[ ] // QuickenWindow.Reports.Click()
		[ ] // QuickenWindow.Reports.Graphs.Click()
		[ ] // QuickenWindow.Reports.Graphs.SpendingByCategory.Click()
		[ ] // 
		[ ] // // Open Spending by Category Report
		[ ] // //iReportSelect = OpenReport(lsReportCategory[5],sExpWindowTitle)			//OpenReport("Spending",sExpWindowTitle)
		[+] // // if (iReportSelect == PASS)
			[ ] // // ReportStatus("Run {sExpWindowTitle} Report", PASS, "Run Report {sExpWindowTitle} successful") 
		[+] // // else
			[ ] // // ReportStatus("Run {sExpWindowTitle} Report", FAIL, "Run Report {sExpWindowTitle} Failed") 
		[ ] // 
		[ ] // // Verify Spending by Category window is Opened
		[+] // if (SpendingByCategory.Exists(5))
			[ ] // 
			[ ] // // Set Activate Spending by Category window
			[ ] // SpendingByCategory.SetActive()
			[ ] // 
			[ ] // // Maximize Spending by Category Report window
			[ ] // SpendingByCategory.Maximize()
			[ ] // 
			[ ] // 
			[ ] // // Get window caption
			[ ] // sActual = SpendingByCategory.GetCaption()
			[ ] // 
			[ ] // // Verify window title
			[ ] // bWindowTitle = AssertEquals(sExpWindowTitle, sActual)
			[+] // if (bWindowTitle == TRUE)
				[ ] // ReportStatus("Verify Report Window Title", PASS, "Window Title -  {sActual} is correct") 
			[+] // else
				[ ] // ReportStatus("Verify Report Window Title", FAIL, "Window Title -  {sActual} is not matching with Expected - {sExpWindowTitle}") 
			[ ] // 
			[ ] // sValue1=trim(str(val(lsExcelData[2][3]),7,2))
			[ ] // //  Verify Report Data
			[ ] // sHandle = Str(SpendingByCategory.QWListViewer1.ListBox1.GetHandle ())
			[ ] // sCategoryValue1= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"1")
			[ ] // bMatch1 = MatchStr("*{sExpectedCategory1}*{sValue1}*", sCategoryValue1)
			[+] // if(bMatch1)
				[ ] // ReportStatus("Verify Report Data", PASS, "Report data is correct: Category1= {sExpectedCategory1} with Value {sValue1}")
			[+] // else
				[ ] // ReportStatus("Verify Report Data", FAIL, "Actual report data - {sCategoryValue1} is not matching with Expected  - {sExpectedCategory1} {sValue1}")
				[ ] // 
			[ ] // 
			[ ] // sValue2=trim(str(val(lsExcelData[1][3]),7,2))
			[ ] // 
			[ ] // sCategoryValue2= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"3")
			[ ] // bMatch2 = MatchStr("*{lsExcelData[1][8]}*{sValue2}*", sCategoryValue2)
			[+] // if(bMatch2)
				[ ] // ReportStatus("Verify Report Data", PASS, "Report data is correct: Category2= {lsExcelData[1][8]} with Value {sValue2} ")
			[+] // else
				[ ] // ReportStatus("Verify Report Data", FAIL, "Actual report data - {sCategoryValue2} is not matching with Expected  - {lsExcelData[1][8]} {sValue2}")
				[ ] // 
			[ ] // // Close Spending by Category Report window
			[ ] // SpendingByCategory.Close()
			[ ] // 
			[ ] // //check if save as report popup is displayed
			[+] // // if(DlgChangeReminderDetails.OKButton.Exists(5))
				[ ] // // DlgChangeReminderDetails.OKButton.click()
				[ ] // // sleep(3)
			[ ] // 
		[ ] // // Report Status if Spending by Category window is not available
		[+] // else
			[ ] // ReportStatus("Verification of {sExpWindowTitle} window", FAIL, "{sExpWindowTitle} window not found") 
	[ ] // // Report Status if Quicken is not launched
	[+] // else
		[ ] // ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
	[ ] // 
[ ] // //################################################################################
[ ] 
[+] //########## Open Spending Tab  #####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test25_OpenSpendingTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Spending tab and Verify window title.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking spending tab							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 23, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test25_OpenSpendingTab() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] BOOLEAN bEnable
		[ ] STRING sCaption
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iNavigate = NavigateQuickenTab(sTAB_SPENDING)
		[+] if (iNavigate == PASS)
			[ ] ReportStatus("Verify tab navigation", iNavigate, "{sTAB_SPENDING} tab is invoked") 
			[ ] 
			[ ] sCaption = QuickenMainWindow.GetCaption()
			[ ] bMatch = Matchstr("*Spending*", sCaption)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Verify Window Title", PASS, "Window Title - {sTAB_SPENDING} is correct") 
			[+] else
				[ ] ReportStatus("Verify Window Title", FAIL, "Window Title - {sTAB_SPENDING} is not correct") 
		[+] else
			[ ] ReportStatus("Verify tab navigation", iNavigate, "Spending tab is not invoked") 
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##############################################################################
[+] //########## Open Investing Center  #################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test27_OpenInvestingCenter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will navigate to Investing >Protfolio tab and verify total cost basis and 
		[ ] // Verify that Price history dialog for Intuit is invoked.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  10 Jan, 2011  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test27_OpenInvestingCenter() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER iCount
		[ ] STRING sExpected,sExpectedWindowTitle,sActualWindowTitle,sExpectedSecurity,sRow
    
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sInvestingTransactionWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsTransactionData=lsExcelData[2]
	[ ] 
	[ ] sExpectedWindowTitle= "Price History for: {lsTransactionData[5]}"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Menu bar > Go to Investing
		[ ] QuickenWindow.Investing.Click()
		[ ] QuickenWindow.Investing.GoToInvesting.Select()
		[ ] 
		[ ] sleep(2)
		[ ] // Navigate to Investing > Portfolio tab
		[ ] iNavigate=NavigateQuickenTab(sTAB_INVESTING,sTAB_PORTFOLIO)
		[ ] ReportStatus("Navigate to {sTAB_INVESTING} > {sTAB_PORTFOLIO} ", iNavigate, "Navigate to {sTAB_INVESTING} > {sTAB_PORTFOLIO}") 
		[ ] 
		[ ] sExpected=str(val(lsTransactionData[11]),NULL,2)
		[ ] sExpected=stuff(sExpected,2,0,",")
		[ ] 
		[ ] sHandle = Str(Investing.ShowValue.ListBox1.GetHandle())
		[ ] 
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(0))
		[ ] // Verify Total Cost Basis
		[ ] bMatch = MatchStr("*{sExpected}*", sActual)
		[+] if(bMatch == TRUE)
			[ ] ReportStatus("Verify Total Cost Basis", PASS, "Total Cost Basis {sExpected} is correctly displayed under {sTAB_INVESTING} > {sTAB_PORTFOLIO}  tab") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Total Cost Basis", FAIL, "Expected Value - {sExpected} is not matching with Actual Value - {sActual}") 
			[ ] 
		[ ] 
		[ ] iCount=Investing.ShowValue.ListBox1.GetItemCount()
		[ ] 
		[+] for(i=0;i<=iCount;i++)
			[ ] 
			[ ] sHandle = Str(Investing.ShowValue.ListBox1.GetHandle())
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
			[ ] bMatch = MatchStr("*{lsTransactionData[5]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] sRow = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, str(i))
				[+] if(sRow=="1")
					[ ] sleep(2)
					[ ] // Right Click and select Price History
					[ ] //Investing.ShowValue.ListBox1.PopupSelect (40, 82, "Price History")
					[ ] Investing.ShowValue.ListBox1.PopupSelect (43, 92, "Price History")
					[ ] 
					[+] if (PriceHistory.Exists(5))
						[ ] 
						[ ] sActualWindowTitle=PriceHistory.GetCaption()
						[ ] // Verify Window Title
						[ ] bMatch = MatchStr("*{sExpectedWindowTitle}*", sActualWindowTitle)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Verify Price History window title", PASS, "Window tile {sExpectedWindowTitle} is correct") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Price History window title", FAIL, "Expected Value - {sExpectedWindowTitle} is not matching with Actual Value - {sActualWindowTitle}") 
							[ ] 
						[ ] 
						[ ] PriceHistory.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Price History window", FAIL, "Window {sExpectedWindowTitle} is not invoked") 
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Row Selection", FAIL, "Row is not getting selected") 
				[ ] ReportStatus("Find Security under {sTAB_INVESTING} tab", PASS, "Security {lsTransactionData[4]} is displayed under {sTAB_INVESTING} tab") 
				[ ] break
			[+] else
				[ ] continue
				[ ] 
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Invoke Lifetime Planner  ###############################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test28_InvokeLifetimePlanner()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will navigate Planning > Lifetime Planner and 
		[ ] // Verify “Change Assumptions” button is present
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 11 Jan, 2011  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test28_InvokeLifetimePlanner() appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN  bMatch
		[ ] STRING sCaption
    
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Planning.Click()
		[ ] QuickenWindow.Planning.GoToPlanning.Select()
		[ ] sleep(2)
		[ ] // Navigate to Investing > Portfolio tab
		[ ] iNavigate=NavigateQuickenTab(sTAB_PLANNING,sTAB_LIFETIME_PLANNER)
		[ ] 
		[ ] //QuickenWindow.Planning.LifetimePlanner.Select()
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] sCaption = QuickenMainWindow.GetCaption()
		[ ] 
		[ ] bMatch = MatchStr("*{sTAB_PLANNING}*", sCaption)
		[+] if (bMatch == TRUE)
			[ ] ReportStatus("Verify Planning tab", PASS, "{sTAB_PLANNING} tab is invoked") 
		[+] else
			[ ] ReportStatus("Verify Planning tab", FAIL, "{sTAB_PLANNING} tab is not invoked") 
		[ ] 
		[ ] //Planning.SetActive()
		[ ] 
		[+] if(MDIClient.Planning.ChangeAssumptions.Exists(5))
			[ ] ReportStatus("Verify 'Change Assumptions' button", PASS, "Change Assumption button is present under {sTAB_PLANNING} > {sTAB_LIFETIME_PLANNER}") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify 'Change Assumptions' button", FAIL, "Change Assumption button is not present under {sTAB_PLANNING} > {sTAB_LIFETIME_PLANNER}") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //########## Invoke Tax Center  #################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test29_InvokeTaxCenter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Tax Center and 
		[ ] // Verify “Assign Tax Categories” button is displayed
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  11 Jan, 2011  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test29_InvokeTaxCenter() appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Navigate to Planning > Go to Planning
		[ ] QuickenWindow.Planning.Click()
		[ ] QuickenWindow.Planning.GoToPlanning.Select()
		[ ] sleep(2)
		[ ] // Navigate to Planning > Tax Center tab
		[ ] iNavigate=NavigateQuickenTab(sTAB_PLANNING,sTAB_TAX_CENTER)
		[ ] ReportStatus("Navigate to {sTAB_PLANNING} > {sTAB_TAX_CENTER} ", iNavigate, "Navigate to {sTAB_PLANNING} > {sTAB_TAX_CENTER}") 
		[ ] 
		[ ] // Verify ��Assign Tax Categories button is displayed
		[+] if(MDIClient.Planning.PlanningSubTab.TaxRelatedExpenses.TaxRelatedExpensesYTD.AssignTaxCategories.Exists(5))
			[ ] ReportStatus("Verify 'Assign Tax Categories' button", PASS, "Assign Tax Categories button is present under {sTAB_PLANNING} > {sTAB_TAX_CENTER}") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify 'Assign Tax Categories' button", FAIL, "Assign Tax Categories button is not present under {sTAB_PLANNING} > {sTAB_TAX_CENTER}") 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //########## Open Tax Planner ####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test30_OpenTaxPlanner()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Tax Planner and 
		[ ] // Verify value of Short term gains and losses
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  10 Feb, 2011  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test30_OpenTaxPlanner() appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN bMatch
		[ ] STRING sActualShortGainsLosses, sExpectedShortGainsLosses
		[ ] sExpectedShortGainsLosses="150"
    
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Check whether Planning is checked or not: View Menu > Tabs to Show > Planning
		[ ] QuickenWindow.View.Click()
		[ ] QuickenWindow.View.TabsToShow.Click()
		[ ] bMatch = QuickenWindow.View.TabsToShow.Planning.IsChecked
		[+] if(bMatch==FALSE)	
			[ ] QuickenWindow.View.Click()
			[ ] QuickenWindow.View.TabsToShow.Click()
			[ ] QuickenWindow.View.TabsToShow.Planning.Select()
			[ ] sleep(1)
		[ ] QuickenWindow.TypeKeys(KEY_ESC)
		[ ] // // Menu item Planning > Tax Planner
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Planning.Click()
		[ ] QuickenWindow.Planning.GoToPlanning.Select()
		[ ] QuickenWindow.SetActive()
		[ ] sleep(1)
		[ ] QuickenWindow.Planning.Click()
		[ ] QuickenWindow.Planning.TaxPlanner.Select()
		[ ] 
		[ ] // ICheck that Tax Planner window is opened
		[+] if(TaxPlanner.Exists(LONG_SLEEP))
			[ ] ReportStatus("Open Tax Planner",PASS,"Tax Planner opened successfully")
			[ ] 
			[ ] TaxPlanner.SetActive()
			[ ] 
			[ ] //------------------------------------------------------------------------------------------
			[ ] //-------------------------WORKING ON THIS-----------------------------------
			[ ] //------------------------------------------------------------------------------------------
			[ ] // // Click on Capital Gains
			[ ] // TaxPlanner.QWBrowserContainer1.StaticText1.CapitalGains.Click(1,48, 178)
			[ ] // 
			[ ] // // Get value of "Short Term Gains and Losses"
			[ ] // sActualShortGainsLosses=DlgTaxPlanner.QWBrowserContainer1.StaticText1.ShellEmbedding1.ShellDocObjectView1.InternetExplorer_Server1.ATL0602B1801.StaticText1.DialogBox1.RegularTax1.GetText()
			[ ] // 
			[ ] // 
			[ ] // // Match the Actual and Expected values
			[ ] // bMatch=AssertEquals(sExpectedShortGainsLosses,sActualShortGainsLosses)
			[+] // if(bMatch==TRUE)
				[ ] // ReportStatus("Verify short term Gains and Losses", PASS, "Short term Gains and Losses is displayed correctly i.e. {sActualShortGainsLosses}")
			[+] // else
				[ ] // ReportStatus("Verify short term Gains and Losses", FAIL, "Actual - {sActualShortGainsLosses} is not matching with Expected - {sExpectedShortGainsLosses}")
			[ ] //------------------------------------------------------------------------------------------
			[ ] //-------------------------WORKING ON THIS-----------------------------------
			[ ] //------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] // Close Tax Planner window
			[+] if(TaxPlanner.Exists(SHORT_SLEEP))
				[ ] TaxPlanner.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Tax Planner window", FAIL, "Tax Planner window is not found")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //############# Open Business Center #############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test31_OpenBusinessCenter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will open Business Center and Verify Window Title
		[ ] // also Verify Total In and Total Out values
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while Opening and verifying							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 5, 2011		Mamta Jain created	
	[ ] // ********************************************************
[+] testcase Test31_OpenBusinessCenter() appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sActual, sExpected
		[ ] BOOLEAN bMatch
	[ ] 
	[ ] // if(SKU_TOBE_TESTED != "Premier")
	[+] if(QuickenWindow.Exists(MEDIUM_SLEEP))
		[ ] 
		[ ] // Check whether Business is checked or not: View Menu > Tabs to Show > Business
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.View.Click()
		[ ] QuickenWindow.View.TabsToShow.Click()
		[ ] sleep(1)
		[ ] bMatch = QuickenWindow.View.TabsToShow.Business.IsChecked
		[+] if(bMatch == FALSE)
			[ ] QuickenWindow.View.TabsToShow.Business.Select()
			[ ] 
			[ ] 
		[ ] QuickenWindow.TypeKeys(KEY_ESC)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_BUSINESS)								// select Business tab
		[ ] sleep(2)
		[ ] sActual = QuickenWindow.GetCaption()			    // Verify Window title
		[ ] 
		[ ] bMatch = MatchStr("*{sTAB_BUSINESS}*", sActual)
		[ ] 
		[+] if(bMatch == TRUE)
			[ ] ReportStatus("Verify Window Title", PASS, "Window title is correct") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Window Title", FAIL, "Actual value - {sActual}, Expected value - {sTAB_BUSINESS}") 
			[ ] 
		[ ] 
		[ ] sActual = Business.ProfitLossSnapshot.MonthPanel.TotalIn.GetText()		// Verify Total In value
		[ ] 
		[ ] sExpected = "$0.00"
		[ ] 
		[ ] bMatch = AssertEquals(sExpected, sActual)
		[ ] 
		[+] if(bMatch == TRUE)
			[ ] ReportStatus("Verify Total In value", PASS, "Expected - {sExpected} matches with Actual - {sActual} Total In value") 
		[+] else
			[ ] ReportStatus("Verify Total In value", FAIL, "Expected - {sExpected}, Actual - {sActual} Total In value") 
			[ ] 
		[ ] 
		[ ] 
		[ ] sActual = Business.ProfitLossSnapshot.MonthPanel.TotalOut.GetText ()	// Verify Total Out value
		[ ] sExpected = "$0.00"
		[ ] bMatch = AssertEquals(sExpected, sActual)
		[ ] 
		[+] if(bMatch == TRUE)
			[ ] ReportStatus("Verify Total Out value", PASS, "Expected - {sExpected} matches with Actual - {sActual} Total Out value") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Total Out value", FAIL, "Expected - {sExpected}, Actual - {sActual} Total Out value") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[+] // else
		[ ] // ReportStatus("Verify testcase according to SKU", WARN, "This Testcase is not executed as this is not applicable for PREMIER SKU") 
		[ ] // 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //############# Add, Edit And Delete Category ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test32_AddEditDeleteCategory()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Add new category, then edit that category 
		[ ] // and then delete the editted category
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while Adding,Editting.Deleting category							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 4, 2011		Mamta Jain created	
		[ ] //      May 14, 2012       Udita Dube  updated for QW2013
	[ ] //*********************************************************
[+] testcase Test32_AddEditDeleteCategory() appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iAdd, iSearch, iEdit, iDelete
		[ ] LIST OF STRING lsEditCategory
		[ ] // CategoryRecord EditCategory = {"Edit US Government Interest", "", "Editted For Smoke Test"}
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sCategoryWorksheet)
	[ ] lsCategoryData=lsExcelData[1]
	[ ] lsEditCategory=lsExcelData[2]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] /////##############Commented by Mukesh by  QW014461#####////
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] //NavigateQuickenTab(sTAB_SPENDING)
		[ ] 
		[ ] iAdd = AddCategory(lsCategoryData[1], lsCategoryData[2], lsCategoryData[3])			// Add new category
		[ ] ReportStatus("Add Category", iAdd, "Category - {lsCategoryData[1]}, is added ") 
		[ ] 
		[ ] iSearch = SearchCategory(lsCategoryData[1])						// search added category
		[+] if(iSearch == PASS)	
			[ ] iEdit = EditCategory(lsExcelData[2])				              // edit category
			[+] if(iEdit == PASS)
				[ ] ReportStatus("Edit Category", iEdit, "Category - {lsCategoryData[1]}, is editted ") 
				[ ] 
			[+] else
				[ ] ReportStatus("Edit Category", iEdit, "Category - {lsEditCategory[1]} is not editted ") 
				[ ] 
			[ ] iDelete = DeleteCategory(lsEditCategory[1])							// delete editted category
			[+] if (iDelete == PASS)
				[ ] ReportStatus("Delete Category", iDelete, "Category - {lsEditCategory[1]} is deleted ") 
				[ ] 
			[+] else
				[ ] ReportStatus("Delete Category", iDelete, "Category - {lsEditCategory[1]} is not deleted ") 
				[ ] 
			[ ] 
			[+] if(CategoryList.Exists(5))
				[ ] CategoryList.Close()
		[+] else
			[+] if(CategoryList.Exists(5))
				[ ] CategoryList.Close()
			[ ] 
			[ ] ReportStatus("Verify Category", iSearch, "Category - {lsCategoryData[1]} is not found ") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] // 
[+] //############# Impact of modifying transactions on report #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test33_ModifyTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Edit transaction, check the transaction report
		[ ] // and then delete the editted transaction and check the transaction report
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while Editting.Deleting and verifying transaction							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 6, 2011		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test33_ModifyTransaction() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER iVerify, iSelect, iEdit, iDelete
		[ ] STRING sWindowType, sExpected, sOutFlow,sAccountName
		[ ] LIST OF STRING lsEditTransaction
		[ ] 
	[+] //Variable Definition
		[ ] sAccountName="Checking 01 Account"
		[ ] 
	[ ] // Read data from excel sheet
	[ ] sDate=ModifyDate(0,"m/d/yyyy")
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sCheckingTransactionWorksheet)
	[ ] lsTransactionData=lsExcelData[1]
	[ ] lsEditTransaction=lsExcelData[3]
	[ ] ListDelete (lsEditTransaction, 4)
	[ ] ListInsert (lsEditTransaction, 4, sDate)
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.View.Click()
		[+] if(QuickenWindow.View.UsePopUpRegisters.IsChecked == TRUE)		// checking the window type
			[ ] sWindowType = sPopUpWindow
		[+] else
			[ ] sWindowType = sMDIWindow
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)		// Select first checking account
		[ ] 
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", iSelect, "Account {lsTransactionData[10]} is selected") 
			[ ] 
			[ ] iVerify = FindTransaction(sWindowType, lsTransactionData[6])		// find transaction
			[+] if(iVerify == PASS)
				[ ] ReportStatus("Verify Transaction", iVerify, "Transaction with Input - {lsTransactionData[6]} is found") 
				[ ] print("***")
				[ ] ListPrint(lsEditTransaction)
				[ ] print("***")
				[ ] print (lsEditTransaction[4])
				[ ] print("***")
				[ ] iEdit = EditCheckingTransaction(sWindowType, lsEditTransaction) 		// edit transaction
				[+] if (iEdit == PASS)
					[ ] ReportStatus("Edit Transaction", PASS, "Transaction with Input - {lsTransactionData[6]} is editted successfully")
					[ ] 
					[ ] iVerify = OpenReport(lsReportCategory[1], sREPORT_TRANSACTION)				//OpenReport("Banking", "Transaction")
					[+] if(TransactionReports.Exists(5) == TRUE)
						[ ] TransactionReports.SetActive ()
						[ ] sHandle = Str(TransactionReports.QWListViewer1.ListBox1.GetHandle ())
						[+] for (iCount=0; iCount < TransactionReports.QWListViewer1.ListBox1.GetItemCount()+1; ++iCount)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))		// Verify that editted transaction is reflected in report
							[ ] sOutFlow=str(val(lsEditTransaction[3]),NULL,2)
							[ ] sExpected = "@@TOTAL OUTFLOWS@-{sOutFlow}"
							[ ] bMatch = MatchStr("*{sExpected}*", sActual)
							[+] if (bMatch)
								[ ] break
						[ ] TransactionReports.Close()
						[ ] WaitForState(TransactionReports, false ,1)
						[+] if(bMatch)
							[ ] ReportStatus("Verify Changes", PASS, "Changes are reflected in Transaction Report") 
						[+] else
							[ ] ReportStatus("Verify Changes", FAIL, "Changes are not reflected in Transaction Report, Expected value - {sExpected}, Actual Value - {sActual}") 
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Transaction Window", FAIL, "Transaction window doesn't exists") 
						[ ] 
				[+] else
					[ ] ReportStatus("Edit Transaction", iEdit, "Transaction with Input - {lsTransactionData[6]} is not editted")
					[ ] 
				[ ] 
				[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)	// select first checking account
				[+] if(iSelect==PASS)
					[ ] ReportStatus("Select Account", iSelect, "Account {lsTransactionData[10]} is selected") 
					[ ] 
					[ ] iDelete = DeleteTransaction(lsEditTransaction[1],lsEditTransaction[6])		// delete transaction
					[+] if (iDelete == PASS)
						[ ] ReportStatus("Delete Transaction", iDelete, "Transaction with Input - {lsEditTransaction[6]} is deleted successfully") 
						[ ] 
						[ ] iVerify = OpenReport(lsReportCategory[1], sREPORT_TRANSACTION)				//OpenReport("Banking", "Transaction")
						[+] if(TransactionReports.Exists(5) == TRUE)
							[ ] TransactionReports.SetActive ()
							[ ] sHandle = Str(TransactionReports.QWListViewer1.ListBox1.GetHandle ())
							[+] for (iCount=0; iCount < TransactionReports.QWListViewer1.ListBox1.GetItemCount()+1; ++iCount)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))		// Verify that editted transaction is reflected in report
								[ ] sExpected = "@@TOTAL OUTFLOWS@0.00"
								[ ] bMatch = MatchStr("*{sExpected}*", sActual)
								[+] if (bMatch)
									[ ] break
							[ ] 
							[ ] TransactionReports.Close()
							[+] if(bMatch)
								[ ] ReportStatus("Verify Changes", PASS, "Changes are reflected in {sREPORT_TRANSACTION} Report") 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Changes", FAIL, "Changes are not reflected in Transaction Report, Expected value - {sExpected}, Actual Value - {sActual}") 
								[ ] 
						[+] else
							[ ] ReportStatus("Verify Transaction Window", FAIL, "Transaction window doesn't exists") 
							[ ] 
					[+] else
						[ ] ReportStatus("Delete Transaction", iDelete, "Transaction with Input - {lsEditTransaction[6]} is not deleted") 
						[ ] // 05/22/2015: Added method call to exit quicken gracefully
						[ ] exitQuicken()
						[ ] // QuickenWindow.Kill()
						[ ] sleep(5)
						[ ] App_Start(sCmdLine)
						[ ] 
				[+] else
					[ ] ReportStatus("Select Account", iSelect, "Account {lsEditTransaction[10]} is not selected") 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Transaction", iVerify, "Transaction with Input - {lsTransactionData[6]} is not found") 
			[ ] 
		[+] else
			[ ] ReportStatus("Select Account", iSelect, "Account {lsTransactionData[10]} is NOT selected") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############## Create New Saving Account #######################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test34_AddSavingAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will add Saving Account - Smoke Savings 
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if saving account is added without any errors						
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 05/01/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test34_AddSavingAccount () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 3rd row 
	[ ] lsAddAccount=lsExcelData[3]
	[ ] 
	[ ] // Quicken is launched then Add Checking Account
	[+] if (QuickenWindow.Exists(5) == True)
		[ ] 
		[ ] // Add Saving Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if Saving Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Add Saving Account", iAddAccount, "Saving Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Saving Account", iAddAccount, "Saving Account -  {lsAddAccount[2]}  is not created")
			[ ] 
		[ ] 
		[ ] //  Verify that Account is shown on account bar
		[+] if(iAddAccount==PASS)
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"3")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Verify Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsAddAccount[1]} Account", FAIL, "Verification has not been done as {lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
			[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
[ ] //############################################################################
[ ] 
[+] //############## Create New Asset Account #########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test35_AddAssetAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will add Asset Account (House) - Smoke Asset
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if asset account is added without any errors						
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 05/01/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test35_AddAssetAccount () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount
	[ ] 
	[ ] // read excel table
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sOtherAccountSheet)
	[ ] // fetch 1st row
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Quicken is launched then Add Checking Account
	[+] if (QuickenWindow.Exists(5) == True)
		[ ] 
		[ ] // Add Asset Account (House)
		[ ] iAddAccount = AddPropertyAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],lsAddAccount[4],lsAddAccount[5])
		[ ] // Report Status if Asset Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Add Asset Account", iAddAccount, "Asset Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Asset Account", iAddAccount, "Asset Account -  {lsAddAccount[2]}  is not created")
			[ ] 
		[ ] 
		[ ] //  Verify that Account is shown on account bar
		[+] if(iAddAccount==PASS)
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Verify Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsAddAccount[1]} Asset Account", FAIL, "Verification has not been done as {lsAddAccount[1]} Asset Account -  {lsAddAccount[2]} is not created")
			[ ] 
		[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############## Create New Other Liability Account ##################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test36_AddOtherLiabilityAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will add Other Liability account - Smoke Liability
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if other liability account is added without any errors						
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 05/01/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test36_AddOtherLiabilityAccount () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount
	[ ] 
	[ ] // read excel table
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sOtherAccountSheet)
	[ ] // fecth 2nd row 
	[ ] lsAddAccount=lsExcelData[2]
	[ ] 
	[ ] // Quicken is launched then Add Checking Account
	[+] if (QuickenWindow.Exists(5) == True)
		[ ] 
		[ ] // Add Other Liability Account 
		[ ] iAddAccount = AddOtherLiabilityAccount(lsAddAccount[1],  lsAddAccount[2], lsAddAccount[3],lsAddAccount[6])
		[ ] // Report Status if Other Liability Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Add Asset Account", iAddAccount, "Asset Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Asset Account", iAddAccount, "Asset Account -  {lsAddAccount[2]}  is not created")
			[ ] 
		[ ] 
		[ ] //  Verify that Account is shown on account bar
		[+] if(iAddAccount==PASS)
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"2")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Verify Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
			[+] else
				[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
		[+] else
			[ ] ReportStatus("Verify Other Liability Account", FAIL, "Verification has not been done as Other Liability Account -  {lsAddAccount[2]} is not created")
			[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] // //############## Create New Business Account ######################################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test37_AddBusinessAccount()
		[ ] // // 
		[ ] // // DESCRIPTION:			
		[ ] // //This testcase will add two Business accounts - “Smoke Vendor Invoice” and “Smoke Customer Invoice”
		[ ] // // 
		[ ] // // PARAMETERS:			None
		[ ] // // 
		[ ] // // RETURNS:				Pass 	if Business account is added without any errors						
		[ ] // //							Fail	if any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:	
		[ ] // // 06/01/2011  	Created By	Udita Dube
	[ ] // //*********************************************************
[+] testcase Test37_AddBusinessAccount () appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount
	[ ] 
	[ ] 
	[+] if(SKU_TOBE_TESTED != "Premier")
		[ ] // Read excel table
		[ ] lsExcelData = ReadExcelTable(sSmokeData, sOtherAccountSheet)
		[ ] // Fetch 3rd row
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] // Quicken is launched then Add Business Account
		[+] if (QuickenWindow.Exists(5) == True)
			[ ] QuickenWindow.SetActive()
			[ ] //***************Add Business Account (Accounts Payable)****************************************************
			[ ] iAddAccount = AddBusinessAccount(lsAddAccount[1], lsAddAccount[2])
			[ ] // Report Status if Business Account (Accounts Payable)  is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Add Business Account", iAddAccount, "Business Account -  {lsAddAccount[1]}  is created successfully")
				[ ] 
			[+] else
				[ ] ReportStatus("Add Business Account", iAddAccount, "Business Account -  {lsAddAccount[1]}  is not created")
				[ ] 
			[ ] 
			[ ] //  Verify that Business Account (Accounts Payable) is shown on account bar
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"1")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Verify Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
				[ ] 
			[ ] 
			[ ] // fetch 4th row
			[ ] lsAddAccount=lsExcelData[4]
			[ ] // 
			[ ] // ***************Add Business Account (Accounts Receivable)****************************************************
			[ ] iAddAccount = AddBusinessAccount(lsAddAccount[1], lsAddAccount[2])
			[ ] // Report Status if Business Account (Accounts Receivable)  is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Add Business Account", iAddAccount, "Business Account -  {lsAddAccount[1]}  is created successfully")
				[ ] 
			[+] else
				[ ] ReportStatus("Add Business Account", iAddAccount, "Business Account -  {lsAddAccount[1]}  is not created")
				[ ] 
			[ ] 
			[ ] //  Verify that Business Account (Accounts Receivable) is shown on account bar
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"1")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Verify Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
				[ ] 
			[ ] 
		[ ] // Report Status if Quicken is not launched
		[+] else
			[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
			[ ] 
	[+] else
		[ ] ReportStatus("Verify testcase according to SKU", WARN, "This Testcase is not executed as this is not applicable for PREMIER SKU") 
		[ ] 
	[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[+] //#############  Verify adding Customer Invoice using account actions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test38_VerifyAddCustomerInvoiceUsingAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding Customer Invoice using account actions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding Customer Invoice using account actions verifification  is successful
		[ ] //						Fail			If adding Customer Invoice using account actions is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 18, 2014		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test38_VerifyAddCustomerInvoiceUsingAccountActions() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] LIST OF ANYTYPE lsTransaction ,lsTemp
		[ ] NUMBER nAmount
		[ ] STRING sValidationText
		[ ] // Read data from excel sheet
		[ ] lsExcelData = ReadExcelTable(sSmokeData, sOtherAccountSheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[4]
		[ ] // Fetch 1st row from the sRegCustomerVendorTransactions sheet
		[ ] sAccountName=lsAddAccount[2]
		[ ] lsExcelData=ReadExcelTable(sSmokeData, sRegCustomerVendorTransactions) 
		[ ] lsTransaction=lsExcelData[1]
		[ ] ///Get the total amount of invoice////
		[ ] nAmount=VAL(lsTransaction[15])
	[ ] 
	[+] if(BankingPopUp.Exists(5))
		[ ] BankingPopUp.SetActive()
		[ ] BankingPopUp.Close()
		[ ] WaitForState(BankingPopUp , FALSE ,5)
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] //Set popup register off
		[ ] UsePopupRegister("OFF")	
		[ ] 
		[ ] //Select the BUSINESS account
		[ ] iSelect=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
		[ ] 
		[+] if (iSelect==PASS)
			[+] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
				[ ] ///##########Verifying Customer Invoices Account Actions> New Customer Invoice#####////
				[ ] sValidationText="Invoice - " + sAccountName
				[ ] NavigateToAccountActionBanking(3, sMDIWindow)
				[+] if (DlgInvoice.Exists(4))
					[ ] DlgInvoice.SetActive()
					[ ] sActual=DlgInvoice.GetProperty("Caption")
					[+] if (sActual==sValidationText)
						[ ] 
						[ ] iResult=AddBusinessInvoiceTransaction(lsTransaction[1],lsTransaction[2], lsTransaction[3], lsTransaction[4], lsTransaction[5], lsTransaction[6], lsTransaction[7], lsTransaction[8], lsTransaction[9], lsTransaction[10], lsTransaction[11], lsTransaction[12],  lsTransaction[13], lsTransaction[14] )
						[+] if (iResult==PASS)
							[ ] //Verify that transaction in register using Find and Replace dailog box///
							[ ] lsTemp=GetTransactionsInRegister(lsTransaction[1])
							[ ] 
							[+] if (ListCount(lsTemp)>0)
								[ ] bMatch= MatchStr("*{sAccountName}*{lsTransaction[1]}*{trim(Str(nAmount,7,2))}*",lsTemp[1])
								[+] if (bMatch==TRUE)
									[ ] ReportStatus("Verify New Customer Invoice added", PASS, "Verify New Customer Invoice added: Customer Invoice with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} entered in account {sAccountName}.")
									[ ] ////delete the added invoice///
									[ ] DeleteTransaction(sMDIWindow,lsTransaction[1])
								[+] else
									[ ] ReportStatus("Verify New Customer Invoice added", FAIL, "Verify New Customer Invoice added: Customer Invoice with payee {lsTransaction[1]} and amount - {trim(Str(nAmount,7,2))} couldn't be entered in account {sAccountName} correctly.")
							[+] else
								[ ] ReportStatus("Verify New Customer Invoice added", FAIL, "Verify New Customer Invoice added: Transaction with payee {lsTransaction[1]} not found in Find and Replace dailog box.")
						[+] else
							[ ] ReportStatus("Verify New Customer Invoice added.", FAIL, "Verify New Customer Invoice added: New Customer Invoice with customer {lsTransaction[1]} couldn't be added.")
					[+] else
						[ ] ReportStatus("Verify Customer Invoices Account Actions> New Customer Invoice", FAIL, "Verify Customer Invoices Account Actions>New Customer Invoice option: Dialog {sValidationText} didn't display.")
				[+] else
					[ ] ReportStatus("Verify New Customer Invoice", FAIL, "Verify Dialog New Customer Invoice: New Customer Invoice dialog didn't appear.")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't be selected.")
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] 
[+] //############# Verify user is able to add a business  ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test39_VerifyUserIsAbleToAddABusiness()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify adding a business
		[ ] 
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	if no error occurs while adding a business
		[ ] //                                     				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 18, 2014		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test39_VerifyUserIsAbleToAddABusiness() appstate none
	[ ] INTEGER iAddBusiness
	[ ] STRING  sBusiness ,sBusinessTag
	[ ] sBusinessTag = "BusinessTag"
	[ ] sBusiness = "Business_Test"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] ////####Add a Business#######////
		[ ] iAddBusiness= AddBusiness ( sBusiness,  sBusinessTag)
		[+] if(iAddBusiness==PASS)
			[ ] ReportStatus("Verify user is able to add a business", PASS, "Business: {sBusiness} is added.")
		[+] else
			[ ] ReportStatus("Verify user is able to add a business", FAIL, "Business: {sBusiness} couldn't be added.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
[ ] 
[ ] 
[+] // //########## Create Reminder  ####################################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test40_CreateReminder()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will add reminder and Verify it in home tab
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If no error occurs while creating reminder							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //	  Jan 10, 2011		Mamta Jain created	
		[ ] // //      May 14, 2012       Udita Dube  updated
	[ ] // // ********************************************************
[+] testcase Test40_CreateReminder () appstate SmokeBaseState
	[+] // Variable Declaration
		[ ] STRING sWindowName ,sReminderType ,sPayeeName
		[ ] INTEGER iAdd,  iCount, j
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] 
	[ ] 
	[ ] // Read excel table
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sReminderSheet)
	[ ] iCount = ListCount (lsExcelData) 		// get row count
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[+] for(i = 1; i<=iCount; i++)
			[ ] lsReminderData = lsExcelData[i]				// get contents from i th row
			[ ] ListDelete (lsReminderData, 4)
			[ ] ListInsert (lsReminderData, 4, sDateStamp)
			[ ] 
			[ ] sReminderType=lsReminderData[1]
			[ ] sPayeeName=lsReminderData[2]
			[ ] iNavigate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[+] if (iNavigate == PASS)
					[ ] 
					[ ] iAdd=AddReminderInDataFile(sReminderType,sPayeeName,lsReminderData[3],lsReminderData[4],lsReminderData[5],lsReminderData[6],lsReminderData[7],lsReminderData[8],lsReminderData[9],lsReminderData[10])
					[ ] 
					[+] if (iAdd == PASS)
						[ ] ReportStatus("Create {sReminderType} ", PASS, "{sReminderType} with Payee Name {sPayeeName} and amount {lsReminderData[3]} created.")
						[ ] 
						[+] if(DlgAddEditReminder.Exists(SHORT_SLEEP))
							[ ] DlgAddEditReminder.SetActive()
							[ ] DlgAddEditReminder.CancelButton.Click()
							[ ] WaitForState(DlgAddEditReminder, false,1)
							[ ] 
						[ ] 
						[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)	// Navigate to Home tab
						[ ] QuickenWindow.SetActive()
						[ ] sHandle= Str(MDIClient.Home.ListBox2.GetHandle ())
						[ ] 
						[+] for(j= 1; j<=5; j++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(j))
							[ ] bMatch = MatchStr("*{sPayeeName}*{lsReminderData[3]}*", sActual)
							[+] if (bMatch)
								[ ] break
						[+] if (bMatch)
							[ ] ReportStatus("Verify Payee name and Amount ", PASS, "{lsReminderData[1]} is displayed on Home Tab with Payee - {sPayeeName} and Amount - {Str(Val(lsReminderData[3]), NULL, 2)}")
						[+] else
							[ ] ReportStatus("Verify Payee name and Amount ", FAIL, "Expected Value - {sPayeeName} of Payee and Expected Value - {lsReminderData[3]} of Amount, Actual Value: {sActual}")
					[+] else
						[ ] ReportStatus("Create {sReminderType} ", FAIL, "{sReminderType} with Payee Name {sPayeeName} and amount {lsReminderData[3]} couldn't be created.")
						[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Bills tab state", iNavigate, "Bills tab is not active") 
				[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] // //############################################################################
[ ] 
[+] //########## Create Income and Transfer Reminder  ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test41_CreatePayCheckReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will create Income and Transfer Reminder and Verify it in Home tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while creating Income and Transfer reminder							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Feb 02, 2011		Mamta Jain created	
	[ ] // ********************************************************
[+] testcase Test41_CreatePayCheckReminder() appstate none
	[+] // Variable Declaration
		[ ] BOOLEAN bCompany, bAmount, bState, bFlag
		[ ] STRING sAmount
		[ ] INTEGER iAdd
	[ ] 
	[ ] // Variable Defination
	[ ] bFlag = FALSE
	[ ] 
	[ ] // Read excel table
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sPaycheckSheet)
	[ ] // fetch 1st row
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Bills.Click()
		[ ] QuickenWindow.Bills.AddReminder.Click()
		[ ] QuickenWindow.Bills.AddReminder.PaycheckReminder.Select()
		[ ] 
		[+] if(PayCheckSetup.Exists(5))
			[ ] PayCheckSetup.SetActive ()
			[ ] PayCheckSetup.HowMuchPaycheck.Select("Gross amount")
			[ ] PayCheckSetup.Next.Click ()
			[ ] PayCheckSetup.CompanyName.SetText (lsAddAccount[1])
			[ ] PayCheckSetup.MemoOptional.SetText (lsAddAccount[2])
			[ ] PayCheckSetup.Next.Click ()
			[ ] bExist = PayCheckError.Exists(5)
			[+] if(bExist == TRUE)						// check for error message
				[ ] PayCheckError.SetActive()
				[ ] PayCheckError.OK.Click()
				[ ] PayCheckSetup.Close()
				[ ] bFlag = TRUE							// set flag to True - states that error message exists
			[+] else
				[ ] PayCheckSetup.SetActive ()
				[ ] PayCheckSetup.Account.Select (lsAddAccount[3])
				[ ] PayCheckSetup.QWSnapHolder.AcceptClearenceTransaction.TransactionFrame.AddEarning.Click()
				[ ] PayCheckSetup.QWSnapHolder.AcceptClearenceTransaction.TransactionFrame.AddEarning.TypeKeys(Replicate(KEY_DN, 1)) 
				[ ] PayCheckSetup.QWSnapHolder.AcceptClearenceTransaction.TransactionFrame.AddEarning.TypeKeys(KEY_ENTER)
				[ ] waitforstate(AddEarning,TRUE,10)
				[+] if(AddEarning.Exists(SHORT_SLEEP))
					[ ] AddEarning.SetActive ()
					[ ] AddEarning.AmountTextField.SetText (lsAddAccount[4])
					[ ] AddEarning.OKButton.Click ()
					[ ] 
				[+] else
					[ ] AddEarning.AmountTextField.SetText (lsAddAccount[4])
					[ ] AddEarning.OKButton.Click ()
					[ ] 
				[ ] PayCheckSetup.StartOn.SetText(lsAddAccount[5])
				[ ] PayCheckSetup.Frequency.Select (lsAddAccount[6])
				[ ] PayCheckSetup.Done.Click ()
				[+] if(EnterYearToDateInformation.Exists(5))
					[ ] EnterYearToDateInformation.SetActive()
					[ ] EnterYearToDateInformation.OK.Click()
					[+] if(PaycheckYearToDateAmounts.Exists(5))
						[ ] PaycheckYearToDateAmounts.SetActive()
						[ ] PaycheckYearToDateAmounts.Enter.Click()
		[+] else
			[ ] ReportStatus("Verify PayCheck Window", FAIL, "PayCheck window doesn't exists") 
			[ ] 
		[ ] 
		[+] if(bFlag == FALSE)					// if flag is false then continue creating Paycheck reminder
			[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)		// Select Home tab
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] sHandle= Str(MDIClient.Home.ListBox2.GetHandle ())
			[ ] 
			[+] for(i = 1; i<=5; i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
				[ ] bCompany = MatchStr("*{lsAddAccount[1]}*", sActual)
				[ ] sAmount=str(val(lsAddAccount[4]),NULL,2)
				[ ] bAmount = MatchStr("*{sAmount}*", sActual)
				[+] if (bCompany == TRUE && bAmount == TRUE)
					[ ] ReportStatus("Verify Company name and Amount ", PASS, "Paycheck is displayed on Home Tab with Company - {lsAddAccount[1]} and Amount - {sAmount}")
					[ ] break
				[+] else
					[+] if(i == 5)
						[ ] ReportStatus("Verify Company name and Amount ", FAIL, "Expected Company - {lsAddAccount[1]} and Amount - {sAmount}, Actual Value - {sActual}")
						[ ] 
					[+] else
						[ ] continue
					[ ] 
		[+] else
			[ ] ReportStatus("Verify Company", FAIL, "Company Name - {lsAddAccount[1]} already exists") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# C2R Functionality (Banking) ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test42_C2RFunctionalityBanking()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will disable “Automatically add downloaded transactions to Registers” checkbox in Quicken Preferences.
		[ ] // Import Banking web connect file and Confirm that transactions are displayed in C2R UI and after accepting all,
		[ ] // transactions are diplayed in register.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 21, 2011	      Mamta Jain 	Created	
	[ ] //*********************************************************
[+] testcase Test42_C2RFunctionalityBanking() appstate none 
	[+] // Variable declaration
		[ ] INTEGER iCreateDataFile,iAccount
		[ ] BOOLEAN bFlag,bVerify
		[ ] STRING sOnlineTransactionDataFile, sFilePath,sFileName,sAccount,sAccountName,sEndingBalance,sIndex1,sIndex2, sCaption, sEndingBalance1, sExpected
	[ ] 
	[+] // Expected Values
		[ ] sFileName = "WellsFargo_Checking"
		[ ] sFilePath = AUT_DATAFILE_PATH + "\WebConnect_Files\" + sFileName
		[ ] sOnlineTransactionDataFile= "OnlineTransactionFile"
		[ ] sAccountName="Checking at Wells Fargo Bank"
		[ ] sEndingBalance="20"
		[ ] sEndingBalance1= "130"
		[ ] sIndex1="#12"
		[ ] sIndex2= "#14"
		[ ] bFlag = FALSE
	[ ] 
	[+] // Pre-requisite
		[ ] // Delete qa_acc32.dll
		[+] if(FileExists (sAccDllDestinationPath))
			[ ] DeleteFile(sAccDllDestinationPath)
		[ ] // Delete file intu_onl.ini located in WIndows directory
		[+] if(FileExists (sDestinationonliniFile))
			[ ] DeleteFile(sDestinationonliniFile)
		[ ] 
		[+] if(FileExists(AUT_DATAFILE_PATH + "\" + "{sOnlineTransactionDataFile}.QDF"))
			[ ] DeleteFile(AUT_DATAFILE_PATH + "\" +  "{sOnlineTransactionDataFile}.QDF")
	[ ] 
	[ ] // //Create a new data file for Online transaction download
	[ ] iResult = DataFileCreate_OII(sOnlineTransactionDataFile)
	[+] if (iResult  == PASS)
		[ ] 
		[ ] ReportStatus("Verify Data File ", PASS, "Data file -  {sOnlineTransactionDataFile} is created")
		[ ] 
		[ ] 
		[ ] 
		[ ] // Check if Quicken is launched
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[+] if (LowScreenResolution.Exists(10))
					[ ] LowScreenResolution.Dontshowthisagain.Check()
					[ ] LowScreenResolution.OK.Click()
					[ ] Sleep(3)
					[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window was closed")
			[+] else
					[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window did not appear")
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Restore()
			[ ] sleep(2)
			[ ] QuickenWindow.Maximize()
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] 
			[ ] // Navigate to Edit > Preferences
			[ ] iResult=SelectPreferenceType("Downloaded Transactions")
			[+] if(iResult== PASS)
				[ ] Preferences.SetActive()
				[ ] 
				[ ] // Check the avalability of the checkbox
				[+] if(Preferences.AutomaticallyAddDownloadedT.Exists(5))
					[ ] // Check the checkbox if it is unchecked
					[ ] bVerify=Preferences.AutomaticallyAddDownloadedT.IsChecked()
					[+] if(bVerify==TRUE)
						[ ] Preferences.AutomaticallyAddDownloadedT.Uncheck()
						[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Checkbox is unchecked") 
						[ ] 
					[+] else
						[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Checkbox is already unchecked") 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify checkbox for Automatic Transaction entry'", FAIL, "Checkbox is not available") 
					[ ] 
				[ ] Preferences.OK.Click()
				[ ] WaitForState(Preferences, false ,2)
				[ ] // Navigate to File > File Import > Web Connect File
				[ ] iResult = ImportWebConnectFile(sFileName)
				[+] if(iResult==PASS)
					[ ] ReportStatus("Import Web Connect File ",PASS,"Web Connect file: {sFileName} is imported successfully.")
					[ ] //  Verify that Account is shown on account bar
					[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
					[ ] bMatch = MatchStr("*{sAccountName}*{sEndingBalance}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Verify Accounts in Account Bar", PASS, "{sAccountName} account is available with ending balance - {sEndingBalance}")
						[ ] 
						[ ] 
						[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
						[+] if (iResult  == PASS)
							[ ] 
							[+] if(MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions.Exists(5))
								[ ] 
								[ ] sCaption = MDIClient.AccountRegister.StaticText1.QWinChild.DownloadedTransactions.GetCaption ()
								[ ] sExpected = "5"
								[ ] bMatch = MatchStr("*{sExpected}*", sCaption)
								[+] if(bMatch == TRUE)
									[ ] ReportStatus("Verify No. of Transactions", PASS, "No. of Transactions = {sExpected}")
								[+] else
									[ ] ReportStatus("Verify No. of Transactions", FAIL, "Expected no. of Transaction - {sExpected}, Actual no. of Transaction - {sCaption}")
									[ ] 
								[ ] 
								[ ] MDIClient.AccountRegister.QWSnapHolder1.StaticText2.AcceptAll.Click()
								[ ] 
								[ ] sleep(2)
								[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
								[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
								[ ] bMatch = MatchStr("*{sEndingBalance1}*", sActual)
								[+] if(bMatch == TRUE)
									[ ] ReportStatus("Verify Ending Balance in Account Bar", PASS, "Ending balance - {sEndingBalance1} is displayed")
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Ending Balance in Account Bar", FAIL, "Expected ending Balance - {sEndingBalance1}, Actual ending Balance - {sActual}")
									[ ] 
							[+] else
								[ ] ReportStatus("Verify DownloadedTransactions tab", FAIL, "DownloadedTransactions tab is not available")
								[ ] 
						[+] else
							[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account couldn't be selected from Account bar")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sActual} account is not available in Account bar")
						[ ] 
				[+] else
					[ ] ReportStatus("Import Web Connect File ",FAIL,"Web Connect file: {sFileName} is not imported successfully.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify 'Downloaded Transactions on preferences dialog", FAIL, "Downloaded Transactions not available on preferences dialog.") 
			[ ] 
		[ ] //Report Status if Quicken is not launched
		[+] else
			[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Data File ", FAIL, "Data file -  {sOnlineTransactionDataFile} couldn't be created")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# Verify auto categorization functionality########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test43_VerifyAutoCategorizationFunctionality()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will disable “Automatically add downloaded transactions to Registers” checkbox in Quicken Preferences.
		[ ] // Import Banking web connect file and Confirm that transactions are displayed in C2R UI and after accepting all,
		[ ] // transactions are diplayed in register.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 21, 2011	      Mamta Jain 	Created	
	[ ] //*********************************************************
[+] testcase Test43_VerifyAutoCategorizationFunctionality() appstate none 
	[+] // Variable declaration
		[ ] LIST OF ANYTYPE lsPayee , lsCategories ,lsListBoxItems
		[ ] STRING sExpReportTitle ,sItem
		[ ] INTEGER iReportSelect ,iReportRowsCount
	[+] // Expected Values
		[ ] sFileName = "BofA_Checking_2014"
		[ ] sFilePath = AUT_DATAFILE_PATH + "\WebConnect_Files\" + sFileName
		[ ] lsPayee = {"Mcdonald's" ,"Dollar Tree" ,"Walgreens", "Valero"}
		[ ] lsCategories = {"Food & Dining:Fast Food" , "Shopping" , "Health & Fitness:Pharmacy" , "Auto & Transport:Gas & Fuel"}
		[ ] // Array a [4] [4] = {"a" , "1"}
		[ ] // list of list of string lspayeetest={{"a" , "1"},{"m" , "2"},{"i" , "3"}}
		[ ] 
		[ ] sAccountName="Checking at Bank of America-All Other S"
	[ ] 
	[ ] 
	[ ] // Verify if Quicken is launched
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[+] if (LowScreenResolution.Exists(10))
				[ ] LowScreenResolution.Dontshowthisagain.Check()
				[ ] LowScreenResolution.OK.Click()
				[ ] Sleep(3)
				[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window was closed")
		[+] else
				[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window did not appear")
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Restore()
		[ ] sleep(2)
		[ ] QuickenWindow.Maximize()
		[ ] sleep(2)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] DisableAddingDownloadedTransactionsToRegisters()
		[ ] 
		[ ] // Navigate to File > File Import > Web Connect File
		[ ] iResult = ImportWebConnectFile(sFileName)
		[+] if(iResult==PASS)
			[ ] ReportStatus("Import Web Connect File ",PASS,"Web Connect file: {sFileName} is imported successfully.")
			[ ] 
			[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[+] if (iResult  == PASS)
				[ ] 
				[+] if(MDIClient.AccountRegister.DownloadedTransactionsTab.Exists(5))
					[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
					[ ] sleep(2)
					[ ] MDIClient.AccountRegister.QWSnapHolder1.StaticText2.AcceptAll.Click()
					[ ] sleep(2)
					[ ] 
					[ ] //Verify auto-categorization in Transaction report
					[ ] sExpReportTitle=NULL
					[ ] sExpReportTitle="Transaction"
					[ ] iReportSelect = OpenReport(lsReportCategory[1], sREPORT_TRANSACTION)	
					[ ] 
					[+] if (iReportSelect==PASS)
						[ ] 
						[+] if (TransactionReports.Exists(5)) 
							[ ] TransactionReports.SetActive()
							[ ] TransactionReports.Maximize()
							[ ] sleep(1)
							[ ] TransactionReports.QWCustomizeBar1.PopupList1.Select("Include all dates")
							[ ] sleep(1)
							[ ] // Get window caption
							[ ] sActual = TransactionReports.GetCaption()
							[ ] 
							[ ] // Verify window title
							[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
							[ ] 
							[ ] // Report Status if window title is as expected
							[+] if ( bMatch )
								[ ] ReportStatus("Verify report window title", PASS, "Report window title -  {sActual} is correct") 
								[ ] //  Verify Report Data
								[ ] sHandle=NULL
								[ ] sHandle = Str(TransactionReports.QWListViewer1.ListBox1.GetHandle ())
								[ ] bMatch=FALSE
								[ ] WaitForState(TransactionReports,TRUE,1)
								[ ] iReportRowsCount=TransactionReports.QWListViewer1.ListBox1.GetItemCount() +1
								[+] for( iCounter=0;iCounter< iReportRowsCount ;++iCounter)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
									[ ] ListAppend (lsListBoxItems,sActual)
								[ ] 
								[ ] //Close the report TransactionReports
								[ ] TransactionReports.SetActive()
								[ ] TransactionReports.Close()
								[ ] WaitForState(TransactionReports , FALSE ,5)
								[+] for( iCounter=1; iCounter< ListCount(lsPayee)+1 ; ++iCounter)
									[ ] 
									[+] for each sItem in lsListBoxItems
										[ ] bMatch = MatchStr("*{lsPayee[iCounter]}*{lsCategories[iCounter]}*", sItem)
										[+] if ( bMatch)
											[ ] break
									[+] if(bMatch)
										[ ] ReportStatus("Verify auto categorization functionality" , PASS , "Auto-categorization applied for payee: {lsPayee[iCounter]} as expected category: {lsCategories[iCounter]}.")
									[+] else
										[ ] ReportStatus("Verify auto categorization functionality" , FAIL , "Auto-categorization applied for payee: {lsPayee[iCounter]} is NOT as expected category: {lsCategories[iCounter]}.")
									[ ] 
									[ ] 
								[ ] // //############## Verifying " My Saved Reports & Graphs " option in Reports############
							[+] else
								[ ] ReportStatus("Verify report window title", PASS, "Report window title -  {sActual} is not as expected: {sExpReportTitle}.") 
							[ ] /////#######Report validation done#######///
						[+] else
							[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
					[+] else
						[ ] ReportStatus("Verify Report displayed", FAIL, "Report didn't open.") 
				[+] else
					[ ] ReportStatus("Verify Downloaded Transactions tab", FAIL, "Downloaded Transactions tab is not available")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account couldn't be selected from Account bar")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Import Web Connect File ",FAIL,"Web Connect file: {sFileName} is not imported successfully.")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] // 
[+] // ############# C2R Functionality (Investing) #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test44_C2RFunctionalityInvesting()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will disable “Automatically add downloaded transactions to Registers” checkbox in Quicken Preferences.
		[ ] // Import Investing web connect file and Confirm that transactions are displayed in C2R UI and after accepting all,
		[ ] // transactions are diplayed in register.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If no error occurs						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Jan 24, 2011	      Mamta Jain 	Created	
	[ ] // *********************************************************
[+] testcase Test44_C2RFunctionalityInvesting() appstate SmokeBaseState 
	[+] // Variable declaration
		[ ] STRING sPayeeName
		[ ] INTEGER iCreateDataFile,iAccount, iBrokerage
		[ ] BOOLEAN bFlag,bVerify
		[ ] STRING sOnlineTransactionDataFile,sFilePath,sFileName,sIndex1,sIndex2, sCaption, sEndingBalance, sExpected, sBrokerageAccountType, sCash,sBrokerageAccount,sStatementEndingDate
	[+] // Expected Values
		[ ] sFileName = "Vanguard_Investing.qfx"
		[ ] sFilePath = AUT_DATAFILE_PATH + "\WebConnect_Files\" + sFileName
		[ ] sOnlineTransactionDataFile= "OnlineTransactionFile"
		[ ] sEndingBalance = "6,589"
		[ ] sBrokerageAccountType = "Brokerage"
		[ ] sBrokerageAccount= "Brokerage 02 Account"
		[ ] sStatementEndingDate = "01/01/2011"
		[ ] sCash = "6,575.75"
		[ ] sPayeeName="Vanguard"
	[ ] 
	[+] // Pre-requisite
		[ ] // Delete qa_acc32.dll
		[+] if(FileExists (sAccDllDestinationPath))
			[ ] DeleteFile(sAccDllDestinationPath)
		[ ] 
		[+] if(FileExists(AUT_DATAFILE_PATH + "\" + "{sOnlineTransactionDataFile}.QDF"))
			[ ] DeleteFile(AUT_DATAFILE_PATH + "\" +  "{sOnlineTransactionDataFile}.QDF")
	[ ] iResult = DataFileCreate_OII(sOnlineTransactionDataFile)
	[ ] // Create a new data file for Online transaction download
	[ ] iResult=PASS
	[+] if (iResult==PASS)
		[ ] 
		[ ] ReportStatus("Verify Data File ", PASS, "Data file -  {sOnlineTransactionDataFile} is created")
		[+] if (QuickenWindow.Exists(5))
			[+] QuickenWindow.SetActive()
				[ ] 
			[ ] iResult=SelectPreferenceType("Downloaded Transactions")
			[+] if(iResult== PASS)
				[ ] Preferences.SetActive()
				[+] if(Preferences.AutomaticallyAddDownloadedT.Exists(5))
					[ ] // Check the checkbox if it is unchecked
					[ ] bVerify=Preferences.AutomaticallyAddDownloadedIT.IsChecked()
					[+] if(bVerify==TRUE)
						[ ] Preferences.AutomaticallyAddDownloadedT.Uncheck()
						[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Checkbox is unchecked") 
						[ ] 
					[+] else
						[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Checkbox is already unchecked") 
						[ ] 
					[ ] Preferences.OK.Click()
					[ ] WaitForState(Preferences,False,2)
					[ ] // Add manual account
					[ ] iResult = AddManualBrokerageAccount(sBrokerageAccountType, sBrokerageAccount, sCash, sStatementEndingDate) 
					[+] if (iResult==PASS)
						[ ] ReportStatus("Add Brokerage Account", PASS, "BrokerageAccount -  {sBrokerageAccount} is created")
						[ ] 
						[ ] 
						[ ] 
						[ ] // Navigate to File > File Import > Web Connect File
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.File.Click()
						[ ] QuickenWindow.File.FileImport.Click()
						[ ] QuickenWindow.File.FileImport.WebConnectFile.Select()
						[ ] 
						[ ] 
						[ ] // Import web connect file
						[+] if(ImportExportQuickenFile.Exists(3))
							[ ] ImportExportQuickenFile.SetActive()
							[ ] ImportExportQuickenFile.FileName.SetText(sFilePath)
							[ ] ImportExportQuickenFile.Open.Click()
							[ ] 
							[+] if(ImportDownloadedTransactions.Exists(40))
								[ ] ImportDownloadedTransactions.SetActive()
								[ ] // Select Existing account
								[ ] ImportDownloadedTransactions.Panel2.LinkToAnExistingAccount.Click()
								[ ] // Click on Import
								[ ] ImportDownloadedTransactions.Import.Click()
								[ ] 
								[+] if(OneStepUpdateSummary.Exists(30))
									[ ] OneStepUpdateSummary.SetActive()
									[ ] OneStepUpdateSummary.Close()
								[+] if (DlgVerifyCashBalance.Exists(30))
									[ ] DlgVerifyCashBalance.SetActive()
									[ ] DlgVerifyCashBalance.TypeKeys(KEY_EXIT)
									[ ] WaitForState(DlgVerifyCashBalance,false,2)
									[ ] sleep(10)
								[ ] 
								[ ] 
								[ ] iResult=SelectAccountFromAccountBar(sBrokerageAccount,ACCOUNT_INVESTING)
								[+] if (iResult==PASS)
									[+] if(MDIClient.BrokerageAccount.wTransaction.DownloadTransactionsTab.Exists (10))
										[ ] sCaption = MDIClient.BrokerageAccount.wTransaction.DownloadTransactionsTab.GetCaption ()
										[ ] sExpected = "0"
										[ ] bMatch = MatchStr("*{sExpected}*", sCaption)
										[+] if(bMatch == TRUE)
											[ ] ReportStatus("Verify No. of Transactions", PASS, "All the transactions has been entered in to the investing register.")
											[ ] //------------------Verify in Register whether the Transaction is Accepted------------------
											[ ] 
											[ ] iResult=FindTransaction(sMDIWindow,sPayeeName ,ACCOUNT_INVESTING)
											[+] if(iResult==PASS)
												[ ] 
												[ ] ReportStatus("Check transaction got added in Register",PASS,"Transaction '{sPayeeName}' has been added into the investing register after importing the investing webconnect file.")
											[+] else
												[ ] ReportStatus("Check transaction got added in Register",FAIL,"Transaction '{sPayeeName}' couldn't be added into the investing register after importing the investing webconnect file.")
											[ ] 
										[+] else
											[ ] ReportStatus("Verify No. of Transactions", FAIL, "All the transactions couldn't be entered in to the investing register the - {sCaption} transactions are still left to be accepted.")
											[ ] 
										[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify DownloadedTransactions tab", FAIL, "DownloadedTransactions tab is not available")
										[ ] 
								[+] else
									[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sBrokerageAccount} account couldn't be selected from Account bar")
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify ImportDownloadedTransactions Window", FAIL, "ImportDownloadedTransactions window is not available") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify 'Import Web Connect File' Window", FAIL, "'Import Web Connect File' Window is not available") 
							[ ] 
					[+] else
						[ ] ReportStatus("Add Brokerage Account", FAIL, "BrokerageAccount -  {sBrokerageAccount} couldn't be created")
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify checkbox for Automatic Transaction entry'", FAIL, "Downloaded Investing Transactions Checkbox is not available") 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify 'Downloaded Transactions on preferences dialog", FAIL, "Downloaded Transactions not available on preferences dialog.") 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Data File ", FAIL, "Data file -  {sOnlineTransactionDataFile} couldn't be created")
		[ ] 
	[ ] 
	[ ] // Check if Quicken is launched
	[ ] 
[ ] // ############################################################################
[ ] 
[+] //############# Automatically adding Download transactions ###########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test45_AutomaticAddDownloadTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Enable “Automatically add downloaded transactions to Registers” checkbox in Quicken Preferences.
		[ ] // Import  web connect file and Confirm that transactions are directly displayed in Register 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 19, 2011	      Udita Dube 	Created	
	[ ] //*********************************************************
[+] testcase Test45_AutomaticAddDownloadTransaction() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER iCreateDataFile,iAccount
		[ ] BOOLEAN bMatch,bFlag
		[ ] STRING sOnlineTransactionDataFile,sFilePath,sFileName,sAccount,sAccountName,sEndingBalance,sIndex1,sIndex2,sDataFilePath, sExpected
	[+] // Expected Values
		[ ] sFileName = "WellsFargo_Checking"
		[ ] sOnlineTransactionDataFile= "OnlineTransactionFile"
		[ ] sDataFilePath = AUT_DATAFILE_PATH + "\" + sOnlineTransactionDataFile + ".QDF"
		[ ] sFilePath = AUT_DATAFILE_PATH + "\WebConnect_Files\" + sFileName
		[ ] sAccountName="Checking at Wells Fargo Bank"
		[ ] sEndingBalance="130"
	[ ] 
	[+] // Pre-requisite
		[ ] // Delete qa_acc32.dll
		[+] if(FileExists (sAccDllDestinationPath))
			[ ] DeleteFile(sAccDllDestinationPath)
		[ ] // Delete file intu_onl.ini located in WIndows directory
		[+] if(FileExists (sDestinationonliniFile))
			[ ] DeleteFile(sDestinationonliniFile)
		[+] // if(FileExists (SYS_GetEnv("WINDIR") + "\\intu_onl.ini"))
			[ ] // DeleteFile(SYS_GetEnv("WINDIR") + "\\intu_onl.ini")
		[ ] // Delete data file if exists
		[+] if(FileExists (sDataFilePath))
			[ ] DeleteFile(sDataFilePath)
	[ ] 
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5) )
		[ ] QuickenWindow.SetActive()
		[ ] // Navigate to Edit > Preferences
		[ ] iResult=SelectPreferenceType("Downloaded Transactions")
		[+] if(iResult== PASS)
			[ ] Preferences.SetActive()
			[ ] 
			[ ] // Check the checkbox if it is unchecked
			[+] if(!Preferences.AutomaticallyAddDownloadedT.IsChecked())
				[ ] Preferences.AutomaticallyAddDownloadedT.Check ()
				[ ] ReportStatus("Enable 'Automatically add downloaded transactions'", PASS, "Checkbox is checked") 
			[+] else
				[ ] ReportStatus("Enable 'Automatically add downloaded transactions'", PASS, "Checkbox is already checked") 
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences, false ,2)
			[ ] QuickenWindow.SetActive()
			[ ] // Navigate to File > File Import > Web Connect File
			[ ] iResult = ImportWebConnectFile(sFileName)
			[+] if(iResult==PASS)
				[ ] ReportStatus("Import Web Connect File ",PASS,"Web Connect file: {sFileName} is imported successfully with C2R Off.")
				[ ] //  Verify that Account is shown on account bar
				[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
				[ ] iListCount =QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetItemCount()
				[+] for (iCount=0 ; iCount<=iListCount ; iCount++)
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(iCount))
					[ ] bMatch = MatchStr("*{sAccountName}*{sEndingBalance}*", sActual)
					[+] if(bMatch)
						[ ] break
					[ ] 
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify Accounts in Account Bar", PASS, "{sAccountName} account is available with ending balance - {sEndingBalance} with C2R off.")
				[+] else
					[ ] ReportStatus("Verify Accounts in Account Bar", FAIL, "{sAccountName} account is not available in Account bar with C2R off.")
				[ ] 
			[+] else
				[ ] ReportStatus("Import Web Connect File ",FAIL,"Web Connect file: {sFileName} is not imported successfully with C2R off.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify 'Downloaded Transactions on preferences dialog", FAIL, "Downloaded Transactions not available on preferences dialog.") 
		[ ] 
		[ ] // 
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] //############## File Backup  ####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test46_FileBackup()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will take a Backup and Verify data file backed up successfully message is displayed
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if File backeup is taken successfully			
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 06/01/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test46_FileBackup () appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER iBackupStatus
		[ ] STRING sFilePath,sFileName
	[+] // Expected Values
		[ ] sFileName = "Smoke File.QDF-backup"
		[ ] sFilePath = BACKUP_PATH + "\"                         //BACKUP_PATH is defined in Globals.inc
	[ ] 
	[ ] // Quicken is launched then take the backup of data file
	[+] if (QuickenMainWindow.Exists(5))
		[ ] 
		[ ] iBackupStatus = QuickenBackup(sFilePath,sFileName)
		[ ] // Report Status after taking file backup
		[+] if (iBackupStatus==PASS)
			[ ] ReportStatus("Verify Quicken Backup ", PASS, "File -  {sFileName}  is backed up successfully")
		[+] else
			[ ] ReportStatus("Verify Quicken Backup ", FAIL, "File Backup is failed ")
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############## File Restore  ####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test47_FileRestore()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will restore a backup file and Verify that file is restored successfully
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if File restored successfully			
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 06/01/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test47_FileRestore () appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER iRestoreStatus
		[ ] STRING sFilePath,sFileName,sRestoreFilePath
	[+] // Expected Values
		[ ] sFileName = "Smoke File"
		[ ] sFilePath = BACKUP_PATH + "\"     
		[ ] sRestoreFilePath=  ROOT_PATH + "\ApplicationSpecific\Data\TestData\" +sFileName +".QDF"                
	[ ] 
	[+] if(FileExists(sRestoreFilePath))
		[ ] DeleteFile(sRestoreFilePath)
		[ ] 
	[ ] 
	[ ] // Quicken is launched then restore the backup file
	[+] if (QuickenMainWindow.Exists(5))
		[ ] 
		[ ] iRestoreStatus = QuickenRestore(sFilePath,sFileName)
		[ ] // Report Status after taking file backup
		[+] if (iRestoreStatus==PASS)
			[ ] ReportStatus("Verify Quicken Backup Restore", iRestoreStatus, "File -  {sFileName}  is restored successfully")
		[+] else
			[ ] ReportStatus("Verify Quicken Backup Restore", iRestoreStatus, "Restore from Backup file is failed ")
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] //########## One Step Update  ###################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test48_OneStepUpdate()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify status of One step update operation
		[ ] // and also verify 5 Quotes updated message is displayed in One Step Update summary dialog
    //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while verification 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 20, 2011		Mamta Jain created	
	[ ] // ********************************************************
[+] testcase Test48_OneStepUpdate() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] STRING  sExpected
		[ ] INTEGER iVerify
		[ ] 
	[+] // Expected Values
		[ ] sExpected = "5 quotes updated"
	[ ] 
	[ ] // Quicken is launched then restore the backup file
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
		[+] if(iNavigate == PASS)
			[ ] 
			[+] if(DlgEnterIntuitPassword.Exists(10))
				[ ] DlgEnterIntuitPassword.SetActive()
				[ ] DlgEnterIntuitPassword.Skip.Click()
			[ ] 
			[+] if(UnlockYourPasswordVault.Exists(10))
				[ ] UnlockYourPasswordVault.SetActive()
				[ ] UnlockYourPasswordVault.Skip.Click()
			[+] if(DlgIAMSignIn.Exists(10))
				[ ] DlgIAMSignIn.SetActive()
				[ ] DlgIAMSignIn.IntuitPasswordTextBox.SetText(sPassword)
				[ ] DlgIAMSignIn.LoginButton.Click()
				[ ] 
			[ ] 
			[+] if(OneStepUpdate.Exists(60))
				[ ] OneStepUpdate.SetActive ()
				[ ] OneStepUpdate.UpdateNow.Click ()		// click on Update button
				[ ] //To handle the OutlookProfile issue
				[+] if (ChooseProfile.Exists(5))
					[ ] ChooseProfile.SetActive()
					[ ] ChooseProfile.Cancel.Click()
				[ ] 
				[ ] 
				[ ] 
				[+] if(OneStepUpdateSummary.Exists(180))
					[ ] ReportStatus("Verify Window", PASS, "{TOOLS_ONE_STEP_UPDATE} Summary window is displayed") 
					[ ] 
					[ ] // verify 5 quotes update message
					[ ] //STRING sHandle = Str(OneStepUpdateSummary.OneStepUpdateSummary1.ListBox1.GetHandle())
					[ ] // STRING sHandle = Str(OneStepUpdateSummary.Panel.QWinChild.Panel2.QWListViewer.ListBox.GetHandle())
					[ ] // 
					[ ] // //.Panel.QWinChild.Panel2.QWListViewer.ListBox.GetHandle())
					[ ] // STRING sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
					[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
					[ ] 
					[+] // if(bMatch == TRUE)
						[ ] // ReportStatus("Verify message", PASS, "One Step Update message is displayed correctly") 
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify message", FAIL, "Expected Message- {sExpected}, is not matching with Actual Message- {sActual}") 
						[ ] // 
					[ ] 
					[ ] OneStepUpdateSummary.Close.Click ()
				[+] else
					[ ] ReportStatus("Verify Window", FAIL, "One Step Update Summary window is not available") 
			[+] else
				[ ] ReportStatus("Verify OneStepUpdate settings Window", FAIL, "{TOOLS_ONE_STEP_UPDATE} settings window didn't display.") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Navigation", FAIL, "Some problem occured while navigating to One Step Window") 
			[ ] 
		[ ] 
		[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# Verify data conversion ##############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test49_VerifyDataConversion()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will Verify data conversion and 
		[ ] // Verifys net worth balance and file attributes
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if old data file coverted and launched without any error					
		[ ] // 							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY: 	
		[ ] //  12 Jan, 2011  Udita Dube created
	[ ] // ********************************************************
[+] testcase Test49_VerifyDataConversion() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] BOOLEAN sFlag, bSource
		[ ] LIST OF STRING lsActualFileAttribute, lsExpectedFileAttribute, lsFileAttributes
		[ ] INTEGER iCreateDataFile,iRegistration,iOpenStatus
		[ ] STRING sFileWithPath, sFileName,sExpectedWindow,sCaption,sNetWorthValue,sSource,sQuicken2010Source,sQuicken2010File, sMessageCaption,sNetWorth
		[ ] 
		[ ] 
	[+] // Expected values
		[ ] sFileName= "Gold Master Quicken 2010"
		[ ] //sFileWithPath = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] bSource= FALSE
		[ ] sQuicken2010Source = AUT_DATAFILE_PATH + "\2010_Data\" + sFileName + ".QDF"
		[ ] sQuicken2010File = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sExpectedWindow ="Convert Your Data"
		[ ] sNetWorth ="OVERALL TOTAL"
		[ ] sNetWorthValue = "549.09"
		[ ] 
		[+] if (SKU_TOBE_TESTED == "RPM")
			[ ] lsExpectedFileAttribute = { "2", "80", "2", "4", "5"}
		[+] else
			[ ] lsExpectedFileAttribute = { "2", "80", "2", "4", "5"}
			[ ] 
		[ ] lsFileAttributes = {"Accounts", "Categories", "Memorized Payee", "Securities", "Transactions" }
		[ ] 
		[ ] //sSource = AUT_DATAFILE_PATH + "\Q10Files\" + sFileName + ".QDF"
		[ ] 
	[ ] 
	[ ] // Pre requisit for the test case
	[+] if(SYS_FileExists(sQuicken2010File))
		[ ] // Delete existing file, if exists
		[ ] DeleteFile(sQuicken2010File)
	[ ] 
	[ ] // Copy last year's data file at given location
	[+] if(SYS_FileExists(sQuicken2010Source))
		[ ] SYS_Execute("attrib -r  {sQuicken2010Source} ")
		[ ] CopyFile(sQuicken2010Source, sQuicken2010File)
		[ ] bSource=TRUE
	[ ] 
	[ ] // Quicken is launched then open Quicken 2010 data file
	[+] if (QuickenWindow.Exists(5) == True && bSource==TRUE)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Open Data File
		[+] do
			[ ] QuickenWindow.File.Click()
			[ ] QuickenWindow.File.OpenQuickenFile.Select()
			[ ] 
		[+] except
			[ ] QuickenMainWindow.TypeKeys("<Ctrl-o>")
		[+] if (ImportExportQuickenFile.Exists(10))
			[ ] 
			[ ] ImportExportQuickenFile.SetActive()
			[ ] ImportExportQuickenFile.FileName.SetText(sQuicken2010File)
			[ ] ImportExportQuickenFile.OK.Click()
			[ ] 
			[ ] // If Data Conversion Wizard exists then start conversion
			[+] if(DataConversionWizard.Exists(15))
				[ ] 
				[ ] DataConversionWizard.SetActive()
				[ ] 
				[ ] // Verify window title
				[ ] sCaption=DataConversionWizard.GetCaption()
				[+] if(sCaption==sExpectedWindow)
					[ ] ReportStatus("Verify window title ", PASS, "Window title -  {sExpectedWindow} is correct")
				[+] else
					[ ] ReportStatus("Verify window title ", FAIL, "Actual - {sCaption} is not matching with Expected window title - {sExpectedWindow}")
					[ ] 
				[ ] 
				[ ] // Start file conversion
				[ ] DataConversionWizard.ConvertFile.Click()
				[+] if (AlertMessage.OK.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage, false ,2)
				[+] if (AlertMessage.Exists(5))
					[+] while (AlertMessage.Exists())
						[ ] sleep(1)
				[ ] 
				[ ] 
				[ ] SignInQuickenConnectedServices()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // Verify converted file is launched
				[ ] sCaption = QuickenWindow.GetCaption ()
				[ ] bMatch = MatchStr("*{sExpectedAboutQuicken}*{sFileName}*", sCaption)
				[+] if (bMatch == TRUE)
					[ ] ReportStatus("Verify converted file launched ", PASS, "Converted file is launched successfully") 
				[+] else
					[ ] ReportStatus("Verify that converted file launched ", FAIL, "Actual - {sCaption} is not matching with Expected  - {sExpectedAboutQuicken} {sFileName}") 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.View.Click()
				[ ] QuickenWindow.View.TabsToShow.Click()
				[+] if(!QuickenWindow.View.TabsToShow.PropertyDebt.IsChecked)
					[ ] QuickenWindow.View.TabsToShow.PropertyDebt.Select()
				[ ] 
				[ ] // Turn OFF Popup mode
				[ ] iSwitchState = UsePopupRegister("OFF")
				[ ] ReportStatus("Verify Pop Up", iSwitchState, "Turn off Pop up register mode")
				[ ] 
				[ ] 
				[ ] // Navigate to Property & Debt
				[ ] iNavigate=NavigateQuickenTab(sTAB_PROPERTY_DEBT)
				[ ] ReportStatus("Navigate to {sTAB_PROPERTY_DEBT} ", iNavigate, "Navigate to {sTAB_PROPERTY_DEBT}") 
				[ ] 
				[ ] // Verification for net worth balance
				[ ] iOpenStatus = OpenReport(sREPORT_NETWORTH_BALANCES,sREPORT_NETWORTH)		// open the report
				[+] if(iOpenStatus == PASS)
					[ ] iCount = NetWorthReports.QWListViewer1.ListBox1.GetItemCount()
					[ ] sHandle = Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())	   // get the handle
					[ ] 
					[+] for (i=iCount ; i>0; --i)
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
						[ ] bMatch = MatchStr("*{sNetWorth}*{sNetWorthValue}*", sActual)
						[+] if (bMatch)
							[ ] break
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Verify Net Worth Balance", PASS, "{sNetWorth} balance {sNetWorthValue} is correctly displayed")
					[+] else
						[ ] ReportStatus("Verify Net Worth Balance", FAIL, "Actual - {sActual} is not matching with Expected {sNetWorth} balance  - {sNetWorthValue}")
					[ ] NetWorthReports.Close()
				[+] else
					[ ] ReportStatus("Verify Networth Report",FAIL,"Networth report is not opened")
				[ ] 
				[ ] // Taking all File Attributes
				[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
				[ ] 
				[ ] // Verification of Actual File Attributes
				[+] for (i=1;i<=ListCount(lsActualFileAttribute);i++)
					[ ] 
					[+] if(lsExpectedFileAttribute[i] == lsActualFileAttribute[i])
						[ ] ReportStatus("Verify {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {lsExpectedFileAttribute[i]} is matching with Actual {lsActualFileAttribute[i]}") 
					[+] else
						[ ] ReportStatus("Verify {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {lsExpectedFileAttribute[i]} is not matching with Actual {lsActualFileAttribute[i]}")
						[ ] 
				[ ] 
				[ ] 
			[+] else 
				[ ] ReportStatus("Verify Data Conversion wizard ", FAIL, "Data Conversion wizard not found")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Open Quicken File", FAIL, "Open Quicken File dailog didn't appear.") 
	[ ] 
	[ ] // Report Status 
	[+] else
		[ ] ReportStatus("Verify Quicken Window and 2010 Quicken data file", FAIL, "Either Quicken window Or 2010 Quicken data file is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[+] //########## Open Security List from using shortcut   ##############################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test51_OpenSecurityList()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Security List from Tools menu and check window title
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while invoking Security List 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Sept 3, 2014		Mukesh created	
	[ ] //*********************************************************
[+] testcase Test51_OpenSecurityList() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] BOOLEAN  bAssert
		[ ] INTEGER  iCount
		[ ] STRING sActualCaption, sExpectedCaption
		[ ] sExpectedCaption="Security List"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] //Navigate to Tools > Security list
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_Y)
			[+] if(SecurityList.Exists(5))
				[ ] ReportStatus("Verify Security List window", PASS, "Security List window invoked using shortcut 'Ctrl-y'.") 
				[ ] SecurityList.SetActive()
				[ ] sActualCaption=SecurityList.GetProperty("Caption")
				[+] if (trim(sActualCaption) ==sExpectedCaption)
					[ ] ReportStatus("Verify title of the Security List window", PASS, " The title of the Security List window is as expected: {sActualCaption}.") 
				[+] else
					[ ] ReportStatus("Verify title of the Security List window", FAIL, " The title of the Security List window is: {sActualCaption} NOT as expected: {sExpectedCaption}.") 
				[ ] SecurityList.Close()
				[ ] WaitForState(SecurityList , FALSE ,5)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Security List window", FAIL, "Security List window didn't invoke using shortcut 'Ctrl-y'.") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
[+] //########## Open Quicken Help using shortcut   ##############################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test52_OpenQuickenHelp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Open Quicken Help using shortcut
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while invoking Quicken Help						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Sept 3, 2014		Mukesh created	
	[ ] //*********************************************************
[+] testcase Test52_OpenQuickenHelp() appstate none
	[+] // Variable declaration
		[ ] BOOLEAN  bAssert
		[ ] INTEGER  iCount
		[ ] STRING sActualCaption, sExpectedCaption
		[ ] sExpectedCaption="Quicken Help"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] //Navigate to Tools > Security list
			[ ] QuickenWindow.TypeKeys(KEY_F1)
			[+] if(QuickenHelp.Exists(5))
				[ ] ReportStatus("Verify Quicken Help window", PASS, "Quicken Help window invoked using shortcut 'F1.") 
				[ ] QuickenHelp.SetActive()
				[ ] sActualCaption=QuickenHelp.GetProperty("Caption")
				[+] if (trim(sActualCaption) ==sExpectedCaption)
					[ ] ReportStatus("Verify title of the Quicken Help window", PASS, " The title of the Quicken Help window is as expected: {sActualCaption}.") 
				[+] else
					[ ] ReportStatus("Verify title of the Quicken Help window", FAIL, " The title of the Quicken Help window is: {sActualCaption} NOT as expected: {sExpectedCaption}.") 
				[ ] QuickenHelp.Close()
				[ ] WaitForState(QuickenHelp , FALSE ,5)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken Help window", FAIL, "Quicken Help window didn't invoke using shortcut 'F1.") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Open Calendar using shortcut   ##############################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test53_OpenCalendar()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Open Calendar using shortcut
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while invoking Calendar					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Sept 3, 2014		Mukesh created	
	[ ] //*********************************************************
[+] testcase Test53_OpenCalendar() appstate none
	[+] // Variable declaration
		[ ] BOOLEAN  bAssert
		[ ] INTEGER  iCount
		[ ] STRING sActualDate, sExpectedDate ,sDateFormat
		[ ] 
		[ ] sDateFormat="m/d/yyyy"
		[ ] sExpectedDate=Modifydate(0 ,sDateFormat)
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] //Navigate to Tools > Security list
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_K)
			[+] if(Calendar.Exists(5))
				[ ] ReportStatus("Verify Calendar window", PASS, "Calendar window invoked using shortcut 'Ctrl-k'.") 
				[ ] Calendar.SetActive()
				[ ] 
				[ ] //Verify current date is displayed on 'Go to date' textfield
				[ ] sActualDate=Calendar.GoToDateTextField.GetText()
				[+] if (trim(sActualDate) ==sExpectedDate)
					[ ] ReportStatus("Verify current date is displayed on 'Go to date' textfield", PASS, "The current date displayed on 'Go to date' textfield on calendar as expected: {sActualDate}.") 
				[+] else
					[ ] ReportStatus("Verify current date is displayed on 'Go to date' textfield", FAIL, "The current date displayed on 'Go to date' textfield on calendar is: {sActualDate} NOT as expected: {sExpectedDate}.") 
				[ ] Calendar.Close()
				[ ] WaitForState(Calendar , FALSE ,5)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Calendar window", FAIL, "Calendar window didn't invoke using shortcut 'Ctrl-k'.") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] //##############################################################################
[+] //############### Create 529 Plan Investment Account ########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test54_529PlanBrokerageAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add 529 Plan Investment (Brokerage) Account
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if 529 Plan brokerage account is added				
		[ ] //							Fail		if any error occurs
		[ ] // REVISION HISTORY:
		[ ] //	  Sept 3, 2014		Mukesh created	
	[ ] //*********************************************************
[+] testcase Test54_529PlanBrokerageAccount () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 4th row from the given sheet
	[ ] lsAddAccount=lsExcelData[5]
	[ ] sAccountName = trim(lsAddAccount[2])
	[ ] // Quicken is launched then Add Brokerage Account
	[+] if (QuickenWindow.Exists(5) == True)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Add Investment Accounts
		[ ] iAddAccount = AddManualBrokerageAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],lsAddAccount[5],lsAddAccount[6])
		[+] if(iAddAccount==PASS)
			[ ] ReportStatus("Add Brokerage Account", PASS, "Brokerage Account -  {sAccountName} is created successfully")
			[ ] 
			[ ] iSelect = SelectAccountFromAccountBar( sAccountName , ACCOUNT_INVESTING)
			[+] if(iSelect==PASS )
				[ ] ReportStatus("Verify 529 Plan account in Account Bar", PASS, "{sAccountName} account is available in account bar")
			[+] else
				[ ] ReportStatus("Verify 529 Plan account in Account Bar", FAIL, "{sAccountName} account couldn't be selected from account bar.") 
		[+] else
			[ ] ReportStatus("Verify Brokerage Account", FAIL, "Verification of account has not been done as Brokerage Account is not created")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] 
[ ] 
[+] //############### Create IRA or Keogh Plan Investment Account ########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test55_IRAOrKeoghPlanBrokerageAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add RA or Keogh Paln Investment (Brokerage) Account
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if RA or Keogh Plan brokerage account is added				
		[ ] //							Fail		if any error occurs
		[ ] // REVISION HISTORY:
		[ ] //	  Sept 3, 2014		Mukesh created	
	[ ] //*********************************************************
[+] testcase Test55_IRAOrKeoghPlanBrokerageAccount () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 4th row from the given sheet
	[ ] lsAddAccount=lsExcelData[6]
	[ ] sAccountName = trim(lsAddAccount[2])
	[ ] // Quicken is launched then Add Brokerage Account
	[+] if (QuickenWindow.Exists(5) == True)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Add Investment Accounts
		[ ] iAddAccount = AddManualBrokerageAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],lsAddAccount[5],lsAddAccount[6])
		[+] if(iAddAccount==PASS)
			[ ] ReportStatus("Verify creation of IRA or Keogh Brokerage Account", PASS, " IRA or Keogh Brokerage Account: {sAccountName} is created successfully")
			[ ] 
			[ ] iSelect = SelectAccountFromAccountBar( sAccountName , ACCOUNT_INVESTING)
			[+] if(iSelect==PASS )
				[ ] ReportStatus("Verify IRA or Keogh Plan account in Account Bar", PASS, "{sAccountName} account is available in account bar")
			[+] else
				[ ] ReportStatus("Verify IRA or Keogh Plan account in Account Bar", FAIL, "{sAccountName} account couldn't be selected from account bar.") 
		[+] else
			[ ] ReportStatus("Verify creation of IRA or Keogh Brokerage Account", FAIL, " IRA or Keogh account: {sAccountName} couldn't be created successfully.")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[ ] 
[+] //############### Verify adding rental property and tenant ########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test56_VerifyRentalPropertyAndTenantt()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add rental property and tenant
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if rental property and tenant is added				
		[ ] //							Fail		if any error occurs
		[ ] // REVISION HISTORY:
		[ ] //	  Sept 4, 2014		Mukesh created	
	[ ] //*********************************************************
[+] testcase Test56_VerifyRentalPropertyAndTenantt () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING  sAccountIntent ,sPropertyWorksheet ,sTenantWorksheet
		[ ] LIST OF ANYTYPE lsAddProperty ,lsAddTenant
		[ ] sAccountIntent="RENTAL"
		[ ] sPropertyWorksheet="Property"
		[ ] sTenantWorksheet = "TenantDetails"
	[ ] 
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sPropertyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddProperty=lsExcelData[1]
	[ ] 
	[ ] // Read Tenant data from excel sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sTenantWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddTenant=lsExcelData[1]
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 4th row from the given sheet
	[ ] lsAddAccount=lsExcelData[7]
	[ ] sAccountName = trim(lsAddAccount[2])
	[ ] // Quicken is launched then Add rental property account
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[+] if (LowScreenResolution.Exists(10))
				[ ] LowScreenResolution.Dontshowthisagain.Check()
				[ ] LowScreenResolution.OK.Click()
				[ ] Sleep(3)
				[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window was closed")
		[+] else
				[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window did not appear")
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Restore()
		[ ] sleep(2)
		[ ] QuickenWindow.Maximize()
		[ ] sleep(2)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Add Checking Account with rental intent
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],sAccountIntent)
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", PASS, "{lsAddAccount[1]} Account -  {sAccountName} is created successfully")
			[ ] //Verfiying adding a property
			[ ] iFunctionResult=AddRentalProperty(lsAddProperty)
			[+] if ( iFunctionResult ==PASS)
				[ ] ReportStatus("Verify Property added", PASS, "Property {lsAddProperty[1]} is added.") 
				[ ] //Verfiying adding a tenant to property
				[ ] iResult=AddRentalPropertyTenant(lsAddTenant)
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify Tenant added", PASS, "Tenant {lsAddTenant[1]} added to property {lsAddTenant[1]}.") 
					[ ] WaitForState(QuickenWindow,True,2)
					[ ] QuickenWindow.SetActive()
				[+] else
					[ ] ReportStatus("Verify Tenant added", FAIL, "Tenant {lsAddTenant[1]} couldn't be added to property {lsAddTenant[1]}.") 
			[+] else
				[ ] ReportStatus("Verify Property added", FAIL, "Property {lsAddProperty[1]} couldn't be added.") 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} Account -  {sAccountName} is not created")
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //############# Verify Split Transaction #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test57_VerifySplitTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify add / updatesplit transaction.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding split transaction is successful
		[ ] //						Fail			If adding split transaction is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 09, 2014		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test57_VerifySplitTransaction() appstate none 
	[ ] 
	[ ] 
	[ ] //Variable Declaration
	[ ] STRING sTag , sMemo
	[ ] LIST OF ANYTYPE lsTransaction ,lsExpenseCategory ,lsAmountData
	[ ] INTEGER iVerify
	[ ] NUMBER nAmount
	[ ] // Read data from sRegAccountWorksheet excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sCheckingTransactionWorksheet)
	[ ] lsTransaction=lsExcelData[3]
	[ ] // Fetch 1st row from sExpenseCategoryDataSheet the given sheet
	[ ] lsExcelData=NULL
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sExpenseCategoryDataSheet)
	[ ] lsExpenseCategory=lsExcelData[1]
	[ ] 
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[+] if (LowScreenResolution.Exists(10))
				[ ] LowScreenResolution.Dontshowthisagain.Check()
				[ ] LowScreenResolution.OK.Click()
				[ ] Sleep(3)
				[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window was closed")
		[+] else
				[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window did not appear")
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Restore()
		[ ] sleep(2)
		[ ] QuickenWindow.Maximize()
		[ ] sleep(2)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] UsePopupRegister("OFF")
		[ ] 
		[ ] //Select the  account
		[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if (iSelect==PASS)
			[ ] 
			[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1])
			[ ] 
			[ ] ////////Fetch 2nd row from sExpenseCategoryDataSheet////
			[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
			[+] if(iVerify==PASS)
				[ ] 
				[ ] 
				[ ] lsExpenseCategory=lsExcelData[2]
				[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
				[+] if(SplitTransaction.Exists(5))
					[ ] SplitTransaction.SetActive()
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_ENTER)
					[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[1])
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(lsExpenseCategory[3])
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
					[+] if (NewTag.Exists(5))
						[ ] NewTag.SetActive()
						[ ] NewTag.OKButton.Click()
						[ ] 
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(lsExpenseCategory[4])
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(KEY_TAB)
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(lsExpenseCategory[2])
					[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(KEY_ENTER)
					[+] if (SplitTransaction.Adjust.IsEnabled())
						[ ] SplitTransaction.Adjust.Click()
					[ ] SplitTransaction.OK.Click()
					[ ] WaitForState(SplitTransaction,False,1)
					[ ] QuickenWindow.SetActive ()
					[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.DoubleClick()
					[ ] ////########Verify Split Button in the category field of the transaction#########///////// 
					[ ] iVerify=FAIL
					[ ] iVerify= VerifyTransactionInAccountRegister(lsTransaction[6],"1",sMDIWindow)   //FindTransaction(sMDIWindow,lsTransaction[6])
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_N) 
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_HOME)
					[ ] MDIClient.AccountRegister.SearchWindow.TypeKeys(lsTransaction[6])
					[ ] 
					[+] if(iVerify==PASS)
						[+] if (MDIClient.AccountRegister.TxList.AddedSplitButton.Exists(5))
							[ ] ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction appeared.")
							[ ] ////########Verify clicking Split Button in the category field of the transaction invokes the split transaction dailog with all categories#########///////// 
							[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
							[ ] // MDIClient.AccountRegister.TxList.AddedSplitButton.Click(1,6,8)
							[+] if(SplitTransaction.Exists(5))
								[ ] SplitTransaction.SetActive()
								[ ] 
								[ ] sHandle=NULL
								[ ] lsExpenseCategory=NULL
								[ ] lsExpenseCategory=lsExcelData[1]
								[ ] nAmount=VAL(lsExpenseCategory[2])
								[ ] lsAmountData=Split(Str(nAmount,7,2),".")
								[ ] sHandle = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "0")
								[ ] bMatch =MatchStr("*{lsExpenseCategory[1]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
								[+] if (bMatch==TRUE)
									[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data: split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} appeared.")
								[+] else
									[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data: split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} didn't appear.")
								[ ] bMatch=FALSE
								[ ] lsExpenseCategory=NULL
								[ ] lsExpenseCategory=lsExcelData[2]
								[ ] nAmount=VAL(lsExpenseCategory[2])
								[ ] lsAmountData=Split(Str(nAmount,7,2),".")
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "1")
								[ ] bMatch =MatchStr("*{lsExpenseCategory[1]}*{lsExpenseCategory[3]}*{lsExpenseCategory[4]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
								[+] if (bMatch==TRUE)
									[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data: Transaction with category {lsExpenseCategory[2]} , Tag: {lsExpenseCategory[3]}, Memo: {lsExpenseCategory[4]} and with amount:{Str(nAmount,7,2)}appeared.")
								[+] else
									[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data: Transaction with category {lsExpenseCategory[2]} , Tag: {lsExpenseCategory[3]}, Memo: {lsExpenseCategory[4]} and with amount: {Str(nAmount,7,2)} didn't appear.")
									[ ] 
								[+] if (!SplitTransaction.IsActive())
									[ ] SplitTransaction.SetActive()
								[ ] SplitTransaction.OK.Click()
								[ ] WaitForState(SplitTransaction,False,1)
								[ ] 
							[+] else
								[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
						[+] else
							[ ] ReportStatus("Verify Split Button in the transaction",FAIL,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction didn't appear.")
					[+] else
							[ ] ReportStatus("Verify Split Transaction",FAIL,"Verify Split Transaction:Transaction with payee {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
					[ ] MDIClient.AccountRegister.SearchWindow.TypeKeys("")
				[+] else
					[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Find Transaction",FAIL,"Transaction {lsTransaction[6]} not found in Account {lsAddAccount[2]}")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsAddAccount[2]}  Account", FAIL, "{lsAddAccount[2]} account couldn't open.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
[ ] 
[+] //############# Verify US$ is the default home currency#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test58_VerifyDefaultHomeCurrency()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the if US$ is the default Home currency for a new Data file
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If US$ is the default Home currency for the Data file						
		[ ] //						Fail		If verification fails
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 10, 2014	
		[ ] //Author                          Mukesh 	
	[ ] // ********************************************************
[-] testcase Test58_VerifyDefaultHomeCurrency() appstate none 
	[+] // Variable Declaration
		[ ] STRING sHomeCurrencyActual , sHomeCurrencyExpected ,sCalendarAndCurrency
		[ ] sHomeCurrencyExpected ="U.S. Dollar"
		[ ] sCalendarAndCurrency= "Calendar and currency"
	[ ] //
	[ ] 
	[-] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iResult=SelectPreferenceType(sCalendarAndCurrency)
		[-] if (iResult==PASS)
			[ ] Preferences.SetActive()
			[ ] Preferences.MulticurrencySupport.Check()
			[ ] Preferences.OK.Click()
			[ ] sleep(7)
			[ ] 
			[ ] //Navigate to Tools Mneu > Currency List
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.CurrencyList.Select()
			[ ] 
			[+] if(CurrencyList.Exists(10))
				[ ] CurrencyList.SetActive()
				[ ] 
				[ ] //Verify if US$ is present in the currency list
				[ ] sHandle = Str(CurrencyList.ListBox.GetHandle ())			// get handle of list box
				[ ] iListCount =CurrencyList.ListBox.GetItemCount()
				[+] for (iCounter =iListCount ; iCounter >=0 ; iCounter--)
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
					[ ] bResult = MatchStr("*{sHomeCurrencyExpected}*" ,sActual)
					[+] if (bResult)
						[ ] CurrencyList.ListBox.VScrollBar.ScrollToMax()
						[ ] CurrencyList.ListBox.TextClick(sHomeCurrencyExpected)
						[ ] CurrencyList.Edit.Click()
						[+] if(DlgEditHomeCurrency.Exists(5))
							[ ] ReportStatus("Verify Edit Home Currency dialog.", PASS, "Edit Home Currency dialog appeared.") 
							[ ] DlgEditHomeCurrency.SetActive()
							[ ] 
							[ ] sHomeCurrencyActual = DlgEditHomeCurrency.CurrencyNameTextField.GetText()
							[+] if (sHomeCurrencyExpected == trim(sHomeCurrencyActual))
								[ ] ReportStatus("Verify US$ is the default Home Currency in Currency List", PASS, "US$ is the default home currency as it is available on Edit Home Currency dialog") 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify US$ is the default Home Currency in Currency List", FAIL, "US$ is NOT the default home currency as it is NOT available on Edit Home Currency dialog.") 
							[ ] DlgEditHomeCurrency.Close()
							[ ] WaitForState(DlgEditHomeCurrency , FALSE ,5)
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Edit Home Currency dialog.", FAIL, "Edit Home Currency dialog didn't appear.") 
						[ ] 
						[ ] break
				[ ] 
				[ ] //Verify if US$ is the default home currency 
				[+] if(bResult==FALSE)
					[ ] ReportStatus("Verify if US$ is present in the currency list", FAIL, "US$ is NOT present in the currency list.") 
				[ ] 
				[ ] CurrencyList.SetActive()
				[ ] CurrencyList.Done.Click()
				[ ] WaitForState(CurrencyList , FALSE ,5)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", FAIL, "Currency List Window Absent")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify preference type: {sCalendarAndCurrency} selected." ,FAIL ,"Preference type: {sCalendarAndCurrency} couldn't be selected.")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
[ ] 
[+] //##########Verify that user is able to add more views on Home page. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test59_VerifyThatUserIsAbleToAddMoreViewsOnHomePage
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to add more views on Home page
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to add more views on Home page
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 10, 2014	
		[ ] //Author                          Mukesh 	
	[ ] // ********************************************************
[+] testcase Test59_VerifyThatUserIsAbleToAddMoreViewsOnHomePage() appstate NavigateToHomeTab
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sViewName
		[ ] sViewName = "TestView"
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.AddViewButton.Click()
		[+] if (CustomizeView.Exists(3))
			[ ] CustomizeView.SetActive()
			[ ] CustomizeView.ViewName.SetText(sViewName)
			[ ] CustomizeView.OK.Click()
			[ ] WaitForState(CustomizeView , False , 2)
			[ ] SelectCustomizeViewItems("Alerts")
			[+] if (QuickenMainWindow.ShowAllAlertsButton.Exists(3))
				[ ] ReportStatus("Verify that user is able to add more views on Home page." , PASS , "New View having Alerts snapshot has been added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify that user is able to add more views on Home page." , FAIL , "New View having Alerts snapshot couldn't be added.")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify that Customize view dialog gets launched when clicked on Add view button." , FAIL , "Customize View dialog didn't appear on clicking Add view button.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] ///OIP Testcases
[ ] 
[ ] // 05/22/2015 KalyanG: Commented below 4 TCs, OIP functionality got changed since 2015 R8
[+] //##########Verify that user is able to Opt out for the datafile password. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test60_VerifyThatUserIsAbleToOptOutForTheDatafilePasword
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to Opt out for the datafile password
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to Opt out for the datafile password
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 12, 2014	
		[ ] //Author                          Mukesh 
		[ ] // Updated By Abhijit S, May 2015 as per Qw2015 R8 Changes		
	[ ] // ********************************************************
[+] testcase Test60_VerifyThatUserIsAbleToOptOutForTheDatafilePasword() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sOIPDatafilePassword
		[ ] INTEGER iPasswordValidation
		[ ] sVersion= "2013"
		[ ] sFileName = "OIPDataFile"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sSourceFile = AUT_DATAFILE_PATH + "\OIPDataFile\" + sFileName + ".QDF"
		[ ] sOIPDatafilePassword ="quicken"
		[ ] sLocation=AUT_DATAFILE_PATH + "\" 
		[ ] // Read data from sRegistrationWorksheet 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sSmokeData, sRegistrationWorksheet)
		[ ] lsRegistrationData = lsExcelData[1]
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[+] if(QuickenWindow.Exists(SHORT_SLEEP))
			[ ] QuickenWindow.Kill()
			[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[+] if(!QuickenWindow.Exists(5))
		[ ] LaunchQuicken()
		[ ] 
		[ ] 
	[+] if(EnterQuickenPassword.Exists(5))
		[ ] EnterQuickenPassword.SetActive()
		[ ] EnterQuickenPassword.Close()
		[ ] WaitForState(EnterQuickenPassword , FALSE , 5)
		[+] if(ImportExportQuickenFile.Exists(5))
			[ ] ImportExportQuickenFile.SetActive()
			[ ] ImportExportQuickenFile.Close()
			[ ] WaitForState(ImportExportQuickenFile , FALSE , 5)
		[ ] 
		[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iConversionResult=DataFileConversion ( sFileName,  sVersion,  sOIPDatafilePassword , sLocation ,  FALSE)
		[+] if(iConversionResult == PASS)
			[ ] QuickenWindow.SetActive()
			[+] if (LowScreenResolution.Exists(10))
					[ ] LowScreenResolution.Dontshowthisagain.Check()
					[ ] LowScreenResolution.OK.Click()
					[ ] Sleep(3)
					[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window was closed")
			[+] else
					[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window did not appear")
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Restore()
			[ ] sleep(2)
			[ ] QuickenWindow.Maximize()
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] iResult=NavigateToRegistrationOIPStep(lsRegistrationData)
			[+] if(iResult == PASS)
				[ ] QuickenWindow.SetActive()
				[ ] // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseExistingDataFilePasswordOption.Check()
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Done.Click()
				[+] // if(DlgConsolidatePassword.Exists(20))
					[ ] // DlgConsolidatePassword.SetActive()
					[ ] // DlgConsolidatePassword.CancelButton.Click()
					[ ] // WaitForState(DlgConsolidatePassword, FALSE ,10)
					[ ] 
					[ ] LaunchQuicken()
					[+] if(EnterQuickenPassword.Exists(MEDIUM_SLEEP))
						[ ] iPasswordValidation =   EnterQuickenPassword( sOIPDatafilePassword)
						[+] if(iPasswordValidation == FAIL)
							[ ] ReportStatus("Verify that user is able to Opt out for the datafile password", FAIL , "The data file didn't open with existing datafile password as password didn't match.") 
							[ ] 
							[ ] 
						[+] else
							[+] if(QuickenWindow.Exists(5))
								[ ] QuickenWindow.SetActive()
								[ ] ReportStatus("Verify that user is able to Opt out for the datafile password", PASS , "The data file opened with existing datafile password.") 
							[+] else
								[ ] ReportStatus("Verify that user is able to Opt out for the datafile password", FAIL , "The data file didn't open with existing datafile password.") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Enter Quicken Password dialog", FAIL,"Enter Quicken Password dialog didn't appear.")
					[ ] 
				[+] // else
					[ ] // ReportStatus("Verify consolidate password dialog", FAIL,"Consolidate password dialog didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify File registration", FAIL," File registration failed")
		[+] else
			[ ] ReportStatus("Verify File Convertion", FAIL,"  File conversion failed")
			[ ] QuickenWindow.Exit()								
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] // 
[+] //##########Verify that user is able to Opt in Intuit Password as datafile password. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test61_VerifyThatUserIsAbleToOptInIntuitPasswordAsTheDatafilePasword
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to Opt in Intuit Password as datafile password
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to Opt in Intuit Password as datafile password
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 12, 2014	
		[ ] //Author                          Mukesh 
		[ ] // Updated By Abhijit S, May 2015 as per Qw2015 R8 Changes	
	[ ] // ********************************************************
[+] testcase Test61_VerifyThatUserIsAbleToOptInIntuitPasswordAsTheDatafilePasword() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sOIPDatafilePassword ,sIntuitIDPassword
		[ ] INTEGER iPasswordValidation
		[ ] sVersion= "2013"
		[ ] sFileName = "OIPDataFile"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sSourceFile = AUT_DATAFILE_PATH + "\OIPDataFile\" + sFileName + ".QDF"
		[ ] sOIPDatafilePassword ="quicken"
		[ ] sIntuitIDPassword =sPassword
		[ ] sLocation=AUT_DATAFILE_PATH + "\" 
		[ ] // Read data from sRegistrationWorksheet 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sSmokeData, sRegistrationWorksheet)
		[ ] lsRegistrationData = lsExcelData[1]
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[+] if(QuickenWindow.Exists(SHORT_SLEEP))
			[ ] QuickenWindow.Kill()
			[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[+] if(!QuickenWindow.Exists(5))
		[ ] LaunchQuicken()
		[ ] 
		[ ] 
	[+] if(EnterQuickenPassword.Exists(10))
		[ ] EnterQuickenPassword.SetActive()
		[ ] EnterQuickenPassword.Close()
		[ ] WaitForState(EnterQuickenPassword , FALSE , 5)
		[+] if(ImportExportQuickenFile.Exists(5))
			[ ] ImportExportQuickenFile.SetActive()
			[ ] ImportExportQuickenFile.Close()
			[ ] WaitForState(ImportExportQuickenFile , FALSE , 5)
		[ ] 
		[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iConversionResult=DataFileConversion ( sFileName,  sVersion,  sOIPDatafilePassword , sLocation ,  FALSE)
		[+] if(iConversionResult == PASS)
			[ ] QuickenWindow.SetActive()
			[ ] iResult=NavigateToRegistrationOIPStep(lsRegistrationData)
			[+] if(iResult == PASS)
				[ ] QuickenWindow.SetActive()
				[ ] //QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseIntuitIDDataFilePasswordOption.Check()
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Done.Click()
				[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
				[+] if (ManageDataFilePassword.Exists(2))
					[ ] ManageDataFilePassword.SetActive()
					[ ] ManageDataFilePassword.UseMyIntuitIDPassword.Select(1)
					[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
					[ ] ManageDataFilePassword.ExistingPassword.SetText(sOIPDatafilePassword)
					[ ] 
					[ ] ManageDataFilePassword.IntuitIDPassword.SetFocus()
					[ ] ManageDataFilePassword.IntuitIDPassword.SetText(sIntuitIDPassword)
					[ ] ManageDataFilePassword.OK.Click()
				[ ] 
				[+] // if(DlgConsolidatePassword.Exists(20))
					[ ] // DlgConsolidatePassword.SetActive()
					[ ] // DlgConsolidatePassword.Close()
					[ ] // sleep(2)
					[ ] // WaitForState(DlgConsolidatePassword, FALSE ,10)
					[ ] CloseQuicken()
					[ ] LaunchQuicken()
					[+] if(EnterQuickenPassword.Exists(MEDIUM_SLEEP)) 
						[ ] iPasswordValidation =  EnterQuickenPassword (sIntuitIDPassword) 
						[+] if(iPasswordValidation == FAIL)
							[ ] ReportStatus("Verify that user is able to Opt in Intuit Password as datafile password", FAIL , "The data file didn't open with IntuitId password as password didn't match.") 
							[ ] 
							[ ] 
						[+] else
							[+] if(QuickenWindow.Exists(5))
								[ ] QuickenWindow.SetActive()
								[ ] ReportStatus("Verify that user is able to Opt in Intuit Password as datafile password", PASS , "The data file opened with Intuit Password as datafile password.") 
							[+] else
								[ ] ReportStatus("Verify that user is able to Opt in Intuit Password as datafile password", FAIL , "The data file didn't open with Intuit Password as datafile password.") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Enter Quicken Password dialog", FAIL,"Enter Quicken Password dialog didn't appear.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify consolidate password", FAIL,"Consolidate password dialog didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify File registration", FAIL,"  File registration failed")
		[+] else
			[ ] ReportStatus("Verify File Convertion", FAIL,"  File conversion failed")
			[ ] QuickenWindow.Exit()								
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] // 
[+] //########## Verify that user is able to setup Custom password for password vault with Custom datafile password. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test62_VerifyThatUserIsAbleToSetupCustomPasswordVaultWithCustomDatafilePasword
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to setup Custom password vault with Custom datafile password.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to setup Custom password vault with Custom datafile password.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 15, 2014	
		[ ] //Author                          Mukesh 	
		[ ] // Updated By Abhijit S, May 2015 as per Qw2015 R8 Changes
	[ ] // ********************************************************
[+] testcase Test62_VerifyThatUserIsAbleToSetupCustomPasswordVaultWithCustomDatafilePasword() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sOIPDatafilePassword, sVaultPassword
		[ ] INTEGER iPasswordValidation
		[ ] sVersion= "2013"
		[ ] sFileName = "OIPDataFile"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sSourceFile = AUT_DATAFILE_PATH + "\OIPDataFile\" + sFileName + ".QDF"
		[ ] sOIPDatafilePassword ="quicken"
		[ ] sVaultPassword = "intuit"
		[ ] 
		[ ] sLocation=AUT_DATAFILE_PATH + "\" 
		[ ] // Read data from sRegistrationWorksheet 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sSmokeData, sRegistrationWorksheet)
		[ ] lsRegistrationData = lsExcelData[1]
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[+] if(QuickenWindow.Exists(SHORT_SLEEP))
			[ ] QuickenWindow.Kill()
			[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[+] if(!QuickenWindow.Exists(5))
		[ ] LaunchQuicken()
		[ ] 
		[ ] 
	[+] if(EnterQuickenPassword.Exists(5))
		[ ] EnterQuickenPassword.SetActive()
		[ ] EnterQuickenPassword.Close()
		[ ] WaitForState(EnterQuickenPassword , FALSE , 5)
		[+] if(ImportExportQuickenFile.Exists(5))
			[ ] ImportExportQuickenFile.SetActive()
			[ ] ImportExportQuickenFile.Close()
			[ ] WaitForState(ImportExportQuickenFile , FALSE , 5)
		[ ] 
		[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iConversionResult=DataFileConversion ( sFileName,  sVersion,  sOIPDatafilePassword , sLocation ,  FALSE)
		[+] if(iConversionResult == PASS)
			[ ] QuickenWindow.SetActive()
			[ ] //navigate to till OIP step during registration
			[ ] iResult=NavigateToRegistrationOIPStep(lsRegistrationData)
			[+] if(iResult == PASS)
				[ ] QuickenWindow.SetActive()
				[ ] //QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseExistingDataFilePasswordOption.Check()
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Done.Click()
				[+] // if(DlgConsolidatePassword.Exists(20))
					[ ] // DlgConsolidatePassword.SetActive()
					[ ] // //Select use existing password for password vault  option
					[ ] // DlgConsolidatePassword.PasswordVaultOptions.Select(2)
					[ ] // DlgConsolidatePassword.OKButton.Click()
					[ ] // WaitForState(DlgConsolidatePassword, FALSE ,10)
					[ ] 
					[ ] LaunchQuicken()
					[+] if(EnterQuickenPassword.Exists(MEDIUM_SLEEP))
						[ ] iPasswordValidation = EnterQuickenPassword (sOIPDatafilePassword) 
						[+] if(iPasswordValidation == PASS)
							[ ] 
							[ ] 
							[ ] //Verify vault password
							[ ] iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
							[ ] 
							[+] if(iNavigate == PASS)
								[ ] 
								[+] if (EnterIntuitPassword.Exists(20))
									[ ] EnterIntuitPassword.SetActive()
									[ ] EnterIntuitPassword.Password.SetText(sVaultPassword)
									[ ] EnterIntuitPassword.UpdateNowButton.Click()
									[+] if(OneStepUpdateSummary.Exists(200))
										[ ] OneStepUpdateSummary.SetActive()
										[ ] OneStepUpdateSummary.Close.Click ()
										[ ] ReportStatus("Verify OSU after configuring vault password as custom password.",PASS, " OSU was successful after configuring vault password as custom password")
									[+] else
										[ ] ReportStatus("Verify OSU after configuring vault password as custom password.",FAIL, " OSU after after configuring vault password as custom password didn't succeed")
										[ ] EnterIntuitPassword.SetActive()
										[ ] EnterIntuitPassword.CancelButton.Click()
										[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Password vault dialog",FAIL, " Password vault dialog didn't appear.")
									[ ] 
							[+] else
								[ ] ReportStatus("Verify One Step Update",FAIL, "One Step Update didn't initiate")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that user is able to Opt out for the datafile password", FAIL , "The data file didn't open with existing datafile password as password didn't match.") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Enter Quicken Password dialog", FAIL,"Enter Quicken Password dialog didn't appear.")
					[ ] 
				[+] // else
					[ ] // ReportStatus("Verify consolidate password", FAIL,"Consolidate password dialog didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify File registration", FAIL,"  File registration failed")
		[+] else
			[ ] ReportStatus("Verify File Convertion", FAIL,"  File conversion failed")
			[ ] QuickenWindow.Exit()								
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] // 
[+] //########## Verify that user is able to setup password vault using intuit password with Custom datafile password. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test63_VerifyThatUserIsAbleToUseIntuitPasswordAsPasswordForPasswordVaultWithCustomDatafilePasword
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to setup password vault using intuit password with Custom datafile password
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to setup password vault using intuit password with Custom datafile password
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 15, 2014	
		[ ] //Author                          Mukesh 
		[ ] // Updated By Abhijit S, May 2015 as per Qw2015 R8 Changes	
	[ ] // ********************************************************
[+] testcase Test63_VerifyThatUserIsAbleToUseIntuitPasswordAsPasswordForPasswordVaultWithCustomDatafilePasword() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sOIPDatafilePassword, sIntuitIDPassword ,sVaultPassword
		[ ] INTEGER iPasswordValidation
		[ ] sVersion= "2013"
		[ ] sFileName = "OIPDataFile"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sSourceFile = AUT_DATAFILE_PATH + "\OIPDataFile\" + sFileName + ".QDF"
		[ ] sOIPDatafilePassword ="quicken"
		[ ] sVaultPassword = "intuit"
		[ ] sIntuitIDPassword = sPassword
		[ ] 
		[ ] sLocation=AUT_DATAFILE_PATH + "\" 
		[ ] // Read data from sRegistrationWorksheet 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sSmokeData, sRegistrationWorksheet)
		[ ] lsRegistrationData = lsExcelData[1]
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[+] if(QuickenWindow.Exists(SHORT_SLEEP))
			[ ] QuickenWindow.Kill()
			[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[+] if(!QuickenWindow.Exists(5))
		[ ] LaunchQuicken()
		[ ] 
		[ ] 
	[+] if(EnterQuickenPassword.Exists(5))
		[ ] EnterQuickenPassword.SetActive()
		[ ] EnterQuickenPassword.Close()
		[ ] WaitForState(EnterQuickenPassword , FALSE , 5)
		[+] if(ImportExportQuickenFile.Exists(5))
			[ ] ImportExportQuickenFile.SetActive()
			[ ] ImportExportQuickenFile.Close()
			[ ] WaitForState(ImportExportQuickenFile , FALSE , 5)
		[ ] 
		[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iConversionResult=DataFileConversion ( sFileName,  sVersion,  sOIPDatafilePassword , sLocation ,  FALSE)
		[+] if(iConversionResult == PASS)
			[ ] QuickenWindow.SetActive()
			[ ] //navigate to till OIP step during registration
			[ ] iResult=NavigateToRegistrationOIPStep(lsRegistrationData)
			[+] if(iResult == PASS)
				[ ] QuickenWindow.SetActive()
				[ ] //QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseExistingDataFilePasswordOption.Check()
				[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Done.Click()
				[+] // if(DlgConsolidatePassword.Exists(20))
					[ ] // DlgConsolidatePassword.SetActive()
					[ ] // //Select use IntuitIdID password for password vault  option
					[ ] // DlgConsolidatePassword.PasswordVaultOptions.Select(1)
					[ ] // DlgConsolidatePassword.Password.SetText(sVaultPassword)
					[ ] // DlgConsolidatePassword.OKButton.Click()
					[ ] // WaitForState(DlgConsolidatePassword, FALSE ,10)
					[ ] QuickenWindow.MainMenu.Select("/_Tools/Password _Vault/Reset Vault")
					[ ] ResetVault.Password.SetFocus()
					[ ] ResetVault.Cancel.Password.SetText(sIntuitIDPassword)
					[ ] ResetVault.ConfirmPassword.SetFocus()
					[ ] ResetVault.ConfirmPassword.SetText(sIntuitIDPassword)
					[ ] ResetVault.OK.Click()
					[ ] CloseQuicken()
					[ ] LaunchQuicken()
					[+] if(EnterQuickenPassword.Exists(MEDIUM_SLEEP))
						[ ] iPasswordValidation =  EnterQuickenPassword (sOIPDatafilePassword) 
						[+] if(iPasswordValidation == PASS)
							[ ] 
							[ ] 
							[ ] //Verify vault password
							[ ] QuickenWindow.MainMenu.Select("/_Tools/Password _Vault/Add or _Edit Passwords...")
							[ ] 
							[+] // if(iNavigate == PASS)
								[ ] 
								[+] // if (EnterIntuitPassword.Exists(20))
									[ ] // EnterIntuitPassword.SetActive()
									[ ] // EnterIntuitPassword.Password.SetText(sIntuitIDPassword)
									[ ] // EnterIntuitPassword.UpdateNowButton.Click()
								[+] if(UnlockYourPasswordVault.Exists(2))
									[ ] UnlockYourPasswordVault.Password.SetFocus()
									[ ] UnlockYourPasswordVault.Password.SetText(sIntuitIDPassword)
									[+] UnlockYourPasswordVault.OK.Click()
											[+] if(EditPasswordVault.Exists(2))
												[ ] ReportStatus("Validate Vault Password ", PASS, "For Data file -  {sFileName} Intuit vault password works fine")
											[+] else
												[ ] ReportStatus("Validate Vault Password ", FAIL, "For Data file -  {sFileName} Intuit vault password is not working")
										[ ] EditPasswordVault.Cancel.Click()
									[ ] 
									[+] // if(OneStepUpdateSummary.Exists(200))
										[ ] // OneStepUpdateSummary.SetActive()
										[ ] // OneStepUpdateSummary.Close.Click ()
										[ ] // ReportStatus("Verify OSU after configuring intuitid password as vault password.",PASS, " OSU was successful after configuring IntuitID password as vault password.")
									[+] // else
										[ ] // ReportStatus("Verify OSU after configuring  intuitid password as vault password.",FAIL, " OSU after after configuring vault password IntuitID password as vault password.")
										[ ] // EnterIntuitPassword.SetActive()
										[ ] // EnterIntuitPassword.CancelButton.Click()
										[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Password vault dialog",FAIL, " Password vault dialog didn't appear.")
									[ ] 
							[+] // else
								[ ] // ReportStatus("Verify One Step Update",FAIL, "One Step Update didn't initiate")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that user is able to Opt out for the datafile password", FAIL , "The data file didn't open with existing datafile password as password didn't match.") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Enter Quicken Password dialog", FAIL,"Enter Quicken Password dialog didn't appear.")
					[ ] 
				[+] // else
					[ ] // ReportStatus("Verify consolidate password", FAIL,"Consolidate password dialog didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify File registration", FAIL,"  File registration failed")
		[+] else
			[ ] ReportStatus("Verify File Convertion", FAIL,"  File conversion failed")
			[ ] QuickenWindow.Exit()								
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] // 
[ ] // 
[+] //########## Verify Start Up >Downlaod Transaction when QN start preference option. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test64_VerifyStartupDownloadTransactionWhenQNStartPreference
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 'Start Up >Downlaod Transaction when QN start preference' option
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If 'Start Up >Downlaod Transaction when QN start preference' option works as expected 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 16, 2014	
		[ ] //Author                          Mukesh 	
	[ ] // ********************************************************
[+] testcase Test64_VerifyStartupDownloadTransactionWhenQNStartPreference() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sOIPDatafilePassword
		[ ] INTEGER iPasswordValidation
		[ ] sOIPDatafilePassword ="quicken"
		[ ] STRING sVaultPassword = 'intuit'
		[ ] sVersion= "2013"
		[ ] sFileName = "OIPDataFile"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sSourceFile = AUT_DATAFILE_PATH + "\OIPDataFile\" + sFileName + ".QDF"
		[ ] sLocation=AUT_DATAFILE_PATH + "\" 
		[ ] // Read data from sRegistrationWorksheet 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sSmokeData, sRegistrationWorksheet)
		[ ] lsRegistrationData = lsExcelData[1]
		[ ] 
		[ ] 
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[+] if(QuickenWindow.Exists(SHORT_SLEEP))
			[ ] QuickenWindow.Kill()
			[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[+] if(!QuickenWindow.Exists(5))
		[ ] LaunchQuicken()
		[ ] 
		[ ] 
	[+] if(EnterQuickenPassword.Exists(5))
		[ ] EnterQuickenPassword.SetActive()
		[ ] EnterQuickenPassword.Close()
		[ ] WaitForState(EnterQuickenPassword , FALSE , 5)
		[+] if(ImportExportQuickenFile.Exists(5))
			[ ] ImportExportQuickenFile.SetActive()
			[ ] ImportExportQuickenFile.Close()
			[ ] WaitForState(ImportExportQuickenFile , FALSE , 5)
		[ ] 
		[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iConversionResult=DataFileConversion ( sFileName,  sVersion,  sOIPDatafilePassword , sLocation ,  FALSE)
		[+] if(iConversionResult == PASS)
			[ ] QuickenWindow.SetActive()
			[ ] //navigate to till OIP step during registration
			[ ] iResult=NavigateToRegistrationOIPStep(lsRegistrationData)
			[+] if(iResult == PASS)
				[ ] QuickenWindow.SetActive()
				[ ] //QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseExistingDataFilePasswordOption.Check()
				[+] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Done.Click()
					[ ] 
					[ ] 
					[+] if (QuickenWindow.Exists(5))
						[ ] QuickenWindow.SetActive()
						[ ] //Select preferences dialog
						[ ] QuickenWindow.Edit.Click()
						[ ] QuickenWindow.Edit.Preferences.Select()
						[ ] 
						[ ] 
						[+] if (Preferences.Exists(5))
							[ ] Preferences.SetActive()
							[ ] //Verify Startup option is by default selected.
							[+] if (Preferences.StartupPreferencesText.Exists())
								[ ] ReportStatus("Verfiy Startup option is displayed by deafult on Preferences dialog." , PASS ,"Startup option is displayed by deafult on Preferences dialog.")
								[ ] Preferences.DownloadTransactionsWhenQuickenStarts.Check()
								[ ] Preferences.OK.Click()
								[ ] WaitForState(Preferences , FALSE ,5)
								[ ] //Restart quicken
								[ ] CloseQuicken()
								[ ] LaunchQuicken()
								[+] if(EnterQuickenPassword.Exists(MEDIUM_SLEEP))
									[ ] iPasswordValidation = EnterQuickenPassword( sOIPDatafilePassword)
									[+] if(iPasswordValidation == PASS)
											[ ] //QuickenWindow.MainMenu.Select("/_Tools/Password _Vault/Add or _Edit Passwords...")
											[ ] 
											[+] // if(iNavigate == PASS)
												[ ] 
												[+] // if (EnterIntuitPassword.Exists(20))
													[ ] // EnterIntuitPassword.SetActive()
													[ ] // EnterIntuitPassword.Password.SetText(sIntuitIDPassword)
													[ ] // EnterIntuitPassword.UpdateNowButton.Click()
												[+] if(UnlockYourPasswordVault.Exists(2))
													[ ] UnlockYourPasswordVault.Password.SetFocus()
													[ ] UnlockYourPasswordVault.Password.SetText(sVaultPassword)
													[+] UnlockYourPasswordVault.OK.Click()
														[ ] 
												[+] else
													[ ] ReportStatus("Validate Vault Password ", FAIL, "For Data file -  {sFileName} vault password is not working")
													[+] // if(OneStepUpdateSummary.Exists(200))
														[ ] // OneStepUpdateSummary.SetActive()
														[ ] // OneStepUpdateSummary.Close.Click ()
														[ ] // ReportStatus("Verify OSU after configuring intuitid password as vault password.",PASS, " OSU was successful after configuring IntuitID password as vault password.")
													[+] // else
														[ ] // ReportStatus("Verify OSU after configuring  intuitid password as vault password.",FAIL, " OSU after after configuring vault password IntuitID password as vault password.")
														[ ] // EnterIntuitPassword.SetActive()
														[ ] // EnterIntuitPassword.CancelButton.Click()
														[ ] 
													[ ] 
										[ ] //Verify download starts after launching the quicken
										[+] // if (EnterIntuitPassword.Exists(20))
											[ ] // EnterIntuitPassword.SetActive()
											[ ] // EnterIntuitPassword.Password.SetText(sPassword)
											[ ] // EnterIntuitPassword.UpdateNowButton.Click()
											[ ] OneStepUpdate.UpdateNow.Click()
											[+] if(OneStepUpdateSummary.Exists(200))
												[ ] OneStepUpdateSummary.SetActive()
												[ ] OneStepUpdateSummary.Close.Click ()
												[ ] ReportStatus("Verify download starts after launching the quicken.",PASS, "Download was successful after selecting option 'Start Up >Downlaod Transaction when QN start preference option' and restarting the quicken.")
											[+] else
												[ ] ReportStatus("Verify download starts after launching the quicken.",FAIL, "Download didn't succeed after selecting option 'Start Up >Downlaod Transaction when QN start preference option' and restarting the quicken.")
												[ ] EnterIntuitPassword.SetActive()
												[ ] EnterIntuitPassword.CancelButton.Click()
												[ ] 
											[ ] 
											[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify that user is able to open the datafile with datafile password", FAIL , "The data file didn't open with existing datafile password as passwords didn't match.") 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Enter Quicken Password dialog", FAIL,"Enter Quicken Password dialog didn't appear.")
								[ ] 
							[+] else
								[ ] ReportStatus("Verfiy Startup option is displayed by deafult on Preferences dialog." , FAIL ,"Startup option is NOT displayed by deafult on Preferences dialog.")
						[+] else
							[ ] ReportStatus("Verify Preference dialog.", FAIL, "Preference dialog didn't appear or Navigation option not found.")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
						[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] // 
[+] //########## Verify Find & Replace feature. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test65_VerifyFindAndReplace
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the find and replace feature
		[ ] // RETURNS:			Pass 		If find and replace feature works as expected 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 16, 2014	
		[ ] //Author                          Mukesh 	
	[ ] // ********************************************************
[+] testcase Test65_VerifyFindAndReplace() appstate none
	[ ] 
	[ ] STRING sCategoryBeforeReplace ,sCategoryAfterReplace
	[ ] 
	[ ] // Fetch 1st row from the given sheet
	[ ] sAccountName ="My Checking XX1111"
	[ ] sCategoryBeforeReplace ="Other Inc"
	[ ] sCategoryAfterReplace="Auto & Transport:Public Transportation"
	[ ] 
	[+] if (!QuickenWindow.Exists(5) )
		[ ] LaunchQuicken()
	[ ] // Quicken is launched then add Payment transaction to Checking account
	[ ] iResult=OpenDataFile(sFileName)
	[+] if(iResult==PASS)
		[+] if (QuickenWindow.Exists(5) )
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // This will click first  account on AccountBar
			[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, 1)
			[+] if(iSelect==PASS)
				[ ] 
				[ ] ReportStatus("Select Account", PASS, "Checking Account {sAccountName} is selected") 
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] sleep(2)
				[+] if (MDIClient.AccountRegister.AcceptAll.IsEnabled())
					[ ] MDIClient.AccountRegister.AcceptAll.Click()
					[ ] Sleep(5)
				[ ] QuickenWindow.SetActive()
				[+] do
					[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
				[+] except
					[+] do
						[ ] QuickenWindow.MainMenu.Select("/_Edit/Find?Rep_lace...")
					[+] except
						[ ] QuickenWindow.Edit.Click()
						[ ] QuickenWindow.Edit.FindReplace.Select()
				[ ] 
				[+] if (!DlgFindAndReplace.Exists(3))
					[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_H)
				[ ] 
				[+] if (DlgFindAndReplace.Exists(10))
					[ ] DlgFindAndReplace.SetActive()
					[ ] 
					[ ] DlgFindAndReplace.SearchTextField.SetText(sCategoryBeforeReplace)
					[ ] DlgFindAndReplace.FindButton.Click()
					[ ] sleep(3)
					[ ] DlgFindAndReplace.SelectAllButton.Click()
					[ ] DlgFindAndReplace.ReplacePopupList.Select("Category")
					[ ] DlgFindAndReplace.ReplacementTextField.SetText(sCategoryAfterReplace)
					[ ] DlgFindAndReplace.ReplaceAllButton.Click()
					[ ] sleep(10)
					[ ] DlgFindAndReplace.DoneButton.Click()
					[ ] WaitForState(DlgFindAndReplace , FALSE ,5)
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.TypeKeys(KEY_CTRL_H)
					[+] if (DlgFindAndReplace.Exists(10))
						[ ] DlgFindAndReplace.SetActive()
						[ ] DlgFindAndReplace.SearchTextField.SetText(sCategoryBeforeReplace)
						[ ] DlgFindAndReplace.FindButton.Click()
						[+] if (AlertMessage.Exists(5))
							[ ] ReportStatus("Verify transactions has been replaced using Find & Replace dialog.", PASS, "Transactions with category: {sCategoryBeforeReplace} has been replaced with category: {sCategoryAfterReplace} using Find & Replace dialog.")
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.OK.Click()
						[+] else
							[ ] ReportStatus("Verify transactions has been replaced using Find & Replace dialog.", FAIL, "Transactions with category: {sCategoryBeforeReplace} couldn't be replaced with category: {sCategoryAfterReplace} using Find & Replace dialog.")
						[ ] DlgFindAndReplace.DoneButton.Click()
						[ ] WaitForState(DlgFindAndReplace , FALSE ,5)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Find and Replace dialog", FAIL, " Find and Replace dialog didn't appear.") 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Find and Replace dialog", FAIL, " Find and Replace dialog didn't appear.") 
					[ ] 
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Select Account", FAIL, "Account {sAccountName} is couldn't be selected") 
			[ ] 
		[+] else
			[ ] ReportStatus("Add New Transaction", FAIL, "Quicken is not available") 
	[+] else
		[ ] ReportStatus("Verify Open datafile ",FAIL,"Datafile: {sFileName} couldn't be opened")
[ ] 
[+] //##########  Verify that user is able to add manual loan account  ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test66_VerifyThatUserIsAbleToAddManualLoanAccount
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to add manual loan account 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to add manual loan account with 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Sept 17, 2014	
		[ ] //Author                          Mukesh 	
		[ ] //
	[ ] // ********************************************************
[+] testcase Test66_VerifyThatUserIsAbleToAddManualLoanAccount() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sPaymentTextCaption ,sPaymentSchedule ,sExpectedPaymentScheduleText ,sDate
		[ ] LIST OF ANYTYPE lsAddLoanAccount
		[ ] INTEGER iVerify
		[ ] 
		[ ] sDate=ModifyDate(0,"m/d/yyyy")
		[ ] sPaymentSchedule="Annually"
		[ ] sExpectedPaymentScheduleText="ANNUAL PAYMENT"
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sSmokeData,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[1]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] // debug statement
	[+] //if (QuickenWindow.Exists())
		[ ] //QuickenWindow.CaptureBitmap("c:\automation\Test66_1.bmp")
	[ ] 
	[ ] iResult=OpenDataFile(sFileName)
	[ ] 
	[+] if(iResult==PASS)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Add Loan account
		[ ] iVerify=AddEditManualLoanAccount("Add",lsAddLoanAccount[1],lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],sPaymentSchedule)
		[+] if(iVerify==PASS)
			[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] iVerify=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
			[+] if(iVerify==PASS)
				[ ] 
				[ ] // Verification points for payment schedule on Loan dashboard
				[ ] 
				[ ] //Payment Text on Dashboard
				[ ] sPaymentTextCaption=MDIClientLoans.LoanWindow.PaymentText.GetCaption()
				[+] if(sPaymentTextCaption==sExpectedPaymentScheduleText)
					[ ] ReportStatus("Verify Payment text",PASS,"Payment text on Dashboard displays correct value {sPaymentTextCaption} ")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Payment text",FAIL,"Payment text on Dashboard displays wrong value {sPaymentTextCaption} ")
				[ ] 
				[ ] //Edit Terms
				[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
				[+] if(LoanDetails.Exists(5))
					[ ] 
					[ ] sPaymentTextCaption=LoanDetails.PaymentScheduleComboBox.GetText()
					[ ] 
					[+] if(sPaymentSchedule==sPaymentTextCaption)
						[ ] ReportStatus("Verify Payment text",PASS,"Payment text displays correct value in Loan details dialog invoked from Edit terms button : {sPaymentTextCaption} ")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Payment text",FAIL,"Payment text displays wrong value in Loan details dialog invoked from Edit terms button {sPaymentTextCaption} ")
					[ ] 
					[ ] LoanDetails.Close()
					[ ] WaitForState(LoanDetails,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify loan details window launched",FAIL,"Loan details window not displayed")
					[ ] 
				[ ] 
				[ ] 
				[ ] //Delete Loan Account
				[ ] iVerify=ModifyAccount(sMDIWindow,lsAddLoanAccount[1],"Delete")
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Add Manual loan account",FAIL,"Manual loan account not added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Open datafile ",FAIL,"Datafile: {sFileName} couldn't be opened")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //############## Verify Data File  ##############################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test67_VerifyDataFile()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will perform Verify data file operation using “Validate and Repair” menu item under File menu 
		[ ] //  And verifies that “DATA_LOG.txt”  file is created in log folder
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if file operation “Validate and Repair” successful 			
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 06/01/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test67_VerifyDataFile () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN bNotepad
		[ ] STRING sDataLogPath,sExpectedOutputFile,sActualOutputFile,sNoError
		[ ] HFILE hFile
		[ ] STRING sLine
		[ ] 
	[+] // Expected Values
		[ ] sExpectedOutputFile = "DATA_LOG"
		[ ] sDataLogPath = USERPROFILE + "\Application Data\Intuit\Quicken\Log\DATA_LOG.TXT"
		[ ] sNoError="No errors."
	[ ] 
	[ ] // Quicken is launched then Verify data log
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] // Navigate to File > File Operations > Validate and Repair
		[ ] QuickenWindow.File.Click()
		[ ] QuickenWindow.File.FileOperations.Click()
		[ ] QuickenWindow.File.FileOperations.ValidateAndRepair.Click()
		[ ] //QuickenWindow.File.FileOperations.VerifyAndRepair.Select()
		[ ] 
		[ ] 
		[ ] // Verify that "Validate and Repair your Quicken file" window exists
		[+] if(ValidateAndRepair.Exists(5))
			[ ] 
			[ ] ValidateAndRepair.SetActive()
			[ ] //if(!VerifyAndRepair.VerifyFile.IsChecked())
			[ ] //VerifyAndRepair.SetActive()
			[ ] ValidateAndRepair.ValidateFile.Check()
			[ ] //if(!VerifyAndRepair.RebuildInvestingLots.IsChecked())
			[ ] ValidateAndRepair.RebuildInvestingLots.Check()
			[ ] //VerifyAndRepair.SetActive()
			[ ] ValidateAndRepair.OK.Click()
			[ ] 
			[ ] 
			[ ] sleep(25)
			[ ] Notepad.VerifyEnabled(TRUE, 20)
			[ ] 
			[ ] // Verify that output file (data log text file) is opened
			[+] if(Notepad.Exists(SHORT_SLEEP))
				[ ] 
				[ ] Notepad.SetActive()
				[ ] // Verify window title for output file
				[ ] sActualOutputFile=Notepad.GetCaption()
				[ ] bMatch = MatchStr("*{sExpectedOutputFile}*",sActualOutputFile)
				[+] if (bMatch == TRUE)
					[ ] ReportStatus("Verify Output File", PASS, "Output file {sExpectedOutputFile} is created")
				[+] else
					[ ] ReportStatus("Verify Output File", FAIL, "Output file {sExpectedOutputFile} is not matching with {sActualOutputFile}")
				[ ] // Close Notepad
				[ ] Notepad.SetActive()
				[ ] Notepad.Exit()
				[ ] 
				[ ] // Read File
				[ ] hFile = FileOpen (sDataLogPath, FM_READ) 
				[+] while (FileReadLine (hFile, sLine))
					[ ] bMatch = MatchStr("*{sNoError}*", sLine)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Verify Data log", PASS, "{sNoError} message is displayed in {sExpectedOutputFile} file")
						[ ] break
					[+] else
						[ ] continue
					[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify Data log", FAIL, "{sNoError} message is not displayed in {sExpectedOutputFile} file")
					[ ] 
				[ ] FileClose (hFile)
				[ ] 
				[ ] 
				[ ] // Verify the path of output file i.e. Notepad
				[ ] bNotepad= SYS_FileExists(sDataLogPath)
				[ ] bExist =  AssertTrue(bNotepad)
				[+] if (bExist == TRUE)
					[ ] ReportStatus("Verify Output File", PASS, "Output file {sExpectedOutputFile} is found at {sDataLogPath}") 
				[+] else
					[ ] ReportStatus("Verify Output File", FAIL, "Output file {sExpectedOutputFile} is not found at {sDataLogPath}") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Data Log Notepad", FAIL, "Notepad is not opened") 
		[+] else
			[ ] ReportStatus("Verify VerifyAndRepair Window", FAIL, "VerifyAndRepair window is not found") 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Confirm account changes on Account List  ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test68_VerifyAccountChanges()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will edit/delete account and Verify changes are reflected in Account List
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while edit/delete and verification 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 11, 2011		Mamta Jain created	
	[ ] // ********************************************************
[+] testcase Test68_VerifyAccountChanges() appstate SmokeBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sWindowType, sExpected, sEditAccount
		[ ] INTEGER  iAction
	[+] // Variable Defination
		[ ] sEditAccount = "Checking 01 Edit Account"
	[ ] 
	[ ] // read excel table
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] print(lsExcelData)
	[ ] // fetch 1st row
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.View.Click()
		[+] if(QuickenWindow.View.UsePopUpRegisters.IsChecked == TRUE)
			[ ] sWindowType = sPopUpWindow
		[+] else
			[ ] sWindowType = sMDIWindow
		[ ] QuickenWindow.TypeKeys(KEY_ESC)
		[ ] QuickenWindow.SetActive ()
		[ ] // Edit Checking Account and verify in Account List
		[ ] //iSelect = AccountBarSelect(ACCOUNT_,1)		// Select first checking account
		[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if (iSelect == PASS)
			[ ] iAction = ModifyAccount(sWindowType, sEditAccount, "Edit")	// Edit account name
			[+] if(iAction == PASS)
				[ ] ReportStatus("Verify Account Action", iAction, "{lsAddAccount[2]} Account editted successfully")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Account Action", iAction, "{lsAddAccount[2]} Account is not editted")
				[ ] 
			[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
			[+] if(iNavigate == PASS)
				[ ] bExist = AccountList.Exists(5)
				[+] if(bExist== TRUE)
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
					[+] for(i = 1; i<=5; i++)			// check existence of account name
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
						[ ] bMatch = MatchStr("*{sEditAccount}*", sActual)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Verify Account Name", PASS, "{lsAddAccount[2]} account is editted to {sEditAccount}") 
							[ ] break
						[+] else
							[+] if(i == 5)
								[ ] ReportStatus("Verify Account Name", FAIL, "Expected Value - {sEditAccount}, Actual Value - {sActual}") 
								[ ] 
							[+] else
								[ ] continue
							[ ] 
					[ ] 
					[ ] //AccountList.Maximize()
					[ ] AccountList.Close ()
				[ ] 
				[+] else
					[ ] ReportStatus("Verify Account List Window", FAIL, "Account List Window is not available")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Selection", iNavigate, "Account List is not selected")
				[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Verify Account selection", iSelect, "First  Account is not selected from Account bar")
			[ ] 
		[ ] 
		[ ] // Delete Savings Account and verify in Account List
		[ ] 
		[ ] // fetch 3rd row
		[ ] lsAddAccount=lsExcelData[3]
		[ ] //iSelect = AccountBarSelect(ACCOUNT_, 3)			// Select Saving account
		[ ] iSelect=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if (iSelect == PASS)
			[ ] iAction = ModifyAccount(sWindowType, lsAddAccount[2], "Delete")		// Delete Smoke Savings account
			[+] if(iAction == PASS)
				[ ] ReportStatus("Verify Account Action", iAction, "{lsAddAccount[2]} Account deleted successfully")
				[ ] 
				[ ] 
				[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)		// Open Account List for verification
				[+] if(iNavigate == PASS)
					[ ] bExist = AccountList.Exists(5)
					[+] if(bExist== TRUE)
						[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())			// get handle of list box
						[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "8")
						[ ] bMatch = MatchStr("*{lsAddAccount[2]}*",  sActual)					// check that savings account is not present
						[+] if(bMatch == FALSE)
							[ ] ReportStatus("Verify Account Deletion", PASS, "Changes are reflected in Account List, {lsAddAccount[2]} account is not present") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Account Deletion", FAIL, "Expected Value - {lsAddAccount[2]}, Actual Value - {sActual}, {lsAddAccount[2]} account is not deleted") 
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Account List Window", FAIL, "Account List Window is not available")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Selection", iNavigate, "Account List is not selected")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Account Action", iAction, "{lsAddAccount[2]} Account is not deleted")
				[ ] 
			[ ] 
			[+] if (AccountList.Exists(10))
				[ ] AccountList.SetActive()
				[ ] AccountList.Close ()
		[ ] 
		[+] else
			[ ] ReportStatus("Verify Account selection", iSelect, "Account List is not selected")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[+] //############# Check shutdown ##################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test69_VerifyQuickenShutdown()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will close Quicken Main Window
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs closing							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 4, 2011		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test69_VerifyQuickenShutdown() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER iVerify
	[ ] // Cleanup
	[ ] // Close Quicken
	[+] if (QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] iVerify = CloseQuicken()
		[+] if (iVerify==PASS)
			[ ] ReportStatus("Verify Quicken Main Window", PASS, "Quicken Main Window Closed") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window didn't close.") 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window has been closed", FAIL, "Quicken Main Window couldn't be closed") 
	[ ] 
[ ] //##############################################################################
[+] //########## Add Edit and Delete Saving Goal  ##########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test26_AddEditDeleteSavingGoal()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add, Edit and Delete a saving goal
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  12 Jun, 2012  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test26_AddEditDeleteSavingGoal() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER iAddSavingGoal,iEditSavingGoal,iDeleteSavingGoal
		[ ] sDate=ModifyDate(0,"m/d/yyyy")
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sSavingGoals)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddSavingGoal=lsExcelData[1]
	[ ] ListDelete(lsAddSavingGoal,3)
	[ ] ListInsert(lsAddSavingGoal ,3, sDate)
	[ ] // Fetch 2nd row from the given sheet
	[ ] sDate=ModifyDate(10,"m/d/yyyy")
	[ ] lsEditSavingGoal=lsExcelData[2]
	[ ] ListDelete(lsEditSavingGoal,3)
	[ ] ListInsert(lsEditSavingGoal ,3, sDate)
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iAddSavingGoal=AddSavingGoal(lsAddSavingGoal[1],lsAddSavingGoal[2],lsAddSavingGoal[3])
		[ ] // Report Status if Saving Goal is created
		[ ] sleep(15)
		[+] if (iAddSavingGoal==PASS)
			[ ] ReportStatus("Edit Saving Goal", iAddSavingGoal, "Saving Goal -  {lsAddSavingGoal[1]}  is created successfully with amount {lsAddSavingGoal[2]} and finish date {lsAddSavingGoal[3]}")
		[+] else
			[ ] ReportStatus("Edit Saving Goal", iAddSavingGoal, "Saving Goal-  {lsAddSavingGoal[1]}  is not created")
		[ ] sleep(15)
		[ ] QuickenWindow.SetActive()
		[ ] iEditSavingGoal=EditSavingGoal(lsEditSavingGoal[1],lsEditSavingGoal[2],lsEditSavingGoal[3])
		[ ] // Report Status if saving goal is edited
		[+] if (iEditSavingGoal==PASS)
			[ ] ReportStatus("Edit Saving Goal", iEditSavingGoal, "Saving Goal -  {lsEditSavingGoal[1]}  is edited successfully with amount {lsEditSavingGoal[2]} and finish date {lsEditSavingGoal[3]}")
		[+] else
			[ ] ReportStatus("Edit Saving Goal", iEditSavingGoal, "Saving Goal-  {lsEditSavingGoal[1]}  is not edited")
		[ ] sleep(15)
		[ ] QuickenWindow.SetActive()
		[ ] iDeleteSavingGoal=DeleteSavingGoal(lsEditSavingGoal[1])
		[ ] sleep(15)
		[ ] // Report Status if saving goal is deleted
		[+] if (iDeleteSavingGoal==PASS)
			[ ] ReportStatus("Delete Saving Goal", iDeleteSavingGoal, "Saving Goal -  {lsEditSavingGoal[1]}  is deleted successfully")
		[+] else
			[ ] ReportStatus("Delete Saving Goal", iDeleteSavingGoal, "Saving Goal-  {lsEditSavingGoal[1]}  is not deleted")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //############# Create Online Account #############################################
	[ ] //********************************************************
	[+] // TestCase Name:	 Test50_CreateOnlineAccount()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will create Online account for Mission Federal Credit Union. This will create a new data file and add Checking and Saving account for MFCU 
		[ ] // Using Localfile Testing mechansim.
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		If no error occurs while creating online account for MFCU 							
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 28, 2010		Chandan Abhyankar	created
		[ ] // Oct  21, 2011       Udita Dube             updated (made it supported for Premier SKU))	
		[ ] // June 2015, Updated by Abhijit S 
	[ ] //*********************************************************
[+] testcase Test50_CreateOnlineAccount () appstate none
	[ ] 
	[ ] STRING sHandle, sActualOutput
	[ ] BOOLEAN bMatchStatus
	[ ] INTEGER iCreateDataFile, iLocalFileSetup, iIntuonlConfigure, iResponseStatus,iAddAccount
	[ ] STRING sOnlieAccountFileName = "Online"
	[ ] STRING sOnlieAccountFilePath = AUT_DATAFILE_PATH + "\" + sOnlieAccountFileName + ".QDF"
	[ ] STRING sOriginalFidir="C:\ProgramData\Intuit\Quicken\Inet\Common\Localweb\Banklist\2016\fidir.txt"
	[ ] STRING sNewFidir="{AUT_DATAFILE_PATH}\SmokeData\fidir.txt"
	[ ] STRING sKeepFidir="{AUT_DATAFILE_PATH}\SmokeData\FIDIR\fidir.txt"
	[ ] 
	[ ] 
	[ ] // Respose files for Local File Testing
	[ ] STRING sBrandingResponse = AUT_DATAFILE_PATH + "\Response_Files\1_brand_resp.dat"
	[ ] STRING sProfileResponse = AUT_DATAFILE_PATH + "\Response_Files\2_prof_resp.dat"
	[ ] STRING sAccountInfoResponse = AUT_DATAFILE_PATH + "\Response_Files\3_acct_info.dat"
	[ ] STRING sPaymentSyncResponse = AUT_DATAFILE_PATH + "\Response_Files\4_payment_sync.dat"
	[ ] STRING sStatementResponse = AUT_DATAFILE_PATH + "\Response_Files\5_stmt_resp.dat"
	[ ] 
	[+] // Cleanup
		[ ] // Close Quicken
		[+] if (QuickenWindow.Exists())
			[ ] 
			[ ] // 05/22/2015 KalyanG: Added the method to gracefully exit quicken
			[ ] CloseQuicken()
			[ ] // Delete qa_acc32.dll
			[ ] DeleteFile(sAccDllDestinationPath)
			[ ] 
			[ ] DeleteFile(sDestinationonliniFile)
			[ ] sleep(3)
			[ ] DeleteFile(sDestinationonliniFile)
			[ ] // Delete file intu_onl.ini located in WIndows directory
			[ ] DeleteFile(SYS_GetEnv("WINDIR") + "\\intu_onl.ini")
		[ ] 
	[ ] 
	[ ] 
	[ ] // Pre-Requisitez
	[ ] 
	[+] if(FileExists(sOriginalFidir) == TRUE)
		[ ] CopyFile(sOriginalFidir,sKeepFidir)
		[ ] DeleteFile(sOriginalFidir)
	[ ] CopyFile(sNewFidir, sOriginalFidir)
	[ ] 
	[ ] 
	[ ] 
	[ ] iResult = DataFileCreate_OII(sOnlieAccountFileName)
	[ ] // Create a new data file for Online account
	[+] if (iResult  == PASS)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] ReportStatus("Verify Data File ", PASS, "Data file -  {sOnlieAccountFileName} is created")
		[ ] // Setup LocalFile Testing mechanism
		[ ] iResult = SetUpLocalFile()
		[+] if (iResult  == PASS)
			[ ] ReportStatus("LocalFile Setup", PASS, "LocalFile Testing Setup is performed")
			[ ] 
			[ ] // 05/22/2015 KalyanG: Added the method to gracefully exit quicken
			[ ] CloseQuicken()
			[ ] 
			[ ] LaunchQuicken()
			[ ] sleep(4)
			[+] if (QuickenWindow.Exists(120))
				[ ] QuickenWindow.SetActive()
				[ ] // Add Online Account
				[ ] iSelect=ExpandAccountBar()
				[+] if(iSelect==PASS)
					[ ] QuickenWindow.SetActive()
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
					[ ] //AddAccount.CustomWin("Checking").Click()
					[ ] AddAccount.Checking.Click()
					[+] if(QuickenUpdateStatus.Exists(2))
						[ ] QuickenUpdateStatus.StopUpdate.Click()
					[ ] WaitForState(AddAccount,TRUE,20)
					[ ] //AddAnyAccount.VerifyEnabled(TRUE, 500)
					[ ] sleep(10)
					[ ] AddAnyAccount.SetActive()
					[ ] AddAnyAccount.EnterTheNameOfYourBank.TypeKeys("ZZZ - Mission Federal Credit Union")
					[ ] AddAnyAccount.Next.Click()
					[ ] 
					[ ] 
					[ ] 
					[ ] // // Provide different DAT files for Local file responses
					[+] if (FakeResponse.Exists(15) == TRUE)
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sBrandingResponse)
						[ ] ReportStatus("Branding Response", iResponseStatus, "Fake Response - {sBrandingResponse} is entered")
						[ ] 
					[+] else
						[ ] ReportStatus("Fake Respose Window", WARN, "Branding Response is not asked") 
						[ ] 
					[+] if (AddAnyAccount.Exists(15) == TRUE)
						[ ] AddAnyAccount.SetActive()
						[ ] AddAnyAccount.MFCUBankMemberNumber.SetText(sMFCUAccountId)
						[ ] AddAnyAccount.MFCUBankPassword.SetText("12345")			// Any random passord is OK
						[ ] AddAnyAccount.Connect.Click()
						[ ] 
						[+] if (FakeResponse.Exists(15) == TRUE)
							[ ] iResponseStatus = EnterFakeResponseFile(sProfileResponse)
							[ ] ReportStatus("Profile Response", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
							[ ] 
							[ ] iResponseStatus = EnterFakeResponseFile(sAccountInfoResponse)
							[ ] ReportStatus("Account Info Response", iResponseStatus, "Fake Response - {sAccountInfoResponse} is entered")
							[ ] 
							[+] if (AddAnyAccount.Exists(15) == TRUE)
								[ ] AddAnyAccount.SetActive()
								[ ] AddAnyAccount.Next.Click()
								[ ] 
								[ ] 
								[+] if (FakeResponse.Exists(15) == TRUE)
									[ ] 
									[ ] // iResponseStatus = EnterFakeResponseFile(sBrandingResponse)
									[ ] // ReportStatus("Branding Response", iResponseStatus, "Fake Response - {sBrandingResponse} is entered")
									[ ] 
									[ ] iResponseStatus = EnterFakeResponseFile(sPaymentSyncResponse)
									[ ] ReportStatus("Payment Sync Response", iResponseStatus, "Fake Response - {sPaymentSyncResponse} is entered")
									[ ] 
									[ ] iResponseStatus = EnterFakeResponseFile(sStatementResponse)
									[ ] ReportStatus("Statement Response", iResponseStatus, "Fake Response - {sStatementResponse} is entered")
									[ ] 
									[ ] 
									[+] // if (PopUp.FileDlg("Quicken Update Status").FileDlg("Local Web Request").Exists(5) == TRUE)
										[ ] // PopUp.FileDlg("Quicken Update Status").FileDlg("Local Web Request").VerifyEnabled(TRUE, 120)
										[ ] // PopUp.FileDlg("Quicken Update Status").FileDlg("Local Web Request").SetActive()
										[ ] // PopUp.FileDlg("Quicken Update Status").FileDlg("Local Web Request").Click(1, 380,540)
										[ ] // // QuickenMainWindow.FileDlg("Quicken Update Status").FileDlg("Local Web Request").FailRequest.Click()
										[ ] // 
										[ ] // // Complete the process by clicking on Finish button
										[ ] // QuickenMainWindow.FileDlg("Accounts Added").VerifyEnabled(TRUE, 150)
										[ ] // QuickenMainWindow.FileDlg("Accounts Added").Close()
										[ ] // 
									[ ] 
									[+] if(LocalWebRequest.Exists(30))
										[ ] LocalWebRequest.SetActive()
										[ ] LocalWebRequest.FailRequest.Click()
										[ ] 
										[ ] 
										[+] if(AccountsAdded.Exists(20))
											[ ] AccountsAdded.Finish.Click()
											[ ] WaitForState(AccountsAdded,FALSE,5)
											[ ] 
											[ ] 
											[ ] // Verify Accounts are displayed on Account Bar
											[ ] QuickenWindow.SetActive()
											[ ] sHandle = str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
											[ ] 
											[ ] // Verify Checking account on AccountBar
											[ ] sActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "0")
											[ ] bMatchStatus = MatchStr("*{sCheckingAccount}*", sActualOutput)
											[+] if (bMatchStatus == TRUE)
												[ ] ReportStatus("Verify Checking Account", PASS, "Checking Account -  {sCheckingAccount} is present in Account Bar") 
											[+] else
												[ ] ReportStatus("Verify Checking Account", FAIL, "Actual -  {sActualOutput} is not matching with Expected - {sCheckingAccount}") 
												[ ] 
											[ ] // Verify Savings account on AccountBar
											[ ] sActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "2")
											[ ] bMatchStatus = MatchStr("*{sSavingsAccount}*", sActualOutput)
											[+] if (bMatchStatus == TRUE)
												[ ] ReportStatus("Verify Savings Account", PASS, "Savings Account -  {sSavingsAccount} is present in Account Bar") 
											[+] else
												[ ] ReportStatus("Verify Checking Account", FAIL, "Actual -  {sActualOutput} is not matching with Expected - {sSavingsAccount}") 
												[ ] 
												[ ] // 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Verify Account Added window is displayed",FAIL,"Accounts added window is not displayed")
										[ ] 
									[+] else
										[ ] ReportStatus("ACE Request", FAIL, "ACE Request window is not available") 
										[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Fake Respose Window", FAIL, "Fake Respose window is not available") 
									[ ] 
							[+] else
								[ ] ReportStatus("Checking Account Window", FAIL, "Checking Account window is not available") 
							[ ] 
						[+] else
							[ ] ReportStatus("Fake Respose Window", FAIL, "Fake Respose window is not available") 
							[ ] 
					[+] else
						[ ] ReportStatus("Checking Account Window", FAIL, "Checking Account window is not available") 
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Expand Account Bar",FAIL,"Account bar is not expanded")
				[ ] 
				[ ] 
				[ ] 
				[+] // if(SKU_TOBE_TESTED == "Premier" || SKU_TOBE_TESTED == "Deluxe" || SKU_TOBE_TESTED == "QNUE")
					[ ] // // Read data from excel sheet
					[ ] // lsExcelData = ReadExcelTable(sSmokeData, sAccountWorksheet)
					[ ] // // Fetch 3rd row 
					[ ] // lsAddAccount=lsExcelData[3]
					[ ] // 
					[ ] // // Add Saving Account
					[ ] // iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
					[ ] // // Report Status if Saving Account is created
					[+] // if (iAddAccount==PASS)
						[ ] // ReportStatus("Add Saving Account", iAddAccount, "Saving Account -  {lsAddAccount[2]}  is created successfully")
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Add Saving Account", iAddAccount, "Saving Account -  {lsAddAccount[2]}  is not created")
						[ ] // 
					[ ] // 
			[+] else
				[ ] ReportStatus("Verify Quicken Window", FAIL, "Quicken is not available") 
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("LocalFile Setup", FAIL, "LocalFile Testing Setup is performed") 
		[ ] 
	[+] // else
		[ ] // ReportStatus("Verify Data File ", FAIL, "Data file -  {sOnlieAccountFileName} couldn't be created")
	[ ] 
	[ ] 
	[ ] 
	[ ] // Cleanup
	[ ] // Close Quicken
	[+] if (QuickenWindow.Exists())
		[ ] CloseQuicken()
		[ ] sleep(5)
		[ ] // Delete qa_acc32.dll
		[ ] DeleteFile(sAccDllDestinationPath)
		[ ] sleep(2)
		[ ] DeleteFile(sDestinationonliniFile)
		[ ] sleep(2)
		[ ] DeleteFile(sDestinationonliniFile)
		[ ] // Delete file intu_onl.ini located in WIndows directory
		[ ] DeleteFile(SYS_GetEnv("WINDIR") + "\\intu_onl.ini")
	[ ] DeleteFile(sOriginalFidir)
	[ ] CopyFile(sKeepFidir,sOriginalFidir)
	[ ] DeleteFile(sKeepFidir)
	[ ] LaunchQuicken()
[ ] //############################################################################
[+] //#############  Re-launch Quicken and Verify File Attributes #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 	Test70_ReLaunchQuicken()
		[ ] //
		[ ] // Description: 				
		[ ] // This testcase will Launch Quicken and Verify File Attributesn.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // Returns:			      	Pass 	if verification is done successfully 							
		[ ] //						Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	
		[ ] //	Jan 10, 2011  		Mamta Jain created	  
	[ ] // ********************************************************
[+] testcase Test70_ReLaunchQuicken() appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] LIST OF STRING lsActualFileAttribute, lsFileAttributes
		[ ] STRING sExpectedAttribute
	[+] // Expected values of Quicken File Attributes
		[ ] lsFileAttributes = {"Accounts", "Categories", "Memorized Payee", "Securities", "Transactions" }
		[ ] LoadSKUDependency()
		[ ] // sQuickenAttributesWorksheet="Quicken_Attributes_RPM"
	[ ] 
	[ ] // Read excel table
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sQuickenAttributesWorksheet)
	[ ] // fetch 1st row
	[ ] lsQuickenAttributes = lsExcelData[3]
	[+] if(EnterQuickenPassword.Exists(5))
		[ ] EnterQuickenPassword.SetActive()
		[ ] EnterQuickenPassword.Close()
		[ ] WaitForState(EnterQuickenPassword , FALSE , 5)
		[+] if(ImportExportQuickenFile.Exists(5))
			[ ] ImportExportQuickenFile.SetActive()
			[ ] ImportExportQuickenFile.Close()
			[ ] WaitForState(ImportExportQuickenFile , FALSE , 5)
		[ ] 
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)		// Get all File Attributes of Quicken
		[ ] 
		[ ] // Verification of Actual File Attributes
		[+] for (i=1;i<=ListCount(lsActualFileAttribute);i++)
			[ ] sExpectedAttribute=str(Val(lsQuickenAttributes[i]))
			[+] if(sExpectedAttribute == lsActualFileAttribute[i])
				[ ] ReportStatus("Verify {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i]}") 
			[+] else
				[ ] ReportStatus("Verify {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i]}")
				[ ] 
				[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //#############################################################################
[+] //############# Smoke Clean Up##################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 SmokeClean()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will close Quicken, QwAuto window if open.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while closing the window							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 10, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase SmokeClean() appstate none
	[ ] 
	[+] if(QuickenAutomationInterface.Exists(5) == TRUE)
		[ ] QuickenAutomationInterface.Close()
	[ ] 
	[+] if(QuickenWindow.Exists(5) == TRUE)
		[ ] QuickenWindow.Close()
[ ] //#############################################################################
[ ] 
