[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<InvestingRegistersAndFormsPart2.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all automated test cases for Investing Registers part of Investing Module for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	  DEAN PAES
	[ ] //
	[ ] // Developed on: 
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 March 19, 2014	 Dean Paes  Created
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
[ ] 
[+] // Global variables 
	[ ] 
	[ ] 
	[ ] //--------------EXCEL DATA----------------
	[ ] // .xls file
	[ ] public STRING sInvestingRegisterExcelData="Investing_Registers"
	[ ] 
	[ ] //Excel WorkSheets
	[ ] public STRING sAllAccountsSheet="AllAccounts"
	[ ] public STRING sBankingAccountsSheet="BankingAccounts"
	[ ] 
	[ ] public STRING sInvestingAccountSheet="InvestingAccountSheet"
	[ ] public STRING sEnterTransactionsExpectedSheet="EnterTransactionOptions"
	[ ] public STRING sAccountOverviewSheet="AccountOverviewSnapshot"
	[ ] public STRING sInvestingReportsSheet="Reports"
	[ ] public STRING sSecurityListSheet="SecurityList"
	[ ] public STRING sBuyTransactionDataSheet="BuySellTransactionData"
	[ ] public STRING sTransactionValidationSheet="TransactionValidation"
	[ ] public STRING sLotsValidationSheet="LotsValidation"
	[ ] public STRING sStockSplitSheet ="StockSplit"
	[ ] public STRING sStockSplitValidationSheet="StockSplitValidation"
	[ ] public STRING sStockDividendSheet="StockDividend"
	[ ] public STRING sReInvestSheet="ReInvestTransactions"
	[ ] public STRING sReInvestValidationSheet="ReInvestValidation"
	[ ] public STRING sIncomeTransactionSheet="IncomeTransactions"
	[ ] public STRING sIncomeValidationSheet="IncomeValidation"
	[ ] 
	[ ] public STRING sReturnOfCapitalSheet="ReturnOfCapital"
	[ ] public STRING sReturnOfCapitalValidationSheet="ReturnOfCapitalValidation"
	[ ] 
	[ ] 
	[ ] public STRING sCashTransactionSheet="CashTransaction"
	[ ] public STRING sCashTransactionValidationSheet="CashTransactionValidation"
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //----------STRING-------------------
	[ ] 
	[ ] public STRING sDataFile1="Investing_Register_WALL_User_Data_File.QDF"
	[ ] public STRING sDataFile2="Investing_Register_Data_File"
	[ ] 
	[ ] public STRING sDateFormat="m/d/yyyy"
	[ ] public STRING sDate=ModifyDate(0,sDateFormat)
	[ ] 
	[ ] public STRING sMDIWindow="MDI"
	[ ] 
	[ ] public STRING sBrowser="$C:\Program Files\Internet Explorer\iexplore.exe"
	[ ] 
	[ ] STRING sHandle,sActual,sExpected,sFileName
	[ ] 
	[ ] STRING sOptionsText="Options"
	[ ] STRING sEditText="Edit"
	[ ] 
	[ ] 
	[ ] //---------LIST OF STRING-----------
	[ ] LIST OF STRING lsAddAccount,lsExpected,lsActual,lsSecurity,lsTransactionData,lsTransactionValidation
	[ ] 
	[ ] //---------LIST OF ANYTYPE-----------
	[ ] LIST OF ANYTYPE lsExcelData
	[ ] 
	[ ] 
	[ ] //------------------INTEGER----------------
	[ ] public INTEGER iValidate,iCount,jCount
	[ ] 
	[ ] 
	[ ] //--------------BOOLEAN---------------
	[ ] public BOOLEAN bMatch,bMatch1,bMatch2
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] // 29-09-2015 KalyanG: added the method, to get edit button on registers into view
[+] public Void EditButtonScrollIntoView()
	[ ] 
	[ ] INTEGER iClick
	[ ] RECT barCoordinates
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] 
	[+] do
		[ ] window horizontalScroll = Desktop.Find("//Control[@caption='Quicken 20*']//HorizontalScrollBar")
	[+] except
		[ ] 
		[ ] // scroll bar does not exist hence come out from the method
		[ ] return
	[ ] 
	[ ] barCoordinates = horizontalScroll.GetRect()
	[ ] 
	[+] for (iClick=1; iClick <4; iClick++)
		[ ] 
		[ ] horizontalScroll.Click(1,barCoordinates.xSize-20, barCoordinates.ySize/2)
		[ ] sleep(0.5)
	[ ] 
	[ ] 
	[ ] 
