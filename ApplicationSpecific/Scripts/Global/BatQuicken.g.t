[ ] 
[-] // *** DATA DRIVEN ASSISTANT Section (!! DO NOT REMOVE !!) ***
	[ ] use "datadrivetc.inc"
	[ ] use "BatQuicken.t"
	[ ] 
	[ ] // *** DSN ***
	[ ] STRING gsDSNConnect = "DSN=Silk DDA Excel;DBQ=D:\Quicken\ApplicationSpecific\Data\TestData\DataDrivenXLS\BatData.xls;UID=;PWD=;"
	[ ] 
	[ ] // *** Global record for each testcase ***
	[ ] 
	[-] type REC_DATALIST_DD_Test07_AddCategory is record
		[ ] REC_Category_ recCategory_  //Category$, 
	[ ] 
	[-] type REC_DATALIST_DD_Test06_AddTransaction is record
		[ ] REC_Transaction_ recTransaction_  //Transaction$, 
	[ ] 
	[-] type REC_DATALIST_DD_Test05_AddCheckingAccount is record
		[ ] REC_Account_ recAccount_  //Account$, 
	[ ] 
	[ ] // *** Global record for each Table ***
	[ ] 
	[-] type REC_Category_ is record
		[ ] STRING CategoryName  //CategoryName, 
		[ ] STRING CategoryType  //CategoryType, 
		[ ] STRING CategoryDescription  //CategoryDescription, 
	[ ] 
	[-] type REC_Transaction_ is record
		[ ] DATETIME TransactionDate  //TransactionDate, 
		[ ] STRING PayeeName  //PayeeName, 
		[ ] REAL Amount  //Amount, 
		[ ] STRING TransactionMode  //TransactionMode, 
		[ ] STRING PaymentBalance  //PaymentBalance, 
		[ ] STRING WindowType  //WindowType, 
		[ ] STRING Memo  //Memo, 
		[ ] STRING Tag  //Tag, 
		[ ] STRING ChequeNo  //ChequeNo, 
	[ ] 
	[-] type REC_Account_ is record
		[ ] STRING BATFileName  //BATFileName, 
		[ ] STRING AccountType  //AccountType, 
		[ ] DATETIME AccountCreateDate  //AccountCreateDate, 
		[ ] STRING AccountBalance  //AccountBalance, 
		[ ] STRING AccountName  //AccountName, 
	[ ] 
	[ ] // *** Global record containing sample data for each table ***
	[ ] // *** Used when running a testcase with 'Use Sample Data from Script' checked ***
	[ ] 
	[ ] // *** End of DATA DRIVEN ASSISTANT Section ***
	[ ] 
[ ] 
[+] //############# Create New Checking Account ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 DD_Test05_AddCheckingAccount()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will add Checking Account - Checking01.
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		if account is added without any errors						
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 6, 2010		Mamta Jain created	
	[ ] // *********************************************************
[+] testcase DD_Test05_AddCheckingAccount (REC_DATALIST_DD_Test05_AddCheckingAccount rData) appstate QuickenBaseState
	[ ] 
	[ ] WriteHeader()
	[ ] 
	[ ] INTEGER iAddAccount
	[ ] STRING sDate = FormatDateTime(rData.recAccount_.AccountCreateDate, "mm/dd/yyyy")
	[ ] 
	[+] if(ProductRegistration.Exists())
		[ ] ProductRegistration.Close()
	[ ] 
	[+] if (Quicken2011RentalPropertyM.Exists() == True)
		[ ] iAddAccount = AddManualSpendingAccount(rData.recAccount_.AccountType, rData.recAccount_.AccountName, rData.recAccount_.AccountBalance, sDate)
		[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {rData.recAccount_.AccountName} is created")
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] WriteFooter(CURRENT_TEST_STATUS)
	[ ] 
[ ] 
[+] //############# Create New Transaction and validate Ending Balance ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 DD_Test06_AddTransaction()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will add transaction to checking account and confirm Ending Balance.
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		if no error occurs while adding transaction 							
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 6, 2010		Mamta Jain created	
	[ ] // *********************************************************
