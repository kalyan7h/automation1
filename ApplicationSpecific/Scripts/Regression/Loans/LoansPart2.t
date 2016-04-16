[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<Loans.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Bill Management test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	  DEAN PAES
	[ ] //
	[ ] // Developed on: 
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 May 22, 2013	Dean Paes  Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] 
[+] // Global variables 
	[ ] 
	[ ] 
	[ ] //--------------EXCEL DATA----------------
	[ ] // .xls file
	[ ] public STRING sLoansDataExcelSheet="Loans_TestData"
	[ ] //Excel Sheets
	[ ] public STRING sBankingAccountSheet="Banking Accounts"
	[ ] public STRING sManualLoanSheet="Manual Loan Accounts"
	[ ] public STRING sPaymentScheduleSheet="Payment Schedule"
	[ ] public STRING sMinimalViewSheet="Minimal View Online Account"
	[ ] public STRING sSplitReminderCategory="Reminder Split Category"
	[ ] public STRING sLoanDetails="Loan Details"
	[ ] public STRING sAssetAccountSheet="Asset Account"
	[ ] public STRING sConversionSheet="Conversion"
	[ ] public STRING sConversionAccountsSheet="Conversion Accounts"
	[ ] public STRING sLoanAccountTypeSheet="Loan Account Type Conversion"
	[ ] 
	[ ] public STRING sOtherManualLoanSheet="Other Manual Accounts"
	[ ] 
	[ ] 
	[ ] //public STRING sLoansDataExcelSheet="LoanTestData"
	[ ] public STRING sLoanAccountWorksheet = "LoanAccount"
	[ ] public STRING sFIDataWorksheet = "FIData"
	[ ] public STRING sOnlineLoanDetailsStep1Worksheet ="OnlineLoanDetailsStep1"
	[ ] //public STRING sOnlineLoanAccountWorksheet ="OnlineLoanAccount"
	[ ] public STRING sManualLoanAccountWorksheet ="Manual Loan Accounts 2"
	[ ] public STRING sCategoryLoanPayment ="Loan Payment"
	[ ] 
	[ ] 
	[ ] public STRING sBankName="CCBank"
	[ ] public STRING sCCBankUserName="User"
	[ ] public STRING sCCBankPassword="Password"
	[ ] 
	[ ] 
	[ ] public STRING sOnlineLoansDataFileName ="OnlineLoanDataFile"
	[ ] public STRING sRegAccountWorksheet = "RegAccount"
	[ ] public STRING sSuperregisterTransacion = "SuperregisterTransacion"
	[ ] public STRING sReminderWorksheet = "Reminder"
	[ ] 
	[ ] 
	[ ] //public STRING sLoanSheet="Loan Account"
	[ ] public STRING sLoanAccSheet="AllAccounts"
	[ ] //public STRING sLoanDetailsSheet="Online Account Details"
	[ ] 
	[ ] public STRING sAssetSheet="Asset Loan"
	[ ] public STRING sPaidOffSheet="Paid Off Details"
	[ ] 
	[ ] 
	[ ] 
	[ ] //----------DATA FILES -------------------
	[ ] public STRING sLoansDataFile = AUT_DATAFILE_PATH + "\" + sLoansDataFileName + ".QDF"
	[ ] public STRING sOnlineLoansDataSource = AUT_DATAFILE_PATH + "\DataFile\" + sOnlineLoansDataFileName + ".QDF"
	[ ] public STRING sOnlineLoansDataFile = AUT_DATAFILE_PATH + "\" + sOnlineLoansDataFileName + ".QDF"
	[ ] 
	[ ] 
	[ ] 
	[ ] //----------STRING-------------------
	[ ] public STRING sLoansDataFileName="Loans_DataFile"
	[ ] public STRING sDateFormat="mm/dd/yyyy"
	[ ] public STRING sDate=ModifyDate(0,sDateFormat)
	[ ] public STRING sMDIWindow="MDI"
	[ ] public STRING sDeleteAction="Delete"
	[ ] public STRING sAddAction="Add"
	[ ] 
	[ ] public STRING sSwitchOn="ON"
	[ ] 
	[ ] 
	[ ] public STRING sActual , sCurrentBalance , sAccountName , sMonthlypayment , sReminderMonthlyPayment  ,sPayeeName ,sReminderType ,sAction ,sActualDueNextOn
	[ ] public STRING sExpectedPayment ,sExpectedCaption ,sCaption ,sHandle,sYear ,sDay ,sMonth ,sCaptionText,sAccount
	[ ] 
	[ ] 
	[ ] 
	[ ] //------------------NUMBER----------------
	[ ] public NUMBER nMonthlypayment
	[ ] 
	[ ] 
	[ ] //----------DATA FILE LOCATION -----------------
	[ ] public STRING sLoanDataFolder="Loans_Data_Files"
	[ ] public STRING sTestDataPath=AUT_DATAFILE_PATH
	[ ] 
	[ ] 
	[ ] //---------LIST OF STRING-----------
	[ ] public LIST OF STRING lsAddAccount,lsAddLoanAccount,lsPaymentSchedule,lsFileData ,lsTransaction,lsEditLoanAccount,lsTransactionData
	[ ] public LIST OF STRING lsLinkedAccounts={"House","Car","Asset"}
	[ ] 
	[ ] //---------LIST OF ANYTYPE-----------
	[ ] public LIST OF ANYTYPE lsExcelData ,lsAccount , IsFIData ,lsLoanData1 ,lsLoanData2 ,lsReminderData
	[ ] 
	[ ] 
	[ ] 
	[ ] //------------------INTEGER----------------
	[ ] 
	[ ] public INTEGER iValidate ,iResult , iCount ,iCounter
	[ ] 
	[ ] public INTEGER i,j,k , iActualCount ,iListCount ,iEdit
	[ ] 
	[ ] public INTEGER iSelectDate ,iYear, iSelect
	[ ] 
	[ ] 
	[ ] //--------------BOOLEAN---------------
	[ ] public BOOLEAN bMatch
	[ ] public BOOLEAN bDeleteTrue
	[ ] public BOOLEAN bResult
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //Local Functions
	[ ] 
	[ ] // ==========================================================
	[+] // FUNCTION: AddSingleAccountFromFI()
		[ ] //
		[ ] // DESCRIPTION:			
		[ ] // This function will select a single account from Add Any Account window from an online FI
		[ ] //
		[ ] // PARAMETERS:			STRING  	sAccountName		E.g. My Savings XX2222    
		[ ] //
		[ ] // RETURNS:				INTEGER	PASS	If a single account is selected from Add Any Account window from an online FI
		[ ] //										FAIL	In case of any error
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  Jan 20th 2014
	[ ] // ==========================================================
	[+] public INTEGER AddSingleAccountFromFI(STRING sAccountName)
		[ ] 
		[ ] 
		[ ] //Variable declaration
		[ ] BOOLEAN bMatch
		[ ] BOOLEAN bAccountFlag=FALSE
		[ ] INTEGER j=2
		[ ] STRING sHandle,sActual
		[ ] 
		[ ] 
		[+] do
			[ ] 
			[ ] 
			[+] if(AddAnyAccount.Exists(5))
				[ ] 
				[ ] AddAnyAccount.SetActive()
				[ ] 
				[+] while(j<AddAnyAccount.ListBox.GetItemCount())
					[ ] 
					[ ] 
					[ ] sHandle=Str(AddAnyAccount.ListBox.GetHandle())
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,str(j-1))
					[ ] 
					[ ] bMatch=MatchStr("*{sAccountName}*",sActual)
					[+] if(bMatch==FALSE)
						[ ] 
						[ ] AddAnyAccount.SetActive()
						[ ] AddAnyAccount.ListBox.Select(j)
						[ ] 
						[+] if(AddAnyAccount.IgnoreMenuItem.Exists(5))
							[ ] AddAnyAccount.IgnoreMenuItem.Pick()
							[ ] 
						[+] else
							[ ] iFunctionResult=FAIL
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] 
						[ ] AddAnyAccount.SetActive()
						[ ] AddAnyAccount.ListBox.Select(j)
						[ ] 
						[+] if(AddAnyAccount.AddMenuItem.Exists(5))
							[ ] AddAnyAccount.AddMenuItem.Pick()
							[ ] 
						[+] else
							[ ] iFunctionResult=FAIL
							[ ] 
						[ ] 
						[ ] bAccountFlag=TRUE
						[ ] 
					[ ] 
					[ ] 
					[ ] // Increment value of j by 2
					[ ] j=j+2
					[ ] 
					[ ] 
				[ ] 
				[+] if(bAccountFlag==FALSE)
					[ ] ReportStatus("Verify Account is found in Add any account window",FAIL,"Account not found in Add an account window")
					[ ] iFunctionResult=FAIL
					[ ] 
					[ ] 
				[+] else
					[ ] iFunctionResult=PASS
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Add any account window is displayed",FAIL,"Add an account window is not displayed")
				[ ] iFunctionResult=FAIL
				[ ] 
			[ ] 
			[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] iFunctionResult=FAIL
			[ ] 
			[ ] 
			[ ] 
		[ ] return iFunctionResult
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] // ==========================================================
	[+] // FUNCTION: VerifyLoanDetailsWindowUI()
		[ ] //
		[ ] // DESCRIPTION:			
		[ ] // This function will select a single account from Add Any Account window from an online FI
		[ ] //
		[ ] // PARAMETERS:			STRING  	sAccountName		E.g. My Savings XX2222    
		[ ] //
		[ ] // RETURNS:				INTEGER	PASS	If a single account is selected from Add Any Account window from an online FI
		[ ] //										FAIL	In case of any error
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  Jan 20th 2014
	[ ] // ==========================================================
	[+] public INTEGER VerifyLoanDetailsWindowUI()
		[ ] 
		[ ] 
		[+] do
			[ ] 
			[ ] 
			[ ] //----------------Navigate to Loan details window-----------------
			[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
				[ ] 
				[ ] AddAnyAccount.SetActive()
				[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
				[ ] 
				[ ] //---------------------Add Loan Details---------------------------------
				[+] if(LoanDetails.Exists(5))
					[ ] 
					[ ] //Loan Name
					[+] if(LoanDetails.LoanNameTextField.Exists(2))
						[ ] // ReportStatus("Verify Loan Name Text field",PASS,"Loan name text field found")
						[ ] 
						[ ] 
						[+] if(LoanDetails.LoanTypePopupList.Exists(2))
							[ ] // ReportStatus("Verify Loan Type Popuplist",PASS,"Loan type popup list  found")
							[ ] 
							[ ] 
							[ ] //Opening Date
							[+] if(LoanDetails.OpeningDateTextField.Exists(2))
								[ ] // ReportStatus("Verify Opening Date Text field",PASS,"Opening Date text field found")
								[ ] 
								[ ] //Original Balance
								[+] if(LoanDetails.OriginalBalanceTextField.Exists(2))
									[ ] // ReportStatus("Verify Original Balance Text Field",PASS,"Original Balance Text Field found")
									[ ] 
									[ ] 
									[ ] //Current Interest Rate
									[+] if(LoanDetails.CurrentInterestRateTextField.Exists(2))
										[ ] // ReportStatus("Verify Current Interest Rate Text Field",PASS,"Current Interest Rate Text Field found")
										[ ] 
										[ ] 
										[ ] //Original Length Rate
										[+] if(LoanDetails.OriginalLengthTextField.Exists(2))
											[ ] // ReportStatus("Verify Original Length Text Field",PASS,"Original Length Text Field found")
											[ ] iFunctionResult=PASS
											[ ] 
										[+] else
											[ ] ReportStatus("Verify Original Length Text Field",FAIL,"Original Length Text Field not found")
											[ ] iFunctionResult=FAIL
											[ ] 
											[ ] 
										[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Current Interest Rate Text Field",FAIL,"Current Interest Rate Text Field not found")
										[ ] iFunctionResult=FAIL
										[ ] 
										[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Original Balance Text Field",FAIL,"Original Balance Text Field not found")
									[ ] iFunctionResult=FAIL
									[ ] 
									[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Opening Date Text field",FAIL,"Opening Date text field not found")
								[ ] iFunctionResult=FAIL
								[ ] 
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Loan Type Popuplist",FAIL,"Loan type popup list not found")
							[ ] iFunctionResult=FAIL
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Loan Name Text field",FAIL,"Loan name text field not found")
						[ ] iFunctionResult=FAIL
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify loan details window open",FAIL,"Loan details window did not open")
					[ ] iFunctionResult=FAIL
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Account window open",FAIL,"Add Account window did not open")
				[ ] iFunctionResult=FAIL
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] iFunctionResult=FAIL
			[ ] 
			[ ] 
			[ ] 
		[ ] return iFunctionResult
		[ ] 
		[ ] 
	[ ] 
	[ ] // ==========================================================
	[+] // FUNCTION: QuickenRestoreAndResize()
		[ ] //
		[ ] // DESCRIPTION:			
		[ ] // This function will restore and resize the Quicken to handle PaymentDetails issue on resolution greater than 1024x768
		[ ] //
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  Nov 28th 2014
		[ ] ///Mukesh
	[ ] // ==========================================================
	[ ] 
	[+] public VOID QuickenRestoreAndResize()
		[+] do
			[ ] ///To handle the payment details issue
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Restore()
			[ ] sleep(2)
			[ ] QuickenWindow.Maximize()
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] // Click on Full Payment Schedule button
			[ ] MDIClientLoans.LoanWindow.HScrollBar.ScrollToMax()
		[+] except
			[ ] 
		[ ] 
	[ ] 
[ ] 
[ ] // 
[ ] // 
[ ] 
[ ] 
[ ] // ===========================================================================================
[ ] // =================================  Loans Debt Module ===========================================
[ ] // ===========================================================================================
[ ] 
[ ] 
[ ] 
[+] //##########  Verify that calculation for Interest Paid and Pricipal Paid on Debt is displayed only when a payment is done from Bills tab.  #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TestDebt1_VerifyThatCalculationForInterestPaidOnDebtIsDisplayedOnlyWhenAPaymentIsDoneFromBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that calculation for Interest Paid and Pricipal Paid on Debt is displayed only when a payment is done from Bills tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If calculation for Interest Paid and Pricipal Paid on Debt is displayed only when a payment is done from Bills tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 10, 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase TestDebt1_VerifyThatCalculationForInterestAndPrincipalPaidOnDebtIsDisplayedOnlyWhenAPaymentIsDoneFromBillsTab() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] NUMBER nPrincipalPaid , nOriginalBal 
		[ ] INTEGER iSelectDate ,iYear
		[ ] 
		[ ] STRING sAction , sInterestPaid , sPrincipalPaid ,sValZero ,sOriginalBal ,sYear ,sDay ,sMonth
		[ ] NUMBER nInterestPaid 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sManualLoanAccountWorksheet)
		[ ] lsAccount = lsExcelData[1]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] sValZero= "0.00"
		[ ] //Interest Paid
		[ ] sInterestPaid =lsAccount[8]
		[ ] nInterestPaid = VAL(sInterestPaid)
		[ ] sInterestPaid = trim( Str(nInterestPaid , 4 ,2))
		[ ] 
		[ ] //Principal Paid
		[ ] sPrincipalPaid =lsAccount[9]
		[ ] nPrincipalPaid = VAL(sPrincipalPaid)
		[ ] sPrincipalPaid = trim( Str(nPrincipalPaid , 4 ,2))
		[ ] 
		[ ] 
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sAction = "Add"
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sRegAccountWorksheet)
		[ ] lsAddAccount = lsExcelData[1]
		[ ] 
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
		[ ] 
	[ ] 
	[ ] //Open Data file 
	[ ] iResult=DataFileCreate(sOnlineLoansDataFileName)
	[+] if(iResult==PASS)
		[ ] ReportStatus("Create Data File",PASS,"Data File: {sOnlineLoansDataFileName} created successfully")
		[ ] 
		[ ] iResult= AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[+] if(iResult==PASS)
			[ ] iResult =AddEditManualLoanAccount(sAction, sAccountName ,sDate ,lsAccount[3] ,lsAccount[4] ,lsAccount[5] ,lsAccount[6])
			[ ] //Add Loan account
			[+] if(iResult==PASS)
				[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account: {sAccountName} is added")
				[ ] 
				[ ] DeSelectCustomizeViewItems()
				[ ] SelectCustomizeViewItems("Loan Summary")
				[ ] SelectCustomizeViewItems("Net Worth")
				[ ] SelectCustomizeViewItems("Property and Debt Accounts")
				[ ] 
				[ ] // /Navigate to Property & Debt > Debt
				[ ] // Verify Interest Paid and Pricipal Paid are not calculated Debt tab for that Loan account untill reminder is not entered.
				[ ] iResult=NavigateQuickenTab(sTAB_PROPERTY_DEBT ,sTAB_DEBT)
				[+] if(iResult==PASS)
					[ ] //Verify Interest Paid and Pricipal Paid are not calculated Debt tab for that Loan account untill reminder is not entered.
					[ ] QuickenWindow.SetActive()
					[ ] sHandle= Str(MDIClientLoans.LoanWindow.DebtAccountsCurrentValueListBox.GetHandle())
					[ ] iListCount= MDIClientLoans.LoanWindow.DebtAccountsCurrentValueListBox.GetItemCount() +1
					[+] for(iCount= 0; iCount <=iListCount;  iCount++)
						[ ] 
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] print(sActual)
						[ ] bMatch =MatchStr("*{sAccountName}*{sPrincipalPaid}*{sInterestPaid}*", sActual)
						[+] if (bMatch)
							[ ] break
					[ ] 
					[+] if (bMatch)
						[ ] ReportStatus("Verify Interest Paid and Pricipal Paid are not calculated on Debt tab for that Loan account untill reminder is not entered" , FAIL , "Interest Paid and Pricipal Paid are calculated as:{sActual} on Debt tab for that Loan without entering the Loan reminder.")
					[+] else
						[ ] ReportStatus("Verify Interest Paid and Pricipal Paid are not calculated on Debt tab for that Loan account untill reminder is not entered" , PASS , " Interest Paid and Pricipal Paid are not calculated on Debt tab for that Loan account when reminder is not entered.")
				[+] else
					[ ] ReportStatus("Verify the  Property & Debt > Debt ", FAIL, " Quicken didn't go to  Property & Debt > Debt")
				[ ] 
				[ ] iResult = SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
				[+] if(iResult==PASS)
					[ ] QuickenWindow.SetActive()
					[ ] sOriginalBal =MDIClientLoans.LoanWindow.LoanBalanceAmount.GetCaption()
					[ ] iResult =NavigateQuickenTab(sTAB_HOME)
					[ ] 
					[ ] /// These listboxes are identified on indexes may fail if index changes
					[ ] ////Verify Original Balance is calculated on Home> Net Worth snapshot for that Loan account when reminder is NOT entered.
					[+] if(iResult==PASS)
						[ ] sHandle= Str(MDIClient.Home.NetWorthListBox.GetHandle())
						[ ] iListCount = MDIClient.Home.NetWorthListBox.GetItemCount() +1
						[+] for(iCount= 0; iCount <=iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] print(sActual)
							[ ] bMatch =MatchStr("*{sOriginalBal}*", sActual)
							[+] if (bMatch)
								[ ] break
						[+] if (bMatch)
							[ ] ReportStatus("Verify Original Balance is calculated on Home tab > Net Worth for that Loan account when reminder is NOT entered" , PASS , "OriginalBalnce l: {sActual} is calculated on Home tab > Net Worth for that Loan account when reminder is NOT entered.")
						[+] else
							[ ] ReportStatus("Verify Original Balance is calculated on Home tab > Net Worth for that Loan account when reminder is NOT entered." , FAIL , "OriginalBalnce actual: {sActual} is not as expected OriginalBal :{sOriginalBal} on Home> Net Worth Accounts snapshot for that Loan without entering the Loan reminder.")
					[+] else
						[ ] ReportStatus("Verify the Home tab.", FAIL, " Quicken didn't go to Home tab.")
					[ ] 
					[ ] 
					[ ] ////Verify Interest Paid and Pricipal Paid are calculated on Home> Loan Summary snapshot for that Loan account when reminder is NOT entered.
					[+] if(iResult==PASS)
						[ ] sHandle= Str(MDIClient.Home.LoanSummaryListBox.GetHandle())
						[ ] iListCount = MDIClient.Home.LoanSummaryListBox.GetItemCount() +1
						[+] for(iCount= 0; iCount <=iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] print(sActual)
							[ ] bMatch =MatchStr("*{sAccountName}*{sValZero}*{sValZero}*", sActual)
							[+] if (bMatch)
								[ ] break
						[+] if (bMatch)
							[ ] ReportStatus("Verify Interest Paid and Pricipal Paid are calculated on Home tab > Loan Summary for that Loan account when reminder is NOT entered" , PASS , " Interest Paid: {sActual} is calculated on Home tab > Loan Summary for that Loan account when reminder is NOT entered.")
						[+] else
							[ ] 
							[ ] ReportStatus("Verify Interest Paid and Pricipal Paid are calculated on Home tab > Loan Summary for that Loan account when reminder is NOT entered." , FAIL , "Interest Paid and Pricipal Paid calculated actual: {sActual} is not as expected Interest Paid: {sInterestPaid} and PrincipalPaid: {sPrincipalPaid} on Home tab > Loan Summary for that Loan without entering the Loan reminder.")
					[+] else
						[ ] ReportStatus("Verify the Home tab.", FAIL, " Quicken didn't go to Home tab.")
					[ ] 
					[ ] ////Verify Interest Paid and Pricipal Paid are calculated on Home> Property & Debt Accounts snapshot for that Loan account when reminder is NOT entered.
					[+] if(iResult==PASS)
						[ ] sHandle= Str(MDIClient.Home.PropertyDebtAccountsListBox.GetHandle())
						[ ] iListCount = MDIClient.Home.PropertyDebtAccountsListBox.GetItemCount() +1
						[+] for(iCount= 0; iCount <=iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] print(sActual)
							[ ] bMatch =MatchStr("*{sAccountName}*{sOriginalBal}*", sActual)
							[+] if (bMatch)
								[ ] break
						[+] if (bMatch)
							[ ] ReportStatus("Verify Original Balance is calculated on Home tab > Property & Debt for that Loan account when reminder is NOT entered" , PASS , "OriginalBalnce l: {sActual} is calculated on Home tab > Property & Debt for that Loan account when reminder isNOT  entered.")
						[+] else
							[ ] ReportStatus("Verify Original Balance is calculated on Home tab > Property & Debt for that Loan account when reminder is NOT entered." , FAIL , "OriginalBalnce actual: {sActual} is not as expected OriginalBal :{sOriginalBal} on Home> Property & Debt Accounts snapshot for that Loan without entering the Loan reminder.")
					[+] else
						[ ] ReportStatus("Verify the Home tab.", FAIL, " Quicken didn't go to Home tab.")
					[ ] 
					[ ] //Enter the loan reminder from bills tab
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] iResult=NavigateQuickenTab(sTAB_BILL, sTAB_UPCOMING)
					[ ] //Enter the transaction
					[+] if (iResult == PASS)
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Bills.ViewAsPopupList.Select("Stack")
						[ ] MDIClient.Bills.DueWithinNextPopupList.Select("30 Days")
						[ ] MDIClient.Bills.Enter.Click()
						[+] if(EnterExpenseIncomeTxn.Exists(5))
							[ ] EnterExpenseIncomeTxn.SetActive()
							[ ] EnterExpenseIncomeTxn.EnterTransactionButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[ ] iResult=FindTransactionsInRegister(sCategoryLoanPayment)
							[+] if (iResult == PASS)
								[ ] ReportStatus(" Verify that a user should be able to Enter the Simple Reminder on Bills tab . ", PASS , "Loan reminder entered from checking register to Loan Account: {sAccountName} .")
								[ ] 
								[ ] //Verify Interest Paid and Pricipal Paid are calculated Debt on tab for that Loan account when reminder is entered.
								[ ] iResult=NavigateQuickenTab(sTAB_PROPERTY_DEBT ,sTAB_DEBT)
								[+] if(iResult==PASS)
									[ ] 
									[ ] //Verify Interest Paid and Pricipal Paid are calculated Debt on tab for that Loan account when reminder is entered.
									[ ] QuickenWindow.SetActive()
									[ ] sHandle= Str(MDIClientLoans.LoanWindow.DebtAccountsQWListViewer.DebtAccountsCurrentValueListBox.GetHandle())
									[ ] iListCount= MDIClientLoans.LoanWindow.DebtAccountsQWListViewer.DebtAccountsCurrentValueListBox.GetItemCount() +1
									[+] for(iCount= 0; iCount <=iListCount;  iCount++)
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
										[ ] print(sActual)
										[ ] bMatch = MatchStr("*{sAccountName}*{sPrincipalPaid}*{sInterestPaid}*", sActual)
										[+] if (bMatch)
											[ ] break
									[ ] 
									[+] if (bMatch)
										[ ] ReportStatus("Verify Interest Paid and Pricipal Paid are calculated on Debt tab for that Loan account when reminder is entered" , PASS , " Interest Paid and Pricipal Paid: {sActual} calculated as expected on Debt tab for that Loan account when reminder is entered.")
									[+] else
										[ ] 
										[ ] ReportStatus("Verify Interest Paid and Pricipal Paid are calculated Debt on tab for that Loan account when reminder is entered." , FAIL , "Interest Paid and Pricipal Paid calculated actual: {sActual} is not as expected InterestPaid: {sInterestPaid} ,PrincipalPaid: {sPrincipalPaid} on Debt tab for that Loan after entering the Loan reminder.")
								[+] else
									[ ] ReportStatus("Verify the  Property & Debt > Debt ", FAIL, " Quicken didn't go to  Property & Debt > Debt")
								[ ] 
								[ ] //Verify that Interest Paid amount displayed on Full Payment is same as that displayed on Debt tab Interest Paid column.
								[ ] sleep(2)
								[ ] QuickenWindow.SetActive()
								[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
								[+] if (iResult==PASS)
									[ ] sleep(2)
									[ ] QuickenWindow.SetActive()
									[ ] //Click on Payment Details tab
									[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
									[ ] ///To handle the payment details issue
									[ ]  QuickenRestoreAndResize()
									[+] if(MDIClientLoans.LoanWindow.PaymentDetailsPanel.FullPaymentButton.Exists(3))
										[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.FullPaymentButton.Click()
										[+] if(DlgLoanSchedule.Exists(3))
											[ ] DlgLoanSchedule.SetActive()
											[ ] //Verify payment in full payment schedule
											[ ] sHandle=Str(PaymentDetailsListBox.GetHandle())
											[ ] iListCount=PaymentDetailsListBox.GetItemCount()
											[+] for(iCount= 0; iCount <=iListCount;  iCount++)
												[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
												[ ] print(sActual)
												[ ] bMatch =MatchStr("*{sPrincipalPaid}*{sInterestPaid}*", sActual)
												[+] if (bMatch)
													[ ] break
											[ ] 
											[+] if (bMatch)
												[ ] ReportStatus("Verify Interest Paid and Pricipal Paid are calculated on Full Payment Schedule for that Loan account when reminder is entered" , PASS , " Interest Paid and Pricipal Paid calculated:{sActual}  as expected Interest Paid: {sInterestPaid} and {nPrincipalPaid } on Full Payment Schedule for that Loan account when reminder is entered.")
											[+] else
												[ ] 
												[ ] ReportStatus("Verify Interest Paid and Pricipal Paid are calculated on Full Payment Schedule on tab for that Loan account when reminder is entered." , FAIL , "Interest Paid and Pricipal Paid calculated actual: {sActual} is not as expected:{sInterestPaid} and {nPrincipalPaid } on Full Payment Schedule for that Loan after entering the Loan reminder.")
												[ ] 
											[ ] DlgLoanSchedule.DoneButton.Click()
											[ ] WaitForState(DlgLoanSchedule,FALSE,5)
										[+] else
											[ ] ReportStatus("Verify Loan Schedule window",FAIL,"Loan Schedule window is not displayed")
											[ ] 
									[+] else
										[ ] ReportStatus("Verify Full Payment Schedule button",FAIL,"Full Payment Schedule button is not displayed")
								[+] else
									[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus(" Verify Interest Paid and Pricipal Paid are calculated Debt on tab for that Loan account when reminder is entered. ", FAIL , "Loan reminder entered, couldn't be found in checking register.")
								[ ] 
						[+] else
							[ ] ReportStatus("Verify that Edit Loan Payment Reminder dialog. ", FAIL , "Edit Loan Payment Reminder dialog didn't appear.")
							[ ] 
						[ ] //handle the fail condition
						[+] if(DlgAddEditReminder.Exists(5))
							[ ] DlgAddEditReminder.SetActive()
							[ ] DlgAddEditReminder.CancelButton.Click()
							[ ] WaitForState(DlgAddEditReminder , false ,5)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Bills tab. ", FAIL , " Bills tab didn't display.") 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Add Manual loan account",FAIL,"Manual loan account not added")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Add {lsAddAccount[2]} account",FAIL,"Account: {lsAddAccount[2]} account couln't be added.")
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File : {sOnlineLoansDataFileName} could not be created.")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //########## Verify that the Interest Paid and Pricipal Paid amount is same on Home and property & debt ->debt tab .  #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TestDebt2_VerifythatTheInterestPaidAmountIsSameOnHomeAndDebtTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that the Interest paid amount is same on Home and property & debt ->debt tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If calculation for Interest paid amount is same on Home and property & debt ->debt tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 10, 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase TestDebt2_VerifythatTheInterestAndPrincipalPaidAmountIsSameOnHomeAndDebtTab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] ////Read sLoanAccountWorksheet 
		[ ] STRING sAction , sInterestPaid , sPrincipalPaid ,sOriginalBal 
		[ ] NUMBER nInterestPaid ,nPrincipalPaid ,nOriginalBal
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sManualLoanAccountWorksheet)
		[ ] lsAccount = lsExcelData[1]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sRegAccountWorksheet)
		[ ] lsAddAccount = lsExcelData[1]
		[ ] 
		[ ] 
		[ ] //Interest Paid
		[ ] sInterestPaid =lsAccount[8]
		[ ] nInterestPaid = VAL(sInterestPaid)
		[ ] sInterestPaid = trim( Str(nInterestPaid , 4 ,2))
		[ ] 
		[ ] //Principal Paid
		[ ] sPrincipalPaid =lsAccount[9]
		[ ] nPrincipalPaid = VAL(sPrincipalPaid)
		[ ] sPrincipalPaid = trim( Str(nPrincipalPaid , 4 ,2))
		[ ] 
		[ ] //Orginal Balance 
		[ ] sOriginalBal =lsAccount[3]
		[ ] nOriginalBal = VAL(sOriginalBal)
		[ ] sOriginalBal = trim( Str(nOriginalBal , 4 ,2))
		[ ] 
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] 
		[ ] 
		[ ] 
		[ ] sAction = "Add"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Verify Interest Paid and Pricipal Paid are calculated Debt on tab for that Loan account when reminder is entered.
		[ ] iResult=NavigateQuickenTab(sTAB_PROPERTY_DEBT ,sTAB_DEBT)
		[+] if(iResult==PASS)
			[ ] 
			[ ] //Verify Interest Paid and Pricipal Paid are calculated Debt on tab for that Loan account when reminder is entered.
			[ ] QuickenWindow.SetActive()
			[ ] // sHandle= Str(MDIClientLoans.LoanWindow.DebtAccountsCurrentValueListBox.GetHandle())
			[ ] // iListCount= MDIClientLoans.LoanWindow.DebtAccountsCurrentValueListBox.GetItemCount() +1
			[ ] sHandle= Str(MDIClientLoans.LoanWindow.DebtAccountsQWListViewer.DebtAccountsCurrentValueListBox.GetHandle())
			[ ] iListCount= MDIClientLoans.LoanWindow.DebtAccountsQWListViewer.DebtAccountsCurrentValueListBox.GetItemCount() +1
			[+] for(iCount= 0; iCount <=iListCount;  iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch =MatchStr("*{sAccountName}*{sPrincipalPaid}*{sInterestPaid}*", sActual)
				[+] if (bMatch)
					[ ] break
			[ ] 
			[+] if (bMatch)
				[ ] ReportStatus("Verify Interest Paid and Pricipal Paid are calculated on Debt tab for that Loan account when reminder is entered" , PASS , " Interest Paid and Pricipal Paid: {nPrincipalPaid }  calculated on Debt tab for that Loan account when reminder is entered.")
			[+] else
				[ ] 
				[ ] ReportStatus("Verify Interest Paid and Pricipal Paid are calculated Debt on tab for that Loan account when reminder is entered." , FAIL , "Interest Paid and Pricipal Paid calculated actual: {sActual} is not as expected I Interest Paid: {sInterestPaid} and PrincipalPaid: {sPrincipalPaid} on Debt tab for that Loan after entering the Loan reminder.")
		[+] else
			[ ] ReportStatus("Verify the  Property & Debt > Debt ", FAIL, " Quicken didn't go to  Property & Debt > Debt")
		[ ] 
		[ ] SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
		[ ] sOriginalBal =MDIClientLoans.LoanWindow.LoanBalanceAmount.GetCaption()
		[ ] iResult =NavigateQuickenTab(sTAB_HOME)
		[ ] ////Verify Interest Paid and Pricipal Paid are calculated on Home> Net Worth snapshot for that Loan account when reminder is entered.
		[+] if(iResult==PASS)
			[ ] sHandle= Str(MDIClient.Home.NetWorthListBox.GetHandle())
			[ ] iListCount = MDIClient.Home.NetWorthListBox.GetItemCount() +1
			[+] for(iCount= 0; iCount <=iListCount;  iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch =MatchStr("*{sOriginalBal}*", sActual)
				[+] if (bMatch)
					[ ] break
			[+] if (bMatch)
				[ ] ReportStatus("Verify Original Balance is calculated on Home tab > Net Worth for that Loan account when reminder is entered" , PASS , "OriginalBalnce l: {sActual} is calculated on Home tab > Net Worth for that Loan account when reminder is entered.")
			[+] else
				[ ] ReportStatus("Verify Original Balance is calculated on Home tab > Net Worth for that Loan account when reminder is entered." , FAIL , "OriginalBalnce actual: {sActual} is not as expected OriginalBal :{sOriginalBal} on Home> Net Worth Accounts snapshot for that Loan after entering the Loan reminder.")
		[+] else
			[ ] ReportStatus("Verify the Home tab.", FAIL, " Quicken didn't go to Home tab.")
		[ ] 
		[ ] 
		[ ] ////Verify Interest Paid and Pricipal Paid are calculated on Home> Loan Summary snapshot for that Loan account when reminder is entered.
		[+] if(iResult==PASS)
			[ ] sHandle= Str(MDIClient.Home.LoanSummaryListBox.GetHandle())
			[ ] iListCount = MDIClient.Home.LoanSummaryListBox.GetItemCount() +1
			[+] for(iCount= 0; iCount <=iListCount;  iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch =MatchStr("*{sAccountName}*{sPrincipalPaid}*{sInterestPaid}*", sActual)
				[+] if (bMatch)
					[ ] break
			[+] if (bMatch)
				[ ] ReportStatus("Verify Interest Paid and Pricipal Paid are calculated on Home tab > Loan Summary for that Loan account when reminder is entered" , PASS , " Interest Paid: {sActual} is calculated on Home tab > Loan Summary for that Loan account when reminder is entered.")
			[+] else
				[ ] 
				[ ] ReportStatus("Verify Interest Paid and Pricipal Paid are calculated on Home tab > Loan Summary for that Loan account when reminder is entered." , FAIL , "Interest Paid and Pricipal Paid calculated actual: {sActual} is not as expected Interest Paid: {sInterestPaid} and PrincipalPaid: {sPrincipalPaid} on Home tab > Loan Summary for that Loan after entering the Loan reminder.")
		[+] else
			[ ] ReportStatus("Verify the Home tab.", FAIL, " Quicken didn't go to Home tab.")
		[ ] 
		[ ] ////Verify Interest Paid and Pricipal Paid are calculated on Home> Property & Debt Accounts snapshot for that Loan account when reminder is entered.
		[+] if(iResult==PASS)
			[ ] sHandle= Str(MDIClient.Home.PropertyDebtAccountsListBox.GetHandle())
			[ ] iListCount = MDIClient.Home.PropertyDebtAccountsListBox.GetItemCount() +1
			[+] for(iCount= 0; iCount <=iListCount;  iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch =MatchStr("*{sAccountName}*{sOriginalBal}*", sActual)
				[+] if (bMatch)
					[ ] break
			[+] if (bMatch)
				[ ] ReportStatus("Verify Original Balance is calculated on Home tab > Property & Debt for that Loan account when reminder is entered" , PASS , "OriginalBalnce l: {sActual} is calculated on Home tab > Property & Debt for that Loan account when reminder is entered.")
			[+] else
				[ ] ReportStatus("Verify Original Balance is calculated on Home tab > Property & Debt for that Loan account when reminder is entered." , FAIL , "OriginalBalnce actual: {sActual} is not as expected OriginalBal :{sOriginalBal} on Home> Property & Debt Accounts snapshot for that Loan after entering the Loan reminder.")
		[+] else
			[ ] ReportStatus("Verify the Home tab.", FAIL, " Quicken didn't go to Home tab.")
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
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //########## Verify that Principal Paid Value is Original Loan Balance - Current Balance. .  #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TestDebt5_VerifyThatPrincipalPaidValueIsOriginalLoanBalanceMinusCurrent
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Principal Paid Value is Original Loan Balance - Current Balance. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Principal Paid Value is Original Loan Balance - Current Balance on Loan Summary and on Full Payment schedule
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 10, 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase TestDebt5_VerifyThatPrincipalPaidValueIsOriginalLoanBalanceMinusCurrentBalance() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] STRING sAction ,  sPrincipalPaid , sCurrentBal  , sOriginalBal ,sYear ,sDay ,sMonth
		[ ] NUMBER nPrincipalPaid ,nCurrentBal  , nOriginalBal 
		[ ] INTEGER iSelectDate ,iYear
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sManualLoanAccountWorksheet)
		[ ] lsAccount = lsExcelData[1]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] //Orginal Balance 
		[ ] sOriginalBal =lsAccount[3]
		[ ] nOriginalBal = VAL(sOriginalBal)
		[ ] 
		[ ] sAction = "Add"
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.SetActive()
			[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
			[+] if (iResult == PASS)
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive()
				[ ] //Calculate the Principal Paid Value is Original Loan Balance - Current Balance om Loan Account> Full payment schedule
				[ ] 
				[ ] sCurrentBal =StrTran(MDIClientLoans.LoanWindow.LoanBalanceAmount.GetCaption() , "," ,"")
				[ ] 
				[ ] nCurrentBal = VAL(sCurrentBal)
				[ ] 
				[ ] nPrincipalPaid =nOriginalBal - nCurrentBal
				[ ] 
				[ ] sPrincipalPaid = trim( Str(nPrincipalPaid , 4 ,2))
				[ ] 
				[ ] //Click on Payment Details tab
				[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
				[ ] ///To handle the payment details issue
				[ ]  QuickenRestoreAndResize()
				[+] if(MDIClientLoans.LoanWindow.PaymentDetailsPanel.PaymentPieChart.FullPaymentScheduleButton.Exists(3))
					[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.PaymentPieChart.FullPaymentScheduleButton.Click()
					[+] if(DlgLoanSchedule.Exists(3))
						[ ] DlgLoanSchedule.SetActive()
						[ ] //Verify payment in full payment schedule
						[ ] sHandle=Str(PaymentDetailsListBox.GetHandle())
						[ ] iListCount=PaymentDetailsListBox.GetItemCount()
						[+] for(iCount= 0; iCount <=iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch =MatchStr("*{sPrincipalPaid}*", sActual)
							[+] if (bMatch)
								[ ] break
						[ ] 
						[+] if (bMatch)
							[ ] ReportStatus("Verify that Principal Paid Value is Original Loan Balance - Current Balance on Full Payment Schedule" , PASS , "Principal Paid Value is: {sActual} Original Loan Balance: {sOriginalBal} - Current Balance: {sCurrentBal} on Full Payment Schedule")
						[+] else
							[ ] 
							[ ] ReportStatus("Verify that Principal Paid Value is Original Loan Balance - Current Balance on Full Payment Schedule." , FAIL , "Principal Paid Value is: {sActual} NOT Original Loan Balance: {sOriginalBal} - Current Balance: {sCurrentBal} on Full Payment Schedule")
							[ ] 
						[ ] DlgLoanSchedule.DoneButton.Click()
						[ ] WaitForState(DlgLoanSchedule,FALSE,5)
					[+] else
						[ ] ReportStatus("Verify Loan Schedule window",FAIL,"Loan Schedule window is not displayed")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Full Payment Schedule button",FAIL,"Full Payment Schedule button is not displayed")
				[ ] 
				[ ] 
				[ ] //Calculate the Principal Paid Value is Original Loan Balance - Current Balance om Home> Loan summary
				[ ] QuickenWindow.SetActive()
				[ ] iResult =NavigateQuickenTab(sTAB_HOME)
				[+] if(iResult==PASS)
					[ ] sHandle= Str(MDIClient.Home.LoanSummaryListBox.GetHandle())
					[ ] iListCount = MDIClient.Home.LoanSummaryListBox.GetItemCount() +1
					[+] for(iCount= 0; iCount <=iListCount;  iCount++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bMatch =MatchStr("*{sAccountName}*{sPrincipalPaid}*", sActual)
						[+] if (bMatch)
							[ ] break
					[+] if (bMatch)
						[ ] ReportStatus("Verify that Principal Paid Value is Original Loan Balance - Current Balance on Home >Loan summary." , PASS , "Principal Paid Value is: {sActual} Original Loan Balance: {sOriginalBal} - Current Balance: {sCurrentBal} on Home >Loan summary.")
					[+] else
						[ ] ReportStatus("Verify that Principal Paid Value is Original Loan Balance - Current Balance on Home >Loan summary." , FAIL , "Principal Paid Value is: {sActual} NOT Original Loan Balance: {sOriginalBal} - Current Balance: {sCurrentBal} on Home >Loan summary.")
						[ ] 
						[ ] 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify the Home tab.", FAIL, " Quicken didn't go to Home tab.")
			[+] else
				[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL, "Quicken does not exist. ") 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //##########Test7- Verify that if loan details are not entered by user then ADD button should be there in Principal Paid column in Debt tab and home->loan summary  #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test7_VerifyAddButtonInPrincipalPaidColumnOnDebtAnLoanSummary
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that if loan details are not entered by user then ADD button should be there in Principal Paid column in Debt tab and home->loan summary
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If ADD button is  there in Principal Paid column in Debt tab and home->loan summary
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 17 16 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test7_VerifyAddButtonInPrincipalPaidColumnOnDebtAndHomeTabLoanSummary() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING  sAddButton
		[ ] 
		[ ] 
		[ ] sAddButton = "Add"
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[1]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] if(FileExists(sOnlineLoansDataFile))
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.Kill()
		[ ] Waitforstate(QuickenWindow,False,5)
		[ ] DeleteFile(sOnlineLoansDataFile)
	[ ] SYS_CopyFile (sOnlineLoansDataSource,sOnlineLoansDataFile)
	[+] if(!QuickenWindow.Exists(5))
		[ ] App_Start(sCmdLine)
		[ ] sleep(5)
		[ ] WaitForState(QuickenWindow , true , 20)
	[ ] iResult=OpenDataFile(sOnlineLoansDataFileName)
	[ ] 
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] DeSelectCustomizeViewItems()
			[ ] SelectCustomizeViewItems("Loan Summary")
			[ ] 
			[ ] 
			[ ] ///Verify that if loan details are not entered by user then ADD button should be there in Principal Paid column in Home> Loan Summary
			[ ] QuickenWindow.SetActive()
			[ ] iResult =NavigateQuickenTab(sTAB_HOME)
			[+] if(iResult==PASS)
				[ ] QuickenWindow.SetActive()
				[ ] sHandle= Str(MDIClient.Home.LoanSummaryListBox.GetHandle())
				[ ] iListCount = MDIClient.Home.LoanSummaryListBox.GetItemCount() +1
				[+] for(iCount= 0; iCount <=iListCount;  iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch =MatchStr("*{sAccountName}*{sAddButton}*", sActual)
					[+] if (bMatch)
						[ ] 
						[ ] break
				[+] if (bMatch)
					[ ] ReportStatus("Verify that if loan details are not entered by user then ADD button should be there in Principal Paid column in Home> Loan Summary.", PASS, "ADD button is present in Principal Paid column as: {sActual} in Home> Loan Summary when loan details not entered.")
					[ ] QuickenWindow.SetActive()
					[ ] MDIClient.Home.LoanSummaryListBox.TextClick("Add")
					[+] if (MDIClientLoans.LoanWindow.AddLoanDetailsButton.Exists(5))
						[ ] ReportStatus("Verify that if loan details are not entered by user then ADD button should be there in Principal Paid column in Home> Loan Summary.", PASS, "Quicken navigated to Add Loan Details after clicking on Add button in  Principal Paid column in Home> Loan Summary when loan details not entered.")
					[+] else
						[ ] ReportStatus("Verify that if loan details are not entered by user then ADD button should be there in Principal Paid column in Home> Loan Summary.", FAIL, "Quicken didn't navigate to Add Loan Details after clicking on Add button in  Principal Paid column in Home> Loan Summary when loan details not entered.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that if loan details are not entered by user then ADD button should be there in Principal Paid column in Home> Loan Summary.", FAIL, "ADD button not present in Principal Paid column in Home> Loan Summary when loan details not entered, actual value of the coulms is: {sActual}.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify the Home tab.", FAIL, " Quicken didn't go to Home tab.")
			[ ] 
			[ ] 
			[ ] ///Verify that if loan details are not entered by user then ADD button should be there in Principal Paid column in Debt tab
			[ ] QuickenWindow.SetActive()
			[ ] iResult=NavigateQuickenTab(sTAB_PROPERTY_DEBT ,sTAB_DEBT)
			[+] if(iResult==PASS)
				[ ] QuickenWindow.SetActive()
				[ ] sHandle= Str(MDIClientLoans.LoanWindow.DebtAccountsCurrentValueListBox.GetHandle())
				[ ] iListCount= MDIClientLoans.LoanWindow.DebtAccountsCurrentValueListBox.GetItemCount() +1
				[+] for(iCount= 0; iCount <=iListCount;  iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch =MatchStr("*{sAccountName}*", sActual)
					[+] if (bMatch)
						[ ] break
				[+] if (bMatch)
					[ ] ReportStatus("Verify that if loan details are not entered by user then ADD button should be there in Principal Paid column in Property & Debt > Debt.", PASS, "ADD button is present in Principal Paid column as: {sActual} in Property & Debt > Debt when loan details not entered.")
					[ ] QuickenWindow.SetActive()
					[ ] MDIClientLoans.LoanWindow.DebtAccountsCurrentValueListBox2.TextClick("Add")
					[+] if (MDIClientLoans.LoanWindow.AddLoanDetailsButton.Exists(5))
						[ ] ReportStatus("Verify that if loan details are not entered by user then ADD button should be there in Principal Paid column in Property & Debt > Debt.", PASS, "Quicken navigated to Add Loan Details after clicking on Add button in  Principal Paid column in Property & Debt > Debt when loan details not entered.")
					[+] else
						[ ] ReportStatus("Verify that if loan details are not entered by user then ADD button should be there in Principal Paid column in Property & Debt > Debt.", FAIL, "Quicken didn't navigate to Add Loan Details after clicking on Add button in  Principal Paid column in Property & Debt > Debt when loan details not entered.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that if loan details are not entered by user then ADD button should be there in Principal Paid column in Property & Debt > Debt.", FAIL, "ADD button is not present in Principal Paid column in Property & Debt > Debt when loan details not entered, actual value of the coulms is: {sActual}.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify the  Property & Debt > Debt ", FAIL, " Quicken didn't go to Property & Debt > Debt")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sOnlineLoansDataFileName} couldn't be opened.")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //##########Test8- .Verify that interest paid column should have dash(-) for connected loan account when loan details are not entered #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test8_VerifyDashSingInInterestPaidColumnOnDebtAndHomeTabLoanSummary
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will .Verify that interest paid column should have dash(-) for connected loan account when loan details are not entered
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If interest paid column have dash(-) for connected loan account when loan details are not entered
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 17 16 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test8_VerifyDashSingInInterestPaidColumnOnDebtAndHomeTabLoanSummary() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING  sAddButton , sDashSign
		[ ] 
		[ ] 
		[ ] sAddButton = "Add"
		[ ] sDashSign ="-"
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[1]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] ///Verify that interest paid column should have dash(-) for connected loan account when loan details are not entered on Home> Loan Summary
		[ ] QuickenWindow.SetActive()
		[ ] iResult =NavigateQuickenTab(sTAB_HOME)
		[+] if(iResult==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] sHandle= Str(MDIClient.Home.LoanSummaryListBox.GetHandle())
			[ ] iListCount = MDIClient.Home.LoanSummaryListBox.GetItemCount() +1
			[+] for(iCount= 0; iCount <=iListCount;  iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch =MatchStr("*{sAccountName}*{sAddButton}*{sDashSign}*", sActual)
				[+] if (bMatch)
					[ ] break
			[+] if (bMatch)
				[ ] ReportStatus("Verify that interest paid column should have dash(-) for connected loan account when loan details are not entered on Home> Loan Summary.", PASS, "Dash (-) is present in Interest Paid column as: {sActual} in Home> Loan Summary when loan details are not entered.")
			[+] else
				[ ] ReportStatus("Verify that interest paid column should have dash(-) for connected loan account when loan details are not entered on Home> Loan Summary.", FAIL, "Dash (-) is NOT present in Interest Paid column in Home> Loan Summary when loan details are not entered, actual value of the coulms is: {sActual}.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify the Home tab.", FAIL, " Quicken didn't go to Home tab.")
		[ ] 
		[ ] 
		[ ] ///Verify that interest paid column should have dash(-) for connected loan account when loan details are not entered on Debt tab
		[ ] QuickenWindow.SetActive()
		[ ] iResult=NavigateQuickenTab(sTAB_PROPERTY_DEBT ,sTAB_DEBT)
		[+] if(iResult==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] sHandle= Str(MDIClientLoans.LoanWindow.DebtAccountsQWListViewer.DebtAccountsCurrentValueListBox.GetHandle())
			[ ] iListCount= MDIClientLoans.LoanWindow.DebtAccountsQWListViewer.DebtAccountsCurrentValueListBox.GetItemCount() +1
			[+] for(iCount= 0; iCount <=iListCount;  iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch =MatchStr("*{sAccountName}*{sAddButton}*{sDashSign}*", sActual)
				[+] if (bMatch)
					[ ] break
			[+] if (bMatch)
				[ ] ReportStatus("Verify that interest paid column should have dash(-) for connected loan account when loan details are not entered on  Property & Debt > Debt tab.", PASS, "Dash (-) is present in Interest Paid column as: {sActual} on Property & Debt > Debt tab when loan details are not entered.")
			[+] else
				[ ] ReportStatus("Verify that interest paid column should have dash(-) for connected loan account when loan details are not entered on Property & Debt > Debt tab.", FAIL, "Dash (-) is NOT present in Interest Paid column on Property & Debt > Debt tab when loan details are not entered, actual value of the coulms is: {sActual}.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify the  Property & Debt > Debt ", FAIL, " Quicken didn't go to Property & Debt > Debt")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] //===========================================================================================
[ ] //=================================  Loans Payment Details  =======================================
[ ] //===========================================================================================
[ ] 
[ ] 
[+] //##########Test 1 - Verify 'Payment Details (minimal)' screen should get launched. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test1_VerifyMinimalPaymentDetailsScreenShouldGetDisplayedForOnlineAccount
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 'Payment Details (minimal)' screen should get launched.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If 'Payment Details (minimal)' screen should get launched when loan details are not entered
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 17 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test1_VerifyMinimalPaymentDetailsScreenShouldGetDisplayedForOnlineAccount() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[1]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
		[+] if (iResult==PASS)
			[ ] QuickenWindow.SetActive()
			[+] if(MDIClientLoans.LoanWindow.PaymentDetails.Exists(5))
				[ ] ReportStatus("Verify Payment Details button. ", PASS , " Payment Details button appeared.") 
				[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
				[+] if(MDIClientLoans.LoanWindow.AddLinkedAssetAccount.Exists(2))
					[ ] ReportStatus("Verify Payment Details tab. ", FAIL , " Payment Details tab didn't appear.") 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Payment Details tab. ", PASS , " Payment Details tab appeared.") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Payment Details button. ", FAIL , " Payment Details button didn't appear.") 
		[+] else
			[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test 2- Verify 'Add Loan Details' button launches Loan.D.1 Screen. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test2_VerifyAddLoanDetailsButtonLaunchesLoanD1DialogFromMinimalPaymentDetailsScreen
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 'Add Loan Details' button launches Loan.D.1 Screen from 'Payment Details (minimal)' screen .
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  'Add Loan Details' button launches Loan.D.1 Screen from 'Payment Details (minimal)' screen
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 17 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test2_VerifyAddLoanDetailsButtonLaunchesLoanD1DialogFromMinimalPaymentDetailsScreen() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[1]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
		[+] if (iResult==PASS)
			[ ] QuickenWindow.SetActive()
			[+] if(MDIClientLoans.LoanWindow.AddLoanDetailsButton.Exists(5))
				[ ] 
				[ ] MDIClientLoans.LoanWindow.AddLoanDetailsButton.Click()
				[+] if(LoanDetails.Exists(2))
					[ ] ReportStatus("Verify Add Loan Details button launches Loan.D.1 Screen.", PASS , "Add Loan Details button launched Loan.D.1 Screen from Payment Details (minimal) screen.") 
					[ ] LoanDetails.SetActive()
					[ ] LoanDetails.CancelButton.Click()
					[ ] WaitForState( LoanDetails , False ,3)
				[+] else
					[ ] ReportStatus("Verify Add Loan Details button launches Loan.D.1 Screen.", FAIL , " Add Loan Details button didn't launch Loan.D.1 Screen from Payment Details (minimal) screen..") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Loan Details button. ", FAIL , " Add Loan Details button didn't appear.") 
		[+] else
			[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test 3 - Verify 'Add Loan Details' button's functionality is working.. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test3_VerifyAddLoanDetailsButtonFunctionalityFromMinimalPaymentDetailsScreen
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 'Add Loan Details' button's functionality from 'Payment Details (minimal)' screen .
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  'Add Loan Details' button functionality from 'Payment Details (minimal)' screen is as expected.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 17 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test3_VerifyAddLoanDetailsButtonFunctionalityFromMinimalPaymentDetailsScreen() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] ////Read sLoanAccountWorksheet
		[ ] STRING sActualTotalPaymentAmountL2
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[1]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] 
		[ ] sDate=ModifyDate(0,sDateFormat)
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
		[+] if (iResult==PASS)
			[ ] QuickenWindow.SetActive()
			[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
			[ ] iResult =OnlineLoansNaviagateToD2Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
			[+] if (iResult==PASS)
				[+] if(LoanDetails.Exists(5))
					[ ] LoanDetails.SetActive()
					[ ] ///Total Payment Amount verification at reminder screen without editing the Other and Extra Principal at Loan step 2
					[ ] sActualTotalPaymentAmountL2 = LoanDetails.TotalPaymentAmount.GetText()
					[ ] sActualTotalPaymentAmountL2=StrTran(sActualTotalPaymentAmountL2 ,"," ,"")
					[+] if (sExpectedPayment== sActualTotalPaymentAmountL2)
						[ ] ReportStatus("Verify Add Loan Details button's functionality.", PASS , "Monthly Payment actual: {sActualTotalPaymentAmountL2} is same as expected {sExpectedPayment} on Payment Details.") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Add Loan Details button's functionality. ", FAIL , "Monthly Payment calculated actual: {sActualTotalPaymentAmountL2} is NOT as expected {sExpectedPayment} on Payment Details.") 
					[ ] 
					[ ] LoanDetails.SetActive()
					[ ] LoanDetails.BackButton.Click()
					[ ] LoanDetails.CancelButton.Click()
					[+] if (AlertMessage.Exists(2))
						[ ] AlertMessage.SetActive()
						[ ] AlertMessage.Yes.Click()
						[ ] WaitForState( AlertMessage , False ,2)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify NextPaymentDueTextField on Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test 4A - Verify that loan account register displays loan account related transactions added from bills tab. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test4A_VerifyThatLoanAccountRegisterDisplaysLoanAccountRelatedTransactionsAddedFromBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that loan account register displays loan account related transactions added from bills tab .
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If loan account register displays loan account related transactions added from bills tab .
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 17 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test4A_VerifyThatLoanAccountRegisterDisplaysLoanAccountRelatedTransactionsAddedFromBillsTab () appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] ////Read sLoanAccountWorksheet
		[ ] STRING sActualTotalPaymentAmountL2
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sManualLoanAccountWorksheet)
		[ ] lsAccount = lsExcelData[1]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] sAction ="Add"
		[ ] 
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
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iResult =AddEditManualLoanAccount(sAction, sAccountName ,sDate ,lsAccount[3] ,lsAccount[4] ,lsAccount[5] ,lsAccount[6])
		[ ] //Add Loan account
		[+] if(iResult==PASS)
			[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
			[+] if (iResult==PASS)
				[ ] iResult=NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
				[ ] //Enter transaction for the reminder
				[+] if (iResult == PASS)
					[ ] QuickenWindow.SetActive()
					[ ] MDIClient.Bills.ViewAsPopupList.Select("Stack")
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select("30 Days")
					[ ] MDIClient.Bills.Enter.Click()
					[+] if(EnterExpenseIncomeTxn.Exists(5))
						[ ] EnterExpenseIncomeTxn.SetActive()
						[ ] EnterExpenseIncomeTxn.EnterTransactionButton.Click()
						[ ] WaitForState(LoanPaymentReminder , false ,5)
						[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
						[+] if (iResult==PASS)
							[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
							[ ] iResult=FindTransaction(sMDIWindow , sAccountName)
							[+] if (iResult == PASS)
								[ ] ReportStatus(" Verify that a user should be able to Enter the Simple Reminder on Bills tab . ", PASS , "Transaction with payee: {sAccountName} has been added to the account: {sAccountName}.")
							[+] else
								[ ] ReportStatus(" Verify that a user should be able to Enter the Simple Reminder on Bills tab . ", FAIL , "Transaction with payee: {sAccountName} couldn't be added to the account: {sAccountName}.")
								[ ] 
						[+] else
							[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Edit Loan Payment Reminder dialog. ", FAIL , "Edit Loan Payment Reminder dialog didn't appear.")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Bills tab. ", FAIL , " Bills tab didn't display.") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Manual loan account",FAIL,"Manual loan: {sAccountName} account not added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test 4B - Verify that loan account register displays loan account related transactions entered using memorized payee from checking account. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test4B_VerifyThatLoanAccountRegisterDisplaysLoanAccountRelatedTransactionsUsingMemorizedPayee
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that loan account register displays loan account related transactions entered using memorized payee from checking account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If loan account register displays loan account related transactions entered using memorized payee from checking account
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 18 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test4B_VerifyThatLoanAccountRegisterDisplaysLoanAccountRelatedTransactionsUsingMemorizedPayee() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] ////Read sLoanAccountWorksheet
		[ ] STRING sActualTotalPaymentAmountL2
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sManualLoanAccountWorksheet)
		[ ] lsAccount = lsExcelData[1]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] // Read checking account
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] sAction ="Add"
		[ ] 
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
		[ ] 
	[+] if(FileExists(sOnlineLoansDataFile))
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.Kill()
		[ ] Waitforstate(QuickenWindow,False,5)
		[ ] DeleteFile(sOnlineLoansDataFile)
	[ ] SYS_CopyFile (sOnlineLoansDataSource,sOnlineLoansDataFile)
	[+] if(!QuickenWindow.Exists(5))
		[ ] App_Start(sCmdLine)
		[ ] sleep(5)
		[ ] WaitForState(QuickenWindow , true , 20)
	[ ] iResult=OpenDataFile(sOnlineLoansDataFileName)
	[ ] 
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] iResult =AddEditManualLoanAccount(sAction, sAccountName ,sDate ,lsAccount[3] ,lsAccount[4] ,lsAccount[5] ,lsAccount[6])
			[ ] //Add Loan account
			[+] if(iResult==PASS)
				[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
				[+] if (iResult==PASS)
					[ ] //Navigate to Bills tab
					[ ] QuickenWindow.SetActive()
					[ ] iResult=NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
					[ ] //Delete the Loan reminder from bills tab
					[+] if (iResult == PASS)
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Bills.ViewAsPopupList.Select("Stack")
						[ ] MDIClient.Bills.DueWithinNextPopupList.Select("30 Days")
						[ ] MDIClient.Bills.Edit.Click()
						[+] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DeleteButton.Click()
							[+] if (AlertMessage.Exists(5))
								[ ] ReportStatus(" Verify that a user should be able to delete the Detailed Reminder on Bills tab. ", PASS , "Delete Confirmation dialog appeared.")
								[ ] AlertMessage.SetActive()
								[ ] AlertMessage.OK.Click()
								[ ] WaitForState(AlertMessage , false ,5)
								[ ] WaitForState(LoanPaymentReminder , false ,5)
								[ ] 
								[ ] //Verify that reminder has been deleted
								[ ] QuickenWindow.SetActive()
								[ ] 
								[+] if (MDIClient.Bills.ViewAsPopupList.Exists(2))
									[ ] ReportStatus(" Verify that a user should be able to delete the Detailed Reminder on Bills tab. ", FAIL , "The Loan payment reminder for account: {sAccountName} couldn't be deleted from Detailed Reminder on Bills tab, reminder is still available.")
									[ ] 
								[+] else
									[ ] //Add transaction to Loan Account from Checking Account
									[ ] iResult =SelectAccountFromAccountBar( lsAddAccount[2], ACCOUNT_BANKING)
									[+] if (iResult == PASS)
										[ ] QuickenWindow.SetActive()
										[ ] QuickenWindow.TypeKeys(KEY_CTRL_N)
										[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_CTRL_N)
										[ ] MDIClient.AccountRegister.TxList.TypeKeys (sDate)
										[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
										[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
										[ ] MDIClient.AccountRegister.TxList.TypeKeys (sAccountName)
										[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_TAB)
										[+] if (DlgConfirmPrincipalandInterest.Exists(5))
											[ ] DlgConfirmPrincipalandInterest.SetActive()
											[ ] DlgConfirmPrincipalandInterest.OKButton.Click()
											[ ] WaitForState( DlgConfirmPrincipalandInterest , False ,3)
											[ ] MDIClient.AccountRegister.TxList.TxToolBar.Save.Click()
											[ ] sleep(3)
											[ ] 
											[ ] ///Verify transaction has been added to the loan account
											[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
											[+] if (iResult==PASS)
												[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
												[ ] iResult=FindTransaction(sMDIWindow , sAccountName)
												[+] if (iResult == PASS)
													[ ] ReportStatus("Verify that a user should be able to Enter the the transaction using memorized payee.", PASS , "Transaction with payee: {sAccountName} has been added to the account: {sAccountName} using memorized payee.")
												[+] else
													[ ] ReportStatus("Verify that a user should be able to Enter the the transaction using memorized payee.", FAIL , "Transaction with payee: {sAccountName} couldn't be added to the account: {sAccountName} using memorized payee.")
													[ ] 
											[+] else
												[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
											[ ] 
										[+] else
											[ ] ReportStatus("Verify Confirm Principal and Interest dialog" , PASS , "Confirm Principal and Interest dialog didn't appear hence Loan transaction couldn't be added.")
										[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
										[ ] 
									[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus(" Verify that a user should be able to delete the Detailed Reminder on Bills tab. ", FAIL , "Delete Confirmation dialog didn't appear.")
							[ ] 
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that a user should be able to Edit the Detailed Reminder on Bills tab . ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.")
							[ ] 
						[ ] //handle the fail condition
						[+] if(DlgAddEditReminder.Exists(5))
							[ ] DlgAddEditReminder.SetActive()
							[ ] DlgAddEditReminder.CancelButton.Click()
							[ ] WaitForState(DlgAddEditReminder , false ,5)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Bills tab. ", FAIL , " Bills tab didn't display.") 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
				[ ] 
			[+] else
				[ ] ReportStatus("Add Manual loan account",FAIL,"Manual loan: {sAccountName} account not added")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sOnlineLoansDataFileName} couldn't be opened.")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test 5 - Verify that on Payment details tab user should be able to see the full categorization of  next loan payment.#####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test5_VerifyThatOnPaymentDetailsTabUserShouldBeAbleToSeeTheFullCategorizationOfNextLoanPayment
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that on Payment details tab user should be able to see the full categorization of  next loan payment.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to see the full categorization of  next loan payment on Payment details tab.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 18 2013
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test5_VerifyThatOnPaymentDetailsTabUserShouldBeAbleToSeeTheFullCategorizationOfNextLoanPayment() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] STRING sOther , sExtraPrincipal  ,sInterestPaid ,sPrincipalPaid 
		[ ] NUMBER nOther , nExtraPrincipal  ,nInterestPaid ,nPrincipalPaid
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sManualLoanAccountWorksheet)
		[ ] lsAccount = lsExcelData[1]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] sInterestPaid = lsAccount[8]
		[ ] sPrincipalPaid = lsAccount[9]
		[ ] 
		[ ] nInterestPaid = VAL (sInterestPaid)
		[ ] sInterestPaid = trim(str(nInterestPaid, 2,2))
		[ ] 
		[ ] nPrincipalPaid = VAL (sPrincipalPaid)
		[ ] sPrincipalPaid = trim(str(nPrincipalPaid, 2,2))
		[ ] 
		[ ] 
		[ ] sOther=lsAccount[10]
		[ ] 
		[ ] sExtraPrincipal=lsAccount[11]
		[ ] 
		[ ] nOther = VAL (sOther)
		[ ] sOther = trim(str(nOther, 2,2))
		[ ] 
		[ ] nExtraPrincipal = VAL (sExtraPrincipal)
		[ ] sExtraPrincipal = trim(str(nExtraPrincipal, 2,2))
		[ ] 
		[ ] 
		[ ] ListAppend(lsData , sInterestPaid)
		[ ] ListAppend(lsData , sPrincipalPaid)
		[ ] ListAppend(lsData , sOther)
		[ ] ListAppend(lsData , sExtraPrincipal)
		[ ] // Read checking account
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] sAction ="Add"
		[ ] 
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
		[ ] 
	[+] if(FileExists(sOnlineLoansDataFile))
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.Kill()
		[ ] Waitforstate(QuickenWindow,False,5)
		[ ] DeleteFile(sOnlineLoansDataFile)
	[ ] SYS_CopyFile (sOnlineLoansDataSource,sOnlineLoansDataFile)
	[+] if(!QuickenWindow.Exists(5))
		[ ] App_Start(sCmdLine)
		[ ] sleep(5)
		[ ] WaitForState(QuickenWindow , true , 20)
	[ ] iResult=OpenDataFile(sOnlineLoansDataFileName)
	[ ] 
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] iResult =AddEditManualLoanAccount(sAction, sAccountName ,sDate ,lsAccount[3] ,lsAccount[4] ,lsAccount[5] ,lsAccount[6] ,NULL,NULL,NULL,NULL, sOther , sExtraPrincipal)
			[ ] //Add Loan account
			[+] if(iResult==PASS)
				[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
				[+] if (iResult==PASS)
					[ ] //Navigate to Bills tab
					[ ] QuickenWindow.SetActive()
					[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
					[ ] //Verify the categories in the Monthly Payment list
					[ ] sHandle= Str(PaymentDetailsListBox.GetHandle())
					[ ] iListCount = PaymentDetailsListBox.GetItemCount() +1
					[+] for(iCounter= 1; iCounter <=ListCount (lsData);  iCounter++)
						[+] for(iCount= 0; iCount <=iListCount;  iCount++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
							[ ] bMatch =MatchStr("*{lsData[iCounter]}*", sActual)
							[+] if (bMatch)
								[ ] break
						[+] if (bMatch)
							[ ] ReportStatus(" Verify that on Payment details tab user should be able to see the full categorization of  next loan payment.", PASS, "Category data is {sActual} is as expected: {lsData[iCounter]} on Payment Details.")
						[+] else
							[ ] ReportStatus(" Verify that on Payment details tab user should be able to see the full categorization of  next loan payment.", FAIL, "Category data is {sActual} is as NOT expected: {lsData[iCounter]} on Payment Details.")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
				[ ] 
			[+] else
				[ ] ReportStatus("Add Manual loan account",FAIL,"Manual loan: {sAccountName} account not added")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sOnlineLoansDataFileName} couldn't be opened.")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] // 
[ ] // ===========================================================================================
[ ] // ================================= Edit Manual Loan Details  =======================================
[ ] // ===========================================================================================
[ ] 
[ ] 
[+] //##########  Verify launching points for Add Manual Loan account - from 'Loan FI selection' screen. ####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_Launching_Points_For_Add_Manual_Loan_Account_FI_Screen
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify launching points for Add Manual Loan account - from 'Loan FI selection' screen.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Manual loan account link is functional and navigates to the correct screen
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  4th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase TestA_Launching_Points_For_Add_Manual_Loan_Account_FI_Screen() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] STRING sLoanAccountType="Loan"
		[ ] STRING sLoanFIName="Chase"
		[ ] STRING sManualAccountLink="manual loan account"
		[ ] STRING sExpectedWindowTitle="Add Loan Account"
		[ ] 
		[ ] 
	[ ] iValidate=DataFileCreate(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Create Data File",PASS,"Data File created successfully")
		[ ] 
		[ ] 
		[ ] SwitchManualBackupOption(sSwitchOn)
		[ ] ExpandAccountBar()
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[ ] 
		[ ] 
		[ ] AddAccount.Loan.Click()
		[+] if(QuickenUpdateStatus.Exists(5))
			[ ] QuickenUpdateStatus.SetActive()
			[ ] QuickenUpdateStatus.StopUpdate.Click()
			[ ] WaitForState(AddAnyAccount,TRUE,700)
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
			[ ] AddAnyAccount.SetActive()
			[ ] 
			[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
			[ ] 
			[ ] 
			[+] if(LoanDetails.Exists(MEDIUM_SLEEP))
				[ ] ReportStatus("Verify if Loan Details Exists",PASS,"Loan Details window opens for manual account link")
				[ ] 
				[ ] LoanDetails.BackButton.Click()
				[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
					[ ] 
					[ ] AddAnyAccount.TextClick(sLoanFIName)
					[ ] sleep(10)
					[ ] 
					[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
						[ ] 
						[ ] 
						[ ] 
						[+] if(AddAnyAccount.GetCaption()==sExpectedWindowTitle)
							[ ] ReportStatus("Verify if Add An Account Exists",PASS,"Clicking on FI name navigates to next screen of Add an account flow")
							[ ] 
							[ ] 
							[+] if(AddAnyAccount.FINameText.GetCaption()==sLoanFIName)
								[ ] ReportStatus("Verify if FI Name is correct",PASS,"Correct FI name is displayed {sLoanFIName}")
								[ ] 
								[ ] AddAnyAccount.TextClick(sManualAccountLink)
								[+] if(LoanDetails.Exists(MEDIUM_SLEEP))
									[ ] ReportStatus("Verify if Loan Details Exists",PASS,"Loan Details window opens for manual account link on Loan FI screen for {sLoanFIName} Account")
									[ ] 
									[ ] LoanDetails.Close()
									[+] if(AlertMessage.Exists(5))
										[ ] AlertMessage.OK.Click()
									[ ] WaitForState(LoanDetails,FALSE,5)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if Loan Details Exists",FAIL,"Loan Details window did not open for manual account link on Loan FI screen for {sLoanFIName} Account")
									[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if FI Name is correct",FAIL,"Wrong FI Name Navigation to  FI name is displayed")
								[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Add An Account Exists",FAIL,"Clicking on FI name does not navigate to next screen of Add an account flow")
							[ ] 
					[ ] 
					[+] else
						[ ] ReportStatus("Verify if Add An Account Exists",FAIL,"Clicking on FI name does not navigate to next screen of Add an account flow")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify if Add An Account Exists",FAIL,"Clicking on Back button does not navigate to Add An Account Window")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify if Loan Details Exists",FAIL,"Loan Details window did not open for manual account link")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify if Add An Account window Exists",FAIL,"Add An Account window did not open")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File not created")
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
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //##########  Verify that user is able to add manual loan account with different payment schedule  ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_Add_Manual_Loan_Account_With_Different_Payment_Schedules
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to add manual loan account with different payment schedule 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to add manual loan account with different payment schedule
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  4th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase TestB_Add_Manual_Loan_Account_With_Different_Payment_Schedules() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sPaymentTextCaption
		[ ] LIST OF STRING lsExpectedPaymentScheduleText
		[ ] BOOLEAN bDeleteTrue
		[ ] 
		[ ] 
		[ ] lsPaymentSchedule={"Annually","Twice per year","Quarterly","Every other month","Monthly","Twice per month","Every other week","Weekly"}
		[ ] lsExpectedPaymentScheduleText={"ANNUAL PAYMENT","SEMI-ANNUAL PAYMENT","QUARTERLY PAYMENT","BI-MONTHLY PAYMENT","MONTHLY PAYMENT","SEMI-MONTHLY PAYMENT","BI-WEEKLY PAYMENT","WEEKLY PAYMENT","WEEKLY PAYMENT"}
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[1]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] // Copy autoapi dll for qwauto utility
		[ ] Setup_AutoApi()
		[ ] 
	[ ] 
	[ ] //Open Data file
	[ ] iValidate=OpenDataFile(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] 
		[ ] //Add Checking account
		[ ] iValidate=AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add Manual spending account",PASS,"Manual Spending account is added")
			[+] for(i=1;i<=ListCount(lsPaymentSchedule);i++)
				[ ] 
				[ ] 
				[ ] 
				[ ] //Add Loan account
				[ ] iValidate=AddEditManualLoanAccount(sAddAction,lsAddLoanAccount[1],lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],lsPaymentSchedule[i])
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account is added")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
					[+] if(iValidate==PASS)
						[ ] 
						[ ] // Verification points for payment schedule on Loan dashboard
						[ ] 
						[ ] //Payment Text on Dashboard
						[ ] sPaymentTextCaption=MDIClientLoans.LoanWindow.PaymentText.GetCaption()
						[+] if(sPaymentTextCaption==lsExpectedPaymentScheduleText[i])
							[ ] ReportStatus("Verify Payment text",PASS,"Payment text on Dashboard displays correct value {sPaymentTextCaption} ")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Payment text",FAIL,"Payment text on Dashboard displays wrong value {sPaymentTextCaption} ")
						[ ] 
						[ ] //Edit Terms
						[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
						[+] if(LoanDetails.Exists(5))
							[ ] 
							[ ] sPaymentTextCaption=LoanDetails.PaymentScheduleComboBox.GetText()
							[ ] 
							[ ] //if(MatchStr("*{lsPaymentSchedule[1]}*",sPaymentTextCaption))
							[+] if(lsPaymentSchedule[i]==sPaymentTextCaption)
								[ ] ReportStatus("Verify Payment text",PASS,"Payment text displays correct value in Loan details dialog invoked from Edit terms button : {sPaymentTextCaption} ")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Payment text",FAIL,"Payment text displays wrong value in Loan details dialog invoked from Edit terms button {sPaymentTextCaption} ")
							[ ] 
							[ ] LoanDetails.Close()
							[ ] WaitForState(LoanDetails,FALSE,5)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify loan details window launched",FAIL,"Loan details window not displayed")
							[ ] 
						[ ] 
						[ ] 
						[ ] //Delete Loan Account
						[ ] iValidate=ModifyAccount(sMDIWindow,lsAddLoanAccount[1],sDeleteAction)
						[+] if(iValidate==PASS)
							[ ] ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
							[ ] bDeleteTrue=TRUE
							[ ] 
						[+] else
							[ ] ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[+] if(bDeleteTrue==FALSE)
						[ ] break
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Add Manual loan account",FAIL,"Manual loan account not added")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Add Manual spending account",FAIL,"Manual Spending account is not added")
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] 
[+] //##########  Verify Loan in Edit mode from Edit terms button on Loan details tab  ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_Edit_Manual_Loan_Account
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Loan DM 1 screen can be open in Edit mode from Edit terms button on Loan details tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Loan displayed in Edit mode from Edit terms button on Loan details tab
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 6th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01_VerifyFieldsEditManualLoanAccount() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] BOOLEAN bDeleteTrue
	[ ] 
	[ ] // Read banking account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Read manual loan account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
	[ ] lsAddLoanAccount=lsExcelData[1]
	[ ] lsAddLoanAccount[3]=sDate
	[ ] 
	[ ] //Add Loan account
	[ ] iValidate=AddEditManualLoanAccount(lsAddLoanAccount[1],lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],lsAddLoanAccount[7],lsAddLoanAccount[8])
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account is added")
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[2],ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Verification
			[ ] 
			[ ] // Click on Edit Terms button
			[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] 
				[ ] 
				[+] do
					[ ] LoanDetails.LoanNameTextField.SetText(lsAddLoanAccount[1])
					[ ] LoanDetails.OpeningDateTextField.SetText(lsAddLoanAccount[2])
					[ ] LoanDetails.OriginalBalanceTextField.SetText(lsAddLoanAccount[3])
					[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsAddLoanAccount[4])
					[ ] LoanDetails.OriginalLengthTextField.SetText(lsAddLoanAccount[5])
					[ ] LoanDetails.OriginalLength.Select("Months")
					[ ] LoanDetails.CompoundingPeriod.Select("Daily")
					[ ] LoanDetails.PaymentScheduleComboBox.Select("Weekly")
					[ ] LoanDetails.CurrentBalanceTextField.SetText(lsAddLoanAccount[3])
					[ ] LoanDetails.MonthlyPaymentTextField.SetText("100")
					[+] if(LoanDetails.RecalculateCurrentBalanceButton.IsEnabled())
						[ ] ReportStatus("Verify Recalculate button in Edit Loan Details window",PASS,"Recalculate Current Balance button is enabled")
					[+] else
						[ ] ReportStatus("Verify Recalculate button in Edit Loan Details window",FAIL,"Recalculate Current Balance button is not enabled")
						[ ] 
					[+] if(LoanDetails.RecalculatePaymentFrequencyButton.Exists(1))
						[+] if(LoanDetails.RecalculatePaymentFrequencyButton.IsEnabled())
							[ ] ReportStatus("Verify Recalculate button in Edit Loan Details window",PASS,"Recalculate Payment Frequency button is enabled")
						[+] else
							[ ] ReportStatus("Verify Recalculate button in Edit Loan Details window",FAIL,"Recalculate Payment Frequency button is not enabled")
						[ ] 
					[ ] 
					[ ] ReportStatus("Verify All fiels are editable in Edit Loan Details window",PASS,"All fields are editable in Edit Loan Details window")
					[ ] 
				[+] except
					[ ] ReportStatus("Verify All fiels are editable in Edit Loan Details window",FAIL,"Some fields are not editable.All fields should be editable in Edit Loan Details window")
					[ ] 
				[ ] 
				[ ] LoanDetails.Close()
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify loan details window launched",FAIL,"Loan details window not displayed")
				[ ] 
			[ ] 
			[ ] 
			[ ] // //Delete Loan Account
			[ ] // iValidate=ModifyAccount(sMDIWindow,lsAddLoanAccount[1],sDeleteAction)
			[+] // if(iValidate==PASS)
				[ ] // ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
				[ ] // bDeleteTrue=TRUE
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
				[ ] // 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add Manual loan account",FAIL,"Manual loan account not added")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################################
[ ] 
[+] //##########  Update Loan Name in Edit mode from Edit terms button on Loan details tab  ################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_Update_Manual_Loan_Account_Name
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that on Loan name can be updated from Edit DM1 screen.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Loan name is updated
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 6th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test02_UpdateManualLoanAccountName() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] STRING sHandle,sActual, sLoanName="Loan"
		[ ] STRING sUpdatedLoanName="Updated Manual Loan"
		[ ] boolean bPattern
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] QuickenWindow.SetActive()
		[ ] // iValidate=SelectAccountFromAccountBar(sLoanName,ACCOUNT_PROPERTYDEBT)
		[+] // if(iValidate==PASS)
			[ ] 
			[ ] // Verification
			[ ] 
			[ ] // Click on Edit Terms button
			[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] 
				[ ] 
				[+] do
					[ ] LoanDetails.LoanNameTextField.SetText(sUpdatedLoanName)
					[ ] LoanDetails.OKButton.Click()
					[ ] WaitForState(LoanDetails,FALSE,5)
					[ ] 
					[+] // if(SelectAccountFromAccountBar(sUpdatedLoanName,ACCOUNT_PROPERTYDEBT))
						[ ] // ReportStatus("Verify Loan name is updated",PASS,"Loan name is updated successfully")
					[+] // else
						[ ] // ReportStatus("Verify Loan name is updated",FAIL,"Loan name is not updated")
						[ ] // 
					[ ] 
				[+] except
					[ ] ReportStatus("Verify All fiels are editable in Edit Loan Details window",FAIL,"Loan name is not editable")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify loan details window launched",FAIL,"Loan details window not displayed")
				[ ] 
			[ ] 
			[ ] 
			[ ] //Delete Loan Account
			[ ] iValidate=ModifyAccount(sMDIWindow,sUpdatedLoanName,sDeleteAction)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
				[ ] bDeleteTrue=TRUE
				[ ] 
			[+] else
				[ ] ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] // else
			[ ] // ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register is not opened")
			[ ] // 
			[ ] // 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################################
[ ] 
[+] //##########  Update all Loan fields in Edit mode from Edit terms button on Loan details tab  ##############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_Update_Manual_Loan_Account_Fields
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that on Opening Date , Original balance,Current Interest Rate,Original Length , Compounding period, Payment Schedule ,Current Balance , can be updated from Edit DM1 screen.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Loan details fields get updated successfully
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 7th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test03_UpdateManualLoanAccountFields() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] BOOLEAN bDeleteTrue
		[ ] DATETIME dDate
		[ ] STRING sCaption,sOriginalBalance
		[ ] INTEGER iInterestRate,iOriginalLength
	[ ] 
	[ ] 
	[ ] // Read manual loan account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
	[ ] lsAddLoanAccount=lsExcelData[1]
	[ ] lsAddLoanAccount[3]=sDate
	[ ] lsEditLoanAccount=lsExcelData[2]
	[ ] 
	[ ] 
	[ ] iInterestRate=Val(lsEditLoanAccount[5])
	[ ] sOriginalBalance=lsEditLoanAccount[4]
	[ ] iOriginalLength=Val(lsEditLoanAccount[6])
	[ ] 
	[ ] //Add Loan account
	[ ] iValidate=AddEditManualLoanAccount(lsAddLoanAccount[1], lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],lsAddLoanAccount[7],lsAddLoanAccount[8])
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account is added")
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[2],ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Edit Loan
			[ ] sDate=ModifyDate(-2,sDateFormat)
			[ ] lsEditLoanAccount[3]=sDate
			[ ] iEdit=AddEditManualLoanAccount(lsEditLoanAccount[1],lsEditLoanAccount[2],lsEditLoanAccount[3],lsEditLoanAccount[4],lsEditLoanAccount[5],lsEditLoanAccount[6],lsEditLoanAccount[7],lsEditLoanAccount[8],lsEditLoanAccount[9],lsEditLoanAccount[10])
			[+] if(iEdit==PASS)
				[ ] ReportStatus("Verify Edit all fields for Manual loan account {lsAddLoanAccount[2]}",PASS,"All fields are updated for {lsAddLoanAccount[2]} account")
			[+] else
				[ ] ReportStatus("Verify Edit all fields for Manual loan account {lsAddLoanAccount[2]}",FAIL,"All fields are not updated for {lsAddLoanAccount[2]} account")
			[ ] 
			[ ] // Verification
			[ ] // iSelect=SelectAccountFromAccountBar(lsEditLoanAccount[2],ACCOUNT_PROPERTYDEBT)
			[+] // if(iSelect==PASS)
				[ ] // ReportStatus("Verify Edited Loan on Account Bar",PASS,"Updated loan name is displayed in Account bar")
			[+] // else
				[ ] // ReportStatus("Verify Edited Loan on Account Bar",FAIL,"Updated loan name is not displayed in Account bar")
				[ ] // 
			[ ] 
			[ ] 
			[ ] 
			[ ] // Verify Interest rate on Loan dashboard
			[ ] sCaption=MDIClientLoans.LoanWindow.InterestRateAmount.Getproperty("caption")
			[+] if(MatchStr("{iInterestRate}*",sCaption))
				[ ] ReportStatus("Verify Edited Interest rate on Loan dashboard",PASS,"Interest rate is updated on Loan dashboard - Interest Rate - {sCaption}")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Edited Interest rate on Loan dashboard",FAIL,"Interest rate is not updated on Loan dashboard - Actual Interest Rate - {sCaption}, Expected {iInterestRate}")
				[ ] 
			[ ] 
			[ ] // Verify Original Balance on Loan dashboard
			[ ] sCaption=MDIClientLoans.LoanWindow.OriginalBalanceText.Getproperty("caption")
			[+] if(MatchStr("{sOriginalBalance}*",sCaption))
				[ ] ReportStatus("Verify Edited Original Balance on Loan dashboard",PASS,"Original Balance is updated on Loan dashboard - Original Balance- {sCaption}")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Edited Original Balance on Loan dashboard",FAIL,"Original Balance is not updated on Loan dashboard - Actual Original Balance - {sCaption}, Expected {sOriginalBalance}")
				[ ] 
			[ ] 
			[ ] // Verify Original Length on Loan dashboard
			[ ] sCaption=MDIClientLoans.LoanWindow.OriginalLengthText.Getproperty("caption")
			[+] if(MatchStr("{iOriginalLength}*{lsEditLoanAccount[9]}",sCaption))
				[ ] ReportStatus("Verify Edited Original Length on Loan dashboard",PASS,"Original Length is updated on Loan dashboard - Original Length - {sCaption}")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Edited Original Length on Loan dashboard",FAIL,"Original Length is not updated on Loan dashboard - Actual Original Length - {sCaption}, Expected {iOriginalLength}{lsEditLoanAccount[9]}")
				[ ] 
			[ ] 
			[ ] // Verify Compounding Period on Loan dashboard
			[ ] sCaption=MDIClientLoans.LoanWindow.CompoundingPeriodText.Getproperty("caption")
			[+] if(MatchStr("*{lsEditLoanAccount[10]}",sCaption))
				[ ] ReportStatus("Verify Edited Compounding Period on Loan dashboard",PASS,"Compounding Period is updated on Loan dashboard - Compounding Period - {sCaption}")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Edited Compounding Period on Loan dashboard",FAIL,"Compounding Period is not updated on Loan dashboard - Actual Compounding Period - {sCaption}, Expected {lsEditLoanAccount[10]}")
				[ ] 
			[ ] 
			[ ] 
			[ ] // Verify Origination Date on Loan dashboard
			[ ] sCaption=MDIClientLoans.LoanWindow.OriginationDateText.Getproperty("caption")
			[ ] 
			[ ] dDate=AddDateTime (GetDateTime(), -2)
			[ ] sDate=FormatDateTime(dDate,"mmm d yyyy")
			[+] if(MatchStr("*{sDate}*",sCaption))
				[ ] ReportStatus("Verify Edited Origination Date on Loan dashboard",PASS,"Origination Date is updated on Loan dashboard - Origination Date - {sCaption}")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Edited Origination Date on Loan dashboard",FAIL,"Origination Date is not updated on Loan dashboard - Actual Origination Date - {sCaption}, Expected {sDate}")
				[ ] 
			[ ] 
			[ ] //Delete Loan Account
			[ ] iValidate=ModifyAccount(sMDIWindow,lsEditLoanAccount[2],sDeleteAction)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
				[ ] bDeleteTrue=TRUE
				[ ] 
			[+] else
				[ ] ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
				[ ] 
			[ ] 
		[+] // else
			[ ] // ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
			[ ] // 
			[ ] // 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add Manual loan account",FAIL,"Manual loan account not added")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################################
[ ] 
[+] //##########   Verify that  <Frequency> Payment can be updated from Edit DM1 screen.   ##################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_Manual_Loan_Account_Frequency_Update_Verification
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //  Verify that  <Frequency> Payment can be updated from Edit DM1 screen. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Correct alert message is displayed and frequecy gets updated successfully
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 8th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test04_ManualLoanAccountFrequencyUpdateVerification() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] STRING sCaption, sPaymentSchedule = "Weekly"
		[ ] STRING sMessage="Quicken has recalculated the loan payment and schedule based on the new loan terms."
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[1]
		[ ] lsAddLoanAccount[3]=sDate
		[ ] 
		[ ] 
		[ ] 
	[ ] //Add Loan account
	[ ] iValidate=AddEditManualLoanAccount(lsAddLoanAccount[1], lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],lsAddLoanAccount[7],lsAddLoanAccount[8])
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account is added")
		[ ] 
		[ ] //Select Loan Account
		[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[2],ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Click on Edit Terms button
			[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
			[ ] WaitForState(LoanDetails,TRUE,5)
			[ ] 
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.PaymentScheduleComboBox.Select(sPaymentSchedule)
				[+] if(LoanDetails.RecalculateCurrentBalanceButton.Exists(SHORT_SLEEP))
					[+] if(LoanDetails.RecalculateCurrentBalanceButton.IsEnabled())
						[ ] ReportStatus("Verify Recalculate button is enabled",PASS,"Recalculate button is enabled after changing payment frequency")
					[+] else
						[ ] ReportStatus("Verify Recalculate button is enabled",FAIL,"Recalculate button is not enabled even after changing payment frequency")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Recalculate button exists",FAIL,"Recalculate button does not exist even after changing payment frequency")
					[ ] 
				[ ] 
				[ ] LoanDetails.OKButton.Click()
				[+] if(AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] sCaption=AlertMessage.MessageText.GetCaption()
					[+] if(MatchStr(sCaption,sMessage))
						[ ] ReportStatus("Verify Alert message after updating frequency",PASS,"Correct Alert message is displayed. Message  - {sMessage}")
					[+] else
						[ ] ReportStatus("Verify Alert message after updating frequency",FAIL,"Correct Alert message is displayed. Actual Message  - {sCaption} and Expected Message - {sMessage}")
						[ ] 
					[ ] 
					[ ] AlertMessage.SetActive()
					[ ] AlertMessage.OK.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify alert message exists",FAIL,"Alert message window does not exist")
				[ ] 
				[ ] WaitForState(LoanDetails,FALSE,SHORT_SLEEP)
				[ ] 
				[ ] 
				[+] if(MDIClientLoans.LoanWindow.PaymentScheduleLabel.Exists(SHORT_SLEEP))
					[ ] sCaption=MDIClientLoans.LoanWindow.PaymentScheduleLabel.GetProperty("Text")
					[+] if(MatchStr("{sPaymentSchedule}*",sCaption))
						[ ] ReportStatus("Verify payment schedule in Loan dashboard", PASS,"Correct payment schedule is displayed on Loan dashboard - Payment schedule is {sCaption}")
					[+] else
						[ ] ReportStatus("Verify payment schedule in Loan dashboard", FAIL,"Payment schedule is not correct on Loan dashboard - Actual Payment schedule is {sCaption} and Expected {sPaymentSchedule}")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Payment Schedule label on loan dashboard",FAIL,"Payment Schedule laabel is not displayed on loan dashboard")
			[+] else
				[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
			[ ] 
			[ ] //Delete Loan Account
			[ ] iValidate=ModifyAccount(sMDIWindow,lsAddLoanAccount[1],sDeleteAction)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
				[ ] bDeleteTrue=TRUE
				[ ] 
			[+] else
				[ ] ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add Manual loan account",FAIL,"Manual loan account not added")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] //===========================================================================================
[ ] //================================= Edit Online Loan Details  =======================================
[ ] //===========================================================================================
[ ] 
[ ] 
[+] //##########  Verify that Loan D1 screen can be open in Edit mode from Edit terms button  ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_Edit_Online_Loan_Account
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //   Verify that Loan D1 screen can be open in Edit mode from Edit terms button on Loan details tab.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Loan Details screen is opened in Edit mode for online loan Account
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 10th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test05_EditOnlineLoanAccount() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sAccount="My Auto Loan XX8888"
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[1]
		[ ] lsAddLoanAccount[3]=sDate
		[ ] 
		[ ] 
		[+] if(FileExists(sOnlineLoansDataFile))
			[+] if (QuickenWindow.Exists(5))
				[ ] QuickenWindow.Kill()
			[ ] Waitforstate(QuickenWindow,False,5)
			[ ] DeleteFile(sOnlineLoansDataFile)
		[ ] SYS_CopyFile (sOnlineLoansDataSource,sOnlineLoansDataFile)
		[+] if(!QuickenWindow.Exists(5))
			[ ] App_Start(sCmdLine)
			[ ] sleep(5)
			[ ] WaitForState(QuickenWindow , true , 20)
		[ ] 
		[ ] 
		[ ] 
	[ ] iResult=OpenDataFile(sOnlineLoansDataFileName)
	[+] if(iResult==PASS)
		[ ] ReportStatus("Add Online loan account",PASS,"Online loan account is added")
		[ ] 
		[ ] //Select Loan Account
		[ ] iValidate=OnlineLoansNaviagateToD3Step(sAccount,lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],lsAddLoanAccount[9],lsAddLoanAccount[10],lsAddLoanAccount[8])
		[+] if(iValidate==PASS)
			[ ] 
			[+] if(DlgLoanReminder.Exists(5))
				[ ] DlgLoanReminder.NextButton.Click()
				[+] if(DlgAddEditReminder.Exists(2))
					[ ] DlgAddEditReminder.SetActive()
					[ ] DlgAddEditReminder.DoneButton.Click()
				[ ] 
				[ ] WaitForState(DlgLoanReminder,FALSE,5)
			[ ] 
			[ ] // Click on Edit Terms button
			[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
			[ ] WaitForState(LoanDetails,TRUE,5)
			[+] if(LoanDetails.Exists(5))
				[ ] 
				[ ] 
				[+] do
					[ ] LoanDetails.LoanNameTextField.SetText(sAccount)
					[ ] LoanDetails.OpeningDateTextField.SetText(sDate)
					[ ] LoanDetails.OriginalBalanceTextField.SetText(lsAddLoanAccount[4])
					[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsAddLoanAccount[5])
					[ ] LoanDetails.OriginalLengthTextField.SetText(lsAddLoanAccount[6])
					[ ] LoanDetails.OriginalLength.Select("Months")
					[ ] LoanDetails.CompoundingPeriod.Select("Daily")
					[ ] LoanDetails.PaymentScheduleComboBox.Select("Weekly")
					[ ] LoanDetails.MonthlyPaymentTextField.SetText("100")
					[+] if(LoanDetails.RecalculatePaymentFrequencyButton.Exists(1))
						[+] if(LoanDetails.RecalculatePaymentFrequencyButton.IsEnabled())
							[ ] ReportStatus("Verify Recalculate button in Edit Loan Details window",PASS,"Recalculate Payment Frequency button is enabled")
						[+] else
							[ ] ReportStatus("Verify Recalculate button in Edit Loan Details window",FAIL,"Recalculate Payment Frequency button is not enabled")
						[ ] 
					[ ] 
					[ ] ReportStatus("Verify All fiels are editable in Edit Loan Details window",PASS,"All fields are editable in Edit Loan Details window for Online account")
					[ ] 
				[+] except
					[ ] ReportStatus("Verify All fiels are editable in Edit Loan Details window",FAIL,"Some fields are not editable.All fields should be editable in Edit Loan Details window")
					[ ] 
				[ ] 
				[ ] LoanDetails.Close()
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify loan details window launched",FAIL,"Loan details window not displayed")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Online loan account register",FAIL,"Online loan account register opened")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sOnlineLoansDataFileName} couldn't be opened.")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################################
[ ] 
[+] //##########  Update Loan Name in Edit mode from Edit terms button on Online Loan details tab  ################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_Update_Online_Loan_Account_Name
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that on Loan name can be updated from Edit D1 screen.
		[ ] // Test -8. Verify that Current Balance  field is a non - editable on Edit D1 screen. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Loan name is updated and current balance text field is not displayed and expected text is displayed
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 10th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test06_UpdateOnlineLoanAccountName_VerifyCurrentBalance() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] STRING sHandle,sActual, sLoanName="My Auto Loan XX8888"
		[ ] STRING sUpdatedLoanName="Updated Online Loan"
		[ ] STRING sExpectedText= "(as reported by your financial institution)"
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(2))
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=SelectAccountFromAccountBar(sLoanName,ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] //Verification
			[ ] 
			[ ] //Click on Edit Terms button
			[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] 
				[ ] // Verification for Current balance for online loan account
				[ ] LoanDetails.SetActive()
				[+] if(!LoanDetails.CurrentBalanceTextField.Exists(5))
					[ ] ReportStatus("Verify Current balance text field is not displayed",PASS,"Current balance text field is not available for online loan account {sLoanName}")
					[+] if(LoanDetails.OnlineCurrentBalanceText.Exists(5))
						[ ] sCaption=LoanDetails.OnlineCurrentBalanceText.GetCaption()
						[+] if(MatchStr("{sExpectedText}",sCaption))
							[ ] ReportStatus("Verify Current balance text displayed",PASS,"The Current balance field is non editable with a text beside stating  - {sExpectedText}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Current balance text displayed",FAIL,"The Current balance field is non editable But text beside it is not correct, Expected - {sExpectedText} and Actual - {sCaption}")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Current balance text displayed",FAIL,"Current balance text is not available for online loan account, Expected Text- {sExpectedText}")
				[+] else
					[ ] ReportStatus("Verify Current balance text field is not displayed",FAIL,"Current balance text field is available for online loan account {sLoanName}")
				[ ] 
				[ ] // Update online loan account name and verify it
				[+] do
					[ ] LoanDetails.SetActive()
					[ ] LoanDetails.LoanNameTextField.SetText(sUpdatedLoanName)
					[ ] LoanDetails.OKButton.Click()
					[ ] WaitForState(LoanDetails,FALSE,5)
					[ ] 
					[ ] QuickenWindow.TypeKeys("<Ctrl-Shift-E>")
					[ ] 
					[+] if (AccountDetails.Exists(SHORT_SLEEP))
						[ ] AccountDetails.SetActive ()
						[ ] sCaption=AccountDetails.AccountName.GetText()
						[ ] AccountDetails.OK.Click ()
						[ ] 
						[ ] bMatch= MatchStr("{sCaption}",sUpdatedLoanName)
						[+] if(bMatch)
							[ ] ReportStatus("Verify Loan name is updated",PASS,"Online Loan account name is updated successfully")
						[+] else
							[ ] ReportStatus("Verify Loan name is updated",FAIL,"Loan name is not updated, Actual - {sCaption}, Expected - {sUpdatedLoanName}")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Account Details window",FAIL,"Account Details window not opened")
					[ ] 
				[+] except
					[ ] ReportStatus("Verify All fiels are editable in Edit Loan Details window",FAIL,"Loan name is not editable")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify loan details window launched",FAIL,"Loan details window not displayed")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Online loan account register",FAIL,"Online loan account register is not opened")
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################################
[ ] 
[+] //##########  Update all Loan fields in Edit mode for Online loan account ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_Update_Online_Loan_Account_Fields
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that on Opening Date , Original balance,Current Interest Rate,Original Length , Compounding period, Payment Schedule can be updated from Edit D1 screen for online loan account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Online Loan details fields get updated successfully
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 10th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test07_UpdateOnlineLoanAccountFields() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] DATETIME dDate
		[ ] STRING sCaption,sOriginalBalance
		[ ] INTEGER iInterestRate,iOriginalLength
		[ ] STRING sUpdatedLoanName="Updated Online Loan"
		[ ] BOOLEAN bCaption
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] // Read manual loan account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
	[ ] lsEditLoanAccount=lsExcelData[2]
	[ ] 
	[ ] iInterestRate=Val(lsEditLoanAccount[5])
	[ ] sOriginalBalance=lsEditLoanAccount[4]
	[ ] iOriginalLength=Val(lsEditLoanAccount[6])
	[ ] lsEditLoanAccount[9]="Years"
	[ ] lsEditLoanAccount[10]="Monthly"
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(sUpdatedLoanName,ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] // Edit Loan
		[ ] sDate=ModifyDate(-2,sDateFormat)
		[ ] lsEditLoanAccount[3]=sDate
		[ ] iEdit=AddEditManualLoanAccount("Edit",lsEditLoanAccount[2],lsEditLoanAccount[3],lsEditLoanAccount[4],lsEditLoanAccount[5],lsEditLoanAccount[6],lsEditLoanAccount[7],lsEditLoanAccount[8],lsEditLoanAccount[9],lsEditLoanAccount[10])
		[+] if(iEdit==PASS)
			[ ] ReportStatus("Verify Edit all fields for Manual loan account {lsEditLoanAccount[2]}",PASS,"All fields are updated for {sUpdatedLoanName} account")
			[ ] // Verification
			[ ] iSelect=SelectAccountFromAccountBar(lsEditLoanAccount[2],ACCOUNT_PROPERTYDEBT)
			[+] if(iSelect==PASS)
				[ ] ReportStatus("Verify Edited Loan on Account Bar",PASS,"Updated loan name is displayed in Account bar")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // Verify Interest rate on Loan dashboard
				[ ] sCaption=MDIClientLoans.LoanWindow.InterestRateAmount.Getproperty("caption")
				[+] if(MatchStr("{iInterestRate}*",sCaption))
					[ ] ReportStatus("Verify Edited Interest rate on Loan dashboard",PASS,"Interest rate is updated on Loan dashboard - Interest Rate - {sCaption}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Edited Interest rate on Loan dashboard",FAIL,"Interest rate is not updated on Loan dashboard - Actual Interest Rate - {sCaption}, Expected {iInterestRate}")
					[ ] 
				[ ] 
				[ ] // Verify Original Balance on Loan dashboard
				[ ] sCaption=MDIClientLoans.LoanWindow.OriginalBalanceText.Getproperty("caption")
				[+] if(MatchStr("{sOriginalBalance}*",sCaption))
					[ ] ReportStatus("Verify Edited Original Balance on Loan dashboard",PASS,"Original Balance is updated on Loan dashboard - Original Balance- {sCaption}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Edited Original Balance on Loan dashboard",FAIL,"Original Balance is not updated on Loan dashboard - Actual Original Balance - {sCaption}, Expected {sOriginalBalance}")
					[ ] 
				[ ] 
				[ ] // Verify Original Length on Loan dashboard
				[ ] sCaption=MDIClientLoans.LoanWindow.OriginalLengthText.Getproperty("caption")
				[ ] 
				[+] if(MatchStr("{iOriginalLength}*{lsEditLoanAccount[9]}",sCaption))
					[ ] ReportStatus("Verify Edited Original Length on Loan dashboard",PASS,"Original Length is updated on Loan dashboard - Original Length - {sCaption}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Edited Original Length on Loan dashboard",FAIL,"Original Length is not updated on Loan dashboard - Actual Original Length - {sCaption}, Expected {iOriginalLength}{lsEditLoanAccount[9]}")
					[ ] 
				[ ] 
				[ ] // Verify Compounding Period on Loan dashboard
				[ ] 
				[ ] sCaption=MDIClientLoans.LoanWindow.CompoundingPeriodText.Getproperty("caption")
				[+] if(MatchStr("*{lsEditLoanAccount[10]}",sCaption))
					[ ] ReportStatus("Verify Edited Compounding Period on Loan dashboard",PASS,"Compounding Period is updated on Loan dashboard - Compounding Period - {sCaption}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Edited Compounding Period on Loan dashboard",FAIL,"Compounding Period is not updated on Loan dashboard - Actual Compounding Period - {sCaption}, Expected {lsEditLoanAccount[10]}")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Verify Origination Date on Loan dashboard
				[ ] sCaption=MDIClientLoans.LoanWindow.OriginationDateText.Getproperty("caption")
				[ ] dDate=AddDateTime (GetDateTime(), -2)
				[ ] sDate=FormatDateTime(dDate,"mmm d yyyy")
				[+] if(MatchStr("*{sDate}*",sCaption))
					[ ] ReportStatus("Verify Edited Origination Date on Loan dashboard",PASS,"Origination Date is updated on Loan dashboard - Origination Date - {sCaption}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Edited Origination Date on Loan dashboard",FAIL,"Origination Date is not updated on Loan dashboard - Actual Origination Date - {sCaption}, Expected {sDate}")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Edited Loan on Account Bar",FAIL,"Updated loan name is not displayed in Account bar")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Edit all fields for Manual loan account {lsEditLoanAccount[2]}",FAIL,"All fields are not updated for {sUpdatedLoanName} account")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################################
