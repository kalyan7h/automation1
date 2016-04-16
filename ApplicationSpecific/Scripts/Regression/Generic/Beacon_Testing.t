﻿[ ] 
[+] // FILE NAME:	<Beacon_Testing.t.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This suit will create online account with the help of local file and perfromce OSU and Update Now.Verify ending balance , online balance and online center
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Puja Verma
	[ ] //
	[ ] // Developed on: 		28/7/2011
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //Julyl 28, 2011	Puja Verma  Created
[ ] // *********************************************************
[ ] 
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
[ ] 
[ ] 
[-] //Global Variable
	[ ] // public STRING sCmdLine="{QUICKEN_ROOT}\qw.exe"
	[ ] public STRING sMFCUAccountId = "123456"
	[ ] public STRING sOnlineAccountFileName = "Online"
	[ ] public STRING sCheckingAccount = "BUSINESS CHECKING XX0124"
	[ ] INTEGER iResponseStatus
	[ ] STRING sHandle,sExpected,sActual
	[ ] BOOLEAN bMatch,bFlag
	[ ] INTEGER i,iSetupAutoAPI
	[ ] STRING sExpEndingbalance="278.50"
	[ ] STRING sExpOnlineBalance="278.50"
	[ ] INTEGER iResult ,iNavigate
	[ ] 
