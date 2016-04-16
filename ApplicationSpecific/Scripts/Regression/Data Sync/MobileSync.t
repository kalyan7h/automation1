[ ] // *********************************************************
[+] // FILE NAME:	<DataSync.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Data Sync test cases for Quicken Desktop : This will not include QM part and data verification on cloud
	[ ] //
	[ ] // DEPENDENCIES:	includes.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube/ Mukesh Mishra/ Dean 
	[ ] //
	[ ] // Developed on: 		14/01/2013
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Jan 14, 2013	Udita Dube  Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[+] ///=====================Variable Declaration =====================================
	[ ] // Variable Declaration
	[ ] LIST OF ANYTYPE lsAddAccount, lsExcelData, lsAddProperty,lsCloudUserData,lsRent,lsReminder,lsExpense,lsTransaction,lsExcelData1
	[ ] LIST OF ANYTYPE lsMlgTrans, lsListBoxItems, lsCategorizedExpenses, lsSpendingByPayees
	[ ] STRING sFileName="MobileSyncData"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sMobileSyncData = "MobileSyncData"
	[ ] public STRING sCloudIdData = "CloudIdData"
	[ ] public STRING sTransactionSheet = "CheckingTransaction"
	[ ] public STRING sAccountWorksheet = "Account"
	[ ] 
	[ ]  public STRING sInvestingTransactionWorksheet = "Investing Transaction"
	[ ] public STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] public INTEGER iAddAccount,iSelect, iAmount,iCounter,iAddTransaction,iSwitchState,iNavigate ,iZipcode
	[ ] public STRING sAccountType,sDateStamp,hWnd,sActual,sItem, sCategory
	[ ] public boolean bMatch
[ ] 
[ ] 
[+] //############# Navigate to Mobile tab from Preference ##########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test4_NavigateToMobileTabFromPreference()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the navigation of Mobile tab from Edit > Preferences
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Navigate to Quicken Mobile from Preference
		[ ] //						Fail		If Navigation is unsuccessful on Quicken Mobile Tab
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Jan 14, 2013		
		[ ] //Author                          Udita Dube
		[ ] 
	[ ] // ********************************************************
