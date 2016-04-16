[ ] 
[+] // FILE NAME:	<Investing_AddTransaction.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This Utility add transactions in Investing Accounts as per the data provided through .xls file
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //
	[ ] // Developed on: 		21/4/2011
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 April 21, 2011	Udita Dube  Created
[ ] // *********************************************************
[ ] 
[ ] 
[-] // Global variables
	[ ] public LIST OF ANYTYPE  lsExcelData,lsTestData
	[ ] INTEGER i,iCount,iPos,iSelect,iCount1,j
	[ ] LIST OF STRING lsAddAccount,lsTransactionData
	[ ] public STRING sFileName = "Investing_AddTransaction"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sDataSheet = "Investing_AddTransaction.xls"
	[ ] public STRING sAccountWorksheet = "Investing Account"
	[ ] public STRING sStartQuicken = "{QUICKEN_ROOT}\qw.exe"
	[ ] public STRING sInvestingTransactionWorksheet = "Add Transaction"
	[ ] public STRING sCommonTransactionWorksheet = "Buy"
	[ ] public STRING sIncomeTransactionWorksheet = "Inc - Income"
	[ ] public STRING sStockSplitTransactionWorksheet = "Stock Split"
	[ ] public STRING sMiscExpTransactionWorksheet = "Miscellaneous Expense"
	[ ] public STRING sReturnCapitalTransactionWorksheet = "Return of Capital"
	[ ] public STRING sCashActionsWorkSheet = "Cash Actions" 
	[ ] public STRING sESPPWorksheet = "ESPP"
[ ] 
[ ] 
[+] //############### Create Investment Account ########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 AddBrokerageAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add Investment (Brokerage) Account 
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if investment account is added 					
		[ ] //							Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	22/4/2020  	Created By	Udita Dube
		[ ] // 											
	[ ] //*********************************************************