[ ] 
[+] 
	[+] // //#######//###### Beacon Setup ############# 
		[ ] // // ********************************************************
		[+] // // TestCase Name:	 BeaconSetup()
			[ ] // //
			[ ] // // DESCRIPTION:
			[ ] // // This testcase will copy few required files from original to temp location  if it exists
			[ ] // //
			[ ] // // PARAMETERS:		None
			[ ] // //
			[ ] // // RETURNS:			Pass 		If no error occurs while deleting file							
			[ ] // //						Fail		If any error occurs
			[ ] // //
			[ ] // // REVISION HISTORY:
			[ ] // //	 Nov 17, 2011		Puja Verma created	
		[ ] // //*********************************************************
	[+] // testcase BeaconSetup() appstate QuickenBaseState
		[ ] // // Load O/S specific paths
		[ ] // // LoadSKUDependency()
		[ ] // LoadOSDependency()
		[ ] // 
		[+] // //VARIABLE
			[ ] // INTEGER iLocalFileSetup, iSetupAutoAPI,iCreateDataFile
			[ ] // STRING sOnlineAccountFilePath = AUT_DATAFILE_PATH + "\" + sOnlineAccountFileName + ".QDF"
			[ ] // STRING sSourceOlnIniFile="{ROOT_PATH}\ApplicationSpecific\Tools\intuonl\Release\intu_onl.ini"
			[ ] //  BOOLEAN bDeleteStatus
			[ ] // STRING sOriginalFolder="{AUT_DATAFILE_PATH}\Original Beacon data"
			[ ] // STRING sTempFolder="{AUT_DATAFILE_PATH}\Beacon data"
		[+] // if (QuickenWindow.Exists(5))
			[ ] // QuickenWindow.Close()
			[ ] // WaitForState(QuickenWindow,FALSE,5)
			[ ] // 
		[ ] // //Deleting existing folder 
		[+] // if(SYS_DirExists(sTempFolder))
			[ ] // bDeleteStatus=DeleteDir(sTempFolder)
			[ ] // print(bDeleteStatus)
			[ ] // 
			[ ] //  
		[+] // else
			[ ] // print("no such folder exists")
		[ ] // 
		[ ] // MakeDir(sTempFolder)
		[+] // if SYS_DirExists(sOriginalFolder)				
			[ ] // CopyDir(sOriginalFolder,sTempFolder)		// copy Beacon  folder to Temporary folder
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Beacon Files and Folder",FAIL,"Beacon Files and Folders are not available in mentioned location")
		[ ] // 
		[ ] // //Delete Existing .ini folder
		[+] // if(FileExists(sDestinationonliniFile) == TRUE)
			[ ] // DeleteFile(sDestinationonliniFile)
		[ ] // 
		[ ] // 
		[ ] // // Create a new data file for Online account
		[ ] // iCreateDataFile = DataFileCreate(sOnlineAccountFileName)
		[+] // if (iCreateDataFile==PASS)
			[ ] // //Test
			[ ] // //BypassRegistration()
			[ ] // 
			[ ] // // QuickenWindow.Tools.Click()
			[ ] // // QuickenWindow.Tools.OneStepUpdate.Select()
			[ ] // // RegisterQuickenConnectedServices()
		[+] // else
			[ ] // ReportStatus("Validate Data File ", FAIL, "Data file -  {sOnlineAccountFileName} is NOT created")
		[ ] // 
		[ ] // 
		[ ] // //Setup LocalFile Testing mechanism
		[ ] // iLocalFileSetup = SetUpLocalFile()
		[ ] // ReportStatus("LocalFile Setup", iLocalFileSetup, "LocalFile Testing Setup is performed") 
		[ ] // 
		[ ] // //Copying Ini file from source to destination folder
		[+] // if(FileExists(sDestinationonliniFile) == FALSE)
			[ ] // CopyFile(sSourceOlnIniFile, sDestinationonliniFile)
		[ ] // 
		[+] // if(FileExists(sOnlineAccountFilePath))
			[ ] // DeleteFile(sOnlineAccountFilePath)
		[ ] // 
		[ ] // //AutoApi Setup
		[ ] // iSetupAutoAPI = SetUp_AutoApi()			// copy qwautoap.dll to Quicken folder in Program files
		[ ] // 
		[ ] // 
		[ ] // /////C:\ProgramData\Intuit\Quicken\Config
		[ ] // 
		[ ] // 
	[ ] // // // //###########################################################################
	[ ] // 
	[+] // // //############# Add online account using local files ##################################
		[ ] // // ********************************************************
		[+] // // TestCase Name:	 Test1_AddEWCWelsFargoAccount()
			[ ] // // 
			[ ] // // DESCRIPTION:
			[ ] // // This testcase will create Online account forWells Fargo Bank. This will create a new data file and add Checking account .
			[ ] // // Using Localfile Testing mechansim.
			[ ] // // 
			[ ] // // PARAMETERS:	none
			[ ] // // 
			[ ] // // RETURNS:			Pass 		If no error occurs while creating online account 							
			[ ] // // Fail		If any error occurs
			[ ] // // 
			[ ] // // REVISION HISTORY:
			[ ] // // Jun 03, 2011		Puja Verma created	
		[ ] // //*********************************************************
	[-] // testcase Test1_AddEWCWellsFargoAccount () appstate none
		[+] // //VARIABLES
			[ ] // STRING hWnd, sActualOutput
			[ ] // BOOLEAN bMatchStatus
			[ ] // INTEGER iCreateDataFile, iLocalFileSetup, iIntuonlConfigure
			[ ] // STRING sActualCount ="9"
			[ ] // 
			[ ] // STRING sOnlieAccountFilePath = AUT_DATAFILE_PATH + "\" + sOnlineAccountFileName + ".QDF"
			[ ] // STRING sFileFolder=AUT_DATAFILE_PATH + "\Beacon data\AccountSetResponse\"
			[ ] // //Respose files for Local File Testing
			[ ] // STRING sBrandingResponse =sFileFolder+"1_Brand_Resp.dat"
			[ ] // STRING sProfileResponse =sFileFolder+"21_profile.dat"
			[ ] // STRING sAdminLogonResponse =sFileFolder+"2_Logon_Admin_Req.dat"
			[ ] // STRING sAddedCustomerResponse =sFileFolder+"3_Add_Cust_resp.dat"
			[ ] // STRING sAdminLogoutResponse =sFileFolder+"4_Logout_Admin_Resp.dat"
			[ ] // 
			[ ] // STRING sCustLogonResponse =sFileFolder+"5_Logon_Cust_resp.dat"
			[ ] // STRING sGetInstitutionalResponse =sFileFolder+"6_Get_Institutetion_Resp.dat"
			[ ] // STRING sDiscoverAccountInstitutionalResponse =sFileFolder+"7_Discover_Account_Intractive_Resp.dat"
			[ ] // 
			[ ] // STRING sLogoutResponseCustomer =sFileFolder+"8_Logout_Resp_Cust.dat"
			[ ] // STRING sLogonResponseCustomer =sFileFolder+"9_logon_Resp_Cust.dat"
			[ ] // STRING sAddAccountResponse =sFileFolder+"10_Add_Account_Resp.dat"
			[ ] // 
			[ ] // STRING sRefreshAccountInteractiveResponse =sFileFolder+"11_Refresh_Account_Interactive_Resp.dat"
			[ ] // STRING sGetAccountResponse =sFileFolder+"12_Get_Account_Resp.dat"
			[ ] // STRING sLogOutResponse =sFileFolder+"13_Logout_resp.dat"
			[ ] // 
			[ ] // 
			[ ] // STRING sLogOnResponse =sFileFolder+"14_Logon_Resp.dat"
			[ ] // STRING sGetInstitutionalResponse1 =sFileFolder+"15_Get_Instutitional_Resp.dat"
			[ ] // STRING sGetAccountResponse1=sFileFolder+"16_Get_Accounts_Resp.dat"
			[ ] // 
			[ ] // STRING sGetRefreshAccountInteractiveResponse =sFileFolder+"17_Refresh_Account_Intractive_Resp.dat"
			[ ] // STRING sGetAccountTransaction =sFileFolder+"18_CCGetAccountTransactions.dat"
			[ ] // STRING sLogoutResponse =sFileFolder+"20_Logout_Resp.dat"
			[ ] // 
			[ ] // // STRING sCCCompareAccountKeyValRequest=sFileFolder+"22_CCCompareAccountKeyVal_Resp.dat"
			[ ] // 
			[ ] // //STRING sDestinationonliniFile=QUICKEN_CONFIG+"\Intu_onl.ini"
			[ ] // STRING sSourceOlnIniFile="{ROOT_PATH}\ApplicationSpecific\Tools\intuonl\Release\intu_onl.ini"
			[ ] // STRING sDestinationonliniFile="{QUICKEN_CONFIG}\intu_onl.ini"
		[ ] // 
		[ ] // 
		[ ] // // // Create a new data file for Online account
		[ ] // // iCreateDataFile = DataFileCreate(sOnlineAccountFileName)
		[+] // // if (iCreateDataFile==FAIL)
			[ ] // // ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sOnlineAccountFileName} is created")
		[ ] // 
		[ ] // // Local Web request window should not come 
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // LaunchQuicken()
		[ ] // 
		[ ] // //OFF the prefrences settings of Auto accept transaction
		[-] // if (QuickenWindow.Exists(25))
			[ ] // // Navigate to Edit > Preferences
			[ ] // QuickenWindow.SetActive()
			[ ] // QuickenWindow.Edit.Click()
			[ ] // QuickenWindow.Edit.Preferences.Select()
			[ ] // 
			[-] // if(Preferences.Exists(2))
				[ ] // sHandle = Str(Preferences.SelectPreferenceType1.ListBox1.GetHandle())
				[ ] // sExpected = "Downloaded Transactions"
				[ ] // // find the Register option in Prefernces window
				[+] // for( i = 11; i<=15; i++)
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
					[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
					[+] // if(bMatch == TRUE)
						[ ] // bFlag=TRUE
						[ ] // QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(i))		// Select Download Transactions option
						[ ] // break
					[+] // else
						[ ] // bFlag = FALSE
						[+] // if(i==15)
							[ ] // ReportStatus("Validate Download Transaction option'", FAIL, "Download Transaction option is not available") 
						[+] // else
							[ ] // continue
						[ ] // 
				[ ] // 
				[ ] // // Check the avalability of the checkbox
				[+] // if(bFlag== TRUE)
					[+] // if(Preferences.AutomaticallyAddDownloadedT.Exists(5))
						[ ] // // Check the checkbox if it is unchecked
						[+] // if(Preferences.AutomaticallyAddDownloadedT.IsChecked())
							[ ] // Preferences.AutomaticallyAddDownloadedT.UnCheck ()
							[ ] // Preferences.OK.Click()
						[+] // else
							[ ] // Preferences.OK.Click()
							[ ] // 
					[+] // else
						[ ] // Preferences.Close()
				[ ] // 
			[+] // else
				[+] // bFlag= FALSE
					[ ] // 
		[ ] // 
		[ ] // 
		[ ] // // Add Online Account
		[ ] // ExpandAccountBar()
		[ ] // 
		[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[ ] // AddAccount.Checking.Click()//Spending.Select("Checking")
		[ ] // //AddAccount.Next.Click()
		[ ] // AddAnyAccount.VerifyEnabled(TRUE, 500)
		[ ] // AddAnyAccount.SetActive()
		[ ] // AddAnyAccount.Panel.QWHtmlView1.Click(1,70,5)
		[ ] // AddAnyAccount.EnterYourFIName.TypeKeys("Wells Fargo Bank")
		[ ] // ////Commented on Nov27 2012 as EWC selection screen wan't appearing always////
		[ ] // ////AddAnyAccount.BankName.SetText("Wells Fargo Bank")
		[ ] // AddAnyAccount.Next.Click()
		[ ] // 
		[ ] // // Provide different DAT files for Local file responses
		[+] // if (FakeResponse.Exists(5) == TRUE)
			[ ] // iResponseStatus = EnterFakeResponseFile(sBrandingResponse)
			[ ] // ReportStatus("Branding Response", iResponseStatus, "Fake Response - {sBrandingResponse} is entered")
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Fake Respose Window", WARN, "Branding Response is not asked") 
			[ ] // 
		[ ] // // AddAnyAccount.Next.Click()
		[+] // if (AddAnyAccount.Exists(5) == TRUE)
			[ ] // AddAnyAccount.SetActive()
			[ ] // AddAnyAccount.Next.Click()
			[ ] // AddAnyAccount.BankMemberNumber.SetText(sMFCUAccountId)
			[ ] // AddAnyAccount.BankPassword.SetText(sMFCUAccountId)			// Any random passord is OK
			[ ] // AddAnyAccount.Next.Click()
			[ ] // 
			[+] // if (FakeResponse.Exists(15) == TRUE)
				[ ] // // // // iResponseStatus = EnterFakeResponseFile(sProfileResponse)
				[ ] // // // // ReportStatus("Profile Response", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sAdminLogonResponse)
				[ ] // ReportStatus("Admin Logon Response ", iResponseStatus, "Fake Response - {sAdminLogonResponse} is entered")
				[ ] // 
				[ ] // // // iResponseStatus = EnterFakeResponseFile(sLogonResponseCustomer)
				[ ] // // // ReportStatus("Log on Response Customer ", iResponseStatus, "Fake Response - {sLogonResponseCustomer} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sAddedCustomerResponse)
				[ ] // ReportStatus("Added Customer Response ", iResponseStatus, "Fake Response - {sAddedCustomerResponse} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sAdminLogoutResponse)
				[ ] // ReportStatus("Admin Logout Response", iResponseStatus, "Fake Response - {sAdminLogoutResponse} is entered")
				[ ] // // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sCustLogonResponse)
				[ ] // ReportStatus("Customer  Logon Response ", iResponseStatus, "Fake Response - {sCustLogonResponse} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sGetInstitutionalResponse)
				[ ] // ReportStatus("Get Institutional Response ", iResponseStatus, "Fake Response - {sGetInstitutionalResponse} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sDiscoverAccountInstitutionalResponse)
				[ ] // ReportStatus("Discover Account Institutional Response", iResponseStatus, "Fake Response - {sDiscoverAccountInstitutionalResponse} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sLogoutResponseCustomer)
				[ ] // ReportStatus("Logout Response Customer ", iResponseStatus, "Fake Response - {sLogoutResponseCustomer} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sLogonResponseCustomer)
				[ ] // ReportStatus("Log on Response Customer ", iResponseStatus, "Fake Response - {sLogonResponseCustomer} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sAddAccountResponse)
				[ ] // ReportStatus("Add Account Response ", iResponseStatus, "Fake Response - {sAddAccountResponse} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sRefreshAccountInteractiveResponse)
				[ ] // ReportStatus("Refresh Account Interactive Response ", iResponseStatus, "Fake Response - {sRefreshAccountInteractiveResponse} is entered")
				[ ] // 
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sGetAccountResponse)
				[ ] // ReportStatus("Get Account Response ", iResponseStatus, "Fake Response - {sGetAccountResponse} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sLogOutResponse)
				[ ] // ReportStatus("Log Out Response ", iResponseStatus, "Fake Response - {sLogOutResponse} is entered")
				[ ] // // 
				[ ] // // iResponseStatus = EnterFakeResponseFile(sLogoutResponseCustomer)
				[ ] // // ReportStatus("Logout Response Customer ", iResponseStatus, "Fake Response - {sLogoutResponseCustomer} is entered")
				[ ] // 
				[ ] // 
				[+] // if(AddAnyAccount.Exists(SHORT_SLEEP))
					[ ] // AddAnyAccount.SetActive()
					[+] // if(AddAnyAccount.BankAccounts.ListBox1.Exists(5))
						[ ] // AddAnyAccount.SetActive()
						[ ] // AddAnyAccount.TypeKeys(Replicate(KEY_TAB, 5))
						[ ] // AddAnyAccount.BankAccounts.ListBox1.PopupList1.Select ("Checking")	
					[ ] // AddAnyAccount.Next.Click()
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sProfileResponse)
				[ ] // ReportStatus("Profile Response", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
				[ ] // 
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sLogOnResponse)
				[ ] // ReportStatus("Log on Response ", iResponseStatus, "Fake Response - {sLogOnResponse} is entered")
				[ ] // 
				[ ] // // 
				[ ] // // iResponseStatus = EnterFakeResponseFile(sCCCompareAccountKeyValRequest)
				[ ] // // ReportStatus("Compare Account Key Val Response ", iResponseStatus, "Fake Response - {sCCCompareAccountKeyValRequest} is entered")
				[ ] // // 
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sGetAccountResponse1)
				[ ] // ReportStatus("Get IAccount Response ", iResponseStatus, "Fake Response - {sGetAccountResponse1} is entered")
				[ ] // 
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sGetRefreshAccountInteractiveResponse)
				[ ] // ReportStatus("Get Refresh Account Interactive Response ", iResponseStatus, "Fake Response - {sGetRefreshAccountInteractiveResponse} is entered")
				[ ] // 
				[ ] // 
				[ ] // // iResponseStatus = EnterFakeResponseFile(sGetAccountResponse1)
				[ ] // // ReportStatus("Get IAccount Response ", iResponseStatus, "Fake Response - {sGetAccountResponse1} is entered")
				[ ] // 
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sGetAccountTransaction)
				[ ] // ReportStatus("Get  Account  Transaction Response ", iResponseStatus, "Fake Response - {sGetAccountTransaction} is entered")
				[ ] // 
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sLogoutResponse)
				[ ] // ReportStatus("Log out  Response ", iResponseStatus, "Fake Response - {sLogoutResponse} is entered")
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // // //Closing Local web Request popup
				[+] // if(LocalWebRequest.Exists(15))
					[ ] // // LocalWebRequest.VerifyEnabled(TRUE, 20)
					[ ] // LocalWebRequest.SetActive()
					[ ] // LocalWebRequest.FailRequest.Click ()
				[ ] // 
				[ ] // // //Complete the process by clicking on Finish button
				[ ] // WaitForState(AccountAdded,TRUE,15)
				[ ] // AccountAdded.Finish.Click()
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Fake Respose Window", FAIL, "Fake Respose window is not available") 
				[ ] // 
		[+] // else
			[ ] // ReportStatus("Checking Account Window", FAIL, "Checking Account window is not available") 
			[ ] // 
		[ ] // 
		[ ] // //Verify Accounts are displayed on Account Bar
		[ ] // QuickenWindow.SetActive()
		[ ] // hWnd = str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
		[ ] // 
		[ ] // 
		[ ] // //Verify Checking account on AccountBar
		[ ] // sActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
		[ ] // bMatchStatus = MatchStr("*{sCheckingAccount}*", sActualOutput)
		[+] // if (bMatchStatus == TRUE)
			[ ] // ReportStatus("Validate Checking Account", PASS, "Checking Account -  {sCheckingAccount} is present in Account Bar") 
		[+] // else
			[ ] // ReportStatus("Validate Checking Account", FAIL, "Actual -  {sActualOutput} is not matching with Expected - {sCheckingAccount}") 
			[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // INTEGER iResult=BeaconVerification(sActualCount,sExpEndingbalance,sExpOnlineBalance)
		[+] // if(iResult==PASS)
			[ ] // ReportStatus("Beacon verification", PASS, "All verification matching correctly")
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Beacon verification", FAIL, "All verification not matching correctly")
			[ ] // 
		[ ] // 
		[+] // // //Cleanup
			[ ] // // //Close Quicken
			[ ] // // QuickenWindow.Close()
			[ ] // // WaitForState(QuickenWindow,FALSE,5)
			[ ] // // 
			[ ] // // //Delete qa_acc32.dll
			[ ] // // //DeleteFile(sIntuonlDestinationPath)
			[ ] // // 
			[ ] // // // Delete file intu_onl.ini located in WIndows directory
			[ ] // // DeleteFile(SYS_GetEnv("WINDIR") + "\\intu_onl.ini")
			[ ] // // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[ ] // // // //###########################################################################
	[ ] // 
	[+] // // //############# Perform one step update using local files ##############################
		[ ] // // // ********************************************************
		[+] // // // TestCase Name:	 Test2_OneStepUpdateForWellsFargo()
			[ ] // // //
			[ ] // // // DESCRIPTION:
			[ ] // // // This testcase will perform one step update for Wells Fargo Bank. .
			[ ] // // // Using Localfile Testing mechansim.
			[ ] // // //
			[ ] // // // PARAMETERS:	none
			[ ] // // //
			[ ] // // // RETURNS:			Pass 		If no error occurs while updating account 							
			[ ] // // //						Fail		If any error occurs
			[ ] // // //
			[ ] // // // REVISION HISTORY:
			[ ] // // //	  Jun 08, 2011		Puja Verma created	
		[ ] // // //*********************************************************
	[-] // testcase Test2_OneStepUpdateForWellsFargo() appstate none
		[+] // // Variable
			[ ] // STRING sOnlieAccountFilePath = AUT_DATAFILE_PATH + "\" + sOnlineAccountFileName + ".QDF"
			[ ] // 
			[ ] // 
			[ ] // INTEGER iOpenDataFile
			[ ] // STRING sCaption
			[ ] // BOOLEAN bCaption
			[ ] // STRING sActualCount ="0"
			[ ] // STRING sFileFolder=AUT_DATAFILE_PATH + "\Beacon data\OSULOG\"
			[ ] // STRING sProfileResponse =sFileFolder+"21_profile.dat"
			[ ] // STRING sLogOnResponse=sFileFolder+"1_Logon_Response.dat"
			[ ] // STRING sGetInstitutionalResponse=sFileFolder+"2_Get_Institutional_Resp.dat"
			[ ] // STRING sGetAccountResponse=sFileFolder+"3_Get_Account_Resp.dat"
			[ ] // STRING sRefreshAccountInteractiveResponse=sFileFolder+"4_Refresh_account_Interactive_Resp.dat"
			[ ] // STRING sAccountTransactionResponse=sFileFolder+"5_CCGetAccountTransactions.dat"
			[ ] // STRING sLogOutResponse=sFileFolder+"6_Logout_Resp.dat"
			[ ] // STRING sCCCompareAccountKeyValRequest=sFileFolder+"22_CCCompareAccountKeyVal_Resp.dat"
			[ ] // 
			[ ] // 
		[ ] // 
		[ ] // 
		[ ] // //OFF the prefrences settings of Auto accept transaction
		[-] // if (QuickenWindow.Exists(5))
			[ ] // // Navigate to Edit > Preferences
			[ ] // QuickenWindow.SetActive()
			[ ] // QuickenWindow.Edit.Click()
			[ ] // QuickenWindow.Edit.Preferences.Select()
			[ ] // 
			[-] // if(Preferences.Exists(2))
				[ ] // sHandle = Str(Preferences.SelectPreferenceType1.ListBox1.GetHandle())
				[ ] // sExpected = "Downloaded Transactions"
				[ ] // // find the Register option in Prefernces window
				[+] // for( i = 11; i<=15; i++)
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
					[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
					[+] // if(bMatch == TRUE)
						[ ] // bFlag=TRUE
						[ ] // QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(i))		// Select Download Transactions option
						[ ] // break
					[+] // else
						[ ] // bFlag = FALSE
						[+] // if(i==15)
							[ ] // ReportStatus("Validate Download Transaction option'", FAIL, "Download Transaction option is not available") 
						[+] // else
							[ ] // continue
						[ ] // 
				[ ] // 
				[ ] // // Check the avalability of the checkbox
				[+] // if(bFlag== TRUE)
					[+] // if(Preferences.AutomaticallyAddDownloadedT.Exists(5))
						[ ] // // Check the checkbox if it is unchecked
						[+] // if(Preferences.AutomaticallyAddDownloadedT.IsChecked())
							[ ] // Preferences.AutomaticallyAddDownloadedT.UnCheck ()
							[ ] // Preferences.OK.Click()
						[+] // else
							[ ] // Preferences.OK.Click()
							[ ] // 
					[+] // else
						[ ] // Preferences.Close()
				[ ] // 
			[+] // else
				[+] // bFlag= FALSE
					[ ] // 
		[ ] // 
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // //Click on one step update 
		[ ] // INTEGER iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
		[ ] // 
		[+] // if(iNavigate == PASS)
			[ ] // 
			[+] // // if(QuickenConnectedServices.Exists(10))
				[ ] // // RegisterQuickenConnectedServices()
				[ ] // // 
			[+] // // else
				[ ] // // ReportStatus("Verify if Quicken Connected Services window is displayed",WARN,"Quicken Connected Services window is not displayed")
				[ ] // // 
				[ ] // // 
			[ ] // 
			[+] // if(OneStepUpdate.Exists(10))
				[ ] // OneStepUpdate.SetActive ()
				[ ] // // OneStepUpdate.UpdateNow.Click ()		// click on Update button
			[ ] // 
			[ ] // //QuickenMainWindow.QWNavigator.Update_Accounts.Click()
			[ ] // //Entering password
			[ ] // OneStepUpdate.OneStepUpdateSettings3.ListBox1.AccountPassword.SetText("12345")
			[ ] // 
			[ ] // 
			[ ] // OneStepUpdate.UpdateNow.Click ()		// click on Update button
			[ ] // 
			[+] // if(SetUpYourPasswordVault.Exists(5))
				[ ] // SetUpYourPasswordVault.Cancel.Click()
				[ ] // 
				[ ] // 
				[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // //Providing response files
			[ ] // 
			[ ] // iResponseStatus = EnterFakeResponseFile(sProfileResponse)
			[ ] // ReportStatus("Profile Response", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
			[ ] // 
			[ ] // iResponseStatus = EnterFakeResponseFile(sLogOnResponse)
			[ ] // ReportStatus("Log On Response", iResponseStatus, "Fake Response - {sLogOnResponse} is entered")
			[ ] // 
			[ ] // // iResponseStatus = EnterFakeResponseFile(sCCCompareAccountKeyValRequest)
			[ ] // // ReportStatus("Compare Account Key Val Response ", iResponseStatus, "Fake Response - {sCCCompareAccountKeyValRequest} is entered")
			[ ] // 
			[ ] // iResponseStatus = EnterFakeResponseFile(sGetAccountResponse)
			[ ] // ReportStatus("Get Account Response", iResponseStatus, "Fake Response - {sGetAccountResponse} is entered")
			[ ] // 
			[ ] // iResponseStatus = EnterFakeResponseFile(sRefreshAccountInteractiveResponse)
			[ ] // ReportStatus("Refresh Account Interactive Response", iResponseStatus, "Fake Response - {sRefreshAccountInteractiveResponse} is entered")
			[ ] // 
			[ ] // iResponseStatus = EnterFakeResponseFile(sAccountTransactionResponse)
			[ ] // ReportStatus("Account Transaction Response", iResponseStatus, "Fake Response - {sAccountTransactionResponse} is entered")
			[ ] // 
			[ ] // iResponseStatus = EnterFakeResponseFile(sLogOutResponse)
			[ ] // ReportStatus("Log Out Response", iResponseStatus, "Fake Response - {sLogOutResponse} is entered")
			[ ] // 
			[ ] // 
			[+] // if(OneStepUpdateSummary.Exists(5))
				[ ] // OneStepUpdateSummary.Close()
				[ ] // 
			[ ] // 
			[ ] // //Calling verification function
			[ ] // INTEGER iResult=BeaconVerification(sActualCount,sExpEndingbalance,sExpOnlineBalance)
			[+] // if(iResult==PASS)
				[ ] // ReportStatus("Beacon verification", PASS, "All verification matching correctly")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Beacon verification", FAIL, "All verification not matching correctly")
			[ ] // 
			[ ] //  
		[+] // else
			[ ] // ReportStatus("OSU online account ",FAIL,"OSU window Not opened properly" )
		[ ] // 
		[ ] // 
	[ ] // // //#########################################################################
	[ ] // 
	[+] // // //############# Perform Update Now using local files ##############################
		[ ] // // // ********************************************************
		[+] // // // TestCase Name:	 Test3_UpdateNowForWellsFargo()
			[ ] // // //
			[ ] // // // DESCRIPTION:
			[ ] // // // This testcase will perform  update now for Wells Fargo Bank. .
			[ ] // // // Using Localfile Testing mechansim.
			[ ] // // //
			[ ] // // // PARAMETERS:	none
			[ ] // // //
			[ ] // // // RETURNS:			Pass 		If no error occurs while updating account 							
			[ ] // // //						Fail		If any error occurs
			[ ] // // //
			[ ] // // // REVISION HISTORY:
			[ ] // // //	  Jun 20, 2011		Puja Verma created	
		[ ] // // //*********************************************************
	[-] // testcase Test3_UpdateNowForWellsFargo() appstate none
		[+] // // Variable
			[ ] // 
			[ ] // INTEGER iNavigate,iSelect=2
			[ ] // 
			[ ] // STRING sCaption
			[ ] // BOOLEAN bCaption
			[ ] // INTEGER iXCords = 38
			[ ] // INTEGER iYCords = 5
			[ ] // STRING sActualCount ="0"
			[ ] // 
			[ ] // STRING sFileFolder=AUT_DATAFILE_PATH + "\Beacon data\UpdateNowdatFiles\"
			[ ] // STRING sProfileResponse =sFileFolder+"21_profile.dat"
			[ ] // STRING sLogOnResponse=sFileFolder+"1_LogonResp.dat"
			[ ] // STRING sGetInstitutionalResponse=sFileFolder+"2_Get_Institutional_Resp.dat"
			[ ] // STRING sGetAccountResponse=sFileFolder+"3_Get_Account_resp.dat"
			[ ] // STRING sRefreshAccountInteractiveResponse=sFileFolder+"4_Refresh_account_interactive_resp.dat"
			[ ] // STRING sAccountTransactionResponse=sFileFolder+"5_CCGetAccountTransactions.dat"
			[ ] // STRING sLogOutResponse=sFileFolder+"6_Logout_Resp.dat"
			[ ] // STRING sCCCompareAccountKeyValRequest=sFileFolder+"22_CCCompareAccountKeyVal_Resp.dat"
			[ ] // 
		[ ] // 
		[ ] // //Test
		[+] // // if(QuickenWindow.Exists(5))
			[ ] // // QuickenWindow.Kill()
			[ ] // // WaitForState(QuickenWindow,FALSE,5)
		[+] // // if (!QuickenWindow.Exists(5))
			[ ] // // App_Start(sCmdLine)
			[ ] // // WaitForState(QuickenWindow,TRUE,10)
			[ ] // // 
			[ ] // // 
		[ ] // 
		[ ] // //TURN OFF the prefrences settings of Auto accept transaction
		[-] // if (QuickenWindow.Exists(5))
			[ ] // // Navigate to Edit > Preferences
			[ ] // QuickenWindow.SetActive()
			[ ] // QuickenWindow.Edit.Click()
			[ ] // QuickenWindow.Edit.Preferences.Select()
			[ ] // 
			[-] // if(Preferences.Exists(5))
				[ ] // sHandle = Str(Preferences.SelectPreferenceType1.ListBox1.GetHandle())
				[ ] // sExpected = "Downloaded Transactions"
				[ ] // // find the Register option in Prefernces window
				[+] // for( i = 11; i<=15; i++)
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
					[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
					[+] // if(bMatch == TRUE)
						[ ] // bFlag=TRUE
						[ ] // QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(i))		// Select Download Transactions option
						[ ] // break
					[+] // else
						[ ] // bFlag = FALSE
						[+] // if(i==15)
							[ ] // ReportStatus("Validate Download Transaction option'", FAIL, "Download Transaction option is not available") 
						[+] // else
							[ ] // continue
						[ ] // 
				[ ] // 
				[ ] // // Check the avalability of the checkbox
				[+] // if(bFlag== TRUE)
					[+] // if(Preferences.AutomaticallyAddDownloadedT.Exists(5))
						[ ] // // Check the checkbox if it is unchecked
						[+] // if(Preferences.AutomaticallyAddDownloadedT.IsChecked())
							[ ] // Preferences.AutomaticallyAddDownloadedT.UnCheck ()
							[ ] // Preferences.OK.Click()
						[+] // else
							[ ] // Preferences.OK.Click()
							[ ] // 
					[+] // else
						[ ] // Preferences.Close()
				[ ] // 
			[+] // else
				[+] // bFlag= FALSE
					[ ] // 
			[ ] // 
			[ ] // 
		[ ] // 
		[ ] // //OpenDataFile(sOnlineAccountFileName)
		[ ] // 
		[+] // if(QuickenWindow.Exists(5))
			[ ] // UsePopupRegister("OFF")			
			[ ] // 
		[ ] // 
		[ ] // 
		[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.Click(1,iXCords, iYCords)
		[ ] // 
		[ ] // //Select Update Now from Acccount Actions
		[ ] // iNavigate=NavigateToAccountActionBanking(iSelect)
		[+] // if(iNavigate==PASS)
			[+] // if(OnlineUpdateForThisAccount.Exists(10))
				[ ] // OnlineUpdateForThisAccount.SetActive()
				[ ] // OnlineUpdateForThisAccount.QWListViewer.ListBox.TextField.SetText("12345")
				[ ] // OnlineUpdateForThisAccount.UpdateNowButton.Click()
				[ ] // 
				[+] // if(SetUpYourPasswordVault.Exists(5))
					[ ] // SetUpYourPasswordVault.Cancel.Click()
					[ ] // 
					[ ] // 
					[ ] // 
				[ ] // 
				[ ] // // 
				[+] // // if(OneStepUpdatePasswordConf.Exists(5))
					[ ] // // OneStepUpdatePasswordConf.SetActive()
					[ ] // // OneStepUpdatePasswordConf.No.Click()
					[ ] // // 
				[+] // // else
					[ ] // // print("Password confirmation not coming")
				[ ] // 
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sProfileResponse)
				[ ] // ReportStatus("Profile Response", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
				[ ] // 
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sLogOnResponse)
				[ ] // ReportStatus("Log On Response", iResponseStatus, "Fake Response - {sLogOnResponse} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sGetInstitutionalResponse)
				[ ] // ReportStatus("Get Institutional Response", iResponseStatus, "Fake Response - {sGetInstitutionalResponse} is entered")
				[ ] // 
				[ ] // // iResponseStatus = EnterFakeResponseFile(sCCCompareAccountKeyValRequest)
				[ ] // // ReportStatus("Compare Account Key Val Response ", iResponseStatus, "Fake Response - {sCCCompareAccountKeyValRequest} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sGetAccountResponse)
				[ ] // ReportStatus("Get Account Response", iResponseStatus, "Fake Response - {sGetAccountResponse} is entered")
				[ ] // 
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sRefreshAccountInteractiveResponse)
				[ ] // ReportStatus("Refresh Account Interactive Response", iResponseStatus, "Fake Response - {sRefreshAccountInteractiveResponse} is entered")
				[ ] // 
				[ ] // 
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sAccountTransactionResponse)
				[ ] // ReportStatus("Account Transaction Response", iResponseStatus, "Fake Response - {sAccountTransactionResponse} is entered")
				[ ] // 
				[ ] // iResponseStatus = EnterFakeResponseFile(sLogOutResponse)
				[ ] // ReportStatus("Log Out Response", iResponseStatus, "Fake Response - {sLogOutResponse} is entered")
				[ ] // 
				[ ] // 
				[ ] // 
				[+] // if(OneStepUpdateSummary.Exists(5))
					[ ] // OneStepUpdateSummary.Close()
					[ ] // 
				[ ] // 
				[ ] // 
				[ ] // //Calling verification function
				[ ] // INTEGER iResult=BeaconVerification(sActualCount,sExpEndingbalance,sExpOnlineBalance)
				[+] // if(iResult==PASS)
					[ ] // ReportStatus("Beacon verification", PASS, "All verification matching correctly")
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Beacon verification", FAIL, "All verification not matching correctly")
					[ ] // 
				[+] // // else
					[ ] // // ReportStatus("Update now window is not present",FAIL,"Update now window is not presen")
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("online account ",FAIL,"Not opened properly" )
		[+] // else
			[ ] // ReportStatus("Navigate to account Actions",FAIL,"Option from Account actions not selected")
			[ ] // 
		[ ] // 
		[ ] // 
	[ ] // //###########################################################################
	[ ] // 
	[+] // //############# Beacon Clean ############# #####################################
		[ ] // // ********************************************************
		[+] // // TestCase Name:	 BeaconClean()
			[ ] // //
			[ ] // // DESCRIPTION:
			[ ] // // This testcase will close Quicken, Delete Ini . file and Data File
			[ ] // //
			[ ] // // PARAMETERS:	none
			[ ] // //
			[ ] // // RETURNS:			Pass 		if no error occurs while closing the window							
			[ ] // //						Fail		if any error occurs
			[ ] // //
			[ ] // // REVISION HISTORY:
			[ ] // //	  June 23, 2011		Puja Verma  created	
		[ ] // //*********************************************************
	[+] // testcase BeaconClean() appstate none
		[+] // //VARAIBLE
			[ ] // STRING sDestinationonliniFile="{QUICKEN_CONFIG}\intu_onl.ini"
		[ ] // 
		[+] // if(QuickenWindow.Exists(5) == TRUE)
			[ ] // QuickenWindow.Kill()
			[ ] // WaitForState(QuickenWindow,FALSE,5)
			[ ] // 
		[+] // if(FileExists(sDestinationonliniFile) == TRUE)
			[ ] // DeleteFile( sDestinationonliniFile)
		[+] // if(FileExists(sOnlineAccountFileName))
			[ ] // DeleteFile(sOnlineAccountFileName)
		[ ] // 
		[ ] // 
	[ ] // // //###########################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[+] //################ Beacon Setup ###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 BeaconSetup()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will copy few required files from original to temp location  if it exists
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	 Nov 17, 2011		Puja Verma created	
	[ ] //*********************************************************
[-] testcase BeaconSetup() appstate QuickenBaseState
	[ ] 
	[+] //VARIABLE
		[ ] INTEGER iLocalFileSetup, iSetupAutoAPI,iCreateDataFile
		[ ] STRING sOnlineAccountFilePath = AUT_DATAFILE_PATH + "\" + sOnlineAccountFileName + ".QDF"
		[ ] STRING sSourceOlnIniFile="{ROOT_PATH}\ApplicationSpecific\Tools\intuonl\Release\intu_onl.ini"
		[ ] BOOLEAN bDeleteStatus
		[ ] STRING sOriginalFolder="{AUT_DATAFILE_PATH}\Original Beacon data"
		[ ] STRING sTempFolder="{AUT_DATAFILE_PATH}\Beacon data"
	[ ] //Deleting existing folder 
	[+] if(SYS_DirExists(sTempFolder))
		[ ] bDeleteStatus=DeleteDir(sTempFolder)
		[ ] print(bDeleteStatus)
		[ ] 
		[ ] 
	[+] else
		[ ] print("no such folder exists")
	[ ] 
	[ ] MakeDir(sTempFolder)
	[+] if SYS_DirExists(sOriginalFolder)				
		[ ] CopyDir(sOriginalFolder,sTempFolder)		// copy Beacon  folder to Temporary folder
		[ ] 
	[+] else
		[ ] ReportStatus("Beacon Files and Folder",FAIL,"Beacon Files and Folders are not available in mentioned location")
	[ ] 
	[ ] //Delete Existing .ini folder
	[-] if(FileExists(sDestinationonliniFile) == TRUE)
		[ ] DeleteFile(sDestinationonliniFile)
	[ ] 
	[ ] 
	[ ] // Create a new data file for Online account
	[ ] iCreateDataFile = DataFileCreate(sOnlineAccountFileName)
	[+] if (iCreateDataFile==PASS)
		[ ] //Test
		[ ] //BypassRegistration()
		[ ] 
		[ ] // QuickenWindow.Tools.Click()
		[ ] // QuickenWindow.Tools.OneStepUpdate.Select()
		[ ] // RegisterQuickenConnectedServices()
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sOnlineAccountFileName} is NOT created")
	[ ] 
	[ ] 
	[ ] //Setup LocalFile Testing mechanism
	[ ] iLocalFileSetup = SetUpLocalFile()
	[ ] ReportStatus("LocalFile Setup", iLocalFileSetup, "LocalFile Testing Setup is performed") 
	[ ] 
	[ ] //Copying Ini file from source to destination folder
	[-] if(FileExists(sDestinationonliniFile) == FALSE)
		[ ] CopyFile(sSourceOlnIniFile, sDestinationonliniFile)
	[ ] 
	[+] if(FileExists(sOnlineAccountFilePath))
		[ ] DeleteFile(sOnlineAccountFilePath)
	[ ] 
	[ ] 
	[ ] /////C:\ProgramData\Intuit\Quicken\Config
	[ ] 
	[ ] 
