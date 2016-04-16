[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<HiddenAccount.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   <This script contains all Hidden/Closed Accounts test cases>
	[ ] //
	[ ] // DEPENDENCIES:	<include.inc>
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 25-Sep-12	Udita Dube	Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[+] // Global variables
	[ ] 
	[ ] public STRING sActual,sHandle,sCaption,sAccount,sToConvert,sAccountId,sItem,sCreditAccount,sGoalName,sLoanAccount,sAccPassword
	[ ] public STRING sDataFile,sTransactionType,sAmount,sAccountType,sAccountName,sCategory,sBudgetName,sExpected,sAccountType1
	[ ] public STRING sAccountType2,sAccountType3
	[ ] public INTEGER iResult,iSeparate,iAddAccount,iSelect, iAmount,iCounter,iAddTransaction,iCreateDataFile,i,iNavigate,iRow,iSetupAutoAPI,iValidate,iAccountPosition,iOpenAccountRegister
	[ ] public LIST OF ANYTYPE  lsExcelData,lsReport,lsTransaction,lsAccount,lsListBoxItems,lsCreditAccount,lsLoanAccount,lsSGAccount,lsAccBank,lsExcelData1
	[ ] public BOOLEAN bCaption,bExists,bMatch,bCheckStatus
	[ ] LIST OF STRING lsAccountChecking,lsAccountBrokerage,lsAccountId,lsPassword,lsAccInv,lsFICompare
	[ ] LIST OF STRING  lsCheckingHideAccount,lsCheckingCloseAccount,lsHCreditAcc,lsAssetHideAccount,lsLoanHideAccount
	[ ] LIST OF STRING  lsBrokerageHideAccount,lsBrokerageCloseAccount,lsClosedAccount,lsAssetCloseAccount,lsLoanCloseAccount
	[ ] 
	[ ] 
	[ ] 
	[ ] public STRING sHiddenAccounts="HiddenAccounts"
	[ ] public STRING sBankingReportWorksheet="Banking Reports"
	[ ] public STRING sComparisonReportWorksheet="Comparison Reports"
	[ ] public STRING sNetWorthReportWorksheet="Net Worth & Balances"
	[ ] public STRING sSpendingReportWorksheet="Spending Reports"
	[ ] public STRING sInvestingReportWorksheet="Investing Reports"
	[ ] public STRING sFileName="HiddenAccountReports"
	[ ] public STRING sTransactionSheet = "CheckingTransactionTAX"
	[ ] public STRING sInvestingTransactionWorksheet = "Investing Transaction"
	[ ] public STRING sHiddenAccountData = "DataForHiddenAccount"
	[ ] public STRING sAccountWorksheet = "Account"
	[ ] public STRING sBankingAccWorksheet="BankingAccount"
	[ ] public STRING sOnlineAccWorksheet="Online Account"
	[ ] public STRING sInvestingAccWorksheet="InvestmentAccount"
	[ ] public STRING sLoanAccWorksheet="LoanAccount"
	[ ] public STRING sAssestAccWorksheet="AssestAccount"
	[ ] public STRING sCreditAccWorksheet="CreditAccount"
	[ ] public STRING sSavingsGoalsWorksheet="SavingsGoals"
	[ ] public STRING sCloseAccountWorksheet="CloseAllTypeAccount"
	[ ] public STRING sTransactionWorksheet="Banking Transaction"
	[ ] public STRING sHiddenAccountExcel="DataForHiddenAccount"
	[ ] public STRING sHiddenAccountWorksheet="HiddenAllTypeAccount"
	[ ] public STRING sDataFileName="HiddenAccountPlanning"
	[ ] public STRING sDateFormate="m/d/yyyy"
	[ ] 
	[ ] public STRING sTab= "Display Options"
	[ ] public STRING sWindowType = "MDI"
	[ ] 
	[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), sDateFormate) 
	[ ] 
	[ ] 
[ ] 
[+] // Global Function
	[ ] // Used for Reports Test cases
	[+] //#############  SetUp ######################################################
		[ ] // ********************************************************
		[+] // Function Name:	 SetUp()
			[ ] //
			[ ] // DESCRIPTION:
			[ ] // This testcase will open data file to test hidden account 
			[ ] //
			[ ] // PARAMETERS:		None
			[ ] //
			[ ] // RETURNS:			Pass 		If no error occurs while deleting and creating file							
			[ ] //						Fail			If any error occurs
			[ ] //
			[ ] // REVISION HISTORY:
			[ ] // 	  , 2012		Dean Paes	created
		[ ] // ********************************************************
		[ ] 
	[+] public INTEGER SetUpReports(STRING sFileName)
		[ ] 
		[ ] INTEGER iRegistration,iOpenDataFile,iFunctionResult
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
		[ ] iFunctionResult=PASS
		[ ] 
		[ ] 
		[ ] // Load O/S specific paths
		[ ] LoadOSDependency()
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[+] if(QuickenWindow.Exists(SHORT_SLEEP))
			[ ] QuickenWindow.SetActive()
		[+] else
			[ ] QuickenWindow.Start (sCmdLine)
			[ ] 
		[ ] 
		[+] if(FileExists(sDataFile))
			[ ] DeleteFile(sDataFile)
			[ ] CopyFile(sSourceFile,sDataFile)
			[ ] OpenDataFile(sFileName)
		[+] else
			[ ] CopyFile(sSourceFile,sDataFile)
			[ ] OpenDataFile(sFileName)
			[ ] 
		[ ] 
		[+] // if(ProductRegistrationPopup.Exists(3))
			[ ] // ProductRegistrationPopup.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] // Set Classic View
		[ ] SetViewMode(VIEW_CLASSIC_MENU)
		[ ] // Bypass Registration
		[ ] iRegistration=BypassRegistration()
		[ ] // Select Home tab
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] // Off Popup Register
		[ ] UsePopUpRegister("OFF")
		[ ] 
		[ ] 
		[ ] //Deselect Save Report Notification option in Preferences to prevent pop ups during reports
		[ ] QuickenWindow.Edit.Click()
		[ ] QuickenWindow.Edit.Preferences.Select()
		[+] if(Preferences.Exists(SHORT_SLEEP))
			[ ] Preferences.SelectPreferenceType1.ListBox1.Select(18)
			[ ] Preferences.RemindMeToSaveReports.Uncheck()
			[ ] Preferences.OK.Click()
			[ ] 
		[+] else
			[ ] iFunctionResult=FAIL
		[ ] 
		[ ] return iFunctionResult
		[ ] 
		[ ] 
	[ ] //#######################################################################################
	[ ] 