[+] testcase Test4_NavigateToMobileTabFromPreference() appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] INTEGER iCount,iLogin,iCreateDataFile,iAddAccount
	[ ] STRING sPreferenceType,sCloudId,sPwd,sExpected
	[ ] STRING sDataFileName = "DataSync_Preferences"
	[ ] sExpected = "Mobile & Alerts"
	[ ] sCloudId="gbsync14@gmail.com"
	[ ] sPwd="qwerty"
	[ ] 
	[ ] // Read data from excel sheet 
	[ ] lsExcelData=ReadExcelTable(sMobileSyncData, sCloudIdData)
	[ ] lsCloudUserData=lsExcelData[1]
	[ ] lsExcelData1=ReadExcelTable(sMobileSyncData, sAccountWorksheet)
	[ ] lsAddAccount=lsExcelData1[1]
	[ ] 
	[ ] 
	[-] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sDataFileName)
		[ ] ReportStatus("Create New Data File {sDataFileName}",iCreateDataFile,"New Data File {sDataFileName} created successfully ")
		[ ] 
		[ ] // Add Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] ReportStatus("Add Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is created successfully")
		[ ] 
		[ ] // Navigate to Edit > Preferences
		[ ] SelectPreferenceType(sExpected)
		[ ] // Check the avalability of the Get Started button
		[ ] Waitforstate(Preferences.GetStartedButton,TRUE,SHORT_SLEEP)
		[+] if(Preferences.GetStartedButton.Exists())
			[ ] Preferences.GetStartedButton.Click()
			[ ] ReportStatus("Validate Get Started Button'", PASS, "Get Started button is available for {sExpected}") 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Get Started Button'", FAIL, "Get Started button is not available for {sExpected}") 
			[ ] 
		[ ] 
		[ ] iLogin=MobileLogIn(sCloudId,sPwd)
		[ ] ReportStatus("Login with {sCloudId}", iLogin, "Login with {sCloudId} successful")
		[ ] 
		[ ] // Click on Replace Accounts On Quicken Cloud
		[ ] Waitforstate(WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.ReplaceAccountsOnQuickenCloudButton,TRUE,60)
		[ ] WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.ReplaceAccountsOnQuickenCloudButton.Click()
		[ ] 
		[ ] // Click on Done Button
		[ ] Waitforstate(WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton,TRUE,70)
		[ ] QuickenMainWindow.SetActive()
		[ ] WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton.Click()
		[ ] 
		[ ] // Verify Server side error
		[+] if(AlertMessageBox.Exists(SHORT_SLEEP))
			[ ] ReportStatus("Server Side Verification",FAIL, "Server side error encountered")
			[ ] AlertMessageBox.OK.Click()
		[+] else
			[ ] Waitforstate(DlgCloudSyncComplete,TRUE,60)
			[+] if(DlgCloudSyncComplete.Exists())
				[ ] DlgCloudSyncComplete.OK.Click()
				[+] if(DlgAccountsSynced.Exists(SHORT_SLEEP))
					[ ] DlgAccountsSynced.OK.Click()
					[ ] 
					[ ] // Navigate to Edit > Preferences and select Mobile & Alerts
					[ ] SelectPreferenceType(sExpected)
					[+] if(Preferences.UpdateYourAccountSettings.Exists())
						[ ] // Click on Update Your Account Settings link
						[ ] Preferences.UpdateYourAccountSettings.Click()
						[ ] // Verify that Update your Account Setting navigates to Edit Account Settings window
						[+] if(DlgEditAccountSettings.Exists())
							[ ] ReportStatus("Update your Account Setting navigates to Edit Account Settings window", PASS,"Update your Account Setting navigates to Edit Account Settings window")
							[ ] DlgEditAccountSettings.Close()
							[ ] Preferences.Close()
						[+] else
							[ ] ReportStatus("Update your Account Setting navigates to Edit Account Settings window", FAIL,"Update your Account Setting does not navigate to Edit Account Settings window")
							[ ] 
					[+] else
						[ ] ReportStatus("Navigation to Edit > Preferences > select Mobile & Alerts",FAIL,"Navigation to Edit > Preferences and select Mobile & Alerts is failed")
				[+] else
					[ ] ReportStatus("Verify Account Synced window",FAIL,"Account Synced window does not appear")
			[+] else if(DlgAccountsSynced.Exists(MEDIUM_SLEEP))
				[ ] DlgAccountsSynced.OK.Click()
				[ ] 
				[ ] // Navigate to Edit > Preferences and select Mobile & Alerts
				[ ] SelectPreferenceType(sExpected)
				[+] if(Preferences.UpdateYourAccountSettings.Exists())
					[ ] Preferences.SetActive()
					[ ] // Click on Update Your Account Settings link
					[ ] Preferences.UpdateYourAccountSettings.Click()
					[ ] 
					[ ] //Verify that Update your Account Setting navigates to Edit Account Settings window
					[ ] Waitforstate(DlgEditAccountSettings,TRUE,SHORT_SLEEP)
					[+] if(DlgEditAccountSettings.Exists())
						[ ] ReportStatus("Update your Account Setting navigates to Edit Account Settings window", PASS,"Update your Account Setting navigates to Edit Account Settings window")
						[ ] DlgEditAccountSettings.Cancel.Click()
						[ ] Preferences.Close()
					[+] else
						[ ] ReportStatus("Update your Account Setting navigates to Edit Account Settings window", FAIL,"Update your Account Setting does not navigate to Edit Account Settings window")
						[ ] 
				[+] else
					[ ] ReportStatus("Navigation to Edit > Preferences > select Mobile & Alerts",FAIL,"Navigation to Edit > Preferences and select Mobile & Alerts is failed")
			[+] else
				[ ] ReportStatus("Verify Cloud Sync complete window",FAIL,"Cloud Sync complete window does not appear")
				[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //########################################################################################
[ ] 
[+] //############# Update Account Setting from Preferences ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test5_UpdateAccountSettingFromPreference()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will update the account settings of Mobile from Edit > Preferences
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Account setting updated successfully
		[ ] //						Fail		If account setting is not updated from preferences
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Jan 16, 2013		
		[ ] //Author                          Udita Dube
		[ ] 
	[ ] // ********************************************************
[-] testcase Test5_UpdateAccountSettingFromPreference() appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] INTEGER iCount,iLogin,iCreateDataFile,iAddAccount
	[ ] STRING sPreferenceType,sExpected,sPwd
	[ ] STRING sDataFileName = "DataSync_Preferences"
	[ ] sExpected = "Mobile & Alerts"
	[ ] sPreferenceType = "#17"		//"Mobile & Alerts" = #19
	[ ] sPwd="qwerty"
	[ ] 
	[ ] // Read data from excel sheet 
	[ ] lsExcelData1=ReadExcelTable(sMobileSyncData, sAccountWorksheet)
	[ ] lsAddAccount=lsExcelData1[2]
	[ ] 
	[ ] 
	[-] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] // Add Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] ReportStatus("Add Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is created successfully")
		[ ] 
		[ ] // Navigate to Edit > Preferences and select Mobile & Alerts
		[ ] SelectPreferenceType(sExpected)
		[-] if(Preferences.UpdateYourAccountSettings.Exists())
			[ ] Preferences.SetActive()
			[ ] // Click on Update Your Account Settings link
			[ ] Preferences.UpdateYourAccountSettings.Click()
			[ ] 
			[ ] //Verify that Update your Account Setting navigates to Edit Account Settings window
			[ ] Waitforstate(DlgEditAccountSettings,TRUE,SHORT_SLEEP)
			[-] if(DlgEditAccountSettings.Exists())
				[ ] ReportStatus("Update your Account Setting navigates to Edit Account Settings window", PASS,"Update your Account Setting navigates to Edit Account Settings window")
				[ ] DlgEditAccountSettings.SetActive ()
				[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, FALSE)
				[ ] DlgEditAccountSettings.AccountsEnabledForMobileQWListViewer.ListBox1.Click(1,15,60)
				[ ] DlgEditAccountSettings.UpdateAccountsButton.Click()
				[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, TRUE)
				[-] if(DlgCloudSyncComplete.Exists())
					[ ] DlgCloudSyncComplete.OK.Click()
				[-] else
					[ ] ReportStatus("Verify Cloud Sync complete window",FAIL,"Cloud Sync complete window does not appear")
					[ ] 
				[-] if(DlgSignInMoblieSync.Exists(SHORT_SLEEP))
					[ ] DlgSignInMoblieSync.QuickenCloudPasswordTextField.SetText(sPwd)
					[ ] DlgSignInMoblieSync.SignInButton.Click()
				[ ] 
				[ ] Waitforstate(Preferences,TRUE,60)
				[ ] Preferences.Close()
			[+] else
				[ ] ReportStatus("Update your Account Setting navigates to Edit Account Settings window", FAIL,"Update your Account Setting does not navigate to Edit Account Settings window")
		[+] else
			[ ] ReportStatus("Verify Mobile & Alerts preference type selection",FAIL,"Mobile & Alerts preference type is not selected")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //########################################################################################
