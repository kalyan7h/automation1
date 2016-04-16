[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[+] // Variable Declaration
	[ ] 
	[ ] LIST OF ANYTYPE lsAddAccount, lsExcelData, lsTransaction, lsReportNames,lsAccount,lsAmountData,lsListBoxItems,lsTemp ,lsTxnExcelData ,lsDateExcelData
	[ ] INTEGER iAmount ,iSwitchState,iSelect,iResult,iNum
	[ ] LIST OF ANYTYPE  lsIncomeCategory,lsExpenseCategory,lsCategory,lsActualListContents
	[ ] NUMBER nAmount,nAmount1,nAmount2,nAmountTotal,nActualAmount,nAmountDifferenceActual ,nAmountDifferenceExpected
	[ ] 
	[ ] public INTEGER iClickAccount,iCreateFile,iPopupRegister,itest 
	[ ] STRING sAccountType
	[ ] public INTEGER iXpos =235
	[ ] public INTEGER iYpos =21
	[ ] 
	[ ] 
	[ ] 
	[ ] public INTEGER iSetupAutoAPI ,iCounter, iItemCount, iCount,iVerify , iListCount
	[ ] BOOLEAN bMatch, bResult
	[ ] STRING sRegFileName="Register"
	[ ] public STRING sRegisterExcelsheet="BankingRegister"
	[ ] 
	[ ] public STRING sRegDataFile = AUT_DATAFILE_PATH + "\" + sRegFileName + ".QDF"
	[ ] public STRING sRegAccountWorksheet = "RegAccount"
	[ ] public STRING sRegTransactionSheet = "RegCheckingTransaction"
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
	[ ] public STRING sBrokerageAccountSheet= "BrokerageAccount"
	[ ] public STRING sTRowPriceTxnsSheet= "TRowPriceTxns"
	[ ] public STRING sAccountAttributesSheet= "AccountAttributes"
	[ ] public STRING sAccountHoldingsDataSheet= "AccountHoldingsData"
	[ ] 
	[ ] public INTEGER  iAddAccount
	[ ] public STRING sActualErrorMsg ,sExpectedErrorMsg,hWnd,sExpected, sActual, sDateRange,sAmountPaid,sCategory,sListitem,sTransactionCount
	[ ] public STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[ ] public string sCaption
	[ ] 
	[ ] public STRING sValidationText,sActualAmount, sAccountAction,sAmount,sItem,sMenuItem,sAccountName,sDueDate,sActualDate,sExpectedDate
	[ ] 
	[ ] 
	[ ] //Integer
	[ ] public INTEGER iCreateDataFile,iAddTransaction,iFileResult,i
	[ ] public INTEGER iLoop
	[ ] public INTEGER iAccountSpecificCounterValue
	[ ] 
	[ ] //String
	[ ] public STRING sFileName = "Register"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] 
	[ ] public STRING sHandle,sExpectedEndingBalance,sDateFormat
	[ ] 
	[ ] public STRING sTransactionFilterWorksheet="TransactionFilter"
	[ ] public STRING sDateFilterWorksheet="DateFilter"
	[ ] public STRING sTypeFilterWorksheet="TypeFilter"
	[ ] public STRING sTransactionWorksheet="OtherTransaction"
	[ ] public STRING sCheckingTransactionWorksheet="CheckingTransaction"
	[ ] public STRING sAccountWorksheet="Account"
	[ ] public STRING sSearchFilterWorksheet="SearchFilter"
	[ ] 
	[ ] //List of String
	[ ] public LIST OF STRING lsTransactionData
	[ ] 
	[ ] public STRING sPopUpWindow = "PopUp"
	[ ] public STRING sMDIWindow = "MDI"
	[ ] STRING sDate=ModifyDate(0,"m/d/yyyy")
	[ ] //Boolean
	[ ] public BOOLEAN bBalanceCheck
	[ ] window CreateExcelCompatibleFile
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] // Functions
	[ ] // 
	[ ] // 
	[ ] // ==========================================================
	[+] // FUNCTION: GetLineFromReport()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This function will restore from the backup of Quicken
		[ ] // 
		[ ] // PARAMETERS:			STRING  	sSearchString      Unique string to search in the report and retirive the transaction
		[ ] // 
		[ ] // 
		[ ] // RETURNS:				STRING 	PASS	 String from report is returned if value is found else NULL
		[ ] // 
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // May 3rd, 2013 	Dean Paes created
	[ ] // ==========================================================
	[+] public STRING GetLineFromReport(window wReport, STRING sSearchString)
		[ ] 
		[ ] 
		[+] // Variable Declaration
			[ ] STRING sActual,sHandle,sCaption
			[ ] BOOLEAN bFindTransactionFlag,bMatch
		[ ] 
		[+] do
			[+] if(wReport.Exists(2))
				[ ] wReport.SetActive()
				[ ] 
				[ ] sCaption=wReport.GetCaption()
				[ ] 
				[ ] iCount=wReport.QWListViewer1.ListBox1.GetItemCount()
				[ ] sHandle=Str(wReport.QWListViewer1.ListBox1.GetHandle())
				[ ] 
				[ ] // ---------------Get Payee Name from Report------------------
				[+] for(i=0;i<=iCount;i++)
					[ ] sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sSearchString}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] bFindTransactionFlag=TRUE
						[ ] goto END
						[ ] 
					[ ] 
				[ ] 
				[ ] 
				[+] if(bFindTransactionFlag==FALSE)
					[ ] ReportStatus("Find Transaction In Report",FAIL,"Transaction NOT found in Report {sCaption}")
					[ ] sActual=NULL
				[ ] 
				[ ] END:
				[+] if(bFindTransactionFlag==TRUE)
					[ ] ReportStatus("Find Transaction In Report",PASS,"Transaction {sActual} found in Report {sCaption}")
				[ ] 
				[ ] 
				[ ] 
		[+] except
			[ ] sActual=NULL
		[ ] return sActual
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] // ==========================================================
	[+] // FUNCTION: TransactionReportOperations()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This function will restore from the backup of Quicken
		[ ] // 
		[ ] // PARAMETERS:			STRING  	sSearchString      Option to search the register to find transaction for which transaction report is to be opened
		[ ] // STRING  	sReportAction	  Option to be selected from the right click menu on the report (e.g:  Retag transaction(s))
		[ ] // INTEGER    iLineNo                Line of the report where the transaction is found
		[ ] // 
		[ ] // RETURNS:				INTEGER	PASS	If Transaction report is opened and option is selected
		[ ] // FAIL	In case of failure
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // May 3rd, 2013 	Dean Paes created
	[ ] // ==========================================================
	[+] // public INTEGER TransactionReportOperations(STRING sSearchString,STRING sReportAction)
		[ ] // 
		[ ] // 
		[+] // Variable Declaration
			[ ] // 
			[ ] // Account Register Coordinates
			[ ] // INTEGER iX1=280
			[ ] // INTEGER iY1=21
			[ ] // Report Coordinates
			[ ] // INTEGER iX2=380
			[ ] // INTEGER iY2=50
			[ ] // 
			[ ] // STRING sAction="Launch Mini-Report For Payee " + sSearchString
		[ ] // 
		[+] // do
			[ ] // 
			[ ] // 
			[ ] // ---------Open Paye Mini Rpeort----------
			[ ] // AccountActionsOnTransaction(sSearchString,sAction,iX1,iY1)
			[+] // if(MDICalloutHolder.CalloutPopup.Exists(5))
				[ ] // ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened")
				[ ] // 
				[ ] // -----------Click on Show Report button on Callout----------
				[ ] // MDICalloutHolder.CalloutPopup.ShowReport.Click()
				[ ] // 
				[+] // if(wReport.Exists(4))
					[ ] // ReportStatus("Open Report from Register Mini Report",PASS,"Report Opened")
					[ ] // 
					[ ] // Select Include All dates from date filter
					[ ] // wReport.QWCustomizeBar1.PopupList1.Select(1)
					[ ] // 
					[ ] // wReport.QWListViewer1.ListBox1.Click(1,iX2,iY2)
					[ ] // 
					[ ] // 
					[ ] // -------------Select Action of report from right click dropdown menu------------
					[ ] // wReport.QWListViewer1.ListBox1.PopUpSelect(iX2,iY2,sReportAction)
					[ ] // iFunctionResult=PASS
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Open Report from Register Mini Report",FAIL,"Report Not Opened")
					[ ] // iFunctionResult=FAIL
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Open Register Mini Report",FAIL,"Mini Report Not Opened")
				[ ] // iFunctionResult=FAIL
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
		[+] // except
			[ ] // iFunctionResult=FAIL
		[ ] // return iFunctionResult
	[ ] // 
	[ ] // 
	[ ] // 
	[ ] // ==========================================================
	[+] // FUNCTION: RegisterSetUp()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This function will restore from the backup of Quicken
		[ ] // 
		[ ] // PARAMETERS:			STRING  	sSearchString      Option to search the register to find transaction for which transaction report is to be opened
		[ ] // STRING  	sReportAction	  Option to be selected from the right click menu on the report (e.g:  Retag transaction(s))
		[ ] // INTEGER    iLineNo                Line of the report where the transaction is found
		[ ] // 
		[ ] // RETURNS:				INTEGER	PASS	If Transaction report is opened and option is selected
		[ ] // FAIL	In case of failure
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // May 3rd, 2013 	Dean Paes created
	[ ] // ==========================================================
	[+] public void RegisterSetUp()
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[+] do
			[ ] 
			[+] if(FileExists(sTestCaseStatusFile))
				[ ] DeleteFile(sTestCaseStatusFile)
			[ ] // Load O/S specific paths
			[ ] LoadOSDependency()
			[+] //########Launch Quicken and open RPM_Test File######################//
				[ ] 
				[ ] iResult =DataFileCreate(sRegFileName)
				[+] if (iResult==PASS)
					[ ] // Add Checking Account---------------------------
					[ ] QuickenWindow.SetActive() 
					[ ] // Read data from excel sheet
					[+] for (iCount=1 ; iCount < 5; ++iCount)
							[ ] 
							[ ] // Fetch rows from the given sheet
							[ ] lsAddAccount=lsExcelData[iCount]
							[+] if (lsAddAccount[1]==NULL)
								[ ] break
							[ ] //############## Manual Spending Account #####################################
							[ ] // Quicken is launched then Add Account
							[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
							[ ] // Report Status if checking Account is created
							[+] if (iAddAccount==PASS)
								[ ] ReportStatus("{lsAddAccount[1]} Account", PASS, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
							[+] else
								[ ] ReportStatus("{lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] // Report Status if Quicken is not launched
					[ ] //############## Added New Checking Account #####################################
					[ ] iSetupAutoAPI = SetUp_AutoApi()
					[+] if (iSetupAutoAPI==PASS)
						[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
					[+] else
						[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup couldn't complete.") 
				[+] else
					[ ] ReportStatus("Verify datafile creation. ", FAIL, "Verify datafile creation: Datafile: {sRegFileName} couldn't be created.") 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] // 
[+] //############# Test_CategoriesSplitTransaction #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test_CategoriesSplitTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add a split transaction with 30 split lines
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding split transaction is successful
		[ ] //						Fail			If adding split transaction is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April 30th 2013		
		[ ] //Author                          Dean
		[ ] 
	[ ] // ********************************************************
	[ ] 
	[ ] 
[+] testcase Test_CategoriesSplitTransaction() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sTag , sMemo ,sAccountTotal ,sActualBalanceText
		[ ] INTEGER iCount,iAccountCount,iAccountLoop
		[ ] LIST OF STRING lsAccountNameList ,lsAccountBalList
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read data from sRegAccountWorksheet excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Fetch 1st row from sRegTransactionSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegTransactionSheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] // Fetch 1st row from sExpenseCategoryDataSheet the given sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
		[ ] lsExpenseCategory=lsExcelData[1]
		[ ] iCount = ListCount (lsExcelData) 
		[ ] 
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[ ] 
	[ ] iResult= DataFileCreate(sRegFileName)
	[-] if (iResult==PASS)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Add Checking Account---------------------------
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] ListAppend(lsAccountNameList,lsAddAccount[2])
		[ ] ListAppend(lsAccountBalList,lsAddAccount[3])
		[ ] 
		[ ] 
		[ ] 
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] // Add Savings Account---------------------------
		[ ] 
		[ ] // // Read data from excel sheet
		[ ] lsAddAccount=lsExcelData[2]
		[ ] ListAppend(lsAccountNameList,lsAddAccount[2])
		[ ] ListAppend(lsAccountBalList,lsAddAccount[3])
		[ ] 
		[ ] 
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] 
		[ ] // Add Credit Card Account---------------------------
		[ ] // // Read data from excel sheet
		[ ] lsAddAccount=lsExcelData[3]
		[ ] ListAppend(lsAccountNameList,lsAddAccount[2])
		[ ] ListAppend(lsAccountBalList,lsAddAccount[3])
		[ ] 
		[ ] 
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] 
		[ ] // Add Cash Account---------------------------
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsAddAccount=lsExcelData[4]
		[ ] ListAppend(lsAccountNameList,lsAddAccount[2])
		[ ] ListAppend(lsAccountBalList,lsAddAccount[3])
		[ ] 
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
		[+] else
			[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] 
		[ ] iAccountCount=ListCount(lsAccountNameList)
		[-] for(iAccountLoop=1;iAccountLoop<=iAccountCount;iAccountLoop++)
			[ ] //Select the Banking account
			[ ] iSelect=SelectAccountFromAccountBar(lsAccountNameList[iAccountLoop],ACCOUNT_BANKING)
			[-] if (iSelect==PASS)
				[ ] 
				[ ] //Change Payee name to account related name
				[ ] lsTransaction[6]=lsAccountNameList[iAccountLoop]+"Payee"
				[ ] 
				[ ] 
				[-] if(iAccountLoop==1)
					[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1])
					[ ] 
				[ ] 
				[-] if(iAccountLoop>1)
					[ ] AddBankingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,NULL,lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1])
					[ ] 
					[ ] 
				[ ] 
				[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransaction[6]} added succesfully to Account {lsAccountNameList[iAccountLoop]}")
					[ ] 
					[ ] 
					[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
					[+] if(SplitTransaction.Exists(2))
						[ ] 
						[ ] 
						[ ] lsExcelData=NULL
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sExpenseCategoryDataSheet)
						[ ] 
						[ ] nAmount1=0
						[+] for(i=1;i<=iCount;i++)
							[ ] lsExpenseCategory=lsExcelData[i]
							[ ] SplitTransaction.SetActive()
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select (i)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[1])
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(lsExpenseCategory[3])
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
							[+] if (NewTag.Exists(3))
								[ ] NewTag.SetActive()
								[ ] NewTag.OKButton.Click()
								[ ] 
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(lsExpenseCategory[4])
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(KEY_TAB)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(lsExpenseCategory[2])
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(KEY_ENTER)
							[ ] 
							[ ] 
							[ ] nAmount1 =VAL(lsExpenseCategory[2]) + nAmount1
						[ ] 
						[+] if (SplitTransaction.Adjust.IsEnabled())
							[ ] SplitTransaction.Adjust.Click()
						[ ] SplitTransaction.OK.Click()
						[ ] WaitForState(SplitTransaction,False,1)
						[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
						[ ] 
						[ ] 
						[ ] nAmount = VAL(lsAccountBalList[iAccountLoop]) - nAmount1
						[ ] //----------------Verify if Transaction is added to account-------------------------
						[+] if (iAccountLoop==3)
							[ ] nAmount = -VAL(lsAccountBalList[iAccountLoop]) - nAmount1
						[ ] sActualBalanceText=MDIClient.AccountRegister.Balances.EndingBalance.GetText()
						[ ] 
						[ ] nActualAmount =VAL(StrTran(sActualBalanceText,",",""))
						[+] if(nActualAmount==nAmount)
							[ ] ReportStatus("Verify Split Transaction added to account",PASS,"Split Transaction:Transaction with payee {lsTransaction[6]} added to Account {lsAccountNameList[iAccountLoop]} with actual balance {nActualAmount}")
						[+] else
							[ ] ReportStatus("Verify Split Transaction added to account",FAIL,"Split Transaction:Transaction with payee {lsTransaction[6]} not added to Account {lsAccountNameList[iAccountLoop]} with actual balance {nActualAmount} but expected balance is {nAmount}")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
				[+] else
					[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAccountNameList[iAccountLoop]}")
			[+] else
				[ ] ReportStatus("Verify Checking Account", FAIL, "Checking account couldn't open.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] else
		[ ] ReportStatus("Verify Create New Quicken File", FAIL, "New Quicken File couldn't be created successfully..") 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Date Filter in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC43_54RegisterDateFilter_AllDates()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify all options under "All Dates" Dropdown menu from  Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all  details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC197_208_BusinessRegisterDateFilter_AllDates() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Datetime
		[ ] DATETIME dtDateTime,newDateTime
		[ ] 
		[ ] //Integer
		[ ] INTEGER iSelectDate ,iYear
		[ ] 
		[ ] //String
		[ ] STRING sCompareDay,sCompareMonth,sCompareYear
		[ ] 
		[ ] STRING sDay,sMonth,sYear
		[ ] 
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] STRING sDateFormat="m/d/yyyy"
		[ ] STRING sCompareDayFormat="d"
		[ ] STRING sCompareMonthFormat="m"
		[ ] STRING sCompareYearFormat="yyyy"
		[ ] STRING sBusinessAccount="Vendor Invoices Account"
		[ ] 
		[ ] STRING sCustomDate1,sCustomDate2
		[ ] 
		[ ] STRING sAccountDate="1/1/2011"
		[ ] 
		[ ] //List of String
		[ ] LIST OF STRING lsDate,lsDateFilterData
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegBusinessTransaction)
		[ ] lsTransactionData=lsExcelData[2]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[12][2]
		[ ] lsExcelData=NULL
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
		[ ] lsDateFilterData=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[+] if (iCreateDataFile == PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Add Business Account
		[ ] iAddAccount = AddBusinessAccount("Accounts Payable",sBusinessAccount)
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Add Business Account", PASS, "Accounts Payable Account -  {sBusinessAccount}  is created successfully")
			[ ] 
			[ ] 
			[ ] 
			[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
			[ ] 
			[ ] //Verify Dates for transactions-------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For All Dates Transactions---------------------------------------------------------------------------------------------------------------
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] 
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]} ") 
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] // lsDateFilterData=lsExcelData[1]
				[ ] // 
				[ ] lsDateFilterData=lsExcelData[1]
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[4])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] //-------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For This Month Transactions------------------------------------------------------------------------------------------------------------
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]} ") 
				[ ] 
				[ ] //This Month---------------------------------
				[ ] //Read data from excel sheet
				[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] // lsDateFilterData=lsExcelData[2]
				[ ] lsDateFilterData=lsExcelData[2]
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[4])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] 
				[ ] //-------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For Last Month Transaction--------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] sDate=GetPreviousMonth(1)
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]} ") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[3]
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[4])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] 
				[ ] //------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] 
			[+] //For Last 30 days-----------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(-29,sDateFormat)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[4]
				[ ] 
				[ ] 
				[ ] //Select Account from Account Bar
				[ ] SelectAccountFromAccountBar(sBusinessAccount, ACCOUNT_BUSINESS)
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] sleep(SHORT_SLEEP)
			[ ] 
			[ ] 
			[+] //For Last 60 days-----------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(-59,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[5]
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] sleep(SHORT_SLEEP)
			[ ] 
			[ ] 
			[+] //For Last 90 days-----------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(-89,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[6]
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] //For Last 12 Months-------------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] 
				[ ] sDate=GetPreviousMonth(11)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[7]
				[ ] 
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] //For This Quarter Transactions----------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] ////invoice no.
				[ ] lsTransactionData[4]=Str(RandInt(200,500 ))
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] //This Month---------------------------------
				[ ] //Read data from excel sheet
				[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] lsDateFilterData=lsExcelData[8]
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] 
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] sleep(SHORT_SLEEP)
			[ ] 
			[ ] 
			[ ] 
			[+] //For Last Quarter Transaction Date-----------------------------------------------------------------------------------------------------
				[ ] 
				[ ] dtDateTime= GetDateTime ()
				[ ] sCompareMonth = FormatDateTime ([DATETIME] dtDateTime,  sCompareMonthFormat) 
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
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] lsTransactionData[4]=Str(RandInt(20,30 ))
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[9]
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] //------------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[+] //For This Year Transaction Date---------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] sDate=ModifyDate(0,sDateFormat)
				[ ] 
				[ ] //Verify total Transaction count under filter
				[ ] lsTransactionData[4]=Str(RandInt(1,10 ))
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[10]
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[6]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] //For Last Year Transaction Date---------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] 
				[ ] INTEGER iDay
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
				[ ] //Verify total Transaction count under filter
				[ ] lsTransactionData[4]=Str(RandInt(30,40 ))
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] //Read data from excel sheet
				[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
				[ ] //Fetch 2nd row from the given sheet
				[ ] lsDateFilterData=lsExcelData[11]
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify the All Transactions Filter
				[ ] iVerify=VerifyAccountRegisterFilter(lsDateFilterData[1],lsDateFilterData[2],lsDateFilterData[3])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
					[ ] 
				[ ] sleep(SHORT_SLEEP)
				[ ] //Delete Transaction From Register
				[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
				[ ] 
				[ ] sleep(SHORT_SLEEP)
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
				[ ] //Verify total Transaction count under filter
				[ ] 
				[ ] lsTransactionData[4]=Str(RandInt(50,60 ))
				[ ] 
				[ ] iAddTransaction= AddBusinessTransaction(lsTransactionData[1],lsTransactionData[2],  lsTransactionData[3], sDate,lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "Transaction with Payee : {lsTransactionData[5]}") 
				[ ] 
				[ ] 
				[ ] dtDateTime= GetDateTime ()
				[ ] newDateTime = AddDateTime (dtDateTime, -15)
				[ ] sCustomDate1 = FormatDateTime ([DATETIME] newDateTime, sDateFormat) 
				[ ] 
				[ ] newDateTime = AddDateTime (dtDateTime, +15)
				[ ] sCustomDate2 = FormatDateTime ([DATETIME] newDateTime, sDateFormat) 
				[ ] QuickenWindow.SetActive()
				[ ] MDIClient.AccountRegister.DateFilter.Select(12)
				[+] if(DlgCustomDate.Exists(3))
					[ ] DlgCustomDate.FromTextField.SetText(sCustomDate1)
					[ ] DlgCustomDate.ToTextField.SetText(sCustomDate2)
					[ ] DlgCustomDate.OKButton.Click()
					[ ] 
					[ ] 
					[ ] 
					[ ] //Verify the All Transactions Filter
					[ ] STRING sNum 
					[ ] 
					[ ] lsDateFilterData=lsExcelData[12]
					[ ] 
					[ ] sNum="1"
					[ ] sTransactionCount  = MDIClient.AccountRegister.Balances.TransactionCount.GetText()
					[ ] 
					[ ] 
					[ ] bMatch=MatchStr("*{sNum}*",sTransactionCount)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Add Transaction", PASS, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} matched to filter {lsDateFilterData[2]}") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "Transaction with Payee : {lsTransactionData[5]} with date {sDate} not matched to filter {lsDateFilterData[2]}") 
						[ ] 
					[ ] 
					[ ] sleep(SHORT_SLEEP)
					[ ] //Delete Transaction From Register
					[ ] DeleteTransaction(sMDIWindow , lsTransactionData[5])
					[ ] 
					[ ] sleep(SHORT_SLEEP)
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
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not created")
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //############# TC271_278_279_283__Verify_401K_Register_Account_Actions_Content #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC271_278_279_283__Verify_401K_Register_Account_Actions_Content()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the following testcases
		[ ] // 1. Register Account Actions for 401 K account
		[ ] // 2. Investing activity report
		[ ] // 3.Register Preferences
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If register account actions verification is successful						
		[ ] //						Fail			If register account actions verification is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes                10th May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC271_278_279_283__Verify_401K_Register_Account_Actions_Content() appstate none //none  
	[-] //Variable Declaration
		[ ] STRING sStatementEndingDate =ModifyDate(-5,"m/d/yyyy")
		[ ] LIST OF ANYTYPE lsAddAccount={"401(k) or 403(b)","401K Account","NewEmployer",sStatementEndingDate,"YHOO",10}
	[ ] 
	[ ] 
	[ ] iCreateDataFile=DataFileCreate(sFileName)
	[-] if(iCreateDataFile==PASS)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult=AddManual401KAccount( lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],lsAddAccount[4],lsAddAccount[5],lsAddAccount[6])
		[-] if(iResult==PASS)
			[ ] ReportStatus("Add 401K account in Quicken",PASS,"401K account successfully added to Quicken")
			[ ] 
			[ ] iSwitchState = UsePopupRegister("OFF")			// Turning Off pop up register mode
			[-] if (iSwitchState==PASS)
				[ ] ReportStatus("Verify Pop Up Register", PASS, "Turn on Pop up register mode")
				[ ] 
				[ ] //Select the 401k account
				[ ] iSelect = SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
				[-] if (iSelect==PASS)
					[ ] ReportStatus("Verify {lsAddAccount[1]} Account", PASS, "{lsAddAccount[1]} account open successfully")
					[ ] 
					[ ] 
					[ ] 
					[-] ///##########Verifying Acount Actions> Set Up Online#####////
						[ ] 
						[ ] sValidationText="Activate One Step Update"
						[ ] NavigateToAccountActionInvesting(2,sMDIWindow)
						[ ] 
						[+] if (DlgActivateOneStepUpdate.Exists(4))
							[ ] DlgActivateOneStepUpdate.SetActive()
							[ ] sActual=DlgActivateOneStepUpdate.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Account Actions", PASS, "Verify Account Actions> Set Up Online:Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Account Actions", FAIL, "Verify Account Actions> Set Up Online:Dialog  {sValidationText} didn't display.")
							[ ] DlgActivateOneStepUpdate.Cancel.Click()
							[ ] WaitForState(DlgActivateOneStepUpdate,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Dialog Activate One Step Update", FAIL, "Verify Dialog Activate One Step Update:  One Step Update Dialog didn't appear.")
					[ ] 
					[ ] 
					[-] ///##########Verifying Acount Actions> Update 401K Holdings#####////
						[ ] 
						[ ] 
						[ ] sValidationText="Update 401(k)/403(b) Account: {lsAddAccount[2]}"
						[ ] NavigateToAccountActionInvesting(3,sMDIWindow)
						[+] if (DlgUpdate401KAccountHoldings.Exists(4))
							[ ] DlgUpdate401KAccountHoldings.SetActive()
							[ ] sActual=DlgUpdate401KAccountHoldings.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Account Actions", PASS, "Verify Account Actions> Update 401K Holdings:Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Account Actions", FAIL, "Verify Account Actions> Update 401K Holdings:Dialog  {sValidationText} didn't display.")
							[ ] DlgUpdate401KAccountHoldings.Cancel.Click()
							[ ] WaitForState(DlgUpdate401KAccountHoldings,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Dialog  Update 401K Holdings", FAIL, "Verify Dialog:  Update 401K Holdings Dialog didn't appear.")
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Update 401K Quotes#####////
						[ ] 
						[ ] sValidationText="Quicken Update Status"
						[ ] NavigateToAccountActionInvesting(4,sMDIWindow)
						[ ] 
						[+] if (QuickenUpdateStatus.Exists(4))
							[ ] QuickenUpdateStatus.SetActive()
							[ ] sActual=QuickenUpdateStatus.GetProperty("Caption")
							[ ] 
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Account Actions", PASS, "Verify Account Actions> Update 401K Quotes:Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Account Actions", FAIL, "Verify Account Actions> Update 401K Quotes:Dialog  {sValidationText} didn't display.")
								[ ] 
							[ ] // QuickenUpdateStatus.StopUpdate.Click()
							[ ] WaitForState(QuickenUpdateStatus,FALSE,20)
							[ ] sleep(10)
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Dialog  Update 401K Quotes", FAIL, "Verify Dialog:  Update 401K Quotes Dialog didn't appear.")
					[ ] 
					[ ] 
					[-] ///##########Verifying Acount Actions> Edit Account Details#####////  
						[ ] 
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Account Details"
						[ ] NavigateToAccountActionInvesting(5,sMDIWindow)
						[+] if (AccountDetails.Exists(4))
							[ ] AccountDetails.SetActive()
							[ ] sActual=AccountDetails.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Edit Account Details", PASS, "Verify Account Actions> Edit Account Details option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Edit Account Details", FAIL, "Verify Account Actions>Edit Account Details option: Dialog {sValidationText} didn't display.")
							[ ] AccountDetails.Cancel.Click()
							[ ] WaitForState(AccountDetails,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify  Edit Account Details", FAIL, "Verify Dialog Edit Account Details:  One Step Update Dialog didn't appear.")
					[ ] 
					[ ] 
					[-] ///##########Verifying Acount Actions> EnterTransaction #####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Buy - Shares Bought"
						[ ] NavigateToAccountActionInvesting(6,sMDIWindow)
						[+] if (wEnterTransaction.Exists(4))
							[ ] wEnterTransaction.SetActive()
							[ ] sActual=wEnterTransaction.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Enter Transaction", PASS, "Verify Account Actions> Enter Transaction option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Enter Transaction", FAIL, "Verify Account Actions>Enter Transaction option: Dialog {sValidationText} didn't display.")
							[ ] wEnterTransaction.Cancel.Click()
							[ ] WaitForState(wEnterTransaction,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify  Enter Transaction ", FAIL, "Verify Dialog Enter Transaction :  Enter Transaction Dialog didn't appear.")
					[ ] 
					[ ] 
					[-] ///##########Verifying Acount Actions> Reconcile Details#####////  
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Reconcile: {lsAddAccount[2]}"
						[ ] NavigateToAccountActionInvesting(7,sMDIWindow)
						[+] if (DlgReconcileDetails.Exists(4))
							[ ] DlgReconcileDetails.SetActive()
							[ ] sActual=DlgReconcileDetails.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Reconcile Details", PASS, "Verify Account Actions> Reconcile Details option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("VerifyReconcile Details", FAIL, "Verify Account Actions> Reconcile Details option: Dialog {sValidationText} didn't display.")
							[ ] DlgReconcileDetails.Cancel.Click()
							[ ] WaitForState(DlgReconcileDetails,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Reconcile Details", FAIL, "Verify Dialog Reconcile Details: Reconcile Details Dialog didn't appear.")
						[ ] 
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Update Cash Balance #####////  
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] 
						[ ] sValidationText="Update Cash Balance"
						[ ] NavigateToAccountActionInvesting(8,sMDIWindow)
						[+] if (UpdateCashBalance.Exists(4))
							[ ] UpdateCashBalance.SetActive()
							[ ] sActual=UpdateCashBalance.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Update Cash Balance", PASS, "Verify Account Actions> Update Cash Balance option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Update Cash Balance", FAIL, "Verify Account Actions> Update Cash Balance option: Dialog {sValidationText} didn't display.")
							[ ] UpdateCashBalance.Cancel.Click()
							[ ] WaitForState(UpdateCashBalance,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Update Cash Balance", FAIL, "Verify Dialog Update Cash Balance :Update Cash Balance Dialog didn't appear.")
						[ ] 
					[ ] 
					[ ] 
					[-] // /##########Verifying Acount Actions> Update Share Balance #####////  
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] 
						[ ] sValidationText="Adjust Share Balance"
						[ ] NavigateToAccountActionInvesting(9,sMDIWindow)
						[ ] 
						[+] if (AdjustShareBalance.Exists(4))
							[ ] AdjustShareBalance.SetActive()
							[ ] sActual=AdjustShareBalance.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Adjust Share Balance", PASS, "Verify Account Actions> Adjust Share Balance option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Adjust Share Balance", FAIL, "Verify Account Actions> Adjust Share Balance option: Dialog {sValidationText} didn't display.")
							[ ] AdjustShareBalance.Cancel.Click()
							[ ] WaitForState(AdjustShareBalance,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Adjust Share Balance", FAIL, "Verify Dialog Adjust Share Balance: Adjust Share Balance Dialog didn't appear.")
						[ ] 
					[ ] 
					[ ] 
					[-] // /##########Verifying Acount Actions> Security List #####////  
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] 
						[ ] sValidationText="Security List"
						[ ] NavigateToAccountActionInvesting(10,sMDIWindow)
						[+] if (SecurityList.Exists(4))
							[ ] SecurityList.SetActive()
							[ ] sActual=SecurityList.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Adjust Share Balance", PASS, "Verify Account Actions> Adjust Share Balance option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Adjust Share Balance", FAIL, "Verify Account Actions> Adjust Share Balance option: Dialog {sValidationText} didn't display.")
							[ ] SecurityList.Close()
							[ ] WaitForState(SecurityList,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Security List", FAIL, "Verify Dialog Security List : Security List Dialog didn't appear.")
						[ ] 
					[ ] 
					[ ] 
					[-] ///##########Verifying Acount Actions> Account Attachments #####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Account Attachments: {lsAddAccount[2]}"
						[ ] NavigateToAccountActionInvesting(12,sMDIWindow)
						[+] if (DlgAccountAttachments.Exists(4))
							[ ] DlgAccountAttachments.SetActive()
							[ ] sActual=DlgAccountAttachments.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Account Attachments", PASS, "Verify Account Actions> Account Attachments option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Account Attachments", FAIL, "Verify Account Actions> Account Attachments option: Dialog {sValidationText} didn't display.")
							[ ] DlgAccountAttachments.DoneButton.Click()
							[ ] WaitForState(DlgAccountAttachments,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Account Attachments ", FAIL, "Verify Dialog Account Attachments : Account Attachments Dialog didn't appear.")
					[ ] 
					[ ] 
					[-] ///##########Verifying Acount Actions> Account Overview #####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Account Overview: {lsAddAccount[2]}"
						[ ] NavigateToAccountActionInvesting(13,sMDIWindow)
						[-] if (DlgAccountOverview.Exists(4))
							[ ] DlgAccountOverview.SetActive()
							[ ] sActual=DlgAccountOverview.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Account Overview", PASS, "Verify Account Actions> Account Overview option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Account Overview", FAIL, "Verify Account Actions> Account Overview option: Dialog {sValidationText} didn't display.")
							[ ] DlgAccountOverview.TypeKeys(KEY_EXIT)
							[ ] WaitForState(DlgAccountOverview,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Account Overview ", FAIL, "Verify Dialog Account Overview : Account Overview Dialog didn't appear.")
					[ ] 
					[ ] 
					[-] ///##########Verifying Acount Actions> Investing Activity #####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Investing Activity"
						[ ] NavigateToAccountActionInvesting(14 , sMDIWindow)
						[+] if (InvestingActivity.Exists(4))
							[ ] InvestingActivity.SetActive()
							[ ] sActual=InvestingActivity.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Investing Activity", PASS, "Verify Account Actions> Investing Activity option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Investing Activity", FAIL, "Verify Account Actions> Investing Activity option: Dialog {sValidationText} didn't display.")
							[ ] InvestingActivity.Close()
							[ ] WaitForState(InvestingActivity,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Investing Activity ", FAIL, "Verify Investing Activity: Investing Activity didn't appear.")
						[ ] 
					[ ] 
					[ ] 
					[-] ///##########Verifying Acount Actions> Print Transactions#####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Print Register"
						[ ] NavigateToAccountActionInvesting(15 , sMDIWindow)
						[+] if (PrintRegister.Exists(4))
							[ ] PrintRegister.SetActive()
							[ ] sActual=PrintRegister.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Print Transactions", PASS, "Verify Account Actions> Print Transactions option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Print Transactions", FAIL, "Verify Account Actions> Print Transactions option: Dialog {sValidationText} didn't display.")
							[ ] PrintRegister.CancelButton.Click()
							[ ] WaitForState(PrintRegister,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Print Register", FAIL, "Verify Dialog Print Register : Print RegisterDialog didn't appear.")
					[ ] 
					[ ] 
					[-] ///##########Verifying Acount Actions> Register preferences#####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Preferences"
						[ ] NavigateToAccountActionInvesting(17 , sMDIWindow)
						[+] if (Preferences.Exists(4))
							[ ] Preferences.SetActive()
							[ ] sActual=Preferences.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Register preferences", PASS, "Verify Account Actions>Register preferences option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Register preferences", FAIL, "Verify Account Actions>Register preferences option: Dialog {sValidationText} didn't display.")
							[ ] Preferences.Cancel.Click()
							[ ] WaitForState(Preferences,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Preferences", FAIL, "Verify Dialog Preferences : Preferences Dialog didn't appear.")
					[ ] 
					[ ] 
					[-] ///##########Verifying Acount Actions> Customize Action Bar#####////  
						[ ] 
						[ ] 
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Customize Action Bar"
						[ ] NavigateToAccountActionInvesting(18 , sMDIWindow)
						[-] if (DlgCustomizeActionBar.Exists(3))
							[ ] DlgCustomizeActionBar.SetActive()
							[ ] sActual=DlgCustomizeActionBar.GetProperty("Caption")
							[-] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Customize Action Bar", PASS, "Verify Account Actions>Customize Action Bar option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Account Actions>Customize Action Bar option: Dialog {sValidationText} didn't display.")
							[ ] DlgCustomizeActionBar.DoneButton.Click()
							[ ] WaitForState(DlgCustomizeActionBar,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Dialog Customize Action Bar :  Customize Action Bar Dialog didn't appear.")
					[ ] 
					[ ] 
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} account coudln't open.")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Pop Up Register", FAIL, "Pop up register mode didn't get enable.")
		[-] else
			[ ] ReportStatus("Add 401K account in Quicken",FAIL,"401K account successfully added to Quicken")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File ", FAIL, "Error during data file creation.") 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //############# Test282_Buttons_Present_In_401K_Register_ #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test282_Buttons_Present_In_401K_Register_()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify buttons present in register
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If buttons are present
		[ ] //						Fail			If buttons are missing
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Dean Paes                             May 10th, 2013		
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test282_Buttons_Present_In_401K_Register_() appstate none 
	[ ] 
	[ ] //Variable Declaration
	[ ] LIST OF STRING lsInvestingRegisterButton={"Enter","Edit","Delete","Attach"}
	[ ] LIST OF ANYTYPE lsAddAccount
	[ ] STRING sHandle,sActual
	[ ] STRING sStatementEndingDate =ModifyDate(-5,"m/d/yyyy")
	[ ] lsAddAccount={"401(k) or 403(b)","401K Account","NewEmployer",sStatementEndingDate,"YHOO",10}
	[ ] 
	[ ] 
	[-] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] //Get Handle of 401K register
			[ ] sHandle=Str(BrokerageAccount.ListBox1.GetHandle())
			[ ] 
			[ ] //Search the register rows for text of buttons using Qwauto
			[+] for(i=0;i<=40;i++)
				[ ] 
				[ ] sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
				[ ] bMatch=MatchStr("*{lsInvestingRegisterButton[1]}*{lsInvestingRegisterButton[2]}*{lsInvestingRegisterButton[3]}*{lsInvestingRegisterButton[4]}*",sActual)    //          lsInvestingRegisterButton[2]*lsInvestingRegisterButton[3]*lsInvestingRegisterButton[4]}*",)
				[+] if(bMatch)
					[ ] break
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify Investing reigster buttons",PASS,"{sActual} buttons are present in reigster as expected :{lsInvestingRegisterButton}")
				[ ] // bMatch=MatchStr("*{lsInvestingRegisterButton[2]}*",sActual)  
				[+] // if(bMatch==TRUE)
					[ ] // ReportStatus("Verify Investing reigster buttons",PASS,"{lsInvestingRegisterButton[2]} button is present in reigster")
					[ ] // bMatch=MatchStr("*{lsInvestingRegisterButton[3]}*",sActual)  
					[+] // if(bMatch==TRUE)
						[ ] // ReportStatus("Verify Investing reigster buttons",PASS,"{lsInvestingRegisterButton[3]} button is present in reigster")
						[ ] // bMatch=MatchStr("*{lsInvestingRegisterButton[4]}*",sActual)  
						[+] // if(bMatch==TRUE)
							[ ] // ReportStatus("Verify Investing reigster buttons",PASS,"{lsInvestingRegisterButton[4]} button is present in reigster")
							[ ] // break
						[+] // else
							[ ] // bMatch=FALSE
							[ ] // goto END 
						[ ] // 
						[ ] // 
						[ ] // 
					[+] // else
						[ ] // bMatch=FALSE
						[ ] // goto END
					[ ] // 
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // bMatch=FALSE
					[ ] // goto END
					[ ] // 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Investing reigster buttons",FAIL,"{sActual} buttons are NOT present in reigster as expected :{lsInvestingRegisterButton}")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Select Account from account bar",FAIL,"Account not selected")
			[ ] 
	[+] else
		[ ] ReportStatus("Quicken Exists",FAIL,"Quicken Main Window not found")
		[ ] 
		[ ] 
[ ] 
[ ] 
[ ]  
[+] //############# TC272_Verify_401K_Register_Enter_Transactions #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC272_Verify_401K_Register_Enter_Transactions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Account Actions menu - Enter Transactions
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If transaction entry is successful						
		[ ] //						Fail			If any error occurs	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes               9th May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC272_Verify_401K_Register_Enter_Transactions() appstate none  
	[-] //Variable Declaration
		[ ] 
		[ ] INTEGER iValidate
		[ ] STRING sNumberOfShares="5"
		[ ] STRING sPricePaid="12.00"
		[ ] 
		[ ] 
		[ ] STRING sStatementEndingDate =ModifyDate(-5,"m/d/yyyy")
		[ ] LIST OF ANYTYPE lsAddAccount={"401(k) or 403(b)","401K Account","NewEmployer",sStatementEndingDate,"Google Inc",10}
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[-] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iSwitchState = UsePopupRegister("OFF")			// Turning Off pop up register mode
		[-] if (iSwitchState==PASS)
			[ ] ReportStatus("Verify Pop Up Register", PASS, "Turn on Pop up register mode")
			[ ] 
			[ ] //Select the 401k account
			[ ] iSelect =AccountBarSelect(ACCOUNT_INVESTING,1)
			[-] if (iSelect==PASS)
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account", PASS, "{lsAddAccount[2]} account open successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] sValidationText=NULL
				[ ] sActual=NULL
				[ ] sValidationText="Buy - Shares Bought"
				[ ] NavigateToAccountActionInvesting(6,sMDIWindow)
				[+] if (wEnterTransaction.Exists(5))
					[ ] wEnterTransaction.SetActive()
					[ ] sActual=wEnterTransaction.GetProperty("Caption")
					[+] if (sActual==sValidationText)
						[ ] ReportStatus("Verify Enter Transaction", PASS, "Verify Account Actions> Enter Transaction option: Dialog {sActual} displayed as expected {sValidationText}.")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] //----------------Enter Transaction Details------------------
						[ ] wEnterTransaction.SecurityName.SetText(lsAddAccount[5])
						[ ] wEnterTransaction.NumberOfShares.SetText(sNumberOfShares)
						[ ] wEnterTransaction.PricePaid.SetText(sPricePaid)
						[ ] wEnterTransaction.EnterDone.Click()
						[+] if(AddSecurityToQuicken2.Exists(120))
							[ ] AddSecurityToQuicken2.SetActive()
							[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
								[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
								[ ] 
							[ ] 
							[ ] sleep(SHORT_SLEEP)
							[ ] 
							[ ] AddSecurityToQuicken2.NextButton.Click()
							[ ] 
							[ ] sleep(SHORT_SLEEP)
							[ ] 
							[+] if (AddSecurityToQuicken.AddManually.Exists(10))
								[ ] AddSecurityToQuicken.AddManually.Select(2)
								[ ] AddSecurityToQuicken.Next.Click()
								[ ] sleep(10)
							[ ] 
							[ ] AddSecurityToQuicken.Done.DoubleClick()
							[ ] 
						[ ] WaitForState(wEnterTransaction,FALSE,20)
						[ ] 
						[ ] 
						[ ] //-----------Find Transaction in Register----------------------------
						[ ] QuickenWindow.TypeKeys("<Ctrl-f>") 
						[ ] QuickenFind.QuickenFind.SetText(lsAddAccount[5])
						[ ] QuickenFind.Find.Click()
						[+] if(AlertMessage.Exists(4))
							[ ] AlertMessage.Yes.Click()
							[ ] 
						[+] if(!AlertMessage.Exists(4))
							[ ] ReportStatus("Verify Transaction Added to Register",PASS,"Transaction Added to Register")
						[+] else
							[ ] ReportStatus("Verify Transaction Added to Register",FAIL,"Transaction not  Added to Register")
						[+] if(AlertMessage.Exists(4))
							[ ] AlertMessage.Yes.Click()
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] QuickenFind.SetActive()
						[ ] QuickenFind.Close()
						[ ] 
					[ ] 
					[ ] 
					[+] else
						[ ] ReportStatus("Verify Enter Transaction", FAIL, "Verify Account Actions>Enter Transaction option: Dialog {sValidationText} didn't display.")
				[+] else
					[ ] ReportStatus("Verify  Enter Transaction ", FAIL, "Verify Dialog Enter Transaction :  Enter Transaction Dialog didn't appear.")
					[ ] 
					[ ] 
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify {lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} account did not open")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Pop Up Register", FAIL, "Pop up register mode didn't get enable.")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] ///Mukesh//
[ ] 
[+] //#############TC 276-Account Actions menu - Update 401 K Holdings#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC276_AccountActionsMenuUpdate401KHoldings()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify cofiguring a manual 401k account for Setup download
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of cofiguring a manual 401k account for Setup download is successful				
		[ ] //						Fail			If verification of cofiguring a manual 401k account for Setup downloadis unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh              20th May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC276_AccountActionsMenuUpdate401KHoldings() appstate none 
	[+] //Variable Declaration
		[ ] 
		[ ] STRING sStatementEndingDate ,sHoldingsEndDate
		[ ] STRING sEmployeeContribution ,sEmployerContribution , sStateTax ,sFederalTax ,sExpReportTitle 
		[ ] INTEGER iSharesCount , iReportSelect
		[ ] LIST OF ANYTYPE lsReportData
		[ ] sStatementEndingDate =ModifyDate(-120,"m/d/yyyy")
		[ ] sHoldingsEndDate =ModifyDate(-1,"m/d/yyyy")
		[ ] ///Fetch sBrokerageAccountSheet 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sBrokerageAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] iSharesCount= Val(lsAddAccount[6])
		[ ] sAccountType=lsAddAccount[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] ///Fetch sAccountHoldingsDataSheet 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountHoldingsDataSheet)
		[ ] 
		[ ] 
		[ ] sEmployeeContribution=lsExcelData[1][2]
		[ ] sEmployerContribution=lsExcelData[2][2]
		[ ] sFederalTax=lsExcelData[3][2]
		[ ] sStateTax=lsExcelData[4][2]
		[ ] 
	[ ] 
	[ ] iCreateDataFile=DataFileCreate(sRegFileName)
	[+] if(iCreateDataFile==PASS)
		[ ] 
		[+] // if (QuickenWindow.Exists())
			[ ] // QuickenWindow.Kill()
			[ ] // WaitForState(QuickenWindow , False ,5)
			[+] // if (!QuickenWindow.Exists())
				[ ] // App_Start (sCmdLine)
				[ ] // sleep(10)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] ///Add a 401K account///
		[ ] iAddAccount=AddManual401KAccount( sAccountType , sAccountName ,lsAddAccount[3],sStatementEndingDate, lsAddAccount[5], iSharesCount)
		[+] if(iAddAccount==PASS)
			[ ] ReportStatus("Add {sAccountType} account in Quicken",PASS,"{sAccountName} account of {sAccountType} added to Quicken")
			[ ] 
			[ ] iSwitchState = UsePopupRegister("OFF")			// Turning Off pop up register mode
			[+] if (iSwitchState==PASS)
				[ ] 
				[ ] //Select the 401k account
				[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
				[+] if (iSelect==PASS)
					[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
					[ ] 
					[ ] 
					[+] ///##########Verifying Acount Actions> Update401KHoldings#####////
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] NavigateToAccountActionInvesting(3 , sMDIWindow)
						[+] if (DlgUpdate401KAccountHoldings.Exists(3))
							[ ] ReportStatus("Verify Account Actions for {sAccountName}", PASS, "Verify Account Actions> Update 401K Holdings for {sAccountName}:Update 401K Holdings for {sAccountName} displayed.")
							[ ] DlgUpdate401KAccountHoldings.SetActive()
							[ ] DlgUpdate401KAccountHoldings.ThisStatementEndsTextField.SetText(sHoldingsEndDate)
							[ ] DlgUpdate401KAccountHoldings.Next.Click()
							[ ] DlgUpdate401KAccountHoldings.EmployeeContributionsTextField.SetText(sEmployeeContribution)
							[ ] DlgUpdate401KAccountHoldings.EmployerMatchingContributionTextField.SetText(sEmployerContribution)
							[ ] DlgUpdate401KAccountHoldings.Next.Click()
							[ ] DlgUpdate401KAccountHoldings.StateTaxWithheldTextField.SetText(sStateTax)
							[ ] DlgUpdate401KAccountHoldings.FederalTaxWithheldTextField.SetText(sFederalTax)
							[ ] DlgUpdate401KAccountHoldings.Next.Click()
							[+] for ( iCount=0;iCount< 3;++iCount)
								[ ] DlgUpdate401KAccountHoldings.SetActive()
								[ ] DlgUpdate401KAccountHoldings.Next.Click()
							[+] if (AlertMessage.Exists(2))
								[ ] AlertMessage.SetActive()
								[ ] AlertMessage.Yes.Click()
								[ ] WaitForState(AlertMessage,False,1)
								[ ] 
							[ ] DlgUpdate401KAccountHoldings.Done.Click()
							[ ] WaitForState(DlgUpdate401KAccountHoldings,False,1)
							[+] ///Verify Update 401K holdings data in register ///
								[ ] //Listcount is commented as the listcount is calculated by incorrectly by silktest it just takes count as 12//
								[ ] //hence count is hardcoded to retrieve the reult till desired rows///
								[ ] 
								[ ] sHandle=Str(BrokerageAccount.ListBox1.GetHandle())
								[ ] // iListCount=MDIClient.AccountRegister.InvestingAccountRegister.AccountRegisterChild.QWListViewer.ListBox.GetItemCount()+1
								[+] for( iCounter=0;iCounter< 20 ;++iCounter)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, " {iCounter}")
									[ ] ListAppend(lsListBoxItems,sActual)
								[ ] 
								[+] for ( iCount=1;iCount< ListCount(lsExcelData) + 1 ; ++iCount)
									[ ] lsTransaction=lsExcelData[iCount]
									[+] if (lsTransaction[1]==NULL)
										[ ] break
									[+] for( iCounter=1;iCounter< ListCount(lsListBoxItems) + 1 ;++iCounter)
										[+] if (lsTransaction[1]==sAccountName)
											[ ] bMatch = MatchStr("*{sHoldingsEndDate}*{lsTransaction[3]}*{lsTransaction[2]}*", lsListBoxItems[iCounter])
										[+] else
											[ ] bMatch = MatchStr("*{sHoldingsEndDate}*{lsTransaction[3]}*{lsTransaction[1]}*{lsTransaction[2]}*", lsListBoxItems[iCounter])
										[+] if ( bMatch == TRUE)
											[ ] break
									[+] if (bMatch)
										[ ] ReportStatus("Verify updated holdings data",PASS,"Verify updated holdings data in {sAccountName}: Updated holdings data is: {lsListBoxItems[iCounter]} as expected {lsTransaction} in {sAccountName}.")
									[+] else
										[ ] ReportStatus("Verify updated holdings data",FAIL,"Verify updated holdings data in {sAccountName}: Updated holdings data is not as expected {lsTransaction} in {sAccountName}.")
									[ ] 
							[+] ///Verify Update 401K holdings data in Investment Income report ///
								[ ] //Listcount is commented as the listcount is calculated by incorrectly by silktest it just takes count as 12//
								[ ] //hence count is hardcoded to retrieve the reult till desired rows///
								[ ] // Open Tax Schedule Report
								[ ] 
								[ ] sExpReportTitle="Investment Transactions"
								[ ] iReportSelect = OpenReport(lsReportCategory[3], sREPORT_INVESTMENT_TRANSACTION)	
								[+] if (iReportSelect==PASS)
									[ ] ReportStatus("Run {sREPORT_INVESTMENT_TRANSACTION} Report", iReportSelect, "Run Report successful") 
									[ ] // Verify sREPORT_INVESTMENT_TRANSACTION is Opened
									[+] if (InvestmentTransactions.Exists(3))
										[ ] 
										[ ] // Set Actives sREPORT_INVESTMENT_TRANSACTION  
										[ ] InvestmentTransactions.SetActive()
										[ ] 
										[ ] // Maximize sREPORT_INVESTMENT_TRANSACTION 
										[ ] InvestmentTransactions.Maximize()
										[ ] 
										[ ] // Get window caption
										[ ] sActual = InvestmentTransactions.GetCaption()
										[ ] 
										[ ] // Verify window title
										[ ] bMatch = MatchStr("*{sExpReportTitle}*", sActual)
										[ ] 
										[ ] // Report Status if window title is as expected
										[+] if (bMatch == TRUE)
											[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
											[ ] //  Validate Report Data
											[ ] sHandle=NULL
											[ ] sHandle = Str(InvestmentTransactions.QWListViewer1.ListBox1.GetHandle ())
											[ ] // //############## Verifying transactions on Reports> Investing> Investment Transaction############
											[ ] sActual=NULL
											[ ] iListCount=InvestmentTransactions.QWListViewer1.ListBox1.GetItemCount() +1
											[+] for( iCounter=0;iCounter< iListCount ;++iCounter)
												[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  "{iCounter}")
												[ ] ListAppend (lsReportData , sActual)
											[ ] 
											[+] for ( iCount=1;iCount< ListCount(lsExcelData) + 1 ; ++iCount)
												[ ] lsTransaction=lsExcelData[iCount]
												[+] if (lsTransaction[1]==NULL)
													[ ] break
												[+] for( iCounter=1;iCounter< ListCount(lsReportData) + 1 ;++iCounter)
													[ ] bMatch = MatchStr("*{sHoldingsEndDate}*{sAccountName}*{lsTransaction[1]}*{lsTransaction[2]}*", lsReportData[iCounter])
													[+] if ( bMatch == TRUE)
														[ ] break
												[+] if (bMatch)
													[ ] ReportStatus("Verify updated holdings data",PASS,"Verify updated holdings data in {sAccountName}: Updated holdings data is: {lsReportData[iCounter]} as expected {lsTransaction} for  {sAccountName}.")
												[+] else
													[ ] ReportStatus("Verify updated holdings data",FAIL,"Verify updated holdings data in {sAccountName}: Updated holdings data is not as expected {lsTransaction} for {sAccountName}.")
												[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is incorrect") 
										[ ] InvestmentTransactions.TypeKeys(KEY_EXIT)
										[ ] WaitForState(InvestmentTransactions,FALSE,1)
										[ ] /////#######Report validation done#######///
									[+] else
										[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Report does not exist.") 
								[+] else
									[ ] ReportStatus("Run {sTAB_SHEDULE_E_REPORT} Report", iReportSelect, "Run Report unsuccessful.") 
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Account Actions for {sAccountName}", FAIL, "Verify Account Actions> Update 401K Holdings for {sAccountName}:Update 401K Holdings for {sAccountName} didn't display.")
							[ ] 
						[ ] 
					[ ] 
				[+] else
						[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Pop Up Register is OFF.", FAIL, "Pop up register mode couldn't be disabled.")
		[+] else
			[ ] ReportStatus("Add {sAccountType} account in Quicken",FAIL,"{sAccountName} account of {sAccountType} couldn't be added to Quicken")
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File ", FAIL, "Error during data file creation.") 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //#############TC 275-Account Actions menu - Setup Download#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC275_AccountActionsMenuSetupDownload()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify cofiguring a manual 401k account for Setup download
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of cofiguring a manual 401k account for Setup download is successful				
		[ ] //						Fail			If verification of cofiguring a manual 401k account for Setup downloadis unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh              20th May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC275_AccountActionsMenuSetupDownload() appstate none //QuickenBaseState 
	[+] //Variable Declaration
		[ ] 
		[ ] STRING  sBankName ,sAccountID ,sPassword , sAccountNumber ,sYear ,sDay,sMonth
		[ ] INTEGER iSharesCount ,iSelectDate ,iYear
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sBrokerageAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sTRowPriceTxnsSheet)
		[ ] 
		[ ] iSharesCount= Val(lsAddAccount[6])
		[ ] sAccountType=lsAddAccount[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] sBankName="T. Rowe Price"
		[ ] sAccountID="quickenqa"
		[ ] sPassword="Zags2010"
		[ ] sAccountNumber="0540120459"
		[ ] //date
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") 
		[ ] sDay=FormatDateTime(GetDateTime(), "d")
		[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[+] if(val(sMonth)==1)
			[ ] iSelectDate=12
			[ ] iYear=val(sYear)-1
			[ ] sYear =Str(iYear)
		[+] else
			[ ] iSelectDate=val(sMonth)-1
		[ ] //Get current year
		[ ] sDate="{iSelectDate}" +"/"+sDay+"/"+sYear
		[ ] 
		[ ] 
	[+] if (QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Select the 401k account
		[ ] iResult = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[+] if (iResult==PASS)
			[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
			[ ] 
			[ ] iResult=NavigateToAccountDetails(sAccountName)
			[+] if (iResult==PASS)
				[ ] AccountDetails.SetActive()
				[ ] AccountDetails.InvestingAccountNumber.SetText(sAccountNumber)
				[ ] AccountDetails.OK.Click()
				[ ] WaitForState(AccountDetails , FALSE , 5)
				[ ] 
				[ ] ///##########Verifying Acount Actions> Set Up Download#####////
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] iResult =NavigateToAccountActionInvesting(2 , sMDIWindow)
				[+] if (iResult==PASS)
					[ ] iResult=SetUpDownload(sBankName, sAccountID ,sPassword)
					[+] if (iResult==PASS)
						[ ] ReportStatus("Verify Account {sAccountName} has been setup as an online account." , PASS , " Account {sAccountName} has been setup as an online account." )
						[ ] ///After converting to online account transactions do get downloaded into C2R//
						[ ] sleep(5)
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.AccountRegister.DownloadedTransactionsTab.Click()
						[ ] sleep(2)
						[+] if (AcceptAll.IsEnabled())
							[ ] AcceptAll.Click()
							[+] if (AlertMessage.Exists(3))
								[ ] AlertMessage.OK.Click()
								[ ] WaitForState(AlertMessage,False,2)
								[ ] 
							[+] if (DlgAdjustHoldingsAmount.Exists(20))
								[ ] DlgAdjustHoldingsAmount.SetActive()
								[ ] DlgAdjustHoldingsAmount.AcceptButton.Click()
								[ ] WaitForState(DlgAdjustHoldingsAmount,False,2)
							[ ] 
							[+] if (DlgSecuritiesComparisonMismatch.Exists(20))
								[ ] DlgSecuritiesComparisonMismatch.SetActive()
								[ ] DlgSecuritiesComparisonMismatch.DoneButton.Click()
								[ ] WaitForState(DlgSecuritiesComparisonMismatch,False,2)
							[+] if (DlgSecuritiesComparisonMismatch.Exists(20))
								[ ] DlgSecuritiesComparisonMismatch.SetActive()
								[ ] DlgSecuritiesComparisonMismatch.AcceptButton.Click()
								[ ] WaitForState(DlgSecuritiesComparisonMismatch,False,2)
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] sHandle=Str(BrokerageAccount.ListBox1.GetHandle())
						[ ] iListCount=BrokerageAccount.ListBox1.GetItemCount()+1
						[ ] iResult=NavigateToAccountDetails(sAccountName)
						[+] if (iResult==PASS)
							[ ] AccountDetails.SetActive()
							[ ] AccountDetails.TextClick("Online Services")
							[+] if (AccountDetails.Deactivate.Exists())
								[ ] ReportStatus("Verify Account {sAccountName} has been setup as an online account." , PASS , " Account {sAccountName} has been setup as an online account as Deactivate button is available on Account deatails>Online Services tab." )
								[ ] AccountDetails.OK.Click()
								[ ] WaitForState(AccountDetails , FALSE , 5)
							[+] else
								[ ] ReportStatus("Verify Account {sAccountName} has been setup as an online account." , FAIL , " Account {sAccountName} couldn't be setup as an online account as Deactivate button is NOT available on Account deatails>Online Services tab." )
						[+] else
							[ ] ReportStatus("Validate Account Details window", FAIL, "Account Details window is not opened")
						[+] // for ( iCount=1;iCount< ListCount(lsExcelData) +1;++iCount)
							[ ] // lsTransaction=lsExcelData[iCount]
							[+] // if (lsTransaction[1]==NULL)
								[ ] // break
							[+] // for( iCounter=0;iCounter< iListCount ;++iCounter)
								[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, " {iCounter}")
								[ ] // bMatch = MatchStr("*{lsTransaction[1]}*{lsTransaction[2]}*{lsTransaction[5]}*", sActual)
								[+] // if ( bMatch == TRUE)
									[ ] // break
							[+] // if (bMatch)
								[ ] // ReportStatus("Verify downloaded transactions",PASS,"Verify downloaded transactions in {lsAddAccount[2]}: Transactions downloaded {sActual} as expected {lsTransaction}.")
							[+] // else
								[ ] // ReportStatus("Verify downloaded transactions",FAIL,"Verify downloaded transactions in {lsAddAccount[2]}: Transactions couldn't download as expected {lsTransaction}.")
							[ ] // 
					[+] else
						[ ] ReportStatus("Verify Account {sAccountName} has been setup as an online account." , FAIL , " Account {sAccountName} couldn't be setup as an online account." )
				[+] else
					[ ] ReportStatus("Verify Quicken navigated to {sAccountName} Account actions." , FAIL , "Quicken didn't navigate to {sAccountName} Account actions.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Account Details window", FAIL, "Account Details window is not opened")
		[+] else
				[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
			[ ] 
		[ ] 
		[ ] // iSwitchState = UsePopupRegister("OFF")			// Turning Off pop up register mode
		[ ] // if (iSwitchState==PASS)
		[+] // else
			[ ] // ReportStatus("Verify Pop Up Register is OFF.", FAIL, "Pop up register mode couldn't be disabled.")
			[ ] // 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] // // 
[+] //#############TC 277-Account Actions menu - Account Overview#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC277_AccountActionsMenuAccountOverview()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Account Status and Account Attributes on Account Overview 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of Account Status and Account Attributes on Account Overview is successful				
		[ ] //						Fail			If verification of cAccount Status and Account Attributes on Account Overview is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh              21st May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC277_AccountActionsMenuAccountOverview() appstate QuickenBaseState 
	[+] //Variable Declaration
		[ ] 
		[ ] STRING  sBankName ,sAccountID ,sPassword , sAccountNumber , sAttribute
		[ ] INTEGER iSharesCount
		[ ] LIST OF ANYTYPE lsAccAttributeParams , lsAccAttributeVal ,lsAccAttribute
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountAttributesSheet)
		[ ] lsAccAttributeParams=lsExcelData[1]
		[ ] lsAccAttributeVal =lsExcelData[2]
		[ ] sAccountName=lsAccAttributeVal[1]
		[ ] ///Create Account attribute  and attribute values key-value list//
		[+] for ( iCounter=1;iCounter<ListCount(lsAccAttributeParams) +1 ;++iCounter)
			[+] if (lsAccAttributeParams[iCounter]==NULL)
				[ ] break
			[+] if (lsAccAttributeVal[iCounter]==NULL)
				[ ] lsAccAttributeVal[iCounter]=""
			[ ] 
			[ ] ListAppend(lsAccAttribute , "{lsAccAttributeParams[iCounter]}@@{lsAccAttributeVal[iCounter]}")
		[ ] 
		[ ] 
	[+] if (QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] //Select the 401k account
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[+] if (iSelect==PASS)
			[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
			[ ] 
			[ ] 
			[+] ///##########Verifying Acount Actions> Account Overview#####////
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] NavigateToAccountActionInvesting(13 , sMDIWindow)
				[ ] 
				[ ] ///After converting to online account transactions do get downloaded into C2R//
				[+] if (DlgAccountOverview.Exists(3))
					[ ] DlgAccountOverview.SetActive()
					[ ] 
					[ ] 
					[ ] 
					[ ] sHandle=Str(DlgAccountOverview.ListBox3.GetHandle())
					[ ] iListCount=DlgAccountOverview.ListBox3.GetItemCount()+1
					[+] for( iCounter=0;iCounter< iListCount ;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, " {iCounter}")
						[ ] ListAppend(lsListBoxItems,sActual)
					[ ] 
					[ ] 
					[+] for each sAttribute in lsAccAttribute
						[+] for( iCounter=1;iCounter<ListCount( lsListBoxItems)+1 ;++iCounter)
							[ ] bMatch = MatchStr("*{sAttribute}*", lsListBoxItems[iCounter])
							[+] if ( bMatch == TRUE)
								[ ] break
						[+] if (bMatch)
							[ ] ReportStatus("Verify Account Overview data",PASS,"Verify Account Overview for {sAccountName}: Attribute {sActual} is as expected {sAttribute} on Account Overview for {sAccountName}.")
						[+] else
							[ ] ReportStatus("Verify Account Overview data",FAIL,"Verify Account Overview for {sAccountName}: Attribute {sActual} is not as expected {sAttribute} on Account Overview for {sAccountName}.")
							[ ] 
					[ ] DlgAccountOverview.SetActive()
					[ ] DlgAccountOverview.Close()
					[ ] WaitForState(DlgAccountOverview , false ,1)
				[+] else
					[ ] ReportStatus("Verify Account Overview dialog", FAIL, "Verify Account Overview dialog for {sAccountName} account couldn't open: Account Overview dialog for {sAccountName} couldn't open")
				[ ] 
			[ ] 
		[+] else
				[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //######################TC 287-Account Actions menu - Update Cash Balance########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC287_AccountActionsMenuUpdateCashBalance()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Update Cash Balance feature for investing account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of Update Cash Balance feature for investing account is successful				
		[ ] //						Fail			If verification of Update Cash Balance feature for investing account is unsuccessful		
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh              21st May 2013
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase TC287_AccountActionsMenuUpdateCashBalance() appstate QuickenBaseState 
	[+] //Variable Declaration
		[ ] 
		[ ] STRING sUpdateBalance ,sActualBalance
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sBrokerageAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountType=lsAddAccount[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] sUpdateBalance="200.22"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //Select the 401k account
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[+] if (iSelect==PASS)
			[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
			[ ] 
			[ ] 
			[+] ///##########Verifying Acount Actions> UpdateCashBalance#####////
				[ ] //Update Cash balance
				[ ] QuickenWindow.SetActive()
				[ ] NavigateToAccountActionInvesting(7 , sMDIWindow)
				[+] if (UpdateCashBalance.Exists(3))
					[ ] ReportStatus("Verify Account Actions for {sAccountName}", PASS, "Verify Account Actions> Update Cash Balance for {sAccountName}:Update Cash Balance for {sAccountName} displayed.")
					[ ] UpdateCashBalance.SetActive()
					[ ] UpdateCashBalance.CashBalanceTextField.SetText(sUpdateBalance)
					[ ] UpdateCashBalance.Done.Click()
					[ ] WaitForState(UpdateCashBalance,False,5)
					[ ] sleep(2)
					[ ] QuickenWindow.SetActive()
					[ ] MDIClient.BrokerageAccount.QWHtmlView.TextClick("${sUpdateBalance}")
					[ ] 
					[ ] ///Verify updated cash balance on updated cash balance dialog by launching the dialog //
					[ ] //by clicking on CashBalance link lower rirght corner of the investing register //
					[+] if (UpdateCashBalance.Exists(2))
						[ ] UpdateCashBalance.SetActive()
						[ ] sActualBalance=UpdateCashBalance.CashBalanceTextField.GetText()
						[ ] UpdateCashBalance.Done.Click()
						[ ] WaitForState(UpdateCashBalance,False,1)
						[ ] 
						[+] if (sActualBalance==sUpdateBalance)
							[ ] ReportStatus("Verify UpdateCashBalance ", PASS, "Verify CashBalance updated: Cash balance {sActualBalance} updated as expected {sUpdateBalance} for {sAccountName}.")
						[+] else
							[ ] ReportStatus("Verify UpdateCashBalance ", FAIL, "Verify CashBalance updated: Cash balance {sActualBalance} updated is not as expected {sUpdateBalance} for {sAccountName}.")
					[+] else
						[ ] ReportStatus("Verify CashBalance link", FAIL, "Verify CashBalance link: CashBalance link couldn't launch the dialog Update Cash Balance for {sAccountName}.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Account Actions for {sAccountName}", FAIL, "Verify Account Actions> Cash BalanceHoldings for {sAccountName}:Update Cash Balance for {sAccountName} didn't display.")
					[ ] 
				[ ] 
			[ ] 
		[+] else
				[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] // ######################TC 288-Account Actions menu - Update Share Balance########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC288_AccountActionsMenuUpdateShareBalance()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify Update Share Balance feature for investing account
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If verification of Update Share Balance feature for investing account is successful				
		[ ] // Fail			If verification of Update Share Balance feature for investing account is unsuccessful		
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Mukesh              21st May 2013
		[ ] // 
		[ ] // ********************************************************
		[ ] // 
	[ ] // 
[+] testcase TC288_AccountActionsMenuUpdateShareBalance() appstate QuickenBaseState 
	[+] // Variable Declaration
		[ ] 
		[ ] STRING sSecurityName , sNumberOfShares
		[ ] sDate=ModifyDate(0,"m/d/yyyy")
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sBrokerageAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountType=lsAddAccount[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] sSecurityName="Intu"
		[ ] sNumberOfShares="50"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Select the 401k account
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[+] if (iSelect==PASS)
			[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
			[ ] 
			[ ] 
			[+] // // /##########Verifying Acount Actions> Update Share Balance#####////
				[ ] // Update share balance
				[ ] QuickenWindow.SetActive()
				[ ] NavigateToAccountActionInvesting(8 , sMDIWindow)
				[+] if (AdjustShareBalance.Exists(3))
					[ ] ReportStatus("Verify Account Actions for {sAccountName}", PASS, "Verify Account Actions> Update Share Balance for {sAccountName}:Update Share Balance for {sAccountName} displayed.")
					[ ] AdjustShareBalance.SetActive()
					[ ] AdjustShareBalance.SecurityName.SetText(sSecurityName)
					[ ] AdjustShareBalance.NumberOfShares.SetText(sNumberOfShares)
					[ ] AdjustShareBalance.EnterDone.Click()
					[ ] 
					[+] if(AddSecurityToQuicken2.Exists(120))
						[ ] AddSecurityToQuicken2.SetActive()
						[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
							[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
							[ ] 
						[ ] 
						[ ] sleep(SHORT_SLEEP)
						[ ] 
						[ ] AddSecurityToQuicken2.NextButton.Click()
						[ ] 
						[ ] sleep(SHORT_SLEEP)
						[ ] 
						[ ] // This code is written to handle Connection error
						[+] if (AddSecurityToQuicken.NoDataFoundFor.Exists(MEDIUM_SLEEP) == TRUE)
							[+] if(AddSecurityToQuicken.SelectTickerSymbol.Exists(SHORT_SLEEP))
								[ ] AddSecurityToQuicken.SelectTickerSymbol.Select("Add manually")
								[ ] AddSecurityToQuicken.Next.Click()
							[ ] 
						[ ] //Click on Done
						[ ] AddSecurityToQuicken.VerifyEnabled(TRUE, 20)
						[ ] AddSecurityToQuicken.SetActive()
						[ ] AddSecurityToQuicken.Done.DoubleClick()
					[ ] //Already existing placeholder entry alert change intorduced in QW2014 R2
					[+] if(AlertMessage.Exists(5))
						[ ] AlertMessage.SetActive()
						[ ] AlertMessage.Yes.Click()
						[ ] WaitForState(AlertMessage , FALSE ,5)
					[ ] WaitForState(AdjustShareBalance,False,5)
					[ ] sleep(2)
					[ ] BrokerageAccount.PlaceholderEntriesTab.Click()
					[ ] sleep(2)
					[ ] sHandle=Str(BrokerageAccount.ListBox2.GetHandle())
					[ ] iListCount=BrokerageAccount.ListBox2.GetItemCount()+1
					[+] for( iCounter=0;iCounter< 60 ;++iCounter)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, " {iCounter}")
						[ ] bMatch = MatchStr("*{sSecurityName}*{sNumberOfShares}*", sActual)
						[+] if ( bMatch == TRUE)
							[ ] break
					[+] if (bMatch)
						[ ] ReportStatus("Verify Update Share Balance",PASS,"Verify Update Share Balance in {lsAddAccount[2]}: Verify Update Share Balance updated: {sActual} as expected: {sDate}, {sSecurityName}, {sNumberOfShares}.")
					[+] else
						[ ] ReportStatus("Verify Update Share Balance",FAIL,"Verify Update Share Balance in {lsAddAccount[2]}: Verify Update Share Balance didn't update: {sActual} as expected: {sDate}, {sSecurityName}, {sNumberOfShares}.")
						[ ] 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Account Actions for {sAccountName}", FAIL, "Verify Account Actions> Share Balance for {sAccountName}:Update Share Balance dialog for {sAccountName} didn't display.")
					[ ] 
				[ ] 
			[ ] 
		[+] else
				[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] // //######################TC 286-Account Actions menu - Reconcile########################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 TC286_AccountActionsMenuReconcile()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will verify Reconcile feature for investing account
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If verification of Reconcile feature for investing account is successful				
		[ ] // //						Fail			If verification of Reconcile feature for investing account is unsuccessful		
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Mukesh              21st May 2013
		[ ] // 
		[ ] // // ********************************************************
		[ ] // 
	[ ] // 
[+] testcase TC286_AccountActionsMenuReconcile() appstate none 
	[+] //Variable Declaration
		[ ] 
		[ ] STRING sStartingCashBalance , sEndingCashBalance , sExpAdjustmentAmount ,sActualAdjustmentAmount
		[ ] STRING sOpeningBalanceDesc ,sAdjustmentBalanceDesc
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sBrokerageAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] sAccountType=lsAddAccount[1]
		[ ] sAccountName=lsAddAccount[2]
		[ ] sStartingCashBalance="1,000.00"
		[ ] sEndingCashBalance="1001"
		[ ] sExpAdjustmentAmount="$199.22"
		[ ] sOpeningBalanceDesc="Opening Balance Adjustment"
		[ ] sAdjustmentBalanceDesc="Balance Adjustment"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Select the 401k account
		[ ] iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[+] if (iSelect==PASS)
			[ ] ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
			[ ] 
			[ ] 
			[-] ///##########Verifying Acount Actions> Update Share Balance#####////
				[ ] //Update share balance
				[ ] QuickenWindow.SetActive()
				[ ] NavigateToAccountActionInvesting(6 , sMDIWindow)
				[-] if (DlgReconcileDetails.Exists(2))
					[ ] ReportStatus("Verify Account Actions for {sAccountName}", PASS, "Verify Account Actions>Reconcile for {sAccountName}: Reconcile for {sAccountName} displayed.")
					[ ] DlgReconcileDetails.SetActive()
					[-] if (DlgReconcileDetails.PriorCashBalanceTextField.Exists())
						[ ] DlgReconcileDetails.PriorCashBalanceTextField.SetText(sStartingCashBalance)
					[-] else
						[ ] DlgReconcileDetails.StartingCashBalanceTextField.SetText(sStartingCashBalance)
					[ ] DlgReconcileDetails.EndingCashBalanceTextField.SetText(sEndingCashBalance)
					[ ] DlgReconcileDetails.OK.Click()
					[-] if (DlgReconcileTransactions.Exists(2))
						[ ] DlgReconcileTransactions.SetActive()
						[ ] DlgReconcileTransactions.MarkAllButton.Click()
						[ ] DlgReconcileTransactions.DoneButton.Click()
						[-] if (DlgAdjustOpeningBalance.Exists(2))
							[ ] DlgAdjustOpeningBalance.SetActive()
							[ ] DlgAdjustOpeningBalance.AdjustButton.Click()
							[-] if (DlgAdjustBalance.Exists(2))
								[ ] DlgAdjustBalance.SetActive()
								[ ] sActualAdjustmentAmount = DlgAdjustBalance.AdjustmentAmountText.GetText()
								[ ] DlgAdjustBalance.AdjustButton.Click()
								[+] if (sActualAdjustmentAmount==sExpAdjustmentAmount)
									[ ] ReportStatus("Verify Adjustment Amount for {sAccountName}", PASS, "Verify Adjustment Amount for {sAccountName}: Adjustment Amount for {sAccountName} : {sActualAdjustmentAmount} is as expected: {sExpAdjustmentAmount} .")
									[+] if (DlgReconciliationComplete.Exists(5))
										[ ] DlgReconciliationComplete.SetActive()
										[ ] DlgReconciliationComplete.NoButton.Click()
										[ ] WaitForState(DlgReconciliationComplete, false,1)
										[ ] 
										[ ] 
										[ ] WaitForState(AdjustShareBalance,False,1)
										[ ] sHandle=Str(BrokerageAccount.ListBox1.GetHandle())
										[ ] 
										[ ] //Listcount is commented as the listcount is calculated by incorrectly by silktest it just takes count as 12//
										[ ] //hence count is hardcoded to retrieve the reult till desired rows///
										[ ] //iListCount=MDIClient.AccountRegister.InvestingAccountRegister.AccountRegisterChild.QWListViewer.ListBox.GetItemCount()+1
										[ ] ///Get all the rows of investing register in a list//
										[+] for( iCounter=0;iCounter< 30 ;++iCounter)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, " {iCounter}")
											[ ] ListAppend(lsListBoxItems,sActual)
										[ ] 
										[ ] ///Verify Reconcile transaction for Opening Balance in 401K Account///
										[+] for( iCounter=1;iCounter< ListCount(lsListBoxItems)+1  ;++iCounter)
											[ ] bMatch = MatchStr("*{sDate}*{sOpeningBalanceDesc}*{sStartingCashBalance}*", lsListBoxItems[iCounter])
											[+] if ( bMatch == TRUE)
												[ ] break
										[+] if (bMatch)
											[ ] ReportStatus("Verify Reconcile for {sOpeningBalanceDesc}",PASS,"Verify Reconcile txn for {sOpeningBalanceDesc} in {sAccountName}: Reconcile txn for {sOpeningBalanceDesc} is : {lsListBoxItems[iCounter]} as expected: {sDate}, {sOpeningBalanceDesc}, {sStartingCashBalance}.")
										[+] else
											[ ] ReportStatus("Verify Reconcile for {sOpeningBalanceDesc}",FAIL,"Verify Reconcile txn for {sOpeningBalanceDesc} in {sAccountName}: Reconcile txn for {sOpeningBalanceDesc} is not as expected: {sDate}, {sOpeningBalanceDesc}, {sStartingCashBalance}.")
											[ ] 
										[ ] 
										[ ] ///Verify Reconcile transaction for Adjustment Balance in 401K Account///
										[ ] 
										[ ] sExpAdjustmentAmount=StrTran(sExpAdjustmentAmount,"$","")
										[+] for ( iCounter=1;iCounter< ListCount(lsListBoxItems)+1  ;++iCounter)
											[ ] bMatch = MatchStr("*{sDate}*{sAdjustmentBalanceDesc}*{sExpAdjustmentAmount}*", lsListBoxItems[iCounter])
											[+] if ( bMatch == TRUE)
												[ ] break
										[+] if (bMatch)
											[ ] ReportStatus("Verify Reconcile for {sAdjustmentBalanceDesc}",PASS,"Verify Reconcile txn for {sAdjustmentBalanceDesc} in {sAccountName}: Reconcile txn for {sAdjustmentBalanceDesc} is : {lsListBoxItems[iCounter]} as expected: {sDate}, {sAdjustmentBalanceDesc}, {sExpAdjustmentAmount}.")
										[+] else
											[ ] ReportStatus("Verify Reconcile for {sAdjustmentBalanceDesc}",FAIL,"Verify Reconcile txn for {sAdjustmentBalanceDesc} in {sAccountName}: Reconcile txn for {sAdjustmentBalanceDesc} is not as expected: {sDate}, {sAdjustmentBalanceDesc}, {sExpAdjustmentAmount}.")
											[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Reconciliation Complete for {sAccountName}", FAIL, "Verify Reconciliation Complete for {sAccountName}: Reconciliation Complete dialog for {sAccountName} didn't display.")
								[-] else
									[ ] ReportStatus("Verify Adjustment Amount for {sAccountName}", FAIL, "Verify Adjustment Amount for {sAccountName}: Adjustment Amount for {sAccountName} : {sActualAdjustmentAmount} is not as expected: {sExpAdjustmentAmount} .")
								[-] if (DlgReconciliationComplete.Exists(5))
									[ ] DlgReconciliationComplete.SetActive()
									[ ] DlgReconciliationComplete.NoButton.Click()
									[ ] WaitForState(DlgReconciliationComplete, false,1)
								[ ] 
							[+] else
								[ ] ReportStatus("Verify dialog Adjust Balance for {sAccountName}", FAIL, "Verify dialog Adjust Balance for {sAccountName}: Adjust Balance dialog for {sAccountName} didn't display.")
						[+] else
							[ ] ReportStatus("Verify dialog AdjustOpeningBalance for {sAccountName}", FAIL, "Verify dialog Adjust Opening Balance for {sAccountName}: Adjust Opening Balance dialog for {sAccountName} didn't display.")
					[+] else
						[ ] ReportStatus("Verify Reconcile for {sAccountName}", FAIL, "Verify Reconcile for {sAccountName}: Reconcile dialog for {sAccountName} didn't display.")
				[+] else
					[ ] ReportStatus("Verify Account Actions for {sAccountName}", FAIL, "Verify Account Actions> Reconcile for {sAccountName}: Account Actions> Reconcile dialog for {sAccountName} didn't display.")
					[ ] 
				[ ] 
			[ ] 
		[+] else
				[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test274_Enter_Transactions_401K_Register_ #################################################
	[ ] //********************************************************
	[-] //TestCase Name:	 Test274_Enter_Transactions_401K_Register_()
		[ ] 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Enter Transactions for Cash Transferred In the account, out of account
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If Entering Transactions for Cash Transferred In the account, out of account is successful
		[ ] // Fail			If Entering Transactions for Cash Transferred In the account, out of account is unsuccessful		
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes                             May 10th, 2013		
		[ ] // ********************************************************
		[ ] // 
	[ ] // 
[+] testcase Test274_Enter_Transactions_401K_Register_() appstate QuickenBaseState 
	[ ] 
	[ ] 
	[+] //Variable Definition
		[ ] 
		[ ] STRING sStatementEndingDate,sTransferInMatch,sTransferOutMatch,sMatchText
		[ ] 
		[ ] INTEGER j
		[ ] 
		[ ] LIST OF STRING lsCashIntoAccount,lsCashOutOfAccount,lsSharesTransferredBetweenAccounts,lsResult
		[ ] 
		[ ] LIST OF ANYTYPE lsAddAccount1,lsAddAccount2
		[ ] 
		[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] sStatementEndingDate =ModifyDate(-5,"m/d/yyyy")
		[ ] sTransferInMatch="XIn"
		[ ] sTransferOutMatch="XOut"
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read data from sRegAccountWorksheet excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //List of Anytype
		[ ] lsAddAccount1={"401(k) or 403(b)","401K 02 Account","NewEmployer",sStatementEndingDate,"YHOO",10}
		[ ] lsAddAccount2={"401(k) or 403(b)","401K Account","NewEmployer",sStatementEndingDate,"YHOO",10}
		[ ] //List Of String
		[ ] lsCashIntoAccount={"Cash Transferred into Account","["+lsAddAccount2[2]+"]","12.5"}
		[ ] lsCashOutOfAccount={"Cash Transferred out of Account","["+lsAddAccount2[2]+"]","7.25"}
		[ ] lsSharesTransferredBetweenAccounts={"Shares Transferred Between Accounts","["+lsAddAccount2[2]+"]","4"}
		[ ] 
	[ ] 
	[ ] 
	[ ] iCreateDataFile=DataFileCreate(sFileName)
	[+] if(iCreateDataFile==PASS)
		[+] if(QuickenWindow.Exists(5))
			[ ] 
			[ ] QuickenWindow.SetActive ()
			[ ] 
			[ ] 
			[ ] iResult=AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3])
			[+] if(iResult==PASS)
				[ ] 
				[ ] iResult=AddManual401KAccount( lsAddAccount2[1],lsAddAccount2[2],lsAddAccount2[3],lsAddAccount2[4],lsAddAccount2[5],lsAddAccount2[6])
				[+] if(iResult==PASS)
					[+] for(j=1;j<=2;j++)
						[ ] 
						[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_INVESTING)
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Open account register of 401K account in account bar",PASS,"Account register of {lsAddAccount1[2]} is opened")
							[ ] 
							[ ] 
							[+] switch j 
								[ ] 
								[ ] // Cash Transferred In the account 
								[+] case 1
									[ ] 
									[ ] //---------------Enter Transaction------------------
									[ ] 
									[ ] NavigateToAccountActionInvesting(6,sMDIWindow)
									[+] if (wEnterTransaction.Exists(5))
										[ ] wEnterTransaction.SetActive()
										[ ] 
										[ ] 
										[ ] wEnterTransaction.EnterTransaction.Select(lsCashIntoAccount[1])
										[ ] wEnterTransaction.TransferAccount.SetText(lsAddAccount[2])
										[ ] wEnterTransaction.AmountToTransfer.SetText(lsCashIntoAccount[3])
										[ ] wEnterTransaction.Memo.SetText(lsCashIntoAccount[1])
										[ ] wEnterTransaction.EnterDone.Click()
										[+] if(AlertMessage.Exists(2))
											[ ] AlertMessage.SetActive()
											[ ] AlertMessage.No.Click()
											[ ] ReportStatus("Add Transaction",PASS,"Transaction is added successfully")
										[ ] WaitForState(wEnterTransaction,FALSE,5)
										[ ] 
										[ ] 
										[ ] 
										[ ] //-----------Open Incoming Register----------------------------
										[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
										[+] if(iVerify==PASS)
											[ ] ReportStatus("Open account register of 401K account in account bar",PASS,"Account register of {lsAddAccount[2]} is opened")
											[ ] 
											[ ] 
											[ ] //-----------Find Transaction in Incoming Register----------------------------
											[ ] lsResult=GetTransactionsInRegister(lsCashIntoAccount[1])
											[ ] bMatch=MatchStr("*{lsCashIntoAccount[2]}*{lsCashIntoAccount[3]}*",lsResult[1])
											[+] if(bMatch==TRUE)
												[ ] ReportStatus("Match Transfer Transaction",PASS,"Transfer into account {sTransferInMatch} matched")
											[+] else
												[ ] ReportStatus("Match Transfer Transaction",FAIL,"Transfer into account {sTransferInMatch} not matched")
												[ ] 
											[ ] 
											[ ] 
											[ ] //FROM_ACCOUNT:
											[ ] //-----------Open Outgoing Register----------------------------
											[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_INVESTING)
											[+] if(iVerify==PASS)
												[ ] ReportStatus("Open account register of 401K account in account bar",PASS,"Account register of account {lsAddAccount2[2]} is opened")
												[ ] 
												[ ] 
												[ ] //-----------Find Transaction in Outgoing Register----------------------------
												[ ] sHandle=Str(BrokerageAccount.ListBox1.GetHandle())
												[+] for(i=0;i<=10;i++)
													[ ] 
													[ ] //Match Transfer 
													[ ] sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
													[ ] bMatch=MatchStr("*{sTransferInMatch}*",sActual)
													[ ] 
													[+] if(bMatch==TRUE)
														[ ] ReportStatus("Match Transfer Transaction",PASS,"Transfer into account {sTransferInMatch} matched")
														[ ] 
														[ ] sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i+1))
														[ ] //Match Transfer from account information
														[ ] bMatch=MatchStr("*{lsAddAccount[2]}*",sActual)
														[+] if(bMatch==TRUE)
															[ ] ReportStatus("Match Transfer Account",PASS,"Transfer from account {lsAddAccount[2]} matched")
															[ ] break
															[ ] 
														[+] else
															[ ] ReportStatus("Match Transfer Account",FAIL,"Transfer from account {lsAddAccount[2]} not matched")
														[ ] 
														[ ] 
														[ ] 
													[+] else
														[ ] bMatch=FALSE
														[ ] 
													[ ] 
													[ ] 
													[ ] 
												[+] if(bMatch==FALSE)
													[ ] 
													[ ] ReportStatus("Match Transfer Transaction",FAIL,"Transfer into account {sTransferInMatch} not matched")
													[ ] break
													[ ] 
													[ ] 
													[ ] 
													[ ] 
													[ ] 
													[ ] 
												[ ] 
												[ ] 
												[ ] 
												[+] // for(i=0;i<=iRegisterCount;i++)
													[ ] // 
													[ ] // sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
													[ ] // //Match Transfer 
													[ ] // bMatch=MatchStr("*{sTransferOutMatch}*",sActual)
													[+] // if(bMatch==TRUE)
														[ ] // ReportStatus("Match Transfer Transaction",PASS,"Transfer into account {sTransferInMatch} matched")
														[ ] // 
														[ ] // sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i+1))
														[ ] // 
														[ ] // //Match Transfer from account information
														[ ] // bMatch=MatchStr("*{lsAddAccount1[2]}*",sActual)
														[+] // if(bMatch==TRUE)
															[ ] // ReportStatus("Match Transfer Account",PASS,"Transfer from account {lsAddAccount1[2]} matched")
															[ ] // goto FROM_ACCOUNT
															[ ] // 
														[+] // else
															[ ] // ReportStatus("Match Transfer Account",FAIL,"Transfer from account {lsAddAccount1[2]} not matched")
															[ ] // 
															[ ] // 
														[ ] // 
														[ ] // 
														[ ] // 
														[ ] // 
														[ ] // 
													[+] // else
														[ ] // 
														[ ] // ReportStatus("Match Transfer Transaction",FAIL,"Transfer into account {sTransferInMatch} not matched")
														[ ] // 
														[ ] // 
														[ ] // 
													[+] // if(bMatch==FALSE)
														[ ] // 
														[ ] // ReportStatus("Match Transfer Transaction",FAIL,"Transfer into account {sTransferInMatch} not matched")
														[ ] // break
														[ ] // 
														[ ] // 
														[ ] // 
														[ ] // 
														[ ] // 
														[ ] // 
													[ ] // 
													[ ] // 
													[ ] // 
												[ ] 
												[ ] 
											[+] else
												[ ] ReportStatus("Open account register of 401K account in account bar",FAIL,"Account register {lsAddAccount2[2]} is not opened")
											[ ] 
											[ ] 
											[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Open account register of 401K account in account bar",FAIL,"Account register is opened")
											[ ] 
											[ ] 
										[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Investing window displayed",FAIL,"Investing window not displayed")
										[ ] 
								[ ] 
								[ ] 
								[ ] // Cash Transferred Out the account 
								[+] case 2
									[ ] 
									[ ] //---------------Enter Transaction------------------
									[ ] 
									[ ] NavigateToAccountActionInvesting(6,sMDIWindow)
									[+] if (wEnterTransaction.Exists(5))
										[ ] wEnterTransaction.SetActive()
										[ ] 
										[ ] 
										[ ] wEnterTransaction.EnterTransaction.Select(lsCashOutOfAccount[1])
										[ ] wEnterTransaction.TransferAccount.SetText(lsAddAccount[2])
										[ ] wEnterTransaction.AmountToTransfer.SetText(lsCashOutOfAccount[3])
										[ ] wEnterTransaction.Memo.SetText(lsCashOutOfAccount[1])
										[ ] wEnterTransaction.EnterDone.Click()
										[+] if(AlertMessage.Exists(2))
											[ ] AlertMessage.SetActive()
											[ ] AlertMessage.No.Click()
											[ ] ReportStatus("Add Transaction",PASS,"Transaction is added successfully")
										[ ] WaitForState(wEnterTransaction,FALSE,5)
										[ ] 
										[ ] 
										[ ] 
										[ ] //-----------Open Incoming Register----------------------------
										[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
										[+] if(iVerify==PASS)
											[ ] ReportStatus("Open account register of 401K account in account bar",PASS,"Account register of {lsAddAccount[2]} is opened")
											[ ] 
											[ ] 
											[ ] //-----------Find Transaction in Incoming Register----------------------------
											[ ] lsResult=GetTransactionsInRegister(lsCashOutOfAccount[1])
											[ ] bMatch=MatchStr("*{lsCashOutOfAccount[2]}*{lsCashOutOfAccount[3]}*",lsResult[1])
											[+] if(bMatch==TRUE)
												[ ] ReportStatus("Match Transfer Transaction",PASS,"Transfer into account {sTransferInMatch} matched")
											[+] else
												[ ] ReportStatus("Match Transfer Transaction",FAIL,"Transfer into account {sTransferInMatch} not matched")
												[ ] 
											[ ] 
											[ ] 
											[ ] //FROM_ACCOUNT:
											[ ] //-----------Open Outgoing Register----------------------------
											[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_INVESTING)
											[+] if(iVerify==PASS)
												[ ] ReportStatus("Open account register of 401K account in account bar",PASS,"Account register of account {lsAddAccount2[2]} is opened")
												[ ] 
												[ ] 
												[ ] //-----------Find Transaction in Outgoing Register----------------------------
												[ ] sHandle=Str(BrokerageAccount.ListBox1.GetHandle())
												[+] for(i=0;i<=10;i++)
													[ ] 
													[ ] //Match Transfer 
													[ ] sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
													[ ] 
													[ ] bMatch=MatchStr("*{sTransferOutMatch}*",sActual)
													[ ] 
													[+] if(bMatch==TRUE)
														[ ] ReportStatus("Match Transfer Transaction",PASS,"Transfer into account {sTransferOutMatch} matched")
														[ ] 
														[ ] sActual=QwautoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i+1))
														[ ] 
														[ ] //Match Transfer from account information
														[ ] bMatch=MatchStr("*{lsAddAccount[2]}*",sActual)
														[+] if(bMatch==TRUE)
															[ ] ReportStatus("Match Transfer Account",PASS,"Transfer from account {lsAddAccount[2]} matched")
															[ ] break
															[ ] 
														[+] else
															[ ] ReportStatus("Match Transfer Account",FAIL,"Transfer from account {lsAddAccount[2]} not matched")
														[ ] 
														[ ] 
														[ ] 
													[+] else
														[ ] bMatch=FALSE
														[ ] 
													[ ] 
													[ ] 
													[ ] 
												[+] if(bMatch==FALSE)
													[ ] 
													[ ] ReportStatus("Match Transfer Transaction",FAIL,"Transfer into account {sTransferInMatch} not matched")
													[ ] break
													[ ] 
													[ ] 
													[ ] 
													[ ] 
													[ ] 
													[ ] 
												[ ] 
												[ ] 
											[+] else
												[ ] ReportStatus("Open account register of 401K account in account bar",FAIL,"Account register {lsAddAccount2[2]} is not opened")
											[ ] 
											[ ] 
											[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Open account register of 401K account in account bar",FAIL,"Account register is opened")
											[ ] 
											[ ] 
										[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Investing window displayed",FAIL,"Investing window not displayed")
										[ ] 
									[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Open account register of 401K account in account bar",FAIL,"Account register couldn't be opened")
							[ ] 
							[ ] 
				[+] else
					[+] ReportStatus("Add 401K account in Quicken",FAIL,"401K account successfully added to Quicken")
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
						[ ] 
						[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Add Checking account in Quicken",FAIL,"Error while adding Checking account to Quicken")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
			[ ] 
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Create Data File ", FAIL, "Error during data file creation.") 
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] // 
[+] // //######################TC 285-Account Actions menu - Account Attachment########################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 TC285_AccountActionsMenuAccountAttachment()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will verify Account Attachment feature for investing account
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If verification of Account Attachment feature for investing account is successful				
		[ ] // //						Fail			If verification of Account Attachment feature for investing account is unsuccessful		
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Mukesh              21st May 2013
		[ ] // 
		[ ] // // ********************************************************
		[ ] // 
	[ ] // 
[+] // testcase TC285_AccountActionsMenuAccountAttachment() appstate none //none  
	[+] // //Variable Declaration
		[ ] // 
		[ ] // 
		[ ] // STRING sAccountName, sAttachmentLocation, sAttachmentFolder
		[+] // LIST OF STRING lsExpectedAttachNewPopupList={...}
			[ ] // "Statement"
			[ ] // "Other"
			[ ] // "Check"
			[ ] // "Invoice"
			[ ] // "Receiptbill"
			[ ] // "Warranty"
		[ ] // 
		[ ] // sAttachmentFolder="TransactionAttachments"
		[ ] // sAttachmentLocation= AUT_DATAFILE_PATH + "\" + sAttachmentFolder+"\"
		[ ] // 
		[ ] // lsExcelData=NULL
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet, sBrokerageAccountSheet)
		[ ] // lsAddAccount=lsExcelData[1]
		[ ] // sAccountType=lsAddAccount[1]
		[ ] // sAccountName=lsAddAccount[2]
	[ ] // 
	[ ] // 
	[+] // if(QuickenWindow.Exists(3))
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // //Select the 401k account
		[ ] // iSelect = SelectAccountFromAccountBar(sAccountName,ACCOUNT_INVESTING)
		[+] // if (iSelect==PASS)
			[ ] // ReportStatus("Verify {sAccountName} Account", PASS, "{sAccountName} account open successfully")
			[ ] // 
			[ ] // 
			[+] // ///##########Verifying Acount Actions> AccountAttachments#####////
				[ ] // //Update Cash balance
				[ ] // QuickenWindow.SetActive()
				[ ] // NavigateToAccountActionInvesting(12 , sMDIWindow)
				[+] // if (DlgAccountAttachments.Exists(2))
					[ ] // DlgAccountAttachments.SetActive()
					[ ] // DlgAccountAttachments.AddButton.Click()
					[+] // if (DlgAddAttachment.Exists(3))
						[ ] // DlgAddAttachment.SetActive()
						[ ] // DlgAddAttachment.OKButton.Click()
						[+] // if (DlgTransactionAttachments.Exists(3))
							[ ] // DlgTransactionAttachments.SetActive()
							[ ] // /// ######Verify AttachNew Check#######///
							[+] // if (DlgTransactionAttachments.AddButton.Exists(3))
								[+] // for (iCounter=1; iCounter<ListCount(lsExpectedAttachNewPopupList)+1 ; ++iCounter)
									[ ] // DlgTransactionAttachments.AddButton.Click()
									[ ] // // DlgTransactionAttachments.AttachNewPopupList.Select(trim(lsExpectedAttachNewPopupList[iCounter]))
									[ ] // ////#####This line has been added to handle "/" as we can not have this as the part of file name#####////
									[ ] // DlgTransactionAttachments.TypeKeys(KEY_DN)
									[ ] // DlgTransactionAttachments.TypeKeys(KEY_ENTER)
									[+] // if (DlgSelectAttachment.Exists(3))
										[ ] // DlgSelectAttachment.SetActive()
										[ ] // DlgSelectAttachment.FileName.SetText(sAttachmentLocation+lsExpectedAttachNewPopupList[iCounter])
										[ ] // DlgSelectAttachment.Open.DoubleClick()
										[ ] // WaitForState(DlgSelectAttachment,False,1)
										[+] // if (DlgTransactionAttachments.Exists(3))
											[ ] // 
											[ ] // DlgTransactionAttachments.SetActive()
											[+] // if (DlgTransactionAttachments.Exists(3))
												[ ] // ReportStatus("Verify attachment attached.", PASS, "Verify attachment attached: Attachment {lsExpectedAttachNewPopupList[iCounter]} successfully attached.") 
												[ ] // ///######Delete the added attachment########////
												[ ] // DlgTransactionAttachments.DeleteButton.Click()
												[ ] // DlgTransactionAttachments.TypeKeys(replicate(KEY_DN,3))
												[ ] // DlgTransactionAttachments.TypeKeys(KEY_ENTER)
												[+] // if(AlertMessage.Exists(3))
													[ ] // AlertMessage.Yes.Click()
													[ ] // WaitForState(AlertMessage,False,2)
													[ ] // sleep(2)
													[ ] // 
												[+] // else
													[ ] // ReportStatus("Verify delete confirmation dialog.", FAIL, "Verify delete confirmation dialog: Delete confirmation dialog didn't appear.") 
											[+] // else
												[ ] // ReportStatus("Verify attachment attached..", FAIL, "Verify attachment attached: Attachment {lsExpectedAttachNewPopupList[3]} couldn't be attached.") 
										[+] // else
											[ ] // ReportStatus("Verify attachments dialog.", FAIL, "Verify attachments dialog: Attachments dialog couldn't be opened.") 
										[ ] // ////Attachment 
									[+] // else
										[ ] // ReportStatus("Verify Select attachment file dialog.", FAIL, "Verify Select attachment file dialog: Select attachment file dialog didn't appear.") 
							[+] // else
								[ ] // ReportStatus("Verify AttachNewPopupList exists.", FAIL, "Verify AttachNewPopupList exists: AttachNewPopupList doesn't exist.") 
							[+] // if (!DlgTransactionAttachments.IsActive())
								[ ] // DlgTransactionAttachments.SetActive()
							[ ] // DlgTransactionAttachments.DoneButton.Click()
							[ ] // WaitForState(DlgTransactionAttachments,False,1)
						[+] // else
							[ ] // ReportStatus("Verify attachments dialog.", FAIL, "Verify attachments dialog: Attachments dialog couldn't be opened.") 
					[+] // else
						[ ] // ReportStatus("Verify Add Attachment ", FAIL, "Verify Add Attachment dialog: Add Attachment dialog didn't appear.")
					[ ] // DlgAccountAttachments.SetActive()
					[ ] // DlgAccountAttachments.DoneButton.Click()
				[+] // else
					[ ] // ReportStatus("Verify Account Attachments ", FAIL, "Verify Dialog Account Attachments : Account Attachments Dialog didn't appear.")
				[ ] // 
			[ ] // 
		[+] // else
				[ ] // ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open")
			[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[ ] // 
	[ ] // 
[ ] // 
[ ] 
[ ] 
[ ] 
[+] ////############# Setup : Convert Data File From 2012 to 2014 ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 DataConversionRegister2012_2013()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will convert old data file of 2012 into latest Quicken version
		[ ] // It will also take backup of converted file.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while converting  file							
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	6/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase DataConversionRegisterSetup2012_2013() appstate none 
	[ ] 
	[ ] 
	[+] // Variable declaration
		[ ] //Boolean
		[ ] BOOLEAN bSource,bVerify
		[ ] 
		[ ] //Integer
		[ ] INTEGER iDataFileConversion
		[ ] 
		[ ] //String
		[ ] STRING sFileName= "RegisterDataFile2012"
		[ ] STRING sQuicken2012File = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sVersion="2012"
		[ ] STRING sQuicken2012Source = AUT_DATAFILE_PATH + "\2012\" + sFileName + ".QDF"
		[ ] STRING sQuicken2012FileCopy= AUT_DATAFILE_PATH + "\" + "Q12Files"+ "\" + sFileName + ".QDF"
		[ ] 
	[ ] 
	[ ] // Delete Existing File
	[+] if(SYS_FileExists(sQuicken2012File))
		[ ] // Delete existing file, if exists
		[ ] bVerify=DeleteFile(sQuicken2012File)
		[+] if(bVerify==TRUE)
			[ ] ReportStatus("2012 Data File Conversion",PASS,"Existing File Deleted")
		[+] else
			[ ] ReportStatus("2012 Data File Conversion",PASS,"Existing File Not Deleted")
		[ ] 
		[ ] 
	[ ] //Delete Copy of File
	[+] if(SYS_FileExists(sQuicken2012FileCopy))
		[ ] DeleteFile(sQuicken2012FileCopy)
		[ ] bVerify=DeleteFile(sQuicken2012FileCopy)
		[+] if(bVerify==TRUE)
			[ ] ReportStatus("2012 Data File Conversion",PASS,"Existing Copy of File Deleted")
		[+] else
			[ ] ReportStatus("2012 Data File Conversion",FAIL,"Existing Copy of File Not Deleted")
	[ ] 
	[ ] // Copy 2012 data file to location
	[+] if(SYS_FileExists(sQuicken2012Source))
		[ ] SYS_Execute("attrib -r  {sQuicken2012Source} ")
		[ ] bVerify=CopyFile(sQuicken2012Source, sQuicken2012File)
		[+] if(bVerify==TRUE)
			[ ] ReportStatus("2012 Data File Conversion",PASS,"File Copied successfully")
		[+] else
			[ ] ReportStatus("2012 Data File Conversion",FAIL,"File Not Copied to location")
	[ ] 
	[ ] sQuicken2012File = AUT_DATAFILE_PATH + "\" 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] iDataFileConversion=DataFileConversion(sFileName,sVersion,"",sQuicken2012File)
		[+] if (iDataFileConversion==PASS)
			[ ] ReportStatus("2012 Data File Conversion",PASS,"File Converted from 2012 to 2015")
		[+] else
			[ ] ReportStatus("2012 Data File Conversion",FAIL,"File couldn't be Converted from 2012 to 2015")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("2012 Data File Conversion",FAIL,"Quicken Window Not found")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# DownloadedTransactionsPreferences_Migration #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC11_DownloadedTransactionsPreferences_Migration()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Downloaded Transactions  Preferences in file migrated from previous version
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	6/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC11_DownloadedTransactionsPreferences_Migration() appstate none 
	[ ] 
	[+] //Variable Decalration
		[ ] STRING sHandle
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[-] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Navigate to option 'Downloaded Transactions'---------------------------------------------------------------------------------
		[ ] iResult=SelectPreferenceType("Downloaded transactions")
		[-] if(iResult==PASS)
			[ ] ReportStatus("Preferences Window",PASS,"Preferences Window Opened")
			[ ] 
			[ ] 
			[ ] Preferences.SetActive()
			[ ] 
			[ ] 
			[ ] //After Transaction Download
			[+] if(Preferences.AfterDownloadingTransactions.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AfterDownloadingTransactions Text is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AfterDownloadingTransactions Text is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyAddToBankingRegister.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyAddToBankingRegister Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyAddToBankingRegister Checkbox is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyAddToInvestmentTransactionLists.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyAddToInvestmentTransactionLists Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyAddToInvestmentTransactionLists Checkbox is missing")
				[ ] 
			[ ] 
			[ ] 
			[ ] //During Transaction Download
			[+] if(Preferences.DownloadedTransactionsPreferences.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"DownloadedTransactionsPreferences Text is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"DownloadedTransactionsPreferences Text is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyCategorizeTransactions.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyCategorizeTransactions Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyCategorizeTransactions Checkbox is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyApplyQuickenSuggestedNameToPayee.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyApplyQuickenSuggestedNameToPayee Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyApplyQuickenSuggestedNameToPayee Checkbox is missing")
				[ ] 
			[+] if(Preferences.CapitalizeFirstLetterOnlyInDownloadedPayeeNames.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"CapitalizeFirstLetterOnlyInDownloadedPayeeNames Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"CapitalizeFirstLetterOnlyInDownloadedPayeeNames Checkbox is missing")
				[ ] 
			[ ] 
			[ ] 
			[ ] //Renaming Rules
			[+] if(Preferences.YourRenamingRulesText.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"YourRenamingRulesText is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"YourRenamingRulesText is missing")
				[ ] 
			[+] if(Preferences.UseMyExistingRenamingRules.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"UseMyExistingRenamingRules Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"UseMyExistingRenamingRules Checkbox is missing")
				[ ] 
			[+] if(Preferences.RenamingRules.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"RenamingRules button is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"RenamingRules button is missing")
				[ ] 
			[+] if(Preferences.AutomaticallyCreateRulesWhenIRenamePayees.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyCreateRulesWhenIRenamePayees Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyCreateRulesWhenIRenamePayees Checkbox is missing")
				[ ] 
			[+] if(Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.Exists(5))
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"LetMeReviewConfirmTheAutomaticallyCreatedRules Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"LetMeReviewConfirmTheAutomaticallyCreatedRules Checkbox is missing")
				[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] Preferences.SetActive()
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,False,1)
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Preferences Window",FAIL,"Preferences Window Not Opened")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] // //############# Setup : Convert Data File From 2012 to 2014 ###############################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 DataConversionRegister2012_2013()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will convert old data file of 2012 into latest Quicken version
		[ ] // // It will also take backup of converted file.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If no error occurs while converting  file							
		[ ] // //						Fail		       If any error occurs
		[ ] // // 
		[ ] // //REVISION HISTORY:	6/2/ 2013	Created by	Dean Paes
		[ ] // //							
	[ ] // // ********************************************************
[+] // testcase DataConversionRegister2012_2013() appstate QuickenBaseState 
	[ ] // 
	[ ] // 
	[-] // // Variable declaration
		[ ] // //Boolean
		[ ] // BOOLEAN bSource,bVerify
		[ ] // 
		[ ] // //Integer
		[ ] // INTEGER iDataFileConversion
		[ ] // 
		[ ] // //String
		[ ] // STRING sFileName= "RegisterDataFile2012"
		[ ] // STRING sQuicken2012File = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] // STRING sVersion="2012"
		[ ] // STRING sQuicken2012Source = AUT_DATAFILE_PATH + "\2012\" + sFileName + ".QDF"
		[ ] // STRING sQuicken2012FileCopy= AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] // 
	[ ] // 
	[ ] // 
	[-] // if(QuickenWindow.Exists(5))
		[ ] // // Delete Existing File
		[+] // if(SYS_FileExists(sQuicken2012File))
			[ ] // // Delete existing file, if exists
			[ ] // bVerify=DeleteFile(sQuicken2012File)
			[-] // if(bVerify==TRUE)
				[ ] // ReportStatus("2012 Data File Conversion",PASS,"Existing File Deleted")
			[+] // else
				[ ] // ReportStatus("2012 Data File Conversion",PASS,"Existing File Not Deleted")
			[ ] // 
			[ ] // 
		[ ] // //Delete Copy of File
		[+] // if(SYS_FileExists(sQuicken2012FileCopy))
			[ ] // DeleteFile(sQuicken2012FileCopy)
			[ ] // bVerify=DeleteFile(sQuicken2012FileCopy)
			[-] // if(bVerify==TRUE)
				[ ] // ReportStatus("2012 Data File Conversion",PASS,"Existing Copy of File Deleted")
			[+] // else
				[ ] // ReportStatus("2012 Data File Conversion",FAIL,"Existing Copy of File Not Deleted")
		[ ] // 
		[ ] // // Copy 2012 data file to location
		[+] // if(SYS_FileExists(sQuicken2012Source))
			[ ] // SYS_Execute("attrib -r  {sQuicken2012Source} ")
			[ ] // bVerify=CopyFile(sQuicken2012Source, sQuicken2012File)
			[+] // if(bVerify==TRUE)
				[ ] // ReportStatus("2012 Data File Conversion",PASS,"File Copied successfully")
			[+] // else
				[ ] // ReportStatus("2012 Data File Conversion",FAIL,"File Not Copied to location")
		[ ] // 
		[ ] // sQuicken2012File= AUT_DATAFILE_PATH + "\" 
		[ ] // 
		[ ] // iDataFileConversion=DataFileConversion(sFileName,sVersion,"",sQuicken2012File)
		[-] // if (iDataFileConversion==PASS)
			[ ] // ReportStatus("2012 Data File Conversion",PASS,"File Converted from 2012 to 2014")
		[-] // else
			[ ] // ReportStatus("2012 Data File Conversion",FAIL,"File couldn't be Converted from 2012 to 2014")
		[ ] // 
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("2012 Data File Conversion",FAIL,"Quicken Window Not found")
		[ ] // 
	[ ] // 
	[ ] // 
[ ] // 
[ ] // 
[+] // ////############# DownloadedTransactionsPreferences_Migration #############################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 TC11_DownloadedTransactionsPreferences_Migration()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify Downloaded Transactions  Preferences in file migrated from previous version
		[ ] // //.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If verification of content is correct					
		[ ] // //						Fail		       If any error occurs
		[ ] // // 
		[ ] // //REVISION HISTORY:	6/2/ 2013	Created by	Dean Paes
		[ ] // //							
	[ ] // // ********************************************************
[+] // testcase TC11_DownloadedTransactionsPreferences_Migration() appstate none
	[ ] // 
	[+] // //Variable Decalration
		[ ] // STRING sHandle
		[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // 
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // 
		[ ] // //Navigate to option 'Downloaded Transactions'---------------------------------------------------------------------------------
		[ ] // QuickenWindow.Edit.Click()
		[ ] // QuickenWindow.Edit.Preferences.Select()
		[+] // if(Preferences.Exists(5))
			[ ] // ReportStatus("Preferences Window",PASS,"Preferences Window Opened")
			[ ] // 
			[ ] // //SelectPreferenceType()
			[ ] // Preferences.SetActive()
			[ ] // sHandle = Str(Preferences.SelectPreferenceType1.ListBox.GetHandle())
			[ ] // QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, "12")
			[ ] // //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] // 
			[ ] // //Verify that all objects are present----------------------------------------------------------------------------------------------------
			[ ] // WaitForState(Preferences,TRUE,10)
			[ ] // //VerifyContentInEditPreferences
			[ ] // 
			[ ] // Preferences.SetActive()
			[ ] // 
			[ ] // 
			[ ] // //After Transaction Download
			[+] // if(Preferences.AfterDownloadingTransactions.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"AfterDownloadingTransactions Text is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"AfterDownloadingTransactions Text is missing")
				[ ] // 
			[+] // if(Preferences.AutomaticallyAddToBankingRegister.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyAddToBankingRegister Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyAddToBankingRegister Checkbox is missing")
				[ ] // 
			[+] // if(Preferences.AutomaticallyAddToInvestmentTransactionLists.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyAddToInvestmentTransactionLists Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyAddToInvestmentTransactionLists Checkbox is missing")
				[ ] // 
			[ ] // 
			[ ] // 
			[ ] // //During Transaction Download
			[+] // if(Preferences.DownloadedTransactionsPreferences.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"DownloadedTransactionsPreferences Text is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"DownloadedTransactionsPreferences Text is missing")
				[ ] // 
			[+] // if(Preferences.AutomaticallyCategorizeTransactions.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyCategorizeTransactions Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyCategorizeTransactions Checkbox is missing")
				[ ] // 
			[+] // if(Preferences.AutomaticallyApplyQuickenSuggestedNameToPayee.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyApplyQuickenSuggestedNameToPayee Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyApplyQuickenSuggestedNameToPayee Checkbox is missing")
				[ ] // 
			[+] // if(Preferences.CapitalizeFirstLetterOnlyInDownloadedPayeeNames.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"CapitalizeFirstLetterOnlyInDownloadedPayeeNames Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"CapitalizeFirstLetterOnlyInDownloadedPayeeNames Checkbox is missing")
				[ ] // 
			[ ] // 
			[ ] // 
			[ ] // //Renaming Rules
			[+] // if(Preferences.YourRenamingRulesText.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"YourRenamingRulesText is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"YourRenamingRulesText is missing")
				[ ] // 
			[+] // if(Preferences.UseMyExistingRenamingRules.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"UseMyExistingRenamingRules Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"UseMyExistingRenamingRules Checkbox is missing")
				[ ] // 
			[+] // if(Preferences.RenamingRules.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"RenamingRules button is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"RenamingRules button is missing")
				[ ] // 
			[+] // if(Preferences.AutomaticallyCreateRulesWhenIRenamePayees.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyCreateRulesWhenIRenamePayees Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyCreateRulesWhenIRenamePayees Checkbox is missing")
				[ ] // 
			[+] // if(Preferences.LetMeReviewConfirmTheAutomaticallyCreatedRules.Exists(5))
				[ ] // ReportStatus("Edit Preferences Download Transactions",PASS,"LetMeReviewConfirmTheAutomaticallyCreatedRules Checkbox is present")
			[+] // else
				[ ] // ReportStatus("Edit Preferences Download Transactions",FAIL,"LetMeReviewConfirmTheAutomaticallyCreatedRules Checkbox is missing")
				[ ] // 
			[ ] // //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] // 
			[ ] // Preferences.SetActive()
			[ ] // Preferences.OK.Click()
			[ ] // WaitForState(Preferences,False,1)
			[ ] // 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Preferences Window",FAIL,"Preferences Window Not Opened")
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Downloaded Transaction Preferences",FAIL,"Quicken Window Not found")
		[ ] // 
		[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
[ ] 
[ ] 
[ ] 
[+] // //############## Enable Classic menu mode  ####################################################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test02_Enable Classic menu mode()
		[ ] // // 
		[ ] // // DESCRIPTION:			
		[ ] // // This testcase will check enable classic menu mode in Prefernces for Converted file.
		[ ] // //
		[ ] // // PARAMETERS:			None
		[ ] // // 
		[ ] // // RETURNS:				Pass 	if Use classic menu is checked		
		[ ] // //							Fail	       if any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:	
		[ ] // // 06/02/2013  	Created By	Indrajit Deshmukh
	[ ] // //*********************************************************
[+] testcase Test02_EnableClassicMenuMode() appstate none 
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
	[ ] 
	[ ] // Quicken is launched
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] SetUp_AutoApi()
		[ ] SelectPreferenceType("Navigation")
		[ ] bCheck=Preferences.UseClassicMenus.IsChecked()
		[+] if (bCheck==TRUE)
			[ ] ReportStatus("Validate Use Classic menu checkbox is checked", PASS, "Use Classic menu checkbox is checked when file where option is checked is migrated")
		[+] else
			[ ] ReportStatus("Validate Use Classic menu checkbox is checked", FAIL, "Use Classic menu checkbox is unchecked when file where option is checked is migrated")
		[ ] 
		[ ] 
		[ ] //Uncheck Classic Menus
		[ ] Preferences.UseClassicMenus.UnCheck()
		[ ] bCheck=Preferences.UseClassicMenus.IsChecked()
		[+] if (bCheck==FALSE)
			[ ] ReportStatus("Validate Use Classic menu checkbox is checked", PASS, "Use Classic menu checkbox is unchecked")
		[+] else
			[ ] ReportStatus("Validate Use Classic menu checkbox is checked", FAIL, "Use Classic menu checkbox is checked ")
		[ ] 
		[ ] Preferences.OK.Click()
		[ ] WaitForState(Preferences,FALSE,20)
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] // 
[ ] // //############################################################################
[ ] 
[ ] 
[+] //############## RegisterpreferencesafterMigration  ####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test06_Register preferences after Migration()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will check enable classic menu mode in Prefernces for Converted file.
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Use classic menu is checked for Converted file.	
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 07/02/2013  	Created By	Indrajit Deshmukh
	[ ] //*********************************************************
[+] testcase Test06_RegisterPreferencesAfterMigration() appstate none 
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
	[ ] 
	[ ] 
	[ ] // Quicken is launched
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] SelectPreferenceType("Register")
		[ ] //To check Register fields section in Preferences
		[+] if (Preferences.RegisterFieldsText.Exists(5))
			[ ] ReportStatus("Verify Register Fields label is exists in Register Preferences", PASS, "Register Fields label is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify Register Fields label is exists in Register Preferences", FAIL, "Register Fields label is not exists in Register Preferences ")
		[+] if (Preferences.ShowDateBeforeCheckNumber.Exists(5))
			[ ] ReportStatus("Verify ShowDateBeforeCheckNumber checkbox is exists in Register Preferences", PASS, "ShowDateBeforeCheckNumber checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify ShowDateBeforeCheckNumber checkbox is exists in Register Preferences", FAIL, "ShowDateBeforeCheckNumber checkbox is not exists in Register Preferences ")
		[+] if (Preferences.ShowMemoBeforeCategory.Exists(5))
			[ ] ReportStatus("Verify ShowMemoBeforeCategory checkbox is exists in Register Preferences", PASS, "ShowMemoBeforeCategory checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify ShowMemoBeforeCategory checkbox is exists in Register Preferences", FAIL, "ShowMemoBeforeCategory checkbox is not exists in Register Preferences ")
			[ ] 
			[ ] //To check Transactions Entry section in Preferences
		[+] if (Preferences.TransactionEntryText.Exists(5))
			[ ] ReportStatus("Verify Transaction Entry label is exists in Register Preferences", PASS, "Transaction Entry label is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify Transaction Entry label is exists in Register Preferences", FAIL, "Transaction Entry label is not exists in Register Preferences ")
		[+] if (Preferences.AutomaticallyEnterSplitData.Exists(5))
			[ ] ReportStatus("Verify AutomaticallyEnterSplitData checkbox is exists in Register Preferences", PASS, "AutomaticallyEnterSplitData checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify AutomaticallyEnterSplitData checkbox is exists in Register Preferences", FAIL, "AutomaticallyEnterSplitData checkbox is not exists in Register Preferences ")
			[ ] 
		[+] if (Preferences.AutomaticallyPlaceDecimalPoint.Exists(5))
			[ ] ReportStatus("Verify AutomaticallyPlaceDecimalPoint checkbox is exists in Register Preferences", PASS, "AutomaticallyPlaceDecimalPoint checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify AutomaticallyPlaceDecimalPoint checkbox is exists in Register Preferences", FAIL, "AutomaticallyPlaceDecimalPoint checkbox is not exists in Register Preferences ")
			[ ] 
			[ ] //To check Register Appearence section in Preferences
		[+] if (Preferences.RegisterAppearanceText.Exists(5))
			[ ] ReportStatus("Verify Register Appearance label is exists in Register Preferences", PASS, "Register Appearance  label is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify Register Appearance  label is exists in Register Preferences", FAIL, "Register Appearance  label is not exists in Register Preferences ")
		[ ] 
		[+] if (Preferences.GrayReconciledTransactions.Exists(5))
			[ ] ReportStatus("Verify GrayReconciledTransactions checkbox is exists in Register Preferences", PASS, "GrayReconciledTransactions checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify GrayReconciledTransactions checkbox is exists in Register Preferences", FAIL, "GrayReconciledTransactions checkbox is not exists in Register Preferences ")
		[ ] 
		[+] if (Preferences.RememberRegisterFiltersAfterQuickenCloses.Exists(5))
			[ ] ReportStatus("Verify RememberRegisterFiltersAfterQuickenCloses checkbox is exists in Register Preferences", PASS, "RememberRegisterFiltersAfterQuickenCloses checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify RememberRegisterFiltersAfterQuickenCloses checkbox is exists in Register Preferences", FAIL, "RememberRegisterFiltersAfterQuickenCloses checkbox is not exists in Register Preferences ")
			[ ] 
		[+] if (Preferences.UsePopUpRegisters.Exists(5))
			[ ] ReportStatus("Verify UsePopUpRegisters checkbox is exists in Register Preferences", PASS, "UsePopUpRegisters checkbox is exists in Register Preferences")
		[+] else
			[ ] ReportStatus("Verify UsePopUpRegisters checkbox is exists in Register Preferences", FAIL, "UsePopUpRegisters checkbox is not exists in Register Preferences ")
		[ ] 
		[ ] Preferences.OK.Click()
		[ ] WaitForState(Preferences,FALSE,20)
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] // //############## Verify Quick Fill Preferences - Migration ####################################################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test08_Verify Quick Fill Preferences - Migration ()
		[ ] // // 
		[ ] // // DESCRIPTION:			
		[ ] // // This testcase will Verify Quick Fill Preferences for converted file.
		[ ] // //
		[ ] // // PARAMETERS:			None
		[ ] // // 
		[ ] // RETURNS:				Pass 	if Quick fill Preferences is available for new file
		[ ] //							Fail	      if Quick fill Preferences is not available for new file
		[ ] // // 
		[ ] // // REVISION HISTORY:	
		[ ] // // 11/02/2013  	Created By	Indrajit Deshmukh
	[ ] // //*********************************************************
[+] testcase Test08_VerifyQuickFillPreferencesMigration() appstate none 
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
		[ ] STRING sHandle,sActual
	[ ] 
	[ ] 
	[ ] // Quicken is launched
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] SelectPreferenceType("Data entry and Quickfill")
		[+] if (Preferences.RemoveMemorizedPayeesNotUsed.Exists(5))
			[ ] ReportStatus("Verify Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences", PASS, "Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences")
		[+] else
			[ ] ReportStatus("Verify Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences", FAIL, "Remove memorized payees not used in last  months is not exists in Data entry & Quick Fill preferences ")
		[ ] 
		[ ] 
		[ ] Preferences.OK.Click()
		[ ] WaitForState(Preferences,FALSE,20)
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
	[ ] // 
[ ] // //############################################################################
[ ] 
[+] //############## Verify default menu mode for new user  #################################################### 
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test01_Verify default menu mode for new user()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will check enable classic menu mode in Prefernces for Converted file.
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Use classic menu is unchecked		
		[ ] //							Fail	      if Use classic menu is checked
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 07/02/2013  	Created By	Indrajit Deshmukh
	[ ] //*********************************************************
[+] testcase Test01_VerifyDefaultMenuModeForNewUser() appstate none
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
		[ ] INTEGER iCreateDataFile,iRegistration
		[ ] STRING sFileName = "Register Test"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] 
	[ ] 
	[ ] 
	[ ] // Create Data File
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[ ] 
	[ ] // Report Staus If Data file Created successfully
	[+] if ( iCreateDataFile==PASS )
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sDataFile} is created")
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] iResult=SelectPreferenceType("Navigation")
		[+] if (iResult==PASS)
			[ ] Preferences.SetActive()
			[ ] //To check Use classic menu checkbox is unchecked
			[ ] bCheck=False
			[ ] bCheck=Preferences.UseClassicMenus.IsChecked()
			[+] if (bCheck==FALSE)
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", PASS, "Use Classic menu checkbox is unchecked ")
			[+] else
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", FAIL, "Use Classic menu checkbox is checked")
				[ ] 
			[ ] //To check Use Popup registers is available in Preferences.
			[ ] Preferences.SetActive()
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences, false,1)
			[ ] SelectPreferenceType("Register")
			[+] if (Preferences.UsePopUpRegisters.Exists(5))
				[ ] ReportStatus("Verify UsePopUpRegisters checkbox is exists in Register Preferences", PASS, "UsePopUpRegisters checkbox exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify UsePopUpRegisters checkbox is exists in Register Preferences", FAIL, "UsePopUpRegisters checkbox does not exist in Register Preferences ")
			[ ] 
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
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] //############## Verify Register display in Classic menu mode  #################################################### 
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test04_Verify Register display in Classic menu mode ()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will check enable classic menu mode in Preferences for New  file.
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Register display in the Respective mode	
		[ ] //							Fail	     	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 08/02/2013  	Created By	Indrajit Deshmukh
	[ ] //*********************************************************
[+] testcase Test04_VerifyRegisterDisplayinClassicMenuMode() appstate none
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
		[ ] INTEGER iCreateDataFile,iRegistration,iAddAccount, iClickAssetAccount
		[ ] LIST OF ANYTYPE  lsAccountData,lsExcelData,lsAddAccount
		[ ] STRING sFileName = "Register Test"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sRegisterExcelsheet = "BankingRegister"
		[ ] STRING sAccountWorksheet = "Account"
		[ ] STRING sActual, sAccountName = "Checking Account"
		[ ] BOOLEAN bMatch
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[-] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] // Report Staus If Data file Created successfully
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] 
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] // NavigateQuickenTab(sTAB_HOME)
			[ ] // QuickenMainWindow.QWNavigator.Accounts.Click()
			[ ] 
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] // Fetch 1st row from the given sheet
			[ ] lsAddAccount=lsExcelData[1]
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2], lsAddAccount[3])
			[ ] 
			[ ] SelectPreferenceType("Navigation")
			[ ] Preferences.UseClassicMenus.Check()
			[ ] Preferences.OK.Click()
			[ ] QuickenWindow.View.Click()
			[ ] bCheck=QuickenWindow.View.ClassicMenus.IsChecked
			[+] if (bCheck==TRUE)
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", PASS, "Use Classic menu is enabled ")
			[+] else
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", FAIL, "Use Classic menu is not enabled")
			[ ] QuickenWindow.TypeKeys(KEY_ESC)
			[ ] SelectPreferenceType("Register")
			[ ] Preferences.UsePopUpRegisters.Check()
			[ ] Preferences.OK.Click()
			[ ] QuickenWindow.View.Click()
			[ ] bCheck=QuickenWindow.View.UsePopUpRegisters.IsChecked
			[+] if (bCheck==TRUE)
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", PASS, "Use PopUp Registers is enabled")
			[+] else
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", FAIL, "Use PopUp Registers checkbox is not enabled")
				[ ] 
			[ ] QuickenWindow.TypeKeys(KEY_ESC)
			[ ] //For selecting the checking account in the Account Bar
			[ ] iClickAssetAccount = AccountBarSelect(ACCOUNT_BANKING,1)
			[+] if (iClickAssetAccount==PASS)
				[ ] ReportStatus("Validate Checking account is selected", PASS, "Checking account is selected")
			[+] else
				[ ] ReportStatus("Validate Checking account is selected", FAIL, "Checking account is not selected")
			[ ] 
			[+] if(BankingPopUp.Exists(5))
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", PASS, "Use PopUp Registers is enabled")
			[+] else
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", FAIL, "Use PopUp Registers checkbox is not enabled")
				[ ] 
			[ ] 
			[ ] //To disable Popup register
			[ ] // UsePopupRegister("OFF")
			[ ] QuickenWindow.View.Click()
			[ ] QuickenWindow.View.UsePopUpRegisters.Click()
			[ ] 
			[ ] sleep(2)
			[ ] AccountBarSelect(ACCOUNT_BANKING,1)
			[ ] sleep(2)
			[ ] sActual=QuickenMainWindow.GetCaption()
			[ ] bMatch = MatchStr("*{sAccountName}*", sActual)
			[ ] sleep(1)
			[+] if(bMatch)
				[ ] ReportStatus("Validate Checking Account display in Document Register mode", PASS, " Checking Account display in Document Register mode")
			[+] else
				[ ] ReportStatus("Validate Checking Account display in Document Register moder", FAIL, "Checking Account is not display in Document Register mode")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] // Report Staus If Data file is not Created 
		[+] else if ( iCreateDataFile ==FAIL)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // Report Staus If Data file already exists
		[+] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
			[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] //############## Verify Popup Mode - Register not available in Start-up #################################################### 
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test05_Verify Popup Mode - Register not available in Start-up ()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will check Popup Mode - Register not available in Start-up 
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Register display in the Respective mode	
		[ ] //							Fail	     	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 07/02/2013  	Created By	Indrajit Deshmukh
	[ ] //*********************************************************
[+] testcase Test05_VerifyPopupModeRegisternotavailableinStartup() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
		[ ] INTEGER iCreateDataFile,iRegistration,iAddAccount, iClickAssetAccount
		[ ] LIST OF ANYTYPE  lsAccountData,lsExcelData,lsAddAccount
		[ ] STRING sFileName = "Register Test"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sRegisterExcelsheet = "BankingRegister"
		[ ] STRING sAccountWorksheet = "Account"
		[ ] STRING sActual, sAccountName = "Checking Account"
		[ ] BOOLEAN bMatch
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] // Report Staus If Data file Created successfully
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] 
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
			[ ] // Fetch 1st row from the given sheet
			[ ] lsAddAccount=lsExcelData[1]
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2], lsAddAccount[3])
			[ ] 
			[ ] 
			[ ] 
			[ ] //Enable Classic menus
			[ ] SelectPreferenceType("Navigation")
			[ ] Preferences.UseClassicMenus.Check()
			[ ] bCheck=Preferences.UseClassicMenus.IsChecked()
			[+] if (bCheck==TRUE)
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", PASS, "Use Classic menu is enabled ")
			[+] else
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", FAIL, "Use Classic menu is not enabled")
			[ ] 
			[ ] //Close preferences
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,20)
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify if Pop Up registers are enabled
			[+] SelectPreferenceType("Register")
				[ ] bCheck=Preferences.UsePopUpRegisters.IsChecked()
			[+] if (bCheck==FALSE)
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", PASS, "Use PopUp Registers is enabled")
			[+] else
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", FAIL, "Use PopUp Registers checkbox is not enabled")
			[ ] 
			[ ] 
			[ ] //Enable pop Up registers
			[ ] Preferences.UsePopUpRegisters.Check()
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,20)
			[ ] 
			[ ] 
			[ ] 
			[ ] //For selecting the checking account in the Account Bar
			[ ] iClickAssetAccount = AccountBarSelect(ACCOUNT_BANKING,1)
			[+] if (iClickAssetAccount==PASS)
				[ ] ReportStatus("Validate Checking account is selected", PASS, "Checking account is selected")
			[+] else
				[ ] ReportStatus("Validate Checking account is selected", FAIL, "Checking account is not selected")
			[ ] 
			[+] if(BankingPopUp.Exists(5))
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", PASS, "Use PopUp Registers is enabled")
			[+] else
				[ ] ReportStatus("Validate Use PopUp Registers checkbox is enabled", FAIL, "Use PopUp Registers checkbox is not enabled")
				[ ] 
			[ ] 
			[ ] 
			[ ] //To disable Popup register
			[ ] // UsePopupRegister("OFF")
			[ ] QuickenWindow.View.Click()
			[ ] QuickenWindow.View.UsePopUpRegisters.Click()
			[ ] 
			[ ] sleep(2)
			[ ] AccountBarSelect(ACCOUNT_BANKING,1)
			[ ] sleep(2)
			[ ] sActual=QuickenMainWindow.GetCaption()
			[ ] bMatch = MatchStr("*{sAccountName}*", sActual)
			[ ] sleep(1)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Checking Account display in Document Register mode", PASS, " Checking Account display in Document Register mode")
			[+] else
				[ ] ReportStatus("Validate Checking Account display in Document Register moder", FAIL, "Checking Account is not display in Document Register mode")
			[ ] 
			[ ] //Uncheck classic Menus
			[ ] SelectPreferenceType("Navigation")
			[ ] Preferences.UseClassicMenus.Uncheck()
			[ ] bCheck=Preferences.UseClassicMenus.IsChecked()
			[+] if (bCheck==FALSE)
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", PASS, "Use Classic menu is unchecked ")
			[+] else
				[ ] ReportStatus("Validate Use Classic menu checkbox is checked", FAIL, "Use Classic menu is checked")
			[ ] 
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,20)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] // Report Staus If Data file is not Created 
		[+] else if ( iCreateDataFile ==FAIL)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // Report Staus If Data file already exists
		[+] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] //############## Verify Register preferences for New file  #################################################### 
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test07_Register preferences for New file()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will check Register preferences for New file
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass   if all the Register settings exists in preferences 
		[ ] //							Fail	     if all the Register settings are not exists in preferences 
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 08/02/2013  	Created By	Indrajit Deshmukh
	[ ] //*********************************************************
