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
[ ] 
[ ] 
[ ] 
[ ] 
[ ] //==========================================================================================
[ ] //==================================  Manual Loan Accounts  =====================================
[ ] //==========================================================================================
[ ] 
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
[+] testcase Test01_Launching_Points_For_Add_Manual_Loan_Account_FI_Screen() appstate QuickenBaseState
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
[+] testcase Test02_Add_Manual_Loan_Account_With_Different_Payment_Schedules() appstate none
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
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] 
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
						[ ] sPaymentTextCaption=MDIClientLoans.LoanWindow.PaymentText.GetProperty("caption")
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
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //###################  Verify the functionality of the 'Account Type' dropdown box.  #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_Manual_Loan_Account_Verify_Account_Type_Dropbox
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of the 'Account Type' dropdown box
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to select different Account types from account dropbox
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  6th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test03_Manual_Loan_Account_Verify_Account_Type_Dropbox() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sLoanTextCaption
		[ ] LIST OF STRING lsActualLoanType,lsExpectedLoanType
		[ ] 
		[ ] 
		[ ] lsExpectedLoanType={"Mortgage","Loan","Auto Loan","Consumer Loan","Commercial Loan","Student Loan","Military Loan","Business Loan","Construction Loan","Home Equity Loan"}
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
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[+] // Verify the loan type drop down box contents on Add Manual loan account window
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
			[ ] sleep(4)
			[ ] AddAccount.Loan.Click()
			[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
				[ ] 
				[ ] AddAnyAccount.SetActive()
				[ ] 
				[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
				[ ] 
				[+] if(LoanDetails.Exists(SHORT_SLEEP))
					[ ] 
					[ ] lsActualLoanType=LoanDetails.LoanTypePopupList.GetContents()
					[+] for(i=1;i<=ListCount(lsActualLoanType);i++)
						[ ] 
						[+] if(lsActualLoanType[i]==lsExpectedLoanType[i])
							[ ] ReportStatus("Verify Loan Type dropdown box",PASS,"Actual value {lsActualLoanType[i]} matches with Expected value {lsExpectedLoanType[i]}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Loan Type dropdown box",FAIL,"Actual value {lsActualLoanType[i]} does not match with Expected value {lsExpectedLoanType[i]}")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
					[ ] 
					[ ] LoanDetails.Close()
					[+] if(AlertMessage.Exists(5))
						[ ] AlertMessage.Yes.Click()
					[ ] WaitForState(LoanDetails,FALSE,5)
					[ ] 
		[ ] 
		[+] // Verify that user can select all types of loan account
			[+] for(i=1;i<=ListCount(lsExpectedLoanType);i++)
				[ ] 
				[ ] 
				[ ] 
				[ ] //Add Loan account
				[ ] iValidate=AddEditManualLoanAccount(sAddAction,lsAddLoanAccount[1],lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsExpectedLoanType[i],lsAddLoanAccount[7])
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
						[ ] //Loan Type Text on Dashboard
						[ ] sLoanTextCaption=MDIClientLoans.LoanWindow.LoanTypeText.GetCaption()
						[+] if(sLoanTextCaption==lsExpectedLoanType[i])
							[ ] ReportStatus("Verify Payment text",PASS,"Loan Type text on Dashboard displays correct value {sLoanTextCaption} ")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Payment text",FAIL,"Payment text on Dashboard displays wrong value {sLoanTextCaption} ")
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
					[ ] // Fail Script if account is not deleted
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
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################  Verify the functionality of the Add Loan Account Data Fields Validation ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_Functionality_Add_Loan_Account_Data_Fields_Validation
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the validation messages of the Add Loan Account Data Fields
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If functionality of  'Opening Date',original balance amount,Interest Rate , 'Original Length',Compounding Period' field and 'Payment Schedule ,'Current Balance'  fields are correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  6th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test04_Functionality_Add_Loan_Account_Data_Fields_Validation() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sMaxValue,sMaxValue2,sMinValue,sActual
		[ ] STRING sDateMessage,sMinMessage,sMaxMessage,sPercentageMessage,sValidationMessage,sMaxMessage2,sCurrentInterestValidationMessage
		[ ] 
		[ ] //LIST OF STRING 
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
		[ ] //Max Values
		[ ] sMaxValue="99999999999999"
		[ ] sMaxValue2="102"
		[ ] //Min Values
		[ ] sMinValue="0"
		[ ] 
		[ ] //Expected Messages
		[ ] sDateMessage="Enter a valid date."
		[ ] sMinMessage="This field must be greater than zero."
		[ ] sMaxMessage="Maximum amount is 99,999,999.99."
		[ ] sMaxMessage2="Please enter a number from 1 to 40."
		[ ] sPercentageMessage="Enter a Percentage."
		[ ] sValidationMessage="Please enter a valid amount"
		[ ] sCurrentInterestValidationMessage="Interest rate must be between 0.0% and 50.0%."
		[ ] 
		[ ] 
		[ ] 
		[ ] // Copy autoapi dll for qwauto utility
		[ ] Setup_AutoApi()
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] 
		[ ] ExpandAccountBar()
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[ ] 
		[ ] 
		[ ] AddAccount.Loan.Click()
		[+] if(QuickenUpdateStatus.Exists(5))
			[ ] WaitForState(AddAnyAccount,TRUE,700)
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
				[ ] 
				[ ] 
				[ ] 
				[+] //Date validation message
					[+] //Verify Valid date message
						[ ] LoanDetails.OpeningDateTextField.SetText(sMinValue)
						[ ] LoanDetails.NextButton.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] sActual=AlertMessage.MessageText.GetCaption()
							[+] if(sActual==sDateMessage)
								[ ] ReportStatus("Verify date message",PASS,"Correct message {sActual} displayed for date")
								[ ] AlertMessage.OK.Click()
								[ ] LoanDetails.OpeningDateTextField.SetText(lsAddLoanAccount[2])
								[ ] 
							[+] else
								[ ] ReportStatus("Verify date message",FAIL,"Wrong message {sActual} displayed for date")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Alert message",FAIL,"Alert Message not displayed for wrong date")
							[ ] 
				[ ] 
				[ ] 
				[+] //Original Balance validation messages
					[ ] 
					[+] //Verify min balance message for Original balance
						[ ] LoanDetails.OriginalBalanceTextField.SetText(sMinValue)
						[ ] LoanDetails.NextButton.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] sActual=AlertMessage.MessageText.GetCaption()
							[+] if(sActual==sMinMessage)
								[ ] ReportStatus("Verify Original balance message",PASS,"Correct message {sActual} displayed for Min original balance")
								[ ] AlertMessage.OK.Click()
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Original balance message",FAIL,"Wrong message {sActual} displayed for Min original balance")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Alert message",FAIL,"Alert Message not displayed for wrong original balance")
							[ ] 
					[ ] 
					[ ] 
					[+] //Verify max balance message for Original balance
						[ ] LoanDetails.OriginalBalanceTextField.SetText(sMaxValue)
						[ ] LoanDetails.NextButton.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] sActual=AlertMessage.MessageText.GetCaption()
							[+] if(sActual==sMaxMessage)
								[ ] ReportStatus("Verify Original balance message",PASS,"Correct message {sActual} displayed for Max original balance")
								[ ] AlertMessage.OK.Click()
								[ ] LoanDetails.OriginalBalanceTextField.SetText(lsAddLoanAccount[3])
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Original balance message",FAIL,"Wrong message {sActual} displayed for Max original balance")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Alert message",FAIL,"Alert Message not displayed for wrong original balance")
							[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[+] //Current Interest validation messages
					[ ] 
					[ ] 
					[+] //Verify max balance message for Current Interest
						[ ] LoanDetails.CurrentInterestRateTextField.SetText(sMaxValue2)
						[ ] LoanDetails.TypeKeys(KEY_TAB)
						[ ] LoanDetails.NextButton.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] sActual=AlertMessage.MessageText.GetCaption()
							[+] if(sActual==sCurrentInterestValidationMessage)
								[ ] ReportStatus("Verify current interest message",PASS,"Correct message {sActual} displayed for max current interest")
								[ ] AlertMessage.OK.Click()
								[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsAddLoanAccount[4])
								[ ] 
								[ ] LoanDetails.TypeKeys(KEY_TAB)
								[ ] 
							[+] else
								[ ] ReportStatus("Verify current interest message",FAIL,"Wrong message {sActual} displayed for max current interest")
								[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Alert message",FAIL,"Alert Message not displayed for current interest")
							[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[+] //Original Length validation messages
					[ ] 
					[ ] 
					[+] //Verify min balance message for Original Length
						[ ] LoanDetails.OriginalLengthTextField.SetText(sMinValue)
						[ ] //LoanDetails.OriginalBalanceTextField.SetText(lsAddLoanAccount[3])
						[ ] LoanDetails.NextButton.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] sActual=AlertMessage.MessageText.GetCaption()
							[+] if(sActual==sMinMessage)
								[ ] ReportStatus("Verify Original balance message",PASS,"Correct message {sActual} displayed for Min original Length")
								[ ] AlertMessage.OK.Click()
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Original balance message",FAIL,"Wrong message {sActual} displayed for Min original Length")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Alert message",FAIL,"Alert Message not displayed for wrong original Length")
							[ ] 
					[ ] 
					[ ] 
					[+] //Verify max balance message for Original Length
						[ ] LoanDetails.OriginalLengthTextField.SetText(sMaxValue2)
						[ ] //LoanDetails.OriginalBalanceTextField.SetText(lsAddLoanAccount[3])
						[ ] //LoanDetails.TypeKeys(KEY_TAB)
						[ ] LoanDetails.NextButton.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] sActual=AlertMessage.MessageText.GetCaption()
							[+] if(sActual==sMaxMessage2)
								[ ] ReportStatus("Verify Original balance message",PASS,"Correct message {sActual} displayed for Max original Length")
								[ ] AlertMessage.OK.Click()
								[ ] LoanDetails.OriginalLengthTextField.SetText(lsAddLoanAccount[5])
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Original balance message",FAIL,"Wrong message {sActual} displayed for Max original Length")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Alert message",FAIL,"Alert Message not displayed for wrong original Length")
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
				[+] //Current Balance validation messages
					[ ] 
					[+] //Verify min balance message for Current balance
						[ ] LoanDetails.CurrentBalanceTextField.SetText(sMinValue)
						[ ] LoanDetails.NextButton.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] sActual=AlertMessage.MessageText.GetCaption()
							[+] if(sActual==sMinMessage)
								[ ] ReportStatus("Verify Current balance message",PASS,"Correct message {sActual} displayed for Min Current balance")
								[ ] AlertMessage.OK.Click()
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Current balance message",FAIL,"Wrong message {sActual} displayed for Min Current balance")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Alert message",FAIL,"Alert Message not displayed for wrong original balance")
							[ ] 
					[ ] 
					[ ] 
					[+] //Verify max balance message for Current balance
						[ ] LoanDetails.CurrentBalanceTextField.SetText(sMaxValue)
						[ ] LoanDetails.NextButton.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] sActual=AlertMessage.MessageText.GetCaption()
							[+] if(sActual==sMaxMessage)
								[ ] ReportStatus("Verify Current balance message",PASS,"Correct message {sActual} displayed for Max Current balance")
								[ ] AlertMessage.OK.Click()
								[ ] LoanDetails.CurrentBalanceTextField.SetText(lsAddLoanAccount[3])
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Current balance message",FAIL,"Wrong message {sActual} displayed for Max Current balance")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Alert message",FAIL,"Alert Message not displayed for wrong Current balance")
							[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] //Monthly Payment validation messages
					[ ] 
					[ ] 
					[ ] 
					[+] //Verify min balance message for Monthly Payment
						[ ] LoanDetails.FrequencyPaymentTextField.SetText(sMinValue)
						[ ] LoanDetails.NextButton.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] sActual=AlertMessage.MessageText.GetCaption()
							[+] if(sActual==sMinMessage)
								[ ] ReportStatus("Verify Current balance message",PASS,"Correct message {sActual} displayed for Min Current balance")
								[ ] AlertMessage.OK.Click()
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Current balance message",FAIL,"Wrong message {sActual} displayed for Min Current balance")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Alert message",FAIL,"Alert Message not displayed for wrong original balance")
							[ ] 
					[ ] 
					[ ] 
					[+] //Verify max balance message for Monthly Payment
						[ ] LoanDetails.FrequencyPaymentTextField.SetText(sMaxValue)
						[ ] LoanDetails.NextButton.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] sActual=AlertMessage.MessageText.GetCaption()
							[+] if(sActual==sMaxMessage)
								[ ] ReportStatus("Verify Current balance message",PASS,"Correct message {sActual} displayed for Max Current balance")
								[ ] AlertMessage.OK.Click()
								[ ] //LoanDetails.MonthlyPaymentTextField.SetText(lsAddLoanAccount[3])
								[ ] //LoanDetails.Rec
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Current balance message",FAIL,"Wrong message {sActual} displayed for Max Current balance")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Alert message",FAIL,"Alert Message not displayed for wrong Current balance")
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
				[ ] LoanDetails.Close()
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // 
				[ ] // 
			[+] else
				[ ] ReportStatus("Verify if Loan Details Exists",FAIL,"Loan Details window did not open for manual account link")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify if Add An Account window Exists",FAIL,"Add An Account window did not open")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //###########  Verify functionality of the 'Recalculate' button present next to 'Current Balance' field ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_Recalculate_Button_Next_To_Current_Balance_Field
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality of the 'Recalculate' button present next to 'Current Balance' field 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If recalculate button next to Current Balance textfield works correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test05_Recalculate_Button_Next_To_Current_Balance_Field_Functionailty() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] STRING sNewCurrentBalanceValue
		[ ] 
		[ ] sNewCurrentBalanceValue="311.5"
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
		[ ] // Copy autoapi dll for qwauto utility
		[ ] Setup_AutoApi()
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] ExpandAccountBar()
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[ ] 
		[ ] 
		[ ] AddAccount.Loan.Click()
		[+] if(QuickenUpdateStatus.Exists(5))
			[ ] WaitForState(AddAnyAccount,TRUE,700)
			[ ] 
		[ ] 
		[ ] 
		[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
			[ ] 
			[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
			[ ] 
			[ ] 
			[ ] 
			[ ] //AddAnyAccount.Next.Click()
			[+] if(LoanDetails.Exists(SHORT_SLEEP))
				[ ] 
				[ ] 
				[+] //Set values for loan textfields
					[ ] // //Set Loan Name
					[ ] // LoanDetails.LoanNameTextField.SetText(lsAddLoanAccount[1])
					[ ] 
					[ ] //Set Opening Date
					[ ] LoanDetails.OpeningDateTextField.SetText(lsAddLoanAccount[2])
					[ ] 
					[ ] //Set Original Balance
					[ ] LoanDetails.OriginalBalanceTextField.SetText(lsAddLoanAccount[3])
					[ ] 
					[ ] //Set Current Interest Rate
					[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsAddLoanAccount[4])
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[ ] 
					[ ] //Set Original length Rate
					[ ] LoanDetails.OriginalLengthTextField.SetText(lsAddLoanAccount[5])
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] //Reset Current Balance window
					[ ] 
					[ ] LoanDetails.CurrentBalanceTextField.SetText(sNewCurrentBalanceValue)
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[+] if(LoanDetails.RecalculateCurrentBalanceButton.Exists(5))
						[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button appears once current balance textfield content is changed")
						[ ] 
						[ ] 
						[ ] //Verify that value should be recalculated once "Recalculate" button is clicked
						[ ] LoanDetails.RecalculateCurrentBalanceButton.Click()
						[ ] sActual=LoanDetails.CurrentBalanceTextField.GetText()
						[ ] 
						[ ] 
						[ ] NUMBER nNum=val(lsAddLoanAccount[3])
						[ ] 
						[+] if(sActual==Str(nNum,NULL,2))
							[ ] ReportStatus("Verify if value is recalculated",PASS,"Value is recalculated when Recalculate button is clicked  Actual : {sActual} ; Expected :{nNum} ")
							[ ] 
							[ ] 
							[+] if(!LoanDetails.RecalculateCurrentBalanceButton.Exists(5))
								[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button gets hidden once current balance is recalculated")
								[ ] 
								[ ] 
								[ ] LoanDetails.Close()
								[+] if(AlertMessage.Exists(5))
									[ ] AlertMessage.Yes.Click()
								[ ] WaitForState(LoanDetails,FALSE,5)
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button is still visible after current balance is recalculated")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if value is recalculated",FAIL,"Value is not recalculated when Recalculate button is clicked : Actual : {sActual} ; Expected :{Str(nNum,NULL,2)} ")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button does not appear if current balance textfield content is changed")
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
				[ ] ReportStatus("Verify loan details window open",FAIL,"Loan details window did not open")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Account window open",FAIL,"Add Account window did not open")
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
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //###########  Verify validation of the 'Recalculate' button present next to 'Current Balance' field #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_Recalculate_Button_Next_To_Current_Balance_Field_Validation
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify validation of the 'Recalculate' button present next to 'Current Balance' field 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If validation of recalculate button next to Current Balance textfield is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test06_Recalculate_Button_Next_To_Current_Balance_Field_Validation() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsModifiedLoanValues
		[ ] STRING sNewCurrentBalanceValue
		[ ] 
		[ ] sNewCurrentBalanceValue="311.50"
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
		[ ] lsModifiedLoanValues={ModifyDate(-30),"430.00","3","2"}
		[ ] 
		[ ] 
		[ ] // Copy autoapi dll for qwauto utility
		[ ] Setup_AutoApi()
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] ExpandAccountBar()
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[ ] 
		[ ] 
		[ ] AddAccount.Loan.Click()
		[+] if(QuickenUpdateStatus.Exists(5))
			[ ] WaitForState(AddAnyAccount,TRUE,700)
			[ ] 
		[ ] 
		[ ] 
		[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
			[ ] 
			[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
			[ ] 
			[ ] 
			[ ] 
			[ ] //AddAnyAccount.Next.Click()
			[+] if(LoanDetails.Exists(SHORT_SLEEP))
				[ ] 
				[ ] 
				[+] //Set values for loan textfields
					[ ] 
					[ ] //Set Opening Date
					[ ] LoanDetails.OpeningDateTextField.SetText(lsAddLoanAccount[2])
					[ ] 
					[ ] //Set Original Balance
					[ ] LoanDetails.OriginalBalanceTextField.SetText(lsAddLoanAccount[3])
					[ ] 
					[ ] //Set Current Interest Rate
					[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsAddLoanAccount[4])
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[ ] 
					[ ] //Set Original length Rate
					[ ] LoanDetails.OriginalLengthTextField.SetText(lsAddLoanAccount[5])
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] //Reset Current Balance window
					[ ] 
					[ ] LoanDetails.CurrentBalanceTextField.SetText(sNewCurrentBalanceValue)
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[+] if(LoanDetails.RecalculateCurrentBalanceButton.Exists(5))
						[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button appears once current balance textfield content is changed")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] ////Edit values of other fields in loan window and check that Quicken does not automatically calculate 
						[ ] 
						[ ] 
						[ ] 
						[+] //For Opening Date
							[ ] LoanDetails.OpeningDateTextField.SetText(lsModifiedLoanValues[1])
							[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
							[ ] 
							[ ] // Verify that Current Balance field is not edited and recalculated button is displayed
							[ ] sActual=LoanDetails.CurrentBalanceTextField.GetText()
							[+] if(sActual==sNewCurrentBalanceValue)
								[ ] ReportStatus("Verify if value is recalculated",PASS,"Value is not recalculated when opening date field is edited")
								[ ] 
								[ ] 
								[+] if(LoanDetails.RecalculateCurrentBalanceButton.Exists(5))
									[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button is still visible if opening date field is edited")
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button is not visible if opening date field is edited")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if value is recalculated",FAIL,"Value is recalculated when opening date field is edited {sActual}")
								[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[+] //For Original Balance
							[ ] LoanDetails.OriginalBalanceTextField.SetText(lsModifiedLoanValues[2])
							[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
							[ ] 
							[ ] // Verify that Current Balance field is not edited and recalculated button is displayed
							[ ] sActual=LoanDetails.CurrentBalanceTextField.GetText()
							[+] if(sActual==sNewCurrentBalanceValue)
								[ ] ReportStatus("Verify if value is recalculated",PASS,"Value is not recalculated when Original Balance field is edited")
								[ ] 
								[ ] 
								[+] if(LoanDetails.RecalculateCurrentBalanceButton.Exists(5))
									[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button is still visible if Original Balance field is edited")
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button is not visible if Original Balance field is edited")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if value is recalculated",FAIL,"Value is recalculated when Original Balance field is edited {sActual}")
								[ ] 
						[ ] 
						[ ] 
						[ ] 
						[+] //For Current Interest Rate
							[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsModifiedLoanValues[3])
							[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
							[ ] 
							[ ] // Verify that Current Balance field is not edited and recalculated button is displayed
							[ ] sActual=LoanDetails.CurrentBalanceTextField.GetText()
							[+] if(sActual==sNewCurrentBalanceValue)
								[ ] ReportStatus("Verify if value is recalculated",PASS,"Value is not recalculated when Current Interest Rate field is edited")
								[ ] 
								[ ] 
								[+] if(LoanDetails.RecalculateCurrentBalanceButton.Exists(5))
									[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button is still visible if Current Interest Rate field is edited")
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button is not visible if Current Interest Rate field is edited")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if value is recalculated",FAIL,"Value is recalculated when Current Interest Rate field is edited {sActual}")
								[ ] 
						[ ] 
						[ ] 
						[ ] 
						[+] //For Original length Rate
							[ ] LoanDetails.OriginalLengthTextField.SetText(lsModifiedLoanValues[4])
							[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
							[ ] 
							[ ] // Verify that Current Balance field is not edited and recalculated button is displayed
							[ ] sActual=LoanDetails.CurrentBalanceTextField.GetText()
							[+] if(sActual==sNewCurrentBalanceValue)
								[ ] ReportStatus("Verify if value is recalculated",PASS,"Value is not recalculated when Original length field is edited")
								[ ] 
								[ ] 
								[+] if(LoanDetails.RecalculateCurrentBalanceButton.Exists(5))
									[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button is still visible if Original length field is edited")
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button is not visible if Original length field is edited")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if value is recalculated",FAIL,"Value is recalculated when Original length field is edited {sActual}")
								[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] // 
						[ ] // //Verify that value should be recalculated once "Recalculate" button is clicked
						[ ] // LoanDetails.RecalculateCurrentBalanceButton.Click()
						[ ] // sActual=LoanDetails.CurrentBalanceTextField.GetText()
						[+] // if(sActual==lsAddLoanAccount[3])
							[ ] // ReportStatus("Verify if value is recalculated",PASS,"Value is recalculated when Recalculate button is clicked {sActual}")
							[ ] // 
							[ ] // 
							[+] // if(!LoanDetails.RecalculateCurrentBalanceButton.Exists(5))
								[ ] // ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button gets hidden once current balance is recalculated")
								[ ] // 
								[ ] // 
								[ ] // LoanDetails.Close()
								[+] // if(AlertMessage.Exists(5))
									[ ] // AlertMessage.Yes.Click()
								[ ] // WaitForState(LoanDetails,FALSE,5)
								[ ] // 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button is still visible after current balance is recalculated")
							[ ] // 
							[ ] // 
							[ ] // 
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify if value is recalculated",FAIL,"Value is not recalculated when Recalculate button is clicked : {sActual}")
							[ ] // 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button does not appear if current balance textfield content is changed")
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
				[ ] LoanDetails.Close()
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify loan details window open",FAIL,"Loan details window did not open")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Account window open",FAIL,"Add Account window did not open")
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
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //###########  Verify functionality of the 'Recalculate' button present next to '<Frequency> Payment' field #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_08_Recalculate_Button_Next_To_Frequency_Payment_Field
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality of the 'Recalculate' button present next to '<Frequency> Payment' field
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If recalculate button next to <Frequency> Payment textfield works correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test07_08_Recalculate_Button_Next_To_Frequency_Payment_Field() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] STRING sNewMonthlyPaymentValue,sExpectedMonthlyPaymentValue
		[ ] 
		[ ] sNewMonthlyPaymentValue="13.5"
		[ ] 
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
		[ ] // Copy autoapi dll for qwauto utility
		[ ] Setup_AutoApi()
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] ExpandAccountBar()
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[ ] 
		[ ] 
		[ ] AddAccount.Loan.Click()
		[+] if(QuickenUpdateStatus.Exists(5))
			[ ] WaitForState(AddAnyAccount,TRUE,700)
			[ ] 
		[ ] 
		[ ] 
		[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
			[ ] 
			[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
			[ ] 
			[ ] 
			[ ] 
			[+] if(LoanDetails.Exists(SHORT_SLEEP))
				[ ] 
				[ ] 
				[+] //Set values for loan textfields
					[ ] 
					[ ] //Set Opening Date
					[ ] LoanDetails.OpeningDateTextField.SetText(lsAddLoanAccount[2])
					[ ] 
					[ ] //Set Original Balance
					[ ] LoanDetails.OriginalBalanceTextField.SetText(lsAddLoanAccount[3])
					[ ] 
					[ ] //Set Current Interest Rate
					[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsAddLoanAccount[4])
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[ ] 
					[ ] //Set Original length Rate
					[ ] LoanDetails.OriginalLengthTextField.SetText(lsAddLoanAccount[5])
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[ ] 
					[ ] sleep(2)
					[ ] sExpectedMonthlyPaymentValue=LoanDetails.FrequencyPaymentTextField.GetText()
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] //Check Monthly Payment amount
					[ ] 
					[ ] LoanDetails.FrequencyPaymentTextField.SetText(sNewMonthlyPaymentValue)
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[+] if(LoanDetails.RecalculatePaymentFrequencyButton.Exists(5))
						[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button appears once Monthly Payment textfield content is changed")
						[ ] 
						[ ] 
						[ ] //Verify that value should be recalculated once "Recalculate" button is clicked
						[ ] LoanDetails.RecalculatePaymentFrequencyButton.Click()
						[ ] sActual=LoanDetails.FrequencyPaymentTextField.GetText()
						[+] if(sActual==sExpectedMonthlyPaymentValue)
							[ ] ReportStatus("Verify if value is recalculated",PASS,"Value is recalculated when Recalculate button is clicked {sActual}")
							[ ] 
							[ ] 
							[+] if(!LoanDetails.RecalculatePaymentFrequencyButton.Exists(5))
								[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button gets hidden once Monthly Payment is recalculated")
								[ ] 
								[ ] 
								[ ] LoanDetails.Close()
								[+] if(AlertMessage.Exists(5))
									[ ] AlertMessage.Yes.Click()
								[ ] WaitForState(LoanDetails,FALSE,5)
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button is still visible after Monthly Payment is recalculated")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if value is recalculated",FAIL,"Value is not recalculated when Recalculate button is clicked : {sActual}")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button does not appear if Monthly Payment textfield content is changed")
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
				[ ] // 
				[ ] // 
				[ ] // 
			[+] else
				[ ] ReportStatus("Verify loan details window open",FAIL,"Loan details window did not open")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Account window open",FAIL,"Add Account window did not open")
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
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //###########  Verify validation of the 'Recalculate' button present next to 'Frequency Payment' field ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_Recalculate_Button_Next_To_Current_Balance_Field_Validation
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify validation of the 'Recalculate' button present next to 'Frequency Payment' field 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If validation of recalculate button next to Frequency Payment textfield is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  12th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test09_Recalculate_Button_Next_To_Frequency_Payment_Field_Validation() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsModifiedLoanValues
		[ ] STRING sNewFrequencyPaymentValue
		[ ] 
		[ ] sNewFrequencyPaymentValue="13.50"
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
		[ ] lsModifiedLoanValues={ModifyDate(-30),"430.00","3","2"}
		[ ] 
		[ ] 
		[ ] // Copy autoapi dll for qwauto utility
		[ ] Setup_AutoApi()
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] ExpandAccountBar()
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[ ] 
		[ ] 
		[ ] AddAccount.Loan.Click()
		[+] if(QuickenUpdateStatus.Exists(5))
			[ ] WaitForState(AddAnyAccount,TRUE,700)
			[ ] 
		[ ] 
		[ ] 
		[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
			[ ] 
			[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
			[ ] 
			[ ] 
			[ ] 
			[ ] //AddAnyAccount.Next.Click()
			[+] if(LoanDetails.Exists(SHORT_SLEEP))
				[ ] 
				[ ] 
				[+] //Set values for loan textfields
					[ ] 
					[ ] //Set Opening Date
					[ ] LoanDetails.OpeningDateTextField.SetText(lsAddLoanAccount[2])
					[ ] 
					[ ] //Set Original Balance
					[ ] LoanDetails.OriginalBalanceTextField.SetText(lsAddLoanAccount[3])
					[ ] 
					[ ] //Set Current Interest Rate
					[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsAddLoanAccount[4])
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[ ] 
					[ ] //Set Original length Rate
					[ ] LoanDetails.OriginalLengthTextField.SetText(lsAddLoanAccount[5])
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] //Reset Current Balance window
					[ ] 
					[ ] LoanDetails.FrequencyPaymentTextField.SetText(sNewFrequencyPaymentValue)
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[+] if(LoanDetails.RecalculatePaymentFrequencyButton.Exists(5))
						[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button appears once current balance textfield content is changed")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] ////Edit values of other fields in loan window and check that Quicken does not automatically calculate 
						[ ] 
						[ ] 
						[ ] 
						[+] //For Opening Date
							[ ] LoanDetails.OpeningDateTextField.SetText(lsModifiedLoanValues[1])
							[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
							[ ] 
							[ ] // Verify that Frequency Paymentfield is not edited and recalculated button is displayed
							[ ] sActual=LoanDetails.FrequencyPaymentTextField.GetText()
							[+] if(sActual==sNewFrequencyPaymentValue)
								[ ] ReportStatus("Verify if value is recalculated",PASS,"Value is not recalculated when opening date field is edited")
								[ ] 
								[ ] 
								[+] if(LoanDetails.RecalculatePaymentFrequencyButton.Exists(5))
									[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button is still visible if opening date field is edited")
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button is not visible if opening date field is edited")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if value is recalculated",FAIL,"Value is recalculated when opening date field is edited {sActual}")
								[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[+] //For Original Balance
							[ ] LoanDetails.OriginalBalanceTextField.SetText(lsModifiedLoanValues[2])
							[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
							[ ] 
							[ ] // Verify that Frequency Payment field is not edited and recalculated button is displayed
							[ ] sActual=LoanDetails.FrequencyPaymentTextField.GetText()
							[+] if(sActual==sNewFrequencyPaymentValue)
								[ ] ReportStatus("Verify if value is recalculated",PASS,"Value is not recalculated when Original Balance field is edited")
								[ ] 
								[ ] 
								[+] if(LoanDetails.RecalculatePaymentFrequencyButton.Exists(5))
									[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button is still visible if Original Balance field is edited")
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button is not visible if Original Balance field is edited")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if value is recalculated",FAIL,"Value is recalculated when Original Balance field is edited {sActual}")
								[ ] 
						[ ] 
						[ ] 
						[ ] 
						[+] //For Current Interest Rate
							[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsModifiedLoanValues[3])
							[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
							[ ] 
							[ ] // Verify that Frequency Payment field is not edited and recalculated button is displayed
							[ ] sActual=LoanDetails.FrequencyPaymentTextField.GetText()
							[+] if(sActual==sNewFrequencyPaymentValue)
								[ ] ReportStatus("Verify if value is recalculated",PASS,"Value is not recalculated when Current Interest Rate field is edited")
								[ ] 
								[ ] 
								[+] if(LoanDetails.RecalculatePaymentFrequencyButton.Exists(5))
									[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button is still visible if Current Interest Rate field is edited")
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button is not visible if Current Interest Rate field is edited")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if value is recalculated",FAIL,"Value is recalculated when Current Interest Rate field is edited {sActual}")
								[ ] 
						[ ] 
						[ ] 
						[ ] 
						[+] //For Original length Rate
							[ ] LoanDetails.OriginalLengthTextField.SetText(lsModifiedLoanValues[4])
							[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
							[ ] 
							[ ] // Verify that Frequency Payment field is not edited and recalculated button is displayed
							[ ] sActual=LoanDetails.FrequencyPaymentTextField.GetText()
							[+] if(sActual==sNewFrequencyPaymentValue)
								[ ] ReportStatus("Verify if value is recalculated",PASS,"Value is not recalculated when Original length field is edited")
								[ ] 
								[ ] 
								[+] if(LoanDetails.RecalculatePaymentFrequencyButton.Exists(5))
									[ ] ReportStatus("Verify if recalculate button exists",PASS,"Recalculate button is still visible if Original length field is edited")
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button is not visible if Original length field is edited")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if value is recalculated",FAIL,"Value is recalculated when Original length field is edited {sActual}")
								[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if recalculate button exists",FAIL,"Recalculate button does not appear if current balance textfield content is changed")
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
				[ ] LoanDetails.Close()
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify loan details window open",FAIL,"Loan details window did not open")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Account window open",FAIL,"Add Account window did not open")
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
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //#######  Verify the functionality of the 'Back' and 'Cancel' button on Loan Details - Add Loan Details' screen #############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_Functionality_Of_Buttons_On_Add_Loan_Details_Screen
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of the 'Back' and 'Cancel' button on Loan Details - Add Loan Details' screen 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If validation of functionality of the 'Back' and 'Cancel' button on Loan Details is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test10_Functionality_Of_Buttons_On_Add_Loan_Details_Screen() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sExpectedCaption="Add Loan Account"
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] ExpandAccountBar()
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[ ] 
		[ ] 
		[ ] AddAccount.Loan.Click()
		[+] if(QuickenUpdateStatus.Exists(5))
			[ ] WaitForState(AddAnyAccount,TRUE,700)
			[ ] 
		[ ] 
		[ ] 
		[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
			[ ] 
			[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
			[ ] 
			[ ] 
			[+] if(LoanDetails.Exists(SHORT_SLEEP))
				[ ] 
				[ ] 
				[+] //Verify Cancel Button
					[ ] LoanDetails.CancelButton.Click()
					[+] if(AlertMessage.Exists(5))
						[ ] ReportStatus("Verify that Alert message is displayed when Back button is clicked",PASS,"Alert message dialogbox displayed")
						[ ] 
						[ ] AlertMessage.SetActive()
						[ ] AlertMessage.No.Click()
						[ ] WaitForState(AlertMessage,FALSE,5)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Alert message is displayed when Back button is clicked",FAIL,"Alert message dialogbox not displayed")
						[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] //Verify Back Button
					[ ] LoanDetails.BackButton.Click()
					[ ] 
					[+] if(AddAnyAccount.Exists(5))
						[+] if(AddAnyAccount.GetCaption()==sExpectedCaption)
							[ ] ReportStatus("Verify that Add Loan Account window is displayed when Back button is clicked",PASS,"Caption {sExpectedCaption} matched succesfully")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that Add Loan Account window is displayed when Back button is clicked",FAIL,"Caption {sExpectedCaption} does not match")
							[ ] 
							[ ] 
						[ ] 
						[ ] AddAnyAccount.SetActive()
						[ ] AddAnyAccount.Close()
						[ ] WaitForState(AddAnyAccount,FALSE,5)
						[ ] 
						[ ] 
						[ ] 
					[+] else
							[ ] ReportStatus("Verify that Add Loan Account window is displayed when Back button is clicked",FAIL,"Incorrect window is displayed")
						[ ] 
						[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify loan details window open",FAIL,"Loan details window did not open")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Account window open",FAIL,"Add Account window did not open")
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
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //###########  Verify the functionality of the 'Help' icon on the Loan Details screen  ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_Functionality_Of_Help_Icon_On_Loan_Details
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of the 'Help' icon on the Loan Details screen 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If help window opens and correct help content is displayed
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test11_Functionality_Of_Help_Icon_On_Loan_Details() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] STRING sLoanText="Set up a loan"
		[ ] 
		[ ] 
		[ ] // Copy autoapi dll for qwauto utility
		[ ] Setup_AutoApi()
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] ExpandAccountBar()
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[ ] 
		[ ] WaitForState(AddAccount,TRUE,15)
		[ ] AddAccount.Loan.Click()
		[+] // if(QuickenUpdateStatus.Exists(5))
			[ ] // WaitForState(AddAnyAccount,TRUE,700)
			[ ] // 
		[ ] 
		[ ] 
		[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
			[ ] sleep(3)
			[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
			[ ] 
			[ ] 
			[ ] 
			[+] if(LoanDetails.Exists(SHORT_SLEEP))
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] if(LoanDetails.HelpButton.Exists(5))
					[ ] ReportStatus("Verify if Help button is displayed on Loan details window",PASS,"Help button is displayed on Loan details window")
					[ ] 
					[ ] //click on help button
					[ ] LoanDetails.HelpButton.Click()
					[+] if(QuickenHelp.Exists(5))
						[ ] ReportStatus("Verify if Help window is displayed",PASS,"Help window is displayed")
						[ ] 
						[ ] //Verify if correct content is displayed
						[+] do
							[ ] QuickenHelp.TextClick(sLoanText)              // will print error "Could not find text" is text is not found 
							[ ] ReportStatus("Verify if Help {sLoanText} is displayed",PASS,"Text {sLoanText} is displayed on Help window.")
						[+] except
							[ ] ReportStatus("Verify if Help {sLoanText} is displayed",FAIL,"Text {sLoanText} didn't  display on Help window.")
						[ ] 
						[ ] QuickenHelp.Close()
						[ ] WaitForState(QuickenHelp,FALSE,5)
						[ ] 
						[ ] LoanDetails.Close()
						[+] if(AlertMessage.Exists(5))
							[ ] AlertMessage.Yes.Click()
						[ ] WaitForState(LoanDetails,FALSE,5)
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Help window is displayed",FAIL,"Help window is not displayed")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Help button is displayed on Loan details window",FAIL,"Help button is not displayed on Loan details window")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify loan details window open",FAIL,"Loan details window did not open")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Account window open",FAIL,"Add Account window did not open")
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
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //###### Verify the functionality of the 'Next Payment Due' field on the Loan.DM.2: Loan Details - Add Payment Details' screen.#####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_Loans_DM2_Next_Payment_Due_Screen_Validation
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of the 'Next Payment Due' field on the Loan.DM.2: Loan Details - Add Payment Details' screen.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If validation of  'Next Payment Due' field on the Loan.DM.2: Loan Details - Add Payment Details' screen is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test12_Loans_DM2_Next_Payment_Due_Screen_Validation() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sFutureDate=ModifyDate(30,sDateFormat)
		[ ] 
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[3]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] //lsAddLoanAccount[7]=NULL
		[ ] //lsAddLoanAccount[8]=ModifyDate(30)
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] //Add Loan account
		[ ] iValidate=AddEditManualLoanAccount(sAddAction,lsAddLoanAccount[1],lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],NULL,NULL,NULL,sFutureDate)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=NavigateQuickenTab(sTAB_BILL)
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
				[+] if (DlgManageReminders.Exists(5))
					[ ] DlgManageReminders.AllBillsDepositsTab.Click()
					[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
					[ ] 
					[ ] 
					[ ] 
					[ ] bResult = MatchStr("*{sFutureDate}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of Reminder ", PASS, "Loan Reminder with date '{sFutureDate}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of Reminder ", FAIL, "Loan Reminder for {sFutureDate} is NOT added, sActual = {sActual}")
					[ ] 
					[ ] DlgManageReminders.Close()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Delete Loan Account
				[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
				[+] if(iValidate==PASS)
					[ ] 
					[ ] 
					[ ] 
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
			[+] else
				[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
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
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //##############################################################################################################
[ ] 
[ ] 
[+] //#######  Verify that 'Principal' amount and  'Interest' amount  on the Loan.DM.2: Loan Details - Add Payment Details' screen are accurate. #####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_Functionality_Of_Buttons_On_Add_Loan_Details_DM2_Screen
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of the 'Back' and 'Cancel' button on Loan Details - Add Loan Details' DM2 screen 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If validation of functionality of the 'Back' and 'Cancel' button on DM2 Loan Details is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test13_Functionality_Of_Principal_And_Interest_Fields_On_Loan_Details_DM2_Screen() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sExpectedPrincipal="$9.43"
		[ ] STRING sExpectedInterest="$2.08"
		[ ] 
		[ ] 
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
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] 
		[ ] ExpandAccountBar()
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[ ] 
		[ ] 
		[ ] AddAccount.Loan.Click()
		[+] if(QuickenUpdateStatus.Exists(5))
			[ ] WaitForState(AddAnyAccount,TRUE,700)
			[ ] 
		[ ] 
		[ ] 
		[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
			[ ] 
			[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
			[ ] 
			[ ] 
			[ ] 
			[ ] //AddAnyAccount.Next.Click()
			[+] if(LoanDetails.Exists(SHORT_SLEEP))
				[ ] 
				[ ] 
				[+] //Set values for loan textfields
					[ ] // //Set Loan Name
					[ ] // LoanDetails.LoanNameTextField.SetText(lsAddLoanAccount[1])
					[ ] 
					[ ] //Set Opening Date
					[ ] LoanDetails.OpeningDateTextField.SetText(lsAddLoanAccount[2])
					[ ] 
					[ ] //Set Original Balance
					[ ] LoanDetails.OriginalBalanceTextField.SetText(lsAddLoanAccount[3])
					[ ] 
					[ ] //Set Current Interest Rate
					[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsAddLoanAccount[4])
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[ ] 
					[ ] //Set Original length Rate
					[ ] LoanDetails.OriginalLengthTextField.SetText(lsAddLoanAccount[5])
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[ ] LoanDetails.TypeKeys(KEY_TAB)  
					[ ] 
					[ ] LoanDetails.NextButton.Click()
					[ ] 
					[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] if(LoanDetails.Exists(SHORT_SLEEP))
				[ ] 
				[ ] 
				[+] //Verify Principal Amount
					[ ] 
					[ ] sActual=LoanDetails.PrincipalAmount.GetCaption()
					[+] if(sActual==sExpectedPrincipal)
						[ ] ReportStatus("Verify Principal Amount",PASS,"Principal amount is displayed correctly {sActual}")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Principal Amount",FAIL,"Principal amount displayed is wrong {sActual}")
						[ ] 
						[ ] 
					[ ] 
				[ ] 
				[ ] 
				[+] //Verify Interest Amount
					[ ] 
					[ ] sActual=NULL
					[ ] sActual=LoanDetails.InterestAmount.GetCaption()
					[+] if(sActual==sExpectedInterest)
						[ ] ReportStatus("Verify Interest Amount",PASS,"Interest amount is displayed correctly {sActual}")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Interest Amount",FAIL,"Interest amount displayed is wrong {sActual}")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] LoanDetails.Close()
				[+] if(AlertMessage.OK.Exists(10))
					[ ] AlertMessage.SetActive()
					[ ] AlertMessage.OK.Click()
				[ ] 
				[+] if(AlertMessage.Exists(10))
					[ ] AlertMessage.SetActive()
					[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(LoanDetails,FALSE,5)
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
				[ ] ReportStatus("Verify loan details window open",FAIL,"Loan details window did not open")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Account window open",FAIL,"Add Account window did not open")
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
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################################
[ ] 
[ ] 
[+] //####### Verify the functionality of the 'Other' field and 'Extra Principal Monthly' on the Loan.DM.2: Loan Details - Add Payment Details' screen  #####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_15_Functionality_Of_Other_And_Extra_Principal_Monthly_Fields_On_Loan_Details_DM2_Screen
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that User should be able to enter amount for the 'Other' field.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If User is able to enter amount for the 'Other' field.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test14_15_Functionality_Of_Other_And_Extra_Principal_Monthly_Fields_On_Loan_Details_DM2_Screen() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanAccountWorksheet)
		[ ] lsAddLoanAccount=lsExcelData[1]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] //Add Loan account
		[ ] iValidate=AddEditManualLoanAccount(sAddAction,lsAddLoanAccount[1],lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],lsAddLoanAccount[7],NULL,NULL,NULL,lsAddLoanAccount[10],lsAddLoanAccount[11])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account is added")
			[ ] 
			[ ] 
			[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify if user can enter values for other and Extra principal monthly fields",PASS,"User can enter values for other and Extra principal monthly fields")
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
			[+] else
				[ ] ReportStatus("Verify if user can enter values for other and Extra principal monthly fields",FAIL,"Error while entering values for other and Extra principal monthly fields")
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
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################################################################
[ ] 
[ ] 
[+] //#################  Verify the functionality of the 'Back' and 'Cancel' button on Loan Details DM 2 - Add Loan Details' screen ###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_Functionality_Of_Buttons_On_Add_Loan_Details_DM2_Screen
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the functionality of the 'Back' and 'Cancel' button on Loan Details - Add Loan Details' DM2 screen 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If validation of functionality of the 'Back' and 'Cancel' button on DM2 Loan Details is correct
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th Dec 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test16_Functionality_Of_Buttons_On_Add_Loan_Details_DM2_Screen() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] //STRING sExpectedCaption="Add Loan Account"
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
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] 
		[ ] ExpandAccountBar()
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
		[ ] 
		[ ] 
		[ ] AddAccount.Loan.Click()
		[+] if(QuickenUpdateStatus.Exists(5))
			[ ] WaitForState(AddAnyAccount,TRUE,700)
			[ ] 
		[ ] 
		[ ] 
		[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
			[ ] 
			[ ] AddAnyAccount.SetActive()
			[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
			[ ] 
			[ ] 
			[ ] 
			[ ] //AddAnyAccount.Next.Click()
			[+] if(LoanDetails.Exists(SHORT_SLEEP))
				[ ] 
				[ ] 
				[+] //Set values for loan textfields
					[ ] // //Set Loan Name
					[ ] // LoanDetails.LoanNameTextField.SetText(lsAddLoanAccount[1])
					[ ] 
					[ ] //Set Opening Date
					[ ] LoanDetails.OpeningDateTextField.SetText(lsAddLoanAccount[2])
					[ ] 
					[ ] //Set Original Balance
					[ ] LoanDetails.OriginalBalanceTextField.SetText(lsAddLoanAccount[3])
					[ ] 
					[ ] //Set Current Interest Rate
					[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsAddLoanAccount[4])
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[ ] 
					[ ] //Set Original length Rate
					[ ] LoanDetails.OriginalLengthTextField.SetText(lsAddLoanAccount[5])
					[ ] LoanDetails.TypeKeys(KEY_TAB)                          //Tab key to refresh values
					[ ] LoanDetails.TypeKeys(KEY_TAB)  
					[ ] 
					[ ] LoanDetails.NextButton.Click()
					[ ] 
					[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] if(LoanDetails.Exists(SHORT_SLEEP))
				[ ] 
				[ ] 
				[+] //Verify Cancel Button
					[ ] LoanDetails.CancelButton.Click()
					[+] if(AlertMessage.Exists(5))
						[ ] ReportStatus("Verify that Alert message is displayed when Back button is clicked",PASS,"Alert message dialogbox displayed")
						[ ] 
						[ ] AlertMessage.SetActive()
						[ ] AlertMessage.No.Click()
						[ ] WaitForState(AlertMessage,FALSE,5)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Alert message is displayed when Back button is clicked",FAIL,"Alert message dialogbox not displayed")
						[ ] 
				[ ] 
				[ ] 
				[ ] 
				[+] //Verify Back Button
					[ ] LoanDetails.BackButton.Click()
					[ ] 
					[+] if(LoanDetails.OpeningDateTextField.Exists(5))
						[ ] ReportStatus("Verify that previous page of  Loan details window is displayed when Back button is clicked",PASS,"Caption Opening Date Text Field matched succesfully")
						[ ] 
						[ ] 
						[+] // if(AddAnyAccount.GetCaption()==sExpectedCaption)
							[ ] // ReportStatus("Verify that Add Loan Account window is displayed when Back button is clicked",PASS,"Caption {sExpectedCaption} matched succesfully")
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify that Add Loan Account window is displayed when Back button is clicked",FAIL,"Caption {sExpectedCaption} does not match")
							[ ] // 
							[ ] // 
						[ ] 
						[ ] LoanDetails.SetActive()
						[ ] LoanDetails.Close()
						[+] if(AlertMessage.OK.Exists(10))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.OK.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.Yes.Click()
						[ ] WaitForState(LoanDetails,FALSE,5)
						[ ] 
						[ ] 
						[ ] 
					[+] else
							[ ] ReportStatus("Verify that Add Loan Account window is displayed when Back button is clicked",FAIL,"Incorrect window is displayed")
						[ ] 
						[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify loan details window open",FAIL,"Loan details window did not open")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Account window open",FAIL,"Add Account window did not open")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] //==========================================================================================
[ ] //=============================Memorized Payee test cases for Loans=================================
[ ] //==========================================================================================
[ ] 
[ ] 
[+] //##### Verify that 'Loan Reminder' option is a default option while setting up a manual loan account on DM2 >> Payment option button ###########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_Loan_Reminder_Default_Option_For_Manual_Loan_Account_Payment_Option_Button
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Loan Reminder' option is a default option while setting up a manual loan account on DM2 >> Payment option button
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Loan Reminder is a Default Option For Manual Loan Account Payment Option Button
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  7th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01_Loan_Reminder_Default_Option_For_Manual_Loan_Account_Payment_Option_Button() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[2]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] //DataFileCreate(sLoansDataFileName)
	[ ] iValidate=DataFileCreate(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Create Data File",PASS,"Data File created successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] //Add Checking account
		[ ] iValidate=AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3])
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] //Add Loan account
			[ ] iValidate=AddEditManualLoanAccount(sAddAction,lsAddLoanAccount[1],lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],lsAddLoanAccount[7])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account is added")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
				[+] if(iValidate==PASS)
					[ ] 
					[ ] 
					[ ] //-----------------------Verification for Loan Reminder--------------------------
					[ ] 
					[ ] //Verification that Loan reminder option is the default selected
					[ ] 
					[ ] //Click on edit payment frequency button
					[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
					[+] if(LoanDetails.Exists(5))
						[ ] LoanDetails.PaymentOptionsButton.Click()
						[ ] 
						[+] if(LoanPaymentOptions.Exists(5))
							[ ] 
							[ ] LoanPaymentOptions.SetActive()
							[ ] 
							[ ] 
							[ ] bResult=LoanPaymentOptions.LoanReminder.GetProperty("Value")
							[+] if(bResult==TRUE)
								[ ] ReportStatus("Verify if Loan Reminder option is selected by default",PASS,"Loan Reminder option is selected by default")
								[ ] 
								[ ] LoanPaymentOptions.Close()
								[ ] WaitForState(LoanPaymentOptions,FALSE,5)
								[ ] LoanDetails.Close()
								[ ] WaitForState(LoanDetails,FALSE,5)
								[ ] 
								[ ] 
								[ ] 
								[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List in Manage Reminders dialog
								[ ] QuickenWindow.SetActive()
								[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
								[+] if (DlgManageReminders.Exists(5))
									[ ] DlgManageReminders.AllBillsDepositsTab.Click()
									[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
									[ ] 
									[ ] bResult = MatchStr("*{lsAddLoanAccount[1]}*",sActual)
									[+] if(bResult==TRUE)
										[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddLoanAccount[1]}' is added successfully")
									[+] else
										[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddLoanAccount[1]} is NOT added, sActual = {sActual}")
									[ ] DlgManageReminders.Close()
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if Loan Reminder option is selected by default",FAIL,"Loan Reminder option is not selected by default")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Loan Payment Options window is open",FAIL,"Loan Payment Options window did not open")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Loan details window is open",FAIL,"Loan Details window did not open")
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
		[+] else
			[ ] ReportStatus("Add Manual spending account",FAIL,"Manual Spending account is not added")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File not created")
		[ ] 
	[ ] 
	[ ] 
[ ] //##########################################################################################################################
[ ] 
[ ] 
[+] //### Verify that on selecting the 'Memorized payee' option [DM2 >> Payment option button] should erase all the scheduled reminders from Bills tab ##
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_Selecting_Memorized_Payee_Option_For_Manual_Loan_Account_Payment_Option_Button
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that on selecting the 'Memorized payee' option [DM2 >> Payment option button] should erase all the scheduled reminders from Bills tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Selecting the 'Memorized payee' option [DM2 >> Payment option button] should erase all the scheduled reminders from Bills tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  7th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test02_Selecting_Memorized_Payee_Option_For_Manual_Loan_Account_Payment_Option_Button() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sExpectedString="Set up</a> a scheduled bill or deposit."
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[2]
		[ ] lsAddLoanAccount[2]=sDate
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
		[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //-----------------------Verification for Loan Reminder--------------------------
			[ ] 
			[ ] //Verification that Loan reminder option is the default selected
			[ ] 
			[ ] //Click on edit payment frequency button
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.PaymentOptionsButton.Click()
				[ ] 
				[+] if(LoanPaymentOptions.Exists(5))
					[ ] 
					[ ] //Select Option Memorized Payee from Payment options dialog
					[ ] LoanPaymentOptions.SetActive()
					[ ] LoanPaymentOptions.LoanReminder.Select(2)
					[ ] 
					[ ] 
					[ ] 
					[ ] bResult=LoanPaymentOptions.MemorizedPayee.GetProperty("Value")
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verify if Loan Reminder option is selected by default",PASS,"Loan Reminder option is selected by default")
						[ ] 
						[ ] 
						[ ] LoanPaymentOptions.OK.Click()
						[ ] WaitForState(LoanPaymentOptions,FALSE,5)
						[ ] 
						[ ] 
						[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List in Manage Reminders dialog
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
						[+] if (DlgManageReminders.Exists(5))
							[ ] DlgManageReminders.AllBillsDepositsTab.Click()
							[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
							[ ] 
							[ ] bResult = MatchStr("*{sExpectedString}*",sActual)
							[+] if(bResult==TRUE)
								[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddLoanAccount[1]}' is removed from manage reminder Dialog")
							[+] else
								[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddLoanAccount[1]} is NOT removed from Manage Reminder Dialog, sActual = {sActual}")
							[ ] DlgManageReminders.Close()
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Loan Reminder option is selected by default",FAIL,"Loan Reminder option is not selected by default")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan Payment Options window is open",FAIL,"Loan Payment Options window did not open")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Loan details window is open",FAIL,"Loan Details window did not open")
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
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################################################################
[ ] 
[ ] 
[+] //### Verify switching back to 'Loan Reminder' option from 'Memorized payee [DM2 >> Payment option button] should get back all the scheduled reminders on Bills tab.####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_Switching_Back_To_Loan_Reminder_Option_For_Manual_Loan_Account_Reschedules_Reminders_On_Bills_Tab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify switching back to 'Loan Reminder' option from 'Memorized payee [DM2 >> Payment option button] should get back all the scheduled reminders on Bills tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  switching back to 'Loan Reminder' option from 'Memorized payee [DM2 >> Payment option button] should get back all the scheduled reminders on Bills tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  7th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test03_Switching_Back_To_Loan_Reminder_Option_For_Manual_Loan_Account_Reschedules_Reminders_On_Bills_Tab() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sExpectedString="Set up</a> a scheduled bill or deposit."
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[2]
		[ ] lsAddLoanAccount[2]=sDate
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
		[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //-----------------------Verification for Loan Reminder--------------------------
			[ ] 
			[ ] //Verification that Loan reminder option is the default selected
			[ ] 
			[ ] //Click on edit payment frequency button
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.PaymentOptionsButton.Click()
				[ ] 
				[+] if(LoanPaymentOptions.Exists(5))
					[ ] 
					[ ] //Select Option Loan Reminder from Payment options dialog
					[ ] LoanPaymentOptions.SetActive()
					[ ] LoanPaymentOptions.LoanReminder.Select(1)
					[ ] 
					[ ] 
					[ ] 
					[ ] bResult=LoanPaymentOptions.LoanReminder.GetProperty("Value")
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verify if Loan Reminder option is selected by default",PASS,"Loan Reminder option is selected by default")
						[ ] 
						[ ] 
						[ ] LoanPaymentOptions.OK.Click()
						[+] if(DlgAddEditReminder.Exists(5))
							[ ] DlgAddEditReminder.DoneButton.Click()
							[ ] WaitForState(DlgAddEditReminder,FALSE,5)
							[ ] 
						[ ] WaitForState(LoanPaymentOptions,FALSE,5)
						[ ] 
						[ ] 
						[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List in Manage Reminders dialog
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
						[+] if (DlgManageReminders.Exists(5))
							[ ] DlgManageReminders.AllBillsDepositsTab.Click()
							[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
							[ ] 
							[ ] bResult = MatchStr("*{lsAddLoanAccount[1]}*",sActual)
							[+] if(bResult==TRUE)
								[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddLoanAccount[1]}' is added successfully")
							[+] else
								[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddLoanAccount[1]} is NOT added, sActual = {sActual}")
							[ ] DlgManageReminders.Close()
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Loan Reminder option is selected by default",FAIL,"Loan Reminder option is not selected by default")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan Payment Options window is open",FAIL,"Loan Payment Options window did not open")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Loan details window is open",FAIL,"Loan Details window did not open")
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
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################################################################
[ ] 
[ ] 
[+] //### Verify that if scheduled reminders for the manual account are deleted from Bills tab, automatically 'Memorized payee' option is selected on Loan Payment options window. [DM2 >> Payment option button] ###
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_Deleting_Loan_Reminders_Makes_Memorized_Payee_Default_Option_For_Manual_Loan_Account_Payment_Options
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that if scheduled reminders for the manual account are deleted from Bills tab, automatically 'Memorized payee' option is selected on Loan Payment options window. [DM2 >> Payment option button]
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If scheduled reminders for the manual account are deleted from Bills tab, automatically 'Memorized payee' option is selected on Loan Payment options window. [DM2 >> Payment option button]
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  7th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test04_Deleting_Loan_Reminders_Makes_Memorized_Payee_Default_Option_For_Manual_Loan_Account_Payment_Options() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sExpectedString="Set up</a> a scheduled bill or deposit."
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[2]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] 
		[ ] //Delete Loan Bill Reminder
		[ ] iValidate=ReminderOperations(sDeleteAction,lsAddLoanAccount[1],lsAddLoanAccount[6])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[ ] 
			[ ] 
			[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] 
				[ ] //-----------------------Verification for Loan Reminder--------------------------
				[ ] 
				[ ] //Verification that Loan reminder option is the default selected
				[ ] 
				[ ] //Click on edit payment frequency button
				[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
				[+] if(LoanDetails.Exists(5))
					[ ] LoanDetails.PaymentOptionsButton.Click()
					[ ] 
					[+] if(LoanPaymentOptions.Exists(5))
						[ ] 
						[ ] 
						[ ] bResult=LoanPaymentOptions.MemorizedPayee.GetProperty("Value")
						[+] if(bResult==TRUE)
							[ ] ReportStatus("Verify if Loan Reminder option is selected by default",PASS,"Loan Reminder option is selected by default")
							[ ] 
							[ ] 
							[ ] LoanPaymentOptions.OK.Click()
							[ ] WaitForState(LoanPaymentOptions,FALSE,5)
							[ ] LoanDetails.Close()
							[ ] WaitForState(LoanDetails,FALSE,5)
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Loan Reminder option is selected by default",FAIL,"Loan Reminder option is not selected by default")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Loan Payment Options window is open",FAIL,"Loan Payment Options window did not open")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan details window is open",FAIL,"Loan Details window did not open")
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
		[+] else
			[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window does NOT exist")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################################################################
[ ] 
[ ] 
[+] //############# Verify that Memorized Payee option is still selected after data file migration from an older version of Quicken ####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_Memorize_Payee_Option_Remains_Selected_After_Data_File_Migration_From_An_Older_Version_Of_Quicken
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that if a manual loan account is created in older version of Quicken (Eg.QW2012) with Memorize Payee option, then on converting that loan account to QW2013 by default 'Memorize Payee' radio button is selected.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Memorize Payee option is still selected after data file migration from an older version of Quicken
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test06_Memorize_Payee_Option_Remains_Selected_After_Data_File_Migration_From_An_Older_Version_Of_Quicken() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] 
		[ ] //Put in Loop
		[ ] STRING sFileName="QW2013_MP"
		[ ] STRING sVersion="2013"
		[ ] 
		[ ] 
		[ ] STRING sSourceFile=AUT_DATAFILE_PATH+"\"+sLoanDataFolder+"\"+sFileName + ".QDF"
		[ ] STRING sDataFile=AUT_DATAFILE_PATH +"\" + sFileName+ ".QDF"
		[ ] STRING sBackupFolder=AUT_DATAFILE_PATH+"\"+"Q13Files"
		[ ] 
		[ ] STRING sExpectedString="Set up</a> a scheduled bill or deposit."
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[2]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Open Older Data File and Convert to current edition
	[ ] 
	[ ] // //Copy Data File from folder
	[+] if(FileExists(sDataFile))
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] 
	[ ] //update due to change in DataFileConversion function
	[ ] sDataFile=AUT_DATAFILE_PATH +"\"
	[ ] iValidate=DataFileConversion(sFileName,sVersion,NULL,sDataFile)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Convert older data file with Manual loan account",PASS,"Data File with Manual loan account converted successfully")
		[ ] 
		[ ] //Verify that Loan Reminders payment option is checked in Loan Details>Loan Payment options window
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //-----------------------Verification for Loan Reminder--------------------------
			[ ] 
			[ ] //Verification that Loan reminder option is the default selected
			[ ] 
			[ ] //Click on edit payment frequency button
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.PaymentOptionsButton.Click()
				[ ] 
				[+] if(LoanPaymentOptions.Exists(5))
					[ ] 
					[ ] bResult=LoanPaymentOptions.MemorizedPayee.GetProperty("Value")
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verify if Loan Reminder option is selected by default",PASS,"Loan Reminder option is selected by default")
						[ ] 
						[ ] 
						[ ] LoanPaymentOptions.OK.Click()
						[ ] WaitForState(LoanPaymentOptions,FALSE,5)
						[ ] LoanDetails.Close()
						[ ] WaitForState(LoanDetails,FALSE,5)
						[ ] 
						[ ] 
						[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List in Manage Reminders dialog
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
						[+] if (DlgManageReminders.Exists(5))
							[ ] DlgManageReminders.AllBillsDepositsTab.Click()
							[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
							[ ] 
							[ ] bResult = MatchStr("*{sExpectedString}*",sActual)
							[+] if(bResult==TRUE)
								[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddLoanAccount[1]}' is removed from manage reminder Dialog")
							[+] else
								[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddLoanAccount[1]} is NOT removed from Manage Reminder Dialog, sActual = {sActual}")
							[ ] DlgManageReminders.Close()
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Manage reminder dialog is opened", FAIL, "Manage reminder dialog did not open")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Loan Reminder option is selected by default",FAIL,"Loan Reminder option is not selected by default")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan Payment Options window is open",FAIL,"Loan Payment Options window did not open")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Loan details window is open",FAIL,"Loan Details window did not open")
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
	[+] else
		[ ] ReportStatus("Convert older data file with Manual loan account",FAIL,"Data File with Manual loan account not converted")
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################################################################
[ ] 
[ ] 
[+] //############# Verify that Loan Reminder option is still selected after data file migration from an older version of Quicken ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_Loan_Reminder_Option_Remains_Selected_After_Data_File_Migration_From_An_Older_Version_Of_Quicken
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that if a manual loan account is created in older version of Quicken (Eg.QW2012) with Scheduled Transaction option, then on converting that loan account to QW2013 by default 'Loan Reminder' radio button is selected.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Loan Reminder option is still selected after data file migration from an older version of Quicken
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test05_Loan_Reminder_Option_Remains_Selected_After_Data_File_Migration_From_An_Older_Version_Of_Quicken() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] 
		[ ] //Put in Loop
		[ ] STRING sFileName="QW2013_LR"
		[ ] STRING sVersion="2013"
		[ ] 
		[ ] 
		[ ] STRING sSourceFile=AUT_DATAFILE_PATH+"\"+sLoanDataFolder+"\"+sFileName +".QDF"
		[ ] STRING sDataFile=AUT_DATAFILE_PATH +"\" + sFileName +".QDF"
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[2]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Open Older Data File and Convert to current edition
	[ ] 
	[ ] // //Copy Data File from folder
	[+] if(FileExists(sDataFile))
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] //OpenDataFile(sFileName)
	[ ] 
	[ ] //update due to change in DataFileConversion function
	[ ] sDataFile=AUT_DATAFILE_PATH +"\"
	[ ] 
	[ ] iValidate=DataFileConversion(sFileName,sVersion,NULL,sDataFile)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Convert older data file with Manual loan account",PASS,"Data File with Manual loan account converted successfully")
		[ ] 
		[ ] //Verify that Loan Reminders payment option is checked in Loan Details>Loan Payment options window
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] //-----------------------Verification for Loan Reminder--------------------------
			[ ] 
			[ ] //Verification that Loan reminder option is the default selected
			[ ] 
			[ ] //Click on edit payment frequency button
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.PaymentOptionsButton.Click()
				[ ] 
				[+] if(LoanPaymentOptions.Exists(5))
					[ ] 
					[ ] LoanPaymentOptions.SetActive()
					[ ] 
					[ ] 
					[ ] bResult=LoanPaymentOptions.LoanReminder.GetProperty("Value")
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verify if Loan Reminder option is selected by default",PASS,"Loan Reminder option is selected by default")
						[ ] 
						[ ] LoanPaymentOptions.Close()
						[ ] WaitForState(LoanPaymentOptions,FALSE,5)
						[ ] LoanDetails.Close()
						[ ] WaitForState(LoanDetails,FALSE,5)
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List in Manage Reminders dialog
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
						[+] if (DlgManageReminders.Exists(5))
							[ ] DlgManageReminders.AllBillsDepositsTab.Click()
							[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
							[ ] 
							[ ] bResult = MatchStr("*{lsAddLoanAccount[1]}*",sActual)
							[+] if(bResult==TRUE)
								[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddLoanAccount[1]}' is added successfully")
							[+] else
								[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddLoanAccount[1]} is NOT added, sActual = {sActual}")
							[ ] DlgManageReminders.Close()
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Loan Reminder option is selected by default",FAIL,"Loan Reminder option is not selected by default")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan Payment Options window is open",FAIL,"Loan Payment Options window did not open")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Loan details window is open",FAIL,"Loan Details window did not open")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Convert older data file with Manual loan account",FAIL,"Data File with Manual loan account not converted")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################################################################
[ ] 
[ ] 
[+] //#### Verify that Quicken should not crash On changing the Payment option from Memorized Payee to Reminder on bills tab  after data file is migrated ####
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_Memorize_Payee_Option_Remains_Selected_After_Data_File_Migration_From_An_Older_Version_Of_Quicken
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Quicken should not crash  On changing the Payment option from Memorized Payee to Reminder on bills tab.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Quicken does not crash and Loan Reminders are added
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  9th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test07_Change_Loan_Reminder_Option_To_Memorize_Payee_Option_In_A_Converted_Data_File() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] 
		[ ] //Put in Loop
		[ ] STRING sFileName="QW2013_MP"
		[ ] STRING sVersion="2013"
		[ ] 
		[ ] 
		[ ] STRING sSourceFile=AUT_DATAFILE_PATH+"\"+sLoanDataFolder+"\"+sFileName + ".QDF"
		[ ] //STRING sTestDataPath=AUT_DATAFILE_PATH
		[ ] STRING sDataFile=AUT_DATAFILE_PATH +"\" + sFileName + ".QDF"
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[2]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Open Older Data File and Convert to current edition
	[ ] 
	[ ] // //Copy Data File from folder
	[+] if(FileExists(sDataFile))
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] 
	[ ] 
	[ ] //update due to change in DataFileConversion function
	[ ] sDataFile=AUT_DATAFILE_PATH +"\"
	[ ] 
	[ ] 
	[ ] iValidate=DataFileConversion(sFileName,sVersion,NULL,sDataFile)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Convert older data file with Manual loan account",PASS,"Data File with Manual loan account converted successfully")
		[ ] 
		[ ] //Verify that Loan Reminders payment option is checked in Loan Details>Loan Payment options window
		[ ] 
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] //-----------------------Verification for Loan Reminder--------------------------
			[ ] 
			[ ] //Verification that Loan reminder option is the default selected
			[ ] 
			[ ] //Click on edit payment frequency button
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.PaymentOptionsButton.Click()
				[ ] 
				[+] if(LoanPaymentOptions.Exists(5))
					[ ] 
					[ ] //Select Option Loan Reminder from Payment options dialog
					[ ] LoanPaymentOptions.SetActive()
					[ ] LoanPaymentOptions.LoanReminder.Select(1)
					[ ] 
					[ ] 
					[ ] 
					[ ] bResult=LoanPaymentOptions.LoanReminder.GetProperty("Value")
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verify if Loan Reminder option is selected by default",PASS,"Loan Reminder option is selected by default")
						[ ] 
						[ ] 
						[ ] LoanPaymentOptions.OK.Click()
						[+] if(DlgAddEditReminder.Exists(5))
							[ ] DlgAddEditReminder.DoneButton.Click()
							[ ] WaitForState(DlgAddEditReminder,FALSE,5)
							[ ] 
						[ ] WaitForState(LoanPaymentOptions,FALSE,5)
						[ ] 
						[ ] 
						[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List in Manage Reminders dialog
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
						[+] if (DlgManageReminders.Exists(5))
							[ ] DlgManageReminders.AllBillsDepositsTab.Click()
							[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
							[ ] 
							[ ] bResult = MatchStr("*{lsAddLoanAccount[1]}*",sActual)
							[+] if(bResult==TRUE)
								[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddLoanAccount[1]}' is added successfully")
							[+] else
								[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddLoanAccount[1]} is NOT added, sActual = {sActual}")
							[ ] DlgManageReminders.Close()
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Loan Reminder option is selected by default",FAIL,"Loan Reminder option is not selected by default")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan Payment Options window is open",FAIL,"Loan Payment Options window did not open")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Loan details window is open",FAIL,"Loan Details window did not open")
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
	[+] else
		[ ] ReportStatus("Convert older data file with Manual loan account",FAIL,"Data File with Manual loan account not converted")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################################################################
[ ] 
[ ] 
[ ] 
[ ] //==========================================================================================
[ ] //======================= Minimal-view Loan details test cases for Loans ================================
[ ] //==========================================================================================
[ ] 
[ ] 
[+] //################ Verify that there is no minimal view for Manual loan account. #####################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_No_Minimal_View_For_Manual_Loan_Accounts
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that there is no minimal view for Manual loan account.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If there is no minimal view for Manual loan account.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  9th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01_No_Minimal_View_For_Manual_Loan_Accounts() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
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
		[ ] 
	[ ] iValidate=DataFileCreate(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Create Data File",PASS,"Data File created successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] //Add Checking account
		[ ] iValidate=AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add Manual spending account",PASS,"Manual Spending account is added")
			[ ] 
			[ ] //Add Loan account
			[ ] iValidate=AddEditManualLoanAccount(sAddAction,lsAddLoanAccount[1],lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],lsAddLoanAccount[7])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account is added")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
				[+] if(iValidate==PASS)
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[+] if(MDIClientLoans.LoanWindow.EditTerms.Exists(5))
						[ ] ReportStatus("Verify that Manual Loan has Edit Terms button",PASS,"Manual Loan has Edit Terms button")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Manual Loan has Edit Terms button",FAIL,"Edit Terms button not found on Manual Loan Dashboard")
						[ ] 
					[ ] 
					[ ] 
					[+] if(MDIClientLoans.LoanWindow.EditInterestRateAmountButton.Exists(5))
						[ ] ReportStatus("Verify that Manual Loan has Edit Interest Rate button",PASS,"Manual Loan has Edit Interest rate button")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Manual Loan has Edit Interest rate button",FAIL,"Edit Interest rate button not found on Manual Loan Dashboard")
						[ ] 
					[ ] 
					[ ] 
					[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
						[ ] ReportStatus("Verify that Manual Loan has Edit Payment Frequency button",PASS,"Manual Loan has Edit Payment Frequency button")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Manual Loan has Edit Payment Frequency button",FAIL,"Edit Payment Frequency button not found on Manual Loan Dashboard")
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
			[+] else
				[ ] ReportStatus("Add Manual loan account",FAIL,"Manual loan account not added")
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
[ ] //########################################################################################################################
[ ] 
[ ] 
[+] //#### Verify that Connected loan account has minimal view with 'Add Loan Details' button and 'Add linked asset account' dropdown.#############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_Add_Manual_Loan_Account_With_Different_Payment_Schedules
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Connected loan account has minimal view with 'Add Loan Details' button and 'Add linked asset account' dropdown.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to add manual loan account with different payment schedule
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  10th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test02_03_04_Connected_Manual_Loan_Account_With_Different_Payment_Schedules() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] // //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sMinimalViewSheet)
		[ ] lsFileData=lsExcelData[1]
		[ ] 
		[ ] STRING sFileName=lsFileData[1]
		[ ] STRING sAccountName=lsFileData[2]
		[ ] STRING sFIName=lsFileData[3]
		[ ] 
		[ ] STRING sSourceFile=AUT_DATAFILE_PATH+"\"+sLoanDataFolder+"\"+sFileName+".QDF"
		[ ] STRING sDataFile=AUT_DATAFILE_PATH +"\" + sFileName+".QDF"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] print(sFileName)
	[ ] print(sDataFile)
	[ ] 
	[ ] 
	[ ] 
	[ ] // //Copy Data File from folder
	[+] if(FileExists(sDataFile))
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] 
	[ ] 
	[ ] //Open Data file
	[ ] iValidate=OpenDataFile(sFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(sAccountName,ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify FI Name
			[ ] STRING sActualName=MDIClientLoans.LoanWindow.FINameText.GetCaption()
			[+] if(sActualName==sFIName)
				[ ] ReportStatus("Verify if correct FI name is displayed",PASS,"Correct FI name is displayed {sActualName}")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if correct FI name is displayed",FAIL,"Wrong FI name is displayed {sActualName}")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] // Verify Loan Details window
			[+] if(MDIClientLoans.LoanWindow.AddLoanDetailsButton.Exists(5))
				[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",PASS,"Add Loan Details button is present")
				[ ] 
				[ ] MDIClientLoans.LoanWindow.AddLoanDetailsButton.Click()
				[+] if(LoanDetails.Exists(5))
					[ ] ReportStatus("Verify if Loan details window opens when Add Loan Details button is clicked on online loan account dashboard",PASS,"Loan Details window opens when Add Loan details is clicked on online loan account dashboard")
					[ ] 
					[ ] //Verify Loan Name
					[+] if(LoanDetails.LoanNameTextField.Exists(2))
						[ ] ReportStatus("Verify Loan Name Text field",PASS,"Loan name text field found")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Loan Name Text field",FAIL,"Loan name text field not found")
						[ ] 
						[ ] 
					[ ] 
					[ ] //Verify Opening Date
					[+] if(LoanDetails.OpeningDateTextField.Exists(2))
						[ ] ReportStatus("Verify Opening Date Text field",PASS,"Opening Date text field found")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Opening Date Text field",FAIL,"Opening Date text field not found")
					[ ] 
					[ ] 
					[ ] //Verify Original Balance
					[+] if(LoanDetails.OriginalBalanceTextField.Exists(2))
						[ ] ReportStatus("Verify Original Balance Text Field",PASS,"Original Balance Text Field  found")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Original Balance Text Field",FAIL,"Original Balance Text Field not found")
					[ ] 
					[ ] 
					[ ] //Verify Current Interest Rate
					[+] if(LoanDetails.CurrentInterestRateTextField.Exists(2))
						[ ] ReportStatus("Verify Current Interest Rate Text Field",PASS,"Current Interest Rate Text Field found")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Current Interest Rate Text Field",FAIL,"Current Interest Rate Text Field not found")
					[ ] 
					[ ] 
					[ ] //Verify Original Length Rate
					[+] if(LoanDetails.OriginalLengthTextField.Exists(2))
						[ ] ReportStatus("Verify Original Length Text Field",PASS,"Original Length Text Field found")
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Original Length Text Field",FAIL,"Original Length Text Field not found")
						[ ] 
					[ ] 
					[ ] 
					[ ] LoanDetails.Close()
					[ ] WaitForState(LoanDetails,FALSE,5)
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan details window opens when Add Loan Details button is clicked on online loan account dashboard",FAIL,"Loan Details window does not open when Add Loan details is clicked on online loan account dashboard")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",FAIL,"Add Loan Details button is not found in Online account minimal view")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] // Verify Add Linked Asset Account window
			[+] if(MDIClientLoans.LoanWindow.AddLinkedAssetAccount.Exists(5))
				[ ] ReportStatus("Verify if Add Linked Asset Account button is present on connected loan account dashboard",PASS,"Add Linked Asset Account button is present")
				[ ] 
				[ ] 
				[+] for(i=1;i<=3;i++)
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] MDIClientLoans.LoanWindow.AddLinkedAssetAccount.Click()
					[ ] 
					[ ] MDIClientLoans.LoanWindow.AddLinkedAssetAccount.TypeKeys(Replicate(KEY_DN,i))
					[ ] MDIClientLoans.LoanWindow.AddLinkedAssetAccount.TypeKeys(KEY_ENTER)
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[+] if(AddAnyAccount.Exists(5))
						[ ] 
						[ ] STRING sActual=AddAnyAccount.AccountName.GetText()
						[+] if(sActual==lsLinkedAccounts[i])
							[ ] ReportStatus("Verify if correct Asset account window opens",PASS,"Correct Asset account window {sActual} opens")
							[ ] 
							[ ] AddAnyAccount.Close()
							[ ] WaitForState(AddAnyAccount,FALSE,5)
							[ ] 
						[+] else
							[ ] 
							[ ] ReportStatus("Verify if correct Asset account window opens",FAIL,"Wrong Asset account window {sActual} opens for {lsLinkedAccounts[i]}")
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Add an Account window opens",FAIL,"Add An Account window did not open")
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
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // MDIClientLoans.LoanWindow.AddLoanDetailsButtonClick()
				[+] // if(LoanDetails.Exists(5))
					[ ] // ReportStatus("Verify if Loan details window opens when Add Loan Details button is clicked on online loan account dashboard",PASS,"Loan Details window opens when Add Loan details is clicked on online loan account dashboard")
					[ ] // 
					[ ] // //Verify Loan Name
					[+] // if(LoanDetails.LoanNameTextField.Exists(2))
						[ ] // ReportStatus("Verify Loan Name Text field",PASS,"Loan name text field not found")
						[ ] // 
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Loan Name Text field",FAIL,"Loan name text field not found")
						[ ] // 
						[ ] // 
					[ ] // 
					[ ] // //Verify Loan Type list
					[+] // if(LoanDetails.LoanTypePopupList.Exists(2))
						[ ] // ReportStatus("Verify Loan Type Popuplist",PASS,"Loan type popup list found")
						[ ] // 
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Loan Type Popuplist",FAIL,"Loan type popup list not found")
					[ ] // 
					[ ] // //Verify Opening Date
					[+] // if(LoanDetails.OpeningDateTextField.Exists(2))
						[ ] // ReportStatus("Verify Opening Date Text field",PASS,"Opening Date text field found")
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Opening Date Text field",FAIL,"Opening Date text field not found")
					[ ] // 
					[ ] // 
					[ ] // //Verify Original Balance
					[+] // if(LoanDetails.OriginalBalanceTextField.Exists(2))
						[ ] // ReportStatus("Verify Original Balance Text Field",PASS,"Original Balance Text Field  found")
						[ ] // 
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Original Balance Text Field",FAIL,"Original Balance Text Field not found")
					[ ] // 
					[ ] // 
					[ ] // //Verify Current Interest Rate
					[+] // if(LoanDetails.CurrentInterestRateTextField.Exists(2))
						[ ] // ReportStatus("Verify Current Interest Rate Text Field",PASS,"Current Interest Rate Text Field found")
						[ ] // 
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Current Interest Rate Text Field",FAIL,"Current Interest Rate Text Field not found")
					[ ] // 
					[ ] // 
					[ ] // //Verify Original Length Rate
					[+] // if(LoanDetails.OriginalLengthTextField.Exists(2))
						[ ] // ReportStatus("Verify Original Length Text Field",PASS,"Original Length Text Field found")
						[ ] // 
						[ ] // 
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Original Length Text Field",FAIL,"Original Length Text Field not found")
						[ ] // 
					[ ] // 
					[ ] // 
					[ ] // LoanDetails.Close()
					[ ] // WaitForState(LoanDetails,FALSE,5)
					[ ] // 
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify if Loan details window opens when Add Loan Details button is clicked on online loan account dashboard",FAIL,"Loan Details window does not open when Add Loan details is clicked on online loan account dashboard")
					[ ] // 
					[ ] // 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",FAIL,"Add Loan Details button is not found in Online account minimal view")
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
			[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //########################################################################################################################
[ ] 
[ ] 
[ ] //==========================================================================================
[ ] //======================= Minimal-view Payment details test cases for Loans ================================
[ ] //==========================================================================================
[ ] 
[ ] 
[+] //#### Verify Payment details tab of Account  for Connected loan account has minimal view with 'Add Loan Details' button and 'Add linked asset account' dropdown.#############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_Add_Manual_Loan_Account_With_Different_Payment_Schedules
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Connected loan account has minimal view with 'Add Loan Details' button and 'Add linked asset account' dropdown.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to add manual loan account with different payment schedule
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  10th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01_02_Verify_Payment_Details_Tab_Connected_Loan_Account() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] // //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sMinimalViewSheet)
		[ ] lsFileData=lsExcelData[1]
		[ ] 
		[ ] STRING sFileName=lsFileData[1]
		[ ] STRING sAccountName=lsFileData[2]
		[ ] STRING sFIName=lsFileData[3]
		[ ] 
		[ ] STRING sSourceFile=AUT_DATAFILE_PATH+"\"+sLoanDataFolder+"\"+sFileName+".QDF"
		[ ] STRING sDataFile=AUT_DATAFILE_PATH +"\" + sFileName+".QDF"
		[ ] 
		[ ] LIST OF STRING lsLinkedAccounts={"House","Car","Asset"}
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] // // //Copy Data File from folder
	[+] // if(FileExists(sDataFile))
		[ ] // DeleteFile(sDataFile)
	[ ] // CopyFile(sSourceFile,sDataFile)
	[ ] 
	[ ] 
	[ ] //Open Data file
	[ ] iValidate=OpenDataFile(sFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(sAccountName,ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] // 
			[ ] // //Verify FI Name
			[ ] // STRING sActualName=MDIClientLoans.LoanWindow.FINameText.GetCaption()
			[+] // if(sActualName==sFIName)
				[ ] // ReportStatus("Verify if correct FI name is displayed",PASS,"Correct FI name is displayed {sActualName}")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify if correct FI name is displayed",FAIL,"Wrong FI name is displayed {sActualName}")
				[ ] // 
				[ ] // 
				[ ] // 
			[ ] // 
			[ ] // 
			[ ] // 
			[ ] 
			[ ] //Navigate to Payment details tab
			[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
			[ ] 
			[ ] // Verify Add Linked Asset Account button should not exist on Payment Details tab
			[+] if(!MDIClientLoans.LoanWindow.AddLinkedAssetAccount.Exists(5))
				[ ] ReportStatus("Verify if Add Linked Asset Account button is present on Payment details tab ",PASS,"Add Linked Asset Account button is not displayed under Payment detaisl tab")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Add Linked Asset Account button is present on Payment details tab ",FAIL,"Add Linked Asset Account button is displayed under Payment detaisl tab")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] // Verify Loan Details window
			[+] if(MDIClientLoans.LoanWindow.AddLoanDetailsButton.Exists(5))
				[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",PASS,"Add Loan Details button is present")
				[ ] 
				[ ] MDIClientLoans.LoanWindow.AddLoanDetailsButton.Click()
				[+] if(LoanDetails.Exists(5))
					[ ] ReportStatus("Verify if Loan details window opens when Add Loan Details button is clicked on online loan account dashboard",PASS,"Loan Details window opens when Add Loan details is clicked on online loan account dashboard")
					[ ] 
					[ ] //Verify Loan Name
					[+] if(LoanDetails.LoanNameTextField.Exists(2))
						[ ] ReportStatus("Verify Loan Name Text field",PASS,"Loan name text field not found")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Loan Name Text field",FAIL,"Loan name text field not found")
						[ ] 
						[ ] 
					[ ] 
					[ ] //Verify Opening Date
					[+] if(LoanDetails.OpeningDateTextField.Exists(2))
						[ ] ReportStatus("Verify Opening Date Text field",PASS,"Opening Date text field found")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Opening Date Text field",FAIL,"Opening Date text field not found")
					[ ] 
					[ ] 
					[ ] //Verify Original Balance
					[+] if(LoanDetails.OriginalBalanceTextField.Exists(2))
						[ ] ReportStatus("Verify Original Balance Text Field",PASS,"Original Balance Text Field  found")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Original Balance Text Field",FAIL,"Original Balance Text Field not found")
					[ ] 
					[ ] 
					[ ] //Verify Current Interest Rate
					[+] if(LoanDetails.CurrentInterestRateTextField.Exists(2))
						[ ] ReportStatus("Verify Current Interest Rate Text Field",PASS,"Current Interest Rate Text Field found")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Current Interest Rate Text Field",FAIL,"Current Interest Rate Text Field not found")
					[ ] 
					[ ] 
					[ ] //Verify Original Length Rate
					[+] if(LoanDetails.OriginalLengthTextField.Exists(2))
						[ ] ReportStatus("Verify Original Length Text Field",PASS,"Original Length Text Field found")
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Original Length Text Field",FAIL,"Original Length Text Field not found")
						[ ] 
					[ ] 
					[ ] 
					[ ] LoanDetails.Close()
					[ ] WaitForState(LoanDetails,FALSE,5)
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan details window opens when Add Loan Details button is clicked on online loan account dashboard",FAIL,"Loan Details window does not open when Add Loan details is clicked on online loan account dashboard")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",FAIL,"Add Loan Details button is not found in Online account minimal view")
				[ ] 
				[ ] 
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
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //########################################################################################################################
[ ] 
[ ] 
[ ] 
[ ] //==========================================================================================
[ ] //=============================== Reminder Split Category dialog ===================================
[ ] //==========================================================================================
[ ] 
[ ] 
[+] //############# Verify that Split Category is not displayed when a simple reminder is added to the Loan account  #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_Split_Category_Is_Not_Displayed_When_Simple_Reminder_Is_Added
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Split Category is not displayed  when a simple reminder is added to the Loan account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If there is no minimal view for Manual loan account.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  13th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01_Split_Category_Is_Not_Displayed_When_Simple_Reminder_Is_Added() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails
		[ ] STRING sExpectedCategory="Home:Mortgage"
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
			[ ] 
			[ ] //Add Loan account
			[ ] iValidate=AddCCBankLoanAccount(lsAddLoanAccount[1],lsAddLoanAccount[2])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Add CCBank loan account",PASS,"CCBank loan account is added")
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=OnlineLoansNaviagateToD3Step(lsLoanDetails[1],lsLoanDetails[2],lsLoanDetails[3],lsLoanDetails[4],lsLoanDetails[5],lsLoanDetails[6],lsLoanDetails[7])
				[+] if(iValidate==PASS)
					[ ] 
					[ ] 
					[+] if(DlgLoanReminder.Exists(5))
						[ ] 
						[ ] //Select First Option i.e. 'Yes' for adding a simple reminder
						[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(1)
						[ ] 
						[ ] //Click on Next Button
						[ ] DlgLoanReminder.NextButton.Click()
						[ ] 
						[ ] 
						[+] if(DlgAddEditReminder.Exists(5))
							[ ] 
							[ ] 
							[ ] DlgAddEditReminder.DoneButton.Click()
							[ ] WaitForState(DlgAddEditReminder,FALSE,5)
							[ ] 
							[ ] 
							[ ] //Verify that Reminder is added without splits
							[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
								[ ] 
								[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
								[+] if(LoanDetails.Exists(5))
									[ ] 
									[ ] LoanDetails.EditLoanReminderButton.Click()
									[ ] 
									[+] if(DlgAddEditReminder.Exists(5))
										[ ] 
										[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
										[ ] 
										[ ] 
										[+] if(!DlgOptionalSetting.SplitCategoryButton.Exists(5))
											[ ] ReportStatus("Verify that split category button should not be visible",PASS,"Split category button is not visible")
											[ ] 
											[ ] 
											[ ] sActual=DlgOptionalSetting.CategoryTextField.GetText()
											[+] if(sActual==sExpectedCategory)
												[ ] ReportStatus("Verify that split category is not added",PASS,"Split category is not added , only single category {sExpectedCategory} is added")
												[ ] 
												[ ] 
												[ ] 
											[+] else
												[ ] ReportStatus("Verify that split category is not added",FAIL,"Wrong value for category is added :  {sActual} , Expected is : {sExpectedCategory}")
												[ ] 
												[ ] 
												[ ] 
												[ ] 
											[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Verify that split category button should not be visible",FAIL,"Split category button is visible")
											[ ] 
											[ ] 
										[ ] 
										[ ] 
										[ ] //Close Optional Settings dialog
										[ ] DlgOptionalSetting.CancelButton.Click()
										[ ] WaitForState(DlgOptionalSetting,FALSE,5)
										[ ] //Close AddEdit Reminder Dialog
										[ ] DlgAddEditReminder.CancelButton.Click()
										[ ] WaitForState(DlgAddEditReminder,FALSE,5)
										[ ] //Close Loan Details Dialog
										[ ] LoanDetails.Close()
										[ ] WaitForState(LoanDetails,FALSE,5)
										[ ] 
										[ ] 
										[ ] //Delete Loan Account
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
										[ ] ReportStatus("Verify if Add Reminder dialog is opened",FAIL,"Add Reminder dialog did not open")
										[ ] 
										[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if Loan Details window is displayed",FAIL,"Loan Details window is not displayed")
									[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if Loan Dashboard is displayed",FAIL,"Loan Dashboard is not displayed")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Add Reminder dialog is opened",FAIL,"Add Reminder dialog did not open")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Open Loan Reminder dialog",FAIL,"Loan Reminder dialog is not displayed")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Navigate to step D3 in an Online loan",FAIL,"Unable to Navigate to step D3 in an Online loan")
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
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //############## Verify that Split Category is  displayed when a Detail reminder is added to the Loan account  ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_Split_Category_Is_Displayed_When_Detailed_Reminder_Is_Added
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Split Category is displayed when a Detail reminder is added to the Loan account.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Split Category is  displayed only when a Detail reminder is added to the Loan account.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  13th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test02_Split_Category_Is_Displayed_When_Detailed_Reminder_Is_Added() appstate none
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
		[ ] // // Read manual loan account data from excel sheet
		[ ] // lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sSplitReminderCategory)
		[ ] // lsAddLoanAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
		[ ] lsLoanDetails=lsExcelData[2]
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
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] iValidate=OnlineLoansNaviagateToD3Step(lsLoanDetails[1],lsLoanDetails[2],lsLoanDetails[3],lsLoanDetails[4],lsLoanDetails[5],lsLoanDetails[6],lsLoanDetails[7])
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[+] if(DlgLoanReminder.Exists(5))
				[ ] 
				[ ] //Select First Option i.e. 'Yes' for adding a detailed reminder
				[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(2)
				[ ] 
				[ ] //Click on Next Button
				[ ] DlgLoanReminder.NextButton.Click()
				[ ] 
				[ ] 
				[+] if(DlgAddEditReminder.Exists(5))
					[ ] 
					[ ] 
					[ ] DlgAddEditReminder.DoneButton.Click()
					[ ] WaitForState(DlgAddEditReminder,FALSE,5)
					[ ] 
					[ ] 
					[ ] //Verify that Reminder is added without splits
					[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
						[ ] 
						[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
						[+] if(LoanDetails.Exists(5))
							[ ] 
							[ ] LoanDetails.EditLoanReminderButton.Click()
							[ ] 
							[+] if(DlgAddEditReminder.Exists(5))
								[ ] 
								[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
								[ ] 
								[ ] 
								[+] if(DlgOptionalSetting.SplitCategoryButton.Exists(5))
									[ ] ReportStatus("Verify that split category button should be visible",PASS,"Split category button is visible for a detailed reminder")
									[ ] 
									[ ] 
									[ ] //Verify if Split dialog is opened
									[ ] DlgOptionalSetting.SplitCategoryButton.Click()
									[+] if(SplitTransaction.Exists(5))
										[ ] ReportStatus("Verify that split category window is opened",PASS,"Split category window is opened")
										[ ] 
										[ ] SplitTransaction.Close()
										[ ] WaitForState(SplitTransaction,FALSE,5)
										[ ] 
										[ ] 
										[ ] bResult=DlgOptionalSetting.CategoryTextField.IsEnabled()
										[+] if(bResult==FALSE)
											[ ] ReportStatus("Verify that split category is added",PASS,"Split category is added since category field is disabled")
											[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Verify that split category is not added",FAIL,"Wrong value for category is added since category field is enabled")
											[ ] 
											[ ] 
											[ ] 
										[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify that split category window is opened",FAIL,"Split category window is not opened")
										[ ] 
										[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify that split category button should not be visible",FAIL,"Split category button is visible for a detailed reminder")
									[ ] 
									[ ] 
								[ ] 
								[ ] 
								[ ] //Close Optional Settings dialog
								[ ] DlgOptionalSetting.CancelButton.Click()
								[ ] WaitForState(DlgOptionalSetting,FALSE,5)
								[ ] //Close AddEdit Reminder Dialog
								[ ] DlgAddEditReminder.CancelButton.Click()
								[ ] WaitForState(DlgAddEditReminder,FALSE,5)
								[ ] //Close Loan Details Dialog
								[ ] LoanDetails.Close()
								[ ] WaitForState(LoanDetails,FALSE,5)
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if Add Reminder dialog is opened",FAIL,"Add Reminder dialog did not open")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Loan Details window is displayed",FAIL,"Loan Details window is not displayed")
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Loan Dashboard is displayed",FAIL,"Loan Dashboard is not displayed")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Add Reminder dialog is opened",FAIL,"Add Reminder dialog did not open")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Loan Reminder dialog is displayed",FAIL,"Loan Reminder dialog is NOT displayed")
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
			[ ] ReportStatus("Navigate to step D3 in an Online loan",FAIL,"Unable to Navigate to step D3 in an Online loan")
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
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //############  Verify that first two rows of the splits for connected loan accounts from loan reminder should be non-editable #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_First_Two_Rows_Of_Splits_In_Connected_Loan_Reminder_Should_Be_Non_Editable
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that first two rows of the splits for Connected loan accounts from loan reminder should be non-editable
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If first two rows of the splits for Connected loan accounts from loan reminder are non-editable
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  14th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test08_First_Two_Rows_Of_Splits_In_Connected_Loan_Reminder_Should_Be_Non_Editable() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
		[ ] lsLoanDetails=lsExcelData[2]
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsLoanDetails[1],ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] //-----------------------Verification for Loan Reminder--------------------------
			[ ] 
			[ ] //Verification that Loan reminder option is the default selected
			[ ] 
			[ ] //Click on edit payment frequency button
			[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] 
				[ ] LoanDetails.EditLoanReminderButton.Click()
				[ ] 
				[+] if(DlgAddEditReminder.Exists(5))
					[ ] ReportStatus("Verify if Add Reminder dialog is open",PASS,"Add Reminder dialog opens from Edit Loan Reminder button")
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
					[ ] 
					[ ] 
					[+] if(DlgOptionalSetting.SplitCategoryButton.Exists(5))
						[ ] ReportStatus("Verify that split category button should be visible",PASS,"Split category button is visible for a detailed reminder")
						[ ] 
						[ ] 
						[ ] //Verify if Split dialog is opened
						[ ] DlgOptionalSetting.SplitCategoryButton.Click()
						[+] if(SplitTransaction.Exists(5))
							[ ] ReportStatus("Verify that split category window is opened",PASS,"Split category window is opened")
							[ ] 
							[ ] 
							[ ] 
							[ ] //Select first row of Listbox
							[ ] SplitTransaction.SetActive()
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select(1)
							[+] if(!SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.Exists(5))
								[ ] ReportStatus("Verify that First row of Split Transaction should not be editable",PASS,"Textfield not found hence First row of Split transaction listbox is not editable")
								[ ] 
								[ ] //Select second row of Listbox
								[ ] SplitTransaction.SetActive()
								[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select(2)
								[+] if(!SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.Exists(5))
									[ ] ReportStatus("Verify that second row of Split Transaction should not be editable",PASS,"Textfield not found hence second row of Split transaction listbox is not editable")
									[ ] 
									[ ] 
									[ ] //Select third row of Listbox
									[ ] SplitTransaction.SetActive()
									[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select(3)
									[+] if(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.Exists(5))
										[ ] ReportStatus("Verify that third row of Split Transaction should be editable",PASS,"Textfield found hence third row of Split transaction listbox is editable")
										[ ] 
										[ ] 
										[ ] SplitTransaction.Close()
										[ ] WaitForState(SplitTransaction,FALSE,5)
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify that third row of Split Transaction should be editable",FAIL,"Textfield not found hence third row of Split transaction listbox is not editable")
										[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify that second row of Split Transaction should not be editable",FAIL,"Textfield found hence second row of Split transaction listbox is editable")
									[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that First row of Split Transaction should not be editable",FAIL,"Textfield found hence First row of Split transaction listbox is editable")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that split category window is opened",FAIL,"Split category window is not opened")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that split category button should not be visible",FAIL,"Split category button is not visible for a detailed reminder")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] //Close Optional Settings dialog
					[ ] DlgOptionalSetting.CancelButton.Click()
					[ ] WaitForState(DlgOptionalSetting,FALSE,5)
					[ ] //Close AddEdit Reminder Dialog
					[ ] DlgAddEditReminder.CancelButton.Click()
					[ ] WaitForState(DlgAddEditReminder,FALSE,5)
					[ ] //Close Loan Details Dialog
					[ ] LoanDetails.Close()
					[ ] WaitForState(LoanDetails,FALSE,5)
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Add Reminder dialog is opened",FAIL,"Add Reminder dialog did not open")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Loan details window is open",FAIL,"Loan Details window did not open")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] //Delete Loan Account
			[ ] iValidate=ModifyAccount(sMDIWindow,lsLoanDetails[1],sDeleteAction)
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
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken window not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################################
[ ] 
[ ] 
[+] //####### Verify that when no reminder is added, then on Edit D2 screen 'Add Reminder' button is diplayed to the Loan account ###########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_Add_Reminder_Button_Is_Displayed_When_Reminder_Is_Not_Added
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Split Category is not displayed  when a simple reminder is added to the Loan account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Split Category is not displayed  when a simple reminder is added to the Loan account
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  13th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test03_Add_Reminder_Button_Is_Displayed_When_Reminder_Is_Not_Added() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails
		[ ] //STRING sExpectedCategory="Home:Mortgage"
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
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] //Add Loan account
		[ ] iValidate=AddCCBankLoanAccount(lsAddLoanAccount[1],lsAddLoanAccount[2])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add CCBank loan account",PASS,"CCBank loan account is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=OnlineLoansNaviagateToD3Step(lsLoanDetails[1],lsLoanDetails[2],lsLoanDetails[3],lsLoanDetails[4],lsLoanDetails[5],lsLoanDetails[6],lsLoanDetails[7])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[+] if(DlgLoanReminder.Exists(5))
					[ ] 
					[ ] //Select First Option i.e. 'Yes' for adding a simple reminder
					[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(3)
					[ ] 
					[ ] //Click on Done Button
					[ ] DlgLoanReminder.DoneButton.Click()
					[ ] 
					[ ] 
					[ ] sleep(5)
					[ ] 
					[ ] iValidate=SelectAccountFromAccountBar(lsLoanDetails[1],ACCOUNT_PROPERTYDEBT)
					[+] if(iValidate==PASS)
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify that no Reminder is added without splits
						[+] if(MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Exists(5))
							[ ] 
							[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
							[ ] 
							[+] if(LoanDetails.AddLoanReminder.Exists(5))
								[ ] ReportStatus("Verify if Loan Details Add Reminder button is displayed",PASS,"Add Reminder button on Loan Details window is displayed")
								[ ] 
								[ ] LoanDetails.AddLoanReminder.Click()
								[ ] 
								[+] if(DlgLoanReminder.Exists(5))
									[ ] ReportStatus("Verify if Loan Reminder dialog is opened",PASS,"Loan Reminder dialog did opened")
									[ ] 
									[ ] DlgLoanReminder.Close()
									[ ] WaitForState(DlgLoanReminder,FALSE,5)
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if Loan Reminder dialog is opened",FAIL,"Loan Reminder dialog did not open")
									[ ] 
									[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if Loan Details Add Reminder button is displayed",FAIL,"Add Reminder button on Loan Details window is displayed")
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Loan Dashboard is displayed",FAIL,"Loan Dashboard is not displayed")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] // 
						[ ] 
					[+] else
						[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register not opened")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Loan Reminder dialog",FAIL,"Loan Reminder dialog is not displayed")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Navigate to step D3 in an Online loan",FAIL,"Unable to Navigate to step D3 in an Online loan")
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
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken window not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //####################################################################################################################
[ ] 
[ ] 
[+] //###################  Verify that while adding Manual Loan account only Detail reminder is added with Split category ###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_Detailed_Reminder_Is_Default_Option_For_Manual_Loan_Reminder
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that while adding Manual Loan account only Detail reminder is added with Split category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If only Detail reminder is added with Split category for Manual Reminder
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  14th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test04_Detailed_Reminder_Is_Default_Option_For_Manual_Loan_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[2]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] //Add Loan account
		[ ] iValidate=AddEditManualLoanAccount(sAddAction,lsAddLoanAccount[1],lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],lsAddLoanAccount[7])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account is added")
			[ ] 
			[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //-----------------------Verification for Loan Reminder--------------------------
				[ ] 
				[ ] //Verification that Loan reminder option is the default selected
				[ ] 
				[ ] //Click on edit payment frequency button
				[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
				[+] if(LoanDetails.Exists(5))
					[ ] 
					[ ] LoanDetails.EditLoanReminderButton.Click()
					[ ] 
					[+] if(DlgAddEditReminder.Exists(5))
						[ ] ReportStatus("Verify if Add Reminder dialog is open",PASS,"Add Reminder dialog opens from Edit Loan Reminder button")
						[ ] 
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
						[ ] 
						[ ] 
						[+] if(DlgOptionalSetting.SplitCategoryButton.Exists(5))
							[ ] ReportStatus("Verify that split category button should be visible",PASS,"Split category button is visible for a detailed reminder")
							[ ] 
							[ ] 
							[ ] //Verify if Split dialog is opened
							[ ] DlgOptionalSetting.SplitCategoryButton.Click()
							[+] if(SplitTransaction.Exists(5))
								[ ] ReportStatus("Verify that split category window is opened",PASS,"Split category window is opened")
								[ ] 
								[ ] SplitTransaction.Close()
								[ ] WaitForState(SplitTransaction,FALSE,5)
								[ ] 
								[ ] 
								[ ] bResult=DlgOptionalSetting.CategoryTextField.IsEnabled()
								[+] if(bResult==FALSE)
									[ ] ReportStatus("Verify that split category is added",PASS,"Split category is added since category field is disabled")
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify that split category is not added",FAIL,"Wrong value for category is added since category field is enabled")
									[ ] 
									[ ] 
									[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that split category window is opened",FAIL,"Split category window is not opened")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that split category button should not be visible",FAIL,"Split category button is visible for a detailed reminder")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] //Close Optional Settings dialog
						[ ] DlgOptionalSetting.CancelButton.Click()
						[ ] WaitForState(DlgOptionalSetting,FALSE,5)
						[ ] //Close AddEdit Reminder Dialog
						[ ] DlgAddEditReminder.CancelButton.Click()
						[ ] WaitForState(DlgAddEditReminder,FALSE,5)
						[ ] //Close Loan Details Dialog
						[ ] LoanDetails.Close()
						[ ] WaitForState(LoanDetails,FALSE,5)
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Add Reminder dialog is opened",FAIL,"Add Reminder dialog did not open")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan details window is open",FAIL,"Loan Details window did not open")
					[ ] 
					[ ] 
				[ ] 
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
				[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register not opened")
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
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken window not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################################
[ ] 
[ ] 
[+] //############  Verify that first two rows of the splits for manual loan accounts from loan reminder should be non-editable #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_First_Two_Rows_Of_Splits_In_Manual_Loan_Reminder_Should_Be_Non_Editable
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that first two rows of the splits for manual loan accounts from loan reminder should be non-editable
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If first two rows of the splits for manual loan accounts from loan reminder are non-editable
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  14th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test07_First_Two_Rows_Of_Splits_In_Manual_Loan_Reminder_Should_Be_Non_Editable() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[2]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] //Add Loan account
		[ ] iValidate=AddEditManualLoanAccount(sAddAction,lsAddLoanAccount[1],lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],lsAddLoanAccount[7])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account is added")
			[ ] 
			[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //-----------------------Verification for Loan Reminder--------------------------
				[ ] 
				[ ] //Verification that Loan reminder option is the default selected
				[ ] 
				[ ] //Click on edit payment frequency button
				[ ] MDIClientLoans.LoanWindow.EditPaymentFrequencyButton.Click()
				[+] if(LoanDetails.Exists(5))
					[ ] 
					[ ] LoanDetails.EditLoanReminderButton.Click()
					[ ] 
					[+] if(DlgAddEditReminder.Exists(5))
						[ ] ReportStatus("Verify if Add Reminder dialog is open",PASS,"Add Reminder dialog opens from Edit Loan Reminder button")
						[ ] 
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
						[ ] 
						[ ] 
						[+] if(DlgOptionalSetting.SplitCategoryButton.Exists(5))
							[ ] ReportStatus("Verify that split category button should be visible",PASS,"Split category button is visible for a detailed reminder")
							[ ] 
							[ ] 
							[ ] //Verify if Split dialog is opened
							[ ] DlgOptionalSetting.SplitCategoryButton.Click()
							[+] if(SplitTransaction.Exists(5))
								[ ] ReportStatus("Verify that split category window is opened",PASS,"Split category window is opened")
								[ ] 
								[ ] 
								[ ] 
								[ ] //Select first row of Listbox
								[ ] SplitTransaction.SetActive()
								[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select(1)
								[+] if(!SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.Exists(5))
									[ ] ReportStatus("Verify that First row of Split Transaction should not be editable",PASS,"Textfield not found hence First row of Split transaction listbox is not editable")
									[ ] 
									[ ] //Select second row of Listbox
									[ ] SplitTransaction.SetActive()
									[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select(2)
									[+] if(!SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.Exists(5))
										[ ] ReportStatus("Verify that second row of Split Transaction should not be editable",PASS,"Textfield not found hence second row of Split transaction listbox is not editable")
										[ ] 
										[ ] 
										[ ] //Select third row of Listbox
										[ ] SplitTransaction.SetActive()
										[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select(3)
										[+] if(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField3.Exists(5))
											[ ] ReportStatus("Verify that third row of Split Transaction should be editable",PASS,"Textfield found hence third row of Split transaction listbox is editable")
											[ ] 
											[ ] 
											[ ] SplitTransaction.Close()
											[ ] WaitForState(SplitTransaction,FALSE,5)
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Verify that third row of Split Transaction should be editable",FAIL,"Textfield not found hence third row of Split transaction listbox is not editable")
											[ ] 
										[ ] 
										[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify that second row of Split Transaction should not be editable",FAIL,"Textfield found hence second row of Split transaction listbox is editable")
										[ ] 
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify that First row of Split Transaction should not be editable",FAIL,"Textfield found hence First row of Split transaction listbox is editable")
									[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that split category window is opened",FAIL,"Split category window is not opened")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that split category button should not be visible",FAIL,"Split category button is visible for a detailed reminder")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] //Close Optional Settings dialog
						[ ] DlgOptionalSetting.CancelButton.Click()
						[ ] WaitForState(DlgOptionalSetting,FALSE,5)
						[ ] //Close AddEdit Reminder Dialog
						[ ] DlgAddEditReminder.CancelButton.Click()
						[ ] WaitForState(DlgAddEditReminder,FALSE,5)
						[ ] //Close Loan Details Dialog
						[ ] LoanDetails.Close()
						[ ] WaitForState(LoanDetails,FALSE,5)
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Add Reminder dialog is opened",FAIL,"Add Reminder dialog did not open")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan details window is open",FAIL,"Loan Details window did not open")
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
			[ ] ReportStatus("Add Manual loan account",FAIL,"Manual loan account not added")
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
[ ] //######################################################################################################################
[ ] 
[ ] 
[+] //###############  Verify that the first two rows of the splits for connected loan account register should be editable    ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_First_Two_Rows_Of_Splits_For_Connected_Loan_Register_Should_Be_Editable
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify that the first two rows of the splits for connected loan account register should be editable
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If first two rows of the splits for connected loan account register should be editable
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  14th Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test06_First_Two_Rows_Of_Splits_For_Connected_Loan_Register_Should_Be_Editable() appstate none
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sPayee,sIncrease,sEnter, sCategory
		[ ] LIST OF STRING lsLoanDetails
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[2]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] sCategory="Auto & Transport:Auto Insurance"
		[ ] sEnter="Enter"
		[ ] sPayee="Loan Payee 2"
		[ ] sIncrease="50"
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] ReportStatus("Verify if Quicken Window exists",PASS,"Quicken Window exists")
		[ ] 
		[ ] 
		[ ] 
		[+] //Add Split to Loan Reminder
			[ ] 
			[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] 
				[ ] //-----------------------Verification for Loan Register--------------------------
				[ ] 
				[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
				[ ] sleep(3)
				[ ] iValidate=ReminderOperations(sEnter,lsAddLoanAccount[1])
				[+] if(iValidate==PASS)
					[ ] 
					[ ] 
					[ ] 
					[ ] // Verfiy if split is editable
					[ ] 
					[ ] MDIClient.AccountRegister.TxList.TextClick(lsAddLoanAccount[1],2)
					[ ] 
					[ ] MDIClient.AccountRegister.TxList.TxToolBar.SplitButton.DoubleClick()
					[+] if(SplitTransaction.Exists(10))
						[ ] ReportStatus("Verify that split category window is opened",PASS,"Split category window is opened")
						[ ] 
						[ ] //Select first row of Listbox
						[ ] SplitTransaction.SetActive()
						[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select(1)
						[+] if(SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.Exists(5))
							[ ] ReportStatus("Verify that First row of Split Transaction should be editable",PASS,"Textfield found hence First row of Split transaction listbox is editable")
							[ ] 
							[ ] //Select second row of Listbox
							[ ] SplitTransaction.SetActive()
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select(2)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField2.TypeKeys(KEY_SHIFT_TAB)
							[ ] SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(sCategory)
							[ ] sActual=SplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.GetText()
							[ ] 
							[+] if(sActual==sCategory)
								[ ] ReportStatus("Verify that second row of Split Transaction should be editable",PASS,"Textfield found hence second row of Split transaction listbox is editable")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that Second row of Split Transaction should be editable",FAIL,"Textfield not found hence Second row of Split transaction listbox is NOT editable")
							[ ] SplitTransaction.SetActive()
							[ ] SplitTransaction.Close()
							[ ] WaitForState(SplitTransaction,FALSE,5)
							[ ] 
							[+] if(AlertMessage.Exists(5))
								[ ] AlertMessage.SetActive()
								[ ] AlertMessage.Yes.Click()
								[ ] WaitForState(AlertMessage , FALSE, 5)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that First row of Split Transaction should be editable",FAIL,"Textfield not found hence First row of Split transaction listbox is NOT editable")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that split category window is opened",FAIL,"Split category window is not opened")
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
				[+] else
					[ ] ReportStatus("Verify if Edit Reminder dialog is open",FAIL,"Edit Reminder dialog is NOT open")
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
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken window not found")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################################
[ ] 
[ ] 
[ ] //==========================================================================================
[ ] //===================  Add Loan Detail Validations test cases for Loans  ==================================
[ ] //==========================================================================================
[ ] 
[ ] 
[+] //##########################  Verify that the Opening balance accepts only numeric values  ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_02_03_Opening_Balance_Accepts_Only_Non_Zero_Numeric_Values
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that the Opening balance accepts only numeric values
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Opening balance accepts only numeric values
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  31st Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01_02_03_Opening_Balance_Accepts_Only_Non_Zero_Numeric_Values() appstate none
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
		[ ] STRING sDefaultBalance="0.00"
		[ ] STRING sActualBalance,sActualDate
		[ ] 
		[ ] STRING sAlphabet="ABCDE"
		[ ] STRING sSpecial="!@#$%^&"
		[ ] STRING sNumeric="15,789.125"
		[ ] STRING sValidMessage="Please enter a valid amount"
		[ ] 
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
		[ ] sDate=ModifyDate(0,sDateFormat)
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
			[ ] 
			[ ] //Add Loan account
			[ ] iValidate=AddCCBankLoanAccount(lsAddLoanAccount[1],lsAddLoanAccount[2])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Add CCBank loan account",PASS,"CCBank loan account is added")
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate =SelectAccountFromAccountBar(lsLoanDetails[1], ACCOUNT_PROPERTYDEBT)
				[+] if (iValidate==PASS)
					[ ] sleep(2)
					[ ] QuickenWindow.SetActive()
					[ ] MDIClientLoans.LoanWindow.AddLoanDetailsButton.Click()
					[+] if(LoanDetails.Exists(5))
						[ ] LoanDetails.SetActive()
						[ ] 
						[ ] 
						[ ] 
						[ ] // Verify that opening date should show date format
						[ ] LoanDetails.SetActive()
						[ ] LoanDetails.OpeningDateTextField.SetText("")
						[ ] LoanDetails.OpeningDateCalendarButton.Click()
						[ ] sActualDate = LoanDetails.OpeningDateTextField.GetText()
						[+] if(sActualDate==sDate)
							[ ] ReportStatus("Verify that date value and format matches current date",PASS,"Date value and format {sActualDate} matches current date {sDate}")
							[ ] 
							[ ] 
							[ ] 
							[ ] // Verify that opening balance should not accept alphabetical values
							[ ] LoanDetails.SetActive()
							[ ] LoanDetails.OriginalBalanceTextField.TypeKeys(sAlphabet)
							[ ] sActualBalance=NULL
							[ ] sActualBalance = LoanDetails.OriginalBalanceTextField.GetText()
							[+] if(sActualBalance==sDefaultBalance)
								[ ] ReportStatus("Verify that opening balance does not accept alphabetical values",PASS,"Opening balance does not accept alphabetical values")
								[ ] 
								[ ] 
								[ ] // Verify that opening balance should not accept special characters
								[ ] LoanDetails.SetActive()
								[ ] LoanDetails.OriginalBalanceTextField.TypeKeys(sSpecial)
								[ ] sActualBalance=NULL
								[ ] sActualBalance = LoanDetails.OriginalBalanceTextField.GetText()
								[+] if(sActualBalance==sDefaultBalance)
									[ ] ReportStatus("Verify that opening balance does not accept special characters",PASS,"Opening balance does not accept special characters")
									[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] // Verify that opening balance should accept decimal values
									[ ] LoanDetails.SetActive()
									[ ] LoanDetails.OriginalBalanceTextField.TypeKeys(sNumeric)
									[ ] sActualBalance=NULL
									[ ] sActualBalance = LoanDetails.OriginalBalanceTextField.GetText()
									[+] if(sActualBalance==sNumeric)
										[ ] ReportStatus("Verify that opening balance accepts decimal values",PASS,"Opening balance accepts decimal values")
										[ ] 
										[ ] 
										[ ] // Verify that opening balance should not accept blank value
										[ ] LoanDetails.SetActive()
										[ ] LoanDetails.OriginalBalanceTextField.SetText("")
										[ ] LoanDetails.NextButton.Click()
										[+] if(AlertMessage.Exists(5))
											[ ] sActual=AlertMessage.MessageText.GetCaption()
											[+] if(sActual==sValidMessage)
												[ ] ReportStatus("Verify Original balance message",PASS,"Correct message {sActual} displayed for Min original balance")
												[ ] AlertMessage.OK.Click()
												[ ] 
												[ ] 
											[+] else
												[ ] ReportStatus("Verify Original balance message",FAIL,"Wrong message {sActual} displayed for Min original balance")
												[ ] 
											[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Verify Alert message",FAIL,"Alert Message not displayed for wrong original balance")
											[ ] 
										[ ] 
										[ ] 
										[ ] 
										[ ] //Close Loan Details
										[ ] LoanDetails.Close()
										[ ] WaitForState(LoanDetails,FALSE,5)
										[+] if(AlertMessage.Exists(5))
											[ ] AlertMessage.OK.Click()
											[ ] WaitForState(AlertMessage,FALSE,5)
											[ ] 
										[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify that opening balance accepts decimal values",FAIL,"Opening balance does not accept decimal values")
										[ ] 
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify that opening balance does not accept special characters",FAIL,"Opening balance accepts special characters")
									[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that opening balance does not accept alphabetical values",FAIL,"Opening balance accepts alphabetical values")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that date value and format matches current date",FAIL,"Date value and format {sActualDate} does not match current date {sDate}")
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
						[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
						[ ] 
					[ ] //Fail condition
					[+] if(LoanDetails.Exists(5))
						[ ] LoanDetails.SetActive()
						[ ] LoanDetails.Close()
						[+] if(AlertMessage.Exists(5))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.OK.Click()
							[ ] sleep(2)
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Add CCBank loan account",FAIL,"CCBank loan account not added")
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
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //##########################  Verify that the Original Length field should not accept blank values ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_Original_Length_Does_Not_Accept_Blank_Values
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that the Original Length field should not accept blank values
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Original Length field does not accept blank values
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  3rd Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test04_Original_Length_Does_Not_Accept_Blank_Values() appstate none
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
		[ ] STRING sDefaultBalance="0.00"
		[ ] STRING sActualBalance,sActualDate
		[ ] 
		[ ] //STRING sNumeric="15,789.125"
		[ ] STRING sValidMessage="Please enter a number from -32767 to 32767."
		[ ] 
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
	[ ] iValidate=OpenDataFile(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate =SelectAccountFromAccountBar(lsLoanDetails[1], ACCOUNT_PROPERTYDEBT)
		[+] if (iValidate==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] MDIClientLoans.LoanWindow.AddLoanDetailsButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] // Verify that origianl length should not accept blank value
				[ ] LoanDetails.OriginalBalanceTextField.SetText(lsLoanDetails[3])
				[ ] LoanDetails.OriginalLengthTextField.SetText("")
				[ ] LoanDetails.NextButton.Click()
				[+] if(AlertMessage.Exists(5))
					[ ] sActual=AlertMessage.MessageText.GetCaption()
					[+] if(sActual==sValidMessage)
						[ ] ReportStatus("Verify Original balance message",PASS,"Correct message {sActual} displayed for blank original length")
						[ ] AlertMessage.OK.Click()
						[ ] 
						[ ] 
						[ ] //Close Loan Details
						[ ] LoanDetails.Close()
						[ ] WaitForState(LoanDetails,FALSE,5)
						[+] if(AlertMessage.Exists(5))
							[ ] AlertMessage.OK.Click()
							[ ] WaitForState(AlertMessage,FALSE,5)
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Original balance message",FAIL,"Wrong message {sActual} displayed for blank original length")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Alert message",FAIL,"Alert Message not displayed for wrong original balance")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
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
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //##################  Verify that values for Compounding Period field should be only selected from the dropdown #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_Verify_Values_For_Compounding_Period_Field_Should_Only_Be_From_Dropdown
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that the Opening balance accepts only numeric values
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Opening balance accepts only numeric values
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  31st Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test05_Verify_Values_For_Compounding_Period_Field_Should_Only_Be_From_Dropdown() appstate none
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
		[ ] LIST OF STRING lsCompoundingInterest
		[ ] 
		[ ] LIST OF STRING lsExpected={"Daily","Monthly","Semi-Annually"}
		[ ] 
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
	[ ] iValidate=OpenDataFile(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate =SelectAccountFromAccountBar(lsLoanDetails[1], ACCOUNT_PROPERTYDEBT)
		[+] if (iValidate==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] MDIClientLoans.LoanWindow.AddLoanDetailsButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] lsCompoundingInterest=LoanDetails.CompoundingPeriod.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsCompoundingInterest);i++)
					[ ] 
					[+] if(lsExpected[i]==lsCompoundingInterest[i])
						[ ] ReportStatus("Verify if the compounding period option is {lsCompoundingInterest[i]}",PASS,"The compounding period option is correct {lsCompoundingInterest[i]}")
						[ ] 
						[ ] 
						[ ] // Verify that origianl length should not accept blank value
						[ ] LoanDetails.OriginalBalanceTextField.SetText(lsLoanDetails[3])
						[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsLoanDetails[4])
						[ ] LoanDetails.OriginalLengthTextField.SetText(lsLoanDetails[5])
						[ ] LoanDetails.CompoundingPeriod.Select(lsCompoundingInterest[i])
						[ ] LoanDetails.NextButton.Click()
						[ ] 
						[ ] //Navigate back to previou page and verify content selected from "Compounding Interest" dropdown menu
						[ ] LoanDetails.BackButton.Click()
						[ ] sActual=LoanDetails.CompoundingPeriod.GetText()
						[+] if(sActual==lsCompoundingInterest[i])
							[ ] ReportStatus("Verify if the compounding period can be selected as {lsCompoundingInterest[i]}",PASS,"The compounding period is correctly selected as {sActual}")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if the compounding period can be selected as {lsCompoundingInterest[i]}",FAIL,"The compounding period is wrongly selected as {sActual}")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if the compounding period option is {lsCompoundingInterest[i]}",FAIL,"The compounding period option is wrong {lsCompoundingInterest[i]}")
						[ ] 
						[ ] 
				[ ] 
				[ ] 
				[ ] //Close Loan Details
				[ ] LoanDetails.Close()
				[ ] WaitForState(LoanDetails,FALSE,5)
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage,FALSE,5)
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
				[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
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
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //##################  Verify that values for Payment Schedule field should be only selected from the dropdown #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_Opening_Balance_Accepts_Only_Numeric_Values
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that values for Payment Schedule field should be only selected from the dropdown
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Opening balance accepts only numeric values
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  31st Jan 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test06_Verify_Values_For_Payment_Schedule_Field_Should_Only_Be_From_Dropdown() appstate none
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
		[ ] LIST OF STRING lsPaymentSchedule
		[ ] 
		[ ] LIST OF STRING lsExpected={"Annually","Twice per year","Quarterly","Every other month","Monthly","Twice per month","Every other week","Weekly","Other period"}
		[ ] 
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
	[ ] iValidate=OpenDataFile(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate =SelectAccountFromAccountBar(lsLoanDetails[1], ACCOUNT_PROPERTYDEBT)
		[+] if (iValidate==PASS)
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] MDIClientLoans.LoanWindow.AddLoanDetailsButton.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.SetActive()
				[ ] 
				[ ] 
				[ ] 
				[ ] lsPaymentSchedule=LoanDetails.PaymentScheduleComboBox.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsPaymentSchedule);i++)
					[ ] 
					[+] if(lsExpected[i]==lsPaymentSchedule[i])
						[ ] ReportStatus("Verify if the payment schedule option is {lsPaymentSchedule[i]}",PASS,"The payment schedule option is correct {lsPaymentSchedule[i]}")
						[ ] 
						[ ] 
						[ ] // Verify that origianl length should not accept blank value
						[ ] LoanDetails.OriginalBalanceTextField.SetText(lsLoanDetails[3])
						[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsLoanDetails[4])
						[ ] LoanDetails.OriginalLengthTextField.SetText(lsLoanDetails[5])
						[ ] LoanDetails.PaymentScheduleComboBox.Select(lsPaymentSchedule[i])
						[ ] LoanDetails.NextButton.Click()
						[ ] 
						[ ] //Navigate back to previou page and verify content selected from "Compounding Interest" dropdown menu
						[ ] LoanDetails.BackButton.Click()
						[ ] sActual=LoanDetails.PaymentScheduleComboBox.GetText()
						[+] if(sActual==lsPaymentSchedule[i])
							[ ] ReportStatus("Verify if the payment schedule can be selected as {lsPaymentSchedule[i]}",PASS,"The payment schedule is correctly selected as {sActual}")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if the payment schedule can be selected as {lsPaymentSchedule[i]}",FAIL,"The payment schedule is wrongly selected as {sActual}")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if the payment schedule option is {lsPaymentSchedule[i]}",FAIL,"The payment schedule option is wrong {lsPaymentSchedule[i]}")
						[ ] 
						[ ] 
				[ ] 
				[ ] 
				[ ] //Close Loan Details
				[ ] LoanDetails.Close()
				[ ] WaitForState(LoanDetails,FALSE,5)
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage,FALSE,5)
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
				[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
				[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
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
[ ] //##################################################################################################################
[ ] 
[ ] 
[ ] 
[ ] //==========================================================================================
[ ] //==============================  Full Payment Schedule  =========================================
[ ] //==========================================================================================
[ ] 
[ ] 
[+] //######### Verify that Full Payment schedule for manual  Loan account created in older version should be correctly displayed  ##############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_Full_Payment_Schedule_For_Manual_Loan_Migrated_Data_File
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Full Payment schedule for manual  Loan account created in 2013 should correctly displayed
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Full Payment schedule for manual  Loan account created in 2013 should correctly displayed
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  20th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01_Full_Payment_Schedule_For_Manual_Loan_Migrated_Data_File() appstate none
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] 
		[ ] //Put in Loop
		[ ] STRING sFileName="QW2013_MP"
		[ ] STRING sVersion="2013"
		[ ] 
		[ ] 
		[ ] STRING sSourceFile=AUT_DATAFILE_PATH+"\"+sLoanDataFolder+"\"+sFileName + ".QDF"
		[ ] STRING sDataFile=AUT_DATAFILE_PATH +"\" + sFileName + ".QDF"
		[ ] STRING sBackupFolder=AUT_DATAFILE_PATH+"\"+"Q13Files"
		[ ] 
		[ ] STRING sExpectedString="Set up</a> a scheduled bill or deposit."
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[2]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Open Older Data File and Convert to current edition
	[ ] 
	[ ] // //Copy Data File from folder
	[+] if(FileExists(sDataFile))
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] 
	[ ] //update due to change in DataFileConversion function
	[ ] sDataFile=AUT_DATAFILE_PATH +"\"
	[ ] 
	[ ] 
	[ ] iValidate=DataFileConversion(sFileName,sVersion,NULL,sDataFile)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Convert older data file with Manual loan account",PASS,"Data File with Manual loan account converted successfully")
		[ ] 
		[ ] //Verify that Loan Reminders payment option is checked in Loan Details>Loan Payment options window
		[ ] 
		[ ] iValidate=SelectAccountFromAccountBar(lsAddLoanAccount[1],ACCOUNT_PROPERTYDEBT)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] // Navigate to Payment Details tab
			[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
			[ ] ///To handle the payment details issue
			[ ]  QuickenRestoreAndResize()
			[ ] // Click on Full Payment Schedule button
			[ ] 
			[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.FullPaymentButton.Click()
			[+] if(LoanSchedule.Exists(5))
				[ ] ReportStatus("Verify if Loan Schedule window is opened",PASS,"Loan Schedule window is opened")
				[ ] 
				[ ] 
				[+] if(LoanSchedule.Done.Exists(5))
					[ ] ReportStatus("Verify if Done button exists on Loan Schedule window",PASS,"Done button exists on Loan Schedule window")
					[ ] 
					[ ] 
					[ ] 
					[+] if(LoanSchedule.ShowRunningBalance.Exists(5))
						[ ] ReportStatus("Verify if Show Running Balance checkbox exists on Loan Schedule window",PASS,"Show Running Balance checkbox exists on Loan Schedule window")
						[ ] 
						[ ] 
						[+] if(LoanSchedule.CurrentBalanceAmount.Exists(5))
							[ ] ReportStatus("Verify if Current Balance Amount exists on Loan Schedule window",PASS,"Current Balance Amount exists on Loan Schedule window")
							[ ] 
							[ ] 
							[+] if(LoanSchedule.RemainingPaymentAmount.Exists(5))
								[ ] ReportStatus("Verify if Remaining Payment Amount exists on Loan Schedule window",PASS,"Remaining Payment Amount exists on Loan Schedule window")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if Remaining Payment Amount exists on Loan Schedule window",FAIL,"Remaining Payment Amount does not exist on Loan Schedule window")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Current Balance Amount exists on Loan Schedule window",FAIL,"Current Balance Amount does not exist on Loan Schedule window")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Show Running Balance checkbox exists on Loan Schedule window",FAIL,"Show Running Balance checkbox does not exist on Loan Schedule window")
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Done button exists on Loan Schedule window",FAIL,"Done button does not exist on Loan Schedule window")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] LoanSchedule.Close()
				[ ] WaitForState(LoanSchedule,FALSE,5)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Loan Schedule window is opened",FAIL,"Loan Schedule window is NOT opened")
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
			[ ] ReportStatus("Open Manual loan account register",FAIL,"Manual loan account register opened")
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Convert older data file with Manual loan account",FAIL,"Data File with Manual loan account not converted")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################################
[ ] 
[ ] 
[+] //################ Verify that Full Payment Schedule gets updated correctly on editing the manual loan account #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_Verify_Full_Payment_Schedule_Gets_Updated_When_Manual_Loan_Account_Migrated_Data_File
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Full Payment Schedule gets updated correctly on editing the manual loan account in a migrated file
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  Full Payment Schedule gets updated correctly on editing the manual loan account
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test02_Verify_Full_Payment_Schedule_Gets_Updated_When_Manual_Loan_Account_Migrated_Data_File() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails 
		[ ] 
		[ ] STRING sFileName="QW2013_MP"
		[ ] 
		[ ] STRING sOriginalLength="4"
		[ ] STRING sOriginalYear=Str(val(FormatDateTime(GetDateTime(), "yyyy")) + val(sOriginalLength))
		[ ] 
		[ ] STRING sNewLength="8"
		[ ] STRING sNewYear=Str(val(FormatDateTime(GetDateTime(), "yyyy")) + val(sNewLength))
		[ ] 
		[ ] 
		[ ] STRING sOldInterestRate="5"
		[ ] STRING sNewInterestRate="6"
		[ ] 
		[ ] 
		[ ] //STRING sCurrentYear=GetDateTime
		[ ] 
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[1]
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
	[ ] iValidate=OpenDataFile(sFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate = SelectAccountFromAccountBar(lsAddLoanAccount[1], ACCOUNT_PROPERTYDEBT)
		[+] if (iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Edit details from Edit Terms button
			[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
			[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.SetActive()
				[ ] 
				[ ] LoanDetails.CurrentInterestRateTextField.SetText(sNewInterestRate)
				[ ] LoanDetails.OriginalLengthTextField.SetText(sNewLength)
				[ ] LoanDetails.TypeKeys(KEY_TAB)
				[ ] 
				[ ] LoanDetails.OKButton.Click()
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage,FALSE,5)
					[ ] 
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
				[ ] //Verify Changes reflected in Full Payment Schedule
				[ ] 
				[ ] 
				[ ] // Navigate to Payment Details tab
				[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
				[ ] 
				[ ] ///To handle the payment details issue
				[ ]  QuickenRestoreAndResize()
				[ ] // Click on Full Payment Schedule button
				[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.FullPaymentButton.Click()
				[+] if(LoanSchedule.Exists(5))
					[ ] ReportStatus("Verify if Loan Schedule window is opened",PASS,"Loan Schedule window is opened")
					[ ] 
					[ ] 
					[ ] sActual=LoanSchedule.PayOffDateText.GetText()
					[ ] bMatch=MatchStr("*{sNewYear}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if changing the duration of loan on Loan Details changes the payoff date on Full Payment schedule",PASS,"Changing the duration of loan on Loan Details {sNewYear} changes the payoff date on Full Payment schedule {sActual}")
						[ ] 
						[ ] sHandle=Str(LoanSchedule.QWListViewer.ListBox.GetHandle())
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,str(1))
						[ ] bMatch=MatchStr("*{sNewInterestRate}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if changing the Current Interest of loan on Loan Details changes the payoff date on Full Payment schedule",PASS,"Changing the Current Interest of loan {sNewInterestRate} on Loan Details changes the payoff date on Full Payment schedule {sActual}")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if changing the Current Interest of loan on Loan Details changes the payoff date on Full Payment schedule",FAIL,"Changing the Current Interest of loan {sNewInterestRate} on Loan Details does not change the payoff date on Full Payment schedule {sActual}")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if changing the duration of loan on Loan Details changes the payoff date on Full Payment schedule",FAIL,"Changing the duration of loan on Loan Details {sNewYear} does not change the payoff date on Full Payment schedule {sActual}")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] LoanSchedule.Close()
					[ ] WaitForState(LoanSchedule,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan Schedule window is opened",FAIL,"Loan Schedule window is NOT opened")
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
				[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
				[ ] 
			[ ] 
			[ ] 
			[ ] // Edit details from Edit Terms button
			[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
			[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.SetActive()
				[ ] 
				[ ] LoanDetails.CurrentInterestRateTextField.SetText(sOldInterestRate)
				[ ] LoanDetails.OriginalLengthTextField.SetText(sOriginalLength)
				[ ] LoanDetails.TypeKeys(KEY_TAB)
				[ ] 
				[ ] LoanDetails.OKButton.Click()
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage,FALSE,5)
					[ ] 
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // Navigate to Payment Details tab
				[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
				[ ] 
				[ ]  QuickenRestoreAndResize()
				[ ] // Click on Full Payment Schedule button
				[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.FullPaymentButton.Click()
				[+] if(LoanSchedule.Exists(5))
					[ ] ReportStatus("Verify if Loan Schedule window is opened",PASS,"Loan Schedule window is opened")
					[ ] 
					[ ] 
					[ ] sActual=LoanSchedule.PayOffDateText.GetText()
					[ ] bMatch=MatchStr("*{sOriginalYear}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if changing the duration of loan on Loan Details changes the payoff date on Full Payment schedule",PASS,"Changing the duration of loan on Loan Details {sOriginalYear} changes the payoff date on Full Payment schedule {sActual}")
						[ ] 
						[ ] sHandle=Str(LoanSchedule.QWListViewer.ListBox.GetHandle())
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,str(1))
						[ ] bMatch=MatchStr("*{sOldInterestRate}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if changing the Current Interest of loan on Loan Details changes the payoff date on Full Payment schedule",PASS,"Changing the Current Interest of loan {sOldInterestRate} on Loan Details changes the payoff date on Full Payment schedule {sActual}")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if changing the Current Interest of loan on Loan Details changes the payoff date on Full Payment schedule",FAIL,"Changing the Current Interest of loan {sOldInterestRate} on Loan Details does not change the payoff date on Full Payment schedule {sActual}")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if changing the duration of loan on Loan Details changes the payoff date on Full Payment schedule",FAIL,"Changing the duration of loan on Loan Details {sOriginalYear} does not change the payoff date on Full Payment schedule {sActual}")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] LoanSchedule.Close()
					[ ] WaitForState(LoanSchedule,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan Schedule window is opened",FAIL,"Loan Schedule window is NOT opened")
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
				[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
			[ ] 
			[+] 
				[ ] 
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Add CCBank loan account",FAIL,"CCBank loan account not added")
				[ ] // 
			[ ] // 
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
		[ ] 
	[ ] 
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //################  Verify that Full Payment schedule for manual Loan account should be correctly displayed. ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_Verify_Full_Payment_Schedule_Displayed_For_Manual_Loan_Account
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Full Payment schedule for manual Loan account should be correctly displayed
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Full Payment schedule for manual Loan account should be correctly displayed
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test03_Verify_Full_Payment_Schedule_Displayed_For_Manual_Loan_Account() appstate none
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
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[1]
		[ ] lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] // Copy autoapi dll for qwauto utility
		[ ] Setup_AutoApi()
		[ ] 
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
			[ ] 
			[ ] //Add Loan account
			[ ] iValidate=AddEditManualLoanAccount(sAddAction,lsAddLoanAccount[1],lsAddLoanAccount[2],lsAddLoanAccount[3],lsAddLoanAccount[4],lsAddLoanAccount[5],lsAddLoanAccount[6],lsAddLoanAccount[7])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account is added")
				[ ] 
				[ ] 
				[ ] iValidate = SelectAccountFromAccountBar(lsAddLoanAccount[1], ACCOUNT_PROPERTYDEBT)
				[+] if (iValidate==PASS)
					[ ] 
					[ ] 
					[ ] // Navigate to Payment Details tab
					[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
					[ ] 
					[ ] ///To handle the payment details issue
					[ ]  QuickenRestoreAndResize()
					[ ] // Click on Full Payment Schedule button
					[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.FullPaymentButton.Click()
					[+] if(LoanSchedule.Exists(5))
						[ ] ReportStatus("Verify if Loan Schedule window is opened",PASS,"Loan Schedule window is opened")
						[ ] 
						[ ] 
						[+] if(LoanSchedule.Done.Exists(5))
							[ ] ReportStatus("Verify if Done button exists on Loan Schedule window",PASS,"Done button exists on Loan Schedule window")
							[ ] 
							[ ] 
							[ ] 
							[+] if(LoanSchedule.ShowRunningBalance.Exists(5))
								[ ] ReportStatus("Verify if Show Running Balance checkbox exists on Loan Schedule window",PASS,"Show Running Balance checkbox exists on Loan Schedule window")
								[ ] 
								[ ] 
								[+] if(LoanSchedule.CurrentBalanceAmount.Exists(5))
									[ ] ReportStatus("Verify if Current Balance Amount exists on Loan Schedule window",PASS,"Current Balance Amount exists on Loan Schedule window")
									[ ] 
									[ ] 
									[+] if(LoanSchedule.RemainingPaymentAmount.Exists(5))
										[ ] ReportStatus("Verify if Remaining Payment Amount exists on Loan Schedule window",PASS,"Remaining Payment Amount exists on Loan Schedule window")
										[ ] 
										[ ] 
										[ ] 
										[ ] 
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify if Remaining Payment Amount exists on Loan Schedule window",FAIL,"Remaining Payment Amount does not exist on Loan Schedule window")
										[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if Current Balance Amount exists on Loan Schedule window",FAIL,"Current Balance Amount does not exist on Loan Schedule window")
									[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if Show Running Balance checkbox exists on Loan Schedule window",FAIL,"Show Running Balance checkbox does not exist on Loan Schedule window")
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Done button exists on Loan Schedule window",FAIL,"Done button does not exist on Loan Schedule window")
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] LoanSchedule.Close()
						[ ] WaitForState(LoanSchedule,FALSE,5)
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Loan Schedule window is opened",FAIL,"Loan Schedule window is NOT opened")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
					[ ] 
					[+] 
						[ ] 
						[ ] // 
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Add CCBank loan account",FAIL,"CCBank loan account not added")
						[ ] // 
					[ ] // 
					[ ] // 
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
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //################ Verify that Full Payment Schedule gets updated correctly on editing the manual loan account #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_Verify_Full_Payment_Schedule_Gets_Updated_When_Manual_Loan_Account
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Full Payment Schedule gets updated correctly on editing the manual loan account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Full Payment Schedule gets updated correctly on editing the manual loan account
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test04_Verify_Full_Payment_Schedule_Gets_Updated_When_Manual_Loan_Account() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails 
		[ ] 
		[ ] STRING sOriginalLength="4"
		[ ] STRING sOriginalYear=Str(val(FormatDateTime(GetDateTime(), "yyyy")) + val(sOriginalLength))
		[ ] 
		[ ] STRING sNewLength="8"
		[ ] STRING sNewYear=Str(val(FormatDateTime(GetDateTime(), "yyyy")) + val(sNewLength))
		[ ] 
		[ ] 
		[ ] STRING sOldInterestRate="5.0"
		[ ] STRING sNewInterestRate="6.0"
		[ ] 
		[ ] 
		[ ] //STRING sCurrentYear=GetDateTime
		[ ] 
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[1]
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
	[ ] iValidate=OpenDataFile(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate = SelectAccountFromAccountBar(lsAddLoanAccount[1], ACCOUNT_PROPERTYDEBT)
		[+] if (iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Edit details from Edit Terms button
			[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
			[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.SetActive()
				[ ] 
				[ ] LoanDetails.CurrentInterestRateTextField.SetText(sNewInterestRate)
				[ ] LoanDetails.OriginalLengthTextField.SetText(sNewLength)
				[ ] LoanDetails.TypeKeys(KEY_TAB)
				[ ] 
				[ ] LoanDetails.OKButton.Click()
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage,FALSE,5)
					[ ] 
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
				[ ] //Verify Changes reflected in Full Payment Schedule
				[ ] 
				[ ] 
				[ ] // Navigate to Payment Details tab
				[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
				[ ] ///To handle the payment details issue
				[ ]  QuickenRestoreAndResize()
				[ ] // Click on Full Payment Schedule button
				[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.FullPaymentButton.Click()
				[+] if(LoanSchedule.Exists(5))
					[ ] ReportStatus("Verify if Loan Schedule window is opened",PASS,"Loan Schedule window is opened")
					[ ] 
					[ ] 
					[ ] sActual=LoanSchedule.PayOffDateText.GetText()
					[ ] bMatch=MatchStr("*{sNewYear}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if changing the duration of loan on Loan Details changes the payoff date on Full Payment schedule",PASS,"Changing the duration of loan on Loan Details {sNewYear} changes the payoff date on Full Payment schedule {sActual}")
						[ ] 
						[ ] sHandle=Str(LoanSchedule.QWListViewer.ListBox.GetHandle())
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,str(2))
						[ ] bMatch=MatchStr("*{sNewInterestRate}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if changing the Current Interest of loan on Loan Details changes the payoff date on Full Payment schedule",PASS,"Changing the Current Interest of loan {sNewInterestRate} on Loan Details changes the payoff date on Full Payment schedule {sActual}")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if changing the Current Interest of loan on Loan Details changes the payoff date on Full Payment schedule",FAIL,"Changing the Current Interest of loan {sNewInterestRate} on Loan Details does not change the payoff date on Full Payment schedule {sActual}")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if changing the duration of loan on Loan Details changes the payoff date on Full Payment schedule",FAIL,"Changing the duration of loan on Loan Details {sNewYear} does not change the payoff date on Full Payment schedule {sActual}")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] LoanSchedule.Close()
					[ ] WaitForState(LoanSchedule,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan Schedule window is opened",FAIL,"Loan Schedule window is NOT opened")
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
				[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
				[ ] 
			[ ] 
			[ ] 
			[ ] // Edit details from Edit Terms button
			[ ] MDIClientLoans.LoanWindow.LoanDetails.Click()
			[ ] MDIClientLoans.LoanWindow.EditTerms.Click()
			[+] if(LoanDetails.Exists(5))
				[ ] LoanDetails.SetActive()
				[ ] 
				[ ] LoanDetails.CurrentInterestRateTextField.SetText(sOldInterestRate)
				[ ] LoanDetails.OriginalLengthTextField.SetText(sOriginalLength)
				[ ] LoanDetails.TypeKeys(KEY_TAB)
				[ ] 
				[ ] LoanDetails.OKButton.Click()
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage,FALSE,5)
					[ ] 
				[ ] WaitForState(LoanDetails,FALSE,5)
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // Navigate to Payment Details tab
				[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
				[ ] ///To handle the payment details issue
				[ ]  QuickenRestoreAndResize()
				[ ] // Click on Full Payment Schedule button
				[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.FullPaymentButton.Click()
				[+] if(LoanSchedule.Exists(5))
					[ ] ReportStatus("Verify if Loan Schedule window is opened",PASS,"Loan Schedule window is opened")
					[ ] 
					[ ] 
					[ ] sActual=LoanSchedule.PayOffDateText.GetText()
					[ ] bMatch=MatchStr("*{sOriginalYear}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if changing the duration of loan on Loan Details changes the payoff date on Full Payment schedule",PASS,"Changing the duration of loan on Loan Details {sOriginalYear} changes the payoff date on Full Payment schedule {sActual}")
						[ ] 
						[ ] sHandle=Str(LoanSchedule.QWListViewer.ListBox.GetHandle())
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,str(2))
						[ ] bMatch=MatchStr("*{sOldInterestRate}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if changing the Current Interest of loan on Loan Details changes the payoff date on Full Payment schedule",PASS,"Changing the Current Interest of loan {sOldInterestRate} on Loan Details changes the payoff date on Full Payment schedule {sActual}")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if changing the Current Interest of loan on Loan Details changes the payoff date on Full Payment schedule",FAIL,"Changing the Current Interest of loan {sOldInterestRate} on Loan Details does not change the payoff date on Full Payment schedule {sActual}")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if changing the duration of loan on Loan Details changes the payoff date on Full Payment schedule",FAIL,"Changing the duration of loan on Loan Details {sOriginalYear} does not change the payoff date on Full Payment schedule {sActual}")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] LoanSchedule.Close()
					[ ] WaitForState(LoanSchedule,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan Schedule window is opened",FAIL,"Loan Schedule window is NOT opened")
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
				[ ] ReportStatus("Verify LoanDetails dialog. ", FAIL , " LoanDetails dialog didn't appear.") 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
			[ ] 
			[+] 
				[ ] 
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Add CCBank loan account",FAIL,"CCBank loan account not added")
				[ ] // 
			[ ] // 
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
		[ ] 
	[ ] 
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //########################  Verify that on clicking Loan Details link, D1 / DM1 screen should open ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_Verify_Clicking_On_Loan_Details_Link_Should_Open_Loan_Details_Window
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that on clicking Loan Details link, D1 / DM1 screen should open
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If clicking Loan Details link, launches D1 / DM1 screen
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test05_Verify_Clicking_On_Loan_Details_Link_Should_Open_Loan_Details_Window() appstate none
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
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[1]
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
	[ ] iValidate=OpenDataFile(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate = SelectAccountFromAccountBar(lsAddLoanAccount[1], ACCOUNT_PROPERTYDEBT)
		[+] if (iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] // Navigate to Payment Details tab
			[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
			[ ] ///To handle the payment details issue
			[ ]  QuickenRestoreAndResize()
			[ ] // Click on Full Payment Schedule button
			[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.FullPaymentButton.Click()
			[+] if(LoanSchedule.Exists(5))
				[ ] ReportStatus("Verify if Loan Schedule window is opened",PASS,"Loan Schedule window is opened")
				[ ] 
				[ ] LoanSchedule.SetActive()
				[ ] 
				[ ] //Verify Loan Details Link
				[ ] LoanSchedule.LoanDetailsLinkPanel.TextClick("Loan Details")
				[+] if(LoanDetails.Exists(5))
					[ ] 
					[ ] //Loan Name
					[+] if(LoanDetails.LoanNameTextField.Exists(2))
						[ ] ReportStatus("Verify Loan Name Text field",PASS,"Loan name text field found")
						[ ] 
						[ ] 
						[ ] //Opening Date
						[+] if(LoanDetails.OpeningDateTextField.Exists(2))
							[ ] ReportStatus("Verify Opening Date Text field",PASS,"Opening Date text field found")
							[ ] 
							[ ] //Original Balance
							[+] if(LoanDetails.OriginalBalanceTextField.Exists(2))
								[ ] ReportStatus("Verify Original Balance Text Field",PASS,"Original Balance Text Field found")
								[ ] 
								[ ] 
								[ ] //Current Interest Rate
								[+] if(LoanDetails.CurrentInterestRateTextField.Exists(2))
									[ ] ReportStatus("Verify Current Interest Rate Text Field",PASS,"Current Interest Rate Text Field found")
									[ ] 
									[ ] 
									[ ] //Original Length Rate
									[+] if(LoanDetails.OriginalLengthTextField.Exists(2))
										[ ] ReportStatus("Verify Original Length Text Field",PASS,"Original Length Text Field found")
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Original Length Text Field",FAIL,"Original Length Text Field not found")
										[ ] 
										[ ] 
										[ ] 
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Current Interest Rate Text Field",FAIL,"Current Interest Rate Text Field not found")
									[ ] 
									[ ] 
									[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Original Balance Text Field",FAIL,"Original Balance Text Field not found")
								[ ] 
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Opening Date Text field",FAIL,"Opening Date text field not found")
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Loan Name Text field",FAIL,"Loan name text field not found")
						[ ] 
						[ ] 
					[ ] 
					[ ] LoanDetails.Close()
					[ ] WaitForState(LoanDetails,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify loan details window open",FAIL,"Loan details window did not open")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] //Verify Loan Details Link
				[ ] LoanSchedule.LoanDetailsLinkPanel.TextClick("Loan Payment")
				[+] if(LoanDetails.Exists(5))
					[ ] 
					[+] if(LoanDetails.NextPaymentDueTextField.Exists(5))
						[ ] ReportStatus("Verify Next Payment Due Text Field",PASS,"Next Payment Due Text Field found")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Next Payment Due Text Field",FAIL,"Next Payment Due Text Field NOT found")
						[ ] 
					[ ] 
					[ ] LoanDetails.Close()
					[ ] WaitForState(LoanDetails,FALSE,5)
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify loan details window open",FAIL,"Loan details window did not open")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] LoanSchedule.Close()
				[ ] WaitForState(LoanSchedule,FALSE,5)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Loan Schedule window is opened",FAIL,"Loan Schedule window is NOT opened")
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
			[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
			[ ] 
			[+] 
				[ ] 
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Add CCBank loan account",FAIL,"CCBank loan account not added")
				[ ] // 
			[ ] // 
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
		[ ] 
	[ ] 
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //#################  Verify that Payoff Date on Full Payment Schedule and on Dashboard should be same #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_PayOff_Date_On_Full_Payment_Schedule_And_Dashboard_Should_Match
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Payoff Date on Full Payment Schedule and on Dashboard should be same
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Payoff Date on Full Payment Schedule and on Dashboard are the same
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  18th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test06_PayOff_Date_On_Full_Payment_Schedule_And_Dashboard_Should_Match() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails 
		[ ] STRING sActualMonth,sActualYear,sActual
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[1]
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
	[ ] iValidate=OpenDataFile(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] 
		[ ] iValidate = SelectAccountFromAccountBar(lsAddLoanAccount[1], ACCOUNT_PROPERTYDEBT)
		[+] if (iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] // Navigate to Payment Details tab
			[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
			[ ] ///To handle the payment details issue
			[ ]  QuickenRestoreAndResize()
			[ ] //Verify PayOff Date value on Dashboard
			[ ] 
			[ ] sActualMonth=MDIClientLoans.LoanWindow.PayOffMonthText.GetText()
			[ ] sActualYear=MDIClientLoans.LoanWindow.PayOffYearText.GetText()
			[ ] 
			[ ] //Verify PayOff Date value on Loan Schedule window
			[ ] // Click on Full Payment Schedule button
			[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.FullPaymentButton.Click()
			[+] if(LoanSchedule.Exists(5))
				[ ] ReportStatus("Verify if Loan Schedule window is opened",PASS,"Loan Schedule window is opened")
				[ ] 
				[ ] LoanSchedule.SetActive()
				[ ] // Get Remaining payment amount from Loan Schedule amount
				[ ] 
				[ ] sActual=LoanSchedule.PayOffDateText.GetText()
				[ ] bMatch=MatchStr("*{sActualMonth}*{sActualYear}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify that Payoff Date on Full Payment Schedule and on Dashboard should be same",PASS,"Payoff Date on Full Payment Schedule {sActualMonth},{sActualYear} and on Dashboard {sActual} match")
					[ ] 
					[ ] 
					[ ] LoanSchedule.Close()
					[ ] WaitForState(LoanSchedule,FALSE,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that Payoff Date on Full Payment Schedule and on Dashboard should be same",FAIL,"Payoff Date on Full Payment Schedule {sActualMonth},{sActualYear} and on Dashboard {sActual} DO NOT match")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Loan Schedule window is opened",FAIL,"Loan Schedule window is NOT opened")
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
			[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
			[ ] 
			[+] 
				[ ] 
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Add CCBank loan account",FAIL,"CCBank loan account not added")
				[ ] // 
			[ ] // 
			[ ] // 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //#######################  Verify that Remaining Payment  values should display correctly #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_Remaining_Payment_Values_Should_Display_Correctly
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Remaining Payment  values should display correctly
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Remaining Payment  values display correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  18th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test07_Remaining_Payment_Values_Should_Display_Correctly() appstate none
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
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] lsAddLoanAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] // Copy autoapi dll for qwauto utility
		[ ] Setup_AutoApi()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=OpenDataFile(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] 
		[ ] iValidate = SelectAccountFromAccountBar(lsAddLoanAccount[1], ACCOUNT_PROPERTYDEBT)
		[+] if (iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] // Navigate to Payment Details tab
			[ ] MDIClientLoans.LoanWindow.PaymentDetails.Click()
			[ ] ///To handle the payment details issue
			[ ]  QuickenRestoreAndResize()
			[ ] //Verify Remaining Payment value on Dashboard
			[ ] 
			[ ] sActual=MDIClientLoans.LoanWindow.RemainingPaymentAmount.GetText()
			[+] if(sActual==lsAddLoanAccount[8])
				[ ] ReportStatus("Verify Remaining payment amount on Loan Dashboard",PASS,"Remaining payment amount on Loan Dashboard {sActual} is as expected : {lsAddLoanAccount[8]}")
				[ ] 
				[ ] //Verify Remaining Payment value on Loan Schedule window
				[ ] // Click on Full Payment Schedule button
				[ ] MDIClientLoans.LoanWindow.PaymentDetailsPanel.FullPaymentButton.Click()
				[+] if(LoanSchedule.Exists(5))
					[ ] ReportStatus("Verify if Loan Schedule window is opened",PASS,"Loan Schedule window is opened")
					[ ] 
					[ ] LoanSchedule.SetActive()
					[ ] // Get Remaining payment amount from Loan Schedule amount
					[ ] sActual=NULL
					[ ] sActual=LoanSchedule.RemainingPaymentAmount.GetText()
					[+] if(sActual==lsAddLoanAccount[8])
						[ ] ReportStatus("Verify Remaining payment amount on Loan Schedule window",PASS,"Remaining payment amount on Loan Schedule window {sActual} is as expected : {lsAddLoanAccount[8]}")
						[ ] 
						[ ] LoanSchedule.Close()
						[ ] WaitForState(LoanSchedule,FALSE,5)
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Remaining payment amount on Loan Schedule window",FAIL,"Remaining payment amount on Loan Schedule window {sActual} is NOT as expected : {lsAddLoanAccount[8]}")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan Schedule window is opened",FAIL,"Loan Schedule window is NOT opened")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Remaining payment amount on Loan Dashboard",FAIL,"Remaining payment amount on Loan Dashboard {sActual} is NOT as expected : {lsAddLoanAccount[8]}")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[ ] 
[ ] //==========================================================================================
[ ] //=================================  Loan Details tab  ===========================================
[ ] //==========================================================================================
[ ] 
[ ] 
[ ] 
[+] //#######################  Verify that  'Loan Details (minimal)' tab get launched  ##############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_Loan_Details_Minimal_View_Tab_Should_Be_Launched
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Loan Details (minimal)' tab get launched
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If 'Loan Details (minimal)' tab get launched
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  21st Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01_Loan_Details_Minimal_View_Tab_Should_Be_Launched() appstate none
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
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sMinimalViewSheet)
		[ ] lsFileData=lsExcelData[1]
		[ ] 
		[ ] STRING sAccountName=lsFileData[2]
		[ ] STRING sFIName=lsFileData[3]
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
	[ ] AddCCBankLoanAccount(sCCBankUserName,sCCBankPassword)
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
			[ ] //Add Online Loan account
			[ ] iValidate=AddCCBankLoanAccount(sCCBankUserName,sCCBankPassword)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Add CCBank loan account",PASS,"CCBank loan account is added")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=SelectAccountFromAccountBar(lsLoanDetails[1],ACCOUNT_PROPERTYDEBT)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Open Online loan account register",PASS,"Online loan account {lsLoanDetails[1]} found in Account Bar")
					[ ] 
					[ ] 
					[ ] //Verify FI Name
					[ ] STRING sActualName=MDIClientLoans.LoanWindow.FINameText.GetCaption()
					[+] if(sActualName==sFIName)
						[ ] ReportStatus("Verify if correct FI name is displayed",PASS,"Correct FI name is displayed {sActualName}")
						[ ] 
						[ ] 
						[ ] // Verify Loan Details window
						[+] if(MDIClientLoans.LoanWindow.AddLoanDetailsButton.Exists(5))
							[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",PASS,"Add Loan Details button is present")
							[ ] 
							[ ] // Verify Add Linked Asset Account window
							[+] if(MDIClientLoans.LoanWindow.AddLinkedAssetAccount.Exists(5))
								[ ] ReportStatus("Verify if Add Linked Asset Account button is present on connected loan account dashboard",PASS,"Add Linked Asset Account button is present")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",FAIL,"Add Loan Details button is not found in Online account minimal view")
								[ ] 
								[ ] 
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",FAIL,"Add Loan Details button is not found in Online account minimal view")
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if correct FI name is displayed",FAIL,"Wrong FI name is displayed {sActualName}")
						[ ] 
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
			[+] else
				[ ] ReportStatus("Add CCBank loan account",FAIL,"CCBank loan account not added")
				[ ] 
		[+] else
			[ ] ReportStatus("Add Manual spending account",FAIL,"Manual Spending account is not added")
			[ ] 
			[ ] 
		[ ] 
		[ ] // 
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
[ ] //###################################################################################################################
[ ] 
[ ] 
[+] //########## Verify that Action menu items functionality works on 'Loan Dashboard' when 'Loan Details' (minimal) tab is displayed #########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_Verify_Action_Menu_Items_Functionality_From_Loan_Dashboard
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Full Payment Schedule gets updated correctly on editing the manual loan account in a migrated file
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If  Full Payment Schedule gets updated correctly on editing the manual loan account
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test02_Verify_Action_Menu_Items_Functionality_From_Loan_Dashboard() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails
		[ ] STRING sValidationText
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sMinimalViewSheet)
		[ ] lsFileData=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
		[ ] lsLoanDetails=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] iValidate = SelectAccountFromAccountBar(lsLoanDetails[1], ACCOUNT_PROPERTYDEBT)
		[+] if (iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[+] ///##########Verifying Acount Actions> Set Up Online#####////
				[ ] QuickenWindow.SetActive()
				[ ] sValidationText="Online Update for this account"
				[ ] NavigateToAccountActionBanking(2)
				[+] if (OnlineUpdateAccount.Exists(4))
					[ ] OnlineUpdateAccount.SetActive()
					[ ] sActual=OnlineUpdateAccount.GetProperty("Caption")
					[+] if (sActual==sValidationText)
						[ ] ReportStatus("Verify Account Actions", PASS, "Verify Account Actions> Update Now Dialog {sActual} displayed as expected {sValidationText}")
					[+] else
						[ ] ReportStatus("Verify Account Actions", FAIL, "Verify Account Actions> Update Now Dialog {sActual} NOT displayed as expected {sValidationText}")
					[ ] OnlineUpdateAccount.Cancel.Click()
					[ ] WaitForState(OneStepUpdate,FALSE,3)
				[+] else
					[ ] ReportStatus("Verify Dialog Online Update Account", FAIL, "Verify Online Update Account Dialog :  Online Update Account Dialog didn't appear.")
			[ ] 
			[ ] 
			[+] ///##########Verifying Acount Actions> Edit Account Details#####////  
				[ ] QuickenWindow.SetActive()
				[ ] sValidationText="Account Details"
				[ ] NavigateToAccountActionBanking(3)
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
			[+] ///##########Verifying Acount Actions> Account Attachments #####////  
				[ ] QuickenWindow.SetActive()
				[ ] sValidationText="Account Attachments: {lsLoanDetails[1]}"
				[ ] NavigateToAccountActionBanking(5)
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
			[+] ///##########Verifying Acount Actions> Account Overview #####////  
				[ ] QuickenWindow.SetActive()
				[ ] sValidationText="Account Overview: {lsLoanDetails[1]}"
				[ ] NavigateToAccountActionBanking(6)
				[+] if (DlgAccountOverview.Exists(4))
					[ ] DlgAccountOverview.SetActive()
					[ ] sActual=DlgAccountOverview.GetProperty("Caption")
					[+] if (sActual==sValidationText)
						[ ] ReportStatus("Verify Account Overview", PASS, "Verify Account Actions> Account Overview option: Dialog {sActual} displayed as expected {sValidationText}.")
					[+] else
						[ ] ReportStatus("Verify Account Overview", FAIL, "Verify Account Actions> Account Overview option: Dialog {sActual} did not display as expected {sValidationText}.")
					[ ] DlgAccountOverview.TypeKeys(KEY_EXIT)
					[ ] WaitForState(DlgAccountOverview,FALSE,1)
				[+] else
					[ ] ReportStatus("Verify Account Overview ", FAIL, "Verify Dialog Account Overview : Account Overview Dialog didn't appear.")
			[ ] 
			[ ] 
			[ ] 
			[+] ///##########Verifying Acount Actions> Customize Action Bar#####////  
				[ ] QuickenWindow.SetActive()
				[ ] sValidationText="Customize Action Bar"
				[ ] NavigateToAccountActionBanking(7)
				[+] if (DlgCustomizeActionBar.Exists(5))
					[ ] DlgCustomizeActionBar.SetActive()
					[ ] sActual=DlgCustomizeActionBar.GetProperty("Caption")
					[+] if (sActual==sValidationText)
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
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
			[ ] 
			[+] 
				[ ] 
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Add CCBank loan account",FAIL,"CCBank loan account not added")
				[ ] // 
			[ ] // 
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists.", FAIL, "Quicken does not exist.") 
		[ ] 
	[ ] 
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //################# Verify that 'Add Linked Asset Account' button functionality works on 'Loan Details (minimal)' tab #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_Verify_Add_Linked_Asset_Account_Button_Functionality_From_Loan_Details_No_Asset_Account
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Add Linked Asset Account' button functionality works on 'Loan Details (minimal)' tab when no asset account is added to data file
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If 'Add Linked Asset Account' button functionality works on 'Loan Details (minimal)' tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test03_Verify_Add_Linked_Asset_Account_Button_Functionality_From_Loan_Details_No_Asset_Account() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails
		[ ] STRING sValidationText
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sMinimalViewSheet)
		[ ] lsFileData=lsExcelData[1]
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
		[ ] lsLoanDetails=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] // Before adding asset account
		[ ] iValidate = SelectAccountFromAccountBar(lsLoanDetails[1], ACCOUNT_PROPERTYDEBT)
		[+] if (iValidate==PASS)
			[ ] 
			[ ] // Verify Add Linked Asset Account window
			[+] if(MDIClientLoans.LoanWindow.AddLinkedAssetAccount.Exists(5))
				[ ] ReportStatus("Verify if Add Linked Asset Account button is present on connected loan account dashboard",PASS,"Add Linked Asset Account button is present")
				[ ] 
				[ ] 
				[+] for(i=1;i<=4;i++)
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] MDIClientLoans.LoanWindow.AddLinkedAssetAccount.Click()
					[ ] 
					[ ] MDIClientLoans.LoanWindow.AddLinkedAssetAccount.TypeKeys(Replicate(KEY_DN,i))
					[ ] MDIClientLoans.LoanWindow.AddLinkedAssetAccount.TypeKeys(KEY_ENTER)
					[ ] 
					[ ] 
					[ ] 
					[ ] // Verify that options Home,Vehicle and Asset account should be present
					[+] if(i<4)
						[+] if(AddAnyAccount.Exists(5))
							[ ] 
							[ ] STRING sActual=AddAnyAccount.AccountName.GetText()
							[+] if(sActual==lsLinkedAccounts[i])
								[ ] ReportStatus("Verify if correct Asset account window opens",PASS,"Correct Asset account window {sActual} opens")
								[ ] 
								[ ] AddAnyAccount.Close()
								[ ] WaitForState(AddAnyAccount,FALSE,5)
								[ ] 
							[+] else
								[ ] 
								[ ] ReportStatus("Verify if correct Asset account window opens",FAIL,"Wrong Asset account window {sActual} opens for {lsLinkedAccounts[i]}")
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Add an Account window opens",FAIL,"Add An Account window did not open")
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] // Verify that Existing Asset account should not be displayed
					[+] if(i==4)
						[+] if(AddAnyAccount.Exists(5))
							[ ] 
							[ ] sActual=AddAnyAccount.AccountName.GetText()
							[+] if(sActual==lsLinkedAccounts[1])
								[ ] ReportStatus("Verify if correct Asset account window opens",PASS,"Correct Asset account window {sActual} opens")
								[ ] 
								[ ] AddAnyAccount.Close()
								[ ] WaitForState(AddAnyAccount,FALSE,5)
								[ ] 
							[+] else
								[ ] 
								[ ] ReportStatus("Verify if correct Asset account window opens",FAIL,"Wrong Asset account window {sActual} opens for {lsLinkedAccounts[1]}")
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify if Add an Account window opens",FAIL,"Add An Account window did not open")
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
				[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",FAIL,"Add Loan Details button is not found in Online account minimal view")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
			[ ] 
			[+] 
				[ ] 
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Add CCBank loan account",FAIL,"CCBank loan account not added")
				[ ] // 
			[ ] // 
			[ ] // 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists.", FAIL, "Quicken does not exist.") 
		[ ] 
	[ ] 
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //################# Verify that 'Add Linked Asset Account' button functionality works on 'Loan Details (minimal)' tab #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_Verify_Add_Linked_Asset_Account_Button_Functionality_From_Loan_Details_Asset_Account
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Add Linked Asset Account' button functionality works on 'Loan Details (minimal)' tab when asset account is added
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If 'Add Linked Asset Account' button functionality works on 'Loan Details (minimal)' tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test04_Verify_Add_Linked_Asset_Account_Button_Functionality_From_Loan_Details_Asset_Account() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails,lsVehicleAccount
		[ ] //STRING sValidationText
		[ ] STRING sLoanBalance,sAssetValue,sCurrentEquityValue
		[ ] NUMBER nLoanBalance , nAssetValue ,nCurrentEquityValue
		[ ] 
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // Read asset account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sAssetAccountSheet)
		[ ] lsVehicleAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
		[ ] lsLoanDetails=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] // Add an asset account (Car Asset)
		[ ] iValidate=AddPropertyAccount(lsVehicleAccount[1],lsVehicleAccount[2],lsVehicleAccount[3],lsVehicleAccount[4],lsVehicleAccount[5],lsVehicleAccount[6],lsVehicleAccount[7])
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // After adding asset account
			[ ] iValidate = SelectAccountFromAccountBar(lsLoanDetails[1], ACCOUNT_PROPERTYDEBT)
			[+] if (iValidate==PASS)
				[ ] 
				[ ] 
				[ ] // Retrieve Loan Balance from Dashboard
				[ ] sLoanBalance=MDIClientLoans.LoanWindow.LoanBalanceAmount.GetCaption()
				[ ] nLoanBalance = VAL(StrTran(sLoanBalance ,"," ,""))
				[ ] // Get Asset Value from excel data
				[ ] sAssetValue=lsVehicleAccount[5]
				[ ] nAssetValue = VAL(sAssetValue)
				[ ] 
				[ ] 
				[ ] // Calculate current equity value that is expected on Dashboard
				[ ] nCurrentEquityValue =nAssetValue - nLoanBalance
				[ ] sCurrentEquityValue =trim(Str(nCurrentEquityValue ,4 ,2))
				[ ] // sCurrentEquityValue=Str(val(StrTran(sAssetValue,",","")-val(sLoanBalance)),NULL,2)
				[ ] 
				[ ] 
				[ ] // Verify Add Linked Asset Account windows
				[+] if(MDIClientLoans.LoanWindow.AddLinkedAssetAccount.Exists(5))
					[ ] ReportStatus("Verify if Add Linked Asset Account button is present on connected loan account dashboard",PASS,"Add Linked Asset Account button is present")
					[ ] 
					[ ] 
					[+] for(i=1;i<=4;i++)
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] 
						[ ] MDIClientLoans.LoanWindow.AddLinkedAssetAccount.Click()
						[ ] 
						[ ] MDIClientLoans.LoanWindow.AddLinkedAssetAccount.TypeKeys(Replicate(KEY_DN,i))
						[ ] MDIClientLoans.LoanWindow.AddLinkedAssetAccount.TypeKeys(KEY_ENTER)
						[ ] 
						[ ] 
						[ ] 
						[ ] // Verify Add Linked Asset Account options
						[+] if(i<4)
							[+] if(AddAnyAccount.Exists(5))
								[ ] 
								[ ] STRING sActual=AddAnyAccount.AccountName.GetText()
								[+] if(sActual==lsLinkedAccounts[i])
									[ ] ReportStatus("Verify if correct Asset account window opens",PASS,"Correct Asset account window {sActual} opens")
									[ ] 
									[ ] AddAnyAccount.Close()
									[ ] WaitForState(AddAnyAccount,FALSE,5)
									[ ] 
								[+] else
									[ ] 
									[ ] ReportStatus("Verify if correct Asset account window opens",FAIL,"Wrong Asset account window {sActual} opens for {lsLinkedAccounts[i]}")
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if Add an Account window opens",FAIL,"Add An Account window did not open")
								[ ] 
								[ ] 
								[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] // Verify Existing Asset Account option
						[+] if(i==4)
							[ ] 
							[ ] 
							[ ] //Use TypeKeys to select asset account for linking
							[ ] MDIClientLoans.LoanWindow.AddLinkedAssetAccount.TypeKeys(KEY_ENTER)
							[ ] //Verify if loan account linked to asset account from Loan Details tab
							[+] if(MDIClientLoans.LoanWindow.EquityLinkedToAssetAmount.Exists(5))
								[ ] ReportStatus("Verify Equity Linked To Asset Amount displayed on Dashboard",PASS,"Equity Linked To Asset Amount displayed on Dashboard")
								[ ] 
								[ ] // Verify if calculation on loan dashboard is correct
								[ ] sActual=MDIClientLoans.LoanWindow.EquityLinkedToAssetAmount.GetCaption()
								[ ] //Remove all commas in amount displayed on loan dashboard
								[ ] sActual=StrTran(sActual,",","")              
								[ ] bMatch=MatchStr("*{sCurrentEquityValue}*",sActual)
								[+] if(bMatch==TRUE)
									[ ] ReportStatus("Verify Equity Linked To Asset Amount",PASS,"Equity Linked To Asset Amount displayed on Loan Dashboard {sActual} is as expected {sCurrentEquityValue} ")
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Equity Linked To Asset Amount",FAIL,"Equity Linked To Asset Amount displayed on Loan Dashboard {sActual} is as NOT as expected {sCurrentEquityValue} ")
									[ ] 
									[ ] 
							[+] else
								[ ] ReportStatus("Verify Equity Linked To Asset Amount displayed on Dashboard",FAIL,"Equity Linked To Asset Amount is not displayed on Dashboard")
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
					[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",FAIL,"Add Loan Details button is not found in Online account minimal view")
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
				[ ] // 
			[+] else
				[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
				[ ] 
				[+] 
					[ ] 
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Add CCBank loan account",FAIL,"CCBank loan account not added")
					[ ] // 
				[ ] // 
				[ ] // 
			[ ] // 
		[+] else
			[ ] ReportStatus("Verify if asset account is added",FAIL,"Error while adding asset account")
			[ ] 
		[ ] 
		[ ] // 
		[ ] // 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists.", FAIL, "Quicken does not exist.") 
		[ ] 
	[ ] 
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //################# Verify that 'Add Linked Asset Account' button functionality works on 'Loan Details (minimal)' tab #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_Verify_Add_Linked_Asset_Account_Button_Functionality_From_Loan_Details_Multiple_Asset_Accounts
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Add Linked Asset Account' button functionality works on 'Loan Details (minimal)' tab when asset account is added
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If 'Add Linked Asset Account' button functionality works on 'Loan Details (minimal)' tab
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test05_Verify_Add_Linked_Asset_Account_Button_Functionality_From_Loan_Details_Multiple_Asset_Accounts() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails
		[ ] 
		[ ] STRING sLoanBalance,sAssetValue,sCurrentEquityValue
		[ ] 
		[ ] STRING sAssetAccountText="Add linked asset account"
		[ ] NUMBER nLoanBalance , nAssetValue ,nCurrentEquityValue ,nToatalLoanBalance
		[ ] // //Read property account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sAssetAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=DataFileCreate(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Create Data File",PASS,"Data File created successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=AddPropertyAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],lsAddAccount[4],lsAddAccount[5],lsAddAccount[6],lsAddAccount[7])
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Add Loan Account
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
			[+] if (AddAccount.Exists(30))
				[ ] AddAccount.SetActive()
				[ ] AddAccount.Loan.Click()
				[+] if(AddAnyAccount.Exists(700) && AddAnyAccount.IsEnabled())
					[ ] AddAnyAccount.VerifyEnabled(TRUE,150)
					[ ] AddAnyAccount.SetActive()
				[ ] AddAnyAccount.BankName.TypeKeys(sBankName) 
				[ ] AddAnyAccount.Next.Click()
				[ ] 
				[ ] WaitForstate(AddAnyAccount.BankUserID,TRUE,200)
				[ ] AddAnyAccount.SetActive ()
				[ ] AddAnyAccount.BankUserID.SetText(sCCBankUserName)     
				[ ] AddAnyAccount.BankPassword.SetText(sCCBankPassword)
				[ ] 
				[+] if(AddAnyAccount.Next.IsEnabled() == TRUE)		
					[ ] 
					[ ] 
					[ ] AddAnyAccount.Next.Click ()
					[ ] WaitForstate(AddAnyAccount.ListBox , TRUE ,300)
					[ ] 
					[ ] 
					[ ] AddAnyAccount.SetActive()
					[ ] AddAnyAccount.Next.Click ()
					[ ] 
					[+] if(AccountAdded.Exists(140))
						[ ] 
						[ ] 
						[ ] // Link first account
						[ ] AccountAdded.SetActive()
						[ ] AccountAdded.TextClick(sAssetAccountText)
						[ ] AccountAdded.TypeKeys(Replicate(KEY_DN,4))
						[ ] AccountAdded.TypeKeys(KEY_ENTER)
						[ ] AccountAdded.TypeKeys(KEY_RT)
						[ ] AccountAdded.TypeKeys(KEY_ENTER)
						[ ] 
						[ ] // Link second account
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
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] // Read manual loan account data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
						[ ] // Get Asset Value from excel data
						[ ] sAssetValue=lsAddAccount[5]
						[ ] nAssetValue = VAL(sAssetValue)
						[ ] nToatalLoanBalance=0
						[ ] 
						[+] for(iCount=1;iCount<=ListCount(lsExcelData)-2;iCount++)
							[ ] lsLoanDetails=lsExcelData[iCount]
							[ ] 
							[ ] SelectAccountFromAccountBar(lsLoanDetails[1],ACCOUNT_PROPERTYDEBT)
							[ ] 
							[ ] // Retrieve Loan Balance from Dashboard
							[ ] sLoanBalance=MDIClientLoans.LoanWindow.LoanBalanceAmount.GetCaption()
							[ ] nLoanBalance = VAL(StrTran(sLoanBalance ,"," ,""))
							[ ] nToatalLoanBalance =nToatalLoanBalance+nLoanBalance
						[ ] nCurrentEquityValue =nAssetValue - nToatalLoanBalance
						[ ] sCurrentEquityValue =trim(Str(nCurrentEquityValue ,4 ,2))
						[+] for(iCount=1;iCount<=ListCount(lsExcelData)-2;iCount++)
							[ ] lsLoanDetails=lsExcelData[iCount]
							[ ] 
							[ ] SelectAccountFromAccountBar(lsLoanDetails[1],ACCOUNT_PROPERTYDEBT)
							[ ] 
							[ ] 
							[+] if(MDIClientLoans.LoanWindow.EquityLinkedToAssetAmount.Exists(5))
								[ ] ReportStatus("Verify Equity Linked To Asset Amount displayed on Dashboard",PASS,"Equity Linked To Asset Amount displayed on Dashboard for account {lsLoanDetails[1]}")
								[ ] 
								[ ] // Verify if calculation on loan dashboard is correct
								[ ] sActual=MDIClientLoans.LoanWindow.EquityLinkedToAssetAmount.GetCaption()
								[ ] //Remove all commas in amount displayed on loan dashboard
								[ ] sActual=StrTran(sActual,",","")              
								[ ] bMatch=MatchStr("*{sCurrentEquityValue}*",sActual)
								[+] if(bMatch==TRUE)
									[ ] ReportStatus("Verify Equity Linked To Asset Amount",PASS,"Equity Linked To Asset Amount displayed on Loan Dashboard {sActual} is as expected {sCurrentEquityValue} for account {lsLoanDetails[1]}")
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Equity Linked To Asset Amount",FAIL,"Equity Linked To Asset Amount displayed on Loan Dashboard {sActual} is as NOT as expected {sCurrentEquityValue} for account {lsLoanDetails[1]}")
									[ ] 
									[ ] 
							[+] else
								[ ] ReportStatus("Verify Equity Linked To Asset Amount displayed on Dashboard",FAIL,"Equity Linked To Asset Amount is not displayed on Dashboard for account {lsLoanDetails[1]}")
								[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Account is added",FAIL,"Account not added")
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Next Button Status", FAIL, "Connect (Next) button is disabled")
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
		[+] else
			[ ] ReportStatus("Verify if asset account is added",FAIL,"Error while adding asset account")
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
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //######################### Verify that 'Add Loan Details' button functionality is working #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_Verify_Add_Loan_Details_Button_Functionality_From_Loan_Details_Tab
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Add Loan Details' button functionality is working
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If 'Add Loan Details' button functionality is working
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test06_Verify_Add_Loan_Details_Button_Functionality_From_Loan_Details_Tab() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails,lsVehicleAccount
		[ ] STRING sValidationText
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read banking account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] 
		[ ] // // Read manual loan account data from excel sheet
		[ ] // lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sMinimalViewSheet)
		[ ] // lsFileData=lsExcelData[1]
		[ ] 
		[ ] // Read asset account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sAssetAccountSheet)
		[ ] lsVehicleAccount=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
		[ ] lsLoanDetails=lsExcelData[1]
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
	[ ] iValidate=OpenDataFile(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] // Before adding asset account
		[ ] iValidate = SelectAccountFromAccountBar(lsLoanDetails[1], ACCOUNT_PROPERTYDEBT)
		[+] if (iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Verify Loan Details window
			[+] if(MDIClientLoans.LoanWindow.AddLoanDetailsButton.Exists(5))
				[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",PASS,"Add Loan Details button is present")
				[ ] 
				[ ] MDIClientLoans.LoanWindow.AddLoanDetailsButton.Click()
				[+] if(LoanDetails.Exists(5))
					[ ] ReportStatus("Verify if Loan details window opens when Add Loan Details button is clicked on online loan account dashboard",PASS,"Loan Details window opens when Add Loan details is clicked on online loan account dashboard")
					[ ] 
					[ ] //Verify Loan Name
					[+] if(LoanDetails.LoanNameTextField.Exists(2))
						[ ] ReportStatus("Verify Loan Name Text field",PASS,"Loan name text field found")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Loan Name Text field",FAIL,"Loan name text field not found")
						[ ] 
						[ ] 
					[ ] 
					[ ] //Verify Opening Date
					[+] if(LoanDetails.OpeningDateTextField.Exists(2))
						[ ] ReportStatus("Verify Opening Date Text field",PASS,"Opening Date text field found")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Opening Date Text field",FAIL,"Opening Date text field not found")
					[ ] 
					[ ] 
					[ ] //Verify Original Balance
					[+] if(LoanDetails.OriginalBalanceTextField.Exists(2))
						[ ] ReportStatus("Verify Original Balance Text Field",PASS,"Original Balance Text Field  found")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Original Balance Text Field",FAIL,"Original Balance Text Field not found")
					[ ] 
					[ ] 
					[ ] //Verify Current Interest Rate
					[+] if(LoanDetails.CurrentInterestRateTextField.Exists(2))
						[ ] ReportStatus("Verify Current Interest Rate Text Field",PASS,"Current Interest Rate Text Field found")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Current Interest Rate Text Field",FAIL,"Current Interest Rate Text Field not found")
					[ ] 
					[ ] 
					[ ] //Verify Original Length Rate
					[+] if(LoanDetails.OriginalLengthTextField.Exists(2))
						[ ] ReportStatus("Verify Original Length Text Field",PASS,"Original Length Text Field found")
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Original Length Text Field",FAIL,"Original Length Text Field not found")
						[ ] 
					[ ] 
					[ ] 
					[ ] LoanDetails.Close()
					[ ] WaitForState(LoanDetails,FALSE,5)
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan details window opens when Add Loan Details button is clicked on online loan account dashboard",FAIL,"Loan Details window does not open when Add Loan details is clicked on online loan account dashboard")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",FAIL,"Add Loan Details button is not found in Online account minimal view")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
		[ ] 
	[ ] 
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[+] //########## Verify that Action menu items functionality works on 'Loan Dashboard' when 'Loan Details' (full) tab is displayed  #############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_Verify_Action_Menu_Items_Functionality_When_Full_Loan_Details_Tab_Is_Displayed
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Action menu items functionality works on 'Loan Dashboard' when 'Loan Details' (full) tab is displayed
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If 'Action menu items functionality works on 'Loan Dashboard' when 'Loan Details' (full) tab is displayed
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th Feb 2014
		[ ] //
	[ ] // ********************************************************
[+] testcase Test07_Verify_Action_Menu_Items_Functionality_When_Full_Loan_Details_Tab_Is_Displayed() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] LIST OF STRING lsLoanDetails
		[ ] STRING sValidationText
		[ ] 
		[ ] // Read manual loan account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
		[ ] lsLoanDetails=lsExcelData[3]
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
	[ ] iValidate=OpenDataFile(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] // Before adding asset account
		[ ] iValidate = SelectAccountFromAccountBar(lsLoanDetails[1], ACCOUNT_PROPERTYDEBT)
		[+] if (iValidate==PASS)
			[ ] 
			[ ] 
			[ ] // Verify Loan Details window
			[+] if(MDIClientLoans.LoanWindow.AddLoanDetailsButton.Exists(5))
				[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",PASS,"Add Loan Details button is present")
				[ ] 
				[ ] MDIClientLoans.LoanWindow.AddLoanDetailsButton.Click()
				[+] if(LoanDetails.Exists(5))
					[ ] ReportStatus("Verify if Loan details window opens when Add Loan Details button is clicked on online loan account dashboard",PASS,"Loan Details window opens when Add Loan details is clicked on online loan account dashboard")
					[ ] 
					[ ] 
					[ ] 
					[ ] //Verify Original Balance
					[+] if(LoanDetails.OriginalBalanceTextField.Exists(2))
						[ ] LoanDetails.OriginalBalanceTextField.SetText(lsLoanDetails[3])
						[ ] 
						[ ] 
						[ ] //Verify Current Interest Rate
						[+] if(LoanDetails.CurrentInterestRateTextField.Exists(2))
							[ ] LoanDetails.CurrentInterestRateTextField.SetText(lsLoanDetails[4])
							[ ] 
							[ ] //Verify Original Length Rate
							[+] if(LoanDetails.OriginalLengthTextField.Exists(2))
								[ ] LoanDetails.OriginalLengthTextField.SetText(lsLoanDetails[5])
								[ ] LoanDetails.TypeKeys(KEY_TAB)
								[ ] LoanDetails.TypeKeys(KEY_TAB)
								[ ] LoanDetails.NextButton.Click()
								[ ] LoanDetails.NextButton.Click()
								[ ] // Select No on Add Reminder option
								[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(3)
								[ ] DlgLoanReminder.DoneButton.Click()
								[ ] WaitForState(LoanDetails,FALSE,5)
								[ ] 
								[ ] 
								[ ] 
								[ ] //Verify if Loan Details are added
								[+] if(MDIClientLoans.LoanWindow.EditTerms.Exists(5))
									[ ] ReportStatus("Verify if Loan Details full tab is displayed on the dashboard",PASS,"Loan Details full tab is displayed on the dashboard")
									[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] // Verify Account Actions menu items
									[ ] 
									[+] ///##########Verifying Acount Actions> Set Up Online#####////
										[ ] QuickenWindow.SetActive()
										[ ] sValidationText="Online Update for this account"
										[ ] NavigateToAccountActionBanking(2)
										[+] if (OnlineUpdateAccount.Exists(4))
											[ ] OnlineUpdateAccount.SetActive()
											[ ] sActual=OnlineUpdateAccount.GetProperty("Caption")
											[+] if (sActual==sValidationText)
												[ ] ReportStatus("Verify Account Actions", PASS, "Verify Account Actions> Update Now Dialog {sActual} displayed as expected {sValidationText}")
											[+] else
												[ ] ReportStatus("Verify Account Actions", FAIL, "Verify Account Actions> Update Now Dialog {sActual} NOT displayed as expected {sValidationText}")
											[ ] OnlineUpdateAccount.Cancel.Click()
											[ ] WaitForState(OneStepUpdate,FALSE,3)
										[+] else
											[ ] ReportStatus("Verify Dialog Online Update Account", FAIL, "Verify Online Update Account Dialog :  Online Update Account Dialog didn't appear.")
									[ ] 
									[ ] 
									[+] ///##########Verifying Acount Actions> Edit Account Details#####////  
										[ ] QuickenWindow.SetActive()
										[ ] sValidationText="Account Details"
										[ ] NavigateToAccountActionBanking(3)
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
									[+] ///##########Verifying Acount Actions> Full Payment Schedule #####////  
										[ ] QuickenWindow.SetActive()
										[ ] sValidationText="Loan Schedule: {lsLoanDetails[1]}"
										[ ] NavigateToAccountActionBanking(5)
										[+] if (LoanSchedule.Exists(4))
											[ ] LoanSchedule.SetActive()
											[ ] sActual=LoanSchedule.GetProperty("Caption")
											[+] if (sActual==sValidationText)
												[ ] ReportStatus("Verify Account Attachments", PASS, "Verify Account Actions> Full Payment Schedule option: Dialog {sActual} displayed as expected {sValidationText}.")
											[+] else
												[ ] ReportStatus("Verify Account Attachments", FAIL, "Verify Account Actions> Full Payment Schedule option: Dialog {sValidationText} didn't display.")
											[ ] LoanSchedule.Close()
											[ ] WaitForState(LoanSchedule,FALSE,4)
										[+] else
											[ ] ReportStatus("Verify Account Attachments ", FAIL, "Verify Dialog Account Actions : Full Payment Schedule Dialog didn't appear.")
									[ ] 
									[ ] 
									[ ] 
									[+] ///##########Verifying Acount Actions> Account Attachments #####////  
										[ ] QuickenWindow.SetActive()
										[ ] sValidationText="Account Attachments: {lsLoanDetails[1]}"
										[ ] NavigateToAccountActionBanking(6)
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
									[+] ///##########Verifying Acount Actions> Account Overview #####////  
										[ ] QuickenWindow.SetActive()
										[ ] sValidationText="Account Overview: {lsLoanDetails[1]}"
										[ ] NavigateToAccountActionBanking(7)
										[+] if (DlgAccountOverview.Exists(4))
											[ ] DlgAccountOverview.SetActive()
											[ ] sActual=DlgAccountOverview.GetProperty("Caption")
											[+] if (sActual==sValidationText)
												[ ] ReportStatus("Verify Account Overview", PASS, "Verify Account Actions> Account Overview option: Dialog {sActual} displayed as expected {sValidationText}.")
											[+] else
												[ ] ReportStatus("Verify Account Overview", FAIL, "Verify Account Actions> Account Overview option: Dialog {sActual} did not display as expected {sValidationText}.")
											[ ] DlgAccountOverview.TypeKeys(KEY_EXIT)
											[ ] WaitForState(DlgAccountOverview,FALSE,1)
										[+] else
											[ ] ReportStatus("Verify Account Overview ", FAIL, "Verify Dialog Account Overview : Account Overview Dialog didn't appear.")
									[ ] 
									[ ] 
									[ ] 
									[+] ///##########Verifying Acount Actions> Customize Action Bar#####////  
										[ ] QuickenWindow.SetActive()
										[ ] sValidationText="Customize Action Bar"
										[ ] NavigateToAccountActionBanking(8)
										[+] if (DlgCustomizeActionBar.Exists(5))
											[ ] DlgCustomizeActionBar.SetActive()
											[ ] sActual=DlgCustomizeActionBar.GetProperty("Caption")
											[+] if (sActual==sValidationText)
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
									[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if Loan Details full tab is displayed on the dashboard",FAIL,"Loan Details full tab is NOT displayed on the dashboard")
									[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Original Length Text Field",FAIL,"Original Length Text Field not found")
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Current Interest Rate Text Field",FAIL,"Current Interest Rate Text Field not found")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Original Balance Text Field",FAIL,"Original Balance Text Field not found")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Loan details window opens when Add Loan Details button is clicked on online loan account dashboard",FAIL,"Loan Details window does not open when Add Loan details is clicked on online loan account dashboard")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Add Loan details button is present on connected loan account dashboard",FAIL,"Add Loan Details button is not found in Online account minimal view")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsLoanDetails[1]} Account", FAIL, "{lsLoanDetails[1]} account couldn't open.")
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
		[ ] 
	[ ] 
	[ ] 
[ ] //##################################################################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] //===========================================================================================
[ ] //=================================  Loan Account Type ===========================================
[ ] //===========================================================================================
[ ] 
[ ] 
[ ] 
[+] //############## Verify that Loan type can be changed while setting up manual loan accounts ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_Loan_Account_Type_Verification_For_Manual_Loan_Account
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Loan type can be changed while setting up manual loan accounts
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to select different Loan types from account dropbox
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th Feb 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01_Loan_Account_Type_Verification_For_Manual_Loan_Account() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sLoanTextCaption
		[ ] LIST OF STRING lsActualLoanType,lsExpectedLoanType
		[ ] 
		[ ] 
		[ ] lsExpectedLoanType={"Mortgage","Loan","Auto Loan","Consumer Loan","Commercial Loan","Student Loan","Military Loan","Business Loan","Construction Loan","Home Equity Loan"}
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
	[ ] 
	[ ] 
	[ ] DataFileCreate(sLoansDataFileName)
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
			[ ] 
			[ ] // Verify the loan type drop down box contents on Add Manual loan account window
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
			[ ] sleep(4)
			[ ] AddAccount.Loan.Click()
			[+] if(AddAnyAccount.Exists(MEDIUM_SLEEP))
				[ ] 
				[ ] AddAnyAccount.SetActive()
				[ ] 
				[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 199, 5)
				[ ] 
				[+] if(LoanDetails.Exists(SHORT_SLEEP))
					[ ] 
					[ ] lsActualLoanType=LoanDetails.LoanTypePopupList.GetContents()
					[+] for(i=1;i<=ListCount(lsActualLoanType);i++)
						[ ] 
						[ ] LoanDetails.LoanTypePopupList.Select(lsActualLoanType[i])
						[ ] 
						[ ] 
						[ ] sActual=LoanDetails.LoanTypePopupList.GetText()
						[ ] 
						[ ] 
						[+] if(sActual==lsExpectedLoanType[i])
							[ ] ReportStatus("Verify Loan Type dropdown box",PASS,"Actual value {lsActualLoanType[i]} matches with Expected value {lsExpectedLoanType[i]}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Loan Type dropdown box",FAIL,"Actual value {lsActualLoanType[i]} does not match with Expected value {lsExpectedLoanType[i]}")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] LoanDetails.Close()
					[+] if(AlertMessage.Exists(5))
						[ ] AlertMessage.Yes.Click()
					[ ] WaitForState(LoanDetails,FALSE,5)
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
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //############## Verify that Loan type can be changed while setting up online loan accounts ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_Loan_Account_Type_Verification_For_Online_Loan_Account
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Loan type can be changed while setting up online loan accounts
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to select different Account types from account dropbox
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th Feb 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test02_Loan_Account_Type_Verification_For_Online_Loan_Account() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] STRING sLoanTextCaption
		[ ] LIST OF STRING lsActualLoanType,lsExpectedLoanType,lsLoanDetails
		[ ] 
		[ ] 
		[ ] lsExpectedLoanType={"Mortgage","Loan","Auto Loan","Consumer Loan","Commercial Loan","Student Loan","Military Loan","Business Loan","Construction Loan","Home Equity Loan"}
		[ ] 
		[ ] // // Read banking account data from excel sheet
		[ ] // lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sBankingAccountSheet)
		[ ] // lsAddAccount=lsExcelData[1]
		[ ] // 
		[ ] // // Read manual loan account data from excel sheet
		[ ] // lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sManualLoanSheet)
		[ ] // lsAddLoanAccount=lsExcelData[1]
		[ ] // lsAddLoanAccount[2]=sDate
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanDetails)
		[ ] lsLoanDetails=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] 
		[ ] // Copy autoapi dll for qwauto utility
		[ ] Setup_AutoApi()
		[ ] 
	[ ] 
	[ ] iValidate=OpenDataFile(sLoansDataFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File Opened successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] // Verify the loan type drop down box contents on Add Manual loan account window
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Add Online Loan account
		[ ] iValidate=AddCCBankLoanAccount(sCCBankUserName,sCCBankPassword)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add CCBank loan account",PASS,"CCBank loan account is added")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=SelectAccountFromAccountBar(lsLoanDetails[1],ACCOUNT_PROPERTYDEBT)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Open Online loan account register",PASS,"Online loan account {lsLoanDetails[1]} found in Account Bar")
				[ ] 
				[ ] 
				[ ] iValidate=NavigateToAccountDetails(lsLoanDetails[1])
				[+] if(iValidate==PASS)
					[ ] 
					[ ] 
					[+] if(AccountDetails.Exists(SHORT_SLEEP))
						[ ] 
						[ ] 
						[ ] lsActualLoanType=AccountDetails.LoanTypeComboBox.GetContents()
						[+] for(i=1;i<=ListCount(lsActualLoanType);i++)
							[ ] 
							[ ] AccountDetails.LoanTypeComboBox.Select(lsActualLoanType[i])
							[ ] 
							[ ] 
							[ ] sActual=AccountDetails.LoanTypeComboBox.GetText()
							[ ] 
							[ ] 
							[+] if(sActual==lsExpectedLoanType[i])
								[ ] ReportStatus("Verify Loan Type dropdown box",PASS,"Actual value {lsActualLoanType[i]} matches with Expected value {lsExpectedLoanType[i]}")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Loan Type dropdown box",FAIL,"Actual value {lsActualLoanType[i]} does not match with Expected value {lsExpectedLoanType[i]}")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] AccountDetails.Close()
						[+] if(AlertMessage.Exists(5))
							[ ] AlertMessage.Yes.Click()
						[ ] WaitForState(AccountDetails,FALSE,5)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Loan Details window is displayed",FAIL,"Loan Details window is NOT displayed")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Open Account Details window",FAIL,"Account Details window NOT opened")
				[ ] 
				[ ] 
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
		[+] else
			[ ] ReportStatus("Add CCBank loan account",FAIL,"CCBank loan account not added")
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
		[ ] ReportStatus("Open Data File",FAIL,"Data File not opened")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //############## Verify Loan account type for linked accounts in a converted data file  ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_04_05_06_Loan_Account_Type_Verification_For_Converted_Loan_Account
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Loan account type for linked accounts in a converted data file for following scenarios :
		[ ] //
		[ ] // 1. Verify that if a loan account created in QW2013 and linked to 'House' Asset account, then in QW2014 we can set loan type as 'Mortgage' 
		[ ] // 2. Verify that if a loan account created in QW2013 and linked to 'Vehicle' Asset account, then in QW2014 we can set loan type as 'Auto Loan'
		[ ] // 3. Verify that if a loan account created in QW2013 and linked to 'Other Asset' account, then in QW2014 we can set loan type as 'Loan'
		[ ] // 4. Verify that if a loan account created in QW2013 and not linked to any Asset account, then in QW2014 we can set loan type as 'Loan'
		[ ] //
		[ ] //
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Loan account type for linked accounts in a converted data file
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  28th Feb 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test03_04_05_06_Loan_Account_Type_Verification_For_Converted_Loan_Account() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration--------------
		[ ] 
		[ ] 
		[ ] 
		[ ] //Put in Loop
		[ ] STRING sFileName="LoansAccountTypeDataFile"
		[ ] STRING sVersion="2013"
		[ ] 
		[ ] 
		[ ] STRING sSourceFile=AUT_DATAFILE_PATH+"\"+sLoanDataFolder+"\"+sFileName + ".QDF"
		[ ] STRING sDataFile=AUT_DATAFILE_PATH +"\" + sFileName + ".QDF"
		[ ] // STRING sBackupFolder=AUT_DATAFILE_PATH+"\"+"Q13Files"
		[ ] 
		[ ] LIST OF STRING lsLoanType
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Open Older Data File and Convert to current edition
	[ ] 
	[ ] // //Copy Data File from folder
	[+] if(FileExists(sDataFile))
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] 
	[ ] //update due to change in DataFileConversion function
	[ ] sDataFile=AUT_DATAFILE_PATH +"\"
	[ ] 
	[ ] iValidate=DataFileConversion(sFileName,sVersion,NULL,sDataFile)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Convert older data file with Manual loan account",PASS,"Data File {sFileName} converted successfully")
		[ ] 
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sLoansDataExcelSheet,sLoanAccountTypeSheet)
		[ ] 
		[ ] 
		[ ] 
		[+] for(iCount=1;iCount<=ListCount(lsExcelData);iCount++)
			[ ] lsLoanType=lsExcelData[iCount]
			[ ] 
			[ ] 
			[ ] iValidate=SelectAccountFromAccountBar(lsLoanType[1],ACCOUNT_PROPERTYDEBT)
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=NavigateToAccountDetails(lsLoanType[1])
				[+] if(iValidate==PASS)
					[ ] 
					[+] if(AccountDetails.Exists(5))
						[ ] 
						[ ] // Verify linked asset account content
						[ ] sActual=AccountDetails.LinkedAssetAccount.GetText()
						[+] if(sActual==lsLoanType[2])
							[ ] ReportStatus("Verify content of Linked Asset account on Account Details window",PASS,"Linked Asset account {sActual} on Account Details window is as expected {lsLoanType[2]}")
							[ ] 
							[ ] // Verify loan type content
							[ ] sActual=AccountDetails.LoanTypeComboBox.GetText()
							[+] if(sActual==lsLoanType[3])
								[ ] ReportStatus("Verify content of Loan Type Combo Box on Account Details window",PASS,"Loan Type {sActual} on Account Details window is as expected {lsLoanType[3]}")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify content of Loan Type Combo Box on Account Details window",FAIL,"Loan Type {sActual} on Account Details window is NOT as expected {lsLoanType[3]}")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify content of Linked Asset account on Account Details window",FAIL,"Linked Asset account {sActual} on Account Details window is NOT as expected {lsLoanType[2]}")
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] AccountDetails.Close()
						[ ] WaitForState(AccountDetails,FALSE,5)
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Navigate To Account Details",FAIL,"Account Details window is NOT open")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Navigate To Account Details",FAIL,"Account Details window is NOT open")
					[ ] 
					[ ] 
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
	[+] else
		[ ] ReportStatus("Convert older data file",FAIL,"Data File  {sFileName} NOT converted")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] 
[ ] // 
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
	[+] //--------------Variable Declaration-------------
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
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] //Add checking Account
			[ ] iResult = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
			[+] if (iResult==PASS)
				[ ] 
				[ ] iResult =AddCCBankLoanAccount(IsFIData[1] , IsFIData[2] , IsFIData[3])
				[ ] sleep(3)
				[ ] // iResult=PASS
				[+] if (iResult==PASS)
					[ ] ReportStatus("Verify online loan account added. ", PASS , "Online loan account added for FI: {IsFIData[3]}.") 
					[ ] QuickenWindow.SetActive()
					[ ] iResult =SelectAccountFromAccountBar( lsAddAccount[2], ACCOUNT_BANKING)
					[+] if (iResult==PASS)
						[ ] sleep(1)
						[ ] QuickenWindow.SetActive()
						[ ] AddSuperRegisterTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],sDate,lsTransaction[6],lsTransaction[7],lsTransaction[8],lsTransaction[9])
						[ ] sleep(3)
						[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
						[+] if (iResult==PASS)
							[ ] sleep(2)
							[ ] QuickenWindow.SetActive()
							[ ] MDIClientLoans.LoanWindow.AddLoanDetailsButton.Click()
							[+] if(LoanDetails.Exists(5))
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
			[+] else
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
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] iResult =SelectAccountFromAccountBar( lsAddAccount[2], ACCOUNT_BANKING)
			[+] if (iResult==PASS)
				[ ] sleep(1)
				[ ] QuickenWindow.SetActive()
				[ ] AddSuperRegisterTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],sDate,lsTransaction[6],lsTransaction[7],lsTransaction[8],lsTransaction[9])
				[ ] sleep(3)
				[ ] iResult =SelectAccountFromAccountBar( sAccountName, ACCOUNT_PROPERTYDEBT)
				[+] if (iResult==PASS)
					[ ] sleep(2)
					[ ] QuickenWindow.SetActive()
					[ ] MDIClientLoans.LoanWindow.AddLoanDetailsButton.Click()
					[+] if(LoanDetails.Exists(5))
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
					[ ] sActualMonthlyPayment = LoanDetails.TotalPaymentAmount.GetText()
					[+] if (sExpectedPayment== sActualMonthlyPayment)
						[ ] ReportStatus("Verify Monthly Payment is calculated correctly. ", PASS , "Monthly Payment is calculated correctly as actual: {sActualMonthlyPayment} is same as expected {sExpectedPayment}.") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Monthly Payment is calculated correctly. ", FAIL , "Monthly Payment is calculated correctly as actual: {sActualMonthlyPayment} is NOT as expected {sExpectedPayment}.") 
					[ ] 
					[ ] sActualPrincipalDeterminesTotalOption=LoanDetails.PrincipaldDeterminesTotalOptionRadioList.GetSelItem()
					[ ] 
					[+] if (sPrincipalDeterminesTotalOption== sActualPrincipalDeterminesTotalOption)
						[ ] ReportStatus("Verify Extra principal determines total is selected by default. ", PASS , "Extra principal determines total is selected by default.") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Extra principal determines total is selected by default. ", FAIL , "Extra principal determines total is NOT selected by default, selected option is: {sActualPrincipalDeterminesTotalOption}.") 
					[ ] 
					[ ] //Reminder step verification
					[ ] LoanDetails.NextButton.Click()
					[ ] DlgLoanReminder.SetActive()
					[ ] 
					[ ] sActualFirstOptionPaymentAmount=DlgLoanReminder.FirstOptionPaymentAmount.GetCaption()
					[ ] // bMatch = MatchStr("*{sExpectedPayment}*{lsLoanData1[8]}",sActualFirstOptionPaymentAmount)
					[+] if (MatchStr("*{sExpectedPayment}*{trim(lsLoanData1[8])}",sActualFirstOptionPaymentAmount))
						[ ] ReportStatus("Verify Monthly Payment on D3 Reminder window for first option. ", PASS , "Monthly Payment on D3 Reminder window for first option displayed actual: {sActualFirstOptionPaymentAmount} is same as expected {sExpectedPayment} {lsLoanData1[8]}.") 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Monthly Payment on D3 Reminder window for first option. ", FAIL , "Monthly Payment on D3 Reminder window for first option not displayed actual: {sActualFirstOptionPaymentAmount} is NOT same as expected {sExpectedPayment} {lsLoanData1[8]}.") 
					[ ] 
					[ ] DlgLoanReminder.CancelButton.Click()
					[+] if (AlertMessage.Exists(3))
						[ ] AlertMessage.SetActive()
						[ ] AlertMessage.Yes.Click()
						[ ] WaitForState(AlertMessage , FALSE ,3)
				[+] else
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
	[+] //--------------Variable Declaration-------------
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
	[+] for each sCancelWindowType in lsCancelWindowType
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
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
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
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] sReminderType=lsReminderData[1]
			[ ] sPayeeName=lsReminderData[2]
			[ ] iResult=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[+] if (iResult == PASS)
				[+] if(DlgAddEditReminder.Exists(SHORT_SLEEP))
					[ ] DlgAddEditReminder.SetActive()
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.TypeKeys(KEY_TAB)
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.TypeKeys(KEY_BACKSPACE)
					[ ] sleep(1)
					[ ] sActualAccountName=DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.GetText()
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
	[+] if(iResult==PASS)
		[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
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
	[+] //--------------Variable Declaration-------------
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
		[+] if(iResult==PASS)
			[ ] ReportStatus("Open Data File",PASS,"Data File: {sOnlineLoansDataFileName} opened.")
			[+] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iResult =OnlineLoansNaviagateToD3Step(sAccountName,sDate,lsLoanData1[3],lsLoanData1[4],lsLoanData1[5],lsLoanData1[6], lsLoanData1[7] , lsLoanData1[8])
				[+] if (iResult==PASS)
					[+] if(DlgLoanReminder.Exists(5))
						[ ] DlgLoanReminder.SetActive()
						[ ] DlgLoanReminder.NextButton.Click()
						[+] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[ ] ReportStatus("Verify Detail Loan Reminder window is displayed. ", PASS , "Detail Loan Reminder window is displayed upon selecting first option from Loan .R.1:Loan Reminder.") 
							[ ] sleep(10)
							[+] if (!DlgLoanReminder.Exists(20))
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL)
								[+] if (iResult == PASS)
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
								[ ] iResult=NavigateQuickenTab(sTAB_BILL)
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
								[ ] iResult=NavigateQuickenTab(sTAB_BILL)
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
								[ ] iResult=NavigateQuickenTab(sTAB_BILL)
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
								[ ] iResult=NavigateQuickenTab(sTAB_BILL)
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
						[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(2)
						[ ] DlgLoanReminder.NextButton.Click()
						[+] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[+] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL)
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
						[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(2)
						[ ] DlgLoanReminder.NextButton.Click()
						[+] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[+] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL)
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
						[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(2)
						[ ] DlgLoanReminder.NextButton.Click()
						[+] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[+] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL)
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
						[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(2)
						[ ] DlgLoanReminder.NextButton.Click()
						[+] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[+] if (!DlgLoanReminder.Exists(20))
								[ ] //Navigate to Bills tab
								[ ] QuickenWindow.SetActive()
								[ ] iResult=NavigateQuickenTab(sTAB_BILL)
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
[ ] 
[+] testcase Test13C_VerifyThatUserShouldBeAbleToDeleteALoanReminderFromProjectedBalances() appstate none
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
						[ ] DlgLoanReminder.LoanReminderOptionRadioList.Select(2)
						[ ] DlgLoanReminder.NextButton.Click()
						[+] if(LoanPaymentReminder.Exists(5))
							[ ] LoanPaymentReminder.SetActive()
							[ ] LoanPaymentReminder.DoneButton.Click()
							[ ] WaitForState(LoanPaymentReminder , false ,5)
							[+] if (!DlgLoanReminder.Exists(20))
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
[ ] 
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
[ ] 
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
[+] //##########  Verify that if user deletes a loan payment reminder then Quicken creates a memorized payee for that loan account.  #####################
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
		[ ] 
		[ ] iResult =AddEditManualLoanAccount(sAction, sAccountName ,sDate ,lsAccount[3] ,lsAccount[4] ,lsAccount[5] ,lsAccount[6])
		[ ] //Add Loan account
		[+] if(iResult==PASS)
			[ ] ReportStatus("Add Manual loan account",PASS,"Manual loan account: {sAccountName} is added")
			[ ] 
			[ ] iResult=NavigateQuickenTab(sTAB_BILL)
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
[ ] // 