[ ] 
[+] //#############  SetUp ######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 PropertyDebt_SetUp()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will open data file to test hidden account for property and debt accounts
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If no error occurs while deleting and creating file							
		[ ] // Fail			If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 29, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[-] testcase PropertyDebt_SetUp () appstate QuickenBaseState
	[ ] 
	[ ] // Variable declaration
	[ ] INTEGER iRegistration,iOpenDataFile
	[ ] sFileName = "HiddenAccountPropertyDebt"
	[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
	[ ] 
	[ ] 
	[ ] //Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[ ] sCaption = QuickenWindow.GetCaption ()
		[+] if(MatchStr("*{sFileName}*", sCaption))
			[+] if(QuickenWindow.Exists(SHORT_SLEEP))
				[ ] QuickenWindow.Kill()
				[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[+] if (!QuickenWindow.Exists(3))
		[ ] LaunchQuicken()
		[ ] sleep(10)
	[ ] 
	[ ] 
	[ ] //SkipRegistration
	[ ] SkipRegistration()
	[ ] //Open data file
	[+] if (!QuickenWindow.Exists(3))
		[ ] LaunchQuicken()
		[ ] sleep(10)
	[ ] iOpenDataFile=OpenDataFile(sFileName)
	[+] if (iOpenDataFile==PASS)
		[ ] ReportStatus("Property and Debt data file open", PASS,"Property and Debt data file opened.")
		[ ] //CloseQuickenConnectedServices()
		[ ] 
	[+] else
		[ ] ReportStatus("Property and Debt data file open", FAIL,"Property and Debt data file couldn't be opened.")
		[ ] 
	[ ] 
	[ ] //Off Popup Register
	[ ] UsePopUpRegister("OFF")
	[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############Property Debt account as Separate Account ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_OtherAssettAsSeparateAccount()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will check Account Display option "-Keep this account separate-Account would be excluded from Quicken reports and features."  for an Other Asset account
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Other Asset account get separated
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 12, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_OtherAssetAsSeparateAccount () appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] sAccount = "Other Asset 1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Restore()
		[ ] sleep(1)
		[ ] QuickenWindow.Maximize()
		[ ] sleep(1)
		[ ] 
		[ ] //Edit Other Asset  Account
		[ ] iSelect = SeparateAccount(ACCOUNT_PROPERTYDEBT,sAccount)			// Select Other Asset account
		[+] if (iSelect == PASS)
			[ ] ReportStatus("Check KeepThisAccountSeparate checkbox for Other Asset account", PASS, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is checked")
			[ ] 
			[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
			[ ] NavigateQuickenTab(sTAB_HOME)
			[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
			[ ] 
			[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount) 
			[+] if (iSeparate == PASS)
				[ ] AccountDetails.Cancel.Click()
				[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and Other Asset account is displayed under this seaction")
			[+] else
				[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Separate section is not created")
			[ ] 
		[+] else
			[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", FAIL, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is not available")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############Verify Hide account name from account bar and account list ###########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_HideOtherAssetAccountFromAccountBar()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check Account Display option "-Hide account name in account bar and account list."  for an Other Asset account
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Other Asset account is hidden from account bar and account list						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 29, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test02_HideOtherAssetAccountFromAccountBar () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iSelectAccount,iAccountDetails
		[ ] sAccount = "Other Asset 2"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Navigate to account list
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
		[+] if(iNavigate == PASS)
			[ ] //Verify Show hidden accounts checkbox is not available if there are no hidden account
			[+] if(AccountList.Exists(SHORT_SLEEP))
				[+] if(!AccountList.QWinChild.ShowHiddenAccounts.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Validate Show hidden Account checkbox", PASS, "Show hidden Account checkbox is not available on Account List") 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Show hidden Account checkbox", FAIL, "Show hidden Account checkbox is available on Account List") 
				[ ] AccountList.Close()
		[ ] 
		[ ] //Hide Other Asset Account from Account Bar and Account List
		[ ] iSelect = AccountHideInAccountBarAccountList(ACCOUNT_PROPERTYDEBT,sAccount)			// Select Other Asset account
		[+] if (iSelect == PASS)
			[ ] ReportStatus("Check Hide account name from account bar and account list checkbox", PASS, "Third Checkbox: Hide account name from account bar and account list is checked")
			[ ] 
			[ ] //Verify account name in Account Bar
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] iSelectAccount=AccountBarSelect(ACCOUNT_PROPERTYDEBT, 9)
			[ ] //iSeparate=SelectAccountFromAccountBar(sAccount,ACCOUNT_SEPARATE)
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(Replicate(KEY_DN,1))
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] //iSelectAccount = SelectAccountFromAccountBar(sAccount,ACCOUNT_PROPERTYDEBT)	// select Other Asset account
			[+] if(iSelectAccount == PASS)
				[ ] iAccountDetails=NavigateToAccountDetails(sAccount)
				[+] if(iAccountDetails==PASS)
					[ ] ReportStatus("Check account in Account bar", PASS, "Account is hidden from Account bar")
					[ ] 
				[+] else
					[ ] ReportStatus("Check account in Account bar", FAIL, "Account is hidden from Account bar")
					[ ] 
				[ ] AccountDetails.Close()
			[+] else
				[ ] ReportStatus("Verify Account Details window",FAIL,"Account Details window is not opened")
			[ ] 
			[ ] //Verify account name in Account List
			[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
			[+] if(iNavigate == PASS)
				[+] if(AccountList.Exists(3))
					[ ] AccountList.SetActive()
					[+] if(AccountList.QWinChild.ShowHiddenAccounts.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Validate Show hidden Account checkbox", PASS, "Show hidden Account checkbox is available on Account List") 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Show hidden Account checkbox", FAIL, "Show hidden Account checkbox is not available on Account List") 
					[ ] AccountList.Close()
			[+] else
				[ ] ReportStatus("Verify Account List window",FAIL,"Account List window is not opened")
				[ ] 
			[ ] 
		[+] // else
			[ ] // ReportStatus("Check Hide account name from account bar and account list checkbox", FAIL, "Third Checkbox: Hide account name from account bar and account list is not available")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############Verify Hide account name from account bar and account list ###########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_HideHouseAccountFromAccountBar()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check Account Display option "-Hide account name in account bar and account list."  for an House account
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If House account is hidden from account bar and account list						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 30, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_HideHouseAccountFromAccountBar () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iSelectAccount,iAccountDetails,iReportSelect,iCount
		[ ] STRING sNetWorth,sReport
		[ ] sReport="Net Worth & Balances"
		[ ] sNetWorth= "24,797.03" // Networth should not be changed after making the account hidden
		[ ] sAccount = "House Asset 1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Navigate to account list
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
		[+] if(iNavigate == PASS)
			[ ] //Verify house account is available in account list
			[+] if(AccountList.Exists(2))
				[ ] AccountList.QWinChild.PersonalNetWorth.Click()
				[ ] iCount=AccountList.QWinChild.Order.ListBox.GetItemCount()
				[+] for(i=1;i<=iCount;i++)
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
					[ ] 
					[ ] //####### Validate Accounts in Account List window #####################
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle, str(i))
					[ ] bMatch = MatchStr("*{sAccount}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Account in Account List and Account Bar", PASS, "{sAccount} account is available in Account list") 
						[ ] break
					[+] else
						[ ] continue
						[+] if(i==iCount)
							[ ] ReportStatus("Validate Account in Account List and Account", FAIL, "Account {sAccount} is not available in Account List and Account Bar") 
					[ ] 
				[ ] AccountList.Close()
		[ ] 
		[ ] //"Hide account name in account bar and account list"  House Account
		[ ] iSelect = AccountHideInAccountBarAccountList(ACCOUNT_PROPERTYDEBT,sAccount,1)			// Select house account
		[+] if (iSelect == PASS)
				[ ] ReportStatus("Check Hide account name from account bar and account list checkbox", PASS, "Third Checkbox: Hide account name from account bar and account list is checked")
				[ ] 
				[ ] //Verify account name in Account Bar
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] //iSelectAccount = SelectAccountFromAccountBar(sAccount,ACCOUNT_PROPERTYDEBT)	// select Other Asset account
				[ ] //iSelectAccount=AccountBarSelect(ACCOUNT_PROPERTYDEBT, 9)
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.Click(1,64, 150)
				[ ] //iSeparate=SelectAccountFromAccountBar(sAccount,ACCOUNT_SEPARATE)
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.TypeKeys(Replicate(KEY_DN,1))
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.TypeKeys(KEY_ENTER)
				[ ] // 
				[+] // if(iSelectAccount == PASS)
					[ ] iAccountDetails=NavigateToAccountDetails(sAccount)
					[+] if(iAccountDetails==PASS)
						[ ] ReportStatus("Check account in Account bar", PASS, "{sAccount} account is hidden from Account bar")
						[ ] 
					[+] else
						[ ] ReportStatus("Check account in Account bar", FAIL, "Account is hidden from Account bar")
						[ ] 
					[ ] AccountDetails.Close()
				[+] // else
					[ ] // ReportStatus("Verify Account Details window",FAIL,"Account Details window is not available")
				[ ] 
				[ ] //Verify account name in Account List
				[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
				[+] if(iNavigate == PASS)
					[+] if(AccountList.Exists(2))
						[ ] AccountList.SetActive()
						[ ] AccountList.QWinChild.PersonalNetWorth.Click()
						[ ] iCount=AccountList.QWinChild.Order.ListBox.GetItemCount()
						[+] for(i=1;i<=iCount;i++)
							[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
							[ ] 
							[ ] //####### Validate Accounts in Account List window #####################
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
							[ ] bMatch = MatchStr("*{sAccount}*", sActual)
							[+] if(bMatch == TRUE)
								[ ] ReportStatus("Validate Account in Account List and Account Bar", FAIL, "{sAccount} account is available in Account list") 
								[ ] break
							[+] else
								[ ] continue
								[+] if(i==iCount)
									[ ] ReportStatus("Validate Account in Account List and Account", PASS, "Account {sAccount} is hidden from Account List and Account Bar") 
							[ ] 
						[ ] AccountList.Close()
					[+] else
						[ ] ReportStatus("Verify Account List window",FAIL,"Account List window is not available")
					[ ] 
				[ ] 
				[ ] //Verify Networth after hiding account
				[ ] iReportSelect = OpenReport(sReport, sREPORT_NETWORTH)		// OpenReport("Net Worth & Balances", "Net Worth")
				[ ] 
				[+] if(NetWorthReports.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Run {sREPORT_NETWORTH} Report", PASS, "Run Report successful") 
					[ ] NetWorthReports.SetActive()
					[+] if(NetWorthReports.ShowReport.Exists(SHORT_SLEEP))
						[ ] NetWorthReports.ShowReport.Click()
						[ ] sleep(1)
					[ ] 
				[ ] iCount = NetWorthReports.QWListViewer1.ListBox1.GetItemCount()
				[ ] 
				[+] for(i=iCount;i>=1;i--)
					[ ] sHandle = Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())	   // get the handle
					[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
					[ ] bMatch = MatchStr("*{sNetWorth}*", sActual)	
					[ ] 
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Verify Networth Amount", PASS, "Correct Networth amount {sNetWorth} is displayed") 
						[ ] break
					[+] else
						[ ] continue
						[+] if(i==1)
							[ ] ReportStatus("Verify Networth amount", FAIL, "Actual networth amount {sActual} does not match with excpected amount {sNetWorth}") 
							[ ] 
					[ ] 
				[+] if(NetWorthReports.Exists(2))
					[ ] NetWorthReports.SetActive()
					[ ] NetWorthReports.Close()
				[+] else
					[ ] ReportStatus("Run {sREPORT_NETWORTH} Report", FAIL, "Run Report successful") 
					[ ] 
				[ ] 
		[+] // else
			[ ] // ReportStatus("Check Hide account name from account bar and account list checkbox", FAIL, "Third Checkbox: Hide account name from account bar and account list is not checked")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############  Verify Hide in Transaction entry lists ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_HouseHideInTransactionEntryList()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check Account Display option "-Hide In Transaction Entry List"  for a House account
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Setting saved successfully
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 30, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test04_HouseHideInTransactionEntryList() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iIndex
		[ ] sAccount = "House Asset 2"
		[ ] sAccountName ="Brokerage 01"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit House Account
		[ ] iSelect = AccountHideInTransactionList(ACCOUNT_PROPERTYDEBT,sAccount,1)			// Select first House account
		[+] if (iSelect == PASS)
				[ ] ReportStatus("Check Hide in Transaction Entry List checkbox", PASS, "Second Checkbox: Hide in transaction entry lists is checked")
				[ ] 
				[ ] //Verify account name in register
				[ ] iNavigate = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)			// Select first account
				[+] if (iNavigate == PASS)
					[+] if(BrokerageAccount.Exists(SHORT_SLEEP))
						[ ] //Click on "Enter Transaction" button
						[ ] BrokerageAccount.EnterTransactions.Click()
						[ ] //Buy - Shares Bought window active
						[ ] wEnterTransaction.SetActive()
						[ ] //Select From radio button from "Use cash for this transaction"
						[ ] wEnterTransaction.UseCashForThisTransaction.Select("From:")
						[ ] //Verify account name in Account list, it should not be available as it is made hidden from transaction entry list
						[ ] iIndex=wEnterTransaction.FromAccountList.FindItem(sAccount)
						[+] if(iIndex==0)
							[ ] ReportStatus("Check Hide in Transaction Entry List verification", PASS, "{sAccount} account is hidden from Transaction Entry List")
							[ ] 
						[+] else
							[ ] ReportStatus("Check Hide in Transaction Entry List verification", FAIL, "Account is not hidden from Transaction Entry List as it is available for Investing transaction")
							[ ] 
						[ ] wEnterTransaction.Close()
					[+] else
						[ ] ReportStatus("Verify Brokerage Account", FAIL, "Brokerage Account is not opened")
				[+] else
					[ ] ReportStatus("Navigation to Brokerage Account", FAIL, "Navigation failed to first Brokerage Account")
				[ ] 
		[+] else
			[ ] ReportStatus("Check Hide in Transaction entry lists checkbox", FAIL, "Hide in Transaction entry lists checkbox is not checked")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //############# Other Asset account with all display options selected #################
	[ ] // ********************************************************
	[+] // TestCase Name:Test05_OtherAssetAccWithAllDisplayOption()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will check other asset account with all display option checked/selected
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If all display options selected and functioning as expected				
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 30, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test05_OtherAssetAccWithAllDisplayOption() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iTab,iCount
		[ ] STRING sReport
		[ ] BOOLEAN bFlag = FALSE
		[ ] sAccount = "Other Asset 3"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Other Asset Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_PROPERTYDEBT,sAccount,sTab)			// Select Other Asset account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] //Check " Keep this account separate- account will be excluded from Quicken reports and features" checkbox
			[+] if(AccountDetails.KeepThisAccountSeparate.Exists(SHORT_SLEEP))
				[+] if(!AccountDetails.KeepThisAccountSeparate.IsChecked())
					[ ] AccountDetails.KeepThisAccountSeparate.Check()
					[ ] ReportStatus("Check Keep this account Separate checkbox", PASS, "First Checkbox: Keep this account separate is checked")
				[+] else
					[ ] ReportStatus("Check Keep this account Separate checkbox", PASS, "First Checkbox: Keep this account separate is checked")
				[ ] bFlag=TRUE
			[+] else
				[ ] ReportStatus("Check keep this account separate checkbox", FAIL, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is not available")
				[ ] bFlag = FALSE
			[ ] 
			[ ] //Check "Hide In Transaction Entry List" checkbox
			[+] if(AccountDetails.HideInTransactionEntryList.Exists(SHORT_SLEEP))
				[+] if(!AccountDetails.HideInTransactionEntryList.IsChecked())
					[ ] AccountDetails.HideInTransactionEntryList.Check()
					[ ] ReportStatus("Check Hide in Transaction Entry List checkbox", PASS, "Second Checkbox: Hide in transaction entry lists is checked")
					[ ] 
				[+] else
					[ ] ReportStatus("Check Hide in Transaction Entry List checkbox", PASS, "Second Checkbox: Hide in transaction entry lists is checked")
				[ ] bFlag=TRUE
			[+] else
				[ ] ReportStatus("Check Hide in Transaction entry lists checkbox", FAIL, "Second Checkbox: Hide in Transaction entry lists is not available")
				[ ] bFlag = FALSE
			[ ] 
			[ ] //Check "Hide account name in account bar and account list" checkbox
			[+] if(AccountDetails.HideAccountNameInAccountB.Exists(SHORT_SLEEP))
				[+] if(!AccountDetails.HideAccountNameInAccountB.IsChecked())
					[ ] AccountDetails.HideAccountNameInAccountB.Check()
					[ ] ReportStatus("Check Hide account name in account bar and account list checkbox", PASS, "Third Checkbox: Hide account name in account bar and account list is checked")
				[+] else
					[ ] ReportStatus("Check Hide account name in account bar and account list checkbox", PASS, "Third Checkbox: Hide account name in account bar and account list is checked")
				[ ] bFlag=TRUE
			[+] else
				[ ] ReportStatus("Check Hide account name from account bar and account list checkbox", FAIL, "Third Checkbox: Hide account name from account bar and account list is not available")
				[ ] bFlag = FALSE
			[ ] 
			[+] if(bFlag == TRUE)
				[ ] ReportStatus("Select all display options", PASS, "All display options are selected in Account Details window")
				[ ] AccountDetails.OK.Click()
				[ ] 
				[ ] //Verify account name in Account List
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
				[+] if(iNavigate == PASS)
					[ ] 
					[ ] AccountList.QWinChild.PersonalNetWorth.Click()
					[ ] 
					[ ] iCount=AccountList.QWinChild.Order.ListBox.GetItemCount()
					[+] for(i=1;i<=iCount;i++)
						[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
						[ ] 
						[ ] //####### Validate Accounts in Account List window #####################
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
						[ ] bMatch = MatchStr("*{sAccount}*", sActual)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Validate Account in Account List and Account Bar", FAIL, "{sAccount} account is available in Account list") 
							[ ] break
						[+] else
							[ ] continue
							[+] if(i==iCount)
								[ ] ReportStatus("Validate Account in Account List and Account", PASS, "Account {sAccount} is not available in Account List and Account Bar") 
						[ ] 
					[ ] AccountList.Close()
				[+] else
					[ ] ReportStatus("Navigate to Account List", FAIL, "Navigation failed to Account List")
					[ ] 
				[ ] 
				[ ] //Verify account "Separate" section 
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] iSeparate=AccountBarSelect(ACCOUNT_SEPARATE,3)
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer7.ListBox.TypeKeys(Replicate(KEY_DN,1))
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer7.ListBox.TypeKeys(KEY_ENTER)
				[+] if (iSeparate == PASS)
					[ ] iNavigate=NavigateToAccountDetails(sAccount)
					[+] if (iNavigate == PASS)
						[ ] iTab=SelectAccountDetailsTabs(ACCOUNT_PROPERTYDEBT,sTab)
						[+] if(AccountDetails.KeepThisAccountSeparate.IsChecked())
							[ ] AccountDetails.Cancel.Click()
							[ ] ReportStatus("Verify account in Separate section in Account Bar", PASS, "{sAccount} account is displayed under Separate section in Account Bar")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify account in Separate section in Account Bar", FAIL, "{sAccount} account is not displayed under Separate section in Account Bar")
							[ ] 
					[+] else
						[ ] ReportStatus("Navigate to Account Details window", PASS, "Navigation failed to Account Details window")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Account is not displayed under Separate section")
				[ ] 
			[+] else
				[ ] ReportStatus("Select all display options", FAIL, "All display options are not selected in Account Details window")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "Other Asset Account is not selected from Account bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############Verify Close Account for House ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_HouseCloseAccount()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will close House account and verify
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If House account closed successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 30, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test06_HouseCloseAccount () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iCount,iReportSelect
		[ ] STRING sSearch,sNetWorth,sReport
		[ ] LIST OF STRING lsActual
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="House Asset 2"
		[ ] sNetWorth="22,247.03"          // 24,647.03 (previous networth) + 2500 (Close Account balance)
		[ ] sReport="Net Worth & Balances"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit House Account
		[ ] iSelect = CloseAccount(ACCOUNT_PROPERTYDEBT,sAccount,1)			// Select first House account
		[+] if (iSelect == PASS)
			[ ] //Open Net Worth Report and Verify
			[ ] iReportSelect = OpenReport(sReport, sREPORT_NETWORTH)		// OpenReport("Net Worth & Balances", "Net Worth")
			[+] if(NetWorthReports.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Run {sREPORT_NETWORTH} Report", PASS, "Run Report successful") 
				[ ] NetWorthReports.SetActive()
				[+] if(NetWorthReports.ShowReport.Exists(SHORT_SLEEP))
					[ ] NetWorthReports.ShowReport.Click()
					[ ] sleep(1)
				[ ] iCount = NetWorthReports.QWListViewer1.ListBox1.GetItemCount()
				[+] for(i=iCount;i>=1;i--)
					[ ] sHandle = Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())	   // get the handle
					[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
					[ ] bMatch = MatchStr("*TOTAL ASSETS*{sNetWorth}*", sActual)						
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Verify Networth Amount", PASS, "Correct Networth amount {sNetWorth} is displayed") 
						[ ] break
					[+] else
						[ ] ListAppend(lsActual,sActual)
						[+] if(i==1)
							[ ] ReportStatus("Verify Networth amount", FAIL, "Actual networth amount {sActual} does not match with excpected amount {sNetWorth}") 
							[ ] 
						[ ] continue
					[ ] 
				[+] if(NetWorthReports.Exists(SHORT_SLEEP))
					[ ] NetWorthReports.SetActive()
					[ ] NetWorthReports.Close()
			[+] else
				[ ] ReportStatus("Run {sREPORT_NETWORTH} Report", iReportSelect, "Run Report successful") 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account is closed", iSelect, "House Account is not Closed")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############Verify Close Account for Other Asset ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_OtherAssetCloseAccount()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will close Other Asset account and verify
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Other Asset account closed successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 30, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test07_OtherAssetCloseAccount () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iCount,iReportSelect
		[ ] STRING sSearch,sNetWorth,sReport
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Other Asset 4"
		[ ] sNetWorth="22,147.03"          // 22,147.03 (previous networth) + 100 (Close Account balance)
		[ ] sReport="Net Worth & Balances"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Other Asset Account
		[ ] iSelect = CloseAccount(ACCOUNT_PROPERTYDEBT,sAccount,4)			// Select Other Asset account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] 
			[ ] //Open Net Worth Report and Verify
			[ ] iReportSelect = OpenReport(sReport, sREPORT_NETWORTH)		// OpenReport("Net Worth & Balances", "Net Worth")
			[ ] 
			[+] if(NetWorthReports.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Run {sREPORT_NETWORTH} Report", PASS, "Run Report successful") 
				[ ] NetWorthReports.SetActive()
				[+] if(NetWorthReports.ShowReport.Exists(SHORT_SLEEP))
					[ ] NetWorthReports.SetActive()
					[ ] NetWorthReports.ShowReport.Click()
				[ ] sleep(2)
				[ ] 
				[ ] NetWorthReports.SetActive()
				[ ] // iCount = NetWorthReports.QWListViewer1.ListBox1.GetItemCount()
				[ ] iCount = NetWorthReports.ListBox.GetItemCount()
				[ ] 
				[+] for(i=iCount;i>=1;i--)
					[ ] sHandle = Str(NetWorthReports.ListBox.GetHandle())	   // get the handle
					[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
					[ ] bMatch = MatchStr("*{sNetWorth}*", sActual)						
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Verify Networth Amount", PASS, "Correct Networth amount {sNetWorth} is displayed") 
						[ ] break
					[+] else
						[+] if(i==1)
							[ ] ReportStatus("Verify Networth amount", FAIL, "Actual networth amount {sActual} does not match with excpected amount {sNetWorth}") 
							[ ] 
						[ ] continue
					[ ] 
				[+] if(NetWorthReports.Exists(SHORT_SLEEP))
					[ ] NetWorthReports.SetActive()
					[ ] NetWorthReports.Close()
			[+] else
				[ ] ReportStatus("Run {sREPORT_NETWORTH} Report", iReportSelect, "Run Report successful") 
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate close Account {sAccount}", iSelect, "Other Asset Account is not closed")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# Close Other Asset account having scheduled reminders ##############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_CloseOtherAssetWithReminders()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify displaying of warning message if Other Asset account to be closed has scheduled reminders in it.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If warning message is displayed						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 30, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test08_CloseOtherAssetWithReminders () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sPayeeName,sActualMessage,sTab,sExpectedMessage1,sExpectedMessage2
		[ ] sAccount="Other Asset 5"
		[ ] sExpectedMessage1="This account has one or more scheduled reminders"
		[ ] sExpectedMessage2="Account not closed"
		[ ] sTab= "Display Options"
		[ ] sPayeeName= "Payee1"
		[ ] sAmount="10"
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] QuickenWindow.Bills.Click()
		[ ] QuickenWindow.Bills.AddReminder.Click()
		[ ] QuickenWindow.Bills.AddReminder.BillReminder.Select()
		[ ] 
		[ ] iResult=AddBill(sPayeeName,sAmount,sDateStamp,sAccount)
		[+] if(iResult==PASS)
			[ ] //Edit Other Asset  Account
			[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_PROPERTYDEBT,sAccount,sTab)			// Select account
			[+] if (iSelect == PASS)
				[ ] 
				[ ] //Check "Close Account" button
				[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
					[ ] AccountDetails.CloseAccount.Click()
					[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
						[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
						[ ] PermanentlyCloseAccount.OK.Click()
						[ ] 
						[+] if(AlertMessage.Exists(SHORT_SLEEP))
							[ ] //Get alert message
							[ ] sActualMessage=AlertMessage.MessageText.GetText()
							[+] if(MatchStr("{sExpectedMessage1}*",sActualMessage))
								[ ] ReportStatus("Verify alert message", PASS, "Correct alert message is displayed i.e. {sExpectedMessage1}")
							[+] else
								[ ] ReportStatus("Verify alert message", FAIL, "Actual alert message: {sActualMessage} and Expected alert message: {sExpectedMessage1}")
							[ ] AlertMessage.No.Click()
							[+] if(AlertMessage.Exists(SHORT_SLEEP))
								[ ] sActualMessage=AlertMessage.MessageText.GetText()
								[+] if(MatchStr("{sExpectedMessage2}*",sActualMessage))
									[ ] ReportStatus("Verify alert message", PASS, "Correct alert message is displayed i.e. {sExpectedMessage2}")
								[+] else
									[ ] ReportStatus("Verify alert message", FAIL, "Actual alert message: {sActualMessage} and Expected alert message: {sExpectedMessage2}")
								[ ] 
								[ ] AlertMessage.OK.Click()
							[ ] 
						[+] else
							[ ] ReportStatus("Verify alert message dialog", FAIL, "Alert message dialog is not displayed")
							[ ] 
						[ ] 
						[+] if(AccountDetails.Exists(SHORT_SLEEP))
							[ ] AccountDetails.SetActive()
							[ ] AccountDetails.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Check Permanently Close Account window", FAIL, "Permanently Close Account window is available")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Check Close Account button", FAIL, "Close button is not available")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Account selection", iSelect, "Banking Account is not selected from Account bar")
				[ ] 
		[+] else
			[ ] ReportStatus("Add Bill Reminder",FAIL,"Bill Reminder is not added to {sAccount}")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# Close Other Asset account in Move Transaction #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_ClosedOtherAssetInMoveTransaction()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed other asset account should not get display on the Move Transaction dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If closed other asset account not available in Move transaction dialog
		[ ] // Fail		If any error occurs or closed account is available in Move Transaction dialog
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 23, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test09_ClosedOtherAssetInMoveTransaction () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iClick,iIndex
		[ ] STRING sTxnSearch,sTxnAction
		[ ] sAccount="Checking 01"
		[ ] sTxnSearch="XYZ"
		[ ] sTxnAction="Move Transaction(s)"
		[ ] sAccountName="Other Asset 4"
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMin()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	// select first checking account
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select  Account", iSelect, "Cheking Account {sAccount} is selected") 
			[ ] 
			[ ] QuickenWindow.TypeKeys(KEY_ESC)
			[ ] 
			[ ] //Select Move Transaction(s)
			[ ] iClick =  SelectTransactionAction(sWindowType,sTxnSearch,sTxnAction)
			[+] if (iClick == PASS)
				[ ] ReportStatus("Select Move Transaction(s) option", iClick, "Move Transaction(s) option is selected") 
				[ ] 
				[+] if(MoveTransactionS.Exists(SHORT_SLEEP))
					[ ] 
					[ ] iIndex=MoveTransactionS.MoveToAccount.FindItem(sAccountName)
					[+] if(iIndex==0)
						[ ] ReportStatus("Closed account in Move Transaction verification", PASS, "Closed other asset account is not available in Move Transaction dialog box")
						[ ] 
					[+] else
						[ ] ReportStatus("Closed account in Move Transaction verification", FAIL, "Closed other asset account is not available in Move Transaction dialog box")
						[ ] 
					[ ] MoveTransactionS.Close()
				[+] else
					[ ] ReportStatus("Verify Move Transaction window", FAIL, "Move Transaction window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Select Move Transaction(s) option", iClick, "Move Transaction(s) option is not selected") 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "Banking Account is not selected from Account bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# Separate Other Asset account in Move Transaction ###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_SeparateOtherAssetInMoveTransaction()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that separated other asset account should get displayed on the Move Transaction dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If separate other asset account available in Move transaction dialog
		[ ] // Fail		If any error occurs or separate account is not available in Move Transaction dialog
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 23, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test10_SeparateOtherAssetInMoveTransaction () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iClick,iIndex
		[ ] STRING sTxnSearch,sTxnAction
		[ ] sAccount="Checking 01"
		[ ] sTxnSearch="XYZ"
		[ ] sTxnAction="Move Transaction(s)"
		[ ] sAccountName="Other Asset 1"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMin()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	// select first checking account
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select  Account", iSelect, "Cheking Account is selected") 
			[ ] 
			[ ] //Select Move Transaction(s)
			[ ] iClick =  SelectTransactionAction(sWindowType,sTxnSearch,sTxnAction)
			[+] if (iClick == PASS)
				[ ] ReportStatus("Select Move Transaction(s) option", iSelect, "Move Transaction(s) option is selected") 
				[ ] 
				[+] if(MoveTransactionS.Exists(SHORT_SLEEP))
					[ ] iIndex=MoveTransactionS.MoveToAccount.FindItem(sAccountName)
					[+] if(iIndex>0)
						[ ] ReportStatus("Separate asset account in Move Transaction verification", PASS, "Separate other asset account is available in Move Transaction dialog box")
						[ ] 
					[+] else
						[ ] ReportStatus("Separate asset account in Move Transaction verification", FAIL, "Separate other asset account is not available in Move Transaction dialog box")
						[ ] 
					[ ] MoveTransactionS.Close()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Move Transaction window", FAIL, "Move Transaction window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Select Move Transaction(s) option", FAIL,"Move Transaction(s) option is not selected") 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "Banking Account is not selected from Account bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] 
[ ] //******************************************************************************************************************************************
[ ] 
[ ] //#############  Hidden In Tax Center  ##########################################
[ ] 
[+] // ############# Tax Center SetUp ######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TaxCenter_SetUp() 
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // It will setup the necessary pre-requisite for tests.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			          Pass 		If no error occurs while creating checking and Brokerage Accounts							
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Mar 21,2013		Anagha Bhandare created
	[ ] // ********************************************************
[+] testcase TaxCenter_SetUp() appstate QuickenBaseState
	[ ] 
	[+] //Variable declaration
		[ ] STRING sSourceFile
		[ ] sFileName = "HiddenAccountTaxCenter"
		[ ] sTab= "Display Options"
		[ ] sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountData, sAccountWorksheet)
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[ ] sCaption = QuickenWindow.GetCaption ()
		[+] if(MatchStr("*{sFileName}*", sCaption))
			[+] if(QuickenWindow.Exists(SHORT_SLEEP))
				[ ] QuickenWindow.Kill()
				[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[+] if (!QuickenWindow.Exists(3))
		[ ] LaunchQuicken()
		[ ] WaitForState(QuickenWindow, TRUE ,10)
	[ ] 
	[ ] //Creating a Data file
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] //Report Staus If Data file Created successfully
		[ ] 
		[+] if(iCreateDataFile==PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] 
			[+] //Need to remove----
				[ ] //Fetching 3rd Row data in a list
				[ ] lsAccountBrokerage = lsExcelData[3]
				[ ] lsAccountBrokerage[4]=sDateStamp
				[ ] 
				[+] for(i=1;i<=ListCount(lsExcelData)-1;i++)
					[ ] //Add Checking Account
					[ ] lsAccountChecking = lsExcelData[i]
					[+] if (lsAccountChecking[1]==NULL)
						[ ] break
					[ ] lsAccountChecking[4] = sDateStamp
					[ ] 
					[ ] //Add Checking Account
					[ ] iAddAccount = AddManualSpendingAccount(lsAccountChecking[1], lsAccountChecking[2], lsAccountChecking[3], lsAccountChecking[4])
					[ ] 
					[ ] //Report Status if checking Account is created
					[+] if (iAddAccount==PASS)
						[ ] 
						[ ] ReportStatus("{lsAccountChecking[1]} Account", iAddAccount, "{lsAccountChecking[2]} Account - is created successfully")
						[ ] 
						[ ] //This will click on Banking account on AccountBar
						[ ] iSelect = SelectAccountFromAccountBar(lsAccountChecking[2],ACCOUNT_BANKING)
						[ ] 
						[ ] ReportStatus("Select Account", iSelect, "Banking Account {lsAccountChecking[2]} is selected") 
						[ ] 
						[ ] lsExcelData=ReadExcelTable(sHiddenAccountData, sTransactionSheet)
						[ ] 
						[ ] //Add Payment Transaction to account
						[+] for(i=1;i<=ListCount(lsExcelData);i++)
							[ ] lsTransaction = lsExcelData[i]
							[ ] ///Adding Transactions in this fashion : ("MDI","ATM","<Amount>","<Date>","<Payee>","<Memo>","<Category>")
							[+] if(lsTransaction[1]==NULL)
								[ ] break
							[ ] lsTransaction[4] = sDateStamp
							[ ] iAddTransaction= AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
							[+] if(iAddTransaction==PASS)
								[ ] ReportStatus("Add Transaction: {lsTransaction[2]} ", iAddTransaction, "{lsTransaction[2]} Transaction is added to banking account") 
							[+] else
								[ ] ReportStatus("Verification of {lsTransaction[2]} account window", FAIL, "{lsTransaction[2]} account window not found") 
						[ ] 
					[ ] 
					[+] else
						[ ] ReportStatus("{lsAccountChecking[1]} Account", iAddAccount, "{lsAccountChecking[1]} Account -  {lsAccountChecking[2]}  is not created successfully")
				[ ] 
				[ ] 
				[ ] //Add Brokerage Account
				[ ] iAddAccount = AddManualBrokerageAccount(lsAccountBrokerage[1],lsAccountBrokerage[2],lsAccountBrokerage[3],lsAccountBrokerage[4])
				[ ] 
				[ ] lsExcelData=ReadExcelTable(sHiddenAccountData, sInvestingTransactionWorksheet)
				[ ] 
				[ ] //Report Status if Brokerage Account is created
				[+] if (iAddAccount==PASS)
					[ ] 
					[ ] ReportStatus("{lsAccountBrokerage[1]} Account", iAddAccount, "{lsAccountBrokerage[1]} Account - is created successfully")
					[ ] 
					[ ] //This will click on INVESTING account on AccountBar
					[ ] iSelect = SelectAccountFromAccountBar(lsAccountBrokerage[2],ACCOUNT_INVESTING)
					[ ] 
					[ ] ReportStatus("Select Account", iSelect, "Banking Account {lsAccountBrokerage[2]} is selected") 
					[ ] 
					[ ] //Add Payment Transaction to account
					[+] for(i=1;i<=ListCount(lsExcelData)-2;++i)
						[ ] 
						[+] if(lsExcelData[i][1]==NULL)
							[ ] break
						[ ] 
						[ ] lsExcelData[i][5] = sDateStamp
						[ ] iAddTransaction=AddBrokerageTransaction(lsExcelData[i])
						[ ] 
						[+] if(iAddTransaction==PASS)
							[ ] ReportStatus("Add Transaction: {lsExcelData[i][1]} ", iAddTransaction, "{lsExcelData[i][1]} Transaction is added to banking account") 
						[+] else
							[ ] ReportStatus("Verification of {lsExcelData[i][1]} account window", FAIL, "{lsExcelData[i][1]} Transaction is added to banking account") 
				[+] else
					[ ] ReportStatus("{lsAccountBrokerage[1]} Account", iAddAccount, "{lsAccountBrokerage[1]} Account -  {lsAccountBrokerage[2]}  is not created successfully")
			[ ] 
		[+] else
			[ ] ReportStatus("Data File Create",FAIL,"Data file {sFileName}.QDF is not created")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
[ ] // ###########################################################################
[ ] 
[+] // #############Verify Separate Account Verification Expenses-IncomeYTD ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_SeparateAccExpensesIncomeYTD()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Separate checking account  should not  get considered in the "Tax- Related Expenses YTD" snapshot.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	           If banking account separate successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // 02 April,2013	Anagha Bhandare created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_SeparateAccExpensesIncomeYTD() appstate none// 
	[+] //Variable declaration and definition
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountData, sAccountWorksheet)
		[ ] lsAccountChecking = lsExcelData [1]
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountData, sTransactionSheet)
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_TAX_CENTER)
		[ ] 
		[ ] //Checking before Separating the Account whether the Tax- Related Expenses YTD & Taxable Income YTD is seen .
		[ ] 
		[+] ///Verify Expense Transactions 
			[ ] sHandle = Str(MDIClient.Planning.PlanningSubTab.TaxRelatedExpenses.QWListViewer.ListBox.GetHandle())
			[+] for( iCounter=0;iCounter<MDIClient.Planning.PlanningSubTab.TaxRelatedExpenses.QWListViewer.ListBox.GetItemCount() +1;++iCounter)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "{iCounter}")
				[ ] ListAppend (lsListBoxItems,sActual)
				[ ] 
			[+] for( iCounter=1; iCounter< ListCount (lsExcelData)+1; ++iCounter)
				[ ] lsTransaction=lsExcelData[iCounter]
				[+] if (lsTransaction[5]=="DEP")
					[ ] break
				[ ] iAmount= VAL(lsTransaction[3])
				[+] for each sItem in lsListBoxItems
					[ ] bMatch = MatchStr("*{lsTransaction[8]}*{iAmount}*", sItem)
					[+] if ( bMatch == TRUE)
						[ ] break
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Tax- Related Expenses YTD & Taxable Income YTD ", PASS, "Tax- Related Expenses YTD is displayed on Planning>Tax Canter>Tax Related Expenses YTD: Transaction with Payee:{lsTransaction[6]}, Category :{lsTransaction[8]} and Amount: {iAmount} get displayed as {sItem}.")
				[+] else
					[ ] ReportStatus("Verify Tax- Related Expenses YTD & Taxable Income YTD  ", FAIL, " Tax- Related Expenses YTD is displayed on Planning>Tax Canter>Tax Related Expenses YTD: Transaction with Payee::{lsTransaction[6]}, Category :{lsTransaction[8]} and Amount: {iAmount} didn't display as {sItem}.")
				[ ] 
				[ ] 
		[ ] 
		[+] //Verify Income Transactions 
			[ ] sHandle = Str(MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetHandle())
			[+] for( iCounter=0;iCounter<MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetItemCount() +1;++iCounter)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
				[ ] ListAppend (lsListBoxItems,sActual)
			[+] for( iCounter=1; iCounter< ListCount (lsExcelData)+1; ++iCounter)
				[ ] lsTransaction=lsExcelData[iCounter]
				[+] if (lsTransaction[5]=="DEP")
					[ ] iAmount= VAL(lsTransaction[3])
					[+] for each sItem in lsListBoxItems
						[ ] bMatch = MatchStr("*{lsTransaction[8]}*{iAmount}*", sItem)
						[+] if ( bMatch == TRUE)
							[ ] break
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify Tax- Related Expenses YTD & Taxable Income YTD ", PASS, "Taxable Income YTD is displayed on Planning>Tax Canter>Tax Related Income YTD: Transaction with Payee:{lsTransaction[6]}, Category :{lsTransaction[8]} and Amount: {iAmount} get displayed as {sItem}.")
					[+] else
						[ ] ReportStatus("Verify Tax- Related Expenses YTD & Taxable Income YTD  ", FAIL, "Taxable Income YTD is displayed on Planning>Tax Canter>Tax Related Income YTD: Transaction with Payee::{lsTransaction[6]}, Category :{lsTransaction[8]} and Amount: {iAmount} didn't display as {sItem}.")
		[ ] 
		[ ] //Making Checking 01 Account as "Keep this Account Separate" i.e Separating
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] iResult = SeparateAccount(ACCOUNT_BANKING, lsAccountChecking[2])
		[ ] 
		[+] if(iResult==PASS)
			[ ] 
			[ ] ReportStatus("Separating brokerage account", PASS,"{lsAccountChecking[2]} account separated successfully.")
			[ ] 
			[ ] //Checking after Separating the Account whether the Tax- Related Expenses YTD & Taxable Income YTD is seen .
			[ ] 
			[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_TAX_CENTER)
			[ ] 
			[+] //Verify Expense Transactions 
				[+] if(MDIClient.Planning.PlanningSubTab.TaxRelatedExpenses.TaxRelatedExpensesYTDPane.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Separate account transactions not displayed on Planning>Tax Canter", PASS, "Separate Account transactions not displayed on Planning>Tax Canter>Tax Related Expenses YTD: Transactions didn't display.")
				[+] else
					[ ] ReportStatus("Verify Separate account transactions not displayed on Planning>Tax Canter ", FAIL, "Separate Account transactions displayed on Planning>Tax Canter>Tax Related Expenses YTD:  Transactions get displayed.")
				[ ] 
				[ ] 
			[ ] 
			[+] //Verify Income Transactions 
				[ ] 
				[ ] sHandle = Str(MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetHandle())
				[+] for( iCounter=0;iCounter<MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
					[ ] 
				[+] for( iCounter=1; iCounter< ListCount (lsExcelData)+1; ++iCounter)
					[ ] lsTransaction=lsExcelData[iCounter]
					[ ] iAmount= VAL(lsTransaction[3])
					[ ] bMatch = MatchStr("*{lsTransaction[8]}*{iAmount}*", sActual)
					[+] if ( bMatch == FALSE)
						[ ] break
						[ ] 
				[+] if(bMatch == FALSE)
					[ ] ReportStatus("Verify Separate account transactions not displayed on Planning>Tax Canter", PASS, "Separate Account transactions not displayed on Planning>Tax Canter>Tax Related Income YTD: Transactions didn't display.")
				[+] else
					[ ] ReportStatus("Verify Separate account transactions not displayed on Planning>Tax Canter ", FAIL, "Separate Account transactions displayed on Planning>Tax Canter>Tax Related Income YTD:  Transactions get displayed.")
			[ ] 
		[+] else
			[ ] ReportStatus("Separating brokerage account", PASS,"{lsAccountChecking[2]} account not separated successfully.")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
[ ] // ###########################################################################
[ ] // 
[+] // #############Verify Closed Account Verification Expenses-IncomeYTD ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_ClosedAccExpensesIncomeYTD()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Separate Checking account  should not  get considered in the "Tax- Related Expenses YTD" snapshot.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If banking account closed successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // 02 April,2013	Anagha Bhandare created
	[ ] // ********************************************************
	[ ] 
[+] testcase  Test02_ClosedAccExpensesIncomeYTD() appstate none
	[+] //Variable declaration and definition
		[ ] sTab="Display Options"
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountData, sAccountWorksheet)
		[ ] lsAccountChecking = lsExcelData [1]
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountData, sTransactionSheet)
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] //UnHidding the Separated Account 
			[ ] iNavigate = NavigateToAccountDetailsTab(ACCOUNT_SEPARATE,lsAccountChecking[2],sTab)
			[ ] 
			[+] if (iNavigate == PASS)
				[+] if(sTab=="Display Options")
					[ ] AccountDetails.Click(1,278,53) 
					[ ] iFunctionResult = PASS
					[ ] 
			[+] if(AccountDetails.KeepThisAccountSeparate.Exists(SHORT_SLEEP))
				[ ] AccountDetails.KeepThisAccountSeparate.Uncheck()
				[ ] AccountDetails.OK.Click()
				[ ] 
		[ ] 
		[ ] //Checking before Closing the Account whether the Tax- Related Expenses YTD & Taxable Income YTD is seen .
		[ ] 
		[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_TAX_CENTER)
		[ ] 
		[+] //Verify Expense Transactions 
			[ ] sHandle = Str(MDIClient.Planning.PlanningSubTab.TaxRelatedExpenses.QWListViewer.ListBox.GetHandle())
			[+] for( iCounter=0;iCounter<MDIClient.Planning.PlanningSubTab.TaxRelatedExpenses.QWListViewer.ListBox.GetItemCount() +1;++iCounter)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "{iCounter}")
				[ ] ListAppend (lsListBoxItems,sActual)
				[ ] 
			[+] for( iCounter=1; iCounter< ListCount (lsExcelData)+1; ++iCounter)
				[ ] lsTransaction=lsExcelData[iCounter]
				[+] if (lsTransaction[5]=="DEP")
					[ ] break
				[ ] iAmount= VAL(lsTransaction[3])
				[+] for each sItem in lsListBoxItems
					[ ] bMatch = MatchStr("*{lsTransaction[8]}*{iAmount}*", sItem)
					[+] if ( bMatch == TRUE)
						[ ] break
				[+] if(bMatch)
					[ ] ReportStatus("Verify Tax- Related Expenses YTD & Taxable Income YTD ", PASS, "Tax- Related Expenses YTD is displayed on Planning>Tax Canter>Tax Related Expenses YTD: Transaction with Payee:{lsTransaction[6]}, Category :{lsTransaction[8]} and Amount: {iAmount} get displayed as {sItem}.")
				[+] else
					[ ] ReportStatus("Verify Tax- Related Expenses YTD & Taxable Income YTD  ", FAIL, " Tax- Related Expenses YTD is displayed on Planning>Tax Canter>Tax Related Expenses YTD: Transaction with Payee::{lsTransaction[5]}, Category :{lsTransaction[8]} and Amount: {iAmount} didn't display as {sItem}.")
				[ ] 
				[ ] 
		[ ] 
		[+] //Verify Income Transactions 
			[ ] sHandle = Str(MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetHandle())
			[+] for( iCounter=0;iCounter<MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetItemCount() +1;++iCounter)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
				[ ] ListAppend (lsListBoxItems,sActual)
			[+] for( iCounter=1; iCounter< ListCount (lsExcelData)+1; ++iCounter)
				[ ] lsTransaction=lsExcelData[iCounter]
				[+] if (lsTransaction[5]=="DEP")
					[ ] iAmount= VAL(lsTransaction[3])
					[+] for each sItem in lsListBoxItems
						[ ] bMatch = MatchStr("*{lsTransaction[8]}*{iAmount}*", sItem)
						[+] if ( bMatch == TRUE)
							[ ] break
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify Tax- Related Expenses YTD & Taxable Income YTD ", PASS, "Taxable Income YTD is displayed on Planning>Tax Canter>Tax Related Income YTD: Transaction with Payee:{lsTransaction[6]}, Category :{lsTransaction[8]} and Amount: {iAmount} get displayed as {sItem}.")
					[+] else
						[ ] ReportStatus("Verify Tax- Related Expenses YTD & Taxable Income YTD  ", FAIL, "Taxable Income YTD is displayed on Planning>Tax Canter>Tax Related Income YTD: Transaction with Payee::{lsTransaction[6]}, Category :{lsTransaction[8]} and Amount: {iAmount} didn't display as {sItem}.")
		[ ] 
		[ ] 
		[ ] //Closing the Checking 01 Account 
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] iResult = CloseAccount(ACCOUNT_BANKING,lsAccountChecking[2],1)
		[ ] 
		[+] if(iResult ==PASS)
			[ ] 
			[ ] ReportStatus("Closing Checking account", PASS,"{lsAccountChecking[2]} account closed successfully.")
			[ ] 
			[ ] //Checking before Closing the Account whether the Tax- Related Expenses YTD & Taxable Income YTD is seen .
			[ ] 
			[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_TAX_CENTER)
			[ ] 
			[+] //Verify Expense Transactions 
				[ ] sHandle = Str(MDIClient.Planning.PlanningSubTab.TaxRelatedExpenses.QWListViewer.ListBox.GetHandle())
				[+] for( iCounter=0;iCounter<MDIClient.Planning.PlanningSubTab.TaxRelatedExpenses.QWListViewer.ListBox.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "{iCounter}")
					[ ] ListAppend (lsListBoxItems,sActual)
				[+] for( iCounter=1; iCounter< ListCount (lsExcelData)+1; ++iCounter)
					[ ] lsTransaction=lsExcelData[iCounter]
					[+] if (lsTransaction[5]=="DEP")
						[ ] break
					[ ] iAmount= VAL(lsTransaction[3])
					[+] for each sItem in lsListBoxItems
						[ ] bMatch = MatchStr("*{lsTransaction[8]}*{iAmount}*", sItem)
						[+] if ( bMatch == TRUE)
							[ ] break
					[+] if(bMatch)
						[ ] ReportStatus("Verify Tax- Related Expenses YTD & Taxable Income YTD ", PASS, "Tax- Related Expenses YTD is displayed on Planning>Tax Canter>Tax Related Expenses YTD: Transaction with Payee:{lsTransaction[6]}, Category :{lsTransaction[8]} and Amount: {iAmount} get displayed as {sItem}.")
					[+] else
						[ ] ReportStatus("Verify Tax- Related Expenses YTD & Taxable Income YTD  ", FAIL, " Tax- Related Expenses YTD is displayed on Planning>Tax Canter>Tax Related Expenses YTD: Transaction with Payee::{lsTransaction[6]}, Category :{lsTransaction[8]} and Amount: {iAmount} didn't display as {sItem}.")
					[ ] 
					[ ] 
			[ ] 
			[+] //Verify Income Transactions 
				[ ] sHandle = Str(MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetHandle())
				[+] for( iCounter=0;iCounter<MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
					[ ] ListAppend (lsListBoxItems,sActual)
				[+] for( iCounter=1; iCounter< ListCount (lsExcelData)+1; ++iCounter)
					[ ] lsTransaction=lsExcelData[iCounter]
					[+] if (lsTransaction[5]=="DEP")
						[ ] iAmount= VAL(lsTransaction[3])
						[+] for each sItem in lsListBoxItems
							[ ] bMatch = MatchStr("*{lsTransaction[8]}*{iAmount}*", sItem)
							[+] if ( bMatch == TRUE)
								[ ] break
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify Tax- Related Expenses YTD & Taxable Income YTD ", PASS, "Taxable Income YTD is displayed on Planning>Tax Canter>Tax Related Income YTD: Transaction with Payee:{lsTransaction[6]}, Category :{lsTransaction[8]} and Amount: {iAmount} get displayed as {sItem}.")
						[+] else
							[ ] ReportStatus("Verify Tax- Related Expenses YTD & Taxable Income YTD  ", FAIL, "Taxable Income YTD is displayed on Planning>Tax Canter>Tax Related Income YTD: Transaction with Payee::{lsTransaction[6]}, Category :{lsTransaction[8]} and Amount: {iAmount} didn't display as {sItem}.")
			[ ] 
		[+] else
			[ ] ReportStatus("Closing Checking account", FAIL,"{lsAccountChecking[2]} account not closed successfully.")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
[ ] // ###########################################################################
[ ] // 
[+] // #############Verify Separate Brokerage Account Verification Capital Gains YTD ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_SeparateBrokAccCapitalGainsYTD()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Separate Brokerage account should not  get considered in the "Capital Gains YTD" snapshot.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	           If banking account separate successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // 04 April,2013	                Anagha Bhandare created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test03_SeparateBrokAccCapitalGainsYTD() appstate none
	[+] //Variable declaration and definition
		[ ] 
		[ ] integer iAmount = 150
		[ ] sAccountType="Investing"
		[ ] sCategory="_RlzdGain"
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountData, sAccountWorksheet)
		[ ] lsAccountBrokerage = lsExcelData [3]
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountData, sInvestingTransactionWorksheet)
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_TAX_CENTER)
		[ ] 
		[ ] //Checking before Separating the Brokerage Account whether the the "Capital Gains YTD"  is seen .
		[ ] 
		[+] //Verify Income Transactions 
				[ ] sHandle = Str(MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetHandle ())
				[+] for( iCounter=0;iCounter<MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
					[ ] bMatch = MatchStr("*{sCategory}*{iAmount}*", sActual)
					[+] if ( bMatch == TRUE)
						[ ] break
				[+] if(bMatch)
					[ ] ReportStatus("Verify Capitalized gain for Brokerage account ", PASS, " Verify Capitalized gain for Brokerage account displayed on Planning>Tax Canter>Tax Related Income YTD: Capitalized gain with Category :{sCategory} and Amount: {iAmount} get displayed as {sActual}.")
				[+] else
					[ ] ReportStatus("Verify Capitalized gain for Brokerage account ", FAIL, "Verify Capitalized gain for Brokerage account displayed on Planning>Tax Canter>Tax Related Income YTD:  Capitalized gain with Category :{sCategory} and Amount: {iAmount} didn't display.")
				[ ] 
				[ ] 
		[ ] 
		[ ] //Making Brokerage Account as "Keep this Account Separate" i.e Separating
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] iResult=SeparateAccount(ACCOUNT_INVESTING, lsAccountBrokerage[2])
		[ ] 
		[+] if(iResult==PASS)
			[ ] 
			[ ] ReportStatus("Separating brokerage account", PASS,"{lsAccountBrokerage[2]} account separated successfully.")
			[ ] 
			[ ] //Checking after Separating the Brokerage Account whether the the "Capital Gains YTD"  is seen .
			[ ] 
			[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_TAX_CENTER)
			[ ] 
			[+] //Verify Income Transactions 
					[ ] sHandle = Str(MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetHandle ())
					[+] for( iCounter=0;iCounter<MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetItemCount() +1;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
						[ ] bMatch = MatchStr("*{sCategory}*{iAmount}*", sActual)
						[+] if ( bMatch == TRUE)
							[ ] break
					[+] if(!bMatch)
						[ ] ReportStatus("Verify Capitalized gain for Separated Brokerage account ", PASS, " Verify Capitalized gain for Brokerage account displayed on Planning>Tax Canter>Tax Related Income YTD: Capitalized gain with Category :{sCategory} and Amount: {iAmount} didn't display. ")
					[+] else
						[ ] ReportStatus("Verify Capitalized gain for Separated Brokerage account ", FAIL, "Verify Capitalized gain for Brokerage account displayed on Planning>Tax Canter>Tax Related Income YTD:  Capitalized gain with Category :{sCategory} and Amount: {iAmount} get displayed as {sActual}. ")
			[ ] 
		[+] else
			[ ] ReportStatus("Separating brokerage account", PASS,"{lsAccountBrokerage[2]} account separated successfully.")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
[ ] // ###########################################################################
[ ] // 
[+] // #############Verify Closed Brokerage Account Verification IncomeYTD #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test04_ClosedBrokAccCapitalGainsYTD()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Closed account  should  get considered in the "Capital Gains YTD" snapshot.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	         If brokerage account closed successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // 02 April,2013	Anagha Bhandare created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test04_ClosedBrokAccCapitalGainsYTD() appstate none
	[+] //Variable declaration and definition
		[ ] INTEGER iAmount = 150
		[ ] sAccountType="Investing"
		[ ] sCategory="_RlzdGain"
		[ ] sTab="Display Options"
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountData, sAccountWorksheet)
		[ ] lsAccountBrokerage = lsExcelData [3]
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountData, sInvestingTransactionWorksheet)
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] //UnHidding the Separated Account 
			[ ] iNavigate = NavigateToAccountDetailsTab(ACCOUNT_SEPARATE,lsAccountBrokerage[2],sTab)
			[+] if (iNavigate == PASS)
				[+] if(sTab=="Display Options")
					[ ] AccountDetails.Click(1,278,53) 
					[ ] iFunctionResult = PASS
					[ ] 
			[+] if(AccountDetails.KeepThisAccountSeparate.Exists(SHORT_SLEEP))
				[ ] AccountDetails.KeepThisAccountSeparate.Uncheck()
				[ ] AccountDetails.OK.Click()
				[ ] 
		[ ] 
		[ ] //Checking before Closing the Brokerage Account whether the Tax- Related Expenses YTD & Taxable Income YTD is seen .
		[ ] 
		[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_TAX_CENTER)
		[ ] 
		[+] //Verify Income Transactions 
			[ ] sHandle = Str(MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetHandle ())
			[+] for( iCounter=0;iCounter<MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetItemCount() +1;++iCounter)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
				[ ] bMatch = MatchStr("*{sCategory}*{iAmount}*", sActual)
				[+] if ( bMatch == TRUE)
					[ ] break
			[+] if(bMatch== TRUE)
				[ ] ReportStatus("Verify Capitalized gain for Brokerage account ", PASS, " Verify Capitalized gain for Brokerage account displayed on Planning>Tax Canter>Tax Related Income YTD: Capitalized gain with Category :{sCategory} and Amount: {iAmount} get displayed as {sActual}.")
			[+] else
				[ ] ReportStatus("Verify Capitalized gain for Brokerage account ", FAIL, "Verify Capitalized gain for Brokerage account displayed on Planning>Tax Canter>Tax Related Income YTD:  Capitalized gain with Category :{sCategory} and Amount: {iAmount} didn't display.")
				[ ] 
				[ ] 
		[ ] 
		[ ] //Closing the Brokerage 01 Account 
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] iResult = CloseAccount(ACCOUNT_INVESTING,lsAccountBrokerage[2],1)
		[ ] 
		[+] if(iResult == PASS)
			[ ] 
			[ ] ReportStatus("Closing brokerage account", PASS,"{lsAccountBrokerage[2]} account closed successfully.")
			[ ] 
			[ ] //Checking after Closing the Brokerage Account whether the Tax- Related Expenses YTD & Taxable Income YTD is seen .
			[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_TAX_CENTER)
			[ ] 
			[+] //Verify Income Transactions 
				[ ] sHandle = Str(MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetHandle ())
				[+] for( iCounter=0;iCounter<MDIClient.Planning.PlanningSubTab.TaxRelatedIncome.QWListViewer.ListBox.GetItemCount() +1;++iCounter)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
					[ ] bMatch = MatchStr("*{sCategory}*{iAmount}*", sActual)
					[+] if ( bMatch == TRUE)
						[ ] break
				[+] if( bMatch == TRUE)
					[ ] ReportStatus("Verify Capitalized gain for Brokerage account ", PASS, " Verify Capitalized gain for Brokerage account displayed on Planning>Tax Canter>Tax Related Income YTD: Capitalized gain with Category :{sCategory} and Amount: {iAmount} get displayed as {sActual}.")
				[+] else
					[ ] ReportStatus("Verify Capitalized gain for Brokerage account ", FAIL, "Verify Capitalized gain for Brokerage account displayed on Planning>Tax Canter>Tax Related Income YTD:  Capitalized gain with Category :{sCategory} and Amount: {iAmount} didn't display.")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Closing brokerage account", FAIL,"{lsAccountBrokerage[2]} account not closed successfully.")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] // ###########################################################################