[+] public void dismissDialog()
	[ ] 
	[ ] STRING sStaticText = "You are entering a transaction over a year away" 
	[ ] 
	[ ] // 2015-09-30 KalyanG: if the date entered is a year or more
	[+] if (AlertMessage.Exists(4))
		[ ] 
		[ ] STRING sActualStaticText = AlertMessage.StaticText.GetText()
		[ ] 
		[+] if (MatchStr("{sStaticText}*", sActualStaticText))
			[ ] 
			[ ] print ("[{sActualStaticText}] dialog got displayed, dismissing the dialog by clicking yes button..")
			[ ] AlertMessage.Yes.Click()
			[ ] sleep(2)
		[+] else
			[ ] LogError("[{sActualStaticText}] dialog appeared which was not expected and not handled in the script")
		[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[+] //#################  Verify Buy - Shares Bought Option on Enter Transaction Dialog  ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test49_Verify_Buy_Transaction_Entry_On_Enter_Transaction_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Buy - Shares Bought Option on Enter Transaction Dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Transaction is added in register using Buy - Shares Bought Option on Enter Transaction Dialog			
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  30th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test46_49_Verify_Buy_Transaction_Entry_On_Enter_Transaction_Dialog() appstate QuickenBaseState
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] List of STRING lsAddBrokerageAccount
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddBrokerageAccount = lsExcelData[4]
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sSecurityListSheet)
		[ ] lsSecurity=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[1]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sTransactionValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=DataFileCreate(sDataFile2)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Create Data File",PASS,"Data File created successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] // //Add Checking account
		[ ] iValidate=AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3])
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] //Add Brokerage account
			[ ] iValidate=AddManualBrokerageAccount(lsAddBrokerageAccount[1],lsAddBrokerageAccount[2],lsAddBrokerageAccount[3],sDate)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Add Manual Brokerage account",PASS,"Manual Brokerage account is added")
				[ ] 
				[ ] 
				[ ] iValidate=SelectAccountFromAccountBar(lsAddBrokerageAccount[2],ACCOUNT_INVESTING)
				[+] if(iValidate==PASS)
					[ ] 
					[ ] 
					[ ] // Click on Enter Transaction button
					[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
					[ ] // Verify if Enter Transaction Dialog exists
					[+] if(wEnterTransaction.Exists(5))
						[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
						[ ] 
						[ ] wEnterTransaction.SetActive()
						[ ] 
						[ ] 
						[ ] // Verify if only one account is displayed in the accounts dropdown
						[ ] lsActual=wEnterTransaction.Account.GetItems()
						[+] if(ListCount(lsActual)==1)
							[ ] ReportStatus("Verify that only a single account is present in account dropdown",PASS,"Single account is present in account dropdown")
							[ ] 
							[+] if(lsActual[1]==lsAddBrokerageAccount[2])
								[ ] ReportStatus("Verify that only single account is present in account dropdown",PASS,"Single account {lsAddBrokerageAccount[2]} is present in account dropdown :: Actual :{lsActual}")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that single account present in account dropdown is {lsAddBrokerageAccount[2]}",FAIL,"Account {lsAddBrokerageAccount[2]} is NOT present in account dropdown :: Actual :{lsActual}")
								[ ] 
						[+] else
							[ ] ReportStatus("Verify that only single account is present in account dropdown",FAIL,"Single account is NOT present in account dropdown :: Actual :{lsActual}")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] iValidate=AddBrokerageTransaction(lsTransactionData)
						[ ] 
						[+] if(iValidate==PASS)
							[ ] ReportStatus("Verify if transaction has been added to Manual Brokerage Account",PASS, "Buy Shares transaction has been added to Manual Brokerage Account")
							[ ] 
							[ ] WaitForState(wEnterTransaction,FALSE,5)
							[ ] //--------Verify that Transaction is entered in the Register-------
							[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
							[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
								[ ] 
								[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
								[ ] 
								[ ] 
								[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[8]}*",sActual)
								[+] if(bMatch==TRUE)
									[ ] 
									[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount+1))
									[ ] bMatch=MatchStr("*{lsTransactionValidation[7]}*",sActual)
									[+] if(bMatch==TRUE)
										[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[1]} is added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[5]} ; Cash Balance:{lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
										[ ] break
										[ ] 
								[ ] 
								[ ] 
							[+] if(bMatch==FALSE)
									[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[1]} is NOT added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[5]} , Cash Balance:{lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
								[ ] 
						[+] else
							[ ] ReportStatus("Verify if transaction has been added to Manual Brokerage Account",FAIL, "Buy Shares transaction has been added to Manual Brokerage Account")
					[+] else
						[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog does NOT exist")
						[ ] 
				[+] else
					[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Add Manual Brokerage account",FAIL,"Manual Brokerage account not added")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Add Manual spending account",FAIL,"Manual Spending account is not added")
			[ ] 
	[+] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File not created")
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] // //#################  Verify Buy - Shares Bought Option for Fractional Shares ####################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test50_Verify_Buy_Transaction_Fractional_Shares()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify Buy - Shares Bought Option on Enter Transaction Dialog with Fractional amount of shares
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If Transaction is added in register using Buy - Shares Bought Option on Enter Transaction Dialog			
		[ ] // //						Fail		      If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Dean Paes created  30th April 2014
		[ ] // //
	[ ] // // ********************************************************
[+] testcase Test50_Verify_Buy_Transaction_Fractional_Shares() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[4]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[2]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sTransactionValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[2]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=AddBrokerageTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------Verify that Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[8]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount+1))
					[ ] bMatch=MatchStr("*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[1]} is added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
						[ ] break
						[ ] 
				[ ] 
				[ ] 
			[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[1]} is NOT added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] // //#######################################################################################################
[ ] // 
[ ] // 
[+] //#################  Verify Buy - Shares Bought Option for Fractional Amount ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test51_Verify_Buy_Transaction_Fractional_Amount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Buy - Shares Bought Option on Enter Transaction Dialog with Fractional no for amount
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Transaction is added in register using Buy - Shares Bought Option on Enter Transaction Dialog			
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  30th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test51_Verify_Buy_Transaction_Fractional_Amount() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[4]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sTransactionValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] iValidate=AddBrokerageTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] //--------Verify that Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[8]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount+1))
					[ ] bMatch=MatchStr("*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[1]} is added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
						[ ] break
						[ ] 
				[ ] 
				[ ] 
			[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[1]} is NOT added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //########### Verify Edit operation for Buy Transaction for Shares , Amount and other fields as well as change in total cost ########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test52_53_54_55_56_Verify_Edit_Buy_Transaction_Shares_Amount_Fields()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 
		[ ] //  1. Edit operation for Buy Transaction for Shares , Amount and other fields as well as change in total cost.
		[ ] //  2. Account field should be inactive                                    
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Buy Transaction Shares , Amount and other fields can be edited AND change in total cost is correct.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  7th May 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test52_53_54_55_56_Verify_Edit_Buy_Transaction_Shares_Amount_Fields() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[4]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sTransactionValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[4]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] // Navigate to latest transaction
		[ ] QuickenMainWindow.TypeKeys(KEY_PAGE_DOWN)
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[3],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Edit Transaction 
				[ ] wEnterTransaction.NumberOfShares.SetText(lsTransactionValidation[4])
				[ ] wEnterTransaction.PricePaid.SetText(lsTransactionValidation[5])
				[ ] wEnterTransaction.Commission.SetText(lsTransactionValidation[6])
				[ ] wEnterTransaction.Memo.SetText(lsTransactionValidation[7])
				[ ] wEnterTransaction.EnterDone.Click()
				[+] if(RecalculateInvTxn.Exists(5))
					[ ] ReportStatus("Verify if Recalculate Investment Transaction dialog is displayed",PASS,"Recalculate Investment Transaction dialog is displayed")
					[ ] 
					[ ] // Select Option Total Cost
					[ ] RecalculateInvTxn.RecalculateOptionRadioList.Select(3)
					[ ] RecalculateInvTxn.OK.Click()
					[ ] WaitForState(RecalculateInvTxn,FALSE,5)
					[ ] 
					[ ] // In case of altering amount for shares
					[+] if(RecalculateInvTxn.Exists(5))
						[ ] 
						[ ] RecalculateInvTxn.RecalculateOptionRadioList.Select(3)
						[ ] RecalculateInvTxn.OK.Click()
						[ ] WaitForState(RecalculateInvTxn,FALSE,5)
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Recalculate Investment Transaction dialog is displayed",FAIL,"Recalculate Investment Transaction dialog is NOT displayed")
					[ ] 
					[ ] 
				[ ] 
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //------------ Verify that Transaction values have been edited -------------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[3]}*{lsTransactionValidation[8]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount+1))
						[ ] bMatch=MatchStr("*{lsTransactionValidation[7]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[1]} is added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
							[ ] break
							[ ] 
					[ ] 
					[ ] 
				[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[1]} is NOT added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //#################  Verify Sell - Transaction operation on Enter Transaction Dialog  ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test58_Verify_Sell_Transaction_Operation_On_Enter_Transaction_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Sell - Transaction operation on Enter Transaction Dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Sell - Transaction operation on Enter Transaction Dialog	adds a transaction for shares sold
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  9th May 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test58_Verify_Sell_Transaction_Operation_On_Enter_Transaction_Dialog() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[4]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[4]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sTransactionValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[5]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=AddBrokerageTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------Verify that Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[8]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[1]} is added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
					[ ] break
				[ ] 
				[ ] 
			[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[1]} is NOT added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //#################  Verify Sell - Shares Sold Option for Fractional Shares #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test59_Verify_Sell_Transaction_Fractional_Shares()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Sell - Shares Bought Option on Enter Transaction Dialog with Fractional amount of shares
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Transaction is added in register using Sell - Shares Bought Option on Enter Transaction Dialog			
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  30th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test59_Verify_Sell_Transaction_Fractional_Shares() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[4]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[5]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sTransactionValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[6]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=AddBrokerageTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------Verify that Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[8]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount+1))
					[ ] bMatch=MatchStr("*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[1]} is added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
						[ ] break
						[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[1]} is NOT added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //#################  Verify Sell - Shares Bought Option for Fractional Amount ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test60_Verify_Sell_Transaction_Fractional_Amount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Sell - Shares Bought Option on Enter Transaction Dialog with Fractional no for amount
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Transaction is added in register using Sell - Shares Bought Option on Enter Transaction Dialog			
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  30th April 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test60_Verify_Sell_Transaction_Fractional_Amount() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[4]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[6]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sTransactionValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[7]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=AddBrokerageTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------Verify that Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[8]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount+1))
					[ ] bMatch=MatchStr("*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[1]} is added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
						[ ] break
						[ ] 
				[ ] 
				[ ] 
			[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[1]} is NOT added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#####################################################################################################
[ ] 
[ ] 
[+] //######## Verify Edit operation for Sell Transaction for Shares , Amount and other fields as well as change in total cost ##########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test61_62_63_64_65_Verify_Edit_Sell_Transaction_Shares_Amount_Fields()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 
		[ ] //  1. Edit operation for Buy Transaction for Shares , Amount and other fields as well as change in total cost.
		[ ] //  2. Account field should be inactive                                    
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Buy Transaction Shares , Amount and other fields can be edited AND change in total cost is correct.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  7th May 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test61_62_63_64_65_66_Verify_Edit_Sell_Transaction_Shares_Amount_Fields() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[4]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sTransactionValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[8]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Navigate to latest transaction
		[ ] QuickenMainWindow.TypeKeys(KEY_PAGE_DOWN)
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[3],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Edit Transaction 
				[ ] wEnterTransaction.NumberOfShares.SetText(lsTransactionValidation[4])
				[ ] wEnterTransaction.PricePaid.SetText(lsTransactionValidation[5])
				[ ] wEnterTransaction.Commission.SetText(lsTransactionValidation[6])
				[ ] wEnterTransaction.Memo.SetText(lsTransactionValidation[7])
				[ ] wEnterTransaction.EnterDone.Click()
				[+] if(RecalculateInvTxn.Exists(5))
					[ ] ReportStatus("Verify if Recalculate Investment Transaction dialog is displayed",PASS,"Recalculate Investment Transaction dialog is displayed")
					[ ] 
					[ ] // Select Option Total Cost
					[ ] RecalculateInvTxn.RecalculateOptionRadioList.Select(3)
					[ ] RecalculateInvTxn.OK.Click()
					[ ] WaitForState(RecalculateInvTxn,FALSE,5)
					[ ] 
					[ ] // In case of altering amount for shares
					[+] if(RecalculateInvTxn.Exists(5))
						[ ] 
						[ ] RecalculateInvTxn.RecalculateOptionRadioList.Select(3)
						[ ] RecalculateInvTxn.OK.Click()
						[ ] WaitForState(RecalculateInvTxn,FALSE,5)
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Recalculate Investment Transaction dialog is displayed",FAIL,"Recalculate Investment Transaction dialog is NOT displayed")
					[ ] 
					[ ] 
				[ ] 
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //------------ Verify that Transaction values have been edited -------------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[3]}*{lsTransactionValidation[8]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount+1))
						[ ] bMatch=MatchStr("*{lsTransactionValidation[7]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[1]} is added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
							[ ] break
							[ ] 
					[ ] 
					[ ] 
				[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[1]} is NOT added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] // Sprint 8
[ ] // Lots
[ ] 
[+] //#################  Verify UI of Lots dialog launched form Enter Transaction dialog ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test68_Verify_Lots_Dialog_UI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will 
		[ ] // Verify Specify Lots Button on Enter Transaction Dialog
		[ ] // AND
		[ ] // Verify following controls are in the Lots dialog box:  
		[ ] // // Label with number of shares sold, price, date sold on, list of lots owned, how many shares sold from each lot,  auto select buttons 
		[ ] // First In First Out, Last In Shares, Minimum Gain, Maximum Gain, Enter Missing Transactions button, Reset, OK, Cancel, and Help.  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no objects are missing from lots UI
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  26th May 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test67_68_Verify_Specify_Lots_Button_And_Dialog_UI() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] 
		[ ] LIST OF STRING lsLabelText={"Purchase date","Type","Holding Period","Purchase price","Available to Sell","Shares to sell","Gain/Loss"}
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add Brokerage account
	[ ] iValidate=AddManualBrokerageAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],sDate)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Add Manual Brokerage account",PASS,"Manual Brokerage account is added")
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[+] for(iCount=7;iCount<=9;iCount++)
				[ ] 
				[ ] lsTransactionData=lsExcelData[iCount]
				[ ] iValidate=AddBrokerageTransaction(lsTransactionData)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] // Select Sell Transaction
			[ ] lsTransactionData=lsExcelData[10]
			[ ] 
			[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] // Select Sell option on Enter Transaction window
				[ ] wEnterTransaction.EnterTransaction.Select(3)
				[ ] wEnterTransaction.TypeKeys(KEY_TAB)
				[ ] wEnterTransaction.SecurityName.SetText(lsTransactionData[6])
				[ ] wEnterTransaction.TypeKeys(KEY_TAB)
				[ ] 
				[ ] // Handle Add Security to Quicken
				[+] if(AddSecurityToQuicken2.Exists(10))
					[ ] AddSecurityToQuicken2.SetActive()
					[ ] AddSecurityToQuicken2.TickerSymbolTextField.SetText(lsTransactionData[6])
					[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
						[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
						[+] if (AddSecurityToQuicken2.NextButton.Exists(10))
							[ ] AddSecurityToQuicken2.NextButton.Click()
							[ ] sleep(5)
						[ ] AddSecurityToQuicken.Done.DoubleClick()
						[ ] 
					[ ] 
				[ ] 
				[ ] wEnterTransaction.PricePaid.SetText(lsTransactionData[8])
				[ ] wEnterTransaction.TypeKeys(KEY_TAB)
				[ ] // Handle Add Security to Quicken
				[+] if(AddSecurityToQuicken2.Exists(10))
					[ ] AddSecurityToQuicken2.SetActive()
					[ ] AddSecurityToQuicken2.TickerSymbolTextField.SetText(lsTransactionData[6])
					[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
						[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
						[+] if (AddSecurityToQuicken2.NextButton.Exists(10))
							[ ] AddSecurityToQuicken2.NextButton.Click()
							[ ] sleep(5)
						[ ] AddSecurityToQuicken.Done.DoubleClick()
						[ ] 
					[ ] 
				[ ] 
				[ ] wEnterTransaction.NumberOfShares.SetText(lsTransactionData[7])
				[ ] wEnterTransaction.Commission.SetText(lsTransactionData[9])
				[ ] 
				[ ] 
				[+] if(wEnterTransaction.SpecifyLotsButton.Exists(5))
					[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",PASS,"Specify Lots Button exists on Enter Transaction dialog")
					[ ] 
					[ ] //Verify UI of Lots dialog
					[ ] wEnterTransaction.SpecifyLotsButton.Click()
					[ ] 
					[+] if(SpecifyLotsDialog.Exists(5))
						[ ] ReportStatus("Verify if Specify Lots Dialog exists",PASS,"Specify Lots Dialog exists")
						[ ] 
						[ ] SpecifyLotsDialog.SetActive()
						[ ] 
						[+] if(SpecifyLotsDialog.FirstSharesIn.Exists(5))
							[ ] ReportStatus("Verify UI of Specify Lots dialog",PASS,"First Shares In button exists on Enter Transaction dialog")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify UI of Specify Lots dialog",FAIL,"First Shares In button does NOT exist on Enter Transaction dialog")
							[ ] 
							[ ] 
						[ ] 
						[+] if(SpecifyLotsDialog.LastSharesIn.Exists(5))
							[ ] ReportStatus("Verify UI of Specify Lots dialog",PASS,"Last Shares In button exists on Enter Transaction dialog")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify UI of Specify Lots dialog",FAIL,"Last Shares In button does NOT exist on Enter Transaction dialog")
							[ ] 
							[ ] 
						[ ] 
						[+] if(SpecifyLotsDialog.MaximumGain.Exists(5))
							[ ] ReportStatus("Verify UI of Specify Lots dialog",PASS,"Maximum Gain button exists on Enter Transaction dialog")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify UI of Specify Lots dialog",FAIL,"Maximum Gain button does NOT exist on Enter Transaction dialog")
							[ ] 
							[ ] 
						[ ] 
						[+] if(SpecifyLotsDialog.MinimumGain.Exists(5))
							[ ] ReportStatus("Verify UI of Specify Lots dialog",PASS,"Minimum Gain button exists on Enter Transaction dialog")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify UI of Specify Lots dialog",FAIL,"Minimum Gain button does NOT exist on Enter Transaction dialog")
							[ ] 
							[ ] 
						[ ] 
						[+] if(SpecifyLotsDialog.OK.Exists(5))
							[ ] ReportStatus("Verify UI of Specify Lots dialog",PASS,"OK button exists on Enter Transaction dialog")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify UI of Specify Lots dialog",FAIL,"OK button does NOT exist on Enter Transaction dialog")
							[ ] 
							[ ] 
						[ ] 
						[+] if(SpecifyLotsDialog.Cancel.Exists(5))
							[ ] ReportStatus("Verify UI of Specify Lots dialog",PASS,"Cancel button exists on Enter Transaction dialog")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify UI of Specify Lots dialog",FAIL,"Cancel button does NOT exist on Enter Transaction dialog")
							[ ] 
							[ ] 
						[ ] 
						[+] if(SpecifyLotsDialog.SecurityNameText.Exists(5))
							[ ] ReportStatus("Verify UI of Specify Lots dialog",PASS,"Security Name Text exists on Enter Transaction dialog")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify UI of Specify Lots dialog",FAIL,"Security Name Text does NOT exist on Enter Transaction dialog")
							[ ] 
							[ ] 
						[ ] 
						[+] if(SpecifyLotsDialog.ResetSelections.Exists(5))
							[ ] ReportStatus("Verify UI of Specify Lots dialog",PASS,"Reset Selections button exists on Enter Transaction dialog")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify UI of Specify Lots dialog",FAIL,"Reset Selections button does NOT exist on Enter Transaction dialog")
							[ ] 
							[ ] 
						[ ] 
						[ ] // Verify labels
						[+] do
							[ ] 
							[ ] iCount=ListCount(lsLabelText)
							[+] while (iCount!=0)
								[ ] 
								[ ] SpecifyLotsDialog.TextClick(lsLabelText[iCount])
								[ ] iCount--
								[ ] 
							[+] if(iCount==0)
								[ ] ReportStatus("Verify labels on Specify Lots Dialog",PASS,"Verification complete for  All labels {lsLabelText} successfully")
								[ ] 
								[ ] 
							[ ] 
						[+] except
							[ ] ReportStatus("Verify labels on Specify Lots Dialog",FAIL,"Error during verification of {lsLabelText[iCount]}")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] SpecifyLotsDialog.Close()
						[ ] WaitForState(SpecifyLotsDialog,FALSE,5)
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Specify Lots Dialog exists",FAIL,"Specify Lots Dialog exists")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",FAIL,"Specify Lots Button does NOT exist on Enter Transaction dialog")
					[ ] 
				[ ] 
				[ ] wEnterTransaction.Close()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add Manual Brokerage account",FAIL,"Manual Brokerage account not added")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //############################   Verify Lots List Viewer data entry  #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test69_Verify_Lots_List_Viewer_Data_Entry()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // // This testcase will Verify Lots List Viewer data entry
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If max number of shares entered in  Lots List Viewer cannot be greater that total shares in that lot 	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th May 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test69_Verify_Lots_List_Viewer_Data_Entry() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[10]
		[ ] 
		[ ] //Expected number of shares
		[ ] sExpected=lsTransactionData[7]
		[ ] 
		[ ] STRING sMaxValue="500"
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Select Sell Transaction
		[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
		[ ] 
		[+] if(wEnterTransaction.Exists(5))
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
			[ ] 
			[ ] wEnterTransaction.SetActive()
			[ ] 
			[ ] // Select Sell option on Enter Transaction window
			[ ] wEnterTransaction.EnterTransaction.Select(3)
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.SecurityName.SetText(lsTransactionData[6])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.PricePaid.SetText(lsTransactionData[8])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[+] if(AddSecurityToQuicken2.Exists(10))
				[ ] AddSecurityToQuicken2.SetActive()
				[ ] AddSecurityToQuicken2.TickerSymbolTextField.SetText(lsTransactionData[6])
				[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
					[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
					[+] if (AddSecurityToQuicken2.NextButton.Exists(10))
						[ ] AddSecurityToQuicken2.NextButton.Click()
						[ ] sleep(5)
					[ ] AddSecurityToQuicken.Done.DoubleClick()
					[ ] 
				[ ] 
			[ ] 
			[ ] wEnterTransaction.NumberOfShares.SetText(lsTransactionData[7])
			[ ] wEnterTransaction.Commission.SetText(lsTransactionData[9])
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.SpecifyLotsButton.Exists(5))
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",PASS,"Specify Lots Button exists on Enter Transaction dialog")
				[ ] 
				[ ] //Verify UI of Lots dialog
				[ ] wEnterTransaction.SpecifyLotsButton.Click()
				[+] if(SpecifyLotsDialog.Exists(5))
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",PASS,"Specify Lots Dialog exists")
					[ ] 
					[ ] SpecifyLotsDialog.SetActive()
					[ ] 
					[+] if(SpecifyLotsDialog.SharesToSellTextField.Exists(5))
						[ ] ReportStatus("Verify Shares To Sell TextField on Specify Lots dialog",PASS,"Shares To Sell TextField exists on Enter Transaction dialog")
						[ ] 
						[ ] 
						[ ] SpecifyLotsDialog.SharesToSellTextField.SetText(sMaxValue)
						[ ] SpecifyLotsDialog.OK.Click()
						[ ] WaitForState(SpecifyLotsDialog,FALSE,5)
						[ ] 
						[ ] wEnterTransaction.SpecifyLotsButton.Click()
						[+] if(SpecifyLotsDialog.Exists(5))
							[ ] 
							[ ] SpecifyLotsDialog.SetActive()
							[ ] 
							[ ] sActual=SpecifyLotsDialog.SharesToSellTextField.GetText()
							[+] if(sActual==sExpected)
								[ ] ReportStatus("Verify value Shares To Sell TextField on Specify Lots dialog",PASS,"Shares To Sell TextField corrected to max value of shares in lot {sActual}")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify value Shares To Sell TextField on Specify Lots dialog",FAIL,"Shares To Sell TextField {sActual} NOT corrected to max value of shares in lot {sExpected}")
								[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Shares To Sell TextField on Specify Lots dialog",FAIL,"Shares To Sell TextField does NOT exist on Enter Transaction dialog")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] SpecifyLotsDialog.Close()
					[ ] WaitForState(SpecifyLotsDialog,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",FAIL,"Specify Lots Dialog exists")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",FAIL,"Specify Lots Button does NOT exist on Enter Transaction dialog")
				[ ] 
			[ ] 
			[ ] wEnterTransaction.Close()
			[ ] WaitForState(wEnterTransaction,FALSE,5)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //############################ Verify First Shares In button on Specify Lots Dialog ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test71_Verify_First_Shares_In_Button_On_Specify_Lots_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // // This testcase will Verify First Shares In button on Specify Lots Dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If First Shares In button on Specify Lots Dialog selects correct lot and calculation
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th May 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test71_Verify_First_Shares_In_Button_On_Specify_Lots_Dialog() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sLotsValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Select Sell Transaction
		[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
		[ ] 
		[+] if(wEnterTransaction.Exists(5))
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
			[ ] 
			[ ] wEnterTransaction.SetActive()
			[ ] 
			[ ] // Select Sell option on Enter Transaction window
			[ ] wEnterTransaction.EnterTransaction.Select(3)
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.SecurityName.SetText(lsTransactionData[6])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.PricePaid.SetText(lsTransactionData[8])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[+] if(AddSecurityToQuicken2.Exists(10))
				[ ] AddSecurityToQuicken2.SetActive()
				[ ] AddSecurityToQuicken2.TickerSymbolTextField.SetText(lsTransactionData[6])
				[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
					[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
					[+] if (AddSecurityToQuicken2.NextButton.Exists(10))
						[ ] AddSecurityToQuicken2.NextButton.Click()
						[ ] sleep(5)
					[ ] AddSecurityToQuicken.Done.DoubleClick()
					[ ] 
				[ ] 
			[ ] 
			[ ] wEnterTransaction.NumberOfShares.SetText(lsTransactionData[7])
			[ ] wEnterTransaction.Commission.SetText(lsTransactionData[9])
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.SpecifyLotsButton.Exists(5))
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",PASS,"Specify Lots Button exists on Enter Transaction dialog")
				[ ] 
				[ ] //Verify UI of Lots dialog
				[ ] wEnterTransaction.SpecifyLotsButton.Click()
				[+] if(SpecifyLotsDialog.Exists(5))
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",PASS,"Specify Lots Dialog exists")
					[ ] 
					[ ] SpecifyLotsDialog.SetActive()
					[+] if(SpecifyLotsDialog.FirstSharesIn.Exists(5))
						[ ] ReportStatus("Verify UI of Specify Lots dialog",PASS,"First Shares In button exists on Enter Transaction dialog")
						[ ] 
						[ ] SpecifyLotsDialog.FirstSharesIn.Click()
						[ ] 
						[ ] sHandle=Str(SpecifyLotsDialog.QWListViewer.ListBox.GetHandle())
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,lsTransactionValidation[6])
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[5]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Validation for {lsTransactionValidation[1]} button on Specify Lots Dialog",PASS,"{lsTransactionValidation[1]} button on Specify Lots Dialog selects lots correctly {sActual}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validation for {lsTransactionValidation[1]} button on Specify Lots Dialog",FAIL,"{lsTransactionValidation[1]} button on Specify Lots Dialog does NOT select correct lots {sActual}")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify UI of Specify Lots dialog",FAIL,"First Shares In button does NOT exist on Enter Transaction dialog")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] SpecifyLotsDialog.Close()
					[ ] WaitForState(SpecifyLotsDialog,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",FAIL,"Specify Lots Dialog exists")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",FAIL,"Specify Lots Button does NOT exist on Enter Transaction dialog")
				[ ] 
			[ ] 
			[ ] wEnterTransaction.Close()
			[ ] WaitForState(wEnterTransaction,FALSE,5)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //############################ Verify Last Shares In button on Specify Lots Dialog #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test72_Verify_Last_Shares_In_Button_On_Specify_Lots_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // // This testcase will Verify Last Shares In button on Specify Lots Dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Last Shares In button on Specify Lots Dialog selects correct lot and calculation
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th May 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test72_Verify_Last_Shares_In_Button_On_Specify_Lots_Dialog() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sLotsValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[2]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Select Sell Transaction
		[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
		[ ] 
		[+] if(wEnterTransaction.Exists(5))
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
			[ ] 
			[ ] wEnterTransaction.SetActive()
			[ ] 
			[ ] // Select Sell option on Enter Transaction window
			[ ] wEnterTransaction.EnterTransaction.Select(3)
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.SecurityName.SetText(lsTransactionData[6])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.PricePaid.SetText(lsTransactionData[8])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[+] if(AddSecurityToQuicken2.Exists(10))
				[ ] AddSecurityToQuicken2.SetActive()
				[ ] AddSecurityToQuicken2.TickerSymbolTextField.SetText(lsTransactionData[6])
				[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
					[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
					[+] if (AddSecurityToQuicken2.NextButton.Exists(10))
						[ ] AddSecurityToQuicken2.NextButton.Click()
						[ ] sleep(5)
					[ ] AddSecurityToQuicken.Done.DoubleClick()
					[ ] 
				[ ] 
			[ ] 
			[ ] wEnterTransaction.NumberOfShares.SetText(lsTransactionData[7])
			[ ] wEnterTransaction.Commission.SetText(lsTransactionData[9])
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.SpecifyLotsButton.Exists(5))
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",PASS,"Specify Lots Button exists on Enter Transaction dialog")
				[ ] 
				[ ] //Verify UI of Lots dialog
				[ ] wEnterTransaction.SpecifyLotsButton.Click()
				[+] if(SpecifyLotsDialog.Exists(5))
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",PASS,"Specify Lots Dialog exists")
					[ ] 
					[ ] SpecifyLotsDialog.SetActive()
					[+] if(SpecifyLotsDialog.LastSharesIn.Exists(5))
						[ ] ReportStatus("Verify UI of Specify Lots dialog",PASS,"First Shares In button exists on Enter Transaction dialog")
						[ ] 
						[ ] SpecifyLotsDialog.LastSharesIn.Click()
						[ ] 
						[ ] sHandle=Str(SpecifyLotsDialog.QWListViewer.ListBox.GetHandle())
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,lsTransactionValidation[6])
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[5]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Validation for {lsTransactionValidation[1]} button on Specify Lots Dialog",PASS,"{lsTransactionValidation[1]} button on Specify Lots Dialog selects lots correctly {sActual}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validation for {lsTransactionValidation[1]} button on Specify Lots Dialog",FAIL,"{lsTransactionValidation[1]} button on Specify Lots Dialog does NOT select correct lots {sActual}")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify UI of Specify Lots dialog",FAIL,"First Shares In button does NOT exist on Enter Transaction dialog")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] SpecifyLotsDialog.Close()
					[ ] WaitForState(SpecifyLotsDialog,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",FAIL,"Specify Lots Dialog exists")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",FAIL,"Specify Lots Button does NOT exist on Enter Transaction dialog")
				[ ] 
			[ ] 
			[ ] wEnterTransaction.Close()
			[ ] WaitForState(wEnterTransaction,FALSE,5)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //############################ Verify Minimum Gain button on Specify Lots Dialog ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test73_Verify_Minimum_Gain_Button_On_Specify_Lots_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // // This testcase will Verify Minimum Gain button on Specify Lots Dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Minimum Gain In button on Specify Lots Dialog selects correct lot and calculation
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th May 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test73_Verify_Minimum_Gain_Button_On_Specify_Lots_Dialog() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sLotsValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[4]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Select Sell Transaction
		[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
		[ ] 
		[+] if(wEnterTransaction.Exists(5))
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
			[ ] 
			[ ] wEnterTransaction.SetActive()
			[ ] 
			[ ] // Select Sell option on Enter Transaction window
			[ ] wEnterTransaction.EnterTransaction.Select(3)
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.SecurityName.SetText(lsTransactionData[6])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.PricePaid.SetText(lsTransactionData[8])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[+] if(AddSecurityToQuicken2.Exists(10))
				[ ] AddSecurityToQuicken2.SetActive()
				[ ] AddSecurityToQuicken2.TickerSymbolTextField.SetText(lsTransactionData[6])
				[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
					[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
					[+] if (AddSecurityToQuicken2.NextButton.Exists(10))
						[ ] AddSecurityToQuicken2.NextButton.Click()
						[ ] sleep(5)
					[ ] AddSecurityToQuicken.Done.DoubleClick()
					[ ] 
				[ ] 
			[ ] 
			[ ] wEnterTransaction.NumberOfShares.SetText(lsTransactionData[7])
			[ ] wEnterTransaction.Commission.SetText(lsTransactionData[9])
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.SpecifyLotsButton.Exists(5))
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",PASS,"Specify Lots Button exists on Enter Transaction dialog")
				[ ] 
				[ ] //Verify UI of Lots dialog
				[ ] wEnterTransaction.SpecifyLotsButton.Click()
				[+] if(SpecifyLotsDialog.Exists(5))
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",PASS,"Specify Lots Dialog exists")
					[ ] 
					[ ] SpecifyLotsDialog.SetActive()
					[+] if(SpecifyLotsDialog.MinimumGain.Exists(5))
						[ ] ReportStatus("Verify UI of Specify Lots dialog",PASS,"First Shares In button exists on Enter Transaction dialog")
						[ ] 
						[ ] SpecifyLotsDialog.MinimumGain.Click()
						[ ] 
						[ ] sHandle=Str(SpecifyLotsDialog.QWListViewer.ListBox.GetHandle())
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,lsTransactionValidation[6])
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[5]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Validation for {lsTransactionValidation[1]} button on Specify Lots Dialog",PASS,"{lsTransactionValidation[1]} button on Specify Lots Dialog selects lots correctly {sActual}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validation for {lsTransactionValidation[1]} button on Specify Lots Dialog",FAIL,"{lsTransactionValidation[1]} button on Specify Lots Dialog does NOT select correct lots {sActual}")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify UI of Specify Lots dialog",FAIL,"First Shares In button does NOT exist on Enter Transaction dialog")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] SpecifyLotsDialog.Close()
					[ ] WaitForState(SpecifyLotsDialog,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",FAIL,"Specify Lots Dialog exists")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",FAIL,"Specify Lots Button does NOT exist on Enter Transaction dialog")
				[ ] 
			[ ] 
			[ ] wEnterTransaction.Close()
			[ ] WaitForState(wEnterTransaction,FALSE,5)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[ ] 
[+] //############################ Verify Maximum Gain button on Specify Lots Dialog #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test74_Verify_Maximum_Gain_Button_On_Specify_Lots_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // // This testcase will Verify Maximum Gain button on Specify Lots Dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Maximum Gain In button on Specify Lots Dialog selects correct lot and calculation
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th May 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test74_Verify_Maximum_Gain_Button_On_Specify_Lots_Dialog() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sLotsValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Select Sell Transaction
		[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
		[ ] 
		[+] if(wEnterTransaction.Exists(5))
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
			[ ] 
			[ ] wEnterTransaction.SetActive()
			[ ] 
			[ ] // Select Sell option on Enter Transaction window
			[ ] wEnterTransaction.EnterTransaction.Select(3)
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.SecurityName.SetText(lsTransactionData[6])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.PricePaid.SetText(lsTransactionData[8])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[+] if(AddSecurityToQuicken2.Exists(10))
				[ ] AddSecurityToQuicken2.SetActive()
				[ ] AddSecurityToQuicken2.TickerSymbolTextField.SetText(lsTransactionData[6])
				[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
					[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
					[+] if (AddSecurityToQuicken2.NextButton.Exists(10))
						[ ] AddSecurityToQuicken2.NextButton.Click()
						[ ] sleep(5)
					[ ] AddSecurityToQuicken.Done.DoubleClick()
					[ ] 
				[ ] 
			[ ] 
			[ ] wEnterTransaction.NumberOfShares.SetText(lsTransactionData[7])
			[ ] wEnterTransaction.Commission.SetText(lsTransactionData[9])
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.SpecifyLotsButton.Exists(5))
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",PASS,"Specify Lots Button exists on Enter Transaction dialog")
				[ ] 
				[ ] //Verify UI of Lots dialog
				[ ] wEnterTransaction.SpecifyLotsButton.Click()
				[+] if(SpecifyLotsDialog.Exists(5))
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",PASS,"Specify Lots Dialog exists")
					[ ] 
					[ ] SpecifyLotsDialog.SetActive()
					[+] if(SpecifyLotsDialog.MaximumGain.Exists(5))
						[ ] ReportStatus("Verify UI of Specify Lots dialog",PASS,"First Shares In button exists on Enter Transaction dialog")
						[ ] 
						[ ] SpecifyLotsDialog.MaximumGain.Click()
						[ ] 
						[ ] sHandle=Str(SpecifyLotsDialog.QWListViewer.ListBox.GetHandle())
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,lsTransactionValidation[6])
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[5]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Validation for {lsTransactionValidation[1]} button on Specify Lots Dialog",PASS,"{lsTransactionValidation[1]} button on Specify Lots Dialog selects lots correctly {sActual}")
							[ ] 
						[+] else
							[ ] ReportStatus("Validation for {lsTransactionValidation[1]} button on Specify Lots Dialog",FAIL,"{lsTransactionValidation[1]} button on Specify Lots Dialog does NOT select correct lots {sActual}")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify UI of Specify Lots dialog",FAIL,"First Shares In button does NOT exist on Enter Transaction dialog")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] SpecifyLotsDialog.Close()
					[ ] WaitForState(SpecifyLotsDialog,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",FAIL,"Specify Lots Dialog exists")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",FAIL,"Specify Lots Button does NOT exist on Enter Transaction dialog")
				[ ] 
			[ ] 
			[ ] wEnterTransaction.Close()
			[ ] WaitForState(wEnterTransaction,FALSE,5)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
[ ] //########################################################################################################
[ ] 
[ ] 
[+] //############################ Verify Reset Selections In button on Specify Lots Dialog ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test75_Verify_Reset_Selections_Button_On_Specify_Lots_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // // This testcase will Verify Reset Selections button on Specify Lots Dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Reset Selections button on Specify Lots Dialog resets all lots
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th May 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test75_Verify_Reset_Selections_Button_On_Specify_Lots_Dialog() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sLotsValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Select Sell Transaction
		[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
		[ ] 
		[+] if(wEnterTransaction.Exists(5))
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
			[ ] 
			[ ] wEnterTransaction.SetActive()
			[ ] 
			[ ] // Select Sell option on Enter Transaction window
			[ ] wEnterTransaction.EnterTransaction.Select(3)
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.SecurityName.SetText(lsTransactionData[6])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.PricePaid.SetText(lsTransactionData[8])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[+] if(AddSecurityToQuicken2.Exists(10))
				[ ] AddSecurityToQuicken2.SetActive()
				[ ] AddSecurityToQuicken2.TickerSymbolTextField.SetText(lsTransactionData[6])
				[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
					[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
					[+] if (AddSecurityToQuicken2.NextButton.Exists(10))
						[ ] AddSecurityToQuicken2.NextButton.Click()
						[ ] sleep(5)
					[ ] AddSecurityToQuicken.Done.DoubleClick()
					[ ] 
				[ ] 
			[ ] 
			[ ] wEnterTransaction.NumberOfShares.SetText(lsTransactionData[7])
			[ ] wEnterTransaction.Commission.SetText(lsTransactionData[9])
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.SpecifyLotsButton.Exists(5))
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",PASS,"Specify Lots Button exists on Enter Transaction dialog")
				[ ] 
				[ ] //Verify UI of Lots dialog
				[ ] wEnterTransaction.SpecifyLotsButton.Click()
				[+] if(SpecifyLotsDialog.Exists(5))
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",PASS,"Specify Lots Dialog exists")
					[ ] 
					[ ] SpecifyLotsDialog.SetActive()
					[+] if(SpecifyLotsDialog.FirstSharesIn.Exists(5))
						[ ] ReportStatus("Verify UI of Specify Lots dialog",PASS,"First Shares In button exists on Enter Transaction dialog")
						[ ] 
						[ ] SpecifyLotsDialog.FirstSharesIn.Click()
						[ ] 
						[ ] sHandle=Str(SpecifyLotsDialog.QWListViewer.ListBox.GetHandle())
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,lsTransactionValidation[6])
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[5]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Validation for {lsTransactionValidation[1]} button on Specify Lots Dialog",PASS,"{lsTransactionValidation[1]} button on Specify Lots Dialog selects lots correctly {sActual}")
							[ ] 
							[ ] 
							[ ] 
							[+] if(SpecifyLotsDialog.ResetSelections.Exists(5))
								[ ] 
								[ ] SpecifyLotsDialog.ResetSelections.Click()
								[ ] 
								[ ] 
								[ ] 
								[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,lsTransactionValidation[6])
								[ ] 
								[ ] bMatch=MatchStr("*{lsTransactionValidation[5]}*",sActual)
								[+] if(bMatch==FALSE)
									[ ] 
									[ ] lsTransactionValidation=lsExcelData[5]
									[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[5]}*",sActual)
									[+] if(bMatch==TRUE)
										[ ] ReportStatus("Validation for {lsTransactionValidation[1]} button on Specify Lots Dialog",PASS,"{lsTransactionValidation[1]} button on Specify Lots Dialog does resets lots correctly {sActual}")
										[ ] 
									[+] else
										[ ] ReportStatus("Validation for {lsTransactionValidation[1]} button on Specify Lots Dialog",PASS,"{lsTransactionValidation[1]} button on Specify Lots Dialog does not reset lots {sActual}")
										[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Validation for {lsTransactionValidation[1]} button on Specify Lots Dialog",PASS,"{lsTransactionValidation[1]} button on Specify Lots Dialog does not reset lots {sActual}")
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
							[ ] ReportStatus("Validation for {lsTransactionValidation[1]} button on Specify Lots Dialog",FAIL,"{lsTransactionValidation[1]} button on Specify Lots Dialog does NOT select correct lots {sActual}")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify UI of Specify Lots dialog",FAIL,"First Shares In button does NOT exist on Enter Transaction dialog")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] SpecifyLotsDialog.Close()
					[ ] WaitForState(SpecifyLotsDialog,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",FAIL,"Specify Lots Dialog exists")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",FAIL,"Specify Lots Button does NOT exist on Enter Transaction dialog")
				[ ] 
			[ ] 
			[ ] wEnterTransaction.Close()
			[ ] WaitForState(wEnterTransaction,FALSE,5)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
[ ] //########################################################################################################
[ ] 
[ ] 
[+] //############################  Verify Specify Lots Help Cancel OK Buttons #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test76_77_78_Verify_Specify_Lots_Help_Cancel_OK_Buttons()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // // This testcase will Verify Specify Lots Help, Cancel and OK Buttons
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If functionality of Help, Cancel and OK Buttons on Specify Lots dialog is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th May 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test76_77_78_Verify_Specify_Lots_Help_Cancel_OK_Buttons() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sLotsValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[1]
		[ ] 
		[ ] sExpected="0"
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Select Sell Transaction
		[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
		[ ] 
		[+] if(wEnterTransaction.Exists(5))
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
			[ ] 
			[ ] wEnterTransaction.SetActive()
			[ ] 
			[ ] // Select Sell option on Enter Transaction window
			[ ] wEnterTransaction.EnterTransaction.Select(3)
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.SecurityName.SetText(lsTransactionData[6])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.PricePaid.SetText(lsTransactionData[8])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[+] if(AddSecurityToQuicken2.Exists(10))
				[ ] AddSecurityToQuicken2.SetActive()
				[ ] AddSecurityToQuicken2.TickerSymbolTextField.SetText(lsTransactionData[6])
				[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
					[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
					[+] if (AddSecurityToQuicken2.NextButton.Exists(10))
						[ ] AddSecurityToQuicken2.NextButton.Click()
						[ ] sleep(5)
					[ ] AddSecurityToQuicken.Done.DoubleClick()
					[ ] 
				[ ] 
			[ ] 
			[ ] wEnterTransaction.NumberOfShares.SetText(lsTransactionData[7])
			[ ] wEnterTransaction.Commission.SetText(lsTransactionData[9])
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.SpecifyLotsButton.Exists(5))
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",PASS,"Specify Lots Button exists on Enter Transaction dialog")
				[ ] 
				[ ] //Verify UI of Lots dialog
				[ ] wEnterTransaction.SpecifyLotsButton.Click()
				[+] if(SpecifyLotsDialog.Exists(5))
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",PASS,"Specify Lots Dialog exists")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] // ---------Verify Help button functionality---------
					[ ] SpecifyLotsDialog.SetActive()
					[ ] SpecifyLotsDialog.Help.Click()
					[+] if(QuickenHelp.Exists(5))
						[ ] ReportStatus("Verify if Help dialog is launched",PASS,"Help dialog is launched")
						[ ] 
						[ ] QuickenHelp.Close()
						[ ] WaitForState(QuickenHelp,FALSE,5)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Help dialog is launched",FAIL,"Help dialog is NOT launched")
						[ ] 
						[ ] 
						[ ] 
					[ ] // ---------------------------------------------------------------
					[ ] 
					[ ] 
					[ ] 
					[ ] // ---------Verify Cancel button functionality---------
					[ ] 
					[ ] SpecifyLotsDialog.SetActive()
					[+] if(SpecifyLotsDialog.SharesToSellTextField.Exists(5))
						[ ] ReportStatus("Verify Shares To Sell TextField on Specify Lots dialog",PASS,"Shares To Sell TextField exists on Enter Transaction dialog")
						[ ] 
						[ ] 
						[ ] 
						[ ] SpecifyLotsDialog.SharesToSellTextField.SetText(lsTransactionValidation[3])
						[ ] SpecifyLotsDialog.Cancel.Click()
						[ ] WaitForState(SpecifyLotsDialog,FALSE,5)
						[ ] 
						[ ] wEnterTransaction.SpecifyLotsButton.Click()
						[+] if(SpecifyLotsDialog.Exists(5))
							[ ] 
							[ ] SpecifyLotsDialog.SetActive()
							[ ] 
							[ ] sActual=SpecifyLotsDialog.SharesToSellTextField.GetText()
							[+] if(sActual==sExpected)
								[ ] ReportStatus("Verify Cancel button on Specify Lots dialog",PASS,"Shares To Sell TextField does NOT display set value of shares in lot {sActual} after clicking on cancel button")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Cancel button on Specify Lots dialog",FAIL,"Shares To Sell TextField displays set value of shares in lot {sActual} after clicking on cancel button")
								[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Shares To Sell TextField on Specify Lots dialog",FAIL,"Shares To Sell TextField does NOT exist on Enter Transaction dialog")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] // ---------Verify OK button functionality---------
					[ ] // wEnterTransaction.SpecifyLotsButton.Click()
					[+] if(SpecifyLotsDialog.SharesToSellTextField.Exists(5))
						[ ] ReportStatus("Verify Shares To Sell TextField on Specify Lots dialog",PASS,"Shares To Sell TextField exists on Enter Transaction dialog")
						[ ] 
						[ ] 
						[ ] 
						[ ] SpecifyLotsDialog.SharesToSellTextField.SetText(lsTransactionValidation[3])
						[ ] SpecifyLotsDialog.OK.Click()
						[ ] WaitForState(SpecifyLotsDialog,FALSE,5)
						[ ] 
						[ ] wEnterTransaction.SpecifyLotsButton.Click()
						[+] if(SpecifyLotsDialog.Exists(5))
							[ ] 
							[ ] SpecifyLotsDialog.SetActive()
							[ ] 
							[ ] sActual=SpecifyLotsDialog.SharesToSellTextField.GetText()
							[+] if(sActual==lsTransactionValidation[3])
								[ ] ReportStatus("Verify OK button on Specify Lots dialog",PASS,"Shares To Sell TextField does displays set value of shares in lot {sActual} after clicking on OK button")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify OK button on Specify Lots dialog",FAIL,"Shares To Sell TextField does NOT  display set value of shares in lot {sActual} after clicking on OK button")
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
						[ ] ReportStatus("Verify Shares To Sell TextField on Specify Lots dialog",FAIL,"Shares To Sell TextField does NOT exist on Enter Transaction dialog")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] SpecifyLotsDialog.Close()
					[ ] WaitForState(SpecifyLotsDialog,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",FAIL,"Specify Lots Dialog exists")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",FAIL,"Specify Lots Button does NOT exist on Enter Transaction dialog")
				[ ] 
			[ ] 
			[ ] wEnterTransaction.Close()
			[ ] WaitForState(wEnterTransaction,FALSE,5)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[ ] 
[+] //###########################    Verify  Lots Total and Remaining  ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test79_80_Verify_Lots_Total_And_Remaining()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // // This testcase will Verify Lots Total and Remaining values
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If lots total sums up to the number of shares user has	 selected.
		[ ] //                                                    If remia
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th May 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test79_80_Verify_Lots_Total_And_Remaining() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[5]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sLotsValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] LIST OF STRING lsLotsShares={"40","50","10"}
		[ ] STRING sSharesRemainingExpected="0"
		[ ] STRING sTotalSharesExpected="100"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Select Sell Transaction
		[ ] MDIClient.BrokerageAccount.EnterTransactions.Click()
		[ ] 
		[+] if(wEnterTransaction.Exists(5))
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
			[ ] 
			[ ] wEnterTransaction.SetActive()
			[ ] 
			[ ] // Select Sell option on Enter Transaction window
			[ ] wEnterTransaction.EnterTransaction.Select(3)
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.SecurityName.SetText(lsTransactionData[6])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[ ] wEnterTransaction.PricePaid.SetText(lsTransactionData[8])
			[ ] wEnterTransaction.TypeKeys(KEY_TAB)
			[+] if(AddSecurityToQuicken2.Exists(10))
				[ ] AddSecurityToQuicken2.SetActive()
				[ ] AddSecurityToQuicken2.TickerSymbolTextField.SetText(lsTransactionData[6])
				[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
					[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
					[+] if (AddSecurityToQuicken2.NextButton.Exists(10))
						[ ] AddSecurityToQuicken2.NextButton.Click()
						[ ] sleep(5)
					[ ] AddSecurityToQuicken.Done.DoubleClick()
					[ ] 
				[ ] 
			[ ] 
			[ ] wEnterTransaction.NumberOfShares.SetText(lsTransactionData[7])
			[ ] wEnterTransaction.Commission.SetText(lsTransactionData[9])
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.SpecifyLotsButton.Exists(5))
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",PASS,"Specify Lots Button exists on Enter Transaction dialog")
				[ ] 
				[ ] //Verify UI of Lots dialog
				[ ] wEnterTransaction.SpecifyLotsButton.Click()
				[+] if(SpecifyLotsDialog.Exists(5))
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",PASS,"Specify Lots Dialog exists")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[+] for(iCount=1;iCount<=3;iCount++)
						[ ] 
						[ ] SpecifyLotsDialog.SetActive()
						[ ] 
						[ ] SpecifyLotsDialog.SharesToSellTextField.SetText(lsLotsShares[iCount])
						[ ] SpecifyLotsDialog.TypeKeys(KEY_DN)
						[ ] 
					[ ] 
					[ ] SpecifyLotsDialog.TypeKeys(KEY_TAB)
					[ ] 
					[ ] sActual=SpecifyLotsDialog.TotalSharesToSellText.GetText()
					[+] if(sActual==sTotalSharesExpected)
						[ ] ReportStatus("Verify Lots Total ",PASS,"Total {sActual} does sum up to the number of shares user has selected {sTotalSharesExpected}")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Lots Total ",FAIL,"Total {sActual} does NOT sum up to the number of shares user has selected {sTotalSharesExpected}")
					[ ] 
					[ ] 
					[ ] sActual=SpecifyLotsDialog.RemainingSharesText.GetText()
					[+] if(sActual==sSharesRemainingExpected)
						[ ] ReportStatus("Verify Lots Remaining Shares ",PASS,"Remaining Shares {sActual} does display correctly {sSharesRemainingExpected}")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Lots Remaining Shares ",FAIL,"Remaining Shares {sActual} does NOT display correctly {sSharesRemainingExpected}")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] SpecifyLotsDialog.Close()
					[ ] WaitForState(SpecifyLotsDialog,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Specify Lots Dialog exists",FAIL,"Specify Lots Dialog exists")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Specify Lots Button exists on Enter Transaction dialog",FAIL,"Specify Lots Button does NOT exist on Enter Transaction dialog")
				[ ] 
			[ ] 
			[ ] wEnterTransaction.Close()
			[ ] WaitForState(wEnterTransaction,FALSE,5)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] // 
[ ] // //Sprint 9
[ ] 
[+] //###################################  Verify Shares Added Entry Data  ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test82_Verify_Shares_Added_Entry_Data()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Shares Added Entry Data
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If shares are added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  4th June 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test82_Verify_Shares_Added_Entry_Data() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[6]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[11]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sTransactionValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[10]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] //Add Brokerage account
	[ ] iValidate=AddManualBrokerageAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],sDate)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Add Manual Brokerage account",PASS,"Manual Brokerage account is added")
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddBrokerageTransaction(lsTransactionData)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
				[ ] 
				[ ] 
				[ ] 
				[ ] //--------Verify that Transaction is entered in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[8]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount+1))
						[ ] bMatch=MatchStr("*{lsTransactionValidation[7]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] break
							[ ] 
						[ ] 
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[1]} is added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[1]} is NOT added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add Manual Brokerage account",FAIL,"Manual Brokerage account not added")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //########################  Verify Edit Shares Added Transaction Fields  #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test83_84_85_86_87_Verify_Edit_Shares_Added_Transaction_Fields()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 
		[ ] //  1. Edit operation for Shares Added Transaction for Shares , Amount and other fields as well as change in total cost.
		[ ] //  2. Account field should be inactive                                    
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Shares Added Shares , Amount and other fields can be edited AND change in total cost is correct.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  4th June 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test83_84_85_86_87_Verify_Edit_Shares_Added_Transaction_Fields() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[6]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sTransactionValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[11]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Navigate to latest transaction
		[ ] QuickenMainWindow.TypeKeys(KEY_PAGE_DOWN)
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[3],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Edit Transaction 
				[ ] wEnterTransaction.NumberOfShares.SetText(lsTransactionValidation[4])
				[ ] wEnterTransaction.PricePaid.SetText(lsTransactionValidation[5])
				[ ] wEnterTransaction.Memo.SetText(lsTransactionValidation[7])
				[ ] wEnterTransaction.EnterDone.Click()
				[+] if(RecalculateInvTxn.Exists(5))
					[ ] ReportStatus("Verify if Recalculate Investment Transaction dialog is displayed",PASS,"Recalculate Investment Transaction dialog is displayed")
					[ ] 
					[ ] // Select Option Total Cost
					[ ] RecalculateInvTxn.RecalculateOptionRadioList.Select(3)
					[ ] RecalculateInvTxn.OK.Click()
					[ ] WaitForState(RecalculateInvTxn,FALSE,5)
					[ ] 
					[ ] // In case of altering amount for shares
					[+] if(RecalculateInvTxn.Exists(5))
						[ ] 
						[ ] RecalculateInvTxn.RecalculateOptionRadioList.Select(3)
						[ ] RecalculateInvTxn.OK.Click()
						[ ] WaitForState(RecalculateInvTxn,FALSE,5)
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Recalculate Investment Transaction dialog is displayed",FAIL,"Recalculate Investment Transaction dialog is NOT displayed")
					[ ] 
					[ ] 
				[ ] 
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //------------ Verify that Transaction values have been edited -------------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[3]}*{lsTransactionValidation[8]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount+1))
						[ ] bMatch=MatchStr("*{lsTransactionValidation[7]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[1]} is added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
							[ ] break
							[ ] 
					[ ] 
					[ ] 
				[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[1]} is NOT added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //###################################  Verify Shares Removed Entry Data  ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test88_Verify_Shares_Removed_Entry_Data()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Shares Removed Entry Data
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If shares are Removed from Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  4th June 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test88_Verify_Shares_Removed_Entry_Data() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[6]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[12]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sTransactionValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[12]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=AddBrokerageTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------Verify that Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount+1))
					[ ] bMatch=MatchStr("*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
					[ ] 
			[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[1]} is added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[1]} is NOT added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //########################  Verify Edit Shares Removed Transaction Fields  #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test89_90_91_Verify_Edit_Shares_Removed_Transaction_Fields()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 
		[ ] //  1. Edit operation for Shares Removed Transaction for Shares and Memo fields as well as change in total cost.
		[ ] //  2. Account field should be inactive                                    
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Shares Removed Shares and Memo fields can be edited AND change in total cost is correct.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  4th June 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test89_90_91_Verify_Edit_Shares_Removed_Transaction_Fields() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[6]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sTransactionValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[13]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Navigate to latest transaction
		[ ] QuickenMainWindow.TypeKeys(KEY_PAGE_DOWN)
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[3],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Edit Transaction 
				[ ] wEnterTransaction.NumberOfShares.SetText(lsTransactionValidation[4])
				[ ] wEnterTransaction.Memo.SetText(lsTransactionValidation[7])
				[ ] wEnterTransaction.EnterDone.Click()
				[+] // if(RecalculateInvTxn.Exists(5))
					[ ] // ReportStatus("Verify if Recalculate Investment Transaction dialog is displayed",PASS,"Recalculate Investment Transaction dialog is displayed")
					[ ] // 
					[ ] // // Select Option Total Cost
					[ ] // RecalculateInvTxn.RecalculateOptionRadioList.Select(3)
					[ ] // RecalculateInvTxn.OK.Click()
					[ ] // WaitForState(RecalculateInvTxn,FALSE,5)
					[ ] // 
					[ ] // // In case of altering amount for shares
					[+] // if(RecalculateInvTxn.Exists(5))
						[ ] // 
						[ ] // RecalculateInvTxn.RecalculateOptionRadioList.Select(3)
						[ ] // RecalculateInvTxn.OK.Click()
						[ ] // WaitForState(RecalculateInvTxn,FALSE,5)
						[ ] // 
					[ ] // 
					[ ] // 
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify if Recalculate Investment Transaction dialog is displayed",FAIL,"Recalculate Investment Transaction dialog is NOT displayed")
					[ ] // 
					[ ] // 
				[ ] 
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //------------ Verify that Transaction values have been edited -------------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount+1))
						[ ] bMatch=MatchStr("*{lsTransactionValidation[7]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[1]} is added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
							[ ] break
							[ ] 
					[ ] 
					[ ] 
				[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if {lsTransactionValidation[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[1]} is NOT added in Investing Register after using Enter/Done button : Verified for Amount : {lsTransactionValidation[8]} and Action : {lsTransactionValidation[2]}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################
[ ] 
[+] //#######################################  Verify Add Stock Split  #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test92_Verify_Add_Stock_Split()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Add Stock Split
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If stock split is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  18th June 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test92_Verify_Add_Stock_Split() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] LIST OF ANYTYPE lsStockSplitData
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[7]
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[13]
		[ ] // Add Stock Split Transaction
		[ ] // Read data for adding splt
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sStockSplitSheet)
		[ ] lsStockSplitData=lsExcelData[1]
		[ ] //Validation data for splt
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sStockSplitValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] //Add Brokerage account
	[ ] iValidate=AddManualBrokerageAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],sDate)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Add Manual Brokerage account",PASS,"Manual Brokerage account is added")
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] // Add Buy Transaction
			[ ] 
			[ ] iValidate=AddBrokerageTransaction(lsTransactionData)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=Inv_AddStockSplitTransaction(lsStockSplitData)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if Stock Split Transaction is added",PASS,"Stock Split Transaction is added")
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] QuickenMainWindow.TypeKeys(KEY_PAGE_DOWN)
					[ ] 
					[ ] 
					[ ] //--------Verify that Transaction is entered in the Register-------
					[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
					[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
						[ ] 
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] break
							[ ] 
							[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if {lsStockSplitData[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsStockSplitData[1]} is added in Investing Register after using Enter/Done button")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if {lsStockSplitData[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsStockSplitData[1]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Stock Split Transaction is added",FAIL,"Stock Split Transaction {lsTransactionData}  is NOT added")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add Manual Brokerage account",FAIL,"Manual Brokerage account not added")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#######################################  Verify Edit Stock Split  #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test93_Verify_Edit_Stock_Split()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit stock split
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user can Edit stock split
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  18th June 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test93_Verify_Edit_Stock_Split() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[7]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sStockSplitSheet)
		[ ] lsTransactionData=lsExcelData[2]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sStockSplitValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[2]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Navigate to last entry
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.TypeKeys(KEY_PAGE_DOWN)
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionData[1],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Edit Transaction 
				[ ] wEnterTransaction.NewShares.SetText(lsTransactionData[6])
				[ ] wEnterTransaction.OldShares.SetText(lsTransactionData[7])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] 
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] // Navigate to last entry
				[ ] QuickenWindow.SetActive()
				[ ] QuickenMainWindow.TypeKeys(KEY_PAGE_DOWN)
				[ ] 
				[ ] //--------Verify that Transaction is entered in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionData[1]} is edited in Investing Register after using Enter/Done button")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is edited in Investing Register after using Enter/Done button",FAIL,"{lsTransactionData[1]} is NOT edited in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#########################  Verify Add Stock Split Between Buy And Sell Transactions ###########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test94_Verify_Add_Stock_Split_Between_Buy_And_Sell_Transactions()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify adding a split between buy and sell transaction
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If After a split is added between buy and sell transaction  , the share value of the sell transaction is higher
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  18th June 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test94_Verify_Add_Stock_Split_Between_Buy_And_Sell_Transactions() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[7]
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
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] 
		[ ] // Add Buy Transaction
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
		[ ] lsTransactionData=lsExcelData[13]
		[ ] iValidate=AddBrokerageTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] // Add Stock Split Transaction
			[ ] lsExcelData=NULL
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sStockSplitSheet)
			[ ] lsTransactionData=lsExcelData[4]
			[ ] iValidate=Inv_AddStockSplitTransaction(lsTransactionData)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
				[ ] 
				[ ] 
				[ ] // Add Sell Transaction
				[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
				[ ] lsTransactionData=lsExcelData[14]
				[ ] iValidate=AddBrokerageTransaction(lsTransactionData)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if Brokerage Sell Transaction is added",PASS,"Brokerage Sell Transaction is added")
					[ ] 
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] QuickenMainWindow.TypeKeys(KEY_PAGE_DOWN)
					[ ] 
					[ ] 
					[ ] //--------Search for Share value of Buy Transaction-----------
					[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sTransactionValidationSheet)
					[ ] lsTransactionValidation=lsExcelData[14]
					[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
					[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
						[ ] 
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
						[ ] 
						[ ] bMatch=MatchStr("*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[10]}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] break
							[ ] 
							[ ] 
					[+] if(bMatch==TRUE)
						[ ] 
						[ ] //----------Search for Share value of Sell Transaction---------
						[ ] lsTransactionValidation=lsExcelData[15]
						[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
						[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
							[ ] 
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
							[ ] 
							[ ] bMatch=MatchStr("*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[10]}*",sActual)
							[+] if(bMatch==TRUE)
								[ ] break
								[ ] 
								[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify adding a split between buy and sell transaction",PASS,"After a split is added between buy and sell transaction  , the share value of the sell transaction is higher")
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify adding a split between buy and sell transaction",FAIL,"Error during verification of adding a split between buy and sell transaction")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify adding a split between buy and sell transaction",FAIL,"Error during verification of adding a split between buy and sell transaction")
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
					[ ] ReportStatus("Verify if Brokerage Sell Transaction is added",FAIL,"Brokerage Sell Transaction is NOT added")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
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
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################  Verify Enter Reverse Stock Split  #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test95_Verify_Enter_Reverse_Stock_Split()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Reverse Stock Split 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user can Enter Reverse Stock Split without any error
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  23rd June 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test95_Verify_Enter_Reverse_Stock_Split() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[7]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sStockSplitSheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=Inv_AddStockSplitTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.TypeKeys(KEY_PAGE_DOWN)
			[ ] 
			[ ] 
			[ ] //--------Verify that Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] bMatch=MatchStr("*{lsTransactionData[1]}*{lsTransactionData[5]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount+2))
					[ ] bMatch=MatchStr("*{lsTransactionData[1]}*{lsTransactionData[5]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionData[1]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionData[1]} is NOT added in Investing Register after using Enter/Done button")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Enter Stock Dividend  ##########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test96_Verify_Enter_Stock_Dividend()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Stock Dividend
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Stock Dividend is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test96_Verify_Enter_Stock_Dividend() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[7]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sStockSplitSheet)
		[ ] lsTransactionData=lsExcelData[5]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sStockSplitValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[5]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] // Add Stock Dividend Transaction
		[ ] iValidate=AddStockDividend(lsTransactionData[5],lsTransactionData[6],lsTransactionData[4])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------Verify that Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionData[1]} is added {sActual} in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionData[1]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
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
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Enter Divident Reinvest  #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test97_Verify_Enter_Dividend_ReInvest()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Dividend Reinvest
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Reinvest Dividend is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  22nd June 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test97_Verify_Enter_Dividend_ReInvest() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] //Add Brokerage account
	[ ] iValidate=AddManualBrokerageAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],sDate)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Add Manual Brokerage account",PASS,"Manual Brokerage account is added")
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Add Buy Transaction
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBuyTransactionDataSheet)
			[ ] lsTransactionData=lsExcelData[15]
			[ ] iValidate=AddBrokerageTransaction(lsTransactionData)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify if Brokerage Buy Transaction is added",PASS,"Brokerage Buy Transaction is added")
				[ ] 
				[ ] 
				[ ] // Add Dividend Income Transaction
				[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestSheet)
				[ ] lsTransactionData=lsExcelData[1]
				[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9])
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if Dividend Income Transaction is added",PASS,"Dividend Income Transaction is added")
					[ ] 
					[ ] 
					[ ] 
					[ ] // Add Reinvest Dividend Transaction
					[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestSheet)
					[ ] lsTransactionData=lsExcelData[2]
					[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9],lsTransactionData[10],lsTransactionData[11],lsTransactionData[12],lsTransactionData[13],lsTransactionData[14],lsTransactionData[15],lsTransactionData[16])
					[+] if(iValidate==PASS)
						[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] QuickenMainWindow.TypeKeys(KEY_PAGE_DOWN)
						[ ] 
						[ ] //--------Verify that Income Transaction is entered in the Register-------
						[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
						[ ] lsTransactionValidation=lsExcelData[1]
						[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
						[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
							[ ] 
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
							[ ] 
							[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[6]}*{lsTransactionValidation[8]}*",sActual)
							[+] if(bMatch==TRUE)
								[ ] break
								[ ] 
								[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
							[ ] 
							[ ] 
						[ ] 
						[ ] //--------Verify that ReInvest Transaction is entered in the Register-------
						[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
						[ ] lsTransactionValidation=lsExcelData[2]
						[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
						[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
							[ ] 
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
							[ ] 
							[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
							[+] if(bMatch==TRUE)
								[ ] break
								[ ] 
								[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Dividend Income Transaction is added",FAIL,"Dividend Income Transaction is NOT added")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Brokerage Buy Transaction is added",FAIL,"Brokerage Buy Transaction is NOT added")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add Manual Brokerage account",FAIL,"Manual Brokerage account not added")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Edit Dividend Reinvest Shares ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test98_Verify_Edit_Dividend_ReInvest_Shares()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Dividend Reinvest Shares
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Reinvest Dividend share total can be edited without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test98_Verify_Edit_Dividend_ReInvest_Shares() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Navigate to latest transaction
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.TypeKeys(KEY_PAGE_DOWN)
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[3],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.DividentShare.SetText(lsTransactionValidation[9])
				[ ] // Edit Amount 
				[ ] wEnterTransaction.Dividend.SetText(lsTransactionValidation[10])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] //--------Verify that ReInvest Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is edited in Investing Register after using Enter/Done button , Actual :{sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Edit Dividend Reinvest Amount ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test99_Verify_Edit_Dividend_ReInvest_Amount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Dividend Reinvest Amount
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Reinvest Dividend amount can be edited without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test99_Verify_Edit_Dividend_ReInvest_Amount() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[4]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.DividentShare.SetText(lsTransactionValidation[9])
				[ ] // Edit Amount 
				[ ] wEnterTransaction.Dividend.SetText(lsTransactionValidation[10])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] //--------Verify that ReInvest Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is edited in Investing Register after using Enter/Done button , Actual :{sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Enter Interest Reinvest  #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test100_Verify_Enter_Interest_ReInvest()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Interest Reinvest
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Reinvest Interest is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  22nd June 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test100_Verify_Enter_Interest_ReInvest() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] 
		[ ] // Add Interest Income Transaction
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestSheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Dividend Income Transaction is added",PASS,"Dividend Income Transaction is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] // Add Reinvest Interest Transaction
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestSheet)
			[ ] lsTransactionData=lsExcelData[4]
			[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9],lsTransactionData[10],lsTransactionData[11],lsTransactionData[12],lsTransactionData[13],lsTransactionData[14],lsTransactionData[15],lsTransactionData[16])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
				[ ] 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] QuickenMainWindow.TypeKeys(KEY_PAGE_DOWN)
				[ ] 
				[ ] //--------Verify that Income Transaction is entered in the Register-------
				[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
				[ ] lsTransactionValidation=lsExcelData[5]
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[6]}*{lsTransactionValidation[8]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] //--------Verify that ReInvest Transaction is entered in the Register-------
				[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
				[ ] lsTransactionValidation=lsExcelData[6]
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Dividend Income Transaction is added",FAIL,"Dividend Income Transaction is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] // // Sprint 10
[ ] 
[+] // //#################################### Verify Edit Interest Reinvest Shares #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test101_Verify_Edit_Interest_ReInvest_Shares()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Interest Reinvest Shares
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 		If Reinvest Interest share total can be edited without any issue
		[ ] // Fail		      If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th July 2014
		[ ] // 
	[ ] // ********************************************************
[+] testcase Test101_Verify_Edit_Interest_ReInvest_Shares() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] //Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[7]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Navigate to latest transaction
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.TypeKeys(KEY_PAGE_DOWN)
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[3],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // Enter Shares
				[ ] wEnterTransaction.IntrestShare.SetText(lsTransactionValidation[9])
				[ ] // Edit Amount 
				[ ] wEnterTransaction.Interest.SetText(lsTransactionValidation[10])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] // --------Verify that ReInvest Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is edited in Investing Register after using Enter/Done button , Actual :{sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] // //#######################################################################################################