[ ] 
[+] //############# Navigate to Update your alert settings from Preference ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test6_NavigateToUpdateAlertSettingFromPreference()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the navigation of Mobile tab from Edit > Preferences > Update your alert setting
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Edit Alerts Settings window is displayed
		[ ] //						Fail		If Navigation is unsuccessful to Edit Alerts Settings window 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Jan 16, 2013		
		[ ] //Author                          Udita Dube
		[ ] 
	[ ] // ********************************************************
[+] testcase Test6_NavigateToUpdateAlertSettingFromPreference() appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] STRING sPreferenceType
	[ ] sPreferenceType = "Mobile & Alerts"
	[ ] 
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] // Navigate to Edit > Preferences and select Mobile & Alerts
		[ ] SelectPreferenceType(sPreferenceType)
		[+] if(Preferences.UpdateYourAlertSettings.Exists())
			[ ] Preferences.SetActive()
			[ ] // Click on Update Your Alerts Settings link
			[ ] Preferences.UpdateYourAlertSettings.Click()
			[ ] 
			[ ] //Verify that Update Your Alerts Settings navigates to Edit Alerts Settings window
			[ ] Waitforstate(DlgEditAlertsSettings,TRUE,SHORT_SLEEP)
			[+] if(DlgEditAlertsSettings.Exists())
				[ ] ReportStatus("Update your Alerts Setting navigates to Edit Alerts Settings window", PASS,"Update your Alerts Setting navigates to Edit Alerts Settings window")
				[ ] DlgEditAlertsSettings.Cancel.Click()
				[ ] Waitforstate(Preferences,TRUE,60)
				[ ] Preferences.Close()
			[+] else
				[ ] ReportStatus("Update your Alerts Setting navigates to Edit Alerts Settings window", FAIL,"Update your Alerts Setting does not navigate to Edit Alerts Settings window")
		[+] else
			[ ] ReportStatus("Verify Mobile & Alerts preference type selection",FAIL,"Mobile & Alerts preference type is not selected")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //########################################################################################
