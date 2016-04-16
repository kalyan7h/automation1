[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[+] // Variable Declaration
	[ ] 
	[ ] LIST OF ANYTYPE lsAddAccount, lsExcelData, lsTransaction, lsReportNames,lsAccount,lsAmountData,lsListBoxItems,lsTemp ,lsTxnExcelData
	[ ] INTEGER iAmount ,iSwitchState,iSelect,iResult,iNum
	[ ] LIST OF ANYTYPE  lsIncomeCategory,lsExpenseCategory,lsCategory,lsActualListContents
	[ ] NUMBER nAmount,nAmount1,nAmount2,nAmountTotal,nActualAmount,nAmountDifferenceActual ,nAmountDifferenceExpected
	[ ] 
	[ ] public INTEGER iClickAccount,iCreateFile,iPopupRegister,itest
	[ ] STRING sAccountType
	[ ] 
	[ ] 
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
[ ] 
[ ] 
[+] //#############  Verify Quicken Asset Account Rgister ####################################### 
	[ ] // ********************************************************
	[+] // TestCase Name:Test01_AssetAccountRgister()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify Asset Account Register opens as Pop up  
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:  07/2/2013  Created By	Abhijit Sarma
		[ ] //	  
	[ ] // ********************************************************
	[ ] 
[+] testcase Test17_AssetAccountRegister () appstate QuickenBaseState 
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sEstimatedValue,sWindowType,sTransactionType,sAmount,sPayee
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
		[ ] sAccType ="House"
		[ ] sAccName ="House Account1"
		[ ] sPrice="1000"
		[ ] sEstimatedValue="1050"
		[ ] sWindowType = "PopUp"
		[ ] sTransactionType = "Payment"
		[ ] sAmount = "50"
		[ ] sPayee = "Test Payee"
		[ ] 
	[ ] 
	[ ] 
	[ ] SetUp_AutoApi()
	[ ] 
	[ ] // Create new data file
	[ ] iCreateFile = DataFileCreate(sFileName)
	[ ] 
	[+] if ( iCreateFile  == PASS)
		[ ] ReportStatus("Create new data file {sFileName}", iCreateFile, "Data file -  {sFileName} is created")
		[ ] 
		[ ] // Add Asset Account
		[ ] iAddAccount = AddPropertyAccount(sAccType, sAccName,sDateStamp,sPrice,sEstimatedValue)
		[+] if ( iAddAccount  == PASS)
			[ ] ReportStatus("Add Asset Account ", PASS, "Account -  {sAccName} is created")
			[ ] // On Popup Register
			[ ] iPopupRegister=UsePopupRegister("ON")
			[+] if (iPopupRegister==PASS)
				[ ] // Open the Asset Account register from ccount Bar
				[ ] iClickAccount = AccountBarSelect(ACCOUNT_PROPERTYDEBT,1)
				[ ] //get the caption of the popo up register
				[ ] sCaption = BankingPopUp.Getproperty("Caption")
				[ ] 
				[ ] //Match the caption and account name
				[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
					[ ] iAddTransaction =  AddPropertyTransaction(sWindowType,sTransactionType,sAmount,sDateStamp,sPayee)
					[+] if (iAddTransaction==PASS)
						[ ] ReportStatus("Add Asset Transaction",PASS,"Asset Transaction Added")
					[+] else
						[ ] ReportStatus("Add Asset Transaction",FAIL,"Asset Transaction Not Added")
				[+] else
					[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
			[+] else
				[ ] ReportStatus("Verify  PopupRegister mode", FAIL, "PopupRegister mode couldn't be set ON")
			[ ] 
			[ ] 
		[ ] //Report Staus If Data file is not Created 
		[+] else
			[ ] ReportStatus("Add Asset  Account", FAIL, "Account -  {sAccName} is not created ")
		[ ] 
		[ ] 
		[+] if (BankingPopUp.Exists(3))
			[ ] BankingPopUp.SetActive()
			[ ] BankingPopUp.Close()
		[ ] 
		[ ] UsePopupRegister("OFF")
		[ ] 
		[ ] 
	[ ] //Report Staus If Data file is not Created 
	[+] else
		[ ] ReportStatus("Data fle not created ", iCreateFile, "Data file -  {sFileName} is created but it is not Opened")
		[ ] 
	[ ] 
	[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[+] //#############  Verify Quicken Vehicle Account Rgister ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:Test02_VehicleAccountRgister()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify Vehicle Account Register opens as Pop up  
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:  07/2/2013  Created By	Abhijity Sarma
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test18_VehicleAccountRegister () appstate none 
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sEstimatedValue,sVehicleYear,sWindowType,sTransactionType,sAmount,sPayee
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
			[ ] sAccType ="Vehicle"
			[ ] sAccName ="My Vehicle Account"
			[ ] sPrice="1000"
			[ ] sEstimatedValue="1050"
			[ ] sVehicleYear = "2012"
			[ ] sWindowType = "PopUp"
			[ ] sTransactionType = "Payment"
			[ ] sAmount = "50"
			[ ] sPayee = "Test Payee"
		[ ] 
	[ ] 
	[ ] // Add Vehicle Account
	[ ] iAddAccount = AddPropertyAccount(sAccType, sAccName,sDateStamp,sPrice,sEstimatedValue,"",sVehicleYear)
	[ ] 
	[+] if ( iAddAccount  == PASS)
		[ ] ReportStatus("Add vehicle Account ", PASS, "Account -  {sAccName} is created")
	[ ] 
	[+] else
		[ ] ReportStatus("Add vehicle Account ", FAIL, "Account -  {sAccName} is not created ")
	[ ] 
	[ ] // On Popup Register
	[ ] iPopupRegister = UsePopupRegister("ON")
	[ ] ReportStatus("Popup Register ON",iPopupRegister,"Popup Register ON")
	[ ] 
	[ ] // Open the Vehicle  Account register from Acount Bar
	[ ] iClickAccount = SelectAccountFromAccountBar(sAccName, ACCOUNT_PROPERTYDEBT)
	[ ] //Get the caption of the popo up register
	[ ] sCaption = BankingPopUp.Getproperty("Caption")
	[ ] 
	[ ] //Match the caption and account name
	[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
	[+] if(bMatch == TRUE)
		[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
	[+] else
		[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
	[ ] 
	[ ] iAddTransaction =  AddPropertyTransaction(sWindowType,sTransactionType,sAmount,sDateStamp,sPayee)
	[ ] ReportStatus("Add Vehicle Transaction",iAddTransaction,"Vehicle Transaction Added")
	[+] if (BankingPopUp.Exists(3))
		[ ] BankingPopUp.SetActive()
		[ ] BankingPopUp.Close()
	[ ] 
	[ ] UsePopupRegister("OFF")
	[ ] 
	[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[+] //#############  Verify Quicken Other Asset Account Rgister ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:Test01_AssetAccountRgister()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify Other Asset Account Register opens as Pop up  
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:  07/2/2013  Created By	Abhijity Sarma
		[ ] //	  
	[ ] // ********************************************************
	[ ] 
[+] testcase Test19_OtherAssetAccountRegister () appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sEstimatedValue,sWindowType,sTransactionType,sAmount,sPayee
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
		[ ] sAccType ="Other Asset"
		[ ] sAccName ="Other Asset Account"
		[ ] sEstimatedValue="1050"
		[ ] sPrice="1000"
		[ ] sWindowType = "PopUp"
		[ ] sAmount = "50"
		[ ] sPayee = "Test Payee"
		[ ] 
		[ ] 
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] // Add Other Type Asset Account
			[ ] iAddAccount = AddPropertyAccount(sAccType, sAccName,sDateStamp,sPrice,sEstimatedValue)
			[+] if ( iAddAccount  == PASS)
				[ ] ReportStatus("Add property Account- Other Type Asset Account ", PASS, "Account -  {sAccName} is created")
			[ ] //Report Staus If Data file is not Created 
			[+] else
				[ ] ReportStatus("Add property Account- Other Type Asset Account ", FAIL, "Account -  {sAccName} is not created ")
			[ ] 
			[ ] // On Popup Register
			[ ] iPopupRegister = UsePopupRegister("ON")
			[ ] ReportStatus("Popup Register ON",iPopupRegister,"Popup Register ON")
			[ ] 
			[ ] // Open the Other Asset Account register from ccount Bar
			[ ] iClickAccount = SelectAccountFromAccountBar(sAccName ,ACCOUNT_PROPERTYDEBT)
			[ ] //Get the caption of the popo up register
			[ ] sCaption = BankingPopUp.Getproperty("Caption")
			[ ] 
			[ ] //Match the caption and account name
			[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
			[+] else
				[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
			[ ] 
			[ ] iAddTransaction =  AddPropertyTransaction("PopUp","Payment","50",sDateStamp,"XYZ","ABC")
			[ ] ReportStatus("Add Property Transaction",iAddTransaction,"Property Transaction Added")
			[+] if (BankingPopUp.Exists(3))
				[ ] BankingPopUp.SetActive()
				[ ] BankingPopUp.Close()
			[ ] 
			[ ] UsePopupRegister("OFF")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
	[ ] 
	[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[ ] //############# Verify Quicken Account Receivable Account Rgister #############################
[+] testcase Test20_AccReceivableAccountRegister () appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sEstimatedValue,sWindowType,sTransactionType,sAmount,sPayee
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
		[ ] sAccType ="Accounts Receivable"
		[ ] sAccName ="Customer Invoice Account"
		[ ] sPrice="1000"
		[ ] sEstimatedValue="1050"
		[ ] sWindowType = "PopUp"
		[ ] sTransactionType = "Payment"
		[ ] sAmount = "50"
		[ ] sPayee = "Test Payee"
		[ ] 
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] // Create new data file
			[ ] iCreateFile = DataFileCreate(sFileName)
			[ ] 
			[+] if ( iCreateFile  == PASS)
				[ ] ReportStatus("Create new data file {sFileName}", iCreateFile, "Data file -  {sFileName} is created")
				[ ] 
				[ ] // Add Account Receivable Account
				[ ] iAddAccount = AddBusinessAccount(sAccType, sAccName)
				[+] if ( iAddAccount  == PASS)
					[ ] ReportStatus("Add Business Account- Account Receivable ", PASS, "Account -  {sAccName} is created")
				[ ] //Report Staus If Data file is not Created 
				[+] else
					[ ] ReportStatus("Add Business Account- Account Receivable", FAIL, "Account -  {sAccName} is not created ")
				[ ] 
				[ ] // On Popup Register
				[ ] iPopupRegister = UsePopupRegister("ON")
				[ ] ReportStatus("Popup Register ON",iPopupRegister,"Popup Register ON")
				[ ] 
				[ ] // Open the Account Receivable register from Account Bar
				[ ] iClickAccount = SelectAccountFromAccountBar(sAccName ,ACCOUNT_BUSINESS)
				[ ] //get the caption of the popo up register
				[ ] sCaption = BankingPopUp.Getproperty("Caption")
				[ ] 
				[ ] //Match the caption and account name
				[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
				[+] else
					[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
				[ ] 
				[ ] // Add Business Transaction // Function for adding Business Transaction to be written
				[ ] // iAddTransaction =  AddBusinessTransaction(sWindowType,sTransactionType,sAmount,sDateStamp,sPayee)
				[ ] // ReportStatus("Add Business Transaction",iAddTransaction,"Business Transaction Added")
				[+] if (BankingPopUp.Exists(3))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Close()
				[ ] 
				[ ] UsePopupRegister("OFF")
				[ ] 
				[ ] 
			[ ] //Report Staus If Data file is not Created 
			[+] else
				[ ] ReportStatus("Add Data File", iCreateFile, "Data file -  {sFileName} is created but it is not Opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
		[ ] 
		[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] //############ Verify Quicken Account payable Account Rgister ################################
[+] testcase Test21_AccPayableAccountRegister () appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sEstimatedValue,sWindowType,sTransactionType,sAmount,sPayee
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
		[ ] sAccType ="Accounts Payable"
		[ ] sAccName ="Business Bill Account"
		[ ] sPrice="1000"
		[ ] sEstimatedValue="1050"
		[ ] sWindowType = "PopUp"
		[ ] sTransactionType = "Payment"
		[ ] sAmount = "50"
		[ ] sPayee = "Test Payee"
		[ ] 
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] // Add Accounts Payable Account
			[ ] iAddAccount = AddBusinessAccount(sAccType, sAccName)
			[+] if ( iAddAccount  == PASS)
				[ ] ReportStatus("Add Business Account- Account payable ", PASS, "Account -  {sAccName} is created")
			[ ] //Report Staus If Data file is not Created 
			[+] else
				[ ] ReportStatus("Add Business Account-Account payable  ", FAIL, "Account -  {sAccName} is not created ")
			[ ] 
			[ ] // On Popup Register
			[ ] iPopupRegister = UsePopupRegister("ON")
			[ ] ReportStatus("Popup Register ON",iPopupRegister,"Popup Register ON")
			[ ] 
			[ ] // Open the Asset Account register from ccount Bar
			[ ] iClickAccount = SelectAccountFromAccountBar(sAccName, ACCOUNT_BUSINESS)
			[ ] //get the caption of the popo up register
			[ ] sCaption = BankingPopUp.Getproperty("Caption")
			[ ] 
			[ ] //Match the caption and account name
			[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
			[+] else
				[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
			[ ] 
			[ ] // Add Business Transaction // Function for adding Business Transaction to be written
			[ ] // iAddTransaction =  AddBusinessTransaction(sWindowType,sTransactionType,sAmount,sDateStamp,sPayee)
			[ ] // ReportStatus("Add Business Transaction",iAddTransaction,"Business Transaction Added")
			[+] if (BankingPopUp.Exists(3))
				[ ] BankingPopUp.SetActive()
				[ ] BankingPopUp.Close()
			[ ] 
			[ ] UsePopupRegister("OFF")
		[+] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
		[ ] 
		[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[+] //#############  Verify Quicken Other Liability  Account Rgister ################################# 
	[ ] // ********************************************************
	[+] // TestCase Name:Test01_AssetAccountRgister()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify Asset Account Register opens as Pop up  
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:  07/2/2013  Created By	Abhijity Sarma
		[ ] //	  
	[ ] // ********************************************************
	[ ] 
[+] testcase Test22_OtherLiabilityAccountRegister () appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sEstimatedValue,sWindowType,sTransactionType,sAmount,sPayee
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
		[ ] sAccType ="Other Liability"
		[ ] sAccName ="New Liability Account"
		[ ] sPrice="1000"
		[ ] sEstimatedValue="1050"
		[ ] sWindowType = "PopUp"
		[ ] sTransactionType = "Payment"
		[ ] sAmount = "50"
		[ ] sPayee = "Test Payee"
		[ ] 
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] // Create new data file
			[ ] iCreateFile = DataFileCreate(sFileName)
			[ ] 
			[+] if ( iCreateFile  == PASS)
				[ ] ReportStatus("Create new data file {sFileName}", iCreateFile, "Data file -  {sFileName} is created")
				[ ] 
				[ ] // Add Asset Account
				[ ] iAddAccount = AddOtherLiabilityAccount( sAccType, sAccName, sDateStamp)
				[ ] 
				[+] if ( iAddAccount  == PASS)
					[ ] ReportStatus("Add Other liability Account ", PASS, "Account -  {sAccName} is created")
				[ ] //Report Staus If Data file is not Created 
				[+] else
					[ ] ReportStatus("Add Other liability Account", FAIL, "Account -  {sAccName} is not created ")
				[ ] 
				[ ] // On Popup Register
				[ ] iPopupRegister = UsePopupRegister("ON")
				[ ] ReportStatus("Popup Register ON",iPopupRegister,"Popup Register ON")
				[ ] 
				[ ] // Open the Asset Account register from ccount Bar
				[ ] iClickAccount = SelectAccountFromAccountBar(sAccName, ACCOUNT_PROPERTYDEBT)
				[ ] //get the caption of the popo up register
				[ ] sCaption = BankingPopUp.Getproperty("Caption")
				[ ] 
				[ ] //Match the caption and account name
				[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
				[+] else
					[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
				[ ] 
				[ ] iAddTransaction =  AddPropertyTransaction(sWindowType,sTransactionType,sAmount,sDateStamp,sPayee)
				[ ] ReportStatus("Add Liability Transaction",iAddTransaction,"Liability Transaction Added")
				[+] if (BankingPopUp.Exists(3))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Close()
				[ ] 
				[ ] UsePopupRegister("OFF")
				[ ] 
				[ ] 
			[ ] //Report Staus If Data file is not Created 
			[+] else
				[ ] ReportStatus("Data fle not created ", iCreateFile, "Data file -  {sFileName} is created but it is not Opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
		[ ] 
		[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[ ] //##################Verify Correct Window Title displayed in Account Register ####################
[+] testcase Test35_CheckingAccountRgisterTitle () appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sAccBalance,sWindowType,sTransactionType,sAmount,sChkNo,sPayee,sMemo, sCategory
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
	[+] // Variable Definition
		[ ] sWindowType="PopUp"
		[ ] sAccType ="Checking"
		[ ] sAccName ="Checking Account"
		[ ] sAccBalance="1000"
		[ ] sWindowType = "PopUp"
		[ ] sTransactionType = "Payment"
		[ ] sAmount = "50"
		[ ] sPayee = "Test Payee"
		[ ] sChkNo = "101"
		[ ] sMemo = "Memo"
		[ ] sCategory= "Auto"
		[ ] 
		[ ] 
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] SetUp_AutoApi()
			[ ] 
			[ ] // Create new data file
			[ ] iCreateFile = DataFileCreate(sFileName)
			[+] if ( iCreateFile  == PASS)
				[ ] ReportStatus("Create new data file {sFileName}", iCreateFile, "Data file -  {sFileName} is created")
				[ ] // Add Asset Account
				[ ] 
				[ ] iAddAccount = AddManualSpendingAccount(sAccType, sAccName,sAccBalance,sDateStamp)
				[+] if ( iAddAccount  == PASS)
					[ ] ReportStatus("Add Checking Account ", PASS, "Account -  {sAccName} is created")
				[ ] //Report Staus If Data file is not Created 
				[+] else
					[ ] ReportStatus("Add Checking Account ", FAIL, "Account -  {sAccName} is not created ")
					[ ] 
				[ ] //On Popup Register
				[ ] iPopupRegister = UsePopupRegister("ON")
				[ ] ReportStatus("Popup Register ON",iPopupRegister,"Popup Register ON")
				[ ] 
				[ ] //Open the Asset Account register from ccount Bar
				[ ] iClickAccount = SelectAccountFromAccountBar(sAccName, ACCOUNT_BANKING)
				[ ] 
				[ ] //get the caption of the popo up register
				[ ] sCaption = BankingPopUp.Getproperty("Caption")
				[ ] 
				[ ] //Match the caption and account name
				[ ] bMatch = MatchStr("*{sAccName}*", sCaption)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Comapre Account name in Account bar and register", PASS, "Account name {sAccName} is same in register and account bar")
				[+] else
					[ ] ReportStatus("Comapre Account name in Account bar and register", FAIL, "Account name {sAccName} is not same in register and account bar")
				[ ] // Add Transaction to register
				[ ] iAddTransaction =  AddCheckingTransaction(sWindowType,sTransactionType,sAmount,sDateStamp,sChkNo,sPayee,sMemo,sCategory)
				[ ] ReportStatus("Add Banking Transaction",iAddTransaction,"Banking Transaction Added")
				[+] if (BankingPopUp.Exists(3))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Close()
				[ ] 
				[ ] 
				[ ] UsePopupRegister("OFF")
				[ ] 
				[ ] //Report Staus If Data file is not Created 
			[+] else
				[ ] ReportStatus("Data fle not created ", iCreateFile, "Data file -  {sFileName} is created but it is not Opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
		[ ] 
		[ ] 
[ ] // //############################################################################
[ ] 
[+] //Global variables
	[ ] public STRING sStartQuicken = "{QUICKEN_ROOT}\qw.exe"
	[ ] public BOOLEAN  bExist
	[ ] 
	[ ] STRING sCCMintBankAccountId = "testuser"
	[ ] STRING sCCMintBankAccountPass = "testuser123"
	[ ] 
[ ] 
[ ] 
[+] // //###############TC93_UndoAcceptAll()###############################
	[ ] // // **************************************************************************************
	[+] // // TestCase Name:	 TC93_UndoAcceptAll()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will create a New Register.QDF
		[ ] // // This test case will verify Undo Accept All Transaction functionality
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 	   If Undo Accept All Transaction functionality works.
		[ ] // //				        Fail		   If Undo Accept All Transaction functionality does not work.
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // 	  Feb 08, 2013		Anagha Bhandare created
	[ ] // // **************************************************************************************
[+] testcase TC93_UndoAcceptAll() appstate none
	[ ] 
	[ ] integer iCreateDataFile,iAddAccount,iNavigate,iResult,iSelect,iOpenAccountRegister
	[ ] STRING sPayee = "Opening Balance",sAction = "Undo Accept All Transactions"
	[ ] STRING sAccBalanceBefore ,sAccBalanceAfter 
	[ ] STRING sCCMintBankAccountId ,sCCMintBankAccountPass
	[ ] integer iSetupAutoAPI 
	[ ] sCCMintBankAccountId="datasync"
	[ ] sCCMintBankAccountPass =sCCMintBankAccountId
	[ ] sAccountName ="MONEY MARKET XX3333"
	[ ] 
	[ ] 
	[ ] //Create Data File
	[ ] iResult = DataFileCreate(sFileName)
	[ ] //Report Staus If Data file Created successfully
	[ ] 
	[+] if(iResult==PASS)
		[ ] QuickenWindow.SetActive()
		[ ] ReportStatus("Validate Data File ", PASS , "Data file -  {sDataFile} is created")
		[ ] //Set C2R Mode On
		[ ] iResult=SetC2RMode("ON")
		[+] if(iResult==PASS)
			[ ] ReportStatus("Turn ON C2R",iResult,"C2R mode is turned ON")
			[ ] QuickenWindow.SetActive()
			[ ] iResult=AddCCMintBankAccount(sCCMintBankAccountId,sCCMintBankAccountPass,NULL,"CCBank")
			[+] if(iResult==PASS)
				[ ] // Opening Checking Account Register
				[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] 
				[+] if(iResult==PASS)
					[ ] ReportStatus("Account is selected from AccountBar", PASS , "account is selected from AccountBar")
					[ ] // 
					[ ] sleep(2)
					[ ] QuickenWindow.SetActive()
					[ ] sAccBalanceBefore=MDIClient.AccountRegister.Balances.OnlineBalance.GetText()
					[ ] 
					[ ] AcceptAll.Click ()
					[ ] sleep(5)
					[ ] QuickenWindow.SetActive()
					[ ] sAccBalanceAfter=MDIClient.AccountRegister.Balances.OnlineBalance.GetText()
					[ ] 
					[+] if(sAccBalanceBefore == sAccBalanceAfter)
						[ ] ReportStatus("Verify Balance in Account Bar after accepting transactions", PASS, "Account Balance- {sAccBalanceBefore} after accepting all transaction")
						[ ] //Right - click for Undo - Accept All 
						[ ] AccountActionsOnTransaction( sMDIWindow,"",sAction)
						[ ] 
						[ ] sleep(5)
						[ ] QuickenWindow.SetActive()
						[ ] sAccBalanceAfter=MDIClient.AccountRegister.Balances.OnlineBalance.GetText()
						[ ] // Verify that Balances is same to opening balance after Undo accept all the online transactions
						[+] if(sAccBalanceBefore == sAccBalanceAfter)
							[ ] ReportStatus("Verify Balance in Account Bar after ", PASS, "Account Balance- {sAccBalanceBefore} after undo accepting all transaction")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Balance in Account Bar", FAIL, "Account Balance- {sAccBalanceBefore} after undo accepting all transaction")
							[ ] 
						[ ] 
					[+] else
						[+] ReportStatus("Verify Balance in Account Bar", FAIL, "Account Balance- {sAccBalanceBefore} after accepting all transaction")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Account is selected from AccountBar", FAIL , "account is not selected from AccountBar")
			[+] else
				[ ] ReportStatus("Verfiy CCBank accounts added.",FAIL,"CCBank accounts couldn't be added.")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Turn ON C2R", FAIL ,"C2R mode is not turned ON")
		[ ] 
		[ ] //Report Staus If Data file is not Created 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Tax Line Item Assignment in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC98_VerifyTaxLineItemAssignmentInRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Tax Line Item Assignment option in account register and click on cancel button
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If matching transfer is selected	
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  25/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC98_VerifyTaxLineItemAssignmentInRegister_Cancel() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] STRING sTaxLineItemAssignAction="Tax Line Item Assignments"
		[ ] //BOOLEAN bMatch
		[ ] LIST OF STRING lsTaxScheduleReportContents,lsSubStringsTaxItem
		[ ] STRING sTaxItem
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsTxnExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
		[ ] 
		[ ] //BOOLEAN bMatch1,bMatch2
		[ ] 
		[ ] 
		[ ] //STRING sMoveCancelExpectedNumberOfTransactionsC1="0"
		[ ] //STRING sMoveCancelExpectedNumberOfTransactionsC2="1"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iVerify = DataFileCreate(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[ ] //Read data from excel sheet
			[ ] 
			[ ] 
			[+] if(iLoop==1)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[1]
				[ ] 
			[+] if(iLoop==2)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[2]
				[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[3]
				[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[4]
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Add Account
			[ ] iVerify = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] //Report Status if checking Account is created
			[+] if (iVerify==PASS)
				[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Select Account From Account Bar
				[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify Tax Line Item Assignment",PASS,"Account {lsAddAccount[2]} selected successfully")
					[ ] 
					[ ] 
					[ ] // Read data from excel sheet
					[ ] lsTransactionData=lsTxnExcelData[4]
					[ ] 
					[ ] //Add Checking Transaction
					[+] if(iLoop==1)
						[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDateStamp,lsTransactionData[4],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added to {lsAddAccount[2]} account") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
						[ ] 
						[ ] 
						[ ] 
					[ ] //Add Savings,Credit Card and Cash Account Transactions
					[+] if(iLoop>1)
						[ ] 
						[ ] 
						[ ] iVerify= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDateStamp,NULL,lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added to {lsAddAccount[2]} account") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
						[ ] 
						[ ] 
					[ ] 
					[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sTaxLineItemAssignAction)
					[+] if(TaxLineItemAssignments.Exists(3))
						[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{sTaxLineItemAssignAction} option is selected") 
						[ ] 
						[ ] 
						[ ] TaxLineItemAssignments.SetActive()
						[ ] //Verify Tax Item
						[ ] TaxLineItemAssignments.TaxItem.Select(12)                 
						[ ] 
						[ ] 
						[ ] TaxLineItemAssignments.Cancel.Click()
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify in Tax Schedule Report---------------------------------------------------------------------------
						[ ] 
						[ ] //Open Tax schedule report
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.Reports.Click()
						[ ] QuickenWindow.Reports.Tax.Click()
						[ ] QuickenWindow.Reports.Tax.TaxSchedule.Select()
						[ ] 
						[ ] i=TaxScheduleReport.QWListViewer1.ListBox1.GetItemCount()
						[+] if(i==1)
							[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Tax Line Item has not been assigned")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Tax Line Item has not been assigned")
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] TaxScheduleReport.Close()
						[ ] WaitForState(TaxScheduleReport,false,1)
						[ ] //clear search field
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)
						[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{sTaxLineItemAssignAction} option is not selected") 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Tax Line Item Assignment",FAIL,"Account {lsAddAccount[2]} not selected")
			[+] else
				[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "Account -  {lsAddAccount[2]}  is not added")
				[ ] 
		[ ] 
	[+] // else
		[ ] // ReportStatus("Verify Tax Line Item Assignment", FAIL, "Error during Data file creation for file -  {sFileName} ")
		[ ] 
	[ ] 
[ ] 
[ ] 
[+] // // //############# Verify Tax Line Item Assignment in Account Register ###############################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 TC99_VerifyTaxLineItemAssignmentInRegister_OK()
		[ ] // // 
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify Tax Line Item Assignment option in account register and click on OK button
		[ ] // // .
		[ ] // // 
		[ ] // // PARAMETERS:		None
		[ ] // // 
		[ ] // // RETURNS:			Pass 		 If matching transfer is selected	
		[ ] // // Fail		       If any error occurs
		[ ] // // 
		[ ] // // REVISION HISTORY:  25/2/ 2013	Created by	Dean Paes
		[ ] // // 
	[ ] // // ********************************************************
[+] testcase TC99_VerifyTaxLineItemAssignmentInRegister_OK() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,iSelectTaxItem=0,iMatchIncrement
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] STRING sTaxLineItemAssignAction="Tax Line Item Assignments"
		[ ] //BOOLEAN bMatch
		[ ] LIST OF STRING lsTaxScheduleReportContents,lsSubStringsTaxItem
		[ ] STRING sTaxItem
		[ ] 
		[ ] 
		[ ] 
		[ ] //STRING sMoveCancelExpectedNumberOfTransactionsC1="0"
		[ ] //STRING sMoveCancelExpectedNumberOfTransactionsC2="1"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
	[ ] lsTransactionData=lsExcelData[4]
	[ ] 
	[ ] //Open New Data File---------------------------------------------------------------------------------
	[ ] 
	[ ] iVerify = OpenDataFile(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Data file -  {sFileName} is opened")
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
			[ ] 
			[ ] 
			[+] if(iLoop==1)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[1]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=1
				[ ] 
			[+] if(iLoop==2)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[2]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=5
				[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[3]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=5
				[ ] 
				[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[4]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=9
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify Tax Line Item Assignment",PASS,"Account {lsAddAccount[2]} selected successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sTaxLineItemAssignAction)
				[ ] //sleep(2)
				[+] if(TaxLineItemAssignments.Exists(3))
					[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{sTaxLineItemAssignAction} option is selected") 
					[ ] 
					[ ] TaxLineItemAssignments.SetActive()
					[ ] //Verify Tax Item
					[ ] iSelectTaxItem=iSelectTaxItem+10
					[ ] TaxLineItemAssignments.TaxItem.Select(iSelectTaxItem)                 
					[ ] sTaxItem=TaxLineItemAssignments.TaxItem.GetSelText()
					[ ] 
					[ ] 
					[ ] lsSubStringsTaxItem=Split(sTaxItem,":")
					[ ] 
					[ ] TaxLineItemAssignments.OK.Click()
					[ ] 
					[ ] 
					[ ] 
					[ ] //Verify in Tax Schedule Report---------------------------------------------------------------------------
					[ ] 
					[ ] //Open Tax schedule report
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Reports.Click()
					[ ] QuickenWindow.Reports.Tax.Click()
					[ ] QuickenWindow.Reports.Tax.TaxSchedule.Select()
					[ ] 
					[ ] 
					[ ] sHandle=Str(TaxScheduleReport.QWListViewer1.ListBox1.GetHandle())
					[ ] iListCount=TaxScheduleReport.QWListViewer1.ListBox1.GetItemCount()
					[ ] 
					[ ] 
					[ ] //Match first part of tax item to report entry
					[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
						[ ] bMatch = MatchStr("*{lsSubStringsTaxItem[1]}*", sActual)
						[+] if (bMatch)
							[ ] break
					[+] if(bMatch)
						[ ] 
						[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsSubStringsTaxItem[1]} matched")
						[ ] 
						[ ] 
						[ ] //Match Second part of tax item to report entry
						[ ] sActual=NULL
						[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
							[ ] bMatch = MatchStr("*{lsSubStringsTaxItem[2]}*", sActual)
							[+] if (bMatch)
								[ ] break
							[ ] 
						[+] if(bMatch)
							[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsSubStringsTaxItem[2]} matched")
							[ ] 
							[ ] 
							[ ] //Match Account Name to report entry
							[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
								[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
								[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
								[+] if (bMatch)
									[ ] break
								[ ] 
							[+] if(bMatch)
								[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsAddAccount[2]} matched")
								[ ] 
								[ ] 
								[ ] //Match Payee Name to report entry
								[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
									[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
									[ ] bMatch = MatchStr("*{lsTransactionData[6]}*", sActual)
									[+] if (bMatch)
										[ ] break
									[ ] 
								[+] if(bMatch)
									[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsTransactionData[6]} matched")
								[+] else
									[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsTransactionData[6]} not matched")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsAddAccount[2]} matched")
								[ ] 
						[+] else
							[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsSubStringsTaxItem[1]} not matched")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsSubStringsTaxItem[2]} not matched")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] TaxScheduleReport.Close()
					[ ] WaitForState(TaxScheduleReport,false,1)
					[+] if(TaxScheduleReport.Exists(2))
						[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "Report Not Closed")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Report Closed")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{sTaxLineItemAssignAction} option is not selected") 
				[ ] 
				[ ] //clear search field
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)
				[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Tax Line Item Assignment",FAIL,"Account {lsAddAccount[2]} not selected")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "Data file -  {sFileName} not opened")
		[ ] 
[ ] 
[ ] 
[+] // //############# Verify Tax Line Item Assignment in Account Register ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC100_VerifyTaxLineItemAssignmentInRegister_New()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Tax Line Item Assignment option in account register and create new Tax line item
		[ ] // .
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		 If matching transfer is selected	
		[ ] // Fail		       If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:  25/2/ 2013	Created by	Dean Paes
		[ ] // 
	[ ] // ********************************************************
[+] testcase TC100_VerifyTaxLineItemAssignmentInRegister_New() appstate none 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,iMatchIncrement
		[ ] INTEGER iSelectTaxItem=2
		[ ] 
		[ ] STRING sActualBalanceText
		[ ] LIST OF STRING lsTransactionActual
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] STRING sTaxLineItemAssignAction="Tax Line Item Assignments"
		[ ] 
		[ ] LIST OF STRING lsTaxScheduleReportContents,lsSubStringsTaxItem
		[ ] STRING sTaxItem
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
	[ ] lsTransactionData=lsExcelData[4]
	[ ] 
	[ ] 
	[ ] 
	[ ] //Open New Data File---------------------------------------------------------------------------------
	[ ] iVerify = OpenDataFile(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "Data file -  {sFileName} is opened")
		[ ] 
		[+] for(iLoop=1;iLoop<=4;iLoop++)
			[ ] 
			[ ] //Read data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
			[ ] 
			[ ] 
			[+] if(iLoop==1)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[1]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=1
				[ ] 
			[+] if(iLoop==2)
				[ ] 
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[2]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=13
				[ ] 
			[+] if(iLoop==3)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[3]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=5
				[ ] 
				[ ] 
			[+] if(iLoop==4)
				[ ] lsAddAccount=NULL
				[ ] lsAddAccount=lsExcelData[4]
				[ ] iMatchIncrement=NULL
				[ ] iMatchIncrement=9
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify Tax Line Item Assignment",PASS,"Account {lsAddAccount[2]} selected successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sTaxLineItemAssignAction)
				[ ] //sleep(2)
				[+] if(TaxLineItemAssignments.Exists(3))
					[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{sTaxLineItemAssignAction} option is selected") 
					[ ] 
					[ ] TaxLineItemAssignments.SetActive()
					[ ] //Verify Tax Item
					[ ] iSelectTaxItem=iSelectTaxItem+10
					[ ] TaxLineItemAssignments.TaxItem.Select(iSelectTaxItem)                 
					[ ] sTaxItem=TaxLineItemAssignments.TaxItem.GetSelText()
					[ ] 
					[ ] 
					[ ] lsSubStringsTaxItem=Split(sTaxItem,":")
					[ ] 
					[ ] TaxLineItemAssignments.OK.Click()
					[ ] 
					[ ] 
					[ ] 
					[ ] //Verify in Tax Schedule Report---------------------------------------------------------------------------
					[ ] 
					[ ] //Open Tax schedule report
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Reports.Click()
					[ ] QuickenWindow.Reports.Tax.Click()
					[ ] QuickenWindow.Reports.Tax.TaxSchedule.Select()
					[ ] 
					[ ] 
					[ ] sHandle=Str(TaxScheduleReport.QWListViewer1.ListBox1.GetHandle())
					[ ] iListCount=TaxScheduleReport.QWListViewer1.ListBox1.GetItemCount()
					[+] // for(i=TaxScheduleReport.QWListViewer1.ListBox1.GetItemCount();i>=1;i--)
						[ ] // ListAppend(lsTaxScheduleReportContents, QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{i}"))
						[ ] // 
						[ ] // 
					[ ] 
					[ ] 
					[ ] //Match first part of tax item to report entry
					[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
						[ ] bMatch = MatchStr("*{lsSubStringsTaxItem[1]}*", sActual)
						[+] if (bMatch)
							[ ] break
					[+] if(bMatch)
						[ ] 
						[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsSubStringsTaxItem[1]} matched")
						[ ] 
						[ ] 
						[ ] //Match Second part of tax item to report entry
						[ ] sActual=NULL
						[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
							[ ] bMatch = MatchStr("*{lsSubStringsTaxItem[2]}*", sActual)
							[+] if (bMatch)
								[ ] break
							[ ] 
						[+] if(bMatch)
							[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsSubStringsTaxItem[2]} matched")
							[ ] 
							[ ] 
							[ ] //Match Account Name to report entry
							[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
								[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
								[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
								[+] if (bMatch)
									[ ] break
								[ ] 
							[+] if(bMatch)
								[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsAddAccount[2]} matched")
								[ ] 
								[ ] 
								[ ] //Match Payee Name to report entry
								[+] for (iCount=0 ; iCount <iListCount+1; ++iCount)
									[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCount}")
									[ ] bMatch = MatchStr("*{lsTransactionData[6]}*", sActual)
									[+] if (bMatch)
										[ ] break
									[ ] 
								[+] if(bMatch)
									[ ] ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsTransactionData[6]} matched")
								[+] else
									[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsTransactionData[6]} not matched")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsAddAccount[2]} matched")
								[ ] 
						[+] else
							[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsSubStringsTaxItem[1]} not matched")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsSubStringsTaxItem[2]} not matched")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[+] // if(bMatch==TRUE)
						[ ] // 
						[ ] // ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsSubStringsTaxItem[1]} matched")
						[ ] // 
						[ ] // 
						[ ] // //Match Second part of tax item to report entry
						[ ] // sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iMatchIncrement+1}")
						[ ] // bMatch = MatchStr("*{lsSubStringsTaxItem[2]}*", sActual)
						[ ] // sActual=NULL
						[+] // if(bMatch==TRUE)
							[ ] // ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsSubStringsTaxItem[2]} matched")
							[ ] // 
							[ ] // 
							[ ] // //Match Account Name to report entry
							[ ] // sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iMatchIncrement+2}")
							[ ] // bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
							[ ] // sActual=NULL
							[+] // if(bMatch==TRUE)
								[ ] // ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsAddAccount[2]} matched")
								[ ] // 
								[ ] // 
								[ ] // //Match Payee Name to report entry
								[ ] // 
								[ ] // sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iMatchIncrement+2}")
								[ ] // bMatch = MatchStr("*{lsTransactionData[6]}*", sActual)
								[+] // if(bMatch==TRUE)
									[ ] // ReportStatus("Verify Tax Line Item Assignment", PASS, "{lsTransactionData[6]} matched")
									[ ] // 
								[+] // else
									[ ] // ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsTransactionData[6]} not matched")
								[ ] // 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsAddAccount[2]} matched")
								[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsSubStringsTaxItem[1]} not matched")
							[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Tax Line Item Assignment", FAIL, "{lsSubStringsTaxItem[2]} not matched")
						[ ] // 
						[ ] // 
						[ ] // 
					[ ] // 
					[ ] 
					[ ] TaxSchedule.Close()
					[ ] WaitForState(TaxSchedule,false,1)
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "{sTaxLineItemAssignAction} option is not selected") 
				[ ] 
				[ ] //clear search field
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)
				[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Tax Line Item Assignment",FAIL,"Account {lsAddAccount[2]} not selected")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Tax Line Item Assignment", FAIL, "Data file -  {sFileName} not opened")
		[ ] 
[ ] 
[ ] 
[ ] 
[+] //////################Open Register Preferences From Account Actions###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC83_OpenRegisterPreferencesFromAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Preferences window is opened and Register Preferences are displayed from Account Actions window
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If Preferences window is opened and Register Preferences are displayed
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  06/3/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC83_OpenRegisterPreferencesFromAccountActions() appstate none 
	[ ] 
	[ ] 
	[+] //Variable
		[ ] INTEGER iCount,iAccountActionsOption
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] for(iLoop=1;iLoop<=4;iLoop++)
		[ ] 
		[ ] //Read data from excel sheet
		[ ] 
		[ ] 
		[ ] 
		[+] if(iLoop==1)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[1]
			[ ] iAccountActionsOption=NULL
			[ ] iAccountActionsOption=18
			[ ] 
			[ ] 
		[+] if(iLoop==2)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[2]
			[ ] iAccountActionsOption=NULL
			[ ] iAccountActionsOption=18
			[ ] 
		[+] if(iLoop==3)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[3]
			[ ] iAccountActionsOption=NULL
			[ ] iAccountActionsOption=17
			[ ] 
			[ ] 
		[+] if(iLoop==4)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[4]
			[ ] iAccountActionsOption=NULL
			[ ] iAccountActionsOption=16
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //Select Account Bar
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[ ] sleep(5)
		[+] if(iVerify==PASS)
			[ ] QuickenWindow.SetActive()
			[+] if (MDIClient.AccountRegister.Exists(5))
				[ ] ReportStatus("Register preferences",PASS,"Register displayed")
				[ ] 
				[ ] //Open Account Actions menu
				[ ] //Navigate to Account Actions> Register preferences
				[ ] NavigateToAccountActionBanking(iAccountActionsOption,sMDIWindow)
				[+] if(Preferences.Exists(3))
					[ ] ReportStatus("Register preferences",PASS,"Preferences Window displayed")
					[ ] 
					[+] if(Preferences.ShowDateBeforeCheckNumber.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"ShowDateBeforeCheckNumber checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"ShowDateBeforeCheckNumber checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.ShowMemoBeforeCategory.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"ShowMemoBeforeCategory checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"ShowMemoBeforeCategory checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.AutomaticallyEnterSplitData.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"AutomaticallyEnterSplitData checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"AutomaticallyEnterSplitData checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.AutomaticallyPlaceDecimalPoint.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"AutomaticallyPlaceDecimalPoint checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"AutomaticallyPlaceDecimalPoint checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.GrayReconciledTransactions.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"GrayReconciledTransactions checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"GrayReconciledTransactions checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.RememberRegisterFiltersAfterQuickenCloses.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"RememberRegisterFiltersAfte checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"RememberRegisterFiltersAfte checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.UsePopUpRegisters.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"UsePopUpRegisters checkbox displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"UsePopUpRegisters checkbox not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.Fonts.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"Fonts button displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"Fonts button not displayed")
						[ ] 
						[ ] 
					[ ] 
					[+] if(Preferences.Colors.Exists(3))
						[ ] ReportStatus("Register preferences",PASS,"Colors button displayed")
					[+] else
						[ ] ReportStatus("Register preferences",FAIL,"Colors button not displayed")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] Preferences.Close()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Register preferences",FAIL,"Preferences Window not displayed")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Register Preferences",FAIL,"Account {lsAddAccount[2]} is not selected")
			[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //////################Buttons Available In Register###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC83_OpenRegisterPreferencesFromAccountActions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Preferences window is opened and Register Preferences are displayed from Account Actions window
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If Preferences window is opened and Register Preferences are displayed
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  06/3/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC87_ButtonsAvailableInRegister() appstate none 
	[ ] 
	[ ] 
	[+] //Variable
		[ ] INTEGER iCount
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] for(iLoop=1;iLoop<=4;iLoop++)
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[ ] 
		[+] if(iLoop==1)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[1]
			[ ] 
			[ ] 
		[+] if(iLoop==2)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[2]
			[ ] 
		[+] if(iLoop==3)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[3]
			[ ] 
			[ ] 
		[+] if(iLoop==4)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[4]
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[+] if (MDIClient.AccountRegister.Exists(3))
				[ ] ReportStatus("Register Buttons",PASS,"Register displayed")
				[ ] 
				[ ] //Select New line
				[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_N)
				[ ] 
				[+] if(MDIClient.AccountRegister.TxList.TxToolBar.Save.Exists(2))
					[ ] ReportStatus("Register Buttons",PASS,"Transaction List Save button displayed")
				[+] else
					[ ] ReportStatus("Register Buttons",FAIL,"Transaction List Save button is not found")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[+] if(MDIClient.AccountRegister.TxList.TxToolBar.MoreActions.Exists(2))
					[ ] ReportStatus("Register Buttons",PASS,"Transaction List More Actions button displayed")
				[+] else
					[ ] ReportStatus("Register Buttons",FAIL,"Transaction List More Actions button is not found")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[+] if(MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.Exists(2))
					[ ] ReportStatus("Register Buttons",PASS,"Transaction List Split button displayed")
				[+] else
					[ ] ReportStatus("Register Buttons",FAIL,"Transaction List Save Split is not found")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Register Preferences",FAIL,"Account Register Window is not found")
				[ ] 
			[ ] 
			[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Register Preferences",FAIL,"Account {lsAddAccount[2]} is not selected")
			[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //////################Add A Flag To Transaction###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC104_AddAFlagToTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that transactions that are flagged are displayed correctly in register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If Preferences window is opened and Register Preferences are displayed
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/3/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC104_AddAFlagToTransaction() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iCount
		[ ] STRING sFlagTransactionAction="Notes and flags..."
		[ ] STRING sFlagActual  ="Blue"
		[ ] STRING sFlagExpected="Blue"
		[ ] STRING sFlaggedFilter="Flagged"
		[ ] 
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
	[ ] lsTransactionData=lsExcelData[4]
	[ ] 
	[ ] 
	[ ] 
	[+] for(iLoop=1;iLoop<=4;iLoop++)
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[ ] 
		[+] if(iLoop==1)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[1]
			[ ] 
			[ ] 
		[+] if(iLoop==2)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[2]
			[ ] 
		[+] if(iLoop==3)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[3]
			[ ] 
			[ ] 
		[+] if(iLoop==4)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[4]
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
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sFlagTransactionAction)
			[+] if(TransactionNotesAndFlags.Exists(5))
				[ ] ReportStatus("Verify Add Notes and Flags to Transactions", PASS, "{sFlagTransactionAction} option is selected") 
				[ ] TransactionNotesAndFlags.SetActive()
				[ ] 
				[ ] //Set Transaction with Flag
				[ ] TransactionNotesAndFlags.FlagThisTransaction.Click()
				[ ] TransactionNotesAndFlags.FlagColor.Select(sFlagExpected)
				[ ] sleep(1)
				[ ] TransactionNotesAndFlags.OK.DoubleClick()
				[ ] WaitForState(TransactionNotesAndFlags , false ,2)
				[ ] 
				[ ] 
				[ ] //Verify if Flagged Transaction is added
				[ ] //has to select 5 times as it was not selecting in the first attempt
				[+] for (iCount=1 ; iCount <6 ; ++iCount)
					[ ] MDIClient.AccountRegister.TransactionTypeFilter.Select(sFlaggedFilter)
					[ ] 
				[ ] sleep(1)
				[ ] VerifyTransactionInAccountRegister(lsTransactionData[6],Str(1))
				[ ] 
				[ ] 
				[ ] //Verify if correct flag is selected
				[ ] AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sFlagTransactionAction)
				[ ] TransactionNotesAndFlags.FlagColor.Click()
				[ ] sFlagActual=TransactionNotesAndFlags.FlagColor.GetSelText()
				[ ] 
				[+] if(sFlagActual==sFlagExpected)
					[ ] ReportStatus("Verify Add Notes and Flags to Transactions", PASS, "{sFlagActual} flag option selected is correct") 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Add Notes and Flags to Transactions", FAIL, "Wrong flag option {sFlagActual} is displayed instead of {sFlagExpected}") 
					[ ] 
				[ ] TransactionNotesAndFlags.Cancel.DoubleClick()
				[ ] WaitForState(TransactionNotesAndFlags , false ,2)
				[ ] //clear search field
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)
				[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Notes and Flags to Transactions", FAIL, "{sFlagTransactionAction} option selection error") 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Register Preferences",FAIL,"Account {lsAddAccount[2]} is not selected")
			[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //////################Add A Note To Transaction###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC105_AddANoteToTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that notes can be added to transactions in register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If Preferences window is opened and Register Preferences are displayed
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/3/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC105_AddANoteToTransaction() appstate none 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iCount
		[ ] STRING sFlagTransactionAction="Notes and flags..."
		[ ] STRING sNoteActual 
		[ ] STRING sNoteExpected
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] // Read transactio data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
	[ ] lsTransactionData=lsExcelData[4]
	[ ] 
	[ ] sNoteExpected="This is a note for a transaction with Payee"+ lsTransactionData[6]
	[ ] 
	[ ] 
	[+] for(iLoop=1;iLoop<=4;iLoop++)
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[ ] 
		[+] if(iLoop==1)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[1]
			[ ] 
			[ ] 
		[+] if(iLoop==2)
			[ ] 
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[2]
			[ ] 
		[+] if(iLoop==3)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[3]
			[ ] 
			[ ] 
		[+] if(iLoop==4)
			[ ] lsAddAccount=NULL
			[ ] lsAddAccount=lsExcelData[4]
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
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sFlagTransactionAction)
			[+] if(TransactionNotesAndFlags.Exists(2))
				[ ] ReportStatus("Verify Add Notes and Flags to Transactions", PASS, "{sFlagTransactionAction} option is selected") 
				[ ] 
				[ ] 
				[ ] //Set Transaction with Flag
				[ ] TransactionNotesAndFlags.SetActive()
				[+] if(TransactionNotesAndFlags.Notes.Exists(3))
					[ ] TransactionNotesAndFlags.Notes.SetText(sNoteExpected)
					[ ] TransactionNotesAndFlags.OK.DoubleClick()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Add Notes and Flags to Transactions", FAIL,"Notes Textfield not found in Transaction notes and flags window") 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Verify if correct note is added
				[ ] AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sFlagTransactionAction)
				[+] if(TransactionNotesAndFlags.Exists(2))
					[ ] 
					[ ] sNoteActual=TransactionNotesAndFlags.Notes.GetText()
					[ ] print(sNoteActual)
					[+] if(sNoteActual==sNoteExpected)
						[ ] ReportStatus("Verify Add Notes and Flags to Transactions", PASS, "{sNoteActual} flag option selected is correct") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Add Notes and Flags to Transactions", FAIL, "Wrong flag option {sNoteActual} is displayed instead of {sNoteExpected}") 
						[ ] 
					[ ] TransactionNotesAndFlags.OK.DoubleClick()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Add Notes and Flags to Transactions", FAIL, "{sFlagTransactionAction} option selection error") 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Notes and Flags to Transactions", FAIL, "{sFlagTransactionAction} option selection error") 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] //clear search field
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)
			[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
		[ ] 
		[+] else
			[ ] ReportStatus("Register Preferences",FAIL,"Account {lsAddAccount[2]} is not selected")
			[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //////################Edit - Payee Report###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC107_EditPayeeReport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Edit - Payee Report is displayed from transactions in register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If Preferences window is opened and Register Preferences are displayed
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/3/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC107_EditPayeeReport() appstate QuickenBaseState
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iCount,iNum
		[ ] INTEGER iXpos=156
		[ ] INTEGER iYpos=21
		[ ] STRING sPayeeReportAction,sAmount
		[ ] NUMBER nNum
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //setup accounts
	[ ] RegisterSetUp()
	[ ] 
	[ ] // Read transactio data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sRegTransactionSheet)
	[ ] lsTransactionData=lsExcelData[1]
	[ ] 
	[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
	[ ] 
	[ ] 
	[ ] sPayeeReportAction="Payments made to"
	[ ] 
	[ ] 
	[+] for(iLoop=1;iLoop<=4;iLoop++)
		[ ] lsAddAccount=lsExcelData[iLoop]
		[ ] 
		[ ] iVerify=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
		[+] if(iVerify==PASS)
			[+] if (iLoop==1)
				[ ] 
				[ ] iVerify= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] 
			[+] else
				[ ] iVerify=AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDateStamp,NULL,lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify Add Transaction", PASS, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
				[ ] 
				[+] if (iLoop==4)
					[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sPayeeReportAction,"",165,21)
				[+] else
					[ ] iVerify=AccountActionsOnTransaction( sMDIWindow,lsTransactionData[6],sPayeeReportAction,"",iXpos,iYpos)
					[ ] 
				[+] if(PayeeReport.Exists(2))
					[ ] PayeeReport.SetActive()
					[ ] ReportStatus("Verify Edit Payee Report", PASS, "{sPayeeReportAction} option is selected") 
					[ ] 
					[ ] 
					[ ] 
					[ ] sHandle=Str(PayeeReport.QWListViewer1.ListBox1.GetHandle())
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"1")
					[ ] 
					[ ] 
					[ ] //Match Payee name to report entry
					[ ] bMatch=MatchStr("*{lsTransactionData[6]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify Edit Payee Report", PASS,"Payee name is matched to report entry")
						[ ] bMatch=FALSE
					[+] else
						[ ] ReportStatus("Verify Edit Payee Report", FAIL,"Payee name is not matched to report entry")
						[ ] 
					[ ] 
					[ ] 
					[ ] //Match Amount to report entry
					[ ] nNum =val(lsTransactionData[3])
					[ ] sAmount=Str(nNum ,4,2)
					[ ] 
					[ ] bMatch=MatchStr("*{sAmount}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify Edit Payee Report", PASS,"Amount is matched to report entry")
						[ ] bMatch=FALSE
					[+] else
						[ ] ReportStatus("Verify Edit Payee Report", FAIL,"Amount is not matched to report entry")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //Match Category to report entry
					[ ] bMatch=MatchStr("*{lsTransactionData[8]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify Edit Payee Report", PASS,"Category is matched to report entry")
						[ ] bMatch=FALSE
					[+] else
						[ ] ReportStatus("Verify Edit Payee Report", FAIL,"Category is not matched to report entry")
						[ ] 
					[ ] 
					[ ] PayeeReport.SetActive()
					[ ] PayeeReport.Close()
					[ ] WaitForState(PayeeReport, false,1)
				[+] else
					[ ] ReportStatus("Verify Edit Payee Report", FAIL, "{sPayeeReportAction} option selection error") 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] //clear search field
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)
				[ ] MDIClient.AccountRegister.SearchWindow.ClearText()
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Transaction", FAIL, "Error adding {lsTransactionData[2]} Transaction") 
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
			[ ] ReportStatus("Register Preferences",FAIL,"Account {lsAddAccount[2]} is not selected")
			[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Checking Account Register Document Window###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test139_CheckingAccountRegisterDocumentWindow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Checking account opens in pop up window and if transaction can be entered in Register
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
[+] testcase TC139_CheckingAccountRegisterDocumentWindow() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] INTEGER iVerify
		[ ] 
		[ ] 
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] 
		[ ] STRING sPayBalance
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[+] if (iCreateDataFile == PASS)
		[ ] ReportStatus("Validate Data File ", PASS , "Data file -  {sDataFile} is created")
		[ ] 
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] 
			[ ] //Select Checking Account---------------------------------------------------------------------------------------------------------------
			[ ] SelectAccountFromAccountBar(lsAddAccount[2],sBankingAccountType)
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[+] if(MDIClient.AccountRegister.Exists(2))
				[ ] ReportStatus("Checking Account", PASS, "Checking Account opened in Document Window")
				[ ] 
				[ ] //Add Transaction to Account Register----------------------------------------------------------------------------------------------
				[ ] 
				[ ] // Read data from excel sheet
				[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
				[ ] // Fetch 2nd row from the given sheet
				[ ] lsTransactionData=lsExcelData[4]
				[ ] 
				[ ] // Add Deposit Transaction to Checking account
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction") 
				[ ] 
				[ ] 
				[ ] 
				[ ] iVerify=FindTransactionsInRegister(lsTransactionData[6])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
				[+] else
					[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
					[ ] 
			[+] else
				[ ] ReportStatus("Checking Account", FAIL, "Checking Account not opened in Document Window")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
		[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Savings Account RegisterDocument Window ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC13_VerifySavingsAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Savings account opens in pop up window and if transaction can be entered in Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	8/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC140_SavingsAccountRegisterDocumentWindow() appstate none 
	[ ] 
	[ ] 
	[+] //Variable Decalration
		[ ] 
		[ ] INTEGER iVerify
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[2]
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile))
		[ ] iFileResult=OpenDataFile(sFileName)
		[+] if(iFileResult==PASS)
			[ ] ReportStatus("Open File ",PASS,"{sDataFile} File opened successfully")
			[ ] 
			[ ] 
			[ ] //Add A Savings account--------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] // Add Savings Account
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Savings Account", PASS, "Account -  {lsAddAccount[2]}  is created successfully")
				[+] if (QuickenWindow.Exists(60))
					[ ] QuickenWindow.SetActive()
					[ ] // Turn Off "Use Popup Register" option for MDI window type
					[ ] UsePopupRegister("OFF")
					[ ] //This will select Savings account on AccountBar
					[ ] 
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],sBankingAccountType)
					[ ] sleep(3)
					[+] if(MDIClient.AccountRegister.Exists(3))
						[ ] ReportStatus("Savings Account", PASS, "Savings Account opened in Document Window")
						[ ] 
						[ ] //Add Transaction to Account Register----------------------------------------------------------------------------------------------
						[ ] 
						[ ] iAddTransaction= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
						[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction") 
						[ ] 
						[ ] 
						[ ] iVerify=FindTransactionsInRegister(lsAddAccount[2])
						[+] if(iVerify==PASS)
							[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
						[+] else
							[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
					[+] else
						[ ] ReportStatus("Savings Account", FAIL, "Savings Account not opened in Document Window")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Savings Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not created")
			[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open File ",FAIL,"File Not opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Credit Card Account Register Document Window###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC14_VerifyCreditCardAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Credit Card account opens in pop up window and if transaction can be entered in Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	8/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC141_CreditCardAccountRegisterDocumentWindow() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] INTEGER iVerify
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile))
		[ ] iFileResult=OpenDataFile(sFileName)
		[+] if(iFileResult==PASS)
			[ ] ReportStatus("Open File ",PASS,"{sDataFile} File opened successfully")
			[ ] 
			[ ] 
			[ ] //Add A Credit Card Account -------------------------------------------------------------------------------------------------------------
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] // Add Credit Card Account
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Credit card Account", PASS, "Credit Card Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] //This will select credit card account on AccountBar
				[ ] SelectAccountFromAccountBar(lsAddAccount[2],sBankingAccountType)
				[+] if(MDIClient.AccountRegister.Exists(3))
					[ ] ReportStatus("Credit Card Account", PASS, "Credit Card Account opened in Document Window")
					[ ] 
					[ ] //Add Transaction to Account Register----------------------------------------------------------------------------------------------
					[ ] iAddTransaction= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction") 
					[ ] 
					[ ] 
					[ ] iVerify=FindTransactionsInRegister(lsAddAccount[2])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
					[+] else
						[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Credit Card Account", FAIL, "Credit Card Account not opened in Document Window")
				[ ] 
			[+] else
				[ ] ReportStatus("Credit Card Account", FAIL, "Account -  {lsAddAccount[2]}  is not created")
			[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open File ",FAIL,"File Not opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Cash Account Register Document Window ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC15_VerifyCashAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Cash account opens in pop up window and if transaction can be entered in Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	8/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC142_CashAccountRegisterDocumentWindow() appstate none
	[ ] 
	[ ] 
	[+] //Variable Decalration
		[ ] 
		[ ] INTEGER iVerify
		[ ] STRING sAccountWorksheet="Account"
		[ ] STRING sTransactionWorksheet="CheckingTransaction"
		[ ] STRING sBankingAccountType="Banking"
		[ ] 
		[ ] 
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[4]
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile))
		[ ] iFileResult=OpenDataFile(sFileName)
		[+] if(iFileResult==PASS)
			[ ] ReportStatus("Open File ",PASS,"{sDataFile} File opened successfully")
			[ ] 
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] // Add Cash Account
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Cash Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
				[ ] 
				[ ] 
				[ ] //Add Transaction to Account Register----------------------------------------------------------------------------------------------
				[ ] 
				[ ] //This will select Cash account on AccountBar
				[ ] SelectAccountFromAccountBar(lsAddAccount[2],sBankingAccountType)
				[ ] 
				[+] if(MDIClient.AccountRegister.Exists(3))
					[ ] ReportStatus("Cash Account", PASS, "Cash Account opened in Document Window")
					[ ] 
					[ ] //Add Transaction to account
					[ ] iAddTransaction= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDate,lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
					[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction") 
					[ ] 
					[ ] iVerify=FindTransactionsInRegister(lsAddAccount[2])
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
					[+] else
						[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
				[+] else
					[ ] ReportStatus("Cash Account", FAIL, "Cash Account not opened in Document Window")
				[ ] 
			[+] else
				[ ] ReportStatus("Cash Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not created")
			[ ] 
			[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
			[ ] 
		[+] else
			[ ] ReportStatus("Open File ",FAIL,"File Not opened")
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] ////############# Verify Money Market Account Register Document Window####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC12_VerifyCheckingAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Checking account opens in pop up window and if transaction can be entered in Register
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
[+] testcase TC143_MoneyMarketAccountRegisterDocumentWindow()  appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] STRING sHandle
		[ ] INTEGER iCreateDataFile,iVerify
		[ ] 
		[ ] STRING sCCBankAccountId="UserAccount"
		[ ] STRING sCCBankAccountPass="Password"
		[ ] STRING sAccountName="MONEY MARKET XX3333"
		[ ] 
		[ ] LIST OF STRING lsMatchTransactions
		[ ] sDate =FormatDateTime ( GetDateTime (), "m/d/yyyy") 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
		[ ] // Fetch row from the given sheet
		[ ] lsMatchTransactions=lsExcelData[5]
		[ ] 
	[ ] 
	[ ] 
	[ ] // Create Data File------------------------------------------------------------------------------------------------------------------------
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[ ] // Report Staus If Data file Created successfully
	[ ] 
	[+] if ( iCreateDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[ ] // Add CCBank Account
		[ ] 
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.DoubleClick()
		[ ] AddAccount.Checking.Click()
		[ ] 
		[ ] AddAnyAccount.VerifyEnabled(TRUE, 500)
		[ ] AddAnyAccount.SetActive()
		[ ] AddAnyAccount.EnterTheNameOfYourBank.SetFocus()
		[ ] AddAnyAccount.EnterTheNameOfYourBank.TypeKeys("CCBank")
		[ ] AddAnyAccount.Next.Click()
		[ ] sleep(20)
		[+] if (AddAnyAccount.Exists(200))
			[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.BankUserID.SetText(sCCBankAccountId) 
			[ ] AddAnyAccount.BankPassword.SetText(sCCBankAccountPass)			
			[ ] AddAnyAccount.Next.Click()
		[ ] 
		[ ] 
		[+] if(AddAnyAccount.CCBank2.ListBox1.Exists(300))
			[ ] AddAnyAccount.Next.Click()
			[+] if(AccountAdded.Exists(300))
				[ ] AccountAdded.SetActive()
				[ ] AccountAdded.Finish.Click()
				[ ] WaitForState(AddAnyAccount,False,4)
				[ ] CloseMobileSyncInfoPopup()
				[+] if(QuickenWindow.Exists(60))
					[ ] 
					[ ] //For Money Market Account--------------------------------------------------------------------------------------------------------------------
					[ ] 
					[ ] iResult=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
					[+] if (iResult==PASS)
						[ ] 
						[ ] sleep(2)
						[+] if(MDIClient.AccountRegister.Exists(3))
							[ ] ReportStatus("Money Market Account", PASS, "Money Market Account opened in Document Window")
							[ ] // Add Deposit Transaction to Money Market Account
							[ ] iVerify= AddCheckingTransaction(lsMatchTransactions[1],lsMatchTransactions[2], lsMatchTransactions[3], sDate,lsMatchTransactions[5],lsMatchTransactions[6],lsMatchTransactions[7],lsMatchTransactions[8])
							[ ] 
							[ ] 
							[ ] //Transaction is added
							[+] if(iVerify==PASS)
								[ ] iVerify=FindTransactionsInRegister(lsMatchTransactions[6])
								[ ] //Transaction added to register
								[+] if(iVerify==PASS)
									[ ] ReportStatus("Add Transaction", PASS, "{lsMatchTransactions[6]} Transaction added successfully") 
								[+] else
									[ ] ReportStatus("Add Transaction", FAIL, "{lsMatchTransactions[6]} Transaction not added") 
						[+] else
							[ ] ReportStatus("Money Market Account", FAIL, "Money Market Account not opened in Document Window")
					[+] else
						[ ] ReportStatus("Verify Money Market Account selected.",FAIL,"Money Market Account couldn't be selected.")
				[+] else
					[ ] ReportStatus("Verify Money Market Account",FAIL,"Quicken Not Available")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Money Market Account",FAIL,"Account Not Added")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Money Market Account",FAIL,"Account Not Added")
			[+] 
				[ ] 
				[ ] 
				[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Error during creating Data file - {sFileName}")
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Line Of Credit Account Register Document Window#####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC17_VerifyLineOfCreditAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Transaction is successfully added to Document Window register for Line of Credit account
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	18/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[ ] 
[+] testcase TC144_LineOfCreditAccountRegisterDocumentWindow() appstate none  
	[ ] 
	[ ] 
	[+] //Variable Decalration
		[ ] 
		[ ] STRING sHandle
		[ ] INTEGER iCreateDataFile,iVerify
		[ ] 
		[ ] STRING sCCBankAccountId="UserAccount"
		[ ] STRING sCCBankAccountPass="Password"
		[ ] STRING sAccountName="My Line of Credit XX6666"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
		[ ] // Fetch row from the given sheet
		[ ] lsMatchTransactions=lsExcelData[5]
		[ ] 
		[ ] LIST OF STRING lsMatchTransactions
		[ ] sDate =FormatDateTime ( GetDateTime (), "m/d/yyyy") 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Open Data File---------------------------------------------------------------------------------
	[ ] iVerify = OpenDataFile(sFileName)
	[+] if (iVerify == PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is created")
		[ ] 
		[+] if(QuickenWindow.Exists(3))
			[ ] 
			[ ] 
			[ ] 
			[ ] //For Money Market Account--------------------------------------------------------------------------------------------------------------------
			[ ] 
			[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
			[ ] 
			[ ] sleep(2)
			[+] if(MDIClient.AccountRegister.Exists(3))
				[ ] ReportStatus("Line Of Credit Account", PASS, "Line Of Credit Account opened in Document Window")
				[ ] 
				[ ] // Add Deposit Transaction to Money Market Account
				[ ] iVerify= AddBankingTransaction(lsMatchTransactions[1],lsMatchTransactions[2], lsMatchTransactions[3],sDate,"",lsMatchTransactions[5],lsMatchTransactions[6],lsMatchTransactions[7])
				[ ] 
				[ ] 
				[ ] //Transaction is added
				[+] if(iVerify==PASS)
					[ ] iVerify=FindTransactionsInRegister(lsMatchTransactions[5])
					[ ] //Transaction added to register
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "{lsMatchTransactions[6]} Transaction added successfully") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "{lsMatchTransactions[6]} Transaction not added") 
			[+] else
				[ ] ReportStatus("Line Of Credit Account", FAIL, "Line Of Credit Account not opened in Document Window")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Money Market Account",FAIL,"Quicken Not Available")
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //#############  Verify Quicken Security Based Investing Account Rgister ########################
	[ ] // ********************************************************
	[+] // TestCase Name:Test25_SecurityBasedInvestingAccountRegister()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify Asset Account Register opens as Pop up  
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:  07/2/2013  Created By	Abhijit Sarma
		[ ] //	  
	[ ] // ********************************************************
	[ ] 
[+] testcase Test25_SecurityBasedInvestingAccountRegister () appstate none
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sWindowType,sTransactionType,sAmount,sPayee, sAccountUsedPrimarily,sAccount,sSecurity,sNumberOfShares,sPricePaid,sCommission,sMemo,sExpectedCashBalance,sUseCash,sDateAcquired,sAccruedInt
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
		[ ] list of anytype  lsTransactionData
	[ ] 
	[+] // Variable Definition
		[ ] sWindowType="PopUp"
		[ ] sAccType ="Brokerage"
		[ ] sAccName ="Brokerage Account"
		[ ] sAmount="1000"
		[ ] sTransactionType = "Buy"
		[ ] sAmount = "50"
		[ ] sAccountUsedPrimarily=""
		[ ] sSecurity= "INTU"
		[ ] sNumberOfShares = "10"
		[ ] sPricePaid= "20"
		[ ] sCommission= "1"
		[ ] sMemo = "memo"
		[ ] sExpectedCashBalance = "1500"
		[ ] sUseCash = " Brokerage"
		[ ] sDateAcquired =""
		[ ] sAccruedInt = "10"
		[ ] STRING sValue="49"
		[ ] //Buy		Brokerage	01/01/2012	Intu	10	50.05	25		6,449.90
		[ ] 
		[ ] lsTransactionData={sWindowType,sTransactionType,sAccountUsedPrimarily,sAccName,sDateStamp,sSecurity,sNumberOfShares,sPricePaid,sCommission,sMemo,sExpectedCashBalance,sUseCash,sDateAcquired,sAccruedInt}
		[ ] //
		[ ] SetUp_AutoApi()
		[ ] //Create new data file
		[ ] 
	[ ] iCreateFile = DataFileCreate(sFileName)
	[+] if ( iCreateFile  == PASS)
		[ ] ReportStatus("Create new data file {sFileName}", iCreateFile, "Data file -  {sFileName} is created")
		[ ] // Add manual Brokerage Account
		[ ] iAddAccount = AddManualBrokerageAccount(sAccType,sAccName,sAmount,sDateStamp)
		[+] if ( iAddAccount  == PASS)
			[ ] ReportStatus("Add Brokerage Account ", PASS, "Account -  {sAccName} is created")
			[ ] //Report Staus If account is not Created 
			[ ] 
			[ ] 
			[ ] // Open the Brokerage Account register from Account Bar
			[ ] iResult=SelectAccountFromAccountBar(sAccName,ACCOUNT_INVESTING)
			[+] if (iResult==PASS)
				[ ] 
				[ ] //Add transaction to Brokerage account
				[ ] 
				[ ] iResult= AddBrokerageTransaction(lsTransactionData)
				[+] if (iResult==PASS) 
					[+] if(InvestingAccountPopup.Exists(5))
						[ ] InvestingAccountPopup.SetActive ()
						[ ] InvestingAccountPopup.Close()
						[ ] WaitForState(InvestingAccountPopup, false,1)
					[ ] iResult=UsePopupRegister("OFF")
					[+] if (iResult==PASS) 
						[ ] iResult=SelectAccountFromAccountBar(sAccName,ACCOUNT_INVESTING)
						[+] if (iResult==PASS) 
							[ ] sHandle=Str(BrokerageAccount.InvestingAccountRegister.AccountRegisterChild.StaticText1.QWListViewer.ListBox.GetHandle())
							[+] for (iCount=0 ;iCount<5;++iCount)
								[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  str(iCount))
								[ ] bMatch = MatchStr("*{sSecurity}*", sActual)
								[+] if (bMatch)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Add Investing  Transaction",PASS,"Investing Transaction for Security: {sSecurity} added")
							[+] else
								[ ] ReportStatus("Add Investing  Transaction",FAIL,"Investing Transaction or Security: {sSecurity} couldn't be added")
						[+] else
							[ ] ReportStatus("Verify brokerage account selected.",FAIL,"Brokerage account couldn't be selected")
					[+] else
						[ ] ReportStatus("Verify PopupRegister set off.",FAIL,"PopupRegister couldn't be set off.")
				[+] else
					[ ] ReportStatus("Add Investing Transaction",FAIL,"Investing Transaction is not Added")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify brokerage account selected.",FAIL,"Brokerage account couldn't be selected")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Add Brokerage Account", FAIL, "Account -  {sAccName} is not created ")
		[ ] 
		[ ] 
		[ ] 
	[ ] //Report Staus If Data file is not Created 
	[+] else
		[+] ReportStatus("Data fle not created ", iCreateFile, "Data file -  {sFileName} is created but it is not Opened")
			[ ] 
	[ ] 
	[ ] 
[ ] // //############################################################################
[ ] 
[ ] 
[ ] 
[ ] //#############  Verify Quicken 401(K) Account Rgister ########################
[+] testcase Test26_401kAccountRegister () appstate none 
	[+] // Variable Declarations
		[ ] STRING sAccType,sAccName,sPrice,sWindowType,sTransactionType,sAmount,sPayee, sAccountUsedPrimarily,sAccount,sSecurity,sNumberOfShares,sPricePaid,sCommission,sMemo,sExpectedCashBalance,sUseCash,sDateAcquired,sAccruedInt, sEmployerName, sStatementEndingDate 
		[ ] INTEGER  iTotalShares
		[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy")
		[ ] list of anytype  lsTransactionData
	[ ] 
	[+] // Variable Definition
		[ ] sWindowType="MDI"
		[ ] sAccType ="401(k) or 403(b)"
		[ ] sAccName ="401K Account"
		[ ] sAmount="1000"
		[ ] sTransactionType = "Buy"
		[ ] sAmount = "50"
		[ ] sAccountUsedPrimarily=""
		[ ] sSecurity= "INTU"
		[ ] sNumberOfShares = "10"
		[ ] sPricePaid= "20"
		[ ] sCommission= "1"
		[ ] sMemo = "memo"
		[ ] sExpectedCashBalance = "1500"
		[ ] sUseCash = " Brokerage"
		[ ] sDateAcquired =""
		[ ] sAccruedInt = "10"
		[ ] sEmployerName = "Intuit Inc"
		[ ] sStatementEndingDate = ModifyDate(-90,"m/d/yyyy")
		[ ] STRING  sTotalShares = "20"
		[ ] iTotalShares=VAL(sTotalShares)
		[ ] 
		[ ] sDateStamp =ModifyDate(-1,"m/d/yyyy")
		[ ] lsTransactionData={sWindowType,sTransactionType,sAccountUsedPrimarily,sAccName,sDateStamp,sSecurity,sNumberOfShares,sPricePaid,sCommission,sMemo,sExpectedCashBalance,sUseCash,sDateAcquired,sAccruedInt}
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // SetUp_AutoApi()
			[ ] // 
			[ ] //Create new data file
			[ ] iResult = OpenDataFile(sFileName)
			[+] if ( iResult  == PASS)
				[ ] QuickenWindow.SetActive()
				[ ] // Add manual Brokerage Account
				[ ] iAddAccount = AddManual401KAccount(sAccType,sAccName,sEmployerName,sStatementEndingDate,sSecurity,iTotalShares)
				[ ] 
				[ ] iAddAccount=PASS
				[+] if ( iAddAccount  == PASS)
					[ ] ReportStatus("Add 401K Account ", PASS, "Account -  {sAccName} is created")
					[ ] //Report Staus If account is not Created 
					[ ] 
					[ ] 
					[ ] // Open the Brokerage Account register from Account Bar
					[ ] iResult=SelectAccountFromAccountBar(sAccName,ACCOUNT_INVESTING)
					[+] if (iResult==PASS)
						[ ] 
						[ ] //Add transaction to Brokerage account
						[ ] 
						[ ] iResult= AddBrokerageTransaction(lsTransactionData)
						[+] if (iResult==PASS) 
							[ ] sHandle=Str(BrokerageAccount.InvestingAccountRegister.AccountRegisterChild.StaticText1.QWListViewer.ListBox.GetHandle())
							[+] for (iCount=0 ;iCount<5;++iCount)
								[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  str(iCount))
								[ ] bMatch = MatchStr("*{sSecurity}*", sActual)
								[+] if (bMatch)
									[ ] break
							[+] if(bMatch)
								[ ] ReportStatus("Add Investing  Transaction",PASS,"Investing Transaction for Security: {sSecurity} added")
							[+] else
								[ ] ReportStatus("Add Investing  Transaction",FAIL,"Investing Transaction or Security: {sSecurity} couldn't be added")
						[+] else
							[ ] ReportStatus("Add Investing Transaction",FAIL,"Investing Transaction is not Added")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify 401K account selected.",FAIL,"401K account: {sAccName} couldn't be selected")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Add 401K Account", FAIL, "Account -  {sAccName} is not created ")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Data fle not opened ", FAIL, "Data file -  {sFileName} is not Opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
		[ ] 
		[ ] 
[ ] // //############################################################################
[ ] 
[+] ////############# Verify Money Market Account Register ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC12_VerifyCheckingAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Register for Checking account opens in pop up window and if transaction can be entered in Register
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
[-] testcase TC16_VerifyMoneyMarketAccountRegister()  appstate none
	[ ] 
	[ ] 
	[-] //Variable Declaration
		[ ] 
		[ ] STRING sHandle
		[ ] INTEGER iCreateDataFile,iVerify
		[ ] 
		[ ] STRING sCCBankAccountId="UserAccount"
		[ ] STRING sCCBankAccountPass="Password"
		[ ] STRING sAccountName="MONEY MARKET XX3333"  //MONEY MARKET XX3333
		[ ] 
		[ ] LIST OF STRING lsMatchTransactions
		[ ] sDateStamp =FormatDateTime ( GetDateTime (), "m/d/yyyy") 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sCheckingTransactionWorksheet)
		[ ] // Fetch row from the given sheet
		[ ] lsMatchTransactions=lsExcelData[5]
		[ ] 
		[ ] 
		[ ] 
		[ ] // Create Data File------------------------------------------------------------------------------------------------------------------------
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] // Report Staus If Data file Created successfully
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sFileName} is created")
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
			[ ] AddAccount.Checking.Click()
			[ ] 
			[ ] AddAnyAccount.VerifyEnabled(TRUE, 500)
			[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.EnterTheNameOfYourBank.SetFocus()
			[ ] AddAnyAccount.EnterTheNameOfYourBank.TypeKeys("CCBank")
			[ ] AddAnyAccount.Next.Click()
			[ ] 
			[+] if (AddAnyAccount.Exists(200))
				[ ] AddAnyAccount.SetActive()
				[ ] sleep(20)
				[ ] AddAnyAccount.BankUserID.SetText(sCCBankAccountId)
				[ ] AddAnyAccount.BankPassword.SetText(sCCBankAccountPass)			
				[ ] AddAnyAccount.Next.Click()
			[ ] 
			[ ] sleep(20)
			[+] if(AddAnyAccount.CCBank2.ListBox1.Exists(300))
				[ ] AddAnyAccount.Next.Click()
				[+] if(AccountAdded.Exists(300))
					[ ] AccountAdded.SetActive()
					[ ] AccountAdded.Finish.Click()
					[ ] WaitForState(AddAnyAccount,False,4)
					[ ] CloseMobileSyncInfoPopup()
					[ ] sleep(5)
					[+] if(QuickenWindow.Exists(60))
						[ ] QuickenWindow.SetActive()
						[ ] 
						[ ] //For Money Market Account--------------------------------------------------------------------------------------------------------------------
						[ ] 
						[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
						[ ] 
						[ ] sleep(2)
						[ ] 
						[ ] // Add Deposit Transaction to Money Market Account
						[ ] iVerify= AddCheckingTransaction(lsMatchTransactions[1],lsMatchTransactions[2], lsMatchTransactions[3], sDateStamp,lsMatchTransactions[5],lsMatchTransactions[6],lsMatchTransactions[7],lsMatchTransactions[8])
						[ ] 
						[ ] 
						[ ] //Transaction is added
						[+] if(iVerify==PASS)
							[ ] iVerify=FindTransactionsInRegister(lsMatchTransactions[6])
							[ ] //Transaction added to register
							[+] if(iVerify==PASS)
								[ ] ReportStatus("Add Transaction", PASS, "{lsMatchTransactions[6]} Transaction added successfully") 
							[+] else
								[ ] ReportStatus("Add Transaction", FAIL, "{lsMatchTransactions[6]} Transaction not added") 
						[+] else
							[ ] ReportStatus("Add Transaction", FAIL, "{lsMatchTransactions[6]} Transaction failed") 
					[+] else
						[ ] ReportStatus("Verify Money Market Account",FAIL,"Quicken Not Available")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Money Market Account",FAIL,"Account Not Added")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Money Market Account",FAIL,"Account Not Added")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] // 
		[ ] // Report Staus If Data file is not Created 
		[+] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Error during creating Data file - {sFileName}")
		[ ] 
		[ ] 
		[ ] 
[ ] 
[ ] 
[+] ////############# Verify Line Of Credit Account Register #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC17_VerifyLineOfCreditAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Transaction is successfully added to Account register for Line of Credit account
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If verification of content is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	18/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC17_VerifyLineOfCreditAccountRegister() appstate none
	[ ] 
	[ ] 
	[+] //Variable Decalration
		[ ] 
		[ ] STRING sHandle
		[ ] INTEGER iCreateDataFile,iVerify
		[ ] 
		[ ] STRING sCCBankAccountId="UserAccount"
		[ ] STRING sCCBankAccountPass="Password"
		[ ] STRING sAccountName="My Line of Credit XX6666"
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
		[ ] // Fetch row from the given sheet
		[ ] lsMatchTransactions=lsExcelData[5]
		[ ] 
		[ ] LIST OF STRING lsMatchTransactions
		[ ] sDateStamp =FormatDateTime ( GetDateTime (), "m/d/yyyy") 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Open Data File---------------------------------------------------------------------------------
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sFileName} is created")
			[ ] 
			[+] if(QuickenWindow.Exists(5))
				[ ] 
				[ ] 
				[ ] 
				[ ] //For Money Market Account--------------------------------------------------------------------------------------------------------------------
				[ ] 
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] 
				[ ] sleep(2)
				[ ] 
				[ ] 
				[ ] 
				[ ] // Add Deposit Transaction to Money Market Account
				[ ] iVerify= AddBankingTransaction(lsMatchTransactions[1],lsMatchTransactions[2], lsMatchTransactions[3],sDateStamp,"",lsMatchTransactions[5],lsMatchTransactions[6],lsMatchTransactions[7])
				[ ] 
				[ ] 
				[ ] //Transaction is added
				[+] if(iVerify==PASS)
					[ ] iVerify=FindTransactionsInRegister(lsMatchTransactions[5])
					[ ] //Transaction added to register
					[+] if(iVerify==PASS)
						[ ] ReportStatus("Add Transaction", PASS, "{lsMatchTransactions[6]} Transaction added successfully") 
					[+] else
						[ ] ReportStatus("Add Transaction", FAIL, "{lsMatchTransactions[6]} Transaction not added") 
				[+] else
					[ ] ReportStatus("Add Transaction", FAIL, "{lsMatchTransactions[6]} Transaction failed") 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Money Market Account",FAIL,"Quicken Not Available")
			[ ] 
		[+] else 
			[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
		[ ] //--------------------------------------------------------------------------------------------------------------------------------------------------
	[+] else
		[ ] ReportStatus("Verify Filters present in account",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //############# TC_Setup_Webconnect_File #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC_Setup_Webconnect_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will create a new data file import a webconnect file into Quicken for testcase nos 165-175
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If file is created and webconnect file is imported
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 6th 2013		
		[ ] //Author                          Dean Paes
	[ ] // ********************************************************
[+] testcase TC_Setup_Webconnect_File() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iValidate
		[ ] STRING sWebConnectFileName="WebConnect_Files\WellsFargo_Checking_Register_Automation"
		[ ] STRING sFileName="Register"
		[ ] 
	[ ] iResult=DataFileCreate(sFileName)
	[+] if(iResult==PASS)
		[ ] 
		[ ] iResult=SelectPreferenceType("Downloaded transactions")
		[+] if(iResult==PASS)
			[+] if(Preferences.AutomaticallyAddToBankingRegister.Exists(5))
				[ ] Preferences.AutomaticallyAddToBankingRegister.Check()
				[ ] Preferences.OK.Click()
				[ ] QuickenWindow.SetActive()
				[ ] iResult=ImportWebConnectFile(sWebConnectFileName)
				[+] if(iResult==PASS)
					[ ] ReportStatus("Import Web connect file",PASS,"Web connect file imported succesfully")
					[ ] 
				[+] else
					[ ] ReportStatus("Import Web connect file",FAIL,"Error during importing Web connect file")
					[ ] 
				[ ] 
				[ ] ReportStatus("Edit Preferences Download Transactions",PASS,"AutomaticallyAddToBankingRegister Checkbox is present")
			[+] else
				[ ] ReportStatus("Edit Preferences Download Transactions",FAIL,"AutomaticallyAddToBankingRegister Checkbox is missing")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Preferences->Downloaded transactions appeared.",FAIL," Preferences->Downloaded transactions didn't appear.")
		[ ] 
	[+] else
		[ ] ReportStatus("Data File Create",FAIL,"Data file not created")
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //############# TC165_Recategorize_Transaction_From_Transaction_Report_Cancel #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC165_Recategorize_Transaction_From_Transaction_Report_Cancel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Update Category from Payee Transaction Report and click on cancel button.
		[ ] //  Then verifies that changes should not be reflected in Report and register
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes are  not be reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 5th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC165_Recategorize_Transaction_From_Transaction_Report_Cancel() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] STRING sSearchPayeeName="Wt FED"     //Payee Name
		[ ] 
		[ ] STRING sOldCategory="Other Inc"
		[ ] STRING sNewCategory="Net Salary"
		[ ] 
		[ ] 
		[ ] STRING sReportAction="Recategorize transaction(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //----------------Verify Category mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction,"",iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports ,sSearchPayeeName)
				[ ] bMatch=MatchStr("*{sOldCategory}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Category to report",PASS,"Category {sOldCategory} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Category to report",FAIL,"Category {sOldCategory} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Re transaction from report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Recategorize Transaction Dialog is open----------------------------
			[+] if(RecategorizeTransactions.Exists(4))
				[ ] ReportStatus("Recategorize transactions dialog box",PASS,"Recategorize transactions dialog box is open")
				[ ] RecategorizeTransactions.SetActive()
				[ ] RecategorizeTransactions.CategoryTextField.TypeKeys(sNewCategory)
				[ ] RecategorizeTransactions.CategoryTextField.TypeKeys(KEY_ENTER)
				[ ] RecategorizeTransactions.Cancel.DoubleClick()
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify New Category NOT mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction ,"", iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] 
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports, sSearchPayeeName)
							[ ] bMatch=MatchStr("*{sOldCategory}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Category to report",PASS,"Old Category {sOldCategory} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Category to report",FAIL,"New Category {sNewCategory} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Retag transactions dialog box",FAIL,"Retag transactions dialog box is open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC166_Recategorize_Transaction_From_Transaction_Report_OK #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC166_Recategorize_Transaction_From_Transaction_Report_OK()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Update Category from Payee Transaction Report and click on OK button.
		[ ] //  Then verifies that changes should be reflected in Report and register
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes should be reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 5th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC166_Recategorize_Transaction_From_Transaction_Report_OK() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] STRING sSearchPayeeName="Wt FED"     //Payee Name
		[ ] 
		[ ] STRING sOldCategory="Other Inc"
		[ ] STRING sNewCategory="Net Salary"
		[ ] 
		[ ] 
		[ ] STRING sReportAction="Recategorize transaction(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] //----------------Verify Category mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
				[ ] bMatch=MatchStr("*{sOldCategory}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Category to report",PASS,"Category {sOldCategory} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Category to report",FAIL,"Category {sOldCategory} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Re transaction from report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Recategorize Transaction Dialog is open----------------------------
			[+] if(RecategorizeTransactions.Exists(4))
				[ ] ReportStatus("Recategorize transactions dialog box",PASS,"Recategorize transactions dialog box is open")
				[ ] RecategorizeTransactions.SetActive()
				[ ] RecategorizeTransactions.CategoryTextField.TypeKeys(sNewCategory)
				[ ] RecategorizeTransactions.CategoryTextField.TypeKeys(KEY_ENTER)
				[ ] RecategorizeTransactions.OK.DoubleClick()
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify New Category mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] TransactionReports.SetActive()
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
							[ ] bMatch=MatchStr("*{sNewCategory}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Category to report",PASS,"New Category {sNewCategory} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Category to report",FAIL,"New Category {sNewCategory} not matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] //-----------------Old Category is NOT matched to report---------------------------
							[ ] bMatch=NULL
							[ ] bMatch=MatchStr("*{sOldCategory}*",sReportEntry)
							[+] if(bMatch==FALSE)
								[ ] ReportStatus("Match Category to report",PASS,"Old Category {sOldCategory} not matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Category to report",FAIL,"Old Category {sOldCategory} matched to report")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Retag transactions dialog box",FAIL,"Retag transactions dialog box is open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] // //############# TC167_Retag_Transaction_From_Transaction_Report_Cancel #################################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 TC167_Retag_Transaction_From_Transaction_Report_Cancel()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Update tag from Payee Transaction Report and click on cancel button.
		[ ] // //  Then verifies that changes should not be reflected in Report and register
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If changes are  not reflected in Report and register
		[ ] // //						Fail			If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //Date                             May 5th 2013		
		[ ] // //Author                          Dean Paes
		[ ] // 
	[ ] // // ********************************************************
[+] testcase TC167_Retag_Transaction_From_Transaction_Report_Cancel() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] STRING sSearchPayeeName="Wt FED"     //Payee Name
		[ ] 
		[ ] STRING sOldTag="Old Tag"
		[ ] STRING sNewTag="New Tag"
		[ ] 
		[ ] 
		[ ] STRING sReportAction="Retag transaction(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] 
		[ ] //---------------------Add Tag to Transaction-----------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] FindTransaction(sMDIWindow,sSearchPayeeName)
		[ ] MDIClient.AccountRegister.TypeKeys(Replicate(KEY_TAB,5))
		[ ] MDIClient.AccountRegister.TypeKeys(sOldTag)
		[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
		[+] if(NewTag.Exists(2))
			[ ] NewTag.SetActive()
			[ ] NewTag.OKButton.Click()
			[ ] 
		[ ] 
		[ ] //REMOVE AFTER DEFECT IS RESOLVED IN R12
		[ ] FindTransaction(sMDIWindow,sSearchPayeeName)
		[ ] MDIClient.AccountRegister.TypeKeys(Replicate(KEY_TAB,5))
		[ ] MDIClient.AccountRegister.TypeKeys(sOldTag)
		[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
		[ ] //MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Verify Tag mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
				[ ] bMatch=MatchStr("*{sOldTag}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Tag to report",PASS,"Tag {sOldTag} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Tag to report",FAIL,"Tag {sOldTag} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Retag transaction from report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Retag Transaction Dialog is open----------------------------
			[+] if(RetagTransactions.Exists(4))
				[ ] ReportStatus("Recategorize transactions dialog box",PASS,"Recategorize transactions dialog box is open")
				[ ] RetagTransactions.SetActive()
				[ ] RetagTransactions.TagS.TypeKeys(sNewTag)
				[ ] RetagTransactions.TagS.TypeKeys(KEY_ENTER)
				[+] if(NewTag.Exists(2))
					[ ] NewTag.SetActive()
					[ ] NewTag.CancelButton.Click()
				[+] if(RetagTransactions.Exists(2))
					[ ] RetagTransactions.Cancel.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify New Tag NOT mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] 
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
							[ ] bMatch=MatchStr("*{sOldTag}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Tag to report",PASS,"Old Tag {sOldTag} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Tag to report",FAIL,"New Tag {sNewTag} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Retag transactions dialog box",FAIL,"Retag transactions dialog box is open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] // //############# TC168_Retag_Transaction_From_Transaction_Report_OK #################################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 TC168_Retag_Transaction_From_Transaction_Report_OK()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Update Tag from Payee Transaction Report and click on OK button.
		[ ] // //  Then verifies that changes should be reflected in Report and register
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If changes should be reflected in Report and register
		[ ] // //						Fail			If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // //Date                             May 5th 2013		
		[ ] // //Author                          Dean Paes
		[ ] // 
	[ ] // // ********************************************************
[+] testcase TC168_Retag_Transaction_From_Transaction_Report_OK() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] STRING sSearchPayeeName="Wt FED"     //Payee Name
		[ ] 
		[ ] STRING sOldTag="Old Tag"
		[ ] STRING sNewTag="New Tag"
		[ ] 
		[ ] 
		[ ] STRING sReportAction="Retag transaction(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] 
		[ ] //---------------------Add Tag to Transaction-----------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] FindTransaction(sMDIWindow,sSearchPayeeName)
		[ ] MDIClient.AccountRegister.TypeKeys(Replicate(KEY_TAB,5))
		[ ] MDIClient.AccountRegister.TypeKeys(sOldTag)
		[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
		[+] if(NewTag.Exists(2))
			[ ] NewTag.SetActive()
			[ ] NewTag.OKButton.Click()
			[ ] 
		[ ] 
		[ ] //REMOVE AFTER DEFECT IS RESOLVED IN R12
		[ ] FindTransaction(sMDIWindow,sSearchPayeeName)
		[ ] MDIClient.AccountRegister.TypeKeys(Replicate(KEY_TAB,5))
		[ ] MDIClient.AccountRegister.TypeKeys(sOldTag)
		[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
		[ ] //MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Verify Tag mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
				[ ] bMatch=MatchStr("*{sOldTag}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Tag to report",PASS,"Tag {sOldTag} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Tag to report",FAIL,"Tag {sOldTag} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Retag transaction from report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Retag Transaction Dialog is open----------------------------
			[+] if(RetagTransactions.Exists(4))
				[ ] ReportStatus("Recategorize transactions dialog box",PASS,"Recategorize transactions dialog box is open")
				[ ] RetagTransactions.SetActive()
				[ ] RetagTransactions.TagS.TypeKeys(sNewTag)
				[ ] RetagTransactions.TagS.TypeKeys(KEY_ENTER)
				[+] if(NewTag.Exists(2))
					[ ] NewTag.SetActive()
					[ ] NewTag.OKButton.Click()
					[ ] 
				[+] if(RetagTransactions.Exists(2))
					[ ] RetagTransactions.OK.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify New Tag NOT mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] TransactionReports.SetActive()
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
							[ ] bMatch=MatchStr("*{sNewTag}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Tag to report",PASS,"Old Category {sOldTag} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Tag to report",FAIL,"New Category {sNewTag} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] //-----------------Old Tag is NOT matched to report---------------------------
							[ ] bMatch=NULL
							[ ] bMatch=MatchStr("*{sOldTag}*",sReportEntry)
							[+] if(bMatch==FALSE)
								[ ] ReportStatus("Match Tag to report",PASS,"Old Tag {sOldTag} not matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Tag to report",FAIL,"Old Tag {sOldTag} matched to report")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.SetActive()
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Retag transactions dialog box",FAIL,"Retag transactions dialog box is open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC169_Rename_Payee__From_Transaction_Report_Cancel #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC169_Rename_Payee__From_Transaction_Report_Cancel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Update Payee Name from Payee Transaction Report and click on Cancel button.
		[ ] //  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes are not reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 6th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC169_Rename_Payee__From_Transaction_Report_Cancel() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] 
		[ ] STRING sOldPayeeName="Wire Trans Svc"          //Payee Name
		[ ] STRING sNewPayeeName="New Payee Wire Trans Svc"
		[ ] 
		[ ] STRING sReportAction="Rename payee(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] //----------------Verify Payee mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sOldPayeeName,sAction,"",iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sOldPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports,sOldPayeeName)
				[ ] bMatch=MatchStr("*{sOldPayeeName}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Payee name to report",PASS,"Payee name {sOldPayeeName} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Payee name to report",FAIL,"Payee name {sOldPayeeName} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sOldPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Rename Payee from report-------------------
		[ ] iVerify=TransactionReportOperations(sOldPayeeName,sReportAction ,sAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Rename Payee Dialog is open----------------------------
			[+] if(RenamePayee.Exists(4))
				[ ] ReportStatus("Rename Payee dialog box",PASS,"Recategorize transactions dialog box is open")
				[ ] RenamePayee.SetActive()
				[ ] RenamePayee.PayeeName.TypeKeys(sNewPayeeName)
				[ ] RenamePayee.Cancel.DoubleClick()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify New Tag NOT mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sOldPayeeName,sAction,"",iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sOldPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] 
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports,sOldPayeeName)
							[ ] bMatch=MatchStr("*{sOldPayeeName}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Payee Name to report",PASS,"Old Payee Name {sOldPayeeName} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Payee Name to report",FAIL,"Old Payee Name {sOldPayeeName} Not matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sOldPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Retag transactions dialog box",FAIL,"Rename Payee dialog box is not open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC170_Rename_Payee__From_Transaction_Report_OK #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC170_Rename_Payee__From_Transaction_Report_OK()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Update Payee Name from Payee Transaction Report and click on OK button.
		[ ] //  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes should be reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 6th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC170_Rename_Payee__From_Transaction_Report_OK() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] 
		[ ] STRING sOldPayeeName="Wire Trans Svc"          //Payee Name
		[ ] STRING sNewPayeeName="New Payee"
		[ ] 
		[ ] STRING sReportAction="Rename payee(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual"
		[ ] STRING sNewAction="Launch Mini-Report for Payee Online"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] //----------------Verify Payee mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sOldPayeeName,sAction,"",iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(5))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sOldPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports,sOldPayeeName)
				[ ] bMatch=MatchStr("*{sOldPayeeName}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Payee name to report",PASS,"Payee name {sOldPayeeName} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Payee name to report",FAIL,"Payee name {sOldPayeeName} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sOldPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Rename Payee from report-------------------
		[ ] iVerify=TransactionReportOperations(sOldPayeeName,sReportAction,sAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Rename Payee Dialog is open----------------------------
			[+] if(RenamePayee.Exists(4))
				[ ] ReportStatus("Rename Payee dialog box",PASS,"Recategorize transactions dialog box is open")
				[ ] RenamePayee.SetActive()
				[ ] RenamePayee.PayeeName.TypeKeys(sNewPayeeName)
				[ ] RenamePayee.OK.DoubleClick()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify New Payee name mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sNewPayeeName,sNewAction)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sNewPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] 
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports,sNewPayeeName)
							[ ] bMatch=MatchStr("*{sNewPayeeName}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Payee Name to report",PASS,"New Payee Name {sNewPayeeName} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Payee Name to report",FAIL,"New Payee Name {sNewPayeeName} Not matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] //-----------------Old Payee Name  is NOT matched to report---------------------------
							[ ] bMatch=NULL
							[ ] bMatch=MatchStr("*{sOldPayeeName}*",sReportEntry)
							[+] if(bMatch==FALSE)
								[ ] ReportStatus("Match Payee name to report",PASS,"Old Payee name {sOldPayeeName} not matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Payee name to report",FAIL,"Old Payee name {sOldPayeeName} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sNewPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Retag transactions dialog box",FAIL,"Rename Payee dialog box is not open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC171_Edit_Memo__From_Transaction_Report_Cancel #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC171_Edit_Memo__From_Transaction_Report_Cancel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Update Memo from Payee Transaction Report and click on Cancel button.
		[ ] //  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes are not reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 6th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC171_Edit_Memo__From_Transaction_Report_Cancel() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] STRING sSearchPayeeName="Wt FED"     //Payee Name
		[ ] 
		[ ] STRING sOldMemo="Old"
		[ ] STRING sNewMemo="New"
		[ ] 
		[ ] 
		[ ] STRING sReportAction="Edit memo(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual" 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] //----------------Verify Memo mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports,sSearchPayeeName)
				[ ] bMatch=MatchStr("*{sOldMemo}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Memo to report",PASS,"Memo {sOldMemo} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Memo to report",FAIL,"Memo {sOldMemo} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Edit memo from report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Edit memo Dialog is open----------------------------
			[+] if(EditMemo.Exists(4))
				[ ] ReportStatus("Edit Memo dialog box",PASS,"Edit Memo dialog box is open")
				[ ] EditMemo.SetActive()
				[ ] EditMemo.EditMemoTextField.TypeKeys(sNewMemo)
				[ ] EditMemo.Cancel.Click()
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify Edited memo NOT mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] 
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports , sSearchPayeeName)
							[ ] bMatch=MatchStr("*{sOldMemo}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Memo to report",PASS,"Old Memo {sOldMemo} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Memo to report",FAIL,"New Memo {sNewMemo} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Edit Memo dialog box",FAIL,"Edit Memo dialog box is open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC172_Edit_Memo__From_Transaction_Report_OK #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC172_Edit_Memo__From_Transaction_Report_OK()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Update Memo from Payee Transaction Report and click on OK button.
		[ ] //  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes should be reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 6th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC172_Edit_Memo__From_Transaction_Report_OK() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] STRING sSearchPayeeName="Wt FED"     //Payee Name
		[ ] 
		[ ] STRING sOldMemo="Old"
		[ ] STRING sNewMemo="New"
		[ ] 
		[ ] 
		[ ] STRING sReportAction="Edit memo(s)"
		[ ] STRING sReportEntry
		[ ] 
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] STRING sAction="Launch Mini-Report for Payee Manual" 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] //----------------Verify Memo mentioned in report---------------------------------
		[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
		[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
		[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
			[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
			[ ] //-----------Click on Show Report button on Callout----------
			[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
			[ ] 
			[ ] 
			[+] if(TransactionReports.Exists(4))
				[ ] 
				[ ] //-------------Select Include all dates from date range filter-------------
				[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
				[ ] 
				[ ] sReportEntry=GetLineFromReport(TransactionReports , sSearchPayeeName)
				[ ] bMatch=MatchStr("*{sOldMemo}*",sReportEntry)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match Memo to report",PASS,"Memo {sOldMemo} matched to report")
					[ ] 
				[+] else
					[ ] ReportStatus("Match Memo to report",FAIL,"Memo {sOldMemo} not matched to report")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Edit memo from report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Edit memo Dialog is open----------------------------
			[+] if(EditMemo.Exists(4))
				[ ] ReportStatus("Edit Memo dialog box",PASS,"Edit Memo dialog box is open")
				[ ] EditMemo.SetActive()
				[ ] EditMemo.EditMemoTextField.TypeKeys(sNewMemo)
				[ ] EditMemo.OK.Click()
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify Edited memo mentioned in report---------------------------------
				[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
				[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
				[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
					[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
					[ ] //-----------Click on Show Report button on Callout----------
					[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
					[ ] 
					[ ] 
					[+] if(TransactionReports.Exists(4))
							[ ] 
							[ ] 
							[ ] //-------------Select Include all dates from date range filter-------------
							[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
							[ ] 
							[ ] sReportEntry=GetLineFromReport(TransactionReports , sSearchPayeeName)
							[ ] //-----------------New memo is matched to report---------------------------
							[ ] bMatch=MatchStr("*{sNewMemo}*",sReportEntry)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Match Memo to report",PASS,"New Memo {sNewMemo} matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Memo to report",FAIL,"New Memo {sNewMemo} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] //-----------------Old memo is NOT matched to report---------------------------
							[ ] bMatch=NULL
							[ ] bMatch=MatchStr("*{sOldMemo}*",sReportEntry)
							[+] if(bMatch==FALSE)
								[ ] ReportStatus("Match Memo to report",PASS,"Old Memo {sOldMemo} not matched to report")
								[ ] 
							[+] else
								[ ] ReportStatus("Match Memo to report",FAIL,"Old Memo {sOldMemo} matched to report")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] //---------Close Report----------
							[ ] TransactionReports.Close()
							[ ] WaitForState(TransactionReports,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Edit Memo dialog box",FAIL,"Edit Memo dialog box is open")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Transaction Report",FAIL,"Error while opening report")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC173_Delete_Transaction__From_Transaction_Report_Cancel #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC173_Delete_Transaction__From_Transaction_Report_Cancel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete transaction from Payee Transaction Report and click on Cancel button.
		[ ] //  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes are not reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 7th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC173_Delete_Transaction__From_Transaction_Report_Cancel() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] 
		[ ] //List Of String
		[ ] LIST OF STRING lsTransactionDetails={"1/4/2010","Account Maintenance Fee","Fees & Charges:Bank Fee","-13.95"}
		[ ] STRING sSearchPayeeName=lsTransactionDetails[2]
		[ ] 
		[ ] 
		[ ] //String
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] 
		[ ] STRING sReportAction="Delete transaction(s)"
		[ ] STRING sReportEntry
		[ ] STRING sAction="Launch Mini-Report for Payee Manual" 
		[ ] STRING sDeleteDialogCaption="Delete Transaction"
		[ ] STRING sExpectedNumberOfTransactions="3"
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Delete Transaction from Report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Delete Transaction Dialog is open----------------------------
			[+] if(AlertMessage.Exists(4))
				[ ] ReportStatus("Delete Transaction dialog box",PASS,"Delete Transaction dialog box is open")
				[ ] AlertMessage.SetActive()
				[ ] AlertMessage.Cancel.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify Transaction present in register---------------------------------
				[ ] iVerify=VerifyTransactionInAccountRegister(sSearchPayeeName,sExpectedNumberOfTransactions)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Transaction present in register",PASS,"Transaction is found in register")
					[ ] 
					[ ] //------------Clear Search window------------
					[ ] MDIClient.AccountRegister.SearchWindow.SetText("")
					[ ] 
					[ ] 
					[ ] //----------------Verify Content in Payee report---------------------------------
					[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
					[ ] AccountActionsOnTransaction( sMDIWindow,sSearchPayeeName,sAction, "", iX,iY)
					[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
						[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
						[ ] //-----------Click on Show Report button on Callout----------
						[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
						[ ] 
						[ ] //----------------------Select Include all dates-----------------------
						[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
						[ ] 
						[ ] //------------Verify that transaction is present in report by retrieving it using amount-----------
						[ ] sReportEntry=GetLineFromReport(TransactionReports, lsTransactionDetails[4])
						[+] if(sReportEntry==NULL)
							[ ] ReportStatus("Transaction present in register",FAIL,"Transaction deleted from register")
							[ ] 
							[ ] 
							[ ] 
						[+] else 
							[ ] ReportStatus("Transaction present in register",PASS,"Transaction present in register")
						[ ] 
						[ ] 
						[ ] //---------Close Report----------
						[ ] TransactionReports.Close()
						[ ] WaitForState(TransactionReports,FALSE,5)
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
					[ ] ReportStatus("Transaction present in register",FAIL,"Transaction deleted from in register")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Delete Transaction dialog box",FAIL,"Delete Transaction dialog box did not open")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# TC174_Delete_Transaction__From_Transaction_Report_OK #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC174_Delete_Transaction__From_Transaction_Report_OK()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete transaction from Payee Transaction Report and click on OK button.
		[ ] //  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If changes should be reflected in Report and register
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             May 7th 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC174_Delete_Transaction__From_Transaction_Report_OK() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] 
		[ ] //List Of String
		[ ] LIST OF STRING lsTransactionDetails={"1/4/2010","Account Maintenance Fee","Fees & Charges:Bank Fee","-13.95"}
		[ ] STRING sSearchPayeeName=lsTransactionDetails[2]
		[ ] 
		[ ] 
		[ ] //String
		[ ] STRING sAccountName="Checking at Wells Fargo Bank"
		[ ] 
		[ ] STRING sReportAction="Delete transaction(s)"
		[ ] STRING sReportEntry
		[ ] STRING sAction="Launch Mini-Report for Payee Manual" 
		[ ] STRING sDeleteDialogCaption="Delete Transaction"
		[ ] STRING sExpectedNumberOfTransactions="2"
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,iX=251,iY=21
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Select Delete Transaction from Report-------------------
		[ ] iVerify=TransactionReportOperations(sSearchPayeeName,sReportAction)
		[+] if(iVerify==PASS)
			[ ] 
			[ ] 
			[ ] //-------------Verify if Delete Transaction Dialog is open----------------------------
			[+] if(AlertMessage.Exists(4))
				[ ] ReportStatus("Delete Transaction dialog box",PASS,"Delete Transaction dialog box is open")
				[ ] AlertMessage.SetActive()
				[ ] AlertMessage.OK.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //---------Close Report----------
				[ ] TransactionReports.Close()
				[ ] WaitForState(TransactionReports,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Verify Transaction present in register---------------------------------
				[ ] iVerify=VerifyTransactionInAccountRegister(sSearchPayeeName,sExpectedNumberOfTransactions)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Transaction present in register",PASS,"Transaction is found in register")
					[ ] 
					[ ] //------------Clear Search window------------
					[ ] MDIClient.AccountRegister.SearchWindow.SetText("")
					[ ] 
					[ ] 
					[ ] //----------------Verify Content in Payee report---------------------------------
					[ ] SelectAccountFromAccountBar(sAccountName,ACCOUNT_BANKING)
					[ ] AccountActionsOnTransaction( sMDIWindow, sSearchPayeeName,sAction, "", iX,iY)
					[+] if(MDICalloutHolder.CalloutPopup.Exists(3))
						[ ] ReportStatus("Open Register Mini Report",PASS,"Mini Report Opened for payee {sSearchPayeeName}")
						[ ] //-----------Click on Show Report button on Callout----------
						[ ] MDICalloutHolder.CalloutPopup.ShowReport.Click()
						[ ] 
						[ ] //----------------------Select Include all dates-----------------------
						[ ] WaitForState(TransactionReports, true ,2)
						[ ] TransactionReports.SetActive()
						[ ] TransactionReports.QWCustomizeBar1.DateRange.Select(1)
						[ ] 
						[ ] //------------Verify that transaction is present in report by retrieving it using amount-----------
						[ ] sReportEntry=GetLineFromReport(TransactionReports ,lsTransactionDetails[4])
						[+] if(sReportEntry==NULL)
							[ ] ReportStatus("Transaction present in register",PASS,"Transaction deleted from report")
							[ ] 
							[ ] 
						[+] else 
							[ ] ReportStatus("Transaction present in register",FAIL,"Transaction not deleted from report")
							[ ] 
						[ ] 
						[ ] 
						[ ] //---------Close Report----------
						[ ] TransactionReports.Close()
						[ ] WaitForState(TransactionReports,FALSE,5)
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
					[ ] ReportStatus("Transaction present in register",FAIL,"Transaction deleted from in register")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Delete Transaction dialog box",FAIL,"Delete Transaction dialog box did not open")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Register Mini Report",FAIL,"Mini Report Did not open for Payee {sSearchPayeeName}")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] // ############# TC11_Delete_Transfer__Transaction_From_Register #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC11_Delete_Transfer__Transaction_From_Register()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Delete Transfer Transaction from Register
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If changes are reflected in both accounts
		[ ] // Fail			If any error occurs
		[ ] // 
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Date                             May 8th 2013		
		[ ] // Author                          Dean Paes
	[ ] // ********************************************************
[+] testcase TC11_Delete_Transfer__Transaction_From_Register() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] LIST OF STRING lsFindTransaction
		[ ] INTEGER iValidate
		[ ] 
		[ ] STRING sCheckingAccountName="Checking at Wells Fargo Bank"
		[ ] 
		[ ] BOOLEAN bMatch1,bMatch2
		[ ] 
		[ ] //-------Savings Account Details----------------------------
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[3]
		[ ] STRING sSavingsAccountName=lsAddAccount[2]
		[ ] STRING sTransferCategorySavings="[{sCheckingAccountName}]"
		[ ] 
		[ ] 
		[ ] //------Checking Account Details Account Details----------------------------
		[ ] STRING sTransferCategoryChecking="[{lsAddAccount[2]}]"
		[ ] 
		[ ] STRING sSearchPayeeName="Transfer Transaction Payee"
		[ ] 
		[ ] //------Transfer Transaction Data--------------------------
		[ ] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionWorksheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] lsTransactionData[6]=sSearchPayeeName
		[ ] STRING sTransferTransaction="Transfer"
		[ ] 
		[ ] 
		[ ] //----------Match Transaction count-----------
		[ ] STRING sExpectedNumberOfTransactions="0"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] SetUp_AutoAPI()
		[ ] 
		[ ] 
		[ ] //-----------------Add a Savings Account----------------
		[ ] iValidate=AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add a savings Account",PASS,"Savings account added successfully")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Add Transaction to account
			[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
			[ ] iValidate= AddBankingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], sDateStamp,sTransferTransaction,lsTransactionData[6],lsTransactionData[7],sTransferCategorySavings)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Add Transaction", iValidate, "{lsTransactionData[2]} Transaction") 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //------------------------------------Verify that transaction is added--------------------------------
				[ ] lsFindTransaction=GetTransactionsInRegister(sSearchPayeeName)
				[ ] 
				[+] if(lsFindTransaction!=NULL)
					[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransactionData[6]} added succesfully to Account {lsAddAccount[2]}")
					[ ] 
					[ ] //---------Verify if transfer transaction is added for Checking Account-------------
					[ ] bMatch1=MatchStr("*{sTransferCategoryChecking}*",lsFindTransaction[1])
					[ ] bMatch2=MatchStr("*{sCheckingAccountName}*",lsFindTransaction[1])
					[+] if(bMatch1==TRUE && bMatch2==TRUE)
						[ ] ReportStatus("Verify if transfer transaction is added for Checking Account",PASS,"Transfer Transaction is added for Checking Account")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if transfer transaction is added for Checking Account",FAIL,"Transfer Transaction is not added for Checking Account")
						[ ] 
					[ ] 
					[ ] 
					[ ] //---------Verify if account is added for Savings Account-------------
					[ ] bMatch1=MatchStr("*{sTransferCategorySavings}*",lsFindTransaction[2])
					[ ] bMatch2=MatchStr("*{sSavingsAccountName}*",lsFindTransaction[2])
					[+] if(bMatch1==TRUE && bMatch2==TRUE)
						[ ] ReportStatus("Verify if transfer transaction is added for Savings Account",PASS,"Transfer Transaction is added for Savings Account")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if transfer transaction is added for Savings Account",FAIL,"Transfer Transaction is not added for Savings Account")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //----------------------------------Delete Transfer Transaction-----------------------------------------
					[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
					[ ] iValidate=DeleteTransaction(sMDIWindow,sSearchPayeeName)
					[+] if(iValidate==PASS)
						[ ] 
						[ ] //---------Verify if transfer transaction is deleted from Checking Account-------------
						[ ] SelectAccountFromAccountBar(sCheckingAccountName,ACCOUNT_BANKING)
						[ ] iValidate=VerifyTransactionInAccountRegister(sSearchPayeeName,sExpectedNumberOfTransactions)
						[+] if(iValidate==PASS)
							[ ] ReportStatus("Verify if transfer transaction is deleted from Checking Account",PASS,"Transfer Transaction is deleted for Checking Account")
						[+] else
							[ ] ReportStatus("Verify if transfer transaction is deleted from Checking Account",FAIL,"Transfer Transaction is not deleted for Checking Account")
							[ ] 
						[ ] 
						[ ] 
						[ ] //---------Verify if account is added for Savings Account-------------
						[ ] SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
						[ ] iValidate=VerifyTransactionInAccountRegister(sSearchPayeeName,sExpectedNumberOfTransactions)
						[+] if(iValidate==PASS)
							[ ] ReportStatus("Verify if transfer transaction is deleted from Savings Account",PASS,"Transfer Transaction is deleted for Savings Account")
						[+] else
							[ ] ReportStatus("Verify if transfer transaction is deleted from Savings Account",FAIL,"Transfer Transaction is not deleted for Savings Account")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Delete Transaction",FAIL,"Error during deletion of Transaction {lsTransactionData[6]} from Account {lsAddAccount[2]}")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransactionData[6]} not added to Account {lsAddAccount[2]}")
				[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Add a savings Account",FAIL,"Savings account not added")
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
		[ ] ReportStatus("Quicken Main Window",FAIL,"Quicken Main Window is not found")
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
[+] //############# Test179_VerifySplitTransactionBankingAccount #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test179_VerifySplitTransactionBankingAccount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify add split transaction and verifies if:
		[ ] //    1.the green tick mark button opens split dialog
		[ ] //    2.the red cross button clears all split lines
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If adding split transaction is successful
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                              26 April 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC179_VerifySplitTransactionBankingAccount() appstate none 
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sTag , sMemo
		[ ] INTEGER iSplitListCount
		[ ] 
		[ ] 
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Create a New Data File---------------------------------------------------------------------------------
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[+] if (iCreateDataFile == PASS)
		[ ] ReportStatus("Validate Data File ", PASS , "Data file -  {sDataFile} is created")
		[ ] 
		[ ] 
		[ ] //Add A checking account--------------------------------------------------------------------------------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
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
			[ ] 
			[ ] //Select Checking Account---------------------------------------------------------------------------------------------------------------
			[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING,1)
			[+] if (iSelect==PASS)
				[ ] AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1])
				[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Add Transaction",PASS,"Transaction {lsTransaction[6]} added succesfully to Account {lsAddAccount[2]}")
					[ ] ////////Fetch 2nd row from sExpenseCategoryDataSheet////
					[ ] lsExpenseCategory=lsExcelData[2]
					[ ] sleep(2)
					[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
					[+] if(SplitTransaction.Exists(2))
						[ ] SplitTransaction.SetActive()
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#2")
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
						[+] if (SplitTransaction.Adjust.IsEnabled())
							[ ] SplitTransaction.Adjust.Click()
						[ ] SplitTransaction.OK.Click()
						[ ] WaitForState(SplitTransaction,False,1)
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
						[ ] ////########Verify Split Button in the category field of the transaction#########///////// 
						[ ] iVerify=FAIL
						[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
						[ ] 
						[+] if(iVerify==PASS)
							[+] if (MDIClient.AccountRegister.TxList.AddedSplitButton.Exists(3))
								[ ] ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction appeared.")
								[ ] ////########Verify clicking Split Button in the category field of the transaction invokes the split transaction dailog with all categories#########///////// 
								[ ] MDIClient.AccountRegister.TxList.AddedSplitButton.DoubleClick()
								[+] if(SplitTransaction.Exists(2))
									[ ] SplitTransaction.SetActive()
									[ ] 
									[ ] hWnd=NULL
									[ ] lsExpenseCategory=NULL
									[ ] lsExpenseCategory=lsExcelData[1]
									[ ] nAmount=VAL(lsExpenseCategory[2])
									[ ] lsAmountData=Split(Str(nAmount,7,2),".")
									[ ] hWnd = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
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
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "1")
									[ ] //bMatch =MatchStr("*{lsExpenseCategory[1]}",sActual)
									[ ] bMatch =MatchStr("*{lsExpenseCategory[1]}*{lsExpenseCategory[4]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
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
							[ ] 
						[+] else
								[ ] ReportStatus("Verify Split Transaction",FAIL,"Verify Split Transaction:Transaction with payee {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
						[ ] 
						[ ] 
						[ ] ////########Verify Clear Split Button in the category field of the transaction#########///////// 
						[ ] iVerify=FAIL
						[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
						[+] if(iVerify==PASS)
							[+] if (MDIClient.AccountRegister.TxList.ClearSplitlinesButton.Exists(3))
								[ ] ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction appeared.")
								[ ] ////########Verify clicking Clear Split Lines Button in the category field of the transaction deletes all split lines#########///////// 
								[ ] MDIClient.AccountRegister.TxList.ClearSplitlinesButton.DoubleClick(1,8,8)
								[+] if(AlertMessage.Exists(3))
									[ ] AlertMessage.Yes.Click()
								[+] else if(AlertMessage.Exists(3))
									[ ] AlertMessage.Yes.Click()
								[ ] 
								[ ] 
								[ ] //Verify if split dialog is empty
								[ ] iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
								[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
								[+] if(SplitTransaction.Exists(2))
									[ ] SplitTransaction.SetActive()
									[ ] 
									[ ] hWnd=NULL
									[ ] lsExpenseCategory=NULL
									[ ] lsExpenseCategory=lsExcelData[1]
									[ ] nAmount=VAL(lsExpenseCategory[2])
									[ ] lsAmountData=Split(Str(nAmount,7,2),".")
									[ ] hWnd = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
									[ ] bMatch =MatchStr("*{lsExpenseCategory[1]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
									[+] if (bMatch==FALSE)
										[ ] ReportStatus("Verify split transaction dailog ",PASS,"Split Lines are cleared for split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)}.")
									[+] else
										[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Split Lines are not cleared for split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)}.")
									[ ] bMatch=FALSE
									[ ] lsExpenseCategory=NULL
									[ ] lsExpenseCategory=lsExcelData[2]
									[ ] nAmount=VAL(lsExpenseCategory[2])
									[ ] lsAmountData=Split(Str(nAmount,7,2),".")
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "1")
									[ ] //bMatch =MatchStr("*{lsExpenseCategory[1]}",sActual)
									[ ] bMatch =MatchStr("*{lsExpenseCategory[1]}*{lsExpenseCategory[3]}*{lsExpenseCategory[4]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
									[+] if (bMatch==FALSE)
										[ ] ReportStatus("Verify split transaction dailog ",PASS,"Split Lines are cleared for split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)}.")
									[+] else
										[ ] ReportStatus("Verify split transaction dailog ",FAIL,"Split Lines are not cleared for split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)}.")
										[ ] 
									[+] if (!SplitTransaction.IsActive())
										[ ] SplitTransaction.SetActive()
									[ ] SplitTransaction.OK.Click()
									[ ] WaitForState(SplitTransaction,False,1)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Split Button in the transaction",FAIL,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction didn't appear.")
							[ ] 
						[+] else
								[ ] ReportStatus("Verify Split Transaction",FAIL,"Verify Split Transaction:Transaction with payee {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
					[ ] 
					[ ] 
					[ ] 
					[+] else
						[ ] ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
				[+] else
					[ ] ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
			[+] else
				[ ] ReportStatus("Verify Checking Account", FAIL, "Checking account couldn't open.")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is not created")
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
		[+] // if(QuickenWindow.Exists(3))
			[ ] // QuickenWindow.SetActive ()
			[ ] // 
			[ ] // //Select the Banking account
			[ ] // iSelect = AccountBarSelect(ACCOUNT_BANKING,1)
			[+] // if (iSelect==PASS)
				[ ] // AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsExpenseCategory[2],sDateStamp,lsTransaction[5],lsTransaction[6],lsExpenseCategory[4],lsExpenseCategory[1])
				[ ] // iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
				[+] // if(iVerify==PASS)
					[ ] // ReportStatus("Add Transaction",PASS,"Transaction {lsTransaction[6]} added succesfully to Account {lsAddAccount[2]}")
					[ ] // ////////Fetch 2nd row from sExpenseCategoryDataSheet////
					[ ] // lsExpenseCategory=lsExcelData[2]
					[ ] // MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
					[+] // if(SplitTransaction.Exists(2))
						[ ] // SplitTransaction.SetActive()
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#2")
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[1])
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // //SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[3])
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[+] // // if (NewTag.Exists(3))
							[ ] // // NewTag.SetActive()
							[ ] // // NewTag.OKButton.Click()
							[ ] // 
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[4])
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(lsExpenseCategory[2])
						[ ] // SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_ENTER)
						[+] // if (SplitTransaction.Adjust.IsEnabled())
							[ ] // SplitTransaction.Adjust.Click()
						[ ] // SplitTransaction.OK.Click()
						[ ] // WaitForState(SplitTransaction,False,1)
						[ ] // MDIClient.AccountRegister.SetActive()
						[ ] // MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
						[ ] // ////########Verify Split Button in the category field of the transaction#########///////// 
						[ ] // iVerify=FAIL
						[ ] // iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
						[ ] // 
						[+] // if(iVerify==PASS)
							[+] // if (MDIClient.AccountRegister.TxList.AddedSplitButton.Exists(3))
								[ ] // ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction appeared.")
								[ ] // ////########Verify clicking Split Button in the category field of the transaction invokes the split transaction dailog with all categories#########///////// 
								[ ] // MDIClient.AccountRegister.TxList.AddedSplitButton.Click()
								[+] // if(SplitTransaction.Exists(2))
									[ ] // SplitTransaction.SetActive()
									[ ] // 
									[ ] // hWnd=NULL
									[ ] // lsExpenseCategory=NULL
									[ ] // lsExpenseCategory=lsExcelData[1]
									[ ] // nAmount=VAL(lsExpenseCategory[2])
									[ ] // lsAmountData=Split(Str(nAmount,7,2),".")
									[ ] // hWnd = Str(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetHandle ())
									[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
									[ ] // bMatch =MatchStr("*{lsExpenseCategory[1]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
									[+] // if (bMatch==TRUE)
										[ ] // ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data: split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} appeared.")
									[+] // else
										[ ] // ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data: split transaction category {lsExpenseCategory[2]} with amount {Str(nAmount,7,2)} didn't appear.")
									[ ] // bMatch=FALSE
									[ ] // lsExpenseCategory=NULL
									[ ] // lsExpenseCategory=lsExcelData[2]
									[ ] // nAmount=VAL(lsExpenseCategory[2])
									[ ] // lsAmountData=Split(Str(nAmount,7,2),".")
									[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "1")
									[ ] // bMatch =MatchStr("*{lsExpenseCategory[1]}*{lsExpenseCategory[3]}*{lsExpenseCategory[4]}*{trim(lsAmountData[1])}*{trim(lsAmountData[2])}*",sActual)
									[+] // if (bMatch==TRUE)
										[ ] // ReportStatus("Verify split transaction dailog ",PASS,"Verify split transaction dailog data: Transaction with category {lsExpenseCategory[2]} , Tag: {lsExpenseCategory[3]}, Memo: {lsExpenseCategory[4]} and with amount:{Str(nAmount,7,2)}appeared.")
									[+] // else
										[ ] // ReportStatus("Verify split transaction dailog ",FAIL,"Verify split transaction dailog data: Transaction with category {lsExpenseCategory[2]} , Tag: {lsExpenseCategory[3]}, Memo: {lsExpenseCategory[4]} and with amount: {Str(nAmount,7,2)} didn't appear.")
										[ ] // 
									[+] // if (!SplitTransaction.IsActive())
										[ ] // SplitTransaction.SetActive()
									[ ] // SplitTransaction.OK.Click()
									[ ] // WaitForState(SplitTransaction,False,1)
									[ ] // 
								[+] // else
									[ ] // ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
							[+] // else
								[ ] // ReportStatus("Verify Split Button in the transaction",FAIL,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction didn't appear.")
							[ ] // 
						[+] // else
								[ ] // ReportStatus("Verify Split Transaction",FAIL,"Verify Split Transaction:Transaction with payee {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
						[ ] // 
						[ ] // 
						[ ] // ////########Verify Clear Split Button in the category field of the transaction#########///////// 
						[ ] // iVerify=FAIL
						[ ] // iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
						[+] // if(iVerify==PASS)
							[+] // if (MDIClient.AccountRegister.TxList.ClearSplitlinesButton.Exists(3))
								[ ] // ReportStatus("Verify Split Button in the transaction",PASS,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction appeared.")
								[ ] // ////########Verify clicking Split Button in the category field of the transaction invokes the split transaction dailog with all categories#########///////// 
								[ ] // MDIClient.AccountRegister.TxList.ClearSplitlinesButton.Click(1,9,8)
								[+] // if(AlertMessage.Exists(3))
									[ ] // AlertMessage.Yes.Click()
								[+] // else if(MessageBox.Exists(3))
									[ ] // MessageBox.Yes.Click()
								[ ] // 
								[ ] // 
								[ ] // //Verify if split dialog is empty
								[ ] // iVerify=FindTransaction(sMDIWindow,lsTransaction[6])
								[ ] // MDIClient.AccountRegister.TxList.TxToolBar.Split.Click()
								[+] // if(SplitTransaction.Exists(2))
									[ ] // SplitTransaction.SetActive()
									[ ] // 
									[ ] // hWnd=NULL
									[+] // if(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.GetItemCount()==0)
										[ ] // ReportStatus("Verify Clear Split lines Button in the transaction",PASS,"All Split data cleared")
										[ ] // 
									[+] // else
										[ ] // ReportStatus("Verify Clear Split lines Button in the transaction",FAIL,"Split data not cleared")
										[ ] // 
									[ ] // 
									[ ] // 
									[ ] // 
									[ ] // 
								[+] // else
									[ ] // ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
								[ ] // 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Verify Split Button in the transaction",FAIL,"Verify Split Button in the category field of the transaction:  Split Button in the category field of the transaction didn't appear.")
							[ ] // 
						[+] // else
								[ ] // ReportStatus("Verify Split Transaction",FAIL,"Verify Split Transaction:Transaction with payee {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
					[ ] // 
					[ ] // 
					[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify split transaction dailog",FAIL,"Verify split transaction dailog: split transaction dailog didn't appear.")
				[+] // else
					[ ] // ReportStatus("Add Transaction",FAIL,"Transaction {lsTransaction[6]} not added to Account {lsAddAccount[2]}")
			[+] // else
				[ ] // ReportStatus("Verify Checking Account", FAIL, "Checking account couldn't open.")
		[+] // else
			[ ] // ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
		[ ] // 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL , "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //############# Verify Correct Window Title displayed for Business Accounts##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC182_AttachDialogForTwoAccount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Correct Window Title displayed for Business Accounts
		[ ] //   
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If correct window name is displayed
		[ ] //						Fail			If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                              22 April 2013		
		[ ] //Author                          Dean Paes
		[ ] 
	[ ] // ********************************************************
[+] testcase TC183_CorrectWindowTitleBusinessAccount() appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] //String
	[ ] 
	[+] if (QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] 
		[ ] // Add Business Account
		[+] for (iCounter=12; iCounter<14;++iCounter)
			[ ] lsAddAccount=lsExcelData[iCounter]
			[+] if (lsAddAccount[1]==NULL)
				[ ] break
			[ ] sAccountName=lsAddAccount[2]
			[ ] iAddAccount = AddBusinessAccount(lsAddAccount[1], sAccountName)
			[ ] 
			[ ] //----------Turn On Popup Register---------------
			[ ] iPopupRegister = UsePopupRegister("ON")
			[+] if (iPopupRegister==PASS)
				[ ] 
				[ ] //-------Select Accounts Payable Receivable From Account Bar------------
				[ ] iVerify=SelectAccountFromAccountBar(sAccountName,ACCOUNT_BUSINESS)
				[+] if(iVerify==PASS)
					[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sAccountName} selected successfully")
					[ ] 
					[ ] //----------Get Caption--------------
					[ ] sCaption = BankingPopUp.Getproperty("Caption")
					[ ] 
					[ ] //-----------Match Caption with window name------------
					[ ] bMatch=MatchStr(sCaption,sAccountName)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify Account Window Title",PASS, "Correct Account Title is displayed for {sAccountName} account")
					[+] else
						[ ] ReportStatus("Verify Account Window Title",FAIL, "Correct Account Title is not displayed for {sCaption} account:{sAccountName} ")
					[ ] 
					[ ] //----------Close Account Register--------------
					[ ] BankingPopUp.Close()
					[ ] WaitForState(BankingPopUp, false,1)
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sAccountName} not selected")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[+] if (BankingPopUp.Exists(3))
					[ ] BankingPopUp.SetActive()
					[ ] BankingPopUp.Close()
				[ ] 
				[ ] 
				[ ] //----------Turn Off Popup Register---------------
				[ ] iPopupRegister = UsePopupRegister("OFF")
				[+] if (iPopupRegister==FAIL)
					[ ] ReportStatus("Popup Register OFF",FAIL,"Popup Register couldn't be set OFF")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Popup Register ON",FAIL,"Popup Register couldn't be set ON.")
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
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken Main window is not opened")
[ ] 
[+] ////############# Verify Transaction Filter Contents in Account Register ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC184_185_FilterForAllTransactionTypeBusinessAccounts()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if content under Transaction and Type filters is correct for business account registers	
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If all content under Transaction and Type filters is correct		
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  18th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC184_185_FilterForAllTransactionTypeBusinessAccounts() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,i
		[ ] 
		[ ] //String
		[ ] //STRING sAccountName
		[ ] STRING sVendorAccount="Vendor Invoices Account"
		[ ] STRING  sCustomerAccount="Customer Invoices Account"
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] 
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionContents,lsTypeContents,lsActualCustomerTypeFilterContents,lsActualVendorTypeFilterContents,lsActualTransactionFilterContents
		[ ] 
		[ ] 
		[ ] lsActualCustomerTypeFilterContents={"Any Type","Paid","Charged"}
		[ ] lsActualVendorTypeFilterContents={"Any Type","Billed","Paid"}
		[ ] 
		[ ] lsActualTransactionFilterContents={"All Transactions","Uncategorized","Unreconciled","Cleared","Uncleared","Flagged"}
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sVendorAccount =lsExcelData[12][2]
		[ ] sCustomerAccount =lsExcelData[13][2]
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[-] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Accounts Receivable From Account Bar
			[ ] iVerify=NULL
			[ ] iVerify=SelectAccountFromAccountBar(sCustomerAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sCustomerAccount} selected successfully")
				[ ] 
				[ ] 
				[ ] //Transaction Filter exists
				[+] if(MDIClient.AccountRegister.TransactionTypeFilter.Exists(3))
					[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"Transaction Type Filter is present in Account Register for {sCustomerAccount} type account")
					[ ] 
					[ ] lsTransactionContents=MDIClient.AccountRegister.TransactionTypeFilter.GetContents()
					[ ] 
					[+] for(i=1;i<=ListCount(lsTransactionContents);i++)
						[ ] 
						[ ] // // Read data from excel sheet
						[ ] // lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
						[ ] // lsTransactionFilterData=lsExcelData[i]
						[ ] // 
						[ ] 
						[ ] bMatch=MatchStr("*{lsActualTransactionFilterContents[i]}*",lsTransactionContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"{lsActualTransactionFilterContents[i]} option present under Transaction Type Filter in Account Register for {sCustomerAccount}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"{lsActualTransactionFilterContents[i]} option not found under Transaction Type Filter in Account Register for {sCustomerAccount}")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"Transaction Type Filter does not exist in Account Register")
					[ ] 
				[ ] 
				[ ] //Type Filter exists
				[+] if(MDIClient.AccountRegister.TypeFilter.Exists(3))
					[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"Transaction Type Filter is present in Account Register")
					[ ] 
					[ ] lsTypeContents=MDIClient.AccountRegister.TypeFilter.GetContents()
					[ ] 
					[ ] 
					[+] for(i=1;i<=ListCount(lsTypeContents);i++)
						[ ] 
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{lsActualCustomerTypeFilterContents[i]}*",lsTypeContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"{lsActualCustomerTypeFilterContents[i]} option present under Type Filter in Account Register")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"{lsActualCustomerTypeFilterContents[i]} option not found under Type Filter in Account Register")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"Transaction Type Filter does not exist in Account Register")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sCustomerAccount} not selected")
			[ ] 
			[ ] 
			[ ] //Select Accounts Payable From Account Bar
			[ ] iVerify=NULL
			[ ] iVerify=SelectAccountFromAccountBar(sVendorAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sVendorAccount} selected successfully")
				[ ] 
				[ ] 
				[ ] //Transaction Filter exists
				[+] if(MDIClient.AccountRegister.TransactionTypeFilter.Exists(3))
					[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"Transaction Type Filter is present in Account Register for {sVendorAccount} type account")
					[ ] 
					[ ] lsTransactionContents=MDIClient.AccountRegister.TransactionTypeFilter.GetContents()
					[ ] 
					[ ] 
					[+] for(i=1;i<=ListCount(lsTransactionContents);i++)
						[ ] 
						[ ] bMatch=MatchStr("*{lsActualTransactionFilterContents[i]}*",lsTransactionContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"{lsActualTransactionFilterContents[i]} option present under Transaction Type Filter in Account Register")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"{lsActualTransactionFilterContents[i]} option not found under Transaction Type Filter in Account Register")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"Transaction Type Filter does not exist in Account Register")
					[ ] 
				[ ] 
				[ ] //Type Filter exists
				[+] if(MDIClient.AccountRegister.TypeFilter.Exists(3))
					[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"Transaction Type Filter is present in Account Register")
					[ ] 
					[ ] lsTypeContents=MDIClient.AccountRegister.TypeFilter.GetContents()
					[ ] 
					[ ] 
					[+] for(i=1;i<=ListCount(lsTypeContents);i++)
						[ ] 
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{lsActualVendorTypeFilterContents[i]}*",lsTypeContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if Filters are present in Account Register",PASS,"{lsActualVendorTypeFilterContents[i]} option present under Type Filter in Account Register")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"{lsActualVendorTypeFilterContents[i]} option not found under Type Filter in Account Register")
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Filters are present in Account Register",FAIL,"Transaction Type Filter does not exist in Account Register")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sVendorAccount} not selected")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open data file",FAIL,"Data File {sFileName} opened successfully")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Filters present in account register",FAIL,"Quicken Main Window Not found")
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Date Filter Contents in Account Register ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC36_FilterForAllDates()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if content under Date filter is correct
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		 If all content under Date filter is correct					
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  19/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC186_FilterForAllDates() appstate none
	[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //Integer
		[ ] INTEGER iVerify,i
		[ ] 
		[ ] //String
		[ ] STRING sAccountName
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sAccountWorksheet)
		[ ] STRING sVendorAccount="Vendor Invoices Account"
		[ ] STRING  sCustomerAccount="Customer Invoices Account"
		[ ] 
		[ ] 
		[ ] //List of String
		[ ] LIST OF STRING lsDateContents,lsTransactionFilterData
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sVendorAccount =lsExcelData[12][2]
		[ ] sCustomerAccount =lsExcelData[13][2]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] //Select Accounts Payable From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sVendorAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sVendorAccount} selected successfully")
				[ ] 
				[ ] 
				[ ] //Verify Date Filter Contents
				[+] if(MDIClient.AccountRegister.DateFilter.Exists(3))
					[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Transaction Type Filter is present in Account Register")
					[ ] 
					[ ] lsDateContents=MDIClient.AccountRegister.DateFilter.GetContents()
					[+] for(i=1;i<=ListCount(lsDateContents);i++)
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
						[ ] lsTransactionFilterData=lsExcelData[i]
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionFilterData[2]}*",lsDateContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if correct data is present under filters",PASS,"{lsTransactionFilterData[2]} option present under Date Filter in Account Register for {sVendorAccount}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"{lsTransactionFilterData[2]} option not found under Date Filter in Account Register for {sVendorAccount}")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sAccountName} not selected")
					[ ] 
			[+] else
				[ ] ReportStatus("Select account from account bar",PASS,"Account {sVendorAccount} selected successfully")
			[ ] 
			[ ] 
			[ ] //Select Accounts Receivable From Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sCustomerAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {sCustomerAccount} selected successfully")
				[ ] 
				[ ] 
				[ ] //Verify Date Filter Contents
				[+] if(MDIClient.AccountRegister.DateFilter.Exists(3))
					[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Transaction Type Filter is present in Account Register")
					[ ] 
					[ ] lsDateContents=MDIClient.AccountRegister.DateFilter.GetContents()
					[+] for(i=1;i<=ListCount(lsDateContents);i++)
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sDateFilterWorksheet)
						[ ] lsTransactionFilterData=lsExcelData[i]
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionFilterData[2]}*",lsDateContents[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if correct data is present under filters",PASS,"{lsTransactionFilterData[2]} option present under Date Filter in Account Register for {sCustomerAccount}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"{lsTransactionFilterData[2]} option not found under Date Filter in Account Register for {sCustomerAccount}")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sAccountName} not selected")
					[ ] 
			[+] else
				[ ] ReportStatus("Select account from account bar",PASS,"Account {sCustomerAccount} selected successfully")
		[+] else
			[ ] ReportStatus("Open data file",FAIL,"Data File {sFileName} opened successfully")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Filters present in account register",FAIL,"Quicken Main Window Not found")
	[ ] 
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC187_VerifyAllTransactionsFilterInBusinessAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "All Transactions" Filter of Business Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  15th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase  TC187_VerifyAllTransactionsFilterInBusinessAccountRegister() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] STRING sBusinessAccount="Vendor Invoices"
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
		[ ] lsTransactionFilterData=lsExcelData[1]
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[12][2]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] SelectAccountFromAccountBar(sBusinessAccount,ACCOUNT_BUSINESS)
			[ ] 
			[ ] //Verify the All Transactions Filter
			[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[4])
		[+] else
			[ ] ReportStatus("Open data file",FAIL,"Data File {sFileName} opened successfully")
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
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC188_VerifyUncategorizedFilterInBusinessAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Uncategorized" Filter of Business Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  15th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase  TC188_VerifyUncategorizedFilterInBusinessAccountRegister() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] STRING sCheckingAccount="Checking"
		[ ] STRING sBusinessAccount="Vendor Invoices"
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[12][2]
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
		[ ] lsTransactionFilterData=lsExcelData[2]
		[ ] 
		[ ] 
		[ ] //Select Account from Account Bar
		[ ] SelectAccountFromAccountBar(sBusinessAccount,ACCOUNT_BUSINESS)
		[ ] 
		[ ] //Verify the All Transactions Filter
		[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[4])
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
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC189_VerifyUnreconciledFilterInBusinessAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Unreconciled" Filter of Business Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  15th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase  TC189_VerifyUnreconciledFilterInBusinessAccountRegister() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] STRING sCheckingAccount="Checking 01 A"
		[ ] STRING sBusinessAccount="Vendor Invoices Account"
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[12][2]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
		[ ] lsTransactionFilterData=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] //Select Account from Account Bar
		[ ] SelectAccountFromAccountBar(sBusinessAccount,ACCOUNT_BUSINESS)
		[ ] 
		[ ] //Verify the All Transactions Filter
		[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[4])
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
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC191_VerifyUnclearedFilterInBusinessAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Uncleared" Filter of Business Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  15th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase  TC191_VerifyUnclearedFilterInBusinessAccountRegister() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String  
		[ ] STRING sFileName ,sCheckingAccount ,sBusinessAccount
		[ ] sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] sCheckingAccount="Checking 01 Account"
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[12][2]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
		[ ] lsTransactionFilterData=lsExcelData[4]
		[ ] 
		[ ] 
		[ ] //Select Account from Account Bar
		[ ] SelectAccountFromAccountBar(sBusinessAccount,ACCOUNT_BUSINESS)
		[ ] 
		[ ] //Verify the All Transactions Filter
		[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[4])
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
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC192_VerifyClearedFilterInBusinessAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Cleared" Filter of Business Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  15th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[-] testcase  TC192_VerifyClearedFilterInBusinessAccountRegister() appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] STRING sCheckingAccount="Checking"
		[ ] STRING sBusinessAccount="Vendor Invoices Account"
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[13][2]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[-] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
		[ ] lsTransactionFilterData=lsExcelData[5]
		[ ] 
		[ ] 
		[ ] //Select Account from Account Bar
		[ ] SelectAccountFromAccountBar(sBusinessAccount,ACCOUNT_BUSINESS)
		[ ] 
		[ ] //Verify the All Transactions Filter
		[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[4])
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
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC193_VerifyFlaggedFilterInBusinessAccountRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify "Flagged" Filter of Business Account Register
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  15th April 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[-] testcase  TC193_VerifyFlaggedFilterInBusinessAccountRegister() appstate none
	[ ] 
	[-] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] STRING sCheckingAccount="Checking"
		[ ] STRING sBusinessAccount="Vendor Invoices Account"
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sBusinessAccount =lsExcelData[13][2]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTransactionFilterWorksheet)
		[ ] lsTransactionFilterData=lsExcelData[6]
		[ ] 
		[ ] 
		[ ] //Select Account from Account Bar
		[ ] SelectAccountFromAccountBar(sBusinessAccount,ACCOUNT_BUSINESS)
		[ ] 
		[ ] //Verify the All Transactions Filter
		[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[4])
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
[ ] 
[ ] 
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC194_RegisterAllTypeFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will Verify "Flagged" Option from Transaction Dropdown menu in Account Register
		[ ] // 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC194_RegisterAllTypeFilter() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] STRING sVendorAccount="Vendor Invoices Account"
		[ ] STRING  sCustomerAccount="Customer Invoices Account"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sVendorAccount =lsExcelData[12][2]
		[ ] sCustomerAccount =lsExcelData[13][2]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTypeFilterWorksheet)
		[ ] 
	[ ] 
	[+] // if (QuickenWindow.Exists(3))
		[ ] // QuickenWindow.Kill()
		[ ] // App_Start(sCmdLine)
		[ ] // WaitForState(QuickenWindow,TRUE,10)
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] // Read data from excel sheet
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sCustomerAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] //Verify the All Type Filter
				[ ] lsTransactionFilterData=lsExcelData[4]
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sVendorAccount} not selected")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sVendorAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] //Verify the All Type Filter
				[ ] lsTransactionFilterData=NULL
				[ ] lsTransactionFilterData=lsExcelData[7]
				[ ] 
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[ ] 
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sVendorAccount} not selected")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
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
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC195_RegisterAllType_PaidFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will Verify "Flagged" Option from Transaction Dropdown menu in Account Register
		[ ] // 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC195_RegisterAllType_Paid_BilledFilter() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] STRING sVendorAccount="Vendor Invoices Account"
		[ ] STRING  sCustomerAccount="Customer Invoices Account"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sVendorAccount =lsExcelData[12][2]
		[ ] sCustomerAccount =lsExcelData[13][2]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet,sTypeFilterWorksheet)
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] // Read data from excel sheet
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sCustomerAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] //Verify the Paid Filter
				[ ] lsTransactionFilterData=lsExcelData[6]
				[ ] 
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sVendorAccount} not selected")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sVendorAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] //Verify the All Type Filter
				[ ] lsTransactionFilterData=NULL
				[ ] lsTransactionFilterData=lsExcelData[10]
				[ ] print(lsTransactionFilterData)
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[ ] 
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sVendorAccount} not selected")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
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
[+] ////############# Verify Transaction Filter in Account Register ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC196_RegisterAllType_ChargedFilter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //This testcase will Verify "Flagged" Option from Transaction Dropdown menu in Account Register
		[ ] // 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If all account details are present			
		[ ] //						Fail		       If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:  11/2/ 2013	Created by	Dean Paes
		[ ] //							
	[ ] // ********************************************************