[ ] 
[+] //#################################### Verify Edit Interest Reinvest Amount #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test102_Verify_Edit_Interest_ReInvest_Amount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Interest Reinvest Amount
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Reinvest Interest amount can be edited without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test102_Verify_Edit_Interest_ReInvest_Amount() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[8]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Navigate to latest transaction
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.IntrestShare.SetText(lsTransactionValidation[9])
				[ ] // Edit Amount 
				[ ] wEnterTransaction.Interest.SetText(lsTransactionValidation[10])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] //--------Verify that ReInvest Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is edited in Investing Register after using Enter/Done button , Actual :{sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[+] //#################################### Verify Enter Short Term Gain Reinvest  ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test103_Verify_Enter_Short_Term_Gain_ReInvest()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Short Term Gain Reinvest
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Short Term Gain Interest is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  22nd June 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test103_Verify_Enter_Short_Term_Gain_ReInvest() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Reinvest Interest Transaction
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestSheet)
		[ ] lsTransactionData=lsExcelData[5]
		[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9],lsTransactionData[10],lsTransactionData[11],lsTransactionData[12],lsTransactionData[13],lsTransactionData[14],lsTransactionData[15],lsTransactionData[16])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that ReInvest Transaction is entered in the Register-------
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
			[ ] lsTransactionValidation=lsExcelData[9]
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Edit Short Term Gain Reinvest Shares ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test104_Verify_Edit_Short_Term_Gain_ReInvest_Shares()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Short Term Gain Reinvest Shares
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Short Term Gain Interest share total can be edited without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test104_Verify_Edit_Short_Term_Gain_ReInvest_Shares() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[10]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Navigate to latest transaction
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.ShortShare.SetText(lsTransactionValidation[9])
				[ ] // Edit Amount 
				[ ] wEnterTransaction.ShortTermCapGainDist.SetText(lsTransactionValidation[10])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] //--------Verify that ReInvest Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is edited in Investing Register after using Enter/Done button , Actual :{sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Edit Short Term Gain Reinvest Amount ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test105_Verify_Edit_Short_Term_Gain_ReInvest_Amount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Short Term Gain  Reinvest Amount
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Reinvest Edit Short Term Gain  amount can be edited without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test105_Verify_Edit_Short_Term_Gain_ReInvest_Amount() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[11]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Navigate to latest transaction
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.ShortShare.SetText(lsTransactionValidation[9])
				[ ] // Edit Amount 
				[ ] wEnterTransaction.ShortTermCapGainDist.SetText(lsTransactionValidation[10])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] //--------Verify that ReInvest Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is edited in Investing Register after using Enter/Done button , Actual :{sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Enter Middle Term Gain Reinvest  #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test106_Verify_Enter_Middle_Term_Gain_ReInvest()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Middle Term Gain Reinvest
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Middle Term Gain Reinvest is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  22nd June 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test106_Verify_Enter_Middle_Term_Gain_ReInvest() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[12]
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestSheet)
		[ ] lsTransactionData=lsExcelData[6]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Reinvest Interest Transaction
		[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9],lsTransactionData[10],lsTransactionData[11],lsTransactionData[12],lsTransactionData[13],lsTransactionData[14],lsTransactionData[15],lsTransactionData[16])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that ReInvest Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Edit Middle Term Gain Reinvest Shares #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test107_Verify_Edit_Middle_Term_Gain_ReInvest_Shares()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Middle Term Gain Reinvest Shares
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Middle Term Gain Reinvest share total can be edited without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test107_Verify_Edit_Middle_Term_Gain_ReInvest_Shares() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[13]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Navigate to latest transaction
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.MidShare.SetText(lsTransactionValidation[9])
				[ ] // Edit Amount 
				[ ] wEnterTransaction.MidTermCapGainDist.SetText(lsTransactionValidation[10])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] //--------Verify that ReInvest Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is edited in Investing Register after using Enter/Done button , Actual :{sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Edit Middle Term Gain Reinvest Amount #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test108_Verify_Edit_Middle_Term_Gain_ReInvest_Shares()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Middle Term Gain Reinvest Amount
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Middle Term Gain Reinvest amount can be edited without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test108_Verify_Edit_Middle_Term_Gain_ReInvest_Shares() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[14]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Navigate to latest transaction
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.MidShare.SetText(lsTransactionValidation[9])
				[ ] // Edit Amount 
				[ ] wEnterTransaction.MidTermCapGainDist.SetText(lsTransactionValidation[10])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] //--------Verify that ReInvest Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is edited in Investing Register after using Enter/Done button , Actual :{sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Enter Long Term Gain Reinvest  #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test109_Verify_Enter_Long_Term_Gain_ReInvest()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Long Term Gain Reinvest
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Long Term Gain is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  22nd June 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test109_Verify_Enter_Long_Term_Gain_ReInvest() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Reinvest Interest Transaction
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestSheet)
		[ ] lsTransactionData=lsExcelData[7]
		[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9],lsTransactionData[10],lsTransactionData[11],lsTransactionData[12],lsTransactionData[13],lsTransactionData[14],lsTransactionData[15],lsTransactionData[16])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that ReInvest Transaction is entered in the Register-------
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
			[ ] lsTransactionValidation=lsExcelData[15]
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Edit Long Term Gain Reinvest Shares #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test107_Verify_Edit_Middle_Term_Gain_ReInvest_Shares()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Long Term Gain Reinvest Shares
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Long Term Gain Reinvest share total can be edited without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test110_Verify_Edit_Long_Term_Gain_ReInvest_Shares() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[16]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Navigate to latest transaction
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.LongShare.SetText(lsTransactionValidation[9])
				[ ] // Edit Amount 
				[ ] wEnterTransaction.LongTermCapGainDist.SetText(lsTransactionValidation[10])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] //--------Verify that ReInvest Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is edited in Investing Register after using Enter/Done button , Actual :{sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Edit Long Term Gain Reinvest Amount #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test108_Verify_Edit_Middle_Term_Gain_ReInvest_Shares()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Long Term Gain Reinvest Amount
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Long Term Gain Reinvest  amount can be edited without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test111_Verify_Edit_Long_Term_Gain_ReInvest_Shares() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[17]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Navigate to latest transaction
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[+] if(wEnterTransaction.Account.IsEnabled()==FALSE)
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",PASS,"Account Field on Enter Transaction dialog is disabled")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Account Field on Enter Transaction dialog is disabled",FAIL,"Account Field on Enter Transaction dialog is enabled")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.LongShare.SetText(lsTransactionValidation[9])
				[ ] // Edit Amount 
				[ ] wEnterTransaction.LongTermCapGainDist.SetText(lsTransactionValidation[10])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] 
				[ ] //--------Verify that ReInvest Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is edited in Investing Register after using Enter/Done button , Actual :{sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] // //#################################### Verify All Fields Reinvest  #########################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test112_113_Verify_All_Fields_ReInvest()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will Verify All Fields Reinvest 
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		If All Fields in Reinvest dialog are active and collective calculation is correct
		[ ] // //						Fail		      If any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:
		[ ] // // Dean Paes created  10th July 2014
		[ ] // //
	[ ] // // ********************************************************
