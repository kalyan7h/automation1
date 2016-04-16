[ ] // *********************************************************
[+] // FILE NAME:	<SpendingTab.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   <This script contains all SpendingTab test cases>
	[ ] //
	[ ] // DEPENDENCIES:	<include.inc>
	[ ] //
	[ ] // DEVELOPED BY:	Mukesh
	[ ] //			
	[ ] // REVISION HISTORY: Adding test case on 30 May 2013 - Udita
	[ ] //	
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[+] // Variable Declaration
	[+] 
		[ ] LIST OF ANYTYPE lsAddPaycheck,lsCategory,lsAmount,lsAddAccount, lsExcelData,lsExcelData1, lsTransaction, lsReportNames,lsListBoxItems,lsTemp,lsExcelData2
		[ ] INTEGER iAmount ,iSwitchState,iSelect,iResult,iNum,iListCount 
		[ ] LIST OF ANYTYPE  lsIncomeCategory,lsExpenseCategory,lsActualListContents ,lsDate
		[ ] NUMBER nAmount,nAmount1,nAmount2,nAmountTotal,nActualAmount,nAmountDifferenceActual ,nAmountDifferenceExpected
		[ ]  
		[ ] public INTEGER iSetupAutoAPI ,iCounter, iItemCount, iCount,iVerify
		[ ] BOOLEAN bMatch, bResult
		[ ] STRING sSpendingTabFileName="SpendingTab"
		[ ] public STRING sSpendingTabExcelFile="SpendingTab"
		[ ] public STRING sTransactionTypeSpending="Spending"
		[ ] public STRING sTransactionTypeIncome="Income"
		[ ] 
		[ ] public STRING sSpendingDataFile = AUT_DATAFILE_PATH + "\" + sSpendingTabFileName + ".QDF"
		[ ] public STRING sSpendingAccountWorksheet = "SpendingAccount"
		[ ] public STRING sSpendingTransactionSheet = "SpendingCheckingTransaction"
		[ ] public STRING sExpenseCategoryDataSheet = "ExpenseCategoryData"
		[ ] public STRING sIncomeCategoryDataSheet = "IncomeCategoryData"
		[ ] public STRING sRegBusinessTransaction = "RegBusinessTransaction"
		[ ] public STRING sRegCustomerVendorTransactions= "CustomerVendorTransactions"
		[ ] public STRING sRegCustomerVendorPayment= "CustomerVendorPayment"
		[ ] public STRING sRegCustomerCreditTransactions= "CustomerCreditTransactions"
		[ ] public STRING sRegCustomerVendorRefund= "CustomerVendorRefund"
		[ ] public STRING sRegCustomerFinanceCharge= "CustomerFinanceCharge"
		[ ] public STRING sRegVendorCreditTransactions= "VendorCreditTransactions"
		[ ] public STRING sRegVendorRefundTransaction= "VendorRefundTransaction"
		[ ] public STRING sBrokerageAccountWorksheet= "Brokerage Account"
		[ ] public STRING sBrokerageTransactionWorksheet= "Investing Transaction"
		[ ] public STRING sPaycheckWorksheet=  "Paycheck"
		[ ] public STRING sLoanAccountWorksheet= "Loan"
		[ ] public STRING sLoanCategoriesWorksheet= "LoanCategories"
		[ ] public STRING sDateFormat= "m/d/yyyy"
		[ ] 
		[ ] //public STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
		[ ] public INTEGER  iAddAccount
		[ ] public STRING sActualErrorMsg ,sExpectedErrorMsg,sExpected, sActual, sDateRange,sAmountPaid,sCategory,sListitem,sTransactionCount
		[ ]  public STRING sDateStamp = FormatDateTime (GetDateTime(), sDateFormat) 
		[ ] 
		[ ] 
		[ ] STRING sValidationText,sDate,sActualAmount, sAccountAction,sAmount,sItem,sMenuItem,sAccountName,sDueDate,sActualDate,sExpectedDate
		[ ] STRING  sActualTransactionCount,sExcelSheet,sActualText
		[ ] 
		[ ] //Integer
		[ ] public INTEGER iCreateDataFile,iAddTransaction,iFileResult,i,nNum
		[ ] INTEGER iLoop
		[ ] INTEGER iAccountSpecificCounterValue
		[ ] 
		[ ] //String
		[ ] public STRING sFileName = "SpendingTabDataFile"
		[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] 
		[ ] public STRING sHandle,sExpectedEndingBalance 
		[ ] 
		[ ] public STRING sTransactionFilterWorksheet="TransactionFilter"
		[ ] public STRING sDateFilterWorksheet="DateFilter"
		[ ] public STRING sTypeFilterWorksheet="TypeFilter"
		[ ] public STRING sTransactionWorksheet="OtherTransaction"
		[ ] public STRING sCheckingTransactionWorksheet="CheckingTransaction"
		[ ] public STRING sAccountWorksheet="Account"
		[ ] public STRING sSearchFilterWorksheet="SearchFilter"
		[ ] public STRING sDateFilter1Worksheet="PaymentTransactionDataFilters"
		[ ] public STRING sDateFilter2Worksheet="IncomeTransactionDataFilters"
		[ ] 
		[ ] STRING sTextOption="Income"
		[ ] 
		[ ] 
		[ ] //List of String
		[ ] public LIST OF STRING lsTransactionData
		[ ] 
		[ ] public STRING sPopUpWindow = "PopUp"
		[ ] public STRING sMDIWindow = "MDI"
		[ ] 
		[ ] 
		[ ] //Boolean
		[ ] public BOOLEAN bBalanceCheck
	[ ] 
[+] //############# SpendingTab SetUp #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test1_SpendingTabSetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the SpendingTabSetUp.QDF if it exists. It will setup the necessary pre-requisite for SpendingTab tests
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 27, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test_SpendingTabSetUp() appstate QuickenBaseState
	[+] //Variables
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile, sSpendingAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
	[ ] 
	[ ] // 
	[+] if(FileExists(sTestCaseStatusFile))
		[ ] DeleteFile(sTestCaseStatusFile)
	[ ] 
	[ ] //########Launch Quicken and open SpendingTab File######################//
	[ ] iCreateDataFile=DataFileCreate(sSpendingTabFileName)
	[ ] // iCreateDataFile=PASS
	[+] if (iCreateDataFile==PASS)
		[ ] 
		[+] if (QuickenWindow.Exists())
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // Add all spending accounts //
			[ ] 
			[ ] //############## Create New Checking Account #####################################
			[+] for (iCounter =1 ; iCounter < 6 ; ++iCounter)
				[ ] lsAddAccount=lsExcelData[iCounter]
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
				[ ] // Report Status if checking Account is created
				[+] if (iAddAccount==PASS)
					[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
				[+] else
					[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[+] else
			[ ] ReportStatus("Verify Quicken Window exists.", FAIL, "Quicken is not available") 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sDataFile} creation was unsuccessful.")
		[ ] 
[ ] //###############################################################################
[ ] 
[+] //############# 1. Verify Spending Tab is present ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test1_SpendingTabSetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Spending Tab is present in Menu bar
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If verification of Spending Tab's pressence in Menu bar is successful					
		[ ] //						Fail		If verification of Spending Tab's pressence in Menu bar is unsuccessful					
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 27, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test1_VerifySpendingTab() appstate none
	[ ] 
	[ ] //Variables
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_SPENDING)
		[+] if (iResult==PASS)
			[ ] ReportStatus("Verify {sTAB_SPENDING}", PASS, "Verify {sTAB_SPENDING}: Quicken navigated to {sTAB_SPENDING}.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {sTAB_SPENDING}", FAIL, "Verify {sTAB_SPENDING}: Quicken couldn't navigate to {sTAB_SPENDING}.")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Window exists.", FAIL, "Quicken is not available") 
		[ ] 
[ ] //###############################################################################
[ ] 
[+] //############# 2.Verify Register and Graph always matches#############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test2_VerifyRegisterandGraphalwaysmatchesinSpendingTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that Register and Graph always matches in spending tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If verification of Spending Tab's Register and Graph is successful					
		[ ] //						Fail		If verification of Spending Tab's Register and Graph is unsuccessful					
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 27, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test2_VerifyRegisterandGraphalwaysmatchesinSpendingTab() appstate none
	[+] //Variables
		[ ] sTransactionCount="1"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile, sSpendingAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] ////Read first row from sRegTransactionSheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile,sSpendingTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] 
	[ ] sAccountName= lsAddAccount[2]
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Select Account
		[ ] iResult=SelectAccountFromAccountBar(sAccountName , ACCOUNT_BANKING)
		[+] if(iResult==PASS)
			[ ] iResult=AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
			[+] if(iResult==PASS)
				[ ] ReportStatus("Verify transaction added.", PASS, " Verify transaction {lsTransaction} added: Transaction {lsTransaction} has been added.")
				[ ] iResult=NavigateQuickenTab(sTAB_SPENDING)
				[+] if (iResult==PASS)
					[ ] 
					[ ] ///Verify transaction in the Graph listbox//
					[ ] sHandle=Str(MDIClientSpending.SpendingWindow.ExamineYourSpending.QWGraphControlClass1.Panel.Window1.ListBox1.GetHandle())
					[ ] iListCount=MDIClientSpending.SpendingWindow.ExamineYourSpending.QWGraphControlClass1.Panel.Window1.ListBox1.GetItemCount()+1
					[+] for (iCounter =0 ; iCounter < iListCount ; ++iCounter)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
						[ ] bMatch = MatchStr("*{lsTransaction[8]}*{lsTransaction[3]}*" , sActual)
						[+] if (bMatch)
							[ ] ReportStatus("Verify transaction added.", PASS, " Verify transaction {lsTransaction} in Spending listbox: Transaction: {sActual} is as expected: {lsTransaction[6]} , {lsTransaction[3]} in Spending listbox.")
							[ ] break
						[+] else
							[ ] ReportStatus("Verify transaction added.", FAIL, " Verify transaction {lsTransaction} in Spending listbox: Transaction: {sActual} is NOT as expected: {lsTransaction[6]} , {lsTransaction[3]} in Spending listbox.")
					[ ] 
					[ ] ///Verify transaction in the spending register//
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransaction[6]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify transaction added.", PASS, " Verify transaction {lsTransaction} in Spending register: Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransaction} in Spending register.")
					[+] else
						[ ] ReportStatus("Verify transaction added.", FAIL, " Verify transaction {lsTransaction} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register.")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify {sTAB_SPENDING}", FAIL, "Verify {sTAB_SPENDING}: Quicken couldn't navigate to {sTAB_SPENDING}.")
			[+] else
				[ ] ReportStatus("Verify transaction added.", FAIL, " Verify transaction {lsTransaction} added: Transaction {lsTransaction} couldn't be added.")
		[+] else
			[ ] ReportStatus("Verify account selected", FAIL, "Verify {sAccountName} account selected: {sAccountName} Account couldn't be selected.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Window exists.", FAIL, "Quicken is not available") 
		[ ] 
		[ ] 
