[+] // FILE NAME:	<OneIntuitPassword.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   <This script contains all OIP test cases>
	[ ] //
	[ ] // DEPENDENCIES:	<include.inc>
	[ ] //
	[ ] // DEVELOPED BY:	Abhjit Sarma
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //14/Feb/2015	Created By Abhjit Sarma
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[+] // Global variables used for OIP Test cases
	[ ] public STRING sOIPFileName = "One Intuit Password"
	[ ] public STRING sSourceFile = AUT_DATAFILE_PATH + "\OIP Data File\" + sOIPFileName + ".QDF"
	[ ] public STRING sOIPFile = AUT_DATAFILE_PATH + "\" + sOIPFileName + ".QDF"
	[ ] public STRING sBackupLocation = AUT_DATAFILE_PATH + "\BACKUP\" 
	[ ] public STRING sRestoreLocation = AUT_DATAFILE_PATH + "\BACKUP\" + sOIPFileName + "\"
	[ ] public STRING sCaption = ""
	[ ] 
	[ ] public LIST OF ANYTYPE  lsAccountData,lsExcelData, lsExcelData1
	[ ] public LIST OF STRING lsAddAccount, lsTransactionData, lsCategoryData
	[ ] public STRING sOIPData = "OipData"
	[ ] public STRING sAccountSheet = "Account"
	[ ] public STRING sTransactionSheet = "Transaction"
	[ ] public STRING sCategorySheet = "Category"
	[ ] public STRING sDateFormate="m/d/yyyy"
	[ ] public STRING sDate = FormatDateTime (GetDateTime(), sDateFormate) 