[+] testcase Test112_113_Verify_All_Fields_ReInvest() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[8]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Reinvest Interest Transaction
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestSheet)
		[ ] lsTransactionData=lsExcelData[7]
		[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9],lsTransactionData[10],lsTransactionData[11],lsTransactionData[12],lsTransactionData[13],lsTransactionData[14],lsTransactionData[15],lsTransactionData[16])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that ReInvest Transaction is entered in the Register-------
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReInvestValidationSheet)
			[ ] lsTransactionValidation=lsExcelData[18]
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*{lsTransactionValidation[7]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Enter Income Dividend   ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test114_Verify_Enter_Dividend_Income()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Income - Dividend
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Dividend is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test114_Verify_Enter_Dividend_Income() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeTransactionSheet)
		[ ] lsTransactionData=lsExcelData[1]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add Brokerage account
	[ ] iValidate=AddManualBrokerageAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],sDate)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Add Manual Brokerage account",PASS,"Manual Brokerage account is added")
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Add Dividend Income Transaction
			[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify if Dividend Income Transaction is added",PASS,"Dividend Income Transaction is added")
				[ ] 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] //--------Verify that Income Transaction is entered in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Dividend Income Transaction is added",FAIL,"Dividend Income Transaction is NOT added")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add Manual Brokerage account",FAIL,"Manual Brokerage account not added")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[+] //#################################### Verify Edit Income Dividend   #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test114_Verify_Edit_Dividend_Income()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Income - Dividend
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Dividend can be edited in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test115_Verify_Edit_Dividend_Income() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[7]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.Dividend.SetText(lsTransactionValidation[6])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //--------Verify that Income Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} transaction can be edited in Investing Register : Actual {sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} transaction can NOT be edited in Investing Register : Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[+] //##############################      Verify Enter Income Interest   #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test116_Verify_Enter_Interest_Income()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Income - Interest
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Interest is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test116_Verify_Enter_Interest_Income() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeTransactionSheet)
		[ ] lsTransactionData=lsExcelData[2]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[2]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Dividend Income Transaction
		[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Dividend Income Transaction is added",PASS,"Dividend Income Transaction is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that Income Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Dividend Income Transaction is added",FAIL,"Dividend Income Transaction is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[+] //#################################### Verify Edit Income Interest   ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test117_Verify_Edit_Interest_Income()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Income - Interest
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Interest can be edited in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test117_Verify_Edit_Interest_Income() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[8]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.Interest.SetText(lsTransactionValidation[6])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //--------Verify that Income Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} transaction can be edited in Investing Register : Actual {sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} transaction can NOT be edited in Investing Register : Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[+] //#################################### Verify Enter Income Short Term Gain  ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test118_Verify_Enter_Short_Term_Gain_Income()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Income - Short Term Gain
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Short Term Gain is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test118_Verify_Enter_Short_Term_Gain_Income() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeTransactionSheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[3]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add Brokerage account
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Dividend Income Transaction
		[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Dividend Income Transaction is added",PASS,"Dividend Income Transaction is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that Income Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Dividend Income Transaction is added",FAIL,"Dividend Income Transaction is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[+] //#################################### Verify Edit Short Term Gain   #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test119_Verify_Edit_Short_Term_Gain()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Short Term Gain
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Short Term Gain can be edited in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test119_Verify_Edit_Short_Term_Gain() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[9]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.ShortTermCapGainDist.SetText(lsTransactionValidation[6])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //--------Verify that Income Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} transaction can be edited in Investing Register : Actual {sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} transaction can NOT be edited in Investing Register : Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[+] //#################################### Verify Enter Income Mid Term Gain  ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test120_Verify_Enter_Mid_Term_Gain_Income()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Income - Mid Term Gain
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Mid Term Gain is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test120_Verify_Enter_Mid_Term_Gain_Income() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeTransactionSheet)
		[ ] lsTransactionData=lsExcelData[4]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[4]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Dividend Income Transaction
		[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Dividend Income Transaction is added",PASS,"Dividend Income Transaction is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that Income Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Dividend Income Transaction is added",FAIL,"Dividend Income Transaction is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#####################################################################################################
[ ] 
[+] //#################################### Verify Edit Mid Term Gain   #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test121_Verify_Edit_Mid_Term_Gain()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Mid Term Gain
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Mid Term Gain can be edited in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test121_Verify_Edit_Mid_Term_Gain() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[10]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.MidTermCapGainDist.SetText(lsTransactionValidation[6])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //--------Verify that Income Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} transaction can be edited in Investing Register : Actual {sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} transaction can NOT be edited in Investing Register : Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#####################################################################################################
[ ] 
[+] //#################################### Verify Enter Income Long Term Gain ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test122_Verify_Enter_Long_Term_Gain_Income()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Income - Long Term Gain
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Long Term Gain is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test122_Verify_Enter_Long_Term_Gain_Income() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeTransactionSheet)
		[ ] lsTransactionData=lsExcelData[5]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[5]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Dividend Income Transaction
		[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Dividend Income Transaction is added",PASS,"Dividend Income Transaction is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that Income Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Dividend Income Transaction is added",FAIL,"Dividend Income Transaction is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################
[ ] 
[+] //#################################### Verify Edit Long Term Gain   #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test123_Verify_Edit_Long_Term_Gain()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Long Term Gain
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Long Term Gain can be edited in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test123_Verify_Edit_Long_Term_Gain() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[11]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.LongTermCapGainDist.SetText(lsTransactionValidation[6])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //--------Verify that Income Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} transaction can be edited in Investing Register : Actual {sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} transaction can NOT be edited in Investing Register : Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################
[ ] 
[+] //#################################### Verify Enter Income Misc   ##########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test124_Verify_Enter_Misc_Income()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Income - Interest
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Misc is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test124_Verify_Enter_Misc_Income() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeTransactionSheet)
		[ ] lsTransactionData=lsExcelData[6]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[6]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Dividend Income Transaction
		[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9],lsTransactionData[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Dividend Income Transaction is added",PASS,"Dividend Income Transaction is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that Income Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Dividend Income Transaction is added",FAIL,"Dividend Income Transaction is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################
[ ] 
[+] //#################################### Verify Edit Income Misc   ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test125_Verify_Edit_Misc_Income()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Income - Misc
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Misc can be edited in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test125_Verify_Edit_Misc_Income() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[12]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Click on the Edit Button once transaction is highlighted in register
		[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(lsTransactionValidation[2])
		[ ] 
		[ ] // 29-09-2015 KalyanG: get the edit button into view
		[ ] sleep(1)
		[ ] EditButtonScrollIntoView()
		[ ] 
		[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
		[ ] 
		[ ] sleep(2)
		[ ] 
		[ ] 
		[+] if(wEnterTransaction.Exists(5))
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
			[ ] 
			[ ] wEnterTransaction.SetActive()
			[ ] 
			[ ] 
			[ ] 
			[ ] //Enter Shares
			[ ] wEnterTransaction.Miscellaneous.SetText(lsTransactionValidation[6])
			[ ] wEnterTransaction.EnterDone.Click()
			[ ] WaitForState(wEnterTransaction,FALSE,5)
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------Verify that Income Transaction is edited in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} transaction can be edited in Investing Register : Actual {sActual}")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} transaction can NOT be edited in Investing Register : Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
		[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Enter Income Misc and Category  #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test126_Verify_Enter_Misc_Income_Category()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Income - Interest with Category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Category for Income - Misc is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  15th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test126_Verify_Enter_Misc_Income_Category() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeTransactionSheet)
		[ ] lsTransactionData=lsExcelData[7]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[13]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Dividend Income Transaction
		[ ] iValidate=AddInvestingTransactionForInvestIncome(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8],lsTransactionData[9],lsTransactionData[10],lsTransactionData[11],lsTransactionData[12],lsTransactionData[13],lsTransactionData[14],lsTransactionData[15],lsTransactionData[16],lsTransactionData[17])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Income Transaction is added",PASS,"Income Transaction is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that Income Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[8]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Income Transaction is added",FAIL,"Income Transaction is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //#################################### Verify Edit Income Misc and Category  #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test127_Verify_Edit_Misc_Income_Category()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Income - Interest with Category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Category for Income - Misc is Edited in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  15th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test127_Verify_Edit_Misc_Income_Category() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[14]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[9],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.CategoryForMiscellaneous.ClearText()
				[ ] wEnterTransaction.CategoryForMiscellaneous.SetText(lsTransactionValidation[6])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //--------Verify that Income Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[8]}*{lsTransactionValidation[4]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} transaction can be edited in Investing Register : Actual {sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} transaction can NOT be edited in Investing Register : Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] // // Work on These--------------
[ ] 
[+] //#################################### Verify Enter Income Misc   ##########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test124_Verify_Enter_Misc_Income()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Income - Interest
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Misc is added in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test128_Verify_Enter_Misc_Income_With_No_Security() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeTransactionSheet)
		[ ] lsTransactionData=lsExcelData[8]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[15]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive ()
		[ ] BrokerageAccount.EnterTransactions.Click()
		[ ] 
		[+] if(wEnterTransaction.Exists(5))
			[ ] 
			[ ] wEnterTransaction.SetActive()
			[ ] // Open Buy transaction window
			[ ] wEnterTransaction.EnterTransaction.SetFocus()
			[ ] 
			[ ] wEnterTransaction.EnterTransaction.Select(lsTransactionData[2])
			[ ] sleep(2)
			[ ] // Enter transaction date
			[ ] wEnterTransaction.TransactionDate.SetText(lsTransactionData[3])
			[ ] wEnterTransaction.Miscellaneous.SetText(lsTransactionData[10])
			[ ] 
			[ ] // Click on Enter Done
			[ ] wEnterTransaction.EnterDone.Click()
			[ ] WaitForState(wEnterTransaction,FALSE,5)
			[ ] sleep(3)
			[ ] dismissDialog()
			[ ] sleep(1)
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------Verify that Income Transaction is entered in the Register-------
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
					[ ] 
			[+] if(bMatch==TRUE)
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[3]}*",sActual)
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register",PASS,"{lsTransactionValidation[2]} is added without Security name in Investing Register after using Enter/Done button")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register",FAIL,"{lsTransactionValidation[2]} is added WITH Security name in Investing Register after using Enter/Done button")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
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
			[ ] ReportStatus("Window Title validation", FAIL, "Enter Transaction Window did not open")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################