[ ] // 
[ ] // #############Tools-Online Module [USER STORY : US906 - TA2405-TA2409]#########
[ ] 
[+] // #############  SetUp ######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Tools_SetUp() 
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // It will setup the necessary pre-requisite for tests.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If no error occurs while deleting and creating file							
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Mar 21,2013		Anagha Bhandare created
	[ ] // ********************************************************
[+] testcase ToolsOnline_SetUp() appstate QuickenBaseState
	[ ] 
	[ ] //Variable declaration and definition
	[ ] STRING sSourceFile
	[ ] sDateStamp = FormatDateTime (GetDateTime(), "mm/dd/yyyy") 
	[ ] sFileName = "HiddenAccountToolsOL"
	[ ] sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
	[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] sTab= "Display Options"
	[ ] 
	[ ] // //Fetching data from Excel Sheet
	[ ] // lsExcelData=ReadExcelTable(sHiddenAccountData, sBankingAccWorksheet)
	[ ] 
	[ ] // Load O/S specific paths
	[ ] 
	[ ] 
	[ ] SetUp_AutoApi()
	[+] if(FileExists(sDataFile) == TRUE)
		[ ] sCaption = QuickenWindow.GetCaption ()
		[+] if(MatchStr("*{sFileName}*", sCaption))
			[+] if(QuickenWindow.Exists(SHORT_SLEEP))
				[ ] QuickenWindow.Kill()
				[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[+] if (!QuickenWindow.Exists())
		[ ] LaunchQuicken()
		[ ] WaitForState(QuickenWindow, TRUE ,10)
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Creating a Data file
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Create Data File
		[ ] iCreateDataFile = OpenDataFile(sFileName)
		[ ] 
		[ ] //Report Staus If Data file Created successfully
		[ ] 
		[+] if(iCreateDataFile==PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] 
			[ ] BypassRegistration()
			[ ] 
			[+] //---Need to remove----if needed
				[ ] // RegisterQuickenConnectedServices()
				[ ] // 
				[ ] // //Add Checking Account
				[+] // for(i=1;i<=4;i++)
					[ ] // lsAccountChecking = lsExcelData[i]
					[ ] // 
					[+] // if (lsAccountChecking[1]==NULL)
						[ ] // break
					[ ] // lsAccountChecking[4] = sDateStamp
					[ ] // // Add Checking Account
					[ ] // iAddAccount = AddManualSpendingAccount(lsAccountChecking[1], lsAccountChecking[2],lsAccountChecking[3], lsAccountChecking[4])
					[ ] // // Report Status if checking Account is created
					[+] // if (iAddAccount==PASS)
						[ ] // ReportStatus("{lsAccountChecking[1]} Account", iAddAccount, "{lsAccountChecking[1]} Account -  {lsAccountChecking[2]}  is created successfully")
					[+] // else
						[ ] // ReportStatus("{lsAccountChecking[1]} Account", iAddAccount, "{lsAccountChecking[1]} Account -  {lsAccountChecking[2]}  is not created successfully")
						[ ] // 
				[ ] // 
				[ ] // //Fetching data from Excel Sheet
				[ ] // lsExcelData1=ReadExcelTable(sHiddenAccountData, sOnlineAccWorksheet)
				[ ] // 
				[ ] // //Creating Online Checking Accounts
				[+] // for(i=1;i<=listCount(lsExcelData1);i++)
					[ ] // lsAccountId = lsExcelData1[i]
					[+] // if(lsAccountId[1]==NULL)
						[ ] // break
					[ ] // iAddAccount=AddCCMintBankAccount(lsAccountId[1],lsAccountId[2])
					[ ] // 
					[+] // if (iAddAccount==PASS)
						[ ] // ReportStatus("{lsAccountId[3]} Account", iAddAccount, "Online Checking Account -  {lsAccountId[3]}  is created successfully")
					[+] // else
						[ ] // ReportStatus("{lsAccountId[3]} Account", iAddAccount, "Online Checking Account -  {lsAccountId[3]}  is not created successfully")
						[ ] // 
					[ ] // 
				[ ] 
				[ ] // lsExcelData=ReadExcelTable(sHiddenAccountData, sBankingAccWorksheet)
				[ ] // 
				[ ] // //Making Checking 01 Account as "Keep this Account Separate"
				[ ] // 
				[ ] // iResult= SeparateAccount(ACCOUNT_BANKING, lsExcelData[1][2],1)
				[ ] // 
				[+] // if(iResult == PASS)
					[ ] // 
					[ ] // ReportStatus("Separate Checking 01 Account", PASS,"{lsExcelData[1][2]} account separated successfully.")
					[ ] // 
					[ ] // NavigateQuickenTab(sTAB_HOME)
					[ ] // 
					[ ] // //Making Checking 02 Account as "Hide In Transaction Entry List" 
					[ ] // 
					[ ] // iResult= AccountHideInTransactionList(ACCOUNT_BANKING,lsExcelData[2][2],1)
					[ ] // 
					[+] // if(iResult == PASS)
						[ ] // 
						[ ] // ReportStatus("Hide In Transaction Entry List Checking 02 Account", PASS,"{lsExcelData[2][2]} account hide in transaction entry list successfully.")
						[ ] // 
						[ ] // NavigateQuickenTab(sTAB_HOME)
						[ ] // 
						[ ] // //Making Checking 03 Account as "Hide in Account Bar & Account List" 
						[ ] // 
						[ ] // iResult= AccountHideInAccountBarAccountList(ACCOUNT_BANKING,lsExcelData[3][2],2)
						[ ] // 
						[+] // if(iResult == PASS)
							[ ] // 
							[ ] // ReportStatus("Hide in Account Bar & Account List Checking 03 Account", PASS,"{lsExcelData[3][2]} account hide in Account Bar & Account List successfully.")
							[ ] // 
							[ ] // NavigateQuickenTab(sTAB_HOME)
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Hide in Account Bar & Account List Checking 03 Account", FAIL,"{lsExcelData[3][2]} account hide in Account Bar & Account List successfully.")
					[+] // else
						[ ] // ReportStatus("Hide In Transaction Entry List Checking 02 Account", FAIL,"{lsExcelData[2][2]} account not hide in transaction entry list successfully.")
				[+] // else
					[ ] // ReportStatus("Separate Checking 01 Account", FAIL,"{lsExcelData[1][2]} account not separated successfully.")
			[ ] 
			[ ] //Report Staus If Data file is not Created 
		[+] else 
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] // ###########################################################################
[ ] // 
[+] // #############Verify CloseAccount Verification OSU ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_CloseAccountVerificationOSU()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Closed accounts should not be included in OSU
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If banking account closed successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // /Mar 29,2013	Anagha Bhandare created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test01_CloseAccountVerificationOSU() appstate none
	[+] //Variable declaration and definition
		[ ] STRING  sOnlAccountID
		[ ] 
		[ ] sAccountName = "Online Checking 02 2"
		[ ] sTab= "Display Options"
		[ ] sOnlAccountID = "CCMintBank - User - 02"
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] //Checking before Closing the Accounts whether the FI is listed in One Step Update
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Tools.Click()
		[ ] QuickenWindow.Tools.OneStepUpdate.Select()
		[+] if(OneStepUpdate.Exists(SHORT_SLEEP))
			[ ] 
			[ ] ReportStatus("Validate One Step Update Window", PASS, "One Step Update Window is present")
			[ ] 
			[ ] sHandle = Str(OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetHandle())
			[+] for( iCounter=1;iCounter<=OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetItemCount()*2;iCounter++)
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}")
				[ ] bMatch = MatchStr("*{sOnlAccountID}*",sActual)
				[+] if(bMatch == TRUE)
					[ ] break
			[ ] 
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Verify FI name is listed in the One Step Update Window before closing Online Account ", PASS, "{sOnlAccountID}  is listed in the One Step Update Window before closing Online Account")
			[+] else
				[ ] ReportStatus("Verify FI name is listed in the One Step Update Window before closing Online Account ", FAIL, "{sOnlAccountID}  is not listed in the One Step Update Window before closing Online Account")
			[ ] 
			[ ] OneStepUpdate.Close()
			[ ] 
			[ ] //Closing the Online Banking Account
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] iResult = CloseAccount(ACCOUNT_BANKING,sAccountName)
			[ ] 
			[+] if(iResult == PASS)
				[ ] 
				[ ] //Checking after Closing the Accounts whether the FI is listed in One Step Update
				[ ] 
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] QuickenWindow.Tools.OneStepUpdate.Select()
				[ ] 
				[ ] sHandle = Str(OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetHandle())
				[+] for( iCounter=1;iCounter<=OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetItemCount()*2;iCounter++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}")
					[ ] bMatch = MatchStr("*{sOnlAccountID}*",sActual)
					[+] if(bMatch == TRUE)
						[ ] break
				[+] if(bMatch == FALSE)
					[ ] ReportStatus("Verify FI name is listed in the One Step Update Window after closing Online Account ", PASS, "{sOnlAccountID}  is not listed in the One Step Update Window after closing Online Account")
				[+] else
					[ ] ReportStatus("Verify FI name is listed in the One Step Update Window after closing Online Account ", FAIL, "{sOnlAccountID}  is listed in the One Step Update Window after closing Online Account")
				[ ] 
				[ ] OneStepUpdate.Close()
			[+] else
				[ ] ReportStatus("Verify Account can be closed", FAIL, "Account cannot be closed")
		[+] else
			[ ] ReportStatus("Validate One Step Update Window", FAIL, "One Step Update Window is not present")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
	[ ] 
	[ ] 