[+] //##########  Verify that Calculator icon should be present beside the <Frequency> Payment text field #######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_VerifyCalculatorForFrequencyOnlineLoanAccount
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //  Verify that Calculator icon should be present beside the <Frequency> Payment text field
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Calculator icon is present beside the <Frequency> Payment text field
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 13th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test9_VerifyCalculatorForFrequencyOnlineLoanAccount() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
		[ ] lsEditLoanAccount=lsExcelData[2]
		[ ] 
		[ ] 
	[ ] 
	[ ] //Select Loan Account
	[ ] iValidate=SelectAccountFromAccountBar(lsEditLoanAccount[2],ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] // Click on Edit Terms button
		[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
		[ ] WaitForState(LoanDetails,TRUE,5)
		[ ] 
		[+] if(LoanDetails.Exists(5))
			[+] if(LoanDetails.FrequencyPaymentCalculator.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Calculator icon is present beside the <Frequency> Payment text field",PASS,"Calculator  icon is present beside the <Frequency> Payment text field")
			[+] else
				[ ] ReportStatus("Verify Calculator icon is present beside the <Frequency> Payment text field",FAIL,"Recalculate  icon is not present beside the <Frequency> Payment text field")
				[ ] 
			[ ] LoanDetails.Cancel.Click()
			[ ] // LoanDetails.CancelButton.Click()
			[ ] WaitForState(LoanDetails,FALSE,SHORT_SLEEP)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################################
[ ] 
[+] //########## Verify that Help icons should be available for - Compounding Period<Frequency> Payment Edit D1 screen  #######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_VerifyHelpIconForCompoundingPeriodFiled
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify that Help icons should be available for - Compounding Period<Frequency> Payment Edit D1 screen for online loan account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If help icon is present beside the Compounding Period<Frequency> Payment Edit D1 screen
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 14th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test10_VerifyHelpIconForCompoundingPeriodFiled() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
		[ ] lsEditLoanAccount=lsExcelData[2]
		[ ] 
	[ ] 
	[ ] // //Select Loan Account
	[ ] iValidate=SelectAccountFromAccountBar(lsEditLoanAccount[2],ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] // Click on Edit Terms button
		[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
		[ ] WaitForState(LoanDetails,TRUE,5)
		[ ] 
		[+] if(LoanDetails.Exists(5))
			[+] if(LoanDetails.HelpIconForCompoundingPeriod.Exists(SHORT_SLEEP))
				[ ] ReportStatus("Verify Help icon is present beside the Compounding Period drop down",PASS,"Help  icon is present beside the Cpompounding Period drop down")
			[+] else
				[ ] ReportStatus("Verify Help icon is present beside the Compounding Period drop down",FAIL,"Help  icon is not present beside the Cpompounding Period drop down")
				[ ] 
			[ ] 
			[ ] LoanDetails.Cancel.Click()
			[ ] WaitForState(LoanDetails,FALSE,SHORT_SLEEP)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###############################################################################################################
[ ] // 
[ ] 
[+] //##########Verify that if we  edit interest rate as '0' it should get reflected on dashboard in full payment schedule    #######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_VerifyZeroInterestRate()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify that if we  edit interest rate as '0' it should get reflected on dashboard in full payment schedule 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If full payment schedule is displayed on loan dashboard
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 14th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test11_VerifyZeroInterestRate() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sInterestRate="0"
		[ ] STRING sMessage="Quicken has recalculated the loan payment and schedule based on the new loan terms."
		[ ] 
		[ ] // Read online loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
		[ ] lsEditLoanAccount=lsExcelData[2]
		[ ] 
		[ ] // lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
		[ ] // lsEditLoanAccount=lsExcelData[1]
		[ ] 
	[ ] 
	[ ] //Select Loan Account
	[ ] iValidate=SelectAccountFromAccountBar(lsEditLoanAccount[2],ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] // Click on Edit Terms button
		[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
		[ ] WaitForState(LoanDetails,TRUE,5)
		[ ] 
		[+] if(LoanDetails.Exists(5))
			[ ] 
			[ ] LoanDetails.CurrentInterestRateTextField.SetText("0")
			[ ] LoanDetails.OKButton.Click()
			[+] if(AlertMessage.Exists(2))
				[ ] AlertMessage.SetActive()
				[ ] sCaption=AlertMessage.MessageText.GetCaption()
				[+] if(MatchStr(sCaption,sMessage))
					[ ] ReportStatus("Verify Alert message after updating frequency",PASS,"Correct Alert message is displayed. Message  - {sMessage}")
				[+] else
					[ ] ReportStatus("Verify Alert message after updating frequency",FAIL,"Correct Alert message is displayed. Actual Message  - {sCaption} and Expected Message - {sMessage}")
					[ ] 
				[ ] 
				[ ] AlertMessage.SetActive()
				[ ] AlertMessage.OK.Click()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify alert message exists",FAIL,"Alert message window does not exist")
			[ ] WaitForState(LoanDetails,FALSE,SHORT_SLEEP)
			[ ] 
			[ ] 
			[ ] // Verify Interest rate on Loan dashboard
			[ ] sCaption=MDIClientLoans.LoanWindow.InterestRateAmount.Getproperty("caption")
			[+] if(MatchStr("{sInterestRate}*",sCaption))
				[ ] ReportStatus("Verify Zero Interest rate on Loan dashboard",PASS,"Interest rate is updated on Loan dashboard - Interest Rate - {sCaption}")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Zero Interest rate on Loan dashboard",FAIL,"Interest rate is not updated on Loan dashboard - Actual Interest Rate - {sCaption}, Expected {sInterestRate}")
				[ ] 
			[ ] 
			[ ] // Navigate to Payment Details tab
			[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
			[ ] 
			[ ] //Verify interest rate on Payment details dashboard is updated to zero
			[ ] sHandle=Str(PaymentDetailsListBox.GetHandle())
			[ ] iCount=PaymentDetailsListBox.GetItemCount()
			[+] for(i=0;i<=iCount;i++)
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(i))
				[ ] bMatch = MatchStr("*Interest*0.00%*", sActual)
				[+] if (bMatch)
					[ ] break
			[+] if (bMatch)
				[ ] ReportStatus("Interest rate is updated zero on Payment Details dashboard",PASS,"Interest rate is updated zero on Payment Details dashboard")
			[+] else
				[ ] ReportStatus("Interest rate is updated zero on Payment Details dashboard",FAIL,"Interest rate is not updated zero on Payment Details dashboard, Actual = {sActual} Expected = 0")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###############################################################################################################
[ ] 
[ ] // 
[ ] // 
[ ] // //===========================================================================================
[ ] // //================================= Edit Loan Payment Details  =======================================
[ ] // //===========================================================================================
[ ] // 
[ ] 
[+] //##########Verify that Edit DM2 can be opened from Payment Details tab >> Edit Payment details link######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_VerifyEditManualLoanAccountFromPaymentDetailsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Edit DM2 can be opened from Payment Details tab >> Edit Payment details link.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Edit DM2 can be opened from Payment Details tab >> Edit Payment details link
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 16th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01_VerifyEditManualLoanAccountFromPaymentDetailsTab() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] BOOLEAN bDeleteTrue
	[ ] 
	[ ] 
	[ ] // Read manual loan account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
	[ ] lsAddLoanAccount=lsExcelData[3]
	[ ] lsAddLoanAccount[3]=sDate
	[ ] 
	[ ] //Add Loan account
	[ ] iValidate=AddEditManualLoanAccount(lsAddLoanAccount[1],lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],lsAddLoanAccount[7],lsAddLoanAccount[8])
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account is added")
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[2],ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Verification
			[ ] 
			[ ] // Click on Payment Details tab
			[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
			[ ]  QuickenRestoreAndResize()
			[+] if(MDIClientLoans.LoanWindow.EditPaymentDetails.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Edit Payment Details link on Payment Details tab for manual loan account",PASS,"Edit Payment Details link is displayed on Payment Details tab for manual loan account")
				[ ] MDIClientLoans.LoanWindow.EditPaymentDetails.Click()
				[+] if(LoanDetails.Exists(5))
					[+] if(LoanDetails.NextPaymentDueTextField.Exists(5))
						[ ] ReportStatus("Verify Loan Details DM2 screen should open in Edit mode",PASS,"Loan Details DM2 screen is opened in Edit mode")
					[+] else
						[ ] ReportStatus("Verify Loan Details DM2 screen should open in Edit mode",FAIL,"Loan Details DM2 screen is not opened in Edit mode")
						[ ] 
					[ ] LoanDetails.Close()
					[ ] WaitForState(LoanDetails,FALSE,5)
				[+] else
					[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify loan details window launched",FAIL,"Loan details window not displayed")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add Manual loan account",FAIL,"Manual loan account not added")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################################
[ ] 
[+] //########## Verify that Edit DM2 can be opened from Monthly payment >> Edit link.  ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_VerifyEditManualLoanAccountFromMonthlyPaymentEdit
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that Edit DM2 can be opened from Monthly payment >> Edit link.  
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Edit DM2 can be opened from Monthly payment >> Edit link.  
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 16th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test02_VerifyEditManualLoanAccountFromMonthlyPaymentEdit() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] BOOLEAN bDeleteTrue
	[ ] 
	[ ] // Read manual loan account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
	[ ] lsAddLoanAccount=lsExcelData[3]
	[ ] lsAddLoanAccount[3]=sDate
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[2],ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] // Verification
		[ ] 
		[ ] // Click on Payment Details tab
		[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
		[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
			[ ] 
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[+] if(LoanDetails.NextPaymentDueTextField.Exists(5))
					[ ] ReportStatus("Verify Loan Details DM2 screen should open in Edit mode",PASS,"Loan Details DM2 screen is opened in Edit mode from Monthly payment >> Edit link")
				[+] else
					[ ] ReportStatus("Verify Loan Details DM2 screen should open in Edit mode",FAIL,"Loan Details DM2 screen is not opened in Edit mode from Monthly payment >> Edit link")
					[ ] 
				[ ] LoanDetails.Close()
				[ ] WaitForState(LoanDetails,FALSE,5)
			[+] else
				[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for manual loan account")
			[ ] 
		[ ] 
		[ ] 
		[ ] // //Delete Loan Account
		[ ] // iValidate=ModifyAccount(sMDIWindow,lsAddLoanAccount[1],sDeleteAction)
		[+] // if(iValidate==PASS)
			[ ] // ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
			[ ] // bDeleteTrue=TRUE
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################################
[ ] 
[+] //########## Verify that Next Payment date can be edited and its changes are correctly reflected on dashboard######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_EditNextPaymentDateFromMonthlyPaymentEdit
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that Next Payment date can be edited and its changes are correctly reflected on dashboard
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Next Payment date is edited and its changes are correctly reflected on dashboard
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 17th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test03_EditNextPaymentDateFromMonthlyPaymentEdit() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sExpectedDate
		[ ] DATETIME dDate
		[ ] 
	[ ] 
	[ ] // Read manual loan account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
	[ ] lsAddLoanAccount=lsExcelData[3]
	[ ] lsAddLoanAccount[3]=sDate
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[2],ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] // Click on Loan Details tab
		[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
		[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
			[ ] 
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] //Edit Next Due date
				[+] if(LoanDetails.NextPaymentDueTextField.Exists(5))
					[ ] ReportStatus("Verify Loan Details DM2 screen should open in Edit mode",PASS,"Loan Details DM2 screen is opened in Edit mode from Monthly payment >> Edit link")
					[ ] sDate=ModifyDate(29,sDateFormat)
					[ ] sExpectedDate=sDate
					[ ] LoanDetails.NextPaymentDueTextField.SetText(sDate)
					[ ] LoanDetails.OKButton.Click()
					[ ] WaitForState(LoanDetails,FALSE,5)
					[ ] 
					[ ] // Verify Next Due date is edited successfully
					[ ] //1. Next payment due date should get changed with the new value on dashboard
					[ ] 
					[ ] sCaption=MDIClientLoans.LoanWindow.NextDueDate.Getproperty("caption")
					[ ] dDate=AddDateTime (GetDateTime(),29)
					[ ] sDate=FormatDateTime(dDate,"mmm d yyyy")
					[+] if(MatchStr("*{sDate}*",sCaption))
						[ ] ReportStatus("Verify Edited Next Due Date on Loan dashboard",PASS,"Next Due Date is updated on Loan dashboard - Next Due Date - {sCaption}")
					[+] else
						[ ] ReportStatus("Verify Edited Next Due Date on Loan dashboard",FAIL,"Next Due Date is not updated on Loan dashboard - Actual Next Due  Date - {sCaption}, Expected {sDate}")
					[ ] 
					[ ] // 2. On legend beside  Projected Payoff graph
					[ ] 
					[ ] sCaption=MDIClientLoans.LoanWindow.NextDueDateOnPayOffLegendText.Getproperty("caption")
					[ ] sDate=FormatDateTime(dDate,"d")
					[+] if(MatchStr("*{sDate}*",sCaption))
						[ ] ReportStatus("Verify Edited Next Due Date is displayed legend beside  Projected Payoff graph on Loan dashboard",PASS,"Next Due Date is updated on legend beside  Projected Payoff graph")
					[+] else
						[ ] ReportStatus("Verify Edited Next Due Date legend beside  Projected Payoff graph",FAIL,"Next Due Date is not updated on legend beside  Projected Payoff graph - Payoff date- {sCaption}, Expected date {sDate}")
					[ ] 
					[ ] 
					[ ] // 3. Reminders scheduled for that loan account on 'Edit' dialogs
					[ ] iSelect=NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
					[+] if(iSelect==PASS)
						[ ] QuickenWindow.SetActive()
						[ ] MDIClient.Bills.ViewAsPopupList.Select("Stack")
						[ ] MDIClient.Bills.DueWithinNextPopupList.Select("30 Days")
						[ ] MDIClient.Bills.Edit.Click()
						[+] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] sActualDueNextOn= LoanPaymentReminder.DueNextOnTextField.GetText()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] sExpectedDate=ModifyDate(29, "m/d/yyyy")
							[+] if(sActualDueNextOn==sExpectedDate)
								[ ] ReportStatus("Verify updated Next Due Date for Edit Reminder",PASS,"Updated Next due date is displayed on Edit Reminder window")
							[+] else
								[ ] ReportStatus("Verify updated Next Due Date for Edit Reminder",FAIL,"Updated Next due date is not displayed on Edit Reminder window Actual - {sActualDueNextOn} and Expected - {sExpectedDate}")
								[ ] 
							[ ] WaitForState(LoanPaymentReminder , false ,5)
						[+] else
							[ ] ReportStatus("Verify Edit Loan Payment Reminder window", FAIL, "Edit Loan Payment Reminder window is not opened after clicking on Edit button for loan reminder")
						[ ] 
						[ ] 
						[ ] //4. Reminders scheduled for that loan account on 'Enter' dialogs
						[ ] MDIClient.Bills.Enter.Click()
						[ ] //Verify edited value of DueNextOn Textfield
						[+] if(EnterExpenseIncomeTxn.Exists(5))
							[ ] EnterExpenseIncomeTxn.SetActive()
							[ ] sActualDueNextOn= EnterExpenseIncomeTxn.PaymentDateTextField.GetText()
							[+] if(sActualDueNextOn==sExpectedDate)
								[ ] ReportStatus("Verify updated Next Due Date for Enter Loan Reminder",PASS,"Updated Next due date is displayed on Enter loan  Reminder window")
							[+] else
								[ ] ReportStatus("Verify updated Next Due Date for Enter Loan Reminder",FAIL,"Updated Next due date is not displayed on Enter loan Reminder window Actual - {sActualDueNextOn} and Expected - {sExpectedDate}")
								[ ] 
							[ ] EnterExpenseIncomeTxn.Cancel.Click()
							[ ] WaitForState(EnterExpenseIncomeTxn , false ,5)
						[+] else
							[ ] ReportStatus("Verify Enter Expense transaction window", FAIL, "Enter Expense transaction window is not opened after clicking on Enter button for loan reminder")
					[+] else
						[ ] ReportStatus("Navigation to Bills tab",FAIL, "Navigation to Bills tab is failed")
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Loan Details DM2 screen should open in Edit mode",FAIL,"Loan Details DM2 screen is not opened in Edit mode from Monthly payment >> Edit link")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for manual loan account")
			[ ] 
		[ ] 
		[ ] 
		[ ] // //Delete Loan Account
		[ ] // iValidate=ModifyAccount(sMDIWindow,lsAddLoanAccount[1],sDeleteAction)
		[+] // if(iValidate==PASS)
			[ ] // ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
			[ ] // bDeleteTrue=TRUE
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################
[ ] 
[+] //##########Verify that Principal and Interest fields are non-editable and has a '$' symbol against each value######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_PrincipalAndInterestFieldsNotEditableForManualLoanAccount
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that Principal and Interest fields are non-editable and has a '$' symbol against each value for manual Loan account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Principal and Interest fields are non-editable and has a '$' symbol
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 17th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test04_PrincipalAndInterestFieldsNotEditableForManualLoanAccount() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sActualClassName, sExpectedClassName="Edit"
		[ ] DATETIME dDate
		[ ] 
	[ ] 
	[ ] // Read manual loan account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
	[ ] lsAddLoanAccount=lsExcelData[3]
	[ ] lsAddLoanAccount[3]=sDate
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[2],ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] //Click on Loan Details tab
		[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
		[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
			[ ] 
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] //Verify Principal is non editable 
				[+] if(LoanDetails.PrincipalText.Exists(5))
					[ ] sActualClassName=LoanDetails.PrincipalText.GetProperty("windowClassName")
					[+] if(sActualClassName!=sExpectedClassName)
						[ ] ReportStatus("Verify Principal field is non editable",PASS,"Principal field is non editable in Edit mode from Monthly payment >> Edit link")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Principal field is non editable",FAIL,"Principal field is editable in Edit mode from Monthly payment >> Edit link, Actula class {sActualClassName} and Expected class {sExpectedClassName}")
						[ ] 
					[ ] 
					[ ] //Verify $ is displayed with value
					[ ] sActual=LoanDetails.PrincipalText.GetText()
					[ ] bMatch=MatchStr("$*",sActual)
					[+] if(bMatch)
						[ ] ReportStatus("Verify $ is displayed with Principal amount ",PASS,"$ is displayed with Principal amount")
						[ ] 
					[+] else 
						[ ] ReportStatus("Verify $ is displayed with Principal amount ",FAIL,"$ is not displayed with Principal amount")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Principal Text is present on Loan Details window", FAIL, "Principal Text is not present on Loan Details window")
				[ ] 
				[ ] //Verify Interest is non editable 
				[+] if(LoanDetails.InterestText.Exists(5))
					[ ] sActualClassName=LoanDetails.InterestText.GetProperty("windowClassName")
					[+] if(sActualClassName!=sExpectedClassName)
						[ ] ReportStatus("Verify Interest field is non editable",PASS,"Interest field is non editable in Edit mode from Monthly payment >> Edit link")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Interest field is non editable",FAIL,"Interest field is editable in Edit mode from Monthly payment >> Edit link, Actula class {sActualClassName} and Expected class {sExpectedClassName}")
						[ ] 
					[ ] 
					[ ] //Verify $ is displayed with value
					[ ] sActual=LoanDetails.InterestText.GetText()
					[ ] bMatch=MatchStr("$*",sActual)
					[+] if(bMatch)
						[ ] ReportStatus("Verify $ is displayed with Interest amount ",PASS,"$ is displayed with Interest amount")
						[ ] 
					[+] else 
						[ ] ReportStatus("Verify $ is displayed with Interest amount ",FAIL,"$ is not displayed with Interest amount")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Interest Text is present on Loan Details window", FAIL, "Interest Text is not present on Loan Details window")
				[ ] 
				[ ] 
				[ ] LoanDetails.SetActive()
				[ ] LoanDetails.Close()
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for manual loan account")
			[ ] 
		[ ] 
		[ ] 
		[ ] // //Delete Loan Account
		[ ] // iValidate=ModifyAccount(sMDIWindow,lsAddLoanAccount[1],sDeleteAction)
		[+] // if(iValidate==PASS)
			[ ] // ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
			[ ] // bDeleteTrue=TRUE
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[ ] 
[+] //##########'Extra Principal paid monthly' field should be editable and the green arrow should be pointing to Total payment ######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_VerifyExtraPrincipalPaidEditable
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that when 'Extra  Principal determines total' radio button is selected, then 'Extra Principal paid monthly' field should be editable and the green arrow should be pointing to Total payment 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Extra Principal paid monthly' field should be editable and the green arrow should be pointing to Total payment
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 17th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test05_VerifyExtraPrincipalPaidEditable() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sActualClassName, sExpectedClassName="Edit"
		[ ] DATETIME dDate
		[ ] 
	[ ] 
	[ ] // Read manual loan account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
	[ ] lsAddLoanAccount=lsExcelData[3]
	[ ] lsAddLoanAccount[3]=sDate
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[2],ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] //Click on Loan Details tab
		[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
		[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
			[ ] 
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] //Verify that when 'Extra  Principal determines total' radio button is selected, then 'Extra Principal paid monthly' field should be editable 
				[ ] LoanDetails.ExtraPrincipalDeterminesTotal.Select("Extra principal determines total")
				[+] if(LoanDetails.ExtraPrincipalPaidMonthly.Exists(5))
					[ ] sActualClassName=LoanDetails.ExtraPrincipalPaidMonthly.GetProperty("windowClassName")
					[+] if(sActualClassName==sExpectedClassName)
						[ ] ReportStatus("Verify that when 'Extra  Principal determines total' radio button is selected, then 'Extra Principal paid monthly' field should be editable ",PASS,"'Extra Principal paid monthly' field is editable as 'Extra  Principal determines total' radio button is selected ")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that when 'Extra  Principal determines total' radio button is selected, then 'Extra Principal paid monthly' field should be editable ",FAIL,"'Extra Principal paid monthly' field is not editable even if 'Extra  Principal determines total' radio button is selected ")
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Principal Text is present on Loan Details window", FAIL, "Principal Text is not present on Loan Details window")
				[ ] 
				[ ] //Verify green arrow should be pointing to Total payment 
				[+] if(LoanDetails.GreenArrowIcon.Exists(5))
					[ ] ReportStatus("Verify green arrow should be displayed",PASS,"green arrow is displayed besides 'Extra Principal paid monthly' field")
				[+] else
					[ ] ReportStatus("Verify green arrow should be displayed",PASS,"green arrow is displayed besides 'Extra Principal paid monthly' field")
					[ ] 
				[ ] 
				[ ] LoanDetails.SetActive()
				[ ] LoanDetails.Close()
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for manual loan account")
			[ ] 
		[ ] 
		[ ] 
		[ ] // //Delete Loan Account
		[ ] // iValidate=ModifyAccount(sMDIWindow,lsAddLoanAccount[1],sDeleteAction)
		[+] // if(iValidate==PASS)
			[ ] // ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
			[ ] // bDeleteTrue=TRUE
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[ ] 
[+] //##########Verify that when 'Total determines Extra  Principal' radio button is selected, then 'Total payment' field should be non editable######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_VerifyTotalDeterminesExtraPrincipalOption
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //6. Verify that when 'Total determines Extra  Principal' radio button is selected, then 'Total payment' field should be editable and the green arrow should be pointing to 'Extra Principal paid monthly' field.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Total Determines Extra Principal field should be non editable and the green arrow should be pointing to 'Extra Principal paid monthly' field
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 3rd Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test06_VerifyTotalDeterminesExtraPrincipalOption() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sActualClassName, sExpectedClassName="Static"
		[ ] DATETIME dDate
		[ ] 
	[ ] 
	[ ] // Read manual loan account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
	[ ] lsAddLoanAccount=lsExcelData[3]
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[2],ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] //Click on Loan Details tab
		[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
		[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
			[ ] 
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] //Verify that when 'Total determines Extra  Principal' radio button is selected, then 'Extra Principal paid monthly' field should be non editable 
				[ ] LoanDetails.ExtraPrincipalDeterminesTotal.Select("Total determines extra principal")
				[+] if(LoanDetails.ExtraPrincipalPaidMonthlyText.Exists(5))
					[ ] sActualClassName=LoanDetails.ExtraPrincipalPaidMonthlyText.GetProperty("windowClassName")
					[+] if(sActualClassName==sExpectedClassName)
						[ ] ReportStatus("Verify that when 'Total determines Extra  Principal' radio button is selected, then 'Extra Principal paid monthly' field should be non editable ",PASS,"'Extra  Principal determines total' field is non editable as 'Total determines Extra  Principal' radio button is selected ")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that when 'Extra  Principal determines total' radio button is selected, then 'Extra Principal paid monthly' field should be non editable ",FAIL,"'Extra Principal paid monthly' field is  editable even if 'Total determines Extra  Principal' radio button is selected ")
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Principal Text is present on Loan Details window", FAIL, "Principal Text is not present on Loan Details window")
				[ ] 
				[ ] //Verify green arrow should be pointing to Total payment 
				[+] if(LoanDetails.GreenArrowIcon.Exists(5))
					[ ] ReportStatus("Verify green arrow should be displayed",PASS,"green arrow is displayed besides 'Extra Principal paid monthly' field")
				[+] else
					[ ] ReportStatus("Verify green arrow should be displayed",PASS,"green arrow is displayed besides 'Extra Principal paid monthly' field")
					[ ] 
				[ ] 
				[ ] LoanDetails.SetActive()
				[ ] LoanDetails.Close()
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for manual loan account")
			[ ] 
		[ ] 
		[ ] 
		[ ] // //Delete Loan Account
		[ ] // iValidate=ModifyAccount(sMDIWindow,lsAddLoanAccount[1],sDeleteAction)
		[+] // if(iValidate==PASS)
			[ ] // ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
			[ ] // bDeleteTrue=TRUE
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[+] //##########Verify that Loan Payment Options dialog should open on clicking on Payment Options button ######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_VerifyLoanPaymentOptions
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify that Loan Payment Options dialog should open on clicking on Payment Options button.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Loan Payment Options dialog should open on clicking on Payment Options button
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 3rd Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test07_VerifyLoanPaymentOptions () appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sActual, sExpected="Loan Reminder"
		[ ] 
	[ ] 
	[ ] // Read manual loan account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
	[ ] lsAddLoanAccount=lsExcelData[3]
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[2],ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] //Click on Loan Details tab
		[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
		[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
			[ ] 
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] //Verify that Payment Options Button is displayed
				[+] if(LoanDetails.PaymentOptionsButton.Exists(2))
					[ ] // Click Payment Options Button
					[ ] LoanDetails.PaymentOptionsButton.Click()
					[ ] //Verify Loan Payment Option window is displayed
					[+] if(LoanPaymentOptions.Exists(3))
						[ ] sActual=LoanPaymentOptions.LoanReminder.GetSelItem()
						[ ] // Verify default selected payment option
						[+] if(sActual==sExpected)
							[ ] ReportStatus("Verify that 'Loan Reminder' should be default selection. ",PASS,"''Loan Reminder' is default selection.")
							[ ] 
						[+] else 
							[ ] ReportStatus("Verify that 'Loan Reminder' should be default selection.",FAIL,"'Loan Reminder' is not default selection. Actual - {sActual}, Expected - {sExpected} ")
							[ ] 
						[ ] LoanPaymentOptions.Close()
					[+] else
						[ ] ReportStatus("Verify Loan Payment Options window",FAIL,"Loan Payment Options window is not displayed")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Payment Options Button is present on Loan Details window", FAIL, "Payment Options Button is not present on Loan Details window")
				[ ] 
				[ ] LoanDetails.SetActive()
				[ ] LoanDetails.Close()
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for manual loan account")
			[ ] 
		[ ] 
		[ ] 
		[ ] // //Delete Loan Account
		[ ] // iValidate=ModifyAccount(sMDIWindow,lsAddLoanAccount[1],sDeleteAction)
		[+] // if(iValidate==PASS)
			[ ] // ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
			[ ] // bDeleteTrue=TRUE
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[+] //##########Verify that 'Edit Loan Reminder' option should open 'Edit Loan Payment Reminder' screen. ######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_VerifyEditLoanReminderForManualLoanAccount
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify that 'Edit Loan Reminder' option should open 'Edit Loan Payment Reminder' screen.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  'Edit Loan Reminder' option should open 'Edit Loan Payment Reminder' screen.
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 3rd Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test08_VerifyEditLoanReminderForManualLoanAccount () appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sActual, sExpected="Edit Loan Payment Reminder"
		[ ] 
	[ ] 
	[ ] // Read manual loan account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
	[ ] lsAddLoanAccount=lsExcelData[3]
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[2],ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] //Click on Loan Details tab
		[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
		[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
			[ ] 
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] //Verify that Edit Loan Reminder Button is displayed
				[+] if(LoanDetails.EditLoanReminderButton.Exists(3))
					[ ] // Click Edit Loan Reminder Button
					[ ] LoanDetails.EditLoanReminderButton.Click()
					[ ] //Verify Loan Payment Reminder window is displayed
					[+] if(LoanPaymentReminder.Exists(3))
						[ ] sActual=LoanPaymentReminder.GetCaption()
						[ ] // Verify window name
						[+] if(sActual==sExpected)
							[ ] ReportStatus("Verify that Loan Payment Reminder window",PASS,"Edit Loan Payment Reminder window is displayed")
							[ ] 
						[+] else 
							[ ] ReportStatus("Verify that Loan Payment Reminder window",FAIL,"Edit Loan Payment Reminder window is not displayed, sAcutal - {sActual}, Expected - {sExpected}")
							[ ] 
						[ ] LoanPaymentReminder.Close()
					[+] else
						[ ] ReportStatus("Verify Loan Payment Options window",FAIL,"Loan Payment Options window is not displayed")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Payment Options Button is present on Loan Details window", FAIL, "Payment Options Button is not present on Loan Details window")
				[ ] 
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for manual loan account")
			[ ] 
		[ ] 
		[ ] 
		[ ] // //Delete Loan Account
		[ ] // iValidate=ModifyAccount(sMDIWindow,lsAddLoanAccount[1],sDeleteAction)
		[+] // if(iValidate==PASS)
			[ ] // ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
			[ ] // bDeleteTrue=TRUE
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[ ] 
[ ] 
[+] //##########Verify that Cancel button does not save any changes made on Edit DM2 screen. ###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_VerifyCancelButtonForEditLoanDetils
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //10. Verify that Cancel button does not save any changes made on Edit DM2 screen.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  Cancel button does not save any changes made on Edit DM2 screen.
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 5th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test09_VerifyCancelButtonForEditLoanDetails () appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sActual1,sActual2, sExpected="Edit Loan Payment Reminder"
		[ ] STRING sUpdateDate=ModifyDate(15,sDateFormat)
		[ ] 
	[ ] 
	[ ] // Read manual loan account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
	[ ] lsAddLoanAccount=lsExcelData[3]
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[2],ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] //Click on Loan Details tab
		[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
		[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
			[ ] 
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.SetActive()
				[+] if(LoanDetails.NextPaymentDueTextField.Exists(5))
					[ ] sActual1=LoanDetails.NextPaymentDueTextField.GetText()
					[ ] LoanDetails.NextPaymentDueTextField.SetText(sUpdateDate)
					[ ] LoanDetails.SetActive()
					[+] if(LoanDetails.CancelButton.Exists())
						[ ] LoanDetails.TextClick("Cancel")
						[ ] 
						[ ] 
					[ ] WaitForState(LoanDetails,FALSE,5)
					[ ] 
					[ ] //Verify that date has not been changed as cancel button is clicked
					[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
					[+] if(LoanDetails.Exists(5))
						[ ] LoanDetails.SetActive()
						[+] if(LoanDetails.NextPaymentDueTextField.Exists(5))
							[ ] sActual2=LoanDetails.NextPaymentDueTextField.GetText()
							[+] if(sActual1==sActual2)
								[ ] ReportStatus("Verify next due date is not updated after clicking on Cancel button ",PASS,"Next due date is not updated after clicking on Cancel button")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify next due date is not updated after clicking on Cancel button ",FAIL,"Next due date is updated even after clicking on Cancel button")
								[ ] 
						[+] else
							[ ] ReportStatus("Verify Loan Details window > Next Payment Due TextField",FAIL,"Loan Details window > Next Payment Due TextField is not displayed")
							[ ] 
						[ ] LoanDetails.SetActive()
						[+] if(LoanDetails.CancelButton.Exists())
							[ ] LoanDetails.TextClick("Cancel")
							[ ] 
							[ ] 
						[ ] 
						[ ] WaitForState(LoanDetails,FALSE,5)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Next Payment Due TextField on Loan Details dashboard for manual loan account",FAIL,"Next Payment Due TextField on Loan Details dashboard for manual loan account NOT found")
					[ ] 
					[ ] 
				[ ] 
				[ ] sleep(2)
			[+] else
				[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for manual loan account")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] // //Delete Loan Account
		[ ] // iValidate=ModifyAccount(sMDIWindow,lsAddLoanAccount[1],sDeleteAction)
		[+] // if(iValidate==PASS)
			[ ] // ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
			[ ] // bDeleteTrue=TRUE
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[ ] 
[+] //##########Verify that while calculating the Total payment, value provided in Other Category is not calculated in Full Payment schedule###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_VerifyFullPaymentScheduleForOtherCategory
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //11. Verify that while calculating the Total payment, value provided in Other Category is not calculated in Full Payment schedule.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Other Category value is not calculated in Full Payment schedule
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 7th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test10_VerifyFullPaymentScheduleForOtherCategory() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sExpected,sAmount, sCategory="Other Inc"
		[ ] STRING sUpdateDate=ModifyDate(15,sDateFormat)
		[ ] sAmount="28"
	[ ] 
	[ ] // Read manual loan account data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
	[ ] lsAddLoanAccount=lsExcelData[3]
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[2],ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] //Click on Payment Details tab
		[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
		[ ] //To handle payment details flickering issue
		[ ] QuickenRestoreAndResize()
		[ ] 
		[+] if(MDIClientLoans.LoanWindow.PaymentDetailsPanel.PaymentPieChart.FullPaymentScheduleButton.Exists(3))
			[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.PaymentPieChart.FullPaymentScheduleButton.Click()
			[+] if(DlgLoanSchedule.Exists(3))
				[ ] DlgLoanSchedule.SetActive()
				[ ] //Verify payment in full payment schedule
				[ ] sHandle=Str(PaymentDetailsListBox.GetHandle())
				[ ] iCount=PaymentDetailsListBox.GetItemCount()
				[+] for(i=0;i<=iCount;i++)
					[ ] sExpected= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(i))
					[ ] bMatch = MatchStr("*%*", sExpected)
					[+] if (bMatch)
						[ ] break
				[ ] DlgLoanSchedule.DoneButton.Click()
				[ ] WaitForState(DlgLoanSchedule,FALSE,5)
				[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
					[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
					[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
					[+] if(LoanDetails.Exists(5))
						[ ] LoanDetails.SetActive()
						[ ] LoanDetails.EditCategoryButton.Click()
						[+] if(SplitTransaction.Exists(3))
							[ ] SplitTransaction.SetActive()
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_ENTER)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(sCategory)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_TAB)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.TypeKeys(KEY_TAB)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(sAmount)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField4.TypeKeys(KEY_ENTER)
							[ ] sleep(2)
							[+] if (SplitTransaction.Adjust.IsEnabled())
								[ ] SplitTransaction.Adjust.Click()
							[ ] SplitTransaction.OK.Click()
							[ ] WaitForState(SplitTransaction,False,1)
							[ ] ReportStatus("Add other category",PASS,"Other Category is added by Split Transaction window")
							[ ] 
							[ ] LoanDetails.SetActive()
							[ ] LoanDetails.OKButton.Click()
							[ ] 
							[ ] //Verify Other category on Payment details dashboard is added
							[ ] sHandle=Str(PaymentDetailsListBox.GetHandle())
							[ ] iCount=PaymentDetailsListBox.GetItemCount()
							[+] for(i=0;i<=iCount;i++)
								[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(i))
								[ ] bMatch = MatchStr("*{sCategory}*{sAmount}*", sActual)
								[+] if (bMatch)
									[ ] break
							[+] if (bMatch)
								[ ] ReportStatus("Other category is added on Payment Details dashboard",PASS,"Other category is added on Payment Details dashboard, Category - {sCategory}, Amount - {sAmount}")
							[+] else
								[ ] ReportStatus("Other category is added on Payment Details dashboard",FAIL,"Other category is not added on Payment Details dashboard, Expected Category - {sCategory}, Amount - {sAmount}, Actual - {sActual}")
							[ ] 
							[ ] // Verify added other category is not added in Full Payment Schedule window
							[+] if(MDIClientLoans.LoanWindow.PaymentDetailsPanel.PaymentPieChart.FullPaymentScheduleButton.Exists(3))
								[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.PaymentPieChart.FullPaymentScheduleButton.Click()
								[+] if(DlgLoanSchedule.Exists(3))
									[ ] DlgLoanSchedule.SetActive()
									[ ] //Verify payment in full payment schedule
									[ ] sHandle=Str(PaymentDetailsListBox.GetHandle())
									[ ] iCount=PaymentDetailsListBox.GetItemCount()
									[+] for(i=0;i<=iCount;i++)
										[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(i))
										[ ] bMatch = MatchStr("*{sExpected}*", sExpected)
										[+] if (bMatch)
											[ ] ReportStatus("Edit DM1 (Loan Details >> Edit Terms) should not consider 'Other' category field value.",PASS,"Edit DM1 (Loan Details >> Edit Terms) does not consider 'Other' category field value")
											[ ] break
										[+] else if(i==iCount)
											[ ] ReportStatus("Edit DM1 (Loan Details >> Edit Terms) should not consider 'Other' category field value.",FAIL,"Edit DM1 (Loan Details >> Edit Terms) does consider 'Other' category field value as Expected - {sExpected}, Actual - {sActual}")
											[ ] 
									[ ] DlgLoanSchedule.DoneButton.Click()
									[ ] WaitForState(DlgLoanSchedule,FALSE,5)
								[+] else
									[ ] ReportStatus("Verify Loan Schedule window",FAIL,"Loan Schedule window is not displayed")
									[ ] 
							[+] else
								[ ] ReportStatus("Verify Full Payment Schedule Button",FAIL,"Full Payment Schedule Button is not displayed")
								[ ] 
						[+] else
							[ ] ReportStatus("Verify SplitTransaction window",FAIL,"Split Transaction window is not displayed")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
						[ ] LoanDetails.SetActive()
						[ ] LoanDetails.OKButton.Click()
						[ ] 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Edit Monthly Payment Button",FAIL,"Edit Monthly Payment Button is not displayed")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Loan Schedule window",FAIL,"Loan Schedule window is not displayed")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Full Payment Schedule button",FAIL,"Full Payment Schedule button is not displayed")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[+] //##########Verify that Edit DM2 can be opened from Payment Details tab >> Edit Payment details link######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_VerifyEditOnlineLoanAccountFromPaymentDetailsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that Edit D2 can be opened from Payment Details tab >> Edit Payment details link and  Monthly payment >> Edit link
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Edit DM2 can be opened from Payment Details tab >> Edit Payment details link
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 10th feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test11_VerifyEditOnlineLoanAccountFromPaymentDetailsTab() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sAccount="Loan Edit Account"
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(sAccount,ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] // Verification
		[ ] 
		[ ] // Click on Payment Details tab
		[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
		[ ] //To handle payment details flickering issue
		[ ] QuickenRestoreAndResize()
		[ ] 
		[+] if(MDIClientLoans.LoanWindow.EditPaymentDetails.Exists(5))
			[ ] 
			[ ] ReportStatus("Verify Edit Payment Details link on Payment Details tab for manual loan account",PASS,"Edit Payment Details link is displayed on Payment Details tab for manual loan account")
			[ ] MDIClientLoans.LoanWindow.EditPaymentDetails.Click()
			[+] if(LoanDetails.Exists(5))
				[+] if(LoanDetails.NextPaymentDueTextField.Exists(5))
					[ ] ReportStatus("Verify Loan Details DM2 screen should open in Edit mode",PASS,"Loan Details DM2 screen is opened in Edit mode")
				[+] else
					[ ] ReportStatus("Verify Loan Details DM2 screen should open in Edit mode",FAIL,"Loan Details DM2 screen is not opened in Edit mode")
					[ ] 
				[ ] LoanDetails.Close()
				[ ] WaitForState(LoanDetails,FALSE,5)
			[+] else
				[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed: UI flickirring issue")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify loan details window launched",FAIL,"Loan details window not displayed")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################################
[ ] 
[+] //##########Verify that Principal and Interest fields are non-editable and has a '$' symbol against each value######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_PrincipalAndInterestFieldsNotEditableForOnlineLoanAccount
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that Principal and Interest fields are non-editable and has a '$' symbol against each value for online loan account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Principal and Interest fields are non-editable and has a '$' symbol
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 10th feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test12_PrincipalAndInterestFieldsNotEditableForOnlineLoanAccount() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sActualClassName, sExpectedClassName="Edit"
		[ ] STRING sAccount="Loan Edit Account"
		[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(sAccount,ACCOUNT_PROPERTYDEBT)
	[+] if(iValidate==PASS)
		[ ] 
		[ ] //Click on Loan Details tab
		[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
		[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
			[ ] 
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for online loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for online loan account")
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] //Verify Principal is non editable 
				[+] if(LoanDetails.PrincipalText.Exists(5))
					[ ] sActualClassName=LoanDetails.PrincipalText.GetProperty("windowClassName")
					[+] if(sActualClassName!=sExpectedClassName)
						[ ] ReportStatus("Verify Principal field is non editable",PASS,"Principal field is non editable in Edit mode from Monthly payment >> Edit link")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Principal field is non editable",FAIL,"Principal field is editable in Edit mode from Monthly payment >> Edit link, Actula class {sActualClassName} and Expected class {sExpectedClassName}")
						[ ] 
					[ ] 
					[ ] //Verify $ is displayed with value
					[ ] sActual=LoanDetails.PrincipalText.GetText()
					[ ] bMatch=MatchStr("$*",sActual)
					[+] if(bMatch)
						[ ] ReportStatus("Verify $ is displayed with Principal amount ",PASS,"$ is displayed with Principal amount")
						[ ] 
					[+] else 
						[ ] ReportStatus("Verify $ is displayed with Principal amount ",FAIL,"$ is not displayed with Principal amount")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Principal Text is present on Loan Details window", FAIL, "Principal Text is not present on Loan Details window")
				[ ] 
				[ ] //Verify Interest is non editable 
				[+] if(LoanDetails.InterestText.Exists(5))
					[ ] sActualClassName=LoanDetails.InterestText.GetProperty("windowClassName")
					[+] if(sActualClassName!=sExpectedClassName)
						[ ] ReportStatus("Verify Interest field is non editable",PASS,"Interest field is non editable in Edit mode from Monthly payment >> Edit link")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Interest field is non editable",FAIL,"Interest field is editable in Edit mode from Monthly payment >> Edit link, Actula class {sActualClassName} and Expected class {sExpectedClassName}")
						[ ] 
					[ ] 
					[ ] //Verify $ is displayed with value
					[ ] sActual=LoanDetails.InterestText.GetText()
					[ ] bMatch=MatchStr("$*",sActual)
					[+] if(bMatch)
						[ ] ReportStatus("Verify $ is displayed with Interest amount ",PASS,"$ is displayed with Interest amount")
						[ ] 
					[+] else 
						[ ] ReportStatus("Verify $ is displayed with Interest amount ",FAIL,"$ is not displayed with Interest amount")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Interest Text is present on Loan Details window", FAIL, "Interest Text is not present on Loan Details window")
				[ ] 
				[ ] 
				[ ] LoanDetails.SetActive()
				[ ] LoanDetails.Close()
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for online loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for online loan account")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open online loan account register",FAIL,"Online loan account {sAccount} dashboard is not opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[+] //##########Verify that adding values in Other and Extra Principal fields ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_VerifyExtraPrincipalPaidUpdate
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that adding values in Other and Extra Principal fields changes the Total Payment. The total payment changed should reflect on dashboard, Full payment schedule and reminders properly.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Extra Principal paid monthly' field updated successfully
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 11th feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test13_VerifyExtraPrincipalPaidUpdate() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sAccount, sExtraPrincipalAmount, sActualTotal,sExpected
		[ ] sExtraPrincipalAmount="10"
		[ ] sAccount="MORTGAGE XX7777"
		[ ] // sExpected="238.45"
		[ ] // Read manual loan account data from excel sheet
		[ ] sDate=ModifyDate(0,sDateFormat)
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[1]
		[ ] lsAddLoanAccount[3]=sDate
		[ ] 
	[ ] 
	[ ] 
	[ ] //Select Loan Account
	[ ] iValidate=OnlineLoansNaviagateToD3Step(sAccount,lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],lsAddLoanAccount[9],lsAddLoanAccount[10],lsAddLoanAccount[8])
	[+] if(iValidate==PASS)
		[ ] 
		[+] if(DlgLoanReminder.Exists(5))
			[ ] DlgLoanReminder.NextButton.Click()
			[+] if(DlgAddEditReminder.Exists(2))
				[ ] DlgAddEditReminder.SetActive()
				[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[ ] WaitForState(DlgLoanReminder,FALSE,5)
		[ ] 
		[ ] //Click on Loan Details tab
		[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
		[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
			[ ] 
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] 
				[ ] sActualTotal=LoanDetails.TotalPaymentAmount.GetText()
				[ ] 
				[ ] // Enter value in 'Extra Principal paid ' text field 
				[+] if(LoanDetails.ExtraPrincipalPaidMonthly.Exists(5))
					[ ] LoanDetails.ExtraPrincipalPaidMonthly.SetText(sExtraPrincipalAmount)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Extra Principal paid ' field is present on Loan Details window", FAIL, "Extra Principal paid ' field is not present on Loan Details window")
				[ ] 
				[ ] 
				[ ] LoanDetails.SetActive()
				[ ] LoanDetails.OKButton.Click()
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] //Click on Payment Details tab
				[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
				[ ] QuickenRestoreAndResize()
				[ ] // Get expected payment value
				[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
				[+] if(LoanDetails.Exists(5))
					[ ] sExpected=LoanDetails.TotalPaymentAmount.GetText()
					[ ] LoanDetails.SetActive()
					[ ] LoanDetails.OKButton.Click()
					[ ] WaitForState(LoanDetails,FALSE,5)
					[ ] 
				[ ] 
				[+] if(sActualTotal!=sExpected)
					[ ] 
					[ ] //Verify Total in Loan Schedule
					[+] if(MDIClientLoans.LoanWindow.PaymentDetailsPanel.PaymentPieChart.FullPaymentScheduleButton.Exists(3))
						[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.PaymentPieChart.FullPaymentScheduleButton.Click()
						[+] if(DlgLoanSchedule.Exists(3))
							[ ] DlgLoanSchedule.SetActive()
							[ ] 
							[ ] //Verify payment in full payment schedule
							[ ] sHandle=Str(PaymentDetailsListBox.GetHandle())
							[ ] iCount=PaymentDetailsListBox.GetItemCount()
							[+] for(i=0;i<=iCount;i++)
								[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,Str(i))
								[ ] bMatch = MatchStr("*{sExpected}*", sActual)
								[+] if (bMatch)
									[ ] ReportStatus("Verify Payment changed after adding extra principal paid on Full Payment Schedule window",PASS,"Payment is changed after adding extra principal paid on Full Payment Schedule window")
									[ ] break
								[+] else if(i==iCount)
									[ ] ReportStatus("Verify Payment changed after adding extra principal paid  on full payment schedule",FAIL,"Payment is not changed after adding extra principal paid for full payment schedule, Actual is {sActual} and Expected {sExpected}")
								[ ] 
							[ ] DlgLoanSchedule.DoneButton.Click()
							[ ] WaitForState(DlgLoanSchedule,FALSE,5)
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Loan Schedule window",FAIL,"Loan Schedule window is not displayed")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Full Payment Schedule button",FAIL,"Full Payment Schedule button is not displayed")
					[ ] 
					[ ] //Verification on dashboard 
					[+] if(MDIClientLoans.LoanWindow.PaymentAmount.Exists(2))
						[ ] sActual=MDIClientLoans.LoanWindow.PaymentAmount.GetProperty("Caption")
						[+] if(MatchStr("*{sExpected}*", sActual))
							[ ] ReportStatus("Verify Payment changed after adding extra principal paid on dashboard",PASS,"Payment is changed after adding extra principal paid on loan dashboard")
						[+] else
							[ ] ReportStatus("Verify Payment changed after adding extra principal paid on dashboard",FAIL,"Payment is not changed even after adding extra principal paid on loan dashboard")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Payment amount text on loan dashboard",FAIL,"Payment amount text is not displayed on loan dashboard")
					[ ] 
					[ ] // Verification for reminder
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
					[+] if (DlgManageReminders.Exists(5))
						[ ] sleep(1)
						[ ] DlgManageReminders.AllBillsDepositsTab.Click()
						[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
						[ ] iCount=DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
						[+] for(i=0;i<iCount;i++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
							[ ] bMatch = MatchStr("*{sExpected}*", sActual)
							[+] if (bMatch)
								[ ] ReportStatus("Verify Payment changed after adding extra principal paid  on Reminder",PASS,"Payment is changed after adding extra principal paid for Reminder")
								[ ] break
							[+] else if(i==iCount)
								[ ] ReportStatus("Verify Payment changed after adding extra principal paid  on Reminder",FAIL,"Payment is not changed after adding extra principal paid for Reminder, Actual is {sActual} and Expected {sExpected}")
								[ ] 
							[ ] 
						[ ] DlgManageReminders.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Manage Reminder dialog",FAIL,"ManageReminder dialog is not displayed")
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Payment changed after adding extra principal paid",FAIL,"Payment is not changed even after adding extra principal paid")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for manual loan account")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[+] //########## Verify that 'Edit Loan Reminder' option should open 'Edit Loan Payment Reminder' screen for Online Loan Account ######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_VerifyEditLoanReminderForOnlineLoanAccount
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify that 'Edit Loan Reminder' option should open 'Edit Loan Payment Reminder' screen for Online Loan Account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  'Edit Loan Reminder' option should open 'Edit Loan Payment Reminder' screen.
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 12th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test14_VerifyEditLoanReminderForOnlineLoanAccount () appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] STRING sActual, sExpected="Edit Loan Payment Reminder"
		[ ] STRING  sAccount="MORTGAGE XX7777"
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[2]
		[ ] 
		[ ] 
		[ ] 
	[ ] iValidate=AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3])
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Add Manual spending account",PASS,"Manual Spending account {lsAddAccount[2]} is added")
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(sAccount,ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] //Click on Loan Details tab
			[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
			[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
				[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
				[+] if(LoanDetails.Exists(5))
					[ ] //Verify that Edit Loan Reminder Button is displayed
					[+] if(LoanDetails.EditLoanReminderButton.Exists(3))
						[ ] // Click Edit Loan Reminder Button
						[ ] LoanDetails.EditLoanReminderButton.Click()
						[ ] //Verify Loan Payment Reminder window is displayed
						[+] if(LoanPaymentReminder.Exists(3))
							[ ] sActual=LoanPaymentReminder.GetCaption()
							[ ] // Verify window name
							[+] if(sActual==sExpected)
								[ ] ReportStatus("Verify that Loan Payment Reminder window",PASS,"Edit Loan Payment Reminder window is displayed for Online Loan Account")
								[ ] 
							[+] else 
								[ ] ReportStatus("Verify that Loan Payment Reminder window",FAIL,"Edit Loan Payment Reminder window is not displayed for Online Loan Account, sAcutal - {sActual}, Expected - {sExpected}")
								[ ] 
							[ ] 
							[+] if(LoanPaymentReminder.FromAccountTextField.Exists(2))
								[ ] LoanPaymentReminder.FromAccountTextField.SetText(lsAddAccount[2])
								[ ] LoanPaymentReminder.DoneButton.Click()
								[ ] sleep(3)
								[ ] 
								[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
								[+] if(LoanDetails.Exists(5))
									[ ] //Verify that Edit Loan Reminder Button is displayed
									[+] if(LoanDetails.EditLoanReminderButton.Exists(3))
										[ ] // Click Edit Loan Reminder Button
										[ ] LoanDetails.EditLoanReminderButton.Click()
										[ ] //Verify Loan Payment Reminder window is displayed
										[ ] if(LoanPaymentReminder.Exists(3))
										[ ] 
										[ ] sActual=LoanPaymentReminder.FromAccountTextField.GetText()
										[+] if(sActual==lsAddAccount[2])
											[ ] ReportStatus("Verify Edit Loan Reminder for Online Account",PASS,"From account field value is edited in Edit Loan Reminder window for Online Account")
										[+] else
											[ ] ReportStatus("Verify Edit Loan Reminder for Online Account",FAIL,"From account field value is not edited in Edit Loan Reminder window for Online Account")
											[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Edit Loan Reminder Button is present on Loan Details window", FAIL, "Edit Loan Reminder Button is not present on Loan Details window")
										[ ] 
								[+] else
									[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
									[ ] 
							[+] else
								[ ] ReportStatus("Verify From Account Text Field",FAIL,"From Account text field is not displayed on Edit Loan Payment Reminder")
							[ ] 
							[ ] LoanPaymentReminder.Close()
						[+] else
							[ ] ReportStatus("Verify Loan Payment Reminder window",FAIL,"Loan Payment Reminder window is not displayed")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Edit Loan Reminder Button is present on Loan Details window", FAIL, "Edit Loan Reminder Button is not present on Loan Details window")
					[ ] 
					[ ] sleep(2)
				[+] else
					[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for manual loan account")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add Manual spending account",FAIL,"Manual Spending account {lsAddAccount[2]} is not added")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[ ] 
[+] //########## Verify that 'Add Reminder' button should be displayed on Edit Loan D2 if No reminder option is selected######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_VerifyAddLoanReminderForOnlineLoanAccount
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //16. Verify that 'Add Reminder' button should be displayed on Edit Loan D2 if No reminder option is selected while adding loan account.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  'Add Reminder' button displayed on Edit Loan D2 if No reminder option is selected while adding loan account.
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 13th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test15_VerifyAddLoanReminderForOnlineLoanAccount () appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[4]
		[ ] lsAddLoanAccount[3]=sDate
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(FileExists(sOnlineLoansDataFile))
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.Kill()
		[ ] Waitforstate(QuickenWindow,False,5)
		[ ] DeleteFile(sOnlineLoansDataFile)
	[ ] SYS_CopyFile (sOnlineLoansDataSource,sOnlineLoansDataFile)
	[+] if(!QuickenWindow.Exists(5))
		[ ] App_Start(sCmdLine)
		[ ] sleep(5)
		[ ] WaitForState(QuickenWindow , true , 20)
		[ ] 
		[ ] 
	[ ] //Commented as time it comes a paid off 
	[ ] //Add Online Loan account
	[+] // iValidate=AddCCBankLoanAccount()
		[ ] 
	[ ] iResult=OpenDataFile(sOnlineLoansDataFileName)
	[+] if(iResult==PASS)
		[ ] ReportStatus("Add Online loan account",PASS,"Online loan account is added")
		[ ] 
		[ ] 
		[ ] //Select Loan Account
		[ ] iValidate=OnlineLoansNaviagateToD3Step(lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6])
		[+] if(iValidate==PASS)
			[ ] 
			[+] if(DlgLoanReminder.Exists(2))
				[ ] // "No" reminder option is selected
				[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(3)
				[ ] DlgLoanReminder.DoneButton.Click()
				[ ] sleep(2)
				[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
					[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
					[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
					[+] if(LoanDetails.Exists(5))
						[ ] //Verify that Add Loan Reminder Button is displayed
						[+] if(LoanDetails.AddLoanReminder.Exists(3))
							[ ] ReportStatus("Verify that Add Loan Reminder Button is displayed",PASS,"Add Reminder' button is displayed on Edit Loan D2 if No reminder option is selected")
							[ ] // Click Add Loan Reminder Button
							[ ] LoanDetails.AddLoanReminder.Click()
							[ ] //Verify Loan Reminder window is displayed
							[+] if(DlgLoanReminder.Exists(3))
								[ ] ReportStatus("Verify Loan Reminder window",PASS,"Loan Reminder window is displayed")
								[ ] DlgLoanReminder.CancelButton.Click()
								[+] if(AlertMessage.Exists(2))
									[ ] AlertMessage.SetActive()
									[ ] AlertMessage.Yes.Click()
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Loan Payment Reminder window",FAIL,"Loan Reminder window is not displayed")
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that Add Loan Reminder Button is displayed",PASS,"Add Reminder' button is not displayed on Edit Loan D2 even if No reminder option is selected")
						[ ] 
						[ ] sleep(2)
					[+] else
						[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
						[ ] 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for manual loan account")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Loan Reminder window",FAIL,"Loan Reminder window is not displayed")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Online loan account register",FAIL,"Online loan account {lsAddLoanAccount} register is not opened")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sOnlineLoansDataFileName} couldn't be opened.")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################
[ ] 
[ ] 
[+] //########## Verify that Edit link for Other category is not present while adding manual loan account ######
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_VerifyEditLinkForOtherCategoryForManualLoanAccount
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //17. Verify that Edit link for Other category is not present while adding manual loan account 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  Edit link for Other category is not present while adding manual loan account 
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 13th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test16_VerifyEditLinkForOtherCategoryForManualLoanAccount () appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] LIST OF STRING lsManualAccount
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
		[ ] lsManualAccount=lsExcelData[6]
		[ ] lsManualAccount[3]=sDate
		[ ] 
	[ ] // Verification for Manual Loan Account
	[+] if(QuickenWindow.Exists(2))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] ExpandAccountBar()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[ ] AddAccount.Loan.Click()
		[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
			[ ] 
			[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
			[+] if(LoanDetails.Exists(5))
				[ ] 
				[+] //Set Loan Name
					[ ] LoanDetails.LoanNameTextField.SetText(lsManualAccount[2])
				[ ] 
				[ ] //Set Loan Type
				[+] if(lsManualAccount[7]!=NULL)
					[ ] 
					[+] if(LoanDetails.LoanTypePopupList.Exists(2))
						[ ] LoanDetails.LoanTypePopupList.Select(lsManualAccount[7])
					[+] else
						[ ] ReportStatus("Verify Loan Type Popuplist",FAIL,"Loan type popup list not found")
				[ ] 
				[+] //Set Opening Date
					[ ] LoanDetails.OpeningDateTextField.SetText(sDate)
				[ ] 
				[+] //Set Original Balance
					[ ] LoanDetails.OriginalBalanceTextField.SetText(lsManualAccount[4])
				[ ] 
				[+] //Set Current Interest Rate
					[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsManualAccount[5])
				[ ] 
				[+] //Set Original Length
					[ ] LoanDetails.OriginalLengthTextField.SetText(lsManualAccount[6])
				[ ] 
				[ ] //Type keys to recalculate values on page
				[ ] LoanDetails.OpeningDateTextField.TypeKeys(KEY_TAB)
				[ ] LoanDetails.OpeningDateTextField.TypeKeys(KEY_TAB)
				[ ] 
				[ ] LoanDetails.NextButton.Click()
				[ ] 
				[+] if(!LoanDetails.EditCategoryButton.Exists(2))
					[ ] ReportStatus(" Verify that Edit link for Other category is not present while adding manual loan account",PASS," Edit link for Other category is not present while adding manual loan account")
				[+] else
					[ ] ReportStatus(" Verify that Edit link for Other category is not present while adding manual loan account",FAIL," Edit link for Other category is present while adding manual loan account")
					[ ] 
				[ ] 
				[ ] LoanDetails.NextButton.Click()
				[ ] YourLoanReminder.Next.Click()
				[ ] sleep(2)
				[ ] LoanPaymentReminder.SetActive()
				[ ] LoanPaymentReminder.DoneButton.Click()
				[ ] sleep(2)
				[ ] AccountAdded.Done.Click()
				[ ] sleep(3)
				[ ] 
				[ ] iValidate=SelectAccountFromAccountBar(lsManualAccount[2],ACCOUNT_PROPERTYDEBT)
				[+] if(iValidate==PASS)
					[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
						[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
						[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
						[+] if(LoanDetails.Exists(5))
							[ ] //Verify that Edit link for Other category is displayed
							[+] if(LoanDetails.EditCategoryButton.Exists(3))
								[ ] ReportStatus("Verify that Edit link for Other category is displayed",PASS,"Edit link for Other category button is displayed on Edit Loan D2 For manual loan account")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that Edit link for Other category is displayed",FAIL,"Edit link for Other category button is not displayed on Edit Loan D2 For manual loan account")
							[ ] 
							[ ] LoanDetails.Close()
							[ ] 
							[ ] 
							[ ] sleep(2)
						[+] else
							[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for manual loan account")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Account is selected",FAIL, "Account {lsManualAccount[2]} is not selected")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Loan Account window",FAIL,"Add Loan Account window is not displayed")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window open",FAIL,"Quicken Main window did not open")
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
[ ] //####################################################################################################
[ ] 
[ ] 
[+] //########## Verify that Edit link for Other category is not present while adding online loan account #############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_VerifyEditLinkForOtherCategoryForOnlineLoanAccount
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //17. Verify that Edit link for Other category is not present while adding  online loan account.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  Edit link for Other category is not present while adding online loan account.
		[ ] //					Fail		 If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Udita Dube created on 13th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test17_VerifyEditLinkForOtherCategoryForOnlineLoanAccount () appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sOtherManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[5]
		[ ] lsAddLoanAccount[3]=sDate
		[ ] 
	[ ] 
	[ ] 
	[ ] // Verification for Online Loan Account
	[ ] iValidate=OnlineLoansNaviagateToD2Step(lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6])
	[+] if(iValidate==PASS)
		[ ] 
		[ ] // Verify Edit link for other category
		[+] if(!LoanDetails.EditCategoryButton.Exists(2))
			[ ] ReportStatus(" Verify that Edit link for Other category is not present while adding Online loan account",PASS," Edit link for Other category is not present while adding Online loan account {lsAddLoanAccount[2]}")
		[+] else
			[ ] ReportStatus(" Verify that Edit link for Other category is not present while adding online loan account",FAIL," Edit link for Other category is present while adding Online loan account {lsAddLoanAccount[2]}")
			[ ] 
		[ ] 
		[ ] LoanDetails.SetActive()
		[ ] LoanDetails.NextButton.Click()
		[+] if(DlgLoanReminder.Exists(5))
			[ ] DlgLoanReminder.SetActive()
			[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(2)
			[ ] DlgLoanReminder.NextButton.Click()
			[ ] LoanPaymentReminder.SetActive()
			[ ] LoanPaymentReminder.DoneButton.Click()
			[ ] 
			[ ] sleep(2)
			[ ] 
			[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
				[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",PASS,"Edit Monthly Payment Button is displayed on Loan Details dashboard for manual loan account")
				[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
				[+] if(LoanDetails.Exists(5))
					[ ] //Verify that Edit link for Other category is displayed
					[+] if(LoanDetails.EditCategoryButton.Exists(3))
						[ ] ReportStatus("Verify that Edit link for Other category is displayed",PASS,"Edit link for Other category button is displayed on Edit Loan D2 For Online account {lsAddLoanAccount[2]}")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Edit link for Other category is displayed",FAIL,"Edit link for Other category button is not displayed on Edit Loan D2 for Online loan Account {lsAddLoanAccount[2]}")
					[ ] 
					[ ] LoanDetails.Close()
					[ ] 
					[ ] 
					[ ] sleep(2)
				[+] else
					[ ] ReportStatus("Verify Loan Details window",FAIL,"Loan Details window is not displayed")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Edit Monthly Payment Button on Loan Details dashboard for manual loan account",FAIL,"Edit Monthly Payment Button is not displayed on Loan Details dashboard for manual loan account")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Loan Reminder window",FAIL,"Loan Reminder window is not opened")
		[ ] 
	[+] else
		[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] // //####################################################################################################
[ ] // 
[ ] // 
[ ] // 
[ ] // 
[ ] // 
[ ] 
[ ] // //===========================================================================================
[ ] // //=================================  Paid Off Loans  ===========================================
[ ] // //===========================================================================================
[ ] // 
[ ] // 
[+] // #############  Paid Off SetUp ######################################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	VariableInterestRate_SetUp()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase it will setup the necessary pre-requisite for tests
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Feb 4,2014		Anagha	created		
	[ ] // ********************************************************
	[ ] // 
[+] testcase PaidOff_SetUp() appstate QuickenBaseState
	[ ] 
	[+] // ------------------ Variable declaration------------------
		[ ] 
		[ ] STRING sFileName="PaidOffLoan"
		[ ] STRING sVersion="2012"
		[ ] 
		[ ] 
		[ ] STRING sSourceFile=AUT_DATAFILE_PATH+"\"+sLoanDataFolder+"\"+sFileName +".QDF"
		[ ] STRING sDataFile=AUT_DATAFILE_PATH +"\" + sFileName  +".QDF"
		[ ] STRING sBackupFolder=AUT_DATAFILE_PATH+"\"+"Q12Files"
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.Kill()
		[ ] WaitForState(QuickenWindow, FALSE ,10)
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] 
	[+] if (!QuickenWindow.Exists(5))
		[ ] App_Start(sCmdLine)
		[ ] sleep(20)
		[ ] WaitForState(QuickenWindow, TRUE ,10)
	[ ] 
	[ ] //update due to change in DataFileConversion function
	[ ] sDataFile=AUT_DATAFILE_PATH +"\"
	[ ] 
	[ ] iValidate=DataFileConversion(sFileName,sVersion,NULL,sDataFile)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Convert older data file with Manual loan account",PASS,"Data File with Manual loan account converted successfully")
		[ ] 
	[+] else
		[ ] ReportStatus("Convert older data file with Manual loan account",FAIL,"Data File with Manual loan account converted successfully")
	[ ] 
	[ ] 
[ ] // ##################################################################################################
[ ] // 
[+] // ############# Manual Loan Account Paid off 2012 converted ###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test01_PaidOff2012Converted()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify that if a manual Loan account  is paid off  in 2012 and opened in 2013, 
		[ ] // UI should be correctly displayed with zero or positive balance with  correct UI.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If Accept button in front of every transaction works						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Jan 14,2014		Anagha	created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test01_ManualPaidOffLoan2012Converted() appstate none
	[ ] 
	[+] // ------------------ Variable declaration & definition------------------
		[ ] LIST OF STRING lsAccount
		[ ] sCaptionText="PAYOFF DATE"
	[ ] 
	[ ] 
	[ ] // ----------Retrieving Data from ExcelSheet----------
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanAccSheet)
	[ ] lsAccount=lsExcelData[6]
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // ------------------Select the Lending Loan Account------------------
		[ ] iValidate = SelectAccountFromAccountBar(lsAccount[1],ACCOUNT_PROPERTYDEBT)	
		[+] if(iValidate == PASS)
			[ ] ReportStatus("Select the Lending Loan Account",PASS,"{lsAccount[1]} Lending Loan Account is selected successfully")
			[ ] 
			[+] if(!MDIClientLoans.LoanWindow.WhatIfTool.Exists(5))
				[ ] ReportStatus("Verify What-If Tab not present for Manual Loan Account",PASS,"What-If Tab not present for Paid Off Manual Loan Account")
				[ ] 
				[ ] sCaption=MDIClientLoans.LoanWindow.PaymentDetailsPanel.QWChild.DashboardPanel.PAYOFFDATE.GetText()
				[ ] 
				[+] if(sCaptionText==sCaption)
					[ ] ReportStatus("Verify Payoff Date string for Manual Loan Account",PASS,"Payoff Date string for Manual Loan Account is present")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Payoff Date string for Manual Loan Account",PASS,"Payoff Date string for Manual Loan Account is not present")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify What-If Tab not present for Manual Loan Account",FAIL,"What-If Tab present for Paid Off Manual Loan Account")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Lending Loan Account",FAIL,"{lsAccount[1]} Lending Loan Account is NOT selected")
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] // ####################################################################################################
[ ] // 
[+] // #############  Lending account Paid off 2012 converted ###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test01_PaidOff2012Converted()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify that if a manual Loan account  is paid off  in 2012 and opened in 2013, 
		[ ] // UI should be correctly displayed with zero or positive balance with  correct UI.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			        Pass 	If Accept button in front of every transaction works						
		[ ] // Fail		If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // Jan 14,2014		Anagha	created
	[ ] // ********************************************************
	[ ] // 
[+] testcase Test02_LendingPaidOffLoan2012Converted() appstate none
	[ ] 
	[ ] // ------------------ Variable declaration & definition------------------
	[ ] LIST OF STRING lsAccount
	[ ] sCaptionText="PAYOFF DATE"
	[ ] 
	[ ] 
	[ ] // ----------Retrieving Data from ExcelSheet----------
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanAccSheet)
	[ ] lsAccount=lsExcelData[6]
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // ------------------Select the Lending Loan Account------------------
		[ ] iValidate = SelectAccountFromAccountBar(lsAccount[1],ACCOUNT_PROPERTYDEBT)	
		[ ] 
		[+] if(iValidate == PASS)
			[ ] ReportStatus("Select the Lending Loan Account",PASS,"{lsAccount[1]} Lending Loan Account is selected successfully")
			[ ] 
			[+] if(!MDIClientLoans.LoanWindow.WhatIfTool.Exists(5))
				[ ] ReportStatus("Verify What-If Tab not present for Manual Loan Account",PASS,"What-If Tab not present for Paid Off Manual Loan Account")
				[ ] 
				[ ] sCaption=MDIClientLoans.LoanWindow.PaymentDetailsPanel.QWChild.DashboardPanel.PAYOFFDATE.GetText()
				[ ] 
				[+] if(sCaptionText==sCaption)
					[ ] ReportStatus("Verify Payoff Date string for Manual Loan Account",PASS,"Payoff Date string for Manual Loan Account is present")
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Payoff Date string for Manual Loan Account",PASS,"Payoff Date string for Manual Loan Account is not present")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify What-If Tab not present for Manual Loan Account",FAIL,"What-If Tab present for Paid Off Manual Loan Account")
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Lending Loan Account",FAIL,"{lsAccount[1]} Lending Loan Account is NOT selected")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] // #########################################################################################################
[ ] // 
[ ] 
[ ] 
[+] //#############Verify past effective date interest rate entry  ##########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test04_InterestRateCoversion()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will  Verify that Interest rate entries created in 2012 for Manual account are 
		[ ] //correctly seen on 2013 dashboard with correct regular payment calculations.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If Accept button in front of every transaction works						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   Feb 05,2014		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test04_InterestRateCoversion() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sRate
	[ ] STRING sFileName="PaidOffLoan.QDF"
	[ ] STRING sVersion="2012"
	[ ] 
	[ ] STRING sSourceFile=AUT_DATAFILE_PATH+"\"+sLoanDataFolder+"\"+sFileName
	[ ] STRING sDataFile=AUT_DATAFILE_PATH +"\" + sFileName
	[ ] STRING sBackupFolder=AUT_DATAFILE_PATH+"\"+"Q12Files"
	[ ] 
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanAccSheet)
	[ ] sAccount =lsExcelData[6][1]
	[ ] sRate="4%"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //------------------Select the Loan Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_PROPERTYDEBT)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Loan Account",PASS,"{sAccount} Online Loan Account is selected successfully")
			[ ] 
			[+] // if(MDIClientLoans.LoanWindow.EditInterestRateAmountButton.Exists(5))
				[ ] // ReportStatus("Verify Edit Interest Rate present for Manual Loan Account",PASS,"Edit Interest Rate for Manual Loan Account")
				[ ] // MDIClientLoans.LoanWindow.EditInterestRateAmountButton.Click()
				[ ] // Sleep(2)
				[+] // if(LoanInterestRate.Exists(5))
					[ ] // ReportStatus("Verify Loan Interest Rate Window",PASS," Loan Interest Rate window is present")
					[ ] // LoanInterestRate.SetActive()
					[ ] // //----------------------Click on Adjustable Interest Rate----------------------------------
					[ ] // LoanInterestRate.Panel.AdjustRateLoans.Click()
					[ ] // Sleep(1)
					[ ] // 
					[ ] // 
					[+] // if(LoanInterestRate.Panel.AdjustableRates.ListBox.Exists(5))
						[ ] // ReportStatus("Verify Variable Interest Rate Window",PASS," Variable Interest Rate window is present")
						[ ] // 
						[ ] // LoanInterestRate.SetActive()
						[ ] // 
						[ ] // sHandle = Str(LoanInterestRate.Panel.AdjustableRates.ListBox.GetHandle())
						[ ] // 
						[+] // for(i=0;i<LoanInterestRate.Panel.AdjustableRates.ListBox.GetItemCount();i++)
							[ ] // sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
							[ ] // bMatch = MatchStr("*{sDate}*{sRate}*", sActual)
							[+] // if(bMatch == TRUE)
								[ ] // break
							[ ] // 
						[ ] // 
						[+] // if (bMatch == TRUE)
							[ ] // ReportStatus("Variable Interest Rate is deleted from list in the Adjustable Rate Loans", PASS, "Variable Interest Rate is deleted from list in the Adjustable Rate Loans") 
						[+] // else
							[ ] // ReportStatus(" Variable Interest Rate is deleted from list in the Adjustable Rate Loans", FAIL, "Variable Interest Rate is deleted from not list in the Adjustable Rate Loans") 
						[ ] // 
						[ ] // LoanInterestRate.OKButton.Click()
						[ ] // 
						[ ] // Sleep(1)
					[+] // else
						[ ] // ReportStatus("Verify Adjustable Rates panel",FAIL,"Adjustable Rates panel didn't appear")
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Loan Interest Rate dialog",FAIL,"Dialog Loan Interest Rate didn't appear")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify  for Manual Loan Account",FAIL," for Manual Loan Account")
			[ ] 
			[+] if(MDIClientLoans.LoanWindow.ClosingInterestRateText.Exists(5))
				[ ] ReportStatus("Verify Closing Interest Rate present for Manual Loan Account",PASS,"Closing Interest Rate for Paid off Manual Loan Account is present")
				[ ] 
				[ ] sActual=trim(MDIClientLoans.LoanWindow.ClosingInterestRateValue.GetProperty("Caption"))
				[+] if(sActual == sRate)
					[ ] ReportStatus("Verify Closing Interest Rate after conversion for the Paid off Manual Loan Account",PASS,"Closing Interest Rate after conversion for the Paid off Manual Loan Account is correct.")
				[+] else
					[ ] ReportStatus("Verify Closing Interest Rate after conversion for the Paid off Manual Loan Account",FAIL,"Closing Interest Rate after conversion for the Paid off Manual Loan Account is incorrect expected: {sRate}, actual is: {sActual}.")
			[+] else
				[ ] ReportStatus("Verify Closing Interest Rate present for Manual Loan Account",FAIL,"Closing Interest Rate for Paid off Manual Loan Account is NOT present")
			[ ] 
		[+] else
			[ ] ReportStatus("Select the Manual Loan Account",FAIL,"{sAccount} Manual Loan Account is not selected successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
[ ] //###########################################################################################################
[ ] 
[ ] 
[ ] 
[ ] // 
[ ] 
[ ] // //===========================================================================================
[ ] // //================================= Variable Interest Rate ===========================================
[ ] // //===========================================================================================
[ ] 
[ ] 
[+] //############# Variable Interest Rate SetUp ######################################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	VariableInterestRate_SetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will setup the necessary pre-requisite for tests
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 Feb 4,2014		Anagha	created		
	[ ] // ********************************************************
	[ ] 
[+] testcase VariableInterestRate_SetUp() appstate QuickenBaseState
	[ ] 
	[ ] //------------------ Variable declaration------------------
	[ ] STRING sFileName = "VariableInterestRate"
	[ ] STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] LIST OF STRING lsLoanAccount
	[ ] LIST OF ANYTYPE lsTransactionData
	[ ] 
	[ ] 
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sBankingAccountSheet)
	[ ] lsAccount=lsExcelData[1]
	[ ] lsTransactionData = ReadExcelTable(sLoansDataExcelSheet, sOtherManualLoanSheet)
	[ ] lsLoanAccount=lsTransactionData[7]
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[+] if(QuickenWindow.Exists(SHORT_SLEEP))
			[ ] QuickenWindow.Kill()
			[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[ ] 
	[+] if (!QuickenWindow.Exists(5))
		[ ] App_Start(sCmdLine)
		[ ] WaitForState(QuickenWindow, TRUE ,10)
	[ ] 
	[ ] //------------------ Create Data File------------------
	[ ] iValidate = DataFileCreate(sFileName)
	[ ] 
	[ ] // ------------------Report Staus If Data file opened successfully------------------
	[+] if ( iValidate  == PASS)
		[ ] ReportStatus("Validate Data File ", PASS, "Data file -  {sDataFile} is created successfully")
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sDataFile} is created successfully")
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------ Set Classic View------------------
		[ ] SetViewMode(VIEW_CLASSIC_MENU)
		[ ] //------------------ Select Home tab------------------
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] //------------------Off Popup Register------------------
		[ ] UsePopUpRegister("OFF")
		[ ] sleep(1)
		[ ] 
		[ ] 
		[ ] // ----------Add Checking Account----------
		[ ] iValidate = AddManualSpendingAccount(lsAccount[1], lsAccount[2], lsAccount[3], lsAccount[4],lsAccount[5])
		[ ] 
		[ ] // ----------Report Status if checking Account is created----------
		[+] if (iValidate==PASS)
			[ ] ReportStatus("{lsAccount[1]} Account", iValidate, "{lsAccount[1]} Account -  {lsAccount[2]}  is created successfully")
			[ ] lsLoanAccount[3]=sDate
			[ ] 
			[ ] iValidate=AddEditManualLoanAccount(lsLoanAccount[1],lsLoanAccount[2],lsLoanAccount[3],lsLoanAccount[4],lsLoanAccount[5],lsLoanAccount[6],lsLoanAccount[7],lsLoanAccount[8],lsLoanAccount[9],lsLoanAccount[10],lsLoanAccount[11])
			[ ] 
			[ ] // ----------Report Status if loan Account is created----------
			[+] if (iValidate==PASS)
				[ ] ReportStatus("{lsLoanAccount[2]} Account", iValidate, "{lsLoanAccount[2]} Account -  {lsLoanAccount[3]}  is created successfully")
			[+] else
				[ ] ReportStatus("{lsLoanAccount[2]} Account", iValidate, "{lsLoanAccount[2]} Account -  {lsLoanAccount[3]}  is not created successfully")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("{lsAccount[1]} Account", iValidate, "{lsAccount[1]} Account -  {lsAccount[2]}  is not created successfully")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
[ ] //###########################################################################################################
[ ] 
[+] //#############Verify editing the Interest rate, Regular Payment should also get updated  ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test01_EditInterestRateRegularPaymentUpdated()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify that on editing the Interest rate, Regular Payment should also get updated accordingly. 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			 Pass 	If Accept button in front of every transaction works						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   Feb 04,2014		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_EditInterestRateRegularPaymentUpdated() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sRate
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanAccSheet)
	[ ] sAccount =lsExcelData[2][1]
	[ ] sRate="6"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_PROPERTYDEBT)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Loan Account",PASS,"{sAccount} Online Loan Account is selected successfully")
			[ ] 
			[+] if(MDIClientLoans.LoanWindow.EditInterestRateAmountButton.Exists(5))
				[ ] ReportStatus("Verify Edit Interest Rate present for Manual Loan Account",PASS,"Edit Interest Rate for Manual Loan Account")
				[ ] MDIClientLoans.LoanWindow.EditInterestRateAmountButton.Click()
				[ ] Sleep(2)
				[+] if(LoanInterestRate.Exists(5))
					[ ] ReportStatus("Verify Loan Interest Rate Window",PASS," Loan Interest Rate window is present")
					[ ] LoanInterestRate.SetActive()
					[ ] //----------------------Click on Adjustable Interest Rate----------------------------------
					[ ] LoanInterestRate.Panel.AdjustRateLoans.Click()
					[ ] Sleep(1)
					[ ] LoanInterestRate.AddNewRate.Click()
					[+] if(LoanInterestRate.VariableInterestRate.Exists(5))
						[ ] ReportStatus("Verify Variable Interest Rate Window",PASS," Variable Interest Rate window is present")
						[ ] LoanInterestRate.VariableInterestRate.SetActive()
						[ ] //----------------------Set Variable Interest Rate----------------------------------
						[ ] LoanInterestRate.VariableInterestRate.EffectiveDate.SetText(sDate)
						[ ] LoanInterestRate.VariableInterestRate.EffectiveRate.SetText(sRate)
						[ ] LoanInterestRate.VariableInterestRate.TypeKeys(KEY_TAB)
						[ ] LoanInterestRate.VariableInterestRate.OKButton.Click()
						[ ] Sleep(1)
						[ ] 
						[ ] LoanInterestRate.SetActive()
						[ ] 
						[ ] sHandle = Str(LoanInterestRate.Panel.AdjustableRates.ListBox.GetHandle())
						[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(0))
						[ ] bMatch = MatchStr("*{sDate}*{sRate}*", sActual)
						[+] if (bMatch == TRUE)
							[ ] ReportStatus("Variable Interest Rate in list is the Adjustable Rate Loans", PASS, "Variable Interest Rate is listed in the Adjustable Rate Loans") 
						[+] else
							[ ] ReportStatus(" Variable Interest Rate in list is the Adjustable Rate Loans", FAIL, "Variable Interest Rate is not listed in the Adjustable Rate Loans") 
						[ ] 
						[ ] LoanInterestRate.OKButton.Click()
						[ ] WaitForState(LoanInterestRate ,FALSE ,5)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Variable Interest Rate ",FAIL,"Variable Interest Rate is not present for Manual Loan Account")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Loan Interest Rate ",FAIL,"Loan Interest Rate is not present for Manual Loan Account")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify  for Manual Loan Account",FAIL," for Manual Loan Account")
		[+] else
			[ ] ReportStatus("Select the Manual Loan Account",FAIL,"{sAccount} Manual Loan Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
[ ] //###########################################################################################################
[ ] 
[+] //#############Verify past effective date interest rate entry  ##########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test02_PastEffectiveDateInterestRateEntry()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify that past effective date interest rate entry is allowed on the Adjustable rate array.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If Accept button in front of every transaction works						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   Feb 05,2014		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test02_PastEffectiveDateInterestRateEntry() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] STRING sRate, sMonth,sYear,sDay
	[ ] INTEGER  iMonth,iYear,iDay
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanAccSheet)
	[ ] sAccount =lsExcelData[2][1]
	[ ] sRate="4.5%"
	[ ] sDate=ModifyDate(31,sDateFormat)
	[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") 
	[ ] sDay=FormatDateTime(GetDateTime(), "dd")
	[ ] sMonth=FormatDateTime(GetDateTime(), "mm") //Get current month
	[ ] iMonth = VAL(sMonth) 
	[ ] 
	[+] if (iMonth==12)
		[ ] iYear = VAL(sYear) +1
		[ ] sYear= Str(iYear)
		[ ] iMonth=1
	[+] else
		[ ] iMonth=iMonth+1
	[ ] sMonth = Str(iMonth)
	[ ] sDate = sMonth +"/"+sDay+"/"+sYear
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_PROPERTYDEBT)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Loan Account",PASS,"{sAccount} Online Loan Account is selected successfully")
			[ ] 
			[+] if(MDIClientLoans.LoanWindow.EditInterestRateAmountButton.Exists(5))
				[ ] ReportStatus("Verify Edit Interest Rate present for Manual Loan Account",PASS,"Edit Interest Rate for Manual Loan Account")
				[ ] MDIClientLoans.LoanWindow.EditInterestRateAmountButton.Click()
				[ ] Sleep(2)
				[+] if(LoanInterestRate.Exists(5))
					[ ] ReportStatus("Verify Loan Interest Rate Window",PASS," Loan Interest Rate window is present")
					[ ] LoanInterestRate.SetActive()
					[ ] //----------------------Click on Adjustable Interest Rate----------------------------------
					[ ] LoanInterestRate.Panel.AdjustRateLoans.Click()
					[ ] Sleep(1)
					[+] if(LoanInterestRate.Panel.AdjustableRates.ListBox.Exists(5))
						[ ] //----------------------Click on Add New Rate----------------------------------
						[ ] LoanInterestRate.Panel.AddNewRate.Click()
						[ ] Sleep(1)
						[ ] 
						[+] if(LoanInterestRate.VariableInterestRate.Exists(5))
							[ ] ReportStatus("Verify Variable Interest Rate Window",PASS," Variable Interest Rate window is present")
							[ ] LoanInterestRate.VariableInterestRate.SetActive()
							[ ] 
							[ ] //----------------------Set Variable Interest Rate----------------------------------
							[ ] LoanInterestRate.VariableInterestRate.EffectiveDate.SetText(sDate)
							[ ] LoanInterestRate.VariableInterestRate.EffectiveRate.SetText(sRate)
							[ ] LoanInterestRate.VariableInterestRate.TypeKeys(KEY_TAB)
							[ ] LoanInterestRate.VariableInterestRate.OKButton.Click()
							[ ] Sleep(1)
							[ ] 
							[ ] LoanInterestRate.SetActive()
							[ ] 
							[ ] sHandle = Str(LoanInterestRate.Panel.AdjustableRates.ListBox.GetHandle())
							[ ] iListCount = LoanInterestRate.Panel.AdjustableRates.ListBox.GetItemCount()
							[+] for (iCount=0 ; iCount<= iListCount; iCount++)
								[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(iCount))
								[ ] bMatch = MatchStr("*{sDate}*{sRate}*", sActual)
								[+] if (bMatch)
									[ ] break
							[+] if (bMatch == TRUE)
								[ ] ReportStatus("Variable Interest Rate is list in the Adjustable Rate Loans", PASS, "Variable Interest Rate is list in the Adjustable Rate Loans") 
							[+] else
								[ ] ReportStatus(" Variable Interest Rate is list in the Adjustable Rate Loans", FAIL, "Variable Interest Rate is not list in the Adjustable Rate Loans") 
							[ ] 
							[ ] LoanInterestRate.OKButton.Click()
							[ ] Sleep(1)
							[ ] 
							[ ] sCaption=MDIClientLoans.LoanWindow.InterestRateAmount.GetCaption()
							[ ] 
							[+] if(sCaption==sRate)
								[ ] ReportStatus("Verify Variable Interest Rate got updated",PASS," Variable Interest Rate got updated successfully")
							[+] else
								[ ] ReportStatus("Verify Variable Interest Rate got updated",FAIL," Variable Interest Rate didn't update")
						[+] else
							[ ] ReportStatus("Verify Variable Interest Rate dialog",FAIL,"Dialog Variable Interest Rate didn't appear")
					[+] else
						[ ] ReportStatus("Verify Adjustable Rates panel",FAIL,"Adjustable Rates panel didn't appear")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Loan Interest Rate dialog",FAIL,"Dialog Loan Interest Rate didn't appear")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify  for Manual Loan Account",FAIL," for Manual Loan Account")
		[+] else
			[ ] ReportStatus("Select the Manual Loan Account",FAIL,"{sAccount} Manual Loan Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
[ ] //###########################################################################################################
[ ] 
[+] //#############Verify past effective date interest rate entry  ##########################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	Test03_InterestRateEntryDeleted()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase it will Verify that the interest rate entry can be deleted.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 	If Accept button in front of every transaction works						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   Feb 05,2014		Anagha	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_InterestRateEntryDeleted() appstate none
	[ ] 
	[ ] //------------------ Variable declaration & definition------------------
	[ ] 
	[ ] STRING sRate, sMonth,sYear,sDay
	[ ] INTEGER  iMonth,iYear,iDay
	[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanAccSheet)
	[ ] sAccount =lsExcelData[2][1]
	[ ] sRate="5.5%"
	[ ] sDate=ModifyDate(31,sDateFormat)
	[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") 
	[ ] sDay=FormatDateTime(GetDateTime(), "dd")
	[ ] sMonth=FormatDateTime(GetDateTime(), "mm") //Get current month
	[ ] iMonth= VAL(sMonth)
	[+] if (iMonth==12)
		[ ] iYear = VAL(sYear) +1
		[ ] sYear= Str(iYear)
		[ ] iMonth=1
	[+] else
		[ ] iMonth=iMonth+1
	[ ] sMonth = Str(iMonth)
	[ ] sDate = sMonth +"/"+sDay+"/"+sYear
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------Select the Online Checking Account------------------
		[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_PROPERTYDEBT)	
		[ ] 
		[+] if(iSelect == PASS)
			[ ] ReportStatus("Select the Online Loan Account",PASS,"{sAccount} Online Loan Account is selected successfully")
			[ ] 
			[+] if(MDIClientLoans.LoanWindow.EditInterestRateAmountButton.Exists(5))
				[ ] ReportStatus("Verify Edit Interest Rate present for Manual Loan Account",PASS,"Edit Interest Rate for Manual Loan Account")
				[ ] MDIClientLoans.LoanWindow.EditInterestRateAmountButton.Click()
				[ ] Sleep(2)
				[+] if(LoanInterestRate.Exists(5))
					[ ] ReportStatus("Verify Loan Interest Rate Window",PASS," Loan Interest Rate window is present")
					[ ] LoanInterestRate.SetActive()
					[ ] //----------------------Click on Adjustable Interest Rate----------------------------------
					[ ] LoanInterestRate.Panel.AdjustRateLoans.Click()
					[ ] Sleep(1)
					[ ] 
					[ ] 
					[+] if(LoanInterestRate.Panel.AdjustableRates.ListBox.Exists(5))
						[ ] ReportStatus("Verify Variable Interest Rate Window",PASS," Variable Interest Rate window is present")
						[ ] //----------------------Click on Add New Rate----------------------------------
						[ ] LoanInterestRate.Panel.AddNewRate.Click()
						[ ] Sleep(1)
						[ ] 
						[+] if(LoanInterestRate.VariableInterestRate.Exists(5))
							[ ] ReportStatus("Verify Variable Interest Rate Window",PASS," Variable Interest Rate window is present")
							[ ] LoanInterestRate.VariableInterestRate.SetActive()
							[ ] 
							[ ] 
							[ ] //----------------------Set Variable Interest Rate----------------------------------
							[ ] LoanInterestRate.VariableInterestRate.EffectiveDate.SetText(sDate)
							[ ] LoanInterestRate.VariableInterestRate.EffectiveRate.SetText(sRate)
							[ ] LoanInterestRate.VariableInterestRate.TypeKeys(KEY_TAB)
							[ ] LoanInterestRate.VariableInterestRate.OKButton.Click()
							[ ] Sleep(1)
							[ ] 
							[ ] LoanInterestRate.SetActive()
							[ ] 
							[ ] sHandle = Str(LoanInterestRate.Panel.AdjustableRates.ListBox.GetHandle())
							[ ] iListCount = LoanInterestRate.Panel.AdjustableRates.ListBox.GetItemCount()
							[+] for (iCount=0 ; iCount<= iListCount; iCount++)
								[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(iCount))
								[ ] bMatch = MatchStr("*{sDate}*{sRate}*", sActual)
								[+] if (bMatch)
									[ ] QWAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, str(iCount))
									[ ] Sleep(1)
									[ ] break
							[ ] 
							[ ] LoanInterestRate.Panel.AdjustableRates.ListBox.TextClick("delete")
							[ ] //Delete confirmation message
							[+] if (AlertMessage.Exists(3))
								[ ] AlertMessage.SetActive()
								[ ] AlertMessage.OK.Click()
								[ ] WaitForState(AlertMessage ,FALSE ,5)
								[ ] 
								[+] for(i=0;i<LoanInterestRate.Panel.AdjustableRates.ListBox.GetItemCount();i++)
									[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
									[ ] bMatch = MatchStr("*{sDate}*{sRate}*", sActual)
									[+] if (bMatch)
										[ ] break
								[+] if (bMatch == FALSE)
									[ ] ReportStatus("Variable Interest Rate is deleted from list in the Adjustable Rate Loans", PASS, "Variable Interest Rate is deleted from list Adjustable Rate Loans") 
								[+] else
									[ ] ReportStatus(" Variable Interest Rate is deleted from list in the Adjustable Rate Loans", FAIL, "Variable Interest Rate is deleted not from list Adjustable Rate Loans") 
								[ ] 
								[ ] LoanInterestRate.OKButton.Click()
								[ ] WaitForState(LoanInterestRate ,FALSE ,5)
								[ ] 
							[+] else
								[ ] ReportStatus("Verify delete confirmation for Interest Rate entry",FAIL,"Delete confirmation didn't appear while deleting Interest Rate entry.")
						[+] else
							[ ] ReportStatus("Verify Variable Interest Rate dialog",FAIL,"Dialog Variable Interest Rate didn't appear")
					[ ] 
					[+] else
						[ ] ReportStatus("Verify Adjustable Rates panel",FAIL,"Adjustable Rates panel didn't appear")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Loan Interest Rate dialog",FAIL,"Dialog Loan Interest Rate didn't appear")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify  for Manual Loan Account",FAIL," for Manual Loan Account")
		[+] else
			[ ] ReportStatus("Select the Manual Loan Account",FAIL,"{sAccount} Manual Loan Account is not selected successfully")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
[ ] //###########################################################################################################
[ ] // 
[ ] // 
[ ] // //==========================================================================================
[ ] // //================================= Add Online Loan Account ======================================
[ ] // //==========================================================================================
[ ] 
[ ] 
[+] //######################## Verify that User should be able to add a online loan account  ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_User_Should_Be_Able_To_Add_Single_Online_Loan_Account
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that User should be able to add a online loan account 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User is able to add a online loan account 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  15th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01_User_Should_Be_Able_To_Add_Single_Online_Loan_Account() appstate none //QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails
		[ ] STRING sBankName="CCBank"
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sSplitReminderCategory)
		[ ] lsAddLoanAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
		[ ] lsLoanDetails=lsExcelData[2]
		[ ] 
		[ ] 
		[ ] // Copy autoapi dll for qwauto utility
		[ ] Setup_AutoApi()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] iValidate=DataFileCreate(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Create Data File",PASS,"Data File created successfully")
		[ ] 
		[ ] 
		[ ] //Add Checking account
		[ ] iValidate=AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add Manual spending account",PASS,"Manual Spending account is added")
			[ ] 
			[ ] 
			[ ] // Add a Single Loan Account
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
			[+] if (AddAccount.Exists(30))
				[ ] AddAccount.SetActive()
				[ ] AddAccount.Loan.Click()
				[+] if(AddAnyAccount.Exists(700) && AddAnyAccount.IsEnabled())
					[ ] AddAnyAccount.VerifyEnabled(TRUE,150)
					[ ] AddAnyAccount.SetActive()
				[ ] AddAnyAccount.BankName.TypeKeys(sBankName)  // Enter the name of the bank
				[ ] AddAnyAccount.Next.Click()
				[ ] // sleep(20)
				[ ] WaitForstate(AddAnyAccount.BankUserID,TRUE,200)
				[ ] AddAnyAccount.SetActive ()
				[ ] AddAnyAccount.BankUserID.SetText(lsAddLoanAccount[1])     
				[ ] AddAnyAccount.BankPassword.SetText(lsAddLoanAccount[2])
				[ ] 
				[+] if(AddAnyAccount.Next.IsEnabled() == TRUE)			// Connect/Next button is disabled for blank user id and password
					[ ] 
					[ ] 
					[ ] AddAnyAccount.Next.Click ()
					[ ] WaitForstate(AddAnyAccount.ListBox , TRUE ,300)
					[ ] 
					[ ] AddAnyAccount.ListBox.Select(2)
					[ ] AddAnyAccount.IgnoreMenuItem.Pick()
					[ ] 
					[ ] iValidate=AddSingleAccountFromFI(lsLoanDetails[1])
					[+] if(iValidate==PASS)
						[ ] 
						[ ] 
						[ ] // 
						[ ] // AddAnyAccount.SetActive()
						[ ] // AddAnyAccount.Next.Click ()
						[+] // if(AccountAdded.Exists(140))
							[ ] // 
							[ ] // AccountAdded.SetActive()
							[ ] // AccountAdded.TextClick(sAssetAccountText)
							[ ] // AccountAdded.TypeKeys(Replicate(KEY_DN,4))
							[ ] // AccountAdded.TypeKeys(KEY_ENTER)
							[ ] // AccountAdded.TypeKeys(KEY_RT)
							[ ] // AccountAdded.TypeKeys(KEY_ENTER)
							[ ] // AccountAdded.Done.Click()
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // SelectAccountFromAccountBar(lsLoanDetails[1],ACCOUNT_PROPERTYDEBT)
							[ ] // iValidate=NavigateToAccountDetails(lsLoanDetails[1])
							[+] // if(iValidate==PASS)
								[ ] // 
								[ ] // 
								[+] // if(AccountDetails.LinkedAssetAccount.GetText()==lsAddAccount[2])
									[ ] // ReportStatus("Verify if Account is Linked",PASS,"Account {lsAddAccount[2]} is linked to asset account {lsLoanDetails[1]}")
									[ ] // 
									[ ] // AccountDetails.Close()
									[ ] // WaitForState(AccountDetails,FALSE,5)
									[ ] // 
									[ ] // 
								[+] // else
									[ ] // ReportStatus("Verify if Account is Linked",FAIL,"Account {lsAddAccount[2]} is not linked to asset account {lsLoanDetails[1]}")
									[ ] // 
									[ ] // 
								[ ] // 
								[ ] // 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Verify if Account Details window is launched",FAIL,"Account Details window is not launched")
								[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify if Account is added",FAIL,"Account not added")
							[ ] // 
						[ ] 
						[ ] AddAnyAccount.SetActive()
						[ ] AddAnyAccount.Next.Click ()
						[+] if(AccountAdded.Exists(140))
							[ ] AccountAdded.SetActive ()
							[ ] AccountAdded.Done.Click()
							[ ] 
							[ ] 
							[ ] //  Verify that Account is shown on account bar
							[ ] QuickenWindow.SetActive()
							[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.GetHandle())
							[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,str(0))
							[ ] bMatch = MatchStr("*{lsLoanDetails[1]}*", sActual)
							[+] if(bMatch == TRUE)
								[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{lsLoanDetails[1]} account is available in Account bar")
								[ ] 
								[ ] 
								[ ] 
								[ ] //Delete Loan Account
								[ ] SelectAccountFromAccountBar(lsLoanDetails[1],ACCOUNT_PROPERTYDEBT)
								[ ] iValidate=ModifyAccount(sMDIWindow,lsLoanDetails[1],sDeleteAction)
								[+] if(iValidate==PASS)
									[ ] ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
									[ ] 
								[+] else
									[ ] ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
									[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{lsLoanDetails[1]} account is not available in Account bar")
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
							[ ] ReportStatus("Verify if Account is added",FAIL,"Account not added")
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that account is added from Add FI flow",FAIL,"Error while adding Account from Add FI flow")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Next Button Status", FAIL, "Connect (Next) button is disabled")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if Add Account window is displayed",PASS,"Manual Spending account is added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Add Manual spending account",FAIL,"Manual Spending account is not added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File not created")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //####### Verify that User should be able to add more then one online loan account with same FI user ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_User_Should_Be_Able_To_Add_Multiple_Online_Loan_Accounts_From_Same_FI
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that User should be able to add more then one online loan account with same FI user
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User is able to add more then one online loan account with same FI user
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  15th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test02_User_Should_Be_Able_To_Add_Multiple_Online_Loan_Accounts_From_Same_FI() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sSplitReminderCategory)
		[ ] lsAddLoanAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
		[ ] lsLoanDetails=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] // Copy autoapi dll for qwauto utility
		[ ] Setup_AutoApi()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] //Add Loan account
		[ ] iValidate=AddCCBankLoanAccount(lsAddLoanAccount[1],lsAddLoanAccount[2])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add CCBank loan account",PASS,"CCBank loan account is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify that both loan accounts are added
			[ ] 
			[ ] // Read manual loan account data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
			[ ] 
			[ ] //print(ListCount(lsExcelData))
			[ ] 
			[+] for(i=1;i<=2;i++)
				[ ] 
				[ ] lsLoanDetails=lsExcelData[i]
				[ ] 
				[ ] 
				[ ] iValidate=SelectAccountFromAccountBar(lsLoanDetails[1],ACCOUNT_PROPERTYDEBT)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Open Online loan account register",PASS,"Online loan account {lsLoanDetails[1]} found in Account Bar")
					[ ] 
					[ ] 
					[ ] // //-----------------------Verification for Loan Reminder--------------------------
					[ ] // 
					[ ] // //Verification that Loan reminder option is the default selected
					[ ] // 
					[ ] // //Click on edit payment frequency button
					[ ] // MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
					[+] // if(LoanDetails.Exists(5))
						[ ] // 
						[ ] // LoanDetails.EditLoanReminderButton.Click()
						[ ] // 
						[+] // if(DlgAddEditReminder.Exists(5))
							[ ] // ReportStatus("Verify if Add Reminder dialog is open",PASS,"Add Reminder dialog opens from Edit Loan Reminder button")
							[ ] // 
							[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
							[ ] // 
							[ ] // 
							[+] // if(DlgOptionalSetting.SplitCategoryButton.Exists(5))
								[ ] // ReportStatus("Verify that split category button should be visible",PASS,"Split category button is visible for a detailed reminder")
								[ ] // 
								[ ] // 
								[ ] // //Verify if Split dialog is opened
								[ ] // DlgOptionalSetting.SplitCategoryButton.Click()
								[+] // if(SplitTransaction.Exists(5))
									[ ] // ReportStatus("Verify that split category window is opened",PASS,"Split category window is opened")
									[ ] // 
									[ ] // SplitTransaction.Close()
									[ ] // WaitForState(SplitTransaction,FALSE,5)
									[ ] // 
									[ ] // 
									[ ] // bResult=DlgOptionalSetting.CategoryTextField.IsEnabled()
									[+] // if(bResult==FALSE)
										[ ] // ReportStatus("Verify that split category is added",PASS,"Split category is added since category field is disabled")
										[ ] // 
										[ ] // 
										[ ] // 
									[+] // else
										[ ] // ReportStatus("Verify that split category is not added",FAIL,"Wrong value for category is added since category field is enabled")
										[ ] // 
										[ ] // 
										[ ] // 
									[ ] // 
									[ ] // 
									[ ] // 
								[+] // else
									[ ] // ReportStatus("Verify that split category window is opened",FAIL,"Split category window is not opened")
									[ ] // 
									[ ] // 
								[ ] // 
								[ ] // 
								[ ] // 
								[ ] // 
								[ ] // 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Verify that split category button should not be visible",FAIL,"Split category button is visible for a detailed reminder")
								[ ] // 
								[ ] // 
							[ ] // 
							[ ] // 
							[ ] // //Close Optional Settings dialog
							[ ] // DlgOptionalSetting.CancelButton.Click()
							[ ] // WaitForState(DlgOptionalSetting,FALSE,5)
							[ ] // //Close AddEdit Reminder Dialog
							[ ] // DlgAddEditReminder.CancelButton.Click()
							[ ] // WaitForState(DlgAddEditReminder,FALSE,5)
							[ ] // //Close Loan Details Dialog
							[ ] // LoanDetails.Close()
							[ ] // WaitForState(LoanDetails,FALSE,5)
							[ ] // 
							[ ] // 
							[ ] // 
						[+] // else
							[ ] //  ReportStatus("Verify if Add Reminder dialog is opened",FAIL,"Add Reminder dialog did not open")
							[ ] // 
							[ ] // 
						[ ] // 
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify if Loan details window is open",FAIL,"Loan Details window did not open")
						[ ] // 
						[ ] // 
					[ ] // 
					[ ] 
					[ ] 
					[ ] // 
					[ ] // //Delete Loan Account
					[ ] // iValidate=ModifyAccount(sMDIWindow,lsLoanDetails[1],sDeleteAction)
					[+] // if(iValidate==PASS)
						[ ] // ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
						[ ] // bDeleteTrue=TRUE
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
						[ ] // 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Online loan account register",FAIL,"Online loan account {lsLoanDetails[1]} not found in Account Bar")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Delete Loan Accounts From Quicken
			[+] for(i=2;i>=1;i--)
				[ ] 
				[ ] lsLoanDetails=lsExcelData[i]
				[ ] 
				[ ] 
				[ ] iValidate=SelectAccountFromAccountBar(lsLoanDetails[1],ACCOUNT_PROPERTYDEBT)
				[+] if(iValidate==PASS)
					[ ] 
					[ ] 
					[ ] //Delete Loan Account
					[ ] iValidate=ModifyAccount(sMDIWindow,lsAddLoanAccount[1],sDeleteAction)
					[+] if(iValidate==PASS)
						[ ] ReportStatus("Verify loan account deletion",PASS,"Loan account deleted successfully")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify loan account deletion",FAIL,"Loan account not deleted")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Online loan account register",FAIL,"Online loan account {lsLoanDetails[1]} not found in Account Bar")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Add CCBank loan account",FAIL,"CCBank loan account not added")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken window not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################################################################
[ ] 
[ ] 
[+] //############## Verify that Account discover screen should not have link option for loan account  ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_Account_Discover_Screen_Should_Not_Have_Link_Option_For_Loan_Account
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Account discover screen should not have link option for loan account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Account discover screen doesnt have link option for loan account 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  15th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test03_Account_Discover_Screen_Should_Not_Have_Link_Option_For_Loan_Account() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails
		[ ] STRING sBankName="CCBank"
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sSplitReminderCategory)
		[ ] lsAddLoanAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
		[ ] lsLoanDetails=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] // Copy autoapi dll for qwauto utility
		[ ] Setup_AutoApi()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] // Add a Single Loan Account
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[+] if (AddAccount.Exists(30))
			[ ] AddAccount.SetActive()
			[ ] AddAccount.Loan.Click()
			[+] if(AddAnyAccount.Exists(700) && AddAnyAccount.IsEnabled())
				[ ] AddAnyAccount.VerifyEnabled(TRUE,150)
				[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.BankName.TypeKeys(sBankName)  // Enter the name of the bank
			[ ] AddAnyAccount.Next.Click()
			[ ] // sleep(20)
			[ ] WaitForstate(AddAnyAccount.BankUserID,TRUE,200)
			[ ] AddAnyAccount.SetActive ()
			[ ] AddAnyAccount.BankUserID.SetText(lsAddLoanAccount[1])     
			[ ] AddAnyAccount.BankPassword.SetText(lsAddLoanAccount[2])
			[ ] 
			[+] if(AddAnyAccount.Next.IsEnabled() == TRUE)			// Connect/Next button is disabled for blank user id and password
				[ ] 
				[ ] 
				[ ] AddAnyAccount.Next.Click ()
				[ ] WaitForstate(AddAnyAccount.ListBox , TRUE ,300)
				[ ] 
				[ ] AddAnyAccount.SetActive()
				[ ] AddAnyAccount.ListBox.Select(2)
				[+] if(!AddAnyAccount.LinkMenuItem.Exists(5))
					[ ] ReportStatus("Verify tha Link menu item is not present in Add an Account window",PASS,"Link menu item is not present in Add an Account window for a connected loan account")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify tha Link menu item is not present in Add an Account window",FAIL,"Link menu item is present in Add an Account window for a connected loan account")
					[ ] 
					[ ] 
				[ ] 
				[ ] AddAnyAccount.Close()
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.Yes.Click()
					[ ] WaitForState(AlertMessage,FALSE,5)
					[ ] 
				[ ] WaitForState(AddAnyAccount,FALSE,5)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Next Button Status", FAIL, "Connect (Next) button is disabled")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] 
			[ ] ReportStatus("Verify if Add Account window is displayed",PASS,"Manual Spending account is added")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken window not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################################################################
[ ] 
[ ] 
[+] //######################## Verify that Loan account should be linked to assest account ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_Loan_Account_Should_Be_Linked_To_Asset_Account
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Loan account should be linked to assest account 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Loan account is linked to assest account 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  15th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test04_Loan_Account_Should_Be_Linked_To_Asset_Account() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails
		[ ] STRING sBankName="CCBank"
		[ ] 
		[ ] STRING sAssetAccountText="Add linked asset account"
		[ ] STRING sExistingAccountText="Existing Asset"
		[ ] 
		[ ] //STRING sAssetAccountText="Add linked asset account"
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sAssetAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sSplitReminderCategory)
		[ ] lsAddLoanAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
		[ ] lsLoanDetails=lsExcelData[2]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] Sys_Execute("taskkill /f /im qw.exe" ,NULL , EM_CONTINUE_RUNNING)
	[ ] sleep(5)
	[ ] Sys_Execute("taskkill /f /im qw.exe" ,NULL , EM_CONTINUE_RUNNING)
	[ ] sleep(5)
	[ ] 
	[ ] LaunchQuicken()
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] ExpandAccountBar()
		[ ] 
		[ ] 
		[ ] 
		[ ] //Add an Asset Account
		[ ] 
		[ ] iValidate=AddPropertyAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],lsAddAccount[4],lsAddAccount[5],lsAddAccount[6],lsAddAccount[7])
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Add a Single Loan Account
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
			[+] if (AddAccount.Exists(150))
				[ ] AddAccount.SetActive()
				[ ] AddAccount.Loan.Click()
				[ ] WaitForstate(AddAnyAccount.BankName, TRUE,1000)
				[+] if(AddAnyAccount.Exists(700) && AddAnyAccount.IsEnabled())
					[ ] AddAnyAccount.VerifyEnabled(TRUE,150)
					[ ] AddAnyAccount.SetActive()
				[ ] AddAnyAccount.BankName.TypeKeys(sBankName)  // Enter the name of the bank
				[ ] AddAnyAccount.Next.Click()
				[ ] // sleep(20)
				[ ] WaitForstate(AddAnyAccount.BankUserID,TRUE,200)
				[ ] AddAnyAccount.SetActive ()
				[ ] AddAnyAccount.BankUserID.SetText(lsAddLoanAccount[1])     
				[ ] AddAnyAccount.BankPassword.SetText(lsAddLoanAccount[2])
				[ ] 
				[+] if(AddAnyAccount.Next.IsEnabled() == TRUE)			// Connect/Next button is disabled for blank user id and password
					[ ] 
					[ ] 
					[ ] AddAnyAccount.Next.Click ()
					[ ] WaitForstate(AddAnyAccount.ListBox , TRUE ,300)
					[ ] 
					[ ] iValidate=AddSingleAccountFromFI(lsLoanDetails[1])
					[+] if(iValidate==PASS)
						[ ] 
						[ ] 
						[ ] 
						[ ] AddAnyAccount.SetActive()
						[ ] AddAnyAccount.Next.Click ()
						[+] if(AccountAdded.Exists(140))
							[ ] 
							[ ] AccountAdded.SetActive()
							[ ] AccountAdded.TextClick(sAssetAccountText)
							[ ] AccountAdded.TypeKeys(Replicate(KEY_DN,4))
							[ ] AccountAdded.TypeKeys(KEY_ENTER)
							[ ] AccountAdded.TypeKeys(KEY_RT)
							[ ] AccountAdded.TypeKeys(KEY_ENTER)
							[ ] AccountAdded.Done.Click()
							[ ] 
							[ ] 
							[ ] 
							[ ] SelectAccountFromAccountBar(lsLoanDetails[1],ACCOUNT_PROPERTYDEBT)
							[ ] iValidate=NavigateToAccountDetails(lsLoanDetails[1])
							[+] if(iValidate==PASS)
								[ ] 
								[ ] 
								[+] if(AccountDetails.LinkedAssetAccount.GetText()==lsAddAccount[2])
									[ ] ReportStatus("Verify if Account is Linked",PASS,"Account {lsAddAccount[2]} is linked to asset account {lsLoanDetails[1]}")
									[ ] 
									[ ] AccountDetails.Close()
									[ ] WaitForState(AccountDetails,FALSE,5)
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if Account is Linked",FAIL,"Account {lsAddAccount[2]} is not linked to asset account {lsLoanDetails[1]}")
									[ ] 
									[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if Account Details window is launched",FAIL,"Account Details window is not launched")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Account is added",FAIL,"Account not added")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that account is added from Add FI flow",FAIL,"Error while adding Account from Add FI flow")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Next Button Status", FAIL, "Connect (Next) button is disabled")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] 
				[ ] ReportStatus("Verify if Add Account window is displayed",PASS,"Manual Spending account is added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if asset account is added",FAIL,"Error while adding asset account")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken window not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###################################################################################################################
[ ] 
[ ]  
[ ] // 
[ ] // 
[ ] // 
[ ] // 
[ ] // 
[ ] // 
[ ] // 