[ ] 
[+] //############# Update your alert settings from Preference #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test6_NavigateToUpdateAlertSettingFromPreference()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the navigation of Mobile tab from Edit > Preferences > Update your alert setting
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Edit Alerts Settings window is displayed
		[ ] //						Fail		If Navigation is unsuccessful to Edit Alerts Settings window 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Jan 17, 2013		
		[ ] //Author                          Udita Dube
		[ ] 
	[ ] // ********************************************************
[-] testcase Test7_UpdateAlertSettingFromPreference() appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] STRING sPreferenceType,sPwd,sSummaryEmail,sAmount
	[ ] INTEGER iNavigate
	[ ] sPreferenceType = "Mobile & Alerts"
	[ ] sPwd="qwerty"
	[ ] sSummaryEmail="Monthly"
	[ ] sAmount="$  500"
	[ ] 
	[ ] 
	[-] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] // Navigate to Edit > Preferences and select Mobile & Alerts
		[ ] SelectPreferenceType(sPreferenceType)
		[-] if(Preferences.UpdateYourAlertSettings.Exists())
			[ ] Preferences.SetActive()
			[ ] // Click on Update Your Alerts Settings link
			[ ] Preferences.UpdateYourAlertSettings.Click()
			[ ] 
			[+] if(DlgSignInMoblieSync.Exists(SHORT_SLEEP))
				[+] if(DlgSignInMoblieSync.QuickenCloudPasswordTextField.Exists())
					[ ] DlgSignInMoblieSync.QuickenCloudPasswordTextField.SetText(sPwd)
					[ ] DlgSignInMoblieSync.SignInButton.Click()
			[ ] 
			[ ] //Verify that Update Your Alerts Settings navigates to Edit Alerts Settings window
			[ ] Waitforstate(DlgEditAlertsSettings,TRUE,SHORT_SLEEP)
			[+] if(DlgEditAlertsSettings.Exists())
				[ ] ReportStatus("Update your Alerts Setting navigates to Edit Alerts Settings window", PASS,"Update your Alerts Setting navigates to Edit Alerts Settings window")
				[ ] DlgEditAlertsSettings.SummaryEmailsPopupList.Select(sSummaryEmail)
				[ ] DlgEditAlertsSettings.EmailAlertsWillBeSentToQWListViewer.ListBox1.AmountPopupList.Select(sAmount)
				[ ] DlgEditAlertsSettings.OK.Click()
				[ ] Waitforstate(Preferences,TRUE,60)
				[ ] Preferences.Close()
			[+] else
				[ ] ReportStatus("Update your Alerts Setting navigates to Edit Alerts Settings window", FAIL,"Update your Alerts Setting does not navigate to Edit Alerts Settings window")
			[ ] 
			[ ] //Verify settings saved in  Edit Alerts Settings window
			[ ] iNavigate=NavigateQuickenTab(sTAB_MOBILE_ALERTS,sTAB_QUICKEN_MOBILE)
			[ ] ReportStatus("Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}",iNavigate,"Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}")
			[ ] 
			[ ] WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.EditAlertsSettingsLink.Click()
			[ ] Waitforstate(DlgEditAlertsSettings,TRUE,40)
			[+] if(DlgEditAlertsSettings.Exists())
				[+] if(sSummaryEmail==DlgEditAlertsSettings.SummaryEmailsPopupList.GetSelText())
					[ ] ReportStatus("Varify that Summry Email setting saved",PASS,"Summary Email setting is saved as it is {sSummaryEmail}")
					[+] if(sAmount==DlgEditAlertsSettings.EmailAlertsWillBeSentToQWListViewer.ListBox1.AmountPopupList.GetSelText())
						[ ] ReportStatus("Varify that amount set for Credit Available",PASS,"Setting for Credit Available amount is saved and it is {sAmount}")
					[+] else
						[ ] ReportStatus("Varify that amount set for Credit Available",FAIL,"Setting for Credit Available amount is not saved as it is not {sAmount}")
						[ ] 
				[+] else
					[ ] ReportStatus("Varify that Summry Email setting saved",FAIL,"Summary Email setting is not saved as it is not {sSummaryEmail}")
					[ ] 
				[ ] DlgEditAlertsSettings.OK.Click()
			[+] else
				[ ] ReportStatus("Verify Edit Alerts Settings window", FAIL,"Edit Alerts Settings window is not opened")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Mobile & Alerts preference type selection",FAIL,"Mobile & Alerts preference type is not selected")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //########################################################################################