[ ] // // //###########################################################################
[ ] 
[+] // //############# Add online account using local files ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test1_AddEWCWelsFargoAccount()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will create Online account forWells Fargo Bank. This will create a new data file and add Checking account .
		[ ] // Using Localfile Testing mechansim.
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		If no error occurs while creating online account 							
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Jun 03, 2011		Puja Verma created	
	[ ] //*********************************************************
[+] testcase Test1_AddEWCWellsFargoAccount () appstate none
	[+] //VARIABLES
		[ ] STRING hWnd, sActualOutput
		[ ] BOOLEAN bMatchStatus
		[ ] INTEGER iCreateDataFile, iLocalFileSetup, iIntuonlConfigure
		[ ] STRING sActualCount ="9"
		[ ] 
		[ ] STRING sOnlieAccountFilePath = AUT_DATAFILE_PATH + "\" + sOnlineAccountFileName + ".QDF"
		[ ] STRING sFileFolder=AUT_DATAFILE_PATH + "\Beacon data\AccountSetResponse\"
		[ ] //Respose files for Local File Testing
		[ ] STRING sBrandingResponse =sFileFolder+"1_Brand_Resp.dat"
		[ ] STRING sProfileResponse =sFileFolder+"21_profile.dat"
		[ ] STRING sAdminLogonResponse =sFileFolder+"2_Logon_Admin_Req.dat"
		[ ] STRING sAddedCustomerResponse =sFileFolder+"3_Add_Cust_resp.dat"
		[ ] STRING sAdminLogoutResponse =sFileFolder+"4_Logout_Admin_Resp.dat"
		[ ] 
		[ ] STRING sCustLogonResponse =sFileFolder+"5_Logon_Cust_resp.dat"
		[ ] STRING sGetInstitutionalResponse =sFileFolder+"6_Get_Institutetion_Resp.dat"
		[ ] STRING sDiscoverAccountInstitutionalResponse =sFileFolder+"7_Discover_Account_Intractive_Resp.dat"
		[ ] 
		[ ] STRING sLogoutResponseCustomer =sFileFolder+"8_Logout_Resp_Cust.dat"
		[ ] STRING sLogonResponseCustomer =sFileFolder+"9_logon_Resp_Cust.dat"
		[ ] STRING sAddAccountResponse =sFileFolder+"10_Add_Account_Resp.dat"
		[ ] 
		[ ] STRING sRefreshAccountInteractiveResponse =sFileFolder+"11_Refresh_Account_Interactive_Resp.dat"
		[ ] STRING sGetAccountResponse =sFileFolder+"12_Get_Account_Resp.dat"
		[ ] STRING sLogOutResponse =sFileFolder+"13_Logout_resp.dat"
		[ ] 
		[ ] 
		[ ] STRING sLogOnResponse =sFileFolder+"14_Logon_Resp.dat"
		[ ] STRING sGetInstitutionalResponse1 =sFileFolder+"15_Get_Instutitional_Resp.dat"
		[ ] STRING sGetAccountResponse1=sFileFolder+"16_Get_Accounts_Resp.dat"
		[ ] 
		[ ] STRING sGetRefreshAccountInteractiveResponse =sFileFolder+"17_Refresh_Account_Intractive_Resp.dat"
		[ ] STRING sGetAccountTransaction =sFileFolder+"18_CCGetAccountTransactions.dat"
		[ ] STRING sLogoutResponse =sFileFolder+"20_Logout_Resp.dat"
		[ ] 
		[ ] // STRING sCCCompareAccountKeyValRequest=sFileFolder+"22_CCCompareAccountKeyVal_Resp.dat"
		[ ] 
		[ ] //STRING sDestinationonliniFile=QUICKEN_CONFIG+"\Intu_onl.ini"
		[ ] STRING sSourceOlnIniFile="{ROOT_PATH}\ApplicationSpecific\Tools\intuonl\Release\intu_onl.ini"
		[ ] STRING sDestinationonliniFile="{QUICKEN_CONFIG}\intu_onl.ini"
	[ ] 
	[ ] //RelaunchQuicken
	[ ] LaunchQuicken()
	[ ] 
	[ ] 
	[ ] //OFF the prefrences settings of Auto accept transaction
	[-] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] // Navigate to Edit > Preferences
		[ ] 
		[ ] iResult=SelectPreferenceType("Downloaded transactions")
		[-] if(iResult==PASS)
			[ ] Preferences.SetActive()
			[ ] // Check the avalability of the checkbox
			[-] if(Preferences.AutomaticallyAddDownloadedT.Exists(5))
				[ ] // Check the checkbox if it is unchecked
				[+] if(Preferences.AutomaticallyAddDownloadedT.IsChecked())
					[ ] Preferences.AutomaticallyAddDownloadedT.UnCheck ()
				[ ] Preferences.OK.Click()
				[ ] WaitForState(Preferences , FALSE ,5)
				[ ] sleep(3)
				[ ] // Add Online Account
				[ ] QuickenWindow.SetActive()
				[ ] ExpandAccountBar()
				[ ] 
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
				[ ] AddAccount.Checking.Click()
				[ ] //AddAccount.Next.Click()
				[ ] AddAnyAccount.VerifyEnabled(TRUE, 500)
				[ ] AddAnyAccount.SetActive()
				[ ] // AddAnyAccount.Panel.QWHtmlView1.Click(1,70,5)
				[ ] AddAnyAccount.EnterYourFIName.TypeKeys("Wells Fargo Bank")
				[ ] ////Commented on Nov27 2012 as EWC selection screen wan't appearing always////
				[ ] ////AddAnyAccount.BankName.SetText("Wells Fargo Bank")
				[ ] AddAnyAccount.Next.Click()
				[ ] 
				[ ] // Provide different DAT files for Local file responses
				[+] if (FakeResponse.Exists(5) == TRUE)
					[ ] iResponseStatus = EnterFakeResponseFile(sBrandingResponse)
					[ ] ReportStatus("Branding Response", iResponseStatus, "Fake Response - {sBrandingResponse} is entered")
					[ ] 
				[+] else
					[ ] ReportStatus("Fake Respose Window", WARN, "Branding Response is not asked") 
					[ ] 
				[ ] // AddAnyAccount.Next.Click()
				[-] if (AddAnyAccount.Exists(5) == TRUE)
					[ ] AddAnyAccount.SetActive()
					[ ] AddAnyAccount.Next.Click()
					[ ] AddAnyAccount.BankMemberNumber.TypeKeys(sMFCUAccountId)
					[ ] AddAnyAccount.BankPassword.TypeKeys(sMFCUAccountId)			// Any random passord is OK
					[ ] AddAnyAccount.Next.Click()
					[ ] 
					[-] if (FakeResponse.Exists(15) == TRUE)
						[ ] iResponseStatus = EnterFakeResponseFile(sCustLogonResponse)
						[ ] ReportStatus("Customer  Logon Response ", iResponseStatus, "Fake Response - {sCustLogonResponse} is entered")
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sGetInstitutionalResponse)
						[ ] ReportStatus("Get Institutional Response ", iResponseStatus, "Fake Response - {sGetInstitutionalResponse} is entered")
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sDiscoverAccountInstitutionalResponse)
						[ ] ReportStatus("Discover Account Institutional Response", iResponseStatus, "Fake Response - {sDiscoverAccountInstitutionalResponse} is entered")
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sLogoutResponseCustomer)
						[ ] ReportStatus("Logout Response Customer ", iResponseStatus, "Fake Response - {sLogoutResponseCustomer} is entered")
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sLogonResponseCustomer)
						[ ] ReportStatus("Log on Response Customer ", iResponseStatus, "Fake Response - {sLogonResponseCustomer} is entered")
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sAddAccountResponse)
						[ ] ReportStatus("Add Account Response ", iResponseStatus, "Fake Response - {sAddAccountResponse} is entered")
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sRefreshAccountInteractiveResponse)
						[ ] ReportStatus("Refresh Account Interactive Response ", iResponseStatus, "Fake Response - {sRefreshAccountInteractiveResponse} is entered")
						[ ] 
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sGetAccountResponse)
						[ ] ReportStatus("Get Account Response ", iResponseStatus, "Fake Response - {sGetAccountResponse} is entered")
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sLogOutResponse)
						[ ] ReportStatus("Log Out Response ", iResponseStatus, "Fake Response - {sLogOutResponse} is entered")
						[ ] // 
						[ ] // iResponseStatus = EnterFakeResponseFile(sLogoutResponseCustomer)
						[ ] // ReportStatus("Logout Response Customer ", iResponseStatus, "Fake Response - {sLogoutResponseCustomer} is entered")
						[ ] 
						[ ] 
						[+] if(AddAnyAccount.Exists(SHORT_SLEEP))
							[ ] AddAnyAccount.SetActive()
							[+] if(AddAnyAccount.BankAccounts.ListBox1.Exists(5))
								[ ] AddAnyAccount.SetActive()
								[ ] AddAnyAccount.TypeKeys(Replicate(KEY_TAB, 5))
								[ ] AddAnyAccount.BankAccounts.ListBox1.PopupList1.Select ("Checking")	
							[ ] AddAnyAccount.Next.Click()
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sProfileResponse)
						[ ] ReportStatus("Profile Response", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
						[ ] 
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sLogOnResponse)
						[ ] ReportStatus("Log on Response ", iResponseStatus, "Fake Response - {sLogOnResponse} is entered")
						[ ] 
						[ ] // 
						[ ] // iResponseStatus = EnterFakeResponseFile(sCCCompareAccountKeyValRequest)
						[ ] // ReportStatus("Compare Account Key Val Response ", iResponseStatus, "Fake Response - {sCCCompareAccountKeyValRequest} is entered")
						[ ] // 
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sGetAccountResponse1)
						[ ] ReportStatus("Get IAccount Response ", iResponseStatus, "Fake Response - {sGetAccountResponse1} is entered")
						[ ] 
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sGetRefreshAccountInteractiveResponse)
						[ ] ReportStatus("Get Refresh Account Interactive Response ", iResponseStatus, "Fake Response - {sGetRefreshAccountInteractiveResponse} is entered")
						[ ] 
						[ ] 
						[ ] // iResponseStatus = EnterFakeResponseFile(sGetAccountResponse1)
						[ ] // ReportStatus("Get IAccount Response ", iResponseStatus, "Fake Response - {sGetAccountResponse1} is entered")
						[ ] 
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sGetAccountTransaction)
						[ ] ReportStatus("Get  Account  Transaction Response ", iResponseStatus, "Fake Response - {sGetAccountTransaction} is entered")
						[ ] 
						[ ] 
						[ ] iResponseStatus = EnterFakeResponseFile(sLogoutResponse)
						[ ] ReportStatus("Log out  Response ", iResponseStatus, "Fake Response - {sLogoutResponse} is entered")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] // //Closing Local web Request popup
						[+] if(LocalWebRequest.Exists(15))
							[ ] // LocalWebRequest.VerifyEnabled(TRUE, 20)
							[ ] LocalWebRequest.SetActive()
							[ ] LocalWebRequest.FailRequest.Click ()
						[ ] 
						[ ] // //Complete the process by clicking on Finish button
						[ ] WaitForState(AccountAdded,TRUE,15)
						[ ] AccountAdded.Finish.Click()
						[ ] 
						[+] if(DlgReplaceExistingID.Exists(200))
							[ ] DlgReplaceExistingID.SetActive()
							[ ] DlgReplaceExistingID.Close()
							[ ] sleep(3)
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify Accounts are displayed on Account Bar
						[ ] QuickenWindow.SetActive()
						[ ] hWnd = str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
						[ ] 
						[ ] 
						[ ] //Verify Checking account on AccountBar
						[ ] sActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
						[ ] bMatchStatus = MatchStr("*{sCheckingAccount}*", sActualOutput)
						[+] if (bMatchStatus == TRUE)
							[ ] ReportStatus("Validate Checking Account", PASS, "Checking Account -  {sCheckingAccount} is present in Account Bar") 
						[+] else
							[ ] ReportStatus("Validate Checking Account", FAIL, "Actual -  {sActualOutput} is not matching with Expected - {sCheckingAccount}") 
							[ ] 
						[ ] 
						[ ] 
						[ ]  iResult=BeaconVerification(sActualCount,sExpEndingbalance,sExpOnlineBalance)
						[+] if(iResult==PASS)
							[ ] ReportStatus("Beacon verification", PASS, "All verification matching correctly")
							[ ] 
						[+] else
							[ ] ReportStatus("Beacon verification", FAIL, "All verification not matching correctly")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Fake Respose Window", FAIL, "Fake Respose window is not available") 
						[ ] 
				[+] else
					[ ] ReportStatus("Checking Account Window", FAIL, "Checking Account window is not available") 
					[ ] 
			[+] else
				[ ] Preferences.Close()
			[ ] 
			[ ] 
		[+] else
			[+] bFlag= FALSE
				[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] // // //###########################################################################
