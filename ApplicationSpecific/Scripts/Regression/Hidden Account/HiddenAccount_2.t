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
[ ] 
[ ] 
[ ] 
[+] // Global variables
	[ ] // public STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
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
[ ] //*******************************************************************INVESTING***********************************************************************
[ ] 
[+] //#############  SetUp ######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Investing_SetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will open data file to test hidden account for investing accounts
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting and creating file							
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 03, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Investing_SetUp () appstate QuickenBaseState
	[ ] 
	[ ] INTEGER iSetupAutoAPI,iRegistration,iCreateDataFile,iAddAccount,j,iAddTransaction
	[ ] STRING sFileName = "HiddenAccountInvesting"
	[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
	[ ] 
	[ ] List of LIST OF STRING lsAddAccount,lsTransactionData
	[ ] 
	[ ] //lsAddAccount={{"Brokerage","Brokerage 01 Account","100",sDateStamp},{"Brokerage","Brokerage 02 Account","100",sDateStamp},{"Brokerage","Brokerage 03 Account","100",sDateStamp},{"Brokerage","Brokerage 04 Account","100",sDateStamp},{"Brokerage","Brokerage 05 Account","100",sDateStamp},{"Brokerage","Brokerage 06 Account","100",sDateStamp}}
	[ ] 
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
	[ ] 
	[ ] 
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] App_start (sCmdLine)
	[ ] // RegisterQuickenConnectedServices()
	[ ] 
	[ ] // Create Data File
	[ ] iCreateDataFile = OpenDataFile(sFileName)
	[ ] 
	[ ] // Set Classic View
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] // 
	[+] // for(i=1;i<=Listcount(lsAddAccount);i++)
		[ ] // // // Add Brokerage Account
		[ ] // // iAddAccount = AddManualBrokerageAccount(lsAddAccount[i][1], lsAddAccount[i][2], lsAddAccount[i][3], lsAddAccount[i][4])
		[ ] // // // Report Status if brokerage Account is created
		[+] // // if (iAddAccount==PASS)
			[ ] // // ReportStatus("Add Brokerage Account", iAddAccount, "Brokerage Account -  {lsAddAccount[i][2]} is created successfully")
			[ ] // 
		[+] // if(i<Listcount(lsAddAccount)-1)
			[+] // for(j=1;j<=2;j++)
				[ ] // // This will click on Investing account on AccountBar
				[ ] // SelectAccountFromAccountBar(lsAddAccount[i][2],ACCOUNT_INVESTING)
				[ ] // //iSelect = SelectAccountFromAccountBar(ACCOUNT_INVESTING, i)
				[ ] // ReportStatus("Select Account", PASS, "Investing Account {lsAddAccount[i][2]} is selected") 
				[ ] // 
				[ ] // lsTransactionData={{"MDI","Buy","",lsAddAccount[i][2],sDateStamp,"Intu","10","50","25"},{"MDI","Sell","",lsAddAccount[i][2],sDateStamp,"Intu","10","50","25"}}
				[ ] // 
				[ ] // // Add Buy/Sell Transaction to account
				[ ] // iAddTransaction= AddBrokerageTransaction(lsTransactionData[j])
				[ ] // ReportStatus("Add Transaction", iAddTransaction, "Transaction is added to investing account") 
			[ ] // 
		[+] // // else
			[ ] // // ReportStatus("{lsAddAccount[i][1]} Account", iAddAccount, "{lsAddAccount[i][1]} Account -  {lsAddAccount[i][2]}  is not created successfully")
	[ ] // 
[ ] //###########################################################################
[ ] 
[+] //#############Investing account as Separate Account ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_InvestingAsSeparateAccount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check Account Display option "-Keep this account separate-Account would be excluded from Quicken reports and features."  for an Investing account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 03, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_InvestingAsSeparateAccount () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sReport
		[ ] sAccount = "Brokerage 01 Account"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Separate Investing Account
		[ ] iSelect = SeparateAccount(ACCOUNT_INVESTING,sAccount)
		[+] if (iSelect == PASS)
			[ ] ReportStatus("Check KeepThisAccountSeparate checkbox for Investing account", PASS, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is checked")
			[ ] 
			[ ] // Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
			[+] if (iSeparate == PASS)
				[ ] AccountDetails.Cancel.Click()
				[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and investing account is displayed under this seaction")
			[+] else
				[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Separate section is not created")
			[ ] 
		[+] else
			[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", FAIL, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is not available")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Close Investing account with securities #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test010_CloseInvestingAccWithSecurity()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the alert message when user try to close investing account which is having securities
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 04, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test02_CloseInvestingAccWithSecurity () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sActualMessage,sTab,sExpectedMessage
		[ ] sTab= "Display Options"
		[ ] sAccount="Brokerage 02 Account"
		[ ] sExpectedMessage="This account has securities balances, please clear the securities before you close the account."
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Edit Investing Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_INVESTING,sAccount,sTab)			// Select Investing account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] // Check "Close Account" button
			[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
				[ ] AccountDetails.CloseAccount.Click()
				[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Check Permanently Close Account window", PASS, "Permanently Close Account window is available")
						[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
						[ ] PermanentlyCloseAccount.OK.Click()
						[ ]  AccountDetails.Close()
						[+] 
							[+] // // if(AlertMessage.Exists(SHORT_SLEEP))
								[ ] // // // Get alert message
								[ ] // // sActualMessage=AlertMessage.MessageText.GetText()
								[+] // // if(AssertEquals(sExpectedMessage,sActualMessage))
									[ ] // // ReportStatus("Verify alert message", PASS, "Correct alert message is displayed i.e. {sExpectedMessage}")
								[+] // // else
									[ ] // // ReportStatus("Verify alert message", FAIL, "Actual alert message: {sActualMessage} and Expected alert message: {sExpectedMessage}")
								[ ] // // // AlertMessage.OK.Click()
							[+] // // if(AccountDetails.Exists(SHORT_SLEEP))
								[ ] // AccountDetails.SetActive()
								[ ] // AccountDetails.Close()
								[ ] 
							[+] // else
								[ ] // ReportStatus("Verify alert message dialog", FAIL, "Alert message dialog is not displayed")
								[ ] 
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
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Close zero balance Investing account with securities ###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test011_CloseZeroBalanceInvestingAcc()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Investing account with zero balance should get closed (with securities)
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If account get closed successfully					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 04, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_CloseZeroBalanceInvestingAcc () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sSearch
		[ ] sTab= "Display Options"
		[ ] sAccount="Brokerage 06 Account"
		[ ] sSearch = "Balance Offset Tx"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Edit Investing Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_INVESTING,sAccount,sTab)			// Select  Investing account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] // Check "Close Account" button
			[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
				[ ] AccountDetails.CloseAccount.Click()
				[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Check Permanently Close Account window", PASS, "Permanently Close Account window is available")
					[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
					[ ] PermanentlyCloseAccount.OK.Click()
					[ ] AccountDetails.Close()
					[ ] ReportStatus("Close investing account having security and balance zero", PASS, "Zero balance investing account with security is closed")
					[ ] 
					[ ] // Verify offset entry
					[ ] //iSelect = SelectAccountFromAccountBar(ACCOUNT_INVESTING,5)	// select checking account
					[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)
					[ ] 
					[+] if(iSelect==PASS)
						[ ] ReportStatus("Select Closed Investing  Account", iSelect, "Closed Investing Account {sAccount} is selected") 
						[ ] 
						[ ] iValidate = NavigateToAccountDetailsTab(ACCOUNT_INVESTING,sAccount,sTab)		// find transaction
						[+] if(iValidate == PASS)
							[+] if(!AccountDetails.CloseAccount.IsEnabled())
								[ ] ReportStatus("Verify Close button is disabled ", PASS, "Close button is disabled as {sAccount} is closed") 
							[+] else
								[ ] ReportStatus("Verify Close button is enabled ", FAIL, "Close button is enabled as {sAccount} is not closed") 
							[ ] AccountDetails.Close()
						[+] else
							[ ] ReportStatus("Verify Navigation", iSelect, "Navigation to Account Details tab is failed") 
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Check Permanently Close Account window", FAIL, "Permanently Close Account window is not available")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Check Close Account button", FAIL, "Close button is not available")
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
[+] //#############Verify Hide account name from account bar and account list ############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_HideInvestingAccountFromAccountBar()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check Account Display option "-Hide account name in account bar and account list."  for an Investing account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If investing account is hidden from account bar and account list						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 04, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test04_HideInvestingAccountFromAccountBar () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iSelectAccount,iAccountDetails
		[ ] sAccount = "Brokerage 02 Account"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Navigate to account list
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
		[+] if(iNavigate == PASS)
			[ ] // Verify Show hidden accounts checkbox is not available if there are no hidden account
			[+] if(AccountList.Exists(SHORT_SLEEP))
				[+] if(!AccountList.QWinChild.ShowHiddenAccounts.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Validate Show hidden Account checkbox", PASS, "Show hidden Account checkbox is not available on Account List") 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Show hidden Account checkbox", FAIL, "Show hidden Account checkbox is available on Account List") 
				[ ] AccountList.Close()
		[ ] 
		[ ] // Edit Investing Account
		[ ] iSelect = AccountHideInAccountBarAccountList(ACCOUNT_INVESTING,sAccount,1)			// Select first Investing account
		[+] if (iSelect == PASS)
			[ ] ReportStatus("Check Hide account name from account bar and account list checkbox", PASS, "Third Checkbox: Hide account name from account bar and account list is checked")
			[ ] 
			[ ] // Verify account name in Account Bar
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] iSelectAccount = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)	// select first investing account
			[ ] 
			[+] if(iSelectAccount == PASS)
				[ ] iAccountDetails=NavigateToAccountDetails(sAccount)
				[+] if(iAccountDetails==FAIL)
					[ ] ReportStatus("Check account in Account bar", PASS, "Account is hidden from Account bar")
					[ ] 
				[+] else
					[ ] ReportStatus("Check account in Account bar", FAIL, "Account is hidden from Account bar")
					[ ] 
				[ ] AccountDetails.Close()
			[ ] 
			[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
			[+] if(iNavigate == PASS)
				[ ] // sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
				[ ] // 
				[ ] // // ####### Validate Accounts in Account List window #####################
				[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "2")
				[ ] // bMatch = MatchStr("*Brokerage 02*", sActual)
				[+] // if(bMatch == FALSE)
					[ ] // ReportStatus("Validate Account in Account List and Account Bar", PASS, "Account is hidden in Account list and Account Bar") 
				[+] // else
					[ ] // ReportStatus("Validate Account in Account List and Account", FAIL, "Account is available in Account List and Account Bar") 
				[+] if(AccountList.Exists(SHORT_SLEEP))
					[+] if(AccountList.QWinChild.ShowHiddenAccounts.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Validate Show hidden Account checkbox", PASS, "Show hidden Account checkbox is available on Account List") 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Show hidden Account checkbox", FAIL, "Show hidden Account checkbox is not available on Account List") 
					[ ] AccountList.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("Check Hide account name from account bar and account list checkbox", FAIL, "Third Checkbox: Hide account name from account bar and account list is not available")
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# Verify Hide in Transaction entry lists for investing account ##############
	[ ] // ********************************************************
	[+] // TestCase Name:Test13_InvestingHideInTransactionEntryList()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will check Account Display option "-Hide in Transaction Entry list."  for a Investing account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If investing account is not present in register					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 5, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test05_InvestingHideInTransactionEntryList() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iReportSelect,iCount
		[ ] STRING sReport
		[ ] sAccount = "Brokerage 03 Account"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Edit Investing Account
		[ ] iSelect = AccountHideInTransactionList(ACCOUNT_INVESTING,sAccount)			// Select investing account
		[+] if (iSelect == PASS)
			[ ] ReportStatus("Check Hide in Transaction Entry List checkbox", PASS, "Second Checkbox: Hide in transaction entry lists is checked")
			[ ] 
			[+] // Verify account name in register
				[ ]  // Select Account in account bar
				[ ] SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive ()
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] // Click on Enter Transaction Button
				[ ] QuickenWindow.SetActive ()
				[ ] BrokerageAccount.EnterTransactions.Click()
				[ ] wEnterTransaction.SetActive()
				[ ] sleep(SHORT_SLEEP)
				[ ] // Open Buy transaction window
				[ ] wEnterTransaction.EnterTransaction.SetFocus()
				[ ] wEnterTransaction.EnterTransaction.TypeKeys("<Alt-g>")
				[ ] wEnterTransaction.UseCashForThisTransaction.Select("#2")
				[ ] //Find Separate Account Name 
				[+] if(wEnterTransaction.FromAccountList.FindItem(sAccount)==0)
					[ ] ReportStatus("Verify Hide in transaction entry lists",PASS,"Investing account {sAccount} is not available in From Account list for entering transaction as it is hidden in transaction entry list")
				[+] else
					[ ] ReportStatus("Verify Hide in transaction entry lists",FAIL,"Investing account {sAccount} is available in From Account list for entering transaction as it is hidden in transaction entry list")
					[ ] 
				[ ] 
				[ ] wEnterTransaction.Close()
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Check Hide in Transaction entry lists checkbox", FAIL, "Second Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is not available")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# Investing account with all display options selected ####################
	[ ] // ********************************************************
	[+] // TestCase Name:Test14_InvestingAccWithAllDisplayOption()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will check investing account with all display option checked/selected
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If all display options selected and functioning as expected				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 5, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test06_InvestingAccWithAllDisplayOption() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iReportSelect,iCount
		[ ] STRING sReport
		[ ] BOOLEAN bFlag = FALSE
		[ ] sAccount = "Brokerage 03 Account"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Edit Investing Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_INVESTING,sAccount,sTab)			// Select investing account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] // Check " Keep this account separate- account will be excluded from Quicken reports and features" checkbox
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
			[ ] // Check "Hide In Transaction Entry List" checkbox
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
			[ ] // Check "Hide account name in account bar and account list" checkbox
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
			[+] else
				[ ] ReportStatus("Select all display options", FAIL, "All display options are not selected in Account Details window")
				[ ] 
			[ ] 
			[+] // Verify account name in register
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] // Click on All Transactions link
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.AllTransactions.Click()
				[ ] //MDIClient.AccountRegister.SetActive ()
				[ ] 
				[ ] //MDIClient.AccountRegister.TypeKeys("<Ctrl-n>")	// highlight the new row
				[ ] QuickenWindow.TypeKeys("<Ctrl-n>")
				[ ] MDIClient.AccountRegister.TxList.TypeKeys ("20-10-2012")
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] 
			[+] // Verify account name in Account List
				[ ] 
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
				[+] if(iNavigate == PASS)
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
					[ ] 
					[ ] // ####### Validate Accounts in Account List window #####################
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "3")
					[ ] bMatch = MatchStr("*Brokerage 04*", sActual)
					[+] if(bMatch == FALSE)
						[ ] ReportStatus("Validate Account in Account List and Account Bar", PASS, "Account is hidden in Account list and Account Bar") 
					[+] else
						[ ] ReportStatus("Validate Account in Account List and Account", FAIL, "Account is available in Account List and Account Bar") 
					[+] if(AccountList.Exists(SHORT_SLEEP))
						[+] if(AccountList.QWinChild.ShowHiddenAccounts.Exists(SHORT_SLEEP))
							[ ] ReportStatus("Validate Show hidden Account checkbox", PASS, "Show hidden Account checkbox is available on Account List") 
							[ ] 
						[+] else
							[ ] ReportStatus("Validate Show hidden Account checkbox", FAIL, "Show hidden Account checkbox is not available on Account List") 
						[ ] AccountList.Close()
			[ ] 
			[+] // Verify account "Separate" section 
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] iSeparate=SelectAccountFromAccountBar(sAccount,ACCOUNT_SEPARATE)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(Replicate(KEY_DN,1))
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_ENTER)
				[+] if (iSeparate == PASS)
					[ ] iNavigate=NavigateToAccountDetails(sAccount)
					[ ] // Click on Display Option Tab
					[ ] AccountAdded.Click(1,256,58)
					[ ] 
					[+] if(AccountDetails.KeepThisAccountSeparate.IsChecked())
						[ ] AccountDetails.Cancel.Click()
						[ ] ReportStatus("Verify account in Separate section in Account Bar", PASS, "Account is displayed under Separate section in Account Bar")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify account in Separate section in Account Bar", FAIL, "Account is not displayed under Separate section in Account Bar")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Account is not displayed under Separate section")
			[ ] 
			[+] // Verify account is Closed
				[ ] NavigateToAccountDetailsTab(ACCOUNT_INVESTING,sAccount,sTab)
				[+] if(!AccountDetails.CloseAccount.IsEnabled())
					[ ] ReportStatus("Verify Close Account button is disabled", PASS, "Close Account button is disabled hence {sAccountName} is closed")
					[ ] iFunctionResult=PASS 
				[+] else
					[ ] ReportStatus("Verify Close Account button is disabled", FAIL, "Close Account button is enabled hence {sAccountName} is not closed") 
					[ ] iFunctionResult=FAIL
				[ ] AccountDetails.Close()
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
[+] //############# Close 529/brokerage account having linked checking account ###########
	[ ] // ********************************************************
	[+] // TestCase Name:Test15_CloseLinkedInvestingAcc()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify closing of 529/brokerage account having linked checking account with it.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If linked investing account successfully closed				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 8, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test07_CloseLinked529InvestingAcc() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sAccountType,sCash,sStatementEndingDate,sSearch
		[ ] BOOLEAN bFlag = FALSE
		[ ] sAccount = "529 Plan"
		[ ] sAccountType="529 Plan"
		[ ] sSearch = "Balance Offset Tx"
		[ ] sCash = "200"
		[ ] sStatementEndingDate= sDateStamp
		[ ] sWindowType = "MDI" 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Add Investment Accounts
		[ ] // iAddAccount = AddManualBrokerageAccount(sAccountType,sAccount,sCash,sStatementEndingDate)
		[ ] // ReportStatus("Add Investing Account", iAddAccount, "Investing Account -  {sAccount} is created successfully")
		[ ] 
		[ ] // Edit Investing Account to link with checking account
		[ ] iNavigate = NavigateToAccountDetailsTab(ACCOUNT_INVESTING,sAccount,"General")			// Select investing account
		[+] if (iNavigate == PASS)
			[+] if(AccountDetails.ShowCashInACheckingAccount.Exists(SHORT_SLEEP))
				[ ] AccountDetails.ShowCashInACheckingAccount.Select("Yes")
				[ ] ReportStatus("Link investing account with checking account", PASS, "Linked investing account with checking account")
				[ ] AccountDetails.OK.Click()
				[ ] 
				[ ] // Edit Investing Account
				[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_INVESTING,sAccount,sTab)			// Select first Investing account
				[+] if (iSelect == PASS)
					[ ] 
					[ ] // Check "Close Account" button
					[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
						[ ] AccountDetails.CloseAccount.Click()
						[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
							[ ] ReportStatus("Check Permanently Close Account window", PASS, "Permanently Close Account window is available")
							[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
							[ ] PermanentlyCloseAccount.OK.Click()
							[ ] AccountDetails.Close()
							[ ] ReportStatus("Close investing account {sAccount} linked with checking account", PASS, "Investing account {sAccount} linked with checking account is closed")
							[ ] 
							[ ] // Verify offset entry
							[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)	// select checking account
							[+] if(iSelect==PASS)
								[ ] ReportStatus("Select Closed Banking Account", iSelect, "Closed Linked Banking Account is selected") 
								[ ] 
								[ ] // iValidate = FindTransaction(sWindowType,sSearch,ACCOUNT_INVESTING)		// find transaction
								[+] // if(iValidate == PASS)
									[ ] // ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found") 
								[+] // else
									[ ] // ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not find") 
								[ ] 
							[+] else
								[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Check Permanently Close Account window", FAIL, "Permanently Close Account window is not available")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Check Close Account button", FAIL, "Close button is not available")
						[ ] 
				[+] else
					[ ] ReportStatus("Validate Account Details window", FAIL, "Navigation to Account Details Window is failed")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Link investing account with checking account", FAIL, "Show cash in checking account radio list is not available")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Account Details window", FAIL, "Account Details window is not available")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] // #############Closed Investing account In Enter Transaction ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test22_InvestingClosedAccountInTransaction()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that closed Investing account name should not get displayed in account list  at the time of entering the transaction.
		[ ] // Verify that closed account name in the "Use cash for this transaction" section (From drop down menu) on the Buy-shares Bought transaction dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If closed investing account is not available in Enter Transaction window  							
		[ ] // 						Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Mar 28, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test22_InvestingClosedAccountInTransaction () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sClosedAccount
		[ ] sAccount = "Brokerage 01 Account"
		[ ] sClosedAccount="Brokerage 06 Account"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Separate Investing Account
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_SEPARATE)
		[ ] 
		[+] if (iSelect == PASS)
			[ ] 
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] sleep(SHORT_SLEEP)
			[ ] // Click on Enter Transaction Button
			[ ] QuickenWindow.SetActive ()
			[ ] BrokerageAccount.EnterTransactions.Click()
			[ ] wEnterTransaction.EnterTransaction.TypeKeys("<Alt-g>")
			[ ] wEnterTransaction.UseCashForThisTransaction.Select("#2")
			[ ] //Find Closed Account Name 
			[+] if(wEnterTransaction.FromAccountList.FindItem(sClosedAccount)==0)
				[ ] ReportStatus("Verify Closed Account availability in From Account list",PASS,"Closed investing account {sClosedAccount} is not available in From Account list for entering transaction")
			[+] else
				[ ] ReportStatus("Verify Closed Account availability in From Account list",FAIL,"Closed investing account {sClosedAccount} is available in From Account list for entering transaction")
				[ ] 
			[ ] 
			[ ] wEnterTransaction.Close()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select Account from account bar ", FAIL, "Account is not selected")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] // ###########################################################################