[ ] 
[+] //#############Verify Reset your password link from Preference ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test8_ResetYourPasswordFromPreference()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify reset your password link from Preferences
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If reset your password link works successfully
		[ ] //						Fail		If reset your password link does not work
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Jan 17, 2013		
		[ ] //Author                          Udita Dube
		[ ] 
	[ ] // ********************************************************
[+] testcase Test8_ResetYourPasswordFromPreference() appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] STRING sPreferenceType,sZipCode
	[ ] sPreferenceType = "Mobile & Alerts"
	[ ] sZipCode="12345"
	[ ] 
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] // Navigate to Edit > Preferences and select Mobile & Alerts
		[ ] SelectPreferenceType(sPreferenceType)
		[+] if(Preferences.UpdateYourAlertSettings.Exists())
			[ ] Preferences.SetActive()
			[ ] // Click on Reset your Password link
			[ ] Preferences.ResetYourPassword.Click()
			[ ] 
			[ ] //Verify that Update Your Alerts Settings navigates to Edit Alerts Settings window
			[ ] Waitforstate(DlgForgotYourQuickenCloudPassword,TRUE,SHORT_SLEEP)
			[+] if(DlgForgotYourQuickenCloudPassword.Exists())
				[ ] ReportStatus("Reset your Password navigates to Forgot Your Quicken Cloud Password window", PASS,"Reset your Password navigates to Forgot Your Quicken Cloud Password window")
				[ ] DlgForgotYourQuickenCloudPassword.ZipCode.SetText(sZipCode)
				[ ] DlgForgotYourQuickenCloudPassword.OK.Click()
				[ ] Waitforstate(DlgResetYourQuickenCloudPassword,TRUE,SHORT_SLEEP)
				[+] if(DlgResetYourQuickenCloudPassword.Exists())
					[ ] DlgResetYourQuickenCloudPassword.SetActive()
					[ ] ReportStatus("Verify Reset your Quicken Cloud Password window", PASS, "Reset your Quicken cloud Password window is opened")
					[ ] DlgResetYourQuickenCloudPassword.Cancel.Click()
				[+] else
					[ ] ReportStatus("Verify Reset your Quicken Cloud Password window", FAIL, "Reset your Quicken cloud Password window is not opened")
					[ ] 
				[ ] Preferences.SetActive()
				[ ] Preferences.Close()
			[+] else
				[ ] ReportStatus("Verify Forgot Your Quicken Cloud Password window", FAIL,"Forgot Your Quicken Cloud Password window is not opened")
		[+] else
			[ ] ReportStatus("Verify Mobile & Alerts preference type selection",FAIL,"Mobile & Alerts preference type is not selected")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //########################################################################################
[ ] 
[+] //#############Update Your Profile link from Preference ##########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9_UpdateYourProfileFromPreference()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify update your profile link from Preferences
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Edit Quicken cloud profile window opened and changes saved
		[ ] //						Fail		If Edit Quicken cloud profile window not opened
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Jan 17, 2013		
		[ ] //Author                          Udita Dube
		[ ] 
	[ ] // ********************************************************