[+] testcase DD_Test06_AddTransaction (REC_DATALIST_DD_Test06_AddTransaction rData) appstate QuickenBaseState
	[ ] 
	[ ] STRING sResult
	[ ] sResult = ReadTCStatus(sTestCaseStatusFile,  "DD_Test05_AddCheckingAccount")
	[-] if(sResult == "PASSED")		// check status of TC #5, i.e. add checking account
		[ ] 
		[ ] WriteHeader()
		[ ] 
		[ ] BOOLEAN bBalanceCheck
		[ ] INTEGER iAddTransaction, iSelect
		[ ] STRING sActual, sDate
		[ ] sDate = FormatDateTime(rData.recTransaction_.TransactionDate , "mm/dd/yyyy")
		[ ] 
		[-] if (Quicken2011RentalPropertyM.Exists() == True)
			[ ] iSelect = AccountBarSelect("Banking", 1)	// This will click  first Banking account on AccountBar
			[ ] ReportStatus("Account select from account bar", iSelect, "Select Account {sAccountName}") 
			[ ] 
			[-] if (BankingMDI.Exists())
				[ ] iAddTransaction= AddCheckingTransaction(rData.recTransaction_.WindowType, rData.recTransaction_.TransactionMode, Str(rData.recTransaction_.Amount, NULL, 2), sDate)
				[ ] ReportStatus("Add Transaction", iAddTransaction, "{rData.recTransaction_.TransactionMode} Transaction of Amount {Str(rData.recTransaction_.Amount, NULL, 2)} is added") 
				[ ] 
				[ ] // Verify Ending balance after transaction is added
				[ ] sActual = BankingMDI.StaticText1.Balance.GetText()
				[ ] bBalanceCheck = AssertEquals(rData.recTransaction_.PaymentBalance, sActual)
				[-] if (bBalanceCheck == TRUE)
					[ ] ReportStatus("Validate Ending Balance", PASS, "Ending Balance -  {sActual} is correct") 
				[-] else
					[ ] ReportStatus("Validate Ending Balance", FAIL, "Actual -  {sActual} is not matching with Expected - {rData.recTransaction_.PaymentBalance}") 
				[ ] 
			[-] else
				[ ] ReportStatus("Account Page open", FAIL, "{sAccountName} Account is not opened") 
		[-] else
			[ ] ReportStatus("Add New Transaction", FAIL, "Quicken is not available") 
		[ ] 
		[ ] WriteFooter(CURRENT_TEST_STATUS)
	[ ] 
	[-] else
		[ ] ReportStatus("Validate Dependent Test  Status ", FAIL, "'DD_Test06_AddTransaction' is not executed as it is dependent on 'DD_Test05_AddCheckingAccount'")
	[ ] 
[ ] 
[+] //############# Create New Category and validate Category Count ############# 
	[ ] // ********************************************************
	[+] // TestCase Name:	 DD_Test07_AddCategory()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will add new category to the category list and check its existence.
		[ ] // 
		[ ] // PARAMETERS:	none
		[ ] // 
		[ ] // RETURNS:			Pass 		if no error occurs while adding category							
		[ ] // 						Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dec 6, 2010		Mamta Jain created	
	[ ] // *********************************************************
[+] testcase DD_Test07_AddCategory (REC_DATALIST_DD_Test07_AddCategory rData) appstate QuickenBaseState
	[ ] 
	[ ] WriteHeader()
	[ ] 
	[ ] INTEGER iAddCategory
	[ ] 
	[-] if (Quicken2011RentalPropertyM.Exists() == True)
		[ ] iAddCategory = AddCategory(rData.recCategory_.CategoryName, rData.recCategory_.CategoryType, rData.recCategory_.CategoryDescription)
		[ ] ReportStatus("Create Category", iAddCategory, " New {rData.recCategory_.CategoryType} Category {rData.recCategory_.CategoryName} add")
	[-] else
		[ ] ReportStatus("Add New Category", FALSE, "Quicken is not available") 
	[ ] 
	[ ] WriteFooter(CURRENT_TEST_STATUS)
	[ ] 