[ ] //###############################################################################
[ ] 
[+] //############# Verify filters on Spending Tab #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test3_VerifyFiltersOnSpendingTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Spending Tab have filters for accounts to show, various date range to select and options to select income and spending transactions at a time.  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If verification of Spending Tab's filters is successful					
		[ ] //						Fail		If verification of Spending Tab's filters is unsuccessful					
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 31, 2013		
		[ ] //Author                          Udita 	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test3_VerifyFiltersOnSpendingTab() appstate none
	[ ] //Variables
	[ ] 
	[+] if (QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] // Navigate to Spending Tab
		[ ] iResult=NavigateQuickenTab(sTAB_SPENDING)
		[+] if (iResult==PASS)
			[ ] ReportStatus("Verify {sTAB_SPENDING}", PASS, "Quicken navigated to {sTAB_SPENDING}.")
			[ ] 
			[ ] // Verify Account filter
			[+] if(MDIClientSpending.SpendingWindow.AccountsPopUpList.Exists())
				[ ] ReportStatus("Verify Account Filter on Spending Tab",PASS,"Account Filter is present in Spending Tab")
			[+] else
				[ ] ReportStatus("Verify Account Filter on Spending Tab",FAIL,"Account Filter is not present in Spending Tab")
			[ ] 
			[ ] // Verify Date filter
			[+] if(MDIClientSpending.SpendingWindow.DatePopUpList.Exists())
				[ ] ReportStatus("Verify Date Filter on Spending Tab",PASS,"Date Filter is present in Spending Tab")
			[+] else
				[ ] ReportStatus("Verify Date Filter on Spending Tab",FAIL,"Date Filter is not present in Spending Tab")
			[ ] 
			[ ] // Verify Transaction Type filter
			[+] if(MDIClientSpending.SpendingWindow.TransactionTypePopUpList.Exists())
				[ ] ReportStatus("Verify Transaction Type Filter on Spending Tab",PASS,"Transaction Type Filter is present in Spending Tab")
			[+] else
				[ ] ReportStatus("Verify Transaction Type Filter on Spending Tab",FAIL,"Transaction Type Filter is not present in Spending Tab")
			[ ] 
			[ ] // Verify Reset Button
			[+] if(MDIClientSpending.SpendingWindow.ResetButton.Exists())
				[ ] ReportStatus("Verify Reset Button on Spending Tab",PASS,"Reset Button is present in Spending Tab")
			[+] else
				[ ] ReportStatus("Verify Reset Button on Spending Tab",FAIL,"Reset Button is not present in Spending Tab")
			[ ] 
			[ ] // Verify Reports Button
			[+] if(QuickenMainWindow.QWNavigator1.Reports.Exists())
				[ ] ReportStatus("Verify Reports Button on Spending Tab",PASS,"Reports Button is present in Spending Tab")
			[+] else
				[ ] ReportStatus("Verify Reports Button on Spending Tab",FAIL,"Reports Button is not present in Spending Tab")
			[ ] 
			[ ] // Verify View Guidance Button
			[+] if(QuickenMainWindow.ViewGuidanceButton.Exists())
				[ ] ReportStatus("Verify View Guidance Button on Spending Tab",PASS,"View Guidance Button is present in Spending Tab")
			[+] else
				[ ] ReportStatus("Verify View Guidance Button on Spending Tab",FAIL,"View Guidance Button is not present in Spending Tab")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {sTAB_SPENDING}", FAIL, "Quicken couldn't navigate to {sTAB_SPENDING}.")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Window exists.", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[+] //########Verify Cash ,Savings and Credit Card Account scope displayed on Spending tab##########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test5_VerifySavingsCashCreditCardAccountsonSpendingtab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify Spending and Income transitions for Cash ,Savings and Credit Card accounts are displayed with respective filter selection
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If verification of Spending and Income transactions for Cash ,Savings and Credit Card accounts in spending tab is successful					
		[ ] //						Fail		If verification of Spending and Income transactions for Cash ,Savings and Credit Card accounts in spending tab is unsuccessful					
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 28, 2013		
		[ ] //Author                          Mukesh 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test5_VerifySavingsCashCreditCardAccountsonSpendingtab() appstate none
	[ ] 
	[+] //Variables
		[ ] STRING sAllDates  ,sAllAccounts
		[ ] INTEGER iAccountIndex ,iAllAccountsIndex ,iAllDatesIndex
		[ ] sAllDates ="All Dates"
		[ ] sTransactionCount="1"
		[ ] sAllAccounts="All Accounts"
		[ ] iAccountIndex=8
		[ ] ////Read first row from sRegTransactionSheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile,sSpendingTransactionSheet)
		[ ] //Append deposit transaction//  
		[ ] ListAppend (lsTemp , lsExcelData[1])
		[ ] //Append payment transaction//
		[ ] ListAppend (lsTemp , lsExcelData[2])
		[ ] // Read data from sSpendingAccountWorksheet sheet
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile, sSpendingAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_SPENDING)
		[+] if (iResult==PASS)
			[ ] 
			[ ] //Select Account
			[+] for (iCount =3 ; iCount < 6 ; ++iCount )
				[ ] lsAddAccount=lsExcelData[iCount]
				[ ] sAccountName=lsAddAccount[2]
				[ ] iAccountIndex=iAccountIndex+1
				[+] for (iCounter =1 ; iCounter < ListCount(lsTemp) +1 ; ++iCounter)
					[ ] iResult=SelectAccountFromAccountBar(sAccountName , ACCOUNT_BANKING)
					[ ] 
					[+] if(iResult==PASS)
						[ ] lsTransaction= lsTemp[iCounter]
						[ ] iResult=AddBankingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],sDateStamp,lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
						[+] if(iResult==PASS)
							[ ] ReportStatus("Verify transaction added.", PASS, "Transaction {lsTransaction} has been added.")
							[ ] 
							[ ] QuickenWindow.SetActive()
							[ ] NavigateQuickenTab(sTAB_SPENDING)
							[ ] // ///Select All Accounts
							[ ] 
							[ ] sleep(1)
							[ ] MDIClientSpending.SpendingWindow.AccountsPopUpList.Select(iAccountIndex)
							[ ] MDIClientSpending.SpendingWindow.AccountsPopUpList.TypeKeys(sAccountName)
							[ ] MDIClientSpending.SpendingWindow.AccountsPopUpList.TypeKeys(KEY_ENTER)
							[ ] 
							[ ] sleep(1)
							[ ] 
							[ ] // 
							[ ] sleep(1)
							[+] if (lsTransaction[5]=="DEP")
								[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys("Inco")
								[ ] sleep(1)
								[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys(KEY_ENTER)
							[+] else
								[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys("Spending")
								[ ] sleep(1)
								[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys(KEY_ENTER)
							[ ] sleep(1)
							[ ] 
							[ ] 
							[ ] ///Verify transaction in the spending register//
							[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransaction[6]) 
							[+] if (sActualTransactionCount==sTransactionCount)
								[ ] ReportStatus("Verify transaction  {lsTransaction[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransaction[6]} in Spending register.")
							[+] else
								[ ] ReportStatus("Verify transaction  {lsTransaction[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransaction[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register. Defect: QW-3165")
								[ ] 
								[ ] 
						[+] else
							[ ] ReportStatus("Verify transaction added.", FAIL, " Verify transaction {lsTransaction} added: Transaction {lsTransaction} couldn't be added.")
					[+] else
						[ ] ReportStatus("Verify account selected", FAIL, "Verify {sAccountName} account selected: {sAccountName} Account couldn't be selected.") 
		[ ] 
		[+] else
			[ ] ReportStatus("Verify {sTAB_SPENDING}", FAIL, "Verify {sTAB_SPENDING}: Quicken couldn't navigate to {sTAB_SPENDING}.")
	[+] else
		[ ] ReportStatus("Verify Quicken Window exists.", FAIL, "Quicken is not available") 
		[ ] 
		[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[ ] 
[+] //############# Verify Brokerage account on Spending Tab ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test7_VerifyBrokerageBuyTxnInSpendingTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify out of scope account (Brokerage) should not displayed on Spending tab and Buy transaction should not be available in Spending register
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Brokerage account is not available in Accounts filter and Buy transaction is not available in Spending register				
		[ ] //						Fail		If Brokerage account is available in Accounts filter and Buy transaction is available in Spending register					
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 31, 2013		
		[ ] //Author                          Udita 	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test7_VerifyBrokerageBuyTxnInSpendingTab() appstate none
	[+] //Variables
		[ ] STRING sDate
		[ ] // Read data from sBrokerageAccountWorksheet 
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile, sBrokerageAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read data from sBrokerageTransactionWorksheet 
		[ ] lsExcelData1=ReadExcelTable(sSpendingTabExcelFile, sBrokerageTransactionWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsTransactionData=lsExcelData1[1]
		[ ] sDate=Modifydate(0 ,sDateFormat)
		[ ] ListDelete(lsTransactionData ,3)
		[ ] ListInsert(lsTransactionData ,3 ,sDate)
		[ ] ListDelete(lsTransactionData ,5)
		[ ] ListInsert(lsTransactionData ,5 ,sDate)
		[ ] 
		[ ] 
		[ ] sTransactionCount="0"
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] // Add Investment Accounts
		[ ] iAddAccount = AddManualBrokerageAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],lsAddAccount[5],lsAddAccount[6])
		[ ] //  Verify that Account is shown on account bar
		[+] if(iAddAccount==PASS)
			[ ] ReportStatus("Add Brokerage Account", iAddAccount, "Brokerage Account -  {lsAddAccount[2]} is created successfully")
			[ ] 
			[ ] // Navigate to Spending Tab
			[ ] iResult=NavigateQuickenTab(sTAB_SPENDING)
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify {sTAB_SPENDING}", PASS, "Quicken navigated to {sTAB_SPENDING}.")
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] // Verify Brokerage account in Account popup list
				[+] if(!MDIClientSpending.SpendingWindow.AccountsPopUpList.FindItem(lsAddAccount[2]))
					[ ] ReportStatus("Verify Brokerage account in Account Filter on Spending Tab",PASS,"Brokerage Account is not present in Account Filter on Spending Tab")
				[+] else
					[ ] ReportStatus("Verify Brokerage account in Account Filter on Spending Tab",FAIL,"Brokerage Account is present in Account Filter on Spending Tab")
				[ ] 
				[ ] // This will click  first Investment account on AccountBar
				[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)	
				[ ] ReportStatus("Account select from account bar", iSelect, "Select Account {lsTransactionData[4]}") 
				[ ] 
				[ ] // Verify Brokerage Account window is available
				[+] if (BrokerageAccount.Exists())
					[ ] //Buy Transaction with all data
					[ ] iAddTransaction= AddBrokerageTransaction(lsTransactionData)
					[+] if(iAddTransaction==PASS)
						[ ] ReportStatus("Add Brokerage Transaction: {lsTransactionData[2]}", iAddTransaction, "{lsTransactionData[2]} Transaction is added") 
						[ ] 
						[ ] // Navigate to Spending Tab
						[ ] NavigateQuickenTab(sTAB_SPENDING)
						[ ] 
						[ ] // Select All Accounts in Account filter
						[ ] MDIClientSpending.SpendingWindow.AccountsPopUpList.Select("All Accounts")
						[ ] 
						[ ] ///Verify transaction in the spending register
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify investment transaction not diplayed in spending tab.", PASS, "Buy investment transaction:{lsTransactionData[2]} not diplayed in spending tab.")
						[+] else
							[ ] ReportStatus("Verify investment transaction not diplayed in spending tab.", FAIL, "Buy investment transaction:{lsTransactionData[2]} diplayed in spending tab.")
						[ ] 
					[+] else
						[ ] ReportStatus("Add Brokerage Transaction: {lsTransactionData[2]}", iAddTransaction, "{lsTransactionData[2]} Transaction is not added") 
						[ ] 
					[ ] 
				[+] else
					[ ] iAddTransaction=FAIL
					[ ] ReportStatus("Verification of {lsTransactionData[3]} account window", FAIL, "{lsTransactionData[3]} account window not found") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify {sTAB_SPENDING}", FAIL, "Quicken couldn't navigate to {sTAB_SPENDING}.")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Brokerage Account", iAddAccount, "Brokerage Account -  {lsAddAccount[2]} is not created successfully")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Window exists.", FAIL, "Quicken is not available") 
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[ ] 
[+] //############# Verify Brokerage transaction on Spending Tab ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test8_VerifyBrokerageSellTxnInSpendingTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify out of scope account transactions should not displayed on Spending tab and Sell transaction should not be available in Spending register
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Brokerage account is not available in Accounts filter and Sell transaction is not available in Spending register				
		[ ] //						Fail		If Brokerage account is available in Accounts filter and Sell transaction is available in Spending register					
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             June 03, 2013		
		[ ] //Author                          Udita 	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test8_VerifyBrokerageSellTxnInSpendingTab() appstate none
	[+] //Variables
		[ ] // Read data from sBrokerageAccountWorksheet 
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile, sBrokerageAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read data from sBrokerageTransactionWorksheet 
		[ ] lsExcelData1=ReadExcelTable(sSpendingTabExcelFile, sBrokerageTransactionWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsTransactionData=lsExcelData1[2]
		[ ] 
		[ ] sTransactionCount="0"
		[ ] sDate=Modifydate(0 ,sDateFormat)
		[ ] ListDelete(lsTransactionData ,3)
		[ ] ListInsert(lsTransactionData ,3 ,sDate)
		[ ] ListDelete(lsTransactionData ,5)
		[ ] ListInsert(lsTransactionData ,5 ,sDate)
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Spending Tab
		[ ] iResult=NavigateQuickenTab(sTAB_SPENDING)
		[+] if (iResult==PASS)
			[ ] ReportStatus("Verify {sTAB_SPENDING}", PASS, "Quicken navigated to {sTAB_SPENDING}.")
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // Verify Brokerage account in Account popup list
			[+] if(!MDIClientSpending.SpendingWindow.AccountsPopUpList.FindItem(lsAddAccount[2]))
				[ ] ReportStatus("Verify Brokerage account in Account Filter on Spending Tab",PASS,"Brokerage Account is not present in Account Filter on Spending Tab")
			[+] else
				[ ] ReportStatus("Verify Brokerage account in Account Filter on Spending Tab",FAIL,"Brokerage Account is present in Account Filter on Spending Tab")
			[ ] 
			[ ] // This will click  first Investment account on AccountBar
			[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)	
			[ ] ReportStatus("Account select from account bar", iSelect, "Select Account {lsTransactionData[4]}") 
			[ ] 
			[ ] // Verify Brokerage Account window is available
			[+] if (BrokerageAccount.Exists())
				[ ] //Buy Transaction with all data
				[ ] iAddTransaction= AddBrokerageTransaction(lsTransactionData)
				[+] if(iAddTransaction==PASS)
					[ ] ReportStatus("Add Brokerage Transaction: {lsTransactionData[2]}", iAddTransaction, "{lsTransactionData[2]} Transaction is added") 
					[ ] 
					[ ] // Navigate to Spending Tab
					[ ] NavigateQuickenTab(sTAB_SPENDING)
					[ ] 
					[ ] // Select All Accounts in Account filter
					[ ] MDIClientSpending.SpendingWindow.AccountsPopUpList.Select("All Accounts")
					[ ] 
					[ ] ///Verify transaction in the spending register
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify investment transaction not diplayed in spending tab.", PASS, "Sell investment transaction:{lsTransactionData[2]} not diplayed in spending tab.")
					[+] else
						[ ] ReportStatus("Verify investment transaction not diplayed in spending tab.", FAIL, "Sell investment transaction:{lsTransactionData[2]} diplayed in spending tab.")
					[ ] 
				[+] else
					[ ] ReportStatus("Add Brokerage Transaction: {lsTransactionData[2]}", iAddTransaction, "{lsTransactionData[2]} Transaction is not added") 
					[ ] 
				[ ] 
			[ ] // Report Status if Brokerage Account window is not available
			[+] else
				[ ] iAddTransaction=FAIL
				[ ] ReportStatus("Verification of {lsTransactionData[3]} account window", FAIL, "{lsTransactionData[3]} account window not found") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {sTAB_SPENDING}", FAIL, "Quicken couldn't navigate to {sTAB_SPENDING}.")
		[ ] 
	[+] else
		[ ] App_Start(sCmdLine)
		[ ] sleep(5)
		[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[+] //#############Verify Transfers Spending Txn in Spending Tab ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9_VerifyBankingTransferTxnInSpendingTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Transfers transaction (Banking) in Spending Tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If banking transfer transaction not available in spending tab 
		[ ] //						Fail		If banking transfer transaction available in Spending register					
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             June 03, 2013		
		[ ] //Author                          Udita 	
	[ ] // ********************************************************
[+] testcase Test9_VerifyBankingTransferTxnInSpendingTab() appstate none
	[+] //Variables
		[ ] // Read data from sSpendingAccountWorksheet 
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile, sSpendingAccountWorksheet)
		[ ] // Fetch 3rd row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read data from sSpendingAccountWorksheet 
		[ ] lsExcelData1=ReadExcelTable(sSpendingTabExcelFile, sSpendingTransactionSheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsTransactionData=lsExcelData1[3]
		[ ] 
		[ ] STRING sAllDates ="All Dates"
		[ ] sTransactionCount="0"
		[ ] 
		[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Select Account
		[ ] sAccountName=lsAddAccount[2]
		[ ] 
		[ ] ExpandAccountBar()
		[ ] iResult=SelectAccountFromAccountBar(sAccountName , ACCOUNT_BANKING)
		[+] if(iResult==PASS)
			[ ] iResult=AddBankingTransaction(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9],lsTransactionData[10])
			[+] if(iResult==PASS)
				[ ] ReportStatus("Verify transaction added - {lsTransactionData}.", PASS, " Transfer Transaction has been added to {sAccountName}.")
				[ ] iResult=NavigateQuickenTab(sTAB_SPENDING)
				[+] if (iResult==PASS)
					[ ] QuickenWindow.SetActive()
					[ ] //Select the cash account//
					[ ] MDIClientSpending.SpendingWindow.AccountsPopUpList.Select(sAccountName)
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(sAllDates)
					[ ] 
					[ ] ///Verify transaction in the spending register//
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[5]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify transfer transaction not displayed in spending tab.", PASS, "Transfer transaction:{lsTransactionData[5]} not displayed in spending tab ")
					[+] else
						[ ] ReportStatus("Verify transfer transaction not displayed in spending tab.", FAIL, "Transfer transaction:{lsTransactionData[5]} displayed in spending tab ")
						[ ] 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify transaction added - {lsTransactionData}.", FAIL, " Transfer Transaction has not been added to {sAccountName}.")
			[+] else
				[ ] ReportStatus("Verify account selected", FAIL, "Verify {sAccountName} account selected: {sAccountName} Account couldn't be selected.") 
		[+] else
			[ ] ReportStatus("Verify account selected", FAIL, "Verify {sAccountName} account selected: {sAccountName} Account couldn't be selected.") 
		[ ] 
	[+] else
		[ ] App_Start(sCmdLine)
		[ ] sleep(5)
		[ ] 
	[ ] 
	[ ] 
[ ] //###############################################################################
[+] //#############Verify Splits category handled in the Spending Tab ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_VerifySplitCategoryTxnInSpendingTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Splits category handled in the Spending Tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Paycheck and Loan transactions are shown under Income and Spending in the Spending Tab.
		[ ] //						Fail		If Paycheck and Loan transactions are not shown under Income and Spending in the Spending Tab.				
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             June 05, 2013		
		[ ] //Author                          Udita 	
	[ ] // ********************************************************
[+] testcase Test11_VerifySplitCategoryTxnInSpendingTab() appstate none
	[+] //Variables
		[ ] List of List of STRING lsSplitCategory
		[ ] BOOLEAN bSplit
		[ ] 
		[ ] // Read data from sPaycheckWorksheet 
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile, sPaycheckWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddPaycheck=lsExcelData[1]
		[ ] lsCategory= Split(lsAddPaycheck[10],",")
		[ ] 
		[ ] lsAmount=Split(lsAddPaycheck[11],",")
		[ ] 
		[ ] lsSplitCategory= {{lsCategory[1],lsAmount[1]},{lsCategory[2],lsAmount[2]}}
		[ ] 
		[+] if(lsAddPaycheck[9]=="TRUE")
			[ ] bSplit=TRUE
		[+] else
			[ ] bSplit=FALSE
		[ ] 
		[ ] // Read data from sLoanAccountWorksheet 
		[ ] lsExcelData1=ReadExcelTable(sSpendingTabExcelFile, sLoanAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData1[1]
		[ ] 
		[ ] 
		[ ] STRING sAllDates ="All Dates"
		[ ] sTransactionCount="1"
		[ ] 
		[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] sDateStamp=ModifyDate ( -1,sDateFormat)
		[ ] 
		[ ] iResult=AddPaycheck(lsAddPaycheck[1],lsAddPaycheck[2],lsAddPaycheck[3],sDateStamp,lsAddPaycheck[5],lsAddPaycheck[6],lsAddPaycheck[7],lsAddPaycheck[8],bSplit,lsSplitCategory)
		[+] if(iResult==PASS)
			[ ] NavigateQuickenTab(sTAB_BILL, "Upcoming") 
			[+] if(Bills.Exists())
				[ ] QuickenWindow.SetActive()
				[ ] Bills.ViewAsPopupList.Select("#1")
				[ ] 
				[ ] // Bills.AccountPopupList.Select("#1")
				[ ] 
				[ ] Bills.Enter.Click()
				[ ] sleep(1)
				[ ] 
				[ ] EnterTransaction.EnterTransactionButton.Click()
				[ ] lsAddAccount[3]= ModifyDate ( -61,sDateFormat)
				[ ] iResult=AddEditManualLoanAccount("Add",lsAddAccount[2],lsAddAccount[3],lsAddAccount[4],lsAddAccount[5],lsAddAccount[6])
				[+] if (iResult==PASS)
					[ ] ReportStatus("Add Loan Account",PASS,"Loan account added successfully")
					[ ] 
					[ ] NavigateQuickenTab(sTAB_BILL)
					[+] if(Bills.Exists())
						[ ] Bills.IncludePaid.Uncheck()
						[ ] Bills.ViewAsPopupList.Select("#1")
						[ ] 
						[ ] Bills.AccountPopupList.Select("#1")
						[ ] 
						[ ] Bills.Enter.Click()
						[ ] 
						[ ] EnterTransaction.EnterTransactionButton.Click()
						[ ] sleep(1)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Bills dialog", FAIL , "Bills page is not present after adding loan account")
					[ ] 
					[ ] iResult=NavigateQuickenTab(sTAB_SPENDING)
					[+] if (iResult==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] //Select the All account//
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(sAllDates)
						[ ] MDIClientSpending.SpendingWindow.AccountsPopUpList.Select("#1")
						[ ] 
						[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.SetSelIndex(3)
						[ ] 
						[ ] //Verify transaction in the spending register//
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsAddPaycheck[2]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify transaction  {lsAddPaycheck} present in spending tab.", PASS, " Transaction count : {sActualTransactionCount} is as expected in Spending register as entered split category transaction is available")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify transaction  {lsAddPaycheck} present in spending tab.", FAIL, " Transaction count : {sActualTransactionCount} is not as expected {sTransactionCount} in Spending register as entered split category transaction is not available. Defect QW-3165")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] sTransactionCount="1"
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsAddAccount[2]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify loan transaction  {lsAddPaycheck} present in spending tab.", PASS, " Transaction count : {sActualTransactionCount} is as expected in Spending register as entered loan transaction is available")
						[+] else
							[ ] ReportStatus("Verify loan transaction  {lsAddPaycheck} present in spending tab.", FAIL, " Transaction count : {sActualTransactionCount} is not as expected {sTransactionCount} in Spending register as entered loan transaction is not available")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify transaction added - {lsTransactionData}.", FAIL, " Transfer Transaction has not been added to {sAccountName}.")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Add Loan Account",FAIL,"Loan account is not added successfully")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Bills dialog", FAIL , "Bills page is not present")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify paycheck added.",FAIL,"Verify paycheck added: Paycheck couldn't be added.")
	[+] else
		[ ] App_Start(sCmdLine)
		[ ] sleep(5)
		[ ] 
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[+] //#############12 Split icon on Category Field in Spending Tab########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_13_14VerifySplitIconInCategoryFieldSpendingTabForPaycheck()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Splits category handled in the Spending Tab ForPaycheck
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If verification of split icon for any split transaction in the Spending Tab ForPaycheck is successful.
		[ ] //						Fail		If verification of split icon for any split transaction in the Spending Tab ForPaycheck is unsuccessful.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             June 10, 2013		
		[ ] //Author                          Udita 	
	[ ] // ********************************************************
[+] testcase Test12_13_14VerifySplitIconInCategoryFieldSpendingTabForPaycheck() appstate none
	[+] //Variables
		[ ] List of List of STRING lsSplitCategory
		[ ] BOOLEAN bSplit
		[ ] INTEGER iAmountTotal , iAmountActual
		[ ] STRING sAmountTotalActual , sAmountTotalExpected
		[ ] NUMBER nAmountTotal
		[ ] 
		[ ] // Read data from sPaycheckWorksheet 
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile, sPaycheckWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddPaycheck=lsExcelData[1]
		[ ] lsCategory= Split(lsAddPaycheck[10],",")
		[ ] lsAmount=Split(lsAddPaycheck[11],",")
		[ ] lsSplitCategory= {{lsCategory[1],lsAmount[1]},{lsCategory[2],lsAmount[2]}}
		[ ] iAmountTotal=VAL (lsAmount[1]) +VAL (lsAmount[2])
		[ ] sAmountTotalExpected= Str(iAmountTotal)
		[ ] 
		[+] if(lsAddPaycheck[9]=="TRUE")
			[ ] bSplit=TRUE
		[+] else
			[ ] bSplit=FALSE
		[ ] 
		[ ] 
		[ ] STRING sAllDates ="All Dates"
		[ ] sTransactionCount="1"
		[ ] 
		[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_SPENDING)
		[+] if (iResult==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] //Select the All account//
			[ ] // MDIClientSpending.SpendingWindow.AccountsPopUpList.Select(lsAddPaycheck[5])
			[ ] // sleep(1)
			[ ] // MDIClientSpending.SpendingWindow.DatePopUpList.Select(sAllDates)
			[ ] // sleep(1)
			[ ] // MDIClientSpending.SpendingWindow.TransactionTypePopUpList.SetSelIndex(3)
			[ ] // sleep(1)
			[ ] 
			[ ] //Verify transaction in the spending register//
			[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsAddPaycheck[2]) 
			[+] if (sActualTransactionCount==sTransactionCount)
				[ ] MDIClientSpending.SpendingWindow.SearchWindow.SetText(lsAddPaycheck[2])
				[ ] 
				[+] if (MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.Exists())
					[ ] ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction appeared.")
					[ ] ////########Verify clicking Split Button in the category field of the transaction invokes the split transaction dailog with all categories#########///////// 
					[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
					[+] if(SplitTransaction.Exists(2))
						[ ] SplitTransaction.SetActive()
						[ ] 
						[ ] sHandle=NULL
						[ ] sHandle = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
						[ ] // iListCount = SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetItemCount() +1
						[+] for (iCounter=0 ; iCounter< ListCount(lsCategory) +1; ++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  Str(iCounter))
							[ ] ListAppend(lsListBoxItems , sActual)
						[ ] 
						[+] for (iCounter=1 ; iCounter< ListCount(lsCategory) +1 ; ++iCounter)
							[+] if (lsCategory[1]==NULL)
								[ ] break
							[+] for each sItem in lsListBoxItems
								[ ] 
								[ ] bMatch =MatchStr("*{lsCategory[iCounter]}*{trim(lsAmount[iCounter])}*" , sItem)
								[+] if (bMatch)
									[ ] break 
							[+] if (bMatch)
								[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data: split transaction category {lsCategory[iCounter]} with amount {lsAmount[iCounter]} appeared as {sItem} .")
							[+] else
								[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data: split transaction category {lsCategory[iCounter]} with amount {lsAmount[iCounter]} didn't appear.")
								[ ] 
						[ ] //Verify Total Amount//
						[ ] nAmountTotal=VAL (lsAmount[1]) +VAL (lsAmount[2])
						[ ] sAmountTotalExpected= Str(nAmountTotal,4,2)
						[ ] 
						[ ] iAmountActual =VAL(SplitTransaction.SplitTotalAmountText.GetText())
						[ ] sAmountTotalActual= Str(iAmountActual)
						[+] if (trim(sAmountTotalActual)==trim(sAmountTotalExpected))
							[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify total amount on split transaction dailog: Total amount: {sAmountTotalActual} is as expected: {sAmountTotalExpected}.")
						[+] else
							[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify total amount on split transaction dailog: Total amount: {sAmountTotalActual} is NOT as expected: {sAmountTotalExpected}.")
						[+] if (!SplitTransaction.IsActive())
							[ ] SplitTransaction.SetActive()
						[ ] SplitTransaction.OK.Click()
						[ ] WaitForState(SplitTransaction,False,1)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
				[+] else
					[ ] ReportStatus("Verify Split Button in the transaction",FAIL,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify transaction  {lsAddPaycheck} present in spending tab.", FAIL, " Transaction count : {sActualTransactionCount} is not as expected {sTransactionCount} in Spending register as entered split category transaction is not available")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify transaction added - {lsTransactionData}.", FAIL, " Transfer Transaction has not been added to {sAccountName}.")
	[+] else
		[ ] App_Start(sCmdLine)
		[ ] sleep(5)
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[+] //#############12 Split icon on Category Field in Spending Tab########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_13_14VerifySplitIconInCategoryFieldSpendingTabForLoan()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Splits category handled in the Spending Tab for loan reminders
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If verification of split icon for any split transaction in the Spending Tab for loan reminders is successful.
		[ ] //						Fail		If verification of split icon for any split transaction in the Spending Tab for loan reminders is unsuccessful.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             June 11, 2013		
		[ ] //Author                          Udita 	
	[ ] // ********************************************************
[+] testcase Test12_13_14VerifySplitIconInCategoryFieldSpendingTabForLoan() appstate none
	[+] //Variables
		[ ] List of List of STRING lsSplitCategory 
		[ ] List of STRING  lsAmountVal
		[ ] BOOLEAN bSplit 
		[ ] STRING sLoanPayment ,sLoanPayee ,sAllDates ,sAmountTotalActual
		[ ] INTEGER iAmountActual 
		[ ] NUMBER nAmountExpected
		[ ] 
		[ ] // Read data from sPaycheckWorksheet 
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile, sPaycheckWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddPaycheck=lsExcelData[1]
		[ ] 
		[ ] // Read data from sLoanAccountWorksheet 
		[ ] lsExcelData1=ReadExcelTable(sSpendingTabExcelFile, sLoanCategoriesWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData1[1]
		[ ] sLoanPayee=StrTran(lsAddAccount[1],"[","")
		[ ] sLoanPayee=StrTran(lsAddAccount[1],"]","")
		[ ] sLoanPayment="833.38"
		[ ] sAllDates ="All Dates"
		[ ] sTransactionCount="1"
		[ ] 
		[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=NavigateQuickenTab(sTAB_SPENDING)
		[+] if (iResult==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] MDIClientSpending.SpendingWindow.AccountsPopUpList.Select(lsAddPaycheck[5])
			[ ] MDIClientSpending.SpendingWindow.AccountsPopUpList.TypeKeys(KEY_ENTER)
			[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys("Spending")
			[ ] sleep(1)
			[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] //Verify transaction in the spending register//
			[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(sLoanPayee) 
			[+] if (sActualTransactionCount==sTransactionCount)
				[ ] MDIClientSpending.SpendingWindow.SearchWindow.SetText(sLoanPayee)
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_UP)
				[+] if (MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.Exists())
					[ ] ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction for Loan Reminder:  Split Button in the category field of the transaction appeared.")
					[ ] ////########Verify clicking Split Button in the category field of the transaction invokes the split transaction dailog with all categories#########///////// 
					[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.Click()
					[+] if(SplitTransaction.Exists(2))
						[ ] SplitTransaction.SetActive()
						[ ] 
						[ ] sHandle=NULL
						[ ] sHandle = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
						[+] for (iCounter=0 ; iCounter< ListCount(lsExcelData1) +1; ++iCounter)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  Str(iCounter-1))
							[ ] ListAppend(lsListBoxItems , sActual)
						[ ] 
						[+] for (iCounter=1 ; iCounter< ListCount(lsExcelData1) +1 ; ++iCounter)
							[ ] lsCategory=lsExcelData1[iCounter]
							[ ] 
							[+] if (lsCategory[1]==NULL)
								[ ] break
							[ ] nAmountExpected =VAL(lsCategory[2])
							[ ] sAmount=trim(Str(nAmountExpected,4,2))
							[ ] lsAmount=Split(sAmount ,".")
							[+] for each sItem in lsListBoxItems
								[ ] bMatch =MatchStr("*{lsCategory[1]}*{lsAmount[1]}*{lsAmount[2]}*" , sItem)
								[+] if (bMatch)
									[ ] break 
							[+] if (bMatch)
								[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data for Loan Reminder: split transaction category {lsCategory[1]} with amount {sAmount} appeared as {sItem} .")
							[+] else
								[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data for Loan Reminder: split transaction category {lsCategory[1]} with amount {sAmount} didn't appear.")
								[ ] 
						[ ] //Verify Total Amount//
						[ ] 
						[ ] sAmountTotalActual =SplitTransaction.SplitTotalAmountText.GetText()
						[+] if (trim(sAmountTotalActual)==trim(sLoanPayment))
							[ ] ReportStatus("Verify split transaction dailog ",PASS,"Verify total amount on split transaction dailog for Loan Reminder: Total amount: {sAmountTotalActual} is as expected: {sLoanPayment}.")
						[+] else
							[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Verify total amount on split transaction dailog for Loan Reminder: Total amount: {sAmountTotalActual} is NOT as expected: {sLoanPayment}.")
							[ ] 
							[ ] 
						[+] if (!SplitTransaction.IsActive())
							[ ] SplitTransaction.SetActive()
						[ ] SplitTransaction.OK.Click()
						[ ] WaitForState(SplitTransaction,False,1)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Split Button in the transaction",FAIL,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify transaction  {sLoanPayee} present in spending tab.", FAIL, " Transaction count : {sActualTransactionCount} is not as expected {sTransactionCount} in Spending register as entered split category transaction is not available")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify transaction added - {lsTransactionData}.", FAIL, " Transfer Transaction has not been added to {sAccountName}.")
	[+] else
		[ ] App_Start(sCmdLine)
		[ ] sleep(5)
		[ ] 
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] // 
[+] //#############Verify options for Spending on Home Page ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_VerifySpendingOptionsOnHomeTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the options for Spending on Home Page
		[ ] //There should be first "Date range" option with "Last 30 days" sub option selected second option should be "Accounts" with "All accounts" sub options selected by default
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If all spending options are present on home page					
		[ ] //						Fail		If options are not present or any error occurs				
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             June 07, 2013		
		[ ] //Author                          Udita 	
	[ ] // ********************************************************
	[ ] 
[+] testcase Test16_VerifySpendingOptionsOnHomeTab() appstate none
	[+] //Variables
		[ ] STRING sCaption,sExpectedTotal
		[ ] 
		[ ] 
		[ ] sExpected = "LAST 30 DAYS SPENDING"
		[ ] sExpectedTotal = "$669.00"
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] // Navigate to Home Tab
		[ ] iResult=NavigateQuickenTab(sTAB_HOME)
		[+] if (iResult==PASS)
			[ ] ReportStatus("Verify {sTAB_HOME}", PASS, "Quicken navigated to {sTAB_HOME}.")
			[ ] 
			[ ] // Verify Date filter
			[ ] sActual=MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.LAST30DAYS.GetText()
			[+] if(MatchStr("*{sExpected}*", sActual))
				[ ] ReportStatus("Verify default value for Date Filter on Home Tab",PASS,"Default date filter value is LAST 30 DAYS in spending snapshot on Home page")
			[+] else
				[ ] ReportStatus("Verify default value for Date Filter on Home Tab",FAIL,"Default date filter value is not LAST 30 DAYS in spending snapshot on Home page")
			[ ] 
			[ ] // Verify Account filter
			[ ] sHandle = Str(MDIClient.Home.ListBox1.GetHandle())
			[ ] iCount = MDIClient.Home.ListBox1.GetItemCount()
			[ ] 
			[+] for(i=iCount;i>=0;i--)
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(i))
				[ ] bMatch = MatchStr("*{sExpectedTotal}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify default value for Account Filter on Home Tab",PASS,"Default account filter value is ALL ACCOUNTS in spending snapshot on Home page")
					[ ] break
				[+] else
					[+] if(i==0)
						[ ] ReportStatus("Verify default value for Account Filter on Home Tab",FAIL,"Default account filter value is not ALL ACCOUNTS in spending snapshot on Home page, Actual value is {sActual}")
					[ ] 
			[ ] 
			[ ] // Verify Examine Your Spending Buttton
			[+] if(MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.ExamineYourSpendingButton.Exists())
				[ ] ReportStatus("Verify Examine Your Spending Buttton in Spending snapshot on Home page",PASS,"Examine Your Spending Buttton is present in Spending snapshot on Home page")
				[ ] MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.ExamineYourSpendingButton.Click()
				[ ] QuickenWindow.SetActive()
				[ ] sCaption = QuickenWindow.GetCaption ()
				[ ] bMatch = MatchStr("*{sTAB_SPENDING}*", sCaption)
				[+] if (bMatch == TRUE)
					[ ] ReportStatus(" Verify that Examine Your Spending Buttton navigates to Spending tab",PASS,"Spending tab is opened after clicking on Examine Your Spending Buttton on Home page")
				[+] else
					[ ] ReportStatus(" Verify that Examine Your Spending Buttton navigates to Spending tab",FAIL,"Spending tab is not opened after clicking on Examine Your Spending Buttton on Home page, Actual navigation - {sCaption}")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Examine Your Spending Buttton in Spending snapshot on Home page",FAIL,"Examine Your Spending Buttton is not present in Spending snapshot on Home page")
			[ ] 
			[ ] // Verify Pie chart's presence
			[+] if(MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.SpendingPieChart.Exists())
				[ ] ReportStatus("Verify presence of Spending Pie Chart on Home Tab",PASS,"Spending Pie chart is present on Home Tab")
			[+] else
				[ ] ReportStatus("Verify presence of Spending Pie Chart on Home Tab",FAIL,"Spending Pie chart is not present on Home Tab")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {sTAB_SPENDING}", FAIL, "Quicken couldn't navigate to {sTAB_SPENDING}.")
		[ ] 
	[+] else
		[ ] App_Start(sCmdLine)
		[ ] sleep(5)
		[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[ ] 
[+] ////############# Verify Date Filter in Spending Tab ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_22SpendingTanDateFilter_AllDates()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify all options under "All Dates" Dropdown menu from Spending Tab
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  08/26/ 2014	Created by	Mukesh
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test21_22SpendingTanDateFilterForAllDatesForExpneseTransaction() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Datetime
		[ ] DATETIME dtDateTime,newDateTime
		[ ] STRING sNum 
		[ ] //Integer
		[ ] INTEGER iCount,i,iCounter=0, j,iVerify,iSelectDate ,iYear
		[ ] //INTEGER iDateDropdownCount=12
		[ ] 
		[ ] //String
		[ ] STRING sNewDate,sCompareDay,sCompareMonth,sCompareYear
		[ ] 
		[ ] STRING sDay,sMonth,sYear
		[ ] sFileName ="Register"
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] STRING sDateFormat="m/d/yyyy"
		[ ] STRING sCompareDayFormat="d"
		[ ] STRING sCompareMonthFormat="m"
		[ ] STRING sCompareYearFormat="yyyy"
		[ ] 
		[ ] 
		[ ] STRING sCustomDate1,sCustomDate2
		[ ] 
		[ ] STRING sAccountDate="1/1/2011"
		[ ] sTransactionCount="1"
		[ ] //List of String
		[ ] LIST OF STRING lsDate,lsDateFilterData
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile, sSpendingAccountWorksheet)
		[ ] lsAddAccount = lsExcelData[1]
		[ ] sAccountName =lsAddAccount[2]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile,sSpendingTransactionSheet)
		[ ] lsTransactionData =lsExcelData[1]
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] //creating data file to handle the identification issue
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[+] if (iCreateDataFile == PASS)
		[ ] //At times stops recognizing controls so just restarting the quicken//
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], sAccountDate)
		[ ] 
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
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
			[ ] //Verify Dates for transactions-------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For All Dates Transactions---------------------------------------------------------------------------------------------------------------
				[ ] sNewDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iResult==PASS)
					[ ] 
					[ ] 
					[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sNewDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateQuickenTab(sTAB_SPENDING)
						[ ] // ///Select All Accounts
						[ ] 
						[ ] sleep(3)
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.TypeKeys("All Dates")
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.TypeKeys(KEY_ENTER)
						[ ] sleep(1)
						[ ] 
						[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys("Spending")
						[ ] sleep(1)
						[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys(KEY_ENTER)
						[ ] sleep(1)
						[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys("Spending")
						[ ] sleep(1)
						[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys(KEY_ENTER)
						[ ] 
						[ ] 
						[ ] sleep(1)
						[ ] 
						[ ] 
						[ ] ///Verify transaction in the spending register//
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register.")
						[+] else
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransactionData} in Spending register.")
							[ ] 
							[ ] 
						[ ] //Delete Transaction From Register
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
						[+] if (iVerify==PASS)
							[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
					[ ] 
					[ ] 
			[ ] //-------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For This Month Transactions------------------------------------------------------------------------------------------------------------
				[ ] sNewDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iResult==PASS)
					[ ] 
					[ ] 
					[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sNewDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateQuickenTab(sTAB_SPENDING)
						[ ] // ///Select All Accounts
						[ ] 
						[ ] sleep(3)
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(2)
						[ ] sleep(1)
						[ ] 
						[ ] 
						[ ] ///Verify transaction in the spending register//
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register.")
						[+] else
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register.")
							[ ] 
							[ ] 
						[ ] //Delete Transaction From Register
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] sleep(2)
						[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
						[+] if (iVerify==PASS)
							[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
					[ ] 
					[ ] 
				[ ] //-------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For Last Month Transaction--------------------------------------------------------------------------------------------------------------
				[ ] sDate=GetPreviousMonth(1)
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iResult==PASS)
					[ ] 
					[ ] 
					[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateQuickenTab(sTAB_SPENDING)
						[ ] // ///Select All Accounts
						[ ] 
						[ ] sleep(3)
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(3)
						[ ] sleep(1)
						[ ] 
						[ ] ///Verify transaction in the spending register//
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register  for This Month date filter.")
						[+] else
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for This Month date filter.")
							[ ] 
							[ ] 
						[ ] //Delete Transaction From Register
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] sleep(2)
						[ ] 
						[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
						[+] if (iVerify==PASS)
							[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
					[ ] 
					[ ] 
				[ ] //------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For Last 30 days-----------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(-25,sDateFormat)
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iResult==PASS)
					[ ] 
					[ ] 
					[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateQuickenTab(sTAB_SPENDING)
						[ ] // ///Select All Accounts
						[ ] 
						[ ] sleep(3)
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(4)
						[ ] sleep(1)
						[ ] 
						[ ] 
						[ ] ///Verify transaction in the spending register//
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for Last 30 days date filter.")
						[+] else
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for Last 30 days date filter.")
							[ ] 
							[ ] 
						[ ] //Delete Transaction From Register
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] sleep(2)
						[ ] 
						[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
						[+] if (iVerify==PASS)
							[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
					[ ] 
					[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] //For Last 60 days-----------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(-59,sDateFormat)
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iResult==PASS)
					[ ] 
					[ ] 
					[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateQuickenTab(sTAB_SPENDING)
						[ ] // ///Select All Accounts
						[ ] 
						[ ] sleep(3)
						[ ] sleep(3)
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(5)
						[ ] sleep(1)
						[ ] 
						[ ] 
						[ ] ///Verify transaction in the spending register//
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for Last 60 days date filter.")
						[+] else
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for Last 60 days date filter.")
							[ ] 
							[ ] 
						[ ] //Delete Transaction From Register
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] sleep(2)
						[ ] 
						[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
						[+] if (iVerify==PASS)
							[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
					[ ] 
					[ ] 
			[ ] 
			[ ] 
			[+] //For Last 90 days-----------------------------------------------------------------------------------------------------------------------------
				[ ] sDate=ModifyDate(-89,sDateFormat)
				[ ] //Select Account from Account Bar
				[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iResult==PASS)
					[ ] 
					[ ] 
					[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateQuickenTab(sTAB_SPENDING)
						[ ] // ///Select All Accounts
						[ ] 
						[ ] sleep(3)
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(6)
						[ ] sleep(1)
						[ ] 
						[ ] 
						[ ] ///Verify transaction in the spending register//
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for Last 90 days date filter.")
						[+] else
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for Last 90 days date filter.")
							[ ] 
							[ ] 
						[ ] //Delete Transaction From Register
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] sleep(2)
						[ ] 
						[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
						[+] if (iVerify==PASS)
							[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
					[ ] 
					[ ] 
			[ ] 
			[ ] 
			[+] //For Last 12 Months-------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=GetPreviousMonth(11)
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iResult==PASS)
					[ ] 
					[ ] 
					[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateQuickenTab(sTAB_SPENDING)
						[ ] // ///Select All Accounts
						[ ] 
						[ ] sleep(3)
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(7)
						[ ] sleep(1)
						[ ] 
						[ ] 
						[ ] ///Verify transaction in the spending register//
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for Last 12 Months date filter.")
						[+] else
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for Last 12 Months date filter.")
							[ ] 
							[ ] 
						[ ] //Delete Transaction From Register
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] sleep(2)
						[ ] 
						[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
						[ ] 
						[+] if (iVerify==PASS)
							[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] //For This Quarter Transactions----------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iResult==PASS)
					[ ] 
					[ ] 
					[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateQuickenTab(sTAB_SPENDING)
						[ ] // ///Select All Accounts
						[ ] 
						[ ] sleep(3)
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(8)
						[ ] sleep(1)
						[ ] 
						[ ] ///Verify transaction in the spending register//
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for This Quarter date filter.")
						[+] else
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for This Quarter date filter.")
							[ ] 
							[ ] 
						[ ] //Delete Transaction From Register
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] sleep(2)
						[ ] 
						[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
						[+] if (iVerify==PASS)
							[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
					[ ] 
					[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] //For Last Quarter Transaction Date-----------------------------------------------------------------------------------------------------
				[ ] 
				[ ] dtDateTime= GetDateTime ()
				[ ] sCompareMonth = FormatDateTime ([DATETIME] dtDateTime,  sCompareMonthFormat) 
				[ ] 
				[ ] 
				[ ] 
				[+] if(sCompareMonth=="3"||sCompareMonth=="6"||sCompareMonth=="9"||sCompareMonth=="12")
					[ ] 
					[ ] //For Last Quarter Month
					[ ] sDate=ModifyDate(-100,sDateFormat)
					[ ] 
					[ ] 
				[+] else if(sCompareMonth=="2"||sCompareMonth=="5"||sCompareMonth=="8"||sCompareMonth=="11")
					[ ] 
					[ ] sDate=ModifyDate(-65,sDateFormat)
					[ ] 
					[ ] 
				[+] else if(sCompareMonth=="1"||sCompareMonth=="4"||sCompareMonth=="7"||sCompareMonth=="10")
					[ ] 
					[ ] sDate=ModifyDate(-35,sDateFormat)
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iResult==PASS)
					[ ] 
					[ ] 
					[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateQuickenTab(sTAB_SPENDING)
						[ ] // ///Select All Accounts
						[ ] 
						[ ] sleep(3)
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(9)
						[ ] sleep(1)
						[ ] 
						[ ] 
						[ ] ///Verify transaction in the spending register//
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for Last Quarter date filter.")
						[+] else
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for Last Quarter date filter.")
							[ ] 
							[ ] 
						[ ] //Delete Transaction From Register
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] sleep(2)
						[ ] 
						[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
						[+] if (iVerify==PASS)
							[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
					[ ] 
					[ ] 
				[ ] 
				[ ] //------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For This Year Transaction Date---------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iResult==PASS)
					[ ] 
					[ ] 
					[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateQuickenTab(sTAB_SPENDING)
						[ ] // ///Select All Accounts
						[ ] sleep(3)
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(10)
						[ ] sleep(1)
						[ ] 
						[ ] 
						[ ] ///Verify transaction in the spending register//
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register This Year date filter.")
						[+] else
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for This Year date filter.")
							[ ] 
							[ ] 
						[ ] //Delete Transaction From Register
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] sleep(2)
						[ ] 
						[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
						[+] if (iVerify==PASS)
							[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
					[ ] 
					[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] //For Last Year Transaction Date---------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] //sNewDate=ModifyDate(-365)
				[ ] //Get date for Bill
				[ ] sDay=FormatDateTime(GetDateTime(), "d")
				[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
				[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
				[ ] iSelectDate=val(sYear)-1
				[ ] 
				[ ] sDate= sMonth+"/"+sDay+"/"+"{iSelectDate}"
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iResult==PASS)
					[ ] 
					[ ] 
					[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateQuickenTab(sTAB_SPENDING)
						[ ] // ///Select All Accounts
						[ ] 
						[ ] sleep(3)
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(11)
						[ ] sleep(1)
						[ ] 
						[ ] 
						[ ] ///Verify transaction in the spending register//
						[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
						[+] if (sActualTransactionCount==sTransactionCount)
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for Last Year date filter.")
						[+] else
							[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransaction[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register Last Year date filter.")
							[ ] 
							[ ] 
						[ ] //Delete Transaction From Register
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] sleep(2)
						[ ] 
						[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
						[+] if (iVerify==PASS)
							[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] //Custom date----------------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] 
				[ ] dtDateTime= GetDateTime ()
				[ ] newDateTime = AddDateTime (dtDateTime, -15)
				[ ] sCustomDate1 = FormatDateTime ([DATETIME] newDateTime, sDateFormat) 
				[ ] 
				[ ] newDateTime = AddDateTime (dtDateTime, +15)
				[ ] sCustomDate2 = FormatDateTime ([DATETIME] newDateTime, sDateFormat) 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if (iResult==PASS)
					[ ] 
					[ ] 
					[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
						[ ] 
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateQuickenTab(sTAB_SPENDING)
						[ ] // ///Select All Accounts
						[ ] 
						[ ] sleep(3)
						[ ] MDIClientSpending.SpendingWindow.AccountsPopUpList.Select("#1")
						[ ] MDIClientSpending.SpendingWindow.AccountsPopUpList.TypeKeys(KEY_ENTER)
						[ ] sleep(1)
						[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys("Spending")
						[ ] sleep(1)
						[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys(KEY_ENTER)
						[ ] 
						[ ] 
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.TypeKeys("Custom...")
						[ ] MDIClientSpending.SpendingWindow.DatePopUpList.TypeKeys(KEY_ENTER)
						[+] if(DlgCustomDate.Exists(3))
							[ ] DlgCustomDate.FromTextField.SetText(sCustomDate1)
							[ ] DlgCustomDate.ToTextField.SetText(sCustomDate2)
							[ ] DlgCustomDate.OKButton.Click()
							[ ] 
							[ ] 
							[ ] 
							[ ] //Verify the All Transactions Filter
							[ ] 
							[ ] 
							[ ] 
							[ ] sNum="1"
							[ ] sTransactionCount  = MDIClient.AccountRegister.Balances.TransactionCount.GetText()
							[ ] 
							[ ] 
							[ ] bMatch=MatchStr("*{sNum}*",sTransactionCount)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to custom date filter ") 
							[+] else
								[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to custom date filter ") 
								[ ] 
						[ ] //Delete Transaction From Register
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] sleep(2)
						[ ] 
						[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
						[+] if (iVerify==PASS)
							[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
				[+] else
					[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  not created")
			[ ] 
	[+] else 
		[ ] App_Start(sCmdLine)
		[ ] sleep(5)
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Date Filter in Spending Tab ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_22SpendingTanDateFilter_AllDates()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify all options under "All Dates" Dropdown menu from Spending Tab
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  08/26/ 2014	Created by	Mukesh
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test21_22SpendingTanDateFilterForAllDatesForIncomeTransaction() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Datetime
		[ ] DATETIME dtDateTime,newDateTime
		[ ] STRING sNum 
		[ ] //Integer
		[ ] INTEGER iCount,i,iCounter=0, j,iVerify,iSelectDate ,iYear
		[ ] //INTEGER iDateDropdownCount=12
		[ ] 
		[ ] //String
		[ ] STRING sNewDate,sCompareDay,sCompareMonth,sCompareYear
		[ ] 
		[ ] STRING sDay,sMonth,sYear
		[ ] sFileName ="Register"
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] STRING sDateFormat="m/d/yyyy"
		[ ] STRING sCompareDayFormat="d"
		[ ] STRING sCompareMonthFormat="m"
		[ ] STRING sCompareYearFormat="yyyy"
		[ ] 
		[ ] 
		[ ] STRING sCustomDate1,sCustomDate2
		[ ] 
		[ ] STRING sAccountDate="1/1/2011"
		[ ] sTransactionCount="1"
		[ ] //List of String
		[ ] LIST OF STRING lsDate,lsDateFilterData
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile, sSpendingAccountWorksheet)
		[ ] lsAddAccount = lsExcelData[1]
		[ ] sAccountName =lsAddAccount[2]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sSpendingTabExcelFile,sSpendingTransactionSheet)
		[ ] lsTransactionData =lsExcelData[2]
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] //creating data file to handle the identification issue
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
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
		[ ] //Verify Dates for transactions-------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] 
		[+] //For All Dates Transactions---------------------------------------------------------------------------------------------------------------
			[ ] sNewDate=ModifyDate(0,sDateFormat)
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sNewDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if (iAddTransaction==PASS)
					[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] NavigateQuickenTab(sTAB_SPENDING)
					[ ] // ///Select All Accounts
					[ ] 
					[ ] sleep(3)
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.TypeKeys("All Dates")
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.TypeKeys(KEY_ENTER)
					[ ] sleep(1)
					[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys("Income")
					[ ] sleep(1)
					[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys(KEY_ENTER)
					[ ] 
					[ ] 
					[ ] sleep(1)
					[ ] 
					[ ] 
					[ ] ///Verify transaction in the spending register//
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register.")
					[+] else
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransactionData} in Spending register.")
						[ ] 
						[ ] 
					[ ] //Delete Transaction From Register
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
					[+] if (iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
				[ ] 
				[ ] 
		[ ] //-------------------------------------------------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] 
		[+] //For This Month Transactions------------------------------------------------------------------------------------------------------------
			[ ] sNewDate=ModifyDate(0,sDateFormat)
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sNewDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if (iAddTransaction==PASS)
					[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] NavigateQuickenTab(sTAB_SPENDING)
					[ ] // ///Select All Accounts
					[ ] 
					[ ] sleep(3)
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(2)
					[ ] sleep(1)
					[ ] 
					[ ] 
					[ ] ///Verify transaction in the spending register//
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register.")
					[+] else
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register.")
						[ ] 
						[ ] 
					[ ] //Delete Transaction From Register
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] sleep(2)
					[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
					[+] if (iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
				[ ] 
				[ ] 
			[ ] //-------------------------------------------------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] 
		[+] //For Last Month Transaction--------------------------------------------------------------------------------------------------------------
			[ ] sDate=GetPreviousMonth(1)
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if (iAddTransaction==PASS)
					[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] NavigateQuickenTab(sTAB_SPENDING)
					[ ] // ///Select All Accounts
					[ ] 
					[ ] sleep(3)
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(3)
					[ ] sleep(1)
					[ ] 
					[ ] ///Verify transaction in the spending register//
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register  for This Month date filter.")
					[+] else
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for This Month date filter.")
						[ ] 
						[ ] 
					[ ] //Delete Transaction From Register
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] sleep(2)
					[ ] 
					[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
					[+] if (iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
				[ ] 
				[ ] 
			[ ] //------------------------------------------------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] 
		[+] //For Last 30 days-----------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] sDate=ModifyDate(-25,sDateFormat)
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if (iAddTransaction==PASS)
					[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] NavigateQuickenTab(sTAB_SPENDING)
					[ ] // ///Select All Accounts
					[ ] 
					[ ] sleep(3)
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(4)
					[ ] sleep(1)
					[ ] 
					[ ] 
					[ ] ///Verify transaction in the spending register//
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for Last 30 days date filter.")
					[+] else
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for Last 30 days date filter.")
						[ ] 
						[ ] 
					[ ] //Delete Transaction From Register
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] sleep(2)
					[ ] 
					[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
					[+] if (iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
				[ ] 
				[ ] 
			[ ] 
		[ ] 
		[ ] 
		[+] //For Last 60 days-----------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] sDate=ModifyDate(-59,sDateFormat)
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if (iAddTransaction==PASS)
					[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] NavigateQuickenTab(sTAB_SPENDING)
					[ ] // ///Select All Accounts
					[ ] 
					[ ] sleep(3)
					[ ] sleep(3)
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(5)
					[ ] sleep(1)
					[ ] 
					[ ] 
					[ ] ///Verify transaction in the spending register//
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for Last 60 days date filter.")
					[+] else
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for Last 60 days date filter.")
						[ ] 
						[ ] 
					[ ] //Delete Transaction From Register
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] sleep(2)
					[ ] 
					[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
					[+] if (iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
				[ ] 
				[ ] 
		[ ] 
		[ ] 
		[+] //For Last 90 days-----------------------------------------------------------------------------------------------------------------------------
			[ ] sDate=ModifyDate(-89,sDateFormat)
			[ ] //Select Account from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if (iAddTransaction==PASS)
					[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] NavigateQuickenTab(sTAB_SPENDING)
					[ ] // ///Select All Accounts
					[ ] 
					[ ] sleep(3)
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(6)
					[ ] sleep(1)
					[ ] 
					[ ] 
					[ ] ///Verify transaction in the spending register//
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for Last 90 days date filter.")
					[+] else
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for Last 90 days date filter.")
						[ ] 
						[ ] 
					[ ] //Delete Transaction From Register
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] sleep(2)
					[ ] 
					[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
					[+] if (iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
				[ ] 
				[ ] 
		[ ] 
		[ ] 
		[+] //For Last 12 Months-------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] sDate=GetPreviousMonth(11)
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if (iAddTransaction==PASS)
					[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] NavigateQuickenTab(sTAB_SPENDING)
					[ ] // ///Select All Accounts
					[ ] 
					[ ] sleep(3)
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(7)
					[ ] sleep(1)
					[ ] 
					[ ] 
					[ ] ///Verify transaction in the spending register//
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for Last 12 Months date filter.")
					[+] else
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for Last 12 Months date filter.")
						[ ] 
						[ ] 
					[ ] //Delete Transaction From Register
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] sleep(2)
					[ ] 
					[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
					[ ] 
					[+] if (iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[+] //For This Quarter Transactions----------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] sDate=ModifyDate(0,sDateFormat)
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if (iAddTransaction==PASS)
					[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] NavigateQuickenTab(sTAB_SPENDING)
					[ ] // ///Select All Accounts
					[ ] 
					[ ] sleep(3)
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(8)
					[ ] sleep(1)
					[ ] 
					[ ] ///Verify transaction in the spending register//
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for This Quarter date filter.")
					[+] else
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for This Quarter date filter.")
						[ ] 
						[ ] 
					[ ] //Delete Transaction From Register
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] sleep(2)
					[ ] 
					[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
					[+] if (iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
				[ ] 
				[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] //For Last Quarter Transaction Date-----------------------------------------------------------------------------------------------------
			[ ] 
			[ ] dtDateTime= GetDateTime ()
			[ ] sCompareMonth = FormatDateTime ([DATETIME] dtDateTime,  sCompareMonthFormat) 
			[ ] 
			[ ] 
			[ ] 
			[+] if(sCompareMonth=="3"||sCompareMonth=="6"||sCompareMonth=="9"||sCompareMonth=="12")
				[ ] 
				[ ] //For Last Quarter Month
				[ ] sDate=ModifyDate(-100,sDateFormat)
				[ ] 
				[ ] 
			[+] else if(sCompareMonth=="2"||sCompareMonth=="5"||sCompareMonth=="8"||sCompareMonth=="11")
				[ ] 
				[ ] sDate=ModifyDate(-65,sDateFormat)
				[ ] 
				[ ] 
			[+] else if(sCompareMonth=="1"||sCompareMonth=="4"||sCompareMonth=="7"||sCompareMonth=="10")
				[ ] 
				[ ] sDate=ModifyDate(-35,sDateFormat)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if (iAddTransaction==PASS)
					[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] NavigateQuickenTab(sTAB_SPENDING)
					[ ] // ///Select All Accounts
					[ ] 
					[ ] sleep(3)
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(9)
					[ ] sleep(1)
					[ ] 
					[ ] 
					[ ] ///Verify transaction in the spending register//
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for Last Quarter date filter.")
					[+] else
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for Last Quarter date filter.")
						[ ] 
						[ ] 
					[ ] //Delete Transaction From Register
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] sleep(2)
					[ ] 
					[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
					[+] if (iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
				[ ] 
				[ ] 
			[ ] 
			[ ] //------------------------------------------------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] 
		[+] //For This Year Transaction Date---------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] sDate=ModifyDate(0,sDateFormat)
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if (iAddTransaction==PASS)
					[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] NavigateQuickenTab(sTAB_SPENDING)
					[ ] // ///Select All Accounts
					[ ] sleep(3)
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(10)
					[ ] sleep(1)
					[ ] 
					[ ] 
					[ ] ///Verify transaction in the spending register//
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register This Year date filter.")
					[+] else
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransactionData[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register for This Year date filter.")
						[ ] 
						[ ] 
					[ ] //Delete Transaction From Register
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] sleep(2)
					[ ] 
					[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
					[+] if (iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
				[ ] 
				[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] //For Last Year Transaction Date---------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] //sNewDate=ModifyDate(-365)
			[ ] //Get date for Bill
			[ ] sDay=FormatDateTime(GetDateTime(), "d")
			[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
			[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
			[ ] iSelectDate=val(sYear)-1
			[ ] 
			[ ] sDate= sMonth+"/"+sDay+"/"+"{iSelectDate}"
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if (iAddTransaction==PASS)
					[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] NavigateQuickenTab(sTAB_SPENDING)
					[ ] // ///Select All Accounts
					[ ] 
					[ ] sleep(3)
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.Select(11)
					[ ] sleep(1)
					[ ] 
					[ ] 
					[ ] ///Verify transaction in the spending register//
					[ ] sActualTransactionCount=VerifyTransactionUsingSearchFieldInRegister(lsTransactionData[6]) 
					[+] if (sActualTransactionCount==sTransactionCount)
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", PASS, " Transaction count : {sActualTransactionCount} is as expected: {sTransactionCount} for {lsTransactionData[6]} in Spending register for Last Year date filter.")
					[+] else
						[ ] ReportStatus("Verify transaction  {lsTransactionData[6]} for {sAccountName} added.", FAIL, " Verify transaction  {lsTransaction[6]} for {sAccountName} in Spending register: Transaction count : {sActualTransactionCount} is NOT as expected: {sTransactionCount} for {lsTransaction} in Spending register Last Year date filter.")
						[ ] 
						[ ] 
					[ ] //Delete Transaction From Register
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] sleep(2)
					[ ] 
					[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
					[+] if (iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] //Custom date----------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] sDate=ModifyDate(0,sDateFormat)
			[ ] 
			[ ] 
			[ ] dtDateTime= GetDateTime ()
			[ ] newDateTime = AddDateTime (dtDateTime, -15)
			[ ] sCustomDate1 = FormatDateTime ([DATETIME] newDateTime, sDateFormat) 
			[ ] 
			[ ] newDateTime = AddDateTime (dtDateTime, +15)
			[ ] sCustomDate2 = FormatDateTime ([DATETIME] newDateTime, sDateFormat) 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if (iAddTransaction==PASS)
					[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[6]} ") 
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] NavigateQuickenTab(sTAB_SPENDING)
					[ ] // ///Select All Accounts
					[ ] 
					[ ] sleep(3)
					[ ] MDIClientSpending.SpendingWindow.AccountsPopUpList.Select("#1")
					[ ] MDIClientSpending.SpendingWindow.AccountsPopUpList.TypeKeys(KEY_ENTER)
					[ ] sleep(1)
					[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys("Income")
					[ ] sleep(1)
					[ ] MDIClientSpending.SpendingWindow.TransactionTypePopUpList.TypeKeys(KEY_ENTER)
					[ ] 
					[ ] 
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.TypeKeys("Custom...")
					[ ] MDIClientSpending.SpendingWindow.DatePopUpList.TypeKeys(KEY_ENTER)
					[+] if(DlgCustomDate.Exists(3))
						[ ] DlgCustomDate.FromTextField.SetText(sCustomDate1)
						[ ] DlgCustomDate.ToTextField.SetText(sCustomDate2)
						[ ] DlgCustomDate.OKButton.Click()
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify the All Transactions Filter
						[ ] 
						[ ] 
						[ ] 
						[ ] sNum="1"
						[ ] sTransactionCount  = MDIClient.AccountRegister.Balances.TransactionCount.GetText()
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{sNum}*",sTransactionCount)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to custom date filter ") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to custom date filter ") 
							[ ] 
					[ ] //Delete Transaction From Register
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] sleep(2)
					[ ] 
					[ ] iVerify=DeleteTransaction(sMDIWindow, lsTransactionData[6])
					[+] if (iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} deleted") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be deleted") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[6]} couldn't be added") 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account selected", FAIL, "{lsAddAccount[2]} account couldn't be selected.")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Verify Quicken Window exists.", FAIL, "Quicken is not available") 
	[ ] 
	[ ] 