[+] testcase Test07_RegisterPreferencesForNewFile() appstate none
	[+] // Variable declaration
		[ ] BOOLEAN bCheck
		[ ] INTEGER iCreateDataFile,iRegistration,iAddAccount, iClickAssetAccount
		[ ] STRING sFileName = "Register Test"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] // Report Staus If Data file Created successfully
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] 
			[ ] 
			[ ] SelectPreferenceType("Register")
			[ ] //To check Register fields section in Preferences
			[+] if (Preferences.RegisterFieldsText.Exists(1))
				[ ] ReportStatus("Verify Register Fields label is exists in Register Preferences", PASS, "Register Fields label is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify Register Fields label is exists in Register Preferences", FAIL, "Register Fields label is not exists in Register Preferences ")
			[+] if (Preferences.ShowDateBeforeCheckNumber.Exists(1))
				[ ] ReportStatus("Verify ShowDateBeforeCheckNumber checkbox is exists in Register Preferences", PASS, "ShowDateBeforeCheckNumber checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify ShowDateBeforeCheckNumber checkbox is exists in Register Preferences", FAIL, "ShowDateBeforeCheckNumber checkbox is not exists in Register Preferences ")
			[+] if (Preferences.ShowMemoBeforeCategory.Exists(1))
				[ ] ReportStatus("Verify ShowMemoBeforeCategory checkbox is exists in Register Preferences", PASS, "ShowMemoBeforeCategory checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify ShowMemoBeforeCategory checkbox is exists in Register Preferences", FAIL, "ShowMemoBeforeCategory checkbox is not exists in Register Preferences ")
				[ ] 
				[ ] //To check Transactions Entry section in Preferences
			[+] if (Preferences.TransactionEntryText.Exists(1))
				[ ] ReportStatus("Verify Transaction Entry label is exists in Register Preferences", PASS, "Transaction Entry label is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify Transaction Entry label is exists in Register Preferences", FAIL, "Transaction Entry label is not exists in Register Preferences ")
			[+] if (Preferences.AutomaticallyEnterSplitData.Exists(1))
				[ ] ReportStatus("Verify AutomaticallyEnterSplitData checkbox is exists in Register Preferences", PASS, "AutomaticallyEnterSplitData checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify AutomaticallyEnterSplitData checkbox is exists in Register Preferences", FAIL, "AutomaticallyEnterSplitData checkbox is not exists in Register Preferences ")
				[ ] 
			[+] if (Preferences.AutomaticallyPlaceDecimalPoint.Exists(1))
				[ ] ReportStatus("Verify AutomaticallyPlaceDecimalPoint checkbox is exists in Register Preferences", PASS, "AutomaticallyPlaceDecimalPoint checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify AutomaticallyPlaceDecimalPoint checkbox is exists in Register Preferences", FAIL, "AutomaticallyPlaceDecimalPoint checkbox is not exists in Register Preferences ")
				[ ] 
				[ ] //To check Register Appearence section in Preferences
			[+] if (Preferences.RegisterAppearanceText.Exists(1))
				[ ] ReportStatus("Verify Register Appearance label is exists in Register Preferences", PASS, "Register Appearance  label is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify Register Appearance  label is exists in Register Preferences", FAIL, "Register Appearance  label is not exists in Register Preferences ")
			[ ] 
			[+] if (Preferences.GrayReconciledTransactions.Exists(1))
				[ ] ReportStatus("Verify GrayReconciledTransactions checkbox is exists in Register Preferences", PASS, "GrayReconciledTransactions checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify GrayReconciledTransactions checkbox is exists in Register Preferences", FAIL, "GrayReconciledTransactions checkbox is not exists in Register Preferences ")
			[ ] 
			[+] if (Preferences.RememberRegisterFiltersAfterQuickenCloses.Exists(1))
				[ ] ReportStatus("Verify RememberRegisterFiltersAfterQuickenCloses checkbox is exists in Register Preferences", PASS, "RememberRegisterFiltersAfterQuickenCloses checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify RememberRegisterFiltersAfterQuickenCloses checkbox is exists in Register Preferences", FAIL, "RememberRegisterFiltersAfterQuickenCloses checkbox is not exists in Register Preferences ")
				[ ] 
			[+] if (Preferences.UsePopUpRegisters.Exists(1))
				[ ] ReportStatus("Verify UsePopUpRegisters checkbox is exists in Register Preferences", PASS, "UsePopUpRegisters checkbox is exists in Register Preferences")
			[+] else
				[ ] ReportStatus("Verify UsePopUpRegisters checkbox is exists in Register Preferences", FAIL, "UsePopUpRegisters checkbox is not exists in Register Preferences ")
			[ ] 
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,20)
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] // Report Staus If Data file is not Created 
		[+] else if ( iCreateDataFile ==FAIL)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // Report Staus If Data file already exists
		[+] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
			[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] // //############## Verify Quick Fill Preferences - New File  ####################################################
	[ ] // //*********************************************************
	[+] // // TestCase Name:	 Test09_Verify Quick Fill Preferences - New File  ()
		[ ] // // 
		[ ] // // DESCRIPTION:			
		[ ] // // This testcase will Verify Quick Fill Preferences - New File 
		[ ] // //
		[ ] // // PARAMETERS:			None
		[ ] // // 
		[ ] // // RETURNS:				Pass 	if Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences
		[ ] // //							Fail	      if any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:	
		[ ] // // 11/02/2013  	Created By	Indrajit Deshmukh
	[ ] // //*********************************************************
[+] testcase Test09_VerifyQuickFillPreferencesNewFile() appstate none
	[+] // Variable declaration
		[ ] STRING sHandle,sActual
		[ ] INTEGER iCreateDataFile,iRegistration
		[ ] STRING sFileName = "Register Test"
		[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] 
		[ ] 
		[ ] 
		[ ] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] // Report Staus If Data file Created successfully
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] 
			[ ] 
			[ ] //To select Data entry & Quick Fill preferences
			[ ] SelectPreferenceType("Data entry and Quickfill")
			[ ] 
			[+] if (Preferences.RemoveMemorizedPayeesNotUsed.Exists(5))
				[ ] ReportStatus("Verify Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences", PASS, "Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences")
			[+] else
				[ ] ReportStatus("Verify Remove memorized payees not used in last  months is exists in Data entry & Quick Fill preferences", FAIL, "Remove memorized payees not used in last  months is not exists in Data entry & Quick Fill preferences ")
			[ ] 
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,20)
			[ ] 
			[ ] 
			[ ] 
		[ ] // Report Staus If Data file is not Created 
		[+] else if ( iCreateDataFile ==FAIL)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // Report Staus If Data file already exists
		[+] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] // 
[ ] // //############################################################################
[ ] 