[+] // testcase AddBrokerageAccount () appstate none
	[ ] // 
	[-] // // Variable declaration
		[ ] // INTEGER  iAddAccount, iSwitchState,iSetupAutoAPI
		[ ] // BOOLEAN bMatch,bFlag
		[ ] // STRING sActual,sHandle
		[ ] // INTEGER iCreateDataFile,j
		[ ] // bFlag=TRUE
	[ ] // 
	[+] // // Perform Setup activities
		[+] // if(QuickenMainWindow.Exists())
			[ ] // QuickenMainWindow.VerifyEnabled(TRUE, 20)
			[ ] // QuickenMainWindow.SetActive()
			[ ] // QuickenMainWindow.Exit()
		[ ] // 
		[ ] // sleep(SHORT_SLEEP)
		[ ] // 
		[+] // if(FileExists(sDataFile))
			[ ] // DeleteFile(sDataFile)
		[ ] // 
		[+] // if(FileExists(sTestCaseStatusFile))
			[ ] // DeleteFile(sTestCaseStatusFile)
		[ ] // 
		[ ] // // Load O/S specific paths
		[ ] // LoadOSDependency()
		[ ] // 
		[ ] // iSetupAutoAPI = SetUp_AutoApi()
		[ ] // ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] // 
	[ ] // // Launch Quicken
	[+] // if (!QuickenMainWindow.Exists ())
		[ ] // QuickenMainWindow.Start (sStartQuicken)
	[ ] // 
	[+] // if (QuickenMainWindow.Exists(MEDIUM_SLEEP) == True)
		[ ] // QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] // 
		[ ] // // Create Data File
		[ ] // iCreateDataFile = DataFileCreate(sFileName)
		[ ] // 
		[ ] // // Report Staus If Data file Created successfully
		[+] // if ( iCreateDataFile  == PASS)
			[ ] // ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
		[ ] // // Report Staus If Data file is not Created 
		[+] // else if ( iCreateDataFile ==FAIL)
			[ ] // ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // // Report Staus If Data file already exists
		[+] // else
			[ ] // ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
		[ ] // 
	[ ] // // Report Status if Quicken is not launched
	[+] // else
		[ ] // ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] // 
	[-] // if(FileExists(sSmokeData))
		[ ] // // Read data from excel sheet
		[ ] // lsExcelData=ReadExcelTable(sDataSheet, sAccountWorksheet)
		[ ] // // Get row counts
		[ ] // iCount=ListCount(lsExcelData)
		[ ] // 
		[ ] // iSwitchState = UsePopupRegister("OFF")
		[ ] // 
		[-] // for(i=1;i<=iCount;i++)
			[ ] // 
			[ ] // lsAddAccount=lsExcelData[i]
			[-] // if(IsNULL(lsAddAccount[1]))
				[ ] // ReportStatus("Add Asset Account", FAIL, "Please enter data for 'AccountType' column in {sDataSheet} > {sAccountWorksheet} sheet ")
				[ ] // bFlag=FALSE
				[ ] // 
			[-] // if(IsNULL(lsAddAccount[2]))
				[ ] // ReportStatus("Add Asset Account", FAIL, "Please enter data for 'AccountName' column in {sDataSheet} > {sAccountWorksheet} sheet ")
				[ ] // bFlag=FALSE
				[ ] // 
			[-] // if(IsNULL(lsAddAccount[4]))
				[ ] // ReportStatus("Add Asset Account", FAIL, "Please enter data for 'Date' column in {sDataSheet} > {sAccountWorksheet} sheet ")
				[ ] // bFlag=FALSE
				[ ] // 
			[+] // if(IsNULL(lsAddAccount[5]))
				[ ] // lsAddAccount[5] = "Personal Transactions"
			[ ] // 
			[ ] // 
			[-] // do
				[ ] // 
				[ ] // // Quicken is launched then Add Brokerage Account
				[-] // if (QuickenMainWindow.Exists() == True && bFlag==TRUE)
					[ ] // 
					[ ] // // Add Investment Accounts
					[ ] // iAddAccount = AddManualBrokerageAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],lsAddAccount[5],lsAddAccount[6])
					[ ] // ReportStatus("Add Brokerage Account", iAddAccount, "Brokerage Account -  {lsAddAccount[2]} is created successfully")
					[ ] // 
					[ ] // //  Verify that Account is shown on account bar
					[-] // if(iAddAccount==PASS)
						[-] // if(MatchStr("Business*", lsAddAccount[5]))
							[ ] // sHandle=Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.GetHandle())
						[+] // else
							[ ] // sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer4.ListBox.GetHandle())
						[ ] // 
						[-] // for(j=0;j<iCount;j++)
							[ ] // sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{j}")
							[ ] // bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
							[-] // if(bMatch == TRUE)
								[ ] // ReportStatus("Validate Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
								[ ] // break
							[+] // else if (j==iCount)
								[ ] // ReportStatus("Validate Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
								[ ] // 
							[-] // else
								[ ] // continue
					[+] // else
						[ ] // ReportStatus("Verify Brokerage Account", FAIL, "Verification of account has not been done as Brokerage Account is not created")
						[ ] // 
				[ ] // 
				[ ] // // Report Status if Quicken is not launched
				[-] // else
					[ ] // ReportStatus("Validate Quicken Window", FAIL, "Either Quicken is not available or Data provided for add account is not correct") 
					[ ] // bFlag=TRUE
			[-] // except
				[ ] // QuickenMainWindow.kill()
				[ ] // QuickenMainWindow.Start (sStartQuicken)
				[ ] // continue
			[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Data file", FAIL, "{sSmokeData} Data file doesn't exists.")
	[ ] // 
	[ ] // 
[+] testcase AddBrokerageAccount () appstate none
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount, iSwitchState,iSetupAutoAPI,iCreateDataFile,j
		[ ] BOOLEAN bMatch,bFlag
		[ ] STRING sActual,sHandle,sFilePath
		[ ] INTEGER jCount=0
		[ ] bFlag=TRUE
		[ ] sFilePath = XLS_DATAFILE_PATH + "\" + sDataSheet
	[ ] 
	[+] // Perform Setup activities
		[-] if(QuickenMainWindow.Exists())
			[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
			[ ] QuickenMainWindow.SetActive()
			[ ] QuickenMainWindow.Exit()
		[ ] 
		[ ] sleep(SHORT_SLEEP)
		[ ] 
		[-] if(FileExists(sDataFile))
			[ ] DeleteFile(sDataFile)
		[ ] 
		[-] if(FileExists(sTestCaseStatusFile))
			[ ] DeleteFile(sTestCaseStatusFile)
		[ ] 
		[ ] // Load O/S specific paths
		[ ] LoadOSDependency()
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
	[ ] //Launch Quicken
	[+] if (!QuickenMainWindow.Exists ())
		[ ] QuickenMainWindow.Start (sStartQuicken)
	[ ] 
	[+] if (QuickenMainWindow.Exists(MEDIUM_SLEEP) == True)
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] 
		[ ] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] // Report Staus If Data file Created successfully
		[-] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
		[ ] // Report Staus If Data file is not Created 
		[+] else if ( iCreateDataFile ==FAIL)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // Report Staus If Data file already exists
		[-] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[+] if(FileExists(sFilePath))
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sDataSheet, sAccountWorksheet)
		[ ] // Get row counts
		[ ] iCount=ListCount(lsExcelData)
		[ ] 
		[ ] iSwitchState = UsePopupRegister("OFF")
		[ ] 
		[ ] 
		[-] for(i=1;i<=iCount;i++)
			[ ] 
			[ ] lsAddAccount=lsExcelData[i]
			[+] if(IsNULL(lsAddAccount[1]))
				[ ] ReportStatus("Add Brokerage Account", FAIL, "Please enter data for 'AccountType' column in {sDataSheet} > {sAccountWorksheet} sheet ")
				[ ] bFlag=FALSE
				[ ] 
			[+] if(IsNULL(lsAddAccount[2]))
				[ ] ReportStatus("Add Brokerage Account", FAIL, "Please enter data for 'AccountName' column in {sDataSheet} > {sAccountWorksheet} sheet ")
				[ ] bFlag=FALSE
				[ ] 
			[+] if(IsNULL(lsAddAccount[4]))
				[ ] ReportStatus("Add Brokerage Account", FAIL, "Please enter data for 'Date' column in {sDataSheet} > {sAccountWorksheet} sheet ")
				[ ] bFlag=FALSE
				[ ] 
			[+] if(IsNULL(lsAddAccount[5]))
				[ ] lsAddAccount[5] = "Personal Transactions"
			[ ] 
			[ ] 
			[-] do
				[ ] 
				[ ] // Quicken is launched then Add Brokerage Account
				[-] if (QuickenMainWindow.Exists() == True && bFlag==TRUE)
					[ ] 
					[ ] // Add Investment Accounts
					[ ] iAddAccount = AddManualBrokerageAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],lsAddAccount[5],lsAddAccount[6])
					[ ] 
					[ ] //  Verify that Account is shown on account bar
					[-] if(iAddAccount==PASS)
						[ ] ReportStatus("Add Brokerage Account", iAddAccount, "Brokerage Account -  {lsAddAccount[2]} is created successfully")
						[ ] 
						[+] if(MatchStr("Business*", lsAddAccount[5]))
							[ ] sHandle=Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.GetHandle())
						[+] else
							[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer4.ListBox.GetHandle())
						[ ] 
						[+] for(j=0;j<iCount;j++)
							[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{j}")
							[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
							[+] if(bMatch == TRUE)
								[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
								[ ] break
							[+] else if (j==iCount)
								[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
								[ ] 
							[+] else
								[ ] continue
					[+] else
						[ ] ReportStatus("Add Brokerage Account", iAddAccount, "Brokerage Account -  {lsAddAccount[2]} is not created")
						[ ] 
				[ ] 
				[ ] // Report Status if Quicken is not launched
				[+] else
					[ ] ReportStatus("Validate Quicken Window", FAIL, "Either Quicken is not available or Data provided for add account is not correct") 
					[ ] bFlag=TRUE
			[-] except
				[ ] QuickenMainWindow.kill()
				[ ] QuickenMainWindow.Start (sStartQuicken)
				[ ] continue
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data file", FAIL, "{sDataSheet} Data file doesn't exists.")
	[ ] 
[ ] 
[ ] //#############################################################################
[ ] 
[ ] 
[+] //############### Add Investment Transaction #######################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test13_InvestmentBuyTransaction()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Testcase verifies "Cash Balance" after Buy transaction from Brokerage Account
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Cash Balance after Buy transaction is correct	
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	24/12/2020  	Created By	Udita Dube
		[ ] // 
	[ ] //*********************************************************
[-] testcase AddInvestmentTransaction  () appstate none
	[ ] 
	[-] // Variable declaration
		[ ] BOOLEAN bMatch, bAccountFound, bAcountSelect
		[ ] INTEGER iAddTransaction, iSelect,iCount, k, iRowCount, iAccountSelect
		[ ] STRING sHandle,sActualCashBalance,sExpectedCashBalance,sActual, sAccountName
		[ ] LIST OF STRING lsRow
		[ ] 
		[ ] bAccountFound = FALSE
		[ ] bAcountSelect = FALSE
	[-] if(FileExists(XLS_DATAFILE_PATH + "/" + sDataSheet))
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sDataSheet, sInvestingTransactionWorksheet)
		[ ] // Get row counts
		[ ] iCount=ListCount(lsExcelData)
		[ ] 
		[-] if (QuickenMainWindow.Exists() == True)
			[-] for(i=1;i<=iCount;i++)
				[ ] lsTransactionData=lsExcelData[i]
				[ ] 
				[-] do
					[-] if(lsTransactionData[1] == "Buy" || lsTransactionData[1] =="Sell" || lsTransactionData[1] =="Add - Shares Added" || lsTransactionData[1] =="Remove - Shares Removed" || lsTransactionData[1] =="Bonds Bought" || lsTransactionData[1] =="Short Sale" || lsTransactionData[1] =="Cover Short Sale" || lsTransactionData[1] == "Adjust Share Balance")
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsTestData = ReadExcelTable(sDataSheet, sCommonTransactionWorksheet)
						[ ] 
						[ ] // Get row count
						[ ] iCount1=ListCount(lsTestData)
						[ ] 
						[-] for(j=1;j<=iCount1;j++)
							[ ] iAccountSelect = AccountSelect(lsTestData[j][2], lsTestData[j][3])
							[-] if(iAccountSelect == PASS)
								[ ] 
								[ ] // Add Transaction with all data
								[ ] iAddTransaction= AddBrokerageTransaction(lsTestData[j])
								[-] if(iAddTransaction == PASS)
									[ ] ReportStatus("Add Brokerage Transaction: {lsTestData[j][1]}", iAddTransaction, "{lsTestData[j][1]} Transaction is added in account {lsTestData[j][3]}") 
								[ ] 
								[+] else
									[ ] ReportStatus("Add Brokerage Transaction: {lsTestData[j][1]}", iAddTransaction, "{lsTestData[j][1]} Transaction is not added in account {lsTestData[j][3]}") 
							[ ] 
							[-] else
								[ ] ReportStatus("Validate Account", FAIL, "{lsTestData[j][3]} Account not found")
								[ ] continue
					[ ] 
					[+] else if  (lsTransactionData[1] == "Inc - Income")
						[ ] 
						[ ] // Read data from excel sheet
						[ ] lsTestData=ReadExcelTable(sDataSheet, sIncomeTransactionWorksheet)
						[ ] // Get row count
						[ ] iCount1=ListCount(lsTestData)
						[ ] 
						[-] for(j=1;j<=iCount1;j++)
							[ ] iAccountSelect = AccountSelect(lsTestData[j][2], lsTestData[j][3])
							[-] if(iAccountSelect == PASS)
								[ ] 
								[ ] // Add Transaction with all data
								[ ] iAddTransaction= Inv_AddIncomeTransaction(lsTestData[j])
								[-] if(iAddTransaction == PASS)
									[ ] ReportStatus("Add Brokerage Transaction: {lsTestData[j][1]}", iAddTransaction, "{lsTestData[j][1]} Transaction is added in account {lsTestData[j][3]}") 
								[+] else
									[ ] ReportStatus("Add Brokerage Transaction: {lsTestData[j][1]}", iAddTransaction, "{lsTestData[j][1]} Transaction is not added in account {lsTestData[j][3]}") 
							[-] else
								[ ] ReportStatus("Validate Account", FAIL, "{lsTestData[j][3]} Account not found")
								[ ] continue
					[ ] 
					[+] else if (lsTransactionData[1] == "Stock Split")
						[ ] // Read data from excel sheet
						[ ] lsTestData=ReadExcelTable(sDataSheet, sStockSplitTransactionWorksheet)
						[ ] // Get row counts
						[ ] iCount1=ListCount(lsTestData)
						[-] for(j=1;j<=iCount1;j++)
							[ ] iAccountSelect = AccountSelect(lsTestData[j][2], lsTestData[j][3])
							[-] if(iAccountSelect == PASS)
								[ ] 
								[ ] // Stock Split Transaction with all data
								[ ] iAddTransaction= Inv_AddStockSplitTransaction(lsTestData[j])
								[-] if(iAddTransaction == PASS)
									[ ] ReportStatus("Add Brokerage Transaction: {lsTestData[j][1]}", iAddTransaction, "{lsTestData[j][1]} Transaction is added in account {lsTestData[j][3]}") 
								[-] else
									[ ] ReportStatus("Add Brokerage Transaction: {lsTestData[j][1]}", iAddTransaction, "{lsTestData[j][1]} Transaction is not added in account {lsTestData[j][3]}") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Account", FAIL, "{lsTestData[j][3]} Account not found")
								[ ] continue
					[ ] 
					[+] else if (lsTransactionData[1] == "Miscellaneous Expense")
						[ ] // Read data from excel sheet
						[ ] lsTestData=ReadExcelTable(sDataSheet, sMiscExpTransactionWorksheet)
						[ ] // Get row counts
						[ ] iCount1=ListCount(lsTestData)
						[-] for(j=1;j<=iCount1;j++)
							[ ] iAccountSelect = AccountSelect(lsTestData[j][2], lsTestData[j][3])
							[-] if(iAccountSelect == PASS)
								[ ] 
								[ ] // Buy Transaction with all data
								[ ] iAddTransaction= Inv_MiscExpTransaction(lsTestData[j])
								[-] if(iAddTransaction == PASS)
									[ ] ReportStatus("Add Brokerage Transaction: {lsTestData[j][1]}", iAddTransaction, "{lsTestData[j][1]} Transaction is added in account {lsTestData[j][3]}") 
								[-] else
									[ ] ReportStatus("Add Brokerage Transaction: {lsTestData[j][1]}", iAddTransaction, "{lsTestData[j][1]} Transaction is not added in account {lsTestData[j][3]}") 
							[+] else
								[ ] ReportStatus("Validate Account", FAIL, "{lsTestData[j][3]} Account not found")
								[ ] continue
					[ ] 
					[+] else if (lsTransactionData[1] == "Return of Capital")
						[ ] // Read data from excel sheet
						[ ] lsTestData=ReadExcelTable(sDataSheet, sReturnCapitalTransactionWorksheet)
						[ ] // Get row counts
						[ ] iCount1=ListCount(lsTestData)
						[+] for(j=1;j<=iCount1;j++)
							[ ] iAccountSelect = AccountSelect(lsTestData[j][2], lsTestData[j][3])
							[-] if(iAccountSelect == PASS)
								[ ] 
								[ ] // Buy Transaction with all data
								[ ] iAddTransaction= Inv_ReturnOfCapital(lsTestData[j])
								[+] if(iAddTransaction == PASS)
									[ ] ReportStatus("Add Brokerage Transaction: {lsTestData[j][1]}", iAddTransaction, "{lsTestData[j][1]} Transaction is added in account {lsTestData[j][3]}") 
								[+] else
									[ ] ReportStatus("Add Brokerage Transaction: {lsTestData[j][1]}", iAddTransaction, "{lsTestData[j][1]} Transaction is not added in account {lsTestData[j][3]}") 
							[+] else
								[ ] ReportStatus("Validate Account", FAIL, "{lsTestData[j][3]} Account not found")
								[ ] continue
					[ ] 
					[+] else if(lsTransactionData[1] == "Withdraw" || lsTransactionData[1] == "Deposit")
						[ ] // Read data from excel sheet
						[ ] lsTestData=ReadExcelTable(sDataSheet, sCashActionsWorkSheet)
						[ ] // Get row counts
						[ ] iCount1=ListCount(lsTestData)
						[-] for(j=1;j<=iCount1;j++)
							[ ] iAccountSelect = AccountSelect(lsTestData[j][2], lsTestData[j][3])
							[-] if(iAccountSelect == PASS)
								[ ] 
								[ ] // Add Transaction with all data
								[ ] iAddTransaction= Inv_CashActionTransaction(lsTestData[j])
							[-] else
								[ ] ReportStatus("Validate Account", FAIL, "{lsTestData[j][3]} Account not found")
								[ ] continue
						[ ] 
						[ ] 
					[ ] 
					[+] // else if(lsTransactionData[1] == "Bought ESPP Shares" || lsTransactionData[1] == "Sold ESPP Shares")
						[ ] // // Read data from excel sheet
						[ ] // lsTestData=ReadExcelTable(sDataSheet, sESPPWorksheet)
						[ ] // // Get row counts
						[ ] // iCount1=ListCount(lsTestData)
						[-] // for(j=1;j<=iCount1;j++)
							[ ] // iAccountSelect = AccountSelect(lsTestData[j][2], lsTestData[j][3])
							[-] // if(iAccountSelect == PASS)
								[ ] // 
								[ ] // // Add Transaction with all data
								[ ] // iAddTransaction= Inv_ESPPTransaction(lsTestData[j])
								[+] // if(iAddTransaction == PASS)
									[ ] // ReportStatus("Add Brokerage Transaction: {lsTestData[j][1]}", iAddTransaction, "{lsTestData[j][1]} Transaction is added in account {lsTestData[j][3]}") 
								[+] // else
									[ ] // ReportStatus("Add Brokerage Transaction: {lsTestData[j][1]}", iAddTransaction, "{lsTestData[j][1]} Transaction is not added in account {lsTestData[j][3]}") 
							[+] // else
								[ ] // ReportStatus("Validate Account", FAIL, "{lsTestData[j][3]} Account not found")
								[ ] // continue
					[ ] 
					[+] else
						[ ] continue
				[ ] 
				[-] except
					[ ] QuickenMainWindow.kill()
					[ ] QuickenMainWindow.Start (sStartQuicken)
					[ ] continue
				[ ] 
				[ ] // AccountSelect:
				[+] // if(bAcountSelect == TRUE)
					[ ] // // This will click account on AccountBar
					[-] // if(lsTestData[j][2] == "Personal Transactions" || lsTestData[j][2] == "Null")
						[-] // if(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer4.ListBox.Exists() == TRUE)
							[ ] // iRowCount = QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer4.ListBox.GetItemCount()		// Get no. of accounts
							[-] // for(k = 0; k<=iRowCount; k++)
								[ ] // AccountBarSelect(ACCOUNT_INVESTING, k)			// Select Account from account bar
								[ ] // sAccountName = QuickenMainWindow.GetCaption()
								[ ] // bMatch = MatchStr("*{lsTestData[j][3]}*", sAccountName)
								[-] // if(bMatch == TRUE)
									[ ] // bAccountFound = TRUE
									[ ] // break
								[+] // else
									[ ] // continue
						[ ] // 
					[ ] // 
					[+] // else if(lsTestData[j][2] == "Business Transactions")
						[-] // if(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.Exists() == TRUE)
							[ ] // iRowCount = QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.GetItemCount()		// Get no. of accounts
							[+] // for(k = 0; k<=iRowCount; k++)
								[ ] // AccountBarSelect(ACCOUNT_BUSINESS, k)			// Select Account from account bar
								[ ] // sAccountName = QuickenMainWindow.GetCaption()
								[ ] // bMatch = MatchStr("*{lsTestData[j][3]}*", sAccountName)
								[-] // if(bMatch == TRUE)
									[ ] // bAccountFound = TRUE
									[ ] // break
								[+] // else
									[ ] // continue
					[ ] // 
					[+] // else
						[ ] // ReportStatus("Validate Account in Account bar", FAIL, "{lsTestData[j][2]} is invalid")
						[ ] // bAccountFound = FALSE 
						[ ] // 
					[ ] // 
			[ ] 
		[ ] // Report Status if Quicken is not launched
		[-] else
			[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
[ ] //#############################################################################
[ ] 