[ ] 
[+] // #############Separate Investing account In Enter Transaction ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_InvestingSeparateAccountInTransaction()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Separate Investing account name should get displayed account list  at the time of entering the transaction.
		[ ] // Separate Investing  account name should  get displayed in the From drop down menu of Buy-shares Bought transaction dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If separate investing account is available in Enter Transaction window  							
		[ ] // 						Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Mar 28, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test23_InvestingSeparateAccountInTransaction () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] sAccount = "Brokerage 01 Account"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Separate Investing Account
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_SEPARATE)
		[+] if (iSelect == PASS)
			[ ] 
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] sleep(SHORT_SLEEP)
			[ ] // Click on Enter Transaction Button
			[ ] QuickenWindow.SetActive ()
			[ ] BrokerageAccount.EnterTransactions.Click()
			[ ] wEnterTransaction.EnterTransaction.TypeKeys("<Alt-g>")
			[ ] wEnterTransaction.UseCashForThisTransaction.Select("#2")
			[ ] //Find Separate Account Name 
			[+] if(wEnterTransaction.FromAccountList.FindItem(sAccount)>0)
				[ ] ReportStatus("Verify Separate Account availability in From Account list",PASS,"Separate investing account {sAccount} is available in From Account list for entering transaction")
			[+] else
				[ ] ReportStatus("Verify Separate Account availability in From Account list",FAIL,"Separate investing account {sAccount} is not available in From Account list for entering transaction")
				[ ] 
			[ ] 
			[ ] wEnterTransaction.Close()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select Account from account bar ", FAIL, "Account is not selected")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] // ###########################################################################
