﻿[ ] 
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
	[+] // TestCase Name:	 Banking_SetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the SavingGoal.QDF if it exists. It will setup the necessary pre-requisite for tests
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  June 20, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[-] testcase Banking_SetUp () appstate QuickenBaseState
	[ ] 
	[ ] // Variable declaration
	[ ] INTEGER iRegistration
	[ ] List of LIST OF STRING lsAccount
	[ ] STRING sFileName = "HiddenAccountBanking"
	[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
	[ ] 
	[+] //Need to remove 
		[ ] // //lsAccount = {{"Checking","Checking 01","500", "{sDateStamp}"},{"Checking","Checking 02","200", "{sDateStamp}"},{"Checking","Checking 03","100", "{sDateStamp}"},{"Savings","Saving 01","500", "{sDateStamp}"},{"Savings","Saving 02","200", "{sDateStamp}"}}
		[ ] // sTransactionType = "Payment"
		[ ] // sAmount = "50"
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
	[ ] //SkipRegistration
	[ ] SkipRegistration()
	[ ] 
	[ ] 
	[ ] 
	[ ] // Open Data File
	[ ] iCreateDataFile = OpenDataFile(sFileName)
	[ ] 
	[ ] // Report Staus If Data file Created successfully
	[+] if ( iCreateDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is Opened")
		[ ] //RegisterQuickenConnectedServices()
	[+] else 
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is not Opened")
	[ ] 
	[ ] // Set Classic View
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] // Bypass Registration
	[ ] iRegistration=BypassRegistration()
	[ ] // Select Home tab
	[ ] NavigateQuickenTab(sTAB_HOME)
	[ ] // Off Popup Register
	[ ] UsePopUpRegister("OFF")
	[ ] sleep(1)
	[ ] 
	[ ] 
	[+] // for(i=1;i<=Listcount(lsAccount);i++)
		[ ] // // Add Checking Account
		[ ] // iAddAccount = AddManualSpendingAccount(lsAccount[i][1], lsAccount[i][2], lsAccount[i][3], lsAccount[i][4])
		[ ] // // Report Status if checking Account is created
		[+] // if (iAddAccount==PASS)
			[ ] // ReportStatus("{lsAccount[i][1]} Account", iAddAccount, "{lsAccount[i][1]} Account -  {lsAccount[i][2]}  is created successfully")
			[ ] // 
			[ ] // // This will click on Banking account on AccountBar
			[ ] // iSelect = SelectAccountFromAccountBar(ACCOUNT_BANKING, i)
			[ ] // ReportStatus("Select Account", iSelect, "Banking Account {lsAccount[i][2]} is selected") 
			[ ] // sleep(5)
			[ ] // // Add Payment Transaction to account
			[ ] // iAddTransaction= AddCheckingTransaction(sWindowType,sTransactionType, sAmount, sDateStamp)
			[ ] // ReportStatus("Add Transaction", iAddTransaction, "Transaction is added to banking account") 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("{lsAccount[i][1]} Account", iAddAccount, "{lsAccount[i][1]} Account -  {lsAccount[i][2]}  is not created successfully")
	[ ] // 
	[ ] // 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Verify UI of Display Options Tab ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_DisplayOptions()
		[ ] //
		[ ] // DESCRIPTION:
		[+] // This testcase will verify UI of Display Options tab: 
			[ ] // In Account Display  section following three check boxes should be listed-
			[ ] // A-Keep this account separate-Account would be excluded from Quicken reports and features.
			[ ] // B-Hide in Transaction entry lists-account will not display as an option in most lists by default.
			[ ] // C-Hide account name from account bar and account list.
			[ ] // Close account button with its description should be displayed in "Account Display" section.
			[ ] // Help Icon(?),Delete Account,Tax Schedule and Cancel buttons should be displayed on bottom of the pop up.
			[ ] 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass     If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Sep 26, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_DisplayOptions () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iAction
		[ ] sAccount="Checking 01"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] 
		[ ] // Edit Checking Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sAccount,sTab)			// Select checking account
		[+] if (iSelect == PASS)
			[ ] AccountDetails.SetActive()
			[ ] // Verify "Keep This Account Separate" checkbox
			[+] if(AccountDetails.KeepThisAccountSeparate.Exists(1))
				[ ] 
				[ ] ReportStatus("Validate Account Display Options", PASS, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Account Display Options", FAIL, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is not available")
				[ ] 
			[ ] 
			[ ] // Verify "Hide in transaction entry lists" checkbox
			[+] if(AccountDetails.HideInTransactionEntryList.Exists(1))
				[ ] ReportStatus("Validate Account Display Options", PASS, "Second Checkbox: Hide in transaction entry lists is displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Account Display Options", FAIL, "Second Checkbox: Hide in transaction entry lists is not available")
				[ ] 
			[ ] 
			[ ] // Verify "Hide account name in account bar and account list" checkbox
			[+] if(AccountDetails.HideAccountNameInAccountB.Exists(1))
				[ ] ReportStatus("Validate Account Display Options", PASS, "Third Checkbox: Hide account name in account bar and account list is displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Account Display Options", FAIL, "Third Checkbox: Hide account name in account bar and account list is not available")
				[ ] 
			[ ] 
			[ ] // Verify "Close Account" button
			[+] if(AccountDetails.CloseAccount.Exists(1))
				[ ] ReportStatus("Validate Account Display Options", PASS, "Closed Account button is displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Account Display Options", FAIL, "Closed Account button is not available")
				[ ] 
			[ ] 
			[ ] // Verify "Help" icon
			[ ] AccountDetails.SetActive()
			[ ] AccountDetails.HelpIcon.Click()
			[ ] //BankingPopUp.SplitButton.Click()
			[ ] 
			[+] if(QuickenHelp.Exists(SHORT_SLEEP))
				[ ] QuickenHelp.SetActive()
				[ ] ReportStatus("Validate Account Display Options", PASS, "Help icon is displayed")
				[ ] QuickenHelp.Close()
			[+] else
				[ ] ReportStatus("Validate Account Display Options", FAIL, "Help icon is not available")
				[ ] 
			[ ] 
			[ ] // Verify "Delete Account" button
			[+] if(AccountDetails.DeleteAccountButton.Exists(1))
				[ ] ReportStatus("Validate Account Display Options", PASS, "Delete Account button is displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Account Display Options", FAIL, "Delete Account button is not available")
				[ ] 
			[ ] 
			[ ] // Verify "Tax Schedule" button
			[+] if(AccountDetails.TaxSchedule.Exists(1))
				[ ] ReportStatus("Validate Account Display Options", PASS, "Tax Schedule button is displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Account Display Options", FAIL, "Tax Schedule button is not available")
				[ ] 
			[ ] 
			[ ] // Verify "Cancel" button
			[+] if(AccountDetails.Cancel.Exists(1))
				[ ] ReportStatus("Validate Account Display Options", PASS, "Cancel button is displayed")
				[ ] AccountDetails.Cancel.Click()
			[+] else
				[ ] ReportStatus("Validate Account Display Options", FAIL, "Cancel button is not available")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "First Banking Account is not selected from Account bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Verify Keep this account separate #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_SeparateAccountVerification()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check Account Display option "-Keep this account separate-Account would be excluded from Quicken reports and features."  for a Checking account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no errors occurs						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Sep 26, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test02_SeparateAccountVerification () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iReportSelect,iCount
		[ ] STRING sReport
		[ ] sAccount = "Checking 01"
		[ ] sReport="Net Worth & Balances"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Check whether Property aand Debt is checked or not: View Menu > Tabs to Show > Property aand Debt
		[ ] // QuickenWindow.View.Click()
		[ ] // bCheckStatus=QuickenWindow.View.TabsToShow.PropertyDebt.GetProperty("IsChecked")
		[+] // if(bCheckStatus == FALSE)	
			[ ] // QuickenWindow.SetActive ()
			[ ] // QuickenWindow.View.Click()
			[ ] // QuickenWindow.View.TabsToShow.Click()
			[ ] // QuickenWindow.View.TabsToShow.PropertyDebt.Select()
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] // Open Net Worth Report
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Reports.Click()
		[ ] QuickenWindow.Reports.Graphs.Click()
		[ ] QuickenWindow.Reports.Graphs.NetWorth.Select()
		[ ] 
		[ ] // iReportSelect = OpenReport(sReport, sREPORT_NETWORTH)		// OpenReport("Net Worth & Balances", "Net Worth")
		[ ] // 
		[ ] // ReportStatus("Run {sREPORT_NETWORTH} Report", iReportSelect, "Run Report successful") 
		[+] if(NetWorthReports.Exists(2))
			[ ] NetWorthReports.SetActive()
			[ ] NetWorthReports.ShowReport.Click()
			[ ] iCount = NetWorthReports.QWListViewer1.ListBox1.GetItemCount()
			[+] for(i=iCount;i>=1;i--)
				[ ] 
				[ ] sHandle = Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())	   // get the handle
				[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
				[ ] bMatch = MatchStr("*1,450.00*", sActual)						
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify Networth Amount", PASS, "Correct Networth amount 1,450.00 is displayed") 
					[ ] break
				[+] else
					[ ] continue
					[+] if(i==1)
						[ ] ReportStatus("Verify Networth amount", FAIL, "Actual networth amount {sActual} does not match with excpected amount 1,450.00") 
						[ ] 
					[ ] 
				[ ] 
			[+] if(NetWorthReports.Exists(SHORT_SLEEP))
				[ ] NetWorthReports.SetActive()
				[ ] NetWorthReports.Close()
			[ ] 
			[ ] 
			[ ] // Edit Checking Account
			[ ] iSelect = SeparateAccount(ACCOUNT_BANKING,sAccount)			// Select first checking account
			[+] if (iSelect == PASS)
				[ ] 
				[ ] // Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
				[+] if (iSeparate == PASS)
					[ ] AccountDetails.Cancel.Click()
					[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and checking account is displayed under this section")
				[+] else
					[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Separate section is not created")
				[ ] 
				[ ] // Verify Account is available in account list even if "Keep This Account Separate" checkbox is checked
				[ ] QuickenWindow.SetActive()
				[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
				[+] if(iNavigate == PASS)
					[ ] AccountList.SetActive()
					[ ] AccountList.Maximize()
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
					[ ] 
					[ ] // ####### Validate Account in Account List window #####################
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
					[ ] bMatch = MatchStr("*{sAccount}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Separate Account in Account List", PASS, "{sAccount} account is present in Account List") 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Separate Account in Account List", FAIL, "{sAccount} account is not present in Account List") 
						[ ] 
					[ ] AccountList.Close ()
				[+] else
					[ ] ReportStatus("Validate Account List window", FAIL, "Account List  window is not opened") 
				[ ] 
				[ ] // Open Net Worth Report and Verify
				[ ] QuickenWindow.SetActive ()
				[ ] QuickenWindow.Reports.Click()
				[ ] QuickenWindow.Reports.Graphs.Click()
				[ ] QuickenWindow.Reports.Graphs.NetWorth.Select()
				[ ] 
				[ ] // iReportSelect = OpenReport(sReport, sREPORT_NETWORTH)		// OpenReport("Net Worth & Balances", "Net Worth")
				[ ] // ReportStatus("Run {sREPORT_NETWORTH} Report", iReportSelect, "Run Report successful") 
				[ ] 
				[+] if (NetWorthReports.Exists(2))
					[ ] ReportStatus("Validate Net Worth report", PASS, "Net Worth report opened successful") 
					[ ] // Set Activate Net Worth window
					[ ] NetWorthReports.SetActive()
					[ ] NetWorthReports.ShowReport.Click()
					[ ] iCount = NetWorthReports.QWListViewer1.ListBox1.GetItemCount()
					[+] for(i=iCount;i>=1;i--)
						[ ] sHandle = Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())	   // get the handle
						[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
						[ ] bMatch = MatchStr("*1,000.00*", sActual)						
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Verify Networth Amount", PASS, "Correct Networth amount 1,000.00 is displayed") 
							[ ] break
						[+] else
							[ ] continue
							[+] if(i==1)
								[ ] ReportStatus("Verify Networth amount", FAIL, "Actual networth amount {sActual} does not match with excpected amount 1,000.00") 
								[ ] 
						[ ] 
					[+] if(NetWorthReports.Exists(SHORT_SLEEP))
						[ ] NetWorthReports.SetActive()
						[ ] NetWorthReports.Close()
				[+] else
					[ ] ReportStatus("Validate Net Worth Report", FAIL, "Net Worth Report not opened successful") 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Account separation", iSelect, "Account {sAccount} is not separated")
				[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Validate Net Worth Report", FAIL, "Net Worth Report not opened successful") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Verify Hide in Transaction entry lists ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_HideInTransactionEntryListVerification()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check Account Display option - "Hide In Transaction Entry List" for a Checking account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no errors ouccurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Sep 26, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_HideInTransactionEntryListVerification () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iReportSelect,iCount
		[ ] STRING sReport
		[ ] sAccount = "Checking 02"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Edit Checking Account
		[ ] iSelect = AccountHideInTransactionList(ACCOUNT_BANKING,sAccount,1)			// Select checking account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] // Verify account name in register
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] // Click on All Transactions link
			[ ] 
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.AllTransactions.Click()
			[ ] 
			[ ] QuickenWindow.TypeKeys("<Ctrl-n>")	// highlight the new row
			[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDateStamp)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
			[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_ESCAPE)
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account is hidden in transaction entry list", iSelect, "Banking Account {sAccount} is not hidden in transaction entry list")
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
	[+] // TestCase Name:	 Test02_SeparateAccountVerification()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check Account Display option - "Hide account name from account bar and account list" for a Checking account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no errors ouccurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Sep 26, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test04_HideAccountFromAccountBarVerification () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCount,j,iReportSelect
		[ ] STRING sReport,sNetWorth
		[ ] sAccount = "Checking 02"
		[ ] sNetWorth="1,000.00"
		[ ] sReport="Net Worth & Balances"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify account name in Account List
		[ ] 
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
		[+] if(iNavigate == PASS)
			[ ] iCount=AccountList.QWinChild.Order.ListBox.GetItemCount()
			[+] for(i=2;i<=iCount;i++)
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
				[ ] 
				[ ] // ####### Validate Accounts in Account List window #####################
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
				[ ] bMatch = MatchStr("*{sAccount}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] j=i
					[ ] ReportStatus("Validate Account in Account List and Account Bar", PASS, "Account is available in Account list and Account Bar") 
					[ ] break
				[+] else
					[ ] continue
					[+] if(i==iCount)
						[ ] ReportStatus("Validate Account in Account List and Account", FAIL, "Account {sAccount} is not available in Account List and Account Bar") 
				[ ] 
		[+] if(AccountList.Exists(SHORT_SLEEP))
			[ ] AccountList.SetActive()
			[ ] AccountList.Close()
		[ ] 
		[ ] // Edit Checking Account
		[ ] iSelect = AccountHideInAccountBarAccountList(ACCOUNT_BANKING,sAccount,1)			// Select checking account
		[+] if (iSelect == PASS)
				[ ] ReportStatus("Check Hide account name from account bar and account list checkbox", PASS, "Third Checkbox: Hide account name from account bar and account list is checked")
				[ ] 
				[ ] // Verify account name in Account List
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
				[+] if(iNavigate == PASS)
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
					[ ] 
					[ ] // ####### Validate Accounts in Account List window #####################
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(j))
					[ ] bMatch = MatchStr("*Checking 02*", sActual)
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
				[+] // if(AccountList.Exists(SHORT_SLEEP))
					[ ] // AccountList.SetActive()
					[ ] // AccountList.Close()
				[ ] 
				[ ] // Open Net Worth Report and Verify
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive ()
				[ ] QuickenWindow.Reports.Click()
				[ ] QuickenWindow.Reports.Graphs.DoubleClick()
				[ ] QuickenWindow.Reports.Graphs.NetWorth.Select()
				[ ] 
				[ ] // iReportSelect = OpenReport(sReport, sREPORT_NETWORTH)		// OpenReport("Net Worth & Balances", "Net Worth")
				[ ] // ReportStatus("Run {sREPORT_NETWORTH} Report", iReportSelect, "Run Report successful")
				[ ] 
				[ ] 
				[+] if (NetWorthReports.Exists(2))
					[ ] ReportStatus("Validate Net Worth report", PASS, "Net Worth report opened successful") 
					[ ] // Set Activate Net Worth window
					[ ] NetWorthReports.SetActive()
					[ ] NetWorthReports.ShowReport.Click()
					[ ] iCount = NetWorthReports.QWListViewer1.ListBox1.GetItemCount()
					[+] for(i=iCount;i>=1;i--)
						[ ] sHandle = Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())	   // get the handle
						[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
						[ ] bMatch = MatchStr("*{sNetWorth}*", sActual)						
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Verify Networth Amount", PASS, "Correct Networth amount {sNetWorth} is displayed") 
							[ ] break
						[+] else
							[ ] continue
							[+] if(i==1)
								[ ] ReportStatus("Verify Networth amount", FAIL, "Actual networth amount {sActual} does not match with excpected amount {sNetWorth}") 
								[ ] 
						[ ] 
					[+] if(NetWorthReports.Exists(SHORT_SLEEP))
						[ ] NetWorthReports.SetActive()
						[ ] NetWorthReports.Close()
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Check Hide account name from account bar and account list checkbox", FAIL, "Third Checkbox: Hide account name from account bar and account list is not available")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Close Account ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_CloseAccountVerification()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will close Checking account and verify
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If banking account closed successfully						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Sep 26, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test05_CloseAccountVerification () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iNavigate,iCount,iReportSelect
		[ ] STRING sSearch,sNetWorth,sReport
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Checking 03"
		[ ] sNetWorth="950.00"         
		[ ] sReport="Net Worth & Balances"
		[ ] sWindowType = "MDI"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Edit Checking Account
		[ ] iSelect = CloseAccount(ACCOUNT_BANKING,sAccount)			// Select checking account
		[+] if (iSelect == PASS)
				[ ] 
				[ ] // Verify offset entry
				[ ] //iSelect = SelectAccountFromAccountBar(ACCOUNT_BANKING, 1)	// select  checking account
				[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("Select Closed Account", iSelect, "Closed Account is selected") 
					[ ] 
					[ ] iValidate = FindTransaction(sWindowType,sSearch,ACCOUNT_BANKING)		// find transaction
					[+] if(iValidate == PASS)
						[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found") 
					[+] else
						[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
					[ ] 
				[+] else
					[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
					[ ] 
				[ ] 
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive ()
				[ ] QuickenWindow.Reports.Click()
				[ ] QuickenWindow.Reports.Graphs.Click()
				[ ] QuickenWindow.Reports.Graphs.NetWorth.Select()
				[ ] 
				[ ] // // Open Net Worth Report and Verify
				[ ] // iReportSelect = OpenReport(sReport, sREPORT_NETWORTH)		// OpenReport("Net Worth & Balances", "Net Worth")
				[ ] // ReportStatus("Run {sREPORT_NETWORTH} Report", iReportSelect, "Run Report successful") 
				[+] if(NetWorthReports.Exists(2))
					[ ] NetWorthReports.SetActive()
					[ ] NetWorthReports.ShowReport.Click()
					[ ] iCount = NetWorthReports.QWListViewer1.ListBox1.GetItemCount()
					[+] for(i=iCount;i>=1;i--)
						[ ] sHandle = Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())	   // get the handle
						[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
						[ ] bMatch = MatchStr("*{sNetWorth}*", sActual)						
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Verify Networth Amount", PASS, "Correct Networth amount {sNetWorth} is displayed") 
							[ ] break
						[+] else
							[ ] continue
							[+] if(i==1)
								[ ] ReportStatus("Verify Networth amount", FAIL, "Actual networth amount {sActual} does not match with excpected amount {sNetWorth}") 
								[ ] 
						[ ] 
					[+] if(NetWorthReports.Exists(SHORT_SLEEP))
						[ ] NetWorthReports.SetActive()
						[ ] NetWorthReports.Close()
				[ ] 
				[ ] // Verify account name in Account List
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
				[+] if(iNavigate == PASS)
					[ ] iCount=AccountList.QWinChild.Order.ListBox.GetItemCount()
					[+] for(i=3;i<=iCount;i++)
						[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
						[ ] 
						[ ] // ####### Validate Accounts in Account List window #####################
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
						[ ] bMatch = MatchStr("*{sAccount}*", sActual)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Validate Account in Account List and Account Bar", PASS, "Account is available in Account list and Account Bar") 
							[ ] break
						[+] else
							[ ] continue
							[+] if(i==iCount)
								[ ] ReportStatus("Validate Account in Account List and Account", FAIL, "Account {sAccount} is not available in Account List and Account Bar") 
						[ ] 
				[+] if(AccountList.Exists(SHORT_SLEEP))
					[ ] AccountList.SetActive()
					[ ] AccountList.Close()
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify close account", FAIL, "Account is not closed")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############  Verify Closed account as Separate #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_MakeClosedAccountAsSeparate()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check a closed account could be separated
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] //						Fail		If any error occurs
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Oct 03, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test07_MakeClosedAccountAsSeparate () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] sAccount="Checking 03"
		[ ] sWindowType = "MDI"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Edit Checking Account
		[ ] iSelect = SeparateAccount(ACCOUNT_BANKING,sAccount)			// Select first checking account
		[+] if (iSelect == PASS)
			[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", PASS, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is checked")
			[ ] 
			[ ] // Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE,sAccount,sTab)
			[+] if (iSeparate == PASS)
				[ ] 
				[+] if(AccountDetails.KeepThisAccountSeparate.IsChecked())
					[ ] AccountDetails.Cancel.Click()
					[ ] ReportStatus("Verify closed account in Separate section in Account Bar", PASS, "Closed account is displayed under Separate section in Account Bar")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify closed account in Separate section in Account Bar", FAIL, "Closed account is not displayed under Separate section in Account Bar")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Account is not displayed under Separate section")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", FAIL, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is not available")
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
	[+] // TestCase Name:	 Test08_MakeHiddenAccountFromAccountBarAsSeparate()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will make account (Hidden account from account bar and account list) as Separate
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] //						PASS		If no error occurs
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Sep 26, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test08_MakeHiddenAccountFromAccountBarAsSeparate () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iReportSelect,iCount,iXCords,iYCords
		[ ] STRING sNetWorth,sReport,sTab
		[ ] sTab="Display Options"
		[ ] sAccount = "Checking 02"
		[ ] sNetWorth="800.00"          // 950.00 (previous networth) -150.00 (Hidden account is made separated)
		[ ] sReport="Net Worth & Balances"
		[ ] iXCords = 64
		[ ] iYCords = 9
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSelect=AccountBarSelect(ACCOUNT_BANKING, 3)
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(Replicate(KEY_DN,1))
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_ENTER)
		[ ] sleep(3)
		[+] if(iSelect==PASS)
			[ ] 
			[ ] // Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
			[ ] NavigateToAccountDetails(sAccount)
			[ ] SelectAccountDetailsTabs(ACCOUNT_BANKING,sTab)
			[+] if(AccountDetails.KeepThisAccountSeparate.Exists(SHORT_SLEEP))
				[ ] AccountDetails.KeepThisAccountSeparate.Check()
				[ ] AccountDetails.OK.Click()
				[ ] iSeparate=PASS
				[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", PASS, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is checked")
			[+] else
				[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", FAIL, "Keep this account separate- account will be excluded from Quicken reports and features is not checked")
				[ ] 
			[ ] 
			[ ] 
			[+] if(iSeparate == PASS)
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive ()
				[ ] QuickenWindow.Reports.Click()
				[ ] QuickenWindow.Reports.Graphs.DoubleClick()
				[ ] QuickenWindow.Reports.Graphs.NetWorth.Select()
				[ ] 
				[ ] // Open Net Worth Report and Verify
				[ ] // iReportSelect = OpenReport(sReport, sREPORT_NETWORTH)		// OpenReport("Net Worth & Balances", "Net Worth")
				[ ] // ReportStatus("Run {sREPORT_NETWORTH} Report", iReportSelect, "Run Report successful") 
				[+] if(NetWorthReports.Exists(2))
						[ ] NetWorthReports.SetActive()
						[ ] NetWorthReports.ShowReport.Click()
					[ ] iCount = NetWorthReports.QWListViewer1.ListBox1.GetItemCount()
					[+] for(i=iCount;i>=1;i--)
						[ ] sHandle = Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())	   // get the handle
						[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
						[ ] bMatch = MatchStr("*{sNetWorth}*", sActual)						
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Verify Networth Amount", PASS, "Correct Networth amount {sNetWorth} is displayed") 
							[ ] break
						[+] else
							[ ] continue
							[+] if(i==1)
								[ ] ReportStatus("Verify Networth amount", FAIL, "Actual networth amount {sActual} does not match with excpected amount {sNetWorth}") 
								[ ] 
						[ ] 
					[+] if(NetWorthReports.Exists(SHORT_SLEEP))
						[ ] NetWorthReports.SetActive()
						[ ] NetWorthReports.Close()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", FAIL, "First Checkbox: Keep this account separate- account will be excluded from Quicken reports and features is not available")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Account is not displayed under Separate section")
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
	[ ] 
[ ] //###########################################################################
[ ] 
[+] // //#############Verify Hide account name from account bar and account list ############
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test09_SetupOnlineOptionForClosedAccount()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify that setup online menu item should not not be available for Closed banking Account
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	If setup online menu item should not not be available for Closed banking Account						
		[ ] // //						Fail		If setup online menu is available for closed account or any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // 	  Mar 22, 2013		Udita Dube	created
	[ ] // // ********************************************************
	[ ] // 
[+] // testcase Test09_SetupOnlineOptionForClosedAccount () appstate none
	[ ] // 
	[+] // // Variable declaration
		[ ] // INTEGER iValidate
		[ ] // sAccount = "Saving 01"
		[ ] // 
	[ ] // 
	[+] // if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] // QuickenWindow.SetActive ()
		[ ] // 
		[ ] // // Edit Checking Account
		[ ] // iSelect = SelectAccountFromAccountBar(ACCOUNT_BANKING,1)		// Select saving account 
		[+] // if (iSelect == PASS)
			[ ] // 
			[ ] // QuickenWindow.SetActive()
			[ ] // QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
			[ ] // QuickenWindow.TypeKeys(KEY_DN)
			[ ] // QuickenWindow.TypeKeys(KEY_DN)
			[ ] // QuickenWindow.TypeKeys(KEY_ENTER)
			[ ] // 
			[ ] // // Check "Keep This Account Separate" checkbox
			[+] // if(DlgActivateOneStepUpdate.Exists(SHORT_SLEEP))
				[ ] // ReportStatus("Verify Activate One Step Update window", PASS, "Setup Online option is available in Account Actions for {sAccount}")
				[ ] // DlgActivateOneStepUpdate.Close()
				[ ] // 
				[ ] // iValidate= CloseAccount(ACCOUNT_BANKING,sAccount,1)
				[+] // if(iValidate==PASS)
					[ ] // ReportStatus("Close account {sAccount}",iValidate,"Account {sAccount} is closed")
					[ ] // SelectAccountFromAccountBar(ACCOUNT_BANKING,1)
					[ ] // QuickenWindow.SetActive()
					[ ] // QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
					[ ] // QuickenWindow.TypeKeys(KEY_DN)
					[ ] // QuickenWindow.TypeKeys(KEY_DN)
					[ ] // QuickenWindow.TypeKeys(KEY_ENTER)
					[+] // if(AccountDetails.Exists(SHORT_SLEEP))
						[ ] // AccountDetails.Close()
						[ ] // ReportStatus("Verify Activate One Step Update window for closed Saving account", PASS, "Setup Online option is not available in Account Actions for closed {sAccount}")
					[+] // else
						[ ] // ReportStatus("Verify Activate One Step Update window for closed Saving account", FAIL, "Setup Online option is not available in Account Actions for closed {sAccount}")
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Close account {sAccount}",FAIL,"Account {sAccount} is closed")
					[ ] // 
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify Activate One Step Update window", FAIL, "Setup Online option is not available in Account Actions for {sAccount}")
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
[ ] 
[ ] //******************************************************************************************************************************************
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
	[ ] // Create Data File
	[ ] iCreateDataFile = OpenDataFile(sFileName)
	[ ] 
	[ ] // Set Classic View
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] // Bypass Registration
	[ ] iRegistration=BypassRegistration()
	[ ] // Select Home tab
	[ ] NavigateQuickenTab(sTAB_HOME)
	[ ] // // Off Popup Register
	[ ] // UsePopUpRegister("OFF")
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
						[ ] AccountDetails.Close()
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
				[ ] // Select Account in account bar
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
				[ ] wEnterTransaction.EnterTransaction.TypeKeys(KEY_ALT_G)
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
				[ ] 
				[+] // Verify account name in register
					[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
					[+] if(wEnterTransaction.Exists(5))
						[ ] wEnterTransaction.SetActive()
						[ ] // Open Buy transaction window
						[ ] wEnterTransaction.EnterTransaction.SetFocus()
						[ ] wEnterTransaction.EnterTransaction.TypeKeys(KEY_ALT_G)
						[ ] wEnterTransaction.UseCashForThisTransaction.Select("From:")
						[ ] iCount=wEnterTransaction.FromAccountList.FindItem(sAccount)
						[+] if(iCount==0)
							[ ] ReportStatus("Verify account which is hidden from transaction list",PASS,"{sAccount} is not available in brokerage transaction as it is hidden from transaction list")
						[+] else
							[ ] ReportStatus("Verify account which is hidden from transaction list",FAIL,"{sAccount} is available in brokerage transaction even if it is hidden from transaction list")
							[ ] 
						[ ] wEnterTransaction.Cancel.Click() 	 	
					[+] else
						[ ] ReportStatus("Verify Enter Transaction window",FAIL,"Enter Transaction window is not displayed")
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
					[+] else
						[ ] ReportStatus("Navigate to Account List",FAIL,"Account List is not opened")
				[ ] 
				[+] // Verify account "Separate" section 
					[ ] NavigateQuickenTab(sTAB_HOME)
					[ ] iSeparate=SelectAccountFromAccountBar("More Accounts",ACCOUNT_SEPARATE)
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer7.ListBox.TypeKeys(Replicate(KEY_DN,1))
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer7.ListBox.TypeKeys(KEY_ENTER)
					[+] if (iSeparate == PASS)
						[ ] iNavigate=NavigateToAccountDetails(sAccount)
						[ ] // Click on Display Option Tab
						[ ] AccountDetails.TextClick(sTab)
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
				[+] // Close account
					[ ] SelectAccountFromAccountBar("More Accounts",ACCOUNT_SEPARATE)
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer7.ListBox.TypeKeys(Replicate(KEY_DN,1))
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer7.ListBox.TypeKeys(KEY_ENTER)
					[ ] NavigateToAccountDetails(sAccount)
					[ ] AccountDetails.TextClick(sTAB_DISPLAY_OPTIONS) 
					[ ] 
					[ ] // Check "Close Account" button
					[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
						[ ] AccountDetails.CloseAccount.Click()
						[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
							[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
							[ ] PermanentlyCloseAccount.OK.Click()
							[+] if(AlertMessage.Exists(SHORT_SLEEP))
								[ ] AlertMessage.SetActive()
								[ ] AlertMessage.OK.Click()
								[ ] 
							[ ] AccountDetails.Close()
							[ ] ReportStatus("Verify close investing account",PASS,"Investing account {sAccount} is closed")
							[ ] 
							[ ] // Verify account is closed
							[ ] SelectAccountFromAccountBar("More Accounts",ACCOUNT_SEPARATE)
							[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer7.ListBox.TypeKeys(Replicate(KEY_DN,1))
							[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer7.ListBox.TypeKeys(KEY_ENTER)
							[ ] NavigateToAccountDetails(sAccount)
							[ ] AccountDetails.TextClick(sTAB_DISPLAY_OPTIONS) 
							[+] if(!AccountDetails.CloseAccount.IsEnabled())
								[ ] ReportStatus("Verify Close Account button is disabled", PASS, "Close Account button is disabled hence {sAccount} is closed")
								[ ] iFunctionResult=PASS 
							[+] else
								[ ] ReportStatus("Verify Close Account button is disabled", FAIL, "Close Account button is enabled hence {sAccountName} is not closed") 
								[ ] iFunctionResult=FAIL
							[ ] AccountDetails.Close()
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Check Permanently Close Account window", FAIL, "Permanently Close Account window is not available")
							[ ] iFunctionResult=FAIL
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Close Account button", FAIL, "Close Account button is not displayed")
						[ ] iFunctionResult=FAIL
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Select all display options", FAIL, "All display options are not selected in Account Details window")
				[ ] 
			[ ] 
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
			[ ] wEnterTransaction.EnterTransaction.TypeKeys(KEY_ALT_G)
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
			[ ] wEnterTransaction.EnterTransaction.TypeKeys(KEY_ALT_G)
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
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Add Investment Accounts
		[ ] // iAddAccount = AddManual401KAccount(sAccountType,sAccount,sEmployerName,sStatementEndingDate)
		[ ] // ReportStatus("Add 401 (k) Investing Account", iAddAccount, "Investing Account -  {sAccount} is created successfully")
		[ ] 
		[ ] // Edit 401 (k) Investing  Account
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)		// Select saving account 
		[+] if (iSelect == PASS)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] NavigateToAccountActionInvesting(3)           // as Update 401(K) Holding  menu item is available at 3rd location
			[ ] 
			[ ] 
			[ ] // Verify Update401K403B window
			[+] if(DlgUpdate401K403BAccount.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Update 401(K) Holding  menu item", PASS, "Update 401(K) Holding  menu item is available in Account Actions for {sAccount}")
				[ ] DlgUpdate401K403BAccount.Close()
				[ ] 
				[ ] iValidate= CloseAccount(ACCOUNT_INVESTING,sAccount)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Close account {sAccount}",iValidate,"Account {sAccount} is closed")
					[ ] sleep(SHORT_SLEEP)
					[ ] SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)
					[ ] QuickenWindow.SetActive()
					[ ] NavigateToAccountActionInvesting(3)  // as Update 401(K) Holding  menu item is available at 3rd location
					[+] if(!AccountDetails.Exists(SHORT_SLEEP))
						[+] if(!Update401KAccountHoldings.Exists(SHORT_SLEEP))
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
[+] testcase Test27_VerifyMenuItemsCloseInvestingAcc() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iAddTransaction,j,iCount,iClose
		[ ] STRING sStatementEndingDate,sExpected
		[ ] BOOLEAN bState
		[ ] sAccount = "Brokerage 04 Account"
		[ ] sStatementEndingDate= ModifyDate(-5) 
		[ ] // LIST OF LIST OF STRING lsTransactionData={{"MDI","Buy","",sAccount,sDateStamp,"Intu","1","50","0"},{"MDI","Sell","",sAccount,sDateStamp,"Intu","2","50","0"}}
		[ ] LIST OF LIST OF STRING lsTransactionData={{"MDI","Intu",ACCOUNT_INVESTING},{"MDI","Goog",ACCOUNT_INVESTING}}
		[ ] sExpected="Activate Quicken Bill Pay"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] 
		[ ] //Click on Investing  Account
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)		// Select investing account 
		[+] if (iSelect == PASS)
			[ ] 
			[ ] //Delete transaction to make balance zero
			[+] // for(j=1;j<=2;j++)
				[ ] //Add Buy/Sell Transaction to account
				[ ] // iAddTransaction= DeleteTransaction(lsTransactionData[1][1],lsTransactionData[1][2],lsTransactionData[1][3])
				[ ] // ReportStatus("Delete Transaction", iAddTransaction, "Transaction is deleted from investing account") 
			[ ] 
			[+] // Verification before closing the account
				[ ] QuickenWindow.SetActive()
				[ ] // Verify Account actions -> set up download
				[ ] NavigateToAccountActionInvesting(2)
				[+] if(DlgActivateOneStepUpdate.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Activate One Step Update window", PASS, "Setup Online option is available in Account Actions for {sAccount} before closing it")
					[ ] DlgActivateOneStepUpdate.Close()
				[+] else
					[ ] ReportStatus("Verify Activate One Step Update window", FAIL, "Setup Online option is not available in Account Actions for {sAccount} before closing it")
					[ ] 
				[ ] 
				[ ] // Account actions -> Update Quotes only
				[ ] NavigateToAccountActionInvesting(3)
				[+] if(QuickenUpdateStatus.Exists(10))
					[ ] ReportStatus("Verify Quicken Update Status window", PASS, "Update Quotes only is available in Account Actions for {sAccount} before closing it")
				[+] else
					[ ] 
				[ ] sleep(10)
				[ ] WaitForState(QuickenUpdateStatus,FALSE,10)
				[ ] WaitForState(QuickenWindow,TRUE,10)
				[ ] // Account actions -> Reconcile
				[ ] NavigateToAccountActionInvesting(6)
				[+] if(DlgReconcileDetails.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Reconcile {sAccount} window", PASS, "Reconcile {sAccount} is available in Account Actions for {sAccount} before closing it")
					[ ] DlgReconcileDetails.Close()
				[+] else
					[ ] ReportStatus("Verify Reconcile {sAccount} window", FAIL, "Reconcile {sAccount} is not available in Account Actions for {sAccount} before closing it")
					[ ] 
				[ ] 
				[ ] //Account actions -> Account Overview -> Holdings snap -> Get Online Quotes
				[ ] NavigateToAccountActionInvesting(12)
				[+] if(DlgAccountOverview.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Account Overview window", PASS, "Account Overview is available in Account Actions for {sAccount} before closing it")
					[ ] DlgAccountOverview.TextClick("Options" ,1)
					[ ] DlgAccountOverview.TypeKeys(Replicate(KEY_DN ,3))
					[ ] DlgAccountOverview.TypeKeys(KEY_ENTER)
					[ ] WaitForState(QuickenUpdateStatus,TRUE,8)
					[+] if(QuickenUpdateStatus.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Quicken Update Status window", PASS, "Update Quotes only is available in Account actions -> Account Overview -> Holdings snap -> Get Online Quotes for {sAccount} before closing it")
						[ ] WaitForState(QuickenUpdateStatus,FALSE,60)
					[+] else
						[ ] 
					[ ] // DlgAccountOverview.Close()
					[+] // else
						[ ] // ReportStatus("Verify Account Overview window", FAIL, "Account Overview is not available in Account Actions for {sAccount} before closing it")
						[ ] // 
					[ ] 
					[ ] sleep(20)
					[ ] //Account actions -> Account overview -> Account status snap -> reconcile this account. 
					[ ] // NavigateToAccountActionInvesting(12)
					[+] // if(DlgAccountOverview.Exists(SHORT_SLEEP))
						[ ] // ReportStatus("Verify Account Overview window", PASS, "Account Overview is available in Account Actions for {sAccount} before closing it")
					[ ] DlgAccountOverview.SetActive()
					[ ] DlgAccountOverview.TextClick("Options" ,3)
					[ ] 
					[ ] DlgAccountOverview.TypeKeys(KEY_DN ,1)
					[ ] DlgAccountOverview.TypeKeys(KEY_ENTER)
					[+] if(DlgReconcileDetails.Exists(5))
						[ ] ReportStatus("Verify Reconcile {sAccount} window", PASS, "Reconcile {sAccount} is available in Account actions -> Account overview -> Account status snap -> reconcile this account for {sAccount} before closing it")
						[ ] DlgReconcileDetails.Close()
					[+] else
						[ ] ReportStatus("Verify Reconcile {sAccount} window", FAIL, "Reconcile {sAccount} is not available in Account actions -> Account overview -> Account status snap -> reconcile this account for {sAccount} before closing it")
						[ ] 
					[ ] // DlgAccountOverview.Close()
					[+] // else
						[ ] // ReportStatus("Verify Account Overview window", FAIL, "Account Overview is not available in Account Actions for {sAccount} before closing it")
						[ ] // 
					[ ] 
					[ ] //Account actions -> account overview -> Account Attributes -> Quicken Bill Pay Link
					[ ] // NavigateToAccountActionInvesting(12)
					[+] // if(DlgAccountOverview.Exists(SHORT_SLEEP))
						[ ] // ReportStatus("Verify Account Overview window", PASS, "Account Overview is available in Account Actions for {sAccount} before closing it")
					[ ] DlgAccountOverview.TextClick(sExpected ,1)
					[+] if(AddAnyAccount.Exists(60))
						[ ] AddAnyAccount.SetActive()
						[ ] ReportStatus("Validate Activate Quicken Bill Pay link", PASS, "Activate Quicken Bill Pay is available in Account actions -> account overview -> Account Attributes") 
						[ ] 
						[ ] AddAnyAccount.Close()
						[ ] 
						[+] if(AlertMessage.Exists(5))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.OK.Click()
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Activate Quicken Bill Pay link", FAIL, "Activate Quicken Bill Pay is not available in Account actions -> account overview -> Account Attributes") 
						[ ] 
					[ ] 
					[ ] DlgAccountOverview.Close()
				[+] else
					[ ] ReportStatus("Verify Account Overview window", FAIL, "Account Overview is not available in Account Actions for {sAccount} before closing it")
					[ ] 
				[ ] 
				[ ] // Download Transactions tab (C2R) > Set up download button 
				[ ] bState=BrokerageAccount.wTransaction.SetUpDownload.IsEnabled()
				[+] if(bState==TRUE)
					[ ] ReportStatus("Verify Set up download button is enabled", PASS, "Set up download button is enaled for {sAccount} before closing it")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Set up download button is enabled", FAIL, "Set up download button is not enaled for {sAccount} before closing it")
					[ ] 
				[ ] 
				[ ] // Download Transactions tab (C2R) > Set up online payment button
				[ ] bState=BrokerageAccount.wTransaction.SetUpOnlinePayment.IsEnabled()
				[+] if(bState==TRUE)
					[ ] ReportStatus("Verify Set up online payment button is enabled", PASS, "Set up online payment button is enaled for {sAccount} before closing it")
				[+] else
					[ ] ReportStatus("Verify Set up online payment button is enabled", FAIL, "Set up online payment button is not enaled for {sAccount} before closing it")
				[ ] 
				[ ] // Download Transactions tab (C2R) > 'Enter your financial institute name' text box
				[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
				[ ] MDIClient.AccountRegister.EnterFINameTextField.SetText("FI")
				[ ] bState=MDIClient.AccountRegister.CheckAvailabilityButton.IsEnabled()
				[+] if(bState==TRUE)
					[ ] ReportStatus("Verify Check Availability Button is enabled", PASS, "Check Availability Button is enabled for {sAccount} before closing it")
				[+] else
					[ ] ReportStatus("Verify Check Availability Button is enabled", FAIL, "Check Availability Button is not enabled for {sAccount} before closing it")
			[ ] 
			[ ] // Close the investing account
			[ ] iClose=CloseAccount(ACCOUNT_INVESTING,sAccount,3)
			[+] if(iClose==PASS)
				[ ] ReportStatus("Close account {sAccount}",PASS,"{sAccount} closed successfully")
				[ ] 
				[+] // Verification after closing the account
					[ ] QuickenWindow.SetActive()
					[ ] //Verify Account actions -> set up download
					[ ] NavigateToAccountActionInvesting(2)
					[+] if(!DlgActivateOneStepUpdate.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Activate One Step Update window", PASS, "Setup Online option is not available in Account Actions for {sAccount} after closing it")
						[+] if(AccountDetails.Exists(3))
							[ ] AccountDetails.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Activate One Step Update window", FAIL, "Setup Online option is available in Account Actions for {sAccount} after closing it")
						[ ] DlgActivateOneStepUpdate.Close()
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] // Account actions -> Update Quotes only
					[ ] NavigateToAccountActionInvesting(3)
					[+] if(!QuickenUpdateStatus.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Quicken Update Status window", PASS, "Update Quotes only is not available in Account Actions for {sAccount} after closing it")
					[+] else
						[ ] ReportStatus("Verify Quicken Update Status window", FAIL, "Update Quotes only is available in Account Actions for {sAccount} after closing it")
						[ ] 
					[ ] 
					[+] if(wEnterTransaction.Exists(3))
						[ ] wEnterTransaction.Close()
					[ ] 
					[ ] 
					[ ] WaitForState(QuickenMainWindow,TRUE,10)
					[ ] //Account actions -> Reconcile
					[ ] NavigateToAccountActionInvesting(6)
					[+] if(!DlgReconcileDetails.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Reconcile {sAccount} window", PASS, "Reconcile {sAccount} is not available in Account Actions for {sAccount} after closing it")
						[+] if(SecurityList.Exists(3))
							[ ] SecurityList.Close()
					[+] else
						[ ] ReportStatus("Verify Reconcile {sAccount} window", FAIL, "Reconcile {sAccount} is available in Account Actions for {sAccount} after closing it")
						[ ] DlgReconcileDetails.Close()
						[ ] 
					[ ] 
					[ ] //Account actions -> Account Overview -> Holdings snap -> Get Online Quotes
					[ ] NavigateToAccountActionInvesting(9)
					[+] if(DlgAccountOverview.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Account Overview window", PASS, "Account Overview is available in Account Actions for {sAccount} after closing it")
						[ ] DlgAccountOverview.TextClick("Options" ,1)
						[ ] DlgAccountOverview.TypeKeys(Replicate(KEY_DN ,3))
						[ ] DlgAccountOverview.TypeKeys(KEY_ENTER)
						[ ] WaitForState(QuickenUpdateStatus,TRUE,8)
						[+] if(!QuickenUpdateStatus.Exists(SHORT_SLEEP))
							[ ] ReportStatus("Verify Quicken Update Status window", PASS, "Update Quotes only is not available in Account actions -> Account Overview -> Holdings snap -> Get Online Quotes for {sAccount} after closing it")
						[+] else
							[ ] 
						[ ] WaitForState(DlgAccountOverview,TRUE,5)
						[ ] // DlgAccountOverview.Close()
						[+] // else
							[ ] // ReportStatus("Verify Account Overview window", FAIL, "Account Overview is not available in Account Actions for {sAccount} before closing it")
							[ ] // 
						[ ] 
						[ ] 
						[ ] //Account actions -> Account overview -> Account status snap -> reconcile this account. 
						[ ] // NavigateToAccountAction(13)
						[ ] // if(DlgAccountOverview.Exists(SHORT_SLEEP))
						[ ] // ReportStatus("Verify Account Overview window", PASS, "Account Overview is available in Account Actions for {sAccount} before closing it")
						[ ] DlgAccountOverview.SetActive()
						[ ] DlgAccountOverview.TextClick("Options" ,3)
						[ ] 
						[ ] DlgAccountOverview.TypeKeys(KEY_DN ,1)
						[ ] DlgAccountOverview.TypeKeys(KEY_ENTER)
						[+] if(!DlgReconcileDetails.Exists(SHORT_SLEEP))
							[ ] ReportStatus("Verify Reconcile {sAccount} window", PASS, "Reconcile {sAccount} is not available in Account actions -> Account overview -> Account status snap -> reconcile this account for {sAccount} after closing it")
						[+] else
							[ ] ReportStatus("Verify Reconcile {sAccount} window", FAIL, "Reconcile {sAccount} is available in Account actions -> Account overview -> Account status snap -> reconcile this account for {sAccount} after closing it")
							[ ] DlgReconcileDetails.Close()
							[ ] 
						[ ] // DlgAccountOverview.Close()
						[+] // else
							[ ] // ReportStatus("Verify Account Overview window", FAIL, "Account Overview is not available in Account Actions for {sAccount} before closing it")
							[ ] // 
						[ ] 
						[ ] //Account actions -> account overview -> Account Attributes -> Quicken Bill Pay Link
						[ ] // NavigateToAccountAction(13)
						[+] // if(DlgAccountOverview.Exists(SHORT_SLEEP))
							[ ] // ReportStatus("Verify Account Overview window", PASS, "Account Overview is available in Account Actions for {sAccount} before closing it")
						[ ] iCount=DlgAccountOverview.ListBox3.GetItemCount()
						[ ] sHandle=Str(DlgAccountOverview.ListBox3.GetHandle())
						[+] for(i=iCount;i>=1;i--)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
							[ ] bMatch = MatchStr("*{sExpected}*", sActual)
							[+] if(bMatch == TRUE)
								[ ] ReportStatus("Validate Activate Quicken Bill Pay link", FAIL, "Activate Quicken Bill Pay is not available in Account actions -> account overview -> Account Attributes after closing the account") 
								[ ] break
							[+] else
								[+] if(i==1)
									[ ] ReportStatus("Validate Activate Quicken Bill Pay link", PASS, "Activate Quicken Bill Pay is not available in Account actions -> account overview -> Account Attributes after closing the account") 
								[ ] continue
						[ ] DlgAccountOverview.Close()
						[+] // else
							[ ] // ReportStatus("Verify Account Overview window", FAIL, "Account Overview is not available in Account Actions for {sAccount} before closing it")
							[ ] // 
						[+] // do
							[ ] // DlgAccountOverview.TextClick(sExpected)
						[+] // except
							[ ] // ReportStatus("Verify {sExpected} link on Account Overview window", PASS, "{sExpected} is not available on Account Overview window for {sAccount} after closing it")
						[+] // if(AddAccount.Exists(10))
							[ ] // ReportStatus("Verify {sExpected} link on Account Overview window", FAIL, "{sExpected} is available on Account Overview window for {sAccount} after closing it")
						[ ] // 
						[ ] // 
						[ ] // DlgAccountOverview.Close()
					[+] else
						[ ] ReportStatus("Verify Account Overview window", FAIL, "Account Overview is not available in Account Actions for {sAccount} after closing it")
						[ ] 
					[ ] 
					[ ] // Download Transactions tab (C2R) > Set up download button 
					[+] if(BrokerageAccount.wTransaction.SetUpDownload.Exists(SHORT_SLEEP))
						[ ] bState=BrokerageAccount.wTransaction.SetUpDownload.IsEnabled()
						[+] if(bState==FALSE)
							[ ] ReportStatus("Verify Set up download button is disabled", PASS, "Set up download button is disabled for {sAccount} after closing it")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Set up download button is disabled", FAIL, "Set up download button is not enaled for {sAccount} after closing it")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Set up download button is available", PASS, "Set up download button is not available for {sAccount} after closing it")
						[ ] 
					[ ] 
					[ ] // Download Transactions tab (C2R) > Set up online payment button
					[ ] bState=BrokerageAccount.wTransaction.SetUpOnlinePayment.IsEnabled()
					[+] if(bState==FALSE)
						[ ] ReportStatus("Verify Set up online payment button is disabled", PASS, "Set up online payment button is disabled for {sAccount} after closing it")
					[+] else
						[ ] ReportStatus("Verify Set up online payment button is disabled", FAIL, "Set up online payment button is not disabled for {sAccount} after closing it")
					[ ] 
					[ ] // Download Transactions tab (C2R) > 'Enter your financial institute name' text box
					[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
					[ ] // MDIClient.AccountRegister.EnterFINameTextField.SetText("FI")
					[+] // if(MDIClient.AccountRegister.EnterFINameTextField.IsEnabled()==FALSE)
						[ ] // 
						[ ] // bState=MDIClient.AccountRegister.CheckAvailabilityButton.IsEnabled()
						[+] // if(bState==FALSE)
							[ ] // ReportStatus("Verify Enter FI Name Text Field is disabled", PASS, "Enter FI Name Text Field is disabled for {sAccount} after closing it")
						[+] // else
							[ ] // ReportStatus("Verify Check Availability Button is disabled", FAIL, "Check Availability Button is not disabled for {sAccount} after closing it")
					[+] // else
						[ ] // ReportStatus("Verify Check Availability Button is disabled", FAIL, "Enter FI Name Text Field is not disabled for {sAccount} after closing it")
						[ ] // 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Close account {sAccount}",FAIL,"{sAccount} is not closed")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", FAIL, "Investing Account is not selected from Account bar")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] // //###########################################################################
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
		[ ] sAccount="Brokerage 07 Account"
		[ ] sExpectedMessage="This account has securities balances, please clear the securities before you close the account."
		[ ] lsTransactionData={"MDI","Buy","",sAccount,sDateStamp,"Intu","20","50","25"}
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)
		[+] if (iSelect == PASS)
			[ ] iAddTransaction= AddBrokerageTransaction(lsTransactionData)
			[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction is added to investing account") 
		[ ] 
		[ ] // Edit Investing Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_INVESTING,sAccount,sTab)			// Select first Investing account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] // Check "Close Account" button
			[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
				[ ] AccountDetails.CloseAccount.Click()
				[+] if(!PermanentlyCloseAccount.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Check Permanently Close Account window", PASS, "Permanently Close Account window is not available")
					[+] if(AlertMessage.Exists(3))
						[ ] AlertMessage.SetActive()
						[ ] sActualMessage=AlertMessage.MessageText.GetText()
						[+] if(sActualMessage==sExpectedMessage)
							[ ] ReportStatus("Verify message if there are securities in account to be closed",PASS,"Correct alert message is getting displayed - {sExpectedMessage}")
						[+] else
							[ ] ReportStatus("Verify message if there are securities in account to be closed",FAIL,"Correct alert message is not getting displayed, Actual - {sActualMessage} and Expected - {sExpectedMessage}")
						[ ] AlertMessage.OK.Click()
					[+] else
						[ ] ReportStatus("Verify Alert message window", FAIL, "Alert message window is not available")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Check Permanently Close Account window", FAIL, "Permanently Close Account window is available")
					[ ] PermanentlyCloseAccount.Close()
				[ ] AccountDetails.Close()
			[+] else
				[ ] ReportStatus("Check Close Account button", FAIL, "Close button is not available")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "Navigation to Account Details tab is failed")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
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
		[ ] iResult=AddCCMintBankAccount(sAccountId,sAccPassword,sAccountType,sFIName)
		[ ] 
		[+] if(iResult==PASS)
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
				[ ] 
				[ ] ShowHiddenInvestmentTransactionOption(TRUE)
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
						[ ] DeleteTransaction(lsTransactionData[1],lsTransactionData[2],ACCOUNT_INVESTING)
						[ ] 
					[ ] iResult=CloseAccount(ACCOUNT_INVESTING,sAccountName)
					[ ] 
					[+] if(iResult==PASS)
						[ ] 
						[ ] ReportStatus("Closing checking account", PASS,"{sAccountName} account closed successfully.")
						[ ] 
						[ ] //Checking after Closing the Accounts whether the FI is listed in One Step Update
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.Tools.Click()
						[ ] QuickenWindow.Tools.OneStepUpdate.Select()
						[ ] 
						[ ] WaitForState(OneStepUpdate,true,2)
						[ ] 
						[+] if(OneStepUpdate.Exists(SHORT_SLEEP))
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
						[+] else
							[ ] ReportStatus("Verify One Step Update Window",FAIL,"One Step Update Window is not displayed")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Closing checking account", FAIL,"{sAccountName} account not closed successfully.")
						[ ] 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Brokerage Online Account selected",FAIL,"Brokerage Online Account is not selected")
			[+] else
				[ ] ReportStatus("Verify One Step Update Window",FAIL,"One Step Update Window is not displayed")
		[+] else
			[ ] ReportStatus("Verify Brokerage Online Account",FAIL,"Brokerage Online Account is not created successfully")
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
		[ ] STRING  sFIName
		[ ] 
		[ ] sAccountId="quickenqa"
		[ ] sAccPassword = "Zags2010"
		[ ] sAccountName = "Investment XX0459"
		[ ] sFIName = "T. Rowe Price"
		[ ] sAccountType ="Brokerage"
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
							[ ] ReportStatus("Verify FI name is listed in the One Step Update Window before separating Online Account ", PASS, "{sFIName}  is listed in the One Step Update Window before separating Online Account")
						[+] else
							[ ] ReportStatus("Verify FI name is listed in the One Step Update Window before separating Online Account ", FAIL, "{sFIName}  is not listed in the One Step Update Window before separating Online Account")
						[ ] 
						[ ] OneStepUpdate.Close()
						[ ] 
						[ ] //Separating the Online Investing Account
						[ ] 
						[ ] 
						[ ] iResult=SeparateAccount(ACCOUNT_INVESTING,sAccountName)
						[ ] 
						[+] if(iResult==PASS)
							[ ] 
							[ ] //Checking after Separating the Accounts whether the FI is listed in One Step Update
							[ ] 
							[ ] ReportStatus("Separating brokerage account", PASS,"{sAccountName} account separated successfully.")
							[ ] 
							[ ] 
							[ ] QuickenWindow.SetActive()
							[ ] QuickenWindow.Tools.Click()
							[ ] QuickenWindow.Tools.OneStepUpdate.Select()
							[ ] 
							[ ] WaitForState(OneStepUpdate,true,2)
							[ ] 
							[+] if(OneStepUpdate.Exists(SHORT_SLEEP))
								[ ] 
								[ ] sHandle = Str(OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetHandle())
								[+] for(iCounter=0;iCounter<OneStepUpdate.OneStepUpdateSettings3.ListBox1.GetItemCount();iCounter++)
									[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}")
									[ ] bMatch = MatchStr("*{sFIName}*",sActual)
									[+] if(bMatch == TRUE)
										[ ] break
								[+] if(bMatch == TRUE)
									[ ] ReportStatus("Verify FI name is listed in the One Step Update Window after separating Online Account ", PASS, "{sFIName}  is listed in the One Step Update Window after separating Online Account")
								[+] else
									[ ] ReportStatus("Verify FI name is listed in the One Step Update Window after separating Online Account ", FAIL, "{sFIName}  is not listed in the One Step Update Window after separating Online Account")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify One Step Update Window",FAIL,"One Step Update Window is not displayed")
							[ ] 
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
			[+] else
				[ ] ReportStatus("Verify Closed Account is deleted ",FAIL,"Closed Account is not deleted successfully")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] //******************************************************************************************************************************************
[ ] // 
[+] //#############  SetUp ######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Business_SetUp()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will open data file to test hidden account for business accounts
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If no error occurs while deleting and creating file							
		[ ] // Fail			If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 17, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Business_SetUp () appstate QuickenBaseState
	[ ] 
	[ ] INTEGER iRegistration,iOpenDataFile
	[ ] 
	[ ] sFileName = "HiddenAccountBusiness"
	[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
	[ ] 
	[ ] 
	[ ] //Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
	[+] else
		[ ] QuickenWindow.Start (sCmdLine)
		[ ] 
	[ ] 
	[ ] //Open data file
	[ ] sCaption = QuickenWindow.GetCaption()
	[ ] bCaption = MatchStr("*{sFileName}*", sCaption)
	[+] if(bCaption == FALSE)
		[ ] bExists = FileExists(sDataFile)
		[+] if(bExists == TRUE)
			[ ] DeleteFile(sDataFile)
			[ ] CopyFile(sSourceFile,sDataFile)
			[ ] iOpenDataFile=OpenDataFile(sFileName)
			[ ] ReportStatus("Business data file open", iOpenDataFile,"Business data file open")
			[ ] CloseQuickenConnectedServices()
			[ ] 
		[+] else
			[ ] CopyFile(sSourceFile,sDataFile)
			[ ] iOpenDataFile=OpenDataFile(sFileName)
			[ ] ReportStatus("Business data file open", iOpenDataFile,"Business data file open")
			[ ] CloseQuickenConnectedServices()
		[ ] 
	[ ] 
	[ ] //Bypass Registration
	[ ] iRegistration=BypassRegistration()
	[ ] //Off Popup Register
	[ ] UsePopUpRegister("OFF")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Business account as Separate Account ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_BusinessAsSeparateAccount()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will check Account Display option "-Keep this account separate-Account would be excluded from Quicken reports and features."  for an Business account
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If business account made separate 							
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 12, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_BusinessAsSeparateAccount () appstate none
	[ ] 
	[+] //Variable declaration
		[ ] sAccount = "Vendor Invoices 1"
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Restore()
		[ ] sleep(1)
		[ ] QuickenWindow.Maximize()
		[ ] sleep(1)
		[ ] 
		[ ] //Edit Business Account
		[ ] iSelect = SeparateAccount(ACCOUNT_BUSINESS,sAccount)			// Select Business account
		[ ] 
		[+] if (iSelect == PASS)
			[ ] ReportStatus("Verify Separate account {sAccount}", iSelect, "Business account {sAccount} is separated")
			[ ] 
			[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
			[ ] NavigateQuickenTab(sTAB_HOME)
			[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
			[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE,sAccount) 
			[+] if (iSeparate == PASS)
				[ ] AccountDetails.Cancel.Click()
				[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and Business account is displayed under this seaction")
			[+] else
				[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Separate section is not created")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Separate account {sAccount}", iSelect, "Business account {sAccount} is not separated")
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
	[+] // TestCase Name:	 Test02_HideBusinessAccountFromAccountBar()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check Account Display option "-Hide account name in account bar and account list."  for an business account
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If business account is hidden from account bar and account list						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 15, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test02_HideBusinessAccountFromAccountBar () appstate none
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER iSelectAccount,iAccountDetails
		[ ] sAccount = "Vendor Invoices 2"
		[ ] iAccountPosition= 6
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Navigate to account list before hiding it from account bar and account list
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
		[ ] 
		[+] if(iNavigate == PASS)
			[ ] //Verify Show hidden accounts checkbox is not available if there are no hidden account
			[+] if(AccountList.Exists(SHORT_SLEEP))
				[ ] 
				[+] if(!AccountList.QWinChild.ShowHiddenAccounts.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Validate Show hidden Account checkbox", PASS, "Show hidden Account checkbox is not available on Account List") 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Show hidden Account checkbox", FAIL, "Show hidden Account checkbox is available on Account List") 
				[ ] AccountList.Close()
		[ ] 
		[ ] //Edit Business Account
		[ ] iSelect = AccountHideInAccountBarAccountList(ACCOUNT_BUSINESS,sAccount)			// Select Business account
		[+] if (iSelect == PASS)
				[ ] ReportStatus("Check Hide account name from account bar and account list checkbox", PASS, "Third Checkbox: Hide account name from account bar and account list is checked")
				[ ] 
				[ ] //Verify account name in Account List
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] iSelectAccount = SelectAccountFromAccountBar(sAccount,ACCOUNT_BUSINESS)	// select Business account
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
				[ ] //Verify account in Account List
				[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
				[+] if(iNavigate == PASS)
					[+] if(AccountList.Exists(SHORT_SLEEP))
						[ ] AccountList.SetActive()
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
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############  Verify Hide in Transaction entry lists ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_BusinessHideInTransactionEntryList()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check Account Display option "-Hide In Transaction Entry List"  for a Business account
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Setting saved successfully
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 17, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_BusinessHideInTransactionEntryList() appstate none
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER iIndex
		[ ] STRING sReport
		[ ] LIST OF STRING lsAccounts
		[ ] 
		[ ] sAccount = "Customer Invoice"
		[ ] iAccountPosition= 2
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] QuickenMainWindow.QWNavigator.Home.Click()
		[ ] 
		[ ] 
		[ ] //Edit Business Account
		[ ] iSelect = AccountHideInTransactionList(ACCOUNT_BUSINESS,sAccount,iAccountPosition)			// Hide In Transaction Entry List
		[+] if (iSelect == PASS)
				[ ] ReportStatus("Check Hide in Transaction Entry List checkbox", PASS, "Second Checkbox: Hide in transaction entry lists is checked")
				[ ] 
				[ ] //Verify account name in register
				[ ] iNavigate = SelectAccountFromAccountBar(sAccount,ACCOUNT_INVESTING)			// Select first account
				[+] if (iNavigate == PASS)
					[+] if (BrokerageAccount.Exists(SHORT_SLEEP))
						[ ] //Click on "Enter Transaction" button
						[ ] BrokerageAccount.EnterTransactions.Click()
						[ ] //Buy - Shares Bought window active
						[ ] wEnterTransaction.SetActive()
						[ ] //Select From radio button from "Use cash for this transaction"
						[ ] wEnterTransaction.UseCashForThisTransaction.Select("#2")
						[ ] //Verify account name in Account list, it should not be available as it is made hidden from transaction entry list
						[ ] iIndex=wEnterTransaction.FromAccountList.FindItem(sAccount)
						[+] if(iIndex==0)
							[ ] ReportStatus("Check Hide in Transaction Entry List verification", PASS, "Account is hidden from Transaction Entry List")
							[ ] 
						[+] else
							[ ] ReportStatus("Check Hide in Transaction Entry List verification", FAIL, "Account is not hidden from Transaction Entry List as it is available for Investing transaction")
							[ ] 
						[ ] wEnterTransaction.Close()
					[ ] 
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
[+] //############# Business account with all display options selected ##################
	[ ] // ********************************************************
	[+] // TestCase Name:Test04_BusinessAccWithAllDisplayOption()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will check business account with all display option checked/selected
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If all display options selected and functioning as expected				
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 15, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test04_BusinessAccWithAllDisplayOption() appstate none
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER iTab,iCount
		[ ] STRING sReport
		[ ] BOOLEAN bFlag = FALSE
		[ ] sAccount = "Customer Invoice"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Business Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BUSINESS,sAccount,sTab)			// Select Business account
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
			[+] else
				[ ] ReportStatus("Select all display options", FAIL, "All display options are not selected in Account Details window")
				[ ] 
			[ ] 
			[ ] 
			[ ] //Verify account name in Account List
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
			[ ] 
			[+] if(iNavigate == PASS)
				[ ] 
				[ ] AccountList.QWinChild.BusinessNetWorth.Click()
				[ ] //AccountList.QWinChild.BusinessNetWorth.Click()
				[ ] 
				[ ] iCount=AccountList.QWinChild.Order.ListBox.GetItemCount()
				[+] for(i=1;i<=iCount;i++)
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle())
					[ ] 
					[ ] //####### Validate Accounts in Account List window #####################
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
					[ ] bMatch = MatchStr("*{sAccount}+@", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Account in Account List and Account Bar", FAIL, "Account is available in Account list") 
						[ ] break
					[+] else
						[ ] continue
						[+] if(i==iCount)
							[ ] ReportStatus("Validate Account in Account List and Account", PASS, "Account {sAccount} is not available in Account List and Account Bar") 
					[ ] 
				[+] if(AccountList.Exists(SHORT_SLEEP))
					[+] if(AccountList.QWinChild.ShowHiddenAccounts.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Validate Show hidden Account checkbox", PASS, "Show hidden Account checkbox is available on Account List") 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Show hidden Account checkbox", FAIL, "Show hidden Account checkbox is not available on Account List") 
					[ ] AccountList.Close()
			[ ] 
			[ ] //Verify account "Separate" section 
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] iSeparate=AccountBarSelect(ACCOUNT_SEPARATE, 3)
			[ ] //iSeparate=SelectAccountFromAccountBar(sAccount,ACCOUNT_SEPARATE)
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(Replicate(KEY_DN,1))
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_ENTER)
			[+] if (iSeparate == PASS)
				[ ] iNavigate=NavigateToAccountDetails(sAccount)
				[+] if (iNavigate == PASS)
					[ ] iTab=SelectAccountDetailsTabs(ACCOUNT_BUSINESS,sTab)
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
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "Business Account is not selected from Account bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############Verify Close Account ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_BusinessCloseAccount()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will close business account and verify
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If business account closed successfully						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 17, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test05_BusinessCloseAccount () appstate none
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER iValidate,iCount,iReportSelect
		[ ] STRING sSearch,sNetWorth,sReport
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Customer Invoices 1"
		[ ] sNetWorth="21,217.03"          // 21,197.03 (previous networth) + 20 (Close Account balance)
		[ ] sReport="Net Worth & Balances"
		[ ] iAccountPosition=3
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Close Business Account
		[ ] iSelect = CloseAccount(ACCOUNT_BUSINESS,sAccount,iAccountPosition)		
		[ ] 
		[+] if (iSelect == PASS)
			[ ] 
			[ ] //Open Net Worth Report and Verify
			[ ] iReportSelect = OpenReport(sReport, sREPORT_NETWORTH)		// OpenReport("Net Worth & Balances", "Net Worth")
			[ ] ReportStatus("Run {sREPORT_NETWORTH} Report", iReportSelect, "Run Report successful") 
			[+] if(NetWorthReports.Exists(3))
				[+] if(NetWorthReports.ShowReport.Exists(SHORT_SLEEP))
					[ ] NetWorthReports.ShowReport.Click()
					[ ] sleep(1)
					[ ] 
				[ ] iCount = NetWorthReports.QWListViewer1.ListBox1.GetItemCount()
				[+] for(i=iCount;i>=1;i--)
					[ ] sHandle = Str(NetWorthReports.QWListViewer1.ListBox1.GetHandle())	   // get the handle
					[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
					[ ] bMatch = MatchStr("*{sNetWorth}*", sActual)						
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Verify Networth Amount", PASS, "Correct Networth amount {sNetWorth} is displayed") 
						[ ] break
					[+] else
						[ ] continue
						[+] if(i==1)
							[ ] ReportStatus("Verify Networth amount", FAIL, "Actual networth amount {sActual} does not match with excpected amount {sNetWorth}") 
							[ ] 
				[ ] 
			[+] if(NetWorthReports.Exists(SHORT_SLEEP))
				[ ] NetWorthReports.SetActive()
				[ ] NetWorthReports.Close()
			[ ] 
			[ ] //Verify account name in Account List
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
			[+] if(iNavigate == PASS)
				[ ] iCount=AccountList.QWinChild.Order.ListBox.GetItemCount()
				[+] for(i=3;i<=iCount;i++)
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
					[ ] 
					[ ] //####### Validate Accounts in Account List window #####################
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
					[ ] bMatch = MatchStr("*{sAccount}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Account in Account List and Account Bar", PASS, "Account is available in Account list and Account Bar") 
						[ ] break
					[+] else
						[ ] continue
						[+] if(i==iCount)
							[ ] ReportStatus("Validate Account in Account List and Account", FAIL, "Account {sAccount} is not available in Account List and Account Bar") 
					[ ] 
			[+] if(AccountList.Exists(SHORT_SLEEP))
				[ ] AccountList.SetActive()
				[ ] AccountList.Close()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Close Account", iSelect, "Business Account is not closed")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed Account in Choose Invoice account dialog ################
	[ ] // ********************************************************
	[+] // TestCase Name: Test06_CustomerInvClosedAccountVerify()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed Customer Invoice account should not get displayed on Choose Invoice account dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If business account not displayed						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 18, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test06_CustomerInvClosedAccountVerify () appstate none
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER iValidate
		[ ] sTab= "Display Options"
		[ ] sAccount="Customer Invoices 1"
		[ ] iAccountPosition=3
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Business Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BUSINESS,sAccount,sTab)			// Select business account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] //Check "Close Account" button
			[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
				[ ] Close:
				[+] if(!AccountDetails.CloseAccount.IsEnabled())
					[ ] ReportStatus("Check Close Account button", PASS, "{sAccount} is closed as Close Account button is disabled")
					[ ] //Close Account Details window
					[ ] AccountDetails.Close()
					[ ] 
					[ ] //Navigate to Business -> Invoices and Estimates ->Create Invoice
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Business.Click()
					[ ] QuickenWindow.Business.InvoicesAndEstimates.DoubleClick()
					[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateInvoice.Select()
					[ ] 
					[+] if(ChooseInvoiceAccount.Exists(SHORT_SLEEP))
						[ ] iValidate=ChooseInvoiceAccount.ChooseInvoiceAccount.FindItem(sAccount)
						[+] if(iValidate == 0)
							[ ] ReportStatus("Verify Closed Account in Choose Invoice account dialog", PASS, "{sAccount} is closed hence not available in Choose Invoice Account window")
						[+] else
							[ ] ReportStatus("Verify Closed Account in Choose Invoice account dialog", FAIL, "Closed Account in Choose Invoice account window: verification failed")
							[ ] 
						[ ] ChooseInvoiceAccount.Cancel.Click()
					[+] else
						[ ] ReportStatus("Verify Choose Invoice account dialog", FAIL, "Choose Invoice Account window is not opened")
				[+] else
					[ ] AccountDetails.CloseAccount.Click()
					[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
						[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
						[ ] PermanentlyCloseAccount.OK.Click()
					[ ] goto Close
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Check Close Account button", FAIL, "Close button is not available")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "Business Account is not selected from Account bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed account in Choose Bill account dialog. ###################
	[ ] // ********************************************************
	[+] // TestCase Name: Test07_VendorInvClosedAccountVerify()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed vendor Invoice account  should not get displayed on Choose Bill account dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If business account not displayed						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 19, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test07_VendorInvClosedAccountVerify () appstate none
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER iValidate
		[ ] sTab= "Display Options"
		[ ] sAccount="Vendor Invoice"
		[ ] iAccountPosition=6
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Business Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BUSINESS,sAccount,sTab)			// Select first business account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] //Check "Close Account" button
			[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
				[ ] Close:
				[+] if(!AccountDetails.CloseAccount.IsEnabled())
					[ ] ReportStatus("Check Close Account button", PASS, "{sAccount} is closed as Close Account button is disabled")
					[ ] //Close Account Details window
					[ ] AccountDetails.Close()
					[ ] 
					[ ] //Navigate to Business -> Invoices and Estimates ->Create Invoice
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Business.Click()
					[ ] QuickenWindow.Business.BillsAndVendors.Click()
					[ ] QuickenWindow.Business.BillsAndVendors.CreateBill.Select()
					[+] if(ChooseBillAccount.Exists(SHORT_SLEEP))
						[ ] iValidate=ChooseBillAccount.ChooseBillAccount.FindItem(sAccount)
						[+] if(iValidate == 0)
							[ ] ReportStatus("Verify Closed Account in Choose Bill Account dialog", PASS, "{sAccount} is closed hence not available in Choose Bill Account window")
						[+] else
							[ ] ReportStatus("Verify Closed Account in Choose Bill Account dialog", FAIL, "Closed Account in Choose Bill Account window: verification failed")
							[ ] 
						[ ] ChooseBillAccount.Cancel.Click()
					[+] else
						[ ] ReportStatus("Verify Choose Bill Account dialog", FAIL, "Choose Bill Account window is not opened")
				[+] else
					[ ] AccountDetails.CloseAccount.Click()
					[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
						[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
						[ ] PermanentlyCloseAccount.OK.Click()
					[ ] goto Close
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Check Close Account button", FAIL, "Close button is not available")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "Business Account is not selected from Account bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Separate Cust Inv Account in Choose Invoice account dialog ########
	[ ] // ********************************************************
	[+] // TestCase Name: Test08_CustomerInvSeparateAccountVerify()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate Customer Invoice account  should  get displayed on Choose Invoice account dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If business account displayed						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 19, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test08_CustomerInvSeparateAccountVerify () appstate none
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sTab
		[ ] sAccount="Customer Invoices 2"
		[ ] iAccountPosition=4
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Business Account
		[ ] iSelect = SeparateAccount(ACCOUNT_BUSINESS,sAccount)			// Select Business account
		[+] if (iSelect == PASS)
			[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount) 
			[+] if (iSeparate == PASS)
				[ ] AccountDetails.Cancel.Click()
				[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Business account is displayed under Separate seaction")
				[ ] 
				[ ] //Navigate to Business -> Invoices and Estimates ->Create Invoice
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Business.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.DoubleClick()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateInvoice.Select()
				[ ] 
				[ ] sleep(2)
				[+] if(ChooseInvoiceAccount.Exists(SHORT_SLEEP))
					[ ] iValidate=ChooseInvoiceAccount.ChooseInvoiceAccount.FindItem(sAccount)
					[+] if(iValidate >= 1)
						[ ] ReportStatus("Verify Separate Account in Choose Invoice account dialog", PASS, "{sAccount} is separate account and is available in Choose Invoice Account window")
					[+] else
						[ ] ReportStatus("Verify Separate Account in Choose Invoice account dialog", FAIL, "Separate Account in Choose Invoice account window: verification failed")
						[ ] 
					[ ] ChooseInvoiceAccount.Cancel.Click()
				[+] else
					[ ] ReportStatus("Verify Choose Invoice account dialog", FAIL, "Choose Invoice Account window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Business account is not displayed under Separate seaction")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Separate Account", iSelect, "Business Account {sAccount} is separated")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] //#############################################################################
[ ] 
[+] //#############Verify Separate Vendor Inv Account in Choose Bill account dialog. #########
	[ ] // ********************************************************
	[+] // TestCase Name: Test09_VendorInvSeparateAccountVerify()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that separate vendor Invoice account  should get displayed in Choose Bill account dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If business account not displayed						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 19, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test09_VendorInvSeparateAccountVerify () appstate none
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER iValidate
		[ ] sTab= "Display Options"
		[ ] sAccount="Vendor Invoices 1"
		[ ] iAccountPosition=3
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Business Account
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_SEPARATE)	
		[ ] 
		[+] if (iSelect == PASS)
			[ ] iNavigate= NavigateToAccountDetails(sAccount)
			[+] if(iNavigate==PASS)
				[ ] AccountDetails.SetActive()
				[ ] //Click on Display Options tab
				[ ] AccountDetails.Click(1, 150, 77)
				[ ] //Check "KeepThisAccountSeparate" checkbox
				[+] if(AccountDetails.KeepThisAccountSeparate.Exists(SHORT_SLEEP))
					[+] if(AccountDetails.KeepThisAccountSeparate.IsChecked())
						[ ] ReportStatus("Check Separate Account checkbox", PASS, "{sAccount} is separate account")
						[ ] //Close Account Details window
						[ ] AccountDetails.Close()
						[ ] 
						[ ] //Navigate to Business -> Bills And Vendors ->Create Bill
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.Business.Click()
						[ ] QuickenWindow.Business.BillsAndVendors.Click()
						[ ] QuickenWindow.Business.BillsAndVendors.CreateBill.Select()
						[ ] sleep(2)
						[+] if(ChooseBillAccount.Exists(SHORT_SLEEP))
							[ ] ChooseBillAccount.SetActive()
							[ ] iValidate=ChooseBillAccount.ChooseBillAccount.FindItem(sAccount)
							[+] if(iValidate >= 1)
								[ ] ReportStatus("Verify Separate Account in Choose Bill Account dialog", PASS, "{sAccount} is separate account and is available in Choose Bill Account window")
							[+] else
								[ ] ReportStatus("Verify Separate Account in Choose Bill Account dialog", FAIL, "Separate Account {sAccount} in Choose Bill Account window: verification failed")
								[ ] 
							[ ] ChooseBillAccount.Cancel.Click()
						[+] else
							[ ] ReportStatus("Verify Choose Bill Account dialog", FAIL, "Choose Bill Account window is not opened")
					[+] else
						[ ] ReportStatus("Verify KeepThisAccountSeparate checkbox", FAIL, "KeepThisAccountSeparate checkbox is not checked")
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", FAIL, "KeepThisAccountSeparate checkbox is not available")
					[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "Business Account is not selected from Account bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Separate Vendor Inv Account in Refund- Vendor Invoices dialog #####
	[ ] // ********************************************************
	[+] // TestCase Name: Test10_SeparateVendorInvAccountInRefundVI()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Vendor Invoices account should get displayed in Refund- Vendor Invoices dialog
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If separate VI account selected and separate checking account available						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 19, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test10_SeparateVendorInvAccountInRefundVI () appstate none
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER iValidate,iNavigateTo
		[ ] STRING  sCheckingAccount
		[ ] sCheckingAccount= "Checking 02"
		[ ] sAccount="Vendor Invoices 1"
		[ ] iAccountPosition=2
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMin()
		[ ] 
		[ ] 
		[ ] //Separate checking account
		[ ] iSelect = SeparateAccount(ACCOUNT_BANKING,sCheckingAccount)			// Select checking account
		[+] if (iSelect == PASS)
				[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", PASS, "{sCheckingAccount} is made separated")
				[ ] 
				[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
					[ ] 
				[ ] 
				[ ] iNavigate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sCheckingAccount)
				[+] if (iNavigate == PASS)
					[ ] AccountDetails.Cancel.Click()
					[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "{sCheckingAccount} is displayed under Separate seaction")
				[+] else
					[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "{sCheckingAccount} is not displayed under Separate seaction")
				[ ] 
				[ ] 
				[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
				[ ] 
				[ ] //Edit Business Account
				[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_SEPARATE)	
				[+] if (iSelect == PASS)
					[ ] iNavigate= NavigateToAccountDetails(sAccount)
					[+] if(iNavigate==PASS)
						[ ] AccountDetails.SetActive()
						[ ] //Click on Display Options tab
						[ ] AccountDetails.Click(1, 150, 77)
						[ ] //Check "KeepThisAccountSeparate" checkbox
						[+] if(AccountDetails.KeepThisAccountSeparate.Exists(SHORT_SLEEP))
							[ ] 
							[+] if(AccountDetails.KeepThisAccountSeparate.IsChecked())
								[ ] ReportStatus("Check Separate Account checkbox", PASS, "{sAccount} is separate account")
								[ ] //Close Account Details window
								[ ] AccountDetails.Close()
								[ ] 
								[ ] //Navigate to Business -> Bills and Vendors ->Receive a Refund
								[ ] QuickenWindow.SetActive()
								[ ] QuickenWindow.Business.Click()
								[ ] QuickenWindow.Business.BillsAndVendors.DoubleClick()
								[ ] QuickenWindow.Business.BillsAndVendors.ReceiveARefund.Select()
								[ ] sleep(2)
								[+] if(ChooseBillAccount.Exists(SHORT_SLEEP))
									[ ] ChooseBillAccount.SetActive()
									[ ] ChooseBillAccount.ChooseBillAccount.Select(sAccount)
									[ ] ChooseBillAccount.OK.Click()
									[ ] sleep(1)
									[+] if(RefundVendorInvoice.Exists(SHORT_SLEEP))
										[ ] RefundVendorInvoice.SetActive()
										[ ] iValidate=RefundVendorInvoice.AccountToDepositTo.FindItem(sCheckingAccount)
										[+] if(iValidate>=1)
											[ ] ReportStatus("Verify Separate Account in Refund Vendor Invoice Account", PASS, "{sAccount} and {sCheckingAccount} are separate account and are available in Refund Vendor Invoices")
										[+] else
											[ ] ReportStatus("Verify Separate Account in Refund Vendor Invoice Account", FAIL, "{sAccount} and {sCheckingAccount} are separate account but are not available in Refund Vendor Invoices")
											[ ] 
										[ ] 
										[ ] RefundVendorInvoice.Close()
										[+] //Need to remove-----------
											[+] // if(RefundVendorInvoice.Exists(SHORT_SLEEP))
												[ ] // RefundVendorInvoice.TypeKeys(KEY_EXIT)
												[ ] // 
											[+] // // if(AlertMessage.Exists(SHORT_SLEEP))
												[ ] // // // AlertMessage.SetActive()
												[ ] // // // AlertMessage.Yes.Click()
											[+] // // // else
												[ ] // // RefundVendorInvoice.Close()
												[ ] // // RefundVendorInvoice.TypeKeys("Enter")
									[+] else
										[ ] ReportStatus("Verify Refund Vendor Invoice Account", FAIL, "Refund Vendor Invoices window is not available")
										[ ] 
								[+] else
									[ ] ReportStatus("Verify Choose Bill Account dialog", FAIL, "Choose Bill Account window is not opened")
							[+] else
								[ ] ReportStatus("Verify KeepThisAccountSeparate checkbox", FAIL, "KeepThisAccountSeparate checkbox is not checked")
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", FAIL, "KeepThisAccountSeparate checkbox is not available")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify navigation to Account Details",FAIL,"Navigation to Account Details failed")
				[+] else
					[ ] ReportStatus("Validate Account selection", iSelect, "Business Account is not selected from Account bar")
					[ ] 
		[+] else
			[ ] ReportStatus("verify separate account",FAIL,"{sCheckingAccount} is not separated")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed Checking Account in Refund- Vendor Invoices dialog #######
	[ ] // ********************************************************
	[+] // TestCase Name: Test11_ClosedCheckingAccountInRefundVI()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Closed checking account should not get displayed in Refund- Vendor Invoices dialog
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If closed checking account is not available					
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 23, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test11_ClosedCheckingAccountInRefundVI () appstate none
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER iValidate,iNavigateTo
		[ ] STRING  sCheckingAccount
		[ ] sTab= "Display Options"
		[ ] sCheckingAccount= "Checking 03"
		[ ] sAccount="Vendor Invoices 1"
		[ ] iAccountPosition=2
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMin()
		[ ] 
		[ ] // Close checking account
		[ ] iSelect = CloseAccount(ACCOUNT_BANKING,sCheckingAccount,2)			// Select checking account
		[+] if (iSelect == PASS)
			[ ] ReportStatus("Close Account {sCheckingAccount}", PASS, "Account {sCheckingAccount} is closed successfully")
		[+] else
			[ ] ReportStatus("Close Account {sCheckingAccount}", FAIL, "Account {sCheckingAccount} is not closed successfully")
			[ ] 
		[ ] 
		[+] if(QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.Exists(3))
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.VScrollBar.ScrollToMax()
		[ ] 
		[ ] //Edit Business Account
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_SEPARATE)	
		[+] if (iSelect == PASS)
			[ ] iNavigate= NavigateToAccountDetails(sAccount)
			[+] if(iNavigate==PASS)
				[ ] AccountDetails.SetActive()
				[ ] //Click on Display Options tab
				[ ] AccountDetails.TextClick("Display Options")
				[ ] //Check "KeepThisAccountSeparate" checkbox
				[+] if(AccountDetails.KeepThisAccountSeparate.Exists(SHORT_SLEEP))
					[ ] 
					[+] if(AccountDetails.KeepThisAccountSeparate.IsChecked())
						[ ] ReportStatus("Check Separate Account checkbox", PASS, "{sAccount} is separate account")
						[ ] //Close Account Details window
						[ ] AccountDetails.Close()
						[ ] 
						[ ] //Navigate to Business -> Bills and Vendors ->Receive a Refund
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.Business.Click()
						[ ] QuickenWindow.Business.BillsAndVendors.DoubleClick()
						[ ] QuickenWindow.Business.BillsAndVendors.ReceiveARefund.Select()
						[+] if(ChooseBillAccount.Exists(SHORT_SLEEP))
							[ ] ChooseBillAccount.ChooseBillAccount.Select(sAccount)
							[ ] ChooseBillAccount.OK.Click()
							[+] if(RefundVendorInvoice.Exists(SHORT_SLEEP))
								[ ] RefundVendorInvoice.SetActive()
								[ ] iValidate=RefundVendorInvoice.AccountToDepositTo.FindItem(sCheckingAccount)
								[+] if(iValidate==0)
									[ ] ReportStatus("Verify Closed Checking Account in Refund Vendor Invoice Account", PASS, "{sCheckingAccount} is closed and not available in Refund Vendor Invoices")
								[+] else
									[ ] ReportStatus("Verify Closed Checking Account in Refund Vendor Invoice Account", FAIL, "{sCheckingAccount} is closed and available in Refund Vendor Invoices")
									[ ] 
								[ ] RefundVendorInvoice.Close()
								[+] 
									[+] // if(AlertMessage.Exists(SHORT_SLEEP))
										[ ] // AlertMessage.SetActive()
										[ ] // AlertMessage.Yes.Click()
									[+] // else
										[ ] // RefundVendorInvoice.Close()
										[+] // if(AlertMessage.Exists(SHORT_SLEEP))
											[ ] // AlertMessage.SetActive()
											[ ] // AlertMessage.TypeKeys("Enter")
							[+] else
								[ ] ReportStatus("Verify Refund Vendor Invoice Account", FAIL, "Refund Vendor Invoices window is not available")
								[ ] 
							[+] if(ChooseBillAccount.Exists(SHORT_SLEEP))
								[ ] ChooseBillAccount.Cancel.Click()
						[+] else
							[ ] ReportStatus("Verify Choose Bill Account dialog", FAIL, "Choose Bill Account window is not opened")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify KeepThisAccountSeparate checkbox", FAIL, "KeepThisAccountSeparate checkbox is not checked")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Check KeepThisAccountSeparate checkbox", FAIL, "KeepThisAccountSeparate checkbox is not available")
					[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Business Account Navigation", FAIL, "Vendor Invoice account is not opened")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Close Vendor Inv account having scheduled reminders #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_CloseVIAccWithReminders()
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
		[ ] // Oct 23, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test12_CloseVIAccWithReminders () appstate none
	[ ] 
	[+] //Variable declaration
		[ ] STRING sActualMessage,sTab,sExpectedMessage1,sExpectedMessage2
		[ ] sAccount="Vendor Invoices 3"
		[ ] sTab= "Display Options"
		[ ] sExpectedMessage1="This account has one or more scheduled reminders"
		[ ] sExpectedMessage2="Account not closed"
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Investing Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BUSINESS,sAccount,sTab)			// Select Vendor Invoice account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] //Check "Close Account" button
			[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
				[ ] AccountDetails.CloseAccount.Click()
				[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
					[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
					[ ] PermanentlyCloseAccount.OK.Click()
					[+] 
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
					[ ] AccountDetails.SetActive()
					[ ] AccountDetails.Close()
					[ ] 
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
[+] //#############Verify Offset transaction entry for Close Account ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_BusinessOffsetTxnVerify()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify addition of balance offset transaction for closed account in the register.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If business account closed successfully and found balance offset transaction						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 25, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test13_BusinessOffsetTxnVerify() appstate none
	[ ] 
	[+] //Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sSearch
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Customer Invoices 1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Business Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BUSINESS,sAccount,sTab)			// Select business account
		[+] if (iSelect == PASS)
			[ ] //Check "Close Account" button
			[+] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
				[ ] Close:
				[+] if(!AccountDetails.CloseAccount.IsEnabled())
					[ ] ReportStatus("Check Close Account button", PASS, "{sAccount} is closed as Close Account button is disabled")
					[ ] //Close Account Details window
					[ ] AccountDetails.Close()
				[+] else
					[ ] AccountDetails.CloseAccount.Click()
					[+] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
						[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
						[ ] PermanentlyCloseAccount.OK.Click()
					[ ] goto Close
					[ ] 
			[+] else
				[ ] ReportStatus("Check Account Details window > Close Account button", FAIL, "Account Details > Close Account button window is not available") 
				[ ] 
			[ ] 
			[ ] //Verify offset entry
			[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BUSINESS)	// select business account
			[+] if(iSelect==PASS)
				[ ] ReportStatus("Select Closed Account", iSelect, "Closed Account is selected") 
				[ ] 
				[ ] iValidate = FindTransaction(sWindowType,sSearch,ACCOUNT_BUSINESS)		// find transaction
				[+] if(iValidate == PASS)
					[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found") 
				[+] else
					[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
				[ ] 
			[+] else
				[ ] ReportStatus("Select Closed  Account", iSelect, "Closed Account is not selected") 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "Business Account is not selected from Account bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Close Customer Inv account having scheduled reminders #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_CloseCIAccWithReminders()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify displaying of warning message if CI account to be closed has scheduled reminders in it.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If warning message is displayed						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Oct 26, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test15_CloseCIAccWithReminders () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sActualMessage,sTab,sExpectedMessage1,sExpectedMessage2
		[ ] sAccount="Customer Invoices 3"
		[ ] sTab= "Display Options"
		[ ] sExpectedMessage1="This account has one or more scheduled reminders"
		[ ] sExpectedMessage2="Account not closed"
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Investing Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BUSINESS,sAccount,sTab)			// Select Customer Invoice account
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
						[ ] if(AccountDetails.Exists(SHORT_SLEEP))
						[ ] 
					[+] else
						[ ] ReportStatus("Verify alert message dialog", FAIL, "Alert message dialog is not displayed")
						[ ] 
					[ ] AccountDetails.Close()
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
[+] //#############  SetUp ######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Tools_SetUp()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will create data file and add accounts and verify hidden account behavior for Tools
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			          Pass 		If no error occurs while creating file							
		[ ] // Fail			If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 23, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Tools_SetUp () appstate QuickenBaseState
	[ ] 
	[ ] // Variable declaration
	[ ] INTEGER iRegistration
	[ ] List of LIST OF STRING lsAccount
	[ ] 
	[ ] // sFileName = "HiddenAccount_Tools"
	[ ] // sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] // lsAccount = {{"Checking","Checking 01","500", "{sDateStamp}"},{"Checking","Checking 02","200", "{sDateStamp}"},{"Savings","Saving 01","500", "{sDateStamp}"},{"Savings","Saving 02","200", "{sDateStamp}"}}
	[ ] 
	[ ] STRING sFileName = "HiddenAccountTools"
	[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
	[ ] 
	[ ] 
	[ ] //Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
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
	[ ] QuickenWindow.SetActive()
	[ ] //Open Data File
	[ ] iCreateDataFile = OpenDataFile(sFileName)
	[ ] //Report Staus If Data file Created successfully
	[+] if ( iCreateDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is opened")
	[+] else 
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is not opened")
		[ ] 
	[ ] 
	[ ] //Set Classic View
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] //Bypass Registration
	[ ] //iRegistration=BypassRegistration()
	[ ] //Select Home tab
	[ ] NavigateQuickenTab(sTAB_HOME)
	[ ] //Off Popup Register
	[ ] UsePopUpRegister("OFF")
	[ ] 
	[+] //Need to remove---------
		[+] // for(i=1;i<=Listcount(lsAccount);i++)
			[ ] // //Add Checking Account
			[ ] // iAddAccount = AddManualSpendingAccount(lsAccount[i][1], lsAccount[i][2], lsAccount[i][3], lsAccount[i][4])
			[ ] // //Report Status if checking Account is created
			[+] // if (iAddAccount==PASS)
				[ ] // ReportStatus("{lsAccount[i][1]} Account", iAddAccount, "{lsAccount[i][1]} Account -  {lsAccount[i][2]}  is created successfully")
			[+] // else
				[ ] // ReportStatus("{lsAccount[i][1]} Account", iAddAccount, "{lsAccount[i][1]} Account -  {lsAccount[i][2]}  is not created successfully")
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############Verify Closed saving Account in Reconcile Account window ############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_CloseAccountInReconcileAccount()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed account should not get displayed in the Reconcile an Account dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If banking account closed successfully and not available in Reconcile an Account dialog				
		[ ] // Fail		If any error occurs or closed account available in Reconcile an Account dialog	
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 23, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_CloseAccountInReconcileAccount () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iCount
		[ ] STRING sSearch
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Saving 01"
		[ ] iAccountPosition=3
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Saving Account
		[ ] iSelect = CloseAccount(ACCOUNT_BANKING,sAccount,iAccountPosition)			// Select first savings account
		[+] if (iSelect == PASS)
			[ ] ReportStatus("Validate Close Account step", iSelect, "Banking Account {sAccount} is closed")
			[ ] //Verify offset entry
			[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	// select account
			[+] if(iSelect==PASS)
				[ ] ReportStatus("Select Closed Account", iSelect, "Closed Account is selected") 
				[ ] 
				[ ] iValidate = FindTransaction(sWindowType,sSearch)		// find transaction
				[+] if(iValidate == PASS)
					[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found in {sAccount} account") 
					[ ] 
					[ ] //Select Home tab
					[ ] iSelect=NavigateQuickenTab(sTAB_HOME)
					[+] if(iSelect==PASS)
						[ ] //Navigate to Tools > Reconcile an Account
						[ ] QuickenWindow.Tools.Click()
						[ ] QuickenWindow.Tools.ReconcileAnAccount.Select()
						[ ] sleep(1)
						[ ] //Search closed account name in Chosse Reconcile Account window
						[+] if(ChooseReconcileAccount.Exists(SHORT_SLEEP))
							[ ] ChooseReconcileAccount.SetActive()
							[ ] iCount= ChooseReconcileAccount.ChooseAccount.FindItem(sAccount)
							[+] if(iCount==0)
								[ ] ReportStatus("Verify closed saving account in Choose Reconcile Account dialog", PASS, "Closed saving account is not available in Choose Reconcile Account dialog")
							[+] else
								[ ] ReportStatus("Verify closed saving account in Choose Reconcile Account dialog", FAIL, "Closed saving account is available in Choose Reconcile Account dialog")
							[ ] ChooseReconcileAccount.Close()
						[+] else
							[ ] ReportStatus("Verify Choose Reconcile Account window",FAIL,"Choose Reconcile Account window is not opened")
					[+] else
						[ ] ReportStatus("Navigate to Home tab",FAIL,"Home tab is not opened")
				[+] else
					[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
				[ ] 
			[+] else
				[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Close Account step", iSelect, "Banking Account {sAccount} is not closed")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Separate saving Account in Reconcile Account window ###########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_SeparateAccountInReconcileAccount()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that separate account should get displayed in the Reconcile an Account dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If banking account separated successfully and available in Reconcile an Account dialog				
		[ ] // Fail		If any error occurs or separated account is not available in Reconcile an Account dialog	
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 23, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test02_SeparateAccountInReconcileAccount () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCount
		[ ] sAccount="Saving 02"
		[ ] iAccountPosition=4
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Edit Saving Account
		[ ] iSelect = SeparateAccount(ACCOUNT_BANKING,sAccount)			// Separate saving account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
			[+] if (iSeparate == PASS)
				[ ] AccountDetails.Cancel.Click()
				[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and saving account is displayed under this seaction")
				[ ] 
				[ ] //Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] //Navigate to Tools > Reconcile an Account
				[ ] QuickenWindow.Tools.Click()
				[ ] QuickenWindow.Tools.ReconcileAnAccount.Select()
				[ ] sleep(1)
				[ ] //Search separate account name in Chosse Reconcile Account window
				[+] if(ChooseReconcileAccount.Exists(SHORT_SLEEP))
					[ ] ChooseReconcileAccount.SetActive()
					[ ] iCount= ChooseReconcileAccount.ChooseAccount.FindItem(sAccount)
					[+] if(iCount>0)
						[ ] ReportStatus("Verify separate saving account in Choose Reconcile Account dialog", PASS, "Separated saving account is available in Choose Reconcile Account dialog")
					[+] else
						[ ] ReportStatus("Verify separate saving account in Choose Reconcile Account dialog", FAIL, "Separated saving account is not available in Choose Reconcile Account dialog")
					[ ] ChooseReconcileAccount.Close()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Choose Reconcile Account window",FAIL,"Choose Reconcile Account window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Separate section is not created")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "First Banking Account is not selected from Account bar")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed saving Account in Write Checks window #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_CloseAccountInWriteChecks()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed account should not get displayed on the Write Checks dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If closed banking account is not available in Write checks dialog				
		[ ] // Fail		If any error occurs or closed account available in Write checks dialog	
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 26, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_CloseAccountInWriteChecks () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iCount
		[ ] STRING sSearch
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Saving 01"
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
				[ ] // Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] //Navigate to Tools > Write and Print Checks
				[ ] QuickenWindow.Tools.Click()
				[ ] QuickenWindow.Tools.WriteAndPrintChecks.Select()
				[ ] sleep(1)
				[ ] //Search closed account name in Write Checks window
				[+] if(WriteChecks.Exists(SHORT_SLEEP))
					[ ] WriteChecks.SetActive()
					[ ] iCount= WriteChecks.WriteChecksFrom.FindItem(sAccount)
					[+] if(iCount==0)
						[ ] ReportStatus("Verify closed saving account in Write Checks dialog", PASS, "Closed saving account is not available in Write Checks dialog")
					[+] else
						[ ] ReportStatus("Verify closed saving account in Write Checks dialog", FAIL, "Closed saving account is available in Write Checks dialog")
					[ ] WriteChecks.Close()
				[+] else
					[ ] ReportStatus("Verify Write Checkst window",FAIL,"Write Checks window is not opened")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found hence {sAccount} account is not closed") 
			[ ] 
		[+] else
			[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Separate saving Account in Write Checks window ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_SeparateAccountInWriteChecks()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that separate account should get displayed in the Write Checks dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If separated banking account available in Write Checks dialog				
		[ ] // Fail		If any error occurs or separated account is not available in Reconcile an Account dialog	
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 26, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test04_SeparateAccountInWriteChecks () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCount
		[ ] sAccount="Saving 02"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
		[+] if (iSeparate == PASS)
			[ ] AccountDetails.Cancel.Click()
			[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and saving account is displayed under this seaction")
			[ ] 
			[ ] //Select Home tab
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] //Navigate to Tools > Write and Prints Checks
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.WriteAndPrintChecks.Select()
			[ ] 
			[ ] //Search separate account name in Write Checks window
			[+] if(WriteChecks.Exists(SHORT_SLEEP))
				[ ] WriteChecks.SetActive()
				[ ] iCount= WriteChecks.WriteChecksFrom.FindItem(sAccount)
				[+] if(iCount>0)
					[ ] ReportStatus("Verify separate saving account in Write Checks dialog", PASS, "Separated saving account is available in Write Checks dialog")
				[+] else
					[ ] ReportStatus("Verify separate saving account in Write Checks dialog", FAIL, "Separated saving account is not available in Write Checks dialog")
				[ ] WriteChecks.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Write Checkst window",FAIL,"Write Checks window is not opened")
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
[+] //#############Verify Closed saving Account in Calender ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_CloseAccountInCalendar()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed account should  get displayed on the Select Calendar account  dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If closed banking account is available in Select Calendar account  dialog.			
		[ ] // Fail		If any error occurs or closed account not available in Select Calendar account dialog.
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 26, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test05_CloseAccountInCalendar () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iListCount
		[ ] STRING sSearch
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Saving 01"
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
				[ ] //Navigate to Tools > Calendar
				[ ] QuickenWindow.Tools.Click()
				[ ] QuickenWindow.Tools.Calendar.Select()
				[ ] 
				[+] if(Calendar.Exists(SHORT_SLEEP))
					[ ] Calendar.Options.Click()
					[+] for ( i = 1; i<=7; i++)
						[ ] Calendar.Options.Typekeys(KEY_DN)
					[ ] Calendar.Options.Typekeys(KEY_ENTER)
					[ ] 
					[ ] //Search closed account name in Calendar Accounts window
					[+] if(CalendarAccounts.Exists(SHORT_SLEEP))
						[ ] CalendarAccounts.SetActive()
						[ ] sHandle = Str(CalendarAccounts.Account.ListBox1.GetHandle())
						[ ] iListCount=CalendarAccounts.Account.ListBox1.GetItemCount()
						[+] for(i=1;i<=iListCount;i++)
							[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
							[ ] bMatch = MatchStr("*{sAccount}*", sActual)
							[+] if(bMatch == TRUE)
								[ ] ReportStatus("Verify closed saving account in Calendar Account dialog", PASS, "Closed saving account is available in Calendar Account dialog")
								[ ] break
							[+] else
								[+] if(i==iListCount)
									[ ] ReportStatus("Verify closed saving account in Caledar Account dialog", FAIL, "Closed saving account is not available in Calendar Account dialog")
						[ ] 
						[ ] CalendarAccounts.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Caledar Account dialog", FAIL, "Calendar Account dialog is not opened")
					[ ] 
					[ ] Calendar.Close()
				[+] else
					[ ] ReportStatus("Verify Calendar window",FAIL,"Calendar window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
			[ ] 
		[+] else
			[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Separate saving Account in Calender ##########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_SeparateAccountInCalendar()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate account should  get displayed on the Select Calendar account  dialog.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Separate banking account is available in Select Calendar account  dialog.			
		[ ] // Fail		If any error occurs or Separate account not available in Select Calendar account dialog.
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 26, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test06_SeparateAccountInCalendar () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iFind,iListCount
		[ ] sAccount="Saving 02"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
		[+] if (iSeparate == PASS)
			[ ] AccountDetails.Cancel.Click()
			[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and saving account is displayed under this seaction")
			[ ] 
			[ ] //Select Home tab
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] //Navigate to Tools > Calendar
			[ ] QuickenWindow.Tools.Calendar.Select()
			[ ] 
			[+] if(Calendar.Exists(SHORT_SLEEP))
				[ ] 
				[ ] Calendar.Options.Click()
				[+] for ( i = 1; i<=7; i++)
					[ ] Calendar.Options.Typekeys(KEY_DN)
				[ ] Calendar.Options.Typekeys(KEY_ENTER)
				[ ] 
				[ ] //Search Separate account name in Calendar Accounts window
				[+] if(CalendarAccounts.Exists(SHORT_SLEEP))
					[ ] sHandle = Str(CalendarAccounts.Account.ListBox1.GetHandle())
					[ ] iListCount=CalendarAccounts.Account.ListBox1.GetItemCount()
					[+] for(i=1;i<=iListCount;i++)
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
						[ ] bMatch = MatchStr("*{sAccount}*", sActual)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Verify Separate saving account in Calendar Account dialog", PASS, "Separate saving account is available in Calendar Account dialog")
							[ ] break
						[+] else
							[+] if(i==iListCount)
								[ ] ReportStatus("Verify Separate saving account in Caledar Account dialog", FAIL, "Separate saving account is not available in Calendar Account dialog")
					[ ] 
					[ ] CalendarAccounts.Close()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Caledar Account dialog", FAIL, "Calendar Account dialog is not opened")
					[ ] 
				[ ] 
				[ ] Calendar.Close()
			[+] else
				[ ] ReportStatus("Verify Calendar window",FAIL,"Calendar window is not opened")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Account {sAccount} is not separated")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed saving account in Enter Expense Transaction dialog #######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_CloseAccountInEnterExpenseTxn()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed account should not be displayed on the Enter Expense Transaction dialog
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If closed banking account is not available in Enter Expense Transaction dialog		
		[ ] // Fail		If any error occurs or closed account is available in Enter Expense Transaction dialog
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 26, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test07_CloseAccountInEnterExpenseTxn () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iFind
		[ ] STRING sSearch
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Saving 01"
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
				[ ] //Navigate to Tools > Calendar
				[ ] QuickenWindow.Tools.Click()
				[ ] QuickenWindow.Tools.Calendar.Select()
				[ ] 
				[+] if(Calendar.Exists(SHORT_SLEEP))
					[ ] Calendar.SetActive()
					[ ] Calendar.Maximize()
					[ ] // Right click on Calendar and select Add Expense option
					[ ] 
					[ ] //Calendar.Options.PopupSelect(12, 6, "Add expense")
					[ ] Calendar.Options.OpenContextMenu()                         //, "Add expense")
					[ ] Calendar.Options.TypeKeys(Replicate(KEY_DN,3))
					[ ] Calendar.Options.TypeKeys(KEY_ENTER)
					[ ] 
					[ ] 
					[ ] 
					[+] if(EnterExpenseIncomeTxn.Exists(SHORT_SLEEP))
						[ ] EnterExpenseIncomeTxn.SetActive()
						[ ] //Search closed account name in Enter Expense Transaction window
						[ ] iFind= EnterExpenseIncomeTxn.AccountToUse.FindItem(sAccount)
						[+] if(iFind==0)
							[ ] ReportStatus("Verify closed saving account in Enter Expense Transaction window", PASS, "Closed saving account is not available in Enter Expense Transaction window")
						[+] else
							[ ] ReportStatus("Verify closed saving account in Enter Expense Transaction window", FAIL, "Closed saving account is available in Enter Expense Transaction window")
						[ ] 
						[ ] EnterExpenseIncomeTxn.Close()
					[+] else
						[ ] ReportStatus("Verify Enter Expense Transaction window", FAIL, "Enter Expense Transaction window is not opened")
						[ ] 
					[ ] 
					[ ] Calendar.Close()
				[+] else
					[ ] ReportStatus("Verify Calendar window",FAIL,"Calendar window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
			[ ] 
		[+] else
			[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Separate saving account in Enter Expense Transaction dialog #####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_SeparateAccountInEnterExpenseTxn()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate account should  get displayed on the Enter Expense Transaction dialog
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Separate banking account is available in Enter Expense Transaction dialog			
		[ ] // Fail		If any error occurs or Separate account not available in Enter Expense Transaction dialog
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 27, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test08_SeparateAccountInEnterExpenseTxn () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iFind
		[ ] sAccount="Saving 02"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
		[+] if (iSeparate == PASS)
			[ ] AccountDetails.Cancel.Click()
			[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and saving account is displayed under this seaction")
			[ ] 
			[ ] //Select Home tab
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] //Navigate to Tools > Calendar
			[ ] QuickenWindow.Tools.Click()
			[ ] QuickenWindow.Tools.Calendar.Select()
			[ ] 
			[+] if(Calendar.Exists(SHORT_SLEEP))
				[ ] Calendar.SetActive()
				[ ] 
				[ ] // Right click on Calendar and select Add Expense option
				[ ] //Calendar.Options.PopupSelect (12, 6, "Add expense")
				[ ] Calendar.Options.OpenContextMenu(12, 6)                         //, "Add expense")
				[ ] Calendar.Options.TypeKeys(Replicate(KEY_DN,3))
				[ ] Calendar.Options.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] 
				[+] if(EnterExpenseIncomeTxn.Exists(SHORT_SLEEP))
					[ ] EnterExpenseIncomeTxn.SetActive()
					[ ] //Search separate account name in Enter Expense Transaction window
					[ ] iFind= EnterExpenseIncomeTxn.AccountToUse.FindItem(sAccount)
					[+] if(iFind>0)
						[ ] ReportStatus("Verify separate saving account in Enter Expense Transaction window", PASS, "Separate saving account is available in Enter Expense Transaction window")
					[+] else
						[ ] ReportStatus("Verify separate saving account in Enter Expense Transaction window", FAIL, "Separate saving account is not available in Enter Expense Transaction window")
					[ ] EnterExpenseIncomeTxn.Close()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Enter Expense Transaction window", FAIL, "Enter Expense Transaction window is not opened")
					[ ] 
				[ ] //Close Calendar
				[ ] Calendar.Close()
			[+] else
				[ ] ReportStatus("Verify Calendar window",FAIL,"Calendar window is not opened")
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
[+] //#############Verify closed saving account in Enter Income Transaction dialog #######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_CloseAccountInEnterIncomeTxn()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed account should  not be displayed on the Enter Income Transaction dialog
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If closed banking account is not available in Enter Income Transaction dialog		
		[ ] // Fail		If any error occurs or closed account is available in Enter Income Transaction dialog
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 27, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test09_CloseAccountInEnterIncomeTxn () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iFind
		[ ] STRING sSearch
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Saving 01"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify offset entry
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	// select account
		[+] if(iSelect==PASS)
			[ ] iValidate = FindTransaction(sWindowType,sSearch)		// find transaction
			[+] if(iValidate == PASS)
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is foundin {sAccount} account") 
				[ ] ReportStatus("Select Closed Account", iSelect, "Closed Account {sAccount} is selected")
				[ ] 
				[ ] //Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] //Navigate to Tools > Calendar
				[ ] QuickenWindow.Tools.Click()
				[ ] QuickenWindow.Tools.Calendar.Select()
				[ ] 
				[+] if(Calendar.Exists(SHORT_SLEEP))
					[ ] Calendar.SetActive()
					[ ] 
					[ ] //Right click on Calendar and select Add Expense option
					[ ] //Calendar.Options.PopupSelect (12, 6, "Add income")
					[ ] Calendar.Options.OpenContextMenu(12, 6)                         //, "Add expense")
					[ ] Calendar.Options.TypeKeys(Replicate(KEY_DN,4))
					[ ] Calendar.Options.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(EnterExpenseIncomeTxn.Exists(SHORT_SLEEP))
						[ ] EnterExpenseIncomeTxn.SetActive()
						[ ] //Search closed account name in Enter Expense Transaction window
						[ ] iFind= EnterExpenseIncomeTxn.AccountToUse.FindItem(sAccount)
						[+] if(iFind==0)
							[ ] ReportStatus("Verify closed saving account in Enter Income Transaction window", PASS, "Closed saving account is not available in Enter Income Transaction window")
						[+] else
							[ ] ReportStatus("Verify closed saving account in Enter Income Transaction window", FAIL, "Closed saving account is available in Enter Income Transaction window")
						[ ] 
						[ ] EnterExpenseIncomeTxn.Close()
					[+] else
						[ ] ReportStatus("Verify Enter Expense Transaction window", FAIL, "Enter Expense Transaction window is not opened")
						[ ] 
					[ ] //Close Calendar
					[ ] Calendar.Close()
				[+] else
					[ ] ReportStatus("Verify Calendar window",FAIL,"Calendar window is not opened")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
			[ ] 
		[+] else
			[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Separate saving account in Enter Income Transaction dialog #####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_SeparateAccountInEnterIncomeTxn()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate account should  get displayed on the Enter Income Transaction dialog
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Separate banking account is available in Enter Income Transaction dialog			
		[ ] // Fail		If any error occurs or Separate account not available in Enter Income Transaction dialog
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 30, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test10_SeparateAccountInEnterIncomeTxn () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iFind
		[ ] sAccount="Saving 02"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
		[+] if (iSeparate == PASS)
			[ ] AccountDetails.Cancel.Click()
			[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and saving account is displayed under this seaction")
			[ ] 
			[ ] //Select Home tab
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] //Navigate to Tools > Calendar
			[ ] QuickenWindow.Tools.Calendar.Select()
			[ ] 
			[+] if(Calendar.Exists(SHORT_SLEEP))
				[ ] Calendar.SetActive()
				[ ] 
				[ ] //Right click on Calendar and select Add Income option
				[ ] //Calendar.Options.PopupSelect (12, 6, "Add income")
				[ ] Calendar.Options.OpenContextMenu(12, 6)                         //, "Add expense")
				[ ] Calendar.Options.TypeKeys(Replicate(KEY_DN,4))
				[ ] Calendar.Options.TypeKeys(KEY_ENTER)
				[ ] 
				[+] if(EnterExpenseIncomeTxn.Exists(SHORT_SLEEP))
					[ ] 
					[ ] EnterExpenseIncomeTxn.SetActive()
					[ ] //Search separate account name in Enter Expense Transaction window
					[ ] iFind= EnterExpenseIncomeTxn.AccountToUse.FindItem(sAccount)
					[+] if(iFind>0)
						[ ] ReportStatus("Verify separate saving account in Enter Income Transaction window", PASS, "Separate saving account is available in Enter Income Transaction window")
					[+] else
						[ ] ReportStatus("Verify separate saving account in Enter Income Transaction window", FAIL, "Separate saving account is not available in Enter Income Transaction window")
					[ ] EnterExpenseIncomeTxn.Close()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Enter Expense Transaction window", FAIL, "Enter Expense Transaction window is not opened")
				[ ] 
				[ ] //Close Calendar
				[ ] Calendar.Close()
			[+] else
				[ ] ReportStatus("Verify Calendar window",FAIL,"Calendar window is not opened")
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
[+] //#############Verify closed saving account in Edit Register Transaction dialog #######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_CloseAccountInEditRegisterTxn()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed account should  not be displayed on the Edit Register Transaction dialog
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:	Pass 	If closed banking account is not available in Edit Register Transaction dialog		
		[ ] // Fail		If any error occurs or closed account is available in Edit Register Transaction dialog
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 30, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test11_CloseAccountInEditRegisterTxn () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iFind,iAddTransaction
		[ ] STRING sSearch,sTransactionType,sAmount
		[ ] sTransactionType = "Payment"
		[ ] sAmount = "50"
		[ ] sSearch = "Balance Offset Tx"
		[ ] sAccount="Saving 01"
		[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify offset entry
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	// select account
		[+] if(iSelect==PASS)
			[ ] iValidate = FindTransaction(sWindowType,sSearch)		// find transaction
			[+] if(iValidate == PASS)
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found") 
				[ ] ReportStatus("Select Closed Account", iSelect, "Closed Account {sAccount} is selected") 
				[ ] 
				[ ] //Select Home tab
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] 
				[ ] //This will click  first Banking account on AccountBar
				[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("Select Checking Account", iSelect, "Checking Account is selected") 
					[ ] 
					[ ] //Add Payment Transaction to Checking account
					[ ] iAddTransaction= AddCheckingTransaction(sWindowType,sTransactionType, sAmount, sDateStamp)
					[+] if(iAddTransaction==PASS)
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction is added to banking account") 
						[ ] 
						[ ] //Navigate to Tools > Calendar
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.Tools.DoubleClick()
						[ ] QuickenWindow.Tools.Calendar.Select()
						[ ] 
						[ ] //Right click on Calendar and select Transactions option
						[ ] Calendar.SetActive()
						[ ] Calendar.Maximize()
						[ ] Calendar.Options.OpenContextMenu()                        
						[ ] Calendar.Options.TypeKeys(Replicate(KEY_DN,1))
						[ ] Calendar.Options.TypeKeys(KEY_ENTER)
						[ ] 
						[+] if(TransactionsOnDate.Exists(SHORT_SLEEP))
							[ ] TransactionsOnDate.SetActive()
							[ ] TransactionsOnDate.Edit.DoubleClick()
							[+] if(EditRegisterTransaction.Exists(SHORT_SLEEP))
								[ ] EditRegisterTransaction.SetActive()
								[ ] //Search closed account name in Edit Register Transaction window
								[ ] iFind= EditRegisterTransaction.AccountToUse.FindItem(sAccount)
								[+] if(iFind==0)
									[ ] ReportStatus("Verify closed saving account in Edit Register Transaction window", PASS, "Closed saving account is not available in Edit Register Transaction window")
								[+] else
									[ ] ReportStatus("Verify closed saving account in Edit Register Transaction window", FAIL, "Closed saving account {sAccount} is available in Edit Register Transaction window -defect QW-3952")
								[ ] 
								[ ] EditRegisterTransaction.Close()
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Edit Register Transaction window", FAIL, "Edit Register Transaction window is not opened")
								[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Transaction on Date window", FAIL, "Transaction on Date window is not opened")
							[ ] 
						[ ] 
						[ ] Calendar.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction is added to banking account") 
					[ ] 
				[+] else
					[ ] ReportStatus("Select Checking Account", iSelect, "Checking Account is selected") 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
			[ ] 
		[+] else
			[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Separate saving account in Edit Register Transaction dialog #####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_SeparateAccountInEnterIncomeTxn()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Separate account should  get displayed on the Edit Register Transaction dialog
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Separate banking account is available in Edit Register Transaction dialog			
		[ ] // Fail		If any error occurs or Separate account not available in Edit Register Transaction dialog
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Nov 30, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test12_SeparateAccountInEditRegisterTxn () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iFind
		[ ] sAccount="Saving 02"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
		[+] if (iSeparate == PASS)
			[ ] AccountDetails.Cancel.Click()
			[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and saving account is displayed under this seaction")
			[ ] 
			[ ] //Select Home tab
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] //Navigate to Tools > Calendar
			[ ] QuickenWindow.Tools.DoubleClick()
			[ ] QuickenWindow.Tools.Calendar.Select()
			[ ] 
			[+] if(Calendar.Exists(SHORT_SLEEP))
				[ ] Calendar.SetActive()
				[ ] 
				[ ] //Right click on Calendar and select Transaction option
				[ ] Calendar.Options.OpenContextMenu()                       
				[ ] Calendar.Options.TypeKeys(Replicate(KEY_DN,1))
				[ ] Calendar.Options.TypeKeys(KEY_ENTER)
				[ ] 
				[+] if(TransactionsOnDate.Exists(SHORT_SLEEP))
					[ ] TransactionsOnDate.SetActive()
					[ ] TransactionsOnDate.Edit.Click()
					[+] if(EditRegisterTransaction.Exists(SHORT_SLEEP))
						[ ] EditRegisterTransaction.SetActive()
						[ ] //Search closed account name in Edit Register Transaction window
						[ ] iFind= EditRegisterTransaction.AccountToUse.FindItem(sAccount)
						[+] if(iFind>0)
							[ ] ReportStatus("Verify separate saving account in Edit Register Transaction window", PASS, "Separate saving account {sAccount} is available in Edit Register Transaction window")
						[+] else
							[ ] ReportStatus("Verify separate saving account in Edit Register Transaction window", FAIL, "Separate saving account {sAccount} is not available in Edit Register Transaction window")
						[ ] EditRegisterTransaction.Close()
					[+] else
						[ ] ReportStatus("Verify Edit Register Transaction window", FAIL, "Edit Register Transaction window is not opened")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Transaction on Date window", FAIL, "Transaction on Date window is not opened")
					[ ] 
				[ ] 
				[ ] Calendar.Close()
			[+] else
				[ ] ReportStatus("Verify Calendar window", FAIL, "Calendar window is not opened")
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
	[ ] 
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
	[ ] //Create Data File
	[ ] iCreateDataFile = OpenDataFile(sFileName)
	[ ] //Report Staus If Data file Created successfully
	[+] if ( iCreateDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is opened")
		[ ] CloseQuickenConnectedServices()
	[+] else 
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is not opened")
	[ ] 
	[ ] //Set Classic View
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] //Bypass Registration
	[ ] iRegistration=BypassRegistration()
	[ ] //Select Home tab
	[ ] NavigateQuickenTab(sTAB_HOME)
	[ ] //Off Popup Register
	[ ] UsePopUpRegister("OFF")
	[ ] 
	[ ] ExpandAccountBar()
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
	[-] if(QuickenWindow.Exists(SHORT_SLEEP))
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
[+] //#############Verify Hide in Transaction entry lists in Add Bill Reminder ##############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_HideInTxnListInAddBillReminder()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check Account Display option "-Hide In Transaction Entry List"  in Add Bill Reminder window
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Setting saved successfully
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 14, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test11_HideInTxnListInAddBillReminder() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCount1,iCount2
		[ ] STRING sPayeeName
		[ ] sAccount="Checking 03"
		[ ] sPayeeName= "Payee1"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Hide In Transaction Entry List checking  Account
		[ ] iSelect = AccountHideInTransactionList(ACCOUNT_BANKING,sAccount,2)			// Select  account
		[+] if (iSelect == PASS)
			[ ] 
			[ ] //Select Home tab
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] //Navigate to Bills > Add Reminder >  Bill Reminder
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Bills.Click()
			[ ] QuickenWindow.Bills.AddReminder.Click()
			[ ] 
			[ ] QuickenWindow.Bills.AddReminder.BillReminder.Select()
			[ ] 
			[ ] //Search account name in Add Bill window
			[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
				[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayToTextField.SetText (sPayeeName)
				[ ] DlgAddEditReminder.NextButton.Click()
				[ ] DlgAddEditReminder.SetActive()
				[ ] DlgAddEditReminder.FromAccountButton.Click()
				[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, FALSE)
				[ ] iCount1=AccountQuickFillBill.QWinChild.ListBox.GetItemCount()
				[+] if(AccountQuickFillBill.ShowHiddenAccountsCheckBox.Exists(SHORT_SLEEP))
					[ ] AccountQuickFillBill.ShowHiddenAccountsCheckBox.Click()
					[ ] iCount2=AccountQuickFillBill.QWinChild.ListBox.GetItemCount()
					[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, TRUE)
					[+] if (iCount1==iCount2-1)
						[ ] ReportStatus("Verify Hide in Transaction entry lists", PASS, "Account {sAccount} is available in Add Bill Reminder window when Show Hidden Account checkbox is checked")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Hide in Transaction entry lists", FAIL, "Account {sAccount} is not available in Add Bill Reminder window when Show Hidden Account checkbox checked")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify show hidden accounts checkbox", FAIL, "Show Hidden Account checkbox is not available in Add Bill Reminder")
					[ ] 
				[ ] DlgAddEditReminder.Close()
			[+] else
				[ ] ReportStatus("Verify Add Bill Reminder window", FAIL, "Add Bill Reminder window is not available")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "Account is not selected from Account bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############Verify Hide in Transaction entry lists in Add Income Reminder###########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_HideInTxnListInAddIncomeReminder()
		[ ] // 
		[ ] // This testcase will Check Account Display option "-Hide In Transaction Entry List"  in Add Income Reminder window
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Setting saved successfully
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 14, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test12_HideInTxnListInAddIncomeReminder() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCount1,iCount2
		[ ] STRING sTab,sPayeeName
		[ ] sAccount="Checking 03"
		[ ] sPayeeName= "Payee1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Select Home tab
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[+] //Navigate to Bills > Add Reminder >  Income Reminder
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Bills.Click()
			[ ] QuickenWindow.Bills.AddReminder.Click()
		[ ] 
		[ ] QuickenWindow.Bills.AddReminder.IncomeReminder.Select()
		[ ] 
		[ ] //Search account name in Add Income Reminder window
		[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
			[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayToTextField.SetText (sPayeeName)
			[ ] DlgAddEditReminder.NextButton.Click()
			[ ] DlgAddEditReminder.SetActive()
			[ ] DlgAddEditReminder.ToAccountButton.Click()
			[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, FALSE)
			[ ] iCount1=AccountQuickFillBill.QWinChild.ListBox.GetItemCount()
			[ ] //Verify Show Hidden Accounts checkbox
			[+] if(AccountQuickFillBill.ShowHiddenAccountsCheckBox.Exists(SHORT_SLEEP))
				[ ] AccountQuickFillBill.ShowHiddenAccountsCheckBox.Click()
				[ ] iCount2=AccountQuickFillBill.QWinChild.ListBox.GetItemCount()
				[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, TRUE)
				[ ] 
				[+] if (iCount1==iCount2-1)
					[ ] ReportStatus("Verify Hide in Transaction entry lists", PASS, "Account {sAccount} is available in Add Income Reminder window when Show Hidden Account checkbox is checked")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Hide in Transaction entry lists", FAIL, "Account {sAccount} is not available in Add Income Reminder window when Show Hidden Account checkbox checked")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify show hidden accounts checkbox", FAIL, "Show Hidden Account checkbox is not available in Add Income Reminder")
				[ ] 
			[ ] DlgAddEditReminder.Close()
		[+] else
			[ ] ReportStatus("Verify Add Income Reminder window", FAIL, "Add Income Reminder window is not available")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide in Transaction entry lists in Add Transfer Reminder ##########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_HideInTxnListInAddTransferReminder()
		[ ] // 
		[ ] // This testcase will Check Account Display option "-Hide In Transaction Entry List"  in Add Transfer Reminder window
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Setting saved successfully
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 14, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test13_HideInTxnListInAddTransferReminder() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCount1,iCount2
		[ ] STRING sTab,sPayeeName
		[ ] sAccount="Checking 03"
		[ ] sPayeeName= "Payee1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
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
		[ ] //Search separate account name in Add TRansfer Reminder window
		[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
			[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayToTextField.SetText (sPayeeName)
			[ ] DlgAddEditReminder.NextButton.Click()
			[ ] DlgAddEditReminder.SetActive()
			[ ] //Verification for From Account
			[ ] DlgAddEditReminder.FromAccountButton.Click()
			[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, FALSE)
			[ ] 
			[ ] print(AccountQuickFillBill.ShowHiddenAccountsCheckBox.GetState())
			[+] if(AccountQuickFillBill.ShowHiddenAccountsCheckBox.IsChecked())
				[ ] AccountQuickFillBill.ShowHiddenAccountsCheckBox.Click()
			[ ] iCount1=AccountQuickFillBill.QWinChild.ListBox.GetItemCount()
			[ ] //Verify Show Hidden Accounts checkbox
			[+] if(AccountQuickFillBill.ShowHiddenAccountsCheckBox.Exists(SHORT_SLEEP))
				[ ] AccountQuickFillBill.ShowHiddenAccountsCheckBox.Click()
				[ ] iCount2=AccountQuickFillBill.QWinChild.ListBox.GetItemCount()
				[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, TRUE)
				[ ] 
				[+] if (iCount1==iCount2-1)
					[ ] ReportStatus("Verify Hide in Transaction entry lists", PASS, "Account {sAccount} is available in From Account dropdown if Show Hidden Account checkbox is checked")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Hide in Transaction entry lists", FAIL, "Account {sAccount} is not available in From Account dropdown if Show Hidden Account checkbox checked")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify show hidden accounts checkbox", FAIL, "Show Hidden Account checkbox is not available in Add Transfer Reminder")
				[ ] 
			[ ] 
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetFocus()
			[ ] sleep(1)
			[ ] //Verification for To Account
			[ ] DlgAddEditReminder.ToAccountForTransferButton.Click()
			[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, FALSE)
			[ ] iCount1=AccountQuickFill.QWinChild.ListBox.GetItemCount()
			[ ] sleep(1)
			[ ] //Verify Show Hidden Accounts checkbox
			[+] if(AccountQuickFill.ShowHiddenAccountsCheckBox.Exists(SHORT_SLEEP))
				[ ] AccountQuickFill.ShowHiddenAccountsCheckBox.Click()
				[ ] iCount2=AccountQuickFill.QWinChild.ListBox.GetItemCount()
				[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, TRUE)
				[ ] 
				[+] if (iCount1==iCount2-1)
					[ ] ReportStatus("Verify Hide in Transaction entry lists", PASS, "Account {sAccount} is available in To Account dropdown if Show Hidden Account checkbox is checked")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Hide in Transaction entry lists", FAIL, "Account {sAccount} is not available in To Account dropdown if Show Hidden Account checkbox checked, QW-3850")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify show hidden accounts checkbox", FAIL, "Show Hidden Account checkbox is not available in Add Transfer Reminder")
				[ ] 
			[ ] DlgAddEditReminder.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Transfer Reminder window", FAIL, "Add Transfer Reminder window is not available")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide in Transaction entry lists in Add Paycheck Reminder ##########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_HideInTxnListInAddPaycheck1()
		[ ] // 
		[ ] // This testcase will Check Account Display option "-Hide In Transaction Entry List"  in Add Paycheck Reminder window - Net amount
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Setting saved successfully
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 14, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test14_HideInTxnListInAddPaycheck1() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCount1,iCount2
		[ ] STRING sTab,sPayeeName
		[ ] sAccount="Checking 03"
		[ ] sPayeeName= "Payee1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Select Home tab
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[+] //Navigate to Bills > Add Reminder >  Paycheck Reminder
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Bills.Click()
			[ ] QuickenWindow.Bills.AddReminder.Click()
		[ ] 
		[ ] QuickenWindow.Bills.AddReminder.PaycheckReminder.Select()
		[ ] 
		[ ] //Search account name in Add Paycheck Reminder window
		[+] if(PayCheckSetup.Exists(SHORT_SLEEP) == TRUE)
			[ ] PayCheckSetup.SetActive ()
			[ ] PayCheckSetup.HowMuchPaycheck.Select("Net amount")
			[ ] PayCheckSetup.Next.Click ()
			[+] if (DlgAddEditReminder.Exists(SHORT_SLEEP))
				[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayToTextField.SetText ("Test")
				[ ] DlgAddEditReminder.NextButton.Click()
				[ ] DlgAddEditReminder.SetActive()
				[ ] //Verification for To Account
				[ ] DlgAddEditReminder.ToAccountButton.Click()
				[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, FALSE)
				[ ] iCount1=AccountQuickFill.QWinChild.ListBox.GetItemCount()
				[ ] //Verify Show Hidden Accounts checkbox
				[+] if(AccountQuickFill.QWinChild.ListBox.Exists(SHORT_SLEEP))
					[ ] AccountQuickFill.ShowHiddenAccountsCheckBox.Click()
					[ ] iCount2=AccountQuickFill.QWinChild.ListBox.GetItemCount()
					[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, TRUE)
					[ ] 
					[+] if (iCount1==iCount2-1)
						[ ] ReportStatus("Verify Hide in Transaction entry lists", PASS, "Account {sAccount} is available in To Account dropdown if Show Hidden Account checkbox is checked")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Hide in Transaction entry lists", FAIL, "Account {sAccount} is not available in To Account dropdown if Show Hidden Account checkbox checked")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify show hidden accounts checkbox", FAIL, "Show Hidden Account checkbox is not available in Add Paycheck Reminder")
					[ ] 
				[ ] DlgAddEditReminder.Close()
			[+] else
				[ ] ReportStatus("Verify Reminder window",FAIL,"Reminder window is not opened")
		[+] else
			[ ] ReportStatus("Verify Add Paycheck window", FAIL, "Add Paycheck window is not available")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide in Transaction entry lists in Add Paycheck Reminder ##########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_HideInTxnListInAddPaycheck2()
		[ ] // 
		[ ] // This testcase will Check Account Display option "-Hide In Transaction Entry List"  in Add Paycheck Reminder window - Gross amount
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	If Setting saved successfully
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 14, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test15_HideInTxnListInAddPaycheck2() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iFind
		[ ] STRING sTab,sPayeeName,sCompany
		[ ] sAccount="Checking 03"
		[ ] sPayeeName= "Payee1"
		[ ] sCompany = "Persistent"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
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
			[+] if (iFind==0)
				[ ] ReportStatus("Verify account {sAccount} in Paycheck Setup window", PASS, "Account {sAccount} is not available in Paycheck Setup window as account is hidden from transaction list")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify account {sAccount} in Paycheck Setup window", FAIL, "Account {sAccount} is available in Paycheck Setup window as account is not hidden from transaction list, QW-3672")
			[ ] 
			[ ] PayCheckSetup.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Paycheck window", FAIL, "Add Paycheck window is not available")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
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
[ ] // 
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
	[-] if(QuickenWindow.Exists(SHORT_SLEEP))
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
		[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
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
					[ ] 
					[+] if(AlertMessage.Yes.Exists(5))
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
						[+] if(AccountDetails.Exists(SHORT_SLEEP))
							[ ] AccountDetails.SetActive()
							[ ] AccountDetails.Close()
						[ ] 
						[ ] //Navigate to Home Page
						[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
						[+] if (iNavigate == PASS)
							[+] if(MDIClient.Home.VScrollBar.Exists(3))
								[ ] MDIClient.Home.VScrollBar.ScrollToMax()
							[ ] //Check for Get Started button
							[ ] MDIClient.Home.Textclick("Get Started" ,1)
							[+] if (StayOnTopOfMonthlyBills.Exists(5))
								[ ] ReportStatus("Verify reminder displayed on home page", PASS, "No reminder is displayed on Home page as Account is closed")
								[ ] StayOnTopOfMonthlyBills.SetActive()
								[ ] StayOnTopOfMonthlyBills.Close()
							[+] else
								[+] if(CreateANewBudget.Exists(2))
									[ ] CreateANewBudget.SetActive()
									[ ] CreateANewBudget.Close()
								[ ] ReportStatus("Verify reminder displayed on home page", FAIL, "Reminder is displayed on Home page")
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
	[-] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] //Navigate to Home Page
		[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
		[-] if (iNavigate == PASS)
			[+] if(MDIClient.Home.VScrollBar.Exists(3))
				[ ] MDIClient.Home.VScrollBar.ScrollToMax()
			[ ] //Check for Get Started button
			[ ] MDIClient.Home.Textclick("Get Started" ,1)
			[-] if (StayOnTopOfMonthlyBills.Exists(5))
				[ ] ReportStatus("Verify reminder displayed on home page", PASS, "No reminder is displayed on Home page as Account is closed")
				[ ] StayOnTopOfMonthlyBills.SetActive()
				[ ] StayOnTopOfMonthlyBills.Close()
				[ ] 
				[ ] //Select Bills tab
				[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
				[ ] 
				[ ] iAddReminder=AddIncomeTransferReminder(rReminderData)
				[+] if(iAddReminder==PASS)
					[ ] ReportStatus("Add Transfer Reminder", PASS, "Transfer reminder added successfully")
					[ ] 
					[ ] //Navigate to Home Page
					[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
					[+] if (iNavigate == PASS)
						[ ] //Check for Get Started button
						[+] if (MDIClient.Home.ListBox1.Exists(SHORT_SLEEP))
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
										[ ] 
										[+] if(AlertMessage.Yes.Exists(SHORT_SLEEP))
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
											[ ] // Close Account details window
											[+] if(AccountDetails.Exists(SHORT_SLEEP))
												[ ] AccountDetails.SetActive()
												[ ] AccountDetails.Close()
											[ ] 
											[ ] //Navigate to Home Page
											[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
											[+] if (iNavigate == PASS)
												[ ] //Check for Get Started button
												[ ] MDIClient.Home.Textclick("Get Started" ,1)
												[+] if (StayOnTopOfMonthlyBills.Exists(5))
													[ ] ReportStatus("Verify reminder displayed on home page", PASS, "Transfer reminder is not displayed on Home page after closing To account {sAccount}")
													[ ] StayOnTopOfMonthlyBills.SetActive()
													[ ] StayOnTopOfMonthlyBills.Close()
												[+] else
													[ ] ReportStatus("Verify reminder displayed on home page", FAIL, "Transfer reminder is displayed on Home page even after closing To account {sAccount}")
											[+] else
												[ ] ReportStatus("Navigate to Home Page", FAIL, "Navigation to Home page is failed")
											[ ] 
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
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Close account having online repeating bill reminders in sent state ########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test25_CloseAccWithOnlineRepeatingBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // User should not be able to close an account if it has online repeating bill reminders in sent state and no pending transaction.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If account is not closed				
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 24, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test25_CloseAccWithOnlineRepeatingBill() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iAddReminder,iNavigate
		[ ] STRING sActualMessage,sTab,sAccount,sExpectedMessage1,sExpectedMessage2
		[ ] 
		[ ] IncTranReminderRecord rReminderData 
		[ ] 
		[ ] sAccount="Saving 01"
		[ ] STRING sFileName="OnlineBill"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
		[ ] 
		[ ] sExpectedMessage1="This account has one or more scheduled reminders"
		[ ] sExpectedMessage2="Account not closed"
		[ ] rReminderData.sReminderType= "Transfer Reminder"
		[ ] rReminderData.sPayeeName="Payee1"
		[ ] rReminderData.sDate=FormatDateTime (GetDateTime(), "mm/dd/yyyy")
		[ ] rReminderData.sToAccount=sAccount
		[ ] rReminderData.sFromAccount="Saving 02"
		[ ] rReminderData.sAmount="20"
		[ ] rReminderData.sMemo="Memo1"
		[ ] rReminderData.sTag="Tag1"
		[ ] sTab= "Display Options"
		[ ] 
		[ ] 
	[ ] 
	[-] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] sCaption = QuickenMainWindow.GetCaption()
		[ ] bCaption = MatchStr("*{sFileName}*", sCaption)
		[+] if(bCaption == FALSE)
			[ ] bExists = FileExists(sDataFile)
			[+] if(bExists == TRUE)
				[ ] DeleteFile(sDataFile)
				[ ] CopyFile(sSourceFile,sDataFile)
				[ ] OpenDataFile(sFileName)
			[ ] 
		[ ] 
		[ ] 
		[ ] // // Navigate to Home Page
		[ ] // iNavigate = NavigateQuickenTab(sTAB_HOME)
		[-] // if (iNavigate == PASS)
			[ ] // // Check for Get Started button
			[+] // if (Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.GetStarted.Exists(SHORT_SLEEP))
				[ ] // ReportStatus("Verify reminder displayed on home page", PASS, "No reminder is displayed on Home page")
			[+] // else
				[ ] // ReportStatus("Verify reminder displayed on home page", PASS, "Reminder is displayed on Home page")
		[+] // else
			[ ] // ReportStatus("Navigate to Home Page", PASS, "Navigation to Home page is failed")
		[ ] 
		[ ] 
		[ ] // Select Bills tab
		[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
		[ ] 
		[ ] iAddReminder=AddIncomeTransferReminder(rReminderData)
		[+] if(iAddReminder==PASS)
			[ ] ReportStatus("Add Transfer Reminder", PASS, "Transfer reminder added successfully")
		[+] else
			[ ] ReportStatus("Add Transfer Reminder",FAIL, "Transfer reminder is not get added")
		[ ] 
		[ ] // // Navigate to Home Page
		[ ] // iNavigate = NavigateQuickenTab(sTAB_HOME)
		[-] // if (iNavigate == PASS)
			[ ] // // Check for Get Started button
			[+] // if (!Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.GetStarted.Exists(SHORT_SLEEP))
				[ ] // ReportStatus("Verify reminder displayed on home page", PASS, "Reminder is displayed on Home page")
			[+] // else
				[ ] // ReportStatus("Verify reminder displayed on home page", PASS, "Reminder is not displayed on Home page")
		[+] // else
			[ ] // ReportStatus("Navigate to Home Page", PASS, "Navigation to Home page is failed")
		[ ] 
		[ ] 
		[ ] // Edit Banking Account
		[ ] iSelect = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sAccount,sTab)				// Select account
		[-] if (iSelect == PASS)
			[ ] 
			[ ] // Check "Close Account" button
			[-] if(AccountDetails.CloseAccount.Exists(SHORT_SLEEP))
				[ ] AccountDetails.CloseAccount.Click()
				[-] if(PermanentlyCloseAccount.Exists(SHORT_SLEEP))
					[ ] PermanentlyCloseAccount.TypeYesToConfirm.SetText("yes")
					[ ] PermanentlyCloseAccount.OK.Click()
					[ ] // if(AlertMessageForCloseAccount.Exists(SHORT_SLEEP))
					[-] if(AlertMessage.Exists(SHORT_SLEEP))
						[ ] 
						[ ] // Get alert message
						[ ] sActualMessage=AlertMessage.MessageText.GetText()
						[+] if(MatchStr("{sExpectedMessage1}*",sActualMessage))
							[ ] ReportStatus("Verify alert message", PASS, "Correct alert message is displayed i.e. {sExpectedMessage1}")
						[+] else
							[ ] ReportStatus("Verify alert message", FAIL, "Actual alert message: {sActualMessage} and Expected alert message: {sExpectedMessage1}")
						[ ] AlertMessage.Yes.Click()
						[ ] 
						[ ] // Verify second alert message is not displayed
						[+] if(!AlertMessage.Exists(SHORT_SLEEP))
							[ ] ReportStatus("Verify alert is not displayed and closed te account", PASS, "Alert message is not displayed and Account is closed successfully")
						[+] else
							[ ] ReportStatus("Verify alert is not displayed and closed te account", FAIL, "Alert message is displayed and Account is not closed")
							[ ] AlertMessage.Close()
						[ ] 
						[ ] // Close Account details window
						[+] if(AccountDetails.Exists(SHORT_SLEEP))
							[ ] AccountDetails.SetActive()
							[ ] AccountDetails.Close()
						[ ] 
						[ ] // Navigate to Home Page
						[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
						[-] if (iNavigate == PASS)
							[ ] // Check for Get Started button
							[ ] MDIClient.Home.Textclick("Get Started" ,1)
							[-] if (StayOnTopOfMonthlyBills.Exists(5))
								[ ] ReportStatus("Verify reminder displayed on home page", PASS, "Transfer reminder is not displayed on Home page after closing To account {sAccount}")
								[ ] StayOnTopOfMonthlyBills.SetActive()
								[ ] StayOnTopOfMonthlyBills.Close()
							[+] else
								[ ] ReportStatus("Verify reminder displayed on home page", FAIL, "Transfer reminder is displayed on Home page even after closing To account {sAccount}")
						[+] else
							[ ] ReportStatus("Navigate to Home Page", PASS, "Navigation to Home page is failed")
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
[ ] //******************************************************************************************************************************************
[ ] 
[+] //#############  Rental SetUp #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Rental_SetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will create data file and add accounts and verify hidden account behavior for Rental
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while creating file							
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 27, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Rental_SetUp () appstate QuickenBaseState
	[ ] 
	[ ] // Variable declaration
	[ ] INTEGER iRegistration,iAddAccount
	[ ] List of LIST OF STRING lsAccount
	[ ] List of LIST OF STRING lsAssetAccount
	[ ] LIST OF List of ANYTYPE lsAddProperty
	[ ] 
	[ ] sFileName = "HiddenAccountRental"
	[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] STRING sSourceFile = AUT_DATAFILE_PATH + "\Hidden Account\" + sFileName + ".QDF"
	[ ] 
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive()
		[ ] // QuickenWindow.Exit()
	[+] else
		[+] if(FileExists(sDataFile) == TRUE)
			[ ] DeleteFile(sDataFile)
			[ ] 
		[ ] QuickenWindow.Start (sCmdLine)
		[ ] 
	[ ] 
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] // Create Data File
	[ ] iCreateDataFile = OpenDataFile(sFileName)
	[ ] // Report Staus If Data file Created successfully
	[+] if ( iCreateDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
		[ ] //RegisterQuickenConnectedServices()
	[+] else 
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] // Set Classic View
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] // Select Home tab
	[ ] NavigateQuickenTab(sTAB_HOME)
	[ ] // Off Popup Register
	[ ] UsePopUpRegister("OFF")
	[ ] 
	[ ] ExpandAccountBar()
	[+] //Need to remove-----
		[+] // for(i=1;i<=Listcount(lsAccount);i++)
			[ ] // // Add Checking Account
			[ ] // iAddAccount = AddManualSpendingAccount(lsAccount[i][1], lsAccount[i][2], lsAccount[i][3], lsAccount[i][4])
			[ ] // // Report Status if checking Account is created
			[+] // if (iAddAccount==PASS)
				[ ] // ReportStatus("{lsAccount[i][1]} Account", iAddAccount, "{lsAccount[i][1]} Account -  {lsAccount[i][2]}  is created successfully")
			[+] // else
				[ ] // ReportStatus("{lsAccount[i][1]} Account", iAddAccount, "{lsAccount[i][1]} Account -  {lsAccount[i][2]}  is not created successfully")
			[ ] // 
		[+] // for(i=1;i<=Listcount(lsAssetAccount);i++)
			[ ] // // Add Asset Account (House)
			[ ] // iAddAccount = AddPropertyAccount(lsAssetAccount[i][1],  lsAssetAccount[i][2], lsAssetAccount[i][3], lsAssetAccount[i][4], lsAssetAccount[i][5])
			[ ] // // Report Status if Asset Account is created
			[+] // if (iAddAccount==PASS)
				[ ] // ReportStatus("Add Asset Account", iAddAccount, "Asset Account -  {lsAssetAccount[i][2]}  is created successfully")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Add Asset Account", iAddAccount, "Asset Account -  {lsAssetAccount[i][2]}  is not created")
				[ ] // 
			[ ] // 
		[+] // for(i=1;i<=ListCount(lsAddProperty);i++)
			[ ] // iAddAccount = AddRentalProperty(lsAddProperty[i])
			[+] // if (iAddAccount==PASS)
				[ ] // ReportStatus("Add Property", iAddAccount, "Property is created successfully")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Add Property", iAddAccount, "Property  is not created successfully")
				[ ] // 
			[ ] // 
	[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //#############Verify Closed House Account in Add Rental Property window ############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_CloseAccountInAddRentalProperty()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that closed account should not get displayed in the Add Rental Property window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If house account closed successfully and not available in Add Rental Property window			
		[ ] //						Fail		If any error occurs or closed account available in Add Rental Property window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 27, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_CloseAccountInAddRentalProperty () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] sAccount="House Asset1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iValidate= CloseAccount(ACCOUNT_PROPERTYDEBT, sAccount)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Close House Account",iValidate,"Account {sAccount} is closed")
			[ ] 
			[ ] // Select Rental Property
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
			[ ] 
			[ ] 
			[ ] // On right top 3 menus should be displayed-A.Add Transactions B.Properties and Tenants C.Reports 
			[+] if(QuickenMainWindow.QWNavigator1.AddTransactions.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Add Transaction menu",PASS,"Add Transaction menu is displayed")
			[+] else
				[ ] ReportStatus("Verify Add Transaction menu",FAIL,"Add Transaction menu is not displayed")
				[ ] 
			[+] if(QuickenMainWindow.QWNavigator1.PropertiesTenants.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Properties and Tenants menu",PASS,"Properties and Tenants menu is displayed")
			[+] else
				[ ] ReportStatus("Verify Properties and Tenants menu",FAIL,"Properties and Tenants menu is not displayed")
				[ ] 
			[+] if(QuickenMainWindow.QWNavigator1.Reports.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Reports menu",PASS,"Reports menu is displayed")
			[+] else
				[ ] ReportStatus("Verify Reports menu",FAIL,"Reports menu is not displayed")
				[ ] 
			[ ] 
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_DN)
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] // Search closed account name in Add Rental Property
			[+] if (AddEditRentalProperty.Exists(SHORT_SLEEP))
				[ ] AddEditRentalProperty.HouseAccountName.Select("Yes, I am tracking the value of this rental property")
				[+] if(AddEditRentalProperty.AccountName.FindItem(sAccount)==0)
					[ ] ReportStatus("Verify {sAccount} in Add Rental Property window",PASS, "Account {sAccount} is not available as it is closed")
				[+] else
					[ ] ReportStatus("Verify {sAccount} in Add Rental Property window",FAIL, "Account {sAccount} is available as it is closed")
					[ ] 
				[ ] AddEditRentalProperty.Close()
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Rental Property window", FAIL, "Add Rental Property window is not available")
			[ ] 
		[+] else
			[ ] ReportStatus("Close House Account",iValidate,"Account {sAccount} is closed")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Separated House Account in Add Rental Property window #########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_SeparateAccountInAddRentalProperty()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that separate account should get displayed in the Add Rental Property window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If house account separated successfully and available in Add Rental Property window			
		[ ] //						Fail		If any error occurs or separated account not available in Add Rental Property window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 28, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test02_SeparateAccountInAddRentalProperty () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] sAccount="House Asset2"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iValidate= SeparateAccount(ACCOUNT_PROPERTYDEBT, sAccount)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Separate House Account",iValidate,"Account {sAccount} is separated")
			[ ] 
			[ ] // Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE,sAccount)
			[+] if (iSeparate == PASS)
				[ ] AccountDetails.Cancel.Click()
				[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and account {sAccount} is displayed under this section")
				[ ] 
				[ ] // Select Rental Property
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
				[ ] 
				[ ] // On right top 3 menus should be displayed-A.Add Transactions B.Properties and Tenants C.Reports 
				[+] if(QuickenMainWindow.QWNavigator1.AddTransactions.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Add Transaction menu",PASS,"Add Transaction menu is displayed")
				[+] else
					[ ] ReportStatus("Verify Add Transaction menu",FAIL,"Add Transaction menu is not displayed")
					[ ] 
				[+] if(QuickenMainWindow.QWNavigator1.PropertiesTenants.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Properties and Tenants menu",PASS,"Properties and Tenants menu is displayed")
				[+] else
					[ ] ReportStatus("Verify Properties and Tenants menu",FAIL,"Properties and Tenants menu is not displayed")
					[ ] 
				[+] if(QuickenMainWindow.QWNavigator1.Reports.Exists(SHORT_SLEEP))
					[ ] ReportStatus("Verify Reports menu",PASS,"Reports menu is displayed")
				[+] else
					[ ] ReportStatus("Verify Reports menu",FAIL,"Reports menu is not displayed")
					[ ] 
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_DN)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Search separate account name in Add Rental Property
				[+] if (AddEditRentalProperty.Exists(SHORT_SLEEP))
					[ ] AddEditRentalProperty.HouseAccountName.Select("Yes, I am tracking the value of this rental property")
					[+] if(AddEditRentalProperty.AccountName.FindItem(sAccount)>0)
						[ ] ReportStatus("Verify separate account {sAccount} in Add Rental Property window",PASS, "Separate Account {sAccount} is available as it is separated")
					[+] else
						[ ] ReportStatus("Verify separate account {sAccount} in Add Rental Property window",FAIL, "Separate Account {sAccount} is not available even if  it is separated")
						[ ] 
					[ ] AddEditRentalProperty.Close()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Add Rental Property window", FAIL, "Add Rental Property window is not available")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Separate section is not created")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Separate House Account",iValidate,"Account {sAccount} is separated")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide in Transaction List in Add Rental Property window ###########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_HideInTxnListInAddRentalProperty()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Account hidden from Transaction entry lists should be displayed in new-property-Accounts dropdown in Rental Property tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If house account available in Add Rental Property window			
		[ ] //						Fail		If any error occurs or account is not available in Add Rental Property window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 28, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_HideInTxnListInAddRentalProperty () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] sAccount="House Asset3"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iValidate= AccountHideInTransactionList(ACCOUNT_PROPERTYDEBT, sAccount)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Hide House Account in Transaction List",iValidate,"Account {sAccount} is hidden in transaction list")
			[ ] 
			[ ] // Select Rental Property
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
			[ ] 
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_DN)
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] // Search account name in Add Rental Property
			[+] if (AddEditRentalProperty.Exists(SHORT_SLEEP))
				[ ] AddEditRentalProperty.HouseAccountName.Select("Yes, I am tracking the value of this rental property")
				[+] if(AddEditRentalProperty.AccountName.FindItem(sAccount)>0)
					[ ] ReportStatus("Verify account {sAccount} in Add Rental Property window",PASS, "Account {sAccount} is available as it is hidden from transaction list")
				[+] else
					[ ] ReportStatus("Verify account {sAccount} in Add Rental Property window",FAIL, "Account {sAccount} is not available even if it is hidden from transaction list")
					[ ] 
				[ ] AddEditRentalProperty.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Rental Property window", FAIL, "Add Rental Property window is not available")
			[ ] 
		[+] else
			[ ] ReportStatus("Hide House Account in Transaction List",iValidate,"Account {sAccount} is not hidden in transaction list")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide in Account bar and Account List #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_HideInAccountBarInAddRentalProperty()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Accounts hidden from account bar and account list should be displayed in new-property-Accounts dropdown in Rental Property tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If house account available in Add Rental Property window			
		[ ] //						Fail		If any error occurs or account is not available in Add Rental Property window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 31, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test04_HideInAccountBarInAddRentalProperty () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] sAccount="House Asset3"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iValidate= AccountHideInAccountBarAccountList(ACCOUNT_PROPERTYDEBT, sAccount, 2)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] ReportStatus("Hide House Account in Account Bar and Account List",iValidate,"Account {sAccount} is hidden from Account Bar and Account List")
			[ ] 
			[ ] // Select Rental Property
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
			[ ] 
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_DN)
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] // Search account name in Add Rental Property
			[+] if (AddEditRentalProperty.Exists(SHORT_SLEEP))
				[ ] AddEditRentalProperty.HouseAccountName.Select("Yes, I am tracking the value of this rental property")
				[+] if(AddEditRentalProperty.AccountName.FindItem(sAccount)>0)
					[ ] ReportStatus("Verify account {sAccount} in Add Rental Property window",PASS, "Account {sAccount} is available as it is hidden from account bar and account list")
				[+] else
					[ ] ReportStatus("Verify account {sAccount} in Add Rental Property window",FAIL, "Account {sAccount} is not available even if it is hidden from account bar and account list")
					[ ] 
				[ ] AddEditRentalProperty.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Rental Property window", FAIL, "Add Rental Property window is not available")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Hide House Account in Account Bar and Account List",iValidate,"Account {sAccount} is hidden from Account Bar and Account List")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed account in Property and Tenants section ##################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_ClosedAccountInRentalPropertyTenant()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify close account is not display in Add Rental Property Tenant
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If closed checking account is not available in Add Rental Property Tenant window
		[ ] //						Fail		If any error occurs or account is available in Add Rental Property Tenant window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 31, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test05_ClosedAccountInRentalPropertyTenant () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sAmount
		[ ] sAccount="Checking 01"
		[ ] sAmount = "100"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iValidate= CloseAccount(ACCOUNT_BANKING, sAccount, 1)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Close account {sAccount}",iValidate,"Account {sAccount} is closed")
			[ ] 
			[ ] // Select Rental Property
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
			[ ] 
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,3))
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] // Search account name in Add Rental Property Tenant dialog 
			[+] if (DlgAddRentalPropertyTenant.Exists(SHORT_SLEEP))
				[ ] DlgAddRentalPropertyTenant.SetActive()
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditRentAmount.SetText(sAmount)
				[+] if(DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.FindItem(sAccount)==0)
					[ ] ReportStatus("Verify account {sAccount} in Add Rental Property Tenant window",PASS, "Account {sAccount} is not available in Add Rental Property Tenant window as it is closed")
				[+] else
					[ ] ReportStatus("Verify account {sAccount} in Add Rental Property Tenant window",FAIL, "Account {sAccount} is available in Add Rental Property Tenant window even if it is closed")
					[ ] 
				[ ] DlgAddRentalPropertyTenant.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Rental Property Tenant window", FAIL, "Add Rental Property Tenant window is not available")
			[ ] 
		[+] else
			[ ] ReportStatus("Close account {sAccount}",iValidate,"Account {sAccount} is not closed")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //#############Verify Separate account in Property and Tenants section #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_SeparateAccountInRentalPropertyTenant()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify separate account is displayed in Add Rental Property Tenant
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separated checking account is available in Add Rental Property Tenant window
		[ ] //						Fail		If any error occurs or account is not available in Add Rental Property Tenant window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Dec 31, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test06_SeparateAccountInRentalPropertyTenant () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sAmount
		[ ] sAccount="Checking 02"
		[ ] sAmount = "100"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iValidate= SeparateAccount(ACCOUNT_BANKING, sAccount)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Separate account {sAccount}",iValidate,"Account {sAccount} is Separated")
			[ ] 
			[ ] // Select Rental Property
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
			[ ] 
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,3))
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] // Search account name in Add Rental Property Tenant dialog 
			[+] if (DlgAddRentalPropertyTenant.Exists(SHORT_SLEEP))
				[ ] DlgAddRentalPropertyTenant.SetActive()
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditRentAmount.SetText(sAmount)
				[+] if(DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.FindItem(sAccount)>0)
					[ ] ReportStatus("Verify account {sAccount} in Add Rental Property Tenant window",PASS, "Account {sAccount} is available in Add Rental Property Tenant window as it is separated")
				[+] else
					[ ] ReportStatus("Verify account {sAccount} in Add Rental Property Tenant window",FAIL, "Account {sAccount} is not available in Add Rental Property Tenant window even if it is sepataed")
					[ ] 
				[ ] DlgAddRentalPropertyTenant.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Rental Property Tenant window", FAIL, "Add Rental Property Tenant window is not available")
			[ ] 
		[+] else
			[ ] ReportStatus("Separate account {sAccount}",iValidate,"Account {sAccount} is not Separated")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //#############Verify Hide in Transaction List in Add Rental Property Tenant window ######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_HideInTxnListInAddRentalPropertyTenant()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Account hidden from Transaction entry lists should not be displayed in new-property-Accounts dropdown in Rental Property tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If account not available in Add Rental Property Tenant window			
		[ ] //						Fail		If any error occurs or account is available in Add Rental Property Tenant window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 01, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test07_HideInTxnListInAddRentalPropertyTenant () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sAmount
		[ ] sAccount="Saving 01"
		[ ] sAmount="150"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iValidate= AccountHideInTransactionList(ACCOUNT_BANKING, sAccount, 3)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] ReportStatus("Hide Account {sAccount} in Transaction List",iValidate,"Account {sAccount} is hidden in transaction list")
			[ ] 
			[ ] // Select Rental Property
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
			[ ] 
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,3))
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] // Search account name in Add Rental Property Tenant window
			[+] if (DlgAddRentalPropertyTenant.Exists(SHORT_SLEEP))
				[ ] DlgAddRentalPropertyTenant.SetActive()
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditRentAmount.SetText(sAmount)
				[+] if(DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.FindItem(sAccount)==0)
					[ ] ReportStatus("Verify account {sAccount} in Add Rental Property Tenant window",PASS, "Account {sAccount} is not available in Add Rental Property Tenant window as it is hidden from transaction list")
				[+] else
					[ ] ReportStatus("Verify account {sAccount} in Add Rental Property Tenant window",FAIL, "Account {sAccount} is available in Add Rental Property Tenant window even if it is hidden from transaction list")
					[ ] 
				[ ] DlgAddRentalPropertyTenant.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Rental Property Tenant window", FAIL, "Add Rental Property Tenant window is not available")
			[ ] 
		[+] else
			[ ] ReportStatus("Hide Account {sAccount} in Transaction List",iValidate,"Account {sAccount} is not made hidden in transaction list")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //#############Verify Hide in Account bar  in Add Rental Property Tenant window  ########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_HideInAccountBarInAddRentalPropertyTenant()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Accounts hidden from account bar and account list should be displayed in new-property-Accounts dropdown in Rental Property Tenant window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If account available in Add Rental Property Tenant window			
		[ ] //						Fail		If any error occurs or account is not available in Add Rental Property Tenant window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 01, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test08_HideInAccountBarInAddRentalPropertyTenant () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] STRING sAccount,sAmount
		[ ] sAccount="Saving 02"
		[ ] sAmount="150"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] iValidate= AccountHideInAccountBarAccountList(ACCOUNT_BANKING, sAccount)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] ReportStatus("Hide House Account in Account Bar and Account List",iValidate,"Account {sAccount} is hidden from Account Bar and Account List")
			[ ] 
			[ ] // NavigateQuickenTab(sTAB_HOME)
			[ ] 
			[ ] // Select Rental Property
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
			[ ] 
			[ ] 
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,3))
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] // Search account name in Add Rental Property Tenant window
			[+] if (DlgAddRentalPropertyTenant.Exists(SHORT_SLEEP))
				[ ] DlgAddRentalPropertyTenant.SetActive()
				[ ] DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.EditRentAmount.SetText(sAmount)
				[+] if(DlgAddRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.FindItem(sAccount)>0)
					[ ] ReportStatus("Verify account {sAccount} in Add Rental Property Tenant window",PASS, "Account {sAccount} is available in Add Rental Property Tenant window as it is hidden from Account Bar and Account List")
				[+] else
					[ ] ReportStatus("Verify account {sAccount} in Add Rental Property Tenant window",FAIL, "Account {sAccount} is not available in Add Rental Property Tenant window even if it is hidden from Account Bar and Account list")
					[ ] 
				[ ] DlgAddRentalPropertyTenant.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Rental Property Tenant window", FAIL, "Add Rental Property Tenant window is not available")
			[ ] 
		[+] else
			[ ] ReportStatus("Hide House Account in Account Bar and Account List",iValidate,"Account {sAccount} is not made hidden from Account Bar and Account List")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //#############Verify Closed account in Edit Rental Property Tenant ###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_ClosedAccountInEditRentalPropertyTenant()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify close account is not display in Edit Rental Property Tenant window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If closed banking account is not available in Edit Rental Property Tenant window
		[ ] //						Fail		If any error occurs or account is available in Edit Rental Property Tenant window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 01, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test09_ClosedAccountInEditRentalPropertyTenant() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate,iSelect
		[ ] LIST OF ANYTYPE lsAddTenant
		[ ] 
		[ ] sAccount="Checking 03"
		[ ] lsAddTenant={"Tenant1","Property1","150",sAccount}
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Select Rental Property
		[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
		[ ] 
		[ ] iSelect=AddRentalPropertyTenant(lsAddTenant)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Add Rental Property Tenant", iSelect, "Rental Property Tenant added successfully") 
			[ ] 
			[ ] iValidate= CloseAccount(ACCOUNT_BANKING, sAccount, 2)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Close account {sAccount}",iValidate,"Account {sAccount} is closed")
				[ ] 
				[ ] 
				[ ] // Select Rental Property
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,4))
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Search account name in Edit Rental Property Tenant dialog 
				[ ] WaitForState(TenantList,true,2)
				[+] if  (TenantList.Exists(SHORT_SLEEP))
					[ ] TenantList.Edit.Click()
					[ ] 
					[+] if (AddEditRentalPropertyTenant.Exists(SHORT_SLEEP))
						[ ] AddEditRentalPropertyTenant.SetActive()
						[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.SelectReminder.Select("#1")
						[+] if(AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.FindItem(sAccount)==0)
							[ ] ReportStatus("Verify account {sAccount} in Edit Rental Property Tenant window",PASS, "Account {sAccount} is not available in Edit Rental Property Tenant window as it is closed")
						[+] else
							[ ] ReportStatus("Verify account {sAccount} in Edit Rental Property Tenant window",FAIL, "Account {sAccount} is available in Edit Rental Property Tenant window even if it is closed")
							[ ] 
						[ ] AddEditRentalPropertyTenant.Close()
						[+] if  (TenantList.Exists(SHORT_SLEEP))
							[ ] TenantList.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Edit Rental Property Tenant window", FAIL, "Edit Rental Property Tenant window is not available")
				[+] else
					[ ] ReportStatus("Verify Tenant List window", FAIL, "Tenant List window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Close account {sAccount}",iValidate,"Account {sAccount} is not closed")
				[ ] 
			[ ] 
		[+] else 
			[ ] ReportStatus("Add Rental Property Tenant", iSelect, "Rental Property Tenant not added") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //#############Verify Separate account in Edit Rental Property Tenant ###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_SeparateAccountInEditRentalPropertyTenant()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify separate account is displayed in Edit Rental Property Tenant window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate banking account is available in Edit Rental Property Tenant window
		[ ] //						Fail		If any error occurs or account is not available in Edit Rental Property Tenant window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 02, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test10_SeparateAccountInEditRentalPropertyTenant() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] sAccount="Checking 02"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
		[+] if (iSeparate == PASS)
			[ ] AccountDetails.Cancel.Click()
			[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and account {sAccount} is displayed under this section")
			[ ] 
			[ ] // Select Rental Property
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
			[ ] 
			[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,4))
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] // Search account name in Edit Rental Property Tenant dialog 
			[ ] WaitForState(TenantList,true,2)
			[+] if(TenantList.Exists(SHORT_SLEEP))
				[ ] TenantList.Edit.Click()
				[ ] 
				[+] if (AddEditRentalPropertyTenant.Exists(SHORT_SLEEP))
					[ ] AddEditRentalPropertyTenant.SetActive()
					[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.SelectReminder.Select("New rent reminder")
					[+] if(AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.FindItem(sAccount)>0)
						[ ] ReportStatus("Verify account {sAccount} in Edit Rental Property Tenant window",PASS, "Account {sAccount} is available in Edit Rental Property Tenant window as it is separated")
					[+] else
						[ ] ReportStatus("Verify account {sAccount} in Edit Rental Property Tenant window",FAIL, "Account {sAccount} is not available in Edit Rental Property Tenant window even if it is separated")
						[ ] 
					[ ] AddEditRentalPropertyTenant.Close()
					[+] if  (TenantList.Exists(SHORT_SLEEP))
						[ ] TenantList.Close()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Edit Rental Property Tenant window", FAIL, "Edit Rental Property Tenant window is not available")
			[+] else
				[ ] ReportStatus("Verify Tenant List window", FAIL, "Tenant List window is not opened")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Separate section is not created")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //#############Verify Hide in Transaction List in Edit Rental Property Tenant #############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_HideInTxnListInEditRentalPropertyTenant()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Account hidden from Transaction entry lists should not be displayed in Edit Rental Property Tenant window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Account hidden from Transaction entry lists should not be displayed in Edit Rental Property Tenant window
		[ ] //						Fail		If any error occurs or account is available in Edit Rental Property Tenant window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 02, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test11_HideInTxnListInEditRentalPropertyTenant() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] sAccount="Saving 01"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify "Hide in Transaction List" checkbox is checked fot the account
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_BANKING, sAccount,sTab)
		[+] if (iSeparate == PASS)
			[ ] HideAccount:
			[+] if(AccountDetails.HideInTransactionEntryList.IsChecked())
				[ ] ReportStatus("Verify account {sAccount} is hidden from Transaction List", PASS, "Account {sAccount} is hidden from Transaction List")
				[ ] 
				[ ] AccountDetails.Cancel.Click()
				[ ] 
				[ ] 
				[ ] // Select Rental Property
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,4))
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Search account name in Edit Rental Property Tenant dialog 
				[ ] WaitForState(TenantList,true,2)
				[+] if  (TenantList.Exists(SHORT_SLEEP))
					[ ] TenantList.Edit.Click()
					[ ] 
					[+] if (AddEditRentalPropertyTenant.Exists(SHORT_SLEEP))
						[ ] AddEditRentalPropertyTenant.SetActive()
						[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.SelectReminder.Select("#1")
						[+] if(AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.FindItem(sAccount)==0)
							[ ] ReportStatus("Verify account {sAccount} in Edit Rental Property Tenant window",PASS, "Account {sAccount} is not available in Edit Rental Property Tenant window as it is hidden from transaction list")
						[+] else
							[ ] ReportStatus("Verify account {sAccount} in Edit Rental Property Tenant window",FAIL, "Account {sAccount} is available in Edit Rental Property Tenant window even if it is hidden from transaction list")
							[ ] 
						[ ] AddEditRentalPropertyTenant.Close()
						[+] if  (TenantList.Exists(SHORT_SLEEP))
							[ ] TenantList.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Edit Rental Property Tenant window", FAIL, "Edit Rental Property Tenant window is not available")
				[ ] 
				[+] else
					[ ] ReportStatus("Verify Tenant List window", FAIL, "Tenant List window is not opened")
				[ ] 
				[ ] 
			[+] else
				[ ] AccountDetails.HideInTransactionEntryList.Check()
				[ ] ReportStatus("Verify account {sAccount} is hidden from Transaction List", PASS, "Account {sAccount} is hidden from Transaction List")
				[ ] goto HideAccount
		[ ] 
		[+] else
			[ ] ReportStatus("Verify navigation to Account Details Tab", FAIL, "Display Options tab is not opened")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //#############Verify Hide in Account bar  in Edit Rental Property Tenant window  ########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_HideInAccountBarInEditRentalPropertyTenant()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Accounts hidden from account bar and account list should be displayed in Edit Rental Property Tenant window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If account available in Edit Rental Property Tenant window			
		[ ] //						Fail		If any error occurs or account is not available in Edit Rental Property Tenant window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 02, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test12_HideInAccountBarInEditRentalPropertyTenant () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iValidate
		[ ] 
		[ ] sAccount="Saving 02"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify "Hide in Account bar and Account List" checkbox is checked fot the account
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] iValidate=AccountBarSelect(ACCOUNT_BANKING, 4)
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(Replicate(KEY_DN,1))
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_ENTER)	
		[+] if(iValidate == PASS)
			[ ] NavigateToAccountDetails(sAccount)
			[ ] SelectAccountDetailsTabs(ACCOUNT_BANKING,sTab)
			[+] if(AccountDetails.HideAccountNameInAccountB.IsChecked())
				[ ] ReportStatus("Verify account {sAccount} is hidden from Account Bar", PASS, "Account {sAccount} is hidden from Account Bar")
				[ ] 
				[ ] AccountDetails.Close()
				[ ] 
				[ ] 
				[ ] // Select Rental Property
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
				[ ] 
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.PropertiesTenants.Click()
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,4))
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Search account name in Edit Rental Property Tenant window
				[ ] WaitForState(TenantList,true,2)
				[+] if  (TenantList.Exists(SHORT_SLEEP))
					[ ] TenantList.Edit.Click()
					[ ] 
					[+] if (AddEditRentalPropertyTenant.Exists(SHORT_SLEEP))
						[ ] AddEditRentalPropertyTenant.SetActive()
						[ ] AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.SelectReminder.Select("#1")
						[+] if(AddEditRentalPropertyTenant.AddEditTenantDetails.QWinChild1.PopupListAccountName.FindItem(sAccount)>0)
							[ ] ReportStatus("Verify account {sAccount} in Edit Rental Property Tenant window",PASS, "Account {sAccount} is available in Edit Rental Property Tenant window as it is hidden from Account Bar")
						[+] else
							[ ] ReportStatus("Verify account {sAccount} in Edit Rental Property Tenant window",FAIL, "Account {sAccount} is not available in Edit Rental Property Tenant window even if it is hidden from Account Bar")
							[ ] 
						[ ] AddEditRentalPropertyTenant.Close()
						[+] if  (TenantList.Exists(SHORT_SLEEP))
							[ ] TenantList.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Edit Rental Property Tenant window", FAIL, "Edit Rental Property Tenant window is not available")
				[+] else
					[ ] ReportStatus("Verify Tenant List window", FAIL, "Tenant List window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify account {sAccount} is hidden from Account Bar", FAIL, "Account {sAccount} is hidden from Account Bar")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Account {sAccount}", FAIL, "Navigation failed to {sAccount}")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed account in Enter Rent window #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_ClosedAccountInEnterRent()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify close account is not display in Enter Rent window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If closed banking account is not available in Enter Rent window
		[ ] //						Fail		If any error occurs or account is available in Enter Rent window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 02, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test13_ClosedAccountInEnterRent() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sProperty,sSearch
		[ ] INTEGER iValidate
		[ ] 
		[ ] sAccount="Checking 01"
		[ ] sProperty="Property1"
		[ ] sSearch = "Balance Offset Tx"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify offset entry
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	// select  checking account
		[+] if(iSelect==PASS)
			[ ] iValidate = FindTransaction(sWindowType,sSearch)		// find transaction
			[+] if(iValidate == PASS)
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found")
				[ ] ReportStatus("Select Closed Account", iSelect, "Closed Account is selected") 
				[ ] 
				[ ] // Select Rental Property
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_DN)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Search account name in Enter Rent dialog 
				[ ] WaitForState(DlgEnterRent,true,2)
				[+] if  (DlgEnterRent.Exists(SHORT_SLEEP))
					[ ] DlgEnterRent.SetActive()
					[ ] DlgEnterRent.PropertyPopupList.Select(sProperty)
					[+] if(DlgEnterRent.AccountPopupList.FindItem(sAccount) == 0)
							[ ] ReportStatus("Verify account {sAccount} in Enter Rent window",PASS, "Account {sAccount} is not available in Enter Rent window as it is closed")
					[+] else
						[ ] ReportStatus("Verify account {sAccount} in Enter Rent window",FAIL, "Account {sAccount} is available in Enter Rent window even if it is closed- Defect id DE3981-QW1828")
						[ ] 
					[ ] DlgEnterRent.Close()
				[+] else
					[ ] ReportStatus("Verify Enter Rent window", FAIL, "Enter Rent window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
			[ ] 
		[+] else
			[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed account in Enter Expense window ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_ClosedAccountInEnterExpense()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify close account is not display in Enter Expense window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If closed banking account is not available in Enter Expense window
		[ ] //						Fail		If any error occurs or account is available in Enter Expense window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 02, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test14_ClosedAccountInEnterExpense() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sProperty,sSearch
		[ ] INTEGER iValidate
		[ ] 
		[ ] sAccount="Checking 01"
		[ ] sProperty="Property1"
		[ ] sSearch = "Balance Offset Tx"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify offset entry
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	// select  checking account
		[+] if(iSelect==PASS)
			[ ] 
			[ ] iValidate = FindTransaction(sWindowType,sSearch)		// find transaction
			[+] if(iValidate == PASS)
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found in {sAccount} account") 
				[ ] ReportStatus("Select Closed Account", iSelect, "Closed Account is selected") 
				[ ] 
				[ ] // Select Rental Property
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_DN)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_DN)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Search account name in Enter Expense dialog 
				[ ] WaitForState(DlgEnterExpense,true,2)
				[+] if  (DlgEnterExpense.Exists(SHORT_SLEEP))
					[ ] DlgEnterExpense.SetActive()
					[ ] DlgEnterExpense.PropertyPopupList.Select(sProperty)
					[+] if(DlgEnterExpense.AccountPopupList.FindItem(sAccount) == 0)
							[ ] ReportStatus("Verify account {sAccount} in Enter Expense window",PASS, "Account {sAccount} is not available in Enter Expense window as it is closed")
					[+] else
						[ ] ReportStatus("Verify account {sAccount} in Enter Expense window",FAIL, "Account {sAccount} is available in Enter Expense window even if it is closed- Defect id DE3981-QW1828")
						[ ] 
					[ ] DlgEnterExpense.Close()
				[+] else
					[ ] ReportStatus("Verify Enter Expense window", FAIL, "Enter Expense window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
			[ ] 
		[+] else
			[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed account in Enter Other Income window ###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_ClosedAccountInEnterOtherIncome()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify close account is not display in Enter Other Income window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If closed banking account is not available in Enter Other Income window
		[ ] //						Fail		If any error occurs or account is available in Enter Other Income window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 03, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test15_ClosedAccountInEnterOtherIncome() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sProperty,sSearch
		[ ] INTEGER iValidate
		[ ] 
		[ ] sAccount="Checking 01"
		[ ] sProperty="Property1"
		[ ] sSearch = "Balance Offset Tx"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify offset entry
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)	// select  checking account
		[+] if(iSelect==PASS)
			[ ] 
			[ ] iValidate = FindTransaction(sWindowType,sSearch)		// find transaction
			[+] if(iValidate == PASS)
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is found in {sAccount} account")
				[ ] ReportStatus("Select Closed Account", iSelect, "Closed Account is selected") 
				[ ] 
				[ ] // Select Rental Property
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,3))
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Search account name in Enter Other Income dialog 
				[ ] WaitForState(DlgEnterOtherIncome,true,2)
				[+] if  (DlgEnterOtherIncome.Exists(SHORT_SLEEP))
					[ ] DlgEnterOtherIncome.SetActive()
					[ ] DlgEnterOtherIncome.PropertyPopupList.Select(sProperty)
					[+] if(DlgEnterOtherIncome.AccountPopupList.FindItem(sAccount) == 0)
							[ ] ReportStatus("Verify account {sAccount} in Enter Other Income window",PASS, "Account {sAccount} is not available in Enter Other Income window as it is closed")
					[+] else
						[ ] ReportStatus("Verify account {sAccount} in Enter Other Income window",FAIL, "Account {sAccount} is available in Enter Other Income window even if it is closed- Defect id DE3981-QW1828")
						[ ] 
					[ ] DlgEnterOtherIncome.Close()
				[+] else
					[ ] ReportStatus("Verify Enter Other Income window", FAIL, "Enter Other Income window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Offset Transaction", iValidate, "Transaction with Input - {sSearch} is not found") 
			[ ] 
		[+] else
			[ ] ReportStatus("SelectClosed  Account", iSelect, "Closed Account is not selected") 
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
[+] //#############Verify Separate account in Enter Rent window #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_SeparateAccountInEnterRent()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify separate account is displayed in Enter Rent window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separated banking account is available in Enter Rent window
		[ ] //						Fail		If any error occurs or account is not available in Enter Rent window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 03, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test16_SeparateAccountInEnterRent() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sProperty
		[ ] sAccount="Checking 02"
		[ ] sProperty="Property1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
		[+] if (iSeparate == PASS)
			[ ] AccountDetails.Cancel.Click()
			[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and account {sAccount} is displayed under this section")
			[ ] 
			[ ] // Select Rental Property
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
			[ ] 
			[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_DN)
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] // Search account name in Enter Rent dialog 
			[ ] WaitForState(DlgEnterRent,true,2)
			[+] if  (DlgEnterRent.Exists(SHORT_SLEEP))
				[ ] DlgEnterRent.SetActive()
				[ ] DlgEnterRent.PropertyPopupList.Select(sProperty)
				[+] if(DlgEnterRent.AccountPopupList.FindItem(sAccount) > 0)
						[ ] ReportStatus("Verify account {sAccount} in Enter Rent window",PASS, "Account {sAccount} is available in Enter Rent window as it is separated")
				[+] else
					[ ] ReportStatus("Verify account {sAccount} in Enter Rent window",FAIL, "Account {sAccount} is not available in Enter Rent window even if it is separated")
					[ ] 
				[ ] DlgEnterRent.Close()
			[+] else
				[ ] ReportStatus("Verify Enter Rent window", FAIL, "Enter Rent window is not opened")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Separate section is not created")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Closed account in Enter Expense window ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_SeparateAccountInEnterExpense()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify separate account is displayed in Enter Expense window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate banking account is available in Enter Expense window
		[ ] //						Fail		If any error occurs or account is not available in Enter Expense window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 03, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test17_SeparateAccountInEnterExpense() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sProperty
		[ ] sAccount="Checking 02"
		[ ] sProperty="Property1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
		[+] if (iSeparate == PASS)
			[ ] AccountDetails.Cancel.Click()
			[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and account {sAccount} is displayed under this section")
			[ ] 
			[ ] // Select Rental Property
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
			[ ] 
			[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,2))
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] // Search account name in Enter Expense dialog 
			[ ] WaitForState(DlgEnterExpense,true,2)
			[+] if  (DlgEnterExpense.Exists(SHORT_SLEEP))
				[ ] DlgEnterExpense.SetActive()
				[ ] DlgEnterExpense.PropertyPopupList.Select(sProperty)
				[+] if(DlgEnterExpense.AccountPopupList.FindItem(sAccount) > 0)
						[ ] ReportStatus("Verify account {sAccount} in Enter Expense window",PASS, "Account {sAccount} is available in Enter Expense window as it is separated")
				[+] else
					[ ] ReportStatus("Verify account {sAccount} in Enter Expense window",FAIL, "Account {sAccount} is not available in Enter Expense window even if it is separated")
					[ ] 
				[ ] DlgEnterExpense.Close()
			[+] else
				[ ] ReportStatus("Verify Enter Expense window", FAIL, "Enter Expense window is not opened")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Separate section is not created")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Separate account in Enter Other Income window ###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test18_SeparateAccountInEnterOtherIncome()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify separate account is displayed in Enter Other Income window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If separate banking account is available in Enter Other Income window
		[ ] //						Fail		If any error occurs or account is not available in Enter Other Income window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 04, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test18_SeparateAccountInEnterOtherIncome() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sProperty
		[ ] sAccount="Checking 02"
		[ ] sProperty="Property1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify "Separate" section is created if  "Keep This Account Separate" checkbox is checked
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_SEPARATE, sAccount)
		[+] if (iSeparate == PASS)
			[ ] AccountDetails.Cancel.Click()
			[ ] ReportStatus("Verify Separate section in Account Bar", PASS, "Separate section is created and account {sAccount} is displayed under this section")
			[ ] 
			[ ] // Select Rental Property
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
			[ ] 
			[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,3))
			[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] // Search account name in Enter Other Income dialog 
			[ ] WaitForState(DlgEnterOtherIncome,true,2)
			[+] if  (DlgEnterOtherIncome.Exists(SHORT_SLEEP))
				[ ] DlgEnterOtherIncome.SetActive()
				[ ] DlgEnterOtherIncome.PropertyPopupList.Select(sProperty)
				[+] if(DlgEnterOtherIncome.AccountPopupList.FindItem(sAccount) > 0)
						[ ] ReportStatus("Verify account {sAccount} in Enter Other Income window",PASS, "Account {sAccount} is available in Enter Other Income window as it is separated")
				[+] else
					[ ] ReportStatus("Verify account {sAccount} in Enter Other Income window",FAIL, "Account {sAccount} is available in Enter Other Income window even if it is separated")
					[ ] 
				[ ] DlgEnterOtherIncome.Close()
			[+] else
				[ ] ReportStatus("Verify Enter Other Income window", FAIL, "Enter Other Income window is not opened")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Separate section in Account Bar", FAIL, "Separate section is not created")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide in Transaction entry lists in Enter Rent window ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test19_HideInTxnListAccountInEnterRent()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify account with "Hide in Transaction entry lists" is not displayed in Enter Rent window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If banking account is not available in Enter Rent window
		[ ] //						Fail		If any error occurs or account is available in Enter Rent window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 04, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test19_HideInTxnListAccountInEnterRent() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sProperty
		[ ] 
		[ ] sAccount="Saving 01"
		[ ] sProperty="Property1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify "Hide in Transaction List" checkbox is checked fot the account
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_BANKING, sAccount,sTab)
		[+] if (iSeparate == PASS)
			[ ] HideAccount:
			[+] if(AccountDetails.HideInTransactionEntryList.IsChecked())
				[ ] ReportStatus("Verify account {sAccount} is hidden from Transaction List", PASS, "Account {sAccount} is hidden from Transaction List")
				[ ] AccountDetails.Cancel.Click()
				[ ] 
				[ ] // Select Rental Property
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_DN)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Search account name in Enter Rent dialog 
				[ ] WaitForState(DlgEnterRent,true,2)
				[+] if  (DlgEnterRent.Exists(SHORT_SLEEP))
					[ ] DlgEnterRent.SetActive()
					[ ] DlgEnterRent.PropertyPopupList.Select(sProperty)
					[+] if(DlgEnterRent.AccountPopupList.FindItem(sAccount)== 0)
							[ ] ReportStatus("Verify account {sAccount} in Enter Rent window",PASS, "Account {sAccount} is not available in Enter Rent window as it is hidden in transaction entry list")
					[+] else
							[ ] ReportStatus("Verify account {sAccount} in Enter Rent window",FAIL, "Account {sAccount} is available in Enter Rent window even if it is hidden in transaction entry list")
						[ ] 
					[ ] DlgEnterRent.Close()
				[+] else
					[ ] ReportStatus("Verify Enter Rent window", FAIL, "Enter Rent window is not opened")
				[ ] 
			[+] else
				[ ] AccountDetails.HideInTransactionEntryList.Check()
				[ ] ReportStatus("Verify account {sAccount} is hidden from Transaction List", PASS, "Account {sAccount} is hidden from Transaction List")
				[ ] goto HideAccount
		[ ] 
		[+] else
			[ ] ReportStatus("Verify navigation to Account Details Tab", FAIL, "Display Options tab is not opened")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide in Transaction entry lists in Enter Expense window ############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test20_HideInTxnListAccountInEnterExpense()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify account with "Hide in Transaction entry lists" is not displayed in Enter Expense window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If banking account is not available in Enter Expense window
		[ ] //						Fail		If any error occurs or account is available in Enter Expense window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 04, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test20_HideInTxnListAccountInEnterExpense() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sProperty
		[ ] 
		[ ] sAccount="Saving 01"
		[ ] sProperty="Property1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify "Hide in Transaction List" checkbox is checked fot the account
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_BANKING, sAccount,sTab)
		[+] if (iSeparate == PASS)
			[ ] HideAccount:
			[+] if(AccountDetails.HideInTransactionEntryList.IsChecked())
				[ ] ReportStatus("Verify account {sAccount} is hidden from Transaction List", PASS, "Account {sAccount} is hidden from Transaction List")
				[ ] AccountDetails.Cancel.Click()
				[ ] 
				[ ] // Select Rental Property
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,2))
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Search account name in Enter Expense dialog 
				[ ] WaitForState(DlgEnterExpense,true,2)
				[+] if  (DlgEnterExpense.Exists(SHORT_SLEEP))
					[ ] DlgEnterExpense.SetActive()
					[ ] DlgEnterExpense.PropertyPopupList.Select(sProperty)
					[+] if(DlgEnterExpense.AccountPopupList.FindItem(sAccount) == 0)
							[ ] ReportStatus("Verify account {sAccount} in Enter Expense window",PASS, "Account {sAccount} is not available in Enter Expense window as it is hidden from transaction entry list")
					[+] else
						[ ] ReportStatus("Verify account {sAccount} in Enter Expense window",FAIL, "Account {sAccount} is available in Enter Expense window even if it is  hidden from transaction entry list")
						[ ] 
					[ ] DlgEnterExpense.Close()
				[+] else
					[ ] ReportStatus("Verify Enter Expense window", FAIL, "Enter Expense window is not opened")
				[ ] 
			[+] else
				[ ] AccountDetails.HideInTransactionEntryList.Check()
				[ ] ReportStatus("Verify account {sAccount} is hidden from Transaction List", PASS, "Account {sAccount} is hidden from Transaction List")
				[ ] goto HideAccount
		[ ] 
		[+] else
			[ ] ReportStatus("Verify navigation to Account Details Tab", FAIL, "Display Options tab is not opened")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide in Transaction entry lists in Enter Other Income window #######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_HideInTxnListAccountInEnterOtherIncome()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify account with "Hide in Transaction entry lists" is not displayed in Enter Other Income window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If banking account is not available in Enter Other Income window
		[ ] //						Fail		If any error occurs or account is available in Enter Other Income window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 07, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test21_HideInTxnListAccountInEnterOtherIncome() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sProperty
		[ ] 
		[ ] sAccount="Saving 01"
		[ ] sProperty="Property1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify "Hide in Transaction List" checkbox is checked fot the account
		[ ] iSeparate=NavigateToAccountDetailsTab(ACCOUNT_BANKING, sAccount,sTab)
		[+] if (iSeparate == PASS)
			[ ] HideAccount:
			[+] if(AccountDetails.HideInTransactionEntryList.IsChecked())
				[ ] ReportStatus("Verify account {sAccount} is hidden from Transaction List", PASS, "Account {sAccount} is hidden from Transaction List")
				[ ] AccountDetails.Cancel.Click()
				[ ] 
				[ ] // Select Rental Property
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,3))
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Search account name in Enter Other Income dialog 
				[ ] WaitForState(DlgEnterOtherIncome,true,2)
				[+] if  (DlgEnterOtherIncome.Exists(SHORT_SLEEP))
					[ ] DlgEnterOtherIncome.SetActive()
					[ ] DlgEnterOtherIncome.PropertyPopupList.Select(sProperty)
					[+] if(DlgEnterOtherIncome.AccountPopupList.FindItem(sAccount) == 0)
							[ ] ReportStatus("Verify account {sAccount} in Enter Other Income window",PASS, "Account {sAccount} is not available in Enter Other Income window as it is hidden from transaction entry list")
					[+] else
						[ ] ReportStatus("Verify account {sAccount} in Enter Other Income window",FAIL, "Account {sAccount} is available in Enter Other Income window even if it is hidden from transaction entry list")
						[ ] 
					[ ] DlgEnterOtherIncome.Close()
				[+] else
					[ ] ReportStatus("Verify Enter Other Income window", FAIL, "Enter Other Income window is not opened")
				[ ] 
			[+] else
				[ ] AccountDetails.HideInTransactionEntryList.Check()
				[ ] ReportStatus("Verify account {sAccount} is hidden from Transaction List", PASS, "Account {sAccount} is hidden from Transaction List")
				[ ] goto HideAccount
			[ ] 
		[+] else
			[ ] ReportStatus("Verify navigation to Account Details Tab", FAIL, "Display Options tab is not opened")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide in Account bar and Account list in Enter Rent window ########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test22_HiddenFromAccBarAccountInEnterRent()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify account with "Hide account name from account bar and account list" is displayed in Enter Rent window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If banking account is available in Enter Rent window
		[ ] //						Fail		If any error occurs or account is not available in Enter Rent window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 07, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test22_HiddenFromAccBarAccountInEnterRent() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sProperty
		[ ] INTEGER iValidate
		[ ] 
		[ ] sAccount="Saving 02"
		[ ] sProperty="Property1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify "Hide account name from account bar and account list" checkbox is checked fot the account
		[ ] iValidate=AccountBarSelect(ACCOUNT_BANKING, 4)
		[ ] // iValidate = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(Replicate(KEY_DN,1))
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_ENTER)	
		[+] if(iValidate == PASS)
			[ ] NavigateToAccountDetails(sAccount)
			[ ] SelectAccountDetailsTabs(ACCOUNT_BANKING,sTab)
			[+] if(AccountDetails.HideAccountNameInAccountB.IsChecked())
				[ ] ReportStatus("Verify account {sAccount} is hidden from Account Bar", PASS, "Account {sAccount} is hidden from Account Bar")
				[ ] AccountDetails.Close()
				[ ] 
				[ ] // Select Rental Property
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_DN)
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Search account name in Enter Rent dialog 
				[ ] WaitForState(DlgEnterRent,true,2)
				[+] if  (DlgEnterRent.Exists(SHORT_SLEEP))
					[ ] DlgEnterRent.SetActive()
					[ ] DlgEnterRent.PropertyPopupList.Select(sProperty)
					[+] if(DlgEnterRent.AccountPopupList.FindItem(sAccount)> 0)
							[ ] ReportStatus("Verify account {sAccount} in Enter Rent window",PASS, "Account {sAccount} is available in Enter Rent window as it is hidden from Account Bar and Account List")
					[+] else
							[ ] ReportStatus("Verify account {sAccount} in Enter Rent window",FAIL, "Account {sAccount} is not available in Enter Rent window even if it is hidden from Account Bar and Account list")
						[ ] 
					[ ] DlgEnterRent.Close()
				[+] else
					[ ] ReportStatus("Verify Enter Rent window", FAIL, "Enter Rent window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify account {sAccount} is hidden from Account Bar", FAIL, "Account {sAccount} is hidden from Account Bar")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Account {sAccount}", FAIL, "Navigation failed to {sAccount}")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide in Account bar and Account list in Enter Expense window #####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_HiddenFromAccBarAccountInEnterExpense()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify account with "Hide account name from account bar and account list" is displayed in Enter Expense window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If banking account is available in Enter Expense window
		[ ] //						Fail		If any error occurs or account is not available in Enter Expense window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 07, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test23_HiddenFromAccBarAccountInEnterExpense() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sProperty
		[ ] INTEGER iValidate
		[ ] 
		[ ] sAccount="Saving 02"
		[ ] sProperty="Property1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify "Hide account name from account bar and account list" checkbox is checked fot the account
		[ ] iValidate=AccountBarSelect(ACCOUNT_BANKING, 4)
		[ ] //iValidate = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(Replicate(KEY_DN,1))
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_ENTER)	
		[+] if(iValidate == PASS)
			[ ] NavigateToAccountDetails(sAccount)
			[ ] SelectAccountDetailsTabs(ACCOUNT_BANKING,sTab)
			[+] if(AccountDetails.HideAccountNameInAccountB.IsChecked())
				[ ] ReportStatus("Verify account {sAccount} is hidden from Account Bar", PASS, "Account {sAccount} is hidden from Account Bar")
				[ ] AccountDetails.Close()
				[ ] 
				[ ] // Select Rental Property
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,2))
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Search account name in Enter Expense dialog 
				[ ] WaitForState(DlgEnterExpense,true,2)
				[+] if  (DlgEnterExpense.Exists(SHORT_SLEEP))
					[ ] DlgEnterExpense.SetActive()
					[ ] DlgEnterExpense.PropertyPopupList.Select(sProperty)
					[+] if(DlgEnterExpense.AccountPopupList.FindItem(sAccount)>0)
							[ ] ReportStatus("Verify account {sAccount} in Enter Expense window",PASS, "Account {sAccount} is available in Enter Expense window as it is hidden from Account Bar and Account list")
					[+] else
						[ ] ReportStatus("Verify account {sAccount} in Enter Expense window",FAIL, "Account {sAccount} is not available in Enter Expense window even if it is  hidden from Account Bar and Account list")
						[ ] 
					[ ] DlgEnterExpense.Close()
				[+] else
					[ ] ReportStatus("Verify Enter Expense window", FAIL, "Enter Expense window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify account {sAccount} is hidden from Account Bar", FAIL, "Account {sAccount} is hidden from Account Bar")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Account {sAccount}", FAIL, "Navigation failed to {sAccount}")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Hide in Account bar and Account list in Enter Other Income window ###
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test24_HiddenFromAccBarAccountInEnterOtherIncome()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify account with "Hide account name from account bar and account list" is displayed in Enter Other Income window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If banking account is available in Enter Other Income window
		[ ] //						Fail		If any error occurs or account is anot vailable in Enter Other Income window
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Jan 07, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test24_HiddenFromAccBarAccountInEnterOtherIncome() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sProperty
		[ ] INTEGER iValidate
		[ ] 
		[ ] sAccount="Saving 02"
		[ ] sProperty="Property1"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify "Hide account name from account bar and account list" checkbox is checked fot the account
		[ ] iValidate=AccountBarSelect(ACCOUNT_BANKING, 4)
		[ ] // iValidate = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(Replicate(KEY_DN,1))
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.TypeKeys(KEY_ENTER)	
		[+] if(iValidate == PASS)
			[ ] NavigateToAccountDetails(sAccount)
			[ ] SelectAccountDetailsTabs(ACCOUNT_BANKING,sTab)
			[+] if(AccountDetails.HideAccountNameInAccountB.IsChecked())
				[ ] ReportStatus("Verify account {sAccount} is hidden from Account Bar", PASS, "Account {sAccount} is hidden from Account Bar")
				[ ] AccountDetails.Close()
				[ ] 
				[ ] // Select Rental Property
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.AddTransactions.Click()
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN,3))
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Search account name in Enter Other Income dialog 
				[ ] WaitForState(DlgEnterOtherIncome,true,2)
				[+] if  (DlgEnterOtherIncome.Exists(SHORT_SLEEP))
					[ ] DlgEnterOtherIncome.SetActive()
					[ ] DlgEnterOtherIncome.PropertyPopupList.Select(sProperty)
					[+] if(DlgEnterOtherIncome.AccountPopupList.FindItem(sAccount) > 0)
							[ ] ReportStatus("Verify account {sAccount} in Enter Other Income window",PASS, "Account {sAccount} is available in Enter Other Income window as it is hidden from Account Bar and Account list")
					[+] else
						[ ] ReportStatus("Verify account {sAccount} in Enter Other Income window",FAIL, "Account {sAccount} is available in Enter Other Income window even if it is hidden from Account Bar and Account list")
						[ ] 
					[ ] DlgEnterOtherIncome.Close()
				[+] else
					[ ] ReportStatus("Verify Enter Other Income window", FAIL, "Enter Other Income window is not opened")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify account {sAccount} is hidden from Account Bar", FAIL, "Account {sAccount} is hidden from Account Bar")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Account {sAccount}", FAIL, "Navigation failed to {sAccount}")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] //******************************************************************************************************************************************
[ ] 