[+] testcase TC196_RegisterAllType_Charged_PaidFilter() appstate none
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] //String
		[ ] STRING sFileName="TransactionTypeFilterFile"
		[ ] STRING sVendorAccount="Vendor Invoices Account"
		[ ] STRING  sCustomerAccount="Customer Invoices Account"
		[ ] //Integer
		[ ] INTEGER iVerify
		[ ] //List of String
		[ ] LIST OF STRING lsTransactionFilterData
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sRegAccountWorksheet)
		[ ] sVendorAccount =lsExcelData[12][2]
		[ ] sCustomerAccount =lsExcelData[13][2]
		[ ] lsExcelData=NULL
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcelsheet, sTypeFilterWorksheet)
		[ ] 
		[ ] 
		[ ] lsTransactionFilterData=lsExcelData[11]
		[ ] print(lsTransactionFilterData)
		[ ] 
	[ ] 
	[ ] 
	[-] if(QuickenWindow.Exists(3))
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] 
		[ ] //Open an Existing Data File
		[ ] iVerify = OpenDataFile(sFileName)
		[+] if (iVerify == PASS)
			[ ] // Read data from excel sheet
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sVendorAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] //Verify the Charged Filter
				[ ] lsTransactionFilterData=lsExcelData[11]
				[ ] print(lsTransactionFilterData)
				[ ] 
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sCustomerAccount} not selected")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Select Account from Account Bar
			[ ] iVerify=SelectAccountFromAccountBar(sCustomerAccount,ACCOUNT_BUSINESS)
			[+] if(iVerify==PASS)
				[ ] //Verify the All Type Filter
				[ ] lsTransactionFilterData=NULL
				[ ] lsTransactionFilterData=lsExcelData[12]
				[ ] print(lsTransactionFilterData)
				[ ] 
				[ ] VerifyAccountRegisterFilter(lsTransactionFilterData[1],lsTransactionFilterData[2],lsTransactionFilterData[3])
				[ ] 
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {sVendorAccount} not selected")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sFileName} is not opened")
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