[+] testcase Test9_UpdateYourProfileFromPreference() appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] STRING sPreferenceType,sZipCode
	[ ] sPreferenceType = "Mobile & Alerts"
	[ ] sZipCode="12345"
	[ ] 
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] // Navigate to Edit > Preferences and select Mobile & Alerts
		[ ] SelectPreferenceType(sPreferenceType)
		[+] if(Preferences.UpdateYourProfile.Exists())
			[ ] Preferences.SetActive()
			[ ] // Click on Update your Profile link
			[ ] Preferences.UpdateYourProfile.Click()
			[ ] 
			[ ] //Verify that Update Your Profile navigates to Edit Quicken Cloud Profile window
			[ ] Waitforstate(DlgEditQuickenCloudProfile,TRUE,SHORT_SLEEP)
			[+] if(DlgEditQuickenCloudProfile.Exists())
				[ ] ReportStatus("Verify that Update Your Profile navigates to Edit Quicken Cloud Profile window", PASS,"Update Your Profile navigates to Edit Quicken Cloud Profile window")
				[ ] DlgEditQuickenCloudProfile.ZipCode.SetText(sZipCode)
				[ ] DlgEditQuickenCloudProfile.OK.Click()
				[ ] Preferences.SetActive()
				[ ] Preferences.Close()
				[ ] 
				[ ] // //Verify settings saved in  Edit Quicken Cloud Profile window
				[ ] // iNavigate=NavigateQuickenTab(sTAB_MOBILE_ALERTS,sTAB_QUICKEN_MOBILE)
				[ ] // ReportStatus("Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}",iNavigate,"Navigate to {sTAB_MOBILE_ALERTS} > {sTAB_QUICKEN_MOBILE}")
				[ ] 
				[ ] // Click on Edit Profile Link
				[ ] WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.EditProfileLink.Click()
				[ ] Waitforstate(DlgEditQuickenCloudProfile,TRUE,40)
				[+] if(DlgEditQuickenCloudProfile.Exists())
					[+] if(sZipCode==DlgEditQuickenCloudProfile.ZipCode.GetText())
						[ ] ReportStatus("Varify that Zip value saved",PASS,"Zip value is saved as it is {sZipCode}")
					[+] else
						[ ] ReportStatus("Varify that Zip value saved",PASS,"Zip value is not saved as it is not {sZipCode}")
						[ ] 
					[ ] DlgEditQuickenCloudProfile.OK.Click()
				[+] else
					[ ] ReportStatus("Verify Edit Quicken Cloud Profile window", FAIL,"Edit Quicken Cloud Profile window is not opened")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify that Update Your Profile navigates to Edit Quicken Cloud Profile window", FAIL,"Update Your Profile does not navigate to Edit Quicken Cloud Profile window")
		[+] else
			[ ] ReportStatus("Verify Mobile & Alerts preference type selection",FAIL,"Mobile & Alerts preference type is not selected")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //########################################################################################
[ ] 
[+] //#############View Your Profile link from Preference ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_ViewYourProfileFromPreference()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify view your profile link from Preferences
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Edit Quicken cloud profile window opened 
		[ ] //						Fail		If Edit Quicken cloud profile window not opened
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Jan 21, 2013		
		[ ] //Author                          Udita Dube
		[ ] 
	[ ] // ********************************************************
[+] testcase Test10_ViewYourProfileFromPreference() appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] STRING sPreferenceType
	[ ] sPreferenceType = "Mobile & Alerts"
	[ ] 
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] // Navigate to Edit > Preferences and select Mobile & Alerts
		[ ] SelectPreferenceType(sPreferenceType)
		[+] if(Preferences.ViewYourProfile.Exists())
			[ ] Preferences.SetActive()
			[ ] // Click on View your Profile link
			[ ] Preferences.ViewYourProfile.Click()
			[ ] 
			[ ] //Verify that View Your Profile navigates to Edit Quicken Cloud Profile window
			[ ] Waitforstate(DlgEditQuickenCloudProfile,TRUE,SHORT_SLEEP)
			[+] if(DlgEditQuickenCloudProfile.Exists())
				[ ] ReportStatus("Verify that View Your Profile navigates to Edit Quicken Cloud Profile window", PASS,"View Your Profile navigates to Edit Quicken Cloud Profile window")
				[ ] DlgEditQuickenCloudProfile.OK.Click()
				[ ] Preferences.SetActive()
				[ ] Preferences.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify that View Your Profile navigates to Edit Quicken Cloud Profile window", FAIL,"View Your Profile does not navigate to Edit Quicken Cloud Profile window")
		[+] else
			[ ] ReportStatus("Verify Mobile & Alerts preference type selection",FAIL,"Mobile & Alerts preference type is not selected")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //########################################################################################