[ ] // ###########################################################################
[ ] // 
[+] // // #############Verify CloseAccount Verification OSU Summary############################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test02_CloseAccountVerificationOSUSummary()
		[ ] // // 
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify Closed accounts should not be displayed on OSU summary is account is closed after successful OSU
		[ ] // // 
		[ ] // // PARAMETERS:		None
		[ ] // // 
		[ ] // // RETURNS:			        Pass 	If banking account closed successfully						
		[ ] // // Fail		If any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // Mar 29,2013	Anagha Bhandare created
	[ ] // // ********************************************************
[+] // testcase Test02_CloseAccountVerificationOSUSummary() appstate none
	[+] // //Variable declaration and definition
		[ ] // LIST OF STRING  lsAccountName
		[ ] // STRING  sOnlAccountID
		[ ] // 
		[ ] // sAccountName = "Online Checking 01 1"
		[ ] // sTab= "Display Options"
		[ ] // sOnlAccountID = "CCMintBank (User - 01)"
		[ ] // 
		[ ] // iSetupAutoAPI = SetUp_AutoApi()
		[ ] // ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] // 
		[ ] // 
	[+] // if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] // 
		[ ] // NavigateQuickenTab(sTAB_HOME)
		[ ] // 
		[ ] // //Checking before Closing the Accounts whether the FI is listed in One Step Update
		[ ] // QuickenWindow.SetActive()
		[ ] // QuickenWindow.Tools.Click()
		[ ] // QuickenWindow.Tools.OneStepUpdateSummary.Select()
		[ ] // 
		[+] // if(OneStepUpdateSummary.Exists(2))
			[ ] // 
			[ ] // ReportStatus("Validate One Step Update Summary Window", PASS, "One Step Update Summary Window is present")
			[ ] // 
			[ ] // sHandle = Str(OneStepUpdateSummary.Panel.QWinChild.Panel2.OneStepUpdateSummary1.ListBox.GetHandle())
			[+] // for( iCounter=0;iCounter<=OneStepUpdateSummary.Panel.QWinChild.Panel2.OneStepUpdateSummary1.ListBox.GetItemCount();iCounter++)
				[ ] // sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}")
				[ ] // bMatch = MatchStr("*{sOnlAccountID}*",sActual)
				[+] // if(bMatch == TRUE)
					[ ] // break
			[+] // if(bMatch == TRUE)
				[ ] // ReportStatus("Verify FI name is listed in the One Step Update Window before closing Online Account ", PASS, "{sOnlAccountID}  is listed in the One Step Update Window before closing Online Account")
			[+] // else
				[ ] // ReportStatus("Verify FI name is listed in the One Step Update Window before closing Online Account ", FAIL, "{sOnlAccountID}  is not listed in the One Step Update Window before closing Online Account")
			[ ] // 
			[ ] // OneStepUpdateSummary.Close()
			[ ] // 
			[ ] // //Closing the Online Banking Account
			[ ] // NavigateQuickenTab(sTAB_HOME)
			[ ] // 
			[ ] // iResult = CloseAccount(ACCOUNT_BANKING,sAccountName,3)
			[+] // if(iResult == PASS)
				[ ] // 
				[ ] // //Checking after Closing the Accounts whether the FI is listed in One Step Update
				[ ] // 
				[ ] // QuickenWindow.SetActive()
				[ ] // QuickenWindow.Tools.Click()
				[ ] // QuickenWindow.Tools.OneStepUpdateSummary.Select()
				[ ] // 
				[ ] // sHandle = Str(OneStepUpdateSummary.Panel.QWinChild.Panel2.OneStepUpdateSummary1.ListBox.GetHandle())
				[+] // for( iCounter=0;iCounter<OneStepUpdateSummary.Panel.QWinChild.Panel2.OneStepUpdateSummary1.ListBox.GetItemCount() +1;++iCounter)
					[ ] // sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}")
					[ ] // bMatch = MatchStr("*{sOnlAccountID}*",sActual)
					[+] // if(bMatch == TRUE)
						[ ] // break
				[+] // if(bMatch == FALSE)
					[ ] // ReportStatus("Verify FI name is listed in the One Step Update Window before closing Online Account ", PASS, "{sOnlAccountID}  is not listed in the One Step Update Window after closing Online Account")
				[+] // else
					[ ] // ReportStatus("Verify FI name is listed in the One Step Update Window before closing Online Account ", FAIL, "{sOnlAccountID}  is listed in the One Step Update Window after closing Online Account")
				[ ] // 
				[ ] // OneStepUpdateSummary.Close()
			[+] // else
				[ ] // ReportStatus("Verify Account can be closed", FAIL, "Account cannot be closed")
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate One Step Update Summary Window", FAIL, "One Step Update Summary Window is not present")
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] // 
	[ ] // 
	[ ] // 
[ ] // // ###########################################################################
[ ] // 
[+] // #############Verify Close Account Verification Reconcile############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_CloseAccountVerificationReconcile()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Closed accounts should not be displayed on Reconcile an account
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If banking account closed successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Mar 21,2013	Anagha Bhandare created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test03_CloseAccountVerificationReconcile() appstate none
	[+] //Variable declaration and definition
		[ ] LIST OF STRING  lsCompare
		[ ] STRING  sAccountName,sTab
		[ ] 
		[ ] sAccountName = "Online Checking 03 3"
		[ ] sTab= "Display Options"
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //AddCCMintBankAccount(sAccountId,sAccPassword)
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] //Checking before Closing the Account whether it is listed in Reconcile a Account 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Tools.Click()
		[ ] QuickenWindow.Tools.ReconcileAnAccount.Select()
		[ ] 
		[+] if(ChooseReconcileAccount.Exists(2))
			[ ] 
			[ ] ReportStatus("Validate Choose Reconcile Account Window", PASS, "Choose Reconcile Account Window is present")
			[ ] 
			[ ] lsCompare=ChooseReconcileAccount.ChooseAccount.GetContents()
			[ ] 
			[+] for(i=1;i<=listCount(lsCompare);i++)
				[ ] bMatch = MatchStr("*{sAccountName}*",lsCompare[i])
				[+] if(bMatch == TRUE)
					[ ] break
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Verify Account is listed in the Choose Account for Reconcile", PASS, "{sAccountName}  is listed in the Choose Account for Reconcile")
			[+] else
				[ ] ReportStatus("Verify Account is listed in the Choose Account for Reconcile", FAIL, "{sAccountName}  is not listed in the Choose Account for Reconcile")
			[ ] 
			[ ] ChooseReconcileAccount.Close()
			[ ] 
			[ ] //Closing the Online Banking Account
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] iResult = CloseAccount(ACCOUNT_BANKING,sAccountName,5)
			[ ] 
			[+] if(iResult == PASS)
				[ ] 
				[ ] //Checking after Closing the Account whether it is listed in Reconcile a Account 
				[ ] 
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Tools.Click()
				[ ] QuickenWindow.Tools.ReconcileAnAccount.Select()
				[ ] 
				[+] if(ChooseReconcileAccount.Exists(2))
					[ ] 
					[ ] lsCompare=ChooseReconcileAccount.ChooseAccount.GetContents()
					[ ] 
					[+] for(i=1;i<=listCount(lsCompare);i++)
						[ ] bMatch = MatchStr("*{sAccountName}*",lsCompare[i])
						[ ] if(bMatch == FALSE)
						[ ] break
						[ ] 
					[+] if(bMatch == FALSE)
						[ ] ReportStatus("Verify Account is listed in the Choose Account for Reconcile", PASS, "{sAccountName}  is not listed in the Choose Account for Reconcile")
					[+] else
						[ ] ReportStatus("Verify Account is listed in the Choose Account for Reconcile", FAIL, "{sAccountName}  is listed in the Choose Account for Reconcile")
					[ ] 
					[ ] ChooseReconcileAccount.Close()
			[+] else
				[ ] ReportStatus("Verify Account can be closed", FAIL, "Account cannot be closed")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Choose Reconcile Account Window", FAIL, "Choose Reconcile Account Window is present")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
	[ ] 
	[ ] 
[ ] // ###########################################################################
[ ] // 
[+] // #############Verify Close Account Verification Online Centre ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_CloseAccountVerificationOnlineCentre
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Closed accounts should not be displayed on Online centre
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If banking account closed successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // /Mar 29,2013	Anagha Bhandare created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test04_CloseAccountVerificationOnlineCentre() appstate none
	[+] //Variable declaration and definition
		[ ] STRING  sCompare
		[ ] 
		[ ] sAccountName = "Online Checking 04 4"
		[ ] sTab= "Display Options"
		[ ] sCompare = "CCMintBank"
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] //Checking before Closing the Accounts whether the Accounts are listed in Online Center
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] QuickenWindow.Tools.OnlineCenter.Select()
			[ ] 
			[+] if(OnlineCenter.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Online Center Window ", PASS, "Online Center Window is present")
				[ ] //Verify the FI name in the List
				[ ] lsFICompare=OnlineCenter.FinancialInstitution.GetContents()
				[ ] 
				[+] for(i=1;i<=listCount(lsFICompare);i++)
					[+] if(lsFICompare[i]==sCompare)
						[ ] ReportStatus("Verify FI Account is listed in the Online Center ", PASS, "{sCompare}  is listed in the Online Center")
						[ ] break
					[+] else
						[ ] continue
					[ ] 
				[ ] 
				[ ] //Checking before Closing the Accounts whether the Accounts are listed in Online Center
				[ ] sHandle = Str(OnlineCenter.ClearedTransactionsAndOnlin2.ListBox1.GetHandle())
				[+] for( iCounter=0;iCounter<OnlineCenter.ClearedTransactionsAndOnlin2.ListBox1.GetItemCount() +1;++iCounter)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}")
					[ ] bMatch = MatchStr("*{sAccountName}*",sActual)
					[+] if(bMatch == TRUE)
						[ ] break
					[ ] 
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify Account Name is listed in Online Center before closing Online Account ", PASS, "{sAccountName}  is listed in Online Center before closing Online Account")
				[+] else
					[ ] ReportStatus("Verify Account Name is listed in Online Center before closing Online Account ", FAIL, "{sAccountName}  is not listed in Online Center before closing Online Account")
				[ ] 
				[ ] OnlineCenter.Close()
				[ ] 
				[ ] //Closing the Online Banking Account
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] iResult = CloseAccount(ACCOUNT_BANKING,sAccountName,6)
				[+] if(iResult == PASS)
					[ ] //Checking after Closing the Accounts whether the Accounts are listed in Online Center
					[ ] NavigateQuickenTab(sTAB_HOME)
					[ ] 
					[ ] QuickenWindow.Tools.OnlineCenter.Select()
					[ ] 
					[+] if(OnlineCenter.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Online Center Window ", PASS, "Online Center Window is present")
						[ ] sHandle = Str(OnlineCenter.ClearedTransactionsAndOnlin2.ListBox1.GetHandle())
						[ ] 
						[+] for( iCounter=0;iCounter<OnlineCenter.ClearedTransactionsAndOnlin2.ListBox1.GetItemCount() +1;++iCounter)
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}")
							[ ] bMatch = MatchStr("*{sAccountName}*",sActual)
							[+] if(bMatch == TRUE)
								[ ] break
							[ ] 
						[+] if(bMatch == FALSE)
							[ ] ReportStatus("Verify Account Name is listed in Online Center after closing Online Account ", PASS, "{sAccountName}  is not listed in Online Center after closing Online Account")
						[+] else
							[ ] ReportStatus("Verify Account Name is listed in Online Center after closing Online Account ", FAIL, "{sAccountName}  is listed in Online Center after closing Online Account")
						[ ] 
						[ ] OnlineCenter.Close()
					[+] else
						[ ] ReportStatus("Verify Online Center Window ", FAIL, "Online Center Window is not present")
				[+] else
					[ ] ReportStatus("Verify Account can be closed", FAIL, "Account cannot be closed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Online Center Window ", FAIL, "Online Center Window is not present")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
	[ ] 
	[ ] 
[ ] // ###########################################################################
[ ] // 
[+] // //#############Verify Close Account Verification Password Vault ############################################
	[ ] // //********************************************************
	[+] // //TestCase Name:	 Test05_CloseAccountVerificationOnlineCentre
		[ ] // 
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify Closed accounts should not be displayed on Online centre
		[ ] // // 
		[ ] // // PARAMETERS:		None
		[ ] // // 
		[ ] // // RETURNS:			        Pass 	If banking account closed successfully						
		[ ] // //                                            Fail		If any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // /Mar 29,2013	Anagha Bhandare created
	[ ] // //********************************************************
	[ ] // 