[ ] 
[ ] 
[+] //#################################### Verify Edit Income Misc   ##########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test125_Verify_Edit_Misc_Income()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Income - Misc
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Income - Misc can be edited in Investing register without any issue
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test129_Verify_Edit_Misc_Income_With_No_Security() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[10]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sIncomeValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[12]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.Miscellaneous.SetText(lsTransactionValidation[6])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //--------Verify that Income Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} transaction can be edited in Investing Register : Actual {sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} transaction can NOT be edited in Investing Register : Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[ ] // //-------------------------------------------------------
[ ] // 
[ ] // 
[ ] // 
[ ] 
[ ] // //Sprint 11
[ ] 
[+] //######################  Verify Enter the Return of Capital with cost basis returned only  #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test130_Verify_Return_Of_Capital_With_Only_Cost_Basis()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter the Return of Capital with cost basis returned only
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Return of Capital transaction is added to register correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  17th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test130_Verify_Return_Of_Capital_With_Only_Cost_Basis() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[12]
		[ ] 
		[ ] 
		[ ] // Add Return Of Capital Transaction with only cost basis
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalSheet)
		[ ] lsTransactionData=lsExcelData[1]
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[1]
		[ ] 
	[ ] //Add Brokerage account
	[ ] iValidate=AddManualBrokerageAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],sDate)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Add Manual Brokerage account",PASS,"Manual Brokerage account is added")
		[ ] 
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=Inv_ReturnOfCapital(lsTransactionData)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
				[ ] 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //--------Verify that Return Of Capital Transaction with only cost basis is entered in the Register-------
				[ ] 
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
					[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionData[1]} with only cost basis is added in Investing Register after using Enter/Done button")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionData[1]} with only cost basis is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add Manual Brokerage account",FAIL,"Manual Brokerage account not added")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[+] //######################  Verify Enter the Return of Capital with cost basis and  Market Value  #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test131_Verify_Return_Of_Capital_With_Cost_Basis_And_Market_Value()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter the Return of Capital with cost basis and market value
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Return of Capital transaction is added to register correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  17th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test131_Verify_Return_Of_Capital_With_Cost_Basis_And_Market_Value() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[12]
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalSheet)
		[ ] lsTransactionData=lsExcelData[2]
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[2]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Return Of Capital Transaction with only cost basis
		[ ] 
		[ ] iValidate=Inv_ReturnOfCapital(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------Verify that Return Of Capital Transaction with only cost basis is entered in the Register-------
			[ ] 
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionData[1]} with cost basis and market value is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionData[1]} with cost basis and market value is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[+] //#################################### Verify Edit Return Of Capital With Cost Basis ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test132_Verify_Edit_Return_Of_Capital_With_Cost_Basis()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Return Of Capital With Cost Basis
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Return Of Capital With Cost Basis Transaction is edited without any error
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test132_Verify_Edit_Return_Of_Capital_With_Cost_Basis() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[12]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[3]
		[ ] 
	[ ] 
	[ ] 
	[ ] //at times find don't work correctly hence commented the find code as the trnsaction is added in the previous testcase and by default selected
	[ ] // 
	[ ] // iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] // if(iValidate==PASS)
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] // if(iValidate==PASS)
			[ ] // ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] // 
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] QuickenWindow.SetActive()
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(lsTransactionValidation[2])
			[ ] sleep(1)
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.Amount.SetText(lsTransactionValidation[8])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //--------Verify that Income Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} transaction can be edited in Investing Register : Actual {sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} transaction can NOT be edited in Investing Register : Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] // else
			[ ] // ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //#################################### Verify Edit Return Of Capital With Cost Basis And Market Value ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test133_Verify_Edit_Return_Of_Capital_With_Cost_Basis_And_Market_Value()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Return Of Capital With Cost Basis and market value
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Return Of Capital With Cost Basis and market value Transaction is edited without any error
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test133_Verify_Edit_Return_Of_Capital_With_Cost_Basis_And_Market_Value() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[12]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[4]
		[ ] 
		[ ] 
	[ ] 
	[ ] // 2015-10-15 KalyanG: Workaround to get the registry transaction in focus
	[ ] // or else required text does not come into view
	[ ] SelectAccountFromAccountBar("Brokerage 01 Account",ACCOUNT_INVESTING)
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] // if(iValidate==PASS)
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // 
		[ ] // iValidate=FindTransaction(sMDIWindow,lsTransactionValidation[2],ACCOUNT_INVESTING)
		[+] // if(iValidate==PASS)
			[ ] // ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] QuickenWindow.SetActive()
			[ ] // Click on the Edit Button once transaction is highlighted in register
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(lsTransactionValidation[2])
			[ ] sleep(1)
			[ ] 
			[ ] // 29-09-2015 KalyanG: get the edit button into view
			[ ] EditButtonScrollIntoView()
			[ ] 
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
			[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
			[+] if(wEnterTransaction.Exists(5))
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
				[ ] 
				[ ] wEnterTransaction.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Shares
				[ ] wEnterTransaction.Amount.SetText(lsTransactionValidation[8])
				[ ] wEnterTransaction.EnterDone.Click()
				[ ] WaitForState(wEnterTransaction,FALSE,5)
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] //--------Verify that Income Transaction is edited in the Register-------
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} transaction can be edited in Investing Register : Actual {sActual}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} transaction can NOT be edited in Investing Register : Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
			[ ] 
		[+] // else
			[ ] // ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction is NOT added")
		[ ] // 
		[ ] // 
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] // 
	[ ] // 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[+] //######################  Verify Enter MisExp transaction with a security  ##########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test134_Verify_Enter_MisExp_Transaction_with_A_Security()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter MisExp transaction with a security
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If MisExp transaction with a security is added to register correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  21st July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test134_Verify_Enter_MisExp_Transaction_with_A_Security() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[12]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Return Of Capital Transaction with only cost basis
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalSheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] 
		[ ] iValidate=Inv_MiscExpTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that Return Of Capital Transaction with only cost basis is entered in the Register-------
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalValidationSheet)
			[ ] lsTransactionValidation=lsExcelData[5]
			[ ] 
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionData[1]} with with a security is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionData[1]} with with a security is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[+] //######################  Verify Enter MisExp transaction with no security and no category  ###########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test135_Verify_Enter_MisExp_Transaction_with_No_Security_No_Category()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter MisExp transaction with no security and no category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If MisExp transaction with no security and no category is added to register correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  21st July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test135_Verify_Enter_MisExp_Transaction_with_No_Security_No_Category() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[12]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Return Of Capital Transaction with only cost basis
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalSheet)
		[ ] lsTransactionData=lsExcelData[4]
		[ ] 
		[ ] iValidate=Inv_MiscExpTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that Return Of Capital Transaction with only cost basis is entered in the Register-------
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalValidationSheet)
			[ ] lsTransactionValidation=lsExcelData[6]
			[ ] 
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction with no security and no category is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionData[1]} with no security and no category is added in Investing Register after using Enter/Done button")
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[9]}*",sActual)
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify that security is not displayed",PASS,"Security is not displayed")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that security is not displayed",FAIL,"Security is not displayed")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionData[1]} withno security and no category NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[+] //######################  Verify Enter MisExp transaction with security and category  ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test136_Verify_Enter_MisExp_Transaction_with_Security_And_Category()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter MisExp transaction with security and category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If MisExp transaction with security and category is added to register correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  21st July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test136_Verify_Enter_MisExp_Transaction_with_Security_And_Category() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[12]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Return Of Capital Transaction with only cost basis
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalSheet)
		[ ] lsTransactionData=lsExcelData[5]
		[ ] 
		[ ] iValidate=Inv_MiscExpTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that Return Of Capital Transaction with only cost basis is entered in the Register-------
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalValidationSheet)
			[ ] lsTransactionValidation=lsExcelData[7]
			[ ] 
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[6]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction with security and category is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionData[1]} with security and category is added in Investing Register after using Enter/Done button")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionData[1]} with security and category NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[+] //###########################  Verify Edit MisExp transaction with a security  ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test137_Verify_Edit_MisExp_Transaction_with_A_Security()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit MisExp transaction with a security
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If MisExp transaction with a security can be Edited without any issues
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test137_Verify_Edit_MisExp_Transaction_with_A_Security() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[12]
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[8]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] // Click on the Edit Button once transaction is highlighted in register
		[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(lsTransactionValidation[2])
		[ ] 
		[ ] // 29-09-2015 KalyanG: get the edit button into view
		[ ] sleep(1)
		[ ] EditButtonScrollIntoView()
		[ ] 
		[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
		[ ] 
		[ ] 
		[ ] 
		[ ] sleep(2)
		[ ] 
		[ ] 
		[+] if(wEnterTransaction.Exists(5))
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
			[ ] 
			[ ] wEnterTransaction.SetActive()
			[ ] 
			[ ] 
			[ ] //Enter New Amount
			[ ] wEnterTransaction.Amount.SetText(lsTransactionValidation[8])
			[ ] wEnterTransaction.EnterDone.Click()
			[ ] WaitForState(wEnterTransaction,FALSE,5)
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} with with a security is edited in Investing Register")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} with with a security is NOT edited in Investing Register: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[+] //######################  Verify Edit MisExp transaction with no security and no category  #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test138_Verify_Edit_MisExp_Transaction_with_No_Security_No_Category()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit MisExp transaction with no security and no category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If MisExp transaction with no security and no category is edited in register
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  21st July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test138_Verify_Edit_MisExp_Transaction_with_No_Security_No_Category() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[12]
		[ ] 
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[9]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] // Click on the Edit Button once transaction is highlighted in register
		[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(lsTransactionValidation[2],2)
		[ ] 
		[ ] // 29-09-2015 KalyanG: get the edit button into view
		[ ] sleep(1)
		[ ] EditButtonScrollIntoView()
		[ ] 
		[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
		[ ] 
		[ ] 
		[ ] 
		[ ] sleep(2)
		[ ] 
		[ ] 
		[+] if(wEnterTransaction.Exists(5))
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
			[ ] 
			[ ] wEnterTransaction.SetActive()
			[ ] 
			[ ] 
			[ ] //Enter New Amount
			[ ] wEnterTransaction.Amount.SetText(lsTransactionValidation[8])
			[ ] wEnterTransaction.EnterDone.Click()
			[ ] WaitForState(wEnterTransaction,FALSE,5)
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction with no security and no category is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} with no security and no category is edited in Investing Register")
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[9]}*",sActual)
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify that security is not displayed",PASS,"Security is not displayed")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that security is not displayed",FAIL,"Security is not displayed")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} withno security and no category NOT edited in Investing Register : Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[+] //######################  Verify Edit MisExp transaction with security and category  ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test139_Verify_Edit_MisExp_Transaction_with_Security_And_Category()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit MisExp transaction with with security and category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If MisExp transaction with with security and category is edited in register
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  21st July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test139_Verify_Edit_MisExp_Transaction_with_Security_And_Category() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[12]
		[ ] 
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[10]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] // Click on the Edit Button once transaction is highlighted in register
		[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(lsTransactionValidation[2],3)
		[ ] 
		[ ] // 29-09-2015 KalyanG: get the edit button into view
		[ ] sleep(1)
		[ ] EditButtonScrollIntoView()
		[ ] 
		[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(sEditText)
		[ ] 
		[ ] 
		[ ] 
		[ ] sleep(2)
		[ ] 
		[ ] 
		[+] if(wEnterTransaction.Exists(5))
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",PASS,"Enter Transaction dialog exists")
			[ ] 
			[ ] wEnterTransaction.SetActive()
			[ ] 
			[ ] 
			[ ] //Enter New Amount
			[ ] wEnterTransaction.Amount.SetText(lsTransactionValidation[8])
			[ ] wEnterTransaction.EnterDone.Click()
			[ ] WaitForState(wEnterTransaction,FALSE,5)
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[6]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction with security and category is edited in Investing Register after using Enter/Done button",PASS,"{lsTransactionValidation[2]} with security and category is edited in Investing Register")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionValidation[2]} Transaction is edited in Investing Register after using Enter/Done button",FAIL,"{lsTransactionValidation[2]} with security and category NOT edited in Investing Register : Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Enter Transaction dialog exists",FAIL,"Enter Transaction dialog did NOT launch")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[+] //######################  Verify Enter MisExp transaction with a newly created category  #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test140_Verify_Enter_MisExp_Transaction_with_A_Newly_Created_Category()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter MisExp transaction with a newly created category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If MisExp transaction with a newly created category is added to register correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  21st July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test140_Verify_Enter_MisExp_Transaction_with_A_Newly_Created_Category() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[12]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Return Of Capital Transaction with only cost basis
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalSheet)
		[ ] lsTransactionData=lsExcelData[6]
		[ ] 
		[ ] iValidate=Inv_MiscExpTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //--------Verify that Return Of Capital Transaction with only cost basis is entered in the Register-------
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sReturnOfCapitalValidationSheet)
			[ ] lsTransactionValidation=lsExcelData[11]
			[ ] 
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[6]}*{lsTransactionValidation[4]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction with a newly created category is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionData[1]} with a newly created category is added in Investing Register after using Enter/Done button")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionData[1]} with a newly created category is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[+] //######################  Verify Entering a check to print via the transation form   #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test141_Verify_Enter_Write_Check_Transaction_Investing()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Entering a check to print via the transaction form
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User can enter Check to print in an investing account correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test141_Verify_Enter_Write_Check_Transaction_Investing() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[13]
		[ ] 
		[ ] lsExcelData=NULL
		[ ] // Add Return Of Capital Transaction with only cost basis
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sCashTransactionSheet)
		[ ] lsTransactionData=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sCashTransactionValidationSheet)
		[ ] lsTransactionValidation=lsExcelData[1]
		[ ] 
	[ ] 
	[ ] //Add Brokerage account
	[ ] iValidate=AddManualBrokerageAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],sDate)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Add Manual Brokerage account",PASS,"Manual Brokerage account {lsAddAccount[2]} is added")
		[ ] 
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=Inv_CashActionTransaction(lsTransactionData)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction for {lsTransactionData[1]} is added")
				[ ] 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(lsTransactionValidation[2])
				[ ] 
				[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
				[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
					[ ] 
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
					[ ] 
					[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[3]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
						[ ] 
						[ ] 
					[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionData[1]} is added in Investing Register after using Enter/Done button")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionData[1]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account {lsAddAccount[2]} register NOT opened")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add Manual Brokerage account",FAIL,"Manual Brokerage account {lsAddAccount[2]} not added")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[+] //###################### Verify Enter a cash Deposit transaction with transaction form ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test142_Verify_Enter_Deposit_Transaction_Investing()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter a cash Deposit transaction with transaction form
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User can Enter a cash Deposit transaction with transaction form
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test142_Verify_Enter_Deposit_Transaction_Investing() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[13]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Return Of Capital Transaction with only cost basis
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sCashTransactionSheet)
		[ ] lsTransactionData=lsExcelData[2]
		[ ] 
		[ ] iValidate=Inv_CashActionTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction for {lsTransactionData[1]} is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------Verify that Return Of Capital Transaction with only cost basis is entered in the Register-------
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sCashTransactionValidationSheet)
			[ ] lsTransactionValidation=lsExcelData[2]
			[ ] 
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(lsTransactionValidation[2],2)
			[ ] 
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] print(sActual)
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionData[1]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionData[1]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account {lsAddAccount[2]} register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[+] //###################### Verify Enter a cash withdrawal transaction with transaction form ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test143_Verify_Enter_Withdraw_Transaction_Investing()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter a cash withdrawal transaction with transaction form
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User can Enter a cash withdrawal transaction with transaction form
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th July 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test143_Verify_Enter_Withdraw_Transaction_Investing() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[13]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Return Of Capital Transaction with only cost basis
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sCashTransactionSheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] 
		[ ] iValidate=Inv_CashActionTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction for {lsTransactionData[1]} is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------Verify that Return Of Capital Transaction with only cost basis is entered in the Register-------
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sCashTransactionValidationSheet)
			[ ] lsTransactionValidation=lsExcelData[3]
			[ ] 
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(lsTransactionValidation[2],2)
			[ ] 
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] print(sActual)
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionData[1]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionData[1]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account {lsAddAccount[2]} register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[ ] 
[+] //############################ Verify Enter Other Cash Transaction of Payment ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test144A_Verify_Enter_Other_Cash_Transaction_Of_Payment()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter Other Cash Transaction of Payment
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User can Enter Other Cash Transaction of Payment
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  1st Aug 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test144A_Verify_Enter_Other_Cash_Transaction_Of_Payment() appstate none
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sBankingAccountsSheet)
		[ ] lsAddAccount=lsExcelData[13]
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_INVESTING)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] 
		[ ] // Add Return Of Capital Transaction with only cost basis
		[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sCashTransactionSheet)
		[ ] lsTransactionData=lsExcelData[3]
		[ ] 
		[ ] iValidate=Inv_CashActionTransaction(lsTransactionData)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify if Brokerage Transaction is added",PASS,"Brokerage Transaction for {lsTransactionData[1]} is added")
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //--------Verify that Return Of Capital Transaction with only cost basis is entered in the Register-------
			[ ] lsExcelData=ReadExcelTable(sInvestingRegisterExcelData,sCashTransactionValidationSheet)
			[ ] lsTransactionValidation=lsExcelData[3]
			[ ] 
			[ ] MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.TextClick(lsTransactionValidation[2],2)
			[ ] 
			[ ] sHandle=Str(MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetHandle())
			[+] for(iCount=0;iCount<=MDIClient.BrokerageAccount.StaticText1.StaticText2.RegisterListBox.ListBox.GetItemCount()*4;iCount++)
				[ ] 
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
				[ ] print(sActual)
				[ ] 
				[ ] bMatch=MatchStr("*{lsTransactionValidation[1]}*{lsTransactionValidation[2]}*{lsTransactionValidation[4]}*{lsTransactionValidation[5]}*{lsTransactionValidation[6]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] break
					[ ] 
					[ ] 
				[ ] 
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",PASS,"{lsTransactionData[1]} is added in Investing Register after using Enter/Done button")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if {lsTransactionData[1]} Transaction is added in Investing Register after using Enter/Done button",FAIL,"{lsTransactionData[1]} is NOT added in Investing Register after using Enter/Done button: Actual {sActual}")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Brokerage Transaction is added",FAIL,"Brokerage Transaction {lsTransactionData}  is NOT added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual Brokerage Account register",FAIL,"Manual Brokerage Account {lsAddAccount[2]} register NOT opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#########################################################################################################
[ ] 
[ ] 