[ ] 
[+] //############# Close Brokerage account having linked checking account ##############
	[ ] // ********************************************************
	[+] // TestCase Name:Test20_CloseLinkedBrokerageInvestingAcc()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify closing of brokerage account having linked checking account with it.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If linked investing account successfully closed				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mar 29, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test20_CloseLinkedBrokerageInvestingAcc() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iSelect,iValidate
		[ ] STRING sAccountType,sStatementEndingDate,sSearch
		[ ] BOOLEAN bFlag = FALSE
		[ ] sAccount = "Brokerage 05 Account"
		[ ] sSearch = "Balance Offset Tx"
		[ ] sStatementEndingDate= sDateStamp 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Edit Investing Account to link with checking account
		[ ] iNavigate = NavigateToAccountDetailsTab(ACCOUNT_INVESTING,sAccount,"General")			// Select investing account
		[+] if (iNavigate == PASS)
			[+] if(AccountDetails.ShowCashInACheckingAccount.Exists(SHORT_SLEEP))
				[ ] AccountDetails.ShowCashInACheckingAccount.Select("Yes")
				[ ] ReportStatus("Link investing account with checking account", PASS, "Linked investing account with checking account")
				[ ] AccountDetails.OK.Click()
				[ ] 
				[ ] // Edit Investing Account
				[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_INVESTING,sAccount,sTab)			// Select  Investing account
				[+] if (iSelect == PASS)
					[ ] 
					[ ] // Check "Close Account" button
					[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
						[ ] AccountDetails.CloseAccount.Click()
						[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
							[ ] ReportStatus("Check Permanently Close Account window", PASS, "Permanently Close Account window is available")
							[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
							[ ] PermanentlyCloseAccount.OK.Click()
							[ ] AccountDetails.Close()
							[ ] ReportStatus("Close investing account linked with checking account", PASS, "Investing account linked with checking account is closed")
							[ ] 
							[ ] // Verify offset entry
							[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	// select checking account
							[+] if(iSelect==PASS)
								[ ] ReportStatus("Select Closed Banking Account", iSelect, "Closed Linked Banking Account is selected") 
								[ ] 
								[ ] iValidate = FindTransaction(sWindowType,sSearch,ACCOUNT_BANKING)		// find transaction
								[+] if(iValidate == PASS)
									[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found in linked banking account") 
								[+] else
									[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not find in linked banking account") 
								[ ] 
							[+] else
								[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
								[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Check Permanently Close Account window", FAIL, "Permanently Close Account window is not available")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Check Close Account button", FAIL, "Close button is not available")
						[ ] 
				[+] else
					[ ] ReportStatus("Validate Account Details window", FAIL, "Navigation to Account Details Window is failed")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Link investing account with checking account", FAIL, "Show cash in checking account radio list is not available")
				[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Close Investing account with Negative Balance #######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test28_CloseInvestingAccWithNegativeBalance()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Investing account with -ve  balance should not get closed.
		[ ] //Account should not get closed  & Quicken should display message box that "This account has securities balances,please clear the  securities  before you close the account.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If message is displayed					
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mar  29, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test28_CloseInvestingAccWithNegativeBalance () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] LIST of STRING lsTransactionData
		[ ] STRING sActualMessage,sExpectedMessage
		[ ] sAccount="Brokerage 04 Account"
		[ ] sExpectedMessage="This account has securities balances, please clear the securities before you close the account."
		[ ] lsTransactionData={"MDI","Buy","",sAccount,sDateStamp,"Intu","10","50","25"}
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)
		[+] // if (iSelect == PASS)
			[ ] // iAddTransaction= AddBrokerageTransaction(lsTransactionData)
			[ ] // ReportStatus("Add Transaction", iAddTransaction, "Transaction is added to investing account") 
		[ ] 
		[ ] 
		[ ] // Edit Investing Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_INVESTING,sAccount,sTab)			// Select first Investing account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] // Check "Close Account" button
			[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
				[ ] AccountDetails.CloseAccount.Click()
				[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Check Permanently Close Account window", PASS, "Permanently Close Account window is not available")
					[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
					[ ] PermanentlyCloseAccount.OK.Click()
					[ ]  AccountDetails.Close()
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
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# Close 401(k) account and verify menu item #########################
	[ ] // ********************************************************
	[+] // TestCase Name:Test26_Close401kInvestingAcc()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify at Update 401(K) Holding  menu item should be in disabled state.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Update 401(K) Holding  menu item should be in disabled state for closed 401(k) investing account				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Apr 2, 2013	Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test26_Close401kInvestingAcc() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sAccountType,sStatementEndingDate,sEmployerName
		[ ] 
		[ ] sAccount = "401k Account"
		[ ] sEmployerName="PSL"
		[ ] sAccountType="401(k) or 403(b)"
		[ ] sStatementEndingDate= ModifyDate(-5,sDateFormate) 
		[ ] 
	[ ] 
	[-] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Add Investment Accounts
		[ ] // iAddAccount = AddManual401KAccount(sAccountType,sAccount,sEmployerName,sStatementEndingDate)
		[ ] // ReportStatus("Add 401 (k) Investing Account", iAddAccount, "Investing Account -  {sAccount} is created successfully")
		[ ] 
		[ ] // Edit 401 (k) Investing  Account
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)		// Select saving account 
		[-] if (iSelect == PASS)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] NavigateToAccountActionInvesting(3)           // as Update 401(K) Holding  menu item is available at 3rd location
			[ ] 
			[ ] 
			[ ] // Verify Update401K403B window
			[-] if(DlgUpdate401K403BAccount.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Update 401(K) Holding  menu item", PASS, "Update 401(K) Holding  menu item is available in Account Actions for {sAccount}")
				[ ] DlgUpdate401K403BAccount.Close()
				[ ] 
				[ ] iValidate= CloseAccount(ACCOUNT_INVESTING,sAccount)
				[-] if(iValidate==PASS)
					[ ] ReportStatus("Close account {sAccount}",iValidate,"Account {sAccount} is closed")
					[ ] sleep(SHORT_SLEEP)
					[ ] SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)
					[ ] QuickenWindow.SetActive()
					[ ] NavigateToAccountActionInvesting(3)  // as Update 401(K) Holding  menu item is available at 3rd location
					[-] if(!AccountDetails.Exists(SHORT_SLEEP))
						[-] if(!Update401KAccountHoldings.Exists(SHORT_SLEEP))
							[ ] ReportStatus("Verify Update 401(K) Holding  menu item for closed 401 k Investing account", PASS, "Update 401(K) Holding  menu item is not enable in Account Actions for closed {sAccount}")
						[+] else
							[ ] ReportStatus("Verify Update 401(K) Holding  menu item for closed 401 k Investing account", FAIL, "Update 401(K) Holding  menu item is enable in Account Actions for closed {sAccount} as Update401K403BAccount window is available")
					[+] if(wEnterTransaction.Exists(SHORT_SLEEP))
						[ ] wEnterTransaction.SetActive()
						[ ] wEnterTransaction.Close()
					[ ] 
				[+] else
					[ ] ReportStatus("Close account {sAccount}",FAIL,"Account {sAccount} is not closed")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Update 401(K) Holding  menu item", FAIL, "Update 401(K) Holding  menu item is not available in Account Actions for {sAccount}")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "Investing Account is not selected from Account bar")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] // //############# Verify disabling of menu item for closed Investing accounts #############
	[ ] // // ********************************************************
	[+] // // TestCase Name:Test26_Close401kInvestingAcc()
		[ ] // //
		[ ] // // DESCRIPTION:
		[+] // // This testcase will Verify disabling of menu item for closed Investing accounts.
			[ ] // // Following menu item should be in disabled state for closed account:                                                                                    
			[ ] // //1. Account actions -> set up download
			[ ] // //2.Account actions -> update quotes only
			[ ] // //3.Account actions -> reconcile
			[ ] // //4.Account actions -> Account overview -> Holdings snap -> get online quotes
			[ ] // //5. Account actions -> Account overview -> Account status snap -> reconcile this account. 
			[ ] // //6. Account actions -> account overview -> Account Attributes -> Quicken Bill Pay Link
			[ ] // 
			[ ] // //Download Transactions tab (C2R):
			[ ] // //7. Set up download button
			[ ] // //8. Set up online payment button
			[ ] // //9. 'Enter your financial institute name' text box
		[ ] // 
		[ ] // 
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If menu item for closed Investing accounts should be in disabled state			
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Apr 2, 2013	Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase Test27_VerifyMenuItemsCloseInvestingAcc() appstate none
	[ ] // 
	[+] // // Variable declaration
		[ ] // INTEGER iAddTransaction,j,iCount,iClose
		[ ] // STRING sStatementEndingDate,sExpected
		[ ] // BOOLEAN bState
		[ ] // sAccount = "Brokerage 04"
		[ ] // sStatementEndingDate= ModifyDate(-5) 
		[ ] // // LIST OF LIST OF STRING lsTransactionData={{"MDI","Buy","",sAccount,sDateStamp,"Intu","1","50","0"},{"MDI","Sell","",sAccount,sDateStamp,"Intu","2","50","0"}}
		[ ] // LIST OF LIST OF STRING lsTransactionData={{"MDI","Intu",ACCOUNT_INVESTING},{"MDI","Goog",ACCOUNT_INVESTING}}
		[ ] // sExpected="Activate Quicken Bill Pay"
	[ ] // 
	[+] // if(QuickenMainWindow.Exists(SHORT_SLEEP))
		[ ] // QuickenMainWindow.SetActive ()
		[ ] // 
		[ ] // 
		[ ] // //Click on Investing  Account
		[ ] // iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)		// Select investing account 
		[+] // if (iSelect == PASS)
			[ ] // 
			[ ] // //Delete transaction to make balance zero
			[+] // for(j=1;j<=2;j++)
				[ ] // //Add Buy/Sell Transaction to account
				[ ] // iAddTransaction= DeleteTransaction(lsTransactionData[j][1],lsTransactionData[j][2],lsTransactionData[j][3])
				[ ] // ReportStatus("Delete Transaction", iAddTransaction, "Transaction is deleted from investing account") 
			[ ] // 
			[+] // // Verification before closing the account
				[ ] // QuickenMainWindow.SetActive()
				[ ] // // Verify Account actions -> set up download
				[ ] // NavigateToAccountAction(2)
				[+] // if(DlgActivateOneStepUpdate.Exists(SHORT_SLEEP))
					[ ] // ReportStatus("Verify Activate One Step Update window", PASS, "Setup Online option is available in Account Actions for {sAccount} before closing it")
					[ ] // DlgActivateOneStepUpdate.Close()
				[+] // else
					[ ] // ReportStatus("Verify Activate One Step Update window", FAIL, "Setup Online option is not available in Account Actions for {sAccount} before closing it")
					[ ] // 
				[ ] // 
				[ ] // // Account actions -> Update Quotes only
				[ ] // NavigateToAccountAction(3)
				[ ] // WaitForState(QuickenUpdateStatus,TRUE,8)
				[+] // if(QuickenUpdateStatus.Exists(SHORT_SLEEP))
					[ ] // ReportStatus("Verify Quicken Update Status window", PASS, "Update Quotes only is available in Account Actions for {sAccount} before closing it")
				[+] // else
					[ ] // 
				[ ] // 
				[ ] // WaitForState(QuickenMainWindow,TRUE,10)
				[ ] // // Account actions -> Reconcile
				[ ] // NavigateToAccountAction(6)
				[+] // if(DlgReconcile.Exists(SHORT_SLEEP))
					[ ] // ReportStatus("Verify Reconcile {sAccount} window", PASS, "Reconcile {sAccount} is available in Account Actions for {sAccount} before closing it")
					[ ] // DlgReconcile.Close()
				[+] // else
					[ ] // ReportStatus("Verify Reconcile {sAccount} window", FAIL, "Reconcile {sAccount} is not available in Account Actions for {sAccount} before closing it")
					[ ] // 
				[ ] // 
				[ ] // //Account actions -> Account Overview -> Holdings snap -> Get Online Quotes
				[ ] // NavigateToAccountAction(12)
				[+] // if(DlgAccountOverview.Exists(SHORT_SLEEP))
					[ ] // ReportStatus("Verify Account Overview window", PASS, "Account Overview is available in Account Actions for {sAccount} before closing it")
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame1.Frame1.OptionsButton.Click()
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame1.Frame1.OptionsButton.TypeKeys(KEY_DN)
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame1.Frame1.OptionsButton.TypeKeys(KEY_DN)
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame1.Frame1.OptionsButton.TypeKeys(KEY_DN)
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame1.Frame1.OptionsButton.TypeKeys(KEY_ENTER)
					[ ] // WaitForState(QuickenUpdateStatus,TRUE,8)
					[+] // if(QuickenUpdateStatus.Exists(SHORT_SLEEP))
						[ ] // ReportStatus("Verify Quicken Update Status window", PASS, "Update Quotes only is available in Account actions -> Account Overview -> Holdings snap -> Get Online Quotes for {sAccount} before closing it")
					[+] // else
						[ ] // 
					[ ] // WaitForState(DlgAccountOverview,TRUE,5)
					[ ] // DlgAccountOverview.Close()
				[+] // else
					[ ] // ReportStatus("Verify Account Overview window", FAIL, "Account Overview is not available in Account Actions for {sAccount} before closing it")
					[ ] // 
				[ ] // 
				[ ] // 
				[ ] // //Account actions -> Account overview -> Account status snap -> reconcile this account. 
				[ ] // NavigateToAccountAction(12)
				[+] // if(DlgAccountOverview.Exists(SHORT_SLEEP))
					[ ] // ReportStatus("Verify Account Overview window", PASS, "Account Overview is available in Account Actions for {sAccount} before closing it")
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame2.Frame2.OptionsButton.Click()
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame2.Frame2.OptionsButton.TypeKeys(KEY_DN)
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame2.Frame2.OptionsButton.TypeKeys(KEY_ENTER)
					[ ] // WaitForState(QuickenUpdateStatus,TRUE,5)
					[+] // if(DlgReconcile.Exists(SHORT_SLEEP))
						[ ] // ReportStatus("Verify Reconcile {sAccount} window", PASS, "Reconcile {sAccount} is available in Account actions -> Account overview -> Account status snap -> reconcile this account for {sAccount} before closing it")
						[ ] // DlgReconcile.Close()
					[+] // else
						[ ] // ReportStatus("Verify Reconcile {sAccount} window", FAIL, "Reconcile {sAccount} is not available in Account actions -> Account overview -> Account status snap -> reconcile this account for {sAccount} before closing it")
						[ ] // 
					[ ] // DlgAccountOverview.Close()
				[+] // else
					[ ] // ReportStatus("Verify Account Overview window", FAIL, "Account Overview is not available in Account Actions for {sAccount} before closing it")
					[ ] // 
				[ ] // 
				[ ] // //Account actions -> account overview -> Account Attributes -> Quicken Bill Pay Link
				[ ] // NavigateToAccountAction(12)
				[+] // if(DlgAccountOverview.Exists(SHORT_SLEEP))
					[ ] // ReportStatus("Verify Account Overview window", PASS, "Account Overview is available in Account Actions for {sAccount} before closing it")
					[ ] // iCount=DlgAccountOverview.AccountStatusFrame.Frame3.QWListViewer.ListBox.GetItemCount()
					[ ] // sHandle=Str(DlgAccountOverview.AccountStatusFrame.Frame3.QWListViewer.ListBox.GetHandle())
					[+] // for(i=iCount;i>=1;i--)
						[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
						[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
						[+] // if(bMatch == TRUE)
							[ ] // ReportStatus("Validate Activate Quicken Bill Pay link", PASS, "Activate Quicken Bill Pay is available in Account actions -> account overview -> Account Attributes") 
							[ ] // break
						[+] // else
							[ ] // continue
							[+] // if(i==1)
								[ ] // ReportStatus("Validate Activate Quicken Bill Pay link", FAIL, "Activate Quicken Bill Pay is not available in Account actions -> account overview -> Account Attributes") 
					[ ] // DlgAccountOverview.Close()
				[+] // else
					[ ] // ReportStatus("Verify Account Overview window", FAIL, "Account Overview is not available in Account Actions for {sAccount} before closing it")
					[ ] // 
				[ ] // 
				[ ] // // Download Transactions tab (C2R) > Set up download button 
				[ ] // bState=BrokerageAccount.wTransaction.SetUpDownload.IsEnabled()
				[+] // if(bState==TRUE)
					[ ] // ReportStatus("Verify Set up download button is enabled", PASS, "Set up download button is enaled for {sAccount} before closing it")
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Set up download button is enabled", FAIL, "Set up download button is not enaled for {sAccount} before closing it")
					[ ] // 
				[ ] // 
				[ ] // // Download Transactions tab (C2R) > Set up online payment button
				[ ] // bState=BrokerageAccount.wTransaction.SetUpOnlinePayment.IsEnabled()
				[+] // if(bState==TRUE)
					[ ] // ReportStatus("Verify Set up online payment button is enabled", PASS, "Set up online payment button is enaled for {sAccount} before closing it")
				[+] // else
					[ ] // ReportStatus("Verify Set up online payment button is enabled", FAIL, "Set up online payment button is not enaled for {sAccount} before closing it")
				[ ] // 
				[ ] // // Download Transactions tab (C2R) > 'Enter your financial institute name' text box
				[ ] // C2RReminders.QWSnapHolder1.StaticText1.StaticText2.EnterFINameTextField.SetText("Enabled")
				[ ] // bState=C2RReminders.QWSnapHolder1.StaticText1.StaticText2.AddReminderButton.IsEnabled()
				[+] // if(bState==TRUE)
					[ ] // ReportStatus("Verify Enter FI Name Text Field is enabled", PASS, "Enter FI Name Text Field is enabled for {sAccount} before closing it")
				[+] // else
					[ ] // ReportStatus("Verify Enter FI Name Text Field is enabled", FAIL, "Enter FI Name Text Field is not enabled for {sAccount} before closing it")
			[ ] // 
			[ ] // // Close the investing account
			[ ] // iClose=CloseAccount(ACCOUNT_INVESTING,sAccount,3)
			[+] // if(iClose==PASS)
				[ ] // ReportStatus("Close account {sAccount}",PASS,"{sAccount} closed successfully")
			[+] // else
				[ ] // ReportStatus("Close account {sAccount}",FAIL,"{sAccount} is not closed")
				[ ] // 
			[ ] // 
			[+] // // Verification after closing the account
				[ ] // QuickenMainWindow.SetActive()
				[ ] // //Verify Account actions -> set up download
				[ ] // NavigateToAccountAction(2)
				[+] // if(!DlgActivateOneStepUpdate.Exists(SHORT_SLEEP))
					[ ] // ReportStatus("Verify Activate One Step Update window", PASS, "Setup Online option is not available in Account Actions for {sAccount} after closing it")
				[+] // else
					[ ] // ReportStatus("Verify Activate One Step Update window", FAIL, "Setup Online option is available in Account Actions for {sAccount} after closing it")
					[ ] // DlgActivateOneStepUpdate.Close()
					[ ] // 
				[ ] // 
				[ ] // // Account actions -> Update Quotes only
				[ ] // NavigateToAccountAction(3)
				[ ] // WaitForState(QuickenUpdateStatus,TRUE,8)
				[+] // if(!QuickenUpdateStatus.Exists(SHORT_SLEEP))
					[ ] // ReportStatus("Verify Quicken Update Status window", PASS, "Update Quotes only is not available in Account Actions for {sAccount} after closing it")
				[+] // else
					[ ] // 
				[ ] // 
				[ ] // WaitForState(QuickenMainWindow,TRUE,10)
				[ ] // //Account actions -> Reconcile
				[ ] // NavigateToAccountAction(6)
				[+] // if(!DlgReconcile.Exists(SHORT_SLEEP))
					[ ] // ReportStatus("Verify Reconcile {sAccount} window", PASS, "Reconcile {sAccount} is not available in Account Actions for {sAccount} after closing it")
				[+] // else
					[ ] // ReportStatus("Verify Reconcile {sAccount} window", FAIL, "Reconcile {sAccount} is available in Account Actions for {sAccount} after closing it")
					[ ] // DlgReconcile.Close()
					[ ] // 
				[ ] // 
				[ ] // //Account actions -> Account Overview -> Holdings snap -> Get Online Quotes
				[ ] // NavigateToAccountAction(13)
				[+] // if(DlgAccountOverview.Exists(SHORT_SLEEP))
					[ ] // ReportStatus("Verify Account Overview window", PASS, "Account Overview is available in Account Actions for {sAccount} before closing it")
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame1.Frame1.OptionsButton.Click()
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame1.Frame1.OptionsButton.TypeKeys(KEY_DN)
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame1.Frame1.OptionsButton.TypeKeys(KEY_DN)
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame1.Frame1.OptionsButton.TypeKeys(KEY_DN)
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame1.Frame1.OptionsButton.TypeKeys(KEY_ENTER)
					[ ] // WaitForState(QuickenUpdateStatus,TRUE,8)
					[+] // if(!QuickenUpdateStatus.Exists(SHORT_SLEEP))
						[ ] // ReportStatus("Verify Quicken Update Status window", PASS, "Update Quotes only is not available in Account actions -> Account Overview -> Holdings snap -> Get Online Quotes for {sAccount} after closing it")
					[+] // else
						[ ] // 
					[ ] // WaitForState(DlgAccountOverview,TRUE,5)
					[ ] // DlgAccountOverview.Close()
				[+] // else
					[ ] // ReportStatus("Verify Account Overview window", FAIL, "Account Overview is not available in Account Actions for {sAccount} before closing it")
					[ ] // 
				[ ] // 
				[ ] // 
				[ ] // //Account actions -> Account overview -> Account status snap -> reconcile this account. 
				[ ] // NavigateToAccountAction(13)
				[+] // if(DlgAccountOverview.Exists(SHORT_SLEEP))
					[ ] // ReportStatus("Verify Account Overview window", PASS, "Account Overview is available in Account Actions for {sAccount} before closing it")
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame2.Frame2.OptionsButton.Click()
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame2.Frame2.OptionsButton.TypeKeys(KEY_DN)
					[ ] // DlgAccountOverview.AccountStatusFrame.Frame2.Frame2.OptionsButton.TypeKeys(KEY_ENTER)
					[+] // if(!DlgReconcile.Exists(SHORT_SLEEP))
						[ ] // ReportStatus("Verify Reconcile {sAccount} window", PASS, "Reconcile {sAccount} is not available in Account actions -> Account overview -> Account status snap -> reconcile this account for {sAccount} after closing it")
					[+] // else
						[ ] // ReportStatus("Verify Reconcile {sAccount} window", FAIL, "Reconcile {sAccount} is available in Account actions -> Account overview -> Account status snap -> reconcile this account for {sAccount} after closing it")
						[ ] // DlgReconcile.Close()
						[ ] // 
					[ ] // DlgAccountOverview.Close()
				[+] // else
					[ ] // ReportStatus("Verify Account Overview window", FAIL, "Account Overview is not available in Account Actions for {sAccount} before closing it")
					[ ] // 
				[ ] // 
				[ ] // //Account actions -> account overview -> Account Attributes -> Quicken Bill Pay Link
				[ ] // NavigateToAccountAction(13)
				[+] // if(DlgAccountOverview.Exists(SHORT_SLEEP))
					[ ] // ReportStatus("Verify Account Overview window", PASS, "Account Overview is available in Account Actions for {sAccount} before closing it")
					[ ] // iCount=DlgAccountOverview.AccountStatusFrame.Frame3.QWListViewer.ListBox.GetItemCount()
					[ ] // sHandle=Str(DlgAccountOverview.AccountStatusFrame.Frame3.QWListViewer.ListBox.GetHandle())
					[+] // for(i=iCount;i>=1;i--)
						[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
						[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
						[+] // if(bMatch == TRUE)
							[ ] // ReportStatus("Validate Activate Quicken Bill Pay link", FAIL, "Activate Quicken Bill Pay is not available in Account actions -> account overview -> Account Attributes after closing the account") 
							[ ] // break
						[+] // else
							[+] // if(i==1)
								[ ] // ReportStatus("Validate Activate Quicken Bill Pay link", PASS, "Activate Quicken Bill Pay is not available in Account actions -> account overview -> Account Attributes after closing the account") 
							[ ] // continue
					[ ] // DlgAccountOverview.Close()
				[+] // else
					[ ] // ReportStatus("Verify Account Overview window", FAIL, "Account Overview is not available in Account Actions for {sAccount} before closing it")
					[ ] // 
				[ ] // 
				[ ] // // Download Transactions tab (C2R) > Set up download button 
				[+] // if(BrokerageAccount.wTransaction.SetUpDownload.Exists(SHORT_SLEEP))
					[ ] // bState=BrokerageAccount.wTransaction.SetUpDownload.IsEnabled()
					[+] // if(bState==FALSE)
						[ ] // ReportStatus("Verify Set up download button is disabled", PASS, "Set up download button is disabled for {sAccount} after closing it")
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Set up download button is disabled", FAIL, "Set up download button is not enaled for {sAccount} after closing it")
						[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Set up download button is available", PASS, "Set up download button is not available for {sAccount} after closing it")
					[ ] // 
				[ ] // 
				[ ] // // Download Transactions tab (C2R) > Set up online payment button
				[ ] // bState=BrokerageAccount.wTransaction.SetUpOnlinePayment.IsEnabled()
				[+] // if(bState==FALSE)
					[ ] // ReportStatus("Verify Set up online payment button is disabled", PASS, "Set up online payment button is disabled for {sAccount} after closing it")
				[+] // else
					[ ] // ReportStatus("Verify Set up online payment button is disabled", FAIL, "Set up online payment button is not disabled for {sAccount} after closing it")
				[ ] // 
				[ ] // // Download Transactions tab (C2R) > 'Enter your financial institute name' text box
				[ ] // C2RReminders.QWSnapHolder1.StaticText1.StaticText2.EnterFINameTextField.SetText("Enabled")
				[ ] // bState=C2RReminders.QWSnapHolder1.StaticText1.StaticText2.AddReminderButton.IsEnabled()
				[+] // if(bState==FALSE)
					[ ] // ReportStatus("Verify Enter FI Name Text Field is disabled", PASS, "Enter FI Name Text Field is disabled for {sAccount} after closing it")
				[+] // else
					[ ] // ReportStatus("Verify Enter FI Name Text Field is disabled", FAIL, "Enter FI Name Text Field is not disabled for {sAccount} after closing it")
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate Account selection", FAIL, "Investing Account is not selected from Account bar")
			[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] // 
	[ ] // 
[ ] // //###########################################################################
[ ] 
[+] //#############Verify Close investment account in OSU ############################
	[ ] //********************************************************
	[+] //TestCase Name:	 Test19_CloseInvestingAccVerificationOSU()
		[ ] 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that closed investment account should not get included in the OSU.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:	          Pass 	If investing account closed successfully and not available in OSU window
		[ ] // 				Fail     If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // /April 02 ,2013	             Anagha Bhandare created
	[ ] //********************************************************
	[ ] 
[+] testcase Test19_CloseInvestingAccVerificationOSU() appstate none
	[+] // Variable declaration and definition
		[ ] string sFIName,sInput
		[ ] LIST OF STRING lsTransactionData
		[ ] sAccountId="quickenqa"
		[ ] sAccPassword = "Zags2010"
		[ ] sAccountName = "Investment XX0459"
		[ ] sFIName = "T. Rowe Price"
		[ ] sAccountType ="Brokerage"
		[ ] sWindowType = "MDI"
		[ ] sInput = "Prime Reserve"
		[ ] 
		[ ] lsTransactionData={sWindowType,sInput}
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ]  
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Creating Online Brokerage Account
		[ ] // //iResult=AddCCMintBankAccount(sAccountId,sAccPassword,sAccountType,sFIName)
		[ ] // 
		[+] // if/(iResult==PASS)
			[ ] 
			[ ] ReportStatus("Verify Brokerage Online Account",PASS,"Brokerage Online Account is created successfully")
			[ ] 
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] //Checking before Closing the Account whether the FI is listed in One Step Update
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.OneStepUpdate.Select()
			[ ] 
			[ ] WaitForState(OneStepUpdate,true,2)
			[ ] 
			[+] if(OneStepUpdate.Exists(SHORT_SLEEP))
				[ ] 
				[ ] ReportStatus("Verify One Step Update Window",PASS,"One Step Update Window is displayed")
				[ ] 
				[ ] sHandle = Str(OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetHandle())
				[+] for(iCounter=0;iCounter<OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetItemCount();iCounter++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}")
					[ ] bMatch = MatchStr("*{sFIName}*",sActual)
					[+] if(bMatch == TRUE)
						[ ] break
						[ ] 
				[+] if(bMatch == TRUE)
					[ ] 
					[ ] ReportStatus("Verify FI name is listed in the One Step Update Window before closing Online Account ", PASS, "{sFIName}  is listed in the One Step Update Window before closing Online Account")
				[+] else
					[ ] ReportStatus("Verify FI name is listed in the One Step Update Window before closing Online Account ", FAIL, "{sFIName}  is not listed in the One Step Update Window before closing Online Account")
				[ ] 
				[ ] OneStepUpdate.Close()
				[ ] 
				[ ] //Closing the Online Banking Account
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] iResult = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)		// Select investing account 
				[ ] 
				[ ] //WaitForState(BankingMDI,true,2)
				[ ] 
				[+] if(iResult==PASS)
					[ ] 
					[ ] //Delete transaction to make balance zero
					[+] for(iCounter=1;iCounter<=3;iCounter++)
						[ ] 
						[ ] //Add Buy/Sell Transaction to account
						[ ] iAddTransaction= DeleteTransaction(lsTransactionData[1],lsTransactionData[2],ACCOUNT_INVESTING)
						[ ]  
						[+] if(iAddTransaction==PASS)
							[ ] 
							[ ] ReportStatus("Delete Transaction", iAddTransaction, "Transaction is deleted from investing account")
							[ ] 
						[+] else
							[ ] ReportStatus("Delete Transaction", iAddTransaction, "Transaction is not deleted from investing account")
							[ ] 
						[ ] 
					[ ] iResult=CloseAccount(ACCOUNT_INVESTING,sAccountName)
					[ ] 
					[+] if(iResult==PASS)
						[ ] 
						[ ] ReportStatus("Closing checking account", PASS,"{sAccountName} account closed successfully.")
						[ ] 
						[ ] //Checking after Closing the Accounts whether the FI is listed in One Step Update
						[ ] 
						[ ] NavigateQuickenTab(sTAB_HOME)
						[ ] 
						[ ] QuickenWindow.Tools.OneStepUpdate.Select()
						[ ] 
						[ ] sHandle = Str(OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetHandle())
						[ ] 
						[+] for(iCounter=0;iCounter<OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetItemCount();iCounter++)
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}")
							[ ] bMatch = MatchStr("*{sFIName}*",sActual)
							[+] if(bMatch == FALSE)
								[ ] break
						[ ] 
						[+] if(bMatch == FALSE)
							[ ] ReportStatus("Verify FI name is listed in the One Step Update Window after closing Online Account ", PASS, "{sFIName}  is not listed in the One Step Update Window after closing Online Account")
						[+] else
							[ ] ReportStatus("Verify FI name is listed in the One Step Update Window after closing Online Account ", FAIL, "{sFIName}  is listed in the One Step Update Window after closing Online Account")
						[ ] 
						[ ] OneStepUpdate.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Closing checking account", FAIL,"{sAccountName} account not closed successfully.")
						[ ] 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Brokerage Online Account selected",FAIL,"Brokerage Online Account is not selected")
			[+] else
				[ ] ReportStatus("Verify One Step Update Window",FAIL,"One Step Update Window is not displayed")
		[+] // else
			[ ] // ReportStatus("Verify Brokerage Online Account",FAIL,"Brokerage Online Account is not created successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify separate investment account in OSU ##########################
	[ ] //********************************************************
	[+] //TestCase Name:	 Test21_SeparateInvestingAccVerificationOSU()
		[ ] 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that separate investment account should get included in the OSU.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 		If investing account separated successfully and available in OSU window					
		[ ] // 					        Fail	          If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // /April 02 ,2013	             Anagha Bhandare created
	[ ] //********************************************************
[+] testcase Test21_SeparateInvestingAccVerificationOSU() appstate none
	[+] // Variable declaration and definition
		[ ] string sFIName
		[ ] 
		[ ] sAccountId="quickenqa"
		[ ] sAccPassword = "Zags2010"
		[ ] sAccountName = "Investment XX0459"
		[ ] sFIName = "T. Rowe Price"
		[ ] sAccountType ="Brokerage"
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] //Deleting the Account is Closed previously
		[ ] iResult = DeleteAccount(ACCOUNT_INVESTING,sAccountName)
		[ ] 
		[+] if(iResult == PASS)
			[ ] 
			[ ] ReportStatus("Verify Closed Account is deleted ",PASS,"Closed Account is deleted successfully")
			[ ] 
			[ ] //Creating Online Brokerage Account
			[ ] iResult=AddCCMintBankAccount(sAccountId,sAccPassword,sAccountType,sFIName)
			[ ] 
			[+] if(iResult == PASS)
				[ ] 
				[ ] ReportStatus("Verify Brokerage Online Account",PASS,"Brokerage Online Account is created successfully")
				[ ] 
				[ ] //Checking before Separating the Accounts whether the FI is listed in One Step Update
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Tools.Click()
				[ ] QuickenWindow.Tools.OneStepUpdate.Select()
				[ ] 
				[ ] WaitForState(OneStepUpdate,true,2)
				[ ] 
				[+] if(OneStepUpdate.Exists(SHORT_SLEEP))
					[ ] 
					[ ] ReportStatus("Verify One Step Update Window",PASS,"One Step Update Window is displayed")
					[ ] 
					[ ] sHandle = Str(OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetHandle())
					[ ] 
					[+] for(iCounter=0;iCounter<OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetItemCount();iCounter++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}")
						[ ] bMatch = MatchStr("*{sFIName}*",sActual)
						[+] if(bMatch == TRUE)
							[ ] break
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Verify FI name is listed in the One Step Update Window before closing Online Account ", PASS, "{sFIName}  is listed in the One Step Update Window before closing Online Account")
					[+] else
						[ ] ReportStatus("Verify FI name is listed in the One Step Update Window before closing Online Account ", FAIL, "{sFIName}  is not listed in the One Step Update Window before closing Online Account")
					[ ] 
					[ ] OneStepUpdate.Close()
					[ ] 
					[ ] //Closing the Online Banking Account
					[ ] NavigateQuickenTab(sTAB_HOME)
					[ ] 
					[ ] iResult=SeparateAccount(ACCOUNT_INVESTING,sAccountName)
					[ ] 
					[+] if(iResult==PASS)
						[ ] 
						[ ] //Checking after Separating the Accounts whether the FI is listed in One Step Update
						[ ] 
						[ ] ReportStatus("Separating brokerage account", PASS,"{sAccountName} account separated successfully.")
						[ ] 
						[ ] NavigateQuickenTab(sTAB_HOME)
						[ ] 
						[ ] QuickenWindow.Tools.OneStepUpdate.Select()
						[ ] 
						[ ] sHandle = Str(OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetHandle())
						[+] for(iCounter=0;iCounter<OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetItemCount();iCounter++)
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}")
							[ ] bMatch = MatchStr("*{sFIName}*",sActual)
							[+] if(bMatch == TRUE)
								[ ] break
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Verify FI name is listed in the One Step Update Window before closing Online Account ", PASS, "{sFIName}  is listed in the One Step Update Window before closing Online Account")
						[+] else
							[ ] ReportStatus("Verify FI name is listed in the One Step Update Window before closing Online Account ", FAIL, "{sFIName}  is not listed in the One Step Update Window before closing Online Account")
					[+] else
						[ ] ReportStatus("Separating brokerage account", FAIL,"{sAccountName} account not separated successfully.")
				[ ] 
				[+] else
					[ ] ReportStatus("Verify One Step Update Window",FAIL,"One Step Update Window is not displayed")
					[ ] 
				[ ] OneStepUpdate.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Brokerage Online Account",FAIL,"Brokerage Online Account is not created successfully")
		[+] // else
			[ ] // ReportStatus("Verify Closed Account is deleted ",FAIL,"Closed Account is not deleted successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
	[ ] QuickenWindow.Kill()
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] //******************************************************************************************************************************************
[ ] 
[+] //#############  SetUp ######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 BillsReminders_SetUp()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will create data file and add accounts and verify hidden account behavior for Bills Reminders
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If no error occurs while creating file							
		[ ] // Fail			If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 10, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase BillsReminders_SetUp () appstate QuickenBaseState
	[ ] 
	[ ] // Variable declaration
	[ ] INTEGER iRegistration,iAddBill
	[ ] List of LIST OF STRING lsAccount
	[ ] LIST OF STRING lsBill
	[ ] 
	[ ] sFileName = "HiddenAccountReminder"
	[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
	[ ] 
	[ ] //Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive()
		[ ] 
	[+] else
		[+] if(FileExists(sDataFile) == TRUE)
			[ ] DeleteFile(sDataFile)
			[ ] 
		[ ] QuickenWindow.Start (sCmdLine)
		[ ] 
	[+] //Need to remove-----
		[ ] // lsAccount = {{"Checking","Checking 01","500", "{sDateStamp}"},{"Checking","Checking 02","200", "{sDateStamp}"},{"Checking","Checking 03","100", "{sDateStamp}"},{"Savings","Saving 01","500", "{sDateStamp}"},{"Savings","Saving 02","200", "{sDateStamp}"}}
		[+] // lsBill = {"Test Payee", "30",sDateStamp,"Checking 03"}
			[ ] 
		[ ] //Open data file
		[ ] // sCaption = QuickenWindow.GetCaption()
		[ ] // bCaption = MatchStr("*{sFileName}*", sCaption)
		[+] // if(bCaption == FALSE)
			[ ] // bExists = FileExists(sDataFile)
			[+] // if(bExists == TRUE)
				[ ] // DeleteFile(sDataFile)
				[ ] 
	[ ] 
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] //Create Data File
	[ ] iCreateDataFile = OpenDataFile(sFileName)
	[ ] //Report Staus If Data file Created successfully
	[+] if ( iCreateDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
		[ ] CloseQuickenConnectedServices()
	[+] else 
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] //Set Classic View
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[+] //Need to remove-----
		[+] // for(i=1;i<=Listcount(lsAccount);i++)
			[ ] // //Add Checking Account
			[ ] // iAddAccount = AddManualSpendingAccount(lsAccount[i][1], lsAccount[i][2], lsAccount[i][3], lsAccount[i][4])
			[ ] // //Report Status if checking Account is created
			[+] // if (iAddAccount==PASS)
				[ ] // ReportStatus("{lsAccount[i][1]} Account", iAddAccount, "{lsAccount[i][1]} Account -  {lsAccount[i][2]}  is created successfully")
			[+] // else
				[ ] // ReportStatus("{lsAccount[i][1]} Account", iAddAccount, "{lsAccount[i][1]} Account -  {lsAccount[i][2]}  is not created successfully")
		[ ] // 
		[ ] 
		[ ] // iAddBill=AddBill(lsBill[1],lsBill[2],lsBill[3],lsBill[4])
		[ ] // ReportStatus("Add Bill",iAddBill,"Bill added successfully")
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############Verify Closed checking Account in Add Bill Reminder window ############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_CloseAccountInAddBillReminder()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed account should not get displayed in the Add Bill Reminder pop up
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If banking account closed successfully and not available in Add Bill Reminder pop up				
		[ ] // Fail		If any error occurs or closed account available in Add Bill Reminder pop up
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 10, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_CloseAccountInAddBillReminder () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sSearch,sSelectedAccount,sPayeeName
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Checking 01"
		[ ] sPayeeName= "Payee1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Checking Account
		[ ] iSelect = CloseAccount(ACCOUNT_BANKING,sAccount)			// Close first checking account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] //Verify offset entry
			[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	// select account
			[+] if(iSelect==PASS)
				[ ] 
				[ ] iValidate = FindTransaction(sWindowType,sSearch)		// find transaction
				[+] if(iValidate == PASS)
					[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found in {sAccount} account") 
					[ ] ReportStatus("Select Closed Account", iSelect, "Closed Account is selected") 
					[ ] 
					[ ] //Select Home tab
					[ ] NavigateQuickenTab(sTAB_HOME)
					[ ] 
					[ ] //Navigate to Bills > Add Reminder >  Bill Reminder
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Bills.Click()
					[ ] QuickenWindow.Bills.AddReminder.DoubleClick()
					[ ] QuickenWindow.Bills.AddReminder.BillReminder.Select()
					[ ] 
					[ ] //Search closed account name in Add Bill window
					[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
						[ ] DlgAddEditReminder.Step1Panel.PayeeNameTextField.SetText (sPayeeName)
						[ ] DlgAddEditReminder.NextButton.Click()
						[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.GetText()
						[+] if (sSelectedAccount!=sAccount)
							[ ] ReportStatus("Verify closed account {sAccount} in Add Bill window", PASS, "Closed account {sAccount} is not available in Add Bill window")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify closed account {sAccount} in Add Bill window", FAIL, "Closed account {sAccount} is available in Add Bill window")
							[ ] 
						[ ] DlgAddEditReminder.Close()
					[+] else
						[ ] ReportStatus("Verify Add Bill window", FAIL, "Add Bill window is not available")
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
				[ ] 
			[+] else
				[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account is closed", iSelect, "Banking Account is not closed")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed checking Account in Add Income Reminder window ########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_CloseAccountInAddIncomeReminder()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed account should not get displayed in the Add Income Reminder pop up
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If banking account closed successfully and not available in Add Income Reminder pop up				
		[ ] // Fail		If any error occurs or closed account available in Add Income Reminder pop up
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 10, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test02_CloseAccountInAddIncomeReminder() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sSearch,sPayeeName,sSelectedAccount
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Checking 01"
		[ ] sPayeeName= "Payee1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify offset entry
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	// select account
		[+] if(iSelect==PASS)
			[ ] iValidate = FindTransaction(sWindowType,sSearch)		// find transaction
			[+] if(iValidate == PASS)
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found in {sAccount} account") 
				[ ] ReportStatus("Select Closed Account", iSelect, "Closed Account {sAccount} is selected") 
				[ ] 
				[ ] //Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[+] //Navigate to Bills > Add Reminder >  Income Reminder
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Bills.Click()
					[ ] QuickenWindow.Bills.AddReminder.DoubleClick()
					[ ] QuickenWindow.Bills.AddReminder.IncomeReminder.Select()
				[ ] 
				[ ] //Search closed account name in Add Income Reminder window
				[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
					[ ] DlgAddEditReminder.Step1Panel.PayeeNameTextField.SetText  (sPayeeName)
					[ ] DlgAddEditReminder.NextButton.Click()
					[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.GetText()
					[ ] 
					[+] if (sSelectedAccount!=sAccount)
						[ ] ReportStatus("Verify closed account {sAccount} in Add Income Reminer window", PASS, "Closed account {sAccount} is not available in Add Income Reminer window")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify closed account {sAccount} in Add Income Reminer window", FAIL, "Closed account {sAccount} is available in Add Income Reminder window")
					[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Verify Add Income Reminder window", FAIL, "Add Income Reminder window is not available")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
		[+] else
			[ ] ReportStatus("Select Closed  Account", iSelect, "Closed Account is not selected") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed checking Account in Add Transfer Reminder window ########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_CloseAccountInAddTransferReminder()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed account should not get displayed in the Add Transfer Reminder pop up
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If banking account closed successfully and not available in Add Transfer Reminder pop up				
		[ ] // Fail		If any error occurs or closed account available in Add Transfer Reminder pop up
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 11, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_CloseAccountInAddTransferReminder() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sSearch,sPayeeName,sSelectedAccount
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Checking 01"
		[ ] sPayeeName= "Payee1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify offset entry
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING) 	// select account
		[+] if(iSelect==PASS)
			[ ] iValidate = FindTransaction(sWindowType,sSearch)		// find transaction
			[+] if(iValidate == PASS)
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found in {sAccount} account")
				[ ] ReportStatus("Select Closed Account", iSelect, "Closed Account {sAccount} is selected") 
				[ ] 
				[ ] //Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[+] //Navigate to Bills > Add Reminder >  Transfer Reminder
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Bills.Click()
					[ ] QuickenWindow.Bills.AddReminder.DoubleClick()
					[ ] QuickenWindow.Bills.AddReminder.TransferReminder.Select()
				[ ] 
				[ ] //Search closed account name in Add TRansfer Reminder window
				[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
					[ ] DlgAddEditReminder.Step1Panel.PayeeNameTextField.SetText(sPayeeName)
					[ ] DlgAddEditReminder.NextButton.Click()
					[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.GetText()
					[+] if (sSelectedAccount!=sAccount)
						[ ] ReportStatus("Verify closed account {sAccount} in Add Transfer Reminer window", PASS, "Closed account {sAccount} is not available in Add Transfer Reminer window")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify closed account {sAccount} in Add Transfer Reminer window", FAIL, "Closed account {sAccount} is available in Add Transfer Reminder window")
					[ ] 
					[ ] //Verification for ToAccount
					[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.GetText()
					[ ] 
					[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Verify Add Transfer Reminder window", FAIL, "Add Transfer Reminder window is not available")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
		[+] else
			[ ] ReportStatus("Select Closed  Account", iSelect, "Closed Account is not selected") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed checking Account in Add Paycheck Reminder window ######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_CloseAccountInPaycheckReminder()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed account should not get displayed in the Add Paycheck Reminder pop up for Net Amount
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If banking account closed successfully and not available in Add Paycheck Reminder pop up				
		[ ] // Fail		If any error occurs or closed account available in Add Paycheck Reminder pop up
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 11, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test04_CloseAccountInPaycheckReminder1() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sSearch,sPayeeName,sSelectedAccount
		[ ] BOOLEAN bAssert
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Checking 01"
		[ ] sPayeeName= "Payee1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify offset entry
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	// select account
		[+] if(iSelect==PASS)
			[ ] iValidate = FindTransaction(sWindowType,sSearch)		// find transaction
			[+] if(iValidate == PASS)
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found in {sAccount} account")
				[ ] ReportStatus("Select Closed Account", iSelect, "Closed Account {sAccount} is selected") 
				[ ] 
				[ ] //Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[+] //Navigate to Bills > Add Reminder >  Paycheck Reminder
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Bills.Click()
					[ ] QuickenWindow.Bills.AddReminder.DoubleClick()
					[ ] QuickenWindow.Bills.AddReminder.PaycheckReminder.Select()
				[ ] 
				[ ] //Search closed account name in Add Paycheck Reminder window
				[+] if(PayCheckSetup.Exists(SHORT_SLEEP) == TRUE)
					[ ] PayCheckSetup.SetActive ()
					[ ] PayCheckSetup.HowMuchPaycheck.Select("Net amount")
					[ ] PayCheckSetup.Next.Click ()
					[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
						[ ] DlgAddEditReminder.Step1Panel.PayeeNameTextField.SetText(sPayeeName)
						[ ] DlgAddEditReminder.NextButton.Click()
						[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.GetText()
						[+] if (sSelectedAccount!=sAccount)
							[ ] ReportStatus("Verify closed account {sAccount} in Add Income Reminer window", PASS, "Closed account {sAccount} is not available in Add Income Reminer window")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify closed account {sAccount} in Add Income Reminer window", FAIL, "Closed account {sAccount} is available in Add Income Reminder window")
						[ ] 
						[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Verify Add Paycheck window", FAIL, "Add Paycheck window is not available")
				[ ] 
			[+] // else
				[ ] // ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
		[+] // else
			[ ] // ReportStatus("Select Closed  Account", iSelect, "Closed Account is not selected") 
			[ ] // 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed checking Account in Add Paycheck Reminder window ######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_CloseAccountInPaycheckReminder2()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed account should not get displayed in the Add Paycheck Reminder pop up for Gross Amount
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If banking account closed successfully and not available in Add Paycheck Reminder pop up				
		[ ] // Fail		If any error occurs or closed account available in Add Paycheck Reminder pop up
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 11, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test05_CloseAccountInPaycheckReminder2() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iFind
		[ ] STRING sSearch,sPayeeName,sCompany
		[ ] BOOLEAN bAssert
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Checking 01"
		[ ] sPayeeName= "Payee1"
		[ ] sCompany = "Persistent"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify offset entry
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	// select account
		[+] if(iSelect==PASS)
			[ ] iValidate = FindTransaction(sWindowType,sSearch)		// find transaction
			[+] if(iValidate == PASS)
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found in {sAccount} account") 
				[ ] ReportStatus("Select Closed Account", iSelect, "Closed Account {sAccount} is selected") 
				[ ] 
				[ ] //Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[+] //Navigate to Bills > Add Reminder >  Paycheck Reminder
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Bills.Click()
					[ ] QuickenWindow.Bills.AddReminder.DoubleClick()
				[ ] QuickenWindow.Bills.AddReminder.PaycheckReminder.Select()
				[ ] 
				[ ] //Search closed account name in Add Paycheck Reminder window
				[+] if(PayCheckSetup.Exists(SHORT_SLEEP) == TRUE)
					[ ] PayCheckSetup.SetActive ()
					[ ] PayCheckSetup.HowMuchPaycheck.Select("Gross amount")
					[ ] PayCheckSetup.Next.Click ()
					[ ] PayCheckSetup.CompanyName.SetPosition (1, 1)
					[ ] PayCheckSetup.CompanyName.SetText (sCompany)
					[ ] PayCheckSetup.Next.Click ()
					[ ] PayCheckSetup.SetActive ()
					[ ] iFind=PayCheckSetup.Account.FindItem(sAccount)
					[+] if (iFind==0)
						[ ] ReportStatus("Verify closed account {sAccount} in Paycheck Setup window", PASS, "Closed account {sAccount} is not available in Paycheck Setup window")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify closed account {sAccount} in Paycheck Setup window", FAIL, "Closed account {sAccount} is available in Paycheck Setup window - Defect id DE3981-QW1828")
					[ ] 
					[ ] PayCheckSetup.Close()
				[+] else
					[ ] ReportStatus("Verify Add Paycheck window", FAIL, "Add Paycheck window is not available")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
		[+] else
			[ ] ReportStatus("Select Closed  Account", iSelect, "Closed Account is not selected") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# Verify Separate checking Account in Add Bill Reminder window #########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_SeparateAccountInAddBillReminder()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that separate account should get displayed in the Add Bill Reminder pop up
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If banking account separated successfully and available in Add Bill Reminder pop up				
		[ ] // Fail		If any error occurs or separated account is not available in Add Bill Reminder pop up
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 12, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test06_SeparateAccountInAddBillReminder () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sTab,sPayeeName,sSelectedAccount
		[ ] sAccount="Checking 02"
		[ ] sPayeeName= "Payee1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit checking Account
		[ ] iSelect = SeparateAccount(ACCOUNT_BANKING,sAccount)			// Select  account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
			[+] if (iSeparate == PASS)
				[ ] AccountDetails.Cancel.Click()
				[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and checking account is displayed under this seaction")
				[ ] 
				[ ] //Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[+] //Navigate to Bills > Add Reminder >  Bill Reminder
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Bills.Click()
					[ ] QuickenWindow.Bills.AddReminder.DoubleClick()
					[ ] QuickenWindow.Bills.AddReminder.BillReminder.Select()
				[ ] 
				[ ] //Search separated account name in Add Bill window
				[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
					[ ] DlgAddEditReminder.Step1Panel.PayeeNameTextField.SetText(sPayeeName)
					[ ] DlgAddEditReminder.NextButton.Click()
					[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.GetText()
					[+] if (sSelectedAccount==sAccount)
						[ ] ReportStatus("Verify separated account {sAccount} in Add Bill Reminder window", PASS, "Separated account {sAccount} is available in Add Bill Reminder window")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify separated account {sAccount} in Add Bill Reminder window", FAIL, "Separated account {sAccount} is not available in Add Bill Reminder window")
						[ ] 
					[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Verify Add Bill Reminder window", FAIL, "Add Bill Reminder window is not available")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "{sAccount} account is not separated")
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
[+] //#############Verify Separate checking Account in Add Income Reminder window ######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_SeparateAccountInAddIncomeReminder()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that separate account should get displayed in the Add Income Reminder pop up
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If separate banking account available in Add Income Reminder pop up				
		[ ] // Fail		If any error occurs or separate account is not available in Add Income Reminder pop up
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 12, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test07_SeparateAccountInAddIncomeReminder() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sTab,sPayeeName,sSelectedAccount
		[ ] sAccount="Checking 02"
		[ ] sPayeeName= "Payee1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
		[+] if (iSeparate == PASS)
			[ ] AccountDetails.Cancel.Click()
			[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and checking account is displayed under this seaction")
			[ ] 
			[ ] //Select Home tab
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[+] //Navigate to Bills > Add Reminder >  Income Reminder
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Bills.Click()
					[ ] QuickenWindow.Bills.AddReminder.DoubleClick()
			[ ] QuickenWindow.Bills.AddReminder.IncomeReminder.Select()
			[ ] 
			[ ] //Search separate account name in Add Income Reminder window
			[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
				[ ] DlgAddEditReminder.Step1Panel.PayeeNameTextField.SetText(sPayeeName)
				[ ] DlgAddEditReminder.NextButton.Click()
				[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.GetText()
				[ ] 
				[+] if (sSelectedAccount==sAccount)
					[ ] ReportStatus("Verify separate account {sAccount} in Add Income Reminer window", PASS, "Separate account {sAccount} is available in Add Income Reminer window")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify separate account {sAccount} in Add Income Reminer window", FAIL, "Separate account {sAccount} is not available in Add Income Reminder window")
				[ ] DlgAddEditReminder.Close()
			[+] else
				[ ] ReportStatus("Verify Add Income Reminder window", FAIL, "Add Income Reminder window is not available")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "{sAccount} account is not separated")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Separate checking Account in Add Transfer Reminder window ######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_SeparateAccountInAddTransferReminder()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that separate account should get displayed in the Add Transfer Reminder pop up
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If separate banking account is available in Add Transfer Reminder pop up				
		[ ] // Fail		If any error occurs or separate account not available in Add Transfer Reminder pop up
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 12, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test08_SeparateAccountInAddTransferReminder() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sTab,sPayeeName,sSelectedAccount
		[ ] sAccount="Checking 02"
		[ ] sPayeeName= "Payee1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
		[+] if (iSeparate == PASS)
			[ ] AccountDetails.Cancel.Click()
			[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and checking account is displayed under this seaction")
			[ ] 
			[ ] //Select Home tab
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[+] //Navigate to Bills > Add Reminder >  Transfer Reminder
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Bills.Click()
					[ ] QuickenWindow.Bills.AddReminder.DoubleClick()
			[ ] QuickenWindow.Bills.AddReminder.TransferReminder.Select()
			[ ] 
			[ ] //Search separate account name in Add TRansfer Reminder window
			[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
				[ ] DlgAddEditReminder.Step1Panel.PayeeNameTextField.SetText(sPayeeName)
				[ ] DlgAddEditReminder.NextButton.Click()
				[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.GetText()
				[+] if (sSelectedAccount==sAccount)
					[ ] ReportStatus("Verify separate account {sAccount} in Add Transfer Reminer window", PASS, "Separate account {sAccount} is available in Add Transfer Reminer window")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify separate account {sAccount} in Add Transfer Reminer window", FAIL, "Separate account {sAccount} is not available in Add Transfer Reminder window")
				[ ] 
				[ ] //Verification for ToAccount
				[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.GetText()
				[ ] 
				[ ] DlgAddEditReminder.Close()
			[+] else
				[ ] ReportStatus("Verify Add Transfer Reminder window", FAIL, "Add Transfer Reminder window is not available")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "{sAccount} account is not separated")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Separate checking Account in Add Paycheck Reminder window ####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_SeparateAccountInPaycheckReminder1()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that separate account should get displayed in the Add Paycheck Reminder pop up for Net Amount
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If separate banking account available in Add Paycheck Reminder pop up				
		[ ] // Fail		If any error occurs or separate account available in Add Paycheck Reminder pop up
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 13, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test09_SeparateAccountInPaycheckReminder1() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iFind
		[ ] STRING sTab,sPayeeName,sSelectedAccount
		[ ] BOOLEAN bAssert
		[ ] sAccount="Checking 02"
		[ ] sPayeeName= "Payee1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
		[+] if (iSeparate == PASS)
			[ ] AccountDetails.Cancel.Click()
			[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and checking account is displayed under this seaction")
			[ ] 
			[ ] //Select Home tab
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] //Navigate to Bills > Add Reminder >  Paycheck Reminder
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Bills.Click()
			[ ] QuickenWindow.Bills.AddReminder.DoubleClick()
			[ ] QuickenWindow.Bills.AddReminder.PaycheckReminder.Select()
			[ ] 
			[ ] //Search separate account name in Add Paycheck Reminder window
			[+] if(PayCheckSetup.Exists(SHORT_SLEEP) == TRUE)
				[ ] PayCheckSetup.SetActive ()
				[ ] PayCheckSetup.HowMuchPaycheck.Select("Net amount")
				[ ] PayCheckSetup.Next.Click ()
				[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
					[ ] DlgAddEditReminder.Step1Panel.PayeeNameTextField.SetText(sPayeeName)
					[ ] DlgAddEditReminder.NextButton.Click()
					[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.GetText()
					[+] if (sSelectedAccount==sAccount)
						[ ] ReportStatus("Verify separate account {sAccount} in Add Income Reminer window", PASS, "Separate account {sAccount} is available in Add Income Reminer window")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify separate account {sAccount} in Add Income Reminer window", FAIL, "Separate account {sAccount} is not available in Add Income Reminder window")
					[ ] 
					[ ] DlgAddEditReminder.Close()
			[+] else
				[ ] ReportStatus("Verify Add Paycheck window", FAIL, "Add Paycheck window is not available")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "{sAccount} account is not separated")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Separate checking Account in Add Paycheck Reminder window ####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_CloseAccountInPaycheckReminder2()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that separate account should get displayed in the Add Paycheck Reminder pop up for Gross amount
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Separate banking account available in Add Paycheck Reminder pop up				
		[ ] // Fail		If any error occurs or Separate account is not available in Add Paycheck Reminder pop up
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 13, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test10_SeparateAccountInPaycheckReminder2() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iFind
		[ ] STRING sTab,sPayeeName,sCompany
		[ ] sAccount="Checking 02"
		[ ] sPayeeName= "Payee1"
		[ ] sCompany = "Persistent"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
		[+] if (iSeparate == PASS)
			[ ] AccountDetails.Cancel.Click()
			[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and checking account is displayed under this seaction")
			[ ] 
			[ ] //Select Home tab
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] //Navigate to Bills > Add Reminder >  Paycheck Reminder
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Bills.Click()
			[ ] QuickenWindow.Bills.AddReminder.DoubleClick()
			[ ] QuickenWindow.Bills.AddReminder.PaycheckReminder.Select()
			[ ] 
			[ ] //Search separate account name in Add Paycheck Reminder window
			[+] if(PayCheckSetup.Exists(SHORT_SLEEP) == TRUE)
				[ ] PayCheckSetup.SetActive ()
				[ ] PayCheckSetup.HowMuchPaycheck.Select("Gross amount")
				[ ] PayCheckSetup.Next.Click ()
				[ ] PayCheckSetup.CompanyName.SetPosition (1, 1)
				[ ] PayCheckSetup.CompanyName.SetText (sCompany)
				[ ] PayCheckSetup.Next.Click ()
				[ ] PayCheckSetup.SetActive ()
				[ ] iFind=PayCheckSetup.Account.FindItem(sAccount)
				[+] if (iFind>0)
					[ ] ReportStatus("Verify separate account {sAccount} in Paycheck Setup window", PASS, "Separate account {sAccount} is available in Paycheck Setup window")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify separate account {sAccount} in Paycheck Setup window", FAIL, "Separate account {sAccount} is not available in Paycheck Setup window")
				[ ] 
				[ ] PayCheckSetup.Close()
			[+] else
				[ ] ReportStatus("Verify Add Paycheck window", FAIL, "Add Paycheck window is not available")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "{sAccount} account is not separated")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] // //#############Verify Hide in Transaction entry lists in Add Bill Reminder ##############
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test11_HideInTxnListInAddBillReminder()
		[ ] // // 
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Check Account Display option "-Hide In Transaction Entry List"  in Add Bill Reminder window
		[ ] // // 
		[ ] // // PARAMETERS:		None
		[ ] // // 
		[ ] // // RETURNS:			Pass 	If Setting saved successfully
		[ ] // // Fail		If any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // Dec 14, 2012		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase Test11_HideInTxnListInAddBillReminder() appstate none
	[ ] // 
	[+] // // Variable declaration
		[ ] // INTEGER iCount1,iCount2
		[ ] // STRING sPayeeName
		[ ] // sAccount="Checking 03"
		[ ] // sPayeeName= "Payee1"
		[ ] // 
	[ ] // 
	[+] // if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] // QuickenWindow.SetActive ()
		[ ] // 
		[ ] // //Hide In Transaction Entry List checking  Account
		[ ] // iSelect = AccountHideInTransactionList(ACCOUNT_BANKING,sAccount,2)			// Select  account
		[+] // if (iSelect == PASS)
			[ ] // 
			[ ] // //Select Home tab
			[ ] // NavigateQuickenTab(sTAB_HOME)
			[ ] // 
			[ ] // //Navigate to Bills > Add Reminder >  Bill Reminder
			[ ] // QuickenWindow.SetActive()
			[ ] // QuickenWindow.Bills.Click()
			[ ] // QuickenWindow.Bills.AddReminder.Click()
			[ ] 
			[ ] // QuickenWindow.Bills.AddReminder.BillReminder.Select()
			[ ] // 
			[ ] // //Search account name in Add Bill window
			[+] // if (DlgAddEditReminder.Exists(SHORT_SLEEP))
				[ ] // DlgAddEditReminder.Step1Panel.HomeChildPanel.PayToTextField.SetText (sPayeeName)
				[ ] // DlgAddEditReminder.Next.Click()
				[ ] // DlgAddEditReminder.SetActive()
				[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountButton.FromAccountButton.Click()
				[ ] // Agent.SetOption (OPT_VERIFY_ACTIVE, FALSE)
				[ ] // iCount1=Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetItemCount()
				[+] // if(Quicken2012Popup.ChooseCategory.ShowHiddenAccount.Exists(SHORT_SLEEP))
					[ ] // Quicken2012Popup.ChooseCategory.ShowHiddenAccount.Click()
					[ ] // iCount2=Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetItemCount()
					[ ] // Agent.SetOption (OPT_VERIFY_ACTIVE, TRUE)
					[+] // if (iCount1==iCount2-1)
						[ ] // ReportStatus("Verify Hide in Transaction entry lists", PASS, "Account {sAccount} is available in Add Bill Reminder window when Show Hidden Account checkbox is checked")
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Hide in Transaction entry lists", FAIL, "Account {sAccount} is not available in Add Bill Reminder window when Show Hidden Account checkbox checked")
						[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify show hidden accounts checkbox", FAIL, "Show Hidden Account checkbox is not available in Add Bill Reminder")
					[ ] // 
				[ ] // DlgAddEditReminder.Close()
			[+] // else
				[ ] // ReportStatus("Verify Add Bill Reminder window", FAIL, "Add Bill Reminder window is not available")
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate Account selection", iSelect, "Account is not selected from Account bar")
			[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] // 
	[ ] // 
[ ] // //##########################################################################
[ ] 
[+] // //#############Verify Hide in Transaction entry lists in Add Income Reminder###########
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test12_HideInTxnListInAddIncomeReminder()
		[ ] // // 
		[ ] // // This testcase will Check Account Display option "-Hide In Transaction Entry List"  in Add Income Reminder window
		[ ] // // 
		[ ] // // PARAMETERS:		None
		[ ] // // 
		[ ] // // RETURNS:			Pass 	If Setting saved successfully
		[ ] // // Fail		If any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // Dec 14, 2012		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase Test12_HideInTxnListInAddIncomeReminder() appstate none
	[ ] // 
	[+] // // Variable declaration
		[ ] // INTEGER iCount1,iCount2
		[ ] // STRING sTab,sPayeeName
		[ ] // sAccount="Checking 03"
		[ ] // sPayeeName= "Payee1"
	[ ] // 
	[+] // if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] // QuickenWindow.SetActive ()
		[ ] // 
		[ ] // //Select Home tab
		[ ] // NavigateQuickenTab(sTAB_HOME)
		[ ] // 
		[+] // //Navigate to Bills > Add Reminder >  Income Reminder
			[ ] // QuickenWindow.SetActive()
			[ ] // QuickenWindow.Bills.Click()
			[ ] // QuickenWindow.Bills.AddReminder.Click()
		[ ] 
		[ ] // QuickenWindow.Bills.AddReminder.IncomeReminder.Select()
		[ ] // 
		[ ] // //Search account name in Add Income Reminder window
		[+] // if (DlgAddEditReminder.Exists(SHORT_SLEEP))
			[ ] // DlgAddEditReminder.Panel1.QWinChild1.PayTo.SetText (sPayeeName)
			[ ] // DlgAddEditReminder.Next.Click()
			[ ] // DlgAddEditReminder.SetActive()
			[ ] // DlgAddEditReminder.Panel2.QWinChild1.FromAccountButton.FromAccountButton.Click()
			[ ] // Agent.SetOption (OPT_VERIFY_ACTIVE, FALSE)
			[ ] // iCount1=Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetItemCount()
			[ ] // //Verify Show Hidden Accounts checkbox
			[+] // if(Quicken2012Popup.ChooseCategory.ShowHiddenAccount.Exists(SHORT_SLEEP))
				[ ] // Quicken2012Popup.ChooseCategory.ShowHiddenAccount.Click()
				[ ] // iCount2=Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetItemCount()
				[ ] // Agent.SetOption (OPT_VERIFY_ACTIVE, TRUE)
				[ ] // 
				[+] // if (iCount1==iCount2-1)
					[ ] // ReportStatus("Verify Hide in Transaction entry lists", PASS, "Account {sAccount} is available in Add Income Reminder window when Show Hidden Account checkbox is checked")
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Hide in Transaction entry lists", FAIL, "Account {sAccount} is not available in Add Income Reminder window when Show Hidden Account checkbox checked")
					[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify show hidden accounts checkbox", FAIL, "Show Hidden Account checkbox is not available in Add Income Reminder")
				[ ] // 
			[ ] // Reminder.Close()
		[+] // else
			[ ] // ReportStatus("Verify Add Income Reminder window", FAIL, "Add Income Reminder window is not available")
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] // 
	[ ] // 
[ ] // //###########################################################################
[ ] // 
[+] // //#############Verify Hide in Transaction entry lists in Add Transfer Reminder ##########
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test13_HideInTxnListInAddTransferReminder()
		[ ] // // 
		[ ] // // This testcase will Check Account Display option "-Hide In Transaction Entry List"  in Add Transfer Reminder window
		[ ] // // 
		[ ] // // PARAMETERS:		None
		[ ] // // 
		[ ] // // RETURNS:			Pass 	If Setting saved successfully
		[ ] // // Fail		If any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // Dec 14, 2012		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase Test13_HideInTxnListInAddTransferReminder() appstate none
	[ ] // 
	[+] // // Variable declaration
		[ ] // INTEGER iCount1,iCount2
		[ ] // STRING sTab,sPayeeName
		[ ] // sAccount="Checking 03"
		[ ] // sPayeeName= "Payee1"
	[ ] // 
	[+] // if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] // QuickenWindow.SetActive ()
		[ ] // 
		[ ] // //Select Home tab
		[ ] // NavigateQuickenTab(sTAB_HOME)
		[ ] // 
		[+] // //Navigate to Bills > Add Reminder >  Transfer Reminder
			[ ] // QuickenWindow.SetActive()
			[ ] // QuickenWindow.Bills.Click()
			[ ] // QuickenWindow.Bills.AddReminder.Click()
		[ ] 
		[ ] // QuickenWindow.Bills.AddReminder.TransferReminder.Select()
		[ ] // 
		[ ] // //Search separate account name in Add TRansfer Reminder window
		[+] // if (DlgAddEditReminder.Exists(SHORT_SLEEP))
			[ ] // DlgAddEditReminder.Panel1.QWinChild1.PayTo.SetText (sPayeeName)
			[ ] // DlgAddEditReminder.Next.Click()
			[ ] // DlgAddEditReminder.SetActive()
			[ ] // //Verification for From Account
			[ ] // DlgAddEditReminder.Panel2.QWinChild1.FromAccountButton.FromAccountButton.Click()
			[ ] // Agent.SetOption (OPT_VERIFY_ACTIVE, FALSE)
			[ ] // iCount1=Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetItemCount()
			[ ] // //Verify Show Hidden Accounts checkbox
			[+] // if(Quicken2012Popup.ChooseCategory.ShowHiddenAccount.Exists(SHORT_SLEEP))
				[ ] // Quicken2012Popup.ChooseCategory.ShowHiddenAccount.Click()
				[ ] // iCount2=Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetItemCount()
				[ ] // Agent.SetOption (OPT_VERIFY_ACTIVE, TRUE)
				[ ] // 
				[+] // if (iCount1==iCount2-1)
					[ ] // ReportStatus("Verify Hide in Transaction entry lists", PASS, "Account {sAccount} is available in From Account dropdown if Show Hidden Account checkbox is checked")
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Hide in Transaction entry lists", FAIL, "Account {sAccount} is not available in From Account dropdown if Show Hidden Account checkbox checked")
					[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify show hidden accounts checkbox", FAIL, "Show Hidden Account checkbox is not available in Add Transfer Reminder")
				[ ] // 
			[ ] // 
			[ ] // DlgAddEditReminder.Panel2.QWinChild1.AmountDue.SetFocus()
			[ ] // //Verification for To Account
			[ ] // DlgAddEditReminder.Panel2.QWinChild1.ToAccountButton.ToAccountButton.Click()
			[ ] // Agent.SetOption (OPT_VERIFY_ACTIVE, FALSE)
			[ ] // iCount1=Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetItemCount()
			[ ] // //Verify Show Hidden Accounts checkbox
			[+] // if(Quicken2012Popup.ChooseCategory.ShowHiddenAccount.Exists(SHORT_SLEEP))
				[ ] // Quicken2012Popup.ChooseCategory.ShowHiddenAccount.Click()
				[ ] // iCount2=Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetItemCount()
				[ ] // Agent.SetOption (OPT_VERIFY_ACTIVE, TRUE)
				[ ] // 
				[+] // if (iCount1==iCount2-1)
					[ ] // ReportStatus("Verify Hide in Transaction entry lists", PASS, "Account {sAccount} is available in To Account dropdown if Show Hidden Account checkbox is checked")
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Hide in Transaction entry lists", FAIL, "Account {sAccount} is not available in To Account dropdown if Show Hidden Account checkbox checked")
					[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify show hidden accounts checkbox", FAIL, "Show Hidden Account checkbox is not available in Add Transfer Reminder")
				[ ] // 
			[ ] // Reminder.Close()
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify Add Transfer Reminder window", FAIL, "Add Transfer Reminder window is not available")
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] // 
	[ ] // 
[ ] // //###########################################################################
[ ] // 
[+] // //#############Verify Hide in Transaction entry lists in Add Paycheck Reminder ##########
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test14_HideInTxnListInAddPaycheck1()
		[ ] // // 
		[ ] // // This testcase will Check Account Display option "-Hide In Transaction Entry List"  in Add Paycheck Reminder window - Net amount
		[ ] // // 
		[ ] // // PARAMETERS:		None
		[ ] // // 
		[ ] // // RETURNS:			Pass 	If Setting saved successfully
		[ ] // // Fail		If any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // Dec 14, 2012		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase Test14_HideInTxnListInAddPaycheck1() appstate none
	[ ] // 
	[+] // // Variable declaration
		[ ] // INTEGER iCount1,iCount2
		[ ] // STRING sTab,sPayeeName
		[ ] // sAccount="Checking 03"
		[ ] // sPayeeName= "Payee1"
	[ ] // 
	[+] // if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] // QuickenWindow.SetActive ()
		[ ] // 
		[ ] // //Select Home tab
		[ ] // NavigateQuickenTab(sTAB_HOME)
		[ ] // 
		[+] // //Navigate to Bills > Add Reminder >  Paycheck Reminder
			[ ] // QuickenWindow.SetActive()
			[ ] // QuickenWindow.Bills.Click()
			[ ] // QuickenWindow.Bills.AddReminder.Click()
		[ ] 
		[ ] // QuickenWindow.Bills.AddReminder.PaycheckReminder.Select()
		[ ] // 
		[ ] // //Search account name in Add Paycheck Reminder window
		[+] // if(PayCheckSetup.Exists(SHORT_SLEEP) == TRUE)
			[ ] // PayCheckSetup.SetActive ()
			[ ] // PayCheckSetup.HowMuchPaycheck.Select("Net amount")
			[ ] // PayCheckSetup.Next.Click ()
			[+] // if (DlgAddEditReminder.Exists(SHORT_SLEEP))
				[ ] // DlgAddEditReminder.Panel1.QWinChild1.PayTo.SetText ("Test")
				[ ] // DlgAddEditReminder.Next.Click()
				[ ] // DlgAddEditReminder.SetActive()
				[ ] // //Verification for To Account
				[ ] // DlgAddEditReminder.Panel2.QWinChild1.FromAccountButton.FromAccountButton.Click()
				[ ] // Agent.SetOption (OPT_VERIFY_ACTIVE, FALSE)
				[ ] // iCount1=Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetItemCount()
				[ ] // //Verify Show Hidden Accounts checkbox
				[+] // if(Quicken2012Popup.ChooseCategory.ShowHiddenAccount.Exists(SHORT_SLEEP))
					[ ] // Quicken2012Popup.ChooseCategory.ShowHiddenAccount.Click()
					[ ] // iCount2=Quicken2012Popup.ChooseCategory.QWListViewer.CategoryList.GetItemCount()
					[ ] // Agent.SetOption (OPT_VERIFY_ACTIVE, TRUE)
					[ ] // 
					[+] // if (iCount1==iCount2-1)
						[ ] // ReportStatus("Verify Hide in Transaction entry lists", PASS, "Account {sAccount} is available in To Account dropdown if Show Hidden Account checkbox is checked")
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Hide in Transaction entry lists", FAIL, "Account {sAccount} is not available in To Account dropdown if Show Hidden Account checkbox checked")
						[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify show hidden accounts checkbox", FAIL, "Show Hidden Account checkbox is not available in Add Paycheck Reminder")
					[ ] // 
				[ ] // DlgAddEditReminder.Close()
			[+] // else
				[ ] // ReportStatus("Verify Reminder window",FAIL,"Reminder window is not opened")
		[+] // else
			[ ] // ReportStatus("Verify Add Paycheck window", FAIL, "Add Paycheck window is not available")
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] // 
	[ ] // 
[ ] // //###########################################################################
[ ] // 
[+] // //#############Verify Hide in Transaction entry lists in Add Paycheck Reminder ##########
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test15_HideInTxnListInAddPaycheck2()
		[ ] // // 
		[ ] // // This testcase will Check Account Display option "-Hide In Transaction Entry List"  in Add Paycheck Reminder window - Gross amount
		[ ] // // 
		[ ] // // PARAMETERS:		None
		[ ] // // 
		[ ] // // RETURNS:			Pass 	If Setting saved successfully
		[ ] // // Fail		If any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:
		[ ] // // Dec 14, 2012		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase Test15_HideInTxnListInAddPaycheck2() appstate none
	[ ] // 
	[+] // // Variable declaration
		[ ] // INTEGER iFind
		[ ] // STRING sTab,sPayeeName,sCompany
		[ ] // sAccount="Checking 03"
		[ ] // sPayeeName= "Payee1"
		[ ] // sCompany = "Persistent"
	[ ] // 
	[+] // if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] // QuickenWindow.SetActive ()
		[ ] // 
		[ ] // //Select Home tab
		[ ] // NavigateQuickenTab(sTAB_HOME)
		[ ] // 
		[+] // //Navigate to Bills > Add Reminder >  Paycheck Reminder
			[ ] // QuickenWindow.SetActive()
			[ ] // QuickenWindow.Bills.Click()
			[ ] // QuickenWindow.Bills.AddReminder.Click()
		[ ] 
		[ ] // QuickenWindow.Bills.AddReminder.PaycheckReminder.Select()
		[ ] // 
		[ ] // //Search account name in Add Paycheck Reminder window
		[+] // if(PayCheckSetup.Exists(SHORT_SLEEP) == TRUE)
			[ ] // PayCheckSetup.SetActive ()
			[ ] // PayCheckSetup.HowMuchPaycheck.Select("Gross amount")
			[ ] // PayCheckSetup.Next.Click ()
			[ ] // PayCheckSetup.CompanyName.SetPosition (1, 1)
			[ ] // PayCheckSetup.CompanyName.SetText (sCompany)
			[ ] // PayCheckSetup.Next.Click ()
			[ ] // PayCheckSetup.SetActive ()
			[ ] // iFind=PayCheckSetup.Account.FindItem(sAccount)
			[+] // if (iFind==0)
				[ ] // ReportStatus("Verify account {sAccount} in Paycheck Setup window", PASS, "Account {sAccount} is not available in Paycheck Setup window as account is hidden from transaction list")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify account {sAccount} in Paycheck Setup window", FAIL, "Account {sAccount} is available in Paycheck Setup window as account is not hidden from transaction list")
			[ ] // 
			[ ] // PayCheckSetup.Close()
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify Add Paycheck window", FAIL, "Add Paycheck window is not available")
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] // 
	[ ] // 
[ ] // //###########################################################################
[ ] 
[+] //#############Verify Hide account name in account bar in Add Bill Reminder ###########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_HideAccountInAccBarForBillReminder()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check Account Display option "-Hide account name in Account Bar and Account List"  in Add Bill Reminder window
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Setting saved successfully
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 18, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test16_HideAccountInAccBarForBillReminder() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iAddAccount
		[ ] STRING sTab,sPayeeName,sSelectedAccount
		[ ] LIST OF STRING lsAccount
		[ ] sPayeeName= "Payee1"
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] lsAccount = {"Checking","Account-Test","500", "{sDateStamp}"}
		[ ] sAccount=lsAccount[2]
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAccount[1], lsAccount[2], lsAccount[3], lsAccount[4])
		[ ] //Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAccount[1]} Account", iAddAccount, "{lsAccount[1]} Account -  {lsAccount[2]}  is created successfully")
			[ ] 
			[ ] //Hide account name in Account Bar and Account List checking  Account
			[ ] iSelect = AccountHideInAccountBarAccountList(ACCOUNT_BANKING,sAccount,1)			// Hide  account
			[+] if (iSelect == PASS)
				[ ] 
				[ ] //Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] //Navigate to Bills > Add Reminder >  Bill Reminder
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Bills.Click()
				[ ] QuickenWindow.Bills.AddReminder.DoubleClick()
				[ ] QuickenWindow.Bills.AddReminder.BillReminder.Select()
				[ ] 
				[ ] //Search account name in Add Bill window
				[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayToTextField.SetText (sPayeeName)
					[ ] DlgAddEditReminder.NextButton.Click()
					[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.GetText()
					[+] if (sSelectedAccount==sAccount)
						[ ] ReportStatus("Verify account {sAccount} in Add Bill Reminder window", PASS, "Account {sAccount} is available in Add Bill Reminder window")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify account {sAccount} in Add Bill Reminder window", FAIL, "Account {sAccount} is not available in Add Bill Reminder window")
						[ ] 
					[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Verify Add Bill Reminder window", FAIL, "Add Bill Reminder window is not available")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Account selection", iSelect, "House Account is not selected from Account bar")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("{lsAccount[1]} Account", iAddAccount, "{lsAccount[1]} Account -  {lsAccount[2]}  is not created successfully")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide account name in account bar in Add Income Reminder#########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_HideAccountInAccBarForIncomeReminder()
		[ ] // 
		[ ] // This testcase will Check Account Display option "-Hide account name in Account Bar and Account List"  in Add Income Reminder window
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Setting saved successfully
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 18, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test17_HideAccountInAccBarForIncomeReminder() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iSelect
		[ ] STRING sTab,sPayeeName,sSelectedAccount
		[ ] sAccount="Account-Test"
		[ ] sPayeeName= "Payee1"
		[ ] sTab= "Display Options"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify account is made hidden from account bar and account list
		[ ] iSeparate=AccountBarSelect(ACCOUNT_BANKING, 5)
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_DN)
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_ENTER)
		[ ] NavigateToAccountDetails(sAccount)
		[ ] iSelect=SelectAccountDetailsTabs(ACCOUNT_BANKING,sTab)
		[+] if(iSelect==PASS)
			[+] if(AccountDetails.HideAccountNameInAccountB.IsChecked())
				[ ] ReportStatus("Verify Hide account name in account bar check box for account {sAccount} ", PASS, "Hide account name in account bar checkbox is checked for {sAccount}")
				[ ] AccountDetails.Close()
				[ ] 
				[ ] 
				[ ] //Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] //Navigate to Bills > Add Reminder >  Income Reminder
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Bills.Click()
				[ ] QuickenWindow.Bills.AddReminder.Click()
				[ ] QuickenWindow.Bills.AddReminder.IncomeReminder.Select()
				[ ] 
				[ ] //Search account name in Add Income Reminder window
				[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayToTextField.SetText (sPayeeName)
					[ ] DlgAddEditReminder.NextButton.Click()
					[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.GetText()
					[+] if (sSelectedAccount==sAccount)
						[ ] ReportStatus("Verify {sAccount} in Add Income Reminer window", PASS, "Account {sAccount} is available in Add Income Reminer window as it is hidden from account bar and account list")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify {sAccount} in Add Income Reminer window", FAIL, "Account {sAccount} is not available in Add Income Reminer window as it is hidden from account bar and account list")
					[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Verify Add Income Reminder window", FAIL, "Add Income Reminder window is not available")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Hide account name in account bar check box for account {sAccount} ", FAIL, "Hide account name in account bar checkbox is not checked for {sAccount}")
		[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Display Options tab for {sAccount} ", FAIL, "Navigate to Display Options tab is failed for {sAccount}")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide account name in account bar in Add Transfer Reminder########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test18_HideAccountInAccBarForTransferReminder()
		[ ] // 
		[ ] // This testcase will Check Account Display option "-Hide account name in Account Bar and Account List"  in Add Transfer Reminder window
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Setting saved successfully
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 19, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test18_HideAccountInAccBarForTransferReminder() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sPayeeName,sSelectedAccount,sSelectAccount
		[ ] sAccount="Account-Test"
		[ ] sPayeeName= "Payee1"
		[ ] sSelectAccount= "Saving 01"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify account is hidden from account bar and account list
		[ ] iSeparate=AccountBarSelect(ACCOUNT_BANKING, 5)
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_DN)
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_ENTER)
		[ ] NavigateToAccountDetails(sAccount)
		[ ] iSelect=SelectAccountDetailsTabs(ACCOUNT_BANKING,sTab)
		[+] if(iSelect==PASS)
			[+] if(AccountDetails.HideAccountNameInAccountB.IsChecked())
				[ ] ReportStatus("Verify Hide account name in account bar check box for account {sAccount} ", PASS, "Hide account name in account bar checkbox is checked for {sAccount}")
				[ ] AccountDetails.Close()
				[ ] 
				[ ] 
				[ ] //Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] //Navigate to Bills > Add Reminder >  Transfer Reminder
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Bills.Click()
				[ ] QuickenWindow.Bills.AddReminder.Click()
				[ ] QuickenWindow.Bills.AddReminder.TransferReminder.Select()
				[ ] 
				[ ] //Search account name in Add Transfer Reminder window
				[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayToTextField.SetText (sPayeeName)
					[ ] DlgAddEditReminder.NextButton.Click()
					[ ] //Verification for From Account
					[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.GetText()
					[+] if (sSelectedAccount==sAccount)
						[ ] ReportStatus("Verify {sAccount} in Add Transfer Reminer window", PASS, "Account {sAccount} is available in From Account dropdown of Add Transfer Reminer window as it is hidden from account bar and account list")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify {sAccount} in Add Transfer Reminer window", FAIL, "Account {sAccount} is not available in From Account dropdown of Add Transfer Reminer window as it is hidden from account bar and account list")
					[ ] 
					[ ] //Verification for To Account
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.SetText(sSelectAccount)
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sAccount)
					[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.GetText()
					[+] if (sSelectedAccount==sAccount)
						[ ] ReportStatus("Verify {sAccount} in Add Transfer Reminer window", PASS, "Account {sAccount} is available in To Account dropdown of Add Transfer Reminer window as it is hidden from account bar and account list")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify {sAccount} in Add Transfer Reminer window", FAIL, "Account {sAccount} is not available in To Account dropdown of Add Transfer Reminer window as it is hidden from account bar and account list")
					[ ] 
					[ ] 
					[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Verify Add Income Reminder window", FAIL, "Add Income Reminder window is not available")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Hide account name in account bar check box for account {sAccount} ", FAIL, "Hide account name in account bar checkbox is not checked for {sAccount}")
		[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Display Options tab for {sAccount} ", FAIL, "Navigate to Display Options tab is failed for {sAccount}")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide account name in account bar in Add Paycheck Reminder #####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test19_HideAccountInAccBarForAddPaycheck1()
		[ ] // 
		[ ] // This testcase will Check Account Display option "-Hide account name in account bar and account list"  in Add Paycheck Reminder window - Net amount
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Setting saved successfully
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 19, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test19_HideAccountInAccBarForAddPaycheck1() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sPayeeName,sSelectedAccount
		[ ] sAccount="Account-Test"
		[ ] sPayeeName= "Payee1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify account is hidden from account bar and account list
		[ ] iSeparate=AccountBarSelect(ACCOUNT_BANKING, 5)	
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_DN)
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_ENTER)
		[ ] NavigateToAccountDetails(sAccount)
		[ ] iSelect=SelectAccountDetailsTabs(ACCOUNT_BANKING,sTab)
		[+] if(iSelect==PASS)
			[+] if(AccountDetails.HideAccountNameInAccountB.IsChecked())
				[ ] ReportStatus("Verify Hide account name in account bar check box for account {sAccount} ", PASS, "Hide account name in account bar checkbox is checked for {sAccount}")
				[ ] AccountDetails.Close()
				[ ] 
				[ ] 
				[ ] //Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] //Navigate to Bills > Add Reminder >  Paycheck Reminder
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Bills.Click()
				[ ] QuickenWindow.Bills.AddReminder.Click()
				[ ] QuickenWindow.Bills.AddReminder.PaycheckReminder.Select()
				[ ] 
				[ ] //Search account name in Add Paycheck Reminder window
				[+] if(PayCheckSetup.Exists(SHORT_SLEEP) == TRUE)
					[ ] PayCheckSetup.SetActive ()
					[ ] PayCheckSetup.HowMuchPaycheck.Select("Net amount")
					[ ] PayCheckSetup.Next.Click ()
					[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
						[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayToTextField.SetText (sPayeeName)
						[ ] DlgAddEditReminder.NextButton.Click()
						[ ] DlgAddEditReminder.SetActive()
						[ ] //Verification for To Account
						[ ] sSelectedAccount=DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.GetText()
						[+] if (sSelectedAccount==sAccount)
							[ ] ReportStatus("Verify account {sAccount} in Add Income Reminer window", PASS, "Account {sAccount} is available in Add Income Reminer window")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify account {sAccount} in Add Income Reminer window", FAIL, "Account {sAccount} is not available in Add Income Reminder window")
						[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Verify Add Paycheck window", FAIL, "Add Paycheck window is not available")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Hide account name in account bar check box for account {sAccount} ", FAIL, "Hide account name in account bar checkbox is not checked for {sAccount}")
		[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Display Options tab for {sAccount} ", FAIL, "Navigate to Display Options tab is failed for {sAccount}")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide account name in account bar in Add Paycheck Reminder #####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test20_HideAccountInAccBarForAddPaycheck2()
		[ ] // 
		[ ] // This testcase will Check Account Display option "-Hide account name in account bar and account list"  in Add Paycheck Reminder window - Gross amount
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Setting saved successfully
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 19, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test20_HideAccountInAccBarForAddPaycheck2() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iFind
		[ ] STRING sTab,sPayeeName,sCompany
		[ ] sAccount="Account-Test"
		[ ] sPayeeName= "Payee1"
		[ ] sCompany = "Persistent"
		[ ] sTab= "Display Options"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify account is hidden from account bar and account list
		[ ] iSeparate=AccountBarSelect(ACCOUNT_BANKING, 5)
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_DN)
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_ENTER)
		[ ] NavigateToAccountDetails(sAccount)
		[ ] iSelect=SelectAccountDetailsTabs(ACCOUNT_BANKING,sTab)
		[+] if(iSelect==PASS)
			[+] if(AccountDetails.HideAccountNameInAccountB.IsChecked())
				[ ] ReportStatus("Verify Hide account name in account bar check box for account {sAccount} ", PASS, "Hide account name in account bar checkbox is checked for {sAccount}")
				[ ] AccountDetails.Close()
				[ ] 
				[ ] //Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] //Navigate to Bills > Add Reminder >  Paycheck Reminder
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Bills.Click()
				[ ] QuickenWindow.Bills.AddReminder.Click()
				[ ] QuickenWindow.Bills.AddReminder.PaycheckReminder.Select()
				[ ] 
				[ ] //Search account name in Add Paycheck Reminder window
				[+] if(PayCheckSetup.Exists(SHORT_SLEEP) == TRUE)
					[ ] PayCheckSetup.SetActive ()
					[ ] PayCheckSetup.HowMuchPaycheck.Select("Gross amount")
					[ ] PayCheckSetup.Next.Click ()
					[ ] PayCheckSetup.CompanyName.SetPosition (1, 1)
					[ ] PayCheckSetup.CompanyName.SetText (sCompany)
					[ ] PayCheckSetup.Next.Click ()
					[ ] PayCheckSetup.SetActive ()
					[ ] iFind=PayCheckSetup.Account.FindItem(sAccount)
					[+] if (iFind>0)
						[ ] ReportStatus("Verify account {sAccount} in Paycheck Setup window", PASS, "Account {sAccount} is available in Paycheck Setup window as account is hidden from account bar")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify account {sAccount} in Paycheck Setup window", FAIL, "Account {sAccount} is not available in Paycheck Setup window as account is not hidden from account bar")
					[ ] 
					[ ] PayCheckSetup.Close()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Add Paycheck window", FAIL, "Add Paycheck window is not available")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Hide account name in account bar check box for account {sAccount} ", FAIL, "Hide account name in account bar checkbox is not checked for {sAccount}")
		[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Display Options tab for {sAccount} ", FAIL, "Navigate to Display Options tab is failed for {sAccount}")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Close Banking account having scheduled reminders #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_CloseBankingAccWithReminders()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify displaying of warning message if account to be closed has scheduled reminders in it.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If warning message is displayed						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 19, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test21_CloseBankingAccWithRemindersVerifyAlert () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iAddReminder
		[ ] STRING sActualMessage,sTab,sExpectedMessage1,sExpectedMessage2
		[ ] IncTranReminderRecord rReminderData 
		[ ] 
		[ ] sAccount="Checking 03"
		[ ] sExpectedMessage1="This account has one or more scheduled reminders"
		[ ] sExpectedMessage2="Account not closed"
		[ ] rReminderData.sReminderType= "Income Reminder"
		[ ] rReminderData.sPayeeName="Payee1"
		[ ] rReminderData.sDate=FormatDateTime (GetDateTime(), "m/d/yyyy")
		[ ] rReminderData.sToAccount=sAccount
		[ ] rReminderData.sAmount="20"
		[ ] rReminderData.sCategory="Travel"
		[ ] rReminderData.sMemo="Memo1"
		[ ] rReminderData.sTag="Tag1"
		[ ] sTab= "Display Options"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sAccount,sTab)			// Select account
		[+] if (iSelect == PASS)
			[+] if(AccountDetails.HideInTransactionEntryList.IsChecked())
				[ ] AccountDetails.HideInTransactionEntryList.Uncheck()
			[+] if(AccountDetails.Exists(SHORT_SLEEP))
				[ ] AccountDetails.SetActive()
				[ ] AccountDetails.OK.Click()
		[ ] 
		[ ] 
		[ ] //Select Bills tab
		[ ] NavigateQuickenTab(sTAB_BILL)
		[ ] 
		[ ] iAddReminder=AddIncomeTransferReminder(rReminderData)
		[+] if(iAddReminder==PASS)
			[ ] ReportStatus("Add Income Reminder", PASS, "Income reminder added successfully")
		[+] else
			[ ] ReportStatus("Add Income Reminder",FAIL, "Income reminder is not get added")
		[ ] 
		[ ] //Edit Banking Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sAccount,sTab)			// Select account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] //Check "Close Account" button
			[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
				[ ] AccountDetails.CloseAccount.Click()
				[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
					[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
					[ ] PermanentlyCloseAccount.OK.Click()
					[+] if(AlertMessage.Exists(SHORT_SLEEP))
						[ ] //Get alert message
						[ ] sActualMessage=AlertMessage.MessageText.GetText()
						[+] if(MatchStr("{sExpectedMessage1}*",sActualMessage))
							[ ] ReportStatus("Verify alert message", PASS, "Correct alert message is displayed i.e. {sExpectedMessage1}")
						[+] else
							[ ] ReportStatus("Verify alert message", FAIL, "Actual alert message: {sActualMessage} and Expected alert message: {sExpectedMessage1}")
						[ ] AlertMessage.Close()
						[ ] 
						[+] if(AlertMessage.Exists(SHORT_SLEEP))
							[ ] sActualMessage=AlertMessage.MessageText.GetText()
							[+] if(MatchStr("{sExpectedMessage2}*",sActualMessage))
								[ ] ReportStatus("Verify alert message", PASS, "Correct alert message is displayed i.e. {sExpectedMessage2}")
							[+] else
								[ ] ReportStatus("Verify alert message", FAIL, "Actual alert message: {sActualMessage} and Expected alert message: {sExpectedMessage2}")
							[ ] 
							[ ] AlertMessage.Close()
							[ ] 
							[+] if(!AlertMessage.Exists(SHORT_SLEEP))
								[ ] ReportStatus("Verify alert gets closed after cancelling", PASS, "Alert message is closed after cancelling")
							[+] else
								[ ] ReportStatus("Verify alert gets closed after cancelling", FAIL, "Alert message is not close after cancelling")
							[ ] 
						[+] if(AccountDetails.Exists(SHORT_SLEEP))
							[ ] AccountDetails.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify alert message dialog", FAIL, "Alert message dialog is not displayed")
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
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Close Banking account having scheduled reminders #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test22_CloseBankingAccWithRemindersCancelAlert()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will cancel displaying of warning message if account to be closed has scheduled reminders in it.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If warning message is displayed and alert get closed after closing it				
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 20, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test22_CloseBankingAccWithRemindersCancelAlert () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iAddReminder
		[ ] STRING sActualMessage,sTab,sExpectedMessage1,sExpectedMessage2
		[ ] 
		[ ] sAccount="Checking 03"
		[ ] sExpectedMessage1="This account has one or more scheduled reminders"
		[ ] sExpectedMessage2="Account not closed"
		[ ] sTab= "Display Options"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Banking Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sAccount,sTab)			// Select account
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
						[ ] AlertMessage.Close()
						[ ] 
						[+] if(AlertMessage.Exists(SHORT_SLEEP))
							[ ] sActualMessage=AlertMessage.MessageText.GetText()
							[+] if(MatchStr("{sExpectedMessage2}*",sActualMessage))
								[ ] ReportStatus("Verify alert message", PASS, "Correct alert message is displayed i.e. {sExpectedMessage2}")
							[+] else
								[ ] ReportStatus("Verify alert message", FAIL, "Actual alert message: {sActualMessage} and Expected alert message: {sExpectedMessage2}")
							[ ] 
							[ ] AlertMessage.Close()
							[ ] 
							[+] if(!AlertMessage.Exists(SHORT_SLEEP))
								[ ] ReportStatus("Verify alert gets closed after cancelling", PASS, "Alert message is closed after cancelling")
							[+] else
								[ ] ReportStatus("Verify alert gets closed after cancelling", FAIL, "Alert message is not close after cancelling")
							[ ] 
						[+] if(AccountDetails.Exists(SHORT_SLEEP))
							[ ] AccountDetails.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify alert message dialog", FAIL, "Alert message dialog is not displayed")
						[ ] 
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
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Close Banking account having scheduled reminders #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_CloseBankingAccWithReminders()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will close account having scheduled reminders in it and reminder are deleted after closing that account.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If warning message is displayed and alert get closed after closing it				
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 20, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test23_CloseBankingAccWithReminders() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iNavigate
		[ ] STRING sActualMessage,sTab,sExpectedMessage1
		[ ] 
		[ ] sAccount="Checking 03"
		[ ] sExpectedMessage1="This account has one or more scheduled reminders"
		[ ] sTab= "Display Options"
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Banking Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sAccount,sTab)			// Select account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] //Check "Close Account" button
			[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
				[ ] AccountDetails.CloseAccount.Click()
				[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
					[ ] PermanentlyCloseAccount.SetActive()
					[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
					[ ] PermanentlyCloseAccount.OK.Click()
					[+] 
						[+] if(AlertMessage.Exists(5))
							[ ] //Get alert message
							[ ] sActualMessage=AlertMessage.MessageText.GetText()
							[+] if(MatchStr("{sExpectedMessage1}*",sActualMessage))
								[ ] ReportStatus("Verify alert message", PASS, "Correct alert message is displayed i.e. {sExpectedMessage1}")
							[+] else
								[ ] ReportStatus("Verify alert message", FAIL, "Actual alert message: {sActualMessage} and Expected alert message: {sExpectedMessage1}")
							[ ] AlertMessage.Yes.Click()
							[ ] 
							[ ] //Verify second alert message is not displayed
							[+] if(!AlertMessage.Exists(SHORT_SLEEP))
								[ ] ReportStatus("Verify alert is not displayed and closed te account", PASS, "Alert message is not displayed and Account is closed successfully")
							[+] else
								[ ] ReportStatus("Verify alert is not displayed and closed te account", FAIL, "Alert message is displayed and Account is not closed")
								[ ] AlertMessage.Close()
							[ ] 
							[ ] // //Close Account details window
							[+] // if(AccountDetails.Exists(SHORT_SLEEP))
								[ ] AccountDetails.SetActive()
								[ ] AccountDetails.Close()
							[ ] 
							[ ] //Navigate to Home Page
							[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
							[+] if (iNavigate == PASS)
								[ ] //Check for Get Started button
								[+] if (MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.GetStarted.Exists(SHORT_SLEEP))
									[ ] ReportStatus("Verify reminder displayed on home page", PASS, "No reminder is displayed on Home page as Account is closed")
								[+] else
									[ ] ReportStatus("Verify reminder displayed on home page", PASS, "Reminder is displayed on Home page")
							[+] else
								[ ] ReportStatus("Navigate to Home Page", FAIL, "Navigation to Home page is failed")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify alert message dialog", FAIL, "Alert message dialog is not displayed")
						[ ] 
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
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Close To account having Transfer reminders ##########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test24_CloseToAccWithTransferReminder()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Transfer Reminder should be removed if To account is closed
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Transfer reminder is removed if To account is closed					
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 20, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test24_CloseToAccWithTransferReminder() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iAddReminder,iNavigate
		[ ] STRING sActualMessage,sTab,sExpectedMessage1,sExpectedMessage2
		[ ] IncTranReminderRecord rReminderData 
		[ ] 
		[ ] sAccount="Saving 02"
		[ ] sExpectedMessage1="This account has one or more scheduled reminders"
		[ ] sExpectedMessage2="Account not closed"
		[ ] rReminderData.sReminderType= "Transfer Reminder"
		[ ] rReminderData.sPayeeName="Payee1"
		[ ] rReminderData.sDate=FormatDateTime (GetDateTime(), "m/d/yyyy")
		[ ] rReminderData.sToAccount=sAccount
		[ ] rReminderData.sFromAccount="Saving 02"
		[ ] rReminderData.sAmount="20"
		[ ] rReminderData.sMemo="Memo1"
		[ ] rReminderData.sTag="Tag1"
		[ ] sTab= "Display Options"
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Navigate to Home Page
		[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
		[+] if (iNavigate == PASS)
			[ ] //Check for Get Started button
			[+] if (MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.GetStarted.Exists(SHORT_SLEEP))
				[ ] // if (Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.GetStarted.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify reminder displayed on home page", PASS, "No reminder is displayed on Home page")
				[ ] 
				[ ] //Select Bills tab
				[ ] NavigateQuickenTab(sTAB_BILL)
				[ ] 
				[ ] iAddReminder=AddIncomeTransferReminder(rReminderData)
				[+] if(iAddReminder==PASS)
					[ ] ReportStatus("Add Transfer Reminder", PASS, "Transfer reminder added successfully")
					[ ] 
					[ ] //Navigate to Home Page
					[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
					[+] if (iNavigate == PASS)
						[ ] //Check for Get Started button
						[+] if (!MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.GetStarted.Exists(SHORT_SLEEP))
							[ ] ReportStatus("Verify reminder displayed on home page", PASS, "Reminder is displayed on Home page")
							[ ] 
							[ ] //Edit Banking Account
							[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sAccount,sTab)			// Select account
							[+] if (iSelect == PASS)
								[ ] 
								[ ] //Check "Close Account" button
								[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
									[ ] AccountDetails.CloseAccount.Click()
									[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
										[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
										[ ] PermanentlyCloseAccount.OK.Click()
										[+] // 
											[+] if(AlertMessage.Exists(SHORT_SLEEP))
												[ ] //Get alert message
												[ ] sActualMessage=AlertMessage.MessageText.GetText()
												[+] if(MatchStr("{sExpectedMessage1}*",sActualMessage))
													[ ] ReportStatus("Verify alert message", PASS, "Correct alert message is displayed i.e. {sExpectedMessage1}")
												[+] else
													[ ] ReportStatus("Verify alert message", FAIL, "Actual alert message: {sActualMessage} and Expected alert message: {sExpectedMessage1}")
												[ ] AlertMessage.Yes.Click()
												[ ] 
												[ ] //Verify second alert message is not displayed
												[+] if(!AlertMessage.Exists(SHORT_SLEEP))
													[ ] ReportStatus("Verify alert is not displayed and closed te account", PASS, "Alert message is not displayed and Account is closed successfully")
												[+] else
													[ ] ReportStatus("Verify alert is not displayed and closed te account", FAIL, "Alert message is displayed and Account is not closed")
													[ ] AlertMessage.Close()
												[ ] 
												[ ] // // Close Account details window
												[+] // if(AccountDetails.Exists(SHORT_SLEEP))
													[ ] AccountDetails.SetActive()
													[ ] AccountDetails.Close()
												[ ] 
												[ ] //Navigate to Home Page
												[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
												[+] if (iNavigate == PASS)
													[ ] //Check for Get Started button
													[+] if (MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.GetStarted.Exists(SHORT_SLEEP))
														[ ] ReportStatus("Verify reminder displayed on home page", PASS, "Transfer reminder is not displayed on Home page after closing To account {sAccount}")
													[+] else
														[ ] ReportStatus("Verify reminder displayed on home page", FAIL, "Transfer reminder is displayed on Home page even after closing To account {sAccount}")
												[+] else
													[ ] ReportStatus("Navigate to Home Page", FAIL, "Navigation to Home page is failed")
												[ ] 
												[ ] 
											[+] else
												[ ] ReportStatus("Verify alert message dialog", FAIL, "Alert message dialog is not displayed")
											[ ] 
										[ ] // 
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
							[ ] ReportStatus("Verify reminder displayed on home page", FAIL, "Reminder is not displayed on Home page")
					[+] else
						[ ] ReportStatus("Navigate to Home Page", FAIL, "Navigation to Home page is failed")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Add Transfer Reminder",FAIL, "Transfer reminder is not get added")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify reminder displayed on home page", FAIL, "Reminder is displayed on Home page")
		[+] else
			[ ] ReportStatus("Navigate to Home Page", FAIL, "Navigation to Home page is failed")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] QuickenWindow.Kill()
[ ] //###########################################################################
[ ] // 
[+] // //#############Close account having online repeating bill reminders in sent state ########
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test25_CloseAccWithOnlineRepeatingBill()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // User should not be able to close an account if it has online repeating bill reminders in sent state and no pending transaction.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If account is not closed				
		[ ] // //						Fail		If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // 	  Dec 24, 2012		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase Test25_CloseAccWithOnlineRepeatingBill() appstate none
	[ ] // 
	[+] // // Variable declaration
		[ ] // INTEGER iAddReminder,iNavigate
		[ ] // STRING sActualMessage,sTab,sAccount,sExpectedMessage1,sExpectedMessage2
		[ ] // 
		[ ] // IncTranReminderRecord rReminderData 
		[ ] // 
		[ ] // sAccount="Saving 01"
		[ ] // STRING sFileName="OnlineBill"
		[ ] // STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] // STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
		[ ] // 
		[ ] // sExpectedMessage1="This account has one or more scheduled reminders"
		[ ] // sExpectedMessage2="Account not closed"
		[ ] // rReminderData.sReminderType= "Transfer Reminder"
		[ ] // rReminderData.sPayeeName="Payee1"
		[ ] // rReminderData.sDate=FormatDateTime (GetDateTime(), "dd/mm/yyyy")
		[ ] // rReminderData.sToAccount=sAccount
		[ ] // rReminderData.sFromAccount="Saving 02"
		[ ] // rReminderData.sAmount="20"
		[ ] // rReminderData.sMemo="Memo1"
		[ ] // rReminderData.sTag="Tag1"
		[ ] // 
		[ ] // 
		[ ] // 
	[ ] // 
	[+] // if(QuickenMainWindow.Exists(SHORT_SLEEP))
		[ ] // QuickenMainWindow.SetActive ()
		[ ] // 
		[ ] // sCaption = QuickenMainWindow.GetCaption()
		[ ] // bCaption = MatchStr("*{sFileName}*", sCaption)
		[+] // if(bCaption == FALSE)
			[ ] // bExists = FileExists(sDataFile)
			[+] // if(bExists == TRUE)
				[ ] // DeleteFile(sDataFile)
				[ ] // CopyFile(sSourceFile,sDataFile)
				[ ] // OpenDataFile(sFileName)
			[ ] // 
		[ ] // 
		[ ] // 
		[ ] // // Navigate to Home Page
		[ ] // iNavigate = NavigateQuickenTab(sTAB_HOME)
		[+] // if (iNavigate == PASS)
			[ ] // // Check for Get Started button
			[+] // if (Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.GetStarted.Exists(SHORT_SLEEP))
				[ ] // ReportStatus("Verify reminder displayed on home page", PASS, "No reminder is displayed on Home page")
			[+] // else
				[ ] // ReportStatus("Verify reminder displayed on home page", PASS, "Reminder is displayed on Home page")
		[+] // else
			[ ] // ReportStatus("Navigate to Home Page", PASS, "Navigation to Home page is failed")
		[ ] // 
		[ ] // 
		[ ] // // Select Bills tab
		[ ] // NavigateQuickenTab(sTAB_BILL)
		[ ] // 
		[ ] // iAddReminder=AddIncomeTransferReminder(rReminderData)
		[+] // if(iAddReminder==PASS)
			[ ] // ReportStatus("Add Transfer Reminder", PASS, "Transfer reminder added successfully")
		[+] // else
			[ ] // ReportStatus("Add Transfer Reminder",FAIL, "Transfer reminder is not get added")
		[ ] // 
		[ ] // // Navigate to Home Page
		[ ] // iNavigate = NavigateQuickenTab(sTAB_HOME)
		[+] // if (iNavigate == PASS)
			[ ] // // Check for Get Started button
			[+] // if (!Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.GetStarted.Exists(SHORT_SLEEP))
				[ ] // ReportStatus("Verify reminder displayed on home page", PASS, "Reminder is displayed on Home page")
			[+] // else
				[ ] // ReportStatus("Verify reminder displayed on home page", PASS, "Reminder is not displayed on Home page")
		[+] // else
			[ ] // ReportStatus("Navigate to Home Page", PASS, "Navigation to Home page is failed")
		[ ] // 
		[ ] // 
		[ ] // // Edit Banking Account
		[ ] // iSelect = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sAccount,sTab)			// Select account
		[+] // if (iSelect == PASS)
			[ ] // 
			[ ] // // Check "Close Account" button
			[+] // if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
				[ ] // AccountDetails.CloseAccount.Click()
				[+] // if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
					[ ] // PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
					[ ] // PermanentlyCloseAccount.OK.Click()
					[+] // if(AlertMessageForCloseAccount.Exists(SHORT_SLEEP))
						[ ] // // Get alert message
						[ ] // sActualMessage=AlertMessageForCloseAccount.Message.GetText()
						[+] // if(MatchStr("{sExpectedMessage1}*",sActualMessage))
							[ ] // ReportStatus("Verify alert message", PASS, "Correct alert message is displayed i.e. {sExpectedMessage1}")
						[+] // else
							[ ] // ReportStatus("Verify alert message", FAIL, "Actual alert message: {sActualMessage} and Expected alert message: {sExpectedMessage1}")
						[ ] // AlertMessageForCloseAccount.Yes.Click()
						[ ] // 
						[ ] // // Verify second alert message is not displayed
						[+] // if(!AlertMessageForCloseAccount.Exists(SHORT_SLEEP))
							[ ] // ReportStatus("Verify alert is not displayed and closed te account", PASS, "Alert message is not displayed and Account is closed successfully")
						[+] // else
							[ ] // ReportStatus("Verify alert is not displayed and closed te account", FAIL, "Alert message is displayed and Account is not closed")
							[ ] // AlertMessageForCloseAccount.Close()
						[ ] // 
						[ ] // // Close Account details window
						[+] // if(AccountDetails.Exists(SHORT_SLEEP))
							[ ] // AccountDetails.SetActive()
							[ ] // AccountDetails.Close()
						[ ] // 
						[ ] // // Navigate to Home Page
						[ ] // iNavigate = NavigateQuickenTab(sTAB_HOME)
						[+] // if (iNavigate == PASS)
							[ ] // // Check for Get Started button
							[+] // if (Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.GetStarted.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Verify reminder displayed on home page", PASS, "Transfer reminder is not displayed on Home page after closing To account {sAccount}")
							[+] // else
								[ ] // ReportStatus("Verify reminder displayed on home page", FAIL, "Transfer reminder is displayed on Home page even after closing To account {sAccount}")
						[+] // else
							[ ] // ReportStatus("Navigate to Home Page", PASS, "Navigation to Home page is failed")
						[ ] // 
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify alert message dialog", FAIL, "Alert message dialog is not displayed")
						[ ] // 
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Check Permanently Close Account window", FAIL, "Permanently Close Account window is available")
					[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Check Close Account button", FAIL, "Close button is not available")
				[ ] // 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate Account selection", iSelect, "Banking Account is not selected from Account bar")
			[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] // 
	[ ] // 
[ ] // //###########################################################################
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
	[ ] 
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] SetUp_AutoApi()
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile))
		[ ] //
		[ ] DeleteFile(sDataFile)
		[ ] //QuickenWindow.Start (sCmdLine)
	[ ] 
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] 
	[ ] //Creating a Data file
	[-] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Create Data File
		[ ] iCreateDataFile = OpenDataFile(sFileName)
		[ ] 
		[ ] //Report Staus If Data file Created successfully
		[ ] 
		[-] if(iCreateDataFile==PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] 
			[ ] // Set Classic View
			[ ] SetViewMode(VIEW_CLASSIC_MENU)
			[ ] 
			[-] //Need to remove----
				[ ] // RegisterQuickenConnectedServices()
				[ ] // 
				[ ] // //Fetching 3rd Row data in a list
				[ ] // lsAccountBrokerage = lsExcelData[3]
				[ ] // lsAccountBrokerage[4]=sDateStamp
				[ ] // 
				[+] // for(i=1;i<=ListCount(lsExcelData)-1;i++)
					[ ] // //Add Checking Account
					[ ] // lsAccountChecking = lsExcelData[i]
					[+] // if (lsAccountChecking[1]==NULL)
						[ ] // break
					[ ] // lsAccountChecking[4] = sDateStamp
					[ ] // 
					[ ] // //Add Checking Account
					[ ] // iAddAccount = AddManualSpendingAccount(lsAccountChecking[1], lsAccountChecking[2], lsAccountChecking[3], lsAccountChecking[4])
					[ ] // 
					[ ] // //Report Status if checking Account is created
					[+] // if (iAddAccount==PASS)
						[ ] // 
						[ ] // ReportStatus("{lsAccountChecking[1]} Account", iAddAccount, "{lsAccountChecking[2]} Account - is created successfully")
						[ ] // 
						[ ] // //This will click on Banking account on AccountBar
						[ ] // iSelect = SelectAccountFromAccountBar(ACCOUNT_BANKING, 1)
						[ ] // 
						[ ] // ReportStatus("Select Account", iSelect, "Banking Account {lsAccountChecking[2]} is selected") 
						[ ] // 
						[ ] // lsExcelData=ReadExcelTable(sHiddenAccountData, sTransactionSheet)
						[ ] // 
						[ ] // //Add Payment Transaction to account
						[+] // for(i=1;i<=ListCount(lsExcelData);i++)
							[ ] // lsTransaction = lsExcelData[i]
							[ ] // ///Adding Transactions in this fashion : ("MDI","ATM","<Amount>","<Date>","<Payee>","<Memo>","<Category>")
							[+] // if(lsTransaction[1]==NULL)
								[ ] // break
							[ ] // lsTransaction[4] = sDateStamp
							[ ] // iAddTransaction= AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
							[+] // if(iAddTransaction==PASS)
								[ ] // ReportStatus("Add Transaction: {lsTransaction[2]} ", iAddTransaction, "{lsTransaction[2]} Transaction is added to banking account") 
							[+] // else
								[ ] // ReportStatus("Verification of {lsTransaction[2]} account window", FAIL, "{lsTransaction[2]} account window not found") 
						[ ] // 
					[ ] // 
					[+] // else
						[ ] // ReportStatus("{lsAccountChecking[1]} Account", iAddAccount, "{lsAccountChecking[1]} Account -  {lsAccountChecking[2]}  is not created successfully")
				[ ] // 
				[ ] // 
				[ ] // //Add Brokerage Account
				[ ] // iAddAccount = AddManualBrokerageAccount(lsAccountBrokerage[1],lsAccountBrokerage[2],lsAccountBrokerage[3],lsAccountBrokerage[4])
				[ ] // 
				[ ] // lsExcelData=ReadExcelTable(sHiddenAccountData, sInvestingTransactionWorksheet)
				[ ] // 
				[ ] // //Report Status if Brokerage Account is created
				[+] // if (iAddAccount==PASS)
					[ ] // 
					[ ] // ReportStatus("{lsAccountBrokerage[1]} Account", iAddAccount, "{lsAccountBrokerage[1]} Account - is created successfully")
					[ ] // 
					[ ] // //This will click on INVESTING account on AccountBar
					[ ] // iSelect = SelectAccountFromAccountBar(ACCOUNT_INVESTING, 1)
					[ ] // 
					[ ] // ReportStatus("Select Account", iSelect, "Banking Account {lsAccountBrokerage[2]} is selected") 
					[ ] // 
					[ ] // //Add Payment Transaction to account
					[+] // for(i=1;i<=ListCount(lsExcelData)-2;++i)
						[ ] // 
						[+] // if(lsExcelData[i][1]==NULL)
							[ ] // break
						[ ] // 
						[ ] // lsExcelData[i][5] = sDateStamp
						[ ] // iAddTransaction=AddBrokerageTransaction(lsExcelData[i])
						[ ] // 
						[+] // if(iAddTransaction==PASS)
							[ ] // ReportStatus("Add Transaction: {lsExcelData[i][1]} ", iAddTransaction, "{lsExcelData[i][1]} Transaction is added to banking account") 
						[+] // else
							[ ] // ReportStatus("Verification of {lsExcelData[i][1]} account window", FAIL, "{lsExcelData[i][1]} account window not found") 
				[+] // else
					[ ] // ReportStatus("{lsAccountBrokerage[1]} Account", iAddAccount, "{lsAccountBrokerage[1]} Account -  {lsAccountBrokerage[2]}  is not created successfully")
			[ ] 
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
	[ ] QuickenWindow.Kill()
[ ] // ###########################################################################
[ ] 
[ ] 
[ ] //******************************************************************************************************************************************
[ ] 