[ ] 
[+] // //############# Perform one step update using local files ##############################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test2_OneStepUpdateForWellsFargo()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will perform one step update for Wells Fargo Bank. .
		[ ] // // Using Localfile Testing mechansim.
		[ ] // //
		[ ] // // PARAMETERS:	none
		[ ] // //
		[ ] // // RETURNS:			Pass 		If no error occurs while updating account 							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //	  Jun 08, 2011		Puja Verma created	
	[ ] // //*********************************************************
[+] testcase Test2_OneStepUpdateForWellsFargo() appstate none
	[+] // Variable
		[ ] STRING sOnlieAccountFilePath = AUT_DATAFILE_PATH + "\" + sOnlineAccountFileName + ".QDF"
		[ ] 
		[ ] 
		[ ] INTEGER iOpenDataFile
		[ ] STRING sCaption
		[ ] BOOLEAN bCaption
		[ ] STRING sActualCount ="0"
		[ ] STRING sFileFolder=AUT_DATAFILE_PATH + "\Beacon data\OSULOG\"
		[ ] STRING sProfileResponse =sFileFolder+"21_profile.dat"
		[ ] STRING sLogOnResponse=sFileFolder+"1_Logon_Response.dat"
		[ ] STRING sGetInstitutionalResponse=sFileFolder+"2_Get_Institutional_Resp.dat"
		[ ] STRING sGetAccountResponse=sFileFolder+"3_Get_Account_Resp.dat"
		[ ] STRING sRefreshAccountInteractiveResponse=sFileFolder+"4_Refresh_account_Interactive_Resp.dat"
		[ ] STRING sAccountTransactionResponse=sFileFolder+"5_CCGetAccountTransactions.dat"
		[ ] STRING sLogOutResponse=sFileFolder+"6_Logout_Resp.dat"
		[ ] STRING sCCCompareAccountKeyValRequest=sFileFolder+"22_CCCompareAccountKeyVal_Resp.dat"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //OFF the prefrences settings of Auto accept transaction
	[-] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Click on one step update 
		[ ]  iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
		[ ] 
		[-] if(iNavigate == PASS)
			[ ] 
			[ ] 
			[-] if(DlgUnlockYourPasswordVault.Exists(5))
				[ ] DlgUnlockYourPasswordVault.SkipButton.Click()
				[ ] //.Cancel.Click()
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[-] if(OneStepUpdate.Exists(10))
				[ ] OneStepUpdate.SetActive ()
				[ ] // OneStepUpdate.UpdateNow.Click ()		// click on Update button
			[ ] 
			[ ] //QuickenMainWindow.QWNavigator.Update_Accounts.Click()
			[ ] //Entering password
			[ ] OneStepUpdate.OneStepUpdateSettings3.ListBox1.AccountPassword.TypeKeys("12345")
			[ ] 
			[ ] 
			[ ] OneStepUpdate.UpdateNow.Click ()		// click on Update button
			[ ] 
			[+] if(SetUpYourPasswordVault.Exists(5))
				[ ] SetUpYourPasswordVault.Cancel.Click()
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Providing response files
			[ ] 
			[ ] iResponseStatus = EnterFakeResponseFile(sProfileResponse)
			[ ] ReportStatus("Profile Response", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
			[ ] 
			[ ] iResponseStatus = EnterFakeResponseFile(sLogOnResponse)
			[ ] ReportStatus("Log On Response", iResponseStatus, "Fake Response - {sLogOnResponse} is entered")
			[ ] 
			[ ] // iResponseStatus = EnterFakeResponseFile(sCCCompareAccountKeyValRequest)
			[ ] // ReportStatus("Compare Account Key Val Response ", iResponseStatus, "Fake Response - {sCCCompareAccountKeyValRequest} is entered")
			[ ] 
			[ ] iResponseStatus = EnterFakeResponseFile(sGetAccountResponse)
			[ ] ReportStatus("Get Account Response", iResponseStatus, "Fake Response - {sGetAccountResponse} is entered")
			[ ] 
			[ ] iResponseStatus = EnterFakeResponseFile(sRefreshAccountInteractiveResponse)
			[ ] ReportStatus("Refresh Account Interactive Response", iResponseStatus, "Fake Response - {sRefreshAccountInteractiveResponse} is entered")
			[ ] 
			[ ] iResponseStatus = EnterFakeResponseFile(sAccountTransactionResponse)
			[ ] ReportStatus("Account Transaction Response", iResponseStatus, "Fake Response - {sAccountTransactionResponse} is entered")
			[ ] 
			[ ] iResponseStatus = EnterFakeResponseFile(sLogOutResponse)
			[ ] ReportStatus("Log Out Response", iResponseStatus, "Fake Response - {sLogOutResponse} is entered")
			[ ] 
			[ ] 
			[-] if(OneStepUpdateSummary.Exists(5))
				[ ] OneStepUpdateSummary.Close()
				[ ] WaitForState(OneStepUpdateSummary , FALSE ,5)
				[ ] QuickenWindow.SetActive()
				[ ] //Calling verification function
				[ ]  iResult=BeaconVerification(sActualCount,sExpEndingbalance,sExpOnlineBalance)
				[-] if(iResult==PASS)
					[ ] ReportStatus("Beacon verification", PASS, "All verification matching correctly")
					[ ] 
				[-] else
					[ ] ReportStatus("Beacon verification", FAIL, "All verification not matching correctly")
			[-] else
				[ ] ReportStatus("Verify One step update summary after one step update.", FAIL , "One step update summary didn't appear after one step update.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("OSU online account ",FAIL,"OSU window Not opened properly" )
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] //#########################################################################
[ ] 
[+] // //############# Perform Update Now using local files ##############################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test3_UpdateNowForWellsFargo()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will perform  update now for Wells Fargo Bank. .
		[ ] // // Using Localfile Testing mechansim.
		[ ] // //
		[ ] // // PARAMETERS:	none
		[ ] // //
		[ ] // // RETURNS:			Pass 		If no error occurs while updating account 							
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //	  Jun 20, 2011		Puja Verma created	
	[ ] // //*********************************************************
[+] testcase Test3_UpdateNowForWellsFargo() appstate none
	[+] // Variable
		[ ] 
		[ ] INTEGER iNavigate,iSelect=2
		[ ] 
		[ ] STRING sCaption
		[ ] BOOLEAN bCaption
		[ ] INTEGER iXCords = 38
		[ ] INTEGER iYCords = 5
		[ ] STRING sActualCount ="0"
		[ ] 
		[ ] STRING sFileFolder=AUT_DATAFILE_PATH + "\Beacon data\UpdateNowdatFiles\"
		[ ] STRING sProfileResponse =sFileFolder+"21_profile.dat"
		[ ] STRING sLogOnResponse=sFileFolder+"1_LogonResp.dat"
		[ ] STRING sGetInstitutionalResponse=sFileFolder+"2_Get_Institutional_Resp.dat"
		[ ] STRING sGetAccountResponse=sFileFolder+"3_Get_Account_resp.dat"
		[ ] STRING sRefreshAccountInteractiveResponse=sFileFolder+"4_Refresh_account_interactive_resp.dat"
		[ ] STRING sAccountTransactionResponse=sFileFolder+"5_CCGetAccountTransactions.dat"
		[ ] STRING sLogOutResponse=sFileFolder+"6_Logout_Resp.dat"
		[ ] STRING sCCCompareAccountKeyValRequest=sFileFolder+"22_CCCompareAccountKeyVal_Resp.dat"
		[ ] 
	[-] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] AccountBarSelect(ACCOUNT_BANKING,1)
		[ ] //Select Update Now from Acccount Actions
		[ ] iNavigate=NavigateToAccountActionBanking(iSelect)
		[-] if(iNavigate==PASS)
			[-] if(OnlineUpdateForThisAccount.Exists(10))
				[ ] OnlineUpdateForThisAccount.SetActive()
				[ ] OnlineUpdateForThisAccount.QWListViewer.ListBox.TextField.TypeKeys("12345")
				[ ] OnlineUpdateForThisAccount.UpdateNowButton.Click()
				[ ] 
				[+] if(DlgUnlockYourPasswordVault.Exists(5))
					[ ] DlgUnlockYourPasswordVault.SkipButton.Click()
					[ ] //.Cancel.Click()
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iResponseStatus = EnterFakeResponseFile(sProfileResponse)
				[ ] ReportStatus("Profile Response", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
				[ ] 
				[ ] 
				[ ] iResponseStatus = EnterFakeResponseFile(sLogOnResponse)
				[ ] ReportStatus("Log On Response", iResponseStatus, "Fake Response - {sLogOnResponse} is entered")
				[ ] 
				[ ] 
				[ ] iResponseStatus = EnterFakeResponseFile(sGetAccountResponse)
				[ ] ReportStatus("Get Account Response", iResponseStatus, "Fake Response - {sGetAccountResponse} is entered")
				[ ] 
				[ ] 
				[ ] iResponseStatus = EnterFakeResponseFile(sRefreshAccountInteractiveResponse)
				[ ] ReportStatus("Refresh Account Interactive Response", iResponseStatus, "Fake Response - {sRefreshAccountInteractiveResponse} is entered")
				[ ] 
				[ ] 
				[ ] 
				[ ] iResponseStatus = EnterFakeResponseFile(sAccountTransactionResponse)
				[ ] ReportStatus("Account Transaction Response", iResponseStatus, "Fake Response - {sAccountTransactionResponse} is entered")
				[ ] 
				[ ] iResponseStatus = EnterFakeResponseFile(sLogOutResponse)
				[ ] ReportStatus("Log Out Response", iResponseStatus, "Fake Response - {sLogOutResponse} is entered")
				[ ] 
				[ ] 
				[ ] 
				[-] if(OneStepUpdateSummary.Exists(15))
					[ ] OneStepUpdateSummary.Close()
					[ ] WaitForState(OneStepUpdateSummary , FALSE ,5)
					[ ] 
					[ ] //Calling verification function
					[ ] QuickenWindow.SetActive()
					[ ] iResult=BeaconVerification(sActualCount,sExpEndingbalance,sExpOnlineBalance)
					[-] if(iResult==PASS)
						[ ] ReportStatus("Beacon verification", PASS, "All verification matching correctly")
						[ ] 
					[-] else
						[ ] ReportStatus("Beacon verification", FAIL, "All verification not matching correctly")
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify One step update summary after one step update.", FAIL , "One step update summary didn't appear after one step update.")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("online account ",FAIL,"Not opened properly" )
		[+] else
			[ ] ReportStatus("Navigate to account Actions",FAIL,"Option from Account actions not selected")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# Beacon Clean ############# #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 BeaconClean()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will close Quicken, Delete Ini . file and Data File
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while closing the window							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  June 23, 2011		Puja Verma  created	
	[ ] //*********************************************************
[-] testcase BeaconClean() appstate none
	[ ] 
	[-] if(QuickenWindow.Exists(5) == TRUE)
		[ ] QuickenWindow.Kill()
		[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] 
	[-] if(FileExists(sDestinationonliniFile) == TRUE)
		[ ] DeleteFile( sDestinationonliniFile)
	[-] if(FileExists(sOnlineAccountFileName))
		[ ] DeleteFile(sOnlineAccountFileName)
	[ ] 
	[ ] 
[ ] // //###########################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 