[+] testcase Test06_CloseAccountVerificationPasswordVault() appstate none
	[+] //Variable declaration and definition
		[ ] STRING  sCompare,sAccountName
		[ ] LIST OF STRING  lsFICompare,lsIDCompare,lsIDName
		[ ] INTEGER iCount
		[ ] sCompare = "CCMintBank"
		[ ] lsIDName = {sCompare,"User - 01","User - 05","User - 06","User - 07"}
		[ ] sAccountName = "Online Checking 05 5"
		[ ] sTab= "Display Options"
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] //Checking before Closing the Accounts whether the FI is listed in Password Vault Setup
		[ ] //Checking before Closing the Accounts whether the Customer IDs are listed in Password Vault Setup
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Tools.Click()
		[ ] QuickenWindow.Tools.PasswordVault.Click()
		[ ] QuickenWindow.Tools.PasswordVault.AddOrEditPasswords.Select()
		[ ] 
		[+] if(EditPasswordVault.Exists(2))
			[ ] ReportStatus("Verify Edit Password Vault Window ", PASS, "Edit Password Vault Window is present")
			[ ] 
			[ ] EditPasswordVault.SetActive()
			[ ] 
			[ ] iCount=EditPasswordVault.QWListViewer.AccountListBox.GetItemCount()
			[ ] 
			[+] for(i=0;i<iCount;i++)
				[ ] sHandle = Str(EditPasswordVault.QWListViewer.AccountListBox.GetHandle())	   // get the handle
				[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
				[ ] bMatch = MatchStr("*{lsIDName[i+1]}*",sActual)
				[+] if(bMatch)
					[+] if(i==0)
						[ ] ReportStatus("Verify FI Account is listed in the Edit Password Vault Window ", PASS, "{sCompare}  is listed in Edit Password Vault Window")
					[+] else
						[ ] ReportStatus("Verify ID Name is listed in Customer ID -Password Vault Setup before closing Online Account ", PASS, "{lsIDName[i+1]}  is listed in Customer ID -Password Vault Setup before closing Online Account")
						[ ] 
				[+] else
					[+] if(i==0)
						[ ] ReportStatus("Verify FI Account is listed in the Edit Password Vault Window ", FAIL, "{sCompare}  is not listed in the Edit Password Vault Window")
					[+] else
						[ ] ReportStatus("Verify ID Name is listed in Customer ID -Password Vault Setup before closing Online Account ", FAIL, "{lsIDName[1]},{lsIDName[i+1]}  is not listed in Customer ID -Password Vault Setup before closing Online Account")
						[ ] 
			[ ] 
			[ ] EditPasswordVault.Cancel.Click()
			[ ] 
			[ ] 
			[ ] //Closing the Online Banking Account
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] iResult = CloseAccount(ACCOUNT_BANKING,sAccountName,7)
			[ ] 
			[+] if(iResult == PASS)
				[ ] //Checking after Closing the Accounts whether the FI is listed in Password Vault Setup
				[ ] //Checking after Closing the Accounts whether the Customer IDs are listed in Password Vault Setup
				[ ] 
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Tools.Click()
				[ ] QuickenWindow.Tools.PasswordVault.Click()
				[ ] QuickenWindow.Tools.PasswordVault.AddOrEditPasswords.Select()
				[ ] 
				[+] if(EditPasswordVault.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify EditPassword Vault Window ", PASS, "Edit Password Vault Window is present")
					[ ] 
					[ ] iCount=EditPasswordVault.QWListViewer.AccountListBox.GetItemCount()
					[ ] 
					[+] for(i=0;i<iCount;i++)
						[ ] sHandle = Str(EditPasswordVault.QWListViewer.AccountListBox.GetHandle())	   // get the handle
						[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
						[ ] bMatch = MatchStr("*{lsIDName[3]}*",sActual)
						[+] if(bMatch)
							[ ] ReportStatus("Verify ID Name is listed in after closing Online Account ", FAIL, "{lsIDName[3]}  is listed in Edit Password Vault window after closing Online Account")
							[ ] break
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify ID Name is listed in after closing Online Account ", PASS, "{lsIDName[3]}  is not listed in Edit Password Vault window after closing Online Account")
					[ ] 
					[ ] EditPasswordVault.Cancel.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Edit Password Vault Window ", FAIL, "Edit Password Vault Window is not present")
			[+] else
				[ ] ReportStatus("Verify Account can be closed", FAIL, "Account cannot be closed")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Set up Your Password Vault Window ", FAIL, "Set up Your Password Vault Window is not present")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] 
[ ] //************************************************************************************************************
[ ] 
[+] //#############  Planning SetUp #########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Planning_SetUp ()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // It will setup the necessary pre-requisite for tests . 
		[ ] //It will create the Banking ,Investing ,Loan,Asset Accounts and Savings Goals
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			       Pass 	If transactions of the closed account are part of the budget
		[ ] //						Fail		If any error occurs or If transactions of the closed account are NOT part of the budget
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	04-April-2013 				Anagha created
	[ ] // ********************************************************
	[ ] 
[+] testcase Planning_SetUp () appstate QuickenBaseState
	[ ] 
	[+] //--Need to remove-if needed---
		[+] // // Variable declaration
			[ ] // 
		[+] // // Variable Defination
			[ ] // sFileName="HA_Planning"
			[ ] // sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
			[ ] // sAccountType = "Banking"
			[ ] // lsExcelData=ReadExcelTable(sHiddenAccountExcel, sBankingAccWorksheet)
			[ ] // 
		[+] // if(QuickenMainWindow.Exists(SHORT_SLEEP))
			[ ] // 
			[ ] // QuickenMainWindow.SetActive()
			[ ] // //Create Data File
			[ ] // iCreateDataFile = DataFileCreate(sFileName)
			[ ] // //Report Staus If Data file Created successfully
			[+] // if(iCreateDataFile==PASS)
				[ ] // ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
				[ ] // 
				[+] // //Account creation of Checking Account
					[+] // for(i=1;i<=ListCount(lsExcelData);i++)
						[ ] // //Add Checking Account
						[ ] // lsAccount = lsExcelData[i]
						[+] // if (lsAccount[1]==NULL)
							[ ] // break
						[ ] // lsAccount[4] = sDateStamp
						[ ] // iAddAccount = AddManualSpendingAccount(lsAccount[1], lsAccount[2], lsAccount[3], lsAccount[4])
						[+] // if (iAddAccount==PASS) // Checking Account is created
							[ ] // ReportStatus("{lsAccount[1]} Account", iAddAccount, "{lsAccount[1]} Account -  {lsAccount[2]}  is created successfully")
						[+] // else
							[ ] // ReportStatus("{lsAccount[1]} Account", iAddAccount, "{lsAccount[1]} Account -  {lsAccount[2]}  is not created successfully")
							[ ] // 
				[ ] // 
				[+] // //Account creation of Credit Card Account
					[ ] // lsExcelData=ReadExcelTable(sHiddenAccountExcel,sCreditAccWorksheet)
					[ ] // 
					[+] // for(i=1;i<=ListCount(lsExcelData);i++)
						[ ] // //Add Checking Account
						[ ] // lsCreditAccount = lsExcelData[i]
						[+] // if (lsCreditAccount[1]==NULL)
							[ ] // break
						[ ] // lsCreditAccount[4] = sDateStamp
						[ ] // //Add Credit Card Account
						[ ] // iAddAccount = AddManualSpendingAccount(lsCreditAccount[1], lsCreditAccount[2], lsCreditAccount[3], lsCreditAccount[4])
						[ ] // 
						[+] // if (iAddAccount==PASS) // Credit Card Account is created
							[ ] // ReportStatus("{lsCreditAccount[1]} Account", iAddAccount, "{lsCreditAccount[1]} Account -  {lsCreditAccount[2]}  is created successfully")
						[+] // else
							[ ] // ReportStatus("{lsCreditAccount[i][1]} Account", iAddAccount, "{lsCreditAccount[i][1]} Account -  {lsCreditAccount[i][2]}  is not created successfully")
					[ ] // 
				[ ] // 
				[+] // //Account creation of Brokerage Account
					[ ] // lsExcelData=ReadExcelTable(sHiddenAccountExcel, sInvestingAccWorksheet)
					[+] // for(i=1;i<=ListCount(lsExcelData);i++)
						[ ] // lsAccount = lsExcelData[i]
						[+] // if (lsAccount[1]==NULL)
							[ ] // break
						[ ] // lsAccount[4] = sDateStamp
						[ ] // // Add Brokerage Account
						[ ] // iAddAccount = AddManualBrokerageAccount(lsAccount[1],lsAccount[2],lsAccount[3],lsAccount[4],lsAccount[5],lsAccount[6])
						[+] // if (iAddAccount==PASS) // Brokerage Account is created
							[ ] // 
							[ ] // ReportStatus("{lsAccount[1]} Account", iAddAccount, "{lsAccount[1]} Account -  {lsAccount[2]}  is created successfully")
						[+] // else
							[ ] // ReportStatus("{lsAccount[1]} Account", iAddAccount, "{lsAccount[1]} Account -  {lsAccount[2]}  is not created successfully")
							[ ] // 
				[ ] // 
				[+] // //Account creation of Loan Account
					[ ] // lsExcelData=ReadExcelTable(sHiddenAccountExcel, sLoanAccWorksheet)
					[+] // for(i=1;i<=ListCount(lsExcelData);i++)
						[ ] // lsLoanAccount = lsExcelData[i]
						[+] // if (lsLoanAccount[1]==NULL)
							[ ] // break
						[ ] // lsLoanAccount[3] = sDateStamp
						[ ] // 
						[ ] // // Add Loan Account
						[ ] // AddLoanAccount(lsLoanAccount[1],lsLoanAccount[2],lsLoanAccount[3],lsLoanAccount[4],lsLoanAccount[5],lsLoanAccount[6])
						[+] // if (iAddAccount==PASS) // Loan Account is created
							[ ] // 
							[ ] // ReportStatus("{lsLoanAccount[1]} Account", iAddAccount, "{lsLoanAccount[1]} Account -  {lsLoanAccount[2]}  is created successfully")
						[+] // else
							[ ] // ReportStatus("{lsLoanAccount[1]} Account", iAddAccount, "{lsLoanAccount[1]} Account -  {lsLoanAccount[2]}  is not created successfully")
					[ ] // 
					[ ] // 
					[ ] // 
					[ ] // 
					[ ] // 
				[ ] // 
				[+] // //Adding a Saving Goal Account
					[ ] // 
					[ ] // lsExcelData=ReadExcelTable(sHiddenAccountExcel, sSavingsGoalsWorksheet)
					[ ] // 
					[+] // for(i=1;i<=ListCount(lsExcelData);i++)
						[ ] // lsSGAccount = lsExcelData[i]
						[+] // if (lsAccount[1]==NULL)
							[ ] // break
						[ ] // lsSGAccount[3] = sDateStamp
					[ ] // 
					[ ] // iAddAccount =AddSavingGoal(lsSGAccount[1],lsSGAccount[2],lsSGAccount[3]) 
					[+] // if (iAddAccount==PASS) // Savings Goals Account is created
						[ ] // 
						[ ] // ReportStatus("{lsSGAccount[1]} Account", iAddAccount, "{lsSGAccount[1]} Account -  {lsSGAccount[2]}  is created successfully")
					[+] // else
						[ ] // ReportStatus("{lsSGAccount[1]} Account", iAddAccount, "{lsSGAccount[1]} Account -  {lsSGAccount[2]}  is not created successfully")
					[ ] // 
				[ ] // 
				[+] // //Account creation of Asset Account
					[ ] // 
					[ ] // lsExcelData=ReadExcelTable(sHiddenAccountExcel, sAssestAccWorksheet)
					[ ] // 
					[+] // for(i=1;i<=ListCount(lsExcelData);i++)
						[ ] // lsAccount = lsExcelData[i]
						[+] // if (lsAccount[1]==NULL)
							[ ] // break
						[ ] // lsAccount[3] = sDateStamp
						[ ] // 
						[ ] // //Add a Assest Account
						[ ] // iValidate=AddPropertyAccount(lsAccount[1],lsAccount[2],lsAccount[3],lsAccount[4])
						[+] // if (iAddAccount==PASS) // Loan Account is created
							[ ] // 
							[ ] // ReportStatus("{lsAccount[1]} Account", iAddAccount, "{lsAccount[1]} Account -  {lsAccount[2]}  is created successfully")
						[+] // else
							[ ] // ReportStatus("{lsAccount[1]} Account", iAddAccount, "{lsAccount[1]} Account -  {lsAccount[2]}  is not created successfully")
				[ ] // 
				[+] // //Add Payment Transaction to Checking Account
					[ ] // lsExcelData=ReadExcelTable(sHiddenAccountExcel, sTransactionWorksheet)
					[+] // for(i=1;i<=ListCount(lsExcelData);i++)
						[ ] // lsTransaction = lsExcelData[i]
						[+] // if (lsTransaction[1]==NULL)
							[ ] // break
						[ ] // lsTransaction[4]=sDateStamp
						[ ] // //This will click on Banking account on AccountBar
						[ ] // iOpenAccountRegister=SelectAccountFromAccountBar(sAccountType,i)
						[ ] // 
						[ ] // // Add Payment Transaction to account
						[ ] // iAddTransaction= AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
						[ ] // ReportStatus("Add Transaction", iAddTransaction, "Transaction is added to banking account") 
				[ ] // 
				[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[+] //Variable Declaration
		[ ] //Integer
		[ ] INTEGER iSetupAutoAPI,iOpenDataFile,iRegistration
		[ ] 
		[ ] //String
		[ ] STRING sFileName = "HiddenAccountPlanning"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
		[ ] STRING sReplaceCategory = "Date"
		[ ] lsAccountChecking={}
		[ ] lsTransaction={}
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sBankingAccWorksheet)
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] ListAppend(lsAccountChecking,lsExcelData[i][2])
			[ ] 
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sTransactionWorksheet)
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] ListAppend(lsTransaction,lsExcelData[i][8])
		[ ] 
	[ ] 
	[ ] // Load O/S specific paths
	[ ] 
	[ ] 
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[ ] sCaption = QuickenWindow.GetCaption ()
		[+] if(MatchStr("*{sFileName}*", sCaption))
			[+] if(QuickenWindow.Exists(SHORT_SLEEP))
				[ ] QuickenWindow.Kill()
				[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[+] if (!QuickenWindow.Exists(3))
		[ ] LaunchQuicken()
		[ ] WaitForState(QuickenWindow, TRUE ,10)
	[ ] 
	[ ] OpenDataFile(sFileName)
	[ ] 
	[ ] // Bypass Registration
	[ ] iRegistration=BypassRegistration()
	[ ] // Select Home tab
	[ ] NavigateQuickenTab(sTAB_HOME)
	[ ] //Dock the Account Bar
	[ ] ExpandAccountBar()
	[ ] //QuickenMainWindow.View.AccountBar.DockAccountBar.Select()
	[ ] // Off Popup Register
	[ ] UsePopUpRegister("OFF")
	[ ] 
	[ ] QuickenWindow.SetActive ()
	[ ] 
	[ ] print(lsAccountChecking)
	[ ] 
	[+] for(i=1;i<=ListCount(lsAccountChecking)-1;i++)
		[ ] 
		[ ] print(lsTransaction[i])
		[ ] // SelectAccountFromAccountBar(lsAccountChecking[i],ACCOUNT_BANKING)
		[ ] // CloseRegisterReminderInfoPopup()
		[ ] FindandReplaceTransaction(lsTransaction[i],sDateStamp,sReplaceCategory)
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] // Set Classic View
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] 
	[ ] // 
	[ ] // 
[ ] // //###########################################################################
[ ] // 
[+] // //#############Closed account should be part of budget planning. ############################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	Test1_ClosedAccTxnPartOfBudget()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will verify that Closed accounts-Transactions should  be part of budget planning
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			       Pass 	If transactions of the closed account are part of the budget
		[ ] // //						Fail		If any error occurs or If transactions of the closed account are NOT part of the budget
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // 	  April 04, 2013     Anagha created
	[ ] // // ********************************************************
	[ ] // 
