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
	[ ] // Updated by Abhijit S, June 2015
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[-] // INCLUDED FILES
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
	[ ] public STRING sDateFormat="m/d/yyyy"
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
		[-] do
			[ ] 
			[ ] 
			[-] if(AddAnyAccount.Exists(5))
				[ ] 
				[ ] AddAnyAccount.SetActive()
				[ ] 
				[-] while(j<AddAnyAccount.ListBox.GetItemCount())
					[ ] 
					[ ] 
					[ ] sHandle=Str(AddAnyAccount.ListBox.GetHandle())
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,str(j-1))
					[ ] 
					[ ] bMatch=MatchStr("*{sAccountName}*",sActual)
					[-] if(bMatch==FALSE)
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
					[-] else
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
		[-] do
			[ ] 
			[ ] 
			[ ] //----------------Navigate to Loan details window-----------------
			[-] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
				[ ] 
				[ ] AddAnyAccount.SetActive()
				[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
				[ ] 
				[ ] //---------------------Add Loan Details---------------------------------
				[-] if(LoanDetails.Exists(5))
					[ ] 
					[ ] //Loan Name
					[-] if(LoanDetails.LoanNameTextField.Exists(2))
						[ ] // ReportStatus("Verify Loan Name Text field",PASS,"Loan name text field found")
						[ ] 
						[ ] 
						[-] if(LoanDetails.LoanTypePopupList.Exists(2))
							[ ] // ReportStatus("Verify Loan Type Popuplist",PASS,"Loan type popup list  found")
							[ ] 
							[ ] 
							[ ] //Opening Date
							[-] if(LoanDetails.OpeningDateTextField.Exists(2))
								[ ] // ReportStatus("Verify Opening Date Text field",PASS,"Opening Date text field found")
								[ ] 
								[ ] //Original Balance
								[-] if(LoanDetails.OriginalBalanceTextField.Exists(2))
									[ ] // ReportStatus("Verify Original Balance Text Field",PASS,"Original Balance Text Field found")
									[ ] 
									[ ] 
									[ ] //Current Interest Rate
									[-] if(LoanDetails.CurrentInterestRateTextField.Exists(2))
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
[ ] // ===========================================================================================
[ ] // =================================  Loan Reminders ===========================================
[ ] // ===========================================================================================
[ ] 
[ ] 
[+] //##########  Test 1 - Verify that on selecting 'Yes' (second option / Detail reminder) from Loan .R.1:Loan Reminder  - type Selection window, Detail Loan Reminder window is displayed.   #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_Verfiy_Loan_Reminder_With_Yes_Option
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Yes' (second option / Detail reminder) from Loan .R.1:Loan Reminder  - type Selection window, Detail Loan Reminder window is displayed
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Detail Loan Reminder window is displayed
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  18th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01_Verfiy_Loan_Reminder_With_Yes_For_Option2() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] 
		[ ] STRING sExpectedMonthlyPayment
		[ ] 
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[1]
		[ ] sAccountName =lsAccount[1]
		[ ] ////Read sFIDataWorksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sFIDataWorksheet)
		[ ] IsFIData = lsExcelData[1]
		[ ] ////Read sFIDataWorksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Read data from sRegAccountWorksheet excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read data from SuperregisterTransacion excel sheet
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sSuperregisterTransacion)
		[ ] lsTransaction=lsExcelData[1]
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedMonthlyPayment = trim(str(nMonthlypayment, 2,2))
	[ ] iResult=DataFileCreate(sOnlineLoansDataFileName)
	[ ] // iResult=PASS
	[+] if(iResult==PASS)
		[ ] ReportStatus("Create Data File", PASS ,"Data File created successfully.")
		[-] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[-] if (LowScreenResolution.Exists(75))
				[ ] LowScreenResolution.Dontshowthisagain.Check()
				[ ] LowScreenResolution.OK.Click()
				[ ] Sleep(3)
				[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window was closed")
			[-] else
				[-] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window did not appear")
					[ ] 
			[ ] //Add checking Account
			[ ] iResult = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[-] if (iResult==PASS)
				[ ] 
				[ ] iResult =AddCCBankLoanAccount(IsFIData[1] , IsFIData[2] , IsFIData[3])
				[ ] sleep(3)
				[ ] // iResult=PASS
				[-] if (iResult==PASS)
					[ ] ReportStatus("Verify online loan account added. ", PASS , "Online loan account added for FI: {IsFIData[3]}.") 
					[ ] QuickenWindow.SetActive()
					[ ] iResult =SelectAccountFromAccountBar( lsAddAccount[2], ACCOUNT_BANKING)
					[-] if (iResult==PASS)
						[ ] sleep(1)
						[ ] QuickenWindow.SetActive()
						[ ] AddSuperRegisterTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],sDate,lsTransaction[6],lsTransaction[7],lsTransaction[8],lsTransaction[9])
						[ ] sleep(3)
						[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
						[-] if (iResult==PASS)
							[ ] sleep(10)
							[ ] QuickenWindow.SetActive()
							[ ] sleep(10)
							[ ] MDIClientLoans.LoanWindow.AddLoanDetailsButton.Click()
							[ ] sleep(30)
							[-] if(LoanDetails.Exists(10))
								[ ] ReportStatus("Verify LoanDetails dialog. ", PASS , " LoanDetails dialog appeared.") 
								[ ] LoanDetails.SetActive()
								[-] if (!LoanDetails.LoanTypePopupList.Exists(2))
									[ ] ReportStatus("Verify LoanType PopupList on LoanDetails dialog. ", PASS , " LoanType PopupList doesn't exist on LoanDetails dialog for Online loan Account: {sAccountName}.") 
									[ ] LoanDetails.OpeningDateTextField.SetText(sDate)
									[ ] LoanDetails.OriginalBalanceTextField.SetText(lsLoanData1[3])
									[ ] LoanDetails.CurrentInterestRateTextField.SetText(StrTran(lsLoanData1[4],"000",""))
									[ ] //This Tab key is pressed to calculate the Interest Rate
									[ ] LoanDetails.CurrentInterestRateTextField.TypeKeys(KEY_TAB)
									[ ] LoanDetails.OriginalLengthTextField.SetText(lsLoanData1[5])
									[ ] LoanDetails.CurrentInterestRateTextField.TypeKeys(KEY_TAB)
									[ ] sCurrentBalance=LoanDetails.OnlineCurrentBalanceText.GetText()
									[ ] 
									[ ] sMonthlypayment=LoanDetails.MonthlyPaymentTextField.GetText()
									[ ] 
									[ ] 
									[ ] 
									[+] if (sExpectedMonthlyPayment== sMonthlypayment)
										[ ] ReportStatus("Verify Monthly Payment is calculated correctly. ", PASS , "Monthly Payment is calculated correctly as actual: {sMonthlypayment} is same as expected {sExpectedMonthlyPayment}.") 
										[ ] 
										[ ] 
										[ ] LoanDetails.NextButton.Click()
										[ ] LoanDetails.NextButton.Click()
										[ ] DlgLoanReminder.VerifyEnabled(True ,2)
										[ ] DlgLoanReminder.SetActive()
										[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(2)
										[ ] DlgLoanReminder.NextButton.Click()
										[+] if(LoanPaymentReminder.Exists(5))
											[ ] LoanPaymentReminder.SetActive()
											[ ] sReminderMonthlyPayment =LoanPaymentReminder.AmountDueText.GetText()
											[ ] sReminderMonthlyPayment= Trim(StrTran(sReminderMonthlyPayment , "$" ,""))
											[+] if (sExpectedMonthlyPayment== sReminderMonthlyPayment)
												[ ] ReportStatus("Verify Monthly Payment on Reminder is calculated correctly. ", PASS , "Monthly Payment on Reminder is calculated correctly as actual: {sReminderMonthlyPayment} is same as expected {sExpectedMonthlyPayment}.") 
											[+] else
												[ ] ReportStatus("Verify Monthly Payment on Reminder is calculated correctly. ", FAIL , "Monthly Payment on Reminder is calculated incorrectly as actual: {sReminderMonthlyPayment} is NOT as expected {sExpectedMonthlyPayment}.") 
											[ ] LoanPaymentReminder.CancelButton.Click()
											[ ] WaitForState(LoanPaymentReminder , false ,2)
											[ ] ReportStatus("Verify Detail Loan Reminder window is displayed. ", PASS , "Detail Loan Reminder window is displayed.") 
										[+] else
											[ ] ReportStatus("Verify Detail Loan Reminder window is displayed. ", FAIL , "Detail Loan Reminder window didn't display.") 
										[ ] 
										[ ] WaitForState(DlgLoanReminder , True ,2)
										[ ] DlgLoanReminder.SetActive()
										[ ] DlgLoanReminder.CancelButton.Click()
										[+] if (AlertMessage.Exists(3))
											[ ] AlertMessage.SetActive()
											[ ] AlertMessage.Yes.Click()
											[ ] WaitForState(AlertMessage , false ,2)
									[+] else
										[ ] ReportStatus("Verify Monthly Payment is calculated correctly. ", FAIL , "Monthly Payment is calculated incorrectly as actual: {sMonthlypayment} is NOT same as expected {sExpectedMonthlyPayment}.") 
									[ ] 
									[ ] // Added to cater the fail condition
									[+] if(LoanDetails.Exists(5))
										[ ] LoanDetails.SetActive()
										[ ] LoanDetails.CancelButton.Click()
										[+] if (AlertMessage.Exists(3))
											[ ] AlertMessage.SetActive()
											[ ] AlertMessage.Yes.Click()
											[ ] WaitForState(AlertMessage , false ,2)
										[ ] 
										[ ] 
								[+] else
									[ ] ReportStatus("Verify LoanType PopupList on LoanDetails dialog. ", FAIL , " LoanType PopupList exists on LoanDetails dialog for Online loan Account: {sAccountName}.") 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
						[+] else
							[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]} account couldn't open.")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify online loan account added. ", FAIL , "Online loan account couldn't be added for FI {IsFIData[3]}.") 
			[-] else
				[ ] ReportStatus("{lsAddAccount[1]} Account", FAIL, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File couldn't be created.")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //##########  Test 2 - Verify that on selecting 'No' (Third option / Detail reminder) from Loan .R.1:Loan Reminder  - type Selection window, Detail Loan Reminder window is NOT displayed.   #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_Verfiy_Loan_Reminder_With_No_For_Option3
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'No' (Third option / Detail reminder) from Loan .R.1:Loan Reminder  - type Selection window, Detail Loan Reminder window is NOT displayed
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Detail Loan Reminder window is NOT displayed
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 07 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test02VerfiyLoanReminderWithNoForOption3() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] STRING sExpectedMonthlyPayment
		[ ] 
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Read data from sRegAccountWorksheet excel sheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read data from SuperregisterTransacion excel sheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sSuperregisterTransacion)
		[ ] lsTransaction=lsExcelData[2]
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedMonthlyPayment = trim(str(nMonthlypayment, 2,2))
	[ ] 
	[ ] iResult=OpenDataFile(sOnlineLoansDataFileName)
	[ ] // iResult=PASS
	[-] if(iResult==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
		[-] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] iResult =SelectAccountFromAccountBar( lsAddAccount[2], ACCOUNT_BANKING)
			[-] if (iResult==PASS)
				[ ] sleep(1)
				[ ] QuickenWindow.SetActive()
				[ ] AddSuperRegisterTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],sDate,lsTransaction[6],lsTransaction[7],lsTransaction[8],lsTransaction[9])
				[ ] sleep(3)
				[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
				[-] if (iResult==PASS)
					[ ] sleep(10)
					[ ] QuickenWindow.SetActive()
					[ ] sleep(10)
					[ ] MDIClientLoans.LoanWindow.AddLoanDetailsButton.Click()
					[ ] sleep(30)
					[+] if(LoanDetails.Exists(10))
						[ ] ReportStatus("Verify LoanDetails dialog. ", PASS , " LoanDetails dialog appeared.") 
						[ ] LoanDetails.SetActive()
						[+] if (!LoanDetails.LoanTypePopupList.Exists(2))
							[ ] ReportStatus("Verify LoanType PopupList on LoanDetails dialog. ", PASS , " LoanType PopupList doesn't exist on LoanDetails dialog for Online loan Account: {sAccountName}.") 
							[ ] LoanDetails.OpeningDateTextField.SetText(sDate)
							[ ] LoanDetails.OriginalBalanceTextField.SetText(lsLoanData1[3])
							[ ] LoanDetails.CurrentInterestRateTextField.SetText(StrTran(lsLoanData1[4],"000",""))
							[ ] //This Tab key is pressed to calculate the Interest Rate
							[ ] LoanDetails.CurrentInterestRateTextField.TypeKeys(KEY_TAB)
							[ ] LoanDetails.OriginalLengthTextField.SetText(lsLoanData1[5])
							[ ] LoanDetails.CurrentInterestRateTextField.TypeKeys(KEY_TAB)
							[ ] sCurrentBalance=LoanDetails.OnlineCurrentBalanceText.GetText()
							[ ] 
							[ ] sMonthlypayment=LoanDetails.MonthlyPaymentTextField.GetText()
							[ ] 
							[+] if (sExpectedMonthlyPayment== sMonthlypayment)
								[ ] ReportStatus("Verify Monthly Payment is calculated correctly. ", PASS , "Monthly Payment is calculated correctly as actual: {sMonthlypayment} is same as expected {sExpectedMonthlyPayment}.") 
								[ ] 
								[ ] 
								[ ] LoanDetails.NextButton.Click()
								[ ] LoanDetails.NextButton.Click()
								[ ] DlgLoanReminder.VerifyEnabled(True ,2)
								[ ] DlgLoanReminder.SetActive()
								[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(3)
								[ ] DlgLoanReminder.DoneButton.Click()
								[+] if(LoanPaymentReminder.Exists(5))
									[ ] LoanPaymentReminder.SetActive()
									[ ] LoanPaymentReminder.CancelButton.Click()
									[ ] WaitForState(LoanPaymentReminder , false ,2)
									[ ] ReportStatus("Verify Detail Loan Reminder window is displayed. ", FAIL , "Detail Loan Reminder window is displayed upon selecting third option from Loan .R.1:Loan Reminder.") 
								[+] else
									[ ] ReportStatus("Verify Detail Loan Reminder window is displayed. ", PASS , "Detail Loan Reminder window didn't display upon selecting third option from Loan .R.1:Loan Reminder.") 
								[ ] 
								[+] if (AlertMessage.Exists(3))
									[ ] AlertMessage.SetActive()
									[ ] AlertMessage.Yes.Click()
									[ ] WaitForState(AlertMessage , false ,2)
							[+] else
								[ ] ReportStatus("Verify Monthly Payment is calculated correctly. ", FAIL , "Monthly Payment is calculated incorrectly as actual: {sMonthlypayment} is NOT same as expected {sExpectedMonthlyPayment}.") 
							[ ] 
							[ ] // Added to cater the fail condition
							[+] if(LoanDetails.Exists(5))
								[ ] LoanDetails.SetActive()
								[ ] LoanDetails.CancelButton.Click()
								[+] if (AlertMessage.Exists(3))
									[ ] AlertMessage.SetActive()
									[ ] AlertMessage.Yes.Click()
									[ ] WaitForState(AlertMessage , false ,2)
								[ ] 
								[ ] 
						[+] else
							[ ] ReportStatus("Verify LoanType PopupList on LoanDetails dialog. ", FAIL , " LoanType PopupList exists on LoanDetails dialog for Online loan Account: {sAccountName}.") 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
				[+] else
					[ ] ReportStatus("Verify {sAccountName} Account", FAIL, "{sAccountName} account couldn't open.")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify {lsAddAccount[2]} Account", FAIL, "{lsAddAccount[2]} account couldn't open.")
				[ ] 
				[+] 
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
[ ] //#######################################################################################################
[ ] 
[+] //##########  Test 3 - Verify that label for the Payment on Loan.D.1: Loan Details - Add Loan Details window, changes according to the Payment Schedule dropdown values and same label and value is displayed on Loan.R.1: Loan Reminder - Type Selection against first option.  #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_Verfiy_Loan_Reminder_With_No_For_Option3
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'No' (Third option / Detail reminder) from Loan .R.1:Loan Reminder  - type Selection window, Detail Loan Reminder window is NOT displayed
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Detail Loan Reminder window is NOT displayed
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 08 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test03_VerifyOnlineLoanAccountFields() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] STRING sExpectedPayment , sActualMonthlyPayment ,sActualPrincipalDeterminesTotalOption ,sPrincipalDeterminesTotalOption ,sActualFirstOptionPaymentAmount
		[ ] 
		[ ] sPrincipalDeterminesTotalOption="Extra principal determines total"
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Read data from sRegAccountWorksheet excel sheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read data from SuperregisterTransacion excel sheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sSuperregisterTransacion)
		[ ] lsTransaction=lsExcelData[2]
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
	[ ] 
	[-] if(FileExists(sOnlineLoansDataFile))
		[-] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.Kill()
		[ ] Waitforstate(QuickenWindow,False,5)
		[ ] DeleteFile(sOnlineLoansDataFile)
	[ ] SYS_CopyFile (sOnlineLoansDataSource,sOnlineLoansDataFile)
	[+] if(!QuickenWindow.Exists(5))
		[ ] App_Start(sCmdLine)
		[ ] sleep(5)
		[ ] WaitForState(QuickenWindow , true , 20)
	[ ] iResult=OpenDataFile(sOnlineLoansDataFileName)
	[ ] // iResult=PASS
	[-] if(iResult==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
		[-] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] iResult =OnlineLoansNaviagateToD2Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
			[-] if (iResult==PASS)
				[-] if(LoanDetails.Exists(10))
					[ ] LoanDetails.SetActive()
					[ ] sActualMonthlyPayment = LoanDetails.TotalPaymentAmount.GetText()
					[-] if (sExpectedPayment== sActualMonthlyPayment)
						[ ] ReportStatus("Verify Monthly Payment is calculated correctly. ", PASS , "Monthly Payment is calculated correctly as actual: {sActualMonthlyPayment} is same as expected {sExpectedPayment}.") 
						[ ] 
					[-] else
						[ ] ReportStatus("Verify Monthly Payment is calculated correctly. ", FAIL , "Monthly Payment is calculated correctly as actual: {sActualMonthlyPayment} is NOT as expected {sExpectedPayment}.") 
					[ ] 
					[ ] sActualPrincipalDeterminesTotalOption=LoanDetails.PrincipaldDeterminesTotalOptionRadioList.GetSelItem()
					[ ] 
					[-] if (sPrincipalDeterminesTotalOption== sActualPrincipalDeterminesTotalOption)
						[ ] ReportStatus("Verify Extra principal determines total is selected by default. ", PASS , "Extra principal determines total is selected by default.") 
						[ ] 
					[-] else
						[ ] ReportStatus("Verify Extra principal determines total is selected by default. ", FAIL , "Extra principal determines total is NOT selected by default, selected option is: {sActualPrincipalDeterminesTotalOption}.") 
					[ ] 
					[ ] //Reminder step verification
					[ ] LoanDetails.NextButton.Click()
					[ ] DlgLoanReminder.SetActive()
					[ ] 
					[ ] sActualFirstOptionPaymentAmount=DlgLoanReminder.FirstOptionPaymentAmount.GetCaption()
					[ ] // bMatch = MatchStr("*{sExpectedPayment}*{lsLoanData1[8]}",sActualFirstOptionPaymentAmount)
					[-] if (MatchStr("*{sExpectedPayment}*{trim(lsLoanData1[8])}",sActualFirstOptionPaymentAmount))
						[ ] ReportStatus("Verify Monthly Payment on D3 Reminder window for first option. ", PASS , "Monthly Payment on D3 Reminder window for first option displayed actual: {sActualFirstOptionPaymentAmount} is same as expected {sExpectedPayment} {lsLoanData1[8]}.") 
						[ ] 
					[-] else
						[ ] ReportStatus("Verify Monthly Payment on D3 Reminder window for first option. ", FAIL , "Monthly Payment on D3 Reminder window for first option not displayed actual: {sActualFirstOptionPaymentAmount} is NOT same as expected {sExpectedPayment} {lsLoanData1[8]}.") 
					[ ] 
					[ ] DlgLoanReminder.CancelButton.Click()
					[-] if (AlertMessage.Exists(3))
						[ ] AlertMessage.SetActive()
						[ ] AlertMessage.Yes.Click()
						[ ] WaitForState(AlertMessage , FALSE ,3)
				[-] else
					[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[+] iFunctionResult=FAIL
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify NextPaymentDueTextField on Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########Test 4 - Verify the functionality of the 'Cancel' button on the Loan.R.1:Loan Reminder - Type Selection window'. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_VerifythefunctionalityoftheCancelbuttonontheLoanReminder
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will the functionality of the 'Cancel' button on the Loan.R.1:Loan Reminder - Type Selection window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If cancel , ALT+F4 and ESC keys worked as expected on  Detail Loan Reminder window
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 08 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test04_VerifythefunctionalityoftheCancelbuttonontheLoanReminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] 
		[ ] STRING sExpectedPayment , sActualMonthlyPayment ,sActualPrincipalDeterminesTotalOption ,sPrincipalDeterminesTotalOption ,sActualFirstOptionPaymentAmount
		[ ] STRING sCancelWindowType
		[ ] LIST OF STRING lsCancelWindowType
		[ ] 
		[ ] 
		[ ] lsCancelWindowType={"Close" ,"Cancel","ALT - F4"}
		[ ] sPrincipalDeterminesTotalOption="Extra principal determines total"
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
	[ ] 
	[-] for each sCancelWindowType in lsCancelWindowType
		[-] if(FileExists(sOnlineLoansDataFile))
			[-] if (QuickenWindow.Exists(5))
				[ ] QuickenWindow.Kill()
			[ ] Waitforstate(QuickenWindow,False,5)
			[ ] DeleteFile(sOnlineLoansDataFile)
		[ ] SYS_CopyFile (sOnlineLoansDataSource,sOnlineLoansDataFile)
		[-] if(!QuickenWindow.Exists(5))
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
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[+] if (iResult==PASS)
					[+] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] 
						[ ] sActualFirstOptionPaymentAmount=DlgLoanReminder.FirstOptionPaymentAmount.GetCaption()
						[ ] bMatch = MatchStr("*{sExpectedPayment}*{trim(lsLoanData1[8])}",sActualFirstOptionPaymentAmount)
						[+] if (bMatch)
							[ ] ReportStatus("Verify Monthly Payment on D3 Reminder window for first option.", PASS , "Monthly Payment on D3 Reminder window for first option displayed actual: {sActualFirstOptionPaymentAmount} is same as expected {sExpectedPayment} {lsLoanData1[8]}.") 
							[ ] //Verify functionality of the Cancel button 
							[ ] 
							[+] switch (sCancelWindowType)
								[+] case "Cancel"
									[ ] 
									[ ] 
									[ ] DlgLoanReminder.CancelButton.Click()
									[ ] //Alert Message verification for No
									[+] if (AlertMessage.Exists(3))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.No.Click()
										[+] if(DlgLoanReminder.Exists(5))
											[ ] ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", PASS, "D3 Reminder window became active after clicking No on the Confirmation dialog for {sCancelWindowType} fuctionality verification.")
										[+] else
											[ ] ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", FAIL, "D3 Reminder window disappeared after clicking No on the Confirmation dialog for {sCancelWindowType} fuctionality verification.")
									[+] else
										[ ] ReportStatus("Verify functionality of the Cancel button on D3 Reminder window", FAIL, "Confirmation message didn't appear after clicking {sCancelWindowType} on D3 Reminder window")
									[ ] 
									[ ] 
									[ ] DlgLoanReminder.CancelButton.Click()
									[ ] //Alert Message verification for Yes
									[+] if (AlertMessage.Exists(3))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.Yes.Click()
										[+] if(!DlgLoanReminder.Exists(5))
											[ ] ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", PASS, "D3 Reminder window disappeared after clicking Yes on the Confirmation dialog for {sCancelWindowType} fuctionality verification.")
										[+] else
											[ ] ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", FAIL, "D3 Reminder window still active after clicking Yes on the Confirmation dialog for {sCancelWindowType} fuctionality verification.")
									[+] else
										[ ] ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", FAIL, "Confirmation message didn't appear after clicking {sCancelWindowType} on D3 Reminder window.")
								[+] // case "Close"
									[ ] // 
									[ ] // DlgLoanReminder.Close()
									[ ] // //Alert Message verification for No
									[+] // if (AlertMessage.Exists(3))
										[ ] // AlertMessage.SetActive()
										[ ] // AlertMessage.No.Click()
										[+] // if(DlgLoanReminder.Exists(5))
											[ ] // ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", PASS, "D3 Reminder window became active after clicking No on the Confirmation dialog for {sCancelWindowType} fuctionality verification.")
										[+] // else
											[ ] // ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", FAIL, "D3 Reminder window disappeared after clicking No on the Confirmation dialog for {sCancelWindowType} fuctionality verification.")
									[+] // else
										[ ] // ReportStatus("Verify functionality of the Cancel button on D3 Reminder window", FAIL, "Confirmation message didn't appear after clicking {sCancelWindowType} on D3 Reminder window")
									[ ] // 
									[ ] // 
									[ ] // DlgLoanReminder.Close()
									[ ] // //Alert Message verification for Yes
									[+] // if (AlertMessage.Exists(3))
										[ ] // AlertMessage.SetActive()
										[ ] // AlertMessage.Yes.Click()
										[+] // if(!DlgLoanReminder.Exists(5))
											[ ] // ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", PASS, "D3 Reminder window disappeared after clicking Yes on the Confirmation dialog for {sCancelWindowType} fuctionality verification.")
										[+] // else
											[ ] // ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", FAIL, "D3 Reminder window still active after clicking Yes on the Confirmation dialog for {sCancelWindowType} fuctionality verification.")
									[+] // else
										[ ] // ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", FAIL, "Confirmation message didn't appear after clicking {sCancelWindowType} on D3 Reminder window.")
									[ ] // 
								[+] case "ALT - F4"
									[ ] 
									[ ] DlgLoanReminder.TypeKeys(KEY_EXIT)
									[ ] //Alert Message verification for No
									[+] if (AlertMessage.Exists(3))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.No.Click()
										[+] if(DlgLoanReminder.Exists(5))
											[ ] ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", PASS, "D3 Reminder window became active after clicking No on the Confirmation dialog for {sCancelWindowType} fuctionality verification.")
										[+] else
											[ ] ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", FAIL, "D3 Reminder window disappeared after clicking No on the Confirmation dialog for {sCancelWindowType} fuctionality verification.")
									[+] else
										[ ] ReportStatus("Verify functionality of the Cancel button on D3 Reminder window", FAIL, "Confirmation message didn't appear after clicking {sCancelWindowType} on D3 Reminder window")
									[ ] 
									[ ] 
									[ ] DlgLoanReminder.TypeKeys(KEY_EXIT)
									[ ] //Alert Message verification for Yes
									[+] if (AlertMessage.Exists(3))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.Yes.Click()
										[+] if(!DlgLoanReminder.Exists(5))
											[ ] ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", PASS, "D3 Reminder window disappeared after clicking Yes on the Confirmation dialog for {sCancelWindowType} fuctionality verification.")
										[+] else
											[ ] ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", FAIL, "D3 Reminder window still active after clicking Yes on the Confirmation dialog for {sCancelWindowType} fuctionality verification.")
									[+] else
										[ ] ReportStatus("Verify functionality of the {sCancelWindowType} button on D3 Reminder window", FAIL, "Confirmation message didn't appear after clicking {sCancelWindowType} on D3 Reminder window.")
									[ ] 
								[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Monthly Payment on D3 Reminder window for first option. ", FAIL , "Monthly Payment on D3 Reminder window for first option not displayed actual: {sActualFirstOptionPaymentAmount} is NOT same as expected {sExpectedPayment} {lsLoanData1[8]}.") 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify NextPaymentDueTextField on Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########  Test 6 - Verify that if values edited on Loan.D.2: Loan Details - Payment Details  for  Extra Principal and Other are properly displayed on Loan.R.1:Loan Reminder - Type Selection window for second option. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_VerifyPaymentDeatailsForExtraPrincipalAndOtherOnLoanReminder
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Test 6 - Verify that if values edited on Loan.D.2: Loan Details - Payment Details  for  Extra Principal and Other are properly displayed on Loan.R.1:Loan Reminder - Type Selection window for second option.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  Payment Details for  Extra Principal and Other are properly displayed on Loan.R.1:Loan Reminder
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 10 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test06_VerifyPaymentDeatailsForExtraPrincipalAndOtherOnLoanReminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] STRING sExpectedPayment  , sExpectedPrincipal ,sActualPrincipal ,sExpectedOther ,sActualOther  ,sActualFirstOptionPaymentAmount
		[ ] STRING sActualTotalPaymentAmountL2 ,sActualTotalPaymentTextOnReminder
		[ ] NUMBER nExpectedPrincipal ,nExpectedOther ,nExpectedPayment
		[ ] nExpectedPrincipal =500.00
		[ ] nExpectedOther =200.00
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Read data from sRegAccountWorksheet excel sheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read data from SuperregisterTransacion excel sheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sSuperregisterTransacion)
		[ ] lsTransaction=lsExcelData[2]
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
	[ ] // iResult=PASS
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] iResult =OnlineLoansNaviagateToD2Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
			[+] if (iResult==PASS)
				[+] if(LoanDetails.Exists(5))
					[ ] LoanDetails.SetActive()
					[ ] ///Total Payment Amount verification at reminder screen without editing the Other and Extra Principal at Loan step 2
					[ ] sActualTotalPaymentAmountL2 = LoanDetails.TotalPaymentAmount.GetText()
					[ ] sActualTotalPaymentAmountL2=StrTran(sActualTotalPaymentAmountL2 ,"," ,"")
					[+] if (sExpectedPayment== sActualTotalPaymentAmountL2)
						[ ] ReportStatus("Verify Monthly Payment is calculated correctly. ", PASS , "Monthly Payment is calculated correctly as actual: {sActualTotalPaymentAmountL2} is same as expected {sExpectedPayment}.") 
						[ ] 
						[ ] //Reminder step verification
						[ ] LoanDetails.NextButton.Click()
						[+] if (DlgLoanReminder.Exists(2))
							[ ] DlgLoanReminder.SetActive()
							[ ] 
							[ ] sActualFirstOptionPaymentAmount=DlgLoanReminder.FirstOptionPaymentAmount.GetCaption()
							[ ] bMatch =  (MatchStr("*{sExpectedPayment}*{trim(lsLoanData1[8])}",sActualFirstOptionPaymentAmount))
							[+] if (bMatch)
								[ ] ReportStatus("Verify Monthly Payment on D3 Reminder window for first option. ", PASS , "Monthly Payment on D3 Reminder window for first option displayed actual: {sActualFirstOptionPaymentAmount} is same as expected {sExpectedPayment} {lsLoanData1[8]}.") 
								[ ] 
								[ ] DlgLoanReminder.SetActive()
								[ ] DlgLoanReminder.BackButton.Click()
								[+] if(LoanDetails.Exists(5))
									[ ] LoanDetails.SetActive()
									[ ] 
									[ ] nMonthlypayment = VAL (lsLoanData1[10])
									[ ] nExpectedPayment=nMonthlypayment+nExpectedPrincipal +nExpectedOther
									[ ] sExpectedPayment = trim(str(nExpectedPayment, 2,2))
									[ ] 
									[ ] ///Total Payment Amount verification at reminder screen after editing the Other and Extra Principal at Loan step 2
									[ ] 
									[ ] LoanDetails.OtherTextField.SetText(Str(nExpectedOther))
									[ ] LoanDetails.PrincipalTextField.SetText(Str(nExpectedPrincipal))
									[ ] LoanDetails.TypeKeys(KEY_TAB)
									[ ] LoanDetails.TypeKeys(KEY_TAB)
									[ ] 
									[ ] sActualTotalPaymentAmountL2 = LoanDetails.TotalPaymentAmount.GetText()
									[ ] sActualTotalPaymentAmountL2=StrTran(sActualTotalPaymentAmountL2 ,"," ,"")
									[+] if (sExpectedPayment== sActualTotalPaymentAmountL2)
										[ ] ReportStatus("Verify Monthly Payment is calculated correctly. ", PASS , "Monthly Payment is calculated correctly as actual: {sActualTotalPaymentAmountL2} is same as expected {sExpectedPayment}.") 
										[ ] 
										[ ] //Reminder step verification
										[ ] LoanDetails.SetActive()
										[ ] LoanDetails.NextButton.Click()
										[+] if (DlgLoanReminder.Exists(2))
											[ ] DlgLoanReminder.SetActive()
											[ ] 
											[ ] sActualFirstOptionPaymentAmount=DlgLoanReminder.FirstOptionPaymentAmount.GetCaption()
											[ ] sActualFirstOptionPaymentAmount=StrTran(sActualFirstOptionPaymentAmount,",","")
											[ ] bMatch =  (MatchStr("*{sExpectedPayment}*{trim(lsLoanData1[8])}*",sActualFirstOptionPaymentAmount))
											[+] if (bMatch)
												[ ] ReportStatus("Verify Monthly Payment on D3 Reminder window for first option. ", PASS , "Monthly Payment on D3 Reminder window for first option displayed actual: {sActualFirstOptionPaymentAmount} is same as expected {sExpectedPayment} {lsLoanData1[8]}.") 
												[ ] 
												[ ] DlgLoanReminder.SetActive()
												[ ] 
												[ ] sActualPrincipal=DlgLoanReminder.PrincipalTextOnReminder.GetCaption()
												[ ] //sActualPrincipal=DlgLoanReminder.InterestTextOnReminder.GetCaption()
												[ ] sActualOther=DlgLoanReminder.OtherTextOnReminder.GetCaption()
												[ ] 
												[ ] sActualTotalPaymentTextOnReminder=DlgLoanReminder.TotalPaymentTextOnReminder.GetCaption()
												[ ] sActualTotalPaymentTextOnReminder=StrTran(sActualTotalPaymentTextOnReminder,",","")
												[ ] 
												[ ] 
												[+] if (sActualPrincipal== str(nExpectedPrincipal,NULL,2))
													[ ] ReportStatus("Verify Extra Principal on reminder step" , PASS , "Extra Principal on reminder :{sActualPrincipal} is same as on Loan step2 : {str(nExpectedPrincipal)}.")
													[ ] 
													[ ] 
												[+] else
													[ ] ReportStatus("Verify Extra Principal on reminder step" , FAIL , "Extra Principal on reminder :{sActualPrincipal} is NOT same as on Loan step2 : {str(nExpectedPrincipal)}.")
												[ ] 
												[ ] 
												[+] if (sActualOther== str(nExpectedOther,NULL,2))
													[ ] ReportStatus("Verify Other on reminder step" , PASS , "Other on reminder :{sActualOther} is same as on Loan step2 : {str(nExpectedOther)}.")
												[+] else
													[ ] ReportStatus("Verify Other on reminder step" , FAIL , "Other on reminder :{sActualOther} is NOT same as on Loan step2 : {str(nExpectedOther)}.")
												[ ] 
												[+] if (sActualTotalPaymentTextOnReminder== sExpectedPayment)
													[ ] ReportStatus("Verify Toatal Payment on reminder step" , PASS , "Toatal Payment on reminder :{sActualTotalPaymentTextOnReminder} is same as on Loan step2 : {sExpectedPayment}.")
												[+] else
													[ ] ReportStatus("Verify Toatal Payment on reminder step" , FAIL , "Toatal Payment on reminder :{sActualTotalPaymentTextOnReminder} is NOT same as on Loan step2 : {sExpectedPayment}.")
												[ ] 
												[ ] 
												[ ] 
												[ ] 
											[+] else
												[ ] ReportStatus("Verify Monthly Payment on D3 Reminder window for first option. ", FAIL , "Monthly Payment on D3 Reminder window for first option not displayed actual: {sActualFirstOptionPaymentAmount} is NOT same as expected {sExpectedPayment} {lsLoanData1[8]}.") 
										[+] else
											[ ] ReportStatus("Verify Loan Reminder dialog. ", FAIL , " Loan Reminder dialog didn't appear.") 
											[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Monthly Payment is calculated correctly. ", FAIL , "Monthly Payment is calculated correctly as actual: {sActualTotalPaymentAmountL2} is NOT as expected {sExpectedPayment}.") 
									[ ] 
									[ ] ///Total Payment Amount verification at reminder screen after editing the Other and Extra Principal at Loan step 2
									[+] if (DlgLoanReminder.Exists(2))
										[ ] DlgLoanReminder.SetActive()
										[ ] DlgLoanReminder.CancelButton.Click()
										[+] if (AlertMessage.Exists(3))
											[ ] AlertMessage.SetActive()
											[ ] AlertMessage.Yes.Click()
											[ ] WaitForState(AlertMessage , FALSE ,3)
								[+] else
									[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Monthly Payment on D3 Reminder window for first option. ", FAIL , "Monthly Payment on D3 Reminder window for first option not displayed actual: {sActualFirstOptionPaymentAmount} is NOT same as expected {sExpectedPayment} {lsLoanData1[8]}.") 
						[+] else
							[ ] ReportStatus("Verify Loan Reminder dialog. ", FAIL , " Loan Reminder dialog didn't appear.") 
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Monthly Payment is calculated correctly. ", FAIL , "Monthly Payment calculated actual: {sActualTotalPaymentAmountL2} is NOT as expected {sExpectedPayment}.") 
					[ ] 
					[ ] ///Total Payment Amount verification at reminder screen after editing the Other and Extra Principal at Loan step 2
					[+] if (DlgLoanReminder.Exists(2))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.CancelButton.Click()
						[+] if (AlertMessage.Exists(3))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.Yes.Click()
							[ ] WaitForState(AlertMessage , FALSE ,3)
				[+] else
					[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify NextPaymentDueTextField on Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########  Test 7. Verify that user is not able to schedule bill reminder for a connected loan account from Bills tab.. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_VerifyThatUserIsNotAbleToScheduleBillReminderForAConnectedLoanAccountFromBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that user is not able to schedule bill reminder for a connected loan account from Bills tab.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is not able to schedule bill reminder for a connected loan account from Bills tab.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 13 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test07_VerifyThatUserIsNotAbleToScheduleBillReminderForAConnectedLoanAccountFromBillsTab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sActualAccountName
		[ ] ////Read sLoanAccountWorksheet
		[ ] INTEGER iExpectedAccountCount
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] 
		[ ] // Read data from sRegAccountWorksheet excel sheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read data from SuperregisterTransacion excel sheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sReminderWorksheet)
		[ ] lsReminderData=lsExcelData[2]
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
	[ ] // iResult=PASS
	[-] if(iResult==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
		[-] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[+] if (LowScreenResolution.Exists(75))
				[ ] LowScreenResolution.Dontshowthisagain.Check()
				[ ] LowScreenResolution.OK.Click()
				[ ] Sleep(3)
				[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window was closed")
			[+] else
				[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window did not appear")
			[ ] 
			[ ] sReminderType=lsReminderData[1]
			[ ] sPayeeName=lsReminderData[2]
			[ ] iResult=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[-] if (iResult == PASS)
				[-] if(DlgAddEditReminder.Exists(SHORT_SLEEP))
					[ ] DlgAddEditReminder.SetActive()
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.TypeKeys(KEY_TAB)
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.TypeKeys(KEY_BACKSPACE)
					[ ] sleep(1)
					[ ] sActualAccountName=DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.GetText()
					[ ] iCount=AccountQuickFillIncome.QWinChild.ListBox.GetItemCount()
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.TypeKeys(KEY_ESC)
					[ ] 
					[-] if (iCount==1)
						[ ] 
						[-] if (sActualAccountName!=sAccountName)
							[ ] ReportStatus("Verify that user is not able to schedule {sReminderType} reminder for a connected loan account from Bills tab",PASS,"Verify that user is not able to schedule {sReminderType} reminder for a connected loan account from Bills tab.")	
						[+] else
							[ ] ReportStatus("Verify that user is not able to schedule {sReminderType} reminder for a connected loan account from Bills tab",FAIL, "User is able to schedule {sReminderType} reminder for a connected loan account from Bills tab as: {sAccountName} is available in account list on {sReminderType} reminder.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that user is not able to schedule {sReminderType} reminder for a connected loan account from Bills tab",FAIL,"Multiple accounts are available in account list on {sReminderType} reminder. Actual number of account {iCount}, Expected is one")
					[ ] 
					[-] if(DlgAddEditReminder.Exists(SHORT_SLEEP))
						[ ] DlgAddEditReminder.SetActive()
						[ ] DlgAddEditReminder.CancelButton.Click()
						[ ] WaitForState(DlgAddEditReminder , false ,2)
						[ ] sleep(2)
					[ ] 
				[-] else
					[ ] ReportStatus("Verify {sReminderType} Reminder dialog second step",FAIL,"Add {sReminderType} Reminder dialog didn't move second step.")	
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify {sReminderType} Reminder dialog",FAIL,"Add {sReminderType} Reminder dialog is not available")	
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[-] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sOnlineLoansDataFileName} couldn't be opened.")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //##########  Test 8. Verify that user is not able to schedule Income reminder for a connected loan account from Bills tab.. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test 8. Verify that user is not able to schedule Income reminder for a connected loan account from Bills tab.
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that user is not able to schedule income reminder for a connected loan account from Bills tab.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is not able to schedule income reminder for a connected loan account from Bills tab.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 13 2013
		[ ] //
	[ ] // ********************************************************
[ ] 
[+] testcase Test08_VerifyThatUserIsNotAbleToScheduleIncomeReminderForAConnectedLoanAccountFromBillsTab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sActualAccountName
		[ ] ////Read sLoanAccountWorksheet
		[ ] INTEGER iExpectedAccountCount
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] 
		[ ] // Read data from sRegAccountWorksheet excel sheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read data from SuperregisterTransacion excel sheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sReminderWorksheet)
		[ ] lsReminderData=lsExcelData[1]
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
	[ ] // iResult=PASS
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
		[-] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[+] if (LowScreenResolution.Exists(75))
				[ ] LowScreenResolution.Dontshowthisagain.Check()
				[ ] LowScreenResolution.OK.Click()
				[ ] Sleep(3)
				[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window was closed")
			[+] else
				[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window did not appear")
			[ ] 
			[ ] sReminderType=lsReminderData[1]
			[ ] sPayeeName=lsReminderData[2]
			[ ] iResult=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[-] if (iResult == PASS)
				[-] if(DlgAddEditReminder.Exists(SHORT_SLEEP))
					[ ] DlgAddEditReminder.SetActive()
					[ ] sActualAccountName=DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.GetText()
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.TypeKeys(KEY_TAB)
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.TypeKeys(KEY_BACKSPACE)
					[ ] sleep(3)
					[ ] 
					[ ] iCount=AccountQuickFillIncome.QWinChild.ListBox.GetItemCount()
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.TypeKeys(KEY_ESC)
					[ ] 
					[+] if (iCount==1)
						[ ] 
						[+] if (sActualAccountName!=sAccountName)
							[ ] ReportStatus("Verify that user is not able to schedule {sReminderType} reminder for a connected loan account from Bills tab",PASS,"Verify that user is not able to schedule {sReminderType} reminder for a connected loan account from Bills tab.")	
						[+] else
							[ ] ReportStatus("Verify that user is not able to schedule {sReminderType} reminder for a connected loan account from Bills tab",FAIL, "User is able to schedule {sReminderType} reminder for a connected loan account from Bills tab as: {sAccountName} is available in account list on {sReminderType} reminder.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that user is not able to schedule {sReminderType} reminder for a connected loan account from Bills tab",FAIL,"Multiple accounts are available in account list on {sReminderType} reminder. Actual number of account {iCount}, Expected is one")
					[ ] 
					[+] if(DlgAddEditReminder.Exists(SHORT_SLEEP))
						[ ] DlgAddEditReminder.SetActive()
						[ ] DlgAddEditReminder.CancelButton.Click()
						[ ] WaitForState(DlgAddEditReminder , false ,2)
						[ ] sleep(2)
					[ ] 
				[+] else
					[ ] ReportStatus("Verify {sReminderType} Reminder dialog second step",FAIL,"Add {sReminderType} Reminder dialog didn't move second step.")	
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify {sReminderType} Reminder dialog",FAIL,"Add {sReminderType} Reminder dialog is not available")	
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
[+] //##########  Test 9. Verify that user is not able to schedule transfer reminder for a connected loan account from Bills tab.. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_VerifyThatUserIsNotAbleToScheduleTransferReminderForAConnectedLoanAccountFromBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify that user is not able to schedule transfer reminder for a connected loan account from Bills tab.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is not able to schedule transfer reminder for a connected loan account from Bills tab.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 13 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test09_VerifyThatUserIsNotAbleToScheduleTransferReminderForAConnectedLoanAccountFromBillsTab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sActualAccountName
		[ ] ////Read sLoanAccountWorksheet
		[ ] INTEGER iExpectedAccountCount
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] 
		[ ] // Read data from sRegAccountWorksheet excel sheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sRegAccountWorksheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read data from SuperregisterTransacion excel sheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sReminderWorksheet)
		[ ] lsReminderData=lsExcelData[3]
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
	[ ] // iResult=PASS
	[-] if(iResult==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
		[-] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[-] if (LowScreenResolution.Exists(75))
				[ ] LowScreenResolution.Dontshowthisagain.Check()
				[ ] LowScreenResolution.OK.Click()
				[ ] Sleep(3)
				[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window was closed")
			[-] else
				[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window did not appear")
			[ ] 
			[ ] sReminderType=lsReminderData[1]
			[ ] sPayeeName=lsReminderData[2]
			[ ] iResult=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[+] if (iResult == PASS)
				[+] if(DlgAddEditReminder.Exists(SHORT_SLEEP))
					[ ] DlgAddEditReminder.SetActive()
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.TypeKeys(KEY_TAB)
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.TypeKeys(KEY_BACKSPACE)
					[ ] sleep(1)
					[ ] sActualAccountName=DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.GetText()
					[ ] iCount=AccountQuickFillIncome.QWinChild.ListBox.GetItemCount()
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.TypeKeys(KEY_ESC)
					[ ] 
					[+] if (iCount==1)
						[ ] 
						[+] if (sActualAccountName!=sAccountName)
							[ ] ReportStatus("Verify that user is not able to schedule {sReminderType} reminder for a connected loan account from Bills tab",PASS,"Verify that user is not able to schedule {sReminderType} reminder for a connected loan account from Bills tab.")	
						[+] else
							[ ] ReportStatus("Verify that user is not able to schedule {sReminderType} reminder for a connected loan account from Bills tab",FAIL, "User is able to schedule {sReminderType} reminder for a connected loan account from Bills tab as: {sAccountName} is available in account list on {sReminderType} reminder.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that user is not able to schedule {sReminderType} reminder for a connected loan account from Bills tab",FAIL,"Multiple accounts are available in account list on {sReminderType} reminder. Actual number of account {iCount}, Expected is one")
					[ ] 
					[+] if(DlgAddEditReminder.Exists(SHORT_SLEEP))
						[ ] DlgAddEditReminder.SetActive()
						[ ] DlgAddEditReminder.CancelButton.Click()
						[ ] WaitForState(DlgAddEditReminder , false ,2)
						[ ] sleep(2)
					[ ] 
				[+] else
					[ ] ReportStatus("Verify {sReminderType} Reminder dialog second step",FAIL,"Add {sReminderType} Reminder dialog didn't move second step.")	
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify {sReminderType} Reminder dialog",FAIL,"Add {sReminderType} Reminder dialog is not available")	
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
[+] //##########Test 10 -  Verify that user should not be able to edit a single instance of a loan reminder on Bills tab. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_VerifyThatUserShouldNotBeAbleToEditASingleInstanceOfALoanReminderOnBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that user should not be able to edit a single instance of a loan reminder on Bills tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is not be able to edit a single instance of a loan reminder on Bills tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 15 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test10_VerifyThatUserShouldNotBeAbleToEditASingleInstanceOfALoanReminderOnBillsTab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] 
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-10,sDateFormat)
		[ ] 
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
		[-] if(iResult==PASS)
			[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
			[-] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[-] if (iResult==PASS)
					[-] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.NextButton.Click()
						[-] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[ ] ReportStatus("Verify Detail Loan Reminder window is displayed. ", PASS , "Detail Loan Reminder window is displayed upon selecting first option from Loan .R.1:Loan Reminder.") 
							[ ] sleep(10)
							[-] if (!DlgLoanReminder.Exists(20))
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
								[-] if (iResult == PASS)
									[ ] QuickenWindow.SetActive()
									[ ] MDIClient.Bills.ViewAsPopupList.Select("Stack")
									[ ] MDIClient.Bills.DueWithinNextPopupList.Select("30 Days")
									[ ] MDIClient.Bills.Edit.Click()
									[+] if(LoanPaymentReminder.Exists(5))
										[ ] sCaption= LoanPaymentReminder.GetCaption()
										[ ] LoanPaymentReminder.CancelButton.Click()
										[ ] WaitForState(LoanPaymentReminder , false ,5)
										[+] if (sCaption==sExpectedCaption)
											[ ] ReportStatus("Verify that user should not be able to edit a single instance of a loan reminder on Bills tab. ", PASS , "User is not be able to edit a single instance of a loan reminder on Bills tab as dialog: {sCaption} appeared.") 
										[+] else
											[ ] ReportStatus("Verify that user should not be able to edit a single instance of a loan reminder on Bills tab. ", FAIL , "User is able to edit a single instance of a loan reminder on Bills tab as expected dialog: {sExpectedCaption} didn't appear, actual dialog appeared is {sCaption}.") 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify that user should not be able to edit a single instance of a loan reminder on Bills tab. ", FAIL , "Detail Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.")
										[ ] 
									[ ] //handle the fail condition
									[+] if(DlgAddEditReminder.Exists(5))
										[ ] DlgAddEditReminder.SetActive()
										[ ] DlgAddEditReminder.CancelButton.Click()
										[ ] WaitForState(DlgAddEditReminder , false ,5)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Bills tab. ", FAIL , " Bills tab didn't display.") 
							[+] else
								[ ] ReportStatus("Verify Detail Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Detail Loan Reminder window is displayed. ", FAIL , "Detail Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########Test 11A -   Verify that a user should be able to edit the Simple Reminder on Bills tab #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_VerifyThatUserShouldBeAbleToEditALoanReminderOnBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that a user should be able to edit the Simple Reminder on Bills tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to edit and skip the Simple Reminder on Bills tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 16 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test11A_VerifyThatUserShouldBeAbleToEditALoanReminderOnBillsTab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
		[-] if(iResult==PASS)
			[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
			[-] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[-] if (iResult==PASS)
					[ ] 
					[-] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.NextButton.Click()
						[-] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[-] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
								[ ] //Edit DueNextOn TextField on Loan reminder
								[+] if (iResult == PASS)
									[ ] QuickenWindow.SetActive()
									[ ] MDIClient.Bills.ViewAsPopupList.Select("Stack")
									[ ] MDIClient.Bills.DueWithinNextPopupList.Select("30 Days")
									[ ] MDIClient.Bills.Edit.Click()
									[+] if(LoanPaymentReminder.Exists(5))
										[ ] LoanPaymentReminder.SetActive()
										[ ] LoanPaymentReminder.DueNextOnTextField.SetText(sExpectedDueNextOn)
										[ ] LoanPaymentReminder.DoneButton.Click()
										[ ] WaitForState(LoanPaymentReminder , false ,5)
										[ ] MDIClient.Bills.Edit.Click()
										[ ] //Verify edited value of DueNextOn Textfield
										[+] if(LoanPaymentReminder.Exists(5))
											[ ] LoanPaymentReminder.SetActive()
											[ ] sActualDueNextOn=LoanPaymentReminder.DueNextOnTextField.GetText()
											[+] if (sActualDueNextOn==sExpectedDueNextOn)
												[ ] ReportStatus(" Verify that a user should be able to Edit the Simple Reminder on Bills tab . ", PASS , "DueNextOn date has been updated on Edit Loan Payment Reminder dialog as :{sActualDueNextOn}.")
											[+] else
												[ ] ReportStatus(" Verify that a user should be able to Edit the Simple Reminder on Bills tab . ", FAIL , "DueNextOn date couldn't update on Edit Loan Payment Reminder dialog as actual value is: {sActualDueNextOn} while expected is: {sExpectedDueNextOn}.")
											[ ] LoanPaymentReminder.SetActive()
											[ ] LoanPaymentReminder.CancelButton.Click()
											[ ] 
										[+] else
											[ ] ReportStatus("Verify that Edit Loan Payment Reminder dialog. ", FAIL , "Edit Loan Payment Reminder dialog didn't appear.")
										[ ] 
									[+] else
										[ ] ReportStatus("Verify that a user should be able to Edit the Simple Reminder on Bills tab . ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.")
										[ ] 
									[ ] //handle the fail condition
									[+] if(DlgAddEditReminder.Exists(5))
										[ ] DlgAddEditReminder.SetActive()
										[ ] DlgAddEditReminder.CancelButton.Click()
										[ ] WaitForState(DlgAddEditReminder , false ,5)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Bills tab. ", FAIL , " Bills tab didn't display.") 
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########Test 11B -   Verify that a user should be able to enter the Simple Reminder on Bills tab #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11B_VerifyThatUserShouldBeAbleToEnterALoanReminderOnBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that a user should be able to enter the Simple Reminder on Bills tab 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to enter the Simple Reminder on Bills tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 16 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test11B_VerifyThatUserShouldBeAbleToEnterALoanReminderOnBillsTab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
		[-] if(iResult==PASS)
			[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
			[-] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[-] if (iResult==PASS)
					[ ] 
					[-] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.NextButton.Click()
						[-] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[-] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
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
										[ ] iResult=FindTransactionsInRegister(sCategoryLoanPayment)
										[+] if (iResult == PASS)
											[ ] ReportStatus(" Verify that a user should be able to Enter the Simple Reminder on Bills tab . ", PASS , "Loan reminder entered from checking register to Loan Account: {sAccountName} .")
										[+] else
											[ ] ReportStatus(" Verify that a user should be able to Enter the Simple Reminder on Bills tab . ", FAIL , "Loan reminder entered, couldn't be found in checking register.")
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
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########Test 11C -   Verify that a user should be able to Delete the Simple Reminder on Bills tab #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11C_VerifyThatUserShouldBeAbleToDeleteALoanReminderOnBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that a user should be able to Delete the Simple Reminder on Bills tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to Delete the Simple Reminder on Bills tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 16 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test11C_VerifyThatUserShouldBeAbleToDeleteALoanReminderOnBillsTab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
		[-] if(iResult==PASS)
			[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
			[-] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[-] if (iResult==PASS)
					[ ] 
					[-] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.NextButton.Click()
						[-] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[-] if (!DlgLoanReminder.Exists(20))
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
											[ ] ReportStatus(" Verify that a user should be able to delete the Simple Reminder on Bills tab. ", PASS , "Delete Confirmation dialog appeared.")
											[ ] AlertMessage.SetActive()
											[ ] AlertMessage.OK.Click()
											[ ] WaitForState(AlertMessage , false ,5)
											[ ] WaitForState(LoanPaymentReminder , false ,5)
											[ ] 
											[ ] //Verify that reminder has been deleted
											[ ] QuickenWindow.SetActive()
											[ ] 
											[+] if (MDIClient.Bills.ViewAsPopupList.Exists(2))
												[ ] ReportStatus(" Verify that a user should be able to delete the Simple Reminder on Bills tab. ", FAIL , "The Loan payment reminder for account: {sAccountName} couldn't be deleted from Simple Reminder on Bills tab, reminder is still available.")
												[ ] 
											[+] else
												[ ] ReportStatus(" Verify that a user should be able to delete the Simple Reminder on Bills tab. ", PASS , "The Loan payment reminder for account: {sAccountName} has been deleted from Simple Reminder on Bills tab.")
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus(" Verify that a user should be able to delete the Simple Reminder on Bills tab. ", FAIL , "Delete Confirmation dialog didn't appear.")
										[ ] 
										[ ] WaitForState(LoanPaymentReminder , false ,5)
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify that a user should be able to Edit the Simple Reminder on Bills tab . ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.")
										[ ] 
									[ ] //handle the fail condition
									[+] if(DlgAddEditReminder.Exists(5))
										[ ] DlgAddEditReminder.SetActive()
										[ ] DlgAddEditReminder.CancelButton.Click()
										[ ] WaitForState(DlgAddEditReminder , false ,5)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Bills tab. ", FAIL , " Bills tab didn't display.") 
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########Test 11D -   Verify that a user should be able to Skip a Simple Reminder on Bills tab #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11D_VerifyThatUserShouldBeAbleToSkipALoanReminderOnBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that a user should be able to Skip a Simple Reminder on Bills tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to Skip a Simple Reminder on Bills tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 17 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test11D_VerifyThatUserShouldBeAbleToSkipALoanReminderOnBillsTab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
		[-] if(iResult==PASS)
			[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
			[-] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[-] if (iResult==PASS)
					[ ] 
					[-] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.NextButton.Click()
						[-] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[-] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
								[ ] //Skip the Loan reminder from bills tab
								[+] if (iResult == PASS)
									[ ] QuickenWindow.SetActive()
									[ ] MDIClient.Bills.ViewAsPopupList.Select("Stack")
									[ ] MDIClient.Bills.DueWithinNextPopupList.Select("30 Days")
									[ ] MDIClient.Bills.Skip.Click()
									[ ] 
									[+] if (SkipThisReminder.Exists(5))
										[ ] SkipThisReminder.SetActive()
										[ ] SkipThisReminder.SkipConfirmButton.Click()
										[ ] WaitForState(SkipThisReminder , false ,5)
										[ ] sleep(8)
										[+] if (MDIClient.Bills.Skip.Exists(5))
											[ ] ReportStatus(" Verify that a user should be able to Skip the Simple Reminder on Bills tab. ", FAIL , "The Loan payment reminder for account: {sAccountName} couldn't be Skipped from Simple Reminder on Bills tab, reminder is still available.")
											[ ] 
										[+] else
											[ ] ReportStatus(" Verify that a user should be able to Skip the Simple Reminder on Bills tab. ", PASS , "The Loan payment reminder for account: {sAccountName} has been Skipped from Simple Reminder on Bills tab.")
									[+] else
										[ ] ReportStatus("Verify Skip this reminder dialog." , FAIL , "Skip this reminder dialog didn't appear.")
									[ ] 
									[ ] //handle the fail condition
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Bills tab. ", FAIL , " Bills tab didn't display.") 
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########Test 12A -   Verify that a user should be able to edit the Detailed Reminder on Bills tab #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12A_VerifyThatUserShouldBeAbleToEditADetailedLoanReminderOnBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that a user should be able to edit the Detailed Reminder on Bills tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to edit and skip the Detailed Reminder on Bills tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 17 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test12A_VerifyThatUserShouldBeAbleToEditADetailedLoanReminderOnBillsTab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
		[-] if(iResult==PASS)
			[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
			[-] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[-] if (iResult==PASS)
					[ ] 
					[-] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(2)
						[ ] DlgLoanReminder.NextButton.Click()
						[-] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[-] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
								[ ] //Edit DueNextOn TextField on Loan reminder
								[+] if (iResult == PASS)
									[ ] QuickenWindow.SetActive()
									[ ] MDIClient.Bills.ViewAsPopupList.Select("Stack")
									[ ] MDIClient.Bills.DueWithinNextPopupList.Select("30 Days")
									[ ] MDIClient.Bills.Edit.Click()
									[+] if(LoanPaymentReminder.Exists(5))
										[ ] LoanPaymentReminder.SetActive()
										[ ] LoanPaymentReminder.DueNextOnTextField.SetText(sExpectedDueNextOn)
										[ ] LoanPaymentReminder.DoneButton.Click()
										[ ] WaitForState(LoanPaymentReminder , false ,5)
										[ ] MDIClient.Bills.Edit.Click()
										[ ] //Verify edited value of DueNextOn Textfield
										[+] if(LoanPaymentReminder.Exists(5))
											[ ] LoanPaymentReminder.SetActive()
											[ ] sActualDueNextOn=LoanPaymentReminder.DueNextOnTextField.GetText()
											[+] if (sActualDueNextOn==sExpectedDueNextOn)
												[ ] ReportStatus(" Verify that a user should be able to Edit the Detailed Reminder on Bills tab . ", PASS , "DueNextOn date has been updated on Edit Loan Payment Reminder dialog as :{sActualDueNextOn}.")
											[+] else
												[ ] ReportStatus(" Verify that a user should be able to Edit the Detailed Reminder on Bills tab . ", FAIL , "DueNextOn date couldn't update on Edit Loan Payment Reminder dialog as actual value is: {sActualDueNextOn} while expected is: {sExpectedDueNextOn}.")
											[ ] LoanPaymentReminder.SetActive()
											[ ] LoanPaymentReminder.CancelButton.Click()
											[ ] 
										[+] else
											[ ] ReportStatus("Verify that Edit Loan Payment Reminder dialog. ", FAIL , "Edit Loan Payment Reminder dialog didn't appear.")
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
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########Test 12B -   Verify that a user should be able to enter the Detailed Reminder on Bills tab #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12B_VerifyThatUserShouldBeAbleToEnterADetailedLoanReminderOnBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that a user should be able to enter the Detailed Reminder on Bills tab 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to enter the Detailed Reminder on Bills tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 16 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test12B_VerifyThatUserShouldBeAbleToEnterADetailedLoanReminderOnBillsTab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
		[-] if(iResult==PASS)
			[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
			[-] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[-] if (iResult==PASS)
					[ ] 
					[-] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(2)
						[ ] DlgLoanReminder.NextButton.Click()
						[-] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[-] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
								[ ] //Edit DueNextOn TextField on Loan reminder
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
											[ ] ReportStatus(" Verify that a user should be able to Enter the Detailed Reminder on Bills tab . ", PASS , "Loan reminder entered from checking register to Loan Account: {sAccountName} .")
										[+] else
											[ ] ReportStatus(" Verify that a user should be able to Enter the Detailed Reminder on Bills tab . ", FAIL , "Loan reminder entered, couldn't be found in checking register.")
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
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########Test 12C -   Verify that a user should be able to Delete the Detailed Reminder on Bills tab #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12C_VerifyThatUserShouldBeAbleToDeleteADetailedLoanReminderOnBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that a user should be able to Delete the Detailed Reminder on Bills tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to Delete the Detailed Reminder on Bills tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 16 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test12C_VerifyThatUserShouldBeAbleToDeleteADetailedLoanReminderOnBillsTab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
		[-] if(iResult==PASS)
			[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
			[-] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[-] if (iResult==PASS)
					[ ] 
					[-] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(2)
						[ ] DlgLoanReminder.NextButton.Click()
						[-] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[-] if (!DlgLoanReminder.Exists(20))
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
												[ ] ReportStatus(" Verify that a user should be able to delete the Detailed Reminder on Bills tab. ", PASS , "The Loan payment reminder for account: {sAccountName} has been deleted from Detailed Reminder on Bills tab.")
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
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########Test 12D -   Verify that a user should be able to Skip a Detailed Reminder on Bills tab #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12D_VerifyThatUserShouldBeAbleToSkipADetailedLoanReminderOnBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that a user should be able to Skip a Detailed Reminder on Bills tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to Skip a Detailed Reminder on Bills tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Jan 17 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test12D_VerifyThatUserShouldBeAbleToSkipADetailedLoanReminderOnBillsTab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
		[-] if(iResult==PASS)
			[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
			[-] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[-] if (iResult==PASS)
					[ ] 
					[-] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(2)
						[ ] DlgLoanReminder.NextButton.Click()
						[-] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[-] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
								[ ] //Skip the Loan reminder from bills tab
								[+] if (iResult == PASS)
									[ ] QuickenWindow.SetActive()
									[ ] MDIClient.Bills.ViewAsPopupList.Select("Stack")
									[ ] MDIClient.Bills.DueWithinNextPopupList.Select("30 Days")
									[ ] MDIClient.Bills.Skip.Click()
									[ ] 
									[+] if (SkipThisReminder.Exists(2))
										[ ] SkipThisReminder.SetActive()
										[ ] SkipThisReminder.SkipConfirmButton.Click()
										[ ] WaitForState(SkipThisReminder , false ,5)
										[ ] sleep(8)
										[+] if (MDIClient.Bills.Skip.Exists(5))
											[ ] ReportStatus(" Verify that a user should be able to Skip the Detailed Reminder on Bills tab. ", FAIL , "The Loan payment reminder for account: {sAccountName} couldn't be Skipped from Detailed Reminder on Bills tab, reminder is still available.")
											[ ] 
										[+] else
											[ ] ReportStatus(" Verify that a user should be able to Skip the Detailed Reminder on Bills tab. ", PASS , "The Loan payment reminder for account: {sAccountName} has been Skipped from Detailed Reminder on Bills tab.")
									[+] else
										[ ] ReportStatus("Verify Skip this reminder dialog." , FAIL , "Skip this reminder dialog didn't appear.")
									[ ] 
									[ ] //handle the fail condition
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Bills tab. ", FAIL , " Bills tab didn't display.") 
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########13A. Verify that a user should be able to edit Loan Reminder from "Projected Balances" Window #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_VerifyThatUserShouldBeAbleToEditALoanReminderOnBillsTab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that a user should be able to edit Loan Reminder from "Projected Balances" Window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to edit Loan Reminder from "Projected Balances" Window
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 04, 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test13A_VerifyThatUserShouldBeAbleToEditALoanReminderFromProjectedBalances() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
				[+] if (LowScreenResolution.Exists(75))
					[ ] LowScreenResolution.Dontshowthisagain.Check()
					[ ] LowScreenResolution.OK.Click()
					[ ] Sleep(3)
					[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window was closed")
				[+] else
					[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window did not appear")
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[+] if (iResult==PASS)
					[ ] 
					[-] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.NextButton.Click()
						[-] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[-] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL,sTAB_PROJECTED_BALANCES)
								[ ] 
								[+] if (iResult == PASS)
									[ ] QuickenWindow.SetActive()
									[ ] MDIClient.Bills.TimeRangePopupList.Select("Next 30 Days")
									[ ] MDIClient.Bills.ListBox.Click(1, 17 ,10)
									[ ] MDIClient.Bills.ListBox.TypeKeys(Replicate(KEY_DN,3))
									[ ] MDIClient.Bills.ListBox.TypeKeys(KEY_RT)
									[ ] MDIClient.Bills.ListBox.TypeKeys(KEY_ENTER)
									[ ] 
									[+] if(LoanPaymentReminder.Exists(5))
										[ ] LoanPaymentReminder.SetActive()
										[ ] LoanPaymentReminder.DueNextOnTextField.SetText(sExpectedDueNextOn)
										[ ] LoanPaymentReminder.DoneButton.Click()
										[ ] WaitForState(LoanPaymentReminder , false ,5)
										[ ] 
										[ ] //Verify bill edited correctly
										[ ] MDIClient.Bills.ListBox.Click(1, 17 ,10)
										[ ] MDIClient.Bills.ListBox.TypeKeys(Replicate(KEY_DN,3))
										[ ] MDIClient.Bills.ListBox.TypeKeys(KEY_RT)
										[ ] MDIClient.Bills.ListBox.TypeKeys(KEY_ENTER)
										[ ] 
										[ ] //Verify edited value of DueNextOn Textfield
										[+] if(LoanPaymentReminder.Exists(5))
											[ ] LoanPaymentReminder.SetActive()
											[ ] sActualDueNextOn=LoanPaymentReminder.DueNextOnTextField.GetText()
											[+] if (sActualDueNextOn==sExpectedDueNextOn)
												[ ] ReportStatus(" Verify that a user should be able to Edit the Simple Reminder on Projected Balances tab . ", PASS , "DueNextOn date has been updated on Edit Loan Payment Reminder dialog as :{sActualDueNextOn} from Projected Balances tab.")
											[+] else
												[ ] ReportStatus(" Verify that a user should be able to Edit the Simple Reminder on Projected Balances tab . ", FAIL , "DueNextOn date couldn't update on Edit Loan Payment Reminder dialog as actual value is: {sActualDueNextOn} while expected is: {sExpectedDueNextOn} Projected Balances.")
											[ ] LoanPaymentReminder.SetActive()
											[ ] LoanPaymentReminder.CancelButton.Click()
											[ ] 
										[+] else
											[ ] ReportStatus("Verify that Edit Loan Payment Reminder dialog. ", FAIL , "Edit Loan Payment Reminder dialog didn't appear.")
										[ ] 
									[+] else
										[ ] ReportStatus("Verify that a user should be able to Edit the Simple Reminder on Bills tab . ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.")
										[ ] 
									[ ] //handle the fail condition
									[+] if(DlgAddEditReminder.Exists(5))
										[ ] DlgAddEditReminder.SetActive()
										[ ] DlgAddEditReminder.CancelButton.Click()
										[ ] WaitForState(DlgAddEditReminder , false ,5)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Bills tab. ", FAIL , " Bills tab didn't display.") 
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########13B. Verify that a user should be able to enter Loan Reminder from "Projected Balances" Window #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13B_VerifyThatUserShouldBeAbleToEnterALoanReminderFromProjectedBalances
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that a user should be able to enter Loan Reminder from "Projected Balances" Window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to enter Loan Reminder from "Projected Balances" Window
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 04, 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test13B_VerifyThatUserShouldBeAbleToEnterALoanReminderFromProjectedBalances() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
		[-] if(iResult==PASS)
			[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
			[-] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[-] if (iResult==PASS)
					[ ] 
					[-] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.NextButton.Click()
						[-] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[-] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL,sTAB_PROJECTED_BALANCES)
								[ ] 
								[+] if (iResult == PASS)
									[ ] QuickenWindow.SetActive()
									[ ] MDIClient.Bills.TimeRangePopupList.Select("Next 30 Days")
									[ ] MDIClient.Bills.ListBox.Click(1, 17 ,10)
									[ ] MDIClient.Bills.ListBox.TypeKeys(KEY_DN)
									[ ] MDIClient.Bills.ListBox.TypeKeys(KEY_ENTER)
									[ ] 
									[+] if(EnterExpenseIncomeTxn.Exists(5))
										[ ] EnterExpenseIncomeTxn.SetActive()
										[ ] EnterExpenseIncomeTxn.EnterTransactionButton.Click()
										[ ] WaitForState(LoanPaymentReminder , false ,5)
										[ ] iResult=FindTransactionsInRegister(sCategoryLoanPayment)
										[+] if (iResult == PASS)
											[ ] ReportStatus(" Verify that a user should be able to Enter the Simple Reminder on Projected Balances tab . ", PASS , "Loan reminder entered from checking register to Loan Account: {sAccountName} from Projected Balances tab")
										[+] else
											[ ] ReportStatus(" Verify that a user should be able to  Enter the Simple Reminder on Projected Balances tab . ", FAIL , "Loan reminder entered, couldn't be found in checking register from Projected Balances tab.")
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
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########13C. Verify that a user should be able to Delete Loan Reminder from "Projected Balances" Window #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13C_VerifyThatUserShouldBeAbleToDeleteALoanReminderFromProjectedBalances
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that a user should be able to delete Loan Reminder from "Projected Balances" Window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to delete Loan Reminder from "Projected Balances" Window
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 04, 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test13C_VerifyThatUserShouldBeAbleToDeleteALoanReminderFromProjectedBalances() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
		[-] if(iResult==PASS)
			[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
			[-] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[-] if (iResult==PASS)
					[ ] 
					[-] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.NextButton.Click()
						[-] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[-] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL,sTAB_PROJECTED_BALANCES)
								[ ] 
								[+] if (iResult == PASS)
									[ ] QuickenWindow.SetActive()
									[ ] MDIClient.Bills.TimeRangePopupList.Select("Next 30 Days")
									[ ] MDIClient.Bills.ListBox.Click(1, 17 ,10)
									[ ] MDIClient.Bills.ListBox.TypeKeys(Replicate(KEY_DN,3))
									[ ] MDIClient.Bills.ListBox.TypeKeys(KEY_RT)
									[ ] MDIClient.Bills.ListBox.TypeKeys(KEY_DN)
									[ ] MDIClient.Bills.ListBox.TypeKeys(KEY_ENTER)
									[+] if (AlertMessage.Exists(5))
										[ ] ReportStatus(" Verify that a user should be able to delete the Simple Loan Reminder from Projected Balances  tab. ", PASS , "Delete Confirmation dialog appeared.")
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.OK.Click()
										[ ] WaitForState(AlertMessage , false ,5)
										[ ] WaitForState(LoanPaymentReminder , false ,5)
										[ ] 
										[ ] //Verify that reminder has been deleted
										[ ] QuickenWindow.SetActive()
										[ ] sHandle = Str(MDIClient.Bills.ListBox.GetHandle())
										[ ] iListCount =MDIClient.Bills.ListBox.GetItemCount() +1
										[+] for(iCount=0; iCount<=iListCount ; ++iCount)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
											[ ] 
											[ ] // Verify reminder has been deleted
											[ ] bMatch = MatchStr("*{sAccountName}*",sActual)
											[+] if(bMatch)
												[ ] break
										[ ] 
										[+] if (bMatch)
											[ ] ReportStatus(" Verify that a user should be able to delete the Simple Loan Reminder from Projected Balances  tab. ", FAIL , "The Loan payment reminder for account: {sAccountName} couldn't be deleted  from Projected Balances tab, reminder is still available.")
											[ ] 
										[+] else
											[ ] ReportStatus(" Verify that a user should be able to delete the Simple Loan Reminder from Projected Balances  tab. ", PASS , "The Loan payment reminder for account: {sAccountName} has been deleted  from Projected Balances  tab.")
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus(" Verify that a user should be able to delete the Simple Loan Reminder from Projected Balances  tab. ", FAIL , "Delete Confirmation dialog didn't appear.")
									[ ] 
									[+] WaitForState(LoanPaymentReminder , false ,5)
										[ ] 
										[ ] 
										[ ] 
									[ ] //handle the fail condition
									[+] if(DlgAddEditReminder.Exists(5))
										[ ] DlgAddEditReminder.SetActive()
										[ ] DlgAddEditReminder.CancelButton.Click()
										[ ] WaitForState(DlgAddEditReminder , false ,5)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Bills tab. ", FAIL , " Bills tab didn't display.") 
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########13D. Verify that a user should be able to Skip Loan Reminder from "Projected Balances" Window #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13D_VerifyThatUserShouldBeAbleToSkipALoanReminderFromProjectedBalances
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that a user should be able to skip Loan Reminder from "Projected Balances" Window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to skip Loan Reminder from "Projected Balances" Window
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 04, 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test13D_VerifyThatUserShouldBeAbleToSkipALoanReminderFromProjectedBalances() appstate none
	[ ] 
	[ ] 
	[ ] 
	[-] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
		[-] if(iResult==PASS)
			[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
			[-] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[-] if (iResult==PASS)
					[ ] 
					[-] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(2)
						[ ] DlgLoanReminder.NextButton.Click()
						[-] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[-] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL,sTAB_PROJECTED_BALANCES)
								[ ] 
								[+] if (iResult == PASS)
									[ ] QuickenWindow.SetActive()
									[ ] MDIClient.Bills.TimeRangePopupList.Select("Next 30 Days")
									[ ] MDIClient.Bills.ListBox.Click(1, 17 ,10)
									[ ] MDIClient.Bills.ListBox.TypeKeys(replicate (KEY_DN, 2))
									[ ] MDIClient.Bills.ListBox.TypeKeys(KEY_ENTER)
									[ ] 
									[ ] //Verify that reminder has been skipped
									[ ] QuickenWindow.SetActive()
									[ ] sHandle = Str(MDIClient.Bills.ListBox.GetHandle())
									[ ] iListCount =MDIClient.Bills.ListBox.GetItemCount() +1
									[+] for(iCount=0; iCount<=iListCount ; ++iCount)
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
										[ ] 
										[ ] // Verify reminder has been deleted
										[ ] bMatch = MatchStr("*{sAccountName}*",sActual)
										[+] if(bMatch)
											[ ] break
									[ ] 
									[+] if (bMatch)
										[ ] ReportStatus(" Verify that a user should be able to skip the Simple Loan Reminder from Projected Balances tab. ", FAIL , "The Loan payment reminder for account: {sAccountName} couldn't be skipped  from Projected Balances tab, reminder is still available.")
										[ ] 
									[+] else
										[ ] ReportStatus(" Verify that a user should be able to skip the Simple Loan Reminder from Projected Balances  tab. ", PASS , "The Loan payment reminder for account: {sAccountName} has been skipped  from Projected Balances  tab.")
									[ ] 
									[ ] 
									[ ] 
									[+] WaitForState(LoanPaymentReminder , false ,5)
										[ ] 
										[ ] 
										[ ] 
									[ ] //handle the fail condition
									[+] if(DlgAddEditReminder.Exists(5))
										[ ] DlgAddEditReminder.SetActive()
										[ ] DlgAddEditReminder.CancelButton.Click()
										[ ] WaitForState(DlgAddEditReminder , false ,5)
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Bills tab. ", FAIL , " Bills tab didn't display.") 
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########13E. Verify that a user should be able to edit Loan Reminder from Home page reminder snapshot #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13E_VerifyThatUserShouldBeAbleToEditALoanReminderFromHomePageReminderSnapshot
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that a user should be able to edit Loan Reminder from  Home page reminder snapshot 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to edit Loan Reminder from  Home page reminder snapshot 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 05, 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test13E_VerifyThatUserShouldBeAbleToEditALoanReminderFromHomePageReminderSnapshot() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[+] if (iResult==PASS)
					[ ] 
					[+] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.NextButton.Click()
						[+] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[+] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to HOME tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_HOME)
								[ ] QuickenWindow.SetActive()
								[ ] 
								[ ] MDIClient.Home.TextClick("Options",2)
								[ ] // MDIClient.Home.SMBOptionsButton.Click()
								[ ] MDIClient.Home.TypeKeys(KEY_DN)
								[ ] MDIClient.Home.TypeKeys(KEY_RT)
								[ ] MDIClient.Home.TypeKeys(REPLICATE(KEY_DN,2))
								[ ] MDIClient.Home.TypeKeys(KEY_ENTER)
								[ ] NavigateQuickenTab(sTAB_HOME)
								[ ] 
								[ ] sHandle= Str(MDIClient.Home.ListBox1.GetHandle())
								[ ] iListCount = MDIClient.Home.ListBox1.GetItemCount() +1
								[+] for(iCount= 1; iCount <=iListCount;  iCount++)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{sAccountName}*", sActual)
									[+] if (bMatch)
										[ ] break
								[+] if (bMatch)
									[ ] ReportStatus("Verify Loan reminder on Home page reminder snapshot ", PASS, "Loan reminder {sActual} on Home page reminder snapshot appeared.")
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] MDIClient.Home.ListBox1.Click(1, 448 ,12)
									[ ] MDIClient.Home.ListBox1.TypeKeys(Replicate(KEY_DN,3))
									[ ] MDIClient.Home.ListBox1.TypeKeys(KEY_RT)
									[ ] MDIClient.Home.ListBox1.TypeKeys(KEY_ENTER)
									[ ] 
									[+] if(LoanPaymentReminder.Exists(5))
										[ ] LoanPaymentReminder.SetActive()
										[ ] LoanPaymentReminder.DueNextOnTextField.SetText(sExpectedDueNextOn)
										[ ] LoanPaymentReminder.DoneButton.Click()
										[ ] WaitForState(LoanPaymentReminder , false ,5)
										[ ] sleep(3)
										[ ] //Verify bill edited correctly
										[ ] //Verify edited value of DueNextOn Textfield
										[ ] QuickenWindow.SetActive()
										[ ] sHandle= Str(MDIClient.Home.ListBox1.GetHandle())
										[ ] iListCount = MDIClient.Home.ListBox1.GetItemCount() +1
										[+] for(iCount= 1; iCount <=iListCount;  iCount++)
											[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
											[ ] bMatch = MatchStr("*{sAccountName}*{sExpectedDueNextOn}*", sActual)
											[+] if (bMatch)
												[ ] break
										[ ] 
										[+] if (bMatch) 
											[ ] ReportStatus(" Verify that a user should be able to Edit the Simple Reminder on Home page reminder snapshot . ", PASS , "DueNextOn date has been updated on Edit Loan Payment Reminder dialog as :{sActual} from Home page reminder snapshot.")
										[+] else
											[ ] ReportStatus(" Verify that a user should be able to Edit the Simple Reminder on Home page reminder snapshot . ", FAIL , "DueNextOn date couldn't update on Edit Loan Payment Reminder dialog as actual value is: {sActual} while expected is: {sExpectedDueNextOn} from Home page reminder snapshot.")
										[ ] 
										[ ] 
										[ ] //Verify edited value of DueNextOn Textfield
									[+] else
										[ ] ReportStatus("Verify that a user should be able to Edit the Home page reminder snapshot . ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.")
										[ ] 
									[ ] //handle the fail condition
									[+] if(DlgAddEditReminder.Exists(5))
										[ ] DlgAddEditReminder.SetActive()
										[ ] DlgAddEditReminder.CancelButton.Click()
										[ ] WaitForState(DlgAddEditReminder , false ,5)
										[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Loan reminder on Home page reminder snapshot ", FAIL, "Loan reminder {sAccountName} on Home page reminder snapshot didn't appear.")
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########13F. Verify that a user should be able to enter Loan Reminder from Home page reminder snapshot #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13F_VerifyThatUserShouldBeAbleToEnterALoanReminderFromHomePageReminderSnapshot
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that a user should be able to enter Loan Reminder from  Home page reminder snapshot 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to enter Loan Reminder from  Home page reminder snapshot 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 07, 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test13F_VerifyThatUserShouldBeAbleToEnterALoanReminderFromHomePageReminderSnapshot() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[+] if (iResult==PASS)
					[ ] 
					[+] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.NextButton.Click()
						[+] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[+] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_HOME)
								[ ] QuickenWindow.SetActive()
								[ ] MDIClient.Home.TextClick("Options",2)
								[ ] MDIClient.Home.TypeKeys(KEY_DN)
								[ ] MDIClient.Home.TypeKeys(KEY_RT)
								[ ] MDIClient.Home.TypeKeys(REPLICATE(KEY_DN,2))
								[ ] MDIClient.Home.TypeKeys(KEY_ENTER)
								[ ] NavigateQuickenTab(sTAB_HOME)
								[ ] 
								[ ] sHandle= Str(MDIClient.Home.ListBox1.GetHandle())
								[ ] iListCount = MDIClient.Home.ListBox1.GetItemCount() +1
								[+] for(iCount= 1; iCount <=iListCount;  iCount++)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{sAccountName}*", sActual)
									[+] if (bMatch)
										[ ] break
								[+] if (bMatch)
									[ ] ReportStatus("Verify Loan reminder on Home page reminder snapshot ", PASS, "Loan reminder {sActual} on Home page reminder snapshot appeared.")
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] MDIClient.Home.ListBox1.Click(1, 448 ,12)
									[ ] MDIClient.Home.ListBox1.TypeKeys(KEY_DN)
									[ ] MDIClient.Home.ListBox1.TypeKeys(KEY_ENTER)
									[ ] 
									[+] if(EnterExpenseIncomeTxn.Exists(5))
										[ ] EnterExpenseIncomeTxn.SetActive()
										[ ] EnterExpenseIncomeTxn.EnterTransactionButton.Click()
										[ ] WaitForState(LoanPaymentReminder , false ,5)
										[ ] iResult=FindTransactionsInRegister(sCategoryLoanPayment)
										[+] if (iResult == PASS)
											[ ] ReportStatus(" Verify that a user should be able to Enter the Simple Reminder on Home page reminder snapshot . ", PASS , "Loan reminder entered from checking register to Loan Account: {sAccountName} from Home page reminder snapshot")
										[+] else
											[ ] ReportStatus(" Verify that a user should be able to  Enter the Simple Reminder on Home page reminder snapshot. ", FAIL , "Loan reminder entered, couldn't be found in checking register from Home page reminder snapshot.")
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
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Loan reminder on Home page reminder snapshot ", FAIL, "Loan reminder {sAccountName} on Home page reminder snapshot didn't appear.")
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########13G. Verify that a user should be able to delete Loan Reminder from Home page reminder snapshot #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13G_VerifyThatUserShouldBeAbleToDeleteALoanReminderFromHomePageReminderSnapshot
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that a user should be able to delete Loan Reminder from  Home page reminder snapshot 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to delete Loan Reminder from  Home page reminder snapshot 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 07, 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test13G_VerifyThatUserShouldBeAbleToDeleteALoanReminderFromHomePageReminderSnapshot() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[+] if (iResult==PASS)
					[ ] 
					[+] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.NextButton.Click()
						[+] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[+] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_HOME)
								[ ] QuickenWindow.SetActive()
								[ ] MDIClient.Home.TextClick("Options",2)
								[ ] MDIClient.Home.TypeKeys(KEY_DN)
								[ ] MDIClient.Home.TypeKeys(KEY_RT)
								[ ] MDIClient.Home.TypeKeys(REPLICATE(KEY_DN,2))
								[ ] MDIClient.Home.TypeKeys(KEY_ENTER)
								[ ] NavigateQuickenTab(sTAB_HOME)
								[ ] 
								[ ] sHandle= Str(MDIClient.Home.ListBox1.GetHandle())
								[ ] iListCount = MDIClient.Home.ListBox1.GetItemCount() +1
								[+] for(iCount= 1; iCount <=iListCount;  iCount++)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{sAccountName}*", sActual)
									[+] if (bMatch)
										[ ] break
								[+] if (bMatch)
									[ ] ReportStatus("Verify Loan reminder on Home page reminder snapshot ", PASS, "Loan reminder {sActual} on Home page reminder snapshot appeared.")
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] MDIClient.Home.ListBox1.Click(1, 448 ,12)
									[ ] MDIClient.Home.ListBox1.TypeKeys(Replicate(KEY_DN,3))
									[ ] MDIClient.Home.ListBox1.TypeKeys(KEY_RT)
									[ ] MDIClient.Home.ListBox1.TypeKeys(KEY_DN)
									[ ] MDIClient.Home.ListBox1.TypeKeys(KEY_ENTER)
									[+] if (AlertMessage.Exists(5))
										[ ] ReportStatus(" Verify that a user should be able to delete the Simple Loan Reminder from Home page reminder snapshot. ", PASS , "Delete Confirmation dialog appeared.")
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.OK.Click()
										[ ] WaitForState(AlertMessage , false ,5)
										[ ] WaitForState(LoanPaymentReminder , false ,5)
										[ ] 
										[ ] //Verify that reminder has been deleted
										[ ] QuickenWindow.SetActive()
										[ ] // sHandle= Str(MDIClient.Home.ListBox1.GetHandle())
										[ ] // iListCount = MDIClient.Home.ListBox1.GetItemCount() +1
										[+] // for(iCount=0; iCount<=iListCount ; ++iCount)
											[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
											[ ] // 
											[ ] // // Verify reminder has been deleted
											[ ] // bMatch = MatchStr("*{sAccountName}*",sActual)
											[+] // if(bMatch)
												[ ] // break
										[ ] 
										[+] if (MDIClient.Home.ListBox1.Exists(2))
											[ ] ReportStatus(" Verify that a user should be able to delete the Simple Loan Reminder from Home page reminder snapshot. ", FAIL , "The Loan payment reminder for account: {sAccountName} couldn't be deleted  from Home page reminder snapshot, reminder is still available.")
											[ ] 
										[+] else
											[ ] ReportStatus(" Verify that a user should be able to delete the Simple Loan Reminder from Home page reminder snapshot. ", PASS , "The Loan payment reminder for account: {sAccountName} has been deleted  from Home page reminder snapshot.")
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus(" Verify that a user should be able to delete the Simple Loan Reminder from Home page reminder snapshot. ", FAIL , "Delete Confirmation dialog didn't appear.")
										[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Loan reminder on Home page reminder snapshot ", FAIL, "Loan reminder {sAccountName} on Home page reminder snapshot didn't appear.")
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########13H. Verify that a user should be able to Skip Loan Reminder from Home page reminder snapshot #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13H_VerifyThatUserShouldBeAbleToSkipALoanReminderFromHomePageReminderSnapshot
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that a user should be able to skip Loan Reminder from  Home page reminder snapshot 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to skip Loan Reminder from  Home page reminder snapshot 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 07, 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test13H_VerifyThatUserShouldBeAbleToSkipALoanReminderFromHomePageReminderSnapshot() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sActualDueNextOn ,sExpectedDueNextOn
		[ ] sExpectedCaption ="Edit Loan Payment Reminder"
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sLoanDetails)
		[ ] lsAccount = lsExcelData[2]
		[ ] sAccountName =lsAccount[1]
		[ ] 
		[ ] ////Read sOnlineLoanDetailsStep1Worksheet
		[ ] 
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sOnlineLoanDetailsStep1Worksheet)
		[ ] lsLoanData1 = lsExcelData[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sExpectedDueNextOn =ModifyDate(-4,sDateFormat)
		[ ] 
		[ ] nMonthlypayment = VAL (lsLoanData1[10])
		[ ] sExpectedPayment = trim(str(nMonthlypayment, 2,2))
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
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[+] if (iResult==PASS)
					[ ] 
					[+] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.NextButton.Click()
						[+] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[+] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_HOME)
								[ ] QuickenWindow.SetActive()
								[ ] MDIClient.Home.TextClick("Options",2)
								[ ] MDIClient.Home.TypeKeys(KEY_DN)
								[ ] MDIClient.Home.TypeKeys(KEY_RT)
								[ ] MDIClient.Home.TypeKeys(REPLICATE(KEY_DN,2))
								[ ] MDIClient.Home.TypeKeys(KEY_ENTER)
								[ ] NavigateQuickenTab(sTAB_HOME)
								[ ] 
								[ ] sHandle= Str(MDIClient.Home.ListBox1.GetHandle())
								[ ] iListCount = MDIClient.Home.ListBox1.GetItemCount() +1
								[+] for(iCount= 0; iCount <=iListCount;  iCount++)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{sAccountName}*", sActual)
									[+] if (bMatch)
										[ ] break
								[+] if (bMatch)
									[ ] ReportStatus("Verify Loan reminder on Home page reminder snapshot ", PASS, "Loan reminder {sActual} on Home page reminder snapshot appeared.")
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] MDIClient.Home.ListBox1.Click(1, 448 ,12)
									[ ] MDIClient.Home.ListBox1.TypeKeys(Replicate(KEY_DN,2))
									[ ] MDIClient.Home.ListBox1.TypeKeys(KEY_ENTER)
									[ ] sleep(2)
									[ ] //Verify that reminder has been deleted
									[ ] QuickenWindow.SetActive()
									[ ] sHandle= Str(MDIClient.Home.ListBox1.GetHandle())
									[ ] iListCount = MDIClient.Home.ListBox1.GetItemCount() +1
									[+] for(iCount= 1; iCount <=iListCount;  iCount++)
										[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
										[ ] bMatch = MatchStr("*{sAccountName}*{sExpectedDueNextOn}*", sActual)
										[+] if (bMatch)
											[ ] break
									[ ] 
									[ ] 
									[+] if (bMatch)
										[ ] ReportStatus(" Verify that a user should be able to skip the Simple Loan Reminder from Home page reminder snapshot. ", FAIL , "The Loan payment reminder for account: {sAccountName} couldn't be skipped from Home page reminder snapshot, reminder is still available.")
										[ ] 
									[+] else
										[ ] ReportStatus(" Verify that a user should be able to skip the Simple Loan Reminder from Home page reminder snapshot. ", PASS , "The Loan payment reminder for account: {sAccountName} has been skipped from Home page reminder snapshot.")
										[ ] 
										[ ] 
										[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Loan reminder on Home page reminder snapshot ", FAIL, "Loan reminder {sAccountName} on Home page reminder snapshot didn't appear.")
							[+] else
								[ ] ReportStatus("Verify Simple Loan Reminder window is disappeared. ", FAIL , "Loan Reminder window didn't disappear.")
						[+] else
							[ ] ReportStatus("Verify Simple Loan Reminder window is displayed. ", FAIL , "Simple Loan Reminder window didn't display upon selecting first option from Loan .R.1:Loan Reminder.") 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Online Loan Details D2 window.", FAIL , "Navigation to Online Loan Details D2 window. for Online loan Account: {sAccountName} is unsuccessful") 
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
[+] //##########  Verify that if user deletes a loan payment reminder then Quicken creates a memorized payee for that loan account#####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_VerifyThatForDeletedLoanReminderMemorizedPayeeGetscreatedForManualLoanAccount
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that if user deletes a loan payment reminder then Quicken creates a memorized payee for that loan account.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to skip Loan Reminder from  Home page reminder snapshot 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 10, 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test14_VerifyThatForDeletedLoanReminderMemorizedPayeeGetscreatedForManualLoanAccount() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] ////Read sLoanAccountWorksheet
		[ ] STRING sAction
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet, sManualLoanAccountWorksheet)
		[ ] lsAccount = lsExcelData[1]
		[ ] sAccountName =lsAccount[1]
		[ ] sDate=ModifyDate(-5,sDateFormat)
		[ ] sAction = "Add"
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
	[ ] //Open Data file
	[ ] iResult=OpenDataFile(sOnlineLoansDataFileName)
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] QuickenWindow.SetActive()
		[+] if (LowScreenResolution.Exists(75))
			[ ] LowScreenResolution.Dontshowthisagain.Check()
			[ ] LowScreenResolution.OK.Click()
			[ ] Sleep(3)
			[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window was closed")
		[+] else
			[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window did not appear")
		[ ] 
		[ ] iResult =AddEditManualLoanAccount(sAction, sAccountName ,sDate ,lsAccount[3] ,lsAccount[4] ,lsAccount[5] ,lsAccount[6])
		[ ] //Add Loan account
		[+] if(iResult==PASS)
			[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account: {sAccountName} is added")
			[ ] 
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
						[ ] ReportStatus("Verify that if user deletes a loan payment reminder then Quicken creates a memorized payee for that loan account. ", PASS , "Delete Confirmation dialog appeared.")
						[ ] AlertMessage.SetActive()
						[ ] AlertMessage.OK.Click()
						[ ] WaitForState(AlertMessage , false ,5)
						[ ] WaitForState(LoanPaymentReminder , false ,5)
						[ ] 
						[ ] //Verify that reminder has been deleted
						[ ] QuickenWindow.SetActive()
						[ ] 
						[+] if (MDIClient.Bills.ViewAsPopupList.Exists(2))
							[ ] ReportStatus(" Verify that a user should be able to delete the Reminder on Bills tab. ", FAIL , "The Loan payment reminder for account: {sAccountName} couldn't be deleted from Detailed Reminder on Bills tab, reminder is still available.")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus(" Verify that a user should be able to delete the Reminder on Bills tab. ", PASS , "The Loan payment reminder for account: {sAccountName} has been deleted from Reminder on Bills tab.")
							[ ] ///Verify that LoanReminder Payee added to memorized payee
							[ ] QuickenWindow.SetActive()
							[ ] QuickenWindow.Tools.Click()
							[ ] QuickenWindow.Tools.MemorizedPayeeList.Select()
							[+] if (MemorizedPayeeList.Exists(5))
								[ ] MemorizedPayeeList.SetActive()
								[ ] 
								[ ] sHandle =Str(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetHandle())
								[ ] iListCount= MemorizedPayeeList.MemorizedPayeeList.ListBox.GetItemCount() +1
								[+] for(iCount= 0; iCount <=iListCount;  iCount++)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
									[ ] bMatch = MatchStr("*{sAccountName}*", sActual)
									[+] if (bMatch)
										[ ] break
								[+] if (bMatch)
									[ ] ReportStatus("Verify that if user deletes a loan payment reminder then Quicken creates a memorized payee for that loan account ", PASS, "Memorized Payee: {sActual} got created after deleting the loan reminder.")
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify that if user deletes a loan payment reminder then Quicken creates a memorized payee for that loan account ", FAIL, "Memorized Payee for: {sAccountName} didn't get created after deleting the loan reminder, the actual payee in the memorized payee list is {sActual}.")
								[+] if (MemorizedPayeeList.Exists(5))
									[ ] MemorizedPayeeList.SetActive()
									[ ] MemorizedPayeeList.Done.Click()
									[ ] WaitForState(MemorizedPayeeList , false ,3)
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus(" Verify that a user should be able to delete the Reminder on Bills tab. ", PASS , "Memorized payee list dialog didn't appear..")
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that if user deletes a loan payment reminder then Quicken creates a memorized payee for that loan account. ", FAIL , "Delete Confirmation dialog didn't appear.")
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
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Add Manual loan account",FAIL,"Manual loan account not added")
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