[+] // Global Functions used for OIP Test cases
	[ ] // //############# Copy data file ############# 
	[+] public INTEGER CopyOIPDataFile(STRING sFileName)
		[ ] //Variable Declaration
		[ ] sSourceFile = AUT_DATAFILE_PATH + "\OIP Data File\" + sFileName + ".QDF"
		[ ] sOIPFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sConvertedFile = AUT_DATAFILE_PATH + "\Q13Files\" + sFileName + ".QDF"
		[ ] print(sConvertedFile)
		[ ] 
		[-] if(FileExists(sTestCaseStatusFile))
			[ ] DeleteFile(sTestCaseStatusFile)
		[ ] // Load O/S specific paths
		[ ] LoadOSDependency()
		[-] if (QuickenWindow.Exists())
				[-] if(FileExists(sOIPFile) == TRUE)
					[ ] sCaption = QuickenWindow.GetCaption ()
					[-] if(MatchStr("*{sFileName}*", sCaption))
						[-] if(QuickenWindow.Exists(SHORT_SLEEP))
							[ ] QuickenWindow.Kill()
							[ ] WaitForState(QuickenWindow,FALSE,5)
					[ ] DeleteFile(sOIPFile)
					[-] if(FileExists(sConvertedFile) == TRUE)
						[ ] DeleteFile(sConvertedFile)
		[-] if(FileExists(sOIPFile) == TRUE)
			[ ] DeleteFile(sOIPFile)
		[-] if(FileExists(sConvertedFile) == TRUE)
			[ ] DeleteFile(sConvertedFile)
		[ ] CopyFile(sSourceFile, sOIPFile)
		[+] if (!QuickenWindow.Exists())
			[ ] LaunchQuicken()
			[+] WaitForState(QuickenWindow, TRUE ,10)
				[+] if (EnterQuickenPassword.Exists(2)) // added by Abhijit s Feb 2015
					[ ] EnterQuickenPassword.SetActive()
					[ ] EnterQuickenPassword.Password.SetFocus()
					[ ] EnterQuickenPassword.Password.SetText(sPassword)
					[ ] EnterQuickenPassword.Password.OK.Click()
			[ ] 
		[ ] return NULL
	[ ] // //############# Enter Password if Enter Password Exist  ############# 
	[+] public INTEGER EnterPassword()
		[-] if (EnterQuickenPassword.Exists(2)) // added by Abhijit s Feb 2015
			[ ] EnterQuickenPassword.SetActive()
			[ ] EnterQuickenPassword.Password.SetFocus()
			[ ] EnterQuickenPassword.Password.SetText(sPassword)
			[ ] EnterQuickenPassword.OK.Click()
		[ ] return NULL
	[ ] // //############# Open data file till Registration Successfull Page  ############# 
	[-] public INTEGER OpenDataFileTillRegistrationSuccessfull(STRING sFileName,STRING sLocation optional, STRING sExtension optional)
		[ ] 
		[-] // Variable declaration
			[ ] STRING sCaption, sExpected, sFileWithPath
			[ ] BOOLEAN  bFound ,bResult
			[ ] INTEGER iResult
			[ ] 
			[-] if(sExtension==NULL)
				[ ] sExtension= ".QDF"
			[ ] 
			[-] if(sLocation==NULL)
				[ ] sFileWithPath = AUT_DATAFILE_PATH + "\" + sFileName + sExtension
			[+] else
				[ ] sFileWithPath = sLocation + "\" + sFileName + ".QDF"
				[ ] 
			[ ] 
		[-] do
			[ ] QuickenWindow.SetActive()
			[-] if (EnterQuickenPassword.Exists(2))
				[ ] EnterQuickenPassword(sPassword) // added by Abhijit s Feb 2015
			[-] // if (EnterQuickenPassword.Exists(2)) // added by Abhijit s Feb 2015
				[ ] // EnterQuickenPassword.SetActive()
				[ ] // EnterQuickenPassword.Password.SetFocus()
				[ ] // EnterQuickenPassword.Password.SetText(sPassword)
				[ ] // EnterQuickenPassword.Password.OK.Click()
			[-] if(ConvertYourData.Exists(10))// added by Abhijit s Feb 2015
				[ ] print("convert your data dialog appeard")
				[ ] ConvertYourData.SetActive()
				[ ] ConvertYourData.ConvertFilebutton.Click()
			[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists(10))// added by Abhijit s Feb 2015
				[ ] SignInQuickenConnectedServices()
			[-] do
				[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
				[ ] QuickenWindow.File.OpenQuickenFile.Select()
			[-] except
				[ ] QuickenWindow.SetActive()
				[-] do
					[ ] QuickenWindow.TypeKeys(KEY_CTRL_O)
				[-] except
					[-] do
						[ ] QuickenWindow.File.Click()
						[ ] QuickenWindow.File.OpenQuickenFile.Select()
					[-] except
						[ ] QuickenWindow.MainMenu.Select("/_File/_Open Quicken File...")
				[ ] 
			[ ] 
			[ ] // Alert for online payments
			[-] if(AlertMessage.No.Exists(5))
				[ ] AlertMessage.SetActive()
				[ ] AlertMessage.No.Click()
			[-] if(QuickenBackupReminder.Exists(5))
				[ ] QuickenBackupReminder.DontShowAgainCheckBox.Check()
				[ ] QuickenBackupReminder.LaterButton.Click()
			[-] if(SyncChangesToTheQuickenCloud.Exists(3))
				[ ] SyncChangesToTheQuickenCloud.Later.Click()
				[ ] WaitForState(SyncChangesToTheQuickenCloud,FALSE,5)
			[ ] 
			[-] if (ImportExportQuickenFile.Exists(10))
				[ ] ImportExportQuickenFile.SetActive()
				[ ] ImportExportQuickenFile.FileName.SetText(sFileWithPath)
				[ ] 
				[ ] ImportExportQuickenFile.OK.Click()
				[ ] 
				[ ] //Password protected file // Added by Abhijit S Feb 2015
				[-] if (EnterQuickenPassword.Exists(20))
					[ ] EnterQuickenPassword(sPassword)
				[-] //if (EnterQuickenPassword.Exists(2)) // added by Abhijit s Feb 2015
					[ ] // EnterQuickenPassword.SetActive()
					[ ] // EnterQuickenPassword.Password.SetFocus()
					[ ] // EnterQuickenPassword.Password.SetText(sPassword)
					[ ] // EnterQuickenPassword.Password.OK.Click()
					[ ] 
				[ ] //Convert data file if older file
				[-] if(ConvertYourData.Exists(30))
					[ ] print("convert your data dialog appeard")
					[ ] ConvertYourData.SetActive()
					[ ] ConvertYourData.ConvertFilebutton.Click()
					[-] if (AlertMessage.Yes.Exists(2))
						[ ] AlertMessage.SetActive()
						[ ] AlertMessage.Yes.Click()
						[ ] WaitForState(AlertMessage, FALSE ,2)
					[ ] 
					[-] if (AlertMessage.OK.Exists(2))
						[ ] AlertMessage.SetActive()
						[ ] AlertMessage.OK.Click()
						[ ] WaitForState(AlertMessage, FALSE ,2)
					[+] if (AlertMessage.Exists(5))
						[+] while (AlertMessage.Exists())
							[ ] sleep(1)
					[+] while (QuickenAlertMessage.Exists(2))
						[ ] sleep(1)
						[ ] 
				[-] else
					[ ] print("convert your data dialog didn't appear")
				[ ] SignInQuickenConnectedServicesTillRegistrationSuccessfull()
				[-] if (AlertMessage.Exists(3))
					[ ] AlertMessage.SetActive()
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage, false ,2)
					[ ] ImportExportQuickenFile.SetActive()
					[ ] ImportExportQuickenFile.Cancel.Click()
				[ ] 
				[ ] WaitForState(ImportExportQuickenFile, false ,5)
				[ ] 
				[ ] sleep(5)
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] sCaption = QuickenWindow.GetCaption ()
				[ ] 
				[ ] bFound = MatchStr("*{sFileName}*", sCaption)
				[-] if(bFound == TRUE)
					[ ] iFunctionResult = PASS
				[-] else
					[ ] iFunctionResult = FAIL
					[ ] 
				[ ] 
				[ ] // iResult=ExpandAccountBar()     
				[-] // if (iResult==FAIL)
					[ ] // LaunchQuicken()
				[ ] 
			[-] else
				[ ] ReportStatus("Verify Open Quicken File", FAIL, "Open Quicken File dailog didn't appear.") 
				[ ] iFunctionResult = FAIL
			[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] // QuickenWindow.Kill()
			[ ] // WaitForState(QuickenWindow , FALSE ,5)
			[ ] // App_Start(sCmdLine)
			[ ] // sleep(10)
			[ ] // WaitForState(QuickenWindow , TRUE ,10)
			[ ] // 
			[+] // if (ImportExportQuickenFile.Exists())
				[ ] // ImportExportQuickenFile.Close()
			[ ] iFunctionResult = FAIL
		[ ] return iFunctionResult
	[ ] // //############# Change Intuit Password From Edit Prefernces  ############# 
	[+] public void ChangeIntuitPasswordFromPreferences(STRING sExistingPassword, STRING sNewPassword)
		[ ] 
		[+] //Variables
			[ ] INTEGER iResult
		[-] do
			[ ] 
			[ ] iResult=SelectPreferenceType(sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE)
			[+] if(UnlockYourPasswordVault.Exists(2))
				[ ] UnlockYourPasswordVault.Password.SetFocus()
				[ ] UnlockYourPasswordVault.Password.SetText("sPassword")
				[ ] UnlockYourPasswordVault.Password.OK.Click()
				[ ] 
			[-] if (iResult==PASS)
				[ ] Preferences.SetActive()
				[ ] Preferences.ChangeIntuitPassword.Click()
				[+] if(UnlockYourPasswordVault.Exists(10))
					[ ] UnlockYourPasswordVault.Password.SetFocus()
					[ ] UnlockYourPasswordVault.Password.SetText(sExistingPassword)
					[ ] UnlockYourPasswordVault.Password.OK.Click()
				[+] if(SignIn.Exists(10))
					[ ] SignIn.SignIn.Password.SetFocus()
					[ ] SignIn.SignIn.Password.SetText(sExistingPassword)
					[ ] sleep(10)
					[ ] SignIn.SignIn.SignInButton.Click()
					[ ] sleep(20)
				[-] if(DlgChangeYourIntuitPassword.Exists(10))
					[ ] DlgChangeYourIntuitPassword.CurrentIntuitIDPassword.SetFocus()
					[ ] DlgChangeYourIntuitPassword.CurrentIntuitIDPassword.SetText(sExistingPassword)
					[ ] DlgChangeYourIntuitPassword.NewPassword.SetFocus()
					[ ] DlgChangeYourIntuitPassword.NewPassword.SetText(sNewPassword)
					[ ] DlgChangeYourIntuitPassword.ReEnterNewPassword.SetFocus()
					[ ] DlgChangeYourIntuitPassword.ReEnterNewPassword.SetText(sNewPassword)
					[ ] 
					[ ] DlgChangeYourIntuitPassword.OKButton.Click()
					[ ] WaitForState(DlgChangeYourIntuitPassword,FALSE,5)
					[ ] sleep(20)
					[-] if(UnlockYourPasswordVault.Exists(10))
						[ ] UnlockYourPasswordVault.Password.SetFocus()
						[ ] UnlockYourPasswordVault.Password.SetText(sNewPassword)
						[ ] UnlockYourPasswordVault.Password.OK.Click()
					[+] if(SignIn.Exists(10))
						[ ] SignIn.SignIn.Password.SetFocus()
						[ ] SignIn.SignIn.Password.SetText(sNewPassword)
						[ ] sleep(10)
						[ ] SignIn.SignIn.SignInButton.Click()
						[ ] sleep(20)
					[ ] 
					[-] if(PasswordChangeAlert.Exists(5))
						[ ] PasswordChangeAlert.OK.Click()
					[-] if(SignIn.Exists(2))
						[ ] SignIn.SignIn.Password.SetFocus()
						[ ] SignIn.SignIn.Password.SetText(sNewPassword)
						[ ] sleep(10)
						[ ] SignIn.SignIn.SignInButton.Click()
						[ ] sleep(20)
					[ ] Preferences.OK.Click()
					[ ] iFunctionResult=PASS
				[+] else
					[ ] ReportStatus("Verify Change Intuit ID dialog",FAIL,"Change Your Intuit Password dialog is not displayed")
					[ ] 
					[ ] iFunctionResult=FAIL
			[+] else
				[ ] ReportStatus("Verify Preference type is selected",FAIL,"{sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE} preference type is not selected")
				[ ] iFunctionResult=FAIL
			[ ] 
		[-] except
			[ ] ExceptLog()
			[ ] iFunctionResult=FAIL
		[ ] 
	[ ] // //############# IAm Registration till Custom or Intuit Password select page  ############# 
	[+] public void SignInQuickenConnectedServicesTillRegistrationSuccessfull(STRING sEmailID optional,STRING sPassword optional,STRING sSecurityQuestion optional,STRING sSecurityQuestionAnswer optional,STRING sName optional,STRING sLastName optional,STRING sAddress optional,STRING sCity optional,STRING sState optional,STRING sZip optional,STRING sBoughtFrom optional,STRING sVaultPassword optional)
		[ ] 
		[-] //Variable Definition in case of NULL Values
			[ ] STRING sActual, sExpected
			[ ] BOOLEAN bExistingUser= FALSE
			[-] if(sEmailID==NULL)
				[ ] sEmailID="Quicken_User@test.qbn.intuit.com"
				[ ] 
			[-] if(sPassword==NULL)
				[ ] sPassword="a123456b"
				[ ] 
			[-] if(sSecurityQuestion==NULL)
				[ ] sSecurityQuestion="2"
				[ ] 
			[-] if(sSecurityQuestionAnswer==NULL)
				[ ] sSecurityQuestionAnswer="Ferrari"
				[ ] 
			[-] if(sName==NULL)
				[ ] sName="Quicken"
				[ ] 
			[-] if(sLastName==NULL)
				[ ] sLastName="User"
				[ ] 
				[ ] 
			[-] if(sAddress==NULL)
				[ ] sAddress="101202 MTV"
				[ ] 
			[-] if(sCity==NULL)
				[ ] sCity="Mountain View"
			[-] if(sState==NULL)
				[ ] sState="CA"
			[-] if(sZip==NULL)
				[ ] sZip="12345"
				[ ] 
			[-] if(sBoughtFrom==NULL)
				[ ] sBoughtFrom="Other"
			[ ] 
			[ ] String sTemp
		[ ] 
		[-] do
			[ ] 
			[ ] //Second page of Quicken Connected Services
			[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists(10))
				[ ] QuickenIAMMainWindow.SetActive() 
				[ ] sleep(20)
				[ ] 
				[ ] print("IAM sign-in ")
				[-] if (QuickenIAMMainWindow.IAMUserControl.IAMContentControl.linkCreateOneHere.Exists())
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.linkCreateOneHere.Click()
				[ ] 
				[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.EmailID.Exists(10))
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.EmailID.SetText(sEmailID)
					[ ] sTemp=QuickenIAMMainWindow.IAMUserControl.IAMContentControl.EmailID.GetProperty("Text")
					[ ] print("stemp: {sTemp}")
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Password.SetText(sPassword)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.ConfirmPassword.SetText(sPassword)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.SecurityQuestion.Select(val(sSecurityQuestion))
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.SecurityQuestionAnswer.SetText(sSecurityQuestionAnswer)
					[ ] sleep(2)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
					[ ] sleep(5)
				[ ] //Third page of Quicken Connected Services(if displayed)
				[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Exists(10))
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Name.SetText(sName)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.LastName.SetText(sLastName)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Address.SetText(sAddress)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.City.SetText(sCity)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.State.Select(sState)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Zip.SetText(sZip)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Select(sBoughtFrom)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
					[ ] sleep(5)
					[ ] 
					[ ] //Fourth page of Quicken Connected Services
					[+] if(sVaultPassword!=NULL)
						[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.PasswordVaultpassword.SetText(sVaultPassword)
						[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
					[+] else
						[+] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.SkipThisStep.Click()
							[ ] 
							[ ] 
							[ ] 
						[ ] 
				[ ] //Handle if ID already exists
				[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.ExistingUserName.Exists(10))
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Password.SetText(sPassword)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
					[ ] bExistingUser = TRUE
					[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Upgrade.Exists(10))
						[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Upgrade.BringIntoView()
						[ ] sleep(1)
						[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Upgrade.Click()
						[-] if (UpgradeToTheQuickenmobileApp.Exists(30))
							[ ] UpgradeToTheQuickenmobileApp.SetActive()
							[ ] UpgradeToTheQuickenmobileApp.CancelButton.Click()
						[ ] 
					[ ] 
					[ ] 
				[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Exists(10))
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Name.SetText(sName)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.LastName.SetText(sLastName)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Address.SetText(sAddress)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.City.SetText(sCity)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.State.Select(sState)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Zip.SetText(sZip)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.WhereDidYouPurchaseQuicken.Select(sBoughtFrom)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
					[ ] sleep(5)
					[ ] 
					[ ] 
				[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseMobileOption.Exists(10))
					[-] do
						[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseMobileOption.Check()
					[+] except
						[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseMobileOption.Click()
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
				[ ] //
				[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Upgrade.Exists(10))
					[ ] 
					[+] if(QuickenWindow.GetState()!=WS_MAXIMIZED)
						[ ] QuickenWindow.PressKeys(KEY_ALT_SPACE)
						[ ] QuickenWindow.TypeKeys(KEY_X)
						[ ] QuickenWindow.ReleaseKeys(KEY_ALT_SPACE)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Upgrade.BringIntoView()
					[ ] sleep(2)
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Upgrade.Click()
					[+] if (UpgradeToTheQuickenmobileApp.Exists(10))
						[ ] UpgradeToTheQuickenmobileApp.SetActive()
						[ ] UpgradeToTheQuickenmobileApp.CancelButton.Click()
					[ ] 
				[ ] 
				[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Exists(10))
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Click()
					[+] if(AddAccount.Exists(5))
						[ ] AddAccount.SetActive()
						[ ] AddAccount.Close()
					[ ] 
					[ ] 
				[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Exists(10))
					[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.NextButton.Click()
					[ ] 
					[ ] 
				[-] // if(QuickenWindow.Done.Exists(20))
					[ ] // QuickenWindow.Done.Click()
				[-] // if (DlgConsolidatePassword.Exists(20))
					[ ] // DlgConsolidatePassword.SetActive()
					[ ] // DlgConsolidatePassword.Close()
					[ ] // WaitForState(DlgConsolidatePassword ,FALSE , 5)
				[-] // if (DlgQuickenOnePassword.Exists(20))
					[ ] // DlgQuickenOnePassword.SetActive()
					[ ] // DlgQuickenOnePassword.Close()
					[ ] // WaitForState(DlgQuickenOnePassword ,FALSE , 5)
				[ ] 
				[ ] iFunctionResult=PASS
			[-] // else if (DlgIAMSignIn.Exists(5))
				[ ] // DlgIAMSignIn.SetActive()
				[ ] // DlgIAMSignIn.IntuitPasswordTextBox.SetText(sPassword)
				[ ] // DlgIAMSignIn.LoginButton.Click()
				[ ] // WaitForState(DlgIAMSignIn , FALSE , 10)
				[ ] // sleep(5)
				[ ] // iFunctionResult=PASS
				[ ] // 
			[+] else 
				[ ] 
				[ ] 
				[ ] ///Datafile is already signed-in
				[ ] iFunctionResult=PASS
			[ ] 
		[-] except
			[ ] ExceptLog()
			[ ] iFunctionResult=FAIL
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
[+] // //############# Verify Registration Successfull UI and Default option for data file password on the Registration Successfull UI  ############# 
	[ ] // // ********************************************************
	[-] // // TestCase Name:	 Test01_VerifyRegistrationSuccessfullUI ()
		[ ] // // 
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will create new OIP data fileand verify UI of RegistrationSuccessfull screen
		[ ] // // 
		[ ] // // PARAMETERS:	none
		[ ] // // 
		[ ] // // RETURNS:			Pass 		if data file is created without any errors and UI verification happens as expected					
		[ ] // // 						Fail		if any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // Feb 14, 2015		Created By Abhjit Sarma
	[ ] // // *********************************************************
[+] testcase Test01_VerifyRegistrationSuccessfullUI () appstate QuickenBaseState
	[ ] 
	[ ] //Variable Declaration
	[ ] INTEGER iCreateDataFile
	[ ] 
	[-] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] //-------Create data file------------
	[ ] iCreateDataFile = DataFileCreateTillRegistration(sOIPFileName)
	[-] if(iCreateDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is created")
		[ ] 
		[ ] sleep(5)
		[ ] //Registration Successfull screen element verification
		[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.RegistrationStatus.Exists(30))
			[ ] ReportStatus("Validate Data File ", PASS, "Registartion successfull for the data file  {sOIPFile} ")
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Add Account Button not present in Registration successfull screen in the datafile  {sOIPFile} ")
			[ ] 
		[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseExistingDataFilePasswordOption.Exists(30))
			[ ] ReportStatus("Validate Data File ", PASS, "UseExistingDataFilePasswordOption exist in the data file  {sOIPFile} ")
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Add Account Button not present in Registration successfull screen in the datafile  {sOIPFile} ")
		[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseExistingDataFilePasswordOption.Exists(30))
			[ ] ReportStatus("Validate Data File ", PASS, "UseIntuitIDDataFilePasswordOption exist in the data file  {sOIPFile} ")
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Add Account Button not present in Registration successfull screen in the datafile  {sOIPFile} ")
			[ ] 
			[ ] 
			[ ] 
		[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseExistingDataFilePasswordOption.State==1)
			[ ] ReportStatus("Validate Data File ", PASS, "UseExistingDataFilePasswordOption is selected by default the data file  {sOIPFile} ")
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Add Account Button not present in Registration successfull screen in the datafile  {sOIPFile} ")
		[ ] 
		[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Exists(30))
			[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Click()
			[ ] ReportStatus("Validate Data File ", PASS, "UseExistingDataFilePasswordOption exist in the data file  {sOIPFile} ")
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Add Account Button not present in Registration successfull screen in the datafile  {sOIPFile} ")
			[ ] 
		[ ] 
		[ ] // // Verification to be done for other elements 
		[-] if(AddAccount.Exists(5))   // Comment this block of code to leave Quicken in registartion Successfull screen
			[ ] AddAccount.SetActive()
			[ ] AddAccount.Close()
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} creation")
	[ ] 
[+] // //############# Verify Verify that user can change option to 'Yes' for data file password on 'Registration Successful' UI  ############# 
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test02_SetIntuitIDAsDataFilePassword ()
		[ ] // // 
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will create new OIP data file and  set Intuit ID as data file password and verify it
		[ ] // // 
		[ ] // // PARAMETERS:	none
		[ ] // // 
		[ ] // // RETURNS:			Pass 		if data file is created without any errors and Intuit ID can be set as data file password					
		[ ] // // 						Fail		if any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // Feb 15, 2015		Created By Abhjit Sarma
	[ ] // // *********************************************************
[+] testcase Test02_SetIntuitIDAsDataFilePassword  () appstate QuickenBaseState
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iCreateDataFile
		[ ] INTEGER iAddAccount
		[ ] 
	[ ] //-------Create data file------------
	[ ] EnterPassword()
	[ ] iCreateDataFile = DataFileCreateTillRegistration(sOIPFileName+" IntuitPassword")
	[+] if(iCreateDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName+" IntuitPassword"} is created")
		[ ] sleep(5)
		[ ] //Registration Successfull screen element verification
		[+] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.RegistrationStatus.Exists(300))
			[ ] ReportStatus("Validate Data File ", PASS, "Registartion successfull for the data file  {sOIPFileName+" IntuitPassword"} ")
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, " Registration is not successfull screen in the datafile  {sOIPFileName+" IntuitPassword"} ")
			[ ] 
		[+] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseIntuitIDDataFilePasswordOption.Exists(300))
			[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseIntuitIDDataFilePasswordOption.Check()
			[ ] Print(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseIntuitIDDataFilePasswordOption.GetProperty("IsChecked"))
			[ ] ReportStatus("Validate Data File ", PASS, "Use Intuit ID Data File Password Option selected by User in {sOIPFileName+" IntuitPassword"} ")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Use Intuit ID Data File Password Option could not be selected by User in {sOIPFileName+" IntuitPassword"} ")
		[+] // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseIntuitIDDataFilePasswordOption.State==1)
			[ ] // ReportStatus("Validate Data File ", PASS, "Use Intuit ID Data File Password Option could be select by User in {sOIPFile} ")
		[+] // else
			[ ] // ReportStatus("Validate Data File ", FAIL, "Use Intuit ID Data File Password Option could not be select by User in {sOIPFile+"1"}")
		[+] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Exists(300))
			[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Click()
			[ ] ReportStatus("Validate Data File ", PASS, "Add Account wizard optionn exist in the data file  {sOIPFileName+" IntuitPassword"} ")
		[ ] 
		[+] if(AddAccount.Exists(5))   // Comment this block of code to leave Quicken in registartion Successfull screen
			[ ] AddAccount.SetActive()
			[ ] AddAccount.Close()
		[ ] sleep(5)
		[ ] iAddAccount = AddManualSpendingAccount("Savings","Saving Account","1000")
		[-] // Verify Intuit password
			[ ] CloseQuicken()
			[ ] LaunchQuicken()
			[+] // if(QuickenTSM.Exists())
				[ ] // QuickenTSM.SetActive()
				[ ] // QuickenTSM.RemindMeLater.Uncheck()
				[ ] // QuickenTSM.Close()
			[+] if (EnterPassword()==PASS)
				[ ] // EnterQuickenPassword.SetActive()
				[ ] // EnterQuickenPassword.Password.SetFocus()
				[ ] // EnterQuickenPassword.Password.SetText(sPassword)
				[ ] // EnterQuickenPassword.Password.OK.Click()
				[ ] 
				[-] if(QuickenWindow.Exists(2))
					[ ] QuickenWindow.SetActive()
					[ ] sCaption = QuickenWindow.GetCaption ()
					[-] if(MatchStr("*{sOIPFileName}*",sCaption))
						[ ] ReportStatus("Verify that user can set Intuit Password as file password",PASS,"User is able to set Intuit password as  file password ")
					[-] else
						[ ] ReportStatus("Verify that user can set Intuit Password as file password",FAIL,"User is not able to set Password as file password as {sOIPFileName+" IntuitPassword"} data file is not opened")
						[ ] 
				[-] else
					[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window does not exist")
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFileName+" IntuitPassword"} creation")
[+] // testcase Test03_DefaultOptionForDataFilePasswordOnTheRegistrationSuccessfullUI () //appstate QuickenBaseState
	[ ] // 
	[-] // // //Variable Declaration
		[ ] // // INTEGER iCreateDataFile
		[ ] // BOOLEAN bSelectState
	[ ] // // 
	[ ] // // 
	[ ] // // //-------Create data file------------
	[ ] // // iCreateDataFile = DataFileCreateTillRegistration(sOIPFileName)
	[+] // // if(iCreateDataFile==PASS)
		[ ] // // ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is created")
		[ ] // // 
		[ ] // // sleep(5)
	[+] // // else
		[ ] // // ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} creation")
	[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.RegistrationStatus.Exists(300))
		[ ] // // ReportStatus("Validate Data File ", PASS, "Registartion successfull for the data file  {sOIPFile} ")
	[+] // // else
		[ ] // // ReportStatus("Validate Data File ", FAIL, "Add Account Button not present in Registration successfull screen in the datafile  {sOIPFile} ")
		[ ] // // 
	[ ] // QuickenIAMMainWindow.SetActive()
	[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseExistingDataFilePasswordOption.Exists(300))
		[ ] // // ReportStatus("Validate Data File ", PASS, "UseIntuitIDDataFilePasswordOption exist in the data file  {sOIPFile} ")
	[+] // // else
		[ ] // // ReportStatus("Validate Data File ", FAIL, "Add Account Button not present in Registration successfull screen in the datafile  {sOIPFile} ")
		[ ] // // 
		[ ] // // 
		[ ] // // 
	[+] // // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Exists(300))
		[ ] // // QuickenIAMMainWindow.IAMUserControl.IAMContentControl.AddAccount.Click()
		[ ] // // ReportStatus("Validate Data File ", PASS, "UseExistingDataFilePasswordOption exist in the data file  {sOIPFile} ")
	[+] // // else
		[ ] // // ReportStatus("Validate Data File ", FAIL, "Add Account Button not present in Registration successfull screen in the datafile  {sOIPFile} ")
		[ ] // // 
	[ ] // 
	[ ] // // Verification to be done for other elements 
	[-] // // if(AddAccount.Exists(5))   // Comment this block of code to leave Quicken in registartion Successfull screen
		[ ] // // AddAccount.SetActive()
		[ ] // // AddAccount.Close()
	[ ] // 
[+] //############# Set Custom Data File Password ############# 
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test02_VerifyUserCanSetCustomFilePassword  ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user can set custom file password 
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		if Verify  user can set custom file password 					
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 14, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test03_SetCustomDataFilePassword () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] sOIPFileName = "One Intuit Password No Password"
		[ ] 
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[+] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] sleep(5)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(2)
		[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
		[+] if (ManageDataFilePassword.Exists(2))
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.UseMyCustomPassword.Select(2)
			[ ] ManageDataFilePassword.CreateNewPassword.SetFocus()
			[ ] ManageDataFilePassword.CreateNewPassword.SetText(sPassword)
			[ ] ManageDataFilePassword.ConfirmPassword.SetFocus()
			[ ] ManageDataFilePassword.ConfirmPassword.SetText(sPassword)
			[ ] ManageDataFilePassword.OK.Click()
			[ ] 
		[+] else
				[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
				[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
	[ ] 
	[ ] // Verify custom password
	[ ] LaunchQuicken()
	[-] if (EnterQuickenPassword.Exists(2))  
		[ ] EnterQuickenPassword.SetActive()
		[ ] EnterQuickenPassword.Password.SetFocus()
		[ ] EnterQuickenPassword.Password.SetText(sPassword)
		[ ] EnterQuickenPassword.Password.OK.Click()
		[ ] 
		[-] if(QuickenWindow.Exists(2))
			[ ] QuickenWindow.SetActive()
			[ ] sCaption = QuickenWindow.GetCaption ()
			[-] if(MatchStr("*{sOIPFileName}*",sCaption))
				[ ] ReportStatus("Verify that user can set custom file password",PASS,"User is able to set custom file password ")
			[+] else
				[ ] ReportStatus("Verify that user can set custom file password",FAIL,"User is not able to set custom file password as {sOIPFileName} data file is not opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window does not exist")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Enter Quicken Password window",FAIL,"Enter Quicken Password window doest not exist")
[+] //############# Set no data file password for Intuit ID as Data File Password ############# 
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test04_VerifyUserCanSetCustomFilePassword  ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user can remove already set Intuit file password to no password
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		if user can remove already set Intuit file password to no password 					
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 14, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test04_IntuitDataFilePasswordToNoPassword () appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] 
		[ ] sOIPFileName = "One Intuit Password"
		[ ] 
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] EnterPassword()
	[-] iOpenDataFile = OpenDataFile(sOIPFileName)
		[-] if(iOpenDataFile==PASS)
				[ ] sleep(5)
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
				[ ] sleep(2)
				[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
				[-] if (ManageDataFilePassword.Exists(2))
					[ ] ManageDataFilePassword.SetActive()
					[ ] ManageDataFilePassword.IDoNotWantToUseDataFilePassword.Select(3)
					[ ] ManageDataFilePassword.ExistingPassword.SetText(sPassword)
					[ ] ManageDataFilePassword.OK.Click()
					[ ] 
				[-] else
						[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
						[ ] 
					[ ] 
		[-] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
			[ ] 
	[ ] // Verify custom password
	[ ] CloseQuicken()
	[ ] LaunchQuicken()
	[-] if (EnterQuickenPassword.Exists(2))
		[ ] EnterQuickenPassword.SetActive()
		[ ] EnterQuickenPassword.Password.SetFocus()
		[ ] EnterQuickenPassword.Password.SetText(sPassword)
		[ ] EnterQuickenPassword.Password.OK.Click()
	[ ] sleep(10)
	[-] if(QuickenWindow.Exists(2))
		[ ] QuickenWindow.SetActive()
		[ ] sCaption = QuickenWindow.GetCaption ()
		[-] if(MatchStr("*{sOIPFileName}*",sCaption))
			[ ] ReportStatus("Verify that user can set custom file password",PASS,"User is able to set custom file password ")
		[-] else
			[ ] ReportStatus("Verify that user can set custom file password",FAIL,"User is not able to set custom file password as {sOIPFileName} data file is not opened")
			[ ] 
	[-] else
		[+] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window does not exist")
			[ ] 
[+] //############# Set Intuit ID as Data File Password ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_SetIntuitIDAsDataFilePasswordFromFileMenu ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user can set custom file password 
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		if Verify  user can set custom file password 					
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 14, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test05_SetIntuitIDAsDataFilePasswordFromFileMenu () appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] 
		[ ] sOIPFileName = "One Intuit Password No Password"
		[ ] 
	[-] CopyOIPDataFile(sOIPFileName)
		[ ] 
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] sleep(5)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(2)
		[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
		[-] if (ManageDataFilePassword.Exists(2))
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.UseMyIntuitIDPassword.Select(1)
			[ ] ManageDataFilePassword.IntuitIDPassword.SetFocus()
			[ ] ManageDataFilePassword.IntuitIDPassword.SetText(sPassword)
			[ ] ManageDataFilePassword.OK.Click()
			[ ] 
		[-] else
				[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
				[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
	[ ] // Verify custom password
	[ ] LaunchQuicken()
	[-] if (EnterQuickenPassword.Exists(2))
		[ ] EnterQuickenPassword.SetActive()
		[ ] EnterQuickenPassword.Password.SetFocus()
		[ ] EnterQuickenPassword.Password.SetText(sPassword)
		[ ] EnterQuickenPassword.Password.OK.Click()
		[ ] 
	[-] if(QuickenWindow.Exists(2))
		[ ] QuickenWindow.SetActive()
		[ ] sCaption = QuickenWindow.GetCaption ()
		[-] if(MatchStr("*{sOIPFileName}*",sCaption))
			[ ] ReportStatus("Verify that user can set Intuit ID as  file password",PASS,"User is able to set Intuit ID as file password ")
		[-] else
			[ ] ReportStatus("Verify that user can set ntuit ID as file password",FAIL,"User is not able to set Intuit ID as file password as {sOIPFileName} data file is not opened")
			[ ] 
	[-] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window does not exist")
		[ ] 
[+] //############# Set Custom Password as Data File Password for a file with Intuit ID as Password ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_SetCustomPasswordForIntuitIDFromFileMenu ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if user can set custom file password for a datafile which has Intuit ID as Data file Password	
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		if user can set custom file password for a datafile which has Intuit ID as Data file Password				
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 14, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test06_SetCustomPasswordForIntuitIDFromFileMenu () appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] STRING sCaption = ""
		[ ] sOIPFileName = "One Intuit Password"
		[ ] 
	[-] CopyOIPDataFile(sOIPFileName)
		[ ] 
	[ ] //-------Open data file------------
	[-] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] sleep(5)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(2)
		[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
		[-] if (ManageDataFilePassword.Exists(2))
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.UseMyCustomPassword.Select(2)
			[ ] ManageDataFilePassword.ExistingPassword.Click()
			[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
			[ ] ManageDataFilePassword.ExistingPassword.SetText(sPassword)
			[ ] ManageDataFilePassword.CreateNewPassword.SetFocus()
			[ ] ManageDataFilePassword.CreateNewPassword.SetText(sPassword)
			[ ] ManageDataFilePassword.ConfirmPassword.SetFocus()
			[ ] ManageDataFilePassword.ConfirmPassword.SetText(sPassword)
			[ ] ManageDataFilePassword.OK.Click()
			[ ] 
		[-] else
				[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
				[ ] 
		[ ] 
	[-] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
	[ ] 
	[ ] // Verify custom password
	[ ] LaunchQuicken()
	[-] if (EnterQuickenPassword.Exists(2))
		[ ] EnterQuickenPassword.SetActive()
		[ ] EnterQuickenPassword.Password.SetFocus()
		[ ] EnterQuickenPassword.Password.SetText(sPassword)
		[ ] EnterQuickenPassword.Password.OK.Click()
		[ ] 
		[-] if(QuickenWindow.Exists(2))
			[ ] QuickenWindow.SetActive()
			[ ] sCaption = QuickenWindow.GetCaption ()
			[-] if(MatchStr("*{sOIPFileName}*",sCaption))
				[ ] ReportStatus("Verify that user can set Intuit ID as  file password",PASS,"User is able to set Intuit ID as file password ")
			[-] else
				[ ] ReportStatus("Verify that user can set ntuit ID as file password",FAIL,"User is not able to set Intuit ID as file password as {sOIPFileName} data file is not opened")
				[ ] 
		[-] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window does not exist")
		[ ] 
	[-] else
		[ ] ReportStatus("Verify Enter Quicken Password window",FAIL,"Enter Quicken Password window doest not exist")
[+] //############# Set no data file password for Custom Password as Data File Password ############# 
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test07_CustomDataFilePasswordToNoPassword ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user can remove already set custom file password to no password
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		if user can remove already set custom file password to no password 					
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 14, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test07_CustomDataFilePasswordToNoPassword () appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] STRING sCaption = ""
		[ ] sOIPFileName = "One Intuit Password Custom Password"
		[ ] 
	[-] CopyOIPDataFile(sOIPFileName)
		[ ] 
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[-] if(iOpenDataFile==PASS)
			[ ] sleep(5)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
			[ ] sleep(2)
			[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
			[-] if (ManageDataFilePassword.Exists(2))
				[ ] ManageDataFilePassword.SetActive()
				[ ] ManageDataFilePassword.IDoNotWantToUseDataFilePassword.Select(3)
				[ ] ManageDataFilePassword.ExistingPassword.SetText(sPassword)
				[ ] ManageDataFilePassword.OK.Click()
				[ ] 
			[+] else
					[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
					[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
	[ ] // Verify custom password
	[ ] CloseQuicken()
	[ ] LaunchQuicken()
	[+] if(QuickenWindow.Exists(2))
		[ ] QuickenWindow.SetActive()
		[ ] sCaption = QuickenWindow.GetCaption ()
		[-] if(MatchStr("*{sOIPFileName}*",sCaption))
			[ ] ReportStatus("Verify that user can set custom file password",PASS,"User is able to set custom file password to no password")
		[-] else
			[ ] ReportStatus("Verify that user can set custom file password",FAIL,"User is not able to set custom file password as {sOIPFileName} data file is not opened")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window does not exist")
	[ ] 
[+] //############# Set Custom Password as Data File Password for a file with Intuit ID as Password ############# 
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test08_SetIntuitPasswordForCustomPasswordFromFileMenu ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if user can set Intuit file password for a data file which has Custom file Password	
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	if user can set Intuit ID as file password for a datafile which has Custom file Password exist			
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 20, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test08_SetIntuitPasswordForCustomPassword () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] STRING sCaption = ""
		[ ] sOIPFileName = "One Intuit Password Custom Password"
		[ ] 
	[-] CopyOIPDataFile(sOIPFileName)
		[ ] 
	[ ] //-------Open data file------------
	[-] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] sleep(5)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(2)
		[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
		[-] if (ManageDataFilePassword.Exists(1))
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.UseMyIntuitIDPassword.Select(1)
			[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
			[ ] ManageDataFilePassword.ExistingPassword.SetText(sPassword)
			[ ] ManageDataFilePassword.IntuitIDPassword.SetFocus()
			[ ] ManageDataFilePassword.IntuitIDPassword.SetText(sPassword)
			[ ] ManageDataFilePassword.OK.Click()
		[+] else
				[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
	[+] // Verify custom password
		[ ] LaunchQuicken()
		[+] if (EnterQuickenPassword.Exists(2))
			[ ] EnterQuickenPassword.SetActive()
			[ ] EnterQuickenPassword.Password.SetFocus()
			[ ] EnterQuickenPassword.Password.SetText(sPassword)
			[ ] EnterQuickenPassword.Password.OK.Click()
			[ ] 
			[-] if(QuickenWindow.Exists(2))
				[ ] QuickenWindow.SetActive()
				[ ] sCaption = QuickenWindow.GetCaption ()
				[-] if(MatchStr("*{sOIPFileName}*",sCaption))
					[ ] ReportStatus("Verify that user can set Intuit ID as  file password",PASS,"User is able to set Intuit ID as file password ")
				[-] else
					[ ] ReportStatus("Verify that user can set ntuit ID as file password",FAIL,"User is not able to set Intuit ID as file password as {sOIPFileName} data file is not opened")
					[ ] 
			[-] else
				[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window does not exist")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Enter Quicken Password window",FAIL,"Enter Quicken Password window doest not exist")
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# Change Custom Data File Password ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_UserCanChangeSetCustomFilePassword  ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user can Change custom file password 
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		if Verify  user can Change custom file password 					
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 19, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test09_UserCanChangeSetCustomFilePassword () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] sOIPFileName = "One Intuit Password Custom Password"
		[ ] STRING sNewPassWord = 'b654321a'
		[ ] 
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[+] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] sleep(5)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(2)
		[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
		[-] if (ManageDataFilePassword.Exists(2))
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.UseMyCustomPassword.Select(2)
			[ ] ManageDataFilePassword.Change.Click()
			[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
			[ ] ManageDataFilePassword.ExistingPassword.SetText(sPassword)
			[ ] ManageDataFilePassword.CreateNewPassword.SetFocus()
			[ ] ManageDataFilePassword.CreateNewPassword.SetText(sNewPassWord)
			[ ] ManageDataFilePassword.ConfirmPassword.SetFocus()
			[ ] ManageDataFilePassword.ConfirmPassword.SetText(sNewPassWord)
			[ ] ManageDataFilePassword.OK.Click()
			[ ] 
		[-] else
				[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
				[ ] 
		[ ] // Verify custom password
		[ ] LaunchQuicken()
		[+] if (EnterQuickenPassword.Exists(2))
			[ ] EnterQuickenPassword.SetActive()
			[ ] EnterQuickenPassword.Password.SetFocus()
			[ ] EnterQuickenPassword.Password.SetText(sNewPassWord)
			[ ] EnterQuickenPassword.Password.OK.Click()
			[ ] 
			[-] if(QuickenWindow.Exists(2))
				[ ] QuickenWindow.SetActive()
				[ ] sCaption = QuickenWindow.GetCaption ()
				[-] if(MatchStr("*{sOIPFileName}*",sCaption))
					[ ] ReportStatus("Verify that user can set custom file password",PASS,"User is able to change custom file password ")
				[+] else
					[ ] ReportStatus("Verify that user can set custom file password",FAIL,"User is not able to set custom file password as {sOIPFileName} data file is not opened")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window does not exist")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Enter Quicken Password window",FAIL,"Enter Quicken Password window doest not exist")
		[ ] // QuickenWindow.SetActive()
		[ ] // QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] // sleep(2)
		[+] // QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
			[-] // if (ManageDataFilePassword.Exists(2))
				[ ] // ManageDataFilePassword.SetActive()
				[ ] // ManageDataFilePassword.UseMyCustomPassword.Select(2)
				[ ] // ManageDataFilePassword.Change.Click()
				[ ] // ManageDataFilePassword.ExistingPassword.SetFocus()
				[ ] // ManageDataFilePassword.ExistingPassword.SetText(sNewPassWord)
				[ ] // ManageDataFilePassword.CreateNewPassword.SetFocus()
				[ ] // ManageDataFilePassword.CreateNewPassword.SetText(sPassword)
				[ ] // ManageDataFilePassword.ConfirmPassword.SetFocus()
				[ ] // ManageDataFilePassword.ConfirmPassword.SetText(sPassword)
				[ ] // ManageDataFilePassword.OK.Click()
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# Set Intuit Password as Data File Password for a Converted Data file with Custom ID as Password ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_SetIntuitPasswordForCustomPasswordForAConvertedDataFileWithCustomIDAsPassword () ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if user can set Intuit file password for a Conevrted data file which has Custom file Password	
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	if user can set Intuit file password for a Conevrted data file which has Custom file Password		
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 20, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test10_SetIntuitPasswordForCustomPasswordForAConvertedDataFileWithCustomIDAsPassword () appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] STRING sCaption = ""
		[ ] sOIPFileName = "QW2013 Data File and Vault Pasword"
		[ ] 
	[-] CopyOIPDataFile(sOIPFileName)
		[ ] 
	[ ] //-------Open data file------------
	[-] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFileTillRegistrationSuccessfull(sOIPFileName)
	[ ] sleep(5)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[-] if (QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists(10))
			[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseIntuitIDDataFilePasswordOption.Check()
			[ ]  QuickenWindow.Done.Click()
			[ ] sleep(5)
		[-] if(DlgConsolidatePassword.Exists(2))
			[ ] DlgConsolidatePassword.PasswordVaultOptions.Select(1)
			[ ] DlgConsolidatePassword.Password.SetFocus()
			[ ] DlgConsolidatePassword.Password.SetText("quicken")
			[ ] DlgConsolidatePassword.OKButton.Click()
			[ ] sleep(15)
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(15)
		[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
		[-] if (ManageDataFilePassword.Exists(1))
			[ ] ManageDataFilePassword.SetActive()
			[-] if(ManageDataFilePassword.UseMyIntuitIDPassword.iValue==1)
				[ ] print(ManageDataFilePassword.UseMyIntuitIDPassword.iValue)
				[ ] ManageDataFilePassword.Cancel.click()
				[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened and Intituit ID is set as File password")
			[-] else
				[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sOIPFileName} is Opened and Intituit ID is not set as File password")
		[+] else
				[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
	[ ] // Verify custom password
	[-] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# Cancel Button Functionality On Manage Data FilePassword Dialog ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_CancelButtonFunctionalityOnManageDataFilePasswordDlg  ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify thw functionlity of Cancel button on Manage Password Dialog
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	if on clicking the Cancel button on Manage Password Dialog 					
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 14, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test11_CancelButtonFunctionalityOnManageDataFilePasswordDlg () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] sOIPFileName = "One Intuit Password No Password"
		[ ] 
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] sleep(5)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(2)
		[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
		[+] if (ManageDataFilePassword.Exists(2))
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.Cancel.Click()
		[+] else
				[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
				[ ] 
		[+] if (ManageDataFilePassword.Exists(2))
			[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
		[+] else
				[ ] ReportStatus("Verify Manage Data file password Window", PASS, "Manage data file password Is closed on Clicking Cancel Button") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# Verify Default option for data file password on the 'Registration Successful' screen when upgrader converts earlier version data file having a custom data file password. ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_VerifyDefaultDataFileOptionForAConvertedDataFileWithCustomIDAsPassword () 
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Default option for data file password on the 'Registration Successful' screen is use existing Password when upgrader converts earlier version data file having a custom data file password.
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass if Default option for data file password on the 'Registration Successful' screen is use existing Password when upgrader converts earlier version data file having a custom data file password.	
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 20, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test12_VerifyDefaultDataFileOptionForAConvertedDataFileWithCustomIDAsPassword () appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] STRING sCaption = ""
		[ ] sOIPFileName = "QW2013 Data File and Vault Pasword"
		[ ] 
	[-] CopyOIPDataFile(sOIPFileName)
		[ ] 
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFileTillRegistrationSuccessfull(sOIPFileName)
	[ ] sleep(5)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[-] if (QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists(10))
			[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseExistingDataFilePasswordOption.State==1)
				[ ] ReportStatus("Validate Default Option ", PASS, "Data file -  {sOIPFileName} is Opened and Custom Data file is selected as default option")
			[ ] ReportStatus("Validate Default Option ", PASS, "Verified in the Data file -  {sOIPFileName} that Custom Data file is selected as default option")
			[ ]  QuickenWindow.Done.Click()
			[ ] sleep(5)
			[-] if(DlgConsolidatePassword.Exists(2))
				[-] if(DlgConsolidatePassword.Exists(2))
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that caption is : Consolidate your passwords?")
				[+] else
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that caption is not : Consolidate your passwords?")
				[-] if(DlgConsolidatePassword.CosolidatePassword.Exists(2))
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text CosolidatePassword exists.")
				[+] else
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text CosolidatePassword does not exists.")
				[-] if(DlgConsolidatePassword.YouCurrentlyRequire.Exists())
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text :You currently require two passwords when use Quicken: exists.")
				[+] else
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text : You currently require two passwords when use Quicken: does not exists.")
				[-] if(DlgConsolidatePassword.RequireForQuicken.Exists())
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text :Required for Quicken connected services and Quicken mobile app. exists.")
				[+] else
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text :Required for Quicken connected services and Quicken mobile app.does not exists.")
				[-] if(DlgConsolidatePassword.WouldYouLike.Exists())
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text : Would you like to use your Intuit password with your password vault? exists.")
				[+] else
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text :Would you like to use your Intuit password with your password vault? does not exists.")
				[-] if(DlgConsolidatePassword.WhatWouldChange.Exists(2))
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text : What Would Change exists.")
				[+] else
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text What Would Changedoes not exists.")
				[-] if(DlgConsolidatePassword.YouWouldEnter.Exists(2))
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text : You Would Enter exists.")
				[+] else
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text : You Would Enter does not exists.")
				[-] if(DlgConsolidatePassword.WhatWouldNo.Exists(2))
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text : What Would No exists.")
				[+] else
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text : What Would No does not exists.")
				[+] if(DlgConsolidatePassword.YourPasswordVault.Exists(2))
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text : Your Password Vault exists.")
				[-] else
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text : Your Password Vault does not exists.")
				[-] if(DlgConsolidatePassword.Help.Exists(2))
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that Help Button exists.")
				[+] else
					[ ] ReportStatus("Validate Cosolidate Password dialog ", PASS, "Verified in the Data file -  {sOIPFileName} that text Help Button  does not exists.")
				[ ] DlgConsolidatePassword.PasswordVaultOptions.Select(1)
				[ ] DlgConsolidatePassword.Password.SetFocus()
				[ ] DlgConsolidatePassword.Password.SetText("quicken")
				[ ] DlgConsolidatePassword.OKButton.Click()
				[ ] sleep(5)
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(5)
		[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
		[-] if (ManageDataFilePassword.Exists(1))
			[ ] ManageDataFilePassword.SetActive()
			[-] if(ManageDataFilePassword.UseMyCustomPassword.Change.Exists(2))
				[ ] print(ManageDataFilePassword.UseMyCustomPassword.iValue)
				[ ] ReportStatus("Validate Default Option ", PASS, "Verified in the Data file -  {sOIPFileName} that Custom Data file is selected as default option")
				[ ] ManageDataFilePassword.SetActive()
				[ ] ManageDataFilePassword.Cancel.Click()
			[+] else
				[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened and Intit ID as not set as File password")
		[+] else
				[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
	[ ] // Verify custom password
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# Forgot Password Links In managae Data File Password Dialog ############# 
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test13_SetIntuitIDAsDataFilePasswordFromFileMenu ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify  Forgot Password Links In managae Data File Password Dialog
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	if  Forgot Password Links in managae Data File Password Dialog	opens correctly				
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 14, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test13_ForgotPasswordLinksInManagaeDataFilePassword () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] 
		[ ] STRING sUrl = "Forgot Password"
		[ ] sOIPFileName = "One Intuit Password No Password"
		[ ] 
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[-] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] // 
		[ ] sleep(5)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(2)
		[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
		[+] if (ManageDataFilePassword.Exists(2))
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.UseMyIntuitIDPassword.Select(1)
			[ ] ManageDataFilePassword.IntuitIDPassword.SetFocus()
			[ ] ManageDataFilePassword.IntuitIDPassword.SetText(sPassword)
			[ ] ManageDataFilePassword.OK.Click()
			[ ] sleep(5)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
			[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
			[ ] sleep(2)
			[+] if (ManageDataFilePassword.Exists(2))
				[ ] ManageDataFilePassword.SetActive()
				[ ] ManageDataFilePassword.UseMyCustomPassword.Select(2)
				[ ] ManageDataFilePassword.IntuitForgotPassword.SetFocus()
				[ ] ManageDataFilePassword.IntuitForgotPassword.Click()
				[ ] sleep(30)
				[ ] InternetExplorer.SetActive()
				[ ] sleep(30)
				[+] if(InternetExplorer.GetCaption()== sUrl)
					[ ] ReportStatus("Verify Manage Data file password Window", PASS, "URL related to Intuit ID forgot password   is dispalayed in external browser") 
				[+] else
					[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "URL related to Intuit ID forgot password   is not  dispalayed in external browser") 
				[ ] sleep(5)
				[ ] InternetExplorer.Close()
				[ ] sleep(10)
				[ ] ManageDataFilePassword.SetActive()
				[ ] ManageDataFilePassword.IDoNotWantToUseDataFilePassword.Select(3)
				[ ] ManageDataFilePassword.IntuitForgotPassword.SetFocus()
				[ ] ManageDataFilePassword.IntuitForgotPassword.Click()
				[ ] sleep(30)
				[ ] InternetExplorer.SetActive()
				[ ] sleep(30)
				[-] if(InternetExplorer.GetCaption()== sUrl )
					[ ] ReportStatus("Verify Manage Data file password Window", PASS, "URL related to Intuit ID forgot password   is dispalayed in external browser") 
				[-] else
					[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "URL related to Intuit ID forgot password   is not  dispalayed in external browser") 
				[ ] Sleep(5)
				[ ] InternetExplorer.Close()
				[ ] QuickenWindow.SetActive()
				[ ] ManageDataFilePassword.Cancel.Click()
			[+] else
					[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
		[ ] sleep(2)
		[+] if (ManageDataFilePassword.Exists(2))
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.UseMyCustomPassword.Select(2)
			[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
			[ ] ManageDataFilePassword.ExistingPassword.SetText(sPassword)
			[ ] ManageDataFilePassword.CreateNewPassword.SetFocus()
			[ ] ManageDataFilePassword.CreateNewPassword.SetText(sPassword)
			[ ] ManageDataFilePassword.ConfirmPassword.SetFocus()
			[ ] ManageDataFilePassword.ConfirmPassword.SetText(sPassword)
			[ ] ManageDataFilePassword.OK.Click()
			[ ] sleep(5)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
			[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
			[ ] sleep(2)
			[-] if (ManageDataFilePassword.Exists(2))
				[ ] ManageDataFilePassword.SetActive()
				[ ] ManageDataFilePassword.IDoNotWantToUseDataFilePassword.Select(3)
				[ ] ManageDataFilePassword.ForgotPassword.SetFocus()
				[ ] ManageDataFilePassword.ForgotPassword.Click()
				[ ] sleep(5)
				[ ] QuickenHelp.SetActive()
				[-] if(QuickenHelp.BrowserWindow.TextExists("What if Quicken doesn't accept my password, asks for a password I didn't add, or gives me an invalid password message?")==TRUE)
					[ ] ReportStatus("Verify Manage Data file password Window", PASS, "Help topic related to Quicken doesn't accept my password is dispalayed") 
					[ ] print(QuickenHelp.BrowserWindow.TextExists("What if Quicken doesn't accept my password, asks for a password I didn't add, or gives me an invalid password message?"))
				[-] else
					[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Help topic related to Quicken doesn't accept my password is dispalayed") 
				[ ] QuickenHelp.Close()
				[ ] QuickenWindow.SetActive()
				[ ] ManageDataFilePassword.SetActive()
				[ ] ManageDataFilePassword.UseMyIntuitIDPassword.Select(1)
				[ ] ManageDataFilePassword.ForgotPassword.SetFocus()
				[ ] ManageDataFilePassword.ForgotPassword.Click()
				[ ] ManageDataFilePassword.IntuitForgotPassword.SetFocus()
				[ ] ManageDataFilePassword.IntuitForgotPassword.Click()
				[ ] sleep(30)
				[ ] InternetExplorer.SetActive()
				[ ] sleep(30)
				[-] if(InternetExplorer.GetCaption() == sUrl)
					[ ] ReportStatus("Verify Manage Data file password Window", PASS, "URL related to Intuit ID forgot password   is dispalayed in external browser") 
					[ ] print(InternetExplorer.GetCaption() )
				[-] else
					[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "URL related to Intuit ID forgot password   is not  dispalayed in external browser") 
				[ ] InternetExplorer.Close()
				[ ] ManageDataFilePassword.SetActive()
				[ ] ManageDataFilePassword.UseMyCustomPassword.Select(2)
				[ ] ManageDataFilePassword.Change.Click()
				[ ] ManageDataFilePassword.ForgotPassword.SetFocus()
				[ ] ManageDataFilePassword.ForgotPassword.Click()
				[ ] QuickenHelp.SetActive()
				[-] if(QuickenHelp.BrowserWindow.TextExists("What if Quicken doesn't accept my password, asks for a password I didn't add, or gives me an invalid password message?")==TRUE)
					[ ] ReportStatus("Verify Manage Data file password Window", PASS, "Help topic related to Quicken doesn't accept my password is dispalayed") 
				[-] else
					[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Help topic related to Quicken doesn't accept my password is dispalayed") 
				[ ] QuickenHelp.Close()
				[ ] QuickenWindow.SetActive()
				[ ] ManageDataFilePassword.Cancel.Click()
			[+] else
				[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
				[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
			[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
			[ ] sleep(2)
			[-] if (ManageDataFilePassword.Exists(2))
				[ ] ManageDataFilePassword.SetActive()
				[ ] ManageDataFilePassword.IDoNotWantToUseDataFilePassword.Select(3)
				[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
				[ ] ManageDataFilePassword.ExistingPassword.SetText(sPassword)
				[ ] ManageDataFilePassword.OK.Click()
			[-] else
					[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
		[ ] sleep(2)
		[-] if (ManageDataFilePassword.Exists(2))
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.UseMyIntuitIDPassword.Select(1)
			[ ] ManageDataFilePassword.ForgotPassword.SetFocus()
			[ ] ManageDataFilePassword.ForgotPassword.Click()
			[ ] sleep(5)
			[ ] QuickenHelp.SetActive()
			[-] if(QuickenHelp.BrowserWindow.TextExists("What if Quicken doesn't accept my password, asks for a password I didn't add, or gives me an invalid password message?")==TRUE)
				[ ] ReportStatus("Verify Manage Data file password Window", PASS, "Help topic related to Quicken doesn't accept my password is dispalayed") 
			[-] else
				[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Help topic related to Quicken doesn't accept my password is dispalayed") 
			[ ] QuickenHelp.Close()
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.SetActive()
			[ ] ManageDataFilePassword.Cancel.Click()
		[+] else
				[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
				[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# User can restore a Backed up file for which Intuit ID is set as File Password ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_RestoreABackedUpFileWithIntuitIDAsDataFilePassword ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if User can restore a Backed up file for which Intuit ID is set as File Password 
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	if User can restore a Backed up file for which Intuit ID is set as File Password 			
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Mar 2, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test14_RestoreABackedUpFileWithIntuitIDAsDataFilePassword () appstate none
	[ ] 
	[+] // //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iBackupFile
		[ ] INTEGER iRestoreFile
		[ ] sOIPFileName = "One Intuit Password"
		[ ] // 
	[+] CopyOIPDataFile(sOIPFileName)
		[ ] 
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[+] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] sleep(5)
		[ ] QuickenWindow.SetActive()
		[ ] iBackupFile = QuickenBackup(sBackupLocation, sOIPFileName)
		[+] if(iBackupFile==PASS)
				[ ] ReportStatus("Verify File BACKUP", PASS, "Data file -  {sOIPFileName} is backed up") 
		[+] else
				[ ] ReportStatus("Verify File BACKUP", FAIL, "Data file -  {sOIPFileName} is not backed up") 
		[ ] Sleep(5)
		[ ] QuickenWindow.SetActive()
		[ ] iRestoreFile = QuickenRestore(sRestoreLocation, sOIPFileName)
		[+] if(iRestoreFile==PASS)
				[ ] ReportStatus("Verify File BACKUP", PASS, "Data file -  {sOIPFileName}  is Restored") 
		[+] else
				[ ] ReportStatus("Verify File BACKUP", FAIL, "Data file -  {sOIPFileName} is not Restored") 
	[+]  else
		[-]  ReportStatus("Verify Open Data file" ,FAIL,"Data file -  {sOIPFileName} is not opened")
			[ ] 
[+] //############# Open a Data File Password for a file with Intuit ID as Password In Other m/c ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_OpenDataFileWith IntuitIDAsFilePasswordInOtherM/C ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if user can open a data file which has Intuit ID as Data file Password in other m/c	
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	if user can open a data file which has Intuit ID as Data file Password in other m/c					
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // March 3, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test15_OpenDataFileWithIntuitIDAsFilePasswordInOtherMc () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] STRING sCaption = ""
		[ ] sOIPFileName = "One Intuit Password"
		[ ] 
	[+] CopyOIPDataFile(sOIPFileName)
		[ ] 
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[+] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} with Intuit ID as File Password is Opened")
		[ ] sleep(5)
		[ ] QuickenWindow.SetActive()
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
	[ ] 
	[ ] // Verify Intuit password
	[ ] LaunchQuicken()
	[ ] QuickenWindow.SetActive()
	[+] if (EnterQuickenPassword.Exists(2))
		[ ] EnterQuickenPassword.SetActive()
		[ ] EnterQuickenPassword.Password.SetFocus()
		[ ] EnterQuickenPassword.Password.SetText(sPassword)
		[ ] EnterQuickenPassword.Password.OK.Click()
		[ ] 
		[+] if(QuickenWindow.Exists(2))
			[ ] QuickenWindow.SetActive()
			[ ] sCaption = QuickenWindow.GetCaption ()
			[+] if(MatchStr("*{sOIPFileName}*",sCaption))
				[ ] ReportStatus("Verify that user can open the file",PASS,"User is able to Open data file with Intuit ID as file password in other machine")
			[+] else
				[ ] ReportStatus("Verify that user can open the file",FAIL,"User is not able to Open the data file {sOIPFileName} with Intuit ID as setas file password in other machine")
				[ ] 
		[-] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window does not exist")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Enter Quicken Password window",FAIL,"Enter Quicken Password window doest not exist")
[+] // //############# Verify that Quicken is creating password vault in background for every new file ############# 
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test16_VerifyPasswordVaultCreationForNewFile ()
		[ ] // // 
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will create new OIP data file and verify if Password vault is created
		[ ] // // 
		[ ] // // PARAMETERS:	none
		[ ] // // 
		[ ] // // RETURNS:			Pass 		if data file is created without any errors and UI verification happens as expected					
		[ ] // // 						Fail		if any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // Feb 14, 2015		Created By Abhjit Sarma
	[ ] // // *********************************************************
[+] testcase Test16_VerifyPasswordVaultCreationForNewFile () appstate QuickenBaseState
	[ ] 
	[ ] //Variable Declaration
	[ ] INTEGER iCreateDataFile
	[ ] 
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] //-------Create data file------------
	[ ] iCreateDataFile = DataFileCreate(sOIPFileName)
	[-] if(iCreateDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is created")
		[ ] sleep(5)
		[ ] QuickenWindow.SetActive()
		[ ] sleep(10)
		[ ] QuickenWindow.MainMenu.Select("/_Tools/Password _Vault/Add or _Edit Passwords...")
		[-] if(EditPasswordVault.Exists(2))
			[ ] ReportStatus("Validate Vault Password Creation ", PASS, "Data file -  {sOIPFileName} is created and vault passwort set and Enter Password dialog exist")
		[-] else
			[ ] ReportStatus("Validate Vault Password Creation ", FAIL, "Data file -  {sOIPFileName} is created but vault passwort is not sett")
		[ ] EditPasswordVault.Cancel.Click()
		[ ] 
		[ ] sleep(5)
		[ ] QuickenWindow.MainMenu.Select("/_Tools/Password _Vault/Reset Vault")
		[-] if(ResetVault.Exists(2))
			[ ] ReportStatus("Validate Vault Password Creation ", PASS, "Data file -  {sOIPFileName} is created and vault passwort set and Enter Password dialog exist")
		[+] else
			[ ] ReportStatus("Validate Vault Password Creation ", FAIL, "Data file -  {sOIPFileName} is created but vault passwort is not sett")
		[ ] ResetVault.Cancel.Click()
		[ ] 
	[+]  else
		[ ] // ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} creation")
	[ ] 
[+] //############# Verify functionality of the 'Consolidate your password' - No option.. ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_VerifyFunctionalityOfConsolidateYourPasswordNoOption ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Default option for data file password on the 'Registration Successful' screen is use existing Password when upgrader converts earlier version data file having a custom data file password.
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass if  functionality of the 'Consolidate your password' - No option leads to Custom vault Password	
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Mar 2, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test17_VerifyFunctionalityOfConsolidateYourPasswordNoOption () appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] STRING sCaption = ""
		[ ] sOIPFileName = "QW2013 Data File and Vault Pasword" 
		[ ] 
	[+] CopyOIPDataFile(sOIPFileName)
		[ ] 
	[ ] //-------Open data file------------
	[-] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFileTillRegistrationSuccessfull(sOIPFileName)
	[ ] sleep(5)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[-] if (QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists(10))
			[+] // if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseExistingDataFilePasswordOption.State==1)
				[ ] // ReportStatus("Validate Default Option ", PASS, "Data file -  {sOIPFileName} is Opened and Custom Data file is selected as default option")
			[ ] // ReportStatus("Validate Default Option ", PASS, "Verified in the Data file -  {sOIPFileName} that Custom Data file is selected as default option")
			[ ] QuickenWindow.Done.Click()
			[ ] sleep(5)
			[-] if(DlgConsolidatePassword.Exists(2))
				[ ] DlgConsolidatePassword.ExistingVaultOptions.Select(2)
				[ ] // DlgConsolidatePassword.Password.SetFocus()
				[ ] // DlgConsolidatePassword.Password.SetText("quicken")
				[ ] DlgConsolidatePassword.OKButton.Click()
				[ ] sleep(5)
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(5)
		[ ] QuickenWindow.MainMenu.Select("/_Tools/Password _Vault/Add or _Edit Passwords...")
		[-] if(UnlockYourPasswordVault.Exists(2))
			[ ] UnlockYourPasswordVault.Password.SetFocus()
			[ ] UnlockYourPasswordVault.Password.SetText("quicken")
			[ ] UnlockYourPasswordVault.OK.Click()
			[+] if(EditPasswordVault.Exists(2))
				[ ] ReportStatus("Validate Vault Password ", PASS, "For Data file -  {sOIPFileName} Old custom vault password works fine")
				[-] EditPasswordVault.ManagePaswordVault.Click()
					[-] if (ManageVaultPassword.Exists(1))
						[ ] ManageVaultPassword.SetActive()
						[-] if(ManageVaultPassword.UseCustomPassword.iValue==2)
							[ ] print(ManageVaultPassword.UseMyIntuitIDPassword.iValue)
							[ ] ManageVaultPassword.Cancel.Click()
							[ ] ReportStatus("Validate Intuit ID password option ", PASS, "Data file -  {sOIPFileName} is Opened and Custom Paswword is set as Vault password")
						[-] else
							[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sOIPFileName} is Opened and ICustom Password is not set as Vault password")
					[-] else
							[ ] ReportStatus("Verify Manage Vault password Window", FAIL, "Manage vault password window is not found") 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Vault Password ", FAIL, "For Data file -  {sOIPFileName} Old custom vault password is not working")
		[ ] EditPasswordVault.Cancel.Click()
	[ ] // Verify custom password
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
		[ ] 
[+] //############# Verify Consolidate Password No Option functionality while converting an earlier version data file having a custom data file password. ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test18_ConsolidatePasswordNoOption ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Default option for data file password on the 'Registration Successful' screen is use existing Password when upgrader converts earlier version data file having a custom data file password.
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass if User should be able to open the password vault using old vault password.when upgrader converts earlier version data file having a custom data file password.	
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Mar, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test18_ConsolidatePasswordNoOption () appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] STRING sCaption = ""
		[ ] sOIPFileName = "QW2013 Data File Vault Password"  
		[ ] 
	[+] CopyOIPDataFile(sOIPFileName)
		[ ] 
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFileTillRegistrationSuccessfull(sOIPFileName)
	[ ] sleep(5)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] if (QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists(10))
			[ ] QuickenWindow.Done.Click()
			[ ] sleep(5)
			[+] if(DlgConsolidatePassword.Exists(2))
				[ ] DlgConsolidatePassword.ExistingVaultOptions.Select(2)
				[ ] DlgConsolidatePassword.OKButton.Click()
				[ ] sleep(5)
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(5)
		[ ] LaunchQuicken()
		[ ] EnterPassword()
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.MainMenu.Select("/_Tools/Password _Vault/Add or _Edit Passwords...")
		[-] if(UnlockYourPasswordVault.Exists(2))
			[ ] UnlockYourPasswordVault.Password.SetFocus()
			[ ] UnlockYourPasswordVault.Password.SetText("quicken")
			[ ] UnlockYourPasswordVault.Password.OK.Click()
			[-] if(EditPasswordVault.Exists(2))
				[ ] ReportStatus("Validate Vault Password ", PASS, "For Data file -  {sOIPFileName} Old custom vault password works fine")
				[-] EditPasswordVault.ManagePaswordVault.Click()
					[-] if (ManageVaultPassword.Exists(1))
						[ ] ManageVaultPassword.SetActive()
						[-] if(ManageVaultPassword.UseCustomPassword.iValue==2)
							[ ] print(ManageVaultPassword.UseMyIntuitIDPassword.iValue)
							[ ] ManageVaultPassword.Cancel.Click()
							[ ] ReportStatus("Validate Intuit ID password option ", PASS, "Data file -  {sOIPFileName} is Opened and Custom Paswword is set as Vault password")
						[-] else
							[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sOIPFileName} is Opened and ICustom Password is not set as Vault password")
					[-] else
							[ ] ReportStatus("Verify Manage Vault password Window", FAIL, "Manage vault password window is not found") 
				[ ] 
			[-] else
				[ ] ReportStatus("Validate Vault Password ", FAIL, "For Data file -  {sOIPFileName} Old custom vault password is not working")
		[ ] EditPasswordVault.Cancel.Click()
	[ ] // Verify custom password
	[-] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# Verify functionality of the 'Consolidate your password' - Yes option for Qw2013 data file with No Vault Password. ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test19_ConsolidatePasswordYesOption ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if user can set Intuit ID as file vault password for a Conevrted data file which has No vault file Password	
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	Use my Intuit ID is selected in Manage Vault Password dialog	
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 20, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test19_ConsolidatePasswordYesOption () appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] STRING sCaption = ""
		[ ] sOIPFileName = "QW2013 Data File With Data File Password"
		[ ] 
	[+] CopyOIPDataFile(sOIPFileName)
		[ ] 
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFileTillRegistrationSuccessfull(sOIPFileName)
	[ ] sleep(5)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[-] if (QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists(10))
			[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseIntuitIDDataFilePasswordOption.Check()
			[ ] QuickenWindow.Done.Click()
			[ ] sleep(5)
		[-] if(DlgConsolidatePassword.Exists(2))
			[ ] DlgConsolidatePassword.PasswordVaultOptions.Select(1)
			[ ] DlgConsolidatePassword.Password.SetFocus()
			[ ] DlgConsolidatePassword.Password.SetText("abcde")
			[-] if(WrongPasswordAlert.Exists(2))
				[ ] ReportStatus("Validate Consolidate Passwod ", PASS, "Data file -  {sOIPFileName} is Opened and Iwrond password is entered in consolidate password dialog")
				[ ] WrongPasswordAlert.OK.Click()
			[ ] DlgConsolidatePassword.Password.SetFocus()
			[ ] DlgConsolidatePassword.Password.SetText("quicken")
			[ ] DlgConsolidatePassword.OKButton.Click()
			[ ] sleep(5)
			[ ] LaunchQuicken()
			[ ] EnterPassword()
		[ ] sleep(5)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(2)
		[ ] QuickenWindow.MainMenu.Select("/_Tools/Password _Vault/Add or _Edit Passwords...")
		[-] if(UnlockYourPasswordVault.Exists(2))
			[ ] UnlockYourPasswordVault.Password.SetFocus()
			[ ] UnlockYourPasswordVault.Password.SetText("sPassword")
			[ ] UnlockYourPasswordVault.Password.OK.Click()
		[-] if(EditPasswordVault.Exists(2))
				[ ] ReportStatus("Validate Vault Password ", PASS, "For Data file -  {sOIPFileName} Intuit ID as vault password works fine")
			[ ] EditPasswordVault.ManagePaswordVault.Click()
			[ ] if (ManageVaultPassword.Exists(1))
			[ ] ManageVaultPassword.SetActive()
		[-] if(ManageVaultPassword.UseMyIntuitIDPassword.iValue==1)
				[ ] print(ManageVaultPassword.UseMyIntuitIDPassword.iValue)
				[ ] ManageVaultPassword.Cancel.Click()
				[ ] ReportStatus("Validate Intuit ID password option ", PASS, "Data file -  {sOIPFileName} is Opened and Intituit ID is set as Vault password")
		[-] else
				[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sOIPFileName} is Opened and Intituit ID is not set as Vault password")
		[ ] EditPasswordVault.Cancel.Click()
	[-] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# Verify functionality of the 'Consolidate your password' - Yes option for Qw2013 data file with Vault Password. ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test20_ConsolidatePasswordYesOptionWithExistingVaultPassword ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if user can set Intuit ID as vault password for a Conevrted data file which has Vault password	
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	Use my Intuit ID is selected in Manage Vault Password dialog	
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 20, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test20_ConsolidatePasswordYesOptionWithExistingVaultPassword () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] STRING sCaption = ""
		[ ] sOIPFileName = "QW2013 Data File Vault Password"  
		[ ] 
	[+] CopyOIPDataFile(sOIPFileName)
		[ ] 
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFileTillRegistrationSuccessfull(sOIPFileName)
	[ ] sleep(5)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[-] if (QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists(10))
			[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseIntuitIDDataFilePasswordOption.Check()
			[ ] QuickenWindow.Done.Click()
			[ ] sleep(5)
		[+] if(DlgConsolidatePassword.Exists(2))
			[ ] DlgConsolidatePassword.PasswordVaultOptions.Select(1)
			[ ] DlgConsolidatePassword.Password.SetFocus()
			[ ] DlgConsolidatePassword.Password.SetText("abcde")
			[ ] DlgConsolidatePassword.OKButton.Click()
			[+] if(WrongPasswordAlert.Exists(2))
				[ ] ReportStatus("Validate Consolidate Passwod ", PASS, "Data file -  {sOIPFileName} is Opened and Iwrond password is entered in consolidate password dialog")
				[ ] WrongPasswordAlert.OK.Click()
			[ ] DlgConsolidatePassword.Password.SetFocus()
			[ ] DlgConsolidatePassword.Password.SetText("quicken")
			[ ] DlgConsolidatePassword.OKButton.Click()
			[ ] sleep(5)
			[ ] CloseQuicken()
			[ ] LaunchQuicken()
			[ ] EnterPassword()
		[ ] sleep(15)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(15)
		[ ] QuickenWindow.MainMenu.Select("/_Tools/Password _Vault/Add or _Edit Passwords...")
		[-] if(UnlockYourPasswordVault.Exists(2))
			[ ] UnlockYourPasswordVault.Password.SetFocus()
			[ ] UnlockYourPasswordVault.Password.SetText(sPassword)
			[ ] UnlockYourPasswordVault.Password.OK.Click()
		[-] if(EditPasswordVault.Exists(2))
			[ ] ReportStatus("Validate Vault Password ", PASS, "For Data file -  {sOIPFileName} Intuit ID as vault password works fine")
			[ ] EditPasswordVault.ManagePaswordVault.Click()
			[+] if (ManageVaultPassword.Exists(1))
				[ ] ManageVaultPassword.SetActive()
				[+] if(ManageVaultPassword.UseMyIntuitIDPassword.iValue==1)
					[ ] print(ManageVaultPassword.UseMyIntuitIDPassword.iValue)
					[ ] ManageVaultPassword.Cancel.Click()
					[ ] ReportStatus("Validate Intuit ID password option ", PASS, "Data file -  {sOIPFileName} is Opened and Intituit ID is set as Vault password")
				[+] else
						[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sOIPFileName} is Opened and Intituit ID is not set as Vault password")
			[+] else
						[-] ReportStatus("Verify Manage Vault password Window", FAIL, "Manage vault password window is not found") 
							[ ] 
		[+] else
				[ ] ReportStatus("Validate Vault Password ", FAIL, "For Data file -  {sOIPFileName}  Intuit ID as vault password is not working")
		[ ] EditPasswordVault.Cancel.Click()
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# Verify if  user is able to open data file for which Intuit ID is set as a data file password and user  changes Intuit ID's password using Quicken reset Intuit ID password dialog ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_ChangeINtuitIDPasswordFromresetIntuitIDDlg  ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if  user is able to open data file for which Intuit ID is set as a data file password and user  changes Intuit ID's password using Quicken reset Intuit ID password dialog.
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		if user can remove already set Intuit file password to no password 					
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Mar 14, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test21_ChangeINtuitIDPasswordFromresetIntuitIDDlg () appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] STRING sNewPassword = 'b123456a'
		[ ] // 
		[ ] sOIPFileName = "QW2013 Data File With Data File Password"
		[ ] // 
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[-] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] EnterPassword()
	[-] iOpenDataFile = OpenDataFile(sOIPFileName)
		[-] if(iOpenDataFile==PASS)
				[ ] sleep(5)
				[ ] QuickenWindow.SetActive()
				[ ] ChangeIntuitPasswordFromPreferences(sPassword, sNewPassword)
				[ ] CloseQuicken()
				[ ] LaunchQuicken()
			[-] if (EnterQuickenPassword.Exists(2))
				[ ] EnterQuickenPassword.SetActive()
				[ ] EnterQuickenPassword.Password.SetFocus()
				[ ] EnterQuickenPassword.Password.SetText(sPassword)
				[ ] EnterQuickenPassword.Password.OK.Click()
				[ ] ReportStatus("Verify Change Intuit Password option ", PASS, "Data File could be opened with Changed Intuit ID") 
				[ ] ChangeIntuitPasswordFromPreferences(sNewPassword, sPassword)
			[-] else
				[ ] ReportStatus("Verify Change Intuit Password option", FAIL, "Data File could not be opened with Changed Intuit ID") 
		[-] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# Change IntuitiD Password from reset Password Dialog ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test22_UserChangesIntuitIDPasswordUsingResetDialog  ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user can change Intuit ID password usin Reset dialog
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		if user user can change Intuit ID password usin Reset dialog 					
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // April 14, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test22_UserChangesIntuitIDPasswordUsingResetDialog () appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] STRING sNewPassword = 'b123456a'
		[ ] sOIPFileName = "One Intuit Password File and Vault Password"
		[ ] 
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[-] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] EnterPassword()
	[-] iOpenDataFile = OpenDataFile(sOIPFileName)
		[-] if(iOpenDataFile==PASS)
			[ ] sleep(5)
			[ ] QuickenWindow.SetActive()
			[ ] sleep(2)
			[ ] // open OSU
			[ ] QuickenMainWindow.QWNavigator.Update_Accounts.Click()
			[ ] //enter Password
			[+] if(UnlockYourPasswordVault.Exists(2))
				[ ] UnlockYourPasswordVault.Password.SetFocus()
				[ ] UnlockYourPasswordVault.Password.SetText(sPassword)
				[ ] UnlockYourPasswordVault.Password.OK.Click()
			[ ] OneStepUpdate.Cancel.Click()
			[ ] //Edit prference and change Intuit Password
			[ ] QuickenWindow.SetActive()
			[ ] ChangeIntuitPasswordFromPreferences(sPassword, sNewPassword)
			[ ] CloseQuicken()
			[ ] LaunchQuicken()
			[-] if (EnterQuickenPassword.Exists(2))
				[ ] EnterQuickenPassword.SetActive()
				[ ] EnterQuickenPassword.Password.SetFocus()
				[ ] EnterQuickenPassword.Password.SetText(sNewPassword)
				[ ] EnterQuickenPassword.Password.OK.Click()
				[ ] ReportStatus("Verify Change Intuit Password option ", PASS, "Data File could be opened with Changed Intuit ID") 
				[-] QuickenMainWindow.QWNavigator.Update_Accounts.Click()
					[-] if(UnlockYourPasswordVault.Exists(2))
						[ ] UnlockYourPasswordVault.Password.SetFocus()
						[ ] UnlockYourPasswordVault.Password.SetText(sNewPassword)
						[ ] UnlockYourPasswordVault.Password.OK.Click()
						[ ] OneStepUpdate.Cancel.Click()
						[ ] ReportStatus("Verify Change Intuit Password option ", PASS, "Password Vault could be opened with Changed Intuit ID") 
					[+] else
						[ ] ReportStatus("Verify Change Intuit Password option ", FAIL, "Password Vault could not be opened with Changed Intuit ID") 
			[ ] ChangeIntuitPasswordFromPreferences(sNewPassword, sPassword)
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
		[ ] 
	[ ] CloseQuicken()
	[ ] 
[+] //############# Sign In As A Different User ############# 
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test23_SignInAsAdifferentUser  ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user can Sign In As A Different User
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		if user user can Sign In As A Different User				
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // April 14, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test23_SignInAsAdifferentUser () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] sOIPFileName = "One Intuit Password File and Vault Password"
		[ ] 
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] EnterPassword()
	[-] iOpenDataFile = OpenDataFile(sOIPFileName)
		[-] if(iOpenDataFile==PASS)
			[ ] sleep(5)
			[ ] QuickenWindow.SetActive()
			[ ] sleep(2)
			[ ] SelectPreferenceType(sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE)
			[ ] Preferences.SignInAsADifferentUser.Click()
			[-] if(DlgSignInAsADifferentUser.Exists(2))
				[ ] DlgSignInAsADifferentUser.SignOutTextField.SetFocus()
				[ ] DlgSignInAsADifferentUser.SignOutTextField.SetText("yes")
				[ ] DlgSignInAsADifferentUser.SignOutButton.Click()
				[ ] 
				[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists(10))
					[ ] ReportStatus("Verify Signin With Other Intuit ID ", PASS, "Signout complete with old Intuit ID") 
					[ ] SignInQuickenConnectedServices()
					[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Exists())
						[ ] ReportStatus("Verify Signin With Other Intuit ID ", PASS, "SignIn complete with New Intuit ID") 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
		[ ] 
	[ ] CloseQuicken()
[+] //############# Sign In As A Different User ############# 
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test24_SignInAsAdifferentUserUnlockVault  ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user can Sign In As A Different User andable to unlock vault
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		if user user can Sign In As A Different User andable to unlock vault				
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // May, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test24_SignInAsAdifferentUserUnlockVault () appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] sOIPFileName = "One Intuit Password File and Vault Password"
		[ ] 
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] EnterPassword()
	[+] iOpenDataFile = OpenDataFile(sOIPFileName)
		[+] if(iOpenDataFile==PASS)
			[ ] sleep(5)
			[ ] QuickenWindow.SetActive()
			[ ] sleep(2)
			[ ] SelectPreferenceType(sINTUIT_ID_MOBILE_ALERT_PREFERENCE_TYPE)
			[ ] Preferences.SignInAsADifferentUser.Click()
			[+] if(DlgSignInAsADifferentUser.Exists(2))
				[ ] DlgSignInAsADifferentUser.SignOutTextField.SetFocus()
				[ ] DlgSignInAsADifferentUser.SignOutTextField.SetText("yes")
				[ ] DlgSignInAsADifferentUser.SignOutButton.Click()
				[ ] 
				[+] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists(10))
					[ ] ReportStatus("Verify Signin With Other Intuit ID ", PASS, "Signout complete with old Intuit ID") 
					[ ] SignInQuickenConnectedServices()
					[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Exists())
						[ ] ReportStatus("Verify Signin With Other Intuit ID ", PASS, "SignIn complete with New Intuit ID") 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
		[ ] 
	[ ] CloseQuicken()
	[ ] LaunchQuicken()
	[ ] QuickenWindow.SetActive()
	[ ] EnterPassword()
	[-] sleep(10)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(2)
		[ ] QuickenWindow.MainMenu.Select("/_Tools/Password _Vault/Add or _Edit Passwords...")
		[-] if(UnlockYourPasswordVault.Exists(2))
			[ ] UnlockYourPasswordVault.Password.SetFocus()
			[ ] UnlockYourPasswordVault.Password.SetText(sPassword)
			[ ] UnlockYourPasswordVault.Password.OK.Click()
		[-] if(EditPasswordVault.Exists(2))
			[ ] ReportStatus("Validate Vault Password ", PASS, "For Data file -  {sOIPFileName} Intuit ID as vault password works fine")
			[ ] EditPasswordVault.Cancel.Click()
			[ ] 
		[-] else
			[ ] ReportStatus("Verify Change Intuit ID ", PASS, "Password Vault could not be opened with Changed Intuit ID") 
			[ ] 
			[ ]  
	[ ] CloseQuicken()
[+] //############# Help Button Functionality On Manage Data FilePassword Dialog ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test25_HelpButtonFunctionalityOnManageDataFilePasswordDlg ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify thw functionlity of Help button on Manage Password Dialog
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	if on clicking the Help button on Manage Password Dialog 					
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // May, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test25_HelpButtonFunctionalityOnManageDataFilePasswordDlg () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] sOIPFileName = "One Intuit Password No Password"
		[ ] 
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] sleep(5)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(2)
		[ ] QuickenWindow.MainMenu.Select("/_File/Set Password for this _data file...*")
		[-] if (ManageDataFilePassword.Exists(2))
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.Help.Click()
			[ ] QuickenHelp.SetActive()
			[-] if(QuickenHelp.BrowserWindow.TextExists("Add, change, or remove a Quicken data file password")==TRUE)
				[ ] ReportStatus("Verify Manage Data file password Window", PASS, "Help topic related manage dat file  password is dispalayed") 
			[-] else
				[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Help topic related manage dat file  password is not dispalayed") 
			[ ] QuickenHelp.Close()
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.SetActive()
			[ ] ManageDataFilePassword.Cancel.Click()
		[+] else
				[ ] ReportStatus("Verify Manage Data file password Window", PASS, "Manage data file password Is closed on Clicking Cancel Button") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# Open Manage Data FilePassword Dialog with Short cut Key ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test25_HelpButtonFunctionalityOnManageDataFilePasswordDlg ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify thw functionlity of Help button on Manage Password Dialog
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	if on clicking the Help button on Manage Password Dialog 					
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // April14, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test26_LaunchManageDataFilePasswordDlgwithKeys () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] sOIPFileName = "One Intuit Password No Password"
		[ ] 
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] sleep(5)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F,5)
		[ ] QuickenWindow.File.TypeKeys(KEY_D)
		[-] if (ManageDataFilePassword.Exists(2))
				[ ] ReportStatus("Verify Manage Data file password Window", PASS, "Manage data File Password dialog opens by Pressing ALT+F and then D Keys") 
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.Cancel.Click()
		[-] else
				[ ] ReportStatus("Verify Manage Data file password Window", PASS, "Manage data File Password dialog is not opened by Pressing ALT+F and then D Keys") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
	[ ] 
[+] // //############# Verify Registration Successfull UI and Default option for data file password on the Registration Successfull UI  ############# 
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test27_VerifyRegistrationSuccessfullUIForUpgrader ()
		[ ] // // 
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will create new OIP data fileand verify UI of RegistrationSuccessfull screen
		[ ] // // 
		[ ] // // PARAMETERS:	none
		[ ] // // 
		[ ] // // RETURNS:			Pass 		if data file is created without any errors and UI verification happens as expected					
		[ ] // // 						Fail		if any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // May, 2015		Created By Abhjit Sarma
	[ ] // // *********************************************************
[+] testcase Test27_VerifyRegistrationSuccessfullUIForUpgrader () appstate QuickenBaseState
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] STRING sOIPFileName = "QW2013 Data File With Data File Password"
	[ ] 
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] 
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] EnterPassword()
	[ ] //-------Open data file------------
	[ ] iOpenDataFile = OpenDataFileTillRegistrationSuccessfull(sOIPFileName)
	[ ] Sleep(5)
	[+] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is opened")
		[ ] 
		[ ] sleep(5)
		[ ] //Registration Successfull screen element verification
		[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.RegistrationStatus.Exists(10))
			[ ] ReportStatus("Validate Data File ", PASS, "Registartion successfull for the data file  {sOIPFile} ")
		[-] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Registartion not successfull for the data file  {sOIPFile} ")
			[ ] 
		[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseExistingDataFilePasswordOption.Exists(10))
			[ ] ReportStatus("Validate Data File ", PASS, "UseExistingDataFilePasswordOption exist in the data file  {sOIPFile} ")
		[-] else
			[ ] ReportStatus("Validate Data File ", FAIL, "UseExistingDataFilePasswordOption doesn't exist  n the datafile  {sOIPFile} ")
		[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseExistingDataFilePasswordOption.Exists(10))
			[ ] ReportStatus("Validate Data File ", PASS, "UseIntuitIDDataFilePasswordOption exist in the data file  {sOIPFile} ")
		[-] else
			[ ] ReportStatus("Validate Data File ", FAIL, "UseIntuitIDDataFilePasswordOption doesn't exist  in the datafile  {sOIPFile} ")
			[ ] 
			[ ] 
			[ ] 
		[-] if(QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseExistingDataFilePasswordOption.State==1)
			[ ] ReportStatus("Validate Data File ", PASS, "UseExistingDataFilePasswordOption is selected by default in the data file  {sOIPFile} ")
		[-] else
			[ ] ReportStatus("Validate Data File ", FAIL, "UseExistingDataFilePasswordOption is not selected by default in the datafile  {sOIPFile} ")
		[-] if (QuickenIAMMainWindow.IAMUserControl.IAMContentControl.Exists(10))
			[ ] QuickenIAMMainWindow.IAMUserControl.IAMContentControl.UseIntuitIDDataFilePasswordOption.Check()
			[ ]  QuickenWindow.Done.Click()
		[ ] 
		[ ] 
		[ ] // // Verification to be done for other elements 
		[-] // if(AddAccount.Exists(5))   // Comment this block of code to leave Quicken in registartion Successfull screen
			[ ] // AddAccount.SetActive()
			[ ] // AddAccount.Close()
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} file opening")
[+] //############# Close Manage Data FilePassword Dialog with Esc Keyand X Button ############# 
	[ ] // ********************************************************
	[-] // TestCase Name: Test28_CloseManageDataFilePasswordDlgwithKeysand XButton
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify thw functionlity of Help button on Manage Password Dialog
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	if on clicking the Help button on Manage Password Dialog 					
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // May 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test28_CloseManageDataFilePasswordDlgwithKeysAndXButton () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] INTEGER iAddAccount
		[ ] sOIPFileName = "One Intuit Password No Password"
		[ ] INTEGER iXpos=491
		[ ] INTEGER iYpos=10
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[+] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] sleep(5)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(2)
		[ ] QuickenWindow.File.TypeKeys(KEY_D)
		[-] if (ManageDataFilePassword.Exists(2))
			[ ] ManageDataFilePassword.TypeKeys(KEY_ESCAPE)
			[-] if (!ManageDataFilePassword.Exists(2))
				[ ] ReportStatus("Verify Manage Data file password Window", PASS, "Manage data File Password dialog is closed by ESC Keys") 
			[-] else
				[ ] ReportStatus("Verify Manage Data file password Window", PASS, "Manage data File Password dialog is not closed by ESC Keys") 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(2)
		[ ] QuickenWindow.File.TypeKeys(KEY_D)
		[-] if (ManageDataFilePassword.Exists(2))
			[ ] ManageDataFilePassword.Click(1,iXpos,iYpos)
			[-] if (!ManageDataFilePassword.Exists(2))
				[ ] ReportStatus("Verify Manage Data file password Window", PASS, "Manage data File Password dialog is closed by X button") 
			[-] else
				[ ] ReportStatus("Verify Manage Data file password Window", PASS, "Manage data File Password dialog is not closed by X button") 
		[ ] 
	[+] else
		[ ] // ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# Manage Data Fille Password Validation With Intuit ID As File Password ############# 
	[ ] // ********************************************************
	[+] // TestCase Name: Test29_ManageDataFillePasswordValidationWithIntuitIDAsFilePAssword
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if correct validation are set for Manage Password Dialog
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	In case validation are not correct		
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // May, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test29_ManageDataFillePasswordValidationWithIntuitIDAsFilePassword () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] sOIPFileName = "One Intuit Password"
		[ ] STRING sWrongPassword = "abcd"
		[ ] STRING sBlankPassword = ""
		[ ] STRING sTemp = ""
		[ ] BOOLEAN bMatch
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[ ] iOpenDataFile = OpenDataFile(sOIPFileName)
	[-] if(iOpenDataFile==PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
		[ ] 
		[ ] sleep(5)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
		[ ] sleep(2)
		[ ] QuickenWindow.File.TypeKeys(KEY_D)
		[-] if (ManageDataFilePassword.Exists(2))
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.UseMyCustomPassword.Select(2)
			[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
			[ ] ManageDataFilePassword.ExistingPassword.SetText(sWrongPassword )
			[ ] ManageDataFilePassword.CreateNewPassword.SetFocus()
			[ ] ManageDataFilePassword.CreateNewPassword.SetText(sWrongPassword )
			[ ] ManageDataFilePassword.ConfirmPassword.SetFocus()
			[ ] ManageDataFilePassword.ConfirmPassword.SetText(sWrongPassword )
			[ ] ManageDataFilePassword.OK.Click()
			[-] if(OperationFailed.Exists())
				[ ] sTemp = OperationFailed.WrongPassword.Gettext()
				[-] if(sTemp == "The operation failed. Please check that the Intuit ID password is correct and you are connected to internet.")
					[ ] ReportStatus("Verify Manage Data file password Window Validation", PASS, "Manage data file password window displays proper message if wrong password is entered") 
					[ ] sTemp = ""
				[-] else
					[ ] ReportStatus("Verify Manage Data file password Window Validation", FAIL, "Manage data file password window donot displays proper message if wrong password is entered") 
				[ ] OperationFailed.OK.Click()
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.UseMyCustomPassword.Select(2)
			[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
			[ ] ManageDataFilePassword.ExistingPassword.SetText(sBlankPassword )
			[ ] ManageDataFilePassword.CreateNewPassword.SetFocus()
			[ ] ManageDataFilePassword.CreateNewPassword.SetText(sBlankPassword )
			[ ] ManageDataFilePassword.ConfirmPassword.SetFocus()
			[ ] ManageDataFilePassword.ConfirmPassword.SetText(sBlankPassword)
			[ ] ManageDataFilePassword.OK.Click()
			[-] if(OperationFailed.Exists())
				[ ] sTemp = OperationFailed.WrongPassword.Gettext()
				[-] if(sTemp == "Quicken cannot use a blank password.")
					[ ] ReportStatus("Verify Manage Data file password Window Validation", PASS, "Manage data file password window displays proper message if Blank password is entered") 
				[-] else
					[ ] ReportStatus("Verify Manage Data file password Window Validation", FAIL, "Manage data file password window donot displays proper message if Blank password is entered") 
				[ ] OperationFailed.OK.Click()
				[ ] sTemp = ""
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.UseMyCustomPassword.Select(2)
			[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
			[ ] ManageDataFilePassword.ExistingPassword.SetText(sPassword )
			[ ] ManageDataFilePassword.CreateNewPassword.SetFocus()
			[ ] ManageDataFilePassword.CreateNewPassword.SetText(sWrongPassword )
			[ ] ManageDataFilePassword.ConfirmPassword.SetFocus()
			[ ] ManageDataFilePassword.ConfirmPassword.SetText("abcde")
			[ ] ManageDataFilePassword.OK.Click()
			[-] if(OperationFailed.Exists())
				[ ] sTemp = OperationFailed.WrongPassword.Gettext()
				[ ] bMatch = MatchStr ("*Quicken was not able to use the password that you entered*", sTemp)
				[-] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Manage Data file password Window Validation", PASS, "Manage data file password window displays proper message if new password and confirm password are different") 
				[-] else
					[ ] ReportStatus("Verify Manage Data file password Window Validation", FAIL, "Manage data file password window donot displays proper message f new password and confirm password are different") 
				[ ] OperationFailed.OK.Click()
				[ ] sTemp = ""
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.UseMyCustomPassword.Select(2)
			[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
			[ ] ManageDataFilePassword.ExistingPassword.SetText(sWrongPassword )
			[ ] ManageDataFilePassword.CreateNewPassword.SetFocus()
			[ ] ManageDataFilePassword.CreateNewPassword.SetText(sWrongPassword )
			[ ] ManageDataFilePassword.ConfirmPassword.SetFocus()
			[ ] ManageDataFilePassword.ConfirmPassword.SetText("abcde")
			[ ] ManageDataFilePassword.OK.Click()
			[-] if(OperationFailed.Exists())
				[ ] sTemp = OperationFailed.WrongPassword.Gettext()
				[ ] bMatch = MatchStr ("*Quicken was not able to use the password that you entered*", sTemp)
				[-] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Manage Data file password Window Validation", PASS, "Manage data file password window displays proper message if new password and confirm password are different") 
				[-] else
					[ ] ReportStatus("Verify Manage Data file password Window Validation", FAIL, "Manage data file password window donot displays proper message f new password and confirm password are different") 
				[ ] OperationFailed.OK.Click()
				[ ] sTemp = ""
			[ ] ManageDataFilePassword.SetActive()
			[ ] ManageDataFilePassword.IDoNotWantToUseDataFilePassword.Select(3)
			[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
			[ ] ManageDataFilePassword.ExistingPassword.SetText(sWrongPassword )
			[ ] ManageDataFilePassword.OK.Click()
			[-] if(OperationFailed.Exists())
				[ ] sTemp = OperationFailed.WrongPassword.Gettext()
				[-] if(sTemp == "The operation failed. Please check that the Intuit ID password is correct and you are connected to internet." )
					[ ] ReportStatus("Verify Manage Data file password Window Validation", PASS, "Manage data file password window displays proper message if wrong Intuit password is entered") 
				[-] else
					[ ] ReportStatus("Verify Manage Data file password Window Validation", FAIL, "Manage data file password window donot displays proper message if wrong Intuit password is entered") 
				[ ] OperationFailed.OK.Click()
				[ ] ManageDataFilePassword.Cancel.Click()
				[ ] 
		[-] else
				[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
		[ ] 
	[-] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# Manage Data Fille Password Validation With Custom password  As File Password ############# 
	[ ] // ********************************************************
	[-] // TestCase Name: Test30_ManageDataFillePasswordValidationWithCustomFilePassword ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if correct validation are set for Manage Password Dialog
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	In case validation are not correct		
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // May, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
[+] testcase Test30_ManageDataFillePasswordValidationWithCustomFilePassword () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] sOIPFileName = "One Intuit Password Custom Password"
		[ ] STRING sWrongPassword = "abcd"
		[ ] STRING sTemp = ""
		[ ] 
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[-] iOpenDataFile = OpenDataFile(sOIPFileName)
		[-] if(iOpenDataFile==PASS)
			[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
			[ ] 
			[ ] sleep(5)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
			[ ] sleep(2)
			[-] QuickenWindow.File.TypeKeys(KEY_D)
				[-] if (ManageDataFilePassword.Exists(2))
					[ ] ManageDataFilePassword.SetActive()
					[ ] ManageDataFilePassword.UseMyIntuitIDPassword.Select(1)
					[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
					[ ] ManageDataFilePassword.ExistingPassword.SetText(sWrongPassword )
					[ ] ManageDataFilePassword.IntuitIDPassword.SetFocus()
					[ ] ManageDataFilePassword.IntuitIDPassword.SetText(sPassword )
					[ ] ManageDataFilePassword.OK.Click()
					[-] if(ChangePassword.Exists())
						[ ] sTemp = ChangePassword.OldPassword.Gettext()
						[-] if(sTemp == "Old Password is not correct.")
							[ ] ReportStatus("Verify Manage Data file password Window Validation", PASS, "Manage data file password window displays proper message if wrong custom password is entered") 
							[ ] sTemp = ""
						[-] else
							[ ] ReportStatus("Verify Manage Data file password Window Validation", FAIL, "Manage data file password window donot displays proper message if wrong custom password is entered") 
						[ ] ChangePassword.OK.Click()
					[ ] ManageDataFilePassword.SetActive()
					[ ] ManageDataFilePassword.UseMyIntuitIDPassword.Select(1)
					[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
					[ ] ManageDataFilePassword.ExistingPassword.SetText(sPassword )
					[ ] ManageDataFilePassword.IntuitIDPassword.SetFocus()
					[ ] ManageDataFilePassword.IntuitIDPassword.SetText(sWrongPassword )
					[ ] ManageDataFilePassword.OK.Click()
					[-] if(OperationFailed.Exists())
						[ ] sTemp = OperationFailed.WrongPassword.Gettext()
						[-] if(sTemp == "The operation failed. Please check that the Intuit ID password is correct and you are connected to internet." )
								[ ] ReportStatus("Verify Manage Data file password Window Validation", PASS, "Manage data file password window displays proper message if wrong Intuit password is entered") 
						[-] else
								[ ] ReportStatus("Verify Manage Data file password Window Validation", FAIL, "Manage data file password window donot displays proper message if wrong Intuit password is entered") 
					[ ] OperationFailed.OK.Click()
					[ ] sTemp = ""
					[ ] ManageDataFilePassword.SetActive()
					[ ] ManageDataFilePassword.UseMyIntuitIDPassword.Select(1)
					[ ] ManageDataFilePassword.ExistingPassword.SetFocus()
					[ ] ManageDataFilePassword.ExistingPassword.SetText(sWrongPassword )
					[ ] ManageDataFilePassword.IntuitIDPassword.SetFocus()
					[ ] ManageDataFilePassword.IntuitIDPassword.SetText(sWrongPassword )
					[ ] ManageDataFilePassword.OK.Click()
					[-] if(OperationFailed.Exists())
						[ ] sTemp = OperationFailed.WrongPassword.Gettext()
						[-] if(sTemp == "The operation failed. Please check that the Intuit ID password is correct and you are connected to internet." )
								[ ] ReportStatus("Verify Manage Data file password Window Validation", PASS, "Manage data file password window displays proper message if wrong Intuit password and wrong custom password is entered") 
						[-] else
								[ ] ReportStatus("Verify Manage Data file password Window Validation", FAIL, "Manage data file password window donot displays proper message if wrong Intuit password is entered") 
					[ ] OperationFailed.OK.Click()
					[ ] ManageDataFilePassword.Cancel.Click()
				[-] else
						[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
		[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
[+] //############# Manage Data Fille Password Validation With No Data File Password ############# 
	[ ] // ********************************************************
	[+] // TestCase Name: Test31_ManageDataFillePasswordValidationWithNoFilePassword () ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if correct validation are set for Manage Password Dialog
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	In case validation are not correct		
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // May, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
	[ ] 
[+] testcase Test31_ManageDataFillePasswordValidationWithNoFilePassword () appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] sOIPFileName = "One Intuit Password"
		[ ] STRING sWrongPassword = "abcd"
		[ ] STRING sBlankPassword = ""
		[ ] STRING sTemp = ""
		[ ] BOOLEAN bMatch
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[-] iOpenDataFile = OpenDataFile(sOIPFileName)
		[-] if(iOpenDataFile==PASS)
			[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
			[ ] 
			[ ] sleep(5)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_ALT_F)
			[ ] sleep(2)
			[-] QuickenWindow.File.TypeKeys(KEY_D)
				[-] if (ManageDataFilePassword.Exists(2))
					[ ] ManageDataFilePassword.SetActive()
					[ ] ManageDataFilePassword.UseMyIntuitIDPassword.Select(1)
					[ ] ManageDataFilePassword.IntuitIDPassword.SetFocus()
					[ ] ManageDataFilePassword.IntuitIDPassword.SetText(sWrongPassword )
					[-] ManageDataFilePassword.OK.Click()
						[-] if(OperationFailed.Exists())
							[ ] sTemp = OperationFailed.WrongPassword.Gettext()
							[-] if(sTemp == "The operation failed. Please check that the Intuit ID password is correct and you are connected to internet.")
								[ ] ReportStatus("Verify Manage Data file password Window Validation", PASS, "Manage data file password window displays proper message if wrong password is entered") 
								[ ] sTemp = ""
							[-] else
								[ ] ReportStatus("Verify Manage Data file password Window Validation", FAIL, "Manage data file password window donot displays proper message if wrong password is entered") 
					[ ] OperationFailed.OK.Click()
					[ ] ManageDataFilePassword.SetActive()
					[ ] ManageDataFilePassword.UseMyCustomPassword.Select(2)
					[ ] ManageDataFilePassword.CreateNewPassword.SetFocus()
					[ ] ManageDataFilePassword.CreateNewPassword.SetText(sWrongPassword )
					[ ] ManageDataFilePassword.ConfirmPassword.SetFocus()
					[ ] ManageDataFilePassword.ConfirmPassword.SetText("abcde")
					[-] ManageDataFilePassword.OK.Click()
						[-] if(OperationFailed.Exists())
							[ ] sTemp = OperationFailed.WrongPassword.Gettext()
							[ ] bMatch = MatchStr ("*Quicken was not able to use the password that you entered*", sTemp)
							[-] if(bMatch==TRUE)
								[ ] ReportStatus("Verify Manage Data file password Window Validation", PASS, "Manage data file password window displays proper message if new password and confirm password are different") 
							[-] else
								[ ] ReportStatus("Verify Manage Data file password Window Validation", FAIL, "Manage data file password window donot displays proper message f new password and confirm password are different") 
					[ ] OperationFailed.OK.Click()
					[ ] sTemp = ""
					[ ] ManageDataFilePassword.SetActive()
					[ ] ManageDataFilePassword.UseMyCustomPassword.Select(2)
					[ ] ManageDataFilePassword.CreateNewPassword.SetFocus()
					[ ] ManageDataFilePassword.CreateNewPassword.SetText(sBlankPassword)
					[ ] ManageDataFilePassword.ConfirmPassword.SetFocus()
					[ ] ManageDataFilePassword.ConfirmPassword.SetText(sBlankPassword)
					[ ] ManageDataFilePassword.OK.Click()
					[-] if(OperationFailed.Exists())
						[ ] sTemp = OperationFailed.WrongPassword.Gettext()
						[-] if(sTemp == "Quicken cannot use a blank password.")
							[ ] ReportStatus("Verify Manage Data file password Window Validation", PASS, "Manage data file password window displays proper message if Blank password is entered") 
						[-] else
							[ ] ReportStatus("Verify Manage Data file password Window Validation", FAIL, "Manage data file password window donot displays proper message if Blank password is entered") 
						[ ] OperationFailed.OK.Click()
						[-] sTemp = ""
							[ ] 
					[ ] ManageDataFilePassword.Cancel.Click()
				[-] else
						[ ] ReportStatus("Verify Manage Data file password Window", FAIL, "Manage data file password window is not found") 
		[ ] 
		[-] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
	[ ] 
[+] //############# Verify Enter Password Error With Intuit ID As Data File Password ############# 
	[ ] // ********************************************************
	[-] // TestCase Name: Test32_VerifyEnterPAsswordErrorWithIntuitIDAsDataFilePassword ()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if correct validation are set for Enter Quicken Password Dialog
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 	In case validation are not correct		
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // May, 2015		Created By Abhjit Sarma
	[ ] // *********************************************************
	[ ] 
[+] testcase Test32_VerifyEnterPAsswordErrorWithIntuitIDAsDataFilePassword () appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] INTEGER iOpenDataFile
		[ ] sOIPFileName = "One Intuit Password Custom Password"
		[ ] STRING sWrongPassword = "abcd"
		[ ] STRING sTemp = ""
	[ ] CopyOIPDataFile(sOIPFileName)
	[ ] //-------Open data file------------
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
	[ ] EnterPassword()
	[-] iOpenDataFile = OpenDataFile(sOIPFileName)
		[-] if(iOpenDataFile==PASS)
			[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sOIPFileName} is Opened")
			[ ] 
			[ ] sleep(5)
			[ ] 
			[ ] CloseQuicken()
			[ ] LaunchQuicken()
			[-] if (EnterQuickenPassword.Exists(2))
				[ ] EnterQuickenPassword.SetActive()
				[ ] EnterQuickenPassword.Password.SetFocus()
				[ ] EnterQuickenPassword.Password.SetText(sWrongPassword)
				[ ] EnterQuickenPassword.OK.Click()
				[-] if(EnterQuickenPassword.WrongPassword.Exists())
						[ ] sTemp = EnterQuickenPassword.WrongPassword.Gettext()
						[-] if(sTemp == "Sorry, the password you entered does not match.")
							[ ] ReportStatus("Verify Enter Quicken Password dialog", PASS, "Enter Quicken Password dialog displays proper message if wrong custom password is entered") 
							[ ] sTemp = ""
						[-] else
							[ ] ReportStatus("Verify Enter Quicken Password dialog", FAIL, "Enter Quicken Password dialog don't display proper message if wrong custom password is entered") 
				[-] if(EnterQuickenPassword.CheckToMake.Exists())
						[ ] sTemp = EnterQuickenPassword.CheckToMake.Gettext()
						[-] if(sTemp == "Check to make sure you are entering the correct password. Note that Quicken passwords are case sensitive.")
							[ ] ReportStatus("Verify Enter Quicken Password dialog", PASS, "Enter Quicken Password dialog displays proper message if wrong custom password is entered") 
							[ ] sTemp = ""
						[-] else
							[ ] ReportStatus("Verify Enter Quicken Password dialog", FAIL, "Enter Quicken Password dialog don't display proper message if wrong custom password is entered") 
				[ ] EnterQuickenPassword.CancelButton.Click()
		[-] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file - Error during  {sOIPFile} is not opened")
			[ ] 