[ ] 
[+] //#############View Your Profile and Delete link from Preference ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_ViewYourProfileAndDeleteFromPreference()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify view your profile and delete link from Preferences
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Edit Quicken cloud profile window opened 
		[ ] //						Fail		If Edit Quicken cloud profile window not opened
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Jan 21, 2013		
		[ ] //Author                          Udita Dube
		[ ] 
	[ ] // ********************************************************
[+] testcase Test11_ViewYourProfileAndDeleteFromPreference() appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] STRING sPreferenceType
	[ ] sPreferenceType = "Mobile & Alerts"
	[ ] 
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] // Navigate to Edit > Preferences and select Mobile & Alerts
		[ ] SelectPreferenceType(sPreferenceType)
		[+] if(Preferences.ViewYourProfileAndChooseDelete.Exists())
			[ ] Preferences.SetActive()
			[ ] // Click on View your Profile and Delete link
			[ ] Preferences.ViewYourProfileAndChooseDelete.Click()
			[ ] 
			[ ] //Verify that View Your Profile and Choose Delete navigates to Edit Quicken Cloud Profile window
			[ ] Waitforstate(DlgEditQuickenCloudProfile,TRUE,40)
			[+] if(DlgEditQuickenCloudProfile.Exists())
				[ ] ReportStatus("Verify that View Your Profile and Choose Delete navigates to Edit Quicken Cloud Profile window", PASS,"View Your Profile and choose Delete navigates to Edit Quicken Cloud Profile window")
				[ ] DlgEditQuickenCloudProfile.OK.Click()
				[ ] Preferences.SetActive()
				[ ] Preferences.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify that View Your Profile and chosse Delete navigates to Edit Quicken Cloud Profile window", FAIL,"View Your Profile and choose Delete does not navigate to Edit Quicken Cloud Profile window")
		[+] else
			[ ] ReportStatus("Verify Mobile & Alerts preference type selection",FAIL,"Mobile & Alerts preference type is not selected")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //########################################################################################
[ ] 
[+] //#############Verify OK and Cancel buttons for Mobile & Alerts Preference type #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_VerifyButtonsOfMobileAlertsPrefernceType()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify OK and Cancel buttons in this window work fine
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If buttons working fine
		[ ] //						Fail		If either of the button or both does not work as expected
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Jan 22, 2013		
		[ ] //Author                          Udita Dube
		[ ] 
	[ ] // ********************************************************
[+] testcase Test12_VerifyButtonsOfMobileAlertsPrefernceType() appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] STRING sPreferenceType
	[ ] sPreferenceType = "Mobile & Alerts"
	[ ] 
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] // Navigate to Edit > Preferences and select Mobile & Alerts
		[ ] SelectPreferenceType(sPreferenceType)
		[ ] // Verification for OK button
		[+] if(Preferences.OK.Exists())
			[ ] Preferences.SetActive()
			[ ] // Click on OK button
			[ ] Preferences.OK.Click()
			[+] if(!Preferences.Exists())
				[ ] ReportStatus("Verify OK button for Mobile & Alerts Prefernce type", PASS, "OK button is working as expected")
			[+] else
				[ ] ReportStatus("Verify OK button for Mobile & Alerts Prefernce type", FAIL, "OK button is not working as expected")
				[ ] Preferences.Close()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Mobile & Alerts preference type selection",FAIL,"Mobile & Alerts preference type is not selected")
		[ ] 
		[ ] // Navigate to Edit > Preferences and select Mobile & Alerts
		[ ] SelectPreferenceType(sPreferenceType)
		[ ] // Verification for Cancel button
		[+] if(Preferences.Cancel.Exists())
			[ ] Preferences.SetActive()
			[ ] // Click on Cancel button
			[ ] Preferences.Cancel.Click()
			[+] if(!Preferences.Exists())
				[ ] ReportStatus("Verify Cancel button for Mobile & Alerts Prefernce type", PASS, "Cancel button is working as expected")
			[+] else
				[ ] ReportStatus("Verify Cancel button for Mobile & Alerts Prefernce type", FAIL, "Cancel button is not working as expected")
				[ ] Preferences.Close()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Mobile & Alerts preference type selection",FAIL,"Mobile & Alerts preference type is not selected")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //########################################################################################
