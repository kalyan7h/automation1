﻿[ ] // *********************************************************
[+] // FILE NAME:	<QuickenBusiness.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Business module test cases
	[ ] //
	[ ] // DEPENDENCIES:	<include.inc>
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 02-May-13	Udita Dube	Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] // Global variables
	[ ] // public STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] public STRING sDataFile,sSourceFile,sFileName
	[ ] 
	[ ] public STRING sWindowType = "MDI"
	[ ] public STRING sDateFormate="m/d/yyyy"
	[ ] public STRING sDateStamp = FormatDateTime (GetDateTime(), sDateFormate) 
	[ ] 
	[ ] 
	[ ] public INTEGER iSetupAutoAPI,iCreateDataFile,iAddAccount,iSelect,iNavigate,iAddTransaction,iCount,i,j,iAddBusiness,iResult,iCounter,iOpenAccountRegister
	[ ] public INTEGER iValidate,iVerify,iOpenDataFile
	[ ] public BOOLEAN bCaption,bExists,bMatch
	[ ] public STRING sAccount,sHandle,sActual,sExcelSheet,sBusinessSheet,sBillSheet,sItem,sExpectedSheet,sAccWorksheet,sTotal,sRegisterExcel,sTransactionsheet
	[ ] public STRING sReportSheet,sAccountUsedPrimarily
	[ ] public LIST OF ANYTYPE  lsExcelData,lsTransactionData,lsTransaction,lsCustomerData,lsVendorData
	[ ] public LIST OF STRING lsAccount
[ ] 
[ ] 
[ ] //Gobal Function
[ ] // ===============================================================================================
[+] // FUNCTION: AddBillReminderForBusinessAccount()
	[ ] //
	[ ] // DESCRIPTION: This function will create a bill reminder for business accounts
	[ ] // 
	[ ] //		QTY						
	[ ] // PARAMETERS:		STRING sPayeeName	     Name of the Payee
	[ ] //						STRING  sDate				Current date
	[ ] //						STRING  sAmount			Amount for the Reminder
	[ ] //						STRING sAccountName	Account Name from which the amount is going to deduce
	[ ] //						STRING sCategory			Category of the reminder
	[ ] //						STRING sTag 				Tag of the reminder
	[ ] 	
	[ ] 
	[ ] // RETURNS:			INTEGER	0 = if function returns the PASS status
	[ ] //									1 =  if function returns the FAIL status
	[ ] //
	[ ] // REVISION HISTORY:
	[ ] // 26 April,2013          	Created by	Anagha Bhandare
[ ] // ================================================================================================
[+] public INTEGER AddBillReminderForBusinessAccount(STRING sPayeeName ,STRING sDate optional,STRING  sAmount,STRING  sAccountName,STRING  sCategory,STRING  sTag)
	[+] // Variable Declaration
		[ ] INTEGER iCounter,iFunctionResult
		[ ] BOOLEAN bCheckStatus
		[ ] iCounter = 2
		[ ]  sDate = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[-] do
		[ ] QuickenWindow.SetActive()
		[+] //Need to remove-----
			[ ] // QuickenWindow.View.Click()
			[ ] // QuickenWindow.View.TabsToShow.Click()
			[ ] // bCheckStatus =QuickenWindow.View.TabsToShow.Business.GetProperty("IsChecked")
			[+] // if (bCheckStatus== FALSE)
				[ ] // QuickenWindow.SetActive()
				[ ] // // QuickenWindow.View.Click()
				[ ] // // // QuickenWindow.View.TabsToShow.Click()
				[ ] // // // QuickenWindow.View.TabsToShow.Business.Select()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_BUSINESS,sTAB_PROFIT_LOSS)
		[ ] 
		[ ] Sleep(1)
		[ ] 
		[+] if(!AddReminderButton.Exists(5))
			[ ] MDIClient.Business.ProfitLossSnapshot.Panel2.TextClick("Business Reminders")
			[ ] Sleep(2)
			[ ] 
		[+] if(AddReminderButton.Exists(5))
			[ ] AddReminderButton.Click()
			[ ] AddReminderButton.BillReminder.Click()
			[ ] Sleep(2)
		[ ] 
		[-] if (DlgAddEditReminder.Exists(5))
			[ ] DlgAddEditReminder.SetActive()
			[ ] // Enter Payee name and go to next screen
			[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.SetText(sPayeeName)
			[ ] 								
			[ ] DlgAddEditReminder.NextButton.Click()
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDate)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.SetText(sAccountName)
			[ ] DlgAddEditReminder.TypeKeys(KEY_ENTER)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
			[ ] 
			[ ] //Enter Data in Category,Tag & Memo Text Field
			[+] if(DlgOptionalSetting.Exists(5))
				[ ] // Enter data in Category,Tag & Memo field 
				[ ] DlgOptionalSetting.CategoryTextField.SetText(sCategory)
				[ ] DlgOptionalSetting.TagTextField.SetText(sTag)
				[ ] // Handled the new tag dialog
				[+] if(DlgOptionalSetting.NewTag.TagOKButton.Exists(5))
					[ ] DlgOptionalSetting.NewTag.TagOKButton.Click()
				[ ] 
				[ ] DlgOptionalSetting.OKButton.Click()
			[+] else
				[ ] ReportStatus("Verify Category,Tag & Memo Window",FAIL," Category,Tag & Memo Window is not present")
				[ ] iFunctionResult = FAIL
			[ ] 
			[ ] DlgAddEditReminder.SetActive()
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] CloseAddLinkBiller()
			[ ] iFunctionResult = PASS
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Bill Remindow Window",FAIL,"Add Bill Remindow Window is not present")
			[ ] iFunctionResult = FAIL
			[ ] 
	[+] except
		[ ] ExceptLog()
		[ ] iFunctionResult = FAIL
		[ ] 
	[ ] 
	[ ] return iFunctionResult
[ ] // ================================================================================================
[ ] 
[ ] 
[ ] ///////////////////////////////////////////// Business Center /////////////////////////////////////////////////////////////
[ ] 
[+] //############# SetUp ####################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Business_SetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the QDF if it exists. It will add few spending account and some business account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 02, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[-] testcase BusinessCenter_SetUp () appstate none
	[ ] 
	[-] //---------- Variable declaration---------------
		[ ] sFileName = "BusinessCenter"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sSourceFile = AUT_DATAFILE_PATH + "\Business Data File\" + sFileName + ".QDF"
		[ ] 
	[ ] 
	[ ] //SkipRegistration
	[ ] // SkipRegistration()
	[+] // if(FileExists(sDataFile) == TRUE)
		[+] // if(QuickenWindow.Exists(SHORT_SLEEP))
			[ ] // QuickenWindow.Kill()
			[ ] // WaitForState(QuickenWindow,FALSE,5)
		[ ] // DeleteFile(sDataFile)
	[ ] // CopyFile(sSourceFile,sDataFile)
	[ ] // 
	[+] // if (!QuickenWindow.Exists(5))
		[ ] // App_Start(sCmdLine)
		[ ] // WaitForState(QuickenWindow, TRUE ,10)
	[ ] // 
	[ ] //------------------ Open Data File------------------
	[ ] iOpenDataFile = OpenDataFile_OII(sFileName)
	[ ] 
	[ ] // ------------------Report Staus If Data file opened successfully------------------
	[+] if ( iOpenDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sDataFile} is opened")
		[ ] //RegisterQuickenConnectedServices()
	[+] else 
		[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sDataFile} is not opened")
	[ ] 
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] UsePopupRegister("OFF")
	[+] //
		[ ] // //----------Retrieving Data from ExcelSheet----------
		[ ] // lsExcelData=ReadExcelTable(sExcelSheet, sBusinessSheet)
		[ ] // lsTransactionData = ReadExcelTable(sExcelSheet, sTransactionSheet)
		[ ] // 
		[ ] // 
		[+] // if(FileExists(sTestCaseStatusFile))
			[ ] // DeleteFile(sTestCaseStatusFile)
		[ ] // 
		[+] // if(FileExists(sDataFile) == TRUE)
			[+] // if(QuickenWindow.Exists(5))
				[ ] // QuickenWindow.Kill()
				[ ] // WaitForState(QuickenWindow,FALSE,5)
			[ ] // DeleteFile(sDataFile)
			[ ] // 
			[ ] // 
		[ ] // 
		[+] // if (!QuickenWindow.Exists(5))
			[ ] // App_Start(sCmdLine)
			[ ] // WaitForState(QuickenWindow, TRUE ,10)
		[ ] // 
		[ ] // 
		[ ] // //---------- Create Data File----------
		[ ] // iCreateDataFile = DataFileCreate(sFileName)
		[ ] // 
		[ ] // // Report Staus If Data file Created successfully
		[+] // if( iCreateDataFile == PASS)
			[ ] // ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
			[ ] // 
			[ ] // SwitchManualBackupOption("OFF")
			[ ] // SetViewMode(VIEW_CLASSIC_MENU)
			[ ] // 
		[+] // else 
			[ ] // ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is not created")
		[ ] // 
		[+] // for(i=1;i<=Listcount(lsExcelData);i++)
			[ ] // lsAccount = lsExcelData[i]
			[ ] // lsTransaction = lsTransactionData[i]
			[+] // if(lsAccount[1]==NULL)
				[ ] // break
			[ ] // lsAccount[4] = sDateStamp
			[ ] // lsTransaction[4]=sDateStamp
			[ ] // 
			[ ] // // ----------Add Checking Account----------
			[ ] // iAddAccount = AddManualSpendingAccount(lsAccount[1],lsAccount[2],lsAccount[3],lsAccount[4],lsAccount[5])
			[ ] // 
			[ ] // // ----------Report Status if checking Account is created----------
			[+] // if (iAddAccount==PASS)
				[ ] // ReportStatus("{lsAccount[1]} Account", iAddAccount, "{lsAccount[1]} Account -  {lsAccount[2]}  is created successfully")
				[ ] // 
				[ ] // //----------This will click on Banking account on AccountBar----------
				[ ] // 
				[ ] // Sleep(2)
				[ ] // 
				[ ] // iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BANKING)
				[ ] // 
				[ ] // Sleep(2)
				[ ] // 
				[ ] // // ----------Add Payment Transaction to account----------
				[ ] // iAddTransaction= AddCheckingTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4])
				[ ] // 
				[ ] // ReportStatus("Add Transaction", iAddTransaction, "Transaction is added to banking account") 
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("{lsAccount[1]} Account", iAddAccount, "{lsAccount[1]} Account -  {lsAccount[2]}  is not created successfully")
				[ ] // 
		[ ] // 
		[ ] // 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################
[ ] 
[+] //#############Verify controls on the Profit/Loss page #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_VerifyProfitLossTabUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add business account and Verify controls on the Projected Profit/Loss page.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 03, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test01_VerifyProfitLossTabUI() appstate none
	[ ] 
	[+] //---------- Variable declaration----------
		[ ] INTEGER iValidate
		[ ] STRING sAccountType,sTaxAccount,sAccountUsedPrimarily
		[ ] 
		[ ] sAccountType= "Accounts Receivable"
		[ ] sAccount = "Customer Invoices Account"
		[ ] sTaxAccount="*Sales Tax*"
		[ ] sAccountUsedPrimarily = "Business Transactions"
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive ()
		[ ] UsePopupRegister("OFF")
		[ ] //----------Add one "Account Receiable" account in Quicken.----------
		[ ] iAddAccount = AddBusinessAccount(sAccountType,sAccount)
		[ ] 
		[ ] Sleep(2)
		[+] if (iAddAccount == PASS)
			[ ] ReportStatus("Add business account {sAccount}", PASS, "Business Account {sAccount} is Added successfully")
			[ ] 
			[ ] // ----------Verify Customer Invoice Account----------
			[ ] iValidate=SelectAccountFromAccountBar(sAccount,ACCOUNT_BUSINESS)
			[ ] //iValidate= AccountSelect(sAccountUsedPrimarily,sAccount)
			[ ] 
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Validate {sAccount}",PASS,"{sAccount} is added in Account Bar")
			[+] else
				[ ] ReportStatus("Validate {sAccount}",FAIL,"{sAccount} is not added in Account Bar")
			[ ] 
			[ ] //---------- Verify Sales Tax account----------
			[ ] iValidate=SelectAccountFromAccountBar(sTaxAccount,ACCOUNT_BUSINESS)
			[ ] //iValidate= AccountSelect(sAccountUsedPrimarily,sTaxAccount)
			[ ] 
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Validate {sTaxAccount}",PASS,"{sTaxAccount} is added in Account Bar")
			[+] else
				[ ] ReportStatus("Validate {sTaxAccount}",FAIL,"{sTaxAccount} is not added in Account Bar")
			[ ] 
			[ ] // ----------Navigate to Profit Loss tab----------
			[ ] NavigateQuickenTab(sTAB_BUSINESS,sTAB_PROFIT_LOSS)
			[ ] 
			[ ] // ----------Verify drop down list box----------
			[+] if(Business.ProfitLossSnapshot.MonthPanel.Exists(5))
				[ ] ReportStatus("Verify Business drop down list box",PASS,"Business drop down list box is present")
			[+] else
				[ ] ReportStatus("Verify Business drop down list box",FAIL,"Business drop down list box is not present")
				[ ] 
			[ ] 
			[ ] //---------- Verify The month navigation control----------
			[+] if(Business.PreMonth.Exists(5))
				[+] if(Business.PostMonth.Exists(5))
					[ ] ReportStatus("Verify month navigation control",PASS,"Month navigation control is present")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify month navigation control",FAIL,"Month navigation control is not present")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify month navigation control",FAIL,"Month navigation control is not present")
				[ ] 
			[ ] 
			[ ] // ----------Verify  Profit/Loss Details push button----------
			[+] if(Business.ProfitLossDetails.Exists(5))
				[ ] ReportStatus("Verify Profit/Loss Details push button",PASS,"Profit/Loss Details push button is present")
			[+] else
				[ ] ReportStatus("Verify Profit/Loss Details push button",FAIL,"Profit/Loss Details push button is not present")
				[ ] 
			[ ] 
			[ ] // ----------Verify Business Tools button----------
			[+] if(QuickenMainWindow.QWNavigator1.BusinessTools.Exists(5))
				[ ] ReportStatus("Verify Business Tools button",PASS,"Business Tools button is present")
			[+] else
				[ ] ReportStatus("Verify Business Tools button",FAIL,"Business Tools button is not present")
				[ ] 
			[ ] 
			[ ] // ----------Verify Business Action button----------
			[+] if(QuickenMainWindow.QWNavigator1.BusinessActions.Exists(5))
				[ ] ReportStatus("Verify Business Actions button",PASS,"Business Actions button is present")
			[+] else
				[ ] ReportStatus("Verify Business Actions button",FAIL,"Business Actions button is not present")
				[ ] 
			[ ] 
			[ ] // Verify Reports button
			[+] if(QuickenMainWindow.QWNavigator1.Reports.Exists(5))
				[ ] ReportStatus("Verify Reports button",PASS,"Reports button is present")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Reports button",FAIL,"Reports button is not present")
				[ ] 
			[ ] 
			[ ] // Verify IN snapshot
			[ ] sHandle = Str(Business.ProfitLossSnapshot.MonthPanel.QWListViewer1.ListBox1.GetHandle())	   // get the handle
			[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
			[ ] bMatch = MatchStr("*Recorded Deposits*", sActual)
			[+] if (bMatch == TRUE)
				[ ] ReportStatus(" Verify IN snapshot ", PASS, "{sActual} is dispayed in IN snapshot") 
			[+] else
				[ ] ReportStatus(" Verify IN snapshot ", FAIL, "Recorded Deposits is not dispayed in IN snapshot, Actual is - {sActual}") 
			[ ] 
			[ ] // Verify OUT snapshot
			[ ] sHandle = Str(Business.ProfitLossSnapshot.MonthPanel.QWListViewer2.ListBox1.GetHandle())	   // get the handle
			[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
			[ ] bMatch = MatchStr("*Recorded Expenses*", sActual)
			[+] if (bMatch == TRUE)
				[ ] ReportStatus(" Verify OUT snapshot ", PASS, "{sActual} is dispayed in OUT snapshot") 
			[+] else
				[ ] ReportStatus(" Verify OUT snapshot ", FAIL, "Recorded Expenses is not dispayed in OUT snapshot, Actual is - {sActual}") 
			[ ] 
			[ ] // Verify Profit/Loss snapshot
			[+] if(Business.ProfitLossSnapshot.MonthPanel.LastMonthProjectedText.Exists(5))
				[ ] ReportStatus("Verify Last Month's Projected Profit Text",PASS,"Last Month's Projected Profit Text is present in Profit/Loss snapshot")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Last Month's Projected Profit Text",FAIL,"Last Month's Projected Profit Text is not present in Profit/Loss snapshot")
				[ ] 
			[ ] 
			[ ] // Verify Business Reminder tab
			[ ] 
			[+] if(ManageReminderButton.Exists(5))
				[ ] ManageReminderButton.Click()
				[+] if(DlgManageReminders.Exists(5))
					[ ] ReportStatus("Verify Manage Reminder button in Business Reminder tab",PASS, "Manage Reminder button is available in Business Reminder tab")
					[ ] DlgManageReminders.Close()
				[+] else
					[ ] ReportStatus("Verify Manage Reminder button in Business Reminder tab",FAIL, "Manage Reminder button is not available in Business Reminder tab")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Manage Reminder button in Business Reminder tab",FAIL, "Business Reminder tab is not available")
				[ ] 
			[ ] 
			[ ] // Verify Expenses tab
			[ ] MDIClient.Business.ProfitLossSnapshot.Panel2.Click (1, 210, 27)
			[+] if(!Business.Panel2.StaticText2.AddReminder.Exists(5))
				[ ] ReportStatus("Verify Add  Reminder button in Expenses tab",PASS, "Expenses tab is available")
			[+] else
				[ ] ReportStatus("Verify Add  Reminder button in Expenses tab",FAIL, "Expenses tab is not available")
			[ ] 
			[ ] // Verify Income Vs. Expenses tab
			[ ] MDIClient.Business.ProfitLossSnapshot.Panel2.Click(1, 350, 21)
			[ ] MDIClient.Business.ProfitLossSnapshot.Panel2.StaticText1.StaticText1.OptionsButton.Click()
			[ ] MDIClient.Business.ProfitLossSnapshot.Panel2.StaticText1.StaticText1.OptionsButton.TypeKeys(Replicate(KEY_DN,3))
			[ ] MDIClient.Business.ProfitLossSnapshot.Panel2.StaticText1.StaticText1.OptionsButton.TypeKeys(KEY_ENTER)
			[+] if(DlgBalanceSheet.Exists(5))
				[ ] ReportStatus("Verify Options button in Income Vs. Expenses tab",PASS, "Income Vs. Expenses tab is available")
				[ ] DlgBalanceSheet.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Options button in Income Vs. Expenses tab",FAIL, "Income Vs. Expenses tab is not available")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //######################################################################
[ ] 
[+] //#############Verify displaying of Cash Flow page ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_VerifyCashFlowPage()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify displaying of Cash Flow page
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Cash Flow tab is available							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 06, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test02_VerifyCashFlowPage() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] List of STRING lsAddAccount
		[ ] lsAddAccount={"Checking","Checking Business Account","100",sDateStamp,"BUSINESS"}
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Add one "Checking Business" account in Quicken.
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],lsAddAccount[4],lsAddAccount[5])
		[+] if (iAddAccount == PASS)
			[ ] ReportStatus("Add business account {lsAddAccount[2]}", PASS, "{lsAddAccount[2]} is Added successfully")
			[ ] 
			[ ] // Navigate to Cash Flow tab
			[ ] iNavigate=NavigateQuickenTab(sTAB_BUSINESS,sTAB_CASH_FLOW)
			[+] if(iNavigate==PASS)
				[ ] ReportStatus("Navigate to Cash Flow tab",PASS,"Navigation successful for Business > Cash Flow")
			[+] else
				[ ] ReportStatus("Navigate to Cash Flow tab",FAIL,"Navigation failed for Business > Cash Flow")
			[ ] 
		[+] else
			[ ] ReportStatus("Add account {lsAddAccount[2]}", FAIL, "{lsAddAccount[2]} is not added")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //######################################################################
[ ] 
[+] //#############Verify controls on the Cash Flow page.#################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_VerifyCashFlowTabUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify controls on the Cash Flow page.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If UI verification passed for Cash Flow							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 07, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_VerifyCashFlowTabUI() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sAccountType
		[ ] 
		[ ] sAccountType= "Accounts Receivable"
		[ ] sAccount = "Customer Invoices Account"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Navigate to Cash Flow tab
		[ ] iNavigate=NavigateQuickenTab(sTAB_BUSINESS,sTAB_CASH_FLOW)
		[+] if (iNavigate == PASS)
			[ ] ReportStatus("Navigate to Cash Flow tab", PASS, "Navigation to Cash Flow tab is successful")
			[ ] 
			[ ] // Verify SelectAccounts button
			[+] if(Business.SelectAccounts.Exists(5))
				[ ] ReportStatus("Verify Select Accounts button",PASS,"Select Accounts button is present in Cash Flow tab")
			[+] else
				[ ] ReportStatus("Verify Select Accounts button",FAIL,"Select Accounts button is not present in Cash Flow tab")
				[ ] 
			[ ] 
			[ ] // Verify The month navigation control
			[+] if(Business.PreMonth.Exists(5))
				[+] if(Business.PostMonth.Exists(5))
					[ ] ReportStatus("Verify month navigation control",PASS,"Month navigation control is present in Cash Flow tab")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify month navigation control",FAIL,"Month navigation control is not present in Cash Flow tab")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify month navigation control",FAIL,"Month navigation control is not present in Cash Flow tab")
				[ ] 
			[ ] 
			[ ] // Verify Cash Flow Details push button
			[+] if(Business.CashFlowDetails.Exists(5))
				[ ] ReportStatus("Verify Cash Flow Details push button",PASS,"Cash Flow Details push button is present in Cash Flow tab")
			[+] else
				[ ] ReportStatus("Verify Cash Flow Details push button",FAIL,"Cash Flow Details push button is not present in Cash Flow tab")
				[ ] 
			[ ] 
			[ ] // Verify Projected Balances push button
			[+] if(Business.ProjectedBalances.Exists(5))
				[ ] ReportStatus("Verify Projected Balances push button",PASS,"Projected Balances push button is present in Cash Flow tab")
			[+] else
				[ ] ReportStatus("Verify Projected Balances push button",FAIL,"Projected Balances push button is not present in Cash Flow tab")
				[ ] 
			[ ] 
			[ ] // Verify Business Tools button
			[+] if(QuickenMainWindow.QWNavigator1.BusinessTools.Exists(5))
				[ ] ReportStatus("Verify Business Tools button",PASS,"Business Tools button is present")
			[+] else
				[ ] ReportStatus("Verify Business Tools button",FAIL,"Business Tools button is not present")
				[ ] 
			[ ] 
			[ ] // Verify Business Action button
			[+] if(QuickenMainWindow.QWNavigator1.BusinessActions.Exists(5))
				[ ] ReportStatus("Verify Business Actions button",PASS,"Business Actions button is present")
			[+] else
				[ ] ReportStatus("Verify Business Actions button",FAIL,"Business Actions button is not present")
				[ ] 
			[ ] 
			[ ] // Verify Reports button
			[+] if(QuickenMainWindow.QWNavigator1.Reports.Exists(5))
				[ ] ReportStatus("Verify Reports button",PASS,"Reports button is present")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Reports button",FAIL,"Reports button is not present")
				[ ] 
			[ ] 
			[ ] // Verify IN snapshot
			[ ] sHandle = Str(MDIClient.Business.ProfitLossSnapshot.MonthPanel.QWListViewer1.ListBox1.GetHandle())	   // get the handle
			[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
			[ ] bMatch = MatchStr("*Expected Income*", sActual)
			[+] if (bMatch == TRUE)
				[ ] ReportStatus(" Verify IN snapshot ", PASS, "Expected Income is dispayed in IN snapshot") 
			[+] else
				[ ] ReportStatus(" Verify IN snapshot ", FAIL, "Expected Income is not dispayed in IN snapshot, Actual is - {sActual}") 
			[ ] 
			[ ] // Verify OUT snapshot
			[ ] sHandle = Str(MDIClient.Business.ProfitLossSnapshot.MonthPanel.QWListViewer2.ListBox1.GetHandle())	   // get the handle
			[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
			[ ] bMatch = MatchStr("*Other Expenses*", sActual)
			[+] if (bMatch == TRUE)
				[ ] ReportStatus(" Verify OUT snapshot ", PASS, "Other Expenses is dispayed in OUT snapshot") 
			[+] else
				[ ] ReportStatus(" Verify OUT snapshot ", FAIL, "Other Expenses is not dispayed in OUT snapshot, Actual is - {sActual}") 
			[ ] 
			[ ] // Verify What's Left snapshot
			[ ] sHandle = Str(MDIClient.Business.SnapShotGraph.Panel1.Profit1.ListBox1.GetHandle())	   // get the handle
			[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
			[ ] bMatch = MatchStr("*Cash Flow difference*", sActual)
			[+] if (bMatch == TRUE)
				[ ] ReportStatus(" Verify What's Left snapshot ", PASS, "Cash Flow difference link is dispayed in What's Left snapshot") 
			[+] else
				[ ] ReportStatus(" Verify What's Left snapshot ", FAIL, "Cash Flow difference link is not dispayed in What's Left snapshot, Actual is - {sActual}") 
			[ ] 
			[ ] // Verify Business Reminder tab
			[+] if(ManageReminderButton.Exists(5))
				[ ] ManageReminderButton.Click()
				[+] if(DlgManageReminders.Exists(5))
					[ ] ReportStatus("Verify Manage Reminder button in Business Reminder tab",PASS, "Manage Reminder button is available in Business Reminder tab")
					[ ] DlgManageReminders.Close()
				[+] else
					[ ] ReportStatus("Verify Manage Reminder button in Business Reminder tab",FAIL, "Manage Reminder button is not available in Business Reminder tab")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Manage Reminder button in Business Reminder tab",FAIL, "Business Reminder tab is not available")
				[ ] 
			[ ] 
			[ ] // Verify Account Balance Graph tab
			[ ] MDIClient.Business.CashFlowTab.Panel2.Click(1, 210, 27)
			[+] if(MDIClient.Business.CashFlowTab.Panel2.StaticText3.StaticText1.StaticText.ShowPopupList.Exists(5))
				[ ] ReportStatus("Verify Show dropdown list in Account Balance Graph tab",PASS, "Account Balance Graph tab is available as Show dropdown is present")
			[+] else
				[ ] ReportStatus("Verify Show dropdown list in Account Balance Graph tab",FAIL, "Account Balance Graph tab is not available as Show dropdown is not present")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Cash Flow tab", FAIL, "Navigation to Cash Flow tab is failed")
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#######################################################################
[ ] 
[+] //#############Verify Month Navigation Control on the Cash Flow page####################
	[ ] // ********************************************************
	[+] // TestCase Name:Test04_VerifyMonthControlOnCashFlow()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Month Navigation Control on the Cash Flow page.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If month navigation control working fine						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 10, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test04_VerifyMonthControlOnCashFlow() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sAccountType
		[ ] 
		[ ] sAccountType= "Accounts Receivable"
		[ ] sAccount = "Customer Invoices Account"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Cash Flow tab
		[ ] 
		[ ] iNavigate=NavigateQuickenTab(sTAB_BUSINESS,sTAB_CASH_FLOW)
		[ ] 
		[+] if (iNavigate == PASS)
			[ ] ReportStatus("Navigate to Cash Flow tab", PASS, "Navigation to Cash Flow tab is successful")
			[ ] 
			[ ] 
			[ ] Business.CurrentMonth.GetText()
			[ ] 
			[ ] // Verify The month navigation control
			[+] if(Business.PreMonth.Exists(5))
				[+] if(Business.PostMonth.Exists(5))
					[ ] ReportStatus("Verify month navigation control",PASS,"Month navigation control is present in Cash Flow tab")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify month navigation control",FAIL,"Month navigation control is not present in Cash Flow tab")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify month navigation control",FAIL,"Month navigation control is not present in Cash Flow tab")
				[ ] 
			[ ] 
			[ ] // Verify SelectAccounts button
			[+] if(Business.SelectAccounts.Exists(5))
				[ ] ReportStatus("Verify Select Accounts button",PASS,"Select Accounts button is present in Cash Flow tab")
			[+] else
				[ ] ReportStatus("Verify Select Accounts button",FAIL,"Select Accounts button is not present in Cash Flow tab")
				[ ] 
			[ ] 
			[ ] // Verify Cash Flow Details push button
			[+] if(Business.CashFlowDetails.Exists(5))
				[ ] ReportStatus("Verify Cash Flow Details push button",PASS,"Cash Flow Details push button is present in Cash Flow tab")
			[+] else
				[ ] ReportStatus("Verify Cash Flow Details push button",FAIL,"Cash Flow Details push button is not present in Cash Flow tab")
				[ ] 
			[ ] 
			[ ] // Verify Projected Balances push button
			[+] if(Business.ProjectedBalances.Exists(5))
				[ ] ReportStatus("Verify Projected Balances push button",PASS,"Projected Balances push button is present in Cash Flow tab")
			[+] else
				[ ] ReportStatus("Verify Projected Balances push button",FAIL,"Projected Balances push button is not present in Cash Flow tab")
				[ ] 
			[ ] 
			[ ] // Verify Business Tools button
			[+] if(QuickenMainWindow.QWNavigator1.BusinessTools.Exists(5))
				[ ] ReportStatus("Verify Business Tools button",PASS,"Business Tools button is present")
			[+] else
				[ ] ReportStatus("Verify Business Tools button",FAIL,"Business Tools button is not present")
				[ ] 
			[ ] 
			[ ] // Verify Business Action button
			[+] if(QuickenMainWindow.QWNavigator1.BusinessActions.Exists(5))
				[ ] ReportStatus("Verify Business Actions button",PASS,"Business Actions button is present")
			[+] else
				[ ] ReportStatus("Verify Business Actions button",FAIL,"Business Actions button is not present")
				[ ] 
			[ ] 
			[ ] // Verify Reports button
			[+] if(QuickenMainWindow.QWNavigator1.Reports.Exists(5))
				[ ] ReportStatus("Verify Reports button",PASS,"Reports button is present")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Reports button",FAIL,"Reports button is not present")
				[ ] 
			[ ] 
			[ ] // Verify IN snapshot
			[ ] sHandle = Str(Business.ProfitLossSnapshot.MonthPanel.QWListViewer1.ListBox1.GetHandle())	   // get the handle
			[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
			[ ] bMatch = MatchStr("*Expected Income*", sActual)
			[+] if (bMatch == TRUE)
				[ ] ReportStatus(" Verify IN snapshot ", PASS, "Expected Income is dispayed in IN snapshot") 
			[+] else
				[ ] ReportStatus(" Verify IN snapshot ", FAIL, "Expected Income is not dispayed in IN snapshot, Actual is - {sActual}") 
			[ ] 
			[ ] // Verify OUT snapshot
			[ ] sHandle = Str(Business.ProfitLossSnapshot.MonthPanel.QWListViewer2.ListBox1.GetHandle())	   // get the handle
			[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
			[ ] bMatch = MatchStr("*Other Expenses*", sActual)
			[+] if (bMatch == TRUE)
				[ ] ReportStatus(" Verify OUT snapshot ", PASS, "Other Expenses is dispayed in OUT snapshot") 
			[+] else
				[ ] ReportStatus(" Verify OUT snapshot ", FAIL, "Other Expenses is not dispayed in OUT snapshot, Actual is - {sActual}") 
			[ ] 
			[ ] // Verify What's Left snapshot
			[ ] sHandle = Str(Business.SnapShotGraph.Panel1.Profit1.ListBox1.GetHandle())	   // get the handle
			[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
			[ ] bMatch = MatchStr("*Cash Flow difference*", sActual)
			[+] if (bMatch == TRUE)
				[ ] ReportStatus(" Verify What's Left snapshot ", PASS, "Cash Flow difference link is dispayed in What's Left snapshot") 
			[+] else
				[ ] ReportStatus(" Verify What's Left snapshot ", FAIL, "Cash Flow difference link is not dispayed in What's Left snapshot, Actual is - {sActual}") 
			[ ] 
			[ ] // Verify Business Reminder tab
			[ ] MDIClient.Business.CashFlowTab.Panel2.Click(1, 82, 17)
			[+] if(ManageReminderButton.Exists(5))
				[ ] ManageReminderButton.Click()
				[+] if(DlgManageReminders.Exists(5))
					[ ] ReportStatus("Verify Manage Reminder button in Business Reminder tab",PASS, "Manage Reminder button is available in Business Reminder tab")
					[ ] DlgManageReminders.Close()
				[+] else
					[ ] ReportStatus("Verify Manage Reminder button in Business Reminder tab",FAIL, "Manage Reminder button is not available in Business Reminder tab")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Manage Reminder button in Business Reminder tab",FAIL, "Business Reminder tab is not available")
				[ ] 
			[ ] 
			[ ] // Verify Account Balance Graph tab
			[ ] MDIClient.Business.CashFlowTab.Panel2.Click(1, 210, 27)
			[ ] 
			[+] if(MDIClient.Business.CashFlowTab.Panel2.StaticText3.StaticText1.StaticText.ShowPopupList.Exists(5))
				[ ] ReportStatus("Verify Show dropdown list in Account Balance Graph tab",PASS, "Account Balance Graph tab is available as Show dropdown is present")
			[+] else
				[ ] ReportStatus("Verify Show dropdown list in Account Balance Graph tab",FAIL, "Account Balance Graph tab is not available as Show dropdown is not present")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Cash Flow tab", FAIL, "Navigation to Cash Flow tab is failed")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //######################################################################
[ ] 
[+] //############# Verify displaying of Invoice account in the Account Overview tab ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_VerifyCashFlowPage()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify displaying of Invoice account in the Account Overview tab.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If Invoice account displayed in the Account Overview tab.						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 07, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test05_VerifyInvoiceAccountInAccountOverviewTab() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sAccountType,sInvoiceAccount
		[ ] INTEGER iValidate
		[ ] sAccountType= "Accounts Payable"
		[ ] sAccount = "Vendor Invoices Account"
		[ ] sInvoiceAccount="Customer Invoices Account"
		[ ] sAccountUsedPrimarily = "Business Transactions"
		[ ] bExists=FALSE
		[ ] j=0
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Add one "Account Payable" account in Quicken.
		[ ] iAddAccount = AddBusinessAccount(sAccountType,sAccount)
		[+] if (iAddAccount == PASS)
			[ ] ReportStatus("Add business account {sAccount}", PASS, "Business Account {sAccount} is Added successfully")
			[ ] 
			[ ] // Verify Vendor Invoice Account.
			[ ] 
			[ ] iValidate=SelectAccountFromAccountBar(sAccount,ACCOUNT_BUSINESS)
			[ ] //iValidate= AccountSelect(sAccountUsedPrimarily,sAccount)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Validate {sAccount}",PASS,"{sAccount} is added in Account Bar")
			[+] else
				[ ] ReportStatus("Validate {sAccount}",FAIL,"{sAccount} is added in Account Bar")
			[ ] 
			[ ] 
			[ ] // Navigate to Account Overview tab
			[ ] NavigateQuickenTab(sTAB_BUSINESS)
			[ ] iNavigate=NavigateQuickenTab(sTAB_BUSINESS,sTAB_ACCOUNT_OVERVIEW)
			[+] if(iNavigate==PASS)
				[ ] ReportStatus("Navigate to Account Overview tab",PASS,"Navigation successful for Business > Account Overview")
				[ ] 
				[ ] 
				[ ] sHandle = Str(MDIClient.Business.AccountOverviewTab.InvoiceAccounts.ShowInvoice.ShowInvoiceAccounts.ListBox1.GetHandle())	   // get the handle
				[ ] iCount=MDIClient.Business.AccountOverviewTab.InvoiceAccounts.ShowInvoice.ShowInvoiceAccounts.ListBox1.GetItemCount()
				[+] for(i=1;i<=iCount;i++)
					[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
					[ ] bMatch = MatchStr("*{sInvoiceAccount}*", sActual)
					[+] if (bMatch == TRUE)
						[ ] ReportStatus(" Verify {sInvoiceAccount} in Account Overview tab ", PASS, "{sInvoiceAccount} is dispayed in  Account Overview tab")
						[ ] j=j+1
					[+] else
						[ ] bMatch = MatchStr("*{sAccount}*", sActual)
						[+] if (bMatch == TRUE)
							[ ] ReportStatus(" Verify {sAccount} in Account Overview tab ", PASS, "{sAccount} is dispayed in  Account Overview tab")
							[ ] bExists=TRUE
							[ ] j=j+1 
					[+] if(i==iCount && j!=2)
						[ ] ReportStatus(" Verify {sAccount} or {sInvoiceAccount}  in Account Overview tab ", FAIL, "Either {sAccount} or {sInvoiceAccount} is not dispayed in  Account Overview tab") 
					[+] else if(j==2)
						[ ] break
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Navigate to Account Overview tab",FAIL,"Navigation failed for Business > Account Overview")
			[ ] 
		[+] else
			[ ] ReportStatus("Add account {sAccount}", FAIL, "{sAccount} is not added")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#######################################################################
[ ] 
[+] //############# Verify checking & saving accounts in Account Overview tab ##################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_VerifyBankingAccountInAccountOverviewTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify displaying of  checking & saving account in the Account Overview tab.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If checking & saving accounts displayed in the Account Overview tab						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 08, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test06_VerifyBankingAccountInAccountOverviewTab() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] List of STRING lsAddAccount
		[ ] STRING sCheckingAccount
		[ ] lsAddAccount={"Savings","Savings Business Account","100",sDateStamp,"BUSINESS"}
		[ ] sCheckingAccount= "Checking Business Account"
		[ ] j=0
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Add one "Saving Business" account in Quicken.
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],lsAddAccount[4],lsAddAccount[5])
		[+] if (iAddAccount == PASS)
			[ ] ReportStatus("Add business account {lsAddAccount[2]}", PASS, "{lsAddAccount[2]} is Added successfully")
			[ ] 
			[ ] // Navigate to Account Overview tab
			[ ] iNavigate=NavigateQuickenTab(sTAB_BUSINESS,sTAB_ACCOUNT_OVERVIEW)
			[+] if(iNavigate==PASS)
				[ ] ReportStatus("Navigate to Account Overview tab",PASS,"Navigation successful for Business > Account Overview")
				[ ] 
				[ ] sHandle = Str(MDIClient.Business.AccountOverviewTab.SpendingAccounts.ShowSpending.ShowSpendingAccounts.ListBox1.GetHandle())	   // get the handle
				[ ] iCount=MDIClient.Business.AccountOverviewTab.SpendingAccounts.ShowSpending.ShowSpendingAccounts.ListBox1.GetItemCount()
				[+] for(i=1;i<=iCount;i++)
					[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
					[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
					[+] if (bMatch == TRUE)
						[ ] j=j+1
						[ ] ReportStatus(" Verify {lsAddAccount[2]} in Account Overview tab ", PASS, "{lsAddAccount[2]} is dispayed in  Account Overview tab")
						[ ] 
					[+] else
						[ ] bMatch = MatchStr("*{sCheckingAccount}*", sActual)
						[+] if (bMatch == TRUE)
							[ ] ReportStatus(" Verify {sCheckingAccount} in Account Overview tab ", PASS, "{sCheckingAccount} is dispayed in  Account Overview tab")
							[ ] j=j+1 
						[ ] 
					[+] if(i==iCount && j!=2)
						[ ] ReportStatus(" Verify {sCheckingAccount} or {lsAddAccount[2]}  in Account Overview tab ", FAIL, "Either {sCheckingAccount} or {lsAddAccount[2]} is not dispayed in  Account Overview tab") 
					[+] if(j==2)
						[ ] break
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Navigate to  Account Overview tab",FAIL,"Navigation failed for Business > Account Overview")
			[ ] 
		[+] else
			[ ] ReportStatus("Add account {lsAddAccount[2]}", FAIL, "{lsAddAccount[2]} is not added")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#######################################################################
[ ] 
[+] //############# Verify credit card accounts in Account Overview tab #######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_VerifyCreditCardAccInAccountOverviewTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify displaying of Credit card account in the Account Overview tab.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If credit card accounts displayed in the Account Overview tab						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 08, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test07_VerifyCreditCardAccInAccountOverviewTab() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] List of STRING lsAddAccount
		[ ] lsAddAccount={"Credit Card","Credit Card Business Account","100",sDateStamp,"BUSINESS"}
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Add one "Credit Card Business" account in Quicken.
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],lsAddAccount[4],lsAddAccount[5])
		[+] if (iAddAccount == PASS)
			[ ] ReportStatus("Add business account {lsAddAccount[2]}", PASS, "{lsAddAccount[2]} is Added successfully")
			[ ] 
			[ ] // Navigate to Account Overview tab
			[ ] iNavigate=NavigateQuickenTab(sTAB_BUSINESS,sTAB_ACCOUNT_OVERVIEW)
			[+] if(iNavigate==PASS)
				[ ] ReportStatus("Navigate to Account Overview tab",PASS,"Navigation successful for Business > Account Overview")
				[ ] 
				[ ] sHandle = Str(MDIClient.Business.AccountOverviewTab.CreditCardAccounts.ShowCreditCardAccounts.ListBox1.GetHandle())	   // get the handle
				[ ] iCount=MDIClient.Business.AccountOverviewTab.CreditCardAccounts.ShowCreditCardAccounts.ListBox1.GetItemCount()
				[+] for(i=0;i<=iCount;i++)
					[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
					[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
					[+] if (bMatch == TRUE)
						[ ] ReportStatus(" Verify {lsAddAccount[2]} in Account Overview tab ", PASS, "{lsAddAccount[2]} is dispayed in  Account Overview tab")
						[ ] break
					[+] else
						[ ] continue
					[+] if(i==iCount)
						[ ] ReportStatus(" Verify {lsAddAccount[2]}  in Account Overview tab ", FAIL, "{lsAddAccount[2]} is not dispayed in  Account Overview tab") 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Navigate to  Account Overview tab",FAIL,"Navigation failed for Business > Account Overview")
			[ ] 
		[+] else
			[ ] ReportStatus("Add account {lsAddAccount[2]}", FAIL, "{lsAddAccount[2]} is not added")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################
[ ] 
[+] //############# Verify Asset account in the Account Overview tab.########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_VerifyAssetAccInAccountOverviewTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify displaying of Asset account in the Account Overview tab.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If asset accounts displayed in the Account Overview tab						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 09, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test08_VerifyAssetAccInAccountOverviewTab() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] List of STRING lsAddAccount
		[ ] lsAddAccount={"Other Asset","Other Asset Business Account",sDateStamp,"100","","Business Transactions"}
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Add one "Other Asset" account in Quicken.
		[ ] iAddAccount = AddPropertyAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3],lsAddAccount[4],lsAddAccount[5],lsAddAccount[6])
		[+] if (iAddAccount == PASS)
			[ ] ReportStatus("Add business account {lsAddAccount[2]}", PASS, "{lsAddAccount[2]} is Added successfully")
			[ ] 
			[ ] // Navigate to Account Overview tab
			[ ] iNavigate=NavigateQuickenTab(sTAB_BUSINESS,sTAB_ACCOUNT_OVERVIEW)
			[+] if(iNavigate==PASS)
				[ ] ReportStatus("Navigate to Account Overview tab",PASS,"Navigation successful for Business > Account Overview")
				[+] if(MDIClient.Business.AccountOverviewTab.AssetAccounts.ShowAsset.ShowAssetAccounts.ListBox1.Exists(5))
					[ ] sHandle = Str(MDIClient.Business.AccountOverviewTab.AssetAccounts.ShowAsset.ShowAssetAccounts.ListBox1.GetHandle())	   // get the handle
					[ ] iCount=MDIClient.Business.AccountOverviewTab.AssetAccounts.ShowAsset.ShowAssetAccounts.ListBox1.GetItemCount()
					[+] for(i=0;i<=iCount;i++)
						[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
						[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
						[+] if (bMatch == TRUE)
							[ ] ReportStatus(" Verify {lsAddAccount[2]} in Account Overview tab ", PASS, "{lsAddAccount[2]} is dispayed in  Account Overview tab")
							[ ] break
						[+] else
							[ ] continue
						[+] if(i==iCount)
							[ ] ReportStatus(" Verify {lsAddAccount[2]}  in Account Overview tab ", FAIL, "{lsAddAccount[2]} is not dispayed in  Account Overview tab") 
				[+] else
					[ ] ReportStatus("Verify for Property & Debt Accounts snapshot",FAIL,"Property & Debt accounts snapshot not present-QW-2507")
				[ ] 
			[+] else
				[ ] ReportStatus("Navigate to  Account Overview tab",FAIL,"Navigation failed for Business > Account Overview")
			[ ] 
		[+] else
			[ ] ReportStatus("Add account {lsAddAccount[2]}", FAIL, "{lsAddAccount[2]} is not added")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#######################################################################
[ ] 
[+] //############# Verify addition of business in Quicken  #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_VerifyAddBusinessUIAndFunctionality()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify addition of business in the Quicken and verify all the controls on “Add Business” dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If UI verification and functionality passed for “Add Business” dialog 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 09, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test09_VerifyAddBusinessUIAndFunctionality() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN bEnable 
		[ ] STRING sBusinessName,sBusinessTag
		[ ] INTEGER iAddBusiness
		[ ] 
		[ ] sBusinessName= "My Business"
		[ ] sBusinessTag = "Business Tag 1"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] SetViewMode(VIEW_CLASSIC_MENU)
		[ ] 
		[ ] // Navigate to Business menu > Manage Business Information
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.ManageBusinessInformation.Select()
		[ ] 
		[ ] WaitForState(DlgManageBusinessInformation,10)
		[+] if(DlgManageBusinessInformation.Exists(5))
			[ ] ReportStatus("Verify Manage Business Information dialog",PASS,"Manage Business Information dialog is opened")
			[ ] DlgManageBusinessInformation.SetActive()
			[ ] 
			[+] // Verify Add button and check that it is in enable state
				[+] if(DlgManageBusinessInformation.ManageBusinessInformationList.AddButton.Exists(5))
					[ ] bEnable= DlgManageBusinessInformation.ManageBusinessInformationList.AddButton.IsEnabled()
					[+] if(bEnable==TRUE)
						[ ] ReportStatus("Verify Add button on Manage Business Information dialog",PASS,"Add button is enabled on Manage Business Information dialog")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Add button on Manage Business Information dialog",FAIL,"Add button is not enabled on Manage Business Information dialog")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Add button on Manage Business Information dialog",FAIL,"Add button is not present on Manage Business Information dialog")
					[ ] 
			[ ] 
			[+] // Verify Edit button and check that it is in disable state
				[+] if(DlgManageBusinessInformation.ManageBusinessInformationList.EditButton.Exists(5))
					[ ] bEnable= DlgManageBusinessInformation.ManageBusinessInformationList.EditButton.IsEnabled()
					[+] if(bEnable==FALSE)
						[ ] ReportStatus("Verify Edit button on Manage Business Information dialog",PASS,"Edit button is disabled on Manage Business Information dialog")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Edit button on Manage Business Information dialog",FAIL,"Edit button is not disabled on Manage Business Information dialog")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Edit button on Manage Business Information dialog",FAIL,"Edit button is not present on Manage Business Information dialog")
					[ ] 
			[ ] 
			[+] // Verify Delete button and check that it is in disable state
				[+] if(DlgManageBusinessInformation.ManageBusinessInformationList.DeleteButton.Exists(5))
					[ ] bEnable= DlgManageBusinessInformation.ManageBusinessInformationList.DeleteButton.IsEnabled()
					[+] if(bEnable==FALSE)
						[ ] ReportStatus("Verify Delete button on Manage Business Information dialog",PASS,"Delete button is disabled on Manage Business Information dialog")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Delete button on Manage Business Information dialog",FAIL,"Delete button is not disabled on Manage Business Information dialog")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Delete button on Manage Business Information dialog",FAIL,"Delete button is not present on Manage Business Information dialog")
					[ ] 
			[ ] 
			[+] // Verify Done button and check that it is in enable state
				[+] if(DlgManageBusinessInformation.DoneButton.Exists(5))
					[ ] bEnable= DlgManageBusinessInformation.DoneButton.IsEnabled()
					[+] if(bEnable==TRUE)
						[ ] ReportStatus("Verify Done button on Manage Business Information dialog",PASS,"Done button is enabled on Manage Business Information dialog")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Done button on Manage Business Information dialog",FAIL,"Done button is not enabled on Manage Business Information dialog")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Done button on Manage Business Information dialog",FAIL,"Done button is not present on Manage Business Information dialog")
					[ ] 
			[ ] 
			[+] // Verify  Add Business dialog and Add business functionality
				[+] if(DlgManageBusinessInformation.ManageBusinessInformationList.AddButton.Exists(5))
					[ ] DlgManageBusinessInformation.ManageBusinessInformationList.AddButton.Click()
					[+] if(DlgAddBusiness.Exists(5))
						[ ] ReportStatus("Verify Add Business dialog",PASS,"Add Business dialog is opened")
						[ ] 
						[ ] // Verify Business Name Field
						[+] if(DlgAddBusiness.BusinessNameTextField.GetText()=="")
							[ ] ReportStatus("Verify Business Name field in Add Business dialog",PASS,"Business Name field is blank by default")
						[+] else
							[ ] ReportStatus("Verify Business Name field in Add Business dialog",FAIL,"Business Name field is not blank by default, Actual: {DlgAddBusiness.BusinessNameTextField.GetText()}")
							[ ] 
						[ ] 
						[ ] // Verify Description Field
						[+] if(DlgAddBusiness.DescriptionTextField.GetText()=="")
							[ ] ReportStatus("Verify Business Description field in Add Business dialog",PASS,"Business Description field is blank by default")
						[+] else
							[ ] ReportStatus("Verify Business Description field in Add Business dialog",FAIL,"Business Description field is not blank by default, Actual: {DlgAddBusiness.DescriptionTextField.GetText()}")
							[ ] 
						[ ] 
						[ ] // Verify Owner radio list Field
						[+] if(DlgAddBusiness.DescriptionRadioList.GetSelText()=="Self")
							[ ] ReportStatus("Verify Business Owner field in Add Business dialog",PASS,"Self is selected for Business Owner field ")
						[+] else
							[ ] ReportStatus("Verify Business Owner field in Add Business dialog",FAIL,"Self is not selected for Business Owner field, Actual: {DlgAddBusiness.DescriptionRadioList.GetSelItem()}")
							[ ] 
						[ ] 
						[ ] // Verify Business Tag Field
						[+] if(DlgAddBusiness.BusinessTagTextField.GetText()=="")
							[ ] ReportStatus("Verify Business Tag field in Add Business dialog",PASS,"Business Tag field is blank by default")
						[+] else
							[ ] ReportStatus("Verify Business Tag field in Add Business dialog",FAIL,"Business Tag field is not blank by default, Actual: {DlgAddBusiness.DescriptionTextField.GetText()}")
							[ ] 
						[ ] 
						[ ] // Verify Business Transaction without the tag belong to this business checkbox
						[+] if(DlgAddBusiness.BusinessTransactionsWithout.IsChecked())
							[ ] ReportStatus("Verify Business Transaction without the tag belong to this business field in Add Business dialog",PASS,"Business Transaction without the tag belong to this business checkbox is checked by default")
						[+] else
							[ ] ReportStatus("Verify Business Transaction without the tag belong to this business field in Add Business dialog",FAIL,"Business Transaction without the tag belong to this business checkbox is not checked by default")
							[ ] 
						[ ] 
						[ ] // Verify Buttons on Add Business window
						[+] if(DlgAddBusiness.OKButton.Exists(5))
							[ ] ReportStatus("Verify OK button in Add Business dialog",PASS,"OK button is present on Add Business window")
						[+] else
							[ ] ReportStatus("Verify OK button in Add Business dialog",FAIL,"OK button is not present on Add Business window")
							[ ] 
						[ ] 
						[+] if(DlgAddBusiness.CancelButton.Exists(5))
							[ ] ReportStatus("Verify Cancel button in Add Business dialog",PASS,"Cancel button is present on Add Business window")
						[+] else
							[ ] ReportStatus("Verify Cancel button in Add Business dialog",FAIL,"Cancel button is not present on Add Business window")
							[ ] 
						[ ] 
						[+] if(DlgAddBusiness.HelpButton.Exists(5))
							[ ] ReportStatus("Verify Help button in Add Business dialog",PASS,"Help button is present on Add Business window")
						[+] else
							[ ] ReportStatus("Verify Help button in Add Business dialog",FAIL,"Help button is not present on Add Business window")
							[ ] 
						[ ] 
						[ ] DlgAddBusiness.Close()
						[ ] DlgManageBusinessInformation.Close()
						[ ] 
						[ ] //Add Business
						[ ] iAddBusiness=AddBusiness(sBusinessName,sBusinessTag)
						[+] if(iAddBusiness==PASS)
							[ ] ReportStatus("Verify Add Business",PASS,"{sBusinessName} is added successfully")
							[ ] 
							[ ] // Navigate to Business menu > Manage Business Information
							[ ] QuickenWindow.Business.Click()
							[ ] QuickenWindow.Business.ManageBusinessInformation.Select()
							[ ] 
							[ ] WaitForState(DlgManageBusinessInformation,10)
							[+] if(DlgManageBusinessInformation.Exists(5))
								[+] // Verify Edit button and check that it is in enable state
									[+] if(DlgManageBusinessInformation.ManageBusinessInformationList.EditButton.Exists(5))
										[ ] bEnable= DlgManageBusinessInformation.ManageBusinessInformationList.EditButton.IsEnabled()
										[+] if(bEnable==TRUE)
											[ ] ReportStatus("Verify Edit button on Manage Business Information dialog",PASS,"Edit button is enabled on Manage Business Information dialog")
											[ ] 
										[+] else
											[ ] ReportStatus("Verify Edit button on Manage Business Information dialog",FAIL,"Edit button is not enabled on Manage Business Information dialog")
											[ ] 
									[+] else
										[ ] ReportStatus("Verify Edit button on Manage Business Information dialog",FAIL,"Edit button is not present on Manage Business Information dialog")
										[ ] 
								[ ] 
								[+] // Verify Delete button and check that it is in enable state
									[+] if(DlgManageBusinessInformation.ManageBusinessInformationList.DeleteButton.Exists(5))
										[ ] bEnable= DlgManageBusinessInformation.ManageBusinessInformationList.DeleteButton.IsEnabled()
										[+] if(bEnable==TRUE)
											[ ] ReportStatus("Verify Delete button on Manage Business Information dialog",PASS,"Delete button is enabled on Manage Business Information dialog")
											[ ] 
										[+] else
											[ ] ReportStatus("Verify Delete button on Manage Business Information dialog",FAIL,"Delete button is not enabled on Manage Business Information dialog")
											[ ] 
									[+] else
										[ ] ReportStatus("Verify Delete button on Manage Business Information dialog",FAIL,"Delete button is not present on Manage Business Information dialog")
										[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] DlgManageBusinessInformation.Close()
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Manage Business Information dialog",FAIL,"Manage Business Information dialog is not opened")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Add Business",FAIL,"{sBusinessName} is not added successfully")
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Add Business dialog",FAIL,"Add Business dialog is not opened")
				[+] else
					[ ] ReportStatus("Verify Add button on Manage Business Information dialog",FAIL,"Add button is not present on Manage Business Information dialog")
					[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Manage Business Information dialog",FAIL,"Manage Business Information dialog is not opened")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#######################################################################
[ ] 
[+] //############# Verify Edit business functionality  #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_VerifyEditBusinessFunctionality()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit business functionality
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If  functionality passed for “Edit Business” dialog 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 10, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test10_VerifyEditBusinessFunctionality() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sSearchString,sBusinessName,sBusinessTag,sActualWindowName,sExpectedWindowName,sDescription,sOwner
		[ ] INTEGER iEditBusiness
		[ ] 
		[ ] sExpectedWindowName= "Edit Business"
		[ ] sSearchString="My Business"
		[ ] sBusinessName= "City Flowers"
		[ ] sDescription="Spouse business"
		[ ] sOwner= "Spouse"
		[ ] sBusinessTag = "Flowers"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Business menu > Manage Business Information
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.ManageBusinessInformation.Select()
		[ ] 
		[ ] WaitForState(DlgManageBusinessInformation,10)
		[+] if(DlgManageBusinessInformation.Exists(5))
			[ ] ReportStatus("Verify Manage Business Information dialog",PASS,"Manage Business Information dialog is opened")
			[ ] DlgManageBusinessInformation.SetActive()
			[ ] 
			[+] // Verify  Edit Business dialog and Edit business functionality
				[+] if(DlgManageBusinessInformation.ManageBusinessInformationList.EditButton.IsEnabled())
					[ ] DlgManageBusinessInformation.ManageBusinessInformationList.EditButton.Click()
					[+] if(DlgAddBusiness.Exists(5))
						[ ] sActualWindowName=DlgAddBusiness.GetCaption()
						[+] if(sActualWindowName==sExpectedWindowName)
							[ ] 
							[ ] ReportStatus("Verify Edit Business dialog",PASS,"Edit Business dialog is opened")
							[ ] 
							[ ] // Verify Business Name Field
							[+] if(DlgAddBusiness.BusinessNameTextField.Exists(5))
								[ ] ReportStatus("Verify Business Name field in Add Business dialog",PASS,"Business Name field is present in Edit Business dialog")
							[+] else
								[ ] ReportStatus("Verify Business Name field in Add Business dialog",FAIL,"Business Name field is not blank by default, Actual: {DlgAddBusiness.BusinessNameTextField.GetText()}")
								[ ] 
							[ ] 
							[ ] // Verify Description Field
							[+] if(DlgAddBusiness.DescriptionTextField.Exists(5))
								[ ] ReportStatus("Verify Business Description field in Add Business dialog",PASS,"Business Description field is present in Edit Business dialog")
							[+] else
								[ ] ReportStatus("Verify Business Description field in Add Business dialog",FAIL,"Business Description field is not present in Edit Business dialog")
								[ ] 
							[ ] 
							[ ] // Verify Owner radio list Field
							[+] if(DlgAddBusiness.DescriptionRadioList.Exists(5))
								[ ] ReportStatus("Verify Business Owner field in Add Business dialog",PASS,"Business Owner field is present in Edit Business dialog ")
							[+] else
								[ ] ReportStatus("Verify Business Owner field in Add Business dialog",FAIL,"Business Owner field is not present in Edit Business dialog")
								[ ] 
							[ ] 
							[ ] // Verify Business Tag Field
							[+] if(DlgAddBusiness.BusinessTagTextField.Exists(5))
								[ ] ReportStatus("Verify Business Tag field in Add Business dialog",PASS,"Business Tag field is present in Edit Business dialog")
							[+] else
								[ ] ReportStatus("Verify Business Tag field in Add Business dialog",FAIL,"Business Tag field is not present in Edit Business dialog")
								[ ] 
							[ ] 
							[ ] // Verify Business Transaction without the tag belong to this business checkbox
							[+] if(DlgAddBusiness.BusinessTransactionsWithout.Exists(5))
								[ ] ReportStatus("Verify Business Transaction without the tag belong to this business field in Add Business dialog",PASS,"Business Transaction without the tag belong to this business checkbox is present in Edit Business dialog")
							[+] else
								[ ] ReportStatus("Verify Business Transaction without the tag belong to this business field in Add Business dialog",FAIL,"Business Transaction without the tag belong to this business checkbox is not present in Edit Business dialog")
								[ ] 
							[ ] 
							[ ] // Verify Buttons on Edit Business window
							[+] if(DlgAddBusiness.OKButton.Exists(5))
								[ ] ReportStatus("Verify OK button in Edit Business dialog",PASS,"OK button is present on Edit Business window")
							[+] else
								[ ] ReportStatus("Verify OK button in Edit Business dialog",FAIL,"OK button is not present on Edit Business window")
								[ ] 
							[ ] 
							[+] if(DlgAddBusiness.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel button in Edit Business dialog",PASS,"Cancel button is present on Edit Business window")
							[+] else
								[ ] ReportStatus("Verify Cancel button in Edit Business dialog",FAIL,"Cancel button is not present on Edit Business window")
								[ ] 
							[ ] 
							[+] if(DlgAddBusiness.HelpButton.Exists(5))
								[ ] ReportStatus("Verify Help button in Edit Business dialog",PASS,"Help button is present on Edit Business window")
							[+] else
								[ ] ReportStatus("Verify Help button in Edit Business dialog",FAIL,"Help button is not present on Edit Business window")
								[ ] 
							[ ] 
							[ ] DlgAddBusiness.SetActive()
							[ ] DlgAddBusiness.CancelButton.Click()
							[ ] 
							[ ] DlgManageBusinessInformation.SetActive()
							[ ] DlgManageBusinessInformation.DoneButton.Click()
							[ ] 
							[ ] //Edit Business
							[ ] iEditBusiness=EditBusiness(sSearchString,sBusinessName,sBusinessTag,sDescription,sOwner,FALSE)
							[ ] 
							[+] if(iEditBusiness==PASS)
								[ ] ReportStatus("Verify Edit Business",PASS,"{sSearchString} is edited successfully with Business name -{sBusinessName}, Description-{sDescription}, Owner-{sOwner}, Business Tag- {sBusinessTag} ")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Edit Business",FAIL,"{sSearchString} is not edited successfully")
								[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Edit Business window caption",FAIL,"Edit Business window caption is not correct, Actual- {sActualWindowName} and Expected- {sExpectedWindowName}")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Edit Business dialog",FAIL,"Edit Business dialog is not opened")
				[+] else
					[ ] ReportStatus("Verify Edit button on Manage Business Information dialog",FAIL,"Edit button is not enabled on Manage Business Information dialog")
					[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Manage Business Information dialog",FAIL,"Manage Business Information dialog is not opened")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#######################################################################
[ ] 
[+] //############# Verify Add second business functionality  ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_VerifyAddSecondBusinessFunctionality()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify add second business functionality
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If  add second business functionality							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 13, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test11_VerifyAddSecondBusinessFunctionality() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sBusinessName,sBusinessTag
		[ ] INTEGER iAddBusiness
		[ ] 
		[ ] sBusinessName= "State Construction"
		[ ] sBusinessTag = "Construction"
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Verify  Add second Business dialog
		[ ] iAddBusiness=AddBusiness(sBusinessName,sBusinessTag)
		[+] if(iAddBusiness==PASS)
			[ ] ReportStatus("Verify Add Business {sBusinessName}",PASS,"{sBusinessName} is added successfully")
		[+] else
			[ ] ReportStatus("Verify Add Business {sBusinessName}",FAIL,"{sBusinessName} is not added successfully")
			[ ] 
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#######################################################################
[ ] 
[+] //#############Verify Addition of Bills ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_VerifyAdditionBills()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify addition of bills 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If  functionality passed for “Edit Business” dialog 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 13, 2013		Anagha created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test12_VerifyAdditionBills() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] LIST OF ANYTYPE lsBusiness,lsBill
		[ ] sExcelSheet = "BusinessTestData"
		[ ] sBusinessSheet = "Business"
		[ ] sBillSheet = "BillReminderData"
		[ ] 
		[ ] 
	[ ] //Retrieving Data from ExcelSheet
	[ ] lsExcelData=ReadExcelTable(sExcelSheet, sBusinessSheet)
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Retrieving Data from ExcelSheet
		[ ] lsExcelData=ReadExcelTable(sExcelSheet, sBillSheet)
		[ ] 
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] lsBill = lsExcelData[i]
			[+] if(lsBill[1]==NULL)
				[ ] break
			[ ] lsBill[2] = sDateStamp
			[ ] //Add Bill Reminder
			[ ] iResult = AddBillReminderForBusinessAccount(lsBill[1],lsBill[2],lsBill[3],lsBill[4],lsBill[5],lsBill[6])
			[ ] 
			[+] if(iResult == PASS)
				[ ] ReportStatus("Verify Bill Reminder got added",PASS,"Bill Reminder for {lsBill[1]} got added successfully")
			[+] else
				[ ] ReportStatus("Verify Bill Reminder got added",FAIL,"Bill Reminder for {lsBill[1]} not got added successfully")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
[ ] //######################################################################
[ ] 
[+] //#############Verify data on Profit/loss page #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_VerifyDataonProfitLoss()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify data on Profit/loss page.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If  functionality passed for “Edit Business” dialog 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 13, 2013		Anagha created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test13_VerifyDataOnProfitLoss() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] LIST OF ANYTYPE lsBusiness,lsBill
		[ ] LIST OF STRING lsExpectedIN,lsExpectedOUT,lsExpectedPROFIT,lsAmount,lsTotal
		[ ] 
		[ ] sExcelSheet = "BusinessTestData"
		[ ] sBusinessSheet = "Business"
		[ ] sBillSheet = "BillReminderData"
		[ ] sExpectedSheet = "Expected Result"
		[ ] lsTotal = {"$0.00","$40.00"}
		[ ] 
		[ ] 
	[+] //Retrieving Data from ExcelSheet
		[ ] lsExcelData=ReadExcelTable(sExcelSheet, sExpectedSheet)
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] ListAppend(lsExpectedIN,lsExcelData[i][1])
			[ ] ListAppend(lsExpectedIN,lsExcelData[i][2])
			[ ] ListAppend(lsExpectedOUT,lsExcelData[i][3])
			[ ] ListAppend(lsExpectedOUT,lsExcelData[i][4])
			[ ] ListAppend(lsExpectedPROFIT,lsExcelData[i][5])
			[ ] ListAppend(lsExpectedPROFIT,lsExcelData[i][6])
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sExcelSheet, sBusinessSheet)
		[ ] //sBusinessName = lsExcelData[2][1]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigate to Business Tab
		[ ] NavigateQuickenTab(sTAB_BUSINESS,sTAB_PROFIT_LOSS)
		[ ] 
		[+] //Verify the data for the "All Businesses" businesson Profit/loss page.
			[ ] Business.BusinessPopupList.Select("All Businesses")
			[ ] 
			[ ] //Verify the data on the "IN" snapshot.
			[+] if(Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.Exists(5))
				[ ] ReportStatus("Verify 'IN' snapshot on Business >> Profit/Loss Tab exists ",PASS,"'IN' snapshot on Business >> Profit/Loss Tab is present ")
				[ ] 
				[ ] //Verify the Items present in IN snapshot
				[ ] sHandle=str(Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetHandle())
				[+] for each sItem in lsExpectedIN
					[+] for( iCounter=0;iCounter<Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetItemCount();iCounter++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
						[ ] bMatch=MatchStr("*{sItem}*",sActual)
						[+] if(bMatch== TRUE)
							[ ] break
					[+] if(bMatch ==TRUE)
						[ ] ReportStatus("Verify 'IN' snapshot includes  items  ",PASS,"{sItem} is included in 'IN' snapshot on Business >> Profit/Loss Tab successfully")
					[+] else
						[ ] ReportStatus("Verify 'IN' snapshot includes  items ",FAIL,"{sItem},{sActual} is not included in 'IN' snapshot on Business >> Profit/Loss Tab successfully")
				[ ] 
				[ ] //Verify the Total in IN snapshot
				[ ] sTotal=Business.ProfitLossSnapshot.MonthPanel.TotalIn.GetText()
				[+] if(lsTotal[1] ==sTotal )
					[ ] ReportStatus("Verify 'IN' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'All Businesses' business  ",PASS,"{sTotal} is included in 'IN' snapshot on Business >> Profit/Loss Tab for 'All Businesses' business  successfully")
				[+] else
					[ ] ReportStatus("Verify 'IN' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'All Businesses' business  ",FAIL,"{lsTotal[1]},{sTotal} is not included in 'IN' snapshot on Business >> Profit/Loss Tab for 'All Businesses' business  successfully")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify 'IN' snapshot on Business >> Profit/Loss Tab exists ",FAIL,"'IN' snapshot on Business >> Profit/Loss Tab is not present ")
			[ ] 
			[+] if(Business.SnapShotGraph.Panel1.OUTSnopshot.ListBox1.Exists(5))
				[ ] ReportStatus("Verify 'OUT' snapshot on Business >> Profit/Loss Tab exists ",PASS,"'OUT' snapshot on Business >> Profit/Loss Tab is present ")
				[ ] 
				[ ] ///Verify the Items present in OUT snapshot
				[ ] sHandle=str(Business.SnapShotGraph.Panel1.OUTSnopshot.ListBox1.GetHandle())
				[+] for each sItem in lsExpectedOUT
					[+] for( iCounter=0;iCounter<Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetItemCount();iCounter++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
						[ ] bMatch=MatchStr("*{sItem}*",sActual)
						[+] if(bMatch== TRUE)
							[ ] break
					[+] if(bMatch ==TRUE)
						[ ] ReportStatus("Verify 'OUT' snapshot includes  items on  ",PASS,"{sItem} is included in 'OUT' snapshot on Business >> Profit/Loss Tab successfully")
					[+] else
						[ ] ReportStatus("Verify 'OUT' snapshot includes  items on  ",FAIL,"{sItem},{sActual} is not included in 'OUT' snapshot on Business >> Profit/Loss Tab successfully")
				[ ] 
				[ ] //Verify the Total in OUT snapshot
				[ ] sTotal=Business.ProfitLossSnapshot.MonthPanel.TotalOut.GetText()
				[+] if(lsTotal[2] ==sTotal )
					[ ] ReportStatus("Verify 'OUT' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'All Businesses' business ",PASS,"{sTotal} is included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'All Businesses' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'OUT' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'All Businesses' business",FAIL,"{lsTotal[2]},{sTotal} is not included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'All Businesses' business successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify 'OUT' snapshot on Business >> Profit/Loss Tab exists ",FAIL,"'OUT' snapshot on Business >> Profit/Loss Tab is not present ")
			[ ] 
			[+] if(Business.SnapShotGraph.Panel1.Profit1.ListBox1.Exists(5))
				[ ] ReportStatus("Verify 'Profit/Loss' snapshot on Business >> Profit/Loss Tab exists ",PASS,"'Profit/Loss' snapshot on Business >> Profit/Loss Tab is present ")
				[ ] 
				[ ] //Verify the data on the "Profit/Loss" snapshot.
				[ ] sHandle=str(Business.SnapShotGraph.Panel1.Profit1.ListBox1.GetHandle())
				[ ] sItem=trim(lsExpectedPROFIT[1])
				[+] for( iCounter=0;iCounter<Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetItemCount();iCounter++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
					[ ] bMatch=MatchStr("*{sItem}*",sActual)
					[+] if(bMatch== TRUE)
						[ ] break
				[+] if(bMatch ==TRUE)
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'All Businesses' business  ",PASS,"{sItem} is included in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'All Businesses' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'All Businesses' business  ",FAIL,"{sItem},{sActual} is not included in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'All Businesses' business successfully")
				[ ] ////Verify projected loss amount
				[ ] sItem=NULL
				[ ] sActual=NULL
				[ ] sItem=trim(lsExpectedPROFIT[2])
				[ ] sActual=Business.ProjectedLossText.GetText()
				[ ] 
				[+] if(sActual ==sItem)
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'All Businesses' business  ",PASS,"Projected Loss is as expected:{sItem} in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'All Businesses' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'All Businesses' business  ",FAIL,"Projected Loss actual: {sActual} is NOT as expected:{sItem} in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'All Businesses' business successfully")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify 'Profit/Loss' snapshot on Business >> Profit/Loss Tab exists ",FAIL,"'Profit/Loss' snapshot on Business >> Profit/Loss Tab is not present ")
			[ ] 
			[ ] 
		[ ] 
		[+] //Verify the data for the "City Flowers" businesson Profit/loss page.
			[ ] Business.BusinessPopupList.Select("City Flowers")
			[ ] 
			[ ] //Verify the data on the "IN" snapshot.
			[+] if(Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.Exists(5))
				[ ] ReportStatus("Verify 'IN' snapshot on Business >> Profit/Loss Tab exists ",PASS,"'IN' snapshot on Business >> Profit/Loss Tab is present ")
				[ ] 
				[ ] //Verify the Items present in IN snapshot
				[ ] sHandle=str(Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetHandle())
				[+] for each sItem in lsExpectedIN
					[+] for( iCounter=0;iCounter<Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetItemCount();iCounter++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
						[ ] bMatch=MatchStr("*{sItem}*",sActual)
						[+] if(bMatch== TRUE)
							[ ] break
					[+] if(bMatch ==TRUE)
						[ ] ReportStatus("Verify 'IN' snapshot includes  items on Business >> Profit/Loss Tab for 'City Flowers' business ",PASS,"{sItem} is included in 'IN' snapshot on Business >> Profit/Loss Tab for 'City Flowers' business  successfully")
					[+] else
						[ ] ReportStatus("Verify 'IN' snapshot includes  items on Business >> Profit/Loss Tab for 'City Flowers' business  ",FAIL,"{sItem},{sActual} is not included in 'IN' snapshot Business >> Profit/Loss Tab for 'City Flowers' business  successfully")
				[ ] 
				[ ] //Verify the Total in IN snapshot
				[ ] sTotal=Business.ProfitLossSnapshot.MonthPanel.TotalIn.GetText()
				[+] if(lsTotal[1] ==sTotal )
					[ ] ReportStatus("Verify 'IN' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'City Flowers' business ",PASS,"{sTotal} is included in 'IN' snapshot on Business >> Profit/Loss Tab for 'City Flowers' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'IN' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'City Flowers' business ",FAIL,"{lsTotal[1]},{sTotal} is not included in 'IN' snapshot on Business >> Profit/Loss Tab for 'City Flowers' business successfully")
				[ ] 
			[+] else
				[+] ReportStatus("Verify 'IN' snapshot on Business >> Profit/Loss Tab exists ",FAIL,"'IN' snapshot on Business >> Profit/Loss Tab is not present ")
							[ ] 
			[ ] 
			[ ] 
			[+] if(Business.SnapShotGraph.Panel1.OUTSnopshot.ListBox1.Exists(5))
				[ ] ReportStatus("Verify 'OUT' snapshot on Business >> Profit/Loss Tab exists ",PASS,"'OUT' snapshot on Business >> Profit/Loss Tab is present ")
				[ ] 
				[ ] lsExpectedOUT[2] = "0.00"
				[ ] lsExpectedOUT[4] = "10.00"
				[ ] 
				[ ] ///Verify the Items present in OUT snapshot
				[ ] sHandle=str(Business.SnapShotGraph.Panel1.OUTSnopshot.ListBox1.GetHandle())
				[+] for each sItem in lsExpectedOUT
					[+] for( iCounter=0;iCounter<Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetItemCount();iCounter++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
						[ ] bMatch=MatchStr("*{sItem}*",sActual)
						[+] if(bMatch== TRUE)
							[ ] break
					[+] if(bMatch ==TRUE)
						[ ] ReportStatus("Verify 'OUT' snapshot includes  items on Business >> Profit/Loss Tab for 'City Flowers' business  ",PASS,"{sItem} is included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'City Flowers' business successfully")
					[+] else
						[ ] ReportStatus("Verify 'OUT' snapshot includes  items on Business >> Profit/Loss Tab for 'City Flowers' business  ",FAIL,"{sItem},{sActual} is not included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'City Flowers' business successfully")
				[ ] 
				[ ] //Verify the Total in OUT snapshot
				[ ] lsTotal[2] = "$10.00"
				[ ] sTotal=Business.ProfitLossSnapshot.MonthPanel.TotalOut.GetText()
				[+] if(lsTotal[2] ==sTotal )
					[ ] ReportStatus("Verify 'OUT' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'City Flowers' business",PASS,"{sTotal} is included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'City Flowers' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'OUT' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'City Flowers' business ",FAIL,"{lsTotal[2]},{sTotal} is not included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'City Flowers' business successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify 'OUT' snapshot on Business >> Profit/Loss Tab exists ",FAIL,"'OUT' snapshot on Business >> Profit/Loss Tab is not present ")
			[ ] 
			[+] if(Business.SnapShotGraph.Panel1.Profit1.ListBox1.Exists(5))
				[ ] ReportStatus("Verify 'Profit/Loss' snapshot on Business >> Profit/Loss Tab exists ",PASS,"'Profit/Loss' snapshot on Business >> Profit/Loss Tab is present ")
				[ ] 
				[ ] lsExpectedPROFIT[2] = "-$10.00"
				[ ] 
				[ ] //Verify the data on the "Profit/Loss" snapshot.
				[ ] sHandle=str(Business.SnapShotGraph.Panel1.Profit1.ListBox1.GetHandle())
				[ ] sItem=trim(lsExpectedPROFIT[1])
				[+] for( iCounter=0;iCounter<Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetItemCount();iCounter++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
					[ ] bMatch=MatchStr("*{sItem}*",sActual)
					[+] if(bMatch== TRUE)
						[ ] break
				[+] if(bMatch ==TRUE)
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'City Flowers' business  ",PASS,"{sItem} is included in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'City Flowers' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'City Flowers' business  ",FAIL,"{sItem},{sActual} is not included in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'City Flowers' business successfully")
				[ ] ////Verify projected loss amount
				[ ] sItem=NULL
				[ ] sActual=NULL
				[ ] sItem=trim(lsExpectedPROFIT[2])
				[ ] sActual=Business.ProjectedLossText.GetText()
				[ ] 
				[+] if(sActual ==sItem)
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'City Flowers' business  ",PASS,"Projected Loss is as expected:{sItem} in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'City Flowers' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'City Flowers' business  ",FAIL,"Projected Loss actual: {sActual} is NOT as expected:{sItem} in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'City Flowers' business successfully")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify 'Profit/Loss' snapshot on Business >> Profit/Loss Tab exists ",FAIL,"'Profit/Loss' snapshot on Business >> Profit/Loss Tab is not present ")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[+] //Verify the data for the "State Construction" businesson Profit/loss page.
			[ ] Business.BusinessPopupList.Select("State Construction")
			[ ] 
			[ ] //Verify the data on the "IN" snapshot.
			[+] if(Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.Exists(5))
				[ ] ReportStatus("Verify 'IN' snapshot on Business >> Profit/Loss Tab exists ",PASS,"'IN' snapshot on Business >> Profit/Loss Tab is present ")
				[ ] 
				[ ] //Verify the Items present in IN snapshot
				[ ] sHandle=str(Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetHandle())
				[+] for each sItem in lsExpectedIN
					[+] for( iCounter=0;iCounter<Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetItemCount();iCounter++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
						[ ] bMatch=MatchStr("*{sItem}*",sActual)
						[+] if(bMatch== TRUE)
							[ ] break
					[+] if(bMatch ==TRUE)
						[ ] ReportStatus("Verify 'IN' snapshot includes  items on Business >> Profit/Loss Tab for 'State Construction' business  ",PASS,"{sItem} is included in 'IN' snapshot on Business >> Profit/Loss Tab for 'State Construction' business successfully")
					[+] else
						[ ] ReportStatus("Verify 'IN' snapshot includes  items on Business >> Profit/Loss Tab for 'State Construction' business  ",FAIL,"{sItem},{sActual} is not included in 'IN' snapshot on Business >> Profit/Loss Tab for 'State Construction' business successfully")
				[ ] 
				[ ] //Verify the Total in IN snapshot
				[ ] sTotal=Business.ProfitLossSnapshot.MonthPanel.TotalIn.GetText()
				[+] if(lsTotal[1] ==sTotal )
					[ ] ReportStatus("Verify 'IN' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'State Construction' business",PASS,"{sTotal} is included in 'IN' snapshot on Business >> Profit/Loss Tab for 'State Construction' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'IN' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'State Construction' business ",FAIL,"{lsTotal[1]},{sTotal} is not included in 'IN' snapshot on Business >> Profit/Loss Tab for 'State Construction' business successfully")
				[ ] 
				[ ] 
			[+] else
				[+] ReportStatus("Verify 'IN' snapshot on Business >> Profit/Loss Tab exists ",FAIL,"'IN' snapshot on Business >> Profit/Loss Tab is not present ")
							[ ] 
			[ ] 
			[ ] 
			[+] if(Business.SnapShotGraph.Panel1.OUTSnopshot.ListBox1.Exists(5))
				[ ] ReportStatus("Verify 'OUT' snapshot on Business >> Profit/Loss Tab exists ",PASS,"'OUT' snapshot on Business >> Profit/Loss Tab is present ")
				[ ] 
				[ ] lsExpectedOUT[2] = "0.00"
				[ ] lsExpectedOUT[4] = "20.00"
				[ ] 
				[ ] ///Verify the Items present in OUT snapshot
				[ ] sHandle=str(Business.SnapShotGraph.Panel1.OUTSnopshot.ListBox1.GetHandle())
				[+] for each sItem in lsExpectedOUT
					[+] for( iCounter=0;iCounter<Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetItemCount();iCounter++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
						[ ] bMatch=MatchStr("*{sItem}*",sActual)
						[+] if(bMatch== TRUE)
							[ ] break
					[+] if(bMatch ==TRUE)
						[ ] ReportStatus("Verify 'OUT' snapshot includes  items on Business >> Profit/Loss Tab for 'State Construction' business  ",PASS,"{sItem} is included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'State Construction' business successfully")
					[+] else
						[ ] ReportStatus("Verify 'OUT' snapshot includes  items on Business >> Profit/Loss Tab for 'State Construction' business  ",FAIL,"{sItem},{sActual} is not included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'State Construction' business successfully")
				[ ] 
				[ ] //Verify the Total in OUT snapshot
				[ ] lsTotal[2] = "$20.00"
				[ ] sTotal=Business.ProfitLossSnapshot.MonthPanel.TotalOut.GetText()
				[+] if(lsTotal[2] ==sTotal )
					[ ] ReportStatus("Verify 'OUT' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'State Construction' business",PASS,"{sTotal} is included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'State Construction' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'OUT' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'State Construction' business",FAIL,"{lsTotal[2]},{sTotal} is not included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'State Construction' business successfully")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify 'OUT' snapshot on Business >> Profit/Loss Tab exists ",FAIL,"'OUT' snapshot on Business >> Profit/Loss Tab is not present ")
			[ ] 
			[+] if(Business.SnapShotGraph.Panel1.Profit1.ListBox1.Exists(5))
				[ ] ReportStatus("Verify 'Profit/Loss' snapshot on Business >> Profit/Loss Tab exists ",PASS,"'Profit/Loss' snapshot on Business >> Profit/Loss Tab is present ")
				[ ] 
				[ ] lsExpectedPROFIT[2] = "-$20.00"
				[ ] 
				[ ] //Verify the data on the "Profit/Loss" snapshot.
				[ ] sHandle=str(Business.SnapShotGraph.Panel1.Profit1.ListBox1.GetHandle())
				[ ] sItem=trim(lsExpectedPROFIT[1])
				[+] for( iCounter=0;iCounter<Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetItemCount();iCounter++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
					[ ] bMatch=MatchStr("*{sItem}*",sActual)
					[+] if(bMatch== TRUE)
						[ ] break
				[+] if(bMatch ==TRUE)
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'State Construction' business  ",PASS,"{sItem} is included in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'State Construction' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'State Construction' business  ",FAIL,"{sItem},{sActual} is not included in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'State Construction' business successfully")
				[ ] ////Verify projected loss amount
				[ ] sItem=NULL
				[ ] sActual=NULL
				[ ] sItem=trim(lsExpectedPROFIT[2])
				[ ] sActual=Business.ProjectedLossText.GetText()
				[ ] 
				[+] if(sActual ==sItem)
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'State Construction' business  ",PASS,"Projected Loss is as expected:{sItem} in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'State Construction' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'State Construction' business  ",FAIL,"Projected Loss actual: {sActual} is NOT as expected:{sItem} in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'State Construction' business successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify 'Profit/Loss' snapshot on Business >> Profit/Loss Tab exists ",FAIL,"'Profit/Loss' snapshot on Business >> Profit/Loss Tab is not present ")
			[ ] 
		[+] //Verify the data for the "Unknown Business" businesson Profit/loss page.
			[ ] Business.BusinessPopupList.Select("#4")
			[ ] 
			[ ] //Verify the data on the "IN" snapshot.
			[+] if(Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.Exists(5))
				[ ] ReportStatus("Verify 'IN' snapshot on Business >> Profit/Loss Tab exists ",PASS,"'IN' snapshot on Business >> Profit/Loss Tab is present ")
				[ ] 
				[ ] //Verify the Items present in IN snapshot
				[ ] sHandle=str(Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetHandle())
				[+] for each sItem in lsExpectedIN
					[+] for( iCounter=0;iCounter<Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetItemCount();iCounter++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
						[ ] bMatch=MatchStr("*{sItem}*",sActual)
						[+] if(bMatch== TRUE)
							[ ] break
					[+] if(bMatch ==TRUE)
						[ ] ReportStatus("Verify 'IN' snapshot includes  items on Business >> Profit/Loss Tab for 'Unknown Business' business  ",PASS,"{sItem} is included in 'IN' snapshot on Business >> Profit/Loss Tab for 'Unknown Business' business successfully")
					[+] else
						[ ] ReportStatus("Verify 'IN' snapshot includes  items on Business >> Profit/Loss Tab for 'Unknown Business' business  ",FAIL,"{sItem},{sActual} is not included in 'IN' snapshot on Business >> Profit/Loss Tab for 'Unknown Business' business successfully")
				[ ] 
				[ ] //Verify the Total in IN snapshot
				[ ] sTotal=Business.ProfitLossSnapshot.MonthPanel.TotalIn.GetText()
				[+] if(lsTotal[1] ==sTotal )
					[ ] ReportStatus("Verify 'IN' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'Unknown Business' business",PASS,"{sTotal} is included in 'IN' snapshot on Business >> Profit/Loss Tab for 'Unknown Business' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'IN' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'Unknown Business' business ",FAIL,"{lsTotal[1]},{sTotal} is not included in 'IN' snapshot on Business >> Profit/Loss Tab for 'State Construction' business successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify 'IN' snapshot on Business >> Profit/Loss Tab exists ",FAIL,"'IN' snapshot on Business >> Profit/Loss Tab is NOT present ")
			[+] if(Business.SnapShotGraph.Panel1.OUTSnopshot.ListBox1.Exists(5))
				[ ] ReportStatus("Verify 'OUT' snapshot on Business >> Profit/Loss Tab exists ",PASS,"'OUT' snapshot on Business >> Profit/Loss Tab is present ")
				[ ] 
				[ ] lsExpectedOUT[2] = "0.00"
				[ ] lsExpectedOUT[4] = "10.00"
				[ ] 
				[ ] ///Verify the Items present in OUT snapshot
				[ ] sHandle=str(Business.SnapShotGraph.Panel1.OUTSnopshot.ListBox1.GetHandle())
				[+] for each sItem in lsExpectedOUT
					[+] for( iCounter=0;iCounter<Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetItemCount();iCounter++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
						[ ] bMatch=MatchStr("*{sItem}*",sActual)
						[+] if(bMatch== TRUE)
							[ ] break
					[+] if(bMatch ==TRUE)
						[ ] ReportStatus("Verify 'OUT' snapshot includes  items on Business >> Profit/Loss Tab for 'Unknown Business' business  ",PASS,"{sItem} is included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'Unknown Business' business successfully")
					[+] else
						[ ] ReportStatus("Verify 'OUT' snapshot includes  items on Business >> Profit/Loss Tab for 'Unknown Business' business  ",FAIL,"{sItem},{sActual} is not included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'Unknown Business' business successfully")
				[ ] 
				[ ] //Verify the Total in OUT snapshot
				[ ] lsTotal[2] = "$10.00"
				[ ] sTotal=Business.ProfitLossSnapshot.MonthPanel.TotalOut.GetText()
				[+] if(lsTotal[2] ==sTotal )
					[ ] ReportStatus("Verify 'OUT' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'Unknown Business' business",PASS,"{sTotal} is included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'Unknown Business' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'OUT' snapshot includes Total Amount items on Business >> Profit/Loss Tab for 'Unknown Business' business",FAIL,"{lsTotal[2]},{sTotal} is not included in 'OUT' snapshot on Business >> Profit/Loss Tab for 'Unknown Business' business successfully")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify 'OUT' snapshot on Business >> Profit/Loss Tab exists ",FAIL,"'OUT' snapshot on Business >> Profit/Loss Tab is NOT present ")
			[+] if(Business.SnapShotGraph.Panel1.Profit1.ListBox1.Exists(5))
				[ ] ReportStatus("Verify 'Profit/Loss' snapshot on Business >> Profit/Loss Tab exists ",PASS,"'Profit/Loss' snapshot on Business >> Profit/Loss Tab is present ")
				[ ] 
				[ ] lsExpectedPROFIT[2] = "-$10.00"
				[ ] 
				[ ] //Verify the data on the "Profit/Loss" snapshot.
				[ ] sHandle=str(Business.SnapShotGraph.Panel1.Profit1.ListBox1.GetHandle())
				[ ] sItem=trim(lsExpectedPROFIT[1])
				[+] for( iCounter=0;iCounter<Business.SnapShotGraph.Panel1.INSnopshot.ListBox1.GetItemCount();iCounter++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,"{iCounter}")
					[ ] bMatch=MatchStr("*{sItem}*",sActual)
					[+] if(bMatch== TRUE)
						[ ] break
				[+] if(bMatch ==TRUE)
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'Unknown Business' business  ",PASS,"{sItem} is included in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'Unknown Business' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes  items on Business >> Profit/Loss Tab for 'Unknown Business' business  ",FAIL,"{sItem},{sActual} is not included in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'Unknown Business' business successfully")
				[ ] ////Verify projected loss amount
				[ ] sItem=NULL
				[ ] sActual=NULL
				[ ] sItem=trim(lsExpectedPROFIT[2])
				[ ] sActual=Business.ProjectedLossText.GetText()
				[ ] 
				[+] if(sActual ==sItem)
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes items on Business >> Profit/Loss Tab for 'Unknown Business' business  ",PASS,"Projected Loss is as expected:{sItem} in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'Unknown Business' business successfully")
				[+] else
					[ ] ReportStatus("Verify 'PROFIT/LOSS' snapshot includes items on Business >> Profit/Loss Tab for 'Unknown Business' business  ",FAIL,"Projected Loss actual: {sActual} is NOT as expected:{sItem} in 'PROFIT/LOSS' snapshot on Business >> Profit/Loss Tab for 'Unknown Business' business successfully")
			[+] else
				[ ] ReportStatus("Verify 'Profit/Loss' snapshot on Business >> Profit/Loss Tab exists ",FAIL,"'Profit/Loss' snapshot on Business >> Profit/Loss Tab is NOT present ")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
	[ ] 
	[ ] 
[ ] //######################################################################
[ ] 
[+] //#############Verify data on the business report. ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_VerifyDataonBusinessReport()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify data on the business report.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If  functionality passed for “business report” dialog 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 13, 2013		Anagha created
	[ ] 
	[ ] // ********************************************************
	[ ] 
[+] testcase Test14_VerifyDataonBusinessReport() appstate none
	[ ] 
	[-] // Variable declaration
		[ ] STRING sItem
		[ ] LIST OF STRING lsExpected
		[ ] 
		[ ] sExcelSheet = "BusinessTestData"
		[ ] sBusinessSheet = "Business"
		[ ] sReportSheet = "Expected Details in Report"
		[ ] 
		[ ] 
		[ ] 
	[-] //Retrieving Data from ExcelSheet
		[ ] lsExcelData=ReadExcelTable(sExcelSheet, sReportSheet)
		[-] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] ListAppend(lsExpected,lsExcelData[i][1])
			[ ] ListAppend(lsExpected,lsExcelData[i][2])
	[ ] 
	[-] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigate to Bills Tab
		[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
		[ ] 
		[ ] //Enter all the Scheduled Bill Reminder as transaction in Account Register
		[ ] 
		[-] if(MDIClient.Bills.Exists(5))
			[ ] ENTERBILL:
			[ ] // Verify the GET STARTED Button to check no bills are remaining to add in Account Register
			[+] if(MDIClient.Bills.Enter.Exists(5))
				[ ] 
				[ ] MDIClient.Bills.ViewAsPopupList.Select("Stack")
				[ ] 
				[ ] MDIClient.Bills.AccountPopupList.Select("All Accounts")
				[ ] 
				[ ] MDIClient.Bills.Enter.Click()
				[ ] 
				[ ] EnterTransaction.EnterTransactionButton.Click()
				[ ] 
				[ ] NavigateQuickenTab(sTAB_BILL)
				[ ] 
				[ ] goto ENTERBILL
				[ ] 
			[ ] 
			[+] else if(!MDIClient.Bills.Enter.Exists(5))
				[ ] ReportStatus("Verify the Enter Button to check no bills are remaining to add in Account Register ",PASS,"'All the Bill Reminders has got add in Account Register ")
				[ ] 
				[ ] //Verify Data in Business Report
				[ ] QuickenWindow.Business.Click()
				[ ] QuickenWindow.Business.BusinessReports.Click()
				[ ] QuickenWindow.Business.BusinessReports.ScheduleCProfitOrLossFrom.Select()
				[ ] 
				[+] if(ScheduleCReport.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Schedule C-Profit or Loss from Business Report ", PASS , "Schedule C-Profit or Loss from Business Report  is displayed")
					[ ] 
					[ ] sHandle = Str(ScheduleCReport.QWListViewer1.ListBox1.GetHandle())
					[ ] //Verify data on the Schedule C-Profit or Loss from Business Report.
					[+] for each sItem in lsExpected
						[+] for(iCounter=1;iCounter <=ScheduleCReport.QWListViewer1.ListBox1.GetItemCount();iCounter++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}") 
							[ ] bMatch= MatchStr("*{sItem}*", sActual)
							[+] if(bMatch == TRUE)
								[ ] break
							[ ] 
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Verify data on the Schedule C-Profit or Loss from Business Report",PASS ,"{sItem} data is present in Schedule C-Profit or Loss from Business Report")
					[+] else
						[ ] ReportStatus("Verify data on the Schedule C-Profit or Loss from Business Report",FAIL ," Expected : {sItem} , Actual : {sActual}, Hence data is not present in Schedule C-Profit or Loss from Business Report")
				[+] else
					[ ] ReportStatus("Verify Schedule C-Profit or Loss from Business Report ", FAIL , "Schedule C-Profit or Loss from Business Report  is not displayed")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify the Enter Button to check no bills are remaining to add in Account Register ",FAIL,"All the Bill Reminders couldn't be added to the Account Register")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Bills dialog", FAIL , "Bills dialog is not present")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
	[ ] 
	[ ] 
[ ] //#####################################################################
[ ] 
[+] //#############Verify data on Vehicle Mileage tracker. ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_VerifyDataonVehicleMileageTracker()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify data in Vehicle Mileage tracker dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If  functionality passed for “Edit Business” dialog 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 13, 2013		Anagha created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test15_VerifyDataonVehicleMileageTracker() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] STRING sItem
		[ ] LIST OF STRING lsExpected,lsActual
		[ ] 
		[ ] sExcelSheet = "BusinessTestData"
		[ ] sBusinessSheet = "Business"
		[ ] 
		[ ] 
		[ ] 
	[+] //Retrieving Data from ExcelSheet
		[ ] lsExcelData=ReadExcelTable(sExcelSheet, sBusinessSheet)
		[ ] lsExpected ={"No business name"}
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] ListAppend(lsExpected,lsExcelData[i][1])
			[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Verify Data in VehicleMileageTracker
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.MileageTracker.Select()
		[ ] 
		[+] if(DlgVehicleMileage.Exists(5))
			[ ] 
			[ ] ReportStatus("Verify Vehicle Mileage Tracker Dialog ", PASS , "Vehicle Mileage Tracker Dialog  is displayed")
			[ ] 
			[ ] lsActual =DlgVehicleMileage.BusinessNamePopupList.GetContents()
			[ ] 
			[ ] //Verify data on  Vehicle Mileage Tracker dialog.
			[+] for each sItem in lsExpected
				[+] for(iCounter=1;iCounter <=ListCount(lsActual);iCounter++)
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}") 
					[ ] bMatch= MatchStr("*{sItem}*", trim(lsActual[iCounter]))
					[+] if(bMatch == TRUE)
						[ ] break
					[ ] 
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Verify data on the Vehicle Mileage Tracker Dialog",PASS ,"{sItem} data is present in Business Name on Vehicle Mileage Tracker Dialog")
			[+] else
				[ ] ReportStatus("Verify data on the Vehicle Mileage Tracker Dialog",FAIL ," Expected : {sItem} , Actual : {lsActual[iCounter]}, Hence data is not present in Business Name on Vehicle Mileage Tracker Dialog")
			[ ] 
			[ ] DlgVehicleMileage.SetActive()
			[ ] DlgVehicleMileage.Close()
			[ ] WaitForState(DlgVehicleMileage , False ,5)
		[+] else
			[ ] ReportStatus("Verify Vehicle Mileage Tracker Dialog ", FAIL , "Vehicle Mileage Tracker Dialog  is displayed")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
[ ] //#####################################################################
[ ] 
[ ] /////////////////////////////////////////////Business Register ////////////////////////////////////////////////////////////////////
[ ] 
[+] //############# SetUp ####################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Business_SetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the QDF if it exists. It will add few spending account and some business account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 02, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase BusinessRegister_SetUp () appstate QuickenBaseState
	[ ] 
	[+] //---------- Variable declaration---------------
		[ ] sFileName = "BusinessRegister"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sSourceFile = AUT_DATAFILE_PATH + "\Business Data File\" + sFileName + ".QDF"
		[ ] 
	[ ] 
	[ ] 
	[+] if(FileExists(sDataFile) == TRUE)
		[+] if(QuickenWindow.Exists(SHORT_SLEEP))
			[ ] QuickenWindow.Exit()
			[ ] WaitForState(QuickenWindow,FALSE,5)
		[ ] DeleteFile(sDataFile)
	[ ] CopyFile(sSourceFile,sDataFile)
	[ ] 
	[+] if (!QuickenWindow.Exists(5))
		[ ] App_Start(sCmdLine)
		[ ] WaitForState(QuickenWindow, TRUE ,15)
	[ ] 
	[+] if (QuickenWindow.Exists(20))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //------------------ Open Data File------------------
		[ ] iOpenDataFile = OpenDataFile(sFileName)
		[ ] 
		[ ] // ------------------Report Staus If Data file opened successfully------------------
		[+] if ( iOpenDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sDataFile} is opened")
			[ ] //RegisterQuickenConnectedServices()
		[+] else 
			[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sDataFile} is not opened")
		[ ] 
		[ ] SetViewMode(VIEW_CLASSIC_MENU)
		[ ] UsePopupRegister("OFF")
	[ ] 
[ ] //######################################################################
[ ] 
[+] //############# Verify sub-menu item present under the Business menu ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_VerifySubMenuOfBusiness()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify sub-menu item present under the Business menu.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 13, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test03_VerifySubMenuOfBusiness() appstate none
	[ ] 
	[+] //---------- Variable declaration----------
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] // ----------Profit Loss Tab----------
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.ProfitLoss.Select()
		[ ] 
		[+] if(MDIClient.Business.ProfitLossDetails.Exists(5))
			[ ] ReportStatus("Verify Profit Loss Tab",PASS,"Profit Loss Tab is present from menu")
		[+] else
			[ ] ReportStatus("Verify Profit Loss Tab",FAIL,"Profit Loss Tab is not present from menu")
			[ ] 
		[ ] 
		[ ] // ----------Cash Flow Tab----------
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.CashFlow.Select()
		[ ] Sleep(2)
		[+] if(MDIClient.Business.CashFlowDetails.Exists(5))
			[ ] ReportStatus("Verify Cash Flow Tab",PASS,"Cash Flow Tab is present from menu")
		[+] else
			[ ] ReportStatus("Verify Cash Flow Tab",FAIL,"Cash Flow Tab is not present from menu")
			[ ] 
		[ ] 
		[ ] // Account Overview Tab
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.AccountOverview.Select()
		[ ] Sleep(2)
		[+] if(!MDIClient.Business.CashFlowDetails.Exists(5))
			[ ] ReportStatus("Verify Account Overview Tab",PASS,"Account Overview Tab is present from menu")
		[+] else
			[ ] ReportStatus("Verify Account Overview Tab",FAIL,"Account Overview Tab is not present from menu")
			[ ] 
		[ ] 
		[ ] QuickenMainWindow.QWNavigator.Home.Click ()
		[ ] 
		[ ] 
		[ ] // Verify Business Accounts > Account List menu
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.BusinessAccounts.Click()
		[ ] QuickenWindow.Business.BusinessAccounts.AccountList.Select()
		[ ] Sleep(2)
		[+] if(AccountList.Exists(5))
			[ ] ReportStatus("Verify Business Accounts menu",PASS,"Business Accounts menu is present")
			[ ] AccountList.SetActive()
			[ ] AccountList.Close()
		[+] else
			[ ] ReportStatus("Verify Business Accounts menu",FAIL,"Business Accounts menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Invoices And Estimates > Report My Accounts Receivable menu
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.ReportMyAccountsReceivable.Select()
		[ ] 
		[+] if(ARByCustomer.Exists(5))
			[ ] ReportStatus("Verify Invoices And Estimates > Report My Accounts Receivable menu",PASS,"Invoices And Estimates > Report My Accounts Receivable menu is present")
			[ ] ARByCustomer.SetActive()
			[ ] ARByCustomer.Close()
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Report My Accounts Receivable menu",FAIL,"Invoices And Estimates > Report My Accounts Receivable menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Bills And Vendors > Report My Accounts Payable menu
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.BillsAndVendors.Click()
		[ ] QuickenWindow.Business.BillsAndVendors.ReportMyAccountsPayable.Select()
		[ ] 
		[+] if(APByVendor.Exists(5))
			[ ] ReportStatus("Verify Bills And Vendors > Report My Accounts Payable menu",PASS,"Bills And Vendors > Report My Accounts Payable menu is present")
			[ ] APByVendor.SetActive()
			[ ] APByVendor.Close()
		[+] else
			[ ] ReportStatus("Verify Bills And Vendors > Report My Accounts Payable menu",FAIL,"Bills And Vendors > Report My Accounts Payable menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Project/Job List
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.ProjectJobList.Select()
		[ ] 
		[+] if(DlgProjectJobList.Exists(5))
			[ ] ReportStatus("Verify Project/Job List menu",PASS,"Project/Job List menu is present")
			[ ] DlgProjectJobList.SetActive()
			[ ] DlgProjectJobList.Close()
		[+] else
			[ ] ReportStatus("Verify Project/Job List menu",FAIL,"Project/Job List menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Estimate List
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.EstimateList.Select()
		[ ] 
		[+] if(EstimateList.Exists(5))
			[ ] ReportStatus("Verify Estimate List menu",PASS,"Estimate List menu is present")
			[ ] EstimateList.SetActive ()
			[ ] EstimateList.Close()
		[+] else
			[ ] ReportStatus("Verify Estimate List menu",FAIL,"Estimate List menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Print Invoices/Invoices List
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.PrintInvoicesInvoicesList.Select()
		[ ] 
		[+] if(DlgPrintInvoices.Exists(5))
			[ ] ReportStatus("Verify Print Invoices menu",PASS,"Print Invoices menu is present")
			[ ] DlgPrintInvoices.SetActive ()
			[ ] DlgPrintInvoices.Close()
		[+] else
			[ ] ReportStatus("Verify Print Invoices menu",FAIL,"Print Invoices menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Unpaid Invoices List
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.UnpaidInvoicesList.Select()
		[ ] 
		[+] if(DlgUnpaidInvoices.Exists(5))
			[ ] ReportStatus("Verify Unpaid Invoices List menu",PASS,"Unpaid Invoices List menu is present")
			[ ] DlgUnpaidInvoices.SetActive()
			[ ] DlgUnpaidInvoices.Close()
		[+] else
			[ ] ReportStatus("Verify Unpaid Invoices List menu",FAIL,"Unpaid Invoices List menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Manage Business Information
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.ManageBusinessInformation.Select()
		[ ] 
		[+] if(DlgManageBusinessInformation.Exists(5))
			[ ] ReportStatus("Verify Manage Business Information menu",PASS,"Manage Business Information menu is present")
			[ ] 
			[ ] DlgManageBusinessInformation.Close()
		[+] else
			[ ] ReportStatus("Verify Manage Business Information menu",FAIL,"Manage Business Information menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Mileage Tracker
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.MileageTracker.Select()
		[ ] 
		[+] if(DlgVehicleMileage.Exists(5))
			[ ] ReportStatus("Verify Mileage Tracker menu",PASS,"Mileage Tracker menu is present")
			[ ] DlgVehicleMileage.Close()
		[+] else
			[ ] ReportStatus("Verify Mileage Tracker menu",FAIL,"Mileage Tracker menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Small Business Guidance
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.OnlineTools.Click()
		[ ] QuickenWindow.Business.OnlineTools.SmallBusinessGuidance.Select()
		[ ] 
		[+] if(DlgSmallBusinessGuidance.Exists(5))
			[ ] ReportStatus("Verify Small Business Guidance menu",PASS,"Small Business Guidance menu is present")
			[ ] DlgSmallBusinessGuidance.Close()
		[+] else
			[ ] ReportStatus("Verify Small Business Guidance menu",FAIL,"Small Business Guidance menu is not present")
			[ ] 
		[ ] 
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] // // Verify Business Reports > Accounts Payable menu
		[ ] // QuickenWindow.SetActive ()
		[ ] // QuickenWindow.Business.Click()
		[ ] // QuickenWindow.Business.BusinessReports.Click()
		[ ] // QuickenWindow.Business.BusinessReports.AccountsPayable.Select()
		[ ] // 
		[+] // if(APByVendor.Exists(5))
			[ ] // ReportStatus("Verify Business Reports > Accounts Payable menu",PASS,"Business Reports > Accounts Payable menu is present")
			[ ] // APByVendor.Close()
		[+] // else
			[ ] // ReportStatus("Verify Business Reports > Accounts Payable menu",FAIL,"Business Reports > Accounts Payable menu is not present")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#######################################################################
[ ] 
[+] //############# Verify sub-menus under the Business > Invoices & Esimates menu ################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_VerifySubMenuOfInvoicesEsimates()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify sub-menu item present under the Business -> Invoices & Esimates menu
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 14, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test04_VerifySubMenuOfInvoicesEsimates() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify Invoices And Estimates > Create Invoice
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateInvoice.Select()
		[ ] 
		[+] if(DlgInvoiceCustomerInvoicesAccount.Exists(5))
			[ ] DlgInvoiceCustomerInvoicesAccount.SetActive()
			[ ] ReportStatus("Verify Invoices And Estimates > Create Invoice menu",PASS,"Invoices And Estimates > Create Invoice menu is present")
			[ ] DlgInvoiceCustomerInvoicesAccount.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , false ,4)
			[+] // // else if(Quicken2013Popup.Exists(5))
				[ ] // // Quicken2013Popup.SetActive()
				[ ] // // Quicken2013Popup.YesButton.Click()
			[+] // else
				[ ] // Quicken2013Popup.SetActive()
				[ ] // Quicken2013Popup.TypeKeys(KEY_EXIT)
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Create Invoice menu",FAIL,"Invoices And Estimates > Create Invoice menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Invoices And Estimates > Receive a Customer Payment
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.ReceiveACustomerPayment.Select()
		[ ] 
		[+] if(DlgPaymentCustomerInvoicesAccount.Exists(5))
			[ ] DlgPaymentCustomerInvoicesAccount.SetActive()
			[ ] ReportStatus("Verify Invoices And Estimates > Receive a Customer Payment menu",PASS,"Invoices And Estimates > Receive a Customer Payment menu is present")
			[ ] DlgPaymentCustomerInvoicesAccount.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , false ,4)
			[+] // else if(Quicken2013Popup.Exists(5))
				[ ] // Quicken2013Popup.SetActive()
				[ ] // Quicken2013Popup.YesButton.Click()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Receive a Customer Payment menu",FAIL,"Invoices And Estimates > Receive a Customer Payment menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Invoices And Estimates > Issue a Credit
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.IssueACredit.Select()
		[ ] 
		[+] if(DlgCreditCustomerInvoicesAccount.Exists(5))
			[ ] DlgCreditCustomerInvoicesAccount.SetActive()
			[ ] ReportStatus("Verify Invoices And Estimates > Issue a Credit menu",PASS,"Invoices And Estimates > Issue a Credit menu is present")
			[ ] DlgCreditCustomerInvoicesAccount.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , false ,4)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Issue a Credit menu",FAIL,"Invoices And Estimates > Issue a Credit menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Invoices And Estimates > Issue a Refund
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.IssueARefund.Select()
		[ ] 
		[+] if(DlgRefundCustomerInvoicesAccount.Exists(5))
			[ ] DlgRefundCustomerInvoicesAccount.SetActive()
			[ ] ReportStatus("Verify Invoices And Estimates > Issue a Refund menu",PASS,"Invoices And Estimates > Issue a Refund menu is present")
			[ ] DlgRefundCustomerInvoicesAccount.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , false ,4)
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Issue a Refund menu",FAIL,"Invoices And Estimates > Issue a Refund menu is not present")
		[ ] 
		[ ] // Verify Invoices And Estimates > Create a Finance Charge
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateAFinanceCharge.Select()
		[ ] 
		[+] if(DlgCreateFinanceCharge.Exists(5))
			[ ] DlgCreateFinanceCharge.SetActive()
			[ ] ReportStatus("Verify Invoices And Estimates > Create a Finance Charge menu",PASS,"Invoices And Estimates > Create a Finance Charge menu is present")
			[ ] DlgCreateFinanceCharge.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , false ,4)
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Create a Finance Charge menu",FAIL,"Invoices And Estimates > Create a Finance Charge menu is not present")
		[ ] 
		[ ] 
		[ ] // Verify Invoices And Estimates > View All Invoices
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.ViewAllInvoices.Select()
		[ ] 
		[+] if(DlgPrintInvoices.Exists(5))
			[ ] DlgPrintInvoices.SetActive()
			[ ] ReportStatus("Verify Invoices And Estimates > View All Invoices menu",PASS,"Invoices And Estimates > View All Invoices menu is present")
			[ ] DlgPrintInvoices.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , false ,4)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > View All Invoices menu",FAIL,"Invoices And Estimates > View All Invoices menu is not present")
		[ ] 
		[ ] // Verify Invoices And Estimates > Report My Accounts Receivable menu
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.ReportMyAccountsReceivable.Select()
		[ ] 
		[+] if(ARByCustomer.Exists(5))
			[ ] ARByCustomer.SetActive()
			[ ] ReportStatus("Verify Invoices And Estimates > Report My Accounts Receivable menu",PASS,"Invoices And Estimates > Report My Accounts Receivable menu is present")
			[ ] ARByCustomer.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , false ,4)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Report My Accounts Receivable menu",FAIL,"Invoices And Estimates > Report My Accounts Receivable menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Invoices And Estimates > Print Statements
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.PrintStatements.Select()
		[ ] 
		[+] if(DlgCustomerStatements.Exists(5))
			[ ] DlgCustomerStatements.SetActive()
			[ ] ReportStatus("Verify Invoices And Estimates > Print Statements menu",PASS,"Invoices And Estimates > Print Statements menu is present")
			[ ] DlgCustomerStatements.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , false ,4)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Print Statements menu",FAIL,"Invoices And Estimates > Print Statements menu is not present")
		[ ] 
		[ ] // Verify Invoices And Estimates > Create Estimate
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateEstimate.Select()
		[ ] 
		[ ] WaitForState(EstimateList.DlgEstimate,TRUE,5)
		[+] if(EstimateList.DlgEstimate.Exists(5))
			[ ] EstimateList.DlgEstimate.SetActive()
			[ ] ReportStatus("Verify Invoices And Estimates > Create Estimate menu",PASS,"Invoices And Estimates > Create Estimate menu is present")
			[ ] EstimateList.DlgEstimate.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , false ,4)
			[+] if(EstimateList.Exists(5))
				[ ] EstimateList.Close()
				[ ] WaitForState(EstimateList , false ,4)
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Create Estimate menu",FAIL,"Invoices And Estimates > Create Estimate menu is not present")
		[ ] 
		[ ] // Verify Invoices And Estimates > View All Invoice Items
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.ViewAllInvoiceItems.Select()
		[ ] 
		[+] if(DlgCustomizeInvoiceItems.Exists(5))
			[ ] DlgCustomizeInvoiceItems.SetActive()
			[ ] ReportStatus("Verify Invoices And Estimates > View All Invoices menu",PASS,"Invoices And Estimates > View All Invoices menu is present")
			[ ] DlgCustomizeInvoiceItems.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , false ,4)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > View All Invoices menu",FAIL,"Invoices And Estimates > View All Invoices menu is not present")
		[ ] 
		[ ] // Verify Invoices And Estimates > View saved customer messages
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.ViewSavedCustomerMessages.Select()
		[ ] 
		[+] if(DlgEditCustomerMessages.Exists(5))
			[ ] DlgEditCustomerMessages.SetActive()
			[ ] ReportStatus("Verify Invoices And Estimates > View saved customer messages menu",PASS,"Invoices And Estimates > View saved customer messages menu is present")
			[ ] DlgEditCustomerMessages.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , false ,4)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > View saved customer messages menu",FAIL,"Invoices And Estimates > View saved customer messages menu is not present")
		[ ] 
		[ ] // Verify Invoices And Estimates > Design Invoice Forms
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.DesignInvoiceForms.Select()
		[ ] 
		[+] if(DlgFormsDesigner.Exists(5))
			[ ] DlgFormsDesigner.SetActive()
			[ ] ReportStatus("Verify Invoices And Estimates > Design Invoice Forms menu",PASS,"Invoices And Estimates > Design Invoice Forms menu is present")
			[ ] DlgFormsDesigner.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , false ,4)
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Design Invoice Forms menu",FAIL,"Invoices And Estimates > Design Invoice Forms menu is not present")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#######################################################################
[ ] 
[+] //############# Verify sub-menus under the Business -> Bills & Vendors menu ####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_VerifySubMenuOfBillsVendors()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify sub-menu item present under the Business -> Bills & Vendors menu.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  May 14, 2013		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[+] testcase Test05_VerifySubMenuOfBillsVendors() appstate none
	[ ] 
	[+] // Variable declaration
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive ()
		[ ] 
		[ ] // Verify Bills And Vendors > Add a Vendor
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.BillsAndVendors.Click()
		[ ] QuickenWindow.Business.BillsAndVendors.AddAVendor.Select()
		[ ] 
		[+] if(AddressBookRecord.DlgEditAddressBookRecord.Exists(5))
			[ ] ReportStatus("Verify Bills And Vendors > Add a Vendor menu ",PASS,"Bills And Vendors > Add a Vendor menu is present")
			[ ] AddressBookRecord.DlgEditAddressBookRecord.Close()
			[+] if(AddressBookRecord.Exists(5))
				[ ] AddressBookRecord.Close()
				[ ] 
			[+] // // else if(Quicken2013Popup.Exists(5))
				[ ] // // Quicken2013Popup.SetActive()
				[ ] // // Quicken2013Popup.YesButton.Click()
			[+] // else
				[ ] // Quicken2013Popup.SetActive()
				[ ] // Quicken2013Popup.TypeKeys(KEY_EXIT)
		[+] else
			[ ] ReportStatus("Verify Bills And Vendors > Add a Vendor menu",FAIL,"Bills And Vendors > Add a Vendor menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Bills And Vendors >Create Bill
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.BillsAndVendors.Click()
		[ ] QuickenWindow.Business.BillsAndVendors.CreateBill.Select()
		[ ] 
		[+] if(DlgBillVendorInvoices.Exists(5))
			[ ] ReportStatus("Verify Bills And Vendors >Create Bill menu",PASS,"Bills And Vendors >Create Bill menu is present")
			[ ] DlgBillVendorInvoices.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] 
			[+] // else if(Quicken2013Popup.Exists(5))
				[ ] // Quicken2013Popup.SetActive()
				[ ] // Quicken2013Popup.YesButton.Click()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Bills And Vendors >Create Bill menu",FAIL,"Bills And Vendors >Create Bill menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Bills And Vendors >Make Payment To Vendor
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.BillsAndVendors.Click()
		[ ] QuickenWindow.Business.BillsAndVendors.MakePaymentToVendor.Select()
		[ ] 
		[+] if(DlgPaymentVendorInvoices.Exists(5))
			[ ] ReportStatus("Verify Bills And Vendors >Make Payment To Vendor menu",PASS,"Bills And Vendors >Make Payment To Vendor  menu is present")
			[ ] DlgPaymentVendorInvoices.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Bills And Vendors >Make Payment To Vendor menu",FAIL,"Bills And Vendors >Make Payment To Vendor menu is not present")
		[ ] 
		[ ] // Verify Bills And Vendors > Receive A Credit
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.BillsAndVendors.Click()
		[ ] QuickenWindow.Business.BillsAndVendors.ReceiveACredit.Select()
		[ ] 
		[+] if(DlgCreditCustomerInvoicesAccount.Exists(5))
			[ ] ReportStatus("Verify Bills And Vendors > Receive A Credit menu",PASS,"Bills And Vendors > Receive A Credit menu is present")
			[ ] DlgCreditCustomerInvoicesAccount.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(DlgCreditCustomerInvoicesAccount , false,3)
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Bills And Vendors > Receive A Credit menu",FAIL,"Bills And Vendors > Receive A Credit menu is not present")
		[ ] 
		[ ] // Verify Invoices And Estimates > Create a Finance Charge
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateAFinanceCharge.Select()
		[ ] 
		[+] if(DlgCreateFinanceCharge.Exists(5))
			[ ] ReportStatus("Verify Invoices And Estimates > Create a Finance Charge menu",PASS,"Invoices And Estimates > Create a Finance Charge menu is present")
			[ ] DlgCreateFinanceCharge.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Create a Finance Charge menu",FAIL,"Invoices And Estimates > Create a Finance Charge menu is not present")
		[ ] 
		[ ] // Verify Invoices And Estimates > View All Invoices
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.ViewAllInvoices.Select()
		[ ] 
		[+] if(DlgPrintInvoices.Exists(5))
			[ ] ReportStatus("Verify Invoices And Estimates > View All Invoices menu",PASS,"Invoices And Estimates > View All Invoices menu is present")
			[ ] DlgPrintInvoices.Close()
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > View All Invoices menu",FAIL,"Invoices And Estimates > View All Invoices menu is not present")
		[ ] 
		[ ] // Verify Invoices And Estimates > Report My Accounts Receivable menu
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.ReportMyAccountsReceivable.Select()
		[ ] 
		[+] if(ARByCustomer.Exists(5))
			[ ] ReportStatus("Verify Invoices And Estimates > Report My Accounts Receivable menu",PASS,"Invoices And Estimates > Report My Accounts Receivable menu is present")
			[ ] ARByCustomer.Close()
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Report My Accounts Receivable menu",FAIL,"Invoices And Estimates > Report My Accounts Receivable menu is not present")
			[ ] 
		[ ] 
		[ ] // Verify Invoices And Estimates > Print Statements
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.PrintStatements.Select()
		[ ] 
		[+] if(DlgCustomerStatements.Exists(5))
			[ ] DlgCustomerStatements.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , False,3)
				[ ] 
			[ ] 
			[ ] ReportStatus("Verify Invoices And Estimates > Print Statements menu",PASS,"Invoices And Estimates > Print Statements menu is present")
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Print Statements menu",FAIL,"Invoices And Estimates > Print Statements menu is not present")
		[ ] 
		[ ] // Verify Invoices And Estimates > Create Estimate
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateEstimate.Select()
		[ ] WaitForState(EstimateList.DlgEstimate,TRUE,5)
		[+] if(EstimateList.DlgEstimate.Exists(5))
			[ ] ReportStatus("Verify Invoices And Estimates > Create Estimate menu",PASS,"Invoices And Estimates > Create Estimate menu is present")
			[ ] EstimateList.DlgEstimate.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , False,3)
				[ ] 
			[+] if(EstimateList.Exists(5))
				[ ] EstimateList.Close()
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Create Estimate menu",FAIL,"Invoices And Estimates > Create Estimate menu is not present")
		[ ] 
		[ ] // Verify Invoices And Estimates > View All Invoice Items
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.ViewAllInvoiceItems.Select()
		[ ] 
		[+] if(DlgCustomizeInvoiceItems.Exists(5))
			[ ] ReportStatus("Verify Invoices And Estimates > View All Invoices menu",PASS,"Invoices And Estimates > View All Invoices menu is present")
			[ ] DlgCustomizeInvoiceItems.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , False,3)
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > View All Invoices menu",FAIL,"Invoices And Estimates > View All Invoices menu is not present")
		[ ] 
		[ ] // Verify Invoices And Estimates > View saved customer messages
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.ViewSavedCustomerMessages.Select()
		[ ] 
		[+] if(DlgEditCustomerMessages.Exists(5))
			[ ] ReportStatus("Verify Invoices And Estimates > View saved customer messages menu",PASS,"Invoices And Estimates > View saved customer messages menu is present")
			[ ] DlgEditCustomerMessages.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , False,3)
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > View saved customer messages menu",FAIL,"Invoices And Estimates > View saved customer messages menu is not present")
		[ ] 
		[ ] // Verify Invoices And Estimates > Design Invoice Forms
		[ ] QuickenWindow.SetActive ()
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
		[ ] QuickenWindow.Business.InvoicesAndEstimates.DesignInvoiceForms.Select()
		[ ] 
		[+] if(DlgFormsDesigner.Exists(5))
			[ ] ReportStatus("Verify Invoices And Estimates > Design Invoice Forms menu",PASS,"Invoices And Estimates > Design Invoice Forms menu is present")
			[ ] DlgFormsDesigner.Close()
			[+] if(AlertMessage.Exists(5))
				[ ] AlertMessage.Yes.Click()
				[ ] WaitForState(AlertMessage , False,3)
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Invoices And Estimates > Design Invoice Forms menu",FAIL,"Invoices And Estimates > Design Invoice Forms menu is not present")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#######################################################################
[ ] 
[+] //#############Verify Add a Customer functionality..##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_AddCustomerFunctionality() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Add a Customer functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		             If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 17 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test06_AddCustomerFunctionality() appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] LIST OF STRING lsCustomer
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "AddCustomerVendor"
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsCustomerData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Verify Business -> Customers -> Add Customer
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.Customers.Click()
		[ ] QuickenWindow.Business.Customers.AddCustomer.Select()
		[ ] 
		[ ] WaitForState(AddressBookRecord.DlgEditAddressBookRecord,TRUE,2)
		[ ] 
		[ ] lsCustomer = lsCustomerData[1]
		[ ] 
		[ ] iResult=AddCustomerVendor(lsCustomer[1],lsCustomer[2],lsCustomer[3],lsCustomer[4],lsCustomer[5],lsCustomer[6],lsCustomer[7],lsCustomer[8],lsCustomer[9])
		[ ] 
		[+] if(iResult==PASS)
			[ ] //Create A Customer using Address Book Record
			[ ] ReportStatus("Verify Customer Added in Address Book Record ", PASS , " Customer added in Address Book Record sucessfully")
			[ ] 
			[+] if(AddressBookRecord.Exists(5))
				[ ] AddressBookRecord.SetActive()
				[ ] sHandle = Str(AddressBookRecord.QWListViewer1.ListBox1.GetHandle())
				[+] for(iCounter =0;iCounter<AddressBookRecord.QWListViewer1.ListBox1.GetItemCount();iCounter++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCounter)) 
					[ ] bMatch = MatchStr("*{lsCustomer[1]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify Customer Added in Address Book Record Correctly ", PASS , " Customer{lsCustomer[1]} got added in Address Book Record sucessfully")
				[+] else
					[ ] ReportStatus("Verify Customer Added in Address Book Record Correctly ", FAIL , "Expected : {lsCustomer} Actual : {sActual} got added in Address Book Record sucessfully")
				[ ] AddressBookRecord.Close()
			[ ] 
			[+] 
					[ ] 
		[+] else
			[ ] ReportStatus("Verify Customer Added in Address Book Record ", FAIL , " Customer not added in Address Book Record sucessfully")
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] // //######################################################################
[ ] 
[+] //#############Verify displaying of Choose Invoice account dialog.##########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_ChooseInvoiceAccount() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify displaying of Choose Invoice account dialog.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		             If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 17 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test07_ChooseInvoiceAccount() appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] LIST OF STRING lsChooseInvoice,lsAccount,lsExcel,lsExpectedAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "InvoiceForm"
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] 
	[ ] 
	[-] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Account creation of Business Account
		[+] for(i=3;i<=4;i++)
			[ ] lsAccount = lsExcelData[i]
			[ ] //Add Business Account
			[ ] iAddAccount = AddBusinessAccount(lsAccount[1],lsAccount[2])
			[ ] 
			[+] if (iAddAccount==PASS) // Business Account is created
				[ ] ReportStatus("{lsAccount[1]} Account", iAddAccount, "{lsAccount[1]} Account -{lsAccount[2]} is created successfully")
			[+] else
				[ ] ReportStatus("{lsAccount[1]} Account", iAddAccount, "{lsAccount[1]} Account -{lsAccount[2]} is not created successfully")
			[ ] 
			[ ] 
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsAccount = lsExcelData[1]
		[ ] 
		[-] if (iAddAccount==PASS)
			[ ] //Opening Business Account Register
			[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
			[ ] 
			[-] if(iOpenAccountRegister==PASS)
				[ ] ReportStatus("Account is selected from AccountBar", PASS , "account is selected from AccountBar")
				[ ] 
				[ ] //Verify displaying of Choose Invoice account dialog.
				[ ] QuickenWindow.Business.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateInvoice.Select()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[-] if(ChooseInvoiceAccount.Exists(5))
					[ ] ChooseInvoiceAccount.SetActive()
					[ ] lsChooseInvoice = ChooseInvoiceAccount.ChooseInvoiceAccount.GetContents()
					[ ] lsExcel=lsExcelData[1]
					[ ] ListAppend(lsExpectedAccount,lsExcel[2])
					[ ] lsExcel=lsExcelData[3]
					[ ] ListAppend(lsExpectedAccount,lsExcel[2])
					[-] for(i=1;i<=ListCount(lsChooseInvoice);i++)
						[-] if(lsExpectedAccount[i]==lsChooseInvoice[i])
							[ ] ReportStatus("Verify Customer Invoice Accounts are listed in Choose Invoice popuplist on Choose Invoice Account DIalog", PASS , "{lsChooseInvoice[i]} Customer Invoice Account is listed in Choose Invoice popuplist on Choose Invoice Account DIalog")
						[-] else
							[ ] ReportStatus("Verify Customer Invoice Accounts are listed in Choose Invoice popuplist on Choose Invoice Account DIalog", FAIL , "Expected :{lsExpectedAccount[i]} Actual :{lsChooseInvoice[i]} Customer Invoice Account is listed in Choose Invoice popuplist on Choose Invoice Account DIalog")
					[ ] ChooseInvoiceAccount.Close()
				[+] else
					[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Business Account", FAIL, "Business Account is not created successfully")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] // //######################################################################
[ ] 
[+] //#############Verify displaying of Choose Bill account dialog.#############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_ChooseBillAccount() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify displaying of Choose Bill account dialog.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		             If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 17 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test08_ChooseBillAccount() appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] LIST OF STRING lsChooseInvoice,lsAccount ,lsAccountNames
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] 
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsAccount = lsExcelData[2]
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] //Opening Business Account Register
			[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
			[ ] 
			[+] if(iOpenAccountRegister==PASS)
				[ ] ReportStatus("Account is selected from AccountBar", PASS , "account is selected from AccountBar")
				[ ] 
				[ ] //Verify displaying of Choose Invoice account dialog.
				[ ] QuickenWindow.Business.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateInvoice.Select()
				[ ] 
				[ ] 
				[+] if(ChooseInvoiceAccount.Exists(5))
					[ ] ChooseInvoiceAccount.SetActive()
					[ ] lsChooseInvoice = ChooseInvoiceAccount.ChooseInvoiceAccount.GetContents()
					[ ] ListAppend(lsAccountNames,trim(lsExcelData[1][2]))
					[ ] ListAppend(lsAccountNames,trim(lsExcelData[3][2]))
					[+] for(i=1;i<=ListCount(lsChooseInvoice);i++)
						[+] if(lsAccountNames[i]==lsChooseInvoice[i])
							[ ] ReportStatus("Verify Customer Invoice Accounts are listed in Choose Invoice popuplist on Choose Invoice Account DIalog", PASS , "{lsChooseInvoice[i]} Customer Invoice Account is listed in Choose Invoice popuplist on Choose Invoice Account DIalog")
						[+] else
							[ ] ReportStatus("Verify Customer Invoice Accounts are listed in Choose Invoice popuplist on Choose Invoice Account DIalog", FAIL , "Expected :{lsAccountNames[i]} Actual :{lsChooseInvoice[i]} Customer Invoice Account is listed in Choose Invoice popuplist on Choose Invoice Account DIalog")
					[ ] ChooseInvoiceAccount.SetActive()
					[ ] ChooseInvoiceAccount.Close()
					[ ] WaitForState(ChooseInvoiceAccount , False ,3)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
					[ ] 
				[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] // //######################################################################
[ ] 
[+] //#############Verify creation of Customer Invoice ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_CreationOfCustomerInvoice() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify creation of Customer Invoice.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		       If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 16 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test09_CreationOfCustomerInvoice() appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "CustomerInvoice"
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[ ] 
	[-] //Retrieving Banking Data from Excel sheet 
		[ ] 
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction = lsTransactionData[1]
		[ ] sBalance=lsTransaction[11]
		[ ] sCustomer = lsTransaction[1]
		[ ] lsExcelData = ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsAccount = lsExcelData[1]
		[ ] 
	[ ] 
	[-] if (QuickenWindow.Exists(5))
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.View.Click()
			[ ] QuickenWindow.View.ClassicMenus.Select()
			[ ] 
			[ ] //Opening Business Account Register
			[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
			[ ] 
			[-] if(iOpenAccountRegister==PASS)
				[ ] ReportStatus("Account is selected from AccountBar", PASS , "account is selected from AccountBar")
				[ ] 
				[ ] //Verify whether transaction is added or not
				[ ] VerifyTransactionInAccountRegister(sBalance,sBeforeExpected)
				[ ] 
				[ ] //Navigate to Business >> Invoices and Estimates  >> Create Inovice
				[ ] QuickenWindow.Business.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateInvoice.Select()
				[ ] 
				[ ] 
				[ ] 
				[-] if(ChooseInvoiceAccount.Exists(5))
					[ ] ChooseInvoiceAccount.SetActive()
					[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
					[ ] ChooseInvoiceAccount.OK.Click()
					[-] if (DlgInvoice.Exists(5))
						[ ] 
						[ ] ReportStatus("Verify Customer Invoice form",PASS ,"Customer Invoice form is displayed")
						[ ] //Enter Data for Customer Invoice form
						[ ] iValidate=AddBusinessInvoiceTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8],lsTransaction[9],lsTransaction[10],lsTransaction[11],lsTransaction[12],lsTransaction[13],lsTransaction[14])
						[ ] 
						[+] if(iValidate==PASS)
							[ ] ReportStatus("Verify Customer Invoice form data entered",PASS ,"Customer Invoice form data is entered successfully")
							[ ] 
							[ ] //Verify the vaild Balance is entered while adding transaction in Register
							[ ] VerifyTransactionInAccountRegister(sBalance,sAfterExpected)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Customer Invoice form data entered",FAIL ,"Customer Invoice form data is not entered successfully")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Customer Invoice form",FAIL ,"Customer Invoice form is not displayed")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
				[ ] 
				[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //#######################################################################
[ ] 
[+] //#############Verify creation of Customer Payment ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_CreationOfCustomerPayment() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Receive a Customer payment functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		       If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 16 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test10_CreationOfCustomerPayment() appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "PaymentForm"
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsAccount = lsExcelData[1]
		[ ] 
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction = lsTransactionData[5]
		[ ] sBalance=lsTransaction[3]
		[ ] sCustomer = lsTransaction[1]
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.View.Click()
		[ ] QuickenWindow.View.ClassicMenus.Select()
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] ReportStatus("Account is selected from AccountBar", PASS , "account is selected from AccountBar")
			[ ] 
			[ ] //Verify whether transaction is added or not
			[ ] VerifyTransactionInAccountRegister(sBalance,sBeforeExpected)
			[ ] 
			[+] //Navigate to Business >> Invoices and Estimates  >>Receive a Customer Payment
				[ ] QuickenWindow.Business.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.ReceiveACustomerPayment.Select()
				[ ] 
				[ ] 
				[+] if(ChooseInvoiceAccount.Exists(5))
					[ ] ChooseInvoiceAccount.SetActive()
					[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
					[ ] ChooseInvoiceAccount.OK.Click()
					[ ] WaitForState(ChooseInvoiceAccount , False ,3)
					[ ] 
					[ ] 
					[+] if (DlgPaymentInvoices.Exists(5))
						[ ] 
						[ ] ReportStatus("Verify Customer Payment form",PASS ,"Customer Payment form is displayed")
						[ ] //Enter Data for Customer Payment form
						[ ] iValidate=AddCustomerVendorPayment(lsTransaction[1], lsTransaction[2] ,lsTransaction[3] ,lsTransaction[4], lsTransaction[5])
						[ ] 
						[+] if(iValidate==PASS)
							[ ] ReportStatus("Verify Customer Payment form data entered",PASS ,"Customer Payment form data is entered successfully")
							[ ] 
							[ ] //Verify the vaild Balance is entered while adding transaction in Register
							[ ] VerifyTransactionInAccountRegister(sBalance,sAfterExpected)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Customer Payment form data entered",FAIL ,"Customer Payment form data is not entered successfully")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Customer Payment form",FAIL ,"Customer Payment form is not displayed")
				[+] else
					[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[+] 
				[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] // //######################################################################
[ ] 
[+] //#############Verify creation of Issue a Credit#######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_CreationOfIssueCredit() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Issue a credit functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 16 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test11_CreationOfIssueCredit() appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "CustomerInvoice"
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[ ] 
	[-] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction = lsTransactionData[2]
		[ ] sBalance=lsTransaction[11]
		[ ] sCustomer = lsTransaction[1]
		[ ] lsAccount = lsExcelData[1]
	[ ] 
	[-] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.View.Click()
		[ ] QuickenWindow.View.ClassicMenus.Select()
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[-] if(iOpenAccountRegister==PASS)
			[ ] ReportStatus("Account is selected from AccountBar", PASS , "account is selected from AccountBar")
			[ ] 
			[ ] //Verify whether transaction is added or not
			[ ] VerifyTransactionInAccountRegister(sBalance,sBeforeExpected)
			[ ] 
			[-] //Navigate to Business >> Invoices and Estimates  >> Issue a Credit
				[ ] QuickenWindow.Business.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.IssueACredit.Select()
				[ ] 
				[ ] 
				[-] if(ChooseInvoiceAccount.Exists(5))
					[ ] ChooseInvoiceAccount.SetActive()
					[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
					[ ] ChooseInvoiceAccount.OK.Click()
					[ ] WaitForState(ChooseInvoiceAccount , False ,3)
					[ ] 
					[-] if (DlgCreditInvoices.Exists(5))
						[ ] 
						[ ] ReportStatus("Verify Credit-Customer form",PASS ,"Credit-Customer form is displayed")
						[ ] //Enter Data for Credit-Customer form
						[ ] iValidate=AddCustomerCreditTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[6],lsTransaction[7],lsTransaction[8],lsTransaction[9],lsTransaction[10],lsTransaction[11],lsTransaction[12],lsTransaction[13],lsTransaction[14])
						[ ] 
						[+] if(iValidate==PASS)
							[ ] ReportStatus("Verify Credit-Customer form data entered",PASS ,"Credit-Customer form data is entered successfully")
							[ ] 
							[ ] //Verify the vaild Balance is entered while adding transaction in Register
							[ ] VerifyTransactionInAccountRegister(sBalance,sAfterExpected)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Credit-Customer form data entered",FAIL ,"Credit-Customer form data is not entered successfully")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Credit-Customer form",FAIL ,"Credit-Customer form is not displayed")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[+] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
				[ ] 
				[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify creation of Issue a Refund######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_CreationOfIssueRefund() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Issue a Refund functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 16 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test12_CreationOfIssueRefund() appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "CustomerRefund"
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsAccount = lsExcelData[1]
		[ ] 
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction = lsTransactionData[1]
		[ ] sBalance=lsTransaction[3]
		[ ] sCustomer = lsTransaction[2]
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.View.Click()
		[ ] QuickenWindow.View.ClassicMenus.Select()
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] ReportStatus("Account is selected from AccountBar", PASS , "account is selected from AccountBar")
			[ ] 
			[ ] //Verify whether transaction is added or not
			[ ] VerifyTransactionInAccountRegister(sBalance,sBeforeExpected)
			[ ] 
			[+] //Navigate to Business >> Invoices and Estimates  >> Issue A Refund
				[ ] QuickenWindow.Business.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.IssueARefund.Select()
				[ ] 
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[+] if (DlgRefund.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Customer Refund form",PASS ,"Customer Refund form is displayed")
					[ ] //Enter Data for Customer Invoice form
					[ ] iValidate=AddCustomerRefund(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
					[ ] 
					[+] if(iValidate==PASS)
						[ ] ReportStatus("Verify Customer Refund form data entered",PASS ,"Customer Refund form data is entered successfully")
						[ ] 
						[ ] //Verify the vaild Balance is entered while adding transaction in Register
						[ ] VerifyTransactionInAccountRegister(sBalance,sAfterExpected)
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Customer Refund form data entered",FAIL ,"Customer Refund form data is not entered successfully")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Customer Refund form",FAIL ,"Customer Refund form is not displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[+] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
				[ ] 
				[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify Create a Finance charge functionality###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_CreationOfFinanceCharge() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Create a Finance charge functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 29 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test13_CreationOfFinanceCharge()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer,sDateFormat
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "FinanceCharge "
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] sDateFormat="mm/dd/yyyy"
	[ ] sDateStamp = ModifyDate(2,sDateFormat)
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction = lsTransactionData[1]
		[ ] sCustomer = lsTransaction[1]
		[ ] lsAccount = lsExcelData[1]
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify displaying of Choose Invoice account dialog.
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateAFinanceCharge.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[+] if (DlgCreateFinanceCharge.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Customer Finance Charge form",PASS ,"Customer Finance Charge form is displayed")
					[ ] 
					[ ] lsTransaction[3]=sDateStamp
					[ ] 
					[ ] //Enter Data for Customer Finance Charge form
					[ ] iValidate=AddCustomerFinanceCharge(lsTransaction[1],sDateStamp,lsTransaction[3],lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
					[ ] 
					[+] if(iValidate==PASS)
						[ ] ReportStatus("Verify Customer Refund form data entered",PASS ,"Customer Refund form data is entered successfully")
						[ ] 
						[ ] //Verify the vaild Balance is entered while adding transaction in Register
						[ ] VerifyTransactionInAccountRegister(sCustomer ,sAfterExpected)
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Customer Refund form data entered",FAIL ,"Customer Refund form data is not entered successfully")
						[ ] 
					[ ] 
					[+] if (DlgCreateFinanceCharge.Exists(5))
						[ ] DlgCreateFinanceCharge.SetActive()
						[ ] DlgCreateFinanceCharge.Close()
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Customer Refund form",FAIL ,"Customer Refund form is not displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[+] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
				[ ] 
				[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify Add a Vendor functionality######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_AddVendorFunctionality() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Add a Vendor functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		             If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 23 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test14_AddVendorFunctionality() appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] LIST OF STRING lsVendor
	[ ] INTEGER iVendor
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "AddCustomerVendor"
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsVendorData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] // Verify Business -> Bills and Vendors -> Add Vendor
		[ ] QuickenWindow.Business.Click()
		[ ] QuickenWindow.Business.BillsAndVendors.Click()
		[ ] QuickenWindow.Business.BillsAndVendors.AddAVendor.Select()
		[ ] 
		[ ] WaitForState(AddressBookRecord.DlgEditAddressBookRecord,TRUE,2)
		[ ] 
		[ ] lsVendor = lsVendorData[2]
		[ ] iVendor =VAL(lsVendor[6])
		[ ] iResult=AddCustomerVendor(lsVendor[1],lsVendor[2],lsVendor[3],lsVendor[4],lsVendor[5],str(iVendor),lsVendor[7],lsVendor[8],lsVendor[9])
		[ ] 
		[+] if(iResult==PASS)
			[ ] //Create A Vendor using Address Book Record
			[ ] ReportStatus("Verify Customer Added in Address Book Record ", PASS , " Customer added in Address Book Record sucessfully")
			[ ] 
			[+] if(AddressBookRecord.Exists(5))
				[ ] sHandle = Str(AddressBookRecord.QWListViewer1.ListBox1.GetHandle())
				[+] for(iCounter =0;iCounter<=AddressBookRecord.QWListViewer1.ListBox1.GetItemCount();iCounter++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}") 
					[ ] bMatch = MatchStr("*{lsVendor[1]}*{lsVendor[3]}*{lsVendor[4]}*{lsVendor[5]}*{trim(str(iVendor))}*{lsVendor[7]}*{lsVendor[9]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify Customer Added in Address Book Record Correctly ", PASS , " Customer{lsVendor[1]} got added in Address Book Record sucessfully")
				[+] else
					[ ] ReportStatus("Verify Customer Added in Address Book Record Correctly ", FAIL , "Expected : {lsVendor} Actual : {sActual} got added in Address Book Record sucessfully")
				[ ] 
				[ ] 
				[ ] AddressBookRecord.SetActive()
				[ ] AddressBookRecord.Close()
			[+] else
				[ ] ReportStatus("Verify Address Book dialog appears.", FAIL ,"Address Book dialog didn't appear.")
		[+] else
			[ ] ReportStatus("Verify Vendor added.", FAIL ,"Vendor couldn't be added.")
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] // //#######################################################################
[ ] 
[+] //#############Verify Create Bill-Vendor Invoice functionality ##############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_CreationOfVendorInvoice() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Create Bill-Vendor Invoice functionality
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		       If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 24 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test15_CreationOfVendorInvoice()   appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "VendorInvoice"
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction = lsTransactionData[1]
		[ ] sBalance=lsTransaction[11]
		[ ] sCustomer = lsTransaction[1]
		[ ] lsAccount = lsExcelData[2]
	[ ] 
	[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] QuickenWindow.View.Click()
			[ ] QuickenWindow.View.ClassicMenus.Select()
			[ ] 
			[ ] //Opening Business Account Register
			[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
			[ ] 
			[+] if(iOpenAccountRegister==PASS)
				[ ] ReportStatus("Account is selected from AccountBar", PASS , "account is selected from AccountBar")
				[ ] 
				[ ] //Verify whether transaction is added or not
				[ ] VerifyTransactionInAccountRegister(sBalance,sBeforeExpected)
				[ ] 
				[ ] //Navigate to Business >> Bills and Vendors  >> Create Bill
				[ ] QuickenWindow.Business.Click()
				[ ] QuickenWindow.Business.BillsAndVendors.Click()
				[ ] QuickenWindow.Business.BillsAndVendors.CreateBill.Select()
				[ ] 
				[+] if(ChooseInvoiceAccount.Exists(5))
					[ ] ChooseInvoiceAccount.SetActive()
					[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
					[ ] ChooseInvoiceAccount.OK.Click()
					[ ] WaitForState(ChooseInvoiceAccount , false ,3)
					[ ] 
					[ ] 
					[+] if (DlgInvoice.Exists(5))
						[ ] 
						[ ] ReportStatus("Verify Bill-Vendor  Invoice form",PASS ,"Bill-Vendor  Invoice form is displayed")
						[ ] 
						[ ] //Enter Data for Bill-Vendor Invoice form
						[ ] iValidate= AddVendorInvoiceTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[7],lsTransaction[8],lsTransaction[11])
						[ ] // iValidate=AddBusinessInvoiceTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8],lsTransaction[9],lsTransaction[10],lsTransaction[11],lsTransaction[12],lsTransaction[13],lsTransaction[14])
						[ ] 
						[+] if(iValidate==PASS)
							[ ] ReportStatus("Verify Bill-Vendor  Invoice form data entered",PASS ,"Bill-Vendor  Invoice form data is entered successfully")
							[ ] 
							[ ] //Verify the vaild Balance is entered while adding transaction in Register
							[ ] VerifyTransactionInAccountRegister(sBalance,sAfterExpected)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Bill-Vendor  Invoice form data entered",FAIL ,"Bill-Vendor  Invoice form data is not entered successfully")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Bill-Vendor  Invoice form",FAIL ,"Bill-Vendor  Invoice form is not displayed")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
				[ ] 
				[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //#######################################################################
[ ] 
[+] //#############Verify creation of Payment to vendor ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_CreationOfVendorPayment()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Make Payment to vendor functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		       If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 24 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test16_CreationOfVendorPayment() appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "PaymentForm"
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction = lsTransactionData[2]
		[ ] sBalance=lsTransaction[3]
		[ ] sCustomer = lsTransaction[1]
		[ ] lsAccount = lsExcelData[2]
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] ReportStatus("Account is selected from AccountBar", PASS , "account is selected from AccountBar")
			[ ] 
			[ ] //Verify whether transaction is added or not
			[ ] VerifyTransactionInAccountRegister(sBalance,sBeforeExpected)
			[ ] 
			[ ] //Navigate to Business >> Bills and Vendors  >>Make a Payment to Vendor
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.MakePaymentToVendor.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[ ] 
				[+] if (DlgPaymentInvoices.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Vendor Payment form",PASS ,"Vendor Payment form is displayed")
					[ ] 
					[ ] //Enter Data for Customer Payment form
					[ ] iValidate=AddCustomerVendorPayment(lsTransaction[1], lsTransaction[2] ,lsTransaction[3] ,lsTransaction[4], lsTransaction[5])
					[ ] 
					[+] if(iValidate==PASS)
						[ ] ReportStatus("Verify Vendor Payment form data entered",PASS ,"Vendor Payment form data is entered successfully")
						[ ] 
						[ ] //Verify the vaild Balance is entered while adding transaction in Register
						[ ] VerifyTransactionInAccountRegister(sBalance,sAfterExpected)
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Vendor Payment form data entered",FAIL ,"Vendor Payment form data is not entered successfully")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Vendor Payment form",FAIL ,"Vendor Payment form is not displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] // //######################################################################
[ ] 
[+] //#############Verify creation of Receive a Credit#######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_CreationOfReceiveCredit() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Receive a credit functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 24 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test17_CreationOfReceiveCredit()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sVendor
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "VendorCredit"
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction = lsTransactionData[1]
		[ ] sBalance=lsTransaction[7]
		[ ] sVendor = lsTransaction[1]
		[ ] lsAccount = lsExcelData[2]
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] ReportStatus("Account is selected from AccountBar", PASS , "account is selected from AccountBar")
			[ ] 
			[ ] //Verify whether transaction is added or not
			[ ] VerifyTransactionInAccountRegister(sBalance,sBeforeExpected)
			[ ] 
			[ ] //Navigate to Business >> Bills and Vendors  >> Receive a Credit
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.ReceiveACredit.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[+] if (DlgCreditInvoices.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Credit-Vendor form",PASS ,"Credit-Vendor form is displayed")
					[ ] 
					[ ] //Enter Data for Credit-Vendor form
					[ ] iValidate=AddVendorCreditTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8])
					[ ] 
					[+] if(iValidate==PASS)
						[ ] ReportStatus("Verify Credit-Vendor form data entered",PASS ,"Credit-Vendor form data is entered successfully")
						[ ] 
						[ ] //Verify the vaild Balance is entered while adding transaction in Register
						[ ] VerifyTransactionInAccountRegister(sBalance,sAfterExpected)
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Credit-Vendor form data entered",FAIL ,"Credit-Vendor form data is not entered successfully")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Credit-Vendor form",FAIL ,"Credit-Vendor form is not displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[+] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
				[ ] 
				[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify creation of Receive a Refund######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test18_CreationOfReceiveRefund() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Receive a Refund functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 24 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase  Test18_CreationOfReceiveRefund() appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "VendorRefund"
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction = lsTransactionData[1]
		[ ] sBalance=lsTransaction[2]
		[ ] sCustomer = lsTransaction[3]
		[ ] lsAccount = lsExcelData[2]
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] ReportStatus("Account is selected from AccountBar", PASS , "account is selected from AccountBar")
			[ ] 
			[ ] //Verify whether transaction is added or not
			[ ] VerifyTransactionInAccountRegister(sBalance,sBeforeExpected)
			[ ] 
			[ ] //Navigate to Business >> Bills and Vendors  >> Receive a Refund
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.ReceiveARefund.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[+] if (DlgRefund.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Customer Refund form",PASS ,"Customer Refund form is displayed")
					[ ] //Enter Data for Vendor Refund form
					[ ] iValidate=AddVendorRefund(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7])
					[ ] 
					[+] if(iValidate==PASS)
						[ ] ReportStatus("Verify Customer Refund form data entered",PASS ,"Customer Refund form data is entered successfully")
						[ ] 
						[ ] //Verify the vaild Balance is entered while adding transaction in Register
						[ ] iValidate =VerifyTransactionInAccountRegister(sBalance,sAfterExpected)
						[+] if(iValidate==PASS)
							[ ] ReportStatus("Verify Customer Refund form data entered",PASS ,"Transaction with payee: {lsTransaction[2]} has been entered in the register.")
						[+] else
							[ ] ReportStatus("Verify Customer Refund form data entered",FAIL ,"Transaction with payee: {lsTransaction[2]} couldn't be entered in the register.")
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Customer Refund form data entered",FAIL ,"Customer Refund form data is not entered successfully")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Customer Refund form",FAIL ,"Customer Refund form is not displayed")
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[+] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
				[ ] 
				[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify View all Invoices functionality#####################################
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test19_ViewAllInvoiceFunctionality() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify View all Invoices functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 27 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test19_ViewAllInvoiceFunctionality()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer
	[ ] LIST OF STRING lsAccount
	[ ] INTEGER iAmount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] // sTransactionsheet = "AddBusinessTransaction"
	[ ] sTransactionsheet = "BusinessTransaction"
	[ ] 
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[ ] 
	[ ] 
	[-] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction =lsTransactionData[1]
		[ ] sBalance=lsTransaction[3]
		[ ] sCustomer = lsTransaction[6]
		[ ] lsAccount = lsExcelData[1]
	[ ] 
	[-] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[-] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Enter Data for Business transactions
			[-] for(iCounter=1;iCounter<=ListCount(lsTransactionData);iCounter++)
				[ ] lsTransaction = lsTransactionData[iCounter]
				[+] if(lsTransaction[1]==NULL)
					[ ] break
					[ ] 
				[ ] lsTransaction[4]= sDateStamp
				[ ] ////add only invoice transactions
				[ ] lsTransaction[2]="INVC"
				[ ] iAmount=VAL(lsTransaction[3])
				[ ] AddBusinessTransaction(lsTransaction[1],lsTransaction[2],Str(iAmount),lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7])
				[ ] 
				[ ] //Verify transaction is added to the register
				[ ] iValidate=VerifyTransactionInAccountRegister(trim(lsTransaction[6]),sAfterExpected)
				[ ] 
				[-] if(iValidate==PASS)
					[ ] ReportStatus("Verify Customer Invoice data entered",PASS ,"Customer Invoice data with payee: {lsTransaction[6]} is entered successfully")
				[-] else
					[ ] ReportStatus("Verify Customer Invoice data entered",FAIL ,"Customer Invoice data with payee: {lsTransaction[6]} is not entered successfully")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.ViewAllInvoices.Select()
			[ ] 
			[-] if(DlgViewAllInvoice.Exists(5))
				[ ] DlgViewAllInvoice.SetActive()
				[ ] sHandle = Str(DlgViewAllInvoice.SelectAccount.ListBox1.GetHandle())
				[ ] 
				[-] for(iCount=1;iCount<=ListCount(lsTransactionData);iCount++)
					[ ] lsTransaction = lsTransactionData[iCount]
					[+] if (lsTransaction[1]==NULL)
						[ ] break
					[ ] 
					[ ] iAmount=VAL(lsTransaction[3])
					[-] for(iCounter =0;iCounter<=DlgViewAllInvoice.SelectAccount.ListBox1.GetItemCount();iCounter++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}") 
						[ ] bMatch = MatchStr("*{lsTransaction[6]}*{iAmount}*",sActual)
						[-] if(bMatch==TRUE)
							[ ] break
					[-] if(bMatch == TRUE)
						[ ] ReportStatus("Verify Customer Added in All Invoice window Correctly ", PASS , " Customer{lsTransaction[6]} got added in All Invoice window sucessfully")
					[-] else
						[ ] ReportStatus("Verify Customer Added in All Invoice window Correctly ", FAIL , "Expected : {lsTransaction} Actual : {sActual} not got added in All Invoice window sucessfully")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify Creation of sales Tax account#####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test20_CreationSalesTaxFunctionality() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Creation of sales Tax account
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 27 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase  Test20_CreationSalesTaxFunctionality()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sTaxName,sPercentage
	[ ] LIST OF STRING lsTaxAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "AddBusinessTransaction"
	[ ] sTaxName = "Tax 01"
	[ ] sPercentage = "2.0%"
	[ ] 
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsAccount = lsExcelData[1]
	[ ] 
	[-] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[-] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Create New Tax Account
			[ ] iResult=CreateNewTaxAccount(sTaxName,sPercentage)
			[ ] 
			[+] if(iResult==PASS)
				[ ] //Navigate to Actions >> Invoice Default 
				[ ] NavigateToAccountActionBanking(18)
				[ ] 
				[+] if(DlgSetInvoiceDefaults.Exists(5))
					[ ] DlgSetInvoiceDefaults.SetActive()
					[ ] ReportStatus("Verify Navigation to Invoice default", PASS , "Invoice default dialog is displayed")
					[ ] 
					[ ] lsTaxAccount=DlgSetInvoiceDefaults.TaxAccountPopupList.GetContents()
					[ ] DlgSetInvoiceDefaults.SetActive()
					[ ] DlgSetInvoiceDefaults.CancelButton.Click()
					[ ] WaitForState(DlgSetInvoiceDefaults , FALSE , 3)
					[+] for(i=1;i<=ListCount(lsTaxAccount);i++)
						[ ] bMatch = MatchStr(lsTaxAccount[i],sTaxName)
						[+] if(bMatch==TRUE)
							[ ] break
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify New Tax Account created", PASS , "New Tax Account : {sTaxName} created successfully")
					[+] else
						[ ] ReportStatus("Verify New Tax Account created", FAIL , "New Tax Account : {sTaxName} is not created successfully")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Navigation to Invoice default", FAIL , "Invoice default dialog is not displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify New Tax Account created", FAIL , "New Tax Account : {sTaxName} is not created successfully")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify Save & New functionality on Customer Invoice dialog.#####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_SaveNewInvoiceFunctionality() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Save & New functionality on Customer Invoice dialog.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 29 May 2013        	Created by	Anagha Bhandare
		[ ] //Failing at last step need to update payee							
	[ ] // ********************************************************
[+] testcase  Test21_SaveNewInvoiceFunctionality()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer,sCategory,sAmount,sMemo
	[ ] LIST OF STRING lsTaxAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "CustomerInvoice"
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction=lsTransactionData[3]
		[ ] lsAccount = lsExcelData[1]
		[ ] //Rename payee to get currect count
		[ ] 
	[ ] 
	[-] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[-] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify displaying of Choose Invoice account dialog.
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateInvoice.Select()
			[ ] 
			[-] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[ ] 
				[-] if (DlgInvoice.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Customer Invoice form",PASS ,"Customer Invoice form is displayed")
					[ ] //Enter Data for Customer Invoice form
					[ ] DlgInvoice.SetActive()
					[ ] DlgInvoice.CustomerTextField.SetText(lsTransaction[1])
					[ ] DlgInvoice.QWListViewerItem.ListBox.Select("#1")
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(Replicate (KEY_SHIFT_TAB,2))
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(lsTransaction[7]) 
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(lsTransaction[11]) 
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
					[ ] DlgInvoice.CustomerMessageTextField.SetText(lsTransaction[14])
					[ ] DlgInvoice.SaveAndNewButton.Click()
					[ ] 
					[+] if (DlgInvoice.Exists(5))
						[ ] DlgInvoice.SetActive()
						[ ] sCustomer=DlgInvoice.CustomerTextField.GetText()
						[ ] sMemo=DlgInvoice.CustomerMessageTextField.GetText()
						[ ] 
						[ ] DlgInvoice.CancelButton.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.Yes.Click()
							[ ] 
						[ ] 
						[ ] 
						[+] if(sCustomer=="" && sMemo =="")
							[ ] ReportStatus("Verify Save and New Button Functionality", PASS , "After clicking Save & New Button, a new form is opened again and there is no contents in the form")
							[ ] 
							[ ] //Verify the vaild Customer is entered while adding transaction in Register
							[ ] iResult=VerifyTransactionInAccountRegister(lsTransaction[1],sAfterExpected)
							[ ] 
							[+] if(iResult==PASS)
								[ ] ReportStatus("Verify Save and New Button Functionality", PASS , "The Previous Invoice transaction got added successfully ")
							[+] else
								[ ] ReportStatus("Verify Save and New Button Functionality", FAIL , "The Previous Invoice transaction not got added successfully ")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Save and New Button Functionality", FAIL , "After clicking Save & New Button, a new form is not opened again and there is contents in the form")
						[ ] 
					[ ] 
					[-] else
						[ ] ReportStatus("Verify New Customer Invoice form",FAIL ,"New Customer Invoice form is not displayed")
					[ ] 
				[-] else
					[ ] ReportStatus("Verify Customer Invoice form",FAIL ,"Customer Invoice form is not displayed")
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify Save & New functionality on Create Bill dialog.#########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test22_SaveNewBillFunctionality() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Save & New functionality on  Create Bill dialog.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 29 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase  Test22_SaveNewBillFunctionality()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer,sCategory,sAmount,sMemo
	[ ] LIST OF STRING lsTaxAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "VendorInvoice"
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction=lsTransactionData[2]
		[ ] lsAccount = lsExcelData[2]
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify displaying of Choose Invoice account dialog.
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.CreateBill.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[ ] 
				[+] if (DlgInvoice.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Customer Invoice form",PASS ,"Customer Invoice form is displayed")
					[ ] //Enter Data for Vendor Invoice form
					[ ] 
					[ ] DlgInvoice.SetActive()
					[ ] DlgInvoice.CustomerTextField.SetText(lsTransaction[1])
					[ ] DlgInvoice.AssignProjectJobButton.Click()
					[ ] SelectProjectJob(NULL ,lsTransaction[2])
					[ ] DlgInvoice.QWListViewerItem.ListBox.Select("#1")
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(Replicate (KEY_SHIFT_TAB,1))
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(lsTransaction[7]) 
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(lsTransaction[11]) 
					[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
					[ ] DlgInvoice.SaveAndNewButton.Click()
					[ ] 
					[+] if (DlgInvoice.Exists(5))
						[ ] DlgInvoice.SetActive()
						[ ] sMemo=DlgInvoice.CustomerTextField.GetText()
						[ ] 
						[ ] DlgInvoice.CancelButton.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.Yes.Click()
							[ ] 
						[ ] 
						[ ] 
						[+] if( sMemo =="")
							[ ] ReportStatus("Verify Save and New Button Functionality", PASS , "After clicking Save & New Button, a new form is opened again and there is no contents in the form")
							[ ] 
							[ ] //Verify the vaild Vendor is entered while adding transaction in Register
							[ ] iResult=VerifyTransactionInAccountRegister(lsTransaction[1],sAfterExpected)
							[ ] MDIClient.AccountRegister.SearchWindow.SetText("")
							[ ] sleep(2)
							[ ] 
							[+] if(iResult==PASS)
								[ ] ReportStatus("Verify Save and New Button Functionality", PASS , "The Previous Invoice transaction with payee: {lsTransaction[1]} got added successfully ")
							[+] else
								[ ] ReportStatus("Verify Save and New Button Functionality", FAIL , "The Previous Invoice transaction with payee: {lsTransaction[1]} didn't get added successfully ")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Save and New Button Functionality", FAIL , "After clicking Save & New Button, a new form is not opened again and there is contents in the form")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Invoice dialog appeared." ,FAIL , "Invoice dialog didn't appear.")
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify Print statement functionality####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_PrintStatementFunctionality() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify Print statement functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 29 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test23_PrintStatementFunctionality()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer,sDateFormat
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "FinanceCharge "
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] sDateFormat="mm/dd/yyyy"
	[ ] sDateStamp = ModifyDate(2,sDateFormat)
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction = lsTransactionData[1]
		[ ] sCustomer = lsTransaction[1]
		[ ] lsAccount = lsExcelData[1]
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify displaying of Choose Invoice account dialog.
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.PrintStatements.Select()
			[ ] 
			[ ] //Verify the Customer Statement window exists
			[+] if(DlgCustomerStatements.Exists(5))
				[ ] ReportStatus("Verify Customer Statement window ", PASS , "Customer Statement window is displayed")
				[ ] DlgCustomerStatements.SetActive()
				[ ] DlgCustomerStatements.PrintButton.Click()
				[ ] 
				[ ] //Verify the Print Invoice window exists
				[+] if(DlgPrintInvoice.Exists(5))
					[ ] ReportStatus("Verify Print Invoice window ", PASS , "Print Invoice window is displayed")
					[ ] DlgPrintInvoice.SetActive()
					[ ] DlgPrintInvoice.PreviewButton.Click()
					[ ] 
					[ ] //Verify the Print Preview window exists
					[+] if(DlgPrintPreview.Exists(5))
						[ ] DlgPrintPreview.SetActive()
						[ ] ReportStatus("Verify Print Preview window for Inovice ", PASS , "Print Preview window for Inovice is displayed")
						[ ] 
						[+] if(DlgPrintPreview.PrintButton.Exists(5) && DlgPrintPreview.PrintButton.IsEnabled() )
							[ ] ReportStatus("Verify Print Button on Print Preview window for Inovice ", PASS , " Print Button is present Print Preview window for Inovice is displayed")
						[+] else
							[ ] ReportStatus("Verify Print Button on Print Preview window for Inovice ", FAIL , " Print Button is present Print Preview window for Inovice is displayed")
						[ ] 
						[ ] DlgPrintPreview.Close()
						[ ] WaitForState(DlgPrintPreview , FALSE ,3)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Print Preview window for Inovice ", FAIL , "Print Preview window for Inovice is displayed")
					[+] if (DlgPrintInvoice.Exists())
						[ ] DlgPrintInvoice.SetActive()
						[ ] DlgPrintInvoice.Close()
				[+] else
					[ ] ReportStatus("Verify Print Invoice window ", FAIL , "Print Invoice window is displayed")
			[+] else
				[ ] ReportStatus("Verify Customer Statement window ", PASS , "Customer Statement window is displayed")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify create Estimate functionality####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test24_CreateEstimateFunctionality() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify create Estimate functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 31 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test24_CreateEstimateFunctionality()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer
	[ ] LIST OF STRING lsAccount
	[ ] INTEGER iAmount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "Estimate"
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsAccount = lsExcelData[1]
	[ ] 
	[-] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[-] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[-] 
				[ ] //Enter Data for Create Estimate form
				[-] for(i=1;i<=ListCount(lsTransactionData);i++)
					[ ] lsTransaction = lsTransactionData[i]
					[-] if(lsTransaction[1]==NULL)
						[ ] break
					[ ] //Verify Business > Invoices And Estimates > Create Estimate
					[ ] QuickenWindow.SetActive()
					[ ] QuickenWindow.Business.Click()
					[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
					[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateEstimate.Select()
					[ ] 
					[ ] WaitForState(EstimateList.DlgEstimate,TRUE,2)
					[ ] 
					[ ] //Verify the Create Estimate window exists
					[-] if(EstimateList.DlgEstimate.Exists(5))
						[ ] ReportStatus("Verify Create Estimate window ", PASS , "Create Estimate window is displayed")
						[ ] 
						[ ] 
						[ ] iValidate=AddEstimate(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8],lsTransaction[9],lsTransaction[10],lsTransaction[11],lsTransaction[12],lsTransaction[13])
						[ ] 
						[-] if(iValidate == PASS)
							[ ] //Verify Add Estimate for Customer
							[ ] ReportStatus("Verify Add Estimate for Customer  ", PASS , "Add Estimate for Customer {lsTransaction[1]}  is added")
							[ ] 
							[-] if(EstimateList.Exists(5))
								[ ] //Verify Estimate List window
								[ ] ReportStatus("Verify Estimate List window ", PASS , "Estimate List window  is displayed")
								[ ] 
								[ ] sHandle = Str(EstimateList.EstimateList.ListBox1.GetHandle())
								[ ] 
								[+] for(iCounter =0;iCounter<=EstimateList.EstimateList.ListBox1.GetItemCount();iCounter++)
									[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}") 
									[ ] iAmount= VAL(lsTransaction[10])
									[ ] bMatch = MatchStr("*{lsTransaction[1]}*{Str(iAmount)}*",sActual)
									[+] if(bMatch==TRUE)
										[ ] break
								[+] if(bMatch == TRUE)
									[ ] ReportStatus("Verify Customer Added in Estimate window Correctly ", PASS , " Customer{lsTransaction[1]} got added in Estimate window sucessfully")
								[+] else
									[ ] ReportStatus("Verify Customer Added in Estimate window Correctly ", FAIL , "Expected : {lsTransaction} Actual : {sActual} not got added in Estimate window sucessfully")
									[ ] 
								[ ] 
								[ ] EstimateList.SetActive()
								[ ] EstimateList.Close()
								[ ] WaitForState(EstimateList.DlgEstimate,FALSE,2)
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Estimate List window ", FAIL , "Estimate List window is not displayed")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Add Estimate for Customer  ", FAIL , "Add Estimate for Customer {lsTransaction[1]}  is not added")
					[+] else
						[ ] ReportStatus("Verify Create Estimate window ", FAIL , "Create Estimate window is not displayed")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify displaying of help for  create Estimate functionality.#######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test25_HelpEstimateFunctionality() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify displaying of help for  create Estimate functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 31 May 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test25_HelpEstimateFunctionality()   appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "Estimate"
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsAccount = lsExcelData[1]
	[ ] 
	[-] if (QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[-] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify Business > Invoices And Estimates > Create Estimate
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateEstimate.Select()
			[ ] 
			[ ] WaitForState(EstimateList.DlgEstimate,TRUE,2)
			[ ] 
			[ ] //Verify the Create Estimate window exists
			[-] if(EstimateList.DlgEstimate.Exists(5))
				[ ] ReportStatus("Verify Create Estimate window ", PASS , "Create Estimate window is displayed")
				[ ] 
				[ ] 
				[ ] //Verify Help icon on Create Estimate window
				[-] if(EstimateList.DlgEstimate.HelpButton.Exists(5))
					[ ] ReportStatus("Verify  Help Icon on Create Estimate window", PASS , "Help Icon is present in Create Estimate window ")
					[ ] 
					[ ] EstimateList.DlgEstimate.HelpButton.click()
					[ ] sleep(3)
					[ ] 
					[+] //Help Dialog gets opened
						[+] if(QuickenHelp.Exists(5))
							[ ] ReportStatus("Verify Help Dialog ", PASS , "Help Dialog is present ")
							[ ] QuickenHelp.Close()
							[ ] WaitForState(QuickenHelp,FALSE,2)
						[+] else
							[ ] ReportStatus("Verify Help Dialog", FAIL , "Help Dialog is not present")
					[ ] 
					[ ] EstimateList.DlgEstimate.Close()
					[ ] WaitForState(EstimateList.DlgEstimate,FALSE,2)
					[+] if(EstimateList.Exists(2))
						[ ] EstimateList.SetActive()
						[ ] EstimateList.Close()
						[ ] WaitForState(EstimateList,FALSE,2)
				[+] else
					[ ] ReportStatus("Verify  Help Icon on Create Estimate window", FAIL , "Help Icon is NOT present in Create Estimate window ")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Create Estimate window ", FAIL , "Create Estimate window is not displayed")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify View all Invoice items functionality.#################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test26_AllInvoiceItemsFunctionality() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify View all Invoice items functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 03 June, 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test26_AllInvoiceItemsFunctionality()    appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sBeforeExpected,sAfterExpected,sBalance,sCustomer
	[ ] LIST OF STRING lsAccount,lsExpected
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "InvoiceForm"
	[ ] sBeforeExpected = "0"
	[ ] sAfterExpected = "1"
	[ ] 
	[-] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsAccount = lsExcelData[1]
	[ ] 
	[-] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[-] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[-] for(i=5;i<=6;i++)
				[ ] //Navigate to Business >> Invoices and Estimates  >> Create Inovice
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Business.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateInvoice.Select()
				[ ] 
				[-] if(ChooseInvoiceAccount.Exists(5))
					[ ] ChooseInvoiceAccount.SetActive()
					[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
					[ ] ChooseInvoiceAccount.OK.Click()
					[ ] WaitForState(ChooseInvoiceAccount , false ,3)
					[ ] 
					[ ] 
					[-] if (DlgInvoice.Exists(5))
						[ ] 
						[ ] ReportStatus("Verify Customer Invoice form",PASS ,"Customer Invoice form is displayed")
						[ ] 
						[ ] lsTransaction=lsTransactionData[i]
						[ ] 
						[ ] //Enter Data for Customer Invoice form
						[ ] iValidate=AddBusinessInvoiceTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7],lsTransaction[8],lsTransaction[9],lsTransaction[10],lsTransaction[11],lsTransaction[12],lsTransaction[13],lsTransaction[14])
						[ ] 
						[-] if(iValidate==PASS)
							[ ] ReportStatus("Verify Customer Invoice form data entered",PASS ,"Customer Invoice form data is entered successfully")
						[+] else
							[ ] ReportStatus("Verify Customer Invoice form data entered",FAIL ,"Customer Invoice form data is not entered successfully")
						[ ] 
						[ ] 
						[ ] ListAppend(lsExpected,lsTransaction[6])
					[+] else
						[ ] ReportStatus("Verify Customer Invoice form",FAIL ,"Customer Invoice form is not displayed")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] //Verify Business > Invoices And Estimates > Create Estimate
			[ ] QuickenWindow.Business.InvoicesAndEstimates.ViewAllInvoiceItems.Select()
			[ ] 
			[ ] WaitForState(DlgCustomizeInvoiceItems,TRUE,2)
			[ ] 
			[ ] //Verify the Create Estimate window exists
			[-] if(DlgCustomizeInvoiceItems.Exists(5))
				[ ] ReportStatus("Verify Customize Invoices Items window ", PASS , "Customize Invoices Items window is displayed")
				[ ] 
				[ ] sHandle = Str(DlgCustomizeInvoiceItems.CustomizeInvoiceItems1.ListBox1.GetHandle())
				[-] for(iCount =1; iCount<=ListCount(lsExpected) ;iCount++)
					[-] for(iCounter =0;iCounter<=DlgCustomizeInvoiceItems.CustomizeInvoiceItems1.ListBox1.GetItemCount();iCounter++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}") 
						[ ] bMatch = MatchStr("*{lsExpected[iCount]}*",sActual)
						[-] if(bMatch==TRUE)
							[ ] break
					[-] if(bMatch == TRUE)
						[ ] ReportStatus("Verify Customer Added in Address Book Record Correctly ", PASS , " Customer{lsExpected[iCount]} got added in Address Book Record sucessfully")
					[+] else
						[ ] ReportStatus("Verify Customer Added in Address Book Record Correctly ", FAIL , "Expected : {lsExpected} Actual : {sActual} got added in Address Book Record sucessfully")
				[ ] 
				[ ] DlgCustomizeInvoiceItems.SetActive()
				[ ] DlgCustomizeInvoiceItems.Close()
			[+] else
				[ ] ReportStatus("Verify Create Estimate window ", FAIL , "Create Estimate window is not displayed")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify View saved customer Messages functionality##########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test27_SavedCustomerMessagesFunctionality() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify View saved customer Messages functionality.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 03 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test27_SavedCustomerMessagesFunctionality() appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sCustomerMessage
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sCustomerMessage="This is Test Message"
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] // lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsAccount = lsExcelData[1]
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[+] //Verify Business > Invoices And Estimates > Create Estimate
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Business.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
				[ ] QuickenWindow.Business.InvoicesAndEstimates.ViewSavedCustomerMessages.Select()
			[ ] 
			[ ] WaitForState(DlgEditCustomerMessages,TRUE,2)
			[ ] 
			[ ] //Verify the Edit Customer Messages window exists
			[+] if(DlgEditCustomerMessages.Exists(5))
				[ ] ReportStatus("Verify Edit Customer Messages window ", PASS , "Edit Customer Messages window is displayed")
				[ ] 
				[ ] DlgEditCustomerMessages.MessageToAddReplace1TextField.SetText(sCustomerMessage)
				[ ] DlgEditCustomerMessages.AddButton.Click()
				[ ] 
				[ ] sHandle = Str(DlgEditCustomerMessages.CustomerMessages.ListBox1.GetHandle())
				[+] for(iCounter =0;iCounter<=DlgEditCustomerMessages.CustomerMessages.ListBox1.GetItemCount();iCounter++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"{iCounter}") 
					[ ] bMatch = MatchStr("*{sCustomerMessage}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify Customer Message Added in Customer Messages Correctly ", PASS , " Customer Message{sCustomerMessage} got added in Customer Messages sucessfully")
				[+] else
					[ ] ReportStatus("Verify Customer Message Added in Customer Messages Correctly ", FAIL , "Expected : {sCustomerMessage} Actual : {sActual} got added in Customer Messages sucessfully")
				[ ] 
				[ ] 
				[ ] DlgEditCustomerMessages.Close()
			[+] else
				[ ] ReportStatus("Verify Create Estimate window ", FAIL , "Create Estimate window is not displayed")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify displaying of design Invoice forms dialog#############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test28_DesignInvoiceFormsFunctionality() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify displaying of design Invoice forms dialog.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 03 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test28_DesignInvoiceFormsFunctionality()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sDialogName,sActualName
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sDialogName = "Forms Designer:  Credit Default"
	[ ] 
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsAccount = lsExcelData[1]
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify Business > Invoices And Estimates > Create Estimate
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.DesignInvoiceForms.Select()
			[ ] 
			[ ] WaitForState(DlgFormsDesigner,TRUE,2)
			[ ] 
			[ ] //Verify Design Form -Estimate Default window exists
			[+] if(DlgFormsDesigner.Exists(5))
				[ ] DlgFormsDesigner.SetActive()
				[ ] sActualName=DlgFormsDesigner.getcaption()
				[+] if(sDialogName==sActualName)
					[ ] ReportStatus("Verify Design Form -Estimate Default window ", PASS , "{sDialogName} is displayed")
				[+] else
					[ ] ReportStatus("Verify Design Form -Estimate Default window ", FAIL , "{sDialogName} window is not displayed the actual dialog is: {sActualName}.")
				[ ] 
				[ ] DlgFormsDesigner.SetActive()
				[ ] DlgFormsDesigner.Close()
				[ ] WaitForState(DlgFormsDesigner,FALSE,2)
			[+] else
				[ ] ReportStatus("Verify Design Form -Estimate Default window ", FAIL , "Design Form -Estimate Default window is not displayed")
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify UI of Customer Invoice dialog -> Create Invoice########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test29_UIofCreateInvoice () 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify UI of Customer Invoice dialog -> Create Invoice 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 03 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test29_UIofCreateInvoice ()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sDialogName,sActualName
	[ ] LIST OF STRING lsAccount,lsCompare,lsLayout,lsTaxAccount
	[ ] 
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] 
	[ ] // sActualName = "Forms Designer : Estimate Default"
	[ ] 
	[ ] sActualName = "Forms Designer:  Credit Default"
	[ ] lsLayout ={"Credit Default","Invoice Default", "<Customize>"}
	[ ] lsTaxAccount ={"*Sales Tax*","Tax 01","<New>","<Edit>"}
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsAccount=lsExcelData[1]
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify Business > Invoices And Estimates > Create Invoice
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateInvoice.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[ ] 
				[ ] WaitForState(DlgInvoice,TRUE,2)
				[ ] 
				[+] if (DlgInvoice.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Invoice- Customer Invoice window ", PASS , "Invoice- Customer Invoice window is displayed")
					[ ] 
					[+] //Verifying UI controls for the Add Customer Invoice Details on Customer Invoice window
						[ ] 
						[+] //Verify the Customer Text Field present on Customer Invoice window
							[+] if(DlgInvoice.CustomerTextField.Exists(5))
								[ ] ReportStatus("Verify Customer Text Field on Add Customer Invoice Details dialog ", PASS , " Customer Text Field is present on Add Customer Invoice Details dialog")
							[+] else
								[ ] ReportStatus("Verify Customer Text Field on Add Customer Invoice Details dialog", FAIL , "Customer Text Field is not present on Add Customer Invoice Details dialog")
						[ ] 
						[+] //Verify the  Project Job Text Field present on Customer Invoice window
							[+] if(DlgInvoice.ProjectJobTextField.Exists(5))
								[ ] ReportStatus("Verify  Project Job Text Field on Customer Invoice window ", PASS , "  Project Job Text Field is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify  Project Job Text Field on Customer Invoice window", FAIL , " Project Job Text Field is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the  Project Layout Popup List present on Customer Invoice window
							[+] if(DlgInvoice.LayoutPopupList.Exists(5))
								[ ] ReportStatus("Verify  Layout Popup List on Customer Invoice window ", PASS , "  Layout Popup List is present on Customer Invoice window")
								[ ] 
								[ ] lsCompare=DlgInvoice. LayoutPopupList.GetContents()
								[ ] 
								[+] for(i=1;i<=ListCount(lsCompare);i++)
									[+] if(lsLayout[i]==lsCompare[i])
										[ ] ReportStatus("Verify the Contents of How often List",PASS,"As {lsLayout[i]} is present in Layout Popup List")
									[+] else
										[ ] ReportStatus("Verify the Contents of How often List",FAIL,"As {lsLayout[i]}, {lsCompare[i]} is not present in Layout Popup List")
							[+] else
								[ ] ReportStatus("Verify  Layout Popup List on Customer Invoice window", FAIL , " Layout Popup List is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the  Business Tag TextField present on Customer Invoice window
							[+] if(DlgInvoice.BusinessTagTextField.Exists(5))
								[ ] ReportStatus("Verify  Business Tag TextField on Customer Invoice window ", PASS , "  Business Tag TextField is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify  Business Tag TextField on Customer Invoice window", FAIL , " Business Tag TextField is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the DATE TextField present on Customer Invoice window
							[+] if(DlgInvoice.DATETextField.Exists(5))
								[ ] ReportStatus("Verify  DATE Text Field on Customer Invoice window ", PASS , " DATE Text Field is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify  DATE Text Field on Customer Invoice window", FAIL , " DATE Text Field is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the INVOICE TextField present on Customer Invoice window
							[+] if(DlgInvoice.INVOICETextField.Exists(5))
								[ ] ReportStatus("Verify INVOICE TextField on Customer Invoice window ", PASS , " INVOICE TextField is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify INVOICE TextField on Customer Invoice window", FAIL , " INVOICE TextField is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the DUEDATE TextField present on Customer Invoice window
							[+] if(DlgInvoice.DUEDATETextField.Exists(5))
								[ ] ReportStatus("Verify DUEDATE TextField on Customer Invoice window ", PASS , "DUEDATE TextField is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify DUEDATE TextField on Customer Invoice window", FAIL , "DUEDATE TextField is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the PONUMBER TextField present on Customer Invoice window
							[+] if(DlgInvoice.PONUMBERTextField.Exists(5))
								[ ] ReportStatus("Verify PONUMBER TextField on Customer Invoice window ", PASS , "PONUMBER TextField is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify PONUMBER TextField on Customer Invoice window", FAIL , "PONUMBER TextField is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the Item List present on Customer Invoice window
							[+] if(DlgInvoice.QWListViewerItem.Exists(5))
								[ ] ReportStatus("Verify Item List on Customer Invoice window ", PASS , "Item List is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify Item List on Customer Invoice window", FAIL , "Item List is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the Add Lines Button present on Customer Invoice window
							[+] if(DlgInvoice.AddLinesButton.Exists(5))
								[ ] ReportStatus("Verify Add Lines Button on Customer Invoice window ", PASS , "Add Lines Button is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify Add Lines Button on Customer Invoice window", FAIL , "Add Lines Button is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the Tax TextField present on Customer Invoice window
							[+] if(DlgInvoice.TaxTextField.Exists(5))
								[ ] ReportStatus("Verify Tax TextField on Customer Invoice window ", PASS , "Tax TextField is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify Tax TextField on Customer Invoice window", FAIL , "Tax TextField is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the Customer Message TextField present on Customer Invoice window
							[+] if(DlgInvoice.CustomerMessageTextField.Exists(5))
								[ ] ReportStatus("Verify Customer Message TextField  on Customer Invoice window ", PASS , "Customer Message TextField  is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify Customer Message TextField  on Customer Invoice window", FAIL , "Customer Message TextField  is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the Memo TextField present on Customer Invoice window
							[+] if(DlgInvoice.MemoTextField.Exists(5))
								[ ] ReportStatus("Verify Memo TextField on Customer Invoice window ", PASS , "Memo TextField is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify Memo TextField on Customer Invoice window", FAIL , "Memo TextField is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the Tax Account PopupList present on Customer Invoice window
							[+] if(DlgInvoice.TaxAccountPopupList.Exists(5))
								[ ] ReportStatus("Verify Tax Account PopupList on Customer Invoice window ", PASS , "Tax Account PopupList is present on Customer Invoice window")
								[ ] 
								[ ] lsCompare=DlgInvoice.TaxAccountPopupList.GetContents()
								[ ] 
								[+] for(i=1;i<=ListCount(lsCompare);i++)
									[+] if(lsTaxAccount[i]==lsCompare[i])
										[ ] ReportStatus("Verify the Contents of How often List",PASS,"As {lsTaxAccount[i]} is present in Layout Popup List")
									[+] else
										[ ] ReportStatus("Verify the Contents of How often List",FAIL,"As {lsTaxAccount[i]}, {lsCompare[i]} is not present in Layout Popup List")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Tax Account PopupList on Customer Invoice window", FAIL , "Tax Account PopupList is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the Receive Payment Button present on Customer Invoice window
							[+] if(DlgInvoice.ReceivePaymentButton.Exists(5))
								[ ] ReportStatus("Verify Receive Payment Button on Customer Invoice window ", PASS , "Receive Payment Button is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify Receive Payment Button on Customer Invoice window", FAIL , "Receive Payment Button is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the Payment History Button present on Customer Invoice window
							[+] if(DlgInvoice.PaymentHistoryButton.Exists(5))
								[ ] ReportStatus("Verify Payment History Button on Customer Invoice window ", PASS , "Payment History Button is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify Payment History Button on Customer Invoice window", FAIL , "Payment History Button is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the Expenses Button present on Customer Invoice window
							[+] if(DlgInvoice.ExpensesButton.Exists(5))
								[ ] ReportStatus("Verify Expenses Button on Customer Invoice window ", PASS , "Expenses Button is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify Expenses Button on Customer Invoice window", FAIL , "Expenses Button is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the EMail Send To Clipboard Button present on Customer Invoice window
							[+] if(DlgInvoice.EMailSendToClipboardButton.Exists(5))
								[ ] ReportStatus("Verify EMail Send To Clipboard Button on Customer Invoice window ", PASS , "EMail Send To Clipboard Button is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify EMail Send To Clipboard Button on Customer Invoice window", FAIL , "EMail Send To Clipboard Button is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the Save And New Button present on Customer Invoice window
							[+] if(DlgInvoice.SaveAndNewButton.Exists(5))
								[ ] ReportStatus("Verify Save And New Button on Customer Invoice window ", PASS , "Save And New Button is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify Save And New Button on Customer Invoice window", FAIL , "Save And New Button is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the Save And Done Button present on Customer Invoice window
							[+] if(DlgInvoice.SaveAndDoneButton.Exists(5))
								[ ] ReportStatus("Verify Save And Done Button on Customer Invoice window ", PASS , "Save And Done Button is present on Customer Invoice window")
							[+] else
								[ ] ReportStatus("Verify Save And Done Button on Customer Invoice window", FAIL , "Save And Done Button is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the Cancel Button present on Customer Invoice window
							[+] if(DlgInvoice.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel Button on Customer Invoice window ", PASS , "Cancel Button is present on Customer Invoice window")
								[ ] DlgInvoice.CancelButton.Click()
								[+] if(AlertMessage.Exists(5))
									[ ] AlertMessage.Yes.Click()
							[+] else
								[ ] ReportStatus("Verify Cancel Button on Customer Invoice window", FAIL , "Cancel Button is present on Customer Invoice window")
					[ ] ///Close Invoice dialog
					[+] if(DlgInvoice.Exists(5))
						[ ] DlgInvoice.Close()
						[ ] WaitForState(DlgInvoice , FALSE ,5)
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Invoice- Customer Invoice window ", FAIL , "Invoice- Customer Invoice window is displayed")
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify UI of Customer Invoice dialog -> Receive Payment#######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test30_UIofReceivePayment() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify UI of Customer Invoice dialog -> Receive Payment 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 03 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test30_UIofReceivePayment()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sDialogName,sActualName
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] 
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsAccount=lsExcelData[1]
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify Business > Invoices And Estimates >  Receive Payment
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.ReceiveACustomerPayment.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[ ] 
				[ ] 
				[+] if (DlgPaymentInvoices.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Invoice- Customer Invoice window ", PASS , "Invoice- Customer Invoice window is displayed")
					[ ] 
					[+] //Verifying UI controls for the Add Customer Payment Details on Customer Payment window
						[ ] 
						[+] //Verify the Customer Text Field present on Customer Payment window
							[+] if(DlgPaymentInvoices.CustomerVendorTextField.Exists(5))
								[ ] ReportStatus("Verify Customer Text Field on Add Customer Payment Details dialog ", PASS , " Customer Text Field is present on Add Customer Payment Details dialog")
							[+] else
								[ ] ReportStatus("Verify Customer Text Field on Add Customer Payment Details dialog", FAIL , "Customer Text Field is not present on Add Customer Payment Details dialog")
						[ ] 
						[+] //Verify the DATE TextField present on Customer Payment window
							[+] if(DlgPaymentInvoices.DATETextField.Exists(5))
								[ ] ReportStatus("Verify  DATE Text Field on Customer Payment window ", PASS , " DATE Text Field is present on Customer Payment window")
							[+] else
								[ ] ReportStatus("Verify  DATE Text Field on Customer Payment window", FAIL , " DATE Text Field is not present on Customer Payment window")
						[ ] 
						[+] //Verify the CHECKNUMBER TextField present on Customer Payment window
							[+] if(DlgPaymentInvoices.CheckNumberTextField.Exists(5))
								[ ] ReportStatus("Verify CHECKNUMBER TextField on Customer Payment window", PASS , "CHECKNUMBER TextField is present on Customer Payment window")
							[+] else
								[ ] ReportStatus("Verify CHECKNUMBER TextField on Customer Payment window", FAIL , "CHECKNUMBER TextField is not present on Customer Payment window")
						[ ] 
						[+] //Verify the Enter Button present on Customer Payment window
							[+] if(DlgPaymentInvoices.EnterButton.Exists(5))
								[ ] ReportStatus("Verify Enter Button present on Customer Payment window ", PASS , "Enter Button present on Customer Payment window")
							[+] else
								[ ] ReportStatus("Verify Enter Button present on Customer Payment window", FAIL , "Enter Button present on Customer Payment window")
						[ ] 
						[+] //Verify the Memo TextField present on Customer Payment window
							[+] if(DlgPaymentInvoices.MemoTextField.Exists(5))
								[ ] ReportStatus("Verify Memo TextField on Customer Payment window", PASS , "Memo TextField is present on Customer Payment window")
							[+] else
								[ ] ReportStatus("Verify Memo TextField on Customer Payment window", FAIL , "Memo TextField is not present on Customer Payment window")
						[ ] 
						[+] //Verify the OK Button present on Customer Payment window
							[+] if(DlgPaymentInvoices.OKButton.Exists(5))
								[ ] ReportStatus("Verify OK Button on Customer Payment window ", PASS , "OK Button is present on Customer Payment window")
							[+] else
								[ ] ReportStatus("Verify OK Button on Customer Payment window", FAIL , "OK Button is not present on Customer Payment window")
						[ ] 
						[+] //Verify the Cancel Button present on Customer Payment window
							[+] if(DlgPaymentInvoices.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel Button on Customer Payment window ", PASS , "Cancel Button is present on Customer Payment window")
								[ ] DlgPaymentInvoices.CancelButton.Click()
								[+] if(AlertMessage.Exists(2))
									[ ] AlertMessage.SetActive()
									[ ] AlertMessage.Yes.Click()
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Cancel Button on Customer Payment window", FAIL , "Cancel Button is not present on Customer Payment window")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Invoice- Customer Invoice window ", FAIL , "Invoice- Customer Invoice window is displayed")
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //##################################################################;######
[ ] 
[+] //#############Verify UI of Customer Invoice dialog -> Issue  a Credit########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test31_UIofIssueACredit() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify UI of Customer Invoice dialog -> Issue  a Credit 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 03 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test31_UIofIssueACredit()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sDialogName,sActualName
	[ ] LIST OF STRING lsAccount,lsLayout,lsTaxAccount,lsCompare
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] // sActualName = "Forms Designer : Estimate Default"
	[ ] lsLayout ={"Credit Default","Invoice Default", "<Customize>"}
	[ ] lsTaxAccount ={"*Sales Tax*","Tax 01","<New>","<Edit>"}
	[ ] 
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsAccount=lsExcelData[1]
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify Business > Invoices And Estimates > Issue  a Credit
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.IssueACredit.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[ ] 
				[ ] 
				[+] if (DlgCreditInvoices.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Customer Credit window ", PASS , "Customer Credit window is displayed")
					[ ] 
					[+] //Verifying UI controls  on Customer Credit window
						[ ] 
						[+] //Verify the Customer Text Field present on Customer Credit window
							[+] if(DlgCreditInvoices.CustomerTextField.Exists(5))
								[ ] ReportStatus("Verify Customer Text Field on Add Customer Credit dialog ", PASS , " Customer Text Field is present on Customer Credit dialog")
							[+] else
								[ ] ReportStatus("Verify Customer Text Field on Add Customer Credit dialog", FAIL , "Customer Text Field is not present on Customer Credit dialog")
						[ ] 
						[+] //Verify the  Project Job Text Field present on Customer Credit window
							[+] if(DlgCreditInvoices.ProjectJobTextField.Exists(5))
								[ ] ReportStatus("Verify  Project Job Text Field on Customer Credit window ", PASS , "  Project Job Text Field is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify  Project Job Text Field on Customer Credit window", FAIL , " Project Job Text Field is not present on Customer Credit window")
						[ ] 
						[+] //Verify the  Project Layout Popup List present on Customer Credit window
							[+] if(DlgCreditInvoices.LayoutPopupList.Exists(5))
								[ ] ReportStatus("Verify  Layout Popup List on Customer Credit window ", PASS , "  Layout Popup List is present on Customer Credit window")
								[ ] 
								[ ] lsCompare=DlgCreditInvoices. LayoutPopupList.GetContents()
								[ ] 
								[+] for(i=1;i<=ListCount(lsCompare);i++)
									[+] if(lsLayout[i]==lsCompare[i])
										[ ] ReportStatus("Verify the Contents of How often List",PASS,"As {lsLayout[i]} is present in Layout Popup List")
									[+] else
										[ ] ReportStatus("Verify the Contents of How often List",FAIL,"As {lsLayout[i]}, {lsCompare[i]} is not present in Layout Popup List")
							[+] else
								[ ] ReportStatus("Verify  Layout Popup List on Customer Credit window", FAIL , " Layout Popup List is not present on Customer Credit window")
						[ ] 
						[+] //Verify the  Business Tag TextField present on Customer Credit window
							[+] if(DlgCreditInvoices.BusinessTagTextField.Exists(5))
								[ ] ReportStatus("Verify  Business Tag TextField on Customer Credit window ", PASS , "  Business Tag TextField is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify  Business Tag TextField on Customer Credit window", FAIL , " Business Tag TextField is not present on Customer Credit window")
						[ ] 
						[+] //Verify the DATE TextField present on Customer Credit window
							[+] if(DlgCreditInvoices.xDATE1TextField.Exists(5))
								[ ] ReportStatus("Verify  DATE Text Field on Customer Credit window ", PASS , " DATE Text Field is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify  DATE Text Field on Customer Credit window", FAIL , " DATE Text Field is not present on Customer Credit window")
						[ ] 
						[+] //Verify the PONUMBER TextField present on Customer Credit window
							[+] if(DlgCreditInvoices.PONUMBERTextField.Exists(5))
								[ ] ReportStatus("Verify PONUMBER TextField on Customer Credit window ", PASS , "PONUMBER TextField is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify PONUMBER TextField on Customer Credit window", FAIL , "PONUMBER TextField is not present on Customer Credit window")
						[ ] 
						[+] //Verify the Item List present on Customer Credit window
							[+] if(DlgCreditInvoices.QWListViewerItem.Exists(5))
								[ ] ReportStatus("Verify Item List on Customer Credit window ", PASS , "Item List is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify Item List on Customer Credit window", FAIL , "Item List is not present on Customer Credit window")
						[ ] 
						[+] //Verify the Add Lines Button present on Customer Credit window
							[+] if(DlgCreditInvoices.AddLinesButton.Exists(5))
								[ ] ReportStatus("Verify Add Lines Button on Customer Credit window ", PASS , "Add Lines Button is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify Add Lines Button on Customer Credit window", FAIL , "Add Lines Button is not present on Customer Credit window")
						[ ] 
						[+] //Verify the Tax TextField present on Customer Credit window
							[+] if(DlgCreditInvoices.TaxTextField.Exists(5))
								[ ] ReportStatus("Verify Tax TextField on Customer Credit window ", PASS , "Tax TextField is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify Tax TextField on Customer Credit window", FAIL , "Tax TextField is not present on Customer Credit window")
						[ ] 
						[+] //Verify the Customer Message TextField present on Customer Credit window
							[+] if(DlgCreditInvoices.CustomerMessageTextField.Exists(5))
								[ ] ReportStatus("Verify Customer Message TextField  on Customer Credit window ", PASS , "Customer Message TextField  is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify Customer Message TextField  on Customer Credit window", FAIL , "Customer Message TextField  is not present on Customer Credit window")
						[ ] 
						[+] //Verify the Memo TextField present on Customer Credit window
							[+] if(DlgCreditInvoices.MemoTextField.Exists(5))
								[ ] ReportStatus("Verify Memo TextField on Customer Credit window ", PASS , "Memo TextField is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify Memo TextField on Customer Credit window", FAIL , "Memo TextField is not present on Customer Credit window")
						[ ] 
						[+] //Verify the Tax Account PopupList present on Customer Credit window
							[+] if(DlgCreditInvoices.TaxAccountPopupList.Exists(5))
								[ ] ReportStatus("Verify Tax Account PopupList on Customer Invoice window ", PASS , "Tax Account PopupList is present on Customer Invoice window")
								[ ] 
								[ ] lsCompare=DlgCreditInvoices.TaxAccountPopupList.GetContents()
								[ ] 
								[+] for(i=1;i<=ListCount(lsCompare);i++)
									[+] if(lsTaxAccount[i]==lsCompare[i])
										[ ] ReportStatus("Verify the Contents of How often List",PASS,"As {lsTaxAccount[i]} is present in Layout Popup List")
									[+] else
										[ ] ReportStatus("Verify the Contents of How often List",FAIL,"As {lsTaxAccount[i]}, {lsCompare[i]} is not present in Layout Popup List")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Tax Account PopupList on Customer Invoice window", FAIL , "Tax Account PopupList is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the Receive Payment Button present on Customer Credit window
							[+] if(DlgCreditInvoices.ReceivePaymentButton.Exists(5))
								[ ] ReportStatus("Verify Receive Payment Button on Customer Credit window ", PASS , "Receive Payment Button is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify Receive Payment Button on Customer Credit window", FAIL , "Receive Payment Button is not present on Customer Credit window")
						[ ] 
						[+] //Verify the Payment History Button present on Customer Credit window
							[+] if(DlgCreditInvoices.PaymentHistoryButton.Exists(5))
								[ ] ReportStatus("Verify Payment History Button on Customer Credit window ", PASS , "Payment History Button is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify Payment History Button on Customer Credit window", FAIL , "Payment History Button is not present on Customer Credit window")
						[ ] 
						[+] //Verify the Refund Button present on Customer Credit window
							[+] if(DlgCreditInvoices.RefundButton.Exists(5))
								[ ] ReportStatus("Verify Refund Buttonon Customer Credit window ", PASS , "Refund Button is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify Refund Button on Customer Credit window", FAIL , "Refund Button is not present on Customer Credit window")
						[ ] 
						[+] //Verify the EMail Send To Clipboard Button present on Customer Credit window
							[+] if(DlgCreditInvoices.EMailSendToClipboardButton.Exists(5))
								[ ] ReportStatus("Verify EMail Send To Clipboard Button on Customer Credit window ", PASS , "EMail Send To Clipboard Button is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify EMail Send To Clipboard Button on Customer Credit window", FAIL , "EMail Send To Clipboard Button is not present on Customer Credit window")
						[ ] 
						[+] //Verify the Enter Button present on Customer Credit window
							[+] if(DlgCreditInvoices.EnterButton.Exists(5))
								[ ] ReportStatus("Verify Enter Button on Customer Credit window ", PASS , "Enter Button is present on Customer Credit window")
							[+] else
								[ ] ReportStatus("Verify Enter Button on Customer Credit window", FAIL , "Enter Button is not present on Customer Credit window")
						[ ] 
						[+] //Verify the Cancel Button present on Customer Credit window
							[+] if(DlgCreditInvoices.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel Button on Customer Credit window ", PASS , "Cancel Button is present on Customer Credit window")
								[+] DlgCreditInvoices.CancelButton.Click()
									[+] if(AlertMessage.Exists(2))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.Yes.Click()
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Cancel Button on Customer Credit window", FAIL , "Cancel Button is present on Customer Credit window")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Customer Credit window ", FAIL , "Customer Credit window is displayed")
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify UI of Customer Invoice dialog -> Issue  a Refund########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test32_UIofIssueARefund() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify UI of Customer Invoice dialog -> Issue  a Refund
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 03 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test32_UIofIssueARefund()   appstate none
	[+] // Variable Declarations
		[ ] 
		[ ] STRING sDialogName
		[ ] LIST OF STRING lsAccount
		[ ] sRegisterExcel = "BusinessTestData"
		[ ] sAccWorksheet = "Business Accounts"
	[ ] 
	[ ] // Variable Definition
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] // lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsAccount=lsExcelData[1]
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify Business > Invoices And Estimates > Issue  a Refund
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.IssueARefund.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[ ] 
				[ ] 
				[+] if (DlgRefund.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Customer Refund window ", PASS , "Customer Refund window is displayed")
					[ ] 
					[+] //Verifying UI controls  on Customer Refund window
						[ ] 
						[+] //Verify the Customer Text Field present on Customer Refund window
							[+] if(DlgRefund.CustomerTextField.Exists(5))
								[ ] ReportStatus("Verify Customer Text Field on Add Customer Refund dialog ", PASS , " Customer Text Field is present on Customer Refund dialog")
							[+] else
								[ ] ReportStatus("Verify Customer Text Field on Add Customer Refund dialog", FAIL , "Customer Text Field is not present on Customer Refund dialog")
						[ ] 
						[+] //Verify the  Project Job Text Field present on Customer Refund window
							[+] if(DlgRefund.ProjectJobTextField.Exists(5))
								[ ] ReportStatus("Verify  Project Job Text Field on Customer Refund window ", PASS , "  Project Job Text Field is present on Customer Refund window")
							[+] else
								[ ] ReportStatus("Verify  Project Job Text Field on Customer Refund window", FAIL , " Project Job Text Field is not present on Customer Refund window")
						[ ] 
						[+] //Verify the  Business Tag TextField present on Customer Refund window
							[+] if(DlgRefund.BusinessTagTextField.Exists(5))
								[ ] ReportStatus("Verify  Business Tag TextField on Customer Refund window ", PASS , "  Business Tag TextField is present on Customer Refund window")
							[+] else
								[ ] ReportStatus("Verify  Business Tag TextField on Customer Refund window", FAIL , " Business Tag TextField is not present on Customer Refund window")
						[ ] 
						[+] //Verify the DATE TextField present on Customer Refund window
							[+] if(DlgRefund.DateTextField.Exists(5))
								[ ] ReportStatus("Verify  DATE Text Field on Customer Refund window ", PASS , " DATE Text Field is present on Customer Refund window")
							[+] else
								[ ] ReportStatus("Verify  DATE Text Field on Customer Refund window", FAIL , " DATE Text Field is not present on Customer Refund window")
						[ ] 
						[+] //Verify the Amount TextField present on Customer Refund window
							[+] if(DlgRefund.AmountTextField.Exists(5))
								[ ] ReportStatus("Verify Amount TextField on Customer Refund window ", PASS , " Amount TextField is present on Customer Refund window")
							[+] else
								[ ] ReportStatus("Verify Amount TextField on Customer Refund window", FAIL , " Amount TextField is not present on Customer Refund window")
						[ ] 
						[+] //Verify the Memo TextField present on Customer Refund window
							[+] if(DlgRefund.MemoTextField.Exists(5))
								[ ] ReportStatus("Verify Memo TextField on Customer Refund window ", PASS , "Memo TextField is present on Customer Refund window")
							[+] else
								[ ] ReportStatus("Verify Memo TextField on Customer Refund window", FAIL , "Memo TextField is not present on Customer Refund window")
						[ ] 
						[+] //Verify the Enter Button present on Customer Refund window
							[+] if(DlgRefund.EnterButton.Exists(5))
								[ ] ReportStatus("Verify Enter Button on Customer Refund window ", PASS , "Enter Button is present on Customer Refund window")
							[+] else
								[ ] ReportStatus("Verify Enter Button on Customer Refund window", FAIL , "Enter Button is not present on Customer Refund window")
						[ ] 
						[+] //Verify the Cancel Button present on Customer Refund window
							[+] if(DlgRefund.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel Button on Customer Refund window ", PASS , "Cancel Button is present on Customer Refund window")
							[+] else
								[ ] ReportStatus("Verify Cancel Button on Customer Refund window", FAIL , "Cancel Button is present on Customer Refund window")
					[ ] DlgRefund.SetActive()
					[ ] DlgRefund.Close()
					[+] if(AlertMessage.Exists())
						[ ] AlertMessage.Yes.Click()
						[ ] WaitForState(AlertMessage , FALSE ,3)
				[+] else
					[ ] ReportStatus("Verify Customer Refund window ", FAIL , "Customer Refund window is displayed")
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify UI of Customer Invoice dialog -> Create Finance Charge##################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test33_UIofFinanceCharge() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify UI of Customer Invoice dialog -> Create Finance Charge
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 03 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test33_UIofFinanceCharge()  appstate none
	[+] // Variable Declarations
		[ ] 
		[ ] STRING sDialogName
		[ ] LIST OF STRING lsAccount
		[ ] sRegisterExcel = "BusinessTestData"
		[ ] sAccWorksheet = "Business Accounts"
	[ ] 
	[ ] // Variable Definition
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsAccount=lsExcelData[1]
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify Business > Invoices And Estimates > Issue  a Refund
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateAFinanceCharge.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[ ] 
				[ ] 
				[+] if (DlgCreateFinanceCharge.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Create Finance Charge window ", PASS , "Create Finance Charge window is displayed")
					[ ] 
					[+] //Verifying UI controls  on Create Finance Charge window
						[ ] 
						[+] //Verify the Customer Text Field present on Create Finance Charge window
							[+] if(DlgCreateFinanceCharge.CustomerTextField.Exists(5))
								[ ] ReportStatus("Verify Customer Text Field on Add Create Finance Charge dialog ", PASS , " Customer Text Field is present on Create Finance Charge dialog")
							[+] else
								[ ] ReportStatus("Verify Customer Text Field on Add Create Finance Charge dialog", FAIL , "Customer Text Field is not present on Create Finance Charge dialog")
						[ ] 
						[+] //Verify the  Project Job Text Field present on Create Finance Charge window
							[+] if(DlgCreateFinanceCharge.ProjectJobTextField.Exists(5))
								[ ] ReportStatus("Verify  Project Job Text Field on Create Finance Charge window ", PASS , "  Project Job Text Field is present on Create Finance Charge window")
							[+] else
								[ ] ReportStatus("Verify  Project Job Text Field on Create Finance Charge window", FAIL , " Project Job Text Field is not present on Create Finance Charge window")
						[ ] 
						[+] //Verify the  Category TextField present on Create Finance Charge window
							[+] if(DlgCreateFinanceCharge.CategoryTextField.Exists(5))
								[ ] ReportStatus("Verify  Category TextField on Create Finance Charge window ", PASS , "  Category TextField is present on Create Finance Charge window")
							[+] else
								[ ] ReportStatus("Verify  Category TextField on Create Finance Charge window", FAIL , " Category TextField is not present on Create Finance Charge window")
						[ ] 
						[+] //Verify the DATE TextField present on Create Finance Charge window
							[+] if(DlgCreateFinanceCharge.DateTextField.Exists(5))
								[ ] ReportStatus("Verify  DATE Text Field on Create Finance Charge window ", PASS , " DATE Text Field is present on Create Finance Charge window")
							[+] else
								[ ] ReportStatus("Verify  DATE Text Field on Create Finance Charge window", FAIL , " DATE Text Field is not present on Create Finance Charge window")
						[ ] 
						[+] //Verify the DUEDATE TextField present on Create Finance Charge window
							[+] if(DlgCreateFinanceCharge.DueDateTextField.Exists(5))
								[ ] ReportStatus("Verify  DUEDATE Text Field on Create Finance Charge window ", PASS , " DUEDATE Text Field is present on Create Finance Charge window")
							[+] else
								[ ] ReportStatus("Verify  DUEDATE Text Field on Create Finance Charge window", FAIL , " DUEDATE Text Field is not present on Create Finance Charge window")
						[ ] 
						[+] //Verify the Finance Charge TextField present on Create Finance Charge window
							[+] if(DlgCreateFinanceCharge.FinanceChargeTextField.Exists(5))
								[ ] ReportStatus("Verify Finance Charge TextField on Create Finance Charge window ", PASS , " Finance Charge TextField is present on Create Finance Charge window")
							[+] else
								[ ] ReportStatus("Verify Finance Charge TextField on Create Finance Charge window", FAIL , " Finance Charge TextField is not present on Create Finance Charge window")
						[ ] 
						[+] //Verify the Memo TextField present on Create Finance Charge window
							[+] if(DlgCreateFinanceCharge.MemoTextField.Exists(5))
								[ ] ReportStatus("Verify Memo TextField on Create Finance Charge window ", PASS , "Memo TextField is present on Create Finance Charge window")
							[+] else
								[ ] ReportStatus("Verify Memo TextField on Create Finance Charge window", FAIL , "Memo TextField is not present on Create Finance Charge window")
						[ ] 
						[+] //Verify the OK Button present on Create Finance Charge window
							[+] if(DlgCreateFinanceCharge.OKButton.Exists(5))
								[ ] ReportStatus("Verify OK Button on Create Finance Charge window ", PASS , "OK Button is present on Create Finance Charge window")
							[+] else
								[ ] ReportStatus("Verify OK Button on Create Finance Charge window", FAIL , "OK Button is not present on Create Finance Charge window")
						[ ] 
						[+] //Verify the Cancel Button present on Create Finance Charge window
							[+] if(DlgCreateFinanceCharge.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel Button on Create Finance Charge window ", PASS , "Cancel Button is present on Create Finance Charge window")
							[+] else
								[ ] ReportStatus("Verify Cancel Button on Create Finance Charge window", FAIL , "Cancel Button is present on Create Finance Charge window")
						[ ] DlgCreateFinanceCharge.CancelButton.Click()
						[+] if(AlertMessage.Exists(2))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.Yes.Click()
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Create Finance Charge window ", FAIL , "Create Finance Charge window is displayed")
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify UI of Customer Invoice dialog ->  Create Estimates######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test34_UIofEstimates() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify UI of Customer Invoice dialog ->  Create Estimates
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 03 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test34_UIofEstimates()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sDialogName
	[ ] LIST OF STRING lsAccount,lsCompare,lsLayout,lsTaxAccount
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] 
	[ ] // Variable Definition
	[ ] lsLayout ={"Estimate Default", "<Customize>"}
	[ ] lsTaxAccount ={"*Sales Tax*","Tax 01","<New>","<Edit>"}
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] // lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsAccount=lsExcelData[1]
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify Business > Invoices And Estimates > Create Estimates
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.CreateEstimate.Select()
			[+] if (EstimateList.DlgEstimate.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Create Estimates window ", PASS , "Create Estimates window is displayed")
				[ ] 
				[+] //Verifying UI controls for the Add Customer Invoice Details on Create Estimates window
					[ ] 
					[+] //Verify the Customer Text Field present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.CustomerTextField.Exists(5))
							[ ] ReportStatus("Verify Customer Text Field on Create Estimates window ", PASS , " Customer Text Field is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify Customer Text Field on Create Estimates window", FAIL , "Customer Text Field is not present on Create Estimates window")
					[ ] 
					[+] //Verify the  Project Job Text Field present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.ProjectJobTextField.Exists(5))
							[ ] ReportStatus("Verify  Project Job Text Field on Create Estimates window ", PASS , "  Project Job Text Field is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify  Project Job Text Field on Create Estimates window", FAIL , " Project Job Text Field is not present on Create Estimates window")
					[ ] 
					[+] //Verify the  Project Layout Popup List present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.LayoutPopupList.Exists(5))
							[ ] ReportStatus("Verify  Layout Popup List on Create Estimates window ", PASS , "  Layout Popup List is present on Create Estimates window")
							[ ] 
							[ ] lsCompare=EstimateList.DlgEstimate.LayoutPopupList.GetContents()
							[ ] 
							[+] for(i=1;i<=ListCount(lsCompare);i++)
								[+] if(lsLayout[i]==lsCompare[i])
									[ ] ReportStatus("Verify the Contents of How often List",PASS,"As {lsLayout[i]} is present in Layout Popup List")
								[+] else
									[ ] ReportStatus("Verify the Contents of How often List",FAIL,"As {lsLayout[i]}, {lsCompare[i]} is not present in Layout Popup List")
						[+] else
							[ ] ReportStatus("Verify  Layout Popup List on Create Estimates window", FAIL , " Layout Popup List is not present on Create Estimates window")
					[ ] 
					[+] //Verify the  Business Tag TextField present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.BusinessTagTextField.Exists(5))
							[ ] ReportStatus("Verify  Business Tag TextField on Create Estimates window ", PASS , "  Business Tag TextField is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify  Business Tag TextField on Create Estimates window", FAIL , " Business Tag TextField is not present on Create Estimates window")
					[ ] 
					[+] //Verify the DATE TextField present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.xDATE1TextField.Exists(5))
							[ ] ReportStatus("Verify  DATE Text Field on Create Estimates window ", PASS , " DATE Text Field is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify  DATE Text Field on Create Estimates window", FAIL , " DATE Text Field is not present on Create Estimates window")
					[ ] 
					[+] //Verify the ESTIMATE TextField present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.ESTIMATETextField.Exists(5))
							[ ] ReportStatus("Verify ESTIMATE TextField on Create Estimates window ", PASS , " ESTIMATE TextField is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify ESTIMATE TextField on Create Estimates window", FAIL , " ESTIMATE TextField is not present on Create Estimates window")
					[ ] 
					[+] //Verify the Item List present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.QWListViewerItem.Exists(5))
							[ ] ReportStatus("Verify Item List on Create Estimates window ", PASS , "Item List is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify Item List on Create Estimates window", FAIL , "Item List is not present on Create Estimates window")
					[ ] 
					[+] //Verify the Add Lines Button present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.AddLinesButton.Exists(5))
							[ ] ReportStatus("Verify Add Lines Button on Create Estimates window ", PASS , "Add Lines Button is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify Add Lines Button on Create Estimates window", FAIL , "Add Lines Button is not present on Create Estimates window")
					[ ] 
					[+] //Verify the Tax TextField present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.TaxTextField.Exists(5))
							[ ] ReportStatus("Verify Tax TextField on Create Estimates window ", PASS , "Tax TextField is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify Tax TextField on Create Estimates window", FAIL , "Tax TextField is not present on Create Estimates window")
					[ ] 
					[+] //Verify the Customer Message TextField present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.CustomerMessageTextField.Exists(5))
							[ ] ReportStatus("Verify Customer Message TextField  on Create Estimates window ", PASS , "Customer Message TextField  is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify Customer Message TextField  on Create Estimates window", FAIL , "Customer Message TextField  is not present on Create Estimates window")
					[ ] 
					[+] //Verify the Memo TextField present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.MemoTextField.Exists(5))
							[ ] ReportStatus("Verify Memo TextField on Create Estimates window ", PASS , "Memo TextField is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify Memo TextField on Create Estimates window", FAIL , "Memo TextField is not present on Create Estimates window")
					[ ] 
					[+] //Verify the Tax Account PopupList present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.TaxAccountPopupList.Exists(5))
							[ ] ReportStatus("Verify Tax Account PopupList on Create Estimates window ", PASS , "Tax Account PopupList is present on Create Estimates window")
							[ ] 
							[ ] lsCompare=EstimateList.DlgEstimate.TaxAccountPopupList.GetContents()
							[ ] 
							[+] for(i=1;i<=ListCount(lsCompare);i++)
								[+] if(lsTaxAccount[i]==lsCompare[i])
									[ ] ReportStatus("Verify the Contents of How often List",PASS,"As {lsTaxAccount[i]} is present in Layout Popup List")
								[+] else
									[ ] ReportStatus("Verify the Contents of How often List",FAIL,"As {lsTaxAccount[i]}, {lsCompare[i]} is not present in Layout Popup List")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Tax Account PopupList on Create Estimates window", FAIL , "Tax Account PopupList is not present on Create Estimates window")
					[ ] 
					[+] //Verify the Help Button present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.HelpButton.Exists(5))
							[ ] ReportStatus("Verify Help Button on Create Estimates window ", PASS , "Help Button is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify Help Button on Create Estimates window", FAIL , "Help Button is not present on Create Estimates window")
					[ ] 
					[+] //Verify the EMail Send To Clipboard Button present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.EMailSendToClipboardButton.Exists(5))
							[ ] ReportStatus("Verify EMail Send To Clipboard Button on Create Estimates window ", PASS , "EMail Send To Clipboard Button is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify EMail Send To Clipboard Button on Create Estimates window", FAIL , "EMail Send To Clipboard Button is not present on Create Estimates window")
					[ ] 
					[+] //Verify the Save And New Button present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.SaveAndNewButton.Exists(5))
							[ ] ReportStatus("Verify Save And New Button on Create Estimates window ", PASS , "Save And New Button is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify Save And New Button on Create Estimates window", FAIL , "Save And New Button is not present on Create Estimates window")
					[ ] 
					[+] //Verify the Save And Done Button present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.SaveAndDoneButton.Exists(5))
							[ ] ReportStatus("Verify Save And Done Button on Create Estimates window ", PASS , "Save And Done Button is present on Create Estimates window")
						[+] else
							[ ] ReportStatus("Verify Save And Done Button on Create Estimates window", FAIL , "Save And Done Button is not present on Create Estimates window")
					[ ] 
					[+] //Verify the Cancel Button present on Create Estimates window
						[+] if(EstimateList.DlgEstimate.CancelButton.Exists(5))
							[ ] ReportStatus("Verify Cancel Button on Create Estimates window ", PASS , "Cancel Button is present on Create Estimates window")
							[ ] EstimateList.DlgEstimate.CancelButton.Click()
							[+] if(AlertMessage.Exists(2))
								[ ] AlertMessage.SetActive()
								[ ] AlertMessage.Yes.Click()
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Cancel Button on Create Estimates window", FAIL , "Cancel Button is present on Create Estimates window")
					[+] if(EstimateList.DlgEstimate.Exists(5))
						[ ] 
						[ ] EstimateList.DlgEstimate.SetActive()
						[ ] EstimateList.DlgEstimate.Close()
						[+] if(AlertMessage.Exists(2))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.Yes.Click()
							[ ] WaitForState(AlertMessage ,FALSE , 3)
						[ ] EstimateList.SetActive()
						[ ] EstimateList.Close()
						[ ] WaitForState(EstimateList ,FALSE , 3)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Create Estimates window ", FAIL , "Create Estimates window is displayed")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify UI of Vendor Invoice dialog ->  Create Bills############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test35_UIofVendorInvoiceBill() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify UI of Vendor Invoice dialog -> Create Bill 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 04 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test35_UIofVendorInvoiceBill()   appstate none
	[+] // Variable Declarations
		[ ] 
		[ ] STRING sDialogName
		[ ] LIST OF STRING lsAccount,lsCompare,lsLayout,lsTaxAccount
		[ ] sRegisterExcel = "BusinessTestData"
		[ ] sAccWorksheet = "Business Accounts"
	[ ] 
	[ ] // Variable Definition
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsAccount=lsExcelData[2]
	[+] 
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify Business > Bills and Vendors  > Create Bills
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.CreateBill.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[ ] 
				[ ] WaitForState(DlgBillVendorInvoices,TRUE,2)
				[ ] 
				[+] if (DlgBillVendorInvoices.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Create Vendor Invoice window ", PASS , "Create Vendor Invoice window is displayed")
					[ ] 
					[+] //Verifying UI controls  on Create Vendor Invoice window
						[ ] 
						[+] //Verify the Customer Text Field present on Create Vendor Invoice window
							[+] if(DlgBillVendorInvoices.CustomerTextField.Exists(5))
								[ ] ReportStatus("Verify Customer Text Field on Create Vendor Invoice window ", PASS , " Customer Text Field is present on Create Vendor Invoice window")
							[+] else
								[ ] ReportStatus("Verify Customer Text Field on Create Vendor Invoice window", FAIL , "Customer Text Field is not present on Create Vendor Invoice window")
						[ ] 
						[+] //Verify the  Project Job Text Field present on Create Vendor Invoice window
							[+] if(DlgBillVendorInvoices.ProjectJobTextField.Exists(5))
								[ ] ReportStatus("Verify  Project Job Text Field on Create Vendor Invoice window ", PASS , "  Project Job Text Field is present on Create Vendor Invoice window")
							[+] else
								[ ] ReportStatus("Verify  Project Job Text Field on Create Vendor Invoice window", FAIL , " Project Job Text Field is not present on Create Vendor Invoice window")
						[ ] 
						[+] //Verify the  Vendor TextField present on Create Vendor Invoice window
							[+] if(DlgBillVendorInvoices.VendorTextField.Exists(5))
								[ ] ReportStatus("Verify  Vendor TextField on Create Vendor Invoice window ", PASS , " Vendor TextField is present on Create Vendor Invoice window")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Vendor TextField on Create Vendor Invoice window", FAIL , " Vendor TextField is not present on Create Vendor Invoice window")
						[ ] 
						[+] //Verify the  Business Tag TextField present on Create Vendor Invoice window
							[+] if(DlgBillVendorInvoices.BusinessTagTextField.Exists(5))
								[ ] ReportStatus("Verify  Business Tag TextField on Create Vendor Invoice window ", PASS , "  Business Tag TextField is present on Create Vendor Invoice window")
							[+] else
								[ ] ReportStatus("Verify  Business Tag TextField on Create Vendor Invoice window", FAIL , " Business Tag TextField is not present on Create Vendor Invoice window")
						[ ] 
						[+] //Verify the DATE TextField present on Create Vendor Invoice window
							[+] if(DlgBillVendorInvoices.xDATE1TextField.Exists(5))
								[ ] ReportStatus("Verify  DATE Text Field on Create Vendor Invoice window ", PASS , " DATE Text Field is present on Create Vendor Invoice window")
							[+] else
								[ ] ReportStatus("Verify  DATE Text Field on Create Vendor Invoice window", FAIL , " DATE Text Field is not present on Create Vendor Invoice window")
						[ ] 
						[+] //Verify the DUEDATE TextField present on Create Vendor Invoice window
							[+] if(DlgBillVendorInvoices.DUEDATE1TextField.Exists(5))
								[ ] ReportStatus("Verify  DUEDATE Text Field on Create Vendor Invoice window ", PASS , " DUEDATE Text Field is present on Create Vendor Invoice window")
							[+] else
								[ ] ReportStatus("Verify  DUEDATE Text Field on Create Vendor Invoice window", FAIL , " DUEDATE Text Field is not present on Create Vendor Invoice window")
						[ ] 
						[+] //Verify the PONUMBER TextField present on Create Vendor Invoice window
							[+] if(DlgBillVendorInvoices.PONUMBERTextField.Exists(5))
								[ ] ReportStatus("Verify PONUMBER TextField on Create Vendor Invoice window ", PASS , " PONUMBER TextField is present on Create Vendor Invoice window")
							[+] else
								[ ] ReportStatus("Verify PONUMBER TextField on Create Vendor Invoice window", FAIL , " PONUMBER TextField is not present on Create Vendor Invoice window")
						[ ] 
						[+] //Verify the Item List present on Create Vendor Invoice window
							[+] if(DlgBillVendorInvoices.QWListViewerItem.Exists(5))
								[ ] ReportStatus("Verify Item List on Create Vendor Invoice window ", PASS , "Item List is present on Create Vendor Invoice window")
							[+] else
								[ ] ReportStatus("Verify Item List on Create Vendor Invoice window", FAIL , "Item List is not present on Create Vendor Invoice window")
						[ ] 
						[+] //Verify the Add Lines Button present on Create Vendor Invoice window
							[+] if(DlgBillVendorInvoices.AddLinesButton.Exists(5))
								[ ] ReportStatus("Verify Add Lines Button on Create Vendor Invoice window ", PASS , "Add Lines Button is present on Create Vendor Invoice window")
							[+] else
								[ ] ReportStatus("Verify Add Lines Button on Create Vendor Invoice window", FAIL , "Add Lines Button is not present on Create Vendor Invoice window")
						[ ] 
						[+] //Verify the Memo TextField present on Create Vendor Invoice window
							[+] if(DlgBillVendorInvoices.MemoTextField.Exists(5))
								[ ] ReportStatus("Verify Memo TextField on Create Vendor Invoice window ", PASS , "Memo TextField is present on Create Vendor Invoice window")
							[+] else
								[ ] ReportStatus("Verify Memo TextField on Create Vendor Invoice window", FAIL , "Memo TextField is not present on Create Vendor Invoice window")
						[ ] 
						[+] //Verify the Save And New Button present on Create Vendor Invoice window
							[+] if(DlgBillVendorInvoices.SaveAndNewButton.Exists(5))
								[ ] ReportStatus("Verify Save And New Button on Create Vendor Invoice window ", PASS , "Save And New Button is present on Create Vendor Invoice window")
							[+] else
								[ ] ReportStatus("Verify Save And New Button on Create Vendor Invoice window", FAIL , "Save And New Button is not present on Create Vendor Invoice window")
						[ ] 
						[+] //Verify the Save And Done Button present on Create Vendor Invoice window
							[+] if(DlgBillVendorInvoices.SaveAndDoneButton.Exists(5))
								[ ] ReportStatus("Verify Save And Done Button on Create Vendor Invoice window ", PASS , "Save And Done Button is present on Create Vendor Invoice window")
							[+] else
								[ ] ReportStatus("Verify Save And Done Button on Create Vendor Invoice window", FAIL , "Save And Done Button is not present on Create Vendor Invoice window")
						[ ] 
						[+] //Verify the Cancel Button present on Create Vendor Invoice window
							[+] if(DlgBillVendorInvoices.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel Button on Create Vendor Invoice window ", PASS , "Cancel Button is present on Create Vendor Invoice window")
							[+] else
								[ ] ReportStatus("Verify Cancel Button on Create Vendor Invoice window", FAIL , "Cancel Button is present on Create Vendor Invoice window")
						[ ] 
					[ ] DlgBillVendorInvoices.Close()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Create Vendor Invoice window ", FAIL , "Create Vendor Invoice window is displayed")
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify UI of Vendor Invoice dialog -> Make Payment to Vendor###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test36_UIofVendorInvoicePayment() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify UI of Vendor Invoice dialog -> Make Payment to Vendor
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 04 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test36_UIofVendorInvoicePayment()   appstate none
	[+] // Variable Declarations
		[ ] 
		[ ] STRING sDialogName
		[ ] LIST OF STRING lsAccount,lsCompare,lsLayout,lsTaxAccount
		[ ] sRegisterExcel = "BusinessTestData"
		[ ] sAccWorksheet = "Business Accounts"
	[ ] 
	[ ] // Variable Definition
	[ ] lsLayout ={"Invoice Default", "<Customize>"}
	[ ] lsTaxAccount ={"*Sales Tax*","<New>","<Edit>"}
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] // lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsAccount=lsExcelData[2]
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify Business > Bills and Vendors > Make a Payment to Vendor
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.MakePaymentToVendor.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[ ] 
				[ ] WaitForState(DlgPaymentVendorInvoices,TRUE,2)
				[+] if (DlgPaymentVendorInvoices.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Vendor Payment window ", PASS , "Vendor Payment window is displayed")
					[ ] 
					[+] //Verifying UI controls for the Add Vendor Payment Details on Vendor Payment window
						[ ] 
						[+] //Verify the Vendor Text Field present on Vendor Payment window
							[+] if(DlgPaymentVendorInvoices.VendorTextField.Exists(5))
								[ ] ReportStatus("Verify Customer Text Field on Vendor Payment window ", PASS , " Customer Text Field is present on Vendor Payment window")
							[+] else
								[ ] ReportStatus("Verify Customer Text Field on Add Customer Payment Details dialog", FAIL , "Customer Text Field is not present on Add Customer Payment Details dialog")
						[ ] 
						[+] //Verify the  WithdrawFrom PopupList present on Vendor Payment window
							[+] if(DlgPaymentVendorInvoices.WithdrawFromPopupList.Exists(5))
								[ ] ReportStatus("Verify  WithdrawFrom Popup List on Customer Invoice window ", PASS , "  WithdrawFrom Popup List is present on Customer Invoice window")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify  WithdrawFrom Popup List on Customer Invoice window", FAIL , " WithdrawFrom Popup List is not present on Customer Invoice window")
						[ ] 
						[+] //Verify the DATE TextField present on Vendor Payment window
							[+] if(DlgPaymentVendorInvoices.xDATE1TextField.Exists(5))
								[ ] ReportStatus("Verify  DATE Text Field on Vendor Payment window ", PASS , " DATE Text Field is present on Vendor Payment window")
							[+] else
								[ ] ReportStatus("Verify  DATE Text Field on Vendor Payment window", FAIL , " DATE Text Field is not present on Vendor Payment window")
						[ ] 
						[+] //Verify the CHECKNUMBER TextField present on Vendor Payment window
							[+] if(DlgPaymentVendorInvoices.CheckNumberTextField.Exists(5))
								[ ] ReportStatus("Verify CHECKNUMBER TextField on Vendor Payment window", PASS , "CHECKNUMBER TextField is present on Vendor Payment window")
							[+] else
								[ ] ReportStatus("Verify CHECKNUMBER TextField on Vendor Payment window", FAIL , "CHECKNUMBER TextField is not present on Vendor Payment window")
						[ ] 
						[+] //Verify the Enter Button present on Vendor Payment window
							[+] if(DlgPaymentVendorInvoices.EnterButton.Exists(5))
								[ ] ReportStatus("Verify Enter Button present on Vendor Payment window ", PASS , "Enter Button present on Vendor Payment window")
							[+] else
								[ ] ReportStatus("Verify Enter Button present on Vendor Payment window", FAIL , "Enter Button present on Vendor Payment window")
						[ ] 
						[+] //Verify the Memo TextField present on Vendor Payment window
							[+] if(DlgPaymentVendorInvoices.MemoTextField.Exists(5))
								[ ] ReportStatus("Verify Memo TextField on Vendor Payment window", PASS , "Memo TextField is present on Vendor Payment window")
							[+] else
								[ ] ReportStatus("Verify Memo TextField on Vendor Payment window", FAIL , "Memo TextField is not present on Vendor Payment window")
						[ ] 
						[+] //Verify the ClearPayments Button present on Vendor Payment window
							[+] if(DlgPaymentVendorInvoices.ClearPaymentsButton.Exists(5))
								[ ] ReportStatus("Verify Clear Payments Button on Vendor Payment window ", PASS , "Clear Payments Button is present on Vendor Payment window")
							[+] else
								[ ] ReportStatus("Verify Clear Payments Button on Vendor Payment window", FAIL , "Clear Payments Button is not present on Vendor Payment window")
						[ ] 
						[+] //Verify the Cancel Button present on Vendor Payment window
							[+] if(DlgPaymentVendorInvoices.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel Button on Vendor Payment window ", PASS , "Cancel Button is present on Vendor Payment window")
							[+] else
								[ ] ReportStatus("Verify Cancel Button on Vendor Payment window", FAIL , "Cancel Button is not present on Vendor Payment window")
					[ ] 
					[ ] DlgPaymentVendorInvoices.Close()
				[+] else
					[ ] ReportStatus("Verify Vendor Payment window ", FAIL , "Vendor Payment window is displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify UI of Vendor Invoice dialog -> Receive a Credit########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test37_UIofReceiveACredit() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify UI of Customer Invoice dialog -> Issue  a Credit 
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 04 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test37_UIofReceiveACredit()  appstate none
	[+] // Variable Declarations
		[ ] 
		[ ] STRING sDialogName,sActualName
		[ ] LIST OF STRING lsAccount,lsLayout,lsTaxAccount,lsCompare
		[ ] sRegisterExcel = "BusinessTestData"
		[ ] sAccWorksheet = "Business Accounts"
	[ ] 
	[ ] // Variable Definition
	[ ] sActualName = "Forms Designer : Estimate Default"
	[ ] lsLayout ={"Invoice Default", "<Customize>"}
	[ ] lsTaxAccount ={"*Sales Tax*","<New>","<Edit>"}
	[ ] 
	[ ] 
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] // lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsAccount=lsExcelData[1]
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify Business > Invoices And Estimates > Issue  a Credit
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.Click()
			[ ] QuickenWindow.Business.InvoicesAndEstimates.IssueACredit.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[ ] 
				[ ] WaitForState(DlgCreditVendorInvoices,TRUE,2)
				[ ] 
				[+] if (DlgCreditVendorInvoices.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Vendor Credit window ", PASS , "Vendor Credit window is displayed")
					[ ] 
					[+] //Verifying UI controls  on Vendor Credit window
						[ ] 
						[+] //Verify the Vendor Text Field present on Vendor Credit window
							[+] if(DlgCreditVendorInvoices.Vendor1TextField.Exists(5))
								[ ] ReportStatus("Verify Vendor Text Field on Add Vendor Credit dialog ", PASS , " Vendor Text Field is present on Vendor Credit dialog")
							[+] else
								[ ] ReportStatus("Verify Vendor Text Field on Add Vendor Credit dialog", FAIL , "Vendor Text Field is not present on Vendor Credit dialog")
						[ ] 
						[+] //Verify the DATE TextField present on Vendor Credit window
							[+] if(DlgCreditVendorInvoices.xDATE1TextField.Exists(5))
								[ ] ReportStatus("Verify  DATE Text Field on Vendor Credit window ", PASS , " DATE Text Field is present on Vendor Credit window")
							[+] else
								[ ] ReportStatus("Verify  DATE Text Field on Vendor Credit window", FAIL , " DATE Text Field is not present on Vendor Credit window")
						[ ] 
						[+] //Verify the PONUMBER TextField present on Vendor Credit window
							[+] if(DlgCreditVendorInvoices.PONUMBERTextField.Exists(5))
								[ ] ReportStatus("Verify PONUMBER TextField on Vendor Credit window ", PASS , "PONUMBER TextField is present on Vendor Credit window")
							[+] else
								[ ] ReportStatus("Verify PONUMBER TextField on Vendor Credit window", FAIL , "PONUMBER TextField is not present on Vendor Credit window")
						[ ] 
						[+] //Verify the Item List present on Vendor Credit window
							[+] if(DlgCreditVendorInvoices.QWListViewerItem.Exists(5))
								[ ] ReportStatus("Verify Item List on Vendor Credit window ", PASS , "Item List is present on Vendor Credit window")
							[+] else
								[ ] ReportStatus("Verify Item List on Vendor Credit window", FAIL , "Item List is not present on Vendor Credit window")
						[ ] 
						[+] //Verify the Add Lines Button present on Vendor Credit window
							[+] if(DlgCreditVendorInvoices.AddLinesButton.Exists(5))
								[ ] ReportStatus("Verify Add Lines Button on Vendor Credit window ", PASS , "Add Lines Button is present on Vendor Credit window")
							[+] else
								[ ] ReportStatus("Verify Add Lines Button on Vendor Credit window", FAIL , "Add Lines Button is not present on Vendor Credit window")
						[ ] 
						[+] //Verify the Memo TextField present on Vendor Credit window
							[+] if(DlgCreditVendorInvoices.Memo1TextField.Exists(5))
								[ ] ReportStatus("Verify Memo TextField on Vendor Credit window ", PASS , "Memo TextField is present on Vendor Credit window")
							[+] else
								[ ] ReportStatus("Verify Memo TextField on Vendor Credit window", FAIL , "Memo TextField is not present on Vendor Credit window")
						[ ] 
						[+] //Verify the Create Payment Button present on Vendor Credit window
							[+] if(DlgCreditVendorInvoices.CreatePaymentButton.Exists(5))
								[ ] ReportStatus("Verify Create Payment Button on Vendor Credit window ", PASS , "Create Payment Button is present on Vendor Credit window")
							[+] else
								[ ] ReportStatus("Verify Create Payment Button on Vendor Credit window", FAIL , "Create Payment Button is not present on Vendor Credit window")
						[ ] 
						[+] //Verify the Payment History Button present on Vendor Credit window
							[+] if(DlgCreditInvoices.PaymentHistoryButton.Exists(5))
								[ ] ReportStatus("Verify Payment History Button on Vendor Credit window ", PASS , "Payment History Button is present on Vendor Credit window")
							[+] else
								[ ] ReportStatus("Verify Payment History Button on Vendor Credit window", FAIL , "Payment History Button is not present on Vendor Credit window")
						[ ] 
						[+] //Verify the Refund Button present on Vendor Credit window
							[+] if(DlgCreditInvoices.RefundButton.Exists(5))
								[ ] ReportStatus("Verify Refund Buttonon Vendor Credit window ", PASS , "Refund Button is present on Vendor Credit window")
							[+] else
								[ ] ReportStatus("Verify Refund Button on Vendor Credit window", FAIL , "Refund Button is not present on Vendor Credit window")
						[ ] 
						[+] //Verify the Enter Button present on Vendor Credit window
							[+] if(DlgCreditInvoices.EnterButton.Exists(5))
								[ ] ReportStatus("Verify Enter Button on Vendor Credit window ", PASS , "Enter Button is present on Vendor Credit window")
							[+] else
								[ ] ReportStatus("Verify Enter Button on Vendor Credit window", FAIL , "Enter Button is not present on Vendor Credit window")
						[ ] 
						[+] //Verify the Cancel Button present on Vendor Credit window
							[+] if(DlgCreditInvoices.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel Button on Vendor Credit window ", PASS , "Cancel Button is present on Vendor Credit window")
							[+] else
								[ ] ReportStatus("Verify Cancel Button on Vendor Credit window", FAIL , "Cancel Button is present on Vendor Credit window")
					[ ] 
					[ ] DlgCreditVendorInvoices.Close()
				[+] else
					[ ] ReportStatus("Verify Vendor Credit window ", FAIL , "Vendor Credit window is displayed")
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#############Verify UI of Vendor Invoice dialog -> Receive  a Refund########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test38_UIofReceiveARefund() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify UI of Customer Invoice dialog -> Receive  a Refund
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 04 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test38_UIofReceiveARefund()   appstate none
	[+] // Variable Declarations
		[ ] 
		[ ] STRING sDialogName
		[ ] sRegisterExcel = "BusinessTestData"
		[ ] sAccWorksheet = "Business Accounts"
	[ ] 
	[ ] 
	[ ] // Variable Definition
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] // lsTransactionData = ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsAccount=lsExcelData[2]
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify Business > Bills and Vendors > Receive  a Refund
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.ReceiveARefund.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select(lsAccount[2])
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
				[ ] 
				[ ] WaitForState(DlgRefundVendorInvoices,TRUE,2)
				[ ] 
				[+] if (DlgRefundVendorInvoices.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Vendor Refund window ", PASS , "Vendor Refund window is displayed")
					[ ] 
					[+] //Verifying UI controls  on Vendor Refund window
						[ ] 
						[+] //Verify the Vendor Text Field present on Vendor Refund window
							[+] if(DlgRefundVendorInvoices.VendorTextField.Exists(5))
								[ ] ReportStatus("Verify Vendor Text Field on Vendor Refund window ", PASS , " Vendor Text Field is present on Vendor Refund window")
							[+] else
								[ ] ReportStatus("Verify Vendor Text Field on Vendor Refund window", FAIL , "Vendor Text Field is not present on Vendor Refund window")
						[ ] 
						[+] //Verify the Customer Text Field present on Vendor Refund window
							[+] if(DlgRefundVendorInvoices.CustomerTextField.Exists(5))
								[ ] ReportStatus("Verify Customer Text Field on Vendor Refund window ", PASS , " Customer Text Field is present on Vendor Refund window")
							[+] else
								[ ] ReportStatus("Verify Customer Text Field on Vendor Refund window", FAIL , "Customer Text Field is not present on Vendor Refund window")
						[ ] 
						[+] //Verify the  Project Job Text Field present on Vendor Refund window
							[+] if(DlgRefundVendorInvoices.ProjectJobTextField.Exists(5))
								[ ] ReportStatus("Verify  Project Job Text Field on Vendor Refund window ", PASS , "  Project Job Text Field is present on Vendor Refund window")
							[+] else
								[ ] ReportStatus("Verify  Project Job Text Field on Vendor Refund window", FAIL , " Project Job Text Field is not present on Vendor Refund window")
						[ ] 
						[+] //Verify the  AccountToDepositTo PopupList present on Vendor Refund window
							[+] if(DlgRefundVendorInvoices.AccountToDepositTo.Exists(5))
								[ ] ReportStatus("Verify AccountToDepositTo on Vendor Refund window ", PASS , "  AccountToDepositTo PopupList is present on Vendor Refund window")
							[+] else
								[ ] ReportStatus("Verify  AccountToDepositTo PopupList on Vendor Refund window", FAIL , " AccountToDepositTo PopupList is not present on Vendor Refund window")
						[ ] 
						[+] //Verify the DATE TextField present on Vendor Refund window
							[+] if(DlgRefundVendorInvoices.xDateTextField.Exists(5))
								[ ] ReportStatus("Verify  DATE Text Field on Vendor Refund window ", PASS , " DATE Text Field is present on Vendor Refund window")
							[+] else
								[ ] ReportStatus("Verify  DATE Text Field on Vendor Refund window", FAIL , " DATE Text Field is not present on Vendor Refund window")
						[ ] 
						[+] //Verify the Amount TextField present on Vendor Refund window
							[+] if(DlgRefundVendorInvoices.AmountTextField.Exists(5))
								[ ] ReportStatus("Verify Amount TextField on Vendor Refund window ", PASS , " Amount TextField is present on Vendor Refund window")
							[+] else
								[ ] ReportStatus("Verify Amount TextField on Vendor Refund window", FAIL , " Amount TextField is not present on Vendor Refund window")
						[ ] 
						[+] //Verify the Memo TextField present on Vendor Refund window
							[+] if(DlgRefundVendorInvoices.Memo1TextField.Exists(5))
								[ ] ReportStatus("Verify Memo TextField on Vendor Refund window ", PASS , "Memo TextField is present on Vendor Refund window")
							[+] else
								[ ] ReportStatus("Verify Memo TextField on Vendor Refund window", FAIL , "Memo TextField is not present on Vendor Refund window")
						[ ] 
						[+] //Verify the Enter Button present on Vendor Refund window
							[+] if(DlgRefundVendorInvoices.EnterButton.Exists(5))
								[ ] ReportStatus("Verify Enter Button on Vendor Refund window ", PASS , "Enter Button is present on Vendor Refund window")
							[+] else
								[ ] ReportStatus("Verify Enter Button on Vendor Refund window", FAIL , "Enter Button is not present on Vendor Refund window")
						[ ] 
						[+] //Verify the Cancel Button present on Vendor Refund window
							[+] if(DlgRefundVendorInvoices.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel Button on Vendor Refund window ", PASS , "Cancel Button is present on Vendor Refund window")
							[+] else
								[ ] ReportStatus("Verify Cancel Button on Vendor Refund window", FAIL , "Cancel Button is present on Vendor Refund window")
					[ ] 
					[ ] DlgRefundVendorInvoices.Close()
				[+] else
					[ ] ReportStatus("Verify Vendor Refund window ", FAIL , "Vendor Refund window is displayed")
			[+] else
				[ ] ReportStatus("Verify Choose Invoice Account dialog." ,FAIL ,"Choose Invoice Account dialog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Account is selected from Account Bar", FAIL , "Account is not selected from Account Bar")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
[ ] //########################################################################
[ ] 
[+] //#####Verify displaying of menu items under Business Tools drop down menu.######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test39_MenuItemsUnderBusinessTools() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify displaying of menu items under Business Tools drop down menu.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 06 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test39_MenuItemsUnderBusinessTools()    appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sDialogName
	[ ] LIST OF STRING lsTestData
	[ ] 
	[ ] // Variable Definition
	[ ] 
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] 
	[ ] sAccWorksheet = "Business>BusinessTools"
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Go to Business tab > Business tools
		[ ] NavigateQuickenTab(sTAB_BUSINESS)
		[ ] 
		[+] if(QuickenMainWindow.QWNavigator1.BusinessTools.Exists(5))
			[ ] 
			[+] for(i=1;i<=iCount;i++)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.BusinessTools.Click()
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN, i))
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] //##########Verifying the Menus of Business Tab > Business Tools#####//
				[ ] lsTestData = lsExcelData[i]
				[ ] lsTestData[2]=trim(lsTestData[2])
				[+] if(StrPos("/",lsTestData[2]) > 0)
					[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
					[ ] 
				[+] if(Desktop.Find("//MainWin[@caption='{lsTestData[2]}']").Exists(5))
					[ ] ReportStatus("Validate {lsTestData[2]} window", PASS, "{lsTestData[2]} window is displayed") 
					[ ] 
					[ ] Desktop.Find("//MainWin[@caption='{lsTestData[2]}']").Close()
					[ ] 
				[+] else
					[ ] ReportStatus("Validate {lsTestData[2]} window", FAIL, " Expected - {lsTestData[2]} window title is not available")
					[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Check the Business Tools Button ", FAIL, "Business Tools does not exists")
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
	[ ] 
[ ] //########################################################################
[ ] 
[ ] 
[+] ////############# Verify displaying of menu items under Business Actions drop down menu.###########
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test41_AccountActionsForBusinessAccount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will  Verify displaying of menu items under Business Actions drop down menu.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		        If register account actions verification is successful						
		[ ] //				        Fail			        If register account actions verification is unsuccessful		
		[ ] // 
		[ ] //REVISION HISTORY: 
		[ ] // 04 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test40_AccountActionsForBusinessAccount() appstate none
	[ ] 
	[+] // Variable Declarations
		[ ] STRING sValidationText ,sAccountName
		[ ] LIST OF STRING lsAccountName
		[ ] 
	[ ] 
	[+] //Variable Declaration
		[ ] 
		[ ] sRegisterExcel = "BusinessTestData"
		[ ] sAccWorksheet = "Business Accounts"
		[ ] 
		[ ] sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
		[ ] 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] ListAppend(lsAccountName,lsExcelData[1][2])
		[ ] ListAppend(lsAccountName,lsExcelData[2][2])
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccountName[1],ACCOUNT_BUSINESS)
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {lsAccountName[1]} selected successfully")
			[ ] 
			[+] if(QuickenWindow.Exists(5))
				[ ] QuickenWindow.SetActive()
				[+] if (AccountActionsButton.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Account Actions button", PASS, "Verify Account Actions button: Account Actions button displayed.")
					[ ] 
					[+] //##########Verifying Customer Invoices Account Actions> Edit Account Details#####//
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] sValidationText="Account Details" 
						[+] for (iCounter=1;iCounter<3;++iCounter)
							[ ] QuickenWindow.TypeKeys(KEY_DN)
						[ ] QuickenWindow.TypeKeys(KEY_ENTER)
						[+] if (AccountDetails.Exists(4))
							[ ] AccountDetails.SetActive()
							[ ] sActual=AccountDetails.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Customer Invoices Account Actions> Edit Account Details", PASS, "Verify Customer Invoices Account Actions> Edit Account Details option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Customer Invoices Account Actions> Edit Account Details", FAIL, "Verify Customer Invoices Account Actions> Edit Account Details option: Dialog {sValidationText} didn't display.")
							[ ] AccountDetails.Cancel.Click()
							[ ] WaitForState(AccountDetails,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Account Details", FAIL, "Verify Dialog Account Details:  Account Details dialog didn't appear.")
					[ ] 
					[+] //##########Verifying Customer Invoices Account Actions> New Customer Invoice#####//
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] sValidationText="Invoice - " + lsAccountName[1]
						[+] for (iCounter=1;iCounter<4;++iCounter)
							[ ] QuickenWindow.TypeKeys(KEY_DN)
						[ ] QuickenWindow.TypeKeys(KEY_ENTER)
						[+] if (DlgInvoice.Exists(4))
							[ ] DlgInvoice.SetActive()
							[ ] sActual=DlgInvoice.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Customer Invoices Account Actions> New Customer Invoice", PASS, "Verify Customer Invoices Account Actions> New Customer Invoice option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Customer Invoices Account Actions> New Customer Invoice", FAIL, "Verify Customer Invoices Account Actions>New Customer Invoice option: Dialog {sValidationText} didn't display.")
							[ ] DlgInvoice.CancelButton.Click()
							[+] if (AlertMessage.Exists(5))
								[ ] AlertMessage.SetActive()
								[ ] AlertMessage.Yes.Click()
							[ ] 
							[ ] WaitForState(DlgInvoice,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify New Customer Invoice", FAIL, "Verify Dialog New Customer Invoice: New Customer Invoice dialog didn't appear.")
					[ ] 
					[+] ///##########Verifying Customer Invoices Account Actions> New Customer Payment#####////
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] sValidationText="Payment - "  + lsAccountName[1]
						[+] for (iCounter=1;iCounter<5;++iCounter)
							[ ] QuickenWindow.TypeKeys(KEY_DN)
						[ ] QuickenWindow.TypeKeys(KEY_ENTER)
						[+] if (DlgPaymentInvoices.Exists(4))
							[ ] DlgPaymentInvoices.SetActive()
							[ ] sActual=DlgPaymentInvoices.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Customer Invoices Account Actions> New Customer Payment", PASS, "Verify Customer Invoices Account Actions> New Customer Payment option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Customer Invoices Account Actions> New Customer Payment", FAIL, "Verify Customer Invoices Account Actions>New Customer Payment option: Dialog {sValidationText} didn't display.")
							[ ] DlgPaymentInvoices.CancelButton.Click()
							[+] if (AlertMessage.Exists(5))
								[ ] AlertMessage.SetActive()
								[ ] AlertMessage.Yes.Click()
							[ ] 
							[ ] WaitForState(DlgPaymentInvoices,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify New Customer Payment", FAIL, "Verify Dialog New Customer Payment: New Customer Payment dialog didn't appear.")
					[ ] 
					[+] ///##########Verifying Customer Invoices Account Actions> New Credit#####////
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] sValidationText="Credit - "  + lsAccountName[1]
						[+] for (iCounter=1;iCounter<6;++iCounter)
							[ ] QuickenWindow.TypeKeys(KEY_DN)
						[ ] QuickenWindow.TypeKeys(KEY_ENTER)
						[+] if (DlgCreditInvoices.Exists(4))
							[ ] DlgCreditInvoices.SetActive()
							[ ] sActual=DlgCreditInvoices.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Customer Invoices Account Actions> New Credit", PASS, "Verify Customer Invoices Account Actions> New Credit option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Customer Invoices Account Actions> New Credit", FAIL, "Verify Customer Invoices Account Actions>New Credit option: Dialog {sValidationText} didn't display.")
							[ ] DlgCreditInvoices.CancelButton.Click()
							[+] if (AlertMessage.Exists(5))
								[ ] AlertMessage.SetActive()
								[ ] AlertMessage.Yes.Click()
							[ ] 
							[ ] WaitForState(DlgCreditInvoices,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify New Credit", FAIL, "Verify Dialog New Credit: New Credit dialog didn't appear.")
					[ ] 
					[+] ///##########Verifying Customer Invoices Account Actions> New Refund#####////
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] sValidationText="Refund - "  + lsAccountName[1]
						[+] for (iCounter=1;iCounter<7;++iCounter)
							[ ] QuickenWindow.TypeKeys(KEY_DN)
						[ ] QuickenWindow.TypeKeys(KEY_ENTER)
						[+] if (DlgRefund.Exists(4))
							[ ] DlgRefund.SetActive()
							[ ] sActual=DlgRefund.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Customer Invoices Account Actions> New Refund", PASS, "Verify Customer Invoices Account Actions> New Refund option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Customer Invoices Account Actions> New Refund", FAIL, "Verify Customer Invoices Account Actions>New Refund option: Dialog {sValidationText} didn't display.")
							[ ] DlgRefund.CancelButton.Click()
							[+] if (AlertMessage.Exists(5))
								[ ] AlertMessage.SetActive()
								[ ] AlertMessage.Yes.Click()
							[ ] 
							[ ] WaitForState(DlgRefund,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify New Refund", FAIL, "Verify Dialog New Refund: New Refund dialog didn't appear.")
					[ ] 
					[+] ///##########Verifying Customer Invoices Account Actions> New Finance Charge#####////
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] sValidationText="Create Finance Charge"
						[+] for (iCounter=1;iCounter<8;++iCounter)
							[ ] QuickenWindow.TypeKeys(KEY_DN)
						[ ] QuickenWindow.TypeKeys(KEY_ENTER)
						[+] if (DlgCreateFinanceCharge.Exists(4))
							[ ] DlgCreateFinanceCharge.SetActive()
							[ ] sActual=DlgCreateFinanceCharge.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Customer Invoices Account Actions> New Finance Charge", PASS, "Verify Customer Invoices Account Actions> New Finance Charge option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Customer Invoices Account Actions> New Finance Charge", FAIL, "Verify Customer Invoices Account Actions>New Finance Charge option: Dialog {sValidationText} didn't display.")
							[ ] DlgCreateFinanceCharge.CancelButton.Click()
							[+] if (AlertMessage.Exists(5))
								[ ] AlertMessage.SetActive()
								[ ] AlertMessage.Yes.Click()
							[ ] 
							[ ] WaitForState(DlgCreateFinanceCharge,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Create Finance Charge", FAIL, "Verify Dialog Create Finance Charge: Create Finance Charge dialog didn't appear.")
					[ ] 
					[+] ///##########Verifying Customer Invoices Account Actions> Account Attachments #####////  
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Account Attachments: {lsAccountName[1]}"
						[+] for (iCounter=1;iCounter<10;++iCounter)
							[ ] QuickenWindow.TypeKeys(KEY_DN)
						[ ] QuickenWindow.TypeKeys(KEY_ENTER)
						[+] if (DlgAccountAttachments.Exists(4))
							[ ] DlgAccountAttachments.SetActive()
							[ ] sActual=DlgAccountAttachments.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Account Attachments", PASS, "Verify Customer Invoices Account Actions> Account Attachments option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Account Attachments", FAIL, "Verify Customer Invoices Account Actions> Account Attachments option: Dialog {sValidationText} didn't display.")
							[ ] DlgAccountAttachments.DoneButton.Click()
							[ ] WaitForState(DlgAccountAttachments,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Account Attachments ", FAIL, "Verify Dialog Account Attachments : Account Attachments Dialog didn't appear.")
					[ ] 
					[+] ///##########Verifying Customer Invoices Account Actions> Account Overview #####////  
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Account Overview: {lsAccountName[1]}"
						[+] for (iCounter=1;iCounter<11;++iCounter)
							[ ] QuickenWindow.TypeKeys(KEY_DN)
						[ ] QuickenWindow.TypeKeys(KEY_ENTER)
						[+] if (DlgAccountOverview.Exists(4))
							[ ] DlgAccountOverview.SetActive()
							[ ] sActual=DlgAccountOverview.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Account Overview", PASS, "Verify Customer Invoices Account Actions> Account Overview option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Account Overview", FAIL, "Verify Customer Invoices Account Actions> Account Overview option: Dialog {sValidationText} didn't display.")
							[ ] DlgAccountOverview.TypeKeys(KEY_EXIT)
							[ ] WaitForState(DlgAccountOverview,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Account Overview ", FAIL, "Verify Dialog Account Overview : Account Overview Dialog didn't appear.")
					[ ] 
					[+] // ///##########Verifying Customer Invoices Account Actions> Print Transactions#####////  
						[ ] // 
						[ ] // 
						[ ] // QuickenWindow.SetActive()
						[ ] // QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] // sValidationText=NULL
						[ ] // sActual=NULL
						[ ] // sValidationText="Print Register"
						[+] // for (iCounter=1;iCounter<iAccountSpecificCounterValue;++iCounter)
							[ ] // QuickenWindow.TypeKeys(KEY_DN)
						[ ] // QuickenWindow.TypeKeys(KEY_ENTER)
						[+] // if (PrintRegister.Exists(4))
							[ ] // PrintRegister.SetActive()
							[ ] // sActual=PrintRegister.GetProperty("Caption")
							[+] // if (sActual==sValidationText)
								[ ] // ReportStatus("Verify Print Transactions", PASS, "Verify Customer Invoices Account Actions> Print Transactions option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] // else
								[ ] // ReportStatus("Verify Print Transactions", FAIL, "Verify Customer Invoices Account Actions> Print Transactions option: Dialog {sValidationText} didn't display.")
							[ ] // PrintRegister.CancelButton.Click()
							[ ] // WaitForState(PrintRegister,FALSE,1)
						[+] // else
							[ ] // ReportStatus("Verify Print Register", FAIL, "Verify Dialog Print Register : Print RegisterDialog didn't appear.")
					[ ] 
					[+] ///##########Verifying Customer Invoices Account Actions> Export to excel compatible file #####////  
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Create Excel compatible file"
						[+] for (iCounter=1;iCounter<14;++iCounter)
							[ ] QuickenWindow.TypeKeys(KEY_DN)
						[ ] QuickenWindow.TypeKeys(KEY_ENTER)
						[+] if (DlgCreateExcelCompatibleFile.Exists(4))
							[ ] DlgCreateExcelCompatibleFile.SetActive()
							[ ] sActual=DlgCreateExcelCompatibleFile.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Export to excel compatible file", PASS, "Verify Customer Invoices Account Actions> Export to excel compatible file option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Export to excel compatible file", FAIL, "Verify Customer Invoices Account Actions>Export to excel compatible file option: Dialog {sValidationText} didn't display.")
							[ ] DlgCreateExcelCompatibleFile.CancelButton.Click()
							[ ] WaitForState(DlgCreateExcelCompatibleFile,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify CreateExcelCompatibleFile", FAIL, "Verify Dialog CreateExcelCompatibleFile : CreateExcelCompatibleFile Dialog didn't appear.")
					[ ] 
					[+] ///##########Verifying Customer Invoices Account Actions> Invoice defaults#####////
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] sValidationText="Set Invoice Defaults"
						[+] for (iCounter=1;iCounter<=18;++iCounter)
							[ ] QuickenWindow.TypeKeys(KEY_DN)
						[ ] QuickenWindow.TypeKeys(KEY_ENTER)
						[+] if (DlgSetInvoiceDefaults.Exists(4))
							[ ] DlgSetInvoiceDefaults.SetActive()
							[ ] sActual=DlgSetInvoiceDefaults.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Customer Invoices Account Actions> Invoice Defaults", PASS, "Verify Customer Invoices Account Actions> Invoice Defaults option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Customer Invoices Account Actions> Invoice Defaults", FAIL, "Verify Customer Invoices Account Actions>Invoice Defaults option: Dialog {sValidationText} didn't display.")
							[ ] DlgSetInvoiceDefaults.CancelButton.Click()
							[ ] WaitForState(DlgSetInvoiceDefaults,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Set Invoice Defaults", FAIL, "Verify Dialog Set Invoice Defaults: Set Invoice Defaults dialog didn't appear.")
					[ ] 
					[+] ///##########Verifying Customer Invoices Account Actions> Register preferences#####////  
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Preferences"
						[+] for (iCounter=1;iCounter<21;++iCounter)
							[ ] QuickenWindow.TypeKeys(KEY_DN)
						[ ] QuickenWindow.TypeKeys(KEY_ENTER)
						[+] if (Preferences.Exists(4))
							[ ] Preferences.SetActive()
							[ ] sActual=Preferences.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Register preferences", PASS, "Verify Customer Invoices Account Actions>Register preferences option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Register preferences", FAIL, "Verify Customer Invoices Account Actions>Register preferences option: Dialog {sValidationText} didn't display.")
							[ ] Preferences.Cancel.Click()
							[ ] WaitForState(Preferences,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Preferences", FAIL, "Verify Dialog Preferences : Preferences Dialog didn't appear.")
					[ ] 
					[+] ///##########Verifying Customer Invoices Account Actions> Customize Action Bar#####////  
						[ ] 
						[ ] QuickenWindow.SetActive()
						[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] sValidationText=NULL
						[ ] sActual=NULL
						[ ] sValidationText="Customize Action Bar"
						[+] for (iCounter=1;iCounter<22;++iCounter)
							[ ] QuickenWindow.TypeKeys(KEY_DN)
						[ ] QuickenWindow.TypeKeys(KEY_ENTER)
						[+] if (DlgCustomizeActionBar.Exists(5))
							[ ] DlgCustomizeActionBar.SetActive()
							[ ] sActual=DlgCustomizeActionBar.GetProperty("Caption")
							[+] if (sActual==sValidationText)
								[ ] ReportStatus("Verify Customize Action Bar", PASS, "Verify Customer Invoices Account Actions>Customize Action Bar option: Dialog {sActual} displayed as expected {sValidationText}.")
							[+] else
								[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Customer Invoices Account Actions>Customize Action Bar option: Dialog {sValidationText} didn't display.")
							[ ] DlgCustomizeActionBar.DoneButton.Click()
							[ ] WaitForState(DlgCustomizeActionBar,FALSE,1)
						[+] else
							[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Dialog Customize Action Bar:  Customize Action Bar Dialog didn't appear.")
					[ ] 
					[ ] //Opening Business Account Register
					[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccountName[2],ACCOUNT_BUSINESS)
					[ ] 
					[+] if(iOpenAccountRegister==PASS)
						[ ] 
						[ ] ReportStatus("Verify if correct data is present under filters",PASS,"Account {lsAccountName[1]} selected successfully")
						[ ] 
						[+] if(QuickenWindow.Exists(5))
							[ ] QuickenWindow.SetActive()
							[+] if (AccountActionsButton.Exists(5))
								[ ] ReportStatus("Verify Account Actions button", PASS, "Verify Account Actions button: Account Actions button displayed.")
								[ ] 
								[+] ///##########Verifying Vendor Invoices Account Actions> Edit Account Details#####////
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
									[ ] sValidationText="Account Details" 
									[+] for (iCounter=1;iCounter<3;++iCounter)
										[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (AccountDetails.Exists(4))
										[ ] AccountDetails.SetActive()
										[ ] sActual=AccountDetails.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Vendor Invoices Account Actions> Edit Account Details", PASS, "Verify Vendor Invoices Account Actions> Edit Account Details option: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Vendor Invoices Account Actions> Edit Account Details", FAIL, "Verify Vendor Invoices Account Actions> Edit Account Details option: Dialog {sValidationText} didn't display.")
										[ ] AccountDetails.Cancel.Click()
										[ ] WaitForState(AccountDetails,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify Account Details", FAIL, "Verify Dialog Account Details:  Account Details dialog didn't appear.")
								[ ] 
								[+] ///##########Verifying Vendor Invoices Account Actions> New Vendor Invoice#####////
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
									[ ] sValidationText="Bill - " + lsAccountName[2]
									[+] for (iCounter=1;iCounter<4;++iCounter)
										[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (DlgInvoice.Exists(4))
										[ ] DlgInvoice.SetActive()
										[ ] sActual=DlgInvoice.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Customer Invoice", PASS, "Verify Vendor Invoices Account Actions> New Vendor Invoice option: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Customer Invoice", FAIL, "Verify Vendor Invoices Account Actions>New Vendor Invoice option: Dialog {sValidationText} didn't display.")
										[ ] DlgInvoice.CancelButton.Click()
										[+] if (AlertMessage.Exists(5))
											[ ] AlertMessage.SetActive()
											[ ] AlertMessage.Yes.Click()
										[ ] 
										[ ] WaitForState(DlgInvoice,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify New Vendor Invoice", FAIL, "Verify Dialog New Vendor Invoice: New Vendor Invoice dialog didn't appear.")
								[ ] 
								[+] ///##########Verifying Vendor Invoices Account Actions> New Vendor Payment#####////
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
									[ ] sValidationText="Payment - "  + lsAccountName[2]
									[+] for (iCounter=1;iCounter<5;++iCounter)
										[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (DlgPaymentInvoices.Exists(4))
										[ ] DlgPaymentInvoices.SetActive()
										[ ] sActual=DlgPaymentInvoices.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Vendor Payment", PASS, "Verify Vendor Invoices Account Actions> New Vendor Payment option: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Vendor Payment", FAIL, "Verify Vendor Invoices Account Actions>New Vendor Payment option: Dialog {sValidationText} didn't display.")
										[ ] DlgPaymentInvoices.CancelButton.Click()
										[+] if (AlertMessage.Exists(5))
											[ ] AlertMessage.SetActive()
											[ ] AlertMessage.Yes.Click()
										[ ] 
										[ ] WaitForState(DlgPaymentInvoices,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify New Vendor Payment", FAIL, "Verify Dialog New Vendor Payment: New Vendor Payment dialog didn't appear.")
								[ ] 
								[+] ///##########Verifying Vendor Invoices Account Actions> New Credit#####////
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
									[ ] sValidationText="Credit - "  + lsAccountName[2]
									[+] for (iCounter=1;iCounter<6;++iCounter)
										[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (DlgCreditInvoices.Exists(4))
										[ ] DlgCreditInvoices.SetActive()
										[ ] sActual=DlgCreditInvoices.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Credit", PASS, "Verify Vendor Invoices Account Actions> New Credit option: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Credit", FAIL, "Verify Vendor Invoices Account Actions>New Credit option: Dialog {sValidationText} didn't display.")
										[ ] DlgCreditInvoices.CancelButton.Click()
										[+] if (AlertMessage.Exists(5))
											[ ] AlertMessage.SetActive()
											[ ] AlertMessage.Yes.Click()
										[ ] 
										[ ] WaitForState(DlgCreditInvoices,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify New Credit", FAIL, "Verify Dialog New Credit: New Credit dialog didn't appear.")
								[ ] 
								[+] ///##########Verifying Vendor Invoices Account Actions> New Refund#####////
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
									[ ] sValidationText="Refund - "  + lsAccountName[2]
									[+] for (iCounter=1;iCounter<7;++iCounter)
										[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (DlgRefund.Exists(4))
										[ ] DlgRefund.SetActive()
										[ ] sActual=DlgRefund.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Refund", PASS, "Verify Vendor Invoices Account Actions> New Refund option: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Vendor Invoices Account Actions> New Refund", FAIL, "Verify Vendor Invoices Account Actions>New Refund option: Dialog {sValidationText} didn't display.")
										[ ] DlgRefund.CancelButton.Click()
										[+] if (AlertMessage.Exists(5))
											[ ] AlertMessage.SetActive()
											[ ] AlertMessage.Yes.Click()
										[ ] 
										[ ] WaitForState(DlgRefund,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify New Refund", FAIL, "Verify Dialog New Refund: New Refund dialog didn't appear.")
								[ ] 
								[+] ///##########Verifying Vendor Invoices Account Actions> Account Attachments #####////  
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
									[ ] sValidationText=NULL
									[ ] sActual=NULL
									[ ] sValidationText="Account Attachments: {lsAccountName[2]}"
									[+] for (iCounter=1;iCounter<9;++iCounter)
										[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (DlgAccountAttachments.Exists(4))
										[ ] DlgAccountAttachments.SetActive()
										[ ] sActual=DlgAccountAttachments.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Account Attachments", PASS, "Verify Vendor Invoices Account Actions> Account Attachments option: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Account Attachments", FAIL, "Verify Vendor Invoices Account Actions> Account Attachments option: Dialog {sValidationText} didn't display.")
										[ ] DlgAccountAttachments.DoneButton.Click()
										[ ] WaitForState(DlgAccountAttachments,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify Account Attachments ", FAIL, "Verify Dialog Account Attachments : Account Attachments Dialog didn't appear.")
								[ ] 
								[+] ///##########Verifying Vendor Invoices Account Actions> Account Overview #####////  
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
									[ ] sValidationText=NULL
									[ ] sActual=NULL
									[ ] sValidationText="Account Overview: {lsAccountName[2]}"
									[+] for (iCounter=1;iCounter<10;++iCounter)
										[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (DlgAccountOverview.Exists(4))
										[ ] DlgAccountOverview.SetActive()
										[ ] sActual=DlgAccountOverview.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Account Overview", PASS, "Verify Vendor Invoices Account Actions> Account Overview option: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Account Overview", FAIL, "Verify Vendor Invoices Account Actions> Account Overview option: Dialog {sValidationText} didn't display.")
										[ ] DlgAccountOverview.TypeKeys(KEY_EXIT)
										[ ] WaitForState(DlgAccountOverview,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify Account Overview ", FAIL, "Verify Dialog Account Overview : Account Overview Dialog didn't appear.")
								[ ] 
								[ ] 
								[+] ///##########Verifying Vendor Invoices Account Actions> Export to excel compatible file #####//// 
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
									[ ] sValidationText=NULL
									[ ] sActual=NULL
									[ ] sValidationText="Create Excel compatible file"
									[+] for (iCounter=1;iCounter<13;++iCounter)
										[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (DlgCreateExcelCompatibleFile.Exists(4))
										[ ] DlgCreateExcelCompatibleFile.SetActive()
										[ ] sActual=DlgCreateExcelCompatibleFile.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Export to excel compatible file", PASS, "Verify Vendor Invoices Account Actions> Export to excel compatible file option: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Export to excel compatible file", FAIL, "Verify Vendor Invoices Account Actions>Export to excel compatible file option: Dialog {sValidationText} didn't display.")
										[ ] DlgCreateExcelCompatibleFile.CancelButton.Click()
										[ ] WaitForState(DlgCreateExcelCompatibleFile,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify CreateExcelCompatibleFile", FAIL, "Verify Dialog CreateExcelCompatibleFile : CreateExcelCompatibleFile Dialog didn't appear.")
								[ ] 
								[+] // ///##########Verifying Vendor Invoices Account Actions> Print Transactions#####////  
									[ ] 
									[ ] sAccountName=lsAccountName[1]
									[ ] QuickenWindow.SetActive()
									[ ] sValidationText="Print Register"
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
									[+] for (iCount=1; iCount<12;++iCount)
										[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_RT)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (PrintRegister.Exists(4))
										[ ] PrintRegister.SetActive()
										[ ] sActual=PrintRegister.GetProperty("Caption")
										[+] if (trim(sActual)==trim(sValidationText))
											[ ] ReportStatus("Verify Print Transactions", PASS, "Verify Account Actions> Print Transactions option for {sAccountName}: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Print Transactions", FAIL, "Verify Account Actions> Print Transactions option for {sAccountName}: Dialog {sValidationText} didn't display.")
										[ ] PrintRegister.CancelButton.Click()
										[ ] WaitForState(PrintRegister,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify Print Register", FAIL, "Verify Dialog Print Register : Print RegisterDialog didn't appear.")
									[ ] ///##########Verifying Acount Actions> Print > Invoices#####////
									[ ] sValidationText="Print Invoices"
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
									[+] for (iCount=1; iCount<12;++iCount)
										[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_RT)
									[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (DlgPrintInvoices.Exists(4))
										[ ] DlgPrintInvoices.SetActive()
										[ ] sActual=DlgPrintInvoices.GetProperty("Caption")
										[+] if (trim(sActual)==trim(sValidationText))
											[ ] ReportStatus("Verify Print Invoices", PASS, "Verify Account Actions> Print Invoices option for {sAccountName}: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Print Invoices", FAIL, "Verify Account Actions> Print Invoices option for {sAccountName}: Dialog {sValidationText} didn't display.")
										[ ] DlgPrintInvoices.DoneButton.Click()
										[ ] WaitForState(DlgPrintInvoices,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify Print Invoices", FAIL, "Verify Dialog Print Invoices option for {sAccountName}: Print Invoices Dialog didn't appear.")
									[ ] 
									[ ] ///##########Verifying Acount Actions> Print > Customer Statements#####////
									[ ] sValidationText="Customer Statements"
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
									[+] for (iCount=1; iCount<12;++iCount)
										[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_RT)
									[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (DlgCustomerStatements.Exists(4))
										[ ] DlgCustomerStatements.SetActive()
										[ ] sActual=DlgCustomerStatements.GetProperty("Caption")
										[+] if (trim(sActual)==trim(sValidationText))
											[ ] ReportStatus("Verify Print Customer Statements", PASS, "Verify Account Actions> Print Customer Statements option for {sAccountName}: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Print Customer Statements", FAIL, "Verify Account Actions> Print Customer Statements option for {sAccountName}: Dialog {sValidationText} didn't display.")
										[ ] DlgCustomerStatements.CancelButton.Click()
										[ ] WaitForState(DlgCustomerStatements,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify Print Customer Statements", FAIL, "Verify Dialog Print Customer Statements option for {sAccountName}: Print Customer Statements Dialog didn't appear.")
									[ ] 
								[ ] 
								[+] ///##########Verifying Vendor Invoices Account Actions> Register preferences#####////  
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
									[ ] sValidationText=NULL
									[ ] sActual=NULL
									[ ] sValidationText="Preferences"
									[+] for (iCounter=1;iCounter<19;++iCounter)
										[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (Preferences.Exists(4))
										[ ] Preferences.SetActive()
										[ ] sActual=Preferences.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Register preferences", PASS, "Verify Vendor Invoices Account Actions>Register preferences option: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Register preferences", FAIL, "Verify Vendor Invoices Account Actions>Register preferences option: Dialog {sValidationText} didn't display.")
										[ ] Preferences.Cancel.Click()
										[ ] WaitForState(Preferences,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify Preferences", FAIL, "Verify Dialog Preferences : Preferences Dialog didn't appear.")
								[ ] 
								[+] ///##########Verifying Vendor Invoices Account Actions> Customize Action Bar#####////  
									[ ] 
									[ ] QuickenWindow.SetActive()
									[ ] QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
									[ ] sValidationText=NULL
									[ ] sActual=NULL
									[ ] sValidationText="Customize Action Bar"
									[+] for (iCounter=1;iCounter<20;++iCounter)
										[ ] QuickenWindow.TypeKeys(KEY_DN)
									[ ] QuickenWindow.TypeKeys(KEY_ENTER)
									[+] if (DlgCustomizeActionBar.Exists(5))
										[ ] DlgCustomizeActionBar.SetActive()
										[ ] sActual=DlgCustomizeActionBar.GetProperty("Caption")
										[+] if (sActual==sValidationText)
											[ ] ReportStatus("Verify Customize Action Bar", PASS, "Verify Vendor Invoices Account Actions>Customize Action Bar option: Dialog {sActual} displayed as expected {sValidationText}.")
										[+] else
											[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Vendor Invoices Account Actions>Customize Action Bar option: Dialog {sValidationText} didn't display.")
										[ ] DlgCustomizeActionBar.DoneButton.Click()
										[ ] WaitForState(DlgCustomizeActionBar,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify Customize Action Bar", FAIL, "Verify Dialog Customize Action Bar:  Customize Action Bar Dialog didn't appear.")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Account Actions button", FAIL, "Verify Account Actions button: Account Actions button doesn't exist'.")
							[ ] // QuickenWindow.Close()
							[ ] // WaitForState(QuickenWindow,FALSE,2)
							[ ] 
						[+] else
								[ ] ReportStatus("Verify {lsAccountName[2]} Account", FAIL, "{lsAccountName[1]} account coudln't open.")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Account Actions button", FAIL, "Verify Account Actions button: Account Actions button doesn't exist'.")
				[ ] 
			[+] else
					[ ] ReportStatus("Verify {lsAccountName[1]} Account", FAIL, "{lsAccountName[1]} account coudln't open.")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify if correct data is present under filters",FAIL,"Account {lsAccountName[1]} not selected")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL, "Quicken doesn't exist.")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] // //######################################################################
[ ] 
[+] // //############# Verify displaying of menu items under Business Actions drop down menu.#############
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test41_AccountActionsForBusinessAccount()
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // // This testcase will  Verify displaying of menu items under Business Actions drop down menu.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			Pass 		        If register account actions verification is successful						
		[ ] // //				        Fail			        If register account actions verification is unsuccessful		
		[ ] // // 
		[ ] // //REVISION HISTORY: 
		[ ] // // 04 June 2013        	Created by	Anagha Bhandare
		[ ] // //							
	[ ] // // ********************************************************
[+] // testcase Test40_AccountActionsForBusinessAccount() appstate none
	[ ] // 
	[ ] // // Variable Declarations
	[ ] // 
	[ ] // STRING sDialogName,sActionWorksheet
	[ ] // LIST OF STRING lsTestData
	[ ] // 
	[ ] // sDateStamp = FormatDateTime (GetDateTime(), "m/d/yyyy") 
	[ ] // 
	[ ] // 
	[ ] // 
	[+] // //Variable Declaration
		[ ] // 
		[ ] // sRegisterExcel = "BusinessTestData"
		[ ] // sAccWorksheet = "Business Accounts"
		[ ] // sActionWorksheet = "BusinessActionMenus"
		[ ] // 
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] // ListAppend(lsAccountName,lsExcelData[1][2])
		[ ] // ListAppend(lsAccountName,lsExcelData[2][2])
		[ ] // 
		[ ] // 
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcel, sActionWorksheet)
		[ ] // // Get row counts
		[ ] // iCount=ListCount(lsExcelData)
		[ ] // 
	[+] // if(QuickenWindow.Exists(5))
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // //Open an Existing Data File
		[ ] // iVerify = OpenDataFile(sFileName)
		[ ] // 
		[+] // if (iVerify == PASS)
			[ ] // QuickenWindow.View.ClassicMenus.Select()
			[ ] // 
			[ ] // //Opening Business Account Register
			[ ] // iOpenAccountRegister=AccountBarSelect(ACCOUNT_BUSINESS,3)
			[ ] // 
			[+] // if(QuickenWindow.Exists(5))
				[ ] // 
				[+] // for(i=1;i<=iCount;i++)
					[+] // //if (QuickenWindow.AccountActionsButtonText.AccountActions.AccountActionsButton.Exists(5))
						[ ] // 
						[ ] // ReportStatus("Verify Account Actions button", PASS, "Verify Account Actions button: Account Actions button displayed.")
						[ ] // 
						[ ] // lsTestData=lsExcelData[i]
						[ ] // 
						[ ] // QuickenWindow.TypeKeys(KEY_CTRL_SHIFT_N)
						[ ] // 
						[ ] // QuickenWindow.TypeKeys(Replicate(KEY_DN,i))
						[ ] // 
						[+] // if(lsTestData[2]=="")
							[ ] // 
							[ ] // 
						[+] // else if(StrPos("-",lsTestData[2]) > 0)
							[ ] // lsTestData[2]= Stuff(lsTestData[2],11,0,lsAccountName[1]) 
						[ ] // 
						[+] // if(lsTestData[3] == "Popup")
							[ ] // 
							[ ] // QuickenWindow.QWNavigator1.TypeKeys(KEY_ENTER)
							[ ] // 
							[ ] // iPos= StrPos(">",lsExcelData[i][1])
							[+] // if( iPos != 0)
								[ ] // lsTestData=split(lsExcelData[i][1],">")
								[ ] // QuickenWindow.QWNavigator1.TypeKeys(KEY_DN)
								[ ] // QuickenWindow.QWNavigator1.TypeKeys(KEY_ENTER)
								[ ] // 
							[ ] // 
							[+] // if(QuickenWindow.FileDlg(lsTestData[2]).Exists(5))
								[ ] // 
								[ ] // ReportStatus("Validate {lsTestData[2]} window", PASS, "{lsTestData[2]} window is displayed") 
								[ ] // 
								[ ] // QuickenWindow.FileDlg(lsTestData[2]).Close()
								[ ] // 
								[+] // if (Quicken2012Popup.Exists(5))
									[ ] // Quicken2012Popup.SetActive()
									[ ] // Quicken2012Popup.Yes.Click()
								[ ] // 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsTestData[2]} window", FAIL, " Expected - {lsTestData[2]} window title is not available")
						[ ] // 
						[ ] // 
						[ ] // //lsAccountName
						[ ] // 
					[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
	[ ] // 
[ ] 
[+] //#####Verify displaying of menu items under Business Tools drop down menu.######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test41_MenuItemsUnderReports() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify displaying of menu items under Reports button drop down menu.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			        Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 07 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test41_MenuItemsUnderReports()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sDialogName
	[ ] LIST OF STRING lsTestData ,lsReportNames
	[ ] 
	[ ] // Variable Definition
	[ ] 
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business>Reports"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Go to Business tab > Reports
		[ ] NavigateQuickenTab(sTAB_BUSINESS)
		[ ] 
		[+] if(QuickenMainWindow.QWNavigator1.Reports.Exists(5))
			[ ] 
			[+] for(iCounter=1;iCounter<=iCount;iCounter++)
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.Reports.Click()
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(Replicate(KEY_DN, iCounter))
				[ ] 
				[ ] QuickenMainWindow.QWNavigator1.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] //##########Verifying the Menus of Business Tab > Reports#####//
				[ ] lsReportNames = lsExcelData[iCounter]
				[+] if(StrPos("/",lsReportNames[2]) > 0)
					[ ] lsReportNames[2] = StrTran (lsReportNames[2], "/", "?")
				[+] if(Desktop.Find("//MainWin[@caption='{lsReportNames[2]}']").Exists(5))
					[ ] Desktop.Find("//MainWin[@caption='{lsReportNames[2]}']").SetActive()
					[ ] sActual=Desktop.Find("//MainWin[@caption='{lsReportNames[2]}']").GetProperty("caption")
					[ ] Desktop.Find("//MainWin[@caption='{lsReportNames[2]}']").Close()
					[ ] sleep(1)
					[ ] lsReportNames[2] = StrTran (lsReportNames[2], "?", "/")
					[+] if (sActual==lsReportNames[2])
						[ ] ReportStatus("Verify Account Actions> More Reports", PASS, "Verify Account Actions> More Reports >{lsReportNames[2]}: Report {sActual} is as expected {lsReportNames[2]} .")
					[+] else
						[ ] ReportStatus("Verify Account Actions> More Reports", FAIL, "Verify Account Actions> More Reports >{lsReportNames[2]}: Report {sActual} is  Not as expected {lsReportNames[2]} .")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Account Actions> More Reports", FAIL, "Verify Account Actions> More Reports >{lsReportNames[iCounter]}: Report {lsReportNames[iCounter]} didn't appear.")
					[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Check the Reports ", FAIL, "Reports does not exists")
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL, "Quicken doesn't exist.")
	[ ] 
[ ] //########################################################################
[ ] 
[ ] // 
[ ] /////////////////////////////////////////////Email Invoice////////////////////////////////////////////////////////////////////
[ ] 
[+] //#############Verify E-mail/Clipboard button in Bill-Vendor Invoices form########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_EmailClipboardButtononVendorInvoiceBill() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify E-mail/Clipboard button in Bill-Vendor Invoices form
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 07 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test01_EmailClipboardButtononVendorInvoiceBill()    appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sDialogName
	[ ] LIST OF STRING lsAccount,lsCompare,lsLayout,lsTaxAccount
	[ ] 
	[ ] // Variable Definition
	[ ] 
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] 
	[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
	[ ] lsAccount=lsExcelData[1]
	[ ] 
	[ ] 
	[-] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[-] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] //Verify Business > Bills and Vendors  > Create Bills
			[ ] QuickenWindow.Business.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.Click()
			[ ] QuickenWindow.Business.BillsAndVendors.CreateBill.Select()
			[ ] 
			[+] if(ChooseInvoiceAccount.Exists(5))
				[ ] ChooseInvoiceAccount.SetActive()
				[ ] ChooseInvoiceAccount.ChooseInvoiceAccount.Select("#1")
				[ ] ChooseInvoiceAccount.OK.Click()
				[ ] WaitForState(ChooseInvoiceAccount , false ,3)
			[ ] 
			[-] if (DlgBillVendorInvoices.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Create Vendor Invoice window ", PASS , "Create Vendor Invoice window is displayed")
				[ ] 
				[-] if(!DlgBillVendorInvoices.EMailSendToClipboardButton.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify EMail Send To Clipboard Button on Create Vendor Invoice window ", PASS , "EMail Send To Clipboard Button does not exist on Create Vendor Invoice window.")
				[-] else
					[ ] ReportStatus("Verify EMail Send To Clipboard Button on Create Vendor Invoice window ", FAIL , "EMail Send To Clipboard Button is present on Create Vendor Invoice window.")
				[ ] DlgBillVendorInvoices.Close()
				[-] if(AlertMessage.Exists(5))
					[ ] AlertMessage.Yes.Click()
					[ ] WaitForState(AlertMessage , false ,4)
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Create Vendor Invoice window ", FAIL , "Create Vendor Invoice window didn't display.")
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL, "Quicken doesn't exist.")
	[ ] 
[ ] //########################################################################
[ ] 
[+] //#############Verify UI of Send Invoice by mail dialog##################################
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test03_SendInvoicebyMail() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify UI of Send Invoice by mail dialog
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		       If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 07 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test03_UISendInvoicebyMail()  appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sDialogName
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "BusinessTransaction"
	[ ] sWindowType = "MDI"
	[ ] 
	[ ] //sAction="Form..."
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsAccount=lsExcelData[1]
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] sPayee=lsTransaction[6]
		[ ] 
	[ ] 
	[-] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[-] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] lsTransaction[4]=sDateStamp
			[ ] 
			[ ] iResult=AddBusinessTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7])
			[ ] 
			[-] if(iResult==PASS)
				[ ] 
				[ ] ReportStatus("Verify Customer Invoice transactions added",PASS ,"Customer Invoice transaction got added successfully")
				[ ] 
				[ ] //iResult=AccountActionsOnTransaction(sPayee,sAction)
				[ ] 
				[ ] iResult = FindTransaction(sWindowType,sPayee)
				[ ] 
				[-] if(iResult==PASS)
					[ ] 
					[ ] QuickenWindow.TypeKeys(KEY_CTRL_S)
					[ ] 
					[-] if (DlgInvoice.Exists(5))
						[ ] 
						[ ] DlgInvoice.SetActive()
						[ ] 
						[ ] ReportStatus("Verify Customer Invoice form",PASS ,"Customer Invoice form is displayed")
						[ ] 
						[-] if(DlgInvoice.EMailSendToClipboardButton.Exists(5))
							[ ] 
							[ ] ReportStatus("Verify EMail Send To Clipboard Button on Create Vendor Invoice window ", PASS , "EMail Send To Clipboard Button on Create Customer Invoice window is present")
							[ ] 
							[ ] DlgInvoice.SetActive()
							[ ] 
							[ ] DlgInvoice.EMailSendToClipboardButton.Click()
							[ ] 
							[-] if(DlgInvoice.DlgSendInvoiceByEMail.Exists(5))
								[ ] 
								[ ] ReportStatus("Verify Send Invoice By Email Dialog",PASS ,"Send Invoice By Email Dialog is displayed")
								[ ] 
								[ ] //Verify the UI controls of Send Invoice by Email
								[ ] 
								[ ] //Verify the Format RadioList on Send Invoice By Email Dialog
								[+] if(DlgInvoice.DlgSendInvoiceByEMail.FormatRadioList.Exists(5))
									[ ] ReportStatus("Verify Format RadioList on Send Invoice By Email Dialog",PASS ,"Format RadioList on Send Invoice By Email Dialog is present")
								[+] else
									[ ] ReportStatus("Verify Format RadioList on Send Invoice By Email Dialog",FAIL ,"Format RadioList on Send Invoice By Email Dialog is not present")
									[ ] 
								[ ] 
								[ ] //Verify the Output RadioList on Send Invoice By Email Dialog
								[+] if(DlgInvoice.DlgSendInvoiceByEMail.OutputRadioList.Exists(5))
									[ ] ReportStatus("Verify Output RadioList on Send Invoice By Email Dialog",PASS ,"Output RadioList on Send Invoice By Email Dialog is present")
								[+] else
									[ ] ReportStatus("Verify Output RadioList on Send Invoice By Email Dialog",FAIL ,"Output RadioList on Send Invoice By Email Dialog is not present")
									[ ] 
								[ ] 
								[ ] //Verify the Send RadioList on Send Invoice By Email Dialog
								[+] if(DlgInvoice.DlgSendInvoiceByEMail.Send1RadioList.Exists(5))
									[ ] ReportStatus("Verify Send RadioList on Send Invoice By Email Dialog",PASS ,"Send RadioList on Send Invoice By Email Dialog is present")
								[+] else
									[ ] ReportStatus("Verify Send RadioList on Send Invoice By Email Dialog",FAIL ,"Send RadioList on Send Invoice By Email Dialog is not present")
									[ ] 
								[ ] 
								[ ] //Verify the EMail Address TextField on Send Invoice By Email Dialog
								[+] if(DlgInvoice.DlgSendInvoiceByEMail.EMailAddressTextField.Exists(5))
									[ ] ReportStatus("Verify EMail Address TextField on Send Invoice By Email Dialog",PASS ,"EMail Address TextField on Send Invoice By Email Dialog is present")
								[+] else
									[ ] ReportStatus("Verify EMail Address TextField on Send Invoice By Email Dialog",FAIL ,"EMail Address TextField on Send Invoice By Email Dialog is not present")
									[ ] 
								[ ] 
								[ ] //Verify the Help Button on Send Invoice By Email Dialog
								[+] if(DlgInvoice.DlgSendInvoiceByEMail.HelpButton.Exists(5))
									[ ] ReportStatus("Verify Help Button on Send Invoice By Email Dialog",PASS ,"Help Button on Send Invoice By Email Dialog is present")
								[+] else
									[ ] ReportStatus("Verify Help Button on Send Invoice By Email Dialog",FAIL ,"Help Button on Send Invoice By Email Dialog is not present")
									[ ] 
								[ ] 
								[ ] //Verify the OK Button on Send Invoice By Email Dialog
								[+] if(DlgInvoice.DlgSendInvoiceByEMail.OKButton.Exists(5))
									[ ] ReportStatus("Verify OK Button on Send Invoice By Email Dialog",PASS ,"OK Button on Send Invoice By Email Dialog is present")
								[+] else
									[ ] ReportStatus("Verify OK Button on Send Invoice By Email Dialog",FAIL ,"OK Button on Send Invoice By Email Dialog is not present")
									[ ] 
								[ ] 
								[ ] //Verify the Cancel Button on Send Invoice By Email Dialog
								[+] if(DlgInvoice.DlgSendInvoiceByEMail.CancelButton.Exists(5))
									[ ] ReportStatus("Verify Cancel Button on Send Invoice By Email Dialog",PASS ,"Cancel Button on Send Invoice By Email Dialog is present")
								[+] else
									[ ] ReportStatus("Verify Cancel Button on Send Invoice By Email Dialog",FAIL ,"Cancel Button on Send Invoice By Email Dialog is not present")
									[ ] 
								[ ] 
								[ ] 
								[ ] DlgInvoice.DlgSendInvoiceByEMail.Close()
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Send Invoice By Email Dialog",FAIL ,"Send Invoice By Email Dialog is not displayed")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify EMail Send To Clipboard Button on Create Vendor Invoice window ", FAIL , "EMail Send To Clipboard Button on Create Customer Invoice window is not present")
						[ ] 
						[ ] DlgInvoice.CancelButton.Click()
						[+] if(AlertMessage.Exists(5))
							[ ] AlertMessage.Yes.Click()
							[ ] WaitForState(AlertMessage , false ,4)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Customer Invoice form",FAIL ,"Customer Invoice form is not displayed")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Customer Invoice transactions added",FAIL ,"Customer Invoice transaction not got added successfully")
		[+] else
			[ ] ReportStatus("Verify Account is selected from AccountBar", FAIL , "Account is not selected from AccountBar")
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL, "Quicken doesn't exist.")
	[ ] 
[ ] //########################################################################
[ ] 
[+] //#############Verify displaying of help for Email Invoice.##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_HelpEmailInvoice() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This testcase will Verify displaying of help for Email Invoice.
		[ ] //.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		              If verification of content is correct					
		[ ] //						Fail		             If any error occurs
		[ ] // 
		[ ] //REVISION HISTORY:	
		[ ] // 07 June 2013        	Created by	Anagha Bhandare
		[ ] //							
	[ ] // ********************************************************
[+] testcase Test05_HelpEmailInvoice()   appstate none
	[ ] // Variable Declarations
	[ ] 
	[ ] STRING sDialogName
	[ ] LIST OF STRING lsAccount
	[ ] 
	[ ] // Variable Definition
	[ ] sRegisterExcel = "BusinessTestData"
	[ ] sAccWorksheet = "Business Accounts"
	[ ] sTransactionsheet = "BusinessTransaction"
	[ ] 
	[+] //Retrieving Banking Data from Excel sheet 
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] lsAccount=lsExcelData[1]
		[ ] lsExcelData=NULL
		[ ] lsExcelData=ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] lsTransaction=lsExcelData[1]
		[ ] sPayee=lsTransaction[6]
		[ ] 
	[ ] 
	[-] if (QuickenWindow.Exists(5))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Opening Business Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] 
		[-] if(iOpenAccountRegister==PASS)
			[ ] 
			[ ] ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] 
			[ ] lsTransaction[4]=sDateStamp
			[ ] 
			[ ] iResult=AddBusinessTransaction(lsTransaction[1],lsTransaction[2],lsTransaction[3],lsTransaction[4],lsTransaction[5],lsTransaction[6],lsTransaction[7])
			[ ] 
			[-] if(iResult==PASS)
				[ ] 
				[ ] ReportStatus("Verify Customer Invoice transactions added",PASS ,"Customer Invoice transaction got added successfully")
				[ ] 
				[ ] iResult = FindTransaction(sWindowType,sPayee)
				[ ] 
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_S)
				[ ] 
				[-] if (DlgInvoice.Exists(5))
					[ ] 
					[ ] DlgInvoice.SetActive()
					[ ] 
					[ ] ReportStatus("Verify Customer Invoice form",PASS ,"Customer Invoice form is displayed")
					[ ] 
					[-] if(DlgInvoice.EMailSendToClipboardButton.Exists(5))
						[ ] 
						[ ] ReportStatus("Verify EMail Send To Clipboard Button on Create Vendor Invoice window ", PASS , "EMail Send To Clipboard Button on Create Customer Invoice window is present")
						[ ] 
						[ ] DlgInvoice.SetActive()
						[ ] 
						[ ] DlgInvoice.EMailSendToClipboardButton.Click()
						[ ] 
						[-] if(DlgInvoice.DlgSendInvoiceByEMail.Exists(5))
							[ ] 
							[ ] ReportStatus("Verify Send Invoice By Email Dialog",PASS ,"Send Invoice By Email Dialog is displayed")
							[ ] 
							[ ] //Verify the Help Button on Send Invoice By Email Dialog
							[-] if(DlgInvoice.DlgSendInvoiceByEMail.HelpButton.Exists(5))
								[ ] ReportStatus("Verify Help Button on Send Invoice By Email Dialog",PASS ,"Help Button on Send Invoice By Email Dialog is present")
								[ ] 
								[ ] DlgInvoice.DlgSendInvoiceByEMail.SetActive()
								[ ] 
								[ ] DlgInvoice.DlgSendInvoiceByEMail.HelpButton.Click()
								[ ] 
								[ ] sleep(3)
								[ ] 
								[-] //Help Dialog gets opened
									[-] if(QuickenHelp.Exists(5))
										[ ] ReportStatus("Verify Help Dialog ", PASS , "Help Dialog is present ")
										[ ] QuickenHelp.Close()
									[+] else
										[ ] ReportStatus("Verify Help Dialog", FAIL , "Help Dialog is not present")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Help Button on Send Invoice By Email Dialog",FAIL ,"Help Button on Send Invoice By Email Dialog is not present")
								[ ] 
							[ ] 
							[ ] DlgInvoice.DlgSendInvoiceByEMail.Close()
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Send Invoice By Email Dialog",FAIL ,"Send Invoice By Email Dialog is not displayed")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify EMail Send To Clipboard Button on Create Vendor Invoice window ", FAIL , "EMail Send To Clipboard Button on Create Customer Invoice window is not present")
					[ ] 
					[ ] DlgInvoice.CancelButton.Click()
					[+] if(AlertMessage.Exists(5))
						[ ] AlertMessage.Yes.Click()
						[ ] WaitForState(AlertMessage , false ,4)
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Customer Invoice form",FAIL ,"Customer Invoice form is not displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Customer Invoice transactions added",FAIL ,"Customer Invoice transaction not got added successfully")
		[+] else
			[ ] ReportStatus("Verify Account is selected from AccountBar", FAIL , "Account is not selected from AccountBar")
	[+] else
		[ ] ReportStatus("Verify Quicken exists. ", FAIL, "Quicken doesn't exist.")
	[ ] 
[ ] //#########################################################################
[ ] 
[+] // //#############Verify E-Mail a created  Invoice########################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test04_EmailACreatedInvoice() 
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // 
		[ ] // // This testcase will :E-Mail a created  Invoice when email client is open
		[ ] // //.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			        Pass 		              If verification of content is correct					
		[ ] // //						Fail		             If any error occurs
		[ ] // // 
		[ ] // //REVISION HISTORY:	
		[ ] // // 10 June 2013        	Created by	Anagha Bhandare
		[ ] // //							
	[ ] // // ********************************************************
[+] // testcase Test04_EmailACreatedInvoice()   appstate none
	[ ] // // Variable Declarations
	[ ] // 
	[ ] // STRING sDialogName,sEmailAddress,sCaption
	[ ] // LIST OF STRING lsAccount
	[ ] // 
	[ ] // // Variable Definition
	[ ] // sRegisterExcel = "BusinessTestData"
	[ ] // sAccWorksheet = "Business Accounts"
	[ ] // sTransactionsheet = "BusinessTransaction"
	[ ] // sEmailAddress = "a1@gmail.com"
	[ ] // sCaption = "This is your Invoice"
	[ ] // 
	[ ] // 
	[+] // //Retrieving Banking Data from Excel sheet 
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] // lsAccount=lsExcelData[1]
		[ ] // lsExcelData=NULL
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcel, sTransactionsheet)
		[ ] // lsTransaction=lsExcelData[1]
		[ ] // sPayee=lsTransaction[6]
		[ ] // 
	[ ] // 
	[+] // if (QuickenWindow.Exists(5))
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // 
		[ ] // //Opening Business Account Register
		[ ] // iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] // 
		[+] // if(iOpenAccountRegister==PASS)
			[ ] // 
			[ ] // ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] // 
			[ ] // iResult = FindTransaction(sWindowType,sPayee)
			[ ] // 
			[+] // if(iResult==PASS)
				[ ] // 
				[ ] // ReportStatus("Verify Customer Invoice transactions selected",PASS ,"Customer Invoice transaction got selected successfully")
				[ ] // 
				[ ] // //iResult=AccountActionsOnTransaction(sPayee,sAction)
				[ ] // 
				[ ] // QuickenWindow.TypeKeys(KEY_CTRL_S)
				[ ] // 
				[+] // if (DlgInvoice.Exists(5))
					[ ] // 
					[ ] // DlgInvoice.SetActive()
					[ ] // 
					[ ] // ReportStatus("Verify Customer Invoice form",PASS ,"Customer Invoice form is displayed")
					[ ] // 
					[+] // if(DlgInvoice.EMailSendToClipboardButton.Exists(5))
						[ ] // 
						[ ] // ReportStatus("Verify EMail Send To Clipboard Button on Create Vendor Invoice window ", PASS , "EMail Send To Clipboard Button on Create Customer Invoice window is present")
						[ ] // 
						[ ] // DlgInvoice.SetActive()
						[ ] // 
						[ ] // DlgInvoice.EMailSendToClipboardButton.Click()
						[ ] // 
						[+] // if(DlgInvoice.DlgSendInvoiceByEMail.Exists(5))
							[ ] // 
							[ ] // ReportStatus("Verify Send Invoice By Email Dialog",PASS ,"Send Invoice By Email Dialog is displayed")
							[ ] // 
							[+] // if(DlgInvoice.DlgSendInvoiceByEMail.FormatRadioList.Exists(5))
								[ ] // ReportStatus("Verify Format radio list",PASS,"Format radio list is displayed")
								[ ] // DlgInvoice.DlgSendInvoiceByEMail.SetActive()
								[ ] // DlgInvoice.DlgSendInvoiceByEMail.FormatRadioList.TypeKeys(KEY_DN)
								[ ] // DlgInvoice.DlgSendInvoiceByEMail.Send1RadioList.TypeKeys(KEY_DN)
								[ ] // 
								[+] // if(DlgInvoice.DlgSendInvoiceByEMail.EMailAddressTextField.Exists(5))
									[ ] // ReportStatus("Verify Email Address TextField",PASS,"Email Address TextField is present")
									[ ] // DlgInvoice.DlgSendInvoiceByEMail.Send1RadioList.Select(2)
									[ ] // DlgInvoice.DlgSendInvoiceByEMail.EMailAddressTextField.SetText(sEmailAddress)
									[ ] // 
									[ ] // DlgInvoice.DlgSendInvoiceByEMail.OKButton.Click()
									[ ] // 
									[+] // if(DlgMicrosoftOutlook.Exists(5))
										[ ] // ReportStatus("Verify Microsoft Outlook Window",PASS,"Microsoft Outlook Window is present")
										[ ] // DlgMicrosoftOutlook.AllowButton.Click()
										[ ] // 
										[ ] // WaitForState(DlgInvoiceMessage,TRUE,10)
										[ ] // 
										[+] // if(DlgInvoiceMessage.Exists(5))
											[ ] // 
											[ ] // sDialogName=DlgInvoiceMessage.GetCaption()
											[ ] // 
											[+] // if(sDialogName == sCaption)
												[ ] // ReportStatus("Verify Email- created Invoice  ",PASS,"Email of created Invoice got created sucessfully")
												[ ] // 
												[ ] // DlgInvoiceMessage.Close()
												[ ] // 
											[+] // else
												[ ] // ReportStatus("Verify Email- created Invoice  ",FAIL,"Email of created Invoice did not got created sucessfully")
										[ ] // 
							[ ] // 
							[ ] // DlgInvoice.DlgSendInvoiceByEMail.Close()
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify Send Invoice By Email Dialog",FAIL ,"Send Invoice By Email Dialog is not displayed")
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify EMail Send To Clipboard Button on Create Vendor Invoice window ", FAIL , "EMail Send To Clipboard Button on Create Customer Invoice window is not present")
					[ ] // 
					[ ] // DlgInvoice.CancelButton.Click()
					[+] // if(AlertMessage.Exists(5))
						[ ] // AlertMessage.Yes.Click()
						[ ] // WaitForState(AlertMessage , false ,4)
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Customer Invoice form",FAIL ,"Customer Invoice form is not displayed")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify Customer Invoice transactions added",FAIL ,"Customer Invoice transaction not got added successfully")
		[+] // else
			[ ] // ReportStatus("Verify Account is selected from AccountBar", FAIL , "Account is not selected from AccountBar")
	[+] // else
		[ ] // ReportStatus("Verify Quicken exists. ", FAIL, "Quicken doesn't exist.")
	[ ] // 
[ ] // //#########################################################################
[ ] // 
[+] // //#############verify Sending of Credit by email.#######################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test10_EmailACreditInvoice() 
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // 
		[ ] // // This testcase will verify Sending of Credit by email.
		[ ] // //.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			        Pass 		              If verification of content is correct					
		[ ] // //						Fail		             If any error occurs
		[ ] // // 
		[ ] // //REVISION HISTORY:	
		[ ] // // 10 June 2013        	Created by	Anagha Bhandare
		[ ] // //							
	[ ] // // ********************************************************
[+] // testcase Test10_EmailACreditInvoice()  appstate none
	[ ] // // Variable Declarations
	[ ] // 
	[ ] // STRING sDialogName,sEmailAddress,sCaption
	[ ] // LIST OF STRING lsAccount
	[ ] // 
	[ ] // // Variable Definition
	[ ] // sRegisterExcel = "BusinessTestData"
	[ ] // sAccWorksheet = "BusinessTransaction"
	[ ] // sEmailAddress = "a1@gmail.com"
	[ ] // sCaption = "This is your Credit statement"
	[ ] // 
	[+] // //Retrieving Banking Data from Excel sheet 
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] // lsAccount=lsExcelData[2]
		[ ] // sPayee=lsAccount[6]
		[ ] // 
	[ ] // 
	[ ] // 
	[+] // if (QuickenWindow.Exists(5))
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // //Opening Business Account Register
		[ ] // iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] // 
		[+] // if(iOpenAccountRegister==PASS)
			[ ] // 
			[ ] // ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] // 
			[ ] // lsAccount[4]=sDateStamp
			[ ] // 
			[ ] // iResult=AddBusinessTransaction(lsAccount[1],lsAccount[2],lsAccount[3],lsAccount[4],lsAccount[5],lsAccount[6],lsAccount[7])
			[ ] // 
			[+] // if(iResult==PASS)
				[ ] // 
				[ ] // ReportStatus("Verify Customer Invoice transactions added",PASS ,"Customer Invoice transaction got added successfully")
				[ ] // 
				[ ] // //iResult=AccountActionsOnTransaction(sPayee,sAction)
				[ ] // iResult = FindTransaction(sWindowType,sPayee)
				[ ] // 
				[+] // if(iResult==PASS)
					[ ] // 
					[ ] // QuickenWindow.TypeKeys(KEY_CTRL_S)
					[ ] // 
					[+] // if (DlgInvoice.Exists(5))
						[ ] // 
						[ ] // DlgInvoice.SetActive()
						[ ] // 
						[ ] // ReportStatus("Verify Customer Invoice form",PASS ,"Customer Invoice form is displayed")
						[ ] // 
						[+] // if(DlgInvoice.EMailSendToClipboardButton.Exists(5))
							[ ] // 
							[ ] // ReportStatus("Verify EMail Send To Clipboard Button on Create Vendor Invoice window ", PASS , "EMail Send To Clipboard Button on Create Customer Invoice window is present")
							[ ] // 
							[ ] // DlgInvoice.SetActive()
							[ ] // 
							[ ] // DlgInvoice.EMailSendToClipboardButton.Click()
							[ ] // 
							[+] // if(DlgInvoice.DlgSendInvoiceByEMail.Exists(5))
								[ ] // 
								[ ] // ReportStatus("Verify Send Invoice By Email Dialog",PASS ,"Send Invoice By Email Dialog is displayed")
								[ ] // 
								[+] // if(DlgInvoice.DlgSendInvoiceByEMail.FormatRadioList.Exists(5))
									[ ] // ReportStatus("Verify Format radio list",PASS,"Format radio list is displayed")
									[ ] // DlgInvoice.DlgSendInvoiceByEMail.SetActive()
									[ ] // DlgInvoice.DlgSendInvoiceByEMail.FormatRadioList.TypeKeys(KEY_DN)
									[ ] // DlgInvoice.DlgSendInvoiceByEMail.Send1RadioList.TypeKeys(KEY_DN)
									[ ] // 
									[+] // if(DlgInvoice.DlgSendInvoiceByEMail.EMailAddressTextField.Exists(5))
										[ ] // ReportStatus("Verify Email Address TextField",PASS,"Email Address TextField is present")
										[ ] // DlgInvoice.DlgSendInvoiceByEMail.EMailAddressTextField.SetText(sEmailAddress)
										[ ] // 
										[ ] // DlgInvoice.DlgSendInvoiceByEMail.OKButton.Click()
										[ ] // 
										[+] // if(DlgMicrosoftOutlook.Exists(5))
											[ ] // ReportStatus("Verify Microsoft Outlook Window",PASS,"Microsoft Outlook Window is present")
											[ ] // DlgMicrosoftOutlook.AllowButton.Click()
											[ ] // 
											[ ] // WaitForState(DlgInvoiceMessage,TRUE,10)
											[ ] // 
											[+] // if(DlgInvoiceMessage.Exists(5))
												[ ] // 
												[ ] // sDialogName=DlgInvoiceMessage.GetCaption()
												[ ] // 
												[+] // if(sDialogName == sCaption)
													[ ] // ReportStatus("Verify Email- created Invoice  ",PASS,"Email of created Invoice got created sucessfully")
													[ ] // 
													[ ] // DlgInvoiceMessage.Close()
													[ ] // 
												[+] // else
													[ ] // ReportStatus("Verify Email- created Invoice  ",FAIL,"Email of created Invoice did not got created sucessfully")
											[ ] // 
								[ ] // 
								[ ] // DlgInvoice.DlgSendInvoiceByEMail.Close()
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Verify Send Invoice By Email Dialog",FAIL ,"Send Invoice By Email Dialog is not displayed")
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify EMail Send To Clipboard Button on Create Vendor Invoice window ", FAIL , "EMail Send To Clipboard Button on Create Customer Invoice window is not present")
						[ ] // 
						[ ] // DlgInvoice.CancelButton.Click()
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify Customer Invoice form",FAIL ,"Customer Invoice form is not displayed")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify Customer Invoice transactions added",FAIL ,"Customer Invoice transaction not got added successfully")
		[+] // else
			[ ] // ReportStatus("Verify Account is selected from AccountBar", FAIL , "Account is not selected from AccountBar")
	[+] // else
		[ ] // ReportStatus("Verify Quicken exists. ", FAIL, "Quicken doesn't exist.")
	[ ] // 
[ ] // //########################################################################
[ ] // 
[+] // //#############verify Sending of Estimate by email#######################################
	[ ] // // ********************************************************
	[+] // // TestCase Name:	 Test11_EmailAEstimateInvoice() 
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // 
		[ ] // // This testcase will  verify Sending of Estimate by email.
		[ ] // //.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			        Pass 		              If verification of content is correct					
		[ ] // //						Fail		                      If any error occurs
		[ ] // // 
		[ ] // //REVISION HISTORY:	
		[ ] // // 10 June 2013        	Created by	Anagha Bhandare
		[ ] // //							
	[ ] // // ********************************************************
[+] // testcase Test11_EmailAEstimateInvoice()  appstate none
	[ ] // // Variable Declarations
	[ ] // 
	[ ] // STRING sDialogName,sEmailAddress,sCaption
	[ ] // LIST OF STRING lsAccount
	[ ] // 
	[ ] // // Variable Definition
	[ ] // sRegisterExcel = "BusinessTestData"
	[ ] // sAccWorksheet = "Estimate"
	[ ] // sEmailAddress = "a1@gmail.com"
	[ ] // sCaption = "This is your Estimate"
	[ ] // 
	[ ] // 
	[+] // //Retrieving Banking Data from Excel sheet 
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] // lsAccount=lsExcelData[2]
		[ ] // sPayee=lsAccount[6]
		[ ] // 
	[ ] // 
	[+] // if (QuickenWindow.Exists(5))
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // 
		[ ] // //Opening Business Account Register
		[ ] // iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] // 
		[+] // if(iOpenAccountRegister==PASS)
			[ ] // 
			[ ] // ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] // 
			[ ] // //Verify Business > Invoices And Estimates > Create Estimates
			[ ] // QuickenWindow.Business.InvoicesAndEstimates.CreateEstimate.Select()
			[ ] // 
			[ ] // WaitForState(EstimateList.DlgEstimate,TRUE,2)
			[ ] // 
			[+] // if (EstimateList.DlgEstimate.Exists(5))
				[ ] // 
				[ ] // EstimateList.DlgEstimate.SetActive()
				[ ] // EstimateList.DlgEstimate.CustomerTextField.SetText(lsTransaction[1])
				[ ] // EstimateList.DlgEstimate.ProjectJobTextField.SetText(lsTransaction[2])
				[ ] // EstimateList.DlgEstimate.BusinessTagTextField.SetText(lsTransaction[3])
				[ ] // EstimateList.DlgEstimate.BILLTO1TextField.SetText(lsTransaction[4])
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.Click()
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.TypeKeys(lsTransaction[5]) 
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.TypeKeys(KEY_TAB)
				[+] // if (MessageBox.Exists(5))
					[ ] // MessageBox.Yes.Click()
					[+] // if (DlgNewItem.Exists(5))
						[ ] // DlgNewItem.SetActive()
						[ ] // DlgNewItem.NewItemTextField.SetText(sItem)
						[ ] // DlgNewItem.OKButton.Click()
						[ ] // WaitForState(DlgNewItem,false,1)
					[+] // else
						[ ] // ReportStatus("Verify dialog New Item",FAIL,"Verify dialog New Item: Dialog New Item didn't appear.")
						[ ] // 
					[ ] // 
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.TypeKeys(lsTransaction[6]) 
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.TypeKeys(KEY_TAB)
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.TypeKeys(lsTransaction[7]) 
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.TypeKeys(KEY_TAB)
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.TypeKeys(lsTransaction[8]) 
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.TypeKeys(KEY_TAB)
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.TypeKeys(lsTransaction[9]) 
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.TypeKeys(KEY_TAB)
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.TypeKeys(lsTransaction[10]) 
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.TypeKeys(KEY_TAB)
				[ ] // EstimateList.DlgEstimate.QWListViewerItem.ListBox1.TypeKeys(lsTransaction[11]) 
				[ ] // EstimateList.DlgEstimate.TaxTextField.SetText(lsTransaction[12]) 
				[ ] // EstimateList.DlgEstimate.CustomerMessageTextField.SetText(lsTransaction[13])
				[ ] // 
				[ ] // EstimateList.DlgEstimate.EMailSendToClipboardButton.Click()
				[ ] // 
				[+] // if(DlgInvoice.DlgSendInvoiceByEMail.Exists(5))
					[ ] // 
					[ ] // ReportStatus("Verify Send Invoice By Email Dialog",PASS ,"Send Invoice By Email Dialog is displayed")
					[ ] // 
					[+] // if(DlgInvoice.DlgSendInvoiceByEMail.FormatRadioList.Exists(5))
						[ ] // ReportStatus("Verify Format radio list",PASS,"Format radio list is displayed")
						[ ] // DlgInvoice.DlgSendInvoiceByEMail.SetActive()
						[ ] // DlgInvoice.DlgSendInvoiceByEMail.FormatRadioList.TypeKeys(KEY_DN)
						[ ] // DlgInvoice.DlgSendInvoiceByEMail.Send1RadioList.TypeKeys(KEY_DN)
						[ ] // 
						[+] // if(DlgInvoice.DlgSendInvoiceByEMail.EMailAddressTextField.Exists(5))
							[ ] // ReportStatus("Verify Email Address TextField",PASS,"Email Address TextField is present")
							[ ] // DlgInvoice.DlgSendInvoiceByEMail.EMailAddressTextField.SetText(sEmailAddress)
							[ ] // 
							[ ] // DlgInvoice.DlgSendInvoiceByEMail.OKButton.Click()
							[ ] // 
							[+] // if(DlgMicrosoftOutlook.Exists(5))
								[ ] // ReportStatus("Verify Microsoft Outlook Window",PASS,"Microsoft Outlook Window is present")
								[ ] // DlgMicrosoftOutlook.AllowButton.Click()
								[ ] // 
								[ ] // WaitForState(DlgInvoiceMessage,TRUE,10)
								[ ] // 
								[+] // if(DlgInvoiceMessage.Exists(5))
									[ ] // 
									[ ] // sDialogName=DlgInvoiceMessage.GetCaption()
									[ ] // 
									[+] // if(sDialogName == sCaption)
										[ ] // ReportStatus("Verify Email- created Invoice  ",PASS,"Email of created Invoice got created sucessfully")
										[ ] // 
										[ ] // DlgInvoiceMessage.Close()
										[ ] // 
									[+] // else
										[ ] // ReportStatus("Verify Email- created Invoice  ",FAIL,"Email of created Invoice did not got created sucessfully")
								[ ] // 
					[ ] // 
					[ ] // DlgInvoice.DlgSendInvoiceByEMail.Close()
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Send Invoice By Email Dialog",FAIL ,"Send Invoice By Email Dialog is not displayed")
				[ ] // 
		[+] // else
			[ ] // ReportStatus("Verify Account is selected from AccountBar", FAIL , "Account is not selected from AccountBar")
	[+] // else
		[ ] // ReportStatus("Verify Quicken exists. ", FAIL, "Quicken doesn't exist.")
	[ ] // 
[ ] // //##########################################################################
[ ] // 
[+] // //#############verify Sending Invoice to Clipboard.######################################
	[ ] // // ********************************************************
	[+] // // TestCase Name: Test09_SendingInvoicetoClipboard() 
		[ ] // //
		[ ] // // DESCRIPTION:
		[ ] // 
		[ ] // // This testcase will verify Sending Invoice to Clipboard.
		[ ] // //.
		[ ] // //
		[ ] // // PARAMETERS:		None
		[ ] // //
		[ ] // // RETURNS:			        Pass 		              If verification of content is correct					
		[ ] // //						Fail		             If any error occurs
		[ ] // // 
		[ ] // //REVISION HISTORY:	
		[ ] // // 10 June 2013        	Created by	Anagha Bhandare
		[ ] // //							
	[ ] // // ********************************************************
[+] // testcase Test09_SendingInvoicetoClipboard() appstate none
	[ ] // // Variable Declarations
	[ ] // 
	[ ] // STRING sDialogName,sMessage
	[ ] // LIST OF STRING lsAccount
	[ ] // 
	[ ] // 
	[ ] // // Variable Definition
	[ ] // sRegisterExcel = "BusinessTestData"
	[ ] // sAccWorksheet = "BusinessTransaction"
	[ ] // sMessage = "The form has been copied to the clipboard"
	[ ] // 
	[+] // //Retrieving Banking Data from Excel sheet 
		[ ] // lsExcelData=ReadExcelTable(sRegisterExcel, sAccWorksheet)
		[ ] // lsAccount=lsExcelData[1]
		[ ] // sPayee=lsAccount[6]
	[ ] // 
	[ ] // 
	[ ] // 
	[+] // if (QuickenWindow.Exists(5))
		[ ] // 
		[ ] // QuickenWindow.SetActive()
		[ ] // 
		[ ] // //Opening Business Account Register
		[ ] // iOpenAccountRegister=SelectAccountFromAccountBar(lsAccount[2],ACCOUNT_BUSINESS)
		[ ] // 
		[+] // if(iOpenAccountRegister==PASS)
			[ ] // 
			[ ] // ReportStatus("Verify Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] // 
			[ ] // iResult = FindTransaction(sWindowType,sPayee)
			[ ] // 
			[+] // if(iResult==PASS)
				[ ] // 
				[ ] // ReportStatus("Verify Customer Invoice transactions selected",PASS ,"Customer Invoice transaction got selected successfully")
				[ ] // 
				[ ] // //iResult=AccountActionsOnTransaction(sPayee,sAction)
				[ ] // 
				[ ] // QuickenWindow.TypeKeys(KEY_CTRL_S)
				[ ] // 
				[+] // if (DlgInvoice.Exists(5))
					[ ] // 
					[ ] // DlgInvoice.SetActive()
					[ ] // 
					[ ] // ReportStatus("Verify Customer Invoice form",PASS ,"Customer Invoice form is displayed")
					[ ] // 
					[+] // if(DlgInvoice.EMailSendToClipboardButton.Exists(5))
						[ ] // 
						[ ] // ReportStatus("Verify EMail Send To Clipboard Button on Create Vendor Invoice window ", PASS , "EMail Send To Clipboard Button on Create Customer Invoice window is present")
						[ ] // 
						[ ] // DlgInvoice.SetActive()
						[ ] // 
						[ ] // DlgInvoice.EMailSendToClipboardButton.Click()
						[ ] // 
						[+] // if(DlgInvoice.DlgSendInvoiceByEMail.Exists(5))
							[ ] // 
							[ ] // ReportStatus("Verify Send Invoice By Email Dialog",PASS ,"Send Invoice By Email Dialog is displayed")
							[ ] // 
							[+] // if(DlgInvoice.DlgSendInvoiceByEMail.FormatRadioList.Exists(5))
								[ ] // ReportStatus("Verify Format radio list",PASS,"Format radio list is displayed")
								[ ] // DlgInvoice.DlgSendInvoiceByEMail.SetActive()
								[ ] // DlgInvoice.DlgSendInvoiceByEMail.FormatRadioList.TypeKeys(KEY_DN)
								[ ] // DlgInvoice.DlgSendInvoiceByEMail.Send1RadioList.TypeKeys(KEY_UP)
								[ ] // 
								[+] // if(DlgInvoice.DlgFormToClipBoard.Exists(5))
									[ ] // ReportStatus("Verify Form to ClipBoard window",PASS,"Form to ClipBoard window is present")
									[ ] // 
									[ ] // sDialogName=DlgInvoice.DlgFormToClipBoard.TheFormText.GetText()
									[ ] // bMatch = MatchStr(sDialogName,"*{sMessage}*")
									[ ] // 
									[+] // if(bMatch==TRUE)
										[ ] // 
										[ ] // ReportStatus("Verify Form to ClipBoard has copied",PASS,"Form to ClipBoard has got copied successfully")
									[+] // else
										[ ] // ReportStatus("Verify Form to ClipBoard has copied",FAIL,"Form to ClipBoard has not got copied successfully")
									[ ] // 
									[ ] // DlgInvoice.DlgFormToClipBoard.OKButton.Click()
								[+] // else
									[ ] // ReportStatus("Verify Form to ClipBoard window",FAIL,"Form to ClipBoard window is not present")
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Verify Format radio list",FAIL,"Format radio list is not displayed")
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Verify Send Invoice By Email Dialog",FAIL ,"Send Invoice By Email Dialog is not displayed")
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Verify EMail Send To Clipboard Button on Create Vendor Invoice window ", FAIL , "EMail Send To Clipboard Button on Create Customer Invoice window is not present")
					[ ] // 
					[ ] // DlgInvoice.CancelButton.Click()
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify Customer Invoice form",FAIL ,"Customer Invoice form is not displayed")
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Verify Customer Invoice transactions added",FAIL ,"Customer Invoice transaction not got added successfully")
		[+] // else
			[ ] // ReportStatus("Verify Account is selected from AccountBar", FAIL , "Account is not selected from AccountBar")
	[+] // else
		[ ] // ReportStatus("Verify Quicken exists. ", FAIL, "Quicken doesn't exist.")
	[ ] // 
[ ] // //#########################################################################
[ ] // 
[ ] // 
[ ] // 
[ ] // 