[+] testcase Test1_ClosedAccTxnPartOfBudget() appstate none
	[ ] 
	[+] // Variable defination
		[ ] sAccountName="Checking 01"
		[ ] sAmount = "200"
		[ ] sCategory = "Auto Insurance"
		[ ] sBudgetName = "Budget 01"
		[ ] sExpected = "$100"
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[+] if(iValidate== PASS)
			[ ] 
			[ ] //Making Checking 01 Account as Closed Account
			[ ] 
			[ ] iValidate=CloseAccount(ACCOUNT_BANKING,sAccountName)
			[+] if(iValidate==PASS)
				[ ] 
				[ ] ReportStatus("Closing checking account", PASS,"{sAccountName} account closed successfully.")
				[ ] 
				[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[+] if(iValidate==PASS)
					[ ] 
					[ ] //Create a new Budget from Home tab
					[ ] SetViewMode(VIEW_CLASSIC_MENU)
					[ ] iValidate=CreateBudget(sBudgetName,sCategory,sAmount)
					[ ] 
					[+] if(iValidate == PASS)
						[ ] //########Validate Total Budgeted amount #######
						[ ] NavigateQuickenTab(sTAB_HOME)
						[ ] 
						[ ] MDIClient.Home.QWStayOnTopOfMonthlyBills.VerticalScrollBar.ScrollByLine(10)
						[ ] 
						[ ] sActual=MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Budget.Panel.Label.GetCaption()
						[ ] 
						[ ] bMatch = MatchStr("*{sExpected}*", sActual)
						[ ] 
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Validate Total Spending ", PASS, "{sExpected} as Transactions from closed account are considered in Budget.")
						[+] else
							[ ] ReportStatus("Validate Total Spending ", FAIL, "{sActual},{sExpected} as Transactions from closed account are not considered in Budget.")
						[ ] 
					[+] else
						[ ] ReportStatus("Create a New Budget", FAIL,"Budget is not created successfully.")
				[+] else
					[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home Tab is not successfully.")
			[+] else
				[ ] ReportStatus("Closing checking account", FAIL,"{sAccountName} account is not closed successfully.")
		[+] else
			[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home Tab is not successfully.")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] // ###########################################################################
[ ] // 
[+] // ####### Transactions for accounts hidden for reports should not be part of budget.##################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test2_SeparateAccTxnNotPartOfBudget()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that transactions for accounts hidden from Quicken reports and features should not be displayed in Planning -Budget
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If banking account separate successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // April 04, 2013         Anagha created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test2_SeparateAccTxnNotPartOfBudget() appstate none
	[ ] 
	[+] //Variable declaration
		[ ] 
	[+] // Variable defination
		[ ] sAccountName="Checking 02"
		[ ] sAmount = "200"
		[ ] sCategory = "Auto Payment"
		[ ] sBudgetName = "Budget 02"
		[ ] sExpected = "$100"
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] 
		[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[+] if(iValidate== PASS)
			[ ] 
			[ ] //Making Checking 02 Account as "Keep this Account Separate" i.e Separating
			[ ] 
			[ ] iValidate= SeparateAccount(ACCOUNT_BANKING, sAccountName)
			[ ] 
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //Deleting previous budget
				[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_BUDGET)
				[+] if(DlgBudgetMessageBox.Exists(3))
					[ ] DlgBudgetMessageBox.SetActive()
					[ ] DlgBudgetMessageBox.OKButton.Click()
				[ ] sleep(2)
				[+] if(!GetStarted.Exists(SHORT_SLEEP))
					[ ] // //Deleting previous budget
					[ ] iValidate=DeleteBudget()
				[+] else
					[ ] iValidate = PASS
					[ ] 
				[ ] //Creating a new Budget with Seperate Account
				[+] if(iValidate == PASS)
					[ ] 
					[ ] iValidate=CreateBudget(sBudgetName,sCategory,sAmount)
					[+] if(iValidate == PASS)
						[ ] //########Validate Total Budgeted amount #######
						[ ] NavigateQuickenTab(sTAB_HOME)
						[ ] 
						[ ] sActual=MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Budget.Panel.Label.GetCaption()
						[ ] bMatch = MatchStr("*{sExpected}*", sActual)
						[+] if(bMatch == FALSE)
							[ ] ReportStatus("Validate Total Spending ", PASS, "{sActual},{sExpected} as Transactions from separate account are not considered in Budget.")
						[+] else
							[ ] ReportStatus("Validate Total Spending ", FAIL, "{sActual},{sExpected} as Transactions from separate account are considered in Budget.")
						[ ] 
					[+] else
						[ ] ReportStatus("Create a New Budget", PASS,"Budget is not created successfully.")
				[+] else
					[ ] ReportStatus("Verify Previous Budget Deletion", FAIL,"Previous Budget not got deleted successfully.")
			[+] else
				[ ] ReportStatus("Separate checking account", FAIL,"{sAccountName} account is not separated successfully.")
		[+] else
			[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home Tab is not successfully.")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] // ###########################################################################
[ ] // 
[+] // ####### Transactions for accounts hidden from  Transaction entry lists should be part of budget.############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test3_HideInTxnAccPartOfBudget()
		[ ] // Hide in Transaction Entry Lists
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Transactions for accounts hidden from  Transaction entry lists  should  be displayed planning -Budget
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If banking account separate successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // April 05, 2013         Anagha created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test3_HideInTxnAccPartOfBudget() appstate none
	[ ] 
	[+] //Variable declaration
		[ ] 
	[+] // Variable defination
		[ ] sAccountName="Checking 03"
		[ ] sAmount = "200"
		[ ] sCategory = "Car Wash"
		[ ] sBudgetName = "Budget 03"
		[ ] sExpected = "$100"
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] 
		[ ] iValidate = NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[+] if(iValidate == PASS)
			[ ] 
			[ ] //Making Checking 03 Account as "Hidden from transaction list" 
			[ ] 
			[ ] iValidate = AccountHideInTransactionList(ACCOUNT_BANKING,sAccountName,2)
			[ ] 
			[+] if(iValidate == PASS)
				[ ] 
				[ ] //Deleting previous budget
				[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_BUDGET)
				[ ] 
				[+] if(!GetStarted.Exists(SHORT_SLEEP))
					[ ] //Deleting previous budget
					[ ] iValidate=DeleteBudget()
				[+] else
					[ ] iValidate = PASS
					[ ] 
				[+] if(iValidate == PASS)
					[ ] 
					[ ] iValidate=CreateBudget(sBudgetName,sCategory,sAmount)
					[ ] 
					[+] if(iValidate == PASS)
						[ ] //########Validate Total Budgeted amount #######
						[ ] NavigateQuickenTab(sTAB_HOME)
						[ ] 
						[ ] sActual=MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Budget.Panel.Label.GetCaption()
						[ ] bMatch = MatchStr("*{sExpected}*", sActual)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Validate Total Spending ", PASS, "{sActual},{sExpected} as Transactions from separate account are considered in Budget.")
						[+] else
							[ ] ReportStatus("Validate Total Spending ", FAIL, "{sActual},{sExpected} as Transactions from separate account are not considered in Budget.")
						[ ] 
					[+] else
						[ ] ReportStatus("Create a New Budget", PASS,"Budget is not created successfully.")
				[+] else
					[ ] ReportStatus("Verify Previous Budget Deletion", FAIL,"Previous Budget not got deleted successfully.")
			[+] else
				[ ] ReportStatus("Hidden from transaction list checking account", FAIL,"{sAccountName} account is not hidden from transaction list  successfully.")
		[+] else
			[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home Tab is not successfully.")
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] // ###########################################################################
[ ] // 
[+] // ####### Transactions for accounts hidden from account bar and account list should be part of budget.######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test4_HideAccBarListPartOfBudget()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Transactions for accounts hidden from account bar and account list  should be included in budget
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If banking account separate successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // April 05, 2013         Anagha created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test4_HideAccBarListPartOfBudget() appstate none
	[ ] 
	[+] //vVariable declaration
		[ ] 
	[+] // Variable defination
		[ ] sAccountName="Checking 04"
		[ ] sAmount = "200"
		[ ] sCategory = "Gas & Fuel"
		[ ] sBudgetName = "Budget 04"
		[ ] sExpected = "$100"
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[+] if(iValidate == PASS)
			[ ] 
			[ ] //Making Checking 03 Account as "Hidden from Account Bar and Account List" 
			[ ] 
			[ ] iValidate= AccountHideInAccountBarAccountList(ACCOUNT_BANKING,sAccountName,3)
			[ ] 
			[+] if(iValidate == PASS)
				[ ] //Deleting previous budget
				[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_BUDGET)
				[ ] 
				[+] if(!GetStarted.Exists(SHORT_SLEEP))
					[ ] // //Deleting previous budget
					[ ] iValidate=DeleteBudget()
				[+] else
					[ ] iValidate = PASS
				[ ] 
				[ ] //Creating a new Budget with Seperate Account
				[ ] 
				[+] if(iValidate == PASS)
					[ ] 
					[ ] iValidate=CreateBudget(sBudgetName,sCategory,sAmount)
					[ ] 
					[+] if(iValidate == PASS)
						[ ] //########Validate Total Budgeted amount #######
						[ ] NavigateQuickenTab(sTAB_HOME)
						[ ] 
						[ ] sActual=MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Budget.Panel.Label.GetCaption()
						[ ] bMatch = MatchStr("*{sExpected}*", sActual)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Validate Total Spending ", PASS, "{sActual},{sExpected} as Transactions from separate account are considered in Budget.")
						[+] else
							[ ] ReportStatus("Validate Total Spending ", FAIL, "{sActual},{sExpected} as Transactions from separate account are not considered in Budget.")
						[ ] 
					[+] else
						[ ] ReportStatus("Create a New Budget", PASS,"Budget is not created successfully.")
				[+] else
					[ ] ReportStatus("Verify Previous Budget Deletion", FAIL,"Previous Budget not got deleted successfully.")
			[+] else
				[ ] ReportStatus("Hidden from Account Bar and Account List checking account", FAIL,"{sAccountName} account is not hidden from Account Bar and Account List successfully.")
		[+] else
			[+] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home Tab is not successfully.")
						[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] // ###########################################################################
[ ] // 
[+] // ####### Separate the Account after creating the Budget ##################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test5_SeparateAccAfterBudget()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that after Making any account separate  after creating budget should not be considered
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If banking account separate successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // April 04, 2013         Anagha created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test5_SeparateAccAfterBudget() appstate none
	[ ] 
	[+] //vVariable declaration
		[ ] 
		[ ] 
	[+] // Variable defination
		[ ] sAccountName="Checking 05"
		[ ] sAmount = "200"
		[ ] sCategory = "Parking"
		[ ] sBudgetName = "Budget 05"
		[ ] sExpected = "$100"
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Navigate to Planning > Budget
		[ ] iValidate = NavigateQuickenTab(sTAB_PLANNING,sTAB_BUDGET)
		[ ] 
		[+] if(iValidate == PASS)
			[+] if(!GetStarted.Exists(SHORT_SLEEP))
				[ ] // //Deleting previous budget
				[ ] iValidate=DeleteBudget()
			[+] else
				[ ] iValidate = PASS
			[ ] 
			[ ] //Creating a new Budget with  Account
			[+] if(iValidate == PASS)
				[ ] 
				[ ] iValidate=CreateBudget(sBudgetName,sCategory,sAmount)
				[ ] 
				[ ] //########Validate Total Budgeted amount #######
				[+] if(iValidate == PASS)
					[ ] 
					[ ] NavigateQuickenTab(sTAB_HOME)
					[ ] 
					[ ] sActual=MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Budget.Panel.Label.GetCaption()
					[ ] bMatch = MatchStr("*{sExpected}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Total Spending ", PASS, "{sExpected} as Transactions from account are considered in Budget.")
					[+] else
						[ ] ReportStatus("Validate Total Spending ", FAIL, "{sActual},{sExpected} as Transactions from account are not considered in Budget.")
				[+] else
					[ ] ReportStatus("Create a New Budget", PASS,"Budget is not created successfully.")
			[+] else
				[ ] ReportStatus("Verify Previous Budget Deletion", FAIL,"Previous Budget not got deleted successfully.")
			[ ] 
			[ ] iValidate= NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[+] if(iValidate == PASS)
				[ ] 
				[ ] //Making Checking 05 Account as "Keep this Account Separate" i.e Separating
				[ ] iValidate=SeparateAccount(ACCOUNT_BANKING, sAccountName)
				[ ] 
				[+] if(iValidate == PASS)
					[ ] //########Validate Total Budgeted amount #######
					[ ] 
					[ ] NavigateQuickenTab(sTAB_HOME)
					[ ] 
					[ ] sActual=MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Budget.Panel.Label.GetCaption()
					[ ] 
					[ ] bMatch = MatchStr("*{sExpected}*", sActual)
					[ ] 
					[+] if(bMatch == FALSE)
						[ ] ReportStatus("Validate Total Spending ", PASS, "{sActual},{sExpected} as Transactions from separate account are not considered in Budget.")
					[+] else
						[ ] ReportStatus("Validate Total Spending ", FAIL, "{sActual},{sExpected} as Transactions from separate account are considered in Budget.")
				[+] else
					[ ] ReportStatus("Separate checking account", FAIL,"{sAccountName} account is not separated successfully.")
				[ ] 
			[+] else
				[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home Tab is not successfully.")
			[ ] 
		[+] else
			[ ] ReportStatus("Navigation to Budget Tab", FAIL,"Navigation to Budget Tab is not successfully.")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] // ###########################################################################
[ ] // 
[+] // ####### Hidden in transaction entry list after creating the Budget ##################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test6_HideInTxnAccAfterBudget()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Mark any separate account ,"Hidden in transaction entry list " after creating budget
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If banking account separate successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // April 05, 2013         Anagha created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test6_HideInTxnAccAfterBudget() appstate none
	[ ] 
	[+] //Variable declaration
		[ ] 
	[+] // Variable defination
		[ ] sAccountName="Checking 06"
		[ ] sAmount = "200"
		[ ] sCategory = "Public Transportation"
		[ ] sBudgetName = "Budget 06"
		[ ] sExpected = "$100"
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Navigate to Planning > Budget
		[ ] iValidate = NavigateQuickenTab(sTAB_PLANNING,sTAB_BUDGET)
		[ ] 
		[+] if(iValidate == PASS)
			[+] if(!GetStarted.Exists(SHORT_SLEEP))
				[ ] //Deleting previous budget
				[ ] iValidate=DeleteBudget()
			[+] else
				[ ] iValidate = PASS
			[ ] 
			[ ] //Creating a new Budget with Seperate Account
			[+] if(iValidate == PASS)
				[ ] 
				[ ] iValidate=CreateBudget(sBudgetName,sCategory,sAmount)
				[ ] 
				[ ] //########Validate Total Budgeted amount ###################
				[ ] 
				[+] if(iValidate == PASS)
					[ ] 
					[ ] NavigateQuickenTab(sTAB_HOME)
					[ ] 
					[ ] sActual=MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Budget.Panel.Label.GetCaption()
					[ ] 
					[ ] bMatch = MatchStr("*{sExpected}*",sActual)
					[ ] 
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Total Spending ",PASS, "{sActual},{sExpected} as Transactions from  account are considered in Budget.")
					[+] else
						[ ] ReportStatus("Validate Total Spending ",FAIL, "{sActual},{sExpected} as Transactions from  account are not considered in Budget.")
				[+] else
					[ ] ReportStatus("Create a New Budget", PASS,"Budget is not created successfully.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Previous Budget Deletion", FAIL,"Previous Budget not got deleted successfully.")
			[ ] 
			[ ] iValidate= NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[+] if(iValidate == PASS)
				[ ] 
				[ ] //Making Checking 06 Account as "Hidden from transaction list" 
				[ ] iValidate= AccountHideInTransactionList(ACCOUNT_BANKING,sAccountName,3)
				[ ] 
				[+] if(iValidate == PASS)
					[ ] 
					[ ] //########Validate Total Budgeted amount ######################
					[ ] 
					[ ] NavigateQuickenTab(sTAB_HOME)
					[ ] 
					[ ] sActual=MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Budget.Panel.Label.GetCaption()
					[ ] 
					[ ] bMatch = MatchStr("*{sExpected}*",sActual)
					[ ] 
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Total Spending ",PASS, "{sActual},{sExpected} as Transactions from separate account are considered in Budget.")
					[+] else
						[ ] ReportStatus("Validate Total Spending ",FAIL, "{sActual},{sExpected} as Transactions from separate account are not considered in Budget.")
				[+] else
					[ ] ReportStatus("Hidden from transaction list checking account", FAIL,"{sAccountName} account is not hidden from transaction list  successfully.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home Tab is not successfully.")
			[ ] 
		[+] else
			[ ] ReportStatus("Navigation to Budget Tab", FAIL,"Navigation to Budget Tab is not successfully.")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //####### accounts hidden from account bar and account list after creating the Budget.############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test7_HideAccBarListAfterBudget()
		[ ] 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Mark any separate  account ,"Hidden in Account bar and account list " after creating budget
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If banking account separate successfully						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // April 05, 2013         Anagha created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test7_HideAccBarListAfterBudget() appstate none
	[ ] 
	[+] //Variable declaration
		[ ] 
	[+] //Variable defination
		[ ] sAccountName="Checking 07"
		[ ] sAmount = "200"
		[ ] sCategory = "Registration"
		[ ] sBudgetName = "Budget 07"
		[ ] sExpected = "$100"
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Navigate to Planning > Budget
		[ ] 
		[ ] iValidate = NavigateQuickenTab(sTAB_PLANNING,sTAB_BUDGET)
		[ ] 
		[+] if(iValidate == PASS)
			[+] if(!GetStarted.Exists(SHORT_SLEEP))
				[ ] //Deleting previous budget
				[ ] iValidate=DeleteBudget()
			[+] else
				[ ] iValidate = PASS
			[ ] 
			[ ] //Creating a new Budget with Account
			[+] if(iValidate == PASS)
				[ ] 
				[ ] iValidate=CreateBudget(sBudgetName,sCategory,sAmount)
				[ ] 
				[+] if(iValidate == PASS)
					[ ] 
					[ ] // ########Validate Total Budgeted amount ########
					[ ] NavigateQuickenTab(sTAB_HOME)
					[ ] 
					[ ] sActual=MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Budget.Panel.Label.GetCaption()
					[ ] 
					[ ] bMatch = MatchStr("*{sExpected}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Total Spending ", PASS, "{sActual},{sExpected} as Transactions from  account are considered in Budget.")
					[+] else
						[ ] ReportStatus("Validate Total Spending ", FAIL, "{sActual},{sExpected} as Transactions from  account are not considered in Budget.")
				[+] else
					[ ] ReportStatus("Create a New Budget", PASS,"Budget is not created successfully.")
			[+] else
				[ ] ReportStatus("Verify Previous Budget Deletion", FAIL,"Previous Budget not got deleted successfully.")
				[ ] 
			[ ] 
			[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[+] if(iValidate == PASS)
				[ ] 
				[ ] //Making Checking 03 Account as "Hidden from Account Bar and Account List" 
				[ ] iValidate= AccountHideInAccountBarAccountList(ACCOUNT_BANKING,sAccountName,4)
				[ ] 
				[+] if(iValidate == PASS)
					[ ] 
					[ ] // ########Validate Total Budgeted amount ###########
					[ ] NavigateQuickenTab(sTAB_HOME)
					[ ] 
					[ ] sActual=MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Budget.Panel.Label.GetCaption()
					[ ] bMatch = MatchStr("*{sExpected}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Total Spending ", PASS, "{sActual},{sExpected} as Transactions from separate account are considered in Budget.")
					[+] else
						[ ] ReportStatus("Validate Total Spending ", FAIL, "{sActual},{sExpected} as Transactions from separate account are not considered in Budget.")
				[+] else
					[ ] ReportStatus("Hidden from Account Bar and Account List checking account", FAIL,"{sAccountName} account is not hidden from Account Bar and Account List  successfully.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home Tab is not successfully.")
			[ ] 
		[+] else
			[ ] ReportStatus("Navigation to Budget Tab", FAIL,"Navigation to Budget Tab is not successfully.")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //#########################################################################
[ ] 
[+] //#############Closed account after creating the Budget ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test8_ClosedAccTxnAfterBudget()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Closed accounts-Transactions should  be part of budget planning
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			       Pass 	If transactions of the closed account are part of the budget
		[ ] //						Fail		If any error occurs or If transactions of the closed account are NOT part of the budget
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 05, 2013     Anagha created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test8_ClosedAccTxnAfterBudget() appstate none
	[ ] 
	[ ] //Variable declaration
	[+] // Variable defination
		[ ] sAccountName="Checking 08"
		[ ] sAmount = "200"
		[ ] sCategory = "Service & Parts"
		[ ] sBudgetName = "Budget 08"
		[ ] sExpected = "$100"
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Navigate to Planning > Budget
		[ ] iValidate=NavigateQuickenTab(sTAB_PLANNING,sTAB_BUDGET)
		[ ] 
		[+] if(iValidate == PASS)
			[ ] 
			[+] if(!GetStarted.Exists(SHORT_SLEEP))
				[ ] //Deleting previous budget
				[ ] iValidate=DeleteBudget()
			[+] else
				[ ] iValidate = PASS
				[ ] //Creating a new Budget with Account
			[+] if(iValidate == PASS)
				[ ] 
				[ ] iValidate=CreateBudget(sBudgetName,sCategory,sAmount)
				[ ] 
				[+] if(iValidate == PASS)
					[ ] // ########Validate Total Budgeted amount ############
					[ ] NavigateQuickenTab(sTAB_HOME)
					[ ] 
					[ ] sActual=MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Budget.Panel.Label.GetCaption()
					[ ] bMatch = MatchStr("*{sExpected}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Total Spending ", PASS, "{sActual},{sExpected} as Transactions from  account are considered in Budget.")
					[+] else
						[ ] ReportStatus("Validate Total Spending ", FAIL, "{sActual},{sExpected} as Transactions from  account are not considered in Budget.")
				[+] else
					[ ] ReportStatus("Create a New Budget", PASS,"Budget is not created successfully.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Previous Budget Deletion", FAIL,"Previous Budget not got deleted successfully.")
				[ ] 
				[ ] 
			[ ] 
			[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[+] if(iValidate == PASS)
				[ ] //Making Checking 08 Account as Closed Account
				[ ] iValidate=CloseAccount(ACCOUNT_BANKING,sAccountName,4)
				[ ] 
				[+] if(iValidate == PASS)
					[ ] 
					[ ] ReportStatus("Closing checking account", PASS,"{sAccountName} account closed successfully.")
					[ ] 
					[ ] iValidate= NavigateQuickenTab(sTAB_HOME)
					[ ] 
					[+] if(iValidate == PASS)
						[ ] 
						[ ] //Deleting previous budget
						[ ] iValidate=DeleteBudget()
						[ ] 
						[+] if(iValidate == PASS)
							[ ] //Create a new Budget from Home tab
							[ ] iValidate=CreateBudget(sBudgetName,sCategory,sAmount)
							[ ] 
							[+] if(iValidate == PASS)
								[ ] // ########Validate Total Budgeted amount #######
								[ ] NavigateQuickenTab(sTAB_HOME)
								[ ] 
								[ ] sActual=MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Budget.Panel.Label.GetCaption()
								[ ] bMatch = MatchStr("*{sExpected}*", sActual)
								[+] if(bMatch == TRUE)
									[ ] ReportStatus("Validate Total Spending ", PASS, "{sActual},{sExpected} as Transactions from closed account are considered in Budget.")
								[+] else
									[ ] ReportStatus("Validate Total Spending ", FAIL, "{sActual},{sExpected} as Transactions from closed account are not considered in Budget.")
							[+] else
								[ ] ReportStatus("Create a New Budget", PASS,"Budget is not created successfully.")
					[+] else
						[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home Tab is not successfully.")
					[ ] 
				[+] else
					[ ] ReportStatus("Close checking account", FAIL,"{sAccountName} account is not closed successfully.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home Tab is not successfully.")
			[ ] 
		[+] else
			[ ] ReportStatus("Navigation to Budget Tab", FAIL,"Navigation to Budget Tab is not successfully.")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //########################################################################
[ ] 
[+] //#############Hidden accounts should be part of DRP. ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test9_HiddenAccPartOfDRP()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Hidden accounts should be included in DRP
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			       Pass 	If transactions of the Hidden account are part of the DRP
		[ ] //						Fail		If any error occurs or If transactions of the Hidden account are NOT  part of the DRP
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 08, 2013     Anagha created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test9_HiddenAccPartOfDRP() appstate none
	[ ] 
	[ ] // Variable declaration
	[+] // Variable defination
		[ ] lsHCreditAcc = {"Credit Card 01","Credit Card 03","Credit Card 04","Credit Card 05"}
		[ ] //sCreditAccount = "Credit Card 02"
		[ ] sAmount = "200"
		[ ] iCounter=0
		[ ] sAccountType = "Credit Card"
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sCreditAccWorksheet)
		[ ] 
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] ListAppend(lsCreditAccount,lsExcelData[i][2])
			[ ] print(lsCreditAccount)
		[ ] 
		[ ] // lsExcelData=ReadExcelTable(sHiddenAccountExcel, sHiddenAccountWorksheet)
		[ ] // 
		[+] // for(i=1;i<=ListCount(lsExcelData);i++)
			[+] // if(sAccountType ==lsExcelData[i][1] )
				[ ] // ListAppend(lsHCreditAcc,lsExcelData[i][2])
			[+] // else
				[ ] // continue
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[+] if(iValidate == PASS)
			[ ] 
			[ ] print("lsCreditAccount[2]- {lsCreditAccount[2]}")
			[ ] //Making Credit Card 02 Account as Separate Account
			[ ] iValidate= SeparateAccount(ACCOUNT_BANKING,lsCreditAccount[2])
			[ ] 
			[+] if(iValidate == PASS)
				[ ] 
				[ ] ReportStatus("Separate Credit Card account", PASS,"{lsCreditAccount[2]} account separate successfully.")
				[ ] 
				[ ] iValidate= NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[+] if(iValidate == PASS)
					[ ] 
					[ ] print("lsCreditAccount[3] - {lsCreditAccount[3]}")
					[ ] //Making Credit Card 03 Account as "Hide In Transaction List "
					[ ] iValidate= AccountHideInTransactionList(ACCOUNT_BANKING,lsCreditAccount[3],7)
					[ ] 
					[+] if(iValidate == PASS)
						[ ] 
						[ ] ReportStatus("Hide In Transaction List Credit Card account", PASS,"{lsCreditAccount[3]} account hide in transaction list successfully.")
						[ ] 
						[ ] print("lsCreditAccount[4] - {lsCreditAccount[4]}")
						[ ] //Making Credit Card 04 Account as "Hide In Account Bar Account List "
						[ ] iValidate= AccountHideInAccountBarAccountList(ACCOUNT_BANKING,lsCreditAccount[4],8)
						[ ] 
						[+] if(iValidate == PASS)
							[ ] 
							[ ] ReportStatus("Hide in account bar account list Credit Card account", PASS,"{lsCreditAccount[4]} account Hide in account bar account list successfully.")
							[ ] 
							[ ] iValidate= NavigateQuickenTab(sTAB_HOME)
							[ ] 
							[+] if(iValidate == PASS)
								[ ] 
								[ ] iValidate= NavigateQuickenTab(sTAB_PLANNING,sTAB_DEBT_REDUCTION)
								[ ] 
								[+] if(iValidate == PASS)
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] GetStarted.SetFocus()
									[+] if(GetStarted.Exists(SHORT_SLEEP))
										[ ] GetStarted.Click()
										[ ] sleep(SHORT_SLEEP)
										[ ] 
									[ ] 
									[ ] //########Validate Account Add in Debt Reduction#############
									[ ] sHandle = Str(MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE1.ListBox1.GetHandle())
									[+] for each sItem in lsHCreditAcc
										[+] for( iCounter=0;iCounter<MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE1.ListBox1.GetItemCount();iCounter++)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "{iCounter}")
											[ ] bMatch = MatchStr("*{sItem}*", sActual)
											[+] if ( bMatch == TRUE)
												[ ] break
										[ ] 
										[+] if(bMatch == TRUE)
											[ ] ReportStatus("Validate Account Add in Debt Reduction ", PASS, "{sActual},{sItem} as Account Add in Debt Reduction.")
										[+] else
											[ ] ReportStatus("Validate Account Add in Debt Reduction ", FAIL, "{sActual},{sItem} as Account is not Add in Debt Reduction.")
									[ ] 
									[ ] //########Validate Separate Account Add in Debt Reduction#######
									[ ] sHandle = Str(MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE2.ListBox1.GetHandle())
									[+] //for each sItem in lsCreditAccount
										[+] for( iCounter=0;iCounter<MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE2.ListBox1.GetItemCount() +1;++iCounter)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "{iCounter}")
											[ ] bMatch = MatchStr("*{lsCreditAccount[2]}*", sActual)
											[+] if ( bMatch == TRUE)
												[ ] break
										[ ] 
										[+] if(bMatch == TRUE)
											[ ] ReportStatus("Validate Separate Account Add in Debt Reduction ", PASS, "{sActual},{sItem} as Separate Account Add in Debt Reduction.")
										[+] else
											[ ] ReportStatus("Validate Separate Account Add in Debt Reduction ", FAIL, "{sActual},{sItem} as Separate Account is not Add in Debt Reduction.")
								[+] else
									[ ] ReportStatus("Navigation to Debt Reduction Tab", FAIL,"Navigation to  Debt Reduction is not successfully.")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home is not successfully.")
							[ ] 
						[+] else
							[ ] ReportStatus("Hide in account bar account list Credit Card account", FAIL,"{lsCreditAccount[3]} account is not Hide in account bar account list successfully.")
						[ ] 
					[+] else
						[ ] ReportStatus("Hide In Transaction List Credit Card account", FAIL,"{lsCreditAccount[3]} account is not hide in transaction list successfully.")
					[ ] 
				[+] else
					[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home is not successfully.")
				[ ] 
			[+] else
				[ ] ReportStatus("Separate Credit Card account", FAIL,"{lsCreditAccount[2]} account is not separate successfully.")
			[ ] 
		[+] else
			[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home is not successfully.")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //#######################################################################
[ ] 
[+] //#############Closed accounts should not be part of DRP. ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test10_ClosedAccNotPartOfDRP()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Closed accounts should not be included in DRP
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			       Pass 	If transactions of the closed account are part of the DRP
		[ ] //						Fail		If any error occurs or If transactions of the closed account are NOT part of the DRP
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // April 08, 2013             Anagha created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test10_ClosedAccNotPartOfDRP() appstate none
	[ ] 
	[ ] // Variable declaration
	[+] // Variable defination
		[ ] //lsCreditAccount = {"Credit Card 01","Credit Card 03","Credit Card 04"}
		[ ] 
		[ ] sAmount = "200"
		[ ] sAccountType = "Credit Card"
		[ ] sCreditAccount = "Credit Card 01"
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] // lsExcelData=ReadExcelTable(sHiddenAccountExcel, sCreditAccWorksheet)
		[ ] // 
		[+] // for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] // ListAppend(lsCreditAccount,lsExcelData[i][2])
			[ ] 
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sCloseAccountWorksheet)
		[ ] 
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[+] if(sCreditAccount ==lsExcelData[i][2] )
				[ ] ListAppend(lsHCreditAcc,lsExcelData[i][2])
			[+] else
				[ ] continue
			[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iValidate= NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[+] if(iValidate == PASS)
			[ ] //Making Credit Card 01 Account as Closed Account
			[ ] iValidate=CloseAccount(ACCOUNT_BANKING,lsHCreditAcc[1],6)
			[ ] 
			[+] if(iValidate == PASS)
				[ ] 
				[ ] ReportStatus("Close Credit Card account", PASS,"{lsHCreditAcc[1]} account closed successfully.")
				[ ] 
				[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[+] if(iValidate == PASS)
					[ ] //Create a new Debt Reduction from Planning tab
					[ ] 
					[ ] iValidate=NavigateQuickenTab(sTAB_PLANNING,sTAB_DEBT_REDUCTION)
					[ ] 
					[+] if(iValidate == PASS)
						[ ] 
						[ ] //########Validate Account Add in Debt Reduction############################
						[ ] 
						[+] if(GetStartedBrowserWindow.GetStarted.Exists(20))
							[ ] GetStartedBrowserWindow.GetStarted.DomClick()
							[ ] sleep(2)
						[ ] 
						[ ] sHandle = Str(MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE1.ListBox1.GetHandle())
						[+] for each sItem in lsHCreditAcc
							[+] for( iCounter=0;iCounter<MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE1.ListBox1.GetItemCount();iCounter++)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle, "{iCounter}")
								[ ] bMatch = MatchStr("*{sItem}*", sActual)
								[+] if ( bMatch == FALSE)
									[ ] break
								[ ] 
							[+] if(bMatch == FALSE)
								[ ] ReportStatus("Validate Account Not Add in Debt Reduction ", PASS, "{sItem} as Closed Account is not Add in Debt Reduction.")
							[+] else
								[ ] ReportStatus("Validate Account Not Add in Debt Reduction ", FAIL, "{sItem} as Closed Account is Add in Debt Reduction.")
					[+] else
						[ ] ReportStatus("Navigation to Debt Reduction Tab", FAIL,"Navigation to Debt Reduction is not successfully.")
					[ ] 
				[+] else
					[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home is not successfully.")
				[ ] 
			[+] else
				[ ] ReportStatus("Close Credit Card account", FAIL,"{lsCreditAccount[1]} account is not closed successfully.")
			[ ] 
			[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home is not successfully.")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############Closed accounts  after creating the DRP. ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test11_ClosedAccAfterDRP()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Debt Reduction Planner should be updated if any participating account gets closed.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			       Pass 	If transactions of the closed account are part of the DRP
		[ ] //						Fail		If any error occurs or If transactions of the closed account are NOT part of the DRP
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // April 08, 2013             Anagha created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test11_ClosedAccAfterDRP() appstate none
	[ ] 
	[ ] // Variable declaration
	[+] // Variable defination
		[ ] sAmount = "200"
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[+] //Retrieving Data from excel
			[ ] 
			[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sCloseAccountWorksheet)
			[ ] 
			[ ] ListAppend(lsClosedAccount,lsExcelData[3][2])
			[ ] 
			[ ] ListAppend(lsClosedAccount,lsExcelData[6][2])
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Create a new Debt Reduction from Planning tab
		[ ] 
		[ ] iValidate= NavigateQuickenTab(sTAB_PLANNING,sTAB_DEBT_REDUCTION)
		[ ] 
		[+] if(iValidate == PASS)
			[ ] 
			[+] if(GetStartedBrowserWindow.GetStarted.Exists(20))
				[ ] GetStartedBrowserWindow.GetStarted.DomClick()
				[ ] sleep(2)
			[ ] 
			[+] //########Validate Credit Account Add in Debt Reduction##################################################
				[ ] sHandle = Str(MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE1.ListBox1.GetHandle())
				[ ] 
				[+] for( iCounter=0;iCounter<MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE1.ListBox1.GetItemCount();iCounter++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle, "{iCounter}")
					[ ] bMatch = MatchStr("*{lsClosedAccount[1]}*", sActual)
					[+] if ( bMatch == TRUE)
						[ ] break
					[ ] 
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate Account Add in Debt Reduction ", PASS, "{lsClosedAccount[1]} Account is Add in Debt Reduction.")
				[+] else
					[+] ReportStatus("Validate Account Add in Debt Reduction ", FAIL, "{sActual},{lsClosedAccount[1]} Account is not Add in Debt Reduction.")
						[ ] 
			[+] //########Validate Loan Account Add in Debt Reduction##################################################
				[ ] sHandle = Str(MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE2.ListBox1.GetHandle())
				[+] for( iCounter=0;iCounter<MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE2.ListBox1.GetItemCount();iCounter++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle, "{iCounter}")
					[ ] bMatch = MatchStr("*{lsClosedAccount[2]}*", sActual)
					[+] if ( bMatch == TRUE)
						[ ] break
					[ ] 
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate Account Add in Debt Reduction ", PASS, "{lsClosedAccount[2]}Account is Add in Debt Reduction.")
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Account Add in Debt Reduction ", FAIL, "{sActual},{lsClosedAccount[2]}Account is not  Add in Debt Reduction.")
			[ ] 
			[ ] 
			[ ] //Making Credit Card 05 Account and Loan Account 05 as Closed Account
			[ ] 
			[ ] iValidate= NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[+] if(iValidate == PASS)
				[ ] 
				[ ] iValidate= CloseAccount(ACCOUNT_BANKING,lsClosedAccount[1],8)
				[ ] 
				[+] if(iValidate == PASS)
					[ ] 
					[ ] ReportStatus("Close Credit Card account", PASS,"{lsClosedAccount[1]} account closed successfully.")
					[ ] 
					[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
						[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
					[ ] 
					[ ] iValidate= CloseAccount(ACCOUNT_PROPERTYDEBT,lsClosedAccount[2],6)
					[ ] 
					[+] if(iValidate == PASS)
						[ ] 
						[ ] ReportStatus("Close Loan account", PASS,"{lsClosedAccount[2]} account closed successfully.")
						[ ] 
						[ ] Sleep(2)
						[ ] 
						[ ] iValidate= NavigateQuickenTab(sTAB_HOME)
						[ ] 
						[+] if(iValidate == PASS)
							[ ] 
							[ ] iValidate= NavigateQuickenTab(sTAB_PLANNING,sTAB_DEBT_REDUCTION)
							[ ] 
							[+] if(iValidate == PASS)
								[ ] 
								[+] //########Validate Account Add in Debt Reduction#############################################################
									[ ] sHandle = Str(MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE1.ListBox1.GetHandle())
									[+] for( iCounter=0;iCounter<MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE1.ListBox1.GetItemCount();iCounter++)
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle, "{iCounter}")
										[ ] bMatch = MatchStr("*{lsClosedAccount[1]}*", sActual)
										[+] if ( bMatch == FALSE)
											[ ] break
									[+] if(bMatch == FALSE)
										[ ] ReportStatus("Validate Account Not Add in Debt Reduction ", PASS, "{lsClosedAccount[1]} Closed Account is not Add in Debt Reduction.")
									[+] else
										[+] ReportStatus("Validate Account Not Add in Debt Reduction ", FAIL, "{sActual},{lsClosedAccount[1]} Closed Account is Add in Debt Reduction.")
											[ ] 
									[+] //########Validate Loan Account Add in Debt Reduction########################################################
										[ ] sHandle = Str(MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE2.ListBox1.GetHandle())
										[+] for( iCounter=0;iCounter<MDIClient.Planning.DebtReduction.Panel.SetupScreenHolder.SetupScreen.BALANCE2.ListBox1.GetItemCount();iCounter++)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle, "{iCounter}")
											[ ] bMatch = MatchStr("*{lsClosedAccount[2]}*", sActual)
											[+] if ( bMatch == FALSE)
												[ ] break
										[+] if(bMatch == FALSE)
											[ ] ReportStatus("Validate Account Not Add in Debt Reduction ", PASS, "{lsClosedAccount[2]} Closed Account is not Add in Debt Reduction.")
										[+] else
											[ ] ReportStatus("Validate Account Not Add in Debt Reduction ", FAIL, "{sActual},{lsClosedAccount[2]} Closed Account is not Add in Debt Reduction.")
											[ ] 
							[+] else
								[ ] ReportStatus("Navigation to Debt Reduction Tab", FAIL,"Navigation to Debt Reduction is not successfully.")
							[ ] 
						[+] else
							[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home is not successfully.")
						[ ] 
					[+] else
						[ ] ReportStatus("Close Loan account", FAIL,"{lsClosedAccount[2]} account is not closed successfully.")
					[ ] 
				[ ] 
				[+] else
					[ ] ReportStatus("Close Credit Card account", FAIL,"{lsClosedAccount[1]} account is not closed successfully.")
				[ ] 
			[+] else
				[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home is not successfully.")
			[ ] 
		[+] else
			[ ] ReportStatus("Navigation to Debt Reduction Tab", FAIL,"Navigation to Debt Reduction is not successfully.")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] // Hidden Accs should be &  Closed Accs should not be included in Saving & Invt. Lifetime planner. #############
	[ ] // ********************************************************
	[+] // TestCase Name:	Test12_Hidden AccClosedAccLifetime()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Hidden accounts should be included  and Closed account should not be included in Lifetime planner-Savings
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			       Pass 	If transactions of the closed account are part of the Lifetime planner
		[ ] //						Fail		If any error occurs or If transactions of the closed account are NOT part of the Lifetime planner
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // April 09, 2013             Anagha created
	[ ] // ********************************************************
[+] testcase Test12_HiddenAccClosedAccSavInvtLP() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] // // Variable defination
		[ ] sExpected = "$100"
		[ ] sAccountType = "Brokerage"
		[ ] sAccountType1 = "Checking"
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sInvestingAccWorksheet)
		[ ] 
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] ListAppend(lsAccount,lsExcelData[i][2])
			[ ] 
			[ ] 
		[+] //Fetching Data from Excel for Closed Account for Checking
			[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sCloseAccountWorksheet)
			[ ] 
			[+] // for(i=1;i<=ListCount(lsExcelData);i++)
				[ ] // if(sAccountType1 ==lsExcelData[i][1] )
				[ ] ListAppend(lsCheckingCloseAccount,lsExcelData[1][2])
				[+] // else
					[ ] // continue
			[ ] 
		[+] //Fetching Data from Excel for Hidden Account for Checking
			[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sHiddenAccountWorksheet)
			[ ] 
			[+] for(i=1;i<=ListCount(lsExcelData);i++)
				[+] if(sAccountType1 ==lsExcelData[i][1] )
					[ ] ListAppend(lsCheckingHideAccount,lsExcelData[i][2])
				[+] else
					[ ] continue
			[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] iValidate= NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[+] if(iValidate == PASS)
			[ ] 
			[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMin()
			[ ] 
			[ ] //Making Brokerage 02 Account as "Separate Account"
			[ ] iValidate= SeparateAccount(ACCOUNT_INVESTING,lsAccount[2])
			[ ] 
			[+] if(iValidate == PASS)
				[ ] 
				[ ] ReportStatus("Separate Brokerage 02 Account", PASS,"{lsAccount[2]} account separate successfully.")
				[ ] 
				[ ] iValidate= NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[+] if(iValidate == PASS)
					[ ] 
					[ ] //Making Brokerage 03 Account as "Hide In Transaction List"
					[ ] iValidate= AccountHideInTransactionList(ACCOUNT_INVESTING,lsAccount[3])
					[ ] 
					[+] if(iValidate == PASS)
						[ ] 
						[ ] ReportStatus("Hide In Transaction List Brokerage 03 Account",PASS,"{lsAccount[3]} account hide in transaction list successfully.")
						[ ] 
						[ ] //Making Brokerage 04 Account as "Hide In Account Bar Account List"
						[ ] iValidate= AccountHideInAccountBarAccountList(ACCOUNT_INVESTING,lsAccount[4],3)
						[ ] 
						[+] if(iValidate == PASS)
							[ ] 
							[ ] ReportStatus("Hide in account bar account list Brokerage 04 Account",PASS,"{lsAccount[4]} account hide in account bar account list successfully.")
							[ ] 
							[ ] //Making Brokerage 01 Account as "Closed Account"
							[ ] iValidate= CloseAccount(ACCOUNT_INVESTING,lsAccount[1],1)
							[ ] 
							[+] if(iValidate == PASS)
								[ ] 
								[ ] ReportStatus("Closed Brokerage 01 Account",PASS,"{lsAccount[1]} closed account list successfully.")
								[ ] // 
								[ ] //Navigating Planning > Update Planning Assumptions > Savings and Investments
								[ ] QuickenWindow.SetActive()
								[ ] QuickenWindow.Planning.Click()
								[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.Click()
								[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.SavingsInvestments.Select()
								[ ] 
								[+] //Verifying the Hidden Accounts available in Savings-LifeTime Planner
									[ ] sHandle = Str(PlannerSavingsInvestments.SelectTheBankAccountsThat2.ListBox1.GetHandle())
									[+] for each sItem in lsCheckingHideAccount
										[+] for( iCounter=0;iCounter<PlannerSavingsInvestments.SelectTheBankAccountsThat2.ListBox1.GetItemCount();iCounter++)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle, "{iCounter}")
											[ ] //Verify the Hidden Accounts are in the Savings - LifeTime Planner
											[ ] bMatch = MatchStr("*{sItem}*", sActual)
											[+] if (bMatch == TRUE)
												[ ] break
												[ ] 
										[+] if(bMatch == TRUE)
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", PASS, "{sItem} Hidden Account is available in Savings-Lifetime Planner")
										[+] else
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", FAIL, "{sItem},{sActual}  Hidden Account is not available in Savings-Lifetime Planner")
										[ ] 
								[ ] 
								[+] //Verifying the Closed Accounts not available in Savings-LifeTime Planner
									[ ] sHandle = Str(PlannerSavingsInvestments.SelectTheBankAccountsThat2.ListBox1.GetHandle())
									[+] for each sItem in lsCheckingCloseAccount
										[+] for( iCounter=0;iCounter<PlannerSavingsInvestments.SelectTheBankAccountsThat2.ListBox1.GetItemCount();iCounter++)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle, "{iCounter}")
											[ ] //Verify the Closed Accounts are not in the Savings - LifeTime Planner
											[ ] bMatch = MatchStr("*{sItem}*", sActual)
											[+] if (bMatch)
												[ ] break
										[+] if(bMatch == FALSE)
											[ ] ReportStatus("Verify closed account in Savings-Lifetime Planner ", PASS, "{sItem}- Closed Account is not displayed in Savings-Lifetime Planner")
										[+] else
											[ ] ReportStatus("Verify closed account in Savings-Lifetime Planner ", FAIL, "{sItem}- Closed Account is displayed in Savings-Lifetime Planner")
								[ ] 
								[+] //Fetching Data from Excel for Closed Account for Brokerage
									[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sCloseAccountWorksheet)
									[ ] // for(i=1;i<=ListCount(lsExcelData);i++)
									[ ] // if(sAccountType==lsExcelData[i][1] )
									[ ] ListAppend(lsBrokerageCloseAccount,lsExcelData[4][2])
									[+] // else
										[ ] // continue
								[ ] 
								[+] //Fetching Data from Excel for Hidden Account for Brokerage
									[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sHiddenAccountWorksheet)
									[+] for(i=1;i<=ListCount(lsExcelData);i++)
										[+] if(sAccountType==lsExcelData[i][1] )
											[ ] ListAppend(lsBrokerageHideAccount,lsExcelData[i][2])
										[+] else
											[ ] continue
								[ ] 
								[ ] //Navigating to Investment Tab on Savings & Investment-LifeTime Planner
								[ ] PlannerSavingsInvestments.Textclick("Investments" ,3)
								[ ] 
								[ ] sHandle = Str(PlannerSavingsInvestments.SelectTheBankAccountsThat1.ListBox1.GetHandle())
								[ ] 
								[+] //Verifying the Hidden Accounts available in Investment-LifeTime Planner
									[+] for each sItem in lsBrokerageHideAccount
										[+] for( iCounter=0;iCounter<PlannerSavingsInvestments.SelectTheBankAccountsThat1.ListBox1.GetItemCount();iCounter++)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle, "{iCounter}")
											[ ] //Verify the Hidden Accounts are in the Investment - LifeTime Planner
											[ ] bMatch = MatchStr("*{sItem}*", sActual)
											[+] if (bMatch== TRUE)
												[ ] break
										[+] if(bMatch == TRUE)
											[ ] ReportStatus("Validate Account Add in Investment-Lifetime Planner ", PASS, "{sItem} Hidden Account is Add Investment-Lifetime Planner")
										[+] else
											[ ] ReportStatus("Validate Account Add in Investment-Lifetime Planner ", FAIL, "{sItem},{sActual} Hidden Account is not available in Savings-Lifetime Planner")
										[ ] 
								[ ] 
								[+] //Verify the Closed Accounts are not in the Investment - LifeTime Planner
									[ ] sHandle = Str(PlannerSavingsInvestments.SelectTheBankAccountsThat1.ListBox1.GetHandle())
									[ ] //Verify the Closed Accounts are not in the Investment - LifeTime Planner
									[+] for each sItem in lsBrokerageCloseAccount
										[+] for( iCounter=0;iCounter<PlannerSavingsInvestments.SelectTheBankAccountsThat1.ListBox1.GetItemCount();iCounter++)
												[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle, "{iCounter}")
												[ ] 
												[ ] bMatch = MatchStr("*{sItem}*", sActual)
												[+] if (bMatch)
													[ ] break
											[ ] 
										[+] if(bMatch == FALSE)
											[ ] ReportStatus("Verify closed account in Savings-Lifetime Planner ", PASS, "{sItem} - Closed Account is not dispalyed in Investment-Lifetime Planner")
										[+] else
											[ ] ReportStatus("Verify closed account in Savings-Lifetime Planner ", FAIL, "{sItem}- Closed Account is displayed in Investment-Lifetime Planner")
								[ ] 
								[ ] PlannerSavingsInvestments.Close()
								[ ] 
							[+] else
								[ ] ReportStatus("Closed Brokerage 01 Account",FAIL,"{lsAccount[1]} account is not closed successfully.")
							[ ] 
						[+] else
							[ ] ReportStatus("Hide in account bar account list Brokerage 04 Account",FAIL,"{lsAccount[4]} account is not hide in account bar account list successfully.")
						[ ] 
					[+] else
						[ ] ReportStatus("Hide In Transaction List Brokerage 03 Account",FAIL,"{lsAccount[3]} account is not hide in transaction list successfully.")
					[ ] 
				[+] else
					[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home is not successfully.")
				[ ] 
			[+] else
				[ ] ReportStatus("Separate Brokerage 02 Account", FAIL,"{lsAccount[2]} account is not separate successfully.")
			[ ] 
		[+] else
			[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home is not successfully.")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] // Hidden Accs should be & Closed Accs should not be included in Home & Assest Lifetime planner. ############
	[ ] // ********************************************************
	[+] // TestCase Name:	Test14_HiddenAccClosedAccHomAsstLP()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Hidden accounts should be included  and Closed account should not be included in Lifetime planner-Current Home and assets 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			       Pass 	If transactions of the closed account are part of the Lifetime planner
		[ ] //						Fail		If any error occurs or If transactions of the closed account are NOT part of the Lifetime planner
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // April 09, 2013             Anagha created
	[ ] // ********************************************************
[+] testcase Test14_HiddenAccClosedAccHomAsstLP() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[ ] 
	[+] // // Variable defination
		[ ] sExpected = "$100"
		[ ] sAccountType = "Asset"
		[ ] 
		[ ] lsAccount={}
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sAssestAccWorksheet)
		[ ] 
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] ListAppend(lsAccount,lsExcelData[i][2])
			[ ] 
		[+] //Fetching Data from Excel for Hidden Account for Asset
			[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sHiddenAccountWorksheet)
			[ ] 
			[+] for(i=1;i<=ListCount(lsExcelData);i++)
				[+] if(sAccountType==lsExcelData[i][1] )
					[ ] ListAppend(lsAssetHideAccount,lsExcelData[i][2])
				[+] else
					[ ] continue
			[ ] 
		[+] //Fetching Data from Excel for Closed Account for Asset
			[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sCloseAccountWorksheet)
			[ ] 
			[ ] // for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] // if(sAccountType==lsExcelData[i][1] )
			[ ] ListAppend(lsAssetCloseAccount,lsExcelData[7][2])
			[+] // else
				[ ] // continue
			[ ] 
			[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[+] if(iValidate == PASS)
			[ ] 
			[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
			[ ] 
			[ ] //Making Assest 02 Account as "Separate Account"
			[ ] iValidate=SeparateAccount(ACCOUNT_PROPERTYDEBT,lsAccount[2])
			[ ] 
			[+] if(iValidate == PASS)
				[ ] 
				[ ] ReportStatus("Separate Assest 02 Account", PASS,"{lsAccount[2]} account separate successfully.")
				[ ] 
				[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[+] if(iValidate == PASS)
					[ ] 
					[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
						[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
					[ ] 
					[ ] 
					[ ] //Making Assest 03 Account as "Hide In Transaction List"
					[ ] iValidate=AccountHideInTransactionList(ACCOUNT_PROPERTYDEBT,lsAccount[3])
					[ ] 
					[+] if(iValidate == PASS)
						[ ] 
						[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
							[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
						[ ] 
						[ ] 
						[ ] ReportStatus("Hide In Transaction List Assest 03 Account",PASS,"{lsAccount[3]} account hide in transaction list successfully.")
						[ ] 
						[ ] //Making Assest 04 Account as "Hide In Account Bar Account List"
						[ ] iValidate=AccountHideInAccountBarAccountList(ACCOUNT_PROPERTYDEBT,lsAccount[4],3)
						[ ] 
						[+] if(iValidate == PASS)
							[ ] 
							[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
								[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
							[ ] 
							[ ] ReportStatus("Hide in account bar account list Assest 04 Account",PASS,"{lsAccount[4]} account hide in account bar account list successfully.")
							[ ] 
							[ ] //Making Assest 01 Account as "Closed Account"
							[ ] iValidate=CloseAccount(ACCOUNT_PROPERTYDEBT,lsAccount[1],1)
							[ ] 
							[+] if(iValidate == PASS)
								[ ] 
								[ ] ReportStatus("Close {lsAccount[1]}  Account",PASS,"{lsAccount[1]} closed account list successfully.")
								[ ] 
								[ ] //Navigating Planning > Update Planning Assumptions > Homes and Assets
								[ ] QuickenWindow.SetActive()
								[ ] QuickenWindow.Planning.Click()
								[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.Click()
								[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.HomesAssets.Select()
								[ ] 
								[ ] 
								[+] //Verifying the Hidden Accounts available in Homes and Assets-LifeTime Planner
									[ ] 
									[ ] sHandle = Str(PlannerHomesAssets.ToCorrectThePurchaseDateO2.ListBox1.GetHandle())
									[ ] 
									[+] for each sItem in lsAssetHideAccount
										[ ] 
										[+] for( iCounter=0;iCounter<PlannerHomesAssets.ToCorrectThePurchaseDateO2.ListBox1.GetItemCount();iCounter++)
											[ ] 
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
											[ ] 
											[ ] //Verify the Hidden Accounts are in Homes and Assets - LifeTime Planner
											[ ] 
											[ ] bMatch = MatchStr("*{sItem}*",sActual)
											[ ] 
											[+] if(bMatch == TRUE)
												[ ] break
												[ ] 
										[+] if(bMatch == TRUE)
											[ ] ReportStatus("Validate Account Add in Home & Assest -Lifetime Planner ",PASS,"{sItem}  Hidden Account is Add in Home & Assest -Lifetime Planner")
										[+] else
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ",FAIL,"{sItem},{sActual} Hidden Account is not Add in Home & Assest -Lifetime Planner")
								[ ] 
								[+] //Verifying the Closed Accounts not available in Savings-LifeTime Planner
									[ ] 
									[ ] sHandle = Str(PlannerHomesAssets.ToCorrectThePurchaseDateO2.ListBox1.GetHandle())
									[ ] 
									[+] for each sItem in lsAssetCloseAccount
										[ ] 
										[+] for( iCounter=0;iCounter<PlannerHomesAssets.ToCorrectThePurchaseDateO2.ListBox1.GetItemCount();iCounter++)
											[ ] 
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
											[ ] 
											[ ] //Verify the Closed Accounts are not in the Savings - LifeTime Planner
											[ ] 
											[ ] bMatch = MatchStr("*{sItem}*", sActual)
											[ ] 
											[+] if(bMatch)
												[ ] break
												[ ] 
										[+] if(bMatch == FALSE)
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", PASS, "{sItem}  Closed Account is not available in Savings-Lifetime Planner")
										[+] else
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", FAIL, "{sItem},{sActual}  Closed Account is available in Savings-Lifetime Planner")
								[ ] 
								[ ] 
								[ ] PlannerHomesAssets.Close()
							[+] else
								[ ] ReportStatus("Close {lsAccount[1]}  Account",FAIL,"{lsAccount[1]} account is not closed successfully.")
							[ ] 
						[+] else
							[ ] ReportStatus("Hide in account bar account list Assest 04 Account",FAIL,"{lsAccount[4]} account is not hide in account bar account list successfully.")
						[ ] 
					[+] else
						[ ] ReportStatus("Hide In Transaction List Assest 03 Account",FAIL,"{lsAccount[3]} account is not hide in transaction list successfully.")
					[ ] 
				[+] else
					[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home is not successfully.")
				[ ] 
			[+] else
				[ ] ReportStatus("Separate Assest 02 Account", PASS,"{lsAccount[2]} account  is not separate successfully.")
			[ ] 
		[+] else
			[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home is not successfully.")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //Hidden Accs should be and Closed Accs should not be included in Loans & Debt Lifetime planner. #############
	[ ] // ********************************************************
	[+] // TestCase Name:	Test15_HiddenAccClosedAccLoanLP()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Hidden accounts should be included  and Closed account should not be included in Lifetime planner-Current loans
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			    Pass 	If transactions of the closed account are part of the Lifetime planner
		[ ] //						Fail		If any error occurs or If transactions of the closed account are NOT part of the Lifetime planner
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // April 10, 2013             Anagha created
	[ ] // ********************************************************
[+] testcase Test15_HiddenAccClosedAccLoanLP() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] // // Variable defination
		[ ] sExpected = "$100"
		[ ] sAccountType = "Loan"
		[ ] 
		[ ] //Fetching data from Excel sheet
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sLoanAccWorksheet)
		[ ] 
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] ListAppend(lsLoanAccount,lsExcelData[i][2])
			[ ] 
		[+] //Fetching Data from Excel for Hidden Account for Asset
			[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sHiddenAccountWorksheet)
			[ ] 
			[+] for(i=1;i<=ListCount(lsExcelData);i++)
				[+] if(sAccountType==lsExcelData[i][1] )
					[ ] ListAppend(lsLoanHideAccount,lsExcelData[i][2])
					[ ] break
			[ ] 
		[+] //Fetching Data from Excel for Closed Account for Asset
			[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sCloseAccountWorksheet)
			[ ] 
			[+] for(i=1;i<=ListCount(lsExcelData);i++)
				[+] if(sAccountType==lsExcelData[i][1] )
					[ ] ListAppend(lsLoanCloseAccount,lsExcelData[i][2])
					[ ] break
			[ ] 
			[ ] 
			[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Restore()
		[ ] sleep(1)
		[ ] QuickenWindow.Maximize()
		[ ] sleep(1)
		[ ] 
		[ ] 
		[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[+] if(iValidate == PASS)
			[ ] 
			[ ] //Making Loan Account 02 Account as "Separate Account"
			[ ] iValidate=SeparateAccount(ACCOUNT_PROPERTYDEBT,lsLoanAccount[2])
			[ ] 
			[+] if(iValidate == PASS)
				[ ] 
				[ ] ReportStatus("Separate Loan 02 Account", PASS,"{lsLoanAccount[2]} account separate successfully.")
				[ ] 
				[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[+] if(iValidate == PASS)
					[ ] 
					[ ] //Making Loan 03 Account as "Hide In Transaction List"
					[ ] iValidate=AccountHideInTransactionList(ACCOUNT_PROPERTYDEBT,lsLoanAccount[3])
					[ ] 
					[+] if(iValidate == PASS)
						[ ] 
						[ ] ReportStatus("Hide In Transaction List Loan 03 Account",PASS,"{lsLoanAccount[3]} account hide in transaction list successfully.")
						[ ] 
						[ ] //Making Loan 04 Account as "Hide In Account Bar Account List"
						[ ] iValidate=AccountHideInAccountBarAccountList(ACCOUNT_PROPERTYDEBT,lsLoanAccount[4],3)
						[ ] 
						[+] if(iValidate == PASS)
							[ ] 
							[ ] ReportStatus("Hide in account bar account list Loan 04 Account",PASS,"{lsLoanAccount[4]} account hide in account bar account list successfully.")
							[ ] 
							[ ] //Making Loan 01 Account as "Closed Account"
							[ ] iValidate=CloseAccount(ACCOUNT_PROPERTYDEBT,lsLoanAccount[1],4)
							[ ] 
							[+] if(iValidate == PASS)
								[ ] 
								[ ] ReportStatus("Closed Loan 01 Account",PASS,"{lsLoanAccount[1]} closed account list successfully.")
								[ ] 
								[ ] //Navigating Planning > Update Planning Assumptions > Loans and Debt
								[ ] QuickenWindow.SetActive()
								[ ] QuickenWindow.Planning.Click()
								[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.Click()
								[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.LoansDebt.Select()
								[ ] 
								[ ] 
								[+] //Verifying the Hidden Accounts available in  Loans and Debt-LifeTime Planner
									[ ] 
									[ ] sHandle = Str(PlannerLoansDebt.QuickenPlannerLoansAndDeb2.ListBox1.GetHandle())
									[ ] 
									[+] for each sItem in lsLoanHideAccount
										[ ] 
										[+] for( iCounter=0;iCounter<PlannerLoansDebt.QuickenPlannerLoansAndDeb2.ListBox1.GetItemCount();iCounter++)
											[ ] 
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
											[ ] 
											[ ] //Verify the Hidden Accounts are in  Loans and Debt - LifeTime Planner
											[ ] 
											[ ] bMatch = MatchStr("*{sItem}*",sActual)
											[ ] 
											[+] if(bMatch == TRUE)
												[ ] break
												[ ] 
										[+] if(bMatch == TRUE)
											[ ] ReportStatus("Validate Account Add in Home & Assest -Lifetime Planner ",PASS,"{sItem} Hidden Account is Add in  Loans and Debt -Lifetime Planner")
										[+] else
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ",FAIL,"{sItem},{sActual}  Hidden Account is not Add in  Loans and Debt -Lifetime Planner")
											[ ] 
											[ ] 
								[ ] 
								[+] //Verifying the Closed Accounts not available in  Loans and Debt-LifeTime Planner
									[ ] 
									[ ] sHandle = Str(PlannerLoansDebt.QuickenPlannerLoansAndDeb2.ListBox1.GetHandle())
									[ ] 
									[+] for each sItem in lsLoanCloseAccount
										[ ] 
										[+] for( iCounter=0;iCounter<PlannerLoansDebt.QuickenPlannerLoansAndDeb2.ListBox1.GetItemCount();iCounter++)
											[ ] 
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
											[ ] 
											[ ] //Verify the Closed Accounts are not in the Savings - LifeTime Planner
											[ ] 
											[ ] bMatch = MatchStr("*{sItem}*", sActual)
											[ ] 
											[+] if (bMatch)
												[ ] break
												[ ] 
										[+] if(bMatch == FALSE)
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", PASS, "{sItem}  Closed Account is not Add  Loans and Debt-Lifetime Planner")
										[+] else
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", FAIL, "{sItem},{sActual}  Closed Account is Add  Loans and Debt-Lifetime Planner")
								[ ] 
								[ ] PlannerLoansDebt.Close()
							[+] else
								[ ] ReportStatus("Closed Loan 01 Account",FAIL,"{lsLoanAccount[1]} account is not closed successfully.")
							[ ] 
						[+] else
							[ ] ReportStatus("Hide in account bar account list Loan 04 Account",FAIL,"{lsLoanAccount[4]} is not account hide in account bar account list successfully.")
					[+] else
						[ ] ReportStatus("Hide In Transaction List Loan 03 Account",FAIL,"{lsLoanAccount[3]}  is not account hide in transaction list successfully.")
					[ ] 
				[+] else
					[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home is not successfully.")
				[ ] 
			[+] else
				[ ] ReportStatus("Separate Loan 02 Account", FAIL,"{lsLoanAccount[2]} account is not separate successfully.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigation to Home Tab", FAIL,"Navigation to Home is not successfully.")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############Closed account Button not for Saving Goals Account. ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test17_ClosedAccButtonNotSG()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Close Account button should not be displayed for a Saving Goal
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			       Pass 	If transactions of the closed account are part of the DRP
		[ ] //						Fail		If any error occurs or If transactions of the closed account are NOT part of the DRP
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // April 08, 2013             Anagha created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test17_ClosedAccButtonNotSG() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING   sCompareString1 = "Close Account..."
		[ ] STRING   sCompareString = "Account Closed"
		[ ] 
		[ ] 
	[+] // Variable defination
		[ ] 
		[ ] sTab = "Display Options"
		[ ] sGoalName = "Saving Goal 01"
		[ ] 
	[+] if(QuickenMainWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
		[ ] 
		[ ] //Navigating to Savings Goals tab
		[ ] NavigateToAccountDetailsTab(ACCOUNT_SAVINGGOALS,sGoalName,sTab)
		[ ] 
		[ ] ReportStatus("Navigate to Display Options tab", PASS, "Display Option tab is opened for {sGoalName}")
		[ ] 
		[ ] //Verify Close Account Button on Account Details for Savings Goals Account
		[+] if(AccountDetails.Exists(SHORT_SLEEP))
			[ ] AccountDetails.SetActive()
			[+] if(!AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Close Account Button for Savings Goals Account", PASS, "Close Account Button for Savings Goals Account is not present on Account Details Window")
				[ ] AccountDetails.Close()
			[+] else
				[ ] ReportStatus("Close Account Button for Savings Goals Account", FAIL, "Close Account Button for Savings Goals Account is present on Account Details Window")
			[ ] 
		[ ] 
		[ ] //Verify Close Account Button on manage hidden accounts list for Savings Goals Account
		[ ] QuickenWindow.Tools.Click()
		[ ] QuickenWindow.Tools.ManageHiddenAccounts.Select()
		[ ] 
		[ ] sHandle = Str(ManageHiddenAccounts.HidingOptions2.ListBox1.GetHandle())
		[+] for( iCounter=0;iCounter<=ManageHiddenAccounts.HidingOptions2.ListBox1.GetItemCount();iCounter++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
			[ ] bMatch = MatchStr("*{sGoalName}*{sCompareString}*", sActual)
			[+] if ( bMatch == TRUE)
				[ ] break
			[+] else
				[ ] bMatch = MatchStr("*{sGoalName}*{sCompareString1}*", sActual)
				[+] if( bMatch == TRUE)
					[ ] break
				[+] else
					[ ] bMatch=FALSE
			[ ] 
		[+] if(bMatch == FALSE)
			[ ] ReportStatus("Close Account Button for Savings Goals Account", PASS, "Close Account Button for Savings Goals Account is not present on Manage Hidden Accounts Window")
		[+] else
			[ ] ReportStatus("Close Account Button for Savings Goals Account", FAIL, "Close Account Button for Savings Goals Account is present on Manage Hidden Accounts Window")
		[ ] 
		[ ] ManageHiddenAccounts.Close()
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] // Hidden Accs should be and Closed Accs should not be included in Loans & Debt Lifetime planner. #############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_ClosedAccLifetime()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Life time Planner should be modified if participating accounts are closed.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			    Pass 	       If transactions of the closed account are part of the Lifetime planner
		[ ] //				           Fail		If any error occurs or If transactions of the closed account are NOT part of the Lifetime planner
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // April 10, 2013             Anagha created
	[ ] // ********************************************************
[+] testcase Test16_ClosedAccLifetime() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[+] // // Variable defination
		[ ] sExpected = "$100"
		[ ] sAccountType = "Brokerage"
		[ ] sAccountType1 = "Checking"
		[ ] sAccountType2 = "Loan"
		[ ] sAccountType3 = "Asset"
		[ ] lsCheckingCloseAccount={}
		[ ] lsBrokerageCloseAccount={}
		[ ] lsAssetCloseAccount={}
		[ ] lsLoanCloseAccount={}
		[+] //Retrieving Banking Data from Excel sheet 
			[ ] lsExcelData=NULL
			[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sCloseAccountWorksheet)
			[ ] 
			[ ] ListAppend(lsCheckingCloseAccount,lsExcelData[8][2])
			[ ] ListAppend(lsBrokerageCloseAccount,lsExcelData[9][2])
			[ ] ListAppend(lsAssetCloseAccount,lsExcelData[10][2])
			[ ] 
		[ ] 
		[+] //Retrieving Loan Data from Excel sheet 
			[ ] lsExcelData=NULL
			[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sCloseAccountWorksheet)
			[ ] 
			[ ] ListAppend(lsLoanCloseAccount,lsExcelData[11][2])
			[ ] 
			[ ] 
			[ ] 
		[ ] //Retrieving Saving goals Data from Excel sheet 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sHiddenAccountExcel, sSavingsGoalsWorksheet)
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMin()
		[ ] 
		[ ] 
		[+] //Savings and Investments
			[ ] 
			[ ] //Navigating Planning > Update Planning Assumptions > Savings and Investments
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Planning.Click()
			[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.Click()
			[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.SavingsInvestments.Select()
			[ ] 
			[+] if(PlannerSavingsInvestments.Exists(SHORT_SLEEP))
				[ ] 
				[ ] ReportStatus("Verify Update Planning Assumptions > Savings and Investments",PASS,"Update Planning Assumptions > Savings and Investments is opened successfully.")
				[ ] 
				[+] //Verifying the Savings Accounts available in Savings-LifeTime Planner
					[ ] sHandle = Str(PlannerSavingsInvestments.SelectTheBankAccountsThat2.ListBox1.GetHandle())
					[ ] 
					[ ] for each sItem in lsCheckingCloseAccount
					[+] for( iCounter=0;iCounter<PlannerSavingsInvestments.SelectTheBankAccountsThat2.ListBox1.GetItemCount();iCounter++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
						[ ] //Verify the Hidden Accounts are in Homes and Assets - LifeTime Planner
						[ ] bMatch = MatchStr("*{sItem}*",sActual)
						[+] if(bMatch == TRUE)
							[ ] break
							[ ] 
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Accounts Add in Savings-Lifetime Planner ",PASS,"{sItem} Account is Add in Savings -Lifetime Planner")
					[+] else
						[ ] ReportStatus("Validate Accounts Add in Savings-Lifetime Planner ",FAIL,"{sItem},{sActual} Account is not Add in Savings -Lifetime Planner")
				[ ] 
				[ ] //Navigating to Investment Tab on Savings & Investment-LifeTime Planner
				[ ] 
				[ ] PlannerSavingsInvestments.TextClick("Investments" ,3)
				[ ] 
				[ ] 
				[+] if(PlannerSavingsInvestments.Exists(SHORT_SLEEP))
					[ ] 
					[ ] ReportStatus("Verify Update Planning Assumptions > Savings and Investments",PASS,"Update Planning Assumptions > Savings and Investments is opened successfully.")
					[ ] 
					[ ] sHandle = Str(PlannerSavingsInvestments.SelectTheBankAccountsThat1.ListBox1.GetHandle())
					[ ] 
					[+] for each sItem in lsBrokerageCloseAccount
						[ ] 
						[+] for( iCounter=0;iCounter<PlannerSavingsInvestments.SelectTheBankAccountsThat1.ListBox1.GetItemCount();iCounter++)
							[ ] 
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
							[ ] 
							[ ] //Verify the Hidden Accounts are displayed in Homes and Assets - LifeTime Planner
							[ ] bMatch = MatchStr("*{sItem}*",sActual)
							[+] if(bMatch)
								[ ] break
								[ ] 
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Validate Account Add in Home & Assest -Lifetime Planner ",PASS,"{sItem}  Hidden Account is Add in Home & Assest -Lifetime Planner")
						[+] else
							[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ",FAIL,"{sItem},{sActual}  Hidden Account is not Add in Home & Assest -Lifetime Planner")
					[ ] 
					[ ] PlannerSavingsInvestments.Close()
				[+] else
					[ ] ReportStatus("Verify Update Planning Assumptions > Savings and Investments",FAIL,"Update Planning Assumptions > Savings and Investments is not opened successfully.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Update Planning Assumptions > Savings and Investments",FAIL,"Update Planning Assumptions > Savings and Investments is not opened successfully.")
		[ ] 
		[+] //Homes and Assets
			[ ] //Navigating Planning > Update Planning Assumptions > Homes and Assets
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Planning.Click()
			[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.Click()
			[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.HomesAssets.Select()
			[ ] 
			[+] if(PlannerHomesAssets.Exists(SHORT_SLEEP))
				[ ] 
				[ ] ReportStatus("Verify Update Planning Assumptions > Homes and Assets",PASS,"Update Planning Assumptions > Homes and Assets is opened successfully.")
				[ ] 
				[ ] //Verifying the Hidden Accounts available in Homes and Assets-LifeTime Planner
				[ ] sHandle = Str(PlannerHomesAssets.ToCorrectThePurchaseDateO2.ListBox1.GetHandle())
				[ ] 
				[+] for each sItem in lsAssetCloseAccount 
					[ ] 
					[+] for( iCounter=0;iCounter<PlannerHomesAssets.ToCorrectThePurchaseDateO2.ListBox1.GetItemCount();iCounter++)
						[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
						[ ] 
						[ ] //Verify the Hidden Accounts are displayed in Homes and Assets - LifeTime Planner
						[ ] bMatch = MatchStr("*{sItem}*",sActual)
						[+] if(bMatch)
							[ ] break
							[ ] 
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Account Add in Home & Assest -Lifetime Planner ",PASS,"{sItem} Account is Add in Home & Assest -Lifetime Planner")
					[+] else
						[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ",FAIL,"{sItem},{sActual}  Account is not Add in Home & Assest -Lifetime Planner")
				[ ] 
				[ ] PlannerHomesAssets.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Update Planning Assumptions > Homes and Assets",FAIL,"Update Planning Assumptions > Homes and Assets is opened successfully.")
			[ ] 
		[ ] 
		[+] // Loans and Debt
			[ ] //Navigating Planning > Update Planning Assumptions > Loans and Debt
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Planning.Click()
			[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.Click()
			[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.LoansDebt.Select()
			[ ] 
			[+] if(PlannerLoansDebt.Exists(SHORT_SLEEP))
				[ ] 
				[ ] ReportStatus("Verify Update Planning Assumptions > Loans and Debt",PASS,"Update Planning Assumptions > Loans and Debt is opened successfully.")
				[ ] 
				[+] //Verifying the Hidden Accounts available in Loans and Debt LifeTime Planner
					[ ] 
					[ ] sHandle = Str(PlannerLoansDebt.QuickenPlannerLoansAndDeb2.ListBox1.GetHandle())
					[ ] 
					[ ] 
					[+] for each sItem in lsLoanCloseAccount
						[ ] 
						[+] for( iCounter=0;iCounter<PlannerLoansDebt.QuickenPlannerLoansAndDeb2.ListBox1.GetItemCount();iCounter++)
							[ ] 
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
							[ ] 
							[ ] //Verify the Hidden Accounts are in Loans and Debt - LifeTime Planner
							[ ] bMatch = MatchStr("*{sItem}*",sActual)
							[+] if(bMatch)
								[ ] break
								[ ] 
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Validate Account Add in Loans and Debt -Lifetime Planner ",PASS,"{sItem} Account is Add in Loans and Debt -Lifetime Planner")
						[+] else
							[ ] ReportStatus("Validate Account Add in Loans and Debt-Lifetime Planner ",FAIL,"{sItem},{sActual} Account is not Add in Loans and Debt -Lifetime Planner")
					[ ] 
				[ ] PlannerLoansDebt.Close()
			[+] else
				[ ] ReportStatus("Verify Update Planning Assumptions > Loans and Debt",FAIL,"Update Planning Assumptions > Loans and Debt is not opened successfully.")
			[ ] 
			[ ] 
		[ ] 
		[ ] //Making Checking 09 Account as "Closed Account"
		[ ] iValidate=CloseAccount(ACCOUNT_BANKING,lsCheckingCloseAccount[1],5)
		[ ] 
		[+] if(iValidate == PASS)
			[ ] 
			[ ] ReportStatus("Closed Checking 09 Account",PASS,"{lsCheckingCloseAccount[1]} closed account list successfully.")
			[ ] 
			[ ] //Making Brokerage 05 Account as "Closed Account"
			[ ] iValidate=CloseAccount(ACCOUNT_INVESTING,lsBrokerageCloseAccount[1],3)
			[ ] 
			[+] if(iValidate == PASS)
				[ ] 
				[ ] ReportStatus("Closed Brokerage 05 Account",PASS,"{lsBrokerageCloseAccount[1]} closed account list successfully.")
				[ ] 
				[ ] //Making  Loan 06 Account as "Closed Account"
				[ ] iValidate=CloseAccount(ACCOUNT_PROPERTYDEBT,lsLoanCloseAccount[1],7)
				[ ] 
				[+] if(iValidate == PASS)
					[ ] 
					[ ] ReportStatus("Closed Loan 05 Account",PASS,"{lsLoanCloseAccount[1]} closed account list successfully.")
					[ ] 
					[ ] //Making Asset 05  Account as "Closed Account"
					[ ] iValidate=CloseAccount(ACCOUNT_PROPERTYDEBT,lsAssetCloseAccount[1],3)
					[ ] 
					[+] if(iValidate == PASS)
						[ ] 
						[ ] ReportStatus("Closed Asset 05  Account",PASS,"{lsAssetCloseAccount[1]} closed account list successfully.")
						[ ] 
						[+] // Savings and Investments
							[ ] //Navigating Planning > Update Planning Assumptions > Savings and Investments
							[ ] QuickenWindow.SetActive()
							[ ] QuickenWindow.Planning.Click()
							[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.Click()
							[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.SavingsInvestments.Select()
							[ ] 
							[+] if(PlannerSavingsInvestments.Exists(SHORT_SLEEP))
								[ ] 
								[ ] ReportStatus("Verify Update Planning Assumptions > Savings and Investments",PASS,"Update Planning Assumptions > Savings and Investments is opened successfully.")
								[ ] 
								[+] //Verifying the Savings Accounts available in Savings-LifeTime Planner
									[ ] sHandle = Str(PlannerSavingsInvestments.SelectTheBankAccountsThat2.ListBox1.GetHandle())
									[ ] 
									[+] for each sItem in lsCheckingCloseAccount
										[ ] 
										[+] for( iCounter=0;iCounter<PlannerSavingsInvestments.SelectTheBankAccountsThat2.ListBox1.GetItemCount();iCounter++)
											[ ] 
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
											[ ] 
											[ ] //Verify the Closed Accounts are not in the Savings - LifeTime Planner
											[ ] 
											[ ] bMatch = MatchStr("*{sItem}*", sActual)
											[ ] 
											[+] if (bMatch)
												[ ] break
												[ ] 
										[+] if(bMatch == FALSE)
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", PASS, "{sItem}  Closed Account is not available available in Savings-Lifetime Planner")
										[+] else
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", FAIL, "{sItem},{sActual}  Closed Account is available Savings-Lifetime Planner")
								[ ] 
								[+] //Navigating to Investment Tab on Savings & Investment-LifeTime Planner
									[ ] 
									[ ] PlannerSavingsInvestments.TextClick("Investments" ,3)
									[ ] 
									[+] if(PlannerSavingsInvestments.Exists(SHORT_SLEEP))
										[ ] 
										[ ] ReportStatus("Verify Update Planning Assumptions > Savings and Investments",PASS,"Update Planning Assumptions > Savings and Investments is opened successfully.")
										[ ] 
										[ ] sHandle = Str(PlannerSavingsInvestments.SelectTheBankAccountsThat1.ListBox1.GetHandle())
										[ ] 
										[+] for each sItem in lsBrokerageCloseAccount
											[ ] 
											[+] for( iCounter=0;iCounter<PlannerSavingsInvestments.SelectTheBankAccountsThat1.ListBox1.GetItemCount();iCounter++)
												[ ] 
												[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
												[ ] 
												[ ] //Verify the Closed Accounts are not in Homes and Assets - LifeTime Planner
												[ ] bMatch = MatchStr("*{sItem}*", sActual)
												[+] if (bMatch)
													[ ] break
												[ ] 
											[+] if(bMatch == FALSE)
												[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", PASS, "{sItem}  Closed Account is not available in Savings-Lifetime Planner")
											[+] else
												[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", FAIL, "{sItem},{sActual}  Closed Account is available in Savings-Lifetime Planner")
										[ ] 
										[ ] PlannerSavingsInvestments.Close()
									[+] else
										[ ] ReportStatus("Verify Update Planning Assumptions > Savings and Investments",FAIL,"Update Planning Assumptions > Savings and Investments is not opened successfully.")
							[+] else
								[ ] ReportStatus("Verify Update Planning Assumptions > Savings and Investments",FAIL,"Update Planning Assumptions > Savings and Investments is not opened successfully.")
							[ ] 
							[ ] 
						[ ] 
						[+] //Homes and Assets
							[ ] //Navigating Planning > Update Planning Assumptions > Homes and Assets
							[ ] QuickenWindow.SetActive()
							[ ] QuickenWindow.Planning.Click()
							[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.Click()
							[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.HomesAssets.Select()
							[ ] 
							[+] if(PlannerHomesAssets.Exists(SHORT_SLEEP))
								[ ] 
								[ ] ReportStatus("Verify Update Planning Assumptions > Homes and Assets",PASS,"Update Planning Assumptions > Homes and Assets is opened successfully.")
								[ ] 
								[+] //Verifying the Hidden Accounts available in Homes and Assets-LifeTime Planner
									[ ] 
									[ ] sHandle = Str(PlannerHomesAssets.ToCorrectThePurchaseDateO2.ListBox1.GetHandle())
									[ ] 
									[+] for each sItem in lsAssetCloseAccount 
										[ ] 
										[+] for( iCounter=0;iCounter<PlannerHomesAssets.ToCorrectThePurchaseDateO2.ListBox1.GetItemCount();iCounter++)
											[ ] 
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
											[ ] 
											[ ] //Verify the Closed Accounts are not in Homes and Assets - LifeTime Planner
											[ ] bMatch = MatchStr("*{sItem}*", sActual)
											[+] if (bMatch)
												[ ] break
												[ ] 
										[+] if(bMatch == FALSE)
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", PASS, "{sItem} Closed Account is not available in Savings-Lifetime Planner")
										[+] else
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", FAIL, "{sItem},{sActual} Closed Account is available in Savings-Lifetime Planner")
								[ ] 
								[ ] PlannerHomesAssets.Close()
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Update Planning Assumptions > Homes and Assets",FAIL,"Update Planning Assumptions > Homes and Assets is opened successfully.")
							[ ] 
						[ ] 
						[+] // Loans and Debt
							[ ] //Navigating Planning > Update Planning Assumptions > Loans and Debt
							[ ] QuickenWindow.SetActive()
							[ ] QuickenWindow.Planning.Click()
							[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.Click()
							[ ] QuickenWindow.Planning.UpdatePlanningAssumptions.LoansDebt.Select()
							[ ] 
							[+] if(PlannerLoansDebt.Exists(SHORT_SLEEP))
								[ ] 
								[ ] ReportStatus("Verify Update Planning Assumptions > Loans and Debt",PASS,"Update Planning Assumptions > Loans and Debt is opened successfully.")
								[ ] 
								[+] //Verifying the Closed Accounts are not in Loans and Debt LifeTime Planner
									[ ] 
									[ ] sHandle = Str(PlannerLoansDebt.QuickenPlannerLoansAndDeb2.ListBox1.GetHandle())
									[ ] 
									[ ] 
									[+] for each sItem in lsLoanCloseAccount
										[ ] 
										[+] for( iCounter=0;iCounter<PlannerLoansDebt.QuickenPlannerLoansAndDeb2.ListBox1.GetItemCount();iCounter++)
											[ ] 
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
											[ ] 
											[ ] //Verify the Closed Accounts are not in Loans and Debt - LifeTime Planner
											[ ] 
											[ ] bMatch = MatchStr("*{sItem}*", sActual)
											[+] if (bMatch)
												[ ] break
												[ ] 
										[+] if(bMatch == FALSE)
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", PASS, "{sItem} Closed Account is not available in Savings-Lifetime Planner")
										[+] else
											[ ] ReportStatus("Validate Account Add in Savings-Lifetime Planner ", FAIL, "{sItem},{sActual} Closed Account is available in Savings-Lifetime Planner")
								[ ] 
								[ ] PlannerLoansDebt.Close()
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Update Planning Assumptions > Loans and Debt",FAIL,"Update Planning Assumptions > Loans and Debt is not opened successfully.")
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Closed Asset 05  Account",PASS,"{lsAssetCloseAccount[1]} closed account list successfully.")
				[+] else
					[ ] ReportStatus("Closed Loan 05 Account",PASS,"{lsLoanCloseAccount[1]} closed account list successfully.")
			[+] else
				[ ] ReportStatus("Closed Brokerage 05 Account",PASS,"{lsBrokerageCloseAccount[1]} closed account list successfully.")
		[+] else
			[+] ReportStatus("Closed Checking 09  Account",PASS,"{lsCheckingCloseAccount[1]} closed account list successfully.")
					[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //##########################################################################
[ ] 
[ ] 