[ ] 
[+] //#############Unlink that file and then sign in with same user id again #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_UnlinkAndSignInAgain()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Unlink that file and then sign in with same user id again
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If sign in successful
		[ ] //						Fail		If sign in unsuccessful or any error comes
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             Jan 22, 2013		
		[ ] //Author                          Udita Dube
		[ ] 
	[ ] // ********************************************************
[-] testcase Test13_UnlinkAndSignInAgain() appstate none
	[ ] 
	[ ] // Variable declaration
	[ ] INTEGER iLogin
	[ ] STRING sPreferenceType,sCloudId,sPwd
	[ ] sPreferenceType = "Mobile & Alerts"
	[ ] sCloudId="gbsync14@gmail.com"
	[ ] sPwd="qwerty"
	[ ] 
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] Waitforstate(QuickenMainWindow,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] // Navigate to Edit > Preferences and select Mobile & Alerts
		[ ] SelectPreferenceType(sPreferenceType)
		[ ] 
		[+] if(Preferences.UnlinkThisDataFile.Exists())
			[ ] ReportStatus("Verify Unlink This Data File button",PASS,"Unlink this Data File button is available under Mobile & Alerts Preference Type")
			[ ] Preferences.SetActive()
			[ ] Preferences.UnlinkThisDataFile.Click()
			[+] if(UnlinkThisDataFile.Exists())
				[ ] ReportStatus("Verify Unlink This Data File Dialog",PASS,"Unlink This Data File dialog is available")
				[ ] UnlinkThisDataFile.SetActive()
				[ ] UnlinkThisDataFile.Unlink.Click()
				[+] if(Preferences.GetStartedButton.Exists())
					[ ] Preferences.GetStartedButton.Click()
					[ ] ReportStatus("Validate Get Started Button'", PASS, "Get Started button is available as data file is unlinked") 
					[ ] iLogin=MobileLogIn(sCloudId,sPwd)
					[ ] ReportStatus("Login with {sCloudId}", iLogin, "Login with {sCloudId} successful")
					[ ] 
					[ ] // Click on Replace Accounts On Quicken Cloud
					[ ] Waitforstate(WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.ReplaceAccountsOnQuickenCloudButton,TRUE,60)
					[ ] WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.ReplaceAccountsOnQuickenCloudButton.Click()
					[ ] 
					[ ] // Click on Done Button
					[ ] Waitforstate(WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton,TRUE,70)
					[ ] QuickenMainWindow.SetActive()
					[ ] WinMoblieSync.QWSnapHolder1.PanelMoblieSyncOverview.DoneButton.Click()
					[ ] 
					[ ] // Verify Server side error
					[+] if(AlertMessageBox.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Server Side Verification",FAIL, "Server side error encountered")
						[ ] AlertMessageBox.OK.Click()
					[+] else
						[ ] Waitforstate(DlgCloudSyncComplete,TRUE,60)
						[+] if(DlgCloudSyncComplete.Exists())
							[ ] DlgCloudSyncComplete.OK.Click()
							[+] if(DlgAccountsSynced.Exists(SHORT_SLEEP))
								[ ] DlgAccountsSynced.OK.Click()
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Account Synced window",FAIL,"Account Synced window does not appear")
						[+] else if(DlgAccountsSynced.Exists(MEDIUM_SLEEP))
							[ ] DlgAccountsSynced.OK.Click()
							[ ] ReportStatus("Verify Cloud Sync complete window",PASS,"Cloud Sync complete window appeared")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Cloud Sync complete window",FAIL,"Cloud Sync complete window does not appear")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Get Started Button'", FAIL, "Get Started button is not available as data file is not unlinked") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Unlink This Data File Dialog",FAIL,"Unlink This Data File dialog is not available")
		[+] else
			[ ] ReportStatus("Verify Unlink This Data File button",FAIL,"Unlink this Data File button is not available under Mobile & Alerts Preference Type")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
[ ] //########################################################################################
[ ] 
