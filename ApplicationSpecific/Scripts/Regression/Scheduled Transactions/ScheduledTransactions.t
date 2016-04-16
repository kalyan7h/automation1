[ ] // *********************************************************
[+] // FILE NAME:	<ScheduledTransactions.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Scheduled Transactions and Bills test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	
	[ ] //
	[ ] // Developed on: 
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 21, 2010	Udita Dube  Created
[ ] // *********************************************************
[ ] 
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
	[ ] 
	[ ] 
	[ ] //STRING
	[ ] public STRING sCaption,sReminderType,sActual,sHandle,sActualName,sAccountName, sCategoryName, sAmount, sTransactionAmount, sTransactionType,sCompare,sBillStatus
	[ ] 
	[ ] 
	[ ] public STRING sFileName = "Scheduled_Transactions"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sOnlineFileName = "Scheduled_Transactions_OBP"
	[ ] public STRING sOnlineDataFile = AUT_DATAFILE_PATH + "\" + sOnlineFileName + ".QDF"
	[ ] public STRING sOriginalFile = AUT_DATAFILE_PATH + "\Original_Scheduled_Transaction_OBP\" + sOnlineFileName + ".QDF"
	[ ] public STRING sPayeeName = "ST_Payee"
	[ ] public STRING sAccountType = "Banking"
	[ ] public STRING sWindowTypeMDI="MDI"
	[ ] 
	[ ] public STRING sDateFormat="m/d/yyyy"
	[ ] 
	[ ] 
	[ ] public STRING sDateStamp = FormatDateTime (GetDateTime(), sDateFormat)
	[ ] 
	[ ] INTEGER iListCount, iCount
	[ ] //xls
	[ ] public STRING sExcelDataFile="Scheduled_Transaction"
	[ ] //Excel Data Sheet
	[ ] public STRING sCheckingTransactionWorksheet="TransactionPaymentBills"
	[ ] public STRING sCheckingTransactionWorksheet1="TransactionDepositIncome"
	[ ] public STRING sAccountWorksheet="Account"
	[ ] public STRING sTransactionWorksheet="TransactionSheet"
	[ ] 
	[ ] 
	[ ] 
	[ ] //LIST OF STRING
	[ ] public LIST OF STRING lsTransactionData,lsCompare
	[ ] public LIST OF STRING lsBusAccType = {"Accounts Payable","Accounts Receivable"}  
	[ ] 
	[ ] 
	[ ] //LIST OF ANYTYPE
	[ ] public LIST OF ANYTYPE lsExcelData
	[ ] public LIST OF STRING IsAddAccount = {"Checking", "Checking 01 Account","100",sDateStamp,"Personal Transactions"}
	[ ] public LIST OF STRING IsAddAccount1 = {"Savings", "Savings 01 Account","500",sDateStamp,"Personal Transactions"}
	[ ] public LIST OF STRING IsAddAccount2 = {"Credit Card", "Credit Card 01 Account","500",sDateStamp,"Personal Transactions"}
	[ ] public LIST OF STRING lsAddAccount3={"Accounts Payable","Vendor Invoices"}
	[ ] public LIST OF STRING lsAddAccount4={"Accounts Receivable","Customer Invoices"}
	[ ] public List OF ANYTYPE lsAddInvoice={sPayeeName,NULL, NULL, "BillTo" ,"ShipTo", "Item1", "Auto Payment","Description","15","5"}
	[ ] 
	[ ] 
	[ ] //INTEGER
	[ ] public INTEGER iValidate,i,j
	[ ] 
	[ ] 
	[ ] //BOOLEAN
	[ ] public BOOLEAN bCaption,bExists,bMatch,bCheckStatus
	[ ] 
	[ ] STRING sDeleteCommand="Delete"
	[ ] STRING sGetStarted = "Get Started"
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[+] //#############  TC01_No_Active_Account #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC01_No_Active_Account()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the ScheduledTransaction.QDF if it exists. 
		[ ] // This test case will also verify that appropriate validation message is getting displayed if data file does not have any active account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while deleting file and appropriate validation message is gets displayed
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 08, 2013		Suyash Joshi	created
	[ ] // ********************************************************
	[ ] 
[+] testcase TC01_No_Active_Account () appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration and definition
		[ ] INTEGER iRegistration
		[ ] STRING sActualMessage,sExpectedMessage
		[ ] List of List of STRING lsAccount
		[ ] 
		[ ] sExpectedMessage = "No accounts exist. Please create an account before creating a reminder."
		[ ] 
	[ ] 
	[ ] 
	[+] // if(QuickenMainWindow.Exists(5))
		[ ] // QuickenWindow.SetActive()
	[+] // else
		[+] // if(FileExists(sDataFile) == TRUE)
			[ ] // DeleteFile(sDataFile)
			[ ] // 
		[ ] // QuickenMainWindow.Start (sCmdLine)
		[ ] // 
	[ ] // // Check for already opened data file
	[ ] // sCaption = QuickenMainWindow.GetCaption()
	[ ] // bCaption = MatchStr("*{sFileName}*", sCaption)
	[+] // if(bCaption == FALSE)
		[ ] // bExists = FileExists(sDataFile)
		[+] // if(bExists == TRUE)
			[ ] // DeleteFile(sDataFile)
			[ ] // 
	[ ] 
	[ ] // Create Data File
	[ ] iValidate = DataFileCreate(sFileName)
	[ ] 
	[ ] // Report Staus If Data file Created successfully
	[+] if ( iValidate  == PASS)
		[ ] ReportStatus("Validate Data File ", iValidate, "Data file -  {sDataFile} is created")
		[ ] 
		[ ] 
		[ ] 
		[ ] // Set Classic View
		[ ] SetViewMode(VIEW_CLASSIC_MENU)
		[ ] // Bypass Registration
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Bills.Click()
		[ ] sleep(1)
		[ ] QuickenWindow.Bills.AddReminder.Click()
		[ ] sleep(1)
		[ ] QuickenWindow.Bills.AddReminder.BillReminder.Select()
		[ ] 
		[ ] 
		[+] if(AlertMessage.Exists(5))
			[ ] AlertMessage.SetActive()
			[ ] sActualMessage=AlertMessage.MessageText.GetText()
			[ ] //.NoAccountMessage.GetText()
			[ ] bCaption = MatchStr("*{sActualMessage}*", sExpectedMessage)
			[+] if(bCaption == TRUE)
				[ ] ReportStatus("Verify validation message", PASS, "Validation message: {sActualMessage} is displayed") 
			[+] else
				[ ] ReportStatus("Verify validation message", PASS, "Wrong validation message: {sActualMessage} is displayed, {sExpectedMessage} message was expected")  
			[ ] AlertMessage.OK.Click()
		[+] else
			[ ] ReportStatus("Verify validation message", FAIL, "No validation message is displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", iValidate, "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] 
[+] //############# TC02_GetStarted_NO_Account ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC02_GetStarted_NO_Account()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify if user clicks on 'Get Started' button on bills tab when no active account exists in a data file then Quicken will launch add account flow.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while deleting file and appropriate validation message is gets displayed
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 08, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC02_GetStarted_NO_Account() appstate none
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] ExpandAccountBar()
		[ ] sleep(1)
		[ ] NavigateQuickenTab(sTAB_BILL)
		[ ] 
		[+] if(GetStartedBrowserWindow.GetStarted.Exists(5))
			[ ] GetStartedBrowserWindow.GetStarted.Click()
			[ ] //Verify that add account flow is launched from 'Get Started' button
			[+] if(AddAccount.Exists(4))
				[ ] AddAccount.Close()
				[ ] ReportStatus("Add Account flow  ", PASS, "Add Account flow is launched from 'Get Started' button ")
			[+] else
				[ ] ReportStatus("Add Account flow  ", FAIL, "Add Account flow is not launched from 'Get Started' button")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify bills tab Get Started button exists ", FAIL, "Verify bills tab Get Started button doesn't exist.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window", FAIL, "Quicken Main window is missing.")
[ ] //###########################################################################
[ ] 
[+] //############# TC03_ReminderLaunchingPoints() #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC03_ReminderLaunchingPoints()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify different invoking points for add a reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 11, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC03_ReminderLaunchingPoints() appstate none
	[ ] 
	[ ] STRING sHomeSetupText="Set up"
	[ ] STRING sListText="Add a bill or income reminder."
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Add a manual checking account.
		[ ] iValidate=AddManualSpendingAccount(IsAddAccount[1],IsAddAccount[2],IsAddAccount[3],IsAddAccount[4])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Manual Checking Account ", PASS, "Manual checking account is added")
			[ ] 
			[ ] SetViewMode(VIEW_CLASSIC_MENU)
			[ ] 
			[ ] //Enable Business tab
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.View.Click()
			[ ] QuickenWindow.View.TabsToShow.Click()
			[+] if (!QuickenWindow.View.TabsToShow.Business.IsChecked)
				[ ] QuickenWindow.View.TabsToShow.Business.Select()
			[ ] QuickenWindow.TypeKeys(KEY_ESC)
			[ ] 
			[+] //Verify that 'Add Bill Reminder' dialog will be launched from Home tab->Get Started Button.
				[ ] sActualName = "Add Bill Reminder"
				[ ] NavigateQuickenTab(sTAB_HOME)
				[ ] sleep(2)
				[ ] MDIClient.Home.VScrollBar.ScrollToMax()
				[ ] sleep(1)
				[ ] 
				[ ] MDIClient.Home.TextClick(sGetStarted)
				[ ] //GetStarted.Click()
				[+] if (StayOnTopOfMonthlyBills.Exists(5))
					[ ] StayOnTopOfMonthlyBills.SetActive()
					[ ] StayOnTopOfMonthlyBills.AddABill.Click()
					[ ] iValidate=VerifyReminderDialog(sActualName)
					[+] if(iValidate ==PASS)
						[ ] ReportStatus("Add Bill Reminder flow  ", PASS, "Add Bill Reminder flow is launched from Stay on Top of your monthly Bills- Get Started Button")
					[+] else
						[ ] ReportStatus("Add Bill Reminder flow  ", FAIL, "Add Bill Reminder flow is NOT launched from Stay on Top of your monthly Bills- Get Started Button")
					[ ] DlgAddEditReminder.Close()
					[ ] WaitForState(DlgAddEditReminder , FALSE ,5)
					[ ] StayOnTopOfMonthlyBills.SetActive()
					[ ] StayOnTopOfMonthlyBills.Close()
					[ ] WaitForState(StayOnTopOfMonthlyBills , FALSE ,5)
				[+] else
					[ ] ReportStatus("Verify dialog Stay On Top Of Monthly Bills appeared." , FAIL , "Dialog Stay On Top Of Monthly Bills didn't appear.")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[+] //Verify that 'Add Reminder' dialog will be launched from Home tab->Setup hyperlink.
				[ ] sActualName = "Add Reminder"
				[ ] MDIClient.Home.VScrollBar.ScrollToMax()
				[ ] sleep(1)
				[ ] 
				[ ] MDIClient.Home.TextClick(sGetStarted)
				[ ] // MDIClient.Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.GetStarted.Click()
				[ ] StayOnTopOfMonthlyBills.SetActive()
				[ ] //StayOnTopOfMonthlyBills.LetSTakeALookAtTheBills.ListBox1.Click(1,76,7)
				[ ] StayOnTopOfMonthlyBills.LetSTakeALookAtTheBills.ListBox1.TextClick(sHomeSetupText)
				[ ] 
				[ ] 
				[ ] iValidate=VerifyReminderDialog(sActualName)
				[+] if(iValidate ==PASS)
					[ ] ReportStatus("Add Bill Reminder flow  ", PASS, "Add Bill Reminder flow is launched from Stay on Top of your monthly Bills- Setup hyperlink")
				[+] else
					[ ] ReportStatus("Add Bill Reminder flow  ", FAIL, "Add Bill Reminder flow is NOT launched from Stay on Top of your monthly Bills- Setup hyperlink")
				[ ] DlgAddEditReminder.Close()
				[ ] StayOnTopOfMonthlyBills.Close()
			[ ] sleep(2)
			[ ] 
			[+] //Verify that 'Add Bill Reminder' dialog will be launched from upcoming tab.
				[ ] sActualName = "Add Bill Reminder"
				[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
				[ ] sleep(2)
				[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
				[ ] 
				[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
				[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
				[ ] iValidate =VerifyReminderDialog(sActualName)
				[+] if(iValidate ==PASS)
					[ ] ReportStatus("Add Bill Reminder flow  ", PASS, "Add Bill Reminder flow is launched from Upcoming tab")
				[+] else
					[ ] ReportStatus("Add Bill Reminder flow  ", FAIL,  "Add Bill Reminder flow is NOT launched from Upcoming tab")
				[ ] DlgAddEditReminder.Close()
				[ ] 
			[ ] sleep(2)
			[ ] 
			[+] //Verify that 'Add Bill Reminder' dialog will be launched from Bills menu.
				[ ] 
				[ ] sActualName = "Add Bill Reminder"
				[ ] 
				[ ] QuickenWindow.Bills.Click()
				[ ] QuickenWindow.Bills.AddReminder.Click()
				[ ] QuickenWindow.Bills.AddReminder.BillReminder.Select()
				[ ] 
				[ ] iValidate =VerifyReminderDialog(sActualName)
				[+] if(iValidate ==PASS)
					[ ] ReportStatus("Add Bill Reminder flow  ", PASS, "Add Bill Reminder flow is launched from Bills menu")
				[+] else
					[ ] ReportStatus("Add Bill Reminder flow  ", FAIL, "Add Bill Reminder flow is NOT launched from Bills menu")
				[ ] DlgAddEditReminder.Close()
			[ ] sleep(2)
			[ ] 
			[+] //Verify that 'Add Bill Reminder' dialog will be launched from Business tab->Add Reminder button.
				[ ] sActualName = "Add Bill Reminder"
				[ ] 
				[ ] 
				[ ] NavigateQuickenTab(sTAB_BUSINESS)
				[ ] AddReminderButton.Click()
				[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
				[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
				[ ] iValidate =VerifyReminderDialog(sActualName)
				[+] if(iValidate ==PASS)
					[ ] ReportStatus("Add Bill Reminder flow  ", PASS, "Add Bill Reminder flow is launched from Business- Profit and Loss - Add Reminder button")
				[+] else
					[ ] ReportStatus("Add Bill Reminder flow  ", FAIL, "Add Bill Reminder flow is NOT launched from Business- Profit and Loss - Add Reminder button")
				[ ] DlgAddEditReminder.Close()
				[ ] 
			[ ] sleep(2)
			[ ] 
			[+] //Verify that 'Add Bill Reminder' dialog will be launched from Business tab->Add a bill or income reminder hyperlink.
				[ ] sActualName = "Add Reminder"
				[ ] 
				[ ] 
				[ ] NavigateQuickenTab(sTAB_BUSINESS)
				[ ] BusinessRemindersList.TextClick(sListText)
				[ ] 
				[ ] 
				[ ] //AddReminderButton.Click()
				[ ] iValidate =VerifyReminderDialog(sActualName)
				[+] if(iValidate ==PASS)
					[ ] ReportStatus("Add Bill Reminder flow  ", PASS, "Add Bill Reminder flow is launched from Business- Profit and Loss - Add a bill or income reminder hyperlink")
				[+] else
					[ ] ReportStatus("Add Bill Reminder flow  ", FAIL, "Add Bill Reminder flow is NOT launched from Business- Profit and Loss - Add a bill or income reminder hyperlink")
				[ ] DlgAddEditReminder.Close()
				[ ] 
			[ ] sleep(2)
			[ ] 
			[+] //Verify that 'Add Bill Reminder' dialog will be launched from Rental Property tab->Add Reminder button.
				[ ] sActualName = "Add Bill Reminder"
				[ ] 
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
				[ ] AddReminderButton.Click()
				[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
				[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
				[ ] iValidate =VerifyReminderDialog(sActualName)
				[+] if(iValidate ==PASS)
					[ ] ReportStatus("Add Bill Reminder flow  ", PASS, "Add Bill Reminder flow is launched from Rental Property tab->Add Reminder button")
				[+] else
					[ ] ReportStatus("Add Bill Reminder flow  ", FAIL, "Add Bill Reminder flow is NOT launched from Rental Property tab->Add Reminder button")
				[ ] DlgAddEditReminder.Close()
			[ ] sleep(2)
			[ ] 
			[+] //Verify that 'Add Bill Reminder' dialog will be launched from Rental Property tab->Add a bill or income reminder hyperlink.
				[ ] sActualName = "Add Reminder"
				[ ] 
				[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
				[ ] BusinessRemindersList.TextClick(sListText)
				[ ] 
				[ ] iValidate =VerifyReminderDialog(sActualName)
				[+] if(iValidate ==PASS)
					[ ] ReportStatus("Add Bill Reminder flow  ", PASS, "Add Bill Reminder flow is launched from Rental Property- Profit and Loss - Add a bill or income reminder hyperlink")
				[+] else
					[ ] ReportStatus("Add Bill Reminder flow  ", FAIL, "Add Bill Reminder flow is NOT launched from Rental Property- Profit and Loss - Add a bill or income reminder hyperlink")
				[ ] DlgAddEditReminder.Close()
				[ ] 
			[ ] sleep(2)
			[ ] 
			[+] //Verify that 'Add Bill Reminder' dialog will be launched from Manage Reminders dialog.
				[ ] sActualName = "Add Reminder"
				[ ] 
				[ ] QuickenWindow.Bills.Click()
				[ ] QuickenWindow.Bills.ManageBillIncomeReminders.Select()
				[+] if (DlgManageReminders.Exists(5))
					[ ] DlgManageReminders.SetActive()
					[ ] DlgManageReminders.TypeKeys(KEY_ALT_W)
					[ ] DlgManageReminders.TypeKeys(KEY_DN)
					[ ] DlgManageReminders.TypeKeys(KEY_ENTER)
					[ ] 
					[ ] iValidate =VerifyReminderDialog(sActualName)
					[+] if(iValidate ==PASS)
						[ ] ReportStatus("Add Bill Reminder flow  ", PASS, "Add Bill Reminder flow is launched from Manage Reminders dialog")
					[+] else
						[ ] ReportStatus("Add Bill Reminder flow  ", FAIL, "Add Bill Reminder flow is NOT launched from Manage Reminders dialog")
					[ ] DlgAddEditReminder.Close()
					[ ] DlgManageReminders.Close()
				[+] else
					[ ] ReportStatus("Manage Reminder dialog ", FAIL, "Manage Reminder dialog is not launched.")
				[ ] 
			[ ] sleep(2)
			[ ] 
			[+] //Verify that 'Add Bill Reminder' dialog will be launched from C2R window->Add Reminder button.
				[ ] sActualName = "Add Bill Reminder"
				[ ] iValidate=SetC2RMode("ON")
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Turn ON C2R",iValidate,"C2R mode is turned ON")
					[ ] iValidate = AccountBarSelect(ACCOUNT_BANKING, 1)
					[ ] sleep(3)
					[ ] C2RReminders.C2RText.QWinChild.BillandIncomeRemindersTab.Click()
					[ ] 
					[ ] C2RReminders.QWSnapHolder1.StaticText1.StaticText2.AddReminderButton.Click()
					[ ] //AddReminderButton.Click()
					[ ] 
					[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
					[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
					[ ] iValidate =VerifyReminderDialog(sActualName)
					[+] if(iValidate ==PASS)
						[ ] ReportStatus("Add Bill Reminder flow  ", PASS, "Add Bill Reminder flow is launched from C2R window->Add Reminder button")
					[+] else
						[ ] ReportStatus("Add Bill Reminder flow  ", FAIL, "Add Bill Reminder flow is NOT launched from C2R window->Add Reminder button")
					[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Turn ON C2R",iValidate,"C2R mode is turned off")
			[ ] sleep(2)
			[ ] 
			[+] //Verify that 'Add Bill Reminder' dialog will be launched from C2R window->Add a bill or income reminder hyperlink.
				[ ] sActualName = "Add Reminder"
				[ ] ReportStatus("Turn ON C2R",iValidate,"C2R mode is turned ON")
				[ ] iValidate = AccountBarSelect(ACCOUNT_BANKING, 1)
				[ ] C2RReminders.C2RText.QWinChild.BillandIncomeRemindersTab.Click()
				[ ] sleep(1)
				[ ] C2RReminders.QWSnapHolder1.StaticText1.QWHtmlView.Click(1,320,40)
				[ ] iValidate =VerifyReminderDialog(sActualName)
				[+] if(iValidate ==PASS)
					[ ] ReportStatus("Add Bill Reminder flow  ", PASS, "Add Bill Reminder flow is launched from C2R window->Add a bill or income reminder hyperlink")
				[+] else
					[ ] ReportStatus("Add Bill Reminder flow  ", FAIL, "Add Bill Reminder flow is NOT launched from C2R window->Add a bill or income reminder hyperlink")
				[ ] DlgAddEditReminder.Close()
				[ ] 
			[ ] sleep(2)
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Manual Checking Account ", FAIL, "Manual checking account is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window", FAIL, "Quicken Main window is missing.")
[ ] //###########################################################################
[ ] 
[+] //############# TC04_ManageReminderLaunchingpoints() ###########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC04_ManageReminderLaunchingpoints()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify different invoking points for manage reminder dialog.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 13, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC04_ManageReminderLaunchingpoints() appstate none
	[ ] 
	[+] //Variable Declaration and defination
		[ ] boolean bCheckStatus
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[+] //Verify that 'Manage Reminder' dialog will be launched from upcoming tab.
			[ ] 
			[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.QWNavigator.ManageReminders.Click()
			[ ] 
			[+] if (DlgManageReminders.Exists(5))
				[ ] iValidate=PASS
			[+] else
				[ ] iValidate=FAIL
			[ ] 
			[+] if(iValidate ==PASS)
				[ ] ReportStatus("Manage Reminder dialog  ", PASS, "Manage Reminder dialog is launched from upcoming tab")
			[+] else
				[ ] ReportStatus("Manage Reminder dialog  ", FAIL, "Manage Reminder dialog is NOT launched from upcoming tab")
			[ ] DlgManageReminders.Close()
			[ ] 
		[ ] 
		[+] //Verify that 'Manage Reminder' dialog will be launched from C2R window->Manage Reminder button.
			[ ] QuickenWindow.SetActive()
			[ ] AccountBarSelect(ACCOUNT_BANKING, 1)
			[ ] C2RReminders.C2RText.QWinChild.BillandIncomeRemindersTab.Click()
			[ ] C2RReminders.QWSnapHolder1.StaticText1.StaticText2.ManageReminderButton.Click()
			[+] if (DlgManageReminders.Exists(5))
				[ ] iValidate=PASS
			[+] else
				[ ] iValidate=FAIL
			[ ] 
			[ ] 
			[+] if(iValidate ==PASS)
				[ ] ReportStatus("Manage Reminder dialog  ", PASS, "Manage Reminder dialog is launched from C2R window->Manage Reminder button")
			[+] else
				[ ] ReportStatus("Manage Reminder dialog  ", FAIL, "Manage Reminder dialog is NOT launched from C2R window->Manage Reminder button")
			[+] DlgManageReminders.Close()
				[ ] 
		[ ] 
		[+] //Verify that 'Manage Reminder' dialog will be launched from Business tab->Manage Reminder button.
			[ ] 
			[ ] NavigateQuickenTab(sTAB_BUSINESS)
			[ ] QuickenWindow.SetActive()
			[ ] ManageReminderButton.Click()
			[ ] 
			[+] if (DlgManageReminders.Exists(5))
				[ ] ReportStatus("Manage Reminder dialog  ", PASS, "Manage Reminder dialog is launched from Business tab- Profit and Loss-Manage Reminder button")
				[ ] DlgManageReminders.SetActive()
				[ ] DlgManageReminders.Close()
			[+] else
				[ ] ReportStatus("Manage Reminder dialog  ", FAIL, "Manage Reminder dialog is NOT launched from Business tab- Profit and Loss-Manage Reminder button")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[+] //Verify that 'Manage Reminder' dialog will be launched from Rental Property tab->Manage Reminder button.
			[ ] 
			[ ] NavigateQuickenTab(sTAB_RENTAL_PROPERTY,sTAB_PROFIT_LOSS)
			[ ] QuickenWindow.SetActive()
			[ ] ManageReminderButton.Click()
			[+] if (DlgManageReminders.Exists(5))
				[ ] ReportStatus("Manage Reminder dialog  ", PASS, "Manage Reminder dialog is launched from Rental Property tab- Profit and Loss- Add Reminder button")
				[ ] DlgManageReminders.SetActive()
				[ ] DlgManageReminders.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Manage Reminder dialog  ", FAIL, "Manage Reminder dialog is NOT launched from Rental Property tab- Profit and Loss- Add Reminder button")
		[ ] 
		[+] //Verify that 'Manage Reminder' dialog will be launched using CTRL+J.
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
			[ ] 
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.SetActive()
				[ ] DlgManageReminders.Close()
				[ ] 
				[ ] ReportStatus("Manage Reminder dialog  ", PASS, "Manage Reminder dialog is launched using CTRL+J button")
			[+] else
				[ ] ReportStatus("Manage Reminder dialog  ", FAIL, "Manage Reminder dialog is NOT launched using CTRL+J button")
		[ ] 
		[+] //Verify that 'Manage Reminder' dialog will be launched from Bills menu.
			[ ] 
			[ ] SetViewMode(VIEW_CLASSIC_MENU)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Bills.Click()
			[ ] QuickenWindow.Bills.ManageBillIncomeReminders.Select()
			[ ] 
			[+] if (DlgManageReminders.Exists(5))
				[ ] ReportStatus("Manage Reminder dialog  ", PASS, "Manage Reminder dialog is launched from Bills menu")
				[ ] DlgManageReminders.SetActive()
				[ ] DlgManageReminders.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Manage Reminder dialog  ", FAIL, "Manage Reminder dialog is NOT launched using Bills menu")
			[ ] 
		[ ] 
		[+] //Verify that 'Manage Reminder' dialog will be launched from Calendar dialog.
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_K)
			[+] if (Calendar.Exists(5))
				[ ] Calendar.SetActive()
				[ ] ReportStatus("Calendar dialog  ", PASS, "Calendar dialog is launched using CTRL+K button")
				[ ] 
				[ ] ManageReminderButton.Click()
				[ ] 
				[+] if (DlgManageReminders.Exists(5))
					[ ] ReportStatus("Manage Reminder dialog  ", PASS, "Manage Reminder dialog is launched from Calendar dialog")
					[ ] DlgManageReminders.SetActive()
					[ ] DlgManageReminders.Close()
					[ ] 
				[+] else
					[ ] ReportStatus("Manage Reminder dialog  ", FAIL, "Manage Reminder dialog is NOT launched from Calendar dialog")
				[ ] 
				[ ] Calendar.SetActive()
				[ ] Calendar.Close()
			[+] else
				[ ] ReportStatus("Calendar dialog  ", FAIL, "Calendar dialog is NOT launched using CTRL+K button")
				[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window", FAIL, "Quicken Main window is missing.")
[ ] //###########################################################################
[ ] 
[+] //###############TC05_BillReminderFirstScreen() #################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	 TC05_BillReminderFirstScreen() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify UI controls Present on Add Bill Reminder First screen
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If UI controls are present on the Add Reminder Dialog
		[ ] //				        Fail		   If any of the UI control is not present
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 08, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC05_BillReminderFirstScreen() appstate none
	[+] //Variable defination
		[ ] i = 1 // For selecting Bill Reminder First option
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_BILL)
		[+] if(QuickenMainWindow.QWNavigator.AddReminder.Exists(5))
			[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
			[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(Replicate(KEY_DN, i)) 
			[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] 
			[ ] //Verifying whether "Add Bill Reminder" dialog exist with proper Caption.
			[+] if(DlgAddEditReminder.Exists(5))
					[ ] ReportStatus("Verify Add Bill Reminder dialog exists", PASS , "Add Bill Reminder Dialog is present")
					[ ] sCaption=DlgAddEditReminder.GetProperty("Caption")
					[ ] 
				[+] if(sCaption=="Add Bill Reminder")
					[ ] ReportStatus("Verify 'Add Bill Reminder' Caption on dialog", PASS , "'Add Bill Reminder' Caption is present on Add Bill Reminder Dialog  ")
				[+] else
					[ ] ReportStatus("Verify 'Add Bill Reminder' Caption on dialog", FAIL , "'Add Bill Reminder' Caption is not present on Add Bill Reminder Dialog  ")
					[ ] 
					[ ] 
				[ ] 
				[+] //verify UI controls on Add Bill Reminder Dialog First Screen
					[+] //Verifying Pay to Textbox  is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.Exists(5))
							[ ] ReportStatus("Verify Pay to Textbox on Add Bill Reminder Dialog", PASS , "Pay to textbox is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify Pay to Textbox on Add Bill Reminder Dialog", FAIL , "Pay to textbox is not present on Add Bill Reminder Dialog")
					[ ] 
					[+] //Verifying Cancel Button is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.CancelButton.Exists(5))
							[ ] ReportStatus("Verify Cancel Button on Add Bill Reminder Dialog", PASS , "Cancel button is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify Cancel Button on Add Bill Reminder Dialog", FAIL , "Cancel button is not present on Add Bill Reminder Dialog")
					[ ] 
					[+] //Verifying Next Button is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.NextButton.Exists(5))
							[ ] ReportStatus("Verify Next Button on Add Bill Reminder Dialog", PASS , "Next button is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify Next Buttonon Add Bill Reminder Dialog", FAIL , "Next button is not present on Add Bill Reminder Dialog")
					[ ] 
					[+] //Verifying Help Button is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.HelpButton.Exists(5))
							[ ] ReportStatus("Verify Help Button on Add Bill Reminder Dialog", PASS , "Help button is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify Help Button on Add Bill Reminder Dialog", FAIL , "Help button is not present on Add Bill Reminder Dialog")
				[ ] 
				[ ] DlgAddEditReminder.Close()
			[+] else
					[ ] ReportStatus("Verify Add Bill Reminder dialog exists", FAIL , "Add Bill Reminder Dialog is not present")
					[ ] 
		[+] else 
			[ ] ReportStatus("Verify Upcoming from Bills Menu", FAIL , "Upcoming is not available as Add Reminder Button is not displayed")
			[ ] 
	[+] else
		[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] 
[+] //###############TC06_BillReminderSecondScreen() ##############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	 TC06_BillReminderSecondScreen()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify UI controls Present on Add Bill Reminder second screen
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If UI controls are present on the Add Reminder Dialog
		[ ] //				        Fail		   If any of the UI control is not present
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 08, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC06_BillReminderSecondScreen() appstate none
	[+] // Variable declaration and definition
		[ ] sReminderType="Bill"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] 
				[+] //verifying whether all UI controls are present on Add Bill Reminder on Second Screen
					[ ] 
					[+] //Verifying whether Due Next On is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.Exists(5))
							[ ] ReportStatus("Verify whether 'Due Next On Textbox' on Add Bill Reminder Dialog ", PASS , "Due Next On Textbox is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify 'Due Next On Textbox' on Add Bill Reminder Dialog", FAIL , "Due Next On Textbox is not present on Add Bill Reminder Dialog")
					[ ] 
					[+] //Verifying whether Due Date Change link is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Exists(5))
							[ ] ReportStatus("Verify Due Date Change link on Add Bill Reminder Dialog", PASS , "Change link is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify Due Date Change link on Add Bill Reminder Dialog", FAIL , "Change link is not present on Add Bill Reminder Dialog")
					[ ] 
					[+] //Verifying whether Amount Due TextField is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.Exists(5))
							[ ] ReportStatus("Verify Amount Due TextField on Add Bill Reminder Dialog", PASS , "AmountDue TextField is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify Amount Due TextField  on Add Bill Reminder Dialog", FAIL , "AmountDue TextField is not present on Add Bill Reminder Dialog")
					[ ] 
					[+] //Verifying whether From Account TextField is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.Exists(5))
							[ ] ReportStatus("Verify FromAccount TextField on Add Bill Reminder Dialog", PASS , "FromAccount Textbox is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify FromAccount TextField on Add Bill Reminder Dialog", FAIL , "FromAccount Textbox is not present on Add Bill Reminder Dialog")
						[ ] 
					[ ] 
					[+] //Verifying whether From Details Text is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DetailsText.Exists(5))
							[ ] ReportStatus("Verify Details Text on Add Bill Reminder Dialog", PASS , "Details  Text is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify Details Text on Add Bill Reminder Dialog", FAIL , "Details Text is not present on Add Bill Reminder Dialog")
					[ ] 
					[+] //Verifying whether Add Category Tag Or Memo is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Exists(5))
							[ ] ReportStatus("Verify AddCategoryTagOrMemo Panel on Add Bill Reminder Dialog", PASS , "AddCategoryTagOrMemo Panel  is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify AddCategoryTagOrMemo Panel on Add Bill Reminder Dialog", FAIL , "AddCategoryTagOrMemo Panel  is not present on Add Bill Reminder Dialog")
					[ ] 
					[+] //Verifying whether Optional Settings Panel is available on Add Bill Reminder Dialog
						[ ] //DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
						[ ] 
						[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Exists(5))
							[ ] ReportStatus("Verify OptionalSettings on Add Bill Reminder Dialog", PASS , "OptionalSettings is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify OptionalSettings on Add Bill Reminder Dialog", FAIL , "OptionalSettings is not present on Add Bill Reminder Dialog")
					[ ] 
					[+] //Verifying whether Back Button is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.BackButton.Exists(5))
							[ ] ReportStatus("Verify Back Button on Add Bill Reminder Dialog", PASS , "Back Button is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify Back Button on Add Bill Reminder Dialog", FAIL , "Back Button is not present on Add Bill Reminder Dialog")
							[ ] 
					[ ] 
					[+] //Verifying whether Done Button is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.DoneButton.Exists(5))
							[ ] ReportStatus("Verify Done Button on Add Bill Reminder Dialog", PASS , "Done Button is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify Done Button on Add Bill Reminder Dialog", FAIL , "Done Button is not present on Add Bill Reminder Dialog")
					[ ] 
					[+] //Verifying whether Cancel Button is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.CancelButton.Exists(5))
							[ ] ReportStatus("Verify Cancel Button on Add Bill Reminder Dialog", PASS , "Cancel Button is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify Cancel Button on Add Bill Reminder Dialog", FAIL , "Cancel Button is not present on Add Bill Reminder Dialog")
						[ ] 
					[ ] 
					[+] //Verifying whether Help Button is available on Add Bill Reminder Dialog
						[+] if(DlgAddEditReminder.HelpButton.Exists(5))
							[ ] ReportStatus("Verify Help Button on Add Bill Reminder Dialog", PASS , "Help Button is present on Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify Help Button on Add Bill Reminder Dialog", FAIL , "Help Button is not present on Add Bill Reminder Dialog")
					[ ] 
				[ ] 
			[+] else 
				[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
				[ ] 
			[ ] DlgAddEditReminder.Close()
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //##########################################################################
[ ] 
[ ] 
[+] //###############TC07_BillNextButtonFirstScreen()################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	 TC07_BillNextButtonFirstScreen()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality of Next button on Add Bill Reminder first screen
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If UI controls are present on the Add Reminder Second Screen after Next button is clicked
		[ ] //				        Fail		   If any of the UI control is not present
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 08, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC07_BillNextButtonFirstScreen() appstate none
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigation to Home Tab
		[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
		[ ] 
		[ ] ReportStatus("Navigate to {sTAB_BILL} > {sTAB_UPCOMING}", iValidate, "Navigate to {sTAB_BILL} > {sTAB_UPCOMING}")
		[ ] 
		[ ] 
		[+] if(QuickenMainWindow.QWNavigator.AddReminder.Exists(5))
			[ ] ReportStatus("Upcoming from Bills Menu", PASS , "Upcoming is available as Add Reminder Button is displayed")
			[ ] 
			[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] 
			[+] //Verifying whether "Add Bill Reminder" dialog exist with proper Caption.
				[+] if(DlgAddEditReminder.Exists(5))
					[ ] ReportStatus("Verify Add Bill Reminder dialog", PASS , "Add Bill Reminder Dialog is present")
					[ ] 
					[ ] sCaption=DlgAddEditReminder.GetProperty("Caption")
					[ ] 
					[+] if(sCaption=="Add Bill Reminder")
						[ ] ReportStatus("Verify 'Add Bill Reminder' Caption on dialog", PASS , "'Add Bill Reminder' Caption is present on Add Bill Reminder Dialog  ")
					[+] else
						[ ] ReportStatus("Verify 'Add Bill Reminder' Caption on dialog", FAIL , "'Add Bill Reminder' Caption is not present on Add Bill Reminder Dialog  ")
					[ ] 
					[ ] //Going to Second Screen
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.SetText(sPayeeName)
					[ ] 
					[ ] DlgAddEditReminder.NextButton.Click()
					[ ] 
					[+] //Verifying whether Next Button functionality is working by checking DueNextOn exists on Second Screen or not.
						[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.Exists(5))
							[ ] ReportStatus("Verify Due Next On Textbox on Second Screen of Add Bill Reminder Dialog ", PASS , "Due Next On Textbox is present on Second Screen of Add Bill Reminder Dialog")
						[+] else
							[ ] ReportStatus("Verify Due Next On Textbox on Second Screen of Add Bill Reminder Dialog", FAIL , "Due Next On Textbox is not present on Second Screen of Add Bill Reminder Dialog")
						[ ] 
					[ ] 
					[ ] DlgAddEditReminder.CancelButton.Click()
				[+] else
						[ ] ReportStatus("Verify Add Bill Reminder dialog", FAIL , "Add Bill Reminder Dialog is not present")
						[ ] 
				[ ] 
		[+] else 
			[ ] ReportStatus("Upcoming from Bills Menu", FAIL , "Upcoming is not available as Add Reminder Button is not displayed")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] 
[+] //###############TC08_BillChangeLinkSecondScreen()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC08_BillChangeLinkSecondScreen()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify available options for frequency selection for due date in change link
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If all the options are available for frequency selection for due date in change link
		[ ] //				        Fail		   If options are not available
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 11, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC08_BillChangeLinkSecondScreen() appstate none
	[ ] 
	[+] // Variable declaration and definition
		[ ] List of STRING lsHowoften, EndDate,lsCompare,lsCompareEndDate
		[ ] 
		[ ] lsHowoften = {"Weekly","Bi-weekly","Monthly","Twice a month","Quarterly","Yearly","Twice a year","Only once","to pay estimated taxes"}
		[ ] EndDate = {"No end date","End on","End after"}
		[ ] sReminderType="Bill"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[ ] Agent.SetOption(OPT_VERIFY_EXPOSED,FALSE)
			[ ] 
			[ ] 
			[ ] 
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
			[ ] 
			[ ] 
			[ ] WaitForState(DlgOptionalSetting,TRUE,20)
			[ ] 
			[ ] //Verifying UI controls for the Change link of 'Due date On' on Add Bill Reminder  
			[+] if(DlgOptionalSetting.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify 'Due Date On' Frequency dialog exists by clicking Change Link ", PASS , " 'Due Date On' Frequency dialog is present by clicking Change Link ")
				[ ] 
				[+] //Verifying Start Date TextField is available on 'Due Date On' Frequency dialog
					[+] if(DlgOptionalSetting.StartDateTextField.Exists(5))
						[ ] ReportStatus("Verify Start Date TextField on 'Due Date On' Frequency dialog ", PASS , "Start Date TextField is present on 'Due Date On' Frequency dialog")
					[+] else
						[ ] ReportStatus("Verify Start Date TextField on 'Due Date On' Frequency dialog ", FAIL , "Start Date TextField is not present on 'Due Date On' Frequency dialog")
						[ ] 
					[ ] 
				[ ] 
				[+] //Verifying How often Popup List is available on 'Due Date On' Frequency dialog
					[+] if(DlgOptionalSetting.HowOftenPopupList.Exists(5))
						[ ] ReportStatus("Verify How often Popup List on 'Due Date On' Frequency dialog ", PASS , "How often Popup List is present on 'Due Date On' Frequency dialog")
						[ ] 
						[ ] lsCompare=DlgOptionalSetting.HowOftenPopupList.GetContents()
						[ ] 
						[ ] // Deleting the "QCombo_Separator" item from the List on ninth and fivth position
						[ ] ListDelete (lsCompare,9)
						[ ] ListDelete (lsCompare,5)
						[ ] 
						[+] for(i=1;i<=ListCount(lsCompare);i++)
							[+] if(lsHowoften[i]==lsCompare[i])
								[ ] ReportStatus("Verify the Contents of How often List",PASS,"As {lsHowoften[i]} is present in How often Popup List")
							[+] else
								[ ] ReportStatus("Verify the Contents of How often List",FAIL,"As {lsHowoften[i]}, {lsCompare[i]} is not present in How often Popup List")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify How often Popup List on 'Due Date On' Frequency dialog ", FAIL , "How often Popup List is not present on 'Due Date On' Frequency dialog")
					[ ] 
				[ ] 
				[+] //Verifying End Date Popup List is available on 'Due Date On' Frequency dialog
					[+] if(DlgOptionalSetting.EndDatePopupList.Exists(5))
						[ ] 
						[ ] ReportStatus("Verify End Date Popup List on 'Due Date On' Frequency dialog ", PASS , "End Date Popup List is present on 'Due Date On' Frequency dialog")
						[ ] 
						[ ] lsCompareEndDate = DlgOptionalSetting.EndDatePopupList.GetContents()
						[ ] 
						[+] for(j=1;j<=ListCount(EndDate);j++)
							[+] if(EndDate[j]==lsCompareEndDate[j])
								[ ] ReportStatus("Verify the Contents of End Date List",PASS,"As {EndDate[j]} = {lsCompareEndDate[j]} is same")
							[+] else
								[ ] ReportStatus("Verify the Contents of End Date List",FAIL,"As {EndDate[j]},{lsCompareEndDate[j]} is not same")
					[+] else
						[ ] ReportStatus("Verify End Date Popup List on 'Due Date On' Frequency dialog ", PASS , "End Date Popup List is not present on 'Due Date On' Frequency dialog")
				[ ] 
				[+] //Verifying Every UpDown List is available on 'Due Date On' Frequency dialog
					[+] if(DlgOptionalSetting.EveryUpDown.Exists(5))
						[ ] ReportStatus("Verify Every UpDown List on 'Due Date On' Frequency dialog ", PASS , "Every UpDown List is present on 'Due Date On' Frequency dialog")
					[+] else
						[ ] ReportStatus("Verify Every UpDown List on 'Due Date On' Frequency dialog ", FAIL , "Every UpDown List is not present on 'Due Date On' Frequency dialog")
				[ ] 
				[+] //Verifying Month On The Popup List is available on 'Due Date On' Frequency dialog
					[+] if(DlgOptionalSetting.MonthOnThePopupList.Exists(5))
						[ ] ReportStatus("Verify Month On The PopupList on 'Due Date On' Frequency dialog ", PASS , "Month On The Popup List is present on 'Due Date On' Frequency dialog")
					[+] else
						[ ] ReportStatus("Verify Month On The PopupList on 'Due Date On' Frequency dialog ", FAIL , "Month On The Popup List is not present on 'Due Date On' Frequency dialog")
				[ ] 
				[+] //Verifying Day Popup List is available on 'Due Date On' Frequency dialog
					[+] if(DlgOptionalSetting.DayPopupList.Exists(5))
						[ ] ReportStatus("Verify Day Popup List on 'Due Date On' Frequency dialog ", PASS , "Day Popup List is present on 'Due Date On' Frequency dialog")
					[+] else
						[ ] ReportStatus("Verify Day Popup List on 'Due Date On' Frequency dialog ", FAIL , "Day Popup List is not present on 'Due Date On' Frequency dialog")
				[ ] 
				[+] //Verifying End Date Popup List is available on 'Due Date On' Frequency dialog
					[+] if(DlgOptionalSetting.EndDatePopupList.Exists(5))
						[ ] ReportStatus("Verify End Date Popup List on 'Due Date On' Frequency dialog ", PASS , "End Date Popup List is present on 'Due Date On' Frequency dialog")
					[+] else
						[ ] ReportStatus("Verify End Date Popup List on 'Due Date On' Frequency dialog ", FAIL , "End Date Popup List is not present on 'Due Date On' Frequency dialog")
				[ ] 
				[+] //Verifying OK Button is available on 'Due Date On' Frequency dialog
					[+] if(DlgOptionalSetting.OKButton.Exists(5))
						[ ] ReportStatus("Verify OK Button on 'Due Date On' Frequency dialog ", PASS , "OK Button is present on 'Due Date On' Frequency dialog")
					[+] else
						[ ] ReportStatus("Verify OK Button on 'Due Date On' Frequency dialog ", FAIL , "OK Button is not present on 'Due Date On' Frequency dialog")
				[ ] 
				[+] //Verifying Cancel Button is available on 'Due Date On' Frequency dialog
					[+] if(DlgOptionalSetting.CancelButton.Exists(5))
						[ ] ReportStatus("Cancel Button on 'Due Date On' Frequency dialog ", PASS , "Cancel Button is present on 'Due Date On' Frequency dialog")
					[+] else
						[ ] ReportStatus("Cancel Button on 'Due Date On' Frequency dialog ", FAIL , "Cancel Button is not present on 'Due Date On' Frequency dialog")
						[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] DlgOptionalSetting.CancelButton.Click()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify 'Due Date On' Frequency dialog exists by clicking Change Link ", FAIL , " 'Due Date On' Frequency dialog is not present by clicking Change Link ")
			[ ] Agent.SetOption(OPT_VERIFY_EXPOSED,TRUE)
			[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
			[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Close()
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //###############TC09_BillUIAddCategoryTagMemoPanel()##########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC09_BillUIAddCategoryTagMemoPanel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify UI of Add Category, tag or memo panel
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If all UI controls of Add Category, tag or memo panel dialog are present
		[ ] //				        Fail		   If UI controls are not available
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 11, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC09_BillUIAddCategoryTagMemoPanel() appstate none
	[+] // Variable declaration and definition
		[ ] sReminderType="Bill"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[ ] DlgAddEditReminder.SetActive()
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
			[ ] 
			[ ] 
			[+] //Verifying UI controls for the Add Category Tag Memo Panel on Add Bill Reminder  
				[ ] 
				[+] //Verifying Category TextField is available on Add Category Tag Memo Panel
					[+] if(DlgOptionalSetting.CategoryTextField.Exists(5))
						[ ] ReportStatus("Verify Category TextField on Add Category Tag Memo Panel ", PASS , "Category TextField is present on Add Category Tag Memo Panel")
					[+] else
						[ ] ReportStatus("Verify Category TextField on Add Category Tag Memo Panel ", FAIL , "Category TextField is not present on Add Category Tag Memo Panel")
						[ ] 
				[ ] 
				[+] //Verifying Split Category Button is available on Add Category Tag Memo Panel
					[+] if(DlgOptionalSetting. SplitCategoryButton.Exists(5))
						[ ] ReportStatus("Split Category Button on Add Category Tag Memo Panel ", PASS , "Split Category Button is present on Add Category Tag Memo Panel")
					[+] else
						[ ] ReportStatus("Split Category Button on Add Category Tag Memo Panel ", FAIL , "Split Category Button is not present on Add Category Tag Memo Panel")
				[ ] 
				[+] //Verifying Tag TextField is available on Add Category Tag Memo Panel
					[+] if(DlgOptionalSetting.TagTextField.Exists(5))
						[ ] ReportStatus("Verify Tag TextField on Add Category Tag Memo Panel ", PASS , "Tag TextField is present on Add Category Tag Memo Panel")
					[+] else
						[ ] ReportStatus("Verify Tag TextField on Add Category Tag Memo Panel ", FAIL , "Tag TextField is not present on Add Category Tag Memo Panel")
				[ ] 
				[+] //Verifying Memo TextField is available on Add Category Tag Memo Panel
					[+] if(DlgOptionalSetting.MemoTextField.Exists(5))
						[ ] ReportStatus("Verify Memo TextField on Add Category Tag Memo Panel ", PASS , "Memo TextField is present on Add Category Tag Memo Panel")
					[+] else
						[ ] ReportStatus("Verify Memo TextField on Add Category Tag Memo Panel ", FAIL , "Memo TextField is not present on Add Category Tag Memo Panel")
				[ ] 
				[+] //Verifying OK Button is available on Add Category Tag Memo Panel
					[+] if(DlgOptionalSetting.OKButton.Exists(5))
						[ ] ReportStatus("Verify OK Button on Add Category Tag Memo Panel ", PASS , "OK Button is present on Add Category Tag Memo Panel")
					[+] else
						[ ] ReportStatus("Verify OK Button on Add Category Tag Memo Panel ", FAIL , "OK Button is not present on Add Category Tag Memo Panel")
				[ ] 
				[+] //Verifying Cancel Button is available on Add Category Tag Memo Panel
					[+] if(DlgOptionalSetting.CancelButton.Exists(5))
						[ ] ReportStatus("Verify Cancel Button on Add Category Tag Memo Panel ", PASS , "Cancel Button is present on Add Category Tag Memo Panel")
					[+] else
						[ ] ReportStatus("Verify Cancel Button on Add Category Tag Memo Panel ", FAIL , "Cancel Button is not present on Add Category Tag Memo Panel")
				[ ] 
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] DlgOptionalSetting.CancelButton.Click()
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
				[ ] DlgAddEditReminder.CancelButton.Click()
		[+] else 
			[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
			[ ] 
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //###############TC10_BillFunctionalityAddCategoryTagMemo()######################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC10_BillFunctionalityAddCategoryTagMemo()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of "Add category, tag or memo" 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If funcionality of Add Category, tag or memo panel dialog is working correctly
		[ ] //				        Fail		   If funcionality is not working
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 12, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC10_BillFunctionalityAddCategoryTagMemo() appstate none
	[ ] 
	[+] // Variable declaration and definition
		[ ] List of STRING  lsContents 
		[ ] 
		[ ] sReminderType="Bill"
		[ ] lsContents = {"Advertising (Business)","AC1","M1"}
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[+] // Verify Functionality of Add Category,Tag & Memo dialog
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] //Enter Data in Category,Tag & Memo Text Field
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] ReportStatus("Verify Add Category,Tag & Memo dialog present", PASS , "Add Category,Tag & Memo dialog is present")
					[ ] 
					[ ] // Enter data in Category,Tag & Memo field 
					[ ] DlgOptionalSetting.CategoryTextField.SetText(lsContents[1])
					[ ] DlgOptionalSetting.TagTextField.SetText(lsContents[2])
					[ ] DlgOptionalSetting.MemoTextField.SetText(lsContents[3])
					[ ] 
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] // Handled the new tag dialog
					[+] if(DlgOptionalSetting.NewTag.TagOKButton.Exists(5))
						[ ] DlgOptionalSetting.NewTag.TagOKButton.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Add Category,Tag & Memo dialog present", PASS , "Add Category,Tag & Memo dialog is not present")
					[ ] 
				[ ] 
				[ ] //DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
				[ ] 
				[ ] 
				[ ] //Retrieve Data from Category,Tag & Memo Text Field to verify whether the previous data is saved or not
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] ReportStatus("Verify Add Category,Tag & Memo dialog present", PASS , "Add Category,Tag & Memo dialog is present")
					[ ] 
					[+] // Verify retrieved category is same as entered
						[+] if(DlgOptionalSetting.CategoryTextField.GetText()==lsContents[1])
							[ ] ReportStatus("Compare entered Category with retrieved ", PASS , " Retrieved Category {lsContents[1]} is same as entered")
						[+] else
							[ ] ReportStatus("Compare entered Category with retrieved ", FAIL , " Retrieved Category {DlgOptionalSetting.CategoryTextField.GetText()} is not same as entered {lsContents[1]} ")
						[ ] 
					[+] // Verify retrieved Tag is same as entered
						[+] if(DlgOptionalSetting.TagTextField.GetText()==lsContents[2])
							[ ] ReportStatus("Compare entered Tag with retrieved ", PASS , " Retrieved Tag {lsContents[2]} is same as entered")
						[+] else
							[ ] ReportStatus("Compare entered Tag with retrieved ", FAIL , " Retrieved Tag {DlgOptionalSetting.TagTextField.GetText()} is not same as entered {lsContents[2]}")
						[ ] 
					[+] // Verify retrieved Memo is same as entered
						[+] if(DlgOptionalSetting.MemoTextField.GetText()==lsContents[3])
							[ ] ReportStatus("Compare entered Memo with retrieved  ", PASS , " Retrieved Memo {lsContents[3]} is same as entered")
						[+] else
							[ ] ReportStatus("Compare entered Memo with retrieved  ", FAIL , " Retrieved Memo {DlgOptionalSetting.MemoTextField.GetText()} is not same as entered {lsContents[3]}")
						[ ] 
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.CancelButton.Click()
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
				[+] else
					[ ] ReportStatus("Verify Add Category,Tag & Memo dialog present", FAIL , "Add Category,Tag & Memo dialog is not present")
			[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
		[+] else 
			[ ] ReportStatus("Upcoming from Bills Menu", FAIL , "Upcoming is not available as Add Reminder Button is not displayed")
			[ ] 
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //###############TC11_BillInvokingPointforSplitDialog()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC11_BillInvokingPointforSplitDialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify invoking point for split Transaction / Category dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If invoking split Transaction / Category dialog correctly
		[ ] //				        Fail		   If split Transaction / Category dialog is not invoked correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 13, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC11_BillInvokingPointforSplitDialog() appstate none
	[+] // Variable declaration and definition
		[ ] sReminderType="Bill"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] //Click on Add Category Tag Or Memo Panel 
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
			[ ] 
			[ ] 
			[ ] 
			[+] if(DlgOptionalSetting.SplitCategoryButton.Exists(5))
				[ ] ReportStatus("Verify Split Category Button on Add Category,Tag & Memo dialog present", PASS , "Split Category Button on Add Category,Tag & Memo dialog is present")
				[ ] 
				[+] //Verifying Invoking point for Split Transaction Dialog for Category
					[ ] 
					[ ] 
					[ ] DlgOptionalSetting.SplitCategoryButton.click()
				[ ] 
				[+] if(ReminderSplitTransaction.Exists(5))
					[ ] ReportStatus("Verify Reminder Split Transaction dialog present", PASS , "Reminder Split Transaction dialog is present")
					[ ] 
					[+] // Verify Add Lines Button exists on Split Transaction Dialog 
						[+] if(ReminderSplitTransaction.AddLinesButton.Exists(5))
							[ ] ReportStatus("Verify AddLines Button on Split Transaction Dialog ", PASS ,"Split Transaction Dialog is displayed as AddLines Button is present")
						[+] else
							[ ] ReportStatus("Verify AddLines Button on Split Transaction Dialog", FAIL ,"Split Transaction Dialog is not displayed as AddLines Button is not present")
					[ ] 
					[+] // Verify Multiple Categories List exists on Split Transaction Dialog 
						[+] if(ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Exists(5))
							[ ] ReportStatus("Verify Multiple Categories List on Split Transaction Dialog ", PASS , "Split Transaction Dialog is displayed as Multiple Categories List is present")
						[+] else
							[ ] ReportStatus("Verify Multiple Categories List on Split Transaction Dialog ", FAIL , "Split Transaction Dialog is not displayed as Multiple Categories List is not present")
					[ ] 
					[ ] ReminderSplitTransaction.CancelButton.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Split Transaction dialog present", FAIL , "Reminder Split Transaction dialog is present")
				[ ] 
				[ ] DlgOptionalSetting.CancelButton.Click()
				[ ] 
			[+] else
				[ ] ReportStatus("Split Category Button on Add Category,Tag & Memo dialog present", FAIL , "Split Category Button on Add Category,Tag & Memo dialog is not present")
				[ ] 
			[ ] 
			[ ] 
			[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //###############TC12_BillSplitCategoryFunctionality()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC12_BillSplitCategoryFunctionality()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify Functionality of split Transaction / Category dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of split Transaction / Category dialog is correct
		[ ] //				        Fail		   If split Transaction / Category dialog is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 13, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC12_BillSplitCategoryFunctionality() appstate none
	[+] // Variable declaration and definition
		[ ] List of STRING lsCategory,lsAmount,lsCompare 
		[ ] 
		[ ] lsCategory = {"Advertising (Business)","Bills & Utilities"}
		[ ] lsAmount = {"5.00","5.00"}
		[ ] sReminderType="Bill"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[+] //Verifying functionality of Split Category on Split Transaction Dialog
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
				[ ] 
				[ ] // Agent.SetOption(OPT_VERIFY_ENABLED,FALSE)
				[ ] // Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] 
				[+] if(DlgOptionalSetting.SplitCategoryButton.Exists(5))
					[ ] ReportStatus("Verify Split Category Button on Add Category,Tag & Memo dialog present", PASS , "Split Category Button on Add Category,Tag & Memo dialog is present")
					[ ] 
					[ ] //DlgOptionalSetting.SetActive()
					[ ] 
					[ ] 
					[ ] DlgOptionalSetting.SplitCategoryButton.Click()
					[ ] 
					[ ] // 
					[+] // if(ReminderSplitTransaction.Exists(5))
						[ ] // ReportStatus("Verify Reminder Split Transaction dialog present", PASS, "Reminder Split Transaction dialog is present")
						[ ] // // Entering data in Category List for first row
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#1")
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText(lsCategory[1])
						[ ] // CategoryQuickList.Close()
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText(lsAmount[1])
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_ENTER)
						[ ] // 
						[ ] // // Entering data in Category List for second row
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#2")
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText(lsCategory[2])
						[ ] // CategoryQuickList.Close()
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText(lsAmount[2])
						[ ] // 
						[ ] // //Close both the dialogs
						[ ] // // Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
						[ ] // ReminderSplitTransaction.OKButton.Click()
						[ ] // // Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
						[ ] // DlgOptionalSetting.OKButton.Click()
						[ ] // // Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
						[ ] // 
						[ ] // 
					[ ] 
					[ ] 
					[ ] 
					[+] if(ReminderSplitTransaction.Exists(5))
						[ ] ReminderSplitTransaction.SetActive()
						[ ] ReportStatus("Verify Reminder Split Transaction dialog present", PASS, "Reminder Split Transaction dialog is present")
						[ ] // Entering data in Category List for first row
						[ ] ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText(lsCategory[1])
						[+] if(NewCategory.Exists(2))
							[ ] NewCategory.SetActive()
							[ ] NewCategory.Yes.Click()
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[ ] ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField14.SetText(lsAmount[1])
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[ ] 
						[ ] 
						[ ] // Entering data in Category List for second row
						[ ] 
						[ ] ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText(lsCategory[2])
						[+] if(NewCategory.Exists(2))
							[ ] NewCategory.SetActive()
							[ ] NewCategory.Yes.Click()
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[ ] ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField14.SetText(lsAmount[2])
						[ ] 
						[ ] //Close both the dialogs
						[ ] ReminderSplitTransaction.OKButton.Click()
						[ ] DlgOptionalSetting.OKButton.Click()
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Reminder Split Transaction dialog present", FAIL , "Reminder Split Transaction dialog is present")
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Split Category Button on Add Category,Tag & Memo dialog present", FAIL , "Split Category Button on Add Category,Tag & Memo dialog is not present")
				[ ] 
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
				[ ] // Agent.SetOption(OPT_VERIFY_ENABLED,FALSE)
				[ ] // Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] 
				[ ] 
				[+] if(DlgOptionalSetting.SplitCategoryButton.Exists(5))
					[ ] ReportStatus("Verify Split Category Button on Add Category,Tag & Memo dialog present", PASS , "Split Category Button on Add Category,Tag & Memo dialog is present")
					[ ] 
					[ ] DlgOptionalSetting.SplitCategoryButton.Click()
					[ ] 
					[+] if(ReminderSplitTransaction.Exists(5))
						[ ] ReportStatus("Verify Reminder Split Transaction dialog present", PASS , "Reminder Split Transaction dialog is present")
						[ ] 
						[+] //Retrieving the data from Category List of first row and appending data in a List for comparsion
							[ ] //ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#1")
							[ ] ListAppend(lsCompare,ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.GetText())
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] ListAppend(lsCompare,ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField14.GetText())
							[ ] //ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_ENTER)
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] 
							[ ] 
						[ ] 
						[+] //Retrieving the data from Category List of second row and appending data in a List for comparsion
							[ ] 
							[ ] ListAppend(lsCompare,ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.GetText())
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] ListAppend(lsCompare,ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField14.GetText())
						[ ] 
						[+] //Close both the dialogs
							[ ] //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
							[ ] ReminderSplitTransaction.OKButton.Click()
					[ ] 
					[+] else
						[ ] ReportStatus("Verify Reminder Split Transaction dialog present", FAIL , "Reminder Split Transaction dialog is present")
						[ ] 
					[ ] // Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] // Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
					[ ] 
				[+] else
					[ ] ReportStatus("Split Category Button on Add Category,Tag & Memo dialog present", FAIL , "Split Category Button on Add Category,Tag & Memo dialog is not present")
					[ ] 
				[ ] 
				[+] //Comparing both the List retrieved data with entered data
					[ ] 
					[+] // Verify retrieved category is same as entered from first row
						[+] if(lsCategory[1]==lsCompare[1])
							[ ] ReportStatus("Verify Category in split is same ", PASS , "Category {lsCompare[1]} in Split is same")
						[+] else
							[ ] ReportStatus("Verify Category in split is same", FAIL , "Category {lsCompare[1]} in Split is not same as entered is {lsCategory[1]}")
							[ ] 
						[ ] 
					[ ] 
					[+] // Verify retrieved Amount is same as entered from first row
						[+] if(lsAmount[1]==lsCompare[2])
							[ ] ReportStatus("Verify Amount in split is same ", PASS ,"Amount {lsCompare[2]} in split is same")
						[+] else
							[ ] ReportStatus("Verify Amount in split is same", FAIL , "Amount {lsCompare[2]} in split is not same as entered is {lsAmount[1]}")
						[ ] 
					[ ] 
					[+] // Verify retrieved category is same as entered from second row
						[+] if(lsCategory[2]==lsCompare[3])
							[ ] ReportStatus("Verify Category in split is same ", PASS , "Category {lsCompare[3]} in Split is same")
						[+] else
							[ ] ReportStatus("Verify Category in split is same", FAIL , "Category {lsCompare[3]} in Split is not same as entered is {lsCategory[2]}")
						[ ] 
					[ ] 
					[+] // Verify retrieved category is same as entered second row
						[+] if(lsAmount[2]==lsCompare[4])
							[ ] ReportStatus("Verify Amount in split is same ", PASS ,"Amount{lsCompare[4]} in split is same")
						[+] else
							[ ] ReportStatus("Verify Amount in split is same", FAIL , "Amount{lsCompare[4]} in split is not same as entered is {lsAmount[2]} ")
				[ ] 
				[ ] 
				[ ] 
				[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# TC13_OnlineBillPayUI() ##########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC13_OnlineBillPayUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify appearance of online bill pay check box for FI bill pay enabled account.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 14, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC13_OnlineBillPayUI() appstate none
	[ ] 
	[+] //Variable Declaration and defination
		[ ] STRING sSelectedAccountName
		[ ] 
		[ ] sAccountName = "Online Bill Pay Account"
		[ ] sPayeeName= "Dale Knievel"
		[ ] sReminderType = "Bill"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] // iSetupAutoAPI = SetUp_AutoApi()
		[ ] // ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
		[+] if(FileExists(sOnlineDataFile))
			[+] if(QuickenWindow.Exists(2))
				[ ] QuickenWindow.Kill()
				[ ] WaitForState(QuickenMainWindow, FALSE,2)
			[ ] DeleteFile(sOnlineDataFile)
		[ ] //Copy Scheduled_Transactions_OBP.QDF from Original Scheduled_Transactions_OBP folder.
		[ ] bCheckStatus =Copyfile(sOriginalFile, sOnlineDataFile)
		[+] if(bCheckStatus==TRUE)
			[ ] ReportStatus("Copy data file", PASS, "Data file -  {sOnlineDataFile} is copied successfully")
		[+] else
			[ ] ReportStatus("Copy data file", FAIL, "Data file -  {sOnlineDataFile} is NOT copied")
		[ ] //Check which data file is opened and open Scheduled_Transactions_OBP.QDF if required.
		[+] if(!QuickenWindow.Exists(10))
			[ ] QuickenWindow.Start (sCmdLine)
			[ ] CloseQuickenConnectedServices()
		[ ] sCaption = QuickenWindow.GetCaption()
		[ ] bCaption = MatchStr("*{sOnlineFileName}*", sCaption)
		[+] if(bCaption == FALSE)
			[ ] iValidate=OpenDataFile(sOnlineFileName)
			[ ] ReportStatus("Open data file", PASS, "Data file -  {sOnlineDataFile} is opened")
		[+] else
			[ ] ReportStatus("Open data file", PASS, "Data file -  {sOnlineDataFile} is already opened")
	[+] else
		[+] if(FileExists(sOnlineDataFile))
			[ ] DeleteFile(sOnlineDataFile)
		[ ] //Copy Scheduled_Transactions_OBP.QDF from Original Scheduled_Transactions_OBP folder.
		[ ] bCheckStatus=Copyfile(sOriginalFile, sOnlineDataFile)
		[+] if(bCheckStatus==TRUE)
			[ ] ReportStatus("Copy data file", PASS, "Data file -  {sOnlineDataFile} is copied successfully")
		[+] else
			[ ] ReportStatus("Copy data file", FAIL, "Data file -  {sOnlineDataFile} is NOT copied")
		[ ] 
		[ ] QuickenMainWindow.Start (sCmdLine)
		[ ] sCaption = QuickenMainWindow.GetCaption()
		[ ] bCaption = MatchStr("*{sFileName}*", sCaption)
		[+] if(bCaption == FALSE)
			[ ] iValidate=OpenDataFile(sOnlineFileName)
			[ ] ReportStatus("Open data file", PASS, "Data file -  {sOnlineDataFile} is opened")
		[+] else
			[ ] ReportStatus("Open data file", PASS, "Data file -  {sOnlineDataFile} is already opened")
	[ ] 
	[ ] //Launch add bill reminder dialog, enter payee and click Next.
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Bill Reminder dialog second screen is displayed.")
		[ ] sSelectedAccountName=DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.GetText()
		[ ] //Verify that Online Bill pay check box is present for selected account
		[ ] // Select online bill pay account if not selected already
		[+] if (sSelectedAccountName==sAccountName)
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.UseBillPayCheckBox.Exists(5))
				[ ] ReportStatus("Online Bill Pay Checkbox", PASS, "Online Bill Pay Checkbox is present.")
			[+] else
				[ ] ReportStatus("Online Bill Pay Checkbox", FAIL, "Online Bill Pay Checkbox is NOT present.")
		[+] else
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.SetText(sAccountName)
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.UseBillPayCheckBox.Exists(5))
				[ ] ReportStatus("Online Bill Pay Checkbox", PASS, "Online Bill Pay Checkbox is present.")
			[+] else
				[ ] ReportStatus("Online Bill Pay Checkbox", FAIL, "Online Bill Pay Checkbox is NOT present.")
			[ ] DlgAddEditReminder.Close()
	[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Bill Reminder screen two is not displayed")
[ ] //###########################################################################
[ ] 
[+] //############# TC14_QuickenBillPayUI() ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC14_QuickenBillPayUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify appearance of Quicken bill pay check box for Quicken bill pay enabled account.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 15, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC14_QuickenBillPayUI() appstate none
	[ ] 
	[+] //Variable Declaration and defination
		[ ] STRING sSelectedAccountName
		[ ] 
		[ ] sAccountName = "Quicken Bill Pay Account"
		[ ] sPayeeName= "Dale Knievel"
		[ ] sReminderType = "Bill"
	[ ] 
	[ ] //Launch add bill reminder dialog, enter payee and click Next.
	[ ] NavigateReminderDetailsPage(sReminderType, sPayeeName)
	[ ] sSelectedAccountName=DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.GetText()
	[ ] //Verify that Quicken Bill pay check box is present for selected account
	[+] if (sSelectedAccountName==sAccountName)
		[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.UseBillPayCheckBox.Exists(5))
			[ ] ReportStatus("Quicken Bill Pay Checkbox", PASS, "Quicken Bill Pay Checkbox is present.")
		[+] else
			[ ] ReportStatus("Quicken Bill Pay Checkbox", FAIL, "Quicken Bill Pay Checkbox is NOT present.")
	[+] else
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.SetText(sAccountName)
		[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.UseBillPayCheckBox.Exists(5))
			[ ] ReportStatus("Quicken Bill Pay Checkbox", PASS, "Quicken Bill Pay Checkbox is present.")
		[+] else
			[ ] ReportStatus("Quicken Bill Pay Checkbox", FAIL, "Quicken Bill Pay Checkbox is NOT present.")
		[ ] 
	[ ] DlgAddEditReminder.Close()
[ ] //########################################################################### 
[ ] 
[+] //############# TC15_OnlineBillPayFunctionality() #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC15_OnlineBillPayFunctionality()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify functionality of online bill pay check box for FI bill pay enabled account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 15, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC15_OnlineBillPayFunctionality() appstate none
	[ ] 
	[+] //Variable Declaration and defination
		[ ] INTEGER iDaysIncrement
		[ ] STRING  sSelectedAccountName, sBillAmount, sMethod, sDueDate
		[ ] boolean bCheckStatus,bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sAccountName = "Online Bill Pay Account"
		[ ] sPayeeName= "Dale Knievel"
		[ ] sReminderType = "Bill"
		[ ] sBillAmount = "1.15"
		[ ] sMethod = "Online Payment"
		[ ] iDaysIncrement=12
		[ ] 
		[ ] sDueDate=ModifyDate(iDaysIncrement,sDateFormat)
		[ ] lsBillVerification = {sPayeeName,sBillAmount,sDueDate,sMethod}
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] //Launch add bill reminder dialog, enter payee and click Next.
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
	[+] if (iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Bill Reminder dialog second screen is displayed.")
		[ ] //Verify if expected account is already selected, if yes then add a online bill reminder, if No then select this account
		[ ] sSelectedAccountName=DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.GetText()
		[ ] DlgAddEditReminder.TypeKeys(KEY_TAB)
		[+] if (sSelectedAccountName==sAccountName)
			[ ] ReportStatus("Select Bill Pay activated account", PASS, "Bill Pay activated account is already selected.")
		[+] else
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.SetText(sAccountName)
			[ ] ReportStatus("Select Bill Pay activated account", PASS, "Bill Pay activated account is selected.")
		[ ] //Verify that Online Bill Pay Checkbox is present
		[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.UseBillPayCheckBox.Exists(5))
			[ ] ReportStatus("Online Bill Pay Checkbox", PASS, "Online Bill Pay Checkbox is present.")
			[ ] //Print(sDueDate)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDueDate)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sBillAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.UseBillPayCheckBox.Check()
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[ ] //Verify if online bill gets added or not using Bill and Income Reminder List (CTRL+J)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] 
				[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification} is NOT added, sActual = {sActual}")
				[ ] DlgManageReminders.Close()
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
			[ ] 
			[ ] 
		[ ] //Report failure that Online Bill Pay Checkbox is NOT present
		[+] else
			[ ] ReportStatus("Online Bill Pay Checkbox", FAIL, "Online Bill Pay Checkbox is NOT present.")
	[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Bill Reminder screen two is not displayed")
[ ] //###########################################################################
[ ] 
[+] //############# TC16_QuickenBillPayFunctionality() ###############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC16_QuickenBillPayFunctionality()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify functionality of Quicken bill pay check box for FI bill pay enabled account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 18, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC16_QuickenBillPayFunctionality() appstate none
	[ ] 
	[+] //Variable Declaration and defination
		[ ] INTEGER iDaysIncrement
		[ ] STRING sSelectedAccountName, sBillAmount, sDueDate,sMethod
		[ ] boolean bResult 
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sAccountName = "Quicken Bill Pay Account"
		[ ] sPayeeName= "Govind B"
		[ ] sReminderType = "Bill"
		[ ] sBillAmount = "3.43"
		[ ] sMethod = "Online Payment"
		[ ] 
		[ ] iDaysIncrement=12
		[ ] sDueDate=ModifyDate(iDaysIncrement,sDateFormat)
		[ ] lsBillVerification = {sPayeeName,sBillAmount,sDueDate,sMethod}
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] //Launch add bill reminder dialog, enter payee and click Next.
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Bill Reminder dialog second screen is displayed.")
		[ ] //Verify if expected account is already selected, if yes then add a online bill reminder, if No then select this account
		[ ] sSelectedAccountName=DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.GetText()
		[ ] DlgAddEditReminder.TypeKeys(KEY_TAB)
		[+] if (sSelectedAccountName==sAccountName)
			[ ] ReportStatus("Select Bill Pay activated account", PASS, "Quicken Bill Pay activated account is already selected.")
		[+] else
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.SetText(sAccountName)
			[ ] ReportStatus("Select Bill Pay activated account", PASS, "Quicken Bill Pay activated account is selected.")
		[ ] //Verify that Online Bill Pay Checkbox is present
		[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.UseBillPayCheckBox.Exists(5))
			[ ] ReportStatus("Quicken Bill Pay Checkbox", PASS, "Quicken Bill Pay Checkbox is present.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDueDate)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sBillAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.UseBillPayCheckBox.Check()
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[ ] //Verify if online bill gets added or not using Bill and Income Reminder List (CTRL+J)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification} is NOT added, sActual = {sActual}")
				[ ] DlgManageReminders.Close()
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Quicken Bill Pay Reminder is NOT added")
			[ ] 
		[ ] //Report failure that Quicken Bill Pay Checkbox is NOT present
		[+] else
			[ ] ReportStatus("Quicken Bill Pay Checkbox", FAIL, "Quicken Bill Pay Checkbox is NOT present.")
	[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Bill Reminder screen two is not displayed")
[ ] //###########################################################################
[ ] 
[+] //############# TC18_MakeRepeatingOnlinePaymentUI() ###########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC18_MakeRepeatingOnlinePaymentUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify appearance of Make this repeating online payment check box for FI bill pay enabled account when Online Bill Pay checkbox is checked
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 19, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC18_MakeRepeatingOnlinePaymentUI() appstate none
	[ ] 
	[+] //Variable Declaration and defination
		[ ] INTEGER iDaysIncrement
		[ ] STRING  sSelectedAccountName, sBillAmount, sMethod, sDueDate, sCaption,sRepeatingOnlinePayment
		[ ] 
		[ ] sAccountName = "Online Bill Pay Account"
		[ ] sPayeeName= "Dale Knievel"
		[ ] sReminderType = "Bill"
		[ ] sBillAmount = "1.15"
		[ ] iDaysIncrement=12
		[ ] 
		[ ] sDueDate=ModifyDate(iDaysIncrement,sDateFormat)
		[ ] sRepeatingOnlinePayment= "Make this a repeating online payment"
	[ ] 
	[ ] //Launch add bill reminder dialog, enter payee and click Next.
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Bill Reminder dialog second screen is displayed.")
		[ ] //Verify if expected account is already selected, if yes then add a online bill reminder, if No then select this account
		[ ] sSelectedAccountName=DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.GetText()
		[ ] DlgAddEditReminder.TypeKeys(KEY_TAB)
		[+] if (sSelectedAccountName==sAccountName)
			[ ] ReportStatus("Select Bill Pay activated account", PASS, "Bill Pay activated account is already selected.")
		[+] else
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.SetText(sAccountName)
			[ ] ReportStatus("Select Bill Pay activated account", PASS, "Bill Pay activated account is selected.")
		[ ] //Verify that Online Bill Pay Checkbox is present
		[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.UseBillPayCheckBox.Exists(5))
			[ ] ReportStatus("Online Bill Pay Checkbox", PASS, "Online Bill Pay Checkbox is present.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDueDate)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sBillAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.UseBillPayCheckBox.Check()
			[ ] 
			[ ] //DlgAddEditReminder.Step2Panel.QWinChild1.UseBillPayCheckBox.Check()
			[ ] //DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel2.OptionalSettingsButton.Click()
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
			[ ] 
			[ ] //sCaption =DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel.OptionalSettingsDisplayedPanel.PrintCheckWithQuickenCheckBox.GetCaption()
			[ ] sCaption = DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.PrintCheckWithQuickenCheckBox.GetCaption()
			[+] if(sCaption==sRepeatingOnlinePayment)
				[ ] ReportStatus("Repeating Online Bill Pay Checkbox", PASS, "Repeating Online Bill Pay Checkbox is present.")
			[+] else
				[ ] ReportStatus("Repeating Online Bill Pay Checkbox", FAIL, "Repeating Online Bill Pay Checkbox is NOT present.")
			[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
		[ ] //Report failure that Online Bill Pay Checkbox is NOT present
		[+] else
			[ ] ReportStatus("Online Bill Pay Checkbox", FAIL, "Online Bill Pay Checkbox is NOT present.")
	[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Bill Reminder screen two is not displayed")
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Optional settings for Bill #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test19_VerifyBillOptionalSettings()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify options available in Optional settings section for manual checking account
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 11, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC19_VerifyBillOptionalSettings () appstate none
	[ ] 
	[+] // Variable Declaration
		[ ] LIST OF STRING lsAddAccount
		[ ] 
		[ ] sReminderType = "Bill"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sExcelDataFile, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Quicken is launched then create data file
	[+] if (QuickenWindow.Exists(10) == True)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Create Data File
		[ ] 
		[ ] // Add Checking Account
		[ ] iValidate = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], sDateStamp)
		[ ] // Report Status if checking Account is created
		[+] if (iValidate==PASS)
			[ ] ReportStatus("Add Checking Account", iValidate, "Checking Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] // Navigate to Bill Details page 
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] // Click on Optional setting button and verify objects
				[ ] // if(DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Exists(5))
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Exists(5))
					[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceText.Exists())
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
					[ ] 
					[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceText.Exists(5))
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
					[ ] 
					[ ] // Verify Remind Days In Advance Text
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceText.Exists(5))
						[ ] ReportStatus("Verify Remind Me 3 days in advance text",PASS,"Remind me 3 days in advance text is available on Add {sReminderType} Reminder dialog")
					[+] else
						[ ] ReportStatus("Verify Remind Me 3 days in advance text",FAIL,"Remind me 3 days in advance text is not available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] // Verify Remind Days In Advance Change Link
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
						[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",PASS,"Remind me 3 days in advance Change link is available on Add {sReminderType} Reminder dialog")
					[+] else
						[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",FAIL,"Remind me 3 days in advance Change link is not available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] // Verify Related Website Text
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteText.Exists(5))
						[ ] ReportStatus("Verify Related Website text",PASS,"Related website text is available on Add {sReminderType} Reminder dialog")
					[+] else
						[ ] ReportStatus("Verify Related website text",FAIL,"Related website text is not available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] // Verify Related Website Add Link
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
						[ ] ReportStatus("Verify Related wesite add Link",PASS,"Related website add link is available on Add {sReminderType} Reminder dialog")
					[+] else
						[ ] ReportStatus("Verify Related website add Link",FAIL,"Related website add link is not available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] // Verify Estimate Amount Text
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountText.Exists(5))
						[ ] ReportStatus("Verify Estimate amount for me:OFF text",PASS,"Estimate amount for me:OFF text is available on Add {sReminderType} Reminder dialog")
					[+] else
						[ ] ReportStatus("Verify Estimate amount for me:OFF text",FAIL,"Estimate amount for me:OFF text is not available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] // Verify Estimate Amount Change Link
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
						[ ] ReportStatus("Verify Estimate amount for me:OFF change link",PASS,"Estimate amount for me:OFF change link is available on Add {sReminderType} Reminder dialog")
					[+] else
						[ ] ReportStatus("Verify Estimate amount for me:OFF change link",FAIL,"Estimate amount for me:OFF change link is not available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] // Verify Sync To Outlook CheckBox
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.SyncToOutlookCheckBox.Exists(5))
						[ ] ReportStatus("Verify Sync to outlook checkbox",PASS,"Sync to outlook checkbox is available on Add {sReminderType} Reminder dialog")
					[+] else
						[ ] ReportStatus("Verify Sync to outlook checkbox",FAIL,"Sync to outlook checkbox is not available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] // Verify Print Check With Quicken CheckBox
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.PrintCheckWithQuickenCheckBox.Exists(5))
						[ ] ReportStatus("Verify Print Check with Quicken checkbox",PASS,"Print Check with Quicken checkbox is available on Add {sReminderType} Reminder dialog")
					[+] else
						[ ] ReportStatus("Verify Print Check with Quicken checkbox",FAIL,"Print Check with Quicken checkboxk is not available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] // Click on Cancel
					[ ] 
					[ ] 
					[ ] DlgAddEditReminder.CancelButton.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Optional Setting button",FAIL,"Optional Setting button is not available on Add {sReminderType} Reminder dialog")
					[ ] 
			[+] else
				[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Checking Account", iValidate, "Checking Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify Reminder Change Link for Bill ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test20_VerifyBillOptionalSettingsReminderChangeLink()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify UI of Reminder days form for Bill Reminder
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 12, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC20_VerifyBillOptionalSettingsReminderChangeLink () appstate none
	[ ] 
	[+] // Variable Declaration
		[ ] sReminderType = "Bill"
		[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10) == True)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
				[ ] 
				[ ] SETTING:
				[ ] // Click on Optional setting button and verify objects
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
					[ ] 
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
						[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",PASS,"Remind me 3 days in advance Change link is available on Add {sReminderType} Reminder dialog")
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
						[ ] 
						[ ] 
						[+] if(DlgOptionalSetting.Exists(5))
							[ ] //DlgOptionalSetting.SetActive()
							[ ] 
							[ ] // Verify Remind Me RadioList
							[+] if(DlgOptionalSetting.RemindMeRadioList.Exists(5))
								[ ] ReportStatus("Verify Remind me radio list",PASS,"Remind me radio list is displayed")
							[+] else
								[ ] ReportStatus("Verify Remind me radio list",FAIL,"Remind me radio list is not displayed")
							[ ] 
							[ ] // Verify Days In Advance TextField
							[+] if(DlgOptionalSetting.DaysInAdvanceTextField.Exists(5))
								[ ] ReportStatus("Verify Days In Advance list box",PASS,"Days In Advance list box is displayed")
							[+] else
								[ ] ReportStatus("Verify Days In Advance list box",FAIL,"Days In Advance list box is not displayed")
							[ ] 
							[ ] // Verify Use Only Business Days CheckBox
							[+] if(DlgOptionalSetting.UseOnlyBusinessDaysCheckBox.Exists(5))
								[ ] ReportStatus("Verify Use Only Business Days CheckBox",PASS,"Use Only Business Days CheckBox is displayed")
							[+] else
								[ ] ReportStatus("Verify Use Only Business Days CheckBox",FAIL,"Use Only Business Days CheckBox is not displayed")
							[ ] 
							[ ] // Verify OK Button
							[+] if(DlgOptionalSetting.OKButton.Exists(5))
								[ ] ReportStatus("Verify OK button",PASS,"OK button is displayed")
							[+] else
								[ ] ReportStatus("Verify OK button",FAIL,"OK button is not displayed")
							[ ] 
							[ ] // Verify Cancel button
							[+] if(DlgOptionalSetting.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel button",PASS,"Cancel button is displayed")
							[+] else
								[ ] ReportStatus("Verify Cancel button",FAIL,"Cancel button is displayed")
							[ ] 
							[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
							[ ] DlgOptionalSetting.CancelButton.Click()
							[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",FAIL,"Remind me 3 days in advance Change link is not available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] // Click on Cancel button
					[ ] DlgAddEditReminder.CancelButton.Click()
					[ ] 
				[+] else
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
					[ ] goto SETTING
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify automatic enter transaction for Bill ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_VerifyBillOptionalSettingsAutomaticEnterTxn()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify automatic enter transaction
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 13, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC21_VerifyBillOptionalSettingsAutomaticEnterTxn () appstate none
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sAmount,sCheckingAccount
		[ ] sAmount="20"
		[ ] sReminderType = "Bill"
		[ ] sCheckingAccount="Checking 01"
		[ ] sBillStatus="Paid"
		[ ] sPayeeName = "ST_Payee"
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
			[ ] 
			[ ] SETTING:
			[ ] // Click on Optional setting button and verify objects
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] sleep(1)
				[ ] DlgAddEditReminder.SetActive()
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
					[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",PASS,"Remind me 3 days in advance Change link is available on Add {sReminderType} Reminder dialog")
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
					[+] if(DlgOptionalSetting.Exists(5))
						[ ] 
						[+] if(DlgOptionalSetting.RemindMeRadioList.Exists(5))
							[ ] ReportStatus("Verify Remind me radio list",PASS,"Remind me radio list is displayed")
							[ ] DlgOptionalSetting.RemindMeRadioList.TypeKeys(KEY_DN)
							[+] if(DlgOptionalSetting.DaysInAdvanceTextField.Exists(5))
								[ ] ReportStatus("Verify Automatically enter the transaction",PASS,"Automatically enter the transaction is selected")
								[ ] DlgOptionalSetting.OKButton.Click()
								[ ] // Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
								[ ] 
								[ ] sleep(1)
								[ ] DlgAddEditReminder.SetActive()
								[ ] DlgAddEditReminder.TextClick("Done")
								[ ] 
								[ ] sleep(3)
								[ ] WaitForState(DlgAddEditReminder ,FALSE ,5)
								[ ] // Relaunch Quicken
								[ ] LaunchQuicken()
								[ ] sleep(5)
								[ ] QuickenWindow.SetActive()
								[ ] 
								[ ] // Navigate to Bills Tab
								[ ] NavigateQuickenTab(sTAB_BILL)
								[ ] sleep(2)
								[ ] QuickenWindow.SetActive()
								[ ] MDIClient.Bills.ViewAsPopupList.Select(1)
								[ ] 
								[ ] // Verify Go to Register button
								[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Exists(5))
									[ ] ReportStatus("Verify Go to Register button",PASS,"Scheduled bill is Paid as Go to Register button is displayed")
								[+] else
									[ ] ReportStatus("Verify Go to Register button",FAIL,"Scheduled bill is not Paid as Go to Register button is not displayed")
								[ ] 
								[ ] 
								[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName ,NULL,0 ,0 , sBillStatus)
								[+] if(iValidate==PASS)
									[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
									[ ] 
									[ ] SelectAccountFromAccountBar(sCheckingAccount,ACCOUNT_BANKING)
									[ ] DeleteTransaction(sWindowTypeMDI,sPayeeName)
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Delete Reminder", FAIL, "Reminder not deleted")
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Days In Advance list box",FAIL,"Days In Advance list box is not displayed")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Remind me radio list",FAIL,"Remind me radio list is not displayed")
					[+] else
						[ ] ReportStatus("Verify Optional Setting window", FAIL, "Optional setting window is not displayed")
				[+] else
					[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",FAIL,"Remind me 3 days in advance Change link is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify UI of "Related website"  #####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test22_VerifyBillOptionalSettingsRelatedWebsite()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify UI of "Related website" form
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 18, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC22_VerifyBillOptionalSettingsRelatedWebsite () appstate none
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sAmount,sWebsite,sActualWebsite
		[ ] 
		[ ] sAmount="20"
		[ ] sWebsite="www.google.com"
		[ ] sReminderType = "Bill"
		[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10) == True)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
			[ ] 
			[ ] SETTING:
			[ ] // Click on Optional setting button and verify objects
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
					[ ] ReportStatus("Verify Related Website Add Link",PASS,"Related Website Add Link is available on Add {sReminderType} Reminder dialog")
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Click()
					[+] if(DlgOptionalSetting.Exists(5))
						[+] if(DlgOptionalSetting.WebsiteTextField.Exists(5))
							[ ] ReportStatus("Verify Website text field",PASS,"Website text field is displayed")
							[ ] DlgOptionalSetting.WebsiteTextField.SetText(sWebsite)
							[ ] DlgOptionalSetting.OKButton.Click()
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Website text field",FAIL,"Website text field is not displayed")
					[+] else
						[ ] ReportStatus("Verify Optional Setting window", FAIL, "Optional setting window is not displayed")
				[+] else
					[ ] ReportStatus("Verify Related Website Add Link",FAIL,"Related Website Add Link is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] DlgAddEditReminder.DoneButton.Click()     //(1, 36, 12)
				[ ] 
				[ ] // Verify entered link in Bills > Stack view
				[ ] //sleep(2)
				[ ] //MDIClient.Bills.Panel.Click(1,173,125)
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Click(MB_LEFT,320,300)
				[ ] QuickenWindow.SetActive()
				[ ] sActualWebsite=MDIClient.Bills.Panel.Panel1.QWinChild.WebsiteLink.GetCaption()
				[ ] bMatch=MatchStr("*{sWebsite}*",sActualWebsite)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify entered website in {sReminderType} Reminder",PASS,"Entered Website is displayed correctly i.e. {sWebsite}")
				[+] else
					[ ] ReportStatus("Verify entered website in {sReminderType} Reminder",FAIL,"Entered Website is not displayed correctly, Expected- {sWebsite} and Actual-{sActualWebsite}")
					[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Delete Single Reminder", PASS, "Single Reminder deleted successfully")
				[+] else
					[ ] ReportStatus("Delete Single Reminder", FAIL, "Single Reminder not deleted")
				[ ] 
				[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify "Go to Website" link  #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_VerifyBillOptionalSettingsGoToWebsiteLink()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify appearance of "Go to Website" link in Add Bill Reminder dialog when website is entered
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 20, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC23_VerifyBillOptionalSettingsGoToWebsiteLink () appstate none
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sAmount,sWebsite,sLinkName,sExpectedLink
		[ ] 
		[ ] sAmount="20"
		[ ] sWebsite="www.google.com"
		[ ] sExpectedLink="(change)"
		[ ] sReminderType = "Bill"
		[ ] 
		[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10) == True)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
				[ ] 
				[ ] SETTING:
				[ ] // Click on Optional setting button and verify objects
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
					[ ] // Verify Add link for Related Website
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
						[ ] ReportStatus("Verify Related Website Add Link",PASS,"Related Website Add Link is available on Add {sReminderType} Reminder dialog")
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Click()
						[ ] 
						[+] if(DlgOptionalSetting.Exists(5))
							[ ] // Enter website
							[+] if(DlgOptionalSetting.WebsiteTextField.Exists(5))
								[ ] ReportStatus("Verify Website text field",PASS,"Website text field is displayed")
								[ ] DlgOptionalSetting.WebsiteTextField.SetText(sWebsite)
								[ ] DlgOptionalSetting.OKButton.Click()
								[ ] 
								[ ] // Verify add link is converted to change link
								[ ] sLinkName=DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.GetCaption()
								[+] if(sLinkName==sExpectedLink)
									[ ] ReportStatus("Verify Add link",PASS,"add link is converted in to change link")
								[+] else
									[ ] ReportStatus("Verify Add link",FAIL,"add link is not converted in to change link")
									[ ] 
								[ ] // Verify Go To Website link
								[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.GoToWebsite.Exists(5))
									[ ] ReportStatus("Verify Go To Website link",PASS,"Go To Website link is displayed")
								[+] else
									[ ] ReportStatus("Verify Go To Website link",FAIL,"Go To Website link is not displayed")
									[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Website text field",FAIL,"Website text field is not displayed")
						[+] else
							[ ] ReportStatus("Verify Optional Setting window", FAIL, "Optional setting window is not displayed")
					[+] else
						[ ] ReportStatus("Verify Related Website Add Link",FAIL,"Related Website Add Link is not available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] DlgAddEditReminder.CancelButton.Click (1, 36, 12)
					[ ] 
					[ ] 
				[+] else
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
					[ ] goto SETTING
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify sync to outlook checkbox ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test24_VerifyBillOptionalSettingsSyncOutlook()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality of sync to outlook checkbox in Add Bill Reminder dialog
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 20, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC24_VerifyBillOptionalSettingsSyncOutlook() appstate none
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sAmount
		[ ] 
		[ ] sAmount="30"
		[ ] sReminderType = "Bill"
		[ ] 
		[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10) == True)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bills Tab
		[ ] NavigateQuickenTab(sTAB_BILL)
		[ ] 
		[ ] // Verify Sync to outlook button is not present
		[ ] 
		[ ] 
		[ ] 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
				[ ] 
				[ ] 
				[ ] // Click on Optional setting button and verify objects
				[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.SyncToOutlookCheckBox.Exists(5))
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
					[ ] 
				[ ] 
				[ ] // Verify Sync to Outlook check box
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.SyncToOutlookCheckBox.Exists(5))
					[ ] ReportStatus("Verify Sync to Outlook check box",PASS,"Sync to Outlook check box is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Sync to Outlook check box",FAIL,"Sync to Outlook check box is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] DlgAddEditReminder.DoneButton.Click ()
				[ ] 
				[+] if(MDIClient.Bills.SyncToOutlookButton.Exists(5))
					[ ] ReportStatus("Verify Sync to Outlook check box",PASS,"Sync to Outlook check box is checked on Add {sReminderType} Reminder dialog")
					[ ] ReportStatus("Verify Sync to Outlook button on {sReminderType} window",PASS,"Sync to Outlook button is available")
				[+] else
					[ ] ReportStatus("Verify Sync to Outlook check box",FAIL,"Sync to Outlook check box is not checked on Add {sReminderType} Reminder dialog")
					[ ] ReportStatus("Verify Sync to Outlook button on {sReminderType} window",FAIL,"Sync to Outlook button is not available")
					[ ] 
				[ ] 
				[ ] 
				[+] // else
					[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel2.OptionalSettingsButton.Click()
					[ ] // goto SETTING
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
		[ ] 
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete Single Reminder", PASS, "Single Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete Single Reminder", FAIL, "Single Reminder not deleted")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify print check with quicken check box ###########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test25_VerifyBillOptionalSettingsPrintCheck()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality of print check with quicken check box in Add Bill Reminder dialog
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 20, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC25_VerifyBillOptionalSettingsPrintCheck() appstate none
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sAmount,sMethod
		[ ] BOOLEAN bResult
		[ ] sAmount="10"
		[ ] sReminderType = "Bill"
		[ ] sMethod="Printed Check"
		[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10) == True)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
				[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.TypeKeys(KEY_TAB)
				[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.TypeKeys(KEY_TAB)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
				[ ] 
				[ ] SETTING:
				[ ] // Click on Optional setting button and verify objects
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.PrintCheckWithQuickenCheckBox.Exists(5))
					[ ] // Verify Print check with Quicken check box
					[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.PrintCheckWithQuickenCheckBox.IsChecked())
						[ ] ReportStatus("Verify Print Check with Quicken check box",PASS,"Print Check with Quicken check box is available on Add {sReminderType} Reminder dialog")
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.PrintCheckWithQuickenCheckBox.Check()
					[+] else
						[ ] ReportStatus("Verify Print Check with Quicken check box",FAIL,"Print Check with Quicken is already checked on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] DlgAddEditReminder.DoneButton.Click ()
					[ ] 
					[ ] //Verify Print check
					[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
					[+] if (DlgManageReminders.Exists(5))
						[ ] DlgManageReminders.AllBillsDepositsTab.Click()
						[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
						[ ] 
						[ ] // Verify  payment method
						[ ] bResult = MatchStr("*{sMethod}*",sActual)
						[+] if(bResult==TRUE)
							[ ] ReportStatus("Verification of Print Check for Bill Reminder ", PASS, "Bill Reminder with '{sMethod}' is added successfully")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verification of Print Check for Bill Reminder  ", FAIL, "Bill Reminder for {sMethod} is NOT added, sActual = {sActual}")
							[ ] 
						[ ] DlgManageReminders.Close()
						[ ] 
						[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
						[+] if(iValidate==PASS)
							[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
						[+] else
							[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
					[ ] 
					[ ] 
					[ ] 
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Manage Reminder is NOT added")
						[ ] 
				[+] else
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
					[ ] goto SETTING
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //###############TC26_BillUIEstimateAmount()###################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC26_BillUIEstimateAmount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify UI of Estimate amount for me (change) link window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If all UI controls  Estimate amount for me (change) link window is correct
		[ ] //				        Fail		   If all UI controls  Estimate amount for me (change) link window is not correct
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 14, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC26_BillUIEstimateAmount() appstate none
	[+] //Variable Declaration and defination
		[ ] List of STRING Estimate 
		[ ] 
		[ ] Estimate = {"Fixed amount","Previous payments","Time of year"}
		[ ] sReminderType = "Bill"
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if(QuickenWindow.Exists(10))
			[ ] 
			[ ] QuickenWindow.SetActive()
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] SETTING :
			[ ] // Verify the 'Estimate for Me' dialog is present
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", PASS , "  Estimate Amount Change Link is present under Optional Settings")
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", PASS , " 'Estimate for Me' dialog is present")
					[+] //Verify the UI Controls on the 'Estimate for Me' dialog
						[ ] 
						[+] //Verify the contents in Estimate Popup List on 'Estimate for Me' dialog
							[+] if(DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Exists(5))
								[ ] ReportStatus("Verify Estimate Popup List on 'Estimate for Me' dialog ", PASS , "Estimate Popup List is present on 'Estimate for Me' dialog")
								[ ] 
								[ ] //Get the contents of Quicken Can Help You Estimate PopupList
								[ ] lsCompare=DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.GetContents()
								[ ] 
								[+] //Verify the contents in Estimate Popup List on 'Estimate for Me' dialog
									[+] for(j=1;j<=ListCount(Estimate);j++)
										[+] if(Estimate[j]==lsCompare[j])
											[ ] ReportStatus("Verify the Contents of Estimate Popup List",PASS,"As {lsCompare[j]} is same")
										[+] else
											[ ] ReportStatus("Verify the Contents of Estimate Popup List",FAIL,"As {Estimate[j]},{lsCompare[j]} is not same")
							[ ] 
							[+] else
								[ ] ReportStatus("Verify Estimate Popup List on 'Estimate for Me' dialog", FAIL , "Estimate Popup List is not present on 'Estimate for Me' dialog")
								[ ] 
						[ ] 
						[+] //Verify the contents in Estimate Text Field on 'Estimate for Me' dialog
							[+] if(DlgOptionalSetting.QuickenCanHelpYouEstimateTextField.Exists(5))
								[ ] ReportStatus("Verify Estimate Text Field on 'Estimate for Me' dialog ", PASS , "Estimate Text Field is present on 'Estimate for Me' dialog")
							[+] else
								[ ] ReportStatus("Verify Estimate Text Field on 'Estimate for Me' dialog", FAIL , "Estimate Text Field is not present on 'Estimate for Me' dialog")
						[ ] 
						[+] //Verify the contents in OK Button on 'Estimate for Me' dialog
							[+] if(DlgOptionalSetting.OKButton.Exists(5))
								[ ] ReportStatus("Verify OK Button on 'Estimate for Me' dialog  ", PASS , "OK Button is present on 'Estimate for Me' dialog")
							[+] else
								[ ] ReportStatus("Verify OK Button on 'Estimate for Me' dialog ", FAIL , "OK Button is not present on 'Estimate for Me' dialog")
								[ ] 
						[ ] 
						[+] //Verify the contents in Cancel Button on 'Estimate for Me' dialog
							[+] if(DlgOptionalSetting.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel Button on 'Estimate for Me' dialog ", PASS , "Cancel Button is present on 'Estimate for Me' dialog")
							[+] else
								[ ] ReportStatus("Verify Cancel Button on 'Estimate for Me' dialog", FAIL , "Cancel Button is not present on 'Estimate for Me' dialog")
							[ ] 
							[ ] 
					[ ] 
					[ ] 
					[ ] DlgOptionalSetting.CancelButton.Click()
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", FAIL , " 'Estimate for Me' dialog is not present")
					[ ] 
				[ ] 
				[ ] DlgAddEditReminder.CancelButton.Click()
				[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //###############TC27_BillFunctionalityPreviousPayments()#########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC27_BillFunctionalityPreviousPayments()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Previous Payments in Estimate amount for me 
		[ ] //  change) link in Add Bill Reminder dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Previous Payments in Estimate amount for me (change) link is correct
		[ ] //        Fail		   If functionality of Previous Payments in Estimate amount for me (change) link is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 14, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC27_BillFunctionalityPreviousPayments() appstate none
	[+] //Variable Declaration and defination
		[ ] INTEGER iOpenAccountRegister,iEnterTransaction
		[ ] STRING sAmount,sAmountCompare,sDate1,sDate2,sDate3
		[ ] LIST OF STRING lsDate
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sPayeeName="Test Biller 1"
		[ ] sDate1 = ModifyDate(-35,sDateFormat)
		[ ] sDate2 = ModifyDate(-65,sDateFormat)
		[ ] sDate3 = ModifyDate(-365,sDateFormat)
		[ ] lsDate={sDate1,sDate2,sDate3}
		[ ] lsExcelData=ReadExcelTable(sExcelDataFile, sCheckingTransactionWorksheet)
		[ ] sAmountCompare=lsExcelData[1][6]
		[ ] 
	[ ] // Verify that Quicken islaunched
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] 
		[ ] // Opening Checking Account Register
		[ ] iOpenAccountRegister=AccountBarSelect(sAccountType,1)
		[ ] 
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] ReportStatus("Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] // //Entering two transactions in Register
			[ ] 
			[+] for(i=1;i<=ListCount(lsExcelData);i++)
				[ ] 
				[ ] // Fetch ith row from the given sheet
				[ ] lsTransactionData=lsExcelData[i]
				[ ] iEnterTransaction=AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],lsDate[i],lsTransactionData[4],lsTransactionData[5])
				[ ] ReportStatus("Add Checking Transaction",iEnterTransaction,"Transaction {i} added")
				[ ] 
			[ ] // //Navigation to Bills > Add Bill > Enter payee > Click Next
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[ ] 
			[+] if(iValidate==PASS)
				[ ] SETTING :
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", PASS , "  Estimate Amount Change Link is present under Optional Settings")
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
					[ ] 
					[+] //verify the functionality of Previous Payments option
						[+] if(DlgOptionalSetting.Exists(5))
							[ ] 
							[ ] ReportStatus("Verify  'Estimate for Me' dialog present", PASS , " 'Estimate for Me' dialog is present")
							[ ] 
							[ ] 
							[ ] //Select the second option from Estimate Popup List on 'Estimate for Me' dialog for Previous Payments
							[ ] DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Select("#2")
							[ ] 
							[ ] 
							[ ] //Set '2'as last payments
							[ ] DlgOptionalSetting.LastTextField.SetText("2")
							[ ] 
							[ ] DlgOptionalSetting.OKButton.Click()
							[ ] 
							[ ] //AmountDue
							[ ] //Amount gets calculated automatically from Previous Payments
							[ ] sAmount=DlgAddEditReminder.Step2Panel.QWinChild1.EstimatedAmountText.GetText()
							[ ] //.AmountDue.GetText()
							[ ] 
							[ ] 
							[ ] print(sAmount)
							[ ] 
							[ ] //Verify the Average amount for previous payments
							[ ] bMatch=MatchStr("*{sAmountCompare}*",sAmount)
							[ ] 
							[+] if(bMatch ==TRUE)
								[ ] ReportStatus("Verify Estimate Amount :Previous Payments option ", PASS , "Previous Payments option is set properly as it is showing Average amount{sAmount}")
							[+] else
								[ ] ReportStatus("Verify Estimate Amount :Previous Payments option ", FAIL , "Previous Payments option is not set properly as it is not showing Average amount same {sAmount},{sAmountCompare}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify  'Estimate for Me' dialog present", FAIL , " 'Estimate for Me' dialog is not present")
				[+] else
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
					[ ] 
					[ ] goto SETTING
					[ ] 
				[ ] DlgAddEditReminder.Close()
				[ ] 
				[ ] 
			[+] else 
				[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
		[+] // else
			[ ] // ReportStatus("Account is selected from AccountBar", FAIL , "Account is not selected from AccountBar")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //###############TC28_BillFunctionalityFixedAmount()##############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC28_BillFunctionalityFixedAmount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Fixed Amount in Estimate amount for me  
		[ ] // (change) link in Add Bill Reminder dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Fixed Amount in Estimate amount for me (change) link is correct
		[ ] //        Fail		   If functionality of Previous Payments in Estimate amount for me (change) link is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 15, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC28_BillFunctionalityFixedAmount() appstate none
	[+] //Variable Declaration and defination
		[ ] INTEGER iOpenAccountRegister,iEnterTransaction
		[ ] STRING sAmount,sAmountCompare 
		[ ] 
		[ ] sAmount="50.00"
		[ ] sReminderType = "Bill"
		[ ] 
	[ ] // Verify that Quicken is launched
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenMainWindow.VerifyEnabled(TRUE,20)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] SETTING :
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", PASS , "  Estimate Amount Change Link is present under Optional Settings")
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", PASS , " 'Estimate for Me' dialog is present")
					[ ] 
					[+] //verify the functionality of Fixed Amounts option
						[ ] 
						[ ] //select first option for Fixed Amount
						[ ] DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Select("#1")
						[ ] 
						[ ] //set Fixed Amount 
						[ ] DlgOptionalSetting.QuickenCanHelpYouEstimateTextField.SetText(sAmount)
						[ ] 
						[ ] DlgOptionalSetting.OKButton.Click()
						[ ] 
						[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
						[ ] 
						[ ] sAmountCompare=DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.GetText()
						[ ] 
						[ ] //Verify the fixed amount is set
						[+] if(sAmount == sAmountCompare)
							[ ] ReportStatus("Verify Estimate Amount :Fixed Amount option ", PASS , "Fixed Amount option is set properly as {sAmount} ")
						[+] else
							[ ] ReportStatus("Verify Estimate Amount :Fixed Amount option ", FAIL , "Fixed Amount option is not set properly as it is not same {sAmount},{sAmountCompare}")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", FAIL , " 'Estimate for Me' dialog is not present")
				[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
				[ ] 
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
			[ ] DlgAddEditReminder.CancelButton.Click()
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //###############TC29_BillFunctionalityTimeofYear()###############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC29_BillFunctionalityTimeofYear()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Time of Year in Estimate amount for me  
		[ ] // (change) link in Add Bill Reminder dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Time of Year in Estimate amount for me (change) link is correct
		[ ] //        Fail		   If functionality of Previous Payments in Estimate amount for me (change) link is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 15, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC29_BillFunctionalityTimeofYear() appstate none
	[+] //Variable Declaration and defination
		[ ] INTEGER iOpenAccountRegister,iEnterTransaction
		[ ] STRING sAmount,sAmountCompare
		[ ] 
		[ ] sAmountCompare ="$500.00"
		[ ] sReminderType = "Bill"
		[ ] sPayeeName="Insurance Bill"
	[ ] // Verify that Quicken is launched
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenMainWindow.VerifyEnabled(TRUE,20)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] SETTING :
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", PASS , "  Estimate Amount Change Link is present under Optional Settings")
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
				[ ] 
				[ ] //verify the functionality of Time of Year option
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", PASS, " 'Estimate for Me' dialog is present")
					[ ] 
					[ ] //Time of year gets selected and it will automatically insert the last year paid amount 
					[ ] 
					[ ] DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Select("#3")
					[ ] 
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] //Verify the amount with last year amount
					[ ] sAmount=DlgAddEditReminder.Step2Panel.QWinChild1.EstimatedAmountText.GetText()
					[ ] 
					[+] if(sAmount == sAmountCompare)
						[ ] ReportStatus("Verify Estimate Amount :Time of Year option ", PASS , "Time of Year option is set properly as it is showing Last year amount{sAmountCompare}")
					[+] else
						[ ] ReportStatus("Verify Estimate Amount :Time of Year option ", FAIL , "Time of Year option is not set properly as it is not showing Last year amount {sAmount},{sAmountCompare}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", FAIL , " 'Estimate for Me' dialog is not present")
			[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
				[ ] 
			[ ] 
			[ ] 
			[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
		[ ] 
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //###############TC31_BillFunctionalityCancelButton()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC31_BillFunctionalityCancelButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Cancel button on "Add Bill Reminder" dialog 
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Cancel button is correct
		[ ] //        Fail		   If functionality of Cancel button is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC31_BillFunctionalityCancelButton() appstate none 
	[+] //Variable Declaration and defination
		[ ] INTEGER iSetupAutoAPI 
		[ ] STRING sAmount,sAmountCompare
		[ ] List of ANYTYPE  lsReminderList
		[ ] 
		[ ] sAmount="500.00"
		[ ] sReminderType = "Bill"
		[ ] sPayeeName="CancelButtonPayee"
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] //Set the Amount 
			[ ] DlgAddEditReminder.SetActive()
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
			[ ] 
			[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.SetActive()
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
				[ ] 
				[+] for(iCount=0; iCount<=iListCount ; iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch = MatchStr("*{sPayeeName}*",sActual)
					[+] if (bMatch)
						[ ] break
				[ ] 
				[ ] 
				[+] if (bMatch==FALSE)
					[ ] ReportStatus("Verify Reminder is not added", PASS, "{sPayeeName} is not availble in Manage Reminders so Cancel Button is working ")
				[+] else
					[ ] ReportStatus("Verify Reminder is added", FAIL, "{sPayeeName} is available in Manage Reminders so Cancel Button is not working")
				[ ] DlgManageReminders.SetActive()
				[ ] DlgManageReminders.Close()
				[+] WaitForState(DlgManageReminders ,FALSE ,5)
					[ ] 
			[+] else
				[ ] ReportStatus("Launch Manage Reminder ", FAIL, "Manage Reminder dialog is NOT launched")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //###############TC32_BillFunctionalityHelpIcon()#################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC32_BillFunctionalityHelpIcon()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of help icon on Add Bill Reminder dialog
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of help icon is correct
		[ ] //        Fail		   If functionality of help icon is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC32_BillFunctionalityHelpIcon() appstate none 
	[ ] // Verify that Quicken is launched
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenMainWindow.VerifyEnabled(TRUE,20)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //Navigation to Home Tab
		[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
		[ ] ReportStatus("Navigate to {sTAB_BILL} > {sTAB_UPCOMING}", iValidate, "Navigate to {sTAB_BILL} > {sTAB_UPCOMING}")
		[ ] 
		[ ] 
		[+] if(QuickenMainWindow.QWNavigator.AddReminder.Exists(5))
			[ ] ReportStatus("Upcoming from Bills Menu", PASS , "Upcoming is available as Add Reminder Button is displayed")
			[ ] 
			[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] //Verify Help icon on Add Bill Reminder
			[+] if(DlgAddEditReminder.HelpButton.Exists(5))
				[ ] ReportStatus("Verify  Help Icon on Add Bill Reminder", PASS , "Help Icon is present in Add Bill Reminder dialog ")
				[ ] 
				[ ] DlgAddEditReminder.HelpButton.click()
				[ ] sleep(3)
				[ ] 
				[+] //Help Dialog gets opened
					[+] if(QuickenHelp.Exists(5))
						[ ] ReportStatus("Verify Help Dialog ", PASS , "Help Dialog is present ")
						[ ] QuickenHelp.Close()
					[+] else
						[ ] ReportStatus("Verify Help Dialog", FAIL , "Help Dialog is not present")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify  Help Icon on Add Bill Reminder", FAIL , "Help Icon is not present in Add Bill Reminder dialog ")
				[ ] 
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
		[+] else 
			[ ] ReportStatus("Upcoming from Bills Menu", FAIL , "Upcoming is not available as Add Reminder Button is not displayed")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
		[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //###############TC33_BillFunctionalityBackButton()##############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC33_BillFunctionalityBackButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Back button on "Add Bill Reminder" dialog
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Back button  is correct
		[ ] //        Fail		   If functionality of Back button  is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC33_BillFunctionalityBackButton() appstate none 
	[+] //Variable Declaration and defination
		[ ] STRING sAmount,sPayeeName
		[ ] 
		[ ] sAmount="500.00"
		[ ] sPayeeName="BackButtonPayee"
		[ ] sReminderType = "Bill"
	[ ] // Verify that Quicken is launched
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenMainWindow.VerifyEnabled(TRUE,20)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
				[ ] 
				[ ] //Set the Amount 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
				[ ] 
				[+] //verifying some Objects present on Second Screen of Add Bill Reminder before Back Button is clicked
					[ ] 
					[ ] // Verify Due Next On Textbox on Add Bill Reminder Second Screen
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.Exists(5))
						[ ] ReportStatus("Verify Due Next On Textbox on Add Bill Reminder Second Screen", PASS , "Due Next On Textbox is present on Add Bill Reminder Second Screen ")
					[+] else
						[ ] ReportStatus("Verify Due Next On Textbox on Add Bill Reminder Second Screen", FAIL , "Due Next On Textbox is not present on Add Bill Reminder Second Screen")
					[ ] 
					[ ] // Verify OptionalSettings on Add Bill Reminder Second Screen
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Exists(5))
						[ ] ReportStatus("Verify OptionalSettings on Add Bill Reminder Second Screen", PASS , "OptionalSettings is present on Add Bill Reminder Second Screen")
					[+] else
						[ ] ReportStatus("Verify OptionalSettings on Add Bill Reminder Second Screen", FAIL , "OptionalSettings is not present on Add Bill Reminder Second Screen")
					[ ] 
					[ ] //Click Back Button
					[ ] DlgAddEditReminder.BackButton.Click()
					[ ] 
				[+] //verifying some Objects of Second Screen present on First Screen of Add Bill Reminder after Back Button is clicked
					[+] if(DlgAddEditReminder.Exists(5))
						[ ] ReportStatus("Verify Add Bill Reminder dailog is present after Back Button clicked",PASS,"Add Bill Reminder dailog is present after Back Button clicked")
						[ ] 
						[+] // // Verify Add Category Tag Memo Panel on Add Bill Reminder First Screen
							[+] // if(!DlgAddEditReminder.Step2Panel.QWinChild1.Panel1.AddCategoryTagOrMemo.Exists(5))
								[ ] // ReportStatus("Verify Add Category Tag Memo Panel on Add Bill Reminder First Screen",PASS , "Add Category Tag Memo Panel is not present on Add Bill Reminder First Screen so Back Button is working")
							[+] // else
								[ ] // ReportStatus("Verify Add Category Tag Memo Panel on Add Bill Reminder First Screen",FAIL , "Add Category Tag Memo Panel is present on Add Bill Reminder First Screen so Back Button is not working")
						[+] // Verify Add Category Tag Memo Panel on Add Bill Reminder First Screen
							[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.Exists(5))
								[ ] ReportStatus("Verify Amount Due on Add Bill Reminder First Screen", PASS ,"Amount Due is not present on Add Bill Reminder First Screen so Back Button is working")
							[+] else
								[ ] ReportStatus("Verify Amount Due on Add Bill Reminder First Screen", FAIL ,"Amount Due is present on Add Bill Reminder First Screenso Back Button is not working")
								[ ] 
					[+] else
						[ ] ReportStatus("Verify Add Bill Reminder dailog is present after Back Button clicked",FAIL,"Add Bill Reminder dailog is not present after Back Button clicked")
						[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
						[ ] DlgAddEditReminder.CancelButton.Click()
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
			[ ] 
		[ ] 
		[+] if(DlgAddEditReminder.Exists(5))
			[ ] DlgAddEditReminder.Close()
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[+] //############# TC35_AddIncomeReminderScreenOneUI() #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC35_AddIncomeReminderScreenOneUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify UI controls present on Add Income Reminder first screen
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC35_AddIncomeReminderScreenOneUI() appstate QuickenBaseState
	[ ] 
	[+] //Variable declaration and defination
		[ ] STRING sAccountType,sAccountName,sAccountBalance,sAccountCreateDate, sDialogName, sActualName
		[ ] boolean bCheckStatus
		[ ] 
		[ ] sFileName = "Scheduled_Transactions"
		[ ] sActualName = "Add Income Reminder"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] SetUp_AutoApi()
		[ ] 
	[+] else
		[+] if(FileExists(sDataFile) == TRUE)
			[ ] DeleteFile(sDataFile)
			[ ] 
		[ ] QuickenMainWindow.Start (sCmdLine)
		[ ] 
	[ ] // Open data file
	[ ] sCaption = QuickenMainWindow.GetCaption()
	[ ] bCaption = MatchStr("*{sFileName}*", sCaption)
	[+] if(bCaption == FALSE)
		[ ] bExists = FileExists(sDataFile)
		[+] if(bExists == TRUE)
			[ ] DeleteFile(sDataFile)
			[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
		[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
		[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
		[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
		[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
		[ ] iValidate =VerifyReminderDialog(sActualName)
		[+] if(iValidate ==PASS)
			[ ] ReportStatus("Add Income Reminder flow  ", PASS, "Add Income Reminder flow is launched from Upcoming tab")
			[ ] 
			[ ] //Verify UI objects for Add Income Reminder First Screen
			[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.Exists(5))
				[ ] ReportStatus("Verify From Textbox ", PASS , "From textbox is displayed")
			[+] else
				[ ] ReportStatus("Verify From Textbox ", FAIL , "From textbox is not displayed")
			[ ] 
			[+] if(DlgAddEditReminder.CancelButton.Exists(5))
				[ ] ReportStatus("Verify Cancel Button", PASS , "Cancel button is displayed")
			[+] else
				[ ] ReportStatus("Verify Cancel Button", FAIL , "Cancel button is not displayed")
			[ ] 
			[+] if(DlgAddEditReminder.NextButton.Exists(5))
				[ ] ReportStatus("Verify Next Button", PASS , "Next button is displayed")
			[+] else
				[ ] ReportStatus("Verify Next Button", FAIL , "Next button is not displayed")
			[ ] 
			[+] if(DlgAddEditReminder.PaycheckSetupText.Exists(5))
				[ ] ReportStatus("Verify Paycheck Setup Text ", PASS , "Paycheck Setup Text Link is displayed")
			[+] else
				[ ] ReportStatus("Verify Next Button", FAIL , "Paycheck Setup Text Link is NOT displayed")
			[ ] DlgAddEditReminder.Close()
		[+] else
			[ ] ReportStatus("Add Income Reminder flow  ", FAIL, "Add Income Reminder flow is NOT launched from Upcoming tab")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window ", FAIL, "Quicken Main Window is NOT present")
	[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //############# TC36_AddIncomeReminderScreenTwoUI() #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC36_AddIncomeReminderScreenTwoUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify UI controls present on Add Income Reminder second screen
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC36_AddIncomeReminderScreenTwoUI() appstate QuickenBaseState
	[ ] 
	[+] //Variable declaration and defination
		[ ] STRING sAccountType,sAccountName,sAccountBalance,sAccountCreateDate, sDialogName, sActualName, sPayeeName
		[ ] boolean bCheckStatus
		[ ] 
		[ ] sFileName = "Scheduled_Transactions"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sAccountType ="Checking"
		[ ] sAccountName = "Checking 01"
		[ ] sAccountBalance = "5000"
		[ ] sAccountCreateDate = sDateStamp
		[ ] sPayeeName = "Test Income Reminder"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] SetUp_AutoApi()
		[ ] 
	[+] else
		[+] if(FileExists(sDataFile) == TRUE)
			[ ] DeleteFile(sDataFile)
			[ ] 
		[ ] QuickenMainWindow.Start (sCmdLine)
		[ ] 
	[ ] // Open data file
	[ ] sCaption = QuickenMainWindow.GetCaption()
	[ ] bCaption = MatchStr("*{sFileName}*", sCaption)
	[+] if(bCaption == FALSE)
		[ ] bExists = FileExists(sDataFile)
		[+] if(bExists == TRUE)
			[ ] DeleteFile(sDataFile)
			[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] //Add a manual checking account.
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] sActualName = "Add Income Reminder"
		[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
		[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
		[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
		[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
		[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
		[ ] iValidate =VerifyReminderDialog(sActualName)
		[+] if(iValidate ==PASS)
			[ ] ReportStatus("Add Income Reminder flow  ", PASS, "Add Income Reminder flow is launched from Upcoming tab")
			[ ] 
			[ ] //Verify UI objects for Add Income Reminder Second Screen
			[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.SetText(sPayeeName)
			[ ] DlgAddEditReminder.TypeKeys(KEY_TAB)
			[ ] DlgAddEditReminder.NextButton.Click()
			[+] // if(DlgAddEditReminder.Step2Panel.Exists(5))
				[ ] // ReportStatus("Add Income Reminder flow  ", PASS, "Add Income Reminder Second screen is displayed")
				[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.Exists(5))
				[ ] ReportStatus("Verify Due Next On Textbox", PASS , "Due Next On Textbox is displayed")
			[+] else
				[ ] ReportStatus("Verify Due Next On Textbox", FAIL , "Due Next On Textbox is not displayed")
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Exists(5))
				[ ] ReportStatus("Verify Change link", PASS , "Change link is displayed")
			[+] else
				[ ] ReportStatus("Verify Change link", FAIL , "Change link is not displayed")
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.Exists(5))
				[ ] ReportStatus("Verify AmountDue", PASS , "AmountDue is displayed")
			[+] else
				[ ] ReportStatus("Verify AmountDue", FAIL , "AmountDue is not displayed")
			[ ] 
			[ ] //DlgAddEditReminder.Step2Panel.QWinChild1.CalculatorButton.Click()
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.Exists(5))
				[ ] ReportStatus("Verify FromAccount Textbox", PASS , "To Account Textbox is displayed")
			[+] else
				[ ] ReportStatus("Verify FromAccount Textbox", FAIL , "To Account Textbox is displayed")
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DetailsText.Exists(5))
				[ ] ReportStatus("Verify Details Text", PASS , "Details  Text  is displayed")
			[+] else
				[ ] ReportStatus("Verify Details Text", FAIL , "Details Text is not displayed")
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Exists(5))
				[ ] ReportStatus("Verify AddCategoryTagOrMemo Panel", PASS , "AddCategoryTagOrMemo Panel  is displayed")
			[+] else
				[ ] ReportStatus("Verify AddCategoryTagOrMemo Panel", FAIL , "AddCategoryTagOrMemo Panel  is not displayed")
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Exists(5))
				[ ] ReportStatus("Verify OptionalSettings", PASS , "OptionalSettings is displayed")
			[+] else
				[ ] ReportStatus("Verify OptionalSettings", FAIL , "OptionalSettings is not displayed")
			[ ] 
			[+] if(DlgAddEditReminder.BackButton.Exists(5))
				[ ] ReportStatus("Verify Back Button", PASS , "Back Button is displayed")
			[+] else
				[ ] ReportStatus("Verify Back Button", FAIL , "Back Button is not displayed")
				[ ] 
			[ ] 
			[+] if(DlgAddEditReminder.DoneButton.Exists(5))
				[ ] ReportStatus("Verify Done Button", PASS , "Done Button is displayed")
			[+] else
				[ ] ReportStatus("Verify Done Button", FAIL , "Done Button is not displayed")
			[ ] 
			[+] if(DlgAddEditReminder.CancelButton.Exists(5))
				[ ] ReportStatus("Verify Cancel Button", PASS , "Cancel Button is displayed")
			[+] else
				[ ] ReportStatus("Verify Cancel Button", FAIL , "Cancel Button is not displayed")
			[ ] 
			[+] if(DlgAddEditReminder.HelpButton.Exists(5))
				[ ] ReportStatus("Verify Help Button", PASS , "Help Button is displayed")
			[+] else
				[ ] ReportStatus("Verify Help Button", FAIL , "Help Button is not displayed")
				[ ] 
			[ ] 
			[ ] DlgAddEditReminder.Close()
		[+] else
			[ ] ReportStatus("Add Income Reminder flow  ", FAIL, "Add Income Reminder flow is NOT launched from Upcoming tab")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window ", FAIL, "Quicken Main Window is NOT present")
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //############# TC37_NextButtonAddIncomeReminderFirstScreen() ##################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC37_NextButtonAddIncomeReminderFirstScreen()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify 'Next' button functionality of Add Income Reminder first screen
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC37_NextButtonAddIncomeReminderFirstScreen() appstate QuickenBaseState
	[ ] 
	[+] //Variable declaration and defination
		[ ] STRING sAccountType,sAccountName,sAccountBalance,sAccountCreateDate, sDialogName, sActualName, sPayeeName
		[ ] boolean bCheckStatus
		[ ] 
		[ ] sActualName = "Add Income Reminder"
		[ ] sPayeeName = "Test Income Reminder"
		[ ] 
	[ ] 
	[+] // if(QuickenWindow.Exists(10))
		[ ] // QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] // QuickenWindow.SetActive()
		[ ] // QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] // iSetupAutoAPI = SetUp_AutoApi()
		[ ] // ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] // 
	[+] // else
		[+] // if(FileExists(sDataFile) == TRUE)
			[ ] // DeleteFile(sDataFile)
			[ ] // 
		[ ] // QuickenMainWindow.Start (sCmdLine)
		[ ] // 
	[ ] // // Open data file
	[ ] // sCaption = QuickenWindow.GetCaption()
	[ ] // bCaption = MatchStr("*{sFileName}*", sCaption)
	[+] // if(bCaption == FALSE)
		[ ] // bExists = FileExists(sDataFile)
		[+] // if(bExists == TRUE)
			[ ] // DeleteFile(sDataFile)
			[ ] // 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] ReportStatus("Manual Checking Account ", PASS, "Manual checking account is added")
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
		[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
		[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
		[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
		[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
		[ ] iValidate =VerifyReminderDialog(sActualName)
		[+] if(iValidate ==PASS)
			[ ] ReportStatus("Add Income Reminder flow  ", PASS, "Add Income Reminder flow is launched from Upcoming tab")
			[ ] 
			[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.SetText(sPayeeName)
			[ ] //DlgAddEditReminder.TypeKeys(KEY_TAB)
			[ ] DlgAddEditReminder.NextButton.Click()
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Exists(15))
				[ ] ReportStatus("Add Income Reminder flow  ", PASS, "Clicking 'Next' button launches Add Income Reminder Second screen ")
			[+] else
				[ ] ReportStatus("Add Income Reminder flow  ", FAIL, "Clicking 'Next' button does NOT launches Add Income Reminder Second screen ")
			[ ] DlgAddEditReminder.Close()
		[+] else
			[ ] ReportStatus("Add Income Reminder flow  ", FAIL, "Add Income Reminder flow is NOT launched from Upcoming tab")
	[+] else
		[ ] ReportStatus("Quicken Main Window ", FAIL, "Quicken Main Window is NOT present")
	[ ] 
[ ] //###########################################################################
[ ] 
[+] // ###############TC38_IncomeReminderFrequencyChangeLink()#####################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC38_IncomeReminderFrequencyChangeLink()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify available options for frequency selection for due date in change link for income reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If all the options are available for frequency selection for due date in change link
		[ ] //				        	Fail		   If options are not available
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 21, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC38_IncomeReminderFrequencyChangeLink() appstate QuickenBaseState
	[ ] 
	[+] //Variable declaration and defination
		[ ] STRING sAccountType,sAccountName,sAccountBalance,sAccountCreateDate, sDialogName, sActualName, sPayeeName
		[ ] boolean bCheckStatus
		[ ] LIST of STRING lsHowoften, lsEndDate, lsCompare
		[ ] 
		[ ] sActualName = "Add Income Reminder"
		[ ] 
		[ ] 
		[ ] sFileName = "Scheduled_Transactions"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sPayeeName = "Test Income Reminder"
		[ ] sReminderType = "Income"
		[ ] lsHowoften = {"Weekly","Bi-weekly","Monthly","Twice a month","Quarterly","Yearly","Twice a year","Only once","to pay estimated taxes"}
		[ ] lsEndDate = {"No end date","End on","End after"}
	[ ] 
	[+] // if(QuickenWindow.Exists(10))
		[ ] // QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] // QuickenWindow.SetActive()
		[ ] // QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] // iSetupAutoAPI = SetUp_AutoApi()
		[ ] // ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] // 
	[+] // else
		[+] // if(FileExists(sDataFile) == TRUE)
			[ ] // DeleteFile(sDataFile)
			[ ] // 
		[ ] // QuickenMainWindow.Start (sCmdLine)
		[ ] // 
	[ ] // // Open data file
	[ ] // sCaption = QuickenMainWindow.GetCaption()
	[ ] // bCaption = MatchStr("*{sFileName}*", sCaption)
	[+] // if(bCaption == FALSE)
		[ ] // bExists = FileExists(sDataFile)
		[+] // if(bExists == TRUE)
			[ ] // DeleteFile(sDataFile)
			[ ] // 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Launch add bill reminder dialog, enter payee and click Next.
		[ ] NavigateReminderDetailsPage(sReminderType, sPayeeName)
		[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Exists(5))
			[ ] ReportStatus("Add Income Reminder flow  ", PASS, "Clicking 'Next' button launches Add Income Reminder Second screen ")
			[ ] 
			[ ] 
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
			[ ] //Verify available options for frequency selection for due date for income reminder.
			[+] if(DlgOptionalSetting.Exists(25))
				[ ] ReportStatus("Verify frequency options ", PASS, "Dialog with different frequency options is launched")
				[ ] 
				[+] if(DlgOptionalSetting.StartDateTextField.Exists(5))
					[ ] ReportStatus("Verify Start Date Text Field", PASS , "Start Date TextField is displayed")
				[+] else
					[ ] ReportStatus("Verify Start Date Text Field", FAIL , "Start Date TextField is not displayed")
				[ ] 
				[+] if(DlgOptionalSetting.HowOftenPopupList.Exists(5))
					[ ] ReportStatus("Verify How often Popup ", PASS , "How often Popup is displayed")
				[+] else
					[ ] ReportStatus("Verify How often Popup", FAIL , "How often Popup is not displayed")
				[ ] 
				[ ] lsCompare=DlgOptionalSetting.HowOftenPopupList.GetContents()
				[ ] ListDelete (lsCompare,9)
				[ ] ListDelete (lsCompare,5)
				[ ] 
				[+] for(i=1;i<=ListCount(lsCompare);i++)
					[ ] 
					[+] if(lsHowoften[i]==lsCompare[i])
						[ ] ReportStatus("Verify the Contents of How often List",PASS,"As {lsHowoften[i]} = {lsCompare[i]} is same")
					[+] else
						[ ] ReportStatus("Verify the Contents of How often List",FAIL,"As {lsHowoften[i]} = {lsCompare[i]} is NOT same")
				[ ] 
				[+] if(DlgOptionalSetting.EveryUpDown.Exists(5))
					[ ] ReportStatus("Verify Every Up Down ", PASS , "Every Up Down is displayed")
				[+] else
					[ ] ReportStatus("Verify Every Up Down", FAIL , "Every Up Down is not displayed")
				[ ] 
				[+] if(DlgOptionalSetting.MonthOnThePopupList.Exists(5))
					[ ] ReportStatus("Verify Month On The PopupList ", PASS , "Month On The PopupList is displayed")
				[+] else
					[ ] ReportStatus("Verify Month On The PopupList", FAIL , "Month On The PopupList is not displayed")
				[ ] 
				[+] if(DlgOptionalSetting.DayPopupList.Exists(5))
					[ ] ReportStatus("Verify Day PopupList ", PASS , "Day PopupList is displayed")
				[+] else
					[ ] ReportStatus("Verify Day PopupList", FAIL , "Day PopupList is not displayed")
				[ ] 
				[+] if(DlgOptionalSetting.EndDatePopupList.Exists(5))
					[ ] ReportStatus("Verify End Date PopupList ", PASS , "End Date PopupList is displayed")
				[+] else
					[ ] ReportStatus("Verify End Date PopupList", FAIL , "End Date PopupList is not displayed")
				[ ] 
				[ ] lsCompare=DlgOptionalSetting.EndDatePopupList.GetContents()
				[+] for(i=1;i<=ListCount(lsCompare);i++)
					[ ] 
					[+] if(lsEndDate[i]==lsCompare[i])
						[ ] ReportStatus("Verify the Contents of End Date List",PASS,"As {lsHowoften[i]} = {lsCompare[i]} is same")
					[+] else
						[ ] ReportStatus("Verify the Contents of End Date LIST",FAIL,"As {lsHowoften[i]} = {lsCompare[i]} is same")
				[ ] 
				[+] if(DlgOptionalSetting.OKButton.Exists(5))
					[ ] ReportStatus("Verify OK Button ", PASS , "OK Button is displayed")
				[+] else
					[ ] ReportStatus("Verify OK Button", FAIL , "OK Button is not displayed")
				[ ] 
				[+] if(DlgOptionalSetting.CancelButton.Exists(5))
					[ ] ReportStatus("Verify Cancel Button ", PASS , "Cancel Button is displayed")
				[+] else
					[ ] ReportStatus("Verify Cancel Button", FAIL , "Cancel Button is not displayed")
					[ ] 
				[ ] DlgOptionalSetting.CancelButton.Click()
			[+] else
				[ ] ReportStatus("Verify frequency options ", FAIL, "Dialog with different frequency options is NOT launched")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Income Reminder flow  ", FAIL, "Clicking 'Next' button does NOT launches Add Income Reminder Second screen ")
		[ ] DlgAddEditReminder.Close()
	[+] else
		[ ] ReportStatus("Quicken Main Window ", FAIL, "Quicken Main Window is NOT present")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] // ###############TC39_UIAddCategoryTagMemoPanel())###########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC39_UIAddCategoryTagMemoPanel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify UI of Add Category, tag or memo panel for income reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If all the options are available for frequency selection for due date in change link
		[ ] //				        	Fail		   If options are not available
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 21, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC39_UIAddCategoryTagMemoPanel() appstate QuickenBaseState
	[ ] 
	[+] //Variable declaration and defination
		[ ] STRING  sDialogName, sActualName, sPayeeName
		[ ] boolean bCheckStatus
		[ ] LIST of STRING lsHowoften, lsEndDate, lsCompare
		[ ] 
		[ ] sFileName = "Scheduled_Transactions"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sPayeeName = "Test Income Reminder"
		[ ] sActualName = "Add Income Reminder"
		[ ] sReminderType = "Income"
		[ ] 
	[ ] 
	[+] // if(QuickenWindow.Exists(10))
		[ ] // QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] // QuickenWindow.SetActive()
		[ ] // QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] // iSetupAutoAPI = SetUp_AutoApi()
		[ ] // ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] // 
	[+] // else
		[+] // if(FileExists(sDataFile) == TRUE)
			[ ] // DeleteFile(sDataFile)
			[ ] // 
		[ ] // QuickenMainWindow.Start (sCmdLine)
		[ ] // 
	[ ] // // Open data file
	[ ] // sCaption = QuickenMainWindow.GetCaption()
	[ ] // bCaption = MatchStr("*{sFileName}*", sCaption)
	[+] // if(bCaption == FALSE)
		[ ] // bExists = FileExists(sDataFile)
		[+] // if(bExists == TRUE)
			[ ] // DeleteFile(sDataFile)
			[ ] // 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] ReportStatus("Manual Checking Account ", PASS, "Manual checking account is added")
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Launch add bill reminder dialog, enter payee and click Next.
		[ ] NavigateReminderDetailsPage(sReminderType, sPayeeName)
		[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Exists(5))
			[ ] ReportStatus("Add Income Reminder flow  ", PASS, "Clicking 'Next' button launches Add Income Reminder Second screen ")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
			[ ] 
			[+] if(DlgOptionalSetting.CategoryTextField.Exists(5))
				[ ] ReportStatus("Verify Category Text Field", PASS , "Category Text Field is displayed")
			[+] else
				[ ] ReportStatus("Verify Category Text Field", FAIL , "Category Text Field is not displayed")
				[ ] 
			[ ] 
			[+] if(DlgOptionalSetting. SplitCategoryButton.Exists(5))
				[ ] ReportStatus("Verify  Split Category Button ", PASS , " Split Category Button is displayed")
			[+] else
				[ ] ReportStatus("Verify Split Category Button", FAIL , " Split Category Button is not displayed")
			[ ] 
			[+] if(DlgOptionalSetting.TagTextField.Exists(5))
				[ ] ReportStatus("Verify Tag Text Field ", PASS , " Tag Text Field is displayed")
			[+] else
				[ ] ReportStatus("Verify Tag Text Field", FAIL , "Tag Text Field is not displayed")
			[ ] 
			[+] if(DlgOptionalSetting.MemoTextField.Exists(5))
				[ ] ReportStatus("Verify Memo Text Field ", PASS , "Memo Text Field is displayed")
			[+] else
				[ ] ReportStatus("Verify Memo Text Field", FAIL , "Memo Text Field is not displayed")
			[ ] 
			[+] if(DlgOptionalSetting.OKButton.Exists(5))
				[ ] ReportStatus("Verify OK Button ", PASS , "OK Button is displayed")
			[+] else
				[ ] ReportStatus("Verify OK Button", FAIL , "OK Button is not displayed")
			[ ] 
			[+] if(DlgOptionalSetting.CancelButton.Exists(5))
				[ ] ReportStatus("Verify Cancel Button ", PASS , "Cancel Button is displayed")
			[+] else
				[ ] ReportStatus("Verify Cancel Button", FAIL , "Cancel Button is not displayed")
			[ ] 
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.CancelButton.Click()
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
			[ ] 
		[+] else
			[ ] ReportStatus("Add Income Reminder flow  ", FAIL, "Clicking 'Next' button does NOT launches Add Income Reminder Second screen ")
		[ ] DlgAddEditReminder.Close()
	[+] else
		[ ] ReportStatus("Quicken Main Window ", FAIL, "Quicken Main Window is NOT present")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] // ###############TC40_FunctionalityAddCategoryTagMemo()########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC40_FunctionalityAddCategoryTagMemo()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of "Add category, tag or memo" for Income Reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If funcionality of Add Category, tag or memo panel dialog is working correctly
		[ ] //				        	Fail		   If funcionality is not working
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 22, 2013		Suyash Joshi	created
	[ ] // **************************************************************************************
[+] testcase TC40_FunctionalityAddCategoryTagMemo() appstate QuickenBaseState
	[ ] 
	[+] //Variable declaration and defination
		[ ] INTEGER iValidate
		[ ] STRING sAccountType,sAccountName,sAccountBalance,sAccountCreateDate, sDialogName, sActualName, sPayeeName
		[ ] 
		[ ] LIST of STRING lsHowoften, lsEndDate, lsCompare, lsContents
		[ ] 
		[ ] sFileName = "Scheduled_Transactions"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sAccountType ="Checking"
		[ ] sAccountName = "Checking 01"
		[ ] sAccountBalance = "5000"
		[ ] sAccountCreateDate = sDateStamp
		[ ] sPayeeName = "Test Income Reminder"
		[ ] sReminderType = "Income"
		[ ] lsHowoften = {"Weekly","Bi-weekly","Monthly","Twice a month","Quarterly","Yearly","Twice a year","Only once","to pay estimated taxes"}
		[ ] lsEndDate = {"No end date","End on","End after"}
		[ ] lsContents = {"Advertising","AC1","M1"}
		[ ] 
	[ ] 
	[+] // if(QuickenWindow.Exists(10))
		[ ] // QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] // QuickenWindow.SetActive()
		[ ] // QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] // iSetupAutoAPI = SetUp_AutoApi()
		[ ] // ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] // 
		[ ] // //Check which data file is opened and open Scheduled_Transactions_OBP.QDF if required.
		[ ] // sCaption = QuickenMainWindow.GetCaption()
		[ ] // bCaption = MatchStr("*{sFileName}*", sCaption)
		[+] // if(bCaption == FALSE)
			[ ] // iValidate=OpenDataFile(sFileName)
			[ ] // ReportStatus("Open data file", PASS, "Data file -  {sDataFile} is opened")
		[+] // else
			[ ] // ReportStatus("Open data file", PASS, "Data file -  {sDataFile} is already opened")
	[ ] // //Launch Quicken and open data file
	[+] // else
		[ ] // QuickenMainWindow.Start (sCmdLine)
		[ ] // sCaption = QuickenMainWindow.GetCaption()
		[ ] // bCaption = MatchStr("*{sFileName}*", sCaption)
		[+] // if(bCaption == FALSE)
			[ ] // iValidate=OpenDataFile(sFileName)
			[ ] // ReportStatus("Open data file", PASS, "Data file -  {sDataFile} is opened")
		[+] // else
			[ ] // ReportStatus("Open data file", PASS, "Data file -  {sDataFile} is already opened")
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
			[ ] //Launch add bill reminder dialog, enter payee and click Next.
			[ ] NavigateReminderDetailsPage(sReminderType, sPayeeName)
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Exists(5))
				[ ] ReportStatus("Add Income Reminder flow  ", PASS, "Clicking 'Next' button launches Add Income Reminder Second screen ")
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
				[ ] 
				[ ] //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] 
				[ ] DlgOptionalSetting.CategoryTextField.SetText(lsContents[1])
				[ ] DlgOptionalSetting.TagTextField.SetText(lsContents[2])
				[ ] DlgOptionalSetting.MemoTextField.SetText(lsContents[3])
				[ ] 
				[ ] DlgOptionalSetting.OKButton.Click()
				[ ] 
				[ ] 
				[+] if(DlgOptionalSetting.NewTag.TagOKButton.Exists(5))
					[ ] DlgOptionalSetting.NewTag.TagOKButton.Click()
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
				[ ] 
				[ ] 
				[+] if(DlgOptionalSetting.CategoryTextField.GetText()==lsContents[1])
					[ ] ReportStatus("Verify Category Match",PASS, "Category entry Match")
				[+] else
					[ ] ReportStatus("Verify Category Match",FAIL, "Category entry doesnot Match")
					[ ] 
				[+] if(DlgOptionalSetting.TagTextField.GetText()==lsContents[2])
					[ ] ReportStatus("Verify Tag Match",PASS, "Tag entry Match")
				[+] else
					[ ] ReportStatus("Verify Tag Match",FAIL, "Tag entry doesnot Match")
					[ ] 
				[+] if(DlgOptionalSetting.MemoTextField.GetText()==lsContents[3])
					[ ] ReportStatus("Verify Memo Match",PASS, "Memo entry Match")
				[+] else
					[ ] ReportStatus("Verify Memo Match",FAIL, "Memo entry doesnot Match")
					[ ] 
				[ ] 
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] DlgOptionalSetting.CancelButton.Click()
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
				[ ] 
			[+] else
				[ ] ReportStatus("Add Income Reminder flow  ", FAIL, "Clicking 'Next' button does NOT launches Add Income Reminder Second screen ")
			[ ] DlgAddEditReminder.Close()
	[+] else
		[ ] ReportStatus("Quicken Main Window ", FAIL, "Quicken Main Window is NOT present")
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //###############TC41_IncomeInvokingPointforSplitDialog()##########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC41_IncomeInvokingPointforSplitDialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify invoking point for split Transaction / Category dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If invoking split Transaction / Category dialog correctly
		[ ] //				        Fail		   If split Transaction / Category dialog is not invoked correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 13, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC41_IncomeInvokingPointforSplitDialog() appstate QuickenBaseState
	[+] // Variable declaration and definition
		[ ] sReminderType="Income"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] //Click on Add Category Tag Or Memo Panel 
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
			[ ] 
			[ ] 
			[ ] 
			[+] if(DlgOptionalSetting.SplitCategoryButton.Exists(5))
				[ ] ReportStatus("Verify Split Category Button on Add Category,Tag & Memo dialog present",PASS , "Split Category Button on Add Category,Tag & Memo dialog is present")
				[ ] 
				[+] //Verifying Invoking point for Split Transaction Dialog for Category
					[ ] 
					[ ] DlgOptionalSetting.SplitCategoryButton.click()
				[ ] 
				[+] if(ReminderSplitTransaction.Exists(5))
					[ ] ReportStatus("Verify Reminder Split Transaction dialog present", PASS , "Reminder Split Transaction dialog is present")
					[ ] 
					[+] // Verify Add Lines Button exists on Split Transaction Dialog 
						[+] if(ReminderSplitTransaction.AddLinesButton.Exists(5))
							[ ] ReportStatus("Verify AddLines Button on Split Transaction Dialog ", PASS ,"Split Transaction Dialog is displayed as AddLines Button is present")
						[+] else
							[ ] ReportStatus("Verify AddLines Button on Split Transaction Dialog", FAIL ,"Split Transaction Dialog is not displayed as AddLines Button is not present")
					[ ] 
					[+] // Verify Multiple Categories List exists on Split Transaction Dialog 
						[+] if(ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Exists(5))
							[ ] ReportStatus("Verify Multiple Categories List on Split Transaction Dialog ", PASS , "Split Transaction Dialog is displayed as Multiple Categories List is present")
						[+] else
							[ ] ReportStatus("Verify Multiple Categories List on Split Transaction Dialog ", FAIL , "Split Transaction Dialog is not displayed as Multiple Categories List is not present")
					[ ] 
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] 
					[ ] ReminderSplitTransaction.CancelButton.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Split Transaction dialog present", FAIL , "Reminder Split Transaction dialog is present")
				[ ] 
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] DlgOptionalSetting.CancelButton.Click()
				[ ] 
			[+] else
				[ ] ReportStatus("Split Category Button on Add Category,Tag & Memo dialog present", FAIL , "Split Category Button on Add Category,Tag & Memo dialog is not present")
				[ ] 
			[ ] 
			[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //###############TC42_IncomeSplitCategoryFunctionality()##########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC42_IncomeSplitCategoryFunctionality()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify Functionality of split Transaction / Category dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of split Transaction / Category dialog is correct
		[ ] //				        Fail		   If split Transaction / Category dialog is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 13, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC42_IncomeSplitCategoryFunctionality() appstate QuickenBaseState
	[+] // Variable declaration and definition
		[ ] List of STRING lsCategory,lsAmount,lsCompare 
		[ ] 
		[ ] lsCategory = {"Advertising","Bills & Utilities"}
		[ ] lsAmount = {"5.00","5.00"}
		[ ] sReminderType="Income"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[+] //Verifying functionality of Split Category on Split Transaction Dialog
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
				[ ] 
				[ ] // Agent.SetOption(OPT_VERIFY_ENABLED,FALSE)
				[ ] // Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] 
				[+] if(DlgOptionalSetting.SplitCategoryButton.Exists(5))
					[ ] ReportStatus("Verify Split Category Button on Add Category,Tag & Memo dialog present", PASS , "Split Category Button on Add Category,Tag & Memo dialog is present")
					[ ] 
					[ ] //DlgOptionalSetting.SetActive()
					[ ] 
					[ ] 
					[ ] DlgOptionalSetting.SplitCategoryButton.Click()
					[ ] 
					[ ] // 
					[+] // if(ReminderSplitTransaction.Exists(5))
						[ ] // ReportStatus("Verify Reminder Split Transaction dialog present", PASS, "Reminder Split Transaction dialog is present")
						[ ] // // Entering data in Category List for first row
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#1")
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText(lsCategory[1])
						[ ] // CategoryQuickList.Close()
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText(lsAmount[1])
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_ENTER)
						[ ] // 
						[ ] // // Entering data in Category List for second row
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#2")
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText(lsCategory[2])
						[ ] // CategoryQuickList.Close()
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] // ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText(lsAmount[2])
						[ ] // 
						[ ] // //Close both the dialogs
						[ ] // // Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
						[ ] // ReminderSplitTransaction.OKButton.Click()
						[ ] // // Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
						[ ] // DlgOptionalSetting.OKButton.Click()
						[ ] // // Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
						[ ] // 
						[ ] // 
					[ ] 
					[ ] 
					[ ] 
					[+] if(ReminderSplitTransaction.Exists(5))
						[ ] ReminderSplitTransaction.SetActive()
						[ ] ReportStatus("Verify Reminder Split Transaction dialog present", PASS, "Reminder Split Transaction dialog is present")
						[ ] // Entering data in Category List for first row
						[ ] ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText(lsCategory[1])
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[+] if(NewCategory.Exists(2))
							[ ] NewCategory.SetActive()
							[ ] NewCategory.Yes.Click()
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[ ] ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField14.SetText(lsAmount[1])
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[ ] 
						[ ] 
						[ ] // Entering data in Category List for second row
						[ ] 
						[ ] ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.SetText(lsCategory[2])
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[+] if(NewCategory.Exists(2))
							[ ] NewCategory.SetActive()
							[ ] NewCategory.Yes.Click()
							[+] if(SetUpCategory.Exists(3))
								[ ] SetUpCategory.SetActive()
								[ ] SetUpCategory.OK.Click()
								[ ] WaitForState(SetUpCategory , FALSE , 3)
							[ ] 
							[ ] 
						[ ] 
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
						[ ] 
						[ ] ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField14.SetText(lsAmount[2])
						[ ] 
						[ ] //Close both the dialogs
						[ ] ReminderSplitTransaction.OKButton.Click()
						[ ] WaitForState(ReminderSplitTransaction , FALSE , 3)
						[ ] DlgOptionalSetting.OKButton.Click()
						[ ] WaitForState(DlgOptionalSetting , FALSE , 3)
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Reminder Split Transaction dialog present", FAIL , "Reminder Split Transaction dialog is present")
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Split Category Button on Add Category,Tag & Memo dialog present", FAIL , "Split Category Button on Add Category,Tag & Memo dialog is not present")
				[ ] 
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
				[ ] // Agent.SetOption(OPT_VERIFY_ENABLED,FALSE)
				[ ] // Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] 
				[ ] 
				[+] if(DlgOptionalSetting.SplitCategoryButton.Exists(5))
					[ ] ReportStatus("Verify Split Category Button on Add Category,Tag & Memo dialog present", PASS , "Split Category Button on Add Category,Tag & Memo dialog is present")
					[ ] 
					[ ] DlgOptionalSetting.SplitCategoryButton.Click()
					[ ] 
					[+] if(ReminderSplitTransaction.Exists(5))
						[ ] ReportStatus("Verify Reminder Split Transaction dialog present", PASS , "Reminder Split Transaction dialog is present")
						[ ] 
						[+] //Retrieving the data from Category List of first row and appending data in a List for comparsion
							[ ] //ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.Select ("#1")
							[ ] ListAppend(lsCompare,ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.GetText())
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] ListAppend(lsCompare,ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField14.GetText())
							[ ] //ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.TypeKeys(KEY_ENTER)
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] 
							[ ] 
						[ ] 
						[+] //Retrieving the data from Category List of second row and appending data in a List for comparsion
							[ ] 
							[ ] ListAppend(lsCompare,ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField1.GetText())
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] ReminderSplitTransaction.TypeKeys(KEY_TAB)
							[ ] ListAppend(lsCompare,ReminderSplitTransaction.EnterMultipleCategoriesToI2.ListBox1.TextField14.GetText())
						[ ] 
						[+] //Close both the dialogs
							[ ] //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
							[ ] ReminderSplitTransaction.OKButton.Click()
					[ ] 
					[+] else
						[ ] ReportStatus("Verify Reminder Split Transaction dialog present", FAIL , "Reminder Split Transaction dialog is present")
						[ ] 
					[ ] // Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] // Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
					[ ] 
				[+] else
					[ ] ReportStatus("Split Category Button on Add Category,Tag & Memo dialog present", FAIL , "Split Category Button on Add Category,Tag & Memo dialog is not present")
					[ ] 
				[ ] 
				[+] //Comparing both the List retrieved data with entered data
					[ ] 
					[+] // Verify retrieved category is same as entered from first row
						[+] if(lsCategory[1]==lsCompare[1])
							[ ] ReportStatus("Verify Category in split is same ", PASS , "Category {lsCompare[1]} in Split is same")
						[+] else
							[ ] ReportStatus("Verify Category in split is same", FAIL , "Category {lsCompare[1]} in Split is not same as entered is {lsCategory[1]}")
							[ ] 
						[ ] 
					[ ] 
					[+] // Verify retrieved Amount is same as entered from first row
						[+] if(lsAmount[1]==lsCompare[2])
							[ ] ReportStatus("Verify Amount in split is same ", PASS ,"Amount {lsCompare[2]} in split is same")
						[+] else
							[ ] ReportStatus("Verify Amount in split is same", FAIL , "Amount {lsCompare[2]} in split is not same as entered is {lsAmount[1]}")
						[ ] 
					[ ] 
					[+] // Verify retrieved category is same as entered from second row
						[+] if(lsCategory[2]==lsCompare[3])
							[ ] ReportStatus("Verify Category in split is same ", PASS , "Category {lsCompare[3]} in Split is same")
						[+] else
							[ ] ReportStatus("Verify Category in split is same", FAIL , "Category {lsCompare[3]} in Split is not same as entered is {lsCategory[2]}")
						[ ] 
					[ ] 
					[+] // Verify retrieved category is same as entered second row
						[+] if(lsAmount[2]==lsCompare[4])
							[ ] ReportStatus("Verify Amount in split is same ", PASS ,"Amount{lsCompare[4]} in split is same")
						[+] else
							[ ] ReportStatus("Verify Amount in split is same", FAIL , "Amount{lsCompare[4]} in split is not same as entered is {lsAmount[2]} ")
				[ ] 
				[ ] 
				[ ] 
				[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
		[ ] 
		[ ] 
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# TC43_IncomeMethodPopupListUI() #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC43_IncomeMethodPopupListUI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify appearance of Income method popup List for brokerage account for Income Reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 22, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC43_IncomeMethodPopupListUI() appstate QuickenBaseState
	[ ] 
	[+] //Variable declaration and defination
		[ ] STRING sAccountType,sAccountName,sAccountBalance,sAccountCreateDate, sDialogName, sActualName, sPayeeName
		[ ] boolean bCheckStatus
		[ ] 
		[ ] sAccountType ="Brokerage"
		[ ] sAccountName = "Brokerage 01"
		[ ] sAccountBalance = "5000"
		[ ] sReminderType = "Income"
		[ ] sAccountCreateDate = sDateStamp
		[ ] sPayeeName = "Test Income Reminder"
	[+] // 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Add a manual Brokerage account.
		[ ] iValidate= AddManualBrokerageAccount(sAccountType,sAccountName,sAccountBalance, sAccountCreateDate)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Manual Brokerage Account ", PASS, "Manual Brokerage account is added")
			[ ] //Launch income reminder and verify income method popup list existance
			[ ] QuickenWindow.SetActive()
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
			[+] if( iValidate==PASS)
				[ ] 
				[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sAccountName)
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.IncomeMethodPopupList.Exists(5))
					[ ] ReportStatus("Verify Income Method List ", PASS , "Income Method List is displayed")
				[+] else
					[ ] ReportStatus("Verify Income Method List ", FAIL , "Income Method List is NOT displayed")
			[+] else
				[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.SetActive()
			[ ] DlgAddEditReminder.Close()
			[ ] WaitForState(DlgAddEditReminder ,FALSE ,5)
		[+] else
			[ ] ReportStatus("Manual Brokerage Account ", FAIL, "Manual Brokerage account is NOT added")
	[+] else
		[ ] ReportStatus("Quicken Main Window ", FAIL, "Quicken Main Window is NOT present")
		[ ] 
		[ ] 
		[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# TC44_IncomeMethodPopupListItems() #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC44_IncomeMethodPopupListItems()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify List items of Income method popup List for brokerage account for Income Reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 22, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC44_IncomeMethodPopupListItems() appstate QuickenBaseState
	[ ] 
	[+] //Variable declaration and defination
		[ ] STRING sAccountType, sDialogName
		[ ] LIST of STRING lsIncomeMethod
		[ ] sAccountType ="Brokerage"
		[ ] sAccountName = "Brokerage 01"
		[ ] sReminderType = "Income"
		[ ] 
		[ ] sPayeeName = "Test Income Reminder"
		[ ] lsIncomeMethod = {"Deposit","Dividend","Interest"}
		[ ] sReminderType = "Income"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] //Launch income reminder and verify income method popup list items
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
		[+] if( iValidate==PASS)
			[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sAccountName)
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.IncomeMethodPopupList.Exists(5))
				[ ] ReportStatus("Verify Income Method List ", PASS , "Income Method List is displayed")
				[ ] lsCompare=DlgAddEditReminder.Step2Panel.QWinChild1.IncomeMethodPopupList.GetContents()
				[+] for(i=1;i<=ListCount(lsCompare);i++)
					[+] if(lsIncomeMethod[i]==lsCompare[i])
						[ ] ReportStatus("Verify the Contents of How often List",PASS,"As {lsIncomeMethod[i]} = {lsCompare[i]} is same")
					[+] else
						[ ] ReportStatus("Verify the Contents of How often List",FAIL,"As {lsIncomeMethod[i]} = {lsCompare[i]} is NOT same")
			[+] else
				[ ] ReportStatus("Verify Income Method List ", FAIL , "Income Method List is NOT displayed")
			[ ] DlgAddEditReminder.SetActive()
			[ ] DlgAddEditReminder.Close()
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.SetActive()
			[ ] DlgAddEditReminder.Close()
			[ ] WaitForState(DlgAddEditReminder ,FALSE ,5)
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window ", FAIL, "Quicken Main Window is NOT present")
[ ] //###########################################################################
[ ] // 
[+] //############# TC45_ScheduleDividendReminder() ################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC45_ScheduleDividendReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify functionality of scheduling dividend transactions for Income Reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 22, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC45_ScheduleDividendReminder() appstate QuickenBaseState
	[ ] 
	[+] //Variable declaration and defination
		[ ] INTEGER iDaysIncrement
		[ ] STRING sAccountBalance,sAccountCreateDate, sDialogName, sSecurity, sSecurityTicker, sIncomeAmount, sDueDate, sMethod
		[ ] BOOLEAN bResult
		[ ] LIST of STRING lsIncomeMethod, lsBillVerification
		[ ] sAccountName = "Brokerage 01"
		[ ] sPayeeName = "Test Dividend Reminder"
		[ ] lsIncomeMethod = {"Deposit","Dividend","Interest"}
		[ ] sSecurityTicker = "A"
		[ ] sSecurity = "Agilent"
		[ ] 
		[ ] sIncomeAmount = "6.57"
		[ ] sMethod = "Dividend Deposit"
		[ ] iDaysIncrement=0
		[ ] 
		[ ] sDueDate=ModifyDate(iDaysIncrement,sDateFormat)
		[ ] lsBillVerification = {sSecurity,sIncomeAmount,sDueDate,sMethod}
		[ ] sReminderType = "Income"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
		[+] if( iValidate==PASS)
			[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sAccountName)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sIncomeAmount)
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.IncomeMethodPopupList.Exists(5))
				[ ] ReportStatus("Verify Income Method List ", PASS , "Income Method List is displayed")
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.IncomeMethodPopupList.Select(2)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.SecurityTextField.SetText(sSecurity)
				[ ] DlgAddEditReminder.DoneButton.Click()
				[ ] //Verify if 'Agilent' security is already added or not, if Not then add it
				[+] if(AddSecurityToQuicken2.Exists(120))
					[ ] AddSecurityToQuicken2.SetActive()
					[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
						[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
						[ ] sleep(5)
						[ ] 
						[ ] AddSecurityToQuicken2.NextButton.Click()
						[+] if(AddSecurityToQuicken.Exists(120))
							[ ] AddSecurityToQuicken.SetActive()
							[ ] AddSecurityToQuicken.Done.Click()
							[ ] WaitForState(AddSecurityToQuicken , FALSE , 5)
					[ ] 
					[ ] // This code is written to handle Connection error
					[+] if (AddSecurityToQuicken.NoDataFoundFor.Exists(MEDIUM_SLEEP))
						[+] if(AddSecurityToQuicken.SelectTickerSymbol.Exists(SHORT_SLEEP))
							[ ] AddSecurityToQuicken.SelectTickerSymbol.Select("Add manually")
							[ ] AddSecurityToQuicken.Next.Click()
							[ ] 
							[ ] AddSecurityToQuicken.VerifyEnabled(TRUE, 20)
							[ ] AddSecurityToQuicken.SetActive()
							[ ] AddSecurityToQuicken.Done.DoubleClick()
							[ ] 
						[ ] 
					[ ] ReportStatus("Add Security ", PASS , "{sSecurity} security is added in the data file")
				[+] else
					[ ] ReportStatus("Add Security ", PASS , "{sSecurity} security is already added in the data file")
				[ ] 
				[ ] //Verify if Divident Income Reminder gets added or not, using Bill and Income Reminder List (CTRL+J)
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
				[+] if (DlgManageReminders.Exists(5))
					[ ] DlgManageReminders.SetActive()
					[ ] DlgManageReminders.AllBillsDepositsTab.Click()
					[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
					[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
					[ ] 
					[+] for(iCount=0; iCount<=iListCount ; iCount++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bMatch = MatchStr("*{lsBillVerification[1]}*",sActual)
						[+] if (bMatch)
							[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
							[+] for(i=1; i<= Listcount(lsBillVerification); i++)
								[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
								[+] if(bResult==TRUE)
									[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Income Interest Reminder with '{lsBillVerification[i]}' is added successfully")
								[+] else
									[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Income Interest Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
							[ ] break
					[+] if (bMatch==FALSE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Income Interest Reminder for {lsBillVerification[1]} not found.")
					[ ] DlgManageReminders.Close()
					[ ] WaitForState(DlgManageReminders ,FALSE ,5)
					[ ] 
				[+] else
					[ ] ReportStatus("Launch Manage Reminder ", FAIL, "Manage Reminder dialog is NOT launched")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Income Method List ", FAIL , "Income Method List is NOT displayed")
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=ReminderOperations(sDeleteCommand,sSecurity)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete Reminder", FAIL, "Reminder not deleted")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window ", FAIL, "Quicken Main Window is NOT present")
[ ] //###########################################################################
[ ] 
[+] //############# TC46_ScheduleInterestReminder() #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC46_ScheduleInterestReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify functionality of scheduling interest transactions for Income Reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 22, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC46_ScheduleInterestReminder() appstate QuickenBaseState
	[ ] 
	[+] //Variable declaration and defination
		[ ] INTEGER iDaysIncrement
		[ ] STRING sDialogName, sActualName, sSecurity, sSecurityTicker, sIncomeAmount, sDueDate, sMethod
		[ ] boolean bCheckStatus, bResult
		[ ] List of STRING lsIncomeMethod, lsBillVerification
		[ ] sAccountName = "Brokerage 01"
		[ ] sPayeeName = "Test Interest Reminder"
		[ ] lsIncomeMethod = {"Deposit","Dividend","Interest"}
		[ ] sSecurityTicker = "A"
		[ ] sReminderType = "Income"
		[ ] sSecurity = "Agilent"
		[ ] sIncomeAmount = "2.17"
		[ ] sMethod = "Interest Deposit"
		[ ] iDaysIncrement=1
		[ ] 
		[ ] sDueDate=ModifyDate(iDaysIncrement,sDateFormat)
		[ ] lsBillVerification = {sSecurity,sIncomeAmount,sDueDate,sMethod}
		[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
		[+] if( iValidate==PASS)
			[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sAccountName)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sIncomeAmount)
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.IncomeMethodPopupList.Exists(5))
				[ ] ReportStatus("Verify Income Method List ", PASS , "Income Method List is displayed")
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDueDate)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.IncomeMethodPopupList.Select(3)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.SecurityTextField.SetText(sSecurity)
				[ ] DlgAddEditReminder.DoneButton.Click()
				[ ] //Verify if 'Agilent' security is already added or not, if Not then add it
				[+] if(AddSecurityToQuicken2.Exists(120))
					[ ] AddSecurityToQuicken2.SetActive()
					[+] if (AddSecurityToQuicken2.SecurityListBox.Exists(10))
						[ ] AddSecurityToQuicken2.SecurityListBox.Select(1)
						[ ] sleep(5)
						[ ] 
						[ ] AddSecurityToQuicken2.NextButton.Click()
						[+] if(AddSecurityToQuicken.Exists(120))
							[ ] AddSecurityToQuicken.SetActive()
							[ ] AddSecurityToQuicken.Done.Click()
							[ ] WaitForState(AddSecurityToQuicken , FALSE , 5)
					[ ] 
					[ ] // This code is written to handle Connection error
					[+] if (AddSecurityToQuicken.NoDataFoundFor.Exists(MEDIUM_SLEEP))
						[+] if(AddSecurityToQuicken.SelectTickerSymbol.Exists(SHORT_SLEEP))
							[ ] AddSecurityToQuicken.SelectTickerSymbol.Select("Add manually")
							[ ] AddSecurityToQuicken.Next.Click()
							[ ] 
							[ ] AddSecurityToQuicken.VerifyEnabled(TRUE, 20)
							[ ] AddSecurityToQuicken.SetActive()
							[ ] AddSecurityToQuicken.Done.DoubleClick()
							[ ] 
						[ ] 
					[ ] ReportStatus("Add Security ", PASS , "{sSecurity} security is added in the data file")
				[+] else
					[ ] ReportStatus("Add Security ", PASS , "{sSecurity} security is already added in the data file")
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
				[+] if (DlgManageReminders.Exists(5))
					[ ] DlgManageReminders.SetActive()
					[ ] DlgManageReminders.AllBillsDepositsTab.Click()
					[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
					[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
					[ ] 
					[+] for(iCount=0; iCount<=iListCount ; iCount++)
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
						[ ] bMatch = MatchStr("*{lsBillVerification[1]}*",sActual)
						[+] if (bMatch)
							[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
							[+] for(i=1; i<= Listcount(lsBillVerification); i++)
								[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
								[+] if(bResult==TRUE)
									[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Income Interest Reminder with '{lsBillVerification[i]}' is added successfully")
								[+] else
									[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Income Interest Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
							[ ] break
					[+] if (bMatch==FALSE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Income Interest Reminder for {lsBillVerification[1]} not found.")
					[ ] DlgManageReminders.Close()
				[+] else
					[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
				[ ] 
				[ ] iValidate=ReminderOperations(sDeleteCommand,sSecurity)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
				[+] else
					[ ] ReportStatus("Delete Reminder", FAIL, "Reminder not deleted")
				[ ] 
				[ ] 
			[ ] //Verify that bill is scheduled.
			[+] else
				[ ] ReportStatus("Verify Income Method List ", FAIL , "Income Method List is NOT displayed")
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window ", FAIL, "Quicken Main Window is NOT present")
[ ] //############################################################################
[ ] // 
[ ] 
[+] //#############Verify Optional settings for Income Reminder ##########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test49_IncomeReminderOptionalSettingsForBrokerage()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that payee name is replaced by Security for dividend and Interest income reminders
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 25, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC49_VerifyPayeeInIncomeReminderForBrokerage () appstate none //QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] LIST OF STRING lsAddAccount
		[ ] STRING sIncomeMethod,sSecurity
		[ ] 
		[ ] lsAddAccount={"Brokerage","Brokerage 01","100",sDateStamp}
		[ ] sReminderType = "Income"
		[ ] sIncomeMethod="Interest"
		[ ] sSecurity="Agilent"
	[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(lsAddAccount[2])
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.IncomeMethodPopupList.Exists(5))
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.IncomeMethodPopupList.Select(sIncomeMethod)
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.SecurityTextField.Exists(5))
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.SecurityTextField.SetText(sSecurity)
					[ ] 
					[ ] sActual=DlgAddEditReminder.Step1Panel.HomeChildPanel.ChangedPayeeNameText.GetText()
					[ ] 
					[ ] 
					[ ] 
					[+] if(sActual==sSecurity)
						[ ] ReportStatus("Verify that payee name is replaced by Security",PASS,"Payee name is replaced by Security i.e {sSecurity}")
					[+] else
						[ ] ReportStatus("Verify that payee name is replaced by Security",FAIL,"Payee name is not replaced by Security: Actual- {sActual} and Expected- {sSecurity}")
				[+] else
					[ ] ReportStatus("Verify Security Text field",FAIL,"Security text field is not found")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Income Method popup list",FAIL,"Income Method popup list is not found")
			[ ] 
			[ ] 
			[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Add Brokerage Account", iValidate, "Brokerage Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# TC55_ScheduleDividendReminderNoSecurity() #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC55_ScheduleDividendReminderNoSecurity()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify functionality of scheduling dividend reminder without specifying Security name for Income Reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Mar 01, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC55_ScheduleDividendReminderNoSecurity() appstate QuickenBaseState
	[ ] 
	[+] //Variable declaration and defination
		[ ] INTEGER iDaysIncrement
		[ ] STRING sAccountType,sAccountName,sAccountBalance,sAccountCreateDate, sDialogName, sActualName, sPayeeName,sSecurity, sSecurityTicker, sIncomeAmount, sDueDate, sHandle,sActual, sCycle,sMethod
		[ ] boolean bCheckStatus, bResult
		[ ] List of STRING lsCompare, lsIncomeMethod, lsBillVerification
		[ ] 
		[ ] 
		[ ] sFileName = "Scheduled_Transactions"
		[ ] // sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sReminderType="Income"
		[ ] sAccountType ="Brokerage"
		[ ] sAccountName = "Brokerage 01"
		[ ] sAccountBalance = "5000"
		[ ] sAccountCreateDate = sDateStamp
		[ ] sPayeeName = "Test Dividend Reminder"
		[ ] lsIncomeMethod = {"Deposit","Dividend","Interest"}
		[ ] sSecurityTicker = "A"
		[ ] sSecurity = "Agilent"
		[ ] sIncomeAmount = "6.57"
		[ ] sMethod = "Dividend Deposit"
		[ ] //sCycle="Forward"
		[ ] iDaysIncrement=0
		[ ] 
		[ ] sDueDate=ModifyDate(iDaysIncrement,sDateFormat)
		[ ] lsBillVerification = {sPayeeName,sIncomeAmount,sDueDate,sMethod}
		[ ] sActualName = "Add Income Reminder"
		[ ] 
		[ ] 
	[ ] 
	[+] if (QuickenWindow.Exists(10))
		[ ] 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate ==PASS)
			[ ] ReportStatus("Add Income Reminder flow  ", PASS, "Add Income Reminder flow is launched from Upcoming tab")
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.Exists(15))
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sIncomeAmount)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sAccountName)
				[ ] 
				[ ] 
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.IncomeMethodPopupList.Exists(5))
					[ ] ReportStatus("Verify Income Method List ", PASS , "Income Method list is displayed")
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.IncomeMethodPopupList.Select(2)
					[ ] DlgAddEditReminder.TypeKeys(KEY_TAB)
					[ ] DlgAddEditReminder.DoneButton.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Income Method List ", FAIL , "Income Method list is NOT displayed")
			[+] else
				[ ] ReportStatus("Add Income Reminder flow  ", FAIL, "Clicking 'Next' button does NOT launches Add Income Reminder Second screen ")
			[ ] 
			[ ] //Verify if Divident Income Reminder gets added or not, using Bill and Income Reminder list (CTRL+J)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.SetActive()
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
				[ ] 
				[+] for(iCount=0; iCount<=iListCount ; iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch = MatchStr("*{lsBillVerification[1]}*",sActual)
					[+] if (bMatch)
						[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
						[+] for(i=1; i<= Listcount(lsBillVerification); i++)
							[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
							[+] if(bResult==TRUE)
								[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Income Interest Reminder with '{lsBillVerification[i]}' is added successfully")
							[+] else
								[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Income Interest Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
						[ ] break
				[+] if (bMatch==FALSE)
					[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Income Interest Reminder for {lsBillVerification[1]} not found.")
				[ ] DlgManageReminders.Close()
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Income Reminder flow  ", FAIL, "Add Income Reminder flow is NOT launched from Upcoming tab")
		[ ] 
		[ ] 
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //############# TC56_ScheduleInterestReminderNoSecurity() ##########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC56_ScheduleInterestReminderNoSecurity()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify functionality of scheduling interest reminder without specifying Security name for Income Reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Mar 04, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC56_ScheduleInterestReminderNoSecurity() appstate QuickenBaseState
	[ ] 
	[+] //Variable declaration and defination
		[ ] INTEGER iDaysIncrement
		[ ] STRING sAccountType,sAccountName,sAccountBalance,sAccountCreateDate, sDialogName, sActualName, sPayeeName,sSecurity, sSecurityTicker, sIncomeAmount, sDueDate, sHandle,sActual, sCycle,sMethod
		[ ] boolean bCheckStatus, bResult
		[ ] List of STRING lsCompare, lsIncomeMethod, lsBillVerification
		[ ] 
		[ ] // sFileName = "Scheduled_Transactions"
		[ ] // sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] 
		[ ] sReminderType="Income"
		[ ] sAccountName = "Brokerage 01"
		[ ] 
		[ ] sPayeeName = "Test Interest Reminder"
		[ ] lsIncomeMethod = {"Deposit","Dividend","Interest"}
		[ ] sSecurityTicker = "A"
		[ ] sSecurity = "Agilent"
		[ ] sIncomeAmount = "2.17"
		[ ] sMethod = "Interest Deposit"
		[ ] // sCycle="Forward"
		[ ] iDaysIncrement=1
		[ ] 
		[ ] sDueDate=ModifyDate(iDaysIncrement,sDateFormat)
		[ ] lsBillVerification = {sPayeeName,sIncomeAmount,sDueDate,sMethod}
		[ ] sActualName = "Add Income Reminder"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigate to Income Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate ==PASS)
			[ ] ReportStatus("Add Income Reminder flow  ", PASS, "Add Income Reminder flow is launched from Upcoming tab")
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.Exists(15))
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sIncomeAmount)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sAccountName)
				[ ] 
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.IncomeMethodPopupList.Exists(5))
					[ ] ReportStatus("Verify Income Method List ", PASS , "Income Method list is displayed")
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDueDate)
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.IncomeMethodPopupList.Select(3)
					[ ] DlgAddEditReminder.TypeKeys(KEY_TAB)
					[ ] DlgAddEditReminder.DoneButton.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Income Method List ", FAIL , "Income Method list is NOT displayed")
			[+] else
				[ ] ReportStatus("Add Income Reminder flow  ", FAIL, "Clicking 'Next' button does NOT launches Add Income Reminder Second screen ")
			[ ] 
			[ ] //Verify if Interest Income Reminder gets added or not, using Bill and Income Reminder list (CTRL+J)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.SetActive()
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
				[ ] 
				[+] for(iCount=0; iCount<=iListCount ; iCount++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
					[ ] bMatch = MatchStr("*{lsBillVerification[1]}*",sActual)
					[+] if (bMatch)
						[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
						[+] for(i=1; i<= Listcount(lsBillVerification); i++)
							[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
							[+] if(bResult==TRUE)
								[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Income Interest Reminder with '{lsBillVerification[i]}' is added successfully")
							[+] else
								[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Income Interest Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
						[ ] break
				[+] if (bMatch==FALSE)
					[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Income Interest Reminder for {lsBillVerification[1]} not found.")
				[ ] DlgManageReminders.Close()
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
			[ ] 
			[ ] 
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Add Income Reminder flow  ", FAIL, "Add Income Reminder flow is NOT launched from Upcoming tab")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window ", FAIL, "Quicken Main Window is NOT present")
[ ] //#############################################################################
[ ] 
[+] //#############Verify Optional settings for Income Reminder ##########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test48_VerifyIncomeReminderOptionalSettings()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify options available in Optional settings section for manual checking account for Income Reminder
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 21, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC48_VerifyIncomeReminderOptionalSettings () appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] LIST OF STRING lsAddAccount
		[ ] 
		[ ] sReminderType = "Income"
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sExcelDataFile, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Click on Optional setting button and verify objects
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Exists(5))
				[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] 
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceText.Exists(5))
					[ ] ReportStatus("Verify Remind Me 3 days in advance text",PASS,"Remind me 3 days in advance text is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Remind Me 3 days in advance text",FAIL,"Remind me 3 days in advance text is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
					[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",PASS,"Remind me 3 days in advance Change link is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",FAIL,"Remind me 3 days in advance Change link is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteText.Exists(5))
					[ ] ReportStatus("Verify Related Website text",PASS,"Related website text is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Related website text",FAIL,"Related website text is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
					[ ] ReportStatus("Verify Related wesite add Link",PASS,"Related website add link is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Related website add Link",FAIL,"Related website add link is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountText.Exists(5))
					[ ] ReportStatus("Verify Estimate amount for me:OFF text",PASS,"Estimate amount for me:OFF text is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Estimate amount for me:OFF text",FAIL,"Estimate amount for me:OFF text is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
					[ ] ReportStatus("Verify Estimate amount for me:OFF change link",PASS,"Estimate amount for me:OFF change link is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Estimate amount for me:OFF change link",FAIL,"Estimate amount for me:OFF change link is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.SyncToOutlookCheckBox.Exists(5))
					[ ] ReportStatus("Verify Sync to outlook checkbox",PASS,"Sync to outlook checkbox is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Sync to outlook checkbox",FAIL,"Sync to outlook checkbox is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] DlgAddEditReminder.CancelButton.Click()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Optional Setting button",FAIL,"Optional Setting button is not available on Add {sReminderType} Reminder dialog")
				[ ] 
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window ", FAIL, "Quicken Main Window is NOT present")
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] //#############Verify Reminder Change Link for Income Reminder ######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test50_IncomeReminderOptionalSettingsReminderChangeLink()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify UI of Reminder days form for Income Reminder
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 22, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC50_IncomeReminderOptionalSettingsReminderChangeLink () appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] sReminderType = "Income"
		[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10) == True)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
				[ ] 
				[ ] SETTING:
				[ ] // Click on Optional setting button and verify objects
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
					[ ] 
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
						[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",PASS,"Remind me 3 days in advance Change link is available on Add {sReminderType} Reminder dialog")
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
						[ ] 
						[ ] 
						[+] if(DlgOptionalSetting.Exists(5))
							[ ] 
							[+] if(DlgOptionalSetting.RemindMeRadioList.Exists(5))
								[ ] ReportStatus("Verify Remind me radio list",PASS,"Remind me radio list is displayed")
							[+] else
								[ ] ReportStatus("Verify Remind me radio list",FAIL,"Remind me radio list is not displayed")
							[ ] 
							[+] if(DlgOptionalSetting.DaysInAdvanceTextField.Exists(5))
								[ ] ReportStatus("Verify Days In Advance list box",PASS,"Days In Advance list box is displayed")
							[+] else
								[ ] ReportStatus("Verify Days In Advance list box",FAIL,"Days In Advance list box is not displayed")
							[ ] 
							[+] if(DlgOptionalSetting.UseOnlyBusinessDaysCheckBox.Exists(5))
								[ ] ReportStatus("Verify Use Only Business Days CheckBox",PASS,"Use Only Business Days CheckBox is displayed")
							[+] else
								[ ] ReportStatus("Verify Use Only Business Days CheckBox",FAIL,"Use Only Business Days CheckBox is not displayed")
							[ ] 
							[+] if(DlgOptionalSetting.OKButton.Exists(5))
								[ ] ReportStatus("Verify OK button",PASS,"OK button is displayed")
							[+] else
								[ ] ReportStatus("Verify OK button",FAIL,"OK button is not displayed")
							[ ] 
							[+] if(DlgOptionalSetting.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel button",PASS,"Cancel button is displayed")
							[+] else
								[ ] ReportStatus("Verify Cancel button",FAIL,"Cancel button is displayed")
							[ ] 
							[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
							[ ] DlgOptionalSetting.CancelButton.Click()
							[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",FAIL,"Remind me 3 days in advance Change link is not available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] // Click on Cancel button
					[ ] DlgAddEditReminder.CancelButton.Click()
					[ ] 
				[+] else
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
					[ ] //OptionalSettingsPanel2.OptionalSettingsButton.Click()
					[ ] goto SETTING
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //#############Verify automatic enter transaction for Income Reminder ##################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test51_IncomeReminderOptionalSettingsAutomaticEnterTxn()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality of automatic enter transaction for Income Reminder
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 22, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC51_IncomeReminderOptionalSettingsAutomaticEnterTxn () appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sAmount,sCheckingAccount
		[ ] sAmount="20"
		[ ] sReminderType = "Income"
		[ ] sCheckingAccount="Checking 01"
		[ ] sBillStatus="Paid"
		[ ] sPayeeName = "ST_Payee"
		[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10) == True)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
			[ ] 
			[ ] SETTING:
			[ ] // Click on Optional setting button and verify objects
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
					[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",PASS,"Remind me 3 days in advance Change link is available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] 
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
					[+] if(DlgOptionalSetting.Exists(5))
						[ ] 
						[+] if(DlgOptionalSetting.RemindMeRadioList.Exists(5))
							[ ] ReportStatus("Verify Remind me radio list",PASS,"Remind me radio list is displayed")
							[ ] DlgOptionalSetting.RemindMeRadioList.TypeKeys(KEY_DN)
							[+] if(DlgOptionalSetting.DaysInAdvanceTextField.Exists(5))
								[ ] ReportStatus("Verify Automatically enter the transaction",PASS,"Automatically enter the transaction is selected")
								[ ] DlgOptionalSetting.OKButton.Click()
								[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Days In Advance list box",FAIL,"Days In Advance list box is not displayed")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Remind me radio list",FAIL,"Remind me radio list is not displayed")
					[+] else
						[ ] ReportStatus("Verify Optional Setting window", FAIL, "Optional setting window is not displayed")
				[+] else
					[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",FAIL,"Remind me 3 days in advance Change link is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] DlgAddEditReminder.TextClick("Done")
				[ ] sleep(2)
				[ ] 
				[ ] // Relaunch Quicken
				[ ] LaunchQuicken()
				[ ] QuickenWindow.SetActive()
				[ ] // Navigate to Income Reminder Tab
				[ ] NavigateQuickenTab(sTAB_BILL)
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive()
				[ ] 
				[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Exists(5))
					[ ] ReportStatus("Verify Go to Register button",PASS,"Scheduled income reminder is received as Go to Register button is displayed")
				[+] else
					[ ] ReportStatus("Verify Go to Register button",FAIL,"Scheduled income reminder is not received as Go to Register button is not displayed")
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,NULL,0,0,sBillStatus)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
					[ ] 
					[ ] SelectAccountFromAccountBar(sCheckingAccount,ACCOUNT_BANKING)
					[ ] DeleteTransaction(sWindowTypeMDI,sPayeeName)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Delete Reminder", FAIL, "Reminder not deleted")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //#############Verify UI of "Related website" for Income Reminder #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test52_VerifyBillOptionalSettingsRelatedWebsite()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify UI of "Related website" form for Income Reminder
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 22, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC52_IncomeReminderOptionalSettingsRelatedWebsite () appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sAmount,sWebsite,sActualWebsite
		[ ] 
		[ ] sAmount="20"
		[ ] sWebsite="www.google.com"
		[ ] sReminderType = "Income"
		[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
			[ ] 
			[ ] SETTING:
			[ ] // Click on Optional setting button and verify objects
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
					[ ] ReportStatus("Verify Related Website Add Link",PASS,"Related Website Add Link is available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Click()
					[+] if(DlgOptionalSetting.Exists(5))
						[ ] 
						[+] if(DlgOptionalSetting.WebsiteTextField.Exists(5))
							[ ] ReportStatus("Verify Website text field",PASS,"Website text field is displayed")
							[ ] DlgOptionalSetting.WebsiteTextField.SetText(sWebsite)
							[ ] DlgOptionalSetting.OKButton.Click()
							[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Website text field",FAIL,"Website text field is not displayed")
					[+] else
						[ ] ReportStatus("Verify Optional Setting window", FAIL, "Optional setting window is not displayed")
				[+] else
					[ ] ReportStatus("Verify Related Website Add Link",FAIL,"Related Website Add Link is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] DlgAddEditReminder.DoneButton.Click()
				[ ] 
				[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.WebsiteLink.Exists(5))
					[ ] //MDIClient.Bills.Panel.Panel1.QWinChild.WebsiteLink.Click()           //(1, 65, 27)
					[ ] sActualWebsite=MDIClient.Bills.Panel.Panel1.QWinChild.WebsiteLink.GetCaption()
					[ ] 
					[ ] bMatch=MatchStr("*{sWebsite}*",sActualWebsite)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify entered website in {sReminderType} Reminder",PASS,"Entered Website is displayed correctly i.e. {sWebsite}")
					[+] else
						[ ] ReportStatus("Verify entered website in {sReminderType} Reminder",FAIL,"Entered Website is not displayed correctly, Expected- {sWebsite} and Actual-{sActualWebsite}")
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify {sReminderType} created",FAIL,"Created {sReminderType} not displayed in stack view")
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
				[+] else
					[ ] ReportStatus("Delete Reminder", FAIL, "Reminder not deleted")
				[ ] 
				[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //#############Verify "Go to Website" link for Income Reminder  #######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_VerifyBillOptionalSettingsGoToWebsiteLink()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify appearance of "Go to Website" link in Add Income Reminder dialog when website is entered
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 22, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC53_IncomeReminderOptionalSettingsGoToWebsiteLink () appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sAmount,sWebsite,sLinkName,sExpectedLink
		[ ] 
		[ ] sAmount="20"
		[ ] sWebsite="www.google.com"
		[ ] sExpectedLink="(change)"
		[ ] sReminderType = "Income"
		[ ] 
		[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10) )
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
				[ ] 
				[ ] SETTING:
				[ ] // Click on Optional setting button and verify objects
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
					[ ] // Verify Add link for Related Website
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
						[ ] ReportStatus("Verify Related Website Add Link",PASS,"Related Website Add Link is available on Add {sReminderType} Reminder dialog")
						[ ] 
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Click()
						[ ] 
						[+] if(DlgOptionalSetting.Exists(5))
							[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
							[ ] // Enter website
							[+] if(DlgOptionalSetting.WebsiteTextField.Exists(5))
								[ ] ReportStatus("Verify Website text field",PASS,"Website text field is displayed")
								[ ] DlgOptionalSetting.WebsiteTextField.SetText(sWebsite)
								[ ] DlgOptionalSetting.OKButton.Click()
								[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
								[ ] // Verify add link is converted to change link
								[ ] sLinkName=DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.GetCaption()
								[+] if(sLinkName==sExpectedLink)
									[ ] ReportStatus("Verify Add link",PASS,"add link is converted in to change link")
								[+] else
									[ ] ReportStatus("Verify Add link",FAIL,"add link is not converted in to change link")
									[ ] 
								[ ] // Verify Go To Website link
								[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.GoToWebsite.Exists(5))
									[ ] ReportStatus("Verify Go To Website link",PASS,"Go To Website link is displayed")
								[+] else
									[ ] ReportStatus("Verify Go To Website link",FAIL,"Go To Website link is not displayed")
									[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Website text field",FAIL,"Website text field is not displayed")
						[+] else
							[ ] ReportStatus("Verify Optional Setting window", FAIL, "Optional setting window is not displayed")
					[+] else
						[ ] ReportStatus("Verify Related Website Add Link",FAIL,"Related Website Add Link is not available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] DlgAddEditReminder.CancelButton.Click ()
					[ ] 
					[ ] 
				[+] else
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
					[ ] goto SETTING
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //#############Verify sync to outlook checkbox for Income Reminder###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test54_IncomeReminderOptionalSettingsSyncOutlook()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality of sync to outlook checkbox in Add Income Reminder dialog
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Feb 22, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC54_IncomeReminderOptionalSettingsSyncOutlook() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sAmount,sCheckingAccount
		[ ] 
		[ ] sAmount="30"
		[ ] sReminderType = "Income"
		[ ] sCheckingAccount="Checking 01"
		[ ] sBillStatus="Paid"
		[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] // Navigate to Bills Tab
		[ ] NavigateQuickenTab(sTAB_BILL)
		[ ] 
		[+] if(!MDIClient.Bills.SyncToOutlookButton.Exists(5))
			[ ] ReportStatus("Verify Sync to Outlook button on {sReminderType} window",PASS,"Sync to Outlook button is not available")
			[ ] 
			[ ] // Navigate to Income Reminder Details page 
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[+] if(iValidate==PASS)
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
					[ ] 
					[ ] 
					[ ] // Click on Optional setting button and verify objects
					[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.SyncToOutlookCheckBox.Exists(5))
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
					[ ] 
					[ ] 
					[ ] // Verify Sync to Outlook check box
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.SyncToOutlookCheckBox.Exists(5))
						[ ] ReportStatus("Verify Sync to Outlook check box",PASS,"Sync to Outlook check box is available on Add {sReminderType} Reminder dialog")
					[+] else
						[ ] ReportStatus("Verify Sync to Outlook check box",FAIL,"Sync to Outlook check box is not available on Add {sReminderType} Reminder dialog")
					[ ] 
					[ ] DlgAddEditReminder.DoneButton.Click ()
					[ ] 
					[+] if(MDIClient.Bills.SyncToOutlookButton.Exists(5))
						[ ] ReportStatus("Verify Sync to Outlook check box",PASS,"Sync to Outlook check box is checked on Add {sReminderType} Reminder dialog")
						[ ] ReportStatus("Verify Sync to Outlook button on {sReminderType} window",PASS,"Sync to Outlook button is available")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Sync to Outlook check box",FAIL,"Sync to Outlook check box is not checked on Add {sReminderType} Reminder dialog")
						[ ] ReportStatus("Verify Sync to Outlook button on {sReminderType} window",FAIL,"Sync to Outlook button is not available")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
					[+] if(iValidate==PASS)
						[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Delete Reminder", FAIL, "Reminder not deleted")
					[ ] 
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Sync to Outlook button on {sReminderType} window",FAIL,"Sync to Outlook button is already  available")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //###############TC57 _IncomeUIEstimateAmount()#################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC57 _IncomeUIEstimateAmount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify UI of Estimate amount for me (change) link window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If all UI controls  Estimate amount for me (change) link window is correct
		[ ] //				        Fail         If all UI controls  Estimate amount for me (change) link window is not correct
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 14, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC57_IncomeUIEstimateAmount() appstate QuickenBaseState
	[+] //Variable Declaration and defination
		[ ] List of STRING Estimate 
		[ ] 
		[ ] Estimate = {"Fixed amount","Previous payments","Time of year"}
		[ ] sReminderType = "Income"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] SETTING :
			[ ] // Verify the 'Estimate for Me' dialog is present
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", PASS , "  Estimate Amount Change Link is present under Optional Settings")
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", PASS , " 'Estimate for Me' dialog is present")
					[+] //Verify the UI Controls on the 'Estimate for Me' dialog
						[+] //Verify the contents in Estimate Popup List on 'Estimate for Me' dialog
							[+] if(DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Exists(5))
								[ ] ReportStatus("Verify Estimate Popup List on 'Estimate for Me' dialog ", PASS , "Estimate Popup List is present on 'Estimate for Me' dialog")
								[ ] 
								[ ] //Get the contents of Quicken Can Help You Estimate PopupList
								[ ] lsCompare=DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.GetContents()
								[ ] 
								[+] //Verify the contents in Estimate Popup List on 'Estimate for Me' dialog
									[+] for(j=1;j<=ListCount(Estimate);j++)
										[+] if(Estimate[j]==lsCompare[j])
											[ ] ReportStatus("Verify the Contents of Estimate Popup List",PASS,"As {lsCompare[j]} is same")
										[+] else
											[ ] ReportStatus("Verify the Contents of Estimate Popup List",FAIL,"As {Estimate[j]},{lsCompare[j]} is not same")
							[ ] 
							[+] else
								[ ] ReportStatus("Verify Estimate Popup List on 'Estimate for Me' dialog", FAIL , "Estimate Popup List is not present on 'Estimate for Me' dialog")
								[ ] 
						[+] //Verify the contents in Estimate Text Field on 'Estimate for Me' dialog
							[+] if(DlgOptionalSetting.QuickenCanHelpYouEstimateTextField.Exists(5))
								[ ] ReportStatus("Verify Estimate Text Field on 'Estimate for Me' dialog ", PASS , "Estimate Text Field is present on 'Estimate for Me' dialog")
							[+] else
								[ ] ReportStatus("Verify Estimate Text Field on 'Estimate for Me' dialog", FAIL , "Estimate Text Field is not present on 'Estimate for Me' dialog")
						[+] //Verify the contents in OK Button on 'Estimate for Me' dialog
							[+] if(DlgOptionalSetting.OKButton.Exists(5))
								[ ] ReportStatus("Verify OK Button on 'Estimate for Me' dialog  ", PASS , "OK Button is present on 'Estimate for Me' dialog")
							[+] else
								[ ] ReportStatus("Verify OK Button on 'Estimate for Me' dialog ", FAIL , "OK Button is not present on 'Estimate for Me' dialog")
								[ ] 
						[+] //Verify the contents in Cancel Button on 'Estimate for Me' dialog
							[+] if(DlgOptionalSetting.CancelButton.Exists(5))
								[ ] ReportStatus("Verify Cancel Button on 'Estimate for Me' dialog ", PASS , "Cancel Button is present on 'Estimate for Me' dialog")
							[+] else
								[ ] ReportStatus("Verify Cancel Button on 'Estimate for Me' dialog", FAIL , "Cancel Button is not present on 'Estimate for Me' dialog")
							[ ] 
							[ ] 
					[ ] 
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.CancelButton.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", FAIL , " 'Estimate for Me' dialog is not present")
					[ ] 
				[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
				[ ] 
			[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
			[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC58_IncomeFunctionalityPreviousPayments() #######################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC58_IncomeFunctionalityPreviousPayments()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Previous Payments in Estimate amount for me 
		[ ] //  change) link in Add Bill Reminder dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Previous Payments in Estimate amount for me (change) link is correct
		[ ] //        Fail		   If functionality of Previous Payments in Estimate amount for me (change) link is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 14, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC58_IncomeFunctionalityPreviousPayments() appstate QuickenBaseState
	[+] //Variable Declaration and defination
		[ ] INTEGER iOpenAccountRegister,iEnterTransaction
		[ ] STRING sAmount,sAmountCompare,sDate,sCheckingAccount
		[ ] 
		[ ] 
		[ ] sCheckingAccount="Checking 01"
		[ ] sReminderType = "Income"
		[ ] sPayeeName="Test Income"
		[ ] sDate = ModifyDate(-365,sDateFormat)
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] 
		[ ] // Opening Checking Account Register
		[ ] iOpenAccountRegister=SelectAccountFromAccountBar(sCheckingAccount,ACCOUNT_BANKING)
		[ ] 
		[ ] 
		[+] if(iOpenAccountRegister==PASS)
			[ ] ReportStatus("Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] //Entering two transactions in Register
			[ ] lsExcelData=ReadExcelTable(sExcelDataFile, sCheckingTransactionWorksheet1)
			[ ] sAmountCompare=lsExcelData[1][6]
			[+] for(i=1;i<=ListCount(lsExcelData);i++)
				[ ] // Fetch ith row from the given sheet
				[ ] lsTransactionData=lsExcelData[i]
				[ ] iEnterTransaction=AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],sDate,lsTransactionData[4],lsTransactionData[5])
				[ ] ReportStatus("Add Checking Transaction",iEnterTransaction,"Transaction {i} added")
				[ ] 
			[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[ ] 
			[+] if(iValidate==PASS)
				[ ] SETTING :
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", PASS , "  Estimate Amount Change Link is present under Optional Settings")
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
					[ ] 
					[+] //verify the functionality of Previous Payments option
						[+] if(DlgOptionalSetting.Exists(5))
							[ ] 
							[ ] ReportStatus("Verify  'Estimate for Me' dialog present", PASS , " 'Estimate for Me' dialog is present")
							[ ] 
							[ ] 
							[ ] //Select the second option from Estimate Popup List on 'Estimate for Me' dialog for Previous Payments
							[ ] DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Select("#2")
							[ ] 
							[ ] 
							[ ] //Set '2'as last payments
							[ ] DlgOptionalSetting.LastTextField.SetText("2")
							[ ] 
							[ ] DlgOptionalSetting.OKButton.Click()
							[ ] 
							[ ] //Amount gets calculated automatically from Previous Payments
							[ ] sAmount=DlgAddEditReminder.Step2Panel.QWinChild1.EstimatedAmountText.GetText()
							[ ] //AmountDue.GetText()
							[ ] 
							[ ] //Verify the Average amount for previous payments
							[+] if(sAmount == sAmountCompare)
								[ ] ReportStatus("Verify Estimate Amount :Previous Payments option ", PASS , "Previous Payments option is set properly as it is showing Average amount{sAmount}")
							[+] else
								[ ] ReportStatus("Verify Estimate Amount :Previous Payments option ", FAIL , "Previous Payments option is not set properly as it is not showing Average amount same {sAmount},{sAmountCompare}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify  'Estimate for Me' dialog present", FAIL , " 'Estimate for Me' dialog is not present")
				[+] else
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
					[ ] goto SETTING
					[ ] 
				[ ] 
				[ ] DlgAddEditReminder.Close()
				[ ] 
				[ ] 
			[+] else 
				[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
		[+] else
			[ ] ReportStatus("Account is selected from AccountBar", FAIL , "Account is not selected from AccountBar")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
[ ] //#############################################################################
[ ] 
[+] //###############TC59_IncomeFunctionalityFixedAmount()############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC59_IncomeFunctionalityFixedAmount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Fixed Amount in Estimate amount for me  
		[ ] // (change) link in Add Bill Reminder dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Fixed Amount in Estimate amount for me (change) link is correct
		[ ] //        Fail		   If functionality of Previous Payments in Estimate amount for me (change) link is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 15, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC59_IncomeFunctionalityFixedAmount() appstate QuickenBaseState
	[+] //Variable Declaration and defination
		[ ] INTEGER iOpenAccountRegister,iEnterTransaction
		[ ] STRING sAmount,sAmountCompare 
		[ ] 
		[ ] sAmount="50.00"
		[ ] sReminderType = "Income"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] SETTING :
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", PASS , "  Estimate Amount Change Link is present under Optional Settings")
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", PASS , " 'Estimate for Me' dialog is present")
					[ ] 
					[+] //verify the functionality of Fixed Amounts option
						[ ] 
						[ ] 
						[ ] 
						[ ] //select first option for Fixed Amount
						[ ] DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Select("#1")
						[ ] 
						[ ] //set Fixed Amount 
						[ ] DlgOptionalSetting.QuickenCanHelpYouEstimateTextField.SetText(sAmount)
						[ ] 
						[ ] DlgOptionalSetting.OKButton.Click()
						[ ] 
						[ ] 
						[ ] sAmountCompare=DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.GetText()
						[ ] 
						[ ] //Verify the fixed amount is set
						[+] if(sAmount == sAmountCompare)
							[ ] ReportStatus("Verify Estimate Amount :Fixed Amount option ", PASS , "Fixed Amount option is set properly as {sAmount} ")
						[+] else
							[ ] ReportStatus("Verify Estimate Amount :Fixed Amount option ", FAIL , "Fixed Amount option is not set properly as it is not same {sAmount},{sAmountCompare}")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", FAIL , " 'Estimate for Me' dialog is not present")
				[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
				[ ] 
			[ ] DlgAddEditReminder.CancelButton.Click()
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
[ ] //#############################################################################
[ ] 
[+] //###############TC60_IncomeFunctionalityTimeofYear()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC60_IncomeFunctionalityTimeofYear()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Time of Year in Estimate amount for me  
		[ ] // (change) link in Add Bill Reminder dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Time of Year in Estimate amount for me (change) link is correct
		[ ] //        Fail		   If functionality of Previous Payments in Estimate amount for me (change) link is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 15, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC60_IncomeFunctionalityTimeofYear() appstate QuickenBaseState
	[+] //Variable Declaration and defination
		[ ] INTEGER iOpenAccountRegister,iEnterTransaction
		[ ] STRING sAmount,sAmountCompare
		[ ] 
		[ ] sAmountCompare ="$500.00"
		[ ] sReminderType = "Income"
		[ ] sPayeeName="Insurance Income"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] SETTING :
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", PASS , "  Estimate Amount Change Link is present under Optional Settings")
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
				[ ] 
				[ ] //verify the functionality of Time of Year option
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", PASS, " 'Estimate for Me' dialog is present")
					[ ] 
					[ ] 
					[ ] 
					[ ] //Time of year gets selected and it will automatically insert the last year paid amount 
					[ ] 
					[ ] DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Select("#3")
					[ ] 
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] 
					[ ] 
					[ ] //Verify the amount with last year amount
					[ ] sAmount=DlgAddEditReminder.Step2Panel.QWinChild1.EstimatedAmountText.GetText()
					[ ] 
					[+] if(sAmount == sAmountCompare)
						[ ] ReportStatus("Verify Estimate Amount :Time of Year option ", PASS , "Time of Year option is set properly as it is showing Last year amount{sAmountCompare}")
					[+] else
						[ ] ReportStatus("Verify Estimate Amount :Time of Year option ", FAIL , "Time of Year option is not set properly as it is not showing Last year amount {sAmount},{sAmountCompare}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", FAIL , " 'Estimate for Me' dialog is not present")
			[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
				[ ] 
			[ ] 
			[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
[ ] //#############################################################################
[ ] 
[+] //###############TC61_IncomeFunctionalityDoneButton()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC61_IncomeFunctionalityDoneButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Done button on "Add Bill Reminder" dialog
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Cancel button is correct
		[ ] //        Fail		   If functionality of Cancel button is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC61_IncomeFunctionalityDoneButton() appstate QuickenBaseState 
	[+] //Variable Declaration and defination
		[ ] INTEGER iSetupAutoAPI 
		[ ] STRING sAmount,sAmountCompare
		[ ] List of ANYTYPE  lsReminderList
		[ ] 
		[ ] sAmount="500.00"
		[ ] sReminderType = "Income"
		[ ] sPayeeName="DoneButtonPayee"
		[ ] 
	[ ] // iSetupAutoAPI = SetUp_AutoApi()
	[ ] // ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] //Set the Amount 
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
			[ ] 
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[+] if(MDIClient.Bills.Exists(5))//Select List view 
				[ ] ReportStatus("Verify Bills tab window ", PASS, "Bills tab Window is present")
				[ ] MDIClient.Bills.ViewAsPopupList.Select("#2")
				[ ] //MDIClient.Bills.ViewAsPopupList.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] //Retrieve the data from the 2nd Row
				[ ] sHandle = Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
				[ ] bMatch = MatchStr("*{sPayeeName}*",sActual)
				[ ] 
				[ ] //verify whether it is present in the List
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify Validate Reminder in List view", PASS, "{sPayeeName}  is available in Bill Reminder in List view")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Validate Reminder in List view", FAIL, "{sPayeeName}  is not available in Bill Reminder in List view")
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
				[+] else
					[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Bills tab window ", PASS, "Bill tab Window is not present")
		[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC62_IncomeFunctionalityCancelButton()############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC62_IncomeFunctionalityCancelButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Cancel button on "Add Bill Reminder" dialog 
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Cancel button is correct
		[ ] //        Fail		   If functionality of Cancel button is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC62_IncomeFunctionalityCancelButton() appstate QuickenBaseState 
	[+] //Variable Declaration and defination
		[ ] INTEGER iSetupAutoAPI 
		[ ] STRING sAmount,sAmountCompare
		[ ] List of ANYTYPE  lsReminderList
		[ ] 
		[ ] sAmount="500.00"
		[ ] sReminderType = "Income"
		[ ] sPayeeName="CancelButtonPayee"
	[ ] 
	[ ] // iSetupAutoAPI = SetUp_AutoApi()
	[ ] // ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenMainWindow.VerifyEnabled(TRUE,20)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[ ] 
			[+] if(iValidate==PASS)
				[ ] //Set the Amount 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
				[ ] 
				[ ] DlgAddEditReminder.CancelButton.Click()
				[ ] 
				[+] // if(MDIClient.Bills.Exists(5))//Select List view 
					[ ] // ReportStatus("Verify Bills tab window ", PASS, "Bills tab Window is present")
					[ ] // MDIClient.Bills.ViewAsPopupList.Select("#2")
					[ ] // //Bills.ViewAsPopupList.TypeKeys(KEY_ENTER)
					[ ] // 
					[ ] // //Retrieve the data from the 2nd Row
					[ ] // sHandle = Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
					[ ] // sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(5))
					[ ] // bMatch = MatchStr("*{sPayeeName}*",sActual)
					[ ] // 
					[ ] // //verify that the cancelled reminder should not be in the List
					[+] // if(bMatch == FALSE)
						[ ] // ReportStatus("Verify Reminder is not added", PASS, "{sPayeeName} is not available Reminder is not added so Cancel Button is working ")
					[+] // else
						[ ] // ReportStatus("Verify Reminder is added", FAIL, "{sPayeeName}  is available in Reminder in List view so Cancel Button is not working")
				[+] // else
					[ ] // ReportStatus("Verify Bills tab window ", PASS, "Bill tab Window is not present")
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
				[+] if (DlgManageReminders.Exists(5))
					[ ] DlgManageReminders.AllBillsDepositsTab.Click()
					[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
					[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
					[ ] //for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bMatch = MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Income Interest Reminder with '{sPayeeName}' is not added")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Income Interest Reminder with '{sPayeeName}' is added")
						[ ] 
					[ ] DlgManageReminders.Close()
				[+] else
					[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
				[ ] 
				[ ] 
			[+] else 
				[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC63_IncomeFunctionalityHelpIcon()################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC63_IncomeFunctionalityHelpIcon()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of help icon on Add Bill Reminder dialog
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of help icon is correct
		[ ] //        Fail		   If functionality of help icon is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC63_IncomeFunctionalityHelpIcon() appstate QuickenBaseState 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //Navigation to Home Tab
		[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
		[ ] ReportStatus("Navigate to {sTAB_BILL} > {sTAB_UPCOMING}", iValidate, "Navigate to {sTAB_BILL} > {sTAB_UPCOMING}")
		[ ] 
		[ ] 
		[+] if(QuickenMainWindow.QWNavigator.AddReminder.Exists(5))
			[ ] ReportStatus("Upcoming from Bills Menu", PASS , "Upcoming is available as Add Reminder Button is displayed")
			[ ] 
			[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] //Verify Help icon on Add Bill Reminder
			[+] if(DlgAddEditReminder.HelpButton.Exists(5))
				[ ] ReportStatus("Verify  Help Icon on Add Bill Reminder", PASS , "Help Icon is present in Add Bill Reminder dialog ")
				[ ] 
				[ ] DlgAddEditReminder.HelpButton.click()
				[ ] sleep(3)
				[ ] 
				[+] //Help Dialog gets opened
					[+] if(QuickenHelp.Exists(5))
						[ ] ReportStatus("Verify Help Dialog ", PASS , "Help Dialog is present ")
						[ ] QuickenHelp.Close()
					[+] else
						[ ] ReportStatus("Verify Help Dialog", FAIL , "Help Dialog is not present")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify  Help Icon on Add Bill Reminder", FAIL , "Help Icon is not present in Add Bill Reminder dialog ")
				[ ] 
			[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
		[+] else 
			[ ] ReportStatus("Upcoming from Bills Menu", FAIL , "Upcoming is not available as Add Reminder Button is not displayed")
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] // ###############TC64_IncomeFunctionalityBackButton()############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC64_IncomeFunctionalityBackButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Back button on "Add Bill Reminder" dialog
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Back button  is correct
		[ ] //        Fail		   If functionality of Back button  is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC64_IncomeFunctionalityBackButton() appstate QuickenBaseState 
	[+] //Variable Declaration and defination
		[ ] STRING sAmount,sPayeeName
		[ ] 
		[ ] sAmount="500.00"
		[ ] sPayeeName="BackButtonPayee"
		[ ] sReminderType = "Income"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenMainWindow.VerifyEnabled(TRUE,20)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
				[ ] 
				[ ] //Set the Amount 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
				[ ] 
				[+] //verifying some Objects present on Second Screen of Add Bill Reminder before Back Button is clicked
					[ ] 
					[+] // Verify Due Next On Textbox on Add Bill Reminder Second Screen
						[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.Exists(5))
							[ ] ReportStatus("Verify Due Next On Textbox on Add Bill Reminder Second Screen", PASS , "Due Next On Textbox is present on Add Bill Reminder Second Screen ")
						[+] else
							[ ] ReportStatus("Verify Due Next On Textbox on Add Bill Reminder Second Screen", FAIL , "Due Next On Textbox is not present on Add Bill Reminder Second Screen")
						[ ] 
					[+] // Verify OptionalSettings on Add Bill Reminder Second Screen
						[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Exists(5))
							[ ] ReportStatus("Verify OptionalSettings on Add Bill Reminder Second Screen", PASS , "OptionalSettings is present on Add Bill Reminder Second Screen")
						[+] else
							[ ] ReportStatus("Verify OptionalSettings on Add Bill Reminder Second Screen", FAIL , "OptionalSettings is not present on Add Bill Reminder Second Screen")
					[ ] 
					[ ] //Click Back Button
					[ ] DlgAddEditReminder.BackButton.Click()
					[ ] 
				[+] //verifying some Objects of Second Screen present on First Screen of Add Bill Reminder after Back Button is clicked
					[+] if(DlgAddEditReminder.Exists(5))
						[ ] ReportStatus("Verify Add Bill Reminder dailog is present after Back Button clicked",PASS,"Add Bill Reminder dailog is present after Back Button clicked")
						[ ] 
						[+] // // Verify Add Category Tag Memo Panel on Add Bill Reminder First Screen
							[+] // if(!DlgAddEditReminder.Step2Panel.QWinChild1.Panel1.AddCategoryTagOrMemo.Exists(5))
								[ ] // ReportStatus("Verify Add Category Tag Memo Panel on Add Bill Reminder First Screen",PASS , "Add Category Tag Memo Panel is not present on Add Bill Reminder First Screen so Back Button is working")
							[+] // else
								[ ] // ReportStatus("Verify Add Category Tag Memo Panel on Add Bill Reminder First Screen",FAIL , "Add Category Tag Memo Panel is present on Add Bill Reminder First Screen so Back Button is not working")
						[+] // Verify Add Category Tag Memo Panel on Add Bill Reminder First Screen
							[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.Exists(5))
								[ ] ReportStatus("Verify Amount Due on Add Bill Reminder First Screen", PASS ,"Amount Due is not present on Add Bill Reminder First Screen so Back Button is working")
							[+] else
								[ ] ReportStatus("Verify Amount Due on Add Bill Reminder First Screen", FAIL ,"Amount Due is present on Add Bill Reminder First Screenso Back Button is not working")
								[ ] 
					[+] else
						[ ] ReportStatus("Verify Add Bill Reminder dailog is present after Back Button clicked",FAIL,"Add Bill Reminder dailog is not present after Back Button clicked")
						[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
						[ ] DlgAddEditReminder.CancelButton.Click()
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
			[ ] 
		[ ] 
		[+] if(DlgAddEditReminder.Exists(4))
			[ ] DlgAddEditReminder.Close()
			[ ] 
		[ ] 
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] // ############### TC66_TransferReminderFirstScreen() #############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	 TC66_TransferReminderFirstScreen() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This test case will Verify UI controls Present on Add Transfer Reminder First screen
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If error does not occurs
		[ ] //				        Fail		   If error does occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 22, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC66_TransferReminderFirstScreen()  appstate QuickenBaseState
		[+] //Variable Declaration and defination
			[ ] integer iValidate2
			[ ] i=3
			[ ] sReminderType="Transfer"
		[ ] 
		[ ] 
		[ ] //Creating a Data file
		[+] if(QuickenWindow.Exists(10))
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] //Create Data File
			[ ] iValidate = DataFileCreate(sFileName)
			[ ] //Report Staus If Data file Created successfully
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Validate Data File ", iValidate, "Data file -  {sDataFile} is created")
				[ ] 
				[ ] //Creating a Checking Account
				[ ] iValidate2=AddManualSpendingAccount(IsAddAccount1[1],IsAddAccount1[2],IsAddAccount1[3],IsAddAccount1[4])
				[ ] 
				[+] if (iValidate==PASS)
					[ ] ReportStatus("Checking Account", iValidate, "Checking Account -  {IsAddAccount[2]}  is created successfully")
				[+] else
					[ ] ReportStatus("Checking Account", iValidate, "Checking Account -  {IsAddAccount[2]}  is not created")
					[ ] 
				[+] if (iValidate2==PASS)
					[ ] ReportStatus("Savings Account", iValidate, "Savings Account -  {IsAddAccount1[2]}  is created successfully")
				[+] else
					[ ] ReportStatus("Savings Account", iValidate, "Savings Account -  {IsAddAccount1[2]}  is not created")
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
				[ ] NavigateQuickenTab(sTAB_BILL)
				[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
				[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(Replicate(KEY_DN, i)) 
				[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(KEY_ENTER)
				[ ] 
				[+] if(DlgAddEditReminder.Exists(5))
					[ ] 
					[+] //Verify UI controls of First Screen on Transfer reminder dialog 
						[ ] // Verify the Description Text field of First Screen on Transfer reminder dialog 
						[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.Exists(5))
							[ ] ReportStatus("Verify Description Text field of First Screen on Transfer reminder dialog  ", PASS , "Description Text field of First Screen is present on Transfer reminder dialog")
						[+] else
							[ ] ReportStatus("Verify Description Text field of First Screen on Transfer reminder dialog  ", FAIL , "Description Text field of First Screen is not present on Transfer reminder dialog")
						[ ] 
						[ ] // Verify the Cancel Button of First Screen on Transfer reminder dialog 
						[+] if(DlgAddEditReminder.CancelButton.Exists(5))
							[ ] ReportStatus("Verify the Cancel Button of First Screen on Transfer reminder dialog ", PASS , "Cancel Button of First Screen is present on Transfer reminder dialog")
						[+] else
							[ ] ReportStatus("Verify the Cancel Button of First Screen on Transfer reminder dialog ", FAIL , "Cancel Button of First Screen is not present on Transfer reminder dialo")
						[ ] 
						[ ] // Verify the Next Button of First Screen on Transfer reminder dialog 
						[+] if(DlgAddEditReminder.NextButton.Exists(5))
							[ ] ReportStatus("Verify the Next Button of First Screen on Transfer reminder dialog", PASS , "Next Button of First Screen is present on Transfer reminder dialog")
						[+] else
							[ ] ReportStatus("Verify the Next Button of First Screen on Transfer reminder dialog", FAIL , "Next Button of First Screen is not present on Transfer reminder dialog")
						[ ] 
						[ ] // Verify the Help Button of First Screen on Transfer reminder dialog 
						[+] if(DlgAddEditReminder.HelpButton.Exists(5))
							[ ] ReportStatus("Verify the Help Button of First Screen on Transfer reminder dialog", PASS , "Help Button of First Screen is present on Transfer reminder dialog")
						[+] else
							[ ] ReportStatus("Verify the Help Button of First Screen on Transfer reminder dialog", FAIL , "Help Button of First Screen is not present on Transfer reminder dialog")
						[ ] 
					[ ] 
					[ ] DlgAddEditReminder.Close()
					[ ] 
				[+] else 
					[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
					[ ] 
					[ ] 
			[ ] 
			[ ] //Report Staus If Data file is not Created 
			[+] else if(iValidate==FAIL)
				[ ] ReportStatus("Validate Data File ", iValidate, "Data file -  {sDataFile} is created but it is not Opened")
				[ ] 
			[ ] //Report Staus If Data file already exists
			[+] else
				[ ] ReportStatus("Validate Data File ", iValidate, "File already exists, Please change the Data File name")
		[+] else
			[ ] ReportStatus("No Quicken Open ", FAIL, "Quicken is not Opened")
		[ ] 
[ ] //############################################################################
[ ] 
[ ] 
[+] // ###############TC67_TransferReminderSecondScreen() ##########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	 TC67_TransferReminderSecondScreen()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This test case will Verify UI controls Present on Add Transfer Reminder second screen
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If error does not occurs
		[ ] //				        Fail		   If error does occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 08, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC67_TransferReminderSecondScreen() appstate QuickenBaseState
	[+] //Variable Declaration and defination
		[ ] sReminderType = "Transfer"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iValidate=AddManualSpendingAccount(IsAddAccount[1],IsAddAccount[2],IsAddAccount[3],IsAddAccount[4])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Manual Checking Account ", PASS, "Manual checking account is added")
			[ ] 
			[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[ ] 
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //Verify UI controls of Second Screen on Transfer reminder dialog 
				[+] // // Verify the Description Text field of Second Screen on Transfer reminder dialog 
					[+] // if(DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.Exists(5))
						[ ] // ReportStatus("Verify Description Text field of Second Screen on Transfer reminder dialog  ", PASS , "Description Text field of Second Screen is present on Transfer reminder dialog")
					[+] // else
						[ ] // ReportStatus("Verify Description Text field of Second Screen on Transfer reminder dialog  ", FAIL , "Description Text field of Second Screen is not present on Transfer reminder dialog")
				[ ] 
				[+] // Verify the Due Next On Text field of Second Screen on Transfer reminder dialog 
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.Exists(5))
						[ ] ReportStatus("Verify  Due Next On Text field of Second Screen on Transfer reminder dialog", PASS , "Due Next On Text field of Second Screen is present on Transfer reminder dialog")
					[+] else
						[ ] ReportStatus("Verify  Due Next On Text field of Second Screen on Transfer reminder dialog", FAIL , "Due Next On Text field of Second Screen is not present on Transfer reminder dialog")
					[ ] 
				[ ] 
				[+] // Verify the Due Next On Change link of Second Screen on Transfer reminder dialog 
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Exists(5))
						[ ] ReportStatus("Verify the Due Next On Change link of Second Screen on Transfer reminder dialog ", PASS , "Due Next On Change link of Second Screen is present on Transfer reminder dialog")
					[+] else
						[ ] ReportStatus("Verify the Due Next On Change link of Second Screen on Transfer reminder dialog ", FAIL , "Due Next On Change link of Second Screen is not present on Transfer reminder dialog")
				[ ] 
				[+] // Verify the Amount Due Text Field of Second Screen on Transfer reminder dialog 
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.Exists(5))
						[ ] ReportStatus("Verify the Amount Due Text Field of Second Screen on Transfer reminder dialog", PASS , "Amount Due Text Field of Second Screen is present on Transfer reminder dialog")
					[+] else
						[ ] ReportStatus("Verify the Amount Due Text Field of Second Screen on Transfer reminder dialog", FAIL , "Amount Due Text Field of Second Screen is not present on Transfer reminder dialog")
				[ ] 
				[+] // Verify the From Account Text field of Second Screen on Transfer reminder dialog 
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.Exists(5))
						[ ] ReportStatus("Verify the From Account Text field of Second Screen on Transfer reminder dialog", PASS , "From Account Text field of Second Screen is present on Transfer reminder dialog")
					[+] else
						[ ] ReportStatus("Verify the From Account Text field of Second Screen on Transfer reminder dialog", FAIL , "From Account Text field of Second Screen is not present on Transfer reminder dialog")
				[ ] 
				[+] // Verify the To Account Text field of Second Screen on Transfer reminder dialog 
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.Exists(5))
						[ ] ReportStatus("Verify the To Account Text field of Second Screen on Transfer reminder dialog", PASS , "To Account Text field of Second Screen is present on Transfer reminder dialog")
					[+] else
						[ ] ReportStatus("Verify the To Account Text field of Second Screen on Transfer reminder dialog", FAIL , "To Account Text field of Second Screen is not present on Transfer reminder dialog")
				[ ] 
				[+] // Verify the Details Text of Second Screen on Transfer reminder dialog 
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DetailsText.Exists(5))
						[ ] ReportStatus("Verify the Details Text of Second Screen on Transfer reminder dialog", PASS , "Details Text of Second Screen is present on Transfer reminder dialog")
					[+] else
						[ ] ReportStatus("Verify the Details Text of Second Screen on Transfer reminder dialog", FAIL , "Details Text of Second Screen is not present on Transfer reminder dialog")
				[ ] 
				[+] // Verify the Add Tag Or Memo Panel of Second Screen on Transfer reminder dialog 
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Exists(5))
						[ ] ReportStatus("Verify the Add Tag Or Memo Panel of Second Screen on Transfer reminder dialog ", PASS , "Add Tag Or Memo Panel of Second Screen is present on Transfer reminder dialog")
					[+] else
						[ ] ReportStatus("Verify the Add Tag Or Memo Panel of Second Screen on Transfer reminder dialog ", FAIL , "Add Tag Or Memo Panel of Second Screen is not present on Transfer reminder dialog")
				[ ] 
				[+] // Verify the Optional Settings Panel of Second Screen on Transfer reminder dialog 
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Exists(5))
						[ ] ReportStatus("Verify the Optional Settings Panel of Second Screen on Transfer reminder dialog", PASS , "Optional Settings Panel of Second Screen is present on Transfer reminder dialog")
					[+] else
						[ ] ReportStatus("Verify the Optional Settings Panel of Second Screen on Transfer reminder dialog", FAIL , "Optional Settings Panel of Second Screen is not present on Transfer reminder dialog")
					[ ] 
				[ ] 
				[+] // Verify the Back Button of Second Screen on Transfer reminder dialog 
					[+] if(DlgAddEditReminder.BackButton.Exists(5))
						[ ] ReportStatus("Verify the Back Button of Second Screen on Transfer reminder dialog", PASS , "Back Button of Second Screen is present on Transfer reminder dialog")
					[+] else
						[ ] ReportStatus("Verify the Back Button of Second Screen on Transfer reminder dialog", FAIL , "Back Button of Second Screen is not present on Transfer reminder dialog")
						[ ] 
					[ ] 
				[ ] 
				[+] // Verify the Done Button of Second Screen on Transfer reminder dialog 
					[+] if(DlgAddEditReminder.DoneButton.Exists(5))
						[ ] ReportStatus("Verify Done Button of Second Screen on Transfer reminder dialog", PASS , "Done Button of Second Screen is present on Transfer reminder dialog")
					[+] else
						[ ] ReportStatus("Verify Done Button of Second Screen on Transfer reminder dialog", FAIL , "Done Button of Second Screen is not present on Transfer reminder dialog")
					[ ] 
				[ ] 
				[+] // Verify the Cancel Button of Second Screen on Transfer reminder dialog 
					[+] if(DlgAddEditReminder.CancelButton.Exists(5))
						[ ] ReportStatus("Verify Cancel Button of Second Screen on Transfer reminder dialog", PASS , "Cancel Button of Second Screen is present on Transfer reminder dialog")
					[+] else
						[ ] ReportStatus("Verify Cancel Button of Second Screen on Transfer reminder dialog", FAIL , "Cancel Button of Second Screen is not present on Transfer reminder dialog")
					[ ] 
				[ ] 
				[+] // Verify the Help Button of Second Screen on Transfer reminder dialog 
					[+] if(DlgAddEditReminder.HelpButton.Exists(5))
						[ ] ReportStatus("Verify Help Button of Second Screen on Transfer reminder dialog", PASS , "Help Button of Second Screen is present on Transfer reminder dialog")
					[+] else
						[ ] ReportStatus("Verify Help Button of Second Screen on Transfer reminder dialog", FAIL , "Help Button of Second Screen is not present on Transfer reminder dialog")
				[ ] 
				[ ] 
			[+] else 
				[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
				[ ] 
				[ ] 
			[ ] 
			[ ] DlgAddEditReminder.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("Add manual account",FAIL,"Manual account couldn't be added")
		[ ] 
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
	[+] 
		[ ] 
[ ] //############################################################################
[ ] 
[+] // ###############TC68_TransferNextButtonFirstScreen()############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	 TC68_TransferNextButtonFirstScreen()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality of Next button on Add Transfer Reminder first screen
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If error does not occurs
		[ ] //				        Fail		   If error does occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 08, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC68_TransferNextButtonFirstScreen() appstate QuickenBaseState
	[+] //Variable Declaration and defination
		[ ] sReminderType = "Transfer"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] iValidate = OpenDataFile(sFileName)
			[ ] 
			[+] if( iValidate==PASS)
				[ ] ReportStatus("Validate Data File ",  iValidate, "Data file -  {sDataFile} is created")
				[ ] 
				[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
				[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
				[ ] 
				[+] if(iValidate==PASS)
					[+] //Verify UI controls of Second Screen on Transfer reminder dialog
						[+] // Verify the Due Next On Text field of Second Screen on Transfer reminder dialog 
							[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.Exists(5))
								[ ] ReportStatus("Verify  Due Next On Text field of Second Screen on Transfer reminder dialog", PASS , "Due Next On Text field of Second Screen is present on Transfer reminder dialog")
							[+] else
								[ ] ReportStatus("Verify  Due Next On Text field of Second Screen on Transfer reminder dialog", FAIL , "Due Next On Text field of Second Screen is not present on Transfer reminder dialog")
					[ ] 
				[+] else 
					[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
				[ ] 
				[ ] DlgAddEditReminder.Close()
				[ ] 
				[ ] //Report Staus If Data file is not Created 
			[+] else if( iValidate==FAIL)
				[ ] ReportStatus("Validate Data File ",  iValidate, "Data file -  {sDataFile} is created but it is not Opened")
				[ ] //Report Staus If Data file already exists
			[+] else
				[ ] ReportStatus("InValidate Data File ", iValidate, "File does not exists, Please change the Data File name")
			[ ] 
	[+] // else
		[ ] // ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //###############TC69_TransferChangeLink()######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC69_TransferChangeLink()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify available options for frequency selection for due date in change link
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If error does not occurs
		[ ] //				        Fail		   If error does occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 11, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC69_TransferChangeLink() appstate QuickenBaseState
	[+] //Variable Declaration and defination
		[ ] list of STRING lsHowOften = {"Weekly","Bi-weekly","Monthly","Twice a month","Quarterly","Yearly","Twice a year","Only once","to pay estimated taxes"}
		[ ] list of STRING EndDate = {"No end date","End on","End after"}
		[ ] list of STRING lsCompare,lsCompareEndDate
		[ ] sReminderType = "Transfer"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] iValidate = OpenDataFile(sFileName)
			[ ] 
			[+] if( iValidate==PASS)
				[ ] ReportStatus("Validate Data File ",  iValidate, "Data file -  {sDataFile} is created")
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
				[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
				[ ] 
				[ ] 
				[+] if(iValidate==PASS)
					[ ] 
					[ ] 
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
					[ ] 
					[ ] WaitForState(DlgOptionalSetting,TRUE,20)
					[ ] 
					[ ] lsCompare=DlgOptionalSetting.HowOftenPopupList.GetContents()
					[ ] lsCompareEndDate = DlgOptionalSetting.EndDatePopupList.GetContents()
					[ ] 
					[ ] ListDelete (lsCompare,9)
					[ ] ListDelete (lsCompare,5)
					[ ] 
					[+] //Verifying UI controls for the Change link of Due date on 
						[+] if(DlgOptionalSetting.StartDateTextField.Exists(5))
							[ ] ReportStatus("Verify Start Date Text Field", PASS , "Start Date TextField is displayed")
						[+] else
							[ ] ReportStatus("Verify Start Date Text Field", FAIL , "Start Date TextField is not displayed")
							[ ] 
						[ ] 
						[+] if(DlgOptionalSetting.HowOftenPopupList.Exists(5))
							[ ] ReportStatus("Verify How Often Popup ", PASS , "How Often Popup is displayed")
						[+] else
							[ ] ReportStatus("Verify How Often Popup", FAIL , "How Often Popup is not displayed")
						[ ] 
						[+] for(i=1;i<=listCount(lsCompare);i++)
							[+] if(lsHowOften[i]==lsCompare[i])
								[ ] ReportStatus("Verify the Contents of How Often List",PASS,"As {lsHowOften[i]} = {lsCompare[i]} is same")
							[+] else
								[ ] ReportStatus("Verify the Contents of How Often List",FAIL,"As {lsHowOften[i]} = {lsCompare[i]} is not same")
								[ ] 
						[+] for(j=1;j<=listCount(EndDate);j++)
							[+] if(EndDate[j]==lsCompareEndDate[j])
								[ ] ReportStatus("Verify the Contents of End Date List",PASS,"As {EndDate[j]} = {lsCompareEndDate[j]} is same")
							[+] else
								[ ] ReportStatus("Verify the Contents of End Date List",FAIL,"As {EndDate[j]} = {lsCompareEndDate[j]} is not same")
								[ ] 
						[ ] 
						[+] if(DlgOptionalSetting.EveryUpDown.Exists(5))
							[ ] ReportStatus("Verify Every Up Down ", PASS , "Every Up Down is displayed")
						[+] else
							[ ] ReportStatus("Verify Every Up Down", FAIL , "Every Up Down is not displayed")
						[ ] 
						[+] if(DlgOptionalSetting.MonthOnThePopupList.Exists(5))
							[ ] ReportStatus("Verify Month On The PopupList ", PASS , "Month On The PopupList is displayed")
						[+] else
							[ ] ReportStatus("Verify Month On The PopupList", FAIL , "Month On The PopupList is not displayed")
						[ ] 
						[+] if(DlgOptionalSetting.DayPopupList.Exists(5))
							[ ] ReportStatus("Verify Day PopupList ", PASS , "Day PopupList is displayed")
						[+] else
							[ ] ReportStatus("Verify Day PopupList", FAIL , "Day PopupList is not displayed")
						[ ] 
						[+] if(DlgOptionalSetting.EndDatePopupList.Exists(5))
							[ ] ReportStatus("Verify End Date PopupList ", PASS , "End Date PopupList is displayed")
						[+] else
							[ ] ReportStatus("Verify End Date PopupList", FAIL , "End Date PopupList is not displayed")
						[ ] 
						[+] if(DlgOptionalSetting.OKButton.Exists(5))
							[ ] ReportStatus("Verify OK Button ", PASS , "OK Button is displayed")
						[+] else
							[ ] ReportStatus("Verify OK Button", FAIL , "OK Button is not displayed")
						[ ] 
						[+] if(DlgOptionalSetting.CancelButton.Exists(5))
							[ ] ReportStatus("Verify Cancel Button ", PASS , "Cancel Button is displayed")
						[+] else
							[ ] ReportStatus("Verify Cancel Button", FAIL , "Cancel Button is not displayed")
							[ ] 
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.CancelButton.Click()
					[ ] 
				[+] else 
					[ ] ReportStatus("Upcoming from Bills Menu", FAIL , "Upcoming is not available as Add Reminder Button is not displayed")
					[ ] 
				[ ] 
				[ ] 
				[ ] // If Data file is not Created 
			[+] else if( iValidate==FAIL)
				[ ] ReportStatus("Validate Data File ",  iValidate, "Data file -  {sDataFile} is created but it is not Opened")
				[ ] // If Data file already exists
			[+] else
				[ ] ReportStatus("InValidate Data File ", iValidate, "File does not exists, Please change the Data File name")
			[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Close()
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //###############TC70_TransferOkCancelButtonDueDate()###########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC70_TransferOkCancelButtonDueDate()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality of Ok, cancel button in Date/Schedule form for change link
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If error does not occurs
		[ ] //				        Fail		   If error does occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 11, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC70_OkCancelButtonDueDate() appstate QuickenBaseState
	[+] //Variable Declaration
		[ ] list of STRING lsCompare,lsCompareEndDate
		[ ] 
		[ ] //list of STRING lsHowOften = {"Weekly","Bi-weekly","Monthly","Twice a month","Quarterly","Yearly","Twice a year","Only once","to pay estimated taxes"}
		[ ] //list of STRING EndDate = {"No end date","End on","End after"}
		[ ] string sDate = ModifyDate(35,sDateFormat)
		[ ] sReminderType = "Transfer"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // iValidate = OpenDataFile(sFileName)
			[ ] // 
			[+] // if( iValidate==PASS)
				[ ] // ReportStatus("Validate Data File ",  iValidate, "Data file -  {sDataFile} is created")
				[ ] // 
				[ ] // // If Data file is not Created 
			[+] // else if( iValidate==FAIL)
				[ ] // ReportStatus("Validate Data File ",  iValidate, "Data file -  {sDataFile} is created but it is not Opened")
				[ ] // // If Data file already exists
			[+] // else
				[ ] // ReportStatus("InValidate Data File ", iValidate, "File does not exists, Please change the Data File name")
			[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //Navigation to Home Tab
		[ ] iValidate=NavigateQuickenTab(sTAB_HOME)
		[ ] //Navigation from Bills >> Add Bill
		[ ] iValidate=NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
		[ ] 
		[ ] ReportStatus("Navigate to {sTAB_BILL} > {sTAB_UPCOMING}", iValidate, "Navigate to {sTAB_BILL} > {sTAB_UPCOMING}")
		[ ] 
		[ ] 
		[+] if(QuickenMainWindow.QWNavigator.AddReminder.Exists(5))
			[ ] ReportStatus("Upcoming from Bills Menu", PASS , "Upcoming is available as Add Reminder Button is displayed")
			[ ] 
			[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_DN)
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] //Going to Second Screen
			[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.SetText(sPayeeName)
			[ ] 
			[ ] DlgAddEditReminder.NextButton.Click()
			[ ] 
			[ ] //DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
			[ ] 
			[ ] 
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
			[ ] 
			[ ] WaitForState(DlgOptionalSetting,TRUE,20)
			[ ] 
			[+] if(DlgOptionalSetting.StartDateTextField.Exists(5))
				[ ] ReportStatus("Verify Start Date Text Field", PASS , "Start Date TextField is displayed")
				[ ] 
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] 
				[ ] DlgOptionalSetting.StartDateTextField.SetText(sDateStamp)
				[ ] 
				[ ] DlgOptionalSetting.CancelButton.Click()
				[ ] 
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] 
				[ ] sCompare = DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.GetText()
				[ ] 
				[+] if(sDate!=sCompare)
					[ ] ReportStatus("Verify Due Next On Date", PASS , "On Clicking Cancel Button Due Next On Date is not set as current date")
				[+] else
					[ ] ReportStatus("Verify Due Next On Date", FAIL , "On Clicking Cancel Button Due Next On Date is set as current date")
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDate)
				[ ] 
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
				[ ] 
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] 
				[ ] DlgOptionalSetting.StartDateTextField.SetText(sDateStamp)
				[ ] 
				[ ] DlgOptionalSetting.OKButton.Click()
				[ ] 
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] 
				[ ] sCompare = DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.GetText()
				[ ] 
				[+] if(sDateStamp==sCompare)
					[ ] ReportStatus("Verify Due Next On Date", PASS , "On Clicking OK Button Due Next On Date is set as current date ")
				[+] else
					[ ] ReportStatus("Verify Due Next On Date", FAIL , "On Clicking OK Button Due Next On Date is not set as current date")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Start Date Text Field", FAIL , "Start Date TextField is not displayed")
				[ ] 
			[ ] 
			[ ] 
		[+] else 
			[ ] ReportStatus("Upcoming from Bills Menu", FAIL , "Upcoming is not available as Add Reminder Button is not displayed")
			[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Close()
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //###############TC71_TransferUIAddTagMemoPanel()##############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC71_TransferUIAddTagMemoPanel()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This test case will Verify UI if Add tag or memo panel for transfer reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If error does not occurs
		[ ] //				        Fail		   If error does occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 11, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC71_TransferUIAddTagMemoPanel() appstate QuickenBaseState
	[+] //Variable Declaration and defination
		[ ] integer iValidate
		[ ] sReminderType = "Transfer"
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[ ] DlgAddEditReminder.SetActive()
			[+] // Verify UI controls on the Add Tag Memo Panel of Transfer Reminder dialog
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
				[ ] // Verify the Add Tag Memo Panel present 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] ReportStatus("Verify Add Tag Or Memo Panel on Transfer Reminder dialog ", PASS , " Add Tag Or Memo Panel is present on Transfer Reminder dialog")
					[+] // Verify the Tag Text Field present on Add Tag Memo dialog
						[+] if(DlgOptionalSetting.TagTextField.Exists(5))
							[ ] ReportStatus("Verify Tag Text Field on Transfer Reminder dialog ", PASS , " Tag Text Field is present on Transfer Reminder dialog")
						[+] else
							[ ] ReportStatus("Verify Tag Text Field on Transfer Reminder dialog", FAIL , "Tag Text Field is not present on Transfer Reminder dialog")
					[ ] 
					[+] // Verify the Memo Text Field present on Add Tag Memo dialog
						[+] if(DlgOptionalSetting.MemoTextField.Exists(5))
							[ ] ReportStatus("Verify Memo Text Field on Transfer Reminder dialog ", PASS , "Memo Text Field is present on Transfer Reminder dialog")
						[+] else
							[ ] ReportStatus("Verify Memo Text Field on Transfer Reminder dialog", FAIL , "Memo Text Field is not present on Transfer Reminder dialog")
					[ ] 
					[+] //Verify the OK Button present on Add Tag Memo dialog
						[+] if(DlgOptionalSetting.OKButton.Exists(5))
							[ ] ReportStatus("Verify OK Button on Transfer Reminder dialog ", PASS , "OK Button is present on Transfer Reminder dialog")
						[+] else
							[ ] ReportStatus("Verify OK Button on Transfer Reminder dialog", FAIL , "OK Button is not present on Transfer Reminder dialog")
					[ ] 
					[+] //Verify the Cancel Buttonpresent on Add Tag Memo dialog
						[+] if(DlgOptionalSetting.CancelButton.Exists(5))
							[ ] ReportStatus("Verify Cancel Button on Transfer Reminder dialog ", PASS , "Cancel Button is present on Transfer Reminder dialog")
						[+] else
							[ ] ReportStatus("Verify Cancel Button on Transfer Reminder dialog", FAIL , "Cancel Button is present on Transfer Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Add Tag Or Memo Panel on Transfer Reminder dialog ", FAIL , " Add Tag Or Memo Panel is not present on Transfer Reminder dialog")
					[ ] 
				[ ] 
			[ ] 
			[ ] DlgOptionalSetting.CancelButton.Click()
			[ ] 
			[ ] DlgAddEditReminder.CancelButton.Click()
		[+] else 
			[ ] ReportStatus("Upcoming from Bills Menu", FAIL , "Upcoming is not available as Add Reminder Button is not displayed")
			[ ] 
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
[ ] //############################################################################
[ ] 
[+] //###############TC72_TransferFunctionalityAddCategoryTagMemo()###################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC72_TransferFunctionalityAddCategoryTagMemo()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This test case will Verify functionality of "Add category, tag or memo" 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If error does not occurs
		[ ] //				        Fail		   If error does occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 12, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC72_TransferFunctionalityAddCategoryTagMemo() appstate QuickenBaseState
	[+] //Variable Declaration and defination
		[ ] list of STRING lsContents
		[ ] lsContents = {"AC1","M1"}
		[ ] sReminderType = "Transfer"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] //Opening a Existinf Data file
			[ ] iValidate = OpenDataFile(sFileName)
			[ ] 
			[+] if( iValidate==PASS)
				[ ] ReportStatus("Validate Data File ",  iValidate, "Data file -  {sDataFile} is created")
				[ ] 
				[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
				[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
				[ ] 
				[+] if(iValidate==PASS)
					[ ] // Verify Functionality of Add Category,Tag & Memo dialog
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
					[ ] 
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] 
					[ ] DlgOptionalSetting.TagTextFieldTxn.SetText(lsContents[1])
					[ ] 
					[ ] DlgOptionalSetting.MemoTextFieldTxn.SetText(lsContents[2])
					[ ] 
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] //Enter Data in Category,Tag & Memo Text Field
					[+] if(DlgOptionalSetting.NewTag.TagOKButton.Exists(5))
						[ ] DlgOptionalSetting.NewTag.TagOKButton.Click()
					[ ] 
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
					[ ] 
					[+] if(DlgOptionalSetting.TagTextFieldTxn.GetText()==lsContents[1])
						[ ] ReportStatus("Verify Tag Match",PASS, "Tag entry Match")
					[+] else
						[ ] ReportStatus("Verify Tag Match",FAIL, "Tag entry doesnot Match")
						[ ] 
					[+] if(DlgOptionalSetting.MemoTextFieldTxn.GetText()==lsContents[2])
						[ ] ReportStatus("Verify Memo Match",PASS, "Memo entry Match")
					[+] else
						[ ] ReportStatus("Verify Memo Match",FAIL, "Memo entry doesnot Match")
						[ ] 
					[ ] 
					[ ] DlgOptionalSetting.CancelButton.Click()
					[ ] DlgAddEditReminder.CancelButton.Click()
					[ ] 
					[ ] 
				[+] else 
					[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
				[ ] 
				[ ] //Report Staus If Data file is not Created 
			[+] else if( iValidate==FAIL)
				[ ] ReportStatus("Validate Data File ",  iValidate, "Data file -  {sDataFile} is created but it is not Opened")
				[ ] // Report Staus If Data file already exists
			[+] else
				[ ] ReportStatus("InValidate Data File ", iValidate, "File does not exists, Please change the Data File name")
			[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
[ ] //############################################################################
[ ] 
[ ] 
[+] //#############Verify Optional settings for Transfer Reminder #########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC74_VerifyTransferReminderOptionalSettings()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify options available in Optional settings section for Transfer Reminder
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Mar 04, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC74_VerifyTransferReminderOptionalSettings () appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] LIST OF STRING lsAddAccount
		[ ] 
		[ ] sReminderType = "Transfer"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sExcelDataFile, sAccountWorksheet)
	[ ] 
	[ ] // Create Data File
	[ ] iValidate = DataFileCreate(sFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Validate Data File ", iValidate, "Data file -  {sDataFile} is created")
		[ ] 
		[ ] // Create 2 checking accounts
		[+] for(i=1;i<=ListCount(lsExcelData);i++)
			[ ] // Fetch row from the given sheet
			[ ] lsAddAccount=lsExcelData[i]
			[ ] print(lsAddAccount)
			[ ] // Add Checking Account
			[ ] iValidate = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], sDateStamp)
			[ ] ReportStatus("Add Checking Account", iValidate, "Checking Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
			[ ] i=i+1
			[ ] 
		[ ] 
		[ ] // // Report Status if checking Account is created
		[+] // if (iValidate==PASS)
			[ ] // 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] // Click on Optional setting button and verify objects
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Exists(5))
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] 
				[ ] // Verify Remind Days In Advance Text
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceText.Exists(5))
					[ ] ReportStatus("Verify Remind Me 3 days in advance text",PASS,"Remind me 3 days in advance text is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Remind Me 3 days in advance text",FAIL,"Remind me 3 days in advance text is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] // Verify Remind Days In Advance Change Link
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
					[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",PASS,"Remind me 3 days in advance Change link is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",FAIL,"Remind me 3 days in advance Change link is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] // Verify Related Website Text
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteText.Exists(5))
					[ ] ReportStatus("Verify Related Website text",PASS,"Related website text is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Related website text",FAIL,"Related website text is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] // Verify Related Website Add Link
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
					[ ] ReportStatus("Verify Related wesite add Link",PASS,"Related website add link is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Related website add Link",FAIL,"Related website add link is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] // Verify Estimate Amount Text
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountText.Exists(5))
					[ ] ReportStatus("Verify Estimate amount for me:OFF text",PASS,"Estimate amount for me:OFF text is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Estimate amount for me:OFF text",FAIL,"Estimate amount for me:OFF text is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] // Verify Estimate Amount Change Link
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
					[ ] ReportStatus("Verify Estimate amount for me:OFF change link",PASS,"Estimate amount for me:OFF change link is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Estimate amount for me:OFF change link",FAIL,"Estimate amount for me:OFF change link is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] // Verify Sync To Outlook CheckBox
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.SyncToOutlookCheckBox.Exists(5))
					[ ] ReportStatus("Verify Sync to outlook checkbox",PASS,"Sync to outlook checkbox is available on Add {sReminderType} Reminder dialog")
				[+] else
					[ ] ReportStatus("Verify Sync to outlook checkbox",FAIL,"Sync to outlook checkbox is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] 
				[ ] // Click on Cancel
				[ ] DlgAddEditReminder.CancelButton.Click()
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Optional Setting button",FAIL,"Optional Setting button is not available on Add {sReminderType} Reminder dialog")
				[ ] 
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Add Checking Account", iValidate, "Checking Account -  {lsAddAccount[2]}  is not created")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Data file -  {sDataFile} is not created")
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify automatic enter transaction for Transfer Reminder #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC75_VerifyTransferReminderOptionalSettingsAutomaticEnterTxn()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify automatic enter transaction for Transfer Reminder
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Mar 04, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC75_VerifyTransferReminderOptionalSettingsAutomaticEnterTxn () appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sAmount,sMethod,sCheckingAccount
		[ ] LIST OF STRING lsAddAccount
		[ ] BOOLEAN bResult
		[ ] sAmount="20"
		[ ] sMethod="Transfer"
		[ ] sReminderType = "Transfer"
		[ ] sCheckingAccount="Checking 01"
		[ ] sBillStatus="Paid"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sExcelDataFile, sAccountWorksheet)
	[ ] lsAddAccount=lsExcelData[3]
	[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10) )
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(lsAddAccount[2])
			[ ] SETTING:
			[ ] // Click on Optional setting button and verify objects
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
					[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",PASS,"Remind me 3 days in advance Change link is available on Add {sReminderType} Reminder dialog")
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
					[+] if(DlgOptionalSetting.Exists(5))
						[ ] 
						[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
						[+] if(DlgOptionalSetting.RemindMeRadioList.Exists(5))
							[ ] ReportStatus("Verify Remind me radio list",PASS,"Remind me radio list is displayed")
							[ ] DlgOptionalSetting.RemindMeRadioList.TypeKeys(KEY_DN)
							[+] if(DlgOptionalSetting.DaysInAdvanceTextField.Exists(5))
								[ ] ReportStatus("Verify Automatically enter the transaction",PASS,"Automatically enter the transaction is selected")
								[ ] DlgOptionalSetting.OKButton.Click()
								[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Days In Advance list box",FAIL,"Days In Advance list box is not displayed")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Remind me radio list",FAIL,"Remind me radio list is not displayed")
					[+] else
						[ ] ReportStatus("Verify Optional Setting window", FAIL, "Optional setting window is not displayed")
				[+] else
					[ ] ReportStatus("Verify Remind Me 3 days in advance Change Link",FAIL,"Remind me 3 days in advance Change link is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] sleep(1)
				[ ] DlgAddEditReminder.SetActive()
				[ ] DlgAddEditReminder.TextClick("Done")        //       (1, 36, 12)
				[ ] WaitForState(DlgAddEditReminder , FALSE ,5)
				[ ] sleep(3)
				[ ] // Relaunch Quicken
				[ ] LaunchQuicken()
				[ ] ExpandAccountBar()
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] // Navigate to Bills Tab
				[ ] NavigateQuickenTab(sTAB_BILL)
				[ ] //select stack view
				[ ] MDIClient.Bills.ViewAsPopupList.Select(1)
				[ ] // Verify Go to Register button
				[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Exists(5))
					[ ] ReportStatus("Verify Go to Register button",PASS,"Scheduled bill is Paid as Go to Register button is displayed")
				[+] else
					[ ] ReportStatus("Verify Go to Register button",FAIL,"Scheduled bill is not Paid as Go to Register button is not displayed")
				[ ] 
				[ ] //Verify Transfer Method
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
				[+] if (DlgManageReminders.Exists(5))
					[ ] DlgManageReminders.AllBillsDepositsTab.Click()
					[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
					[ ] // Verify  method
					[ ] bResult = MatchStr("*{sMethod}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of Automatic Enter Transaction for Transfer Reminder ", PASS, "Transfer Reminder with '{sMethod}' method is added successfully")
					[+] else
						[ ] ReportStatus("Verification of Print Check for Bill Reminder  ", FAIL, "Transfer Reminder for {sMethod} is NOT added, sActual = {sActual}")
						[ ] 
					[ ] DlgManageReminders.Close()
				[+] else
					[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Manage Reminder is NOT added")
					[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,NULL,0,0,sBillStatus)
				[ ] // iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
					[ ] 
					[ ] SelectAccountFromAccountBar(sCheckingAccount,ACCOUNT_BANKING)
					[ ] DeleteTransaction(sWindowTypeMDI,sPayeeName)
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Delete Reminder", FAIL, "Reminder not deleted")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //#############Verify UI of "Related website"  for Transfer Reminder ####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC76_VerifyTransferReminderOptionalSettingsRelatedWebsite()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify UI of "Related website" for Transfer Reminder
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Mar 07, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC76_VerifyTransferReminderOptionalSettingsRelatedWebsite () appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sAmount,sWebsite,sActualWebsite,sToAccount
		[ ] 
		[ ] sAmount="20"
		[ ] sWebsite="www.google.com"
		[ ] sReminderType = "Transfer"
		[ ] sToAccount="Checking 02"
		[ ] 
		[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10) )
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sToAccount)
			[ ] 
			[ ] SETTING:
			[ ] // Click on Optional setting button and verify objects
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
					[ ] ReportStatus("Verify Related Website Add Link",PASS,"Related Website Add Link is available on Add {sReminderType} Reminder dialog")
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Click()
					[+] if(DlgOptionalSetting.Exists(5))
						[ ] 
						[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
						[+] if(DlgOptionalSetting.WebsiteTextField.Exists(5))
							[ ] ReportStatus("Verify Website text field",PASS,"Website text field is displayed")
							[ ] DlgOptionalSetting.WebsiteTextField.SetText(sWebsite)
							[ ] DlgOptionalSetting.OKButton.Click()
							[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Website text field",FAIL,"Website text field is not displayed")
					[+] else
						[ ] ReportStatus("Verify Optional Setting window", FAIL, "Optional setting window is not displayed")
				[+] else
					[ ] ReportStatus("Verify Related Website Add Link",FAIL,"Related Website Add Link is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] DlgAddEditReminder.DoneButton.Click()          //           (1, 36, 12)
				[ ] 
				[ ] // Verify entered link in Bills > Stack view
				[ ] 
				[ ] 
				[ ] 
				[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.WebsiteLink.Exists(5))
					[ ] //MDIClient.Bills.Panel.Panel1.QWinChild.WebsiteLink.Click()           //(1, 65, 27)
					[ ] sActualWebsite=MDIClient.Bills.Panel.Panel1.QWinChild.WebsiteLink.GetCaption()
					[ ] 
					[ ] 
					[ ] // print(sActualWebsite)
					[ ] // print(sWebsite)
					[ ] 
					[ ] 
					[+] // if(sActualWebsite==sWebsite)
						[ ] // ReportStatus("Verify entered website in {sReminderType} Reminder",PASS,"Entered Website is displayed correctly i.e. {sWebsite}")
					[+] // else
						[ ] // ReportStatus("Verify entered website in {sReminderType} Reminder",FAIL,"Entered Website is not displayed correctly, Expected- {sWebsite} and Actual-{sActualWebsite}")
						[ ] // 
					[ ] 
					[ ] bMatch=MatchStr("*{sWebsite}*",sActualWebsite)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify entered website in {sReminderType} Reminder",PASS,"Entered Website is displayed correctly i.e. {sWebsite}")
					[+] else
						[ ] ReportStatus("Verify entered website in {sReminderType} Reminder",FAIL,"Entered Website is not displayed correctly, Expected- {sWebsite} and Actual-{sActualWebsite}")
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify {sReminderType} created",FAIL,"Created {sReminderType} not displayed in stack view")
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
				[+] else
					[ ] ReportStatus("Delete Reminder", FAIL, "Reminder not deleted")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //#############Verify "Go to Website" link for Transfer Reminder######################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC77_VerifyTransferReminderOptionalSettingsGoToWebsiteLink()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify appearance of "Go to Website" link in Add Transfer Reminder dialog when website is entered
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Mar 07, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC77_VerifyTransferReminderOptionalSettingsGoToWebsiteLink () appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sAmount,sWebsite,sLinkName,sExpectedLink,sToAccount
		[ ] 
		[ ] sAmount="20"
		[ ] sWebsite="www.google.com"
		[ ] sExpectedLink="(change)"
		[ ] sReminderType = "Transfer"
		[ ] sToAccount="Checking 02"
		[ ] 
		[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10) == True)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bill Details page 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sToAccount)
			[ ] 
			[ ] SETTING:
			[ ] // Click on Optional setting button and verify objects
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
				[ ] // Verify Add link for Related Website
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
					[ ] ReportStatus("Verify Related Website Add Link",PASS,"Related Website Add Link is available on Add {sReminderType} Reminder dialog")
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Click()
					[ ] 
					[+] if(DlgOptionalSetting.Exists(5))
						[ ] 
						[ ] // Enter website
						[+] if(DlgOptionalSetting.WebsiteTextField.Exists(5))
							[ ] ReportStatus("Verify Website text field",PASS,"Website text field is displayed")
							[ ] DlgOptionalSetting.WebsiteTextField.SetText(sWebsite)
							[ ] DlgOptionalSetting.OKButton.Click()
							[ ] 
							[ ] // Verify add link is converted to change link
							[ ] sLinkName=DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.GetCaption()
							[+] if(sLinkName==sExpectedLink)
								[ ] ReportStatus("Verify Add link",PASS,"add link is converted in to change link")
							[+] else
								[ ] ReportStatus("Verify Add link",FAIL,"add link is not converted in to change link")
								[ ] 
							[ ] // Verify Go To Website link
							[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.GoToWebsite.Exists(5))
								[ ] ReportStatus("Verify Go To Website link",PASS,"Go To Website link is displayed")
							[+] else
								[ ] ReportStatus("Verify Go To Website link",FAIL,"Go To Website link is not displayed")
								[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Website text field",FAIL,"Website text field is not displayed")
					[+] else
						[ ] ReportStatus("Verify Optional Setting window", FAIL, "Optional setting window is not displayed")
				[+] else
					[ ] ReportStatus("Verify Related Website Add Link",FAIL,"Related Website Add Link is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] DlgAddEditReminder.CancelButton.Click (1, 36, 12)
				[ ] 
				[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
		[+] else
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //#############Verify sync to outlook checkbox for Transfer Reminder #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC78_VerifyTransferReminderOptionalSettingsSyncOutlook()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality of sync to outlook checkbox in Add Transfer Reminder dialog
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while verification						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //       Mar 07, 2013       Udita Dube  created
	[ ] // ********************************************************
[+] testcase TC78_VerifyTransferReminderOptionalSettingsSyncOutlook() appstate QuickenBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] STRING sAmount,sToAccount
		[ ] 
		[ ] sAmount="30"
		[ ] sReminderType = "Transfer"
		[ ] sToAccount="Checking 02"
		[ ] 
		[ ] 
	[ ] 
	[ ] // Verify that Quicken is launched
	[+] if (QuickenWindow.Exists(10) == True)
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Bills Tab
		[ ] NavigateQuickenTab(sTAB_BILL)
		[ ] 
		[ ] // Verify Sync to outlook button is not present
		[+] if(!MDIClient.Bills.SyncToOutlookButton.Exists(5))
			[ ] ReportStatus("Verify Sync to Outlook button on {sReminderType} window",PASS,"Sync to Outlook button is not available")
			[ ] 
			[ ] // Navigate to Bill Details page 
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sToAccount)
				[ ] 
				[ ] // Click on Optional setting button and verify objects
				[ ] // Verify Sync to Outlook check box
				[ ] 
				[+] // if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.SyncToOutlookCheckBox.Exists(2))
					[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] // 
				[ ] // 
				[+] // if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.SyncToOutlookCheckBox.Exists(5))
					[ ] // ReportStatus("Verify Sync to Outlook check box",PASS,"Sync to Outlook check box is available on Add {sReminderType} Reminder dialog")
				[+] // else
					[ ] // ReportStatus("Verify Sync to Outlook check box",FAIL,"Sync to Outlook check box is not available on Add {sReminderType} Reminder dialog")
				[ ] // 
				[ ] // DlgAddEditReminder.DoneButton.Click ()
				[ ] // 
				[+] // if(Bills.SyncToOutlookButton.Exists(5))
					[ ] // ReportStatus("Verify Sync to Outlook check box",PASS,"Sync to Outlook check box is checked on Add {sReminderType} Reminder dialog")
					[ ] // ReportStatus("Verify Sync to Outlook button on {sReminderType} window",PASS,"Sync to Outlook button is available")
				[+] // else
					[ ] // ReportStatus("Verify Sync to Outlook check box",FAIL,"Sync to Outlook check box is not checked on Add {sReminderType} Reminder dialog")
					[ ] // ReportStatus("Verify Sync to Outlook button on {sReminderType} window",FAIL,"Sync to Outlook button is not available")
					[ ] // 
				[ ] 
				[ ] // Verify Sync to Outlook check box
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.SyncToOutlookCheckBox.Exists(5))
					[ ] ReportStatus("Verify Sync to Outlook check box",PASS,"Sync to Outlook check box is available on Add {sReminderType} Reminder dialog")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Sync to Outlook check box",FAIL,"Sync to Outlook check box is not available on Add {sReminderType} Reminder dialog")
				[ ] 
				[ ] DlgAddEditReminder.DoneButton.Click ()
				[ ] 
				[+] if(MDIClient.Bills.SyncToOutlookButton.Exists(5))
					[ ] ReportStatus("Verify Sync to Outlook check box",PASS,"Sync to Outlook check box is checked on Add {sReminderType} Reminder dialog")
					[ ] ReportStatus("Verify Sync to Outlook button on {sReminderType} window",PASS,"Sync to Outlook button is available")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Sync to Outlook check box",FAIL,"Sync to Outlook check box is not checked on Add {sReminderType} Reminder dialog")
					[ ] ReportStatus("Verify Sync to Outlook button on {sReminderType} window",FAIL,"Sync to Outlook button is not available")
					[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Delete Reminder", FAIL, "Reminder not deleted")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Sync to Outlook button on {sReminderType} window",FAIL,"Sync to Outlook button is already  available")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken main window",FAIL,"Quicken main window is not available")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] 
[+] //###############TC79_TransferUIEstimateAmount()################################
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC79_TransferUIEstimateAmount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify UI of Estimate amount for me "change" link window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If all UI controls  Estimate amount for me "change" link window is correct
		[ ] //				        Fail         If all UI controls  Estimate amount for me "change" link window is not correct
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 14, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC79_TransferUIEstimateAmount() appstate QuickenBaseState
	[+] //Variable Declaration and defination
		[ ] list of STRING Estimate = {"Fixed amount","Previous payments","Time of year"}
		[ ] sReminderType = "Transfer"
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] 
			[ ] QuickenWindow.SetActive()
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] SETTING :
			[ ] // Verify the 'Estimate for Me' dialog is present
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
				[ ] 
				[ ] //Get the contents of Quicken Can Help You Estimate PopupList
				[ ] lsCompare=DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.GetContents()
				[ ] 
				[+] //Verify the UI Controls on the 'Estimate for Me' dialog
					[+] //Verify Quicken Can Help You Estimate Popup List on 'Estimate for Me' dialog
						[+] if(DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Exists(5))
							[ ] ReportStatus("Verify Estimate Popup List on 'Estimate for Me' dialog ", PASS , "Estimate Popup List is present on 'Estimate for Me' dialog")
						[+] else
							[ ] ReportStatus("Verify Estimate Popup List on 'Estimate for Me' dialog", FAIL , "Estimate Popup List is not present on 'Estimate for Me' dialog")
					[ ] 
					[+] //Verify the contents in Estimate Popup List on 'Estimate for Me' dialog
						[+] for(j=1;j<=listCount(Estimate);j++)
							[+] if(Estimate[j]==lsCompare[j])
								[ ] ReportStatus("Verify the Contents of Estimate Popup List",PASS,"As {Estimate[j]} = {lsCompare[j]} is same")
							[+] else
								[ ] ReportStatus("Verify the Contents of Estimate Popup List",FAIL,"As {Estimate[j]} = {lsCompare[j]} is not same")
					[ ] 
					[+] //Verify the contents in Estimate Popup List on 'Estimate for Me' dialog
						[+] if(DlgOptionalSetting.QuickenCanHelpYouEstimateTextField.Exists(5))
							[ ] ReportStatus("Verify Estimate Text Field on 'Estimate for Me' dialog ", PASS , "Estimate Text Field is present on 'Estimate for Me' dialog")
						[+] else
							[ ] ReportStatus("Verify Estimate Text Field on 'Estimate for Me' dialog", FAIL , "Estimate Text Field is not present on 'Estimate for Me' dialog")
						[ ] 
					[ ] 
					[+] //Verify the contents in OK Button on 'Estimate for Me' dialog
						[+] if(DlgOptionalSetting.OKButton.Exists(5))
							[ ] ReportStatus("Verify OK Button on 'Estimate for Me' dialog  ", PASS , "OK Button is present on 'Estimate for Me' dialog")
						[+] else
							[ ] ReportStatus("Verify OK Button on 'Estimate for Me' dialog ", FAIL , "OK Button is not present on 'Estimate for Me' dialog")
							[ ] 
					[ ] 
					[+] //Verify the contents in Cancel Button on 'Estimate for Me' dialog
						[+] if(DlgOptionalSetting.CancelButton.Exists(5))
							[ ] ReportStatus("Verify Cancel Button on 'Estimate for Me' dialog ", PASS , "Cancel Button is present on 'Estimate for Me' dialog")
						[+] else
							[ ] ReportStatus("Verify Cancel Button on 'Estimate for Me' dialog", FAIL , "Cancel Button is not present on 'Estimate for Me' dialog")
				[ ] 
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] DlgOptionalSetting.CancelButton.Click()
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
				[ ] DlgAddEditReminder.CancelButton.Click()
				[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
				[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
			[ ] 
[ ] //############################################################################
[ ] 
[+] //###############Verify functionality of Previous Payments in Estimate amount for me #####
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC80_TransferFunctionalityPreviousPayments()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Previous Payments in Estimate amount for me 
		[ ] //  change) link in Add Bill Reminder dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Previous Payments in Estimate amount for me "change" link is correct
		[ ] //        Fail		   If functionality of Previous Payments in Estimate amount for me "change" link is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 14, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC80_TransferFunctionalityPreviousPayments() appstate QuickenBaseState
	[+] //Variable Declaration and defination
		[ ] INTEGER iOpenAccountRegister,iEnterTransaction
		[ ] STRING sAmount,sAmountCompare,sDate
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sPayeeName="Test Bill"
		[ ] sDate = ModifyDate(-365,sDateFormat)
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] 
		[ ] // Opening Checking Account Register
		[ ] iOpenAccountRegister=AccountBarSelect(sAccountType,1)
		[ ] 
		[+] if(iOpenAccountRegister==0)
			[ ] ReportStatus("Account is selected from AccountBar", PASS , "Account is selected from AccountBar")
			[ ] //Entering two transactions in Register
			[ ] lsExcelData=ReadExcelTable(sExcelDataFile, sCheckingTransactionWorksheet)
			[ ] sAmountCompare=lsExcelData[1][6]
			[+] for(i=1;i<=ListCount(lsExcelData);i++)
				[ ] 
				[ ] // Fetch ith row from the given sheet
				[ ] lsTransactionData=lsExcelData[i]
				[ ] iEnterTransaction=AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2],lsTransactionData[3],sDate,lsTransactionData[4],lsTransactionData[5])
				[ ] ReportStatus("Add Checking Transaction",iEnterTransaction,"Transaction {i} added")
				[ ] 
			[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[ ] 
			[+] if(iValidate==PASS)
				[ ] SETTING :
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", PASS , "  Estimate Amount Change Link is present under Optional Settings")
					[ ] 
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
					[ ] 
					[+] //verify the functionality of Previous Payments option
						[+] if(DlgOptionalSetting.Exists(5))
							[ ] 
							[ ] ReportStatus("Verify  'Estimate for Me' dialog present", PASS , " 'Estimate for Me' dialog is present")
							[ ] 
							[ ] 
							[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
							[ ] 
							[ ] //Select the second option from Estimate Popup List on 'Estimate for Me' dialog for Previous Payments
							[ ] DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Select("#2")
							[ ] 
							[ ] 
							[ ] //Set '2'as last payments
							[ ] DlgOptionalSetting.LastTextField.SetText("2")
							[ ] 
							[ ] DlgOptionalSetting.OKButton.Click()
							[ ] 
							[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
							[ ] 
							[ ] //Amount gets calculated automatically from Previous Payments
							[ ] // sAmount=DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.GetText()
							[ ] sAmount=DlgAddEditReminder.Step2Panel.QWinChild1.EstimatedAmountText.GetText()
							[ ] 
							[ ] 
							[ ] //Verify the Average amount for previous payments
							[+] if(sAmount == sAmountCompare)
								[ ] ReportStatus("Verify Estimate Amount :Previous Payments option ", PASS , "Previous Payments option is set properly as it is showing Average amount{sAmount}")
							[+] else
								[ ] ReportStatus("Verify Estimate Amount :Previous Payments option ", FAIL , "Previous Payments option is not set properly as it is not showing Average amount same {sAmount},{sAmountCompare}")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify  'Estimate for Me' dialog present", FAIL , " 'Estimate for Me' dialog is not present")
				[+] else
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
					[ ] goto SETTING
					[ ] 
				[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
				[ ] DlgAddEditReminder.Close()
				[ ] 
				[ ] 
			[+] else 
				[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
		[+] else
			[ ] ReportStatus("Account is selected from AccountBar", FAIL , "Account is not selected from AccountBar")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
[ ] //############################################################################
[ ] 
[+] //###############Verify functionality of Fixed Amount in Estimate amount for me #########
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC81_TransferFunctionalityFixedAmount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Fixed Amount in Estimate amount for me  
		[ ] // "change" link in Add Income Reminder dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Fixed Amount in Estimate amount for me "change" link is correct
		[ ] //        Fail		   If functionality of Previous Payments in Estimate amount for me change link is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 15, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC81_TransferFunctionalityFixedAmount() appstate QuickenBaseState
	[+] //Variable Declaration and defination
		[ ] INTEGER iOpenAccountRegister,iEnterTransaction
		[ ] STRING sAmount,sAmountCompare 
		[ ] 
		[ ] sAmount="50.00"
		[ ] sReminderType = "Bill"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenMainWindow.VerifyEnabled(TRUE,20)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] SETTING :
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", PASS , "  Estimate Amount Change Link is present under Optional Settings")
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", PASS , " 'Estimate for Me' dialog is present")
					[ ] 
					[+] //verify the functionality of Fixed Amounts option
						[ ] 
						[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
						[ ] 
						[ ] //select first option for Fixed Amount
						[ ] DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Select("#1")
						[ ] 
						[ ] //set Fixed Amount 
						[ ] DlgOptionalSetting.QuickenCanHelpYouEstimateTextField.SetText(sAmount)
						[ ] 
						[ ] DlgOptionalSetting.OKButton.Click()
						[ ] 
						[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
						[ ] 
						[ ] sAmountCompare=DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.GetText()
						[ ] 
						[ ] //Verify the fixed amount is set
						[+] if(sAmount == sAmountCompare)
							[ ] ReportStatus("Verify Estimate Amount :Fixed Amount option ", PASS , "Fixed Amount option is set properly as {sAmount} ")
						[+] else
							[ ] ReportStatus("Verify Estimate Amount :Fixed Amount option ", FAIL , "Fixed Amount option is not set properly as it is not same {sAmount},{sAmountCompare}")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", FAIL , " 'Estimate for Me' dialog is not present")
				[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
				[ ] 
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
			[ ] DlgAddEditReminder.CancelButton.Click()
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
[ ] //############################################################################
[ ] 
[+] //###############Verify functionality of Time Of Year in Estimate amount for me ##########
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC82_TransferFunctionalityTimeOfYear() 
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Time Of Year in Estimate amount for me  
		[ ] // "change" link in Add Income Reminder dialog
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Time Of Year in Estimate amount for me "change" link is correct
		[ ] //        Fail		   If functionality of Previous Payments in Estimate amount for me "change" link is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 15, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC82_TransferFunctionalityTimeOfYear() appstate QuickenBaseState
	[+] //Variable Declaration and defination
		[ ] INTEGER iOpenAccountRegister,iEnterTransaction
		[ ] STRING sAmount,sAmountCompare
		[ ] 
		[ ] sAmountCompare ="$500.00"
		[ ] sReminderType = "Bill"
		[ ] sPayeeName="Insurance Bill"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenMainWindow.VerifyEnabled(TRUE,20)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] SETTING :
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", PASS , "  Estimate Amount Change Link is present under Optional Settings")
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
				[ ] 
				[ ] //verify the functionality of Time of Year option
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", PASS, " 'Estimate for Me' dialog is present")
					[ ] 
					[ ] 
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] 
					[ ] //Time of year gets selected and it will automatically insert the last year paid amount 
					[ ] 
					[ ] DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Select("#3")
					[ ] 
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] 
					[ ] //Verify the amount with last year amount
					[ ] // sAmount=DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.GetText()
					[ ] sAmount=DlgAddEditReminder.Step2Panel.QWinChild1.EstimatedAmountText.GetText()
					[ ] 
					[ ] 
					[+] if(sAmount == sAmountCompare)
						[ ] ReportStatus("Verify Estimate Amount :Time of Year option ", PASS , "Time of Year option is set properly as it is showing Last year amount{sAmountCompare}")
					[+] else
						[ ] ReportStatus("Verify Estimate Amount :Time of Year option ", FAIL , "Time of Year option is not set properly as it is not showing Last year amount {sAmount},{sAmountCompare}")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify  'Estimate for Me' dialog present", FAIL , " 'Estimate for Me' dialog is not present")
			[ ] 
			[+] else
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] goto SETTING
				[ ] 
			[ ] 
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,TRUE)
			[ ] DlgAddEditReminder.CancelButton.Click()
			[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
[ ] //############################################################################
[ ] 
[+] //###############Verify functionality of Done button on "Add Transfer Reminder" dialog#####
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC83_TransferFunctionalityDoneButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Done button on "Add Transfer Reminder" dialog
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If error does not occurs
		[ ] //				        Fail		   If error does occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 1, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC83_TransferFunctionalityDoneButton()appstate QuickenBaseState 
	[+] //Variable Declaration and defination
		[ ] INTEGER iSetupAutoAPI,iValidate
		[ ] 
		[ ] STRING sAmount="500.00",sAmountCompare,sFromAccount,sToAccount
		[ ] LIST OF ANYTYPE  lsReminderList
		[ ] sReminderType = "Transfer"
		[ ] sPayeeName="DoneButtonPayee"
		[ ] sFromAccount ="Checking 01"
		[ ] sToAccount = "Checking 02"
		[ ] 
	[ ] 
	[ ] // Create Data File
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] //Set the Amount 
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
			[ ] //Set From Account for Transfer
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.SetText(sFromAccount)
			[ ] //Set to Account for Transfer
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sToAccount)
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] WaitForState(DlgAddEditReminder ,False,5)
			[ ] 
			[ ] //Select List view 
			[ ] 
			[ ] MDIClient.Bills.ViewAsPopupList.Select("#2")
			[ ] 
			[ ] MDIClient.Bills.AccountPopupList.Select("#1")
			[ ] 
			[ ] //Bills.ViewAsPopupList.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] //Retrieve the data from the 2nd Row
			[ ] sHandle = Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
			[ ] iListCount =MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
			[ ] 
			[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr("*{sPayeeName}*",sActual)
				[+] if (bMatch)
					[ ] break
			[ ] 
			[ ] //Verify whether it is present in the list
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Verify Validate Reminder in List view", PASS, "{sPayeeName}  is available in Transfer Reminder in List view")
			[+] else
				[ ] ReportStatus("Verify Validate Reminder in List view", FAIL, "{sPayeeName}  is not available in Transfer Reminder in List view")
			[ ] 
			[ ] 
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
		[ ] 
		[ ] 
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //############################################################################
[ ] 
[+] //###############TC84_TransferFunctionalityCancelButton()###########################
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC84_TransferFunctionalityCancelButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Cancel button on "Add Transfer Reminder" dialog 
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If error does not occurs
		[ ] //				        Fail		   If error does occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC84_TransferFunctionalityCancelButton() appstate QuickenBaseState 
	[+] //Variable Declaration and defination
		[ ] integer iSetupAutoAPI 
		[ ] STRING sAmount="500.00",sAmountCompare,sFromAccount,sToAccount
		[ ] list of AnyType  lsReminderList
		[ ] sReminderType = "Transfer"
		[ ] sPayeeName="CancelButtonPayee"
		[ ] sFromAccount ="Checking"
		[ ] sToAccount = "Savings"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[ ] 
			[+] if(iValidate==PASS)
				[ ] //Set the Amount 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
				[ ] //Set From Account for Transfer
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.SetText(sFromAccount)
				[ ] //Set to Account for Transfer
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sToAccount)
				[ ] 
				[ ] DlgAddEditReminder.CancelButton.Click()
				[ ] 
				[ ] 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
				[+] if (DlgManageReminders.Exists(5))
					[ ] DlgManageReminders.AllBillsDepositsTab.Click()
					[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
					[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
					[ ] //for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bMatch = MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Reminder with '{sPayeeName}' is not added")
					[+] else
						[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Reminder with '{sPayeeName}' is added")
						[ ] 
					[ ] DlgManageReminders.Close()
				[+] else
					[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
				[ ] 
				[ ] 
				[ ] 
				[ ] // NavigateQuickenTab(sTAB_BILL)
				[+] // if(MDIClient.Bills.Panel.QWMsHtmlVw1.ShellEmbedding1.ShellDocObjectView1.GetStartedBillsButton.Exists(2))
					[ ] // ReportStatus("Verify Reminder is not added", PASS, "{sPayeeName} is not available Transfer Reminder is not added")
				[+] // else
					[ ] // ReportStatus("Verify Reminder is added", FAIL, "{sPayeeName}  is available in  Transfer Reminder in List view")
				[ ] 
				[ ] 
				[ ] 
				[ ] // //Select List view 
				[ ] // Bills.ViewAsPopupList.Select("#2")
				[ ] // Bills.ViewAsPopupList.TypeKeys(KEY_ENTER)
				[ ] // 
				[ ] // //Retrieve the data from the 2nd Row
				[ ] // sHandle = Str(Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[ ] // sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
				[ ] // bMatch = MatchStr("*{sPayeeName}*",sActual)
				[ ] // 
				[ ] // //verify that the cancelled reminder should not be in the list
				[+] // if(bMatch != TRUE)
					[ ] // ReportStatus("Verify Reminder is not added", PASS, "{sPayeeName} is not available Transfer Reminder is not added")
				[+] // else
					[ ] // ReportStatus("Verify Reminder is added", FAIL, "{sPayeeName}  is available in  Transfer Reminder in List view")
			[ ] 
			[+] else 
				[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //###############TC85_TransferFunctionalityHelpIcon()###############################
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC85_TransferFunctionalityHelpIcon()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of help icon on Add Bill Reminder dialog
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of help icon is correct
		[ ] //        Fail		   If functionality of help icon is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC85_TransferFunctionalityHelpIcon() appstate QuickenBaseState 
	[+] //Variable Declaration and defination
		[ ] i=3
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_BILL)
		[ ] //Navigation
		[+] if(QuickenMainWindow.QWNavigator.AddReminder.Exists(5))
			[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
			[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(Replicate(KEY_DN, i)) 
			[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] //Verify Help icon on Add Bill Reminder
			[+] if(DlgAddEditReminder.HelpButton.Exists(5))
				[ ] ReportStatus("Verify  Help Icon on Add Transfer Reminder", PASS , "Help Icon is present in Add Transfer Reminder dialog ")
				[ ] 
				[ ] DlgAddEditReminder.HelpButton.click()
				[ ] sleep(3)
				[ ] 
				[ ] //Help Dialog gets opened
				[+] if(QuickenHelp.Exists(5))
					[ ] ReportStatus("Verify Help Dialog ", PASS , "Help Dialog is present in Add Transfer Reminder dialog ")
					[ ] QuickenHelp.Close()
				[+] else
					[ ] ReportStatus("Verify Help Dialog", FAIL , "Help Dialog is not present")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify  Help Icon on Add Transfer Reminder", FAIL , "Help Icon is not present in Add Transfer Reminder dialog ")
				[ ] 
				[ ] 
			[ ] DlgAddEditReminder.Close()
			[ ] 
		[+] else 
			[ ] ReportStatus("Upcoming from Bills Menu", FAIL , "Upcoming is not available as Add Reminder Button is not displayed")
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC86_TransferFunctionalityBackButton()#############################
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC86_TransferFunctionalityBackButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Back button on "Add Bill Reminder" dialog
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Back button  is correct
		[ ] //        Fail		   If functionality of Back button  is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC86_TransferFunctionalityBackButton() appstate QuickenBaseState 
	[+] //Variable Declaration and defination
		[ ] STRING sAmount="500.00",sFromAccount ="Checking",sToAccount = "Savings"
		[ ] STRING sPayee="BackButtonPayee"
		[ ] sReminderType = "Transfer"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
				[ ] 
				[ ] //Set the Amount 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
				[ ] //Set From Account for Transfer
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.FromAccountTextField.SetText(sFromAccount)
				[ ] //Set to Account for Transfer
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sToAccount)
				[ ] 
				[ ] 
				[+] //verifying some Objects present on Second Screen of Add Transfer Reminder
					[ ] 
					[+] // Verify Due Next On TextField on Add Transfer Reminder Second Screen
						[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.Exists(5))
							[ ] ReportStatus("Verify Due Next On TextField on Add Transfer Reminder Second Screen", PASS , "Due Next On TextField is present on Add Transfer Reminder Second Screen ")
						[+] else
							[ ] ReportStatus("Verify Due Next On TextField on Add Transfer Reminder Second Screen", FAIL , "Due Next On TextField is not present on Add Transfer Reminder Second Screen")
						[ ] 
					[+] // Verify OptionalSettings on Add Transfer Reminder Second Screen
						[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Exists(5))
							[ ] ReportStatus("Verify OptionalSettings on Add Transfer Reminder Second Screen", PASS , "OptionalSettings is present on Add Transfer Reminder Second Screen")
						[+] else
							[ ] ReportStatus("Verify OptionalSettings on Add Transfer Reminder Second Screen", FAIL , "OptionalSettings is not present on Add Transfer Reminder Second Screen")
					[ ] 
					[ ] //Click Back Button
					[ ] DlgAddEditReminder.BackButton.Click()
					[ ] 
					[+] //verifying some Objects present on Second Screen of Add Transfer Reminder
						[+] // Verify Amount Due on Add Transfer Reminder First Screen
							[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.Exists(5))
								[ ] ReportStatus("Verify Amount Due on Add Transfer Reminder First Screen", PASS ,"Amount Due is not present on Add Transfer Reminder First Screen")
							[+] else
								[ ] ReportStatus("Verify Amount Due on Add Transfer Reminder First Screen", FAIL ,"Amount Due is present on Add Transfer Reminder First Screen")
					[+] // Verify OptionalSettings on Add Transfer Reminder Second Screen
						[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Exists(5))
							[ ] ReportStatus("Verify OptionalSettings on Add Transfer Reminder Second Screen", PASS , "OptionalSettings is not present on Add Transfer Reminder Second Screen")
						[+] else
							[ ] ReportStatus("Verify OptionalSettings on Add Transfer Reminder Second Screen", FAIL , "OptionalSettings is  present on Add Transfer Reminder Second Screen")
						[ ] 
					[ ] 
					[ ] DlgAddEditReminder.CancelButton.Click()
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
			[ ] 
			[ ] 
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[ ] 
[+] // ###############TC88_TransferReminderOptionExists()##############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC88_TransferReminderOptionExists()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify that transfer reminder option doesn't exists if data file has only one active account
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If transfer reminder option doesn't exists
		[ ] //        					Fail		   If transfer reminder option exists or error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 27, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC88_TransferReminderOptionExists() appstate QuickenBaseState 
	[+] // Variable declaration and definition
		[ ] INTEGER iRegistration,iValidate
		[ ] List of LIST OF STRING lsAccount
		[ ] sReminderType = "Transfer"
		[ ] sFileName = "Scheduled_Transactions"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] STRING sActualName, sAccountType,sAccountName,sAccountBalance,sAccountCreateDate, sDialogName
		[ ] sAccountType ="Checking"
		[ ] sAccountName = "Checking 01"
		[ ] sAccountBalance = "5000"
		[ ] sAccountCreateDate = sDateStamp
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
		[+] if (iValidate==PASS)
			[+] if (DlgAddEditReminder.Exists(5))
				[ ] DlgAddEditReminder.SetActive()
				[ ] sActualName = "Add Transfer Reminder"
				[ ] iValidate=VerifyReminderDialog(sActualName)
				[+] if( iValidate == PASS)
					[ ] ReportStatus("Add Transfer Reminder", PASS, "Add Transfer reminder option is not available as only one account is present in the data file")
				[+] else
					[ ] ReportStatus("Add Transfer Reminder", FAIL, "Add Transfer reminder option is  available even if only one account is present in the data file")
				[ ] DlgAddEditReminder.Close()
		[+] else
			[ ] ReportStatus("Add Transfer Reminder", FAIL, "Add Transfer Reminder dialog is NOT launched") 
		[ ] 
		[ ] 
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] // ###############TC91_DeleteToAccount()#########################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC88_TransferReminderOption()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify that transfer reminder will get entered without any category if user deletes 'To Account' before entering the reminder
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If transfer reminder get entered without any category
		[ ] //        					Fail		   If transfer reminder get entered with category or some error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 28, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC91_TransferReminderOption() appstate QuickenBaseState 
	[+] //Variable Declaration and defination
		[ ] STRING sAccountType, sAccountName, sAccountBalance,sAccountCreateDate, sDialogName, sActualName, sTab, sTransferAmount,sFromAccount, sVerifyCategory
		[ ] List of STRING lsTransaction
		[ ] boolean bCheckStatus, bResult
		[ ] 
		[ ] sFileName = "Scheduled_Transactions"
		[ ] sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sAccountType ="Savings"
		[ ] sAccountName = "Savings 01"
		[ ] sAccountBalance = "5000"
		[ ] sAccountCreateDate = sDateStamp
		[ ] sTab= "General"
		[ ] sTransferAmount = "5.12"
		[ ] sReminderType = "Transfer"
		[ ] sFromAccount = "Checking 01"
		[ ] sVerifyCategory = "[Savings 01]"
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] //Add a manual Saving account.
		[ ] iValidate=AddManualSpendingAccount( sAccountType,sAccountName,sAccountBalance, sAccountCreateDate )
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Manual Saving Account ", PASS, "Manual saving account is added")
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
			[+] if (iValidate==PASS)
				[+] if (DlgAddEditReminder.Exists(5))
					[ ] DlgAddEditReminder.SetActive()
					[ ] 
					[ ] sActualName = "Add Transfer Reminder"
					[ ] iValidate=VerifyReminderDialog(sActualName)
					[+] if( iValidate == PASS)
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransferAmount)
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(sAccountName)
						[ ] DlgAddEditReminder.DoneButton.Click()
						[ ] 
					[+] else
						[ ] ReportStatus("Add Transfer Reminder", FAIL, "Add Transfer reminder dialog is not opened")
			[+] else
				[ ] ReportStatus("Add Transfer Reminder", FAIL, "Add Transfer Reminder dialog is NOT launched") 
			[ ] 
			[ ] // Delete Savings 01 account
			[ ] iValidate = NavigateToAccountDetailsTab(ACCOUNT_BANKING,sAccountName,sTab)			// Select Savings 01 account
			[+] if(AccountDetails.Exists(5))
				[ ] ReportStatus("Validate Delete Account button", PASS, "Delete Account button is displayed")
				[ ] AccountDetails.DeleteAccountButton.Click()
				[ ] 
				[+] if(DeleteAccount.Exists(5))
					[ ] DeleteAccount.YesField.SetText("Yes")
					[ ] DeleteAccount.OK.Click()
					[ ] ReportStatus("Delete Account", PASS, "Savings 01 Account is deleted")
				[+] else
					[ ] ReportStatus("Delete Account", FAIL, "Savings 01 Account is NOT present")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] //Navigate to Stack view
			[ ] MDIClient.Bills.ViewAsPopupList.Select(1)
			[ ] MDIClient.Bills.IncludePaid.Check()
			[ ] // MDIClient.Bills.Panel.Panel1.QWinChild.Typekeys(KEY_TAB)
			[ ] // MDIClient.Bills.Panel.Panel1.QWinChild.Typekeys(KEY_ENTER)
			[ ] MDIClient.Bills.Panel.Panel1.QWinChild1.EnterButton.Click()
			[ ] 
			[+] if(EnterExpenseIncomeTxn.Exists(5))
				[ ] EnterExpenseIncomeTxn.EnterTransactionButton.Click()
				[ ] 
				[ ] lsTransaction=GetTransactionsInRegister(sPayeeName)
				[ ] // print(lsTransaction)
				[ ] bResult = MatchStr("*{sVerifyCategory}*",lsTransaction[1])
				[+] if(bResult == FALSE)
					[ ] ReportStatus("Verify category in checking register ", PASS, "As 'To Account' is deleted, transfer reminder is entered as without any category")
				[+] else
					[ ] ReportStatus("Verify category in checking register ", FAIL, "Even if  'To Account' is deleted, transfer reminder is entered with category {sVerifyCategory}")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Enter expense Transaction ", FAIL, "Enter Expense Transaction dialog is NOT present")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Manual Saving Account ", FAIL, "Manual saving account is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window", FAIL, "Quicken Main window is missing.")
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC92_SkipButtonFunctionality()##########################
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC92_SkipButtonFunctionality()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This test case will verify-skip reminder confirmation dialog UI and functionality
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Skip button is correct
		[ ] //        Fail		                           If functionality of Skip button is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 07, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC92_SkipButtonFunctionality() appstate QuickenBaseState 
	[ ] 
	[ ] STRING sAmount="500.00",sAmountCompare,sReminder
	[ ] list of AnyType  lsReminderList
	[ ] STRING sPayee="SkipButtonPayee"
	[ ] STRING sDateFormat = "m/d/yyyy"
	[ ] STRING sDateStamp = FormatDateTime (GetDateTime(), sDateFormat) 
	[ ] STRING sDateStampNext = ModifyDate(1,sDateFormat)
	[ ] sReminder="Bill"
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
	[ ] iValidate=NavigateReminderDetailsPage(sReminder,sPayee)
	[ ] 
	[+] if(iValidate==PASS)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
		[ ] DlgAddEditReminder.DoneButton.Click()
		[ ] 
		[ ] iValidate=NavigateReminderDetailsPage(sReminder,sPayee)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStampNext)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Income Reminder dialog", FAIL , "Add Income Reminder dialog is not present")
	[+] else
		[ ] ReportStatus("Verify Add Income Reminder dialog", FAIL , "Add Income Reminder dialog is not present")
		[ ] 
	[+] if(MDIClient.Bills.Exists(5))
		[ ] MDIClient.Bills.ViewAsPopupList.Select("#1")
		[ ] 
		[ ] MDIClient.Bills.AccountPopupList.Select("#1")
		[ ] 
		[ ] MDIClient.Bills.IncludePaid.Uncheck()
		[ ] 
		[ ] MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Click()
		[ ] 
		[+] if(SkipThisReminder.Exists(3))
			[ ] SkipThisReminder.SkipConfirmButton.Click()
		[ ] 
		[ ] 
		[+] if(MDIClient.Bills.Exists(5))
			[ ] 
			[ ] MDIClient.Bills.ViewAsPopupList.Select("#1")
			[ ] MDIClient.Bills.ViewAsPopupList.TypeKeys(KEY_ENTER)
		[ ] 
		[ ] MDIClient.Bills.ViewAsPopupList.Select("#2")
		[ ] //Bills.ViewAsPopupList.TypeKeys(KEY_ENTER)
		[ ] 
		[ ] sHandle = Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
		[ ] bMatch = MatchStr("*{sDateStamp}*",sActual)
		[ ] 
		[+] if(bMatch == FALSE)
			[ ] ReportStatus("Verify Reminder in List view", PASS, "{sDateStamp}  is not available in Reminder in List view")
			[ ] 
			[ ] bMatch = MatchStr("*{sPayee}*",sActual)
			[ ] 
			[+] if(bMatch== TRUE)
				[ ] ReportStatus("Verify Reminder in List view", PASS, "{sPayee}  is not available in Reminder in List view")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Reminder in List view", FAIL, "{sPayee}  is available in Reminder in List view")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Validate Reminder in List view", FAIL, "{sDateStamp}  is available in Reminder in List view")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Bills dialog", PASS , "Bills dialog is not present")
		[ ] 
		[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC93_EnterButtonFunctionality()##########################
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC93_EnterButtonFunctionality()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This test case will verify-Enter reminder confirmation dialog UI and functionality
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Enter button is correct
		[ ] //        Fail		   If functionality of Enter button is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 08, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC93_EnterButtonFunctionality() appstate QuickenBaseState 
	[ ] STRING sAmount="500.00"
	[ ] STRING sDateStamp = ModifyDate(0,"m/d/yyyy")
	[ ] STRING sReminder = "Bill"
	[ ] STRING sPayee="EnterButtonPayee"
	[ ] 
	[ ] List of STRING lsActual
	[ ] 
	[ ] INTEGER iOpenAccountRegister 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
	[ ] iValidate=NavigateReminderDetailsPage(sReminder,sPayee)
	[ ] 
	[+] if(iValidate==PASS)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDateStamp)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
		[ ] DlgAddEditReminder.DoneButton.Click()
		[ ] sleep(2)
		[ ] 
		[+] if(MDIClient.Bills.Exists(5))
			[ ] 
			[ ] MDIClient.Bills.ViewAsPopupList.Select("#1")
			[ ] 
			[ ] MDIClient.Bills.AccountPopupList.Select("#1")
			[ ] 
			[ ] sleep(1)
			[ ] 
			[ ] MDIClient.Bills.Panel.Panel1.QWinChild1.EnterButton.Click()
			[ ] 
			[+] if(EnterExpenseIncomeTxn.Exists(10))
				[ ] EnterExpenseIncomeTxn.SetActive()
				[ ] EnterExpenseIncomeTxn.EnterTransactionButton.Click()
				[ ] WaitForState( EnterExpenseIncomeTxn ,FALSE ,5)
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive()
				[ ] lsActual=GetTransactionsInRegister(sPayee)
				[ ] print(lsActual)
				[ ] 
				[+] if (ListCount(lsActual)>0)
					[ ] bMatch = MatchStr("*{sDateStamp}*{sPayee}*",lsActual[1])
					[ ] 
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Verify reminder gets entered into the register", PASS, "Reminder with payee: {sPayee} and date: {sDateStamp} has been entered into the register")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify reminder gets entered into the register", FAIL, "Reminder with payee: {sPayee} and date: {sDateStamp} couldn't be entered into the register, actual transactions is/are: {lsActual}.")
						[ ] 
				[+] else
					[ ] ReportStatus("Search transactions using Find & Replace dialog.", FAIL, "No transactions found in Find & Replace dialog while searching for payee: {sPayee}.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Enter Expense Income Transaction dialog." ,FAIL , "Enter Expense Income Transaction dialog didn't appear.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Bills dialog", PASS , "Bills dialog is not present")
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Add Income Reminder dialog", FAIL, "Add Income Reminder dialog is not present")
		[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC94_InvoiceReminderFirstScreen()##########################
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC94_InvoiceReminderFirstScreen()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] 
		[ ] // This test case will verify-Enter reminder confirmation dialog UI and functionality
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Enter button is correct
		[ ] //        Fail		   If functionality of Enter button is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 11, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC94_InvoiceReminderFirstScreen() appstate QuickenBaseState 
	[ ] 
	[ ] List of STRING lsAccountName = {"Vendor Invoices","Customer Invoices"}
	[ ] i=4
	[ ] //Create Data File
	[ ] iValidate = DataFileCreate(sFileName)
	[ ] //Report Staus If Data file Created successfully
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Validate Data File ", iValidate, "Data file -  {sDataFile} is created")
		[ ] 
		[ ] 
		[ ] //Creating Bussiness Accounts
		[ ] iValidate=AddBusinessAccount(lsBusAccType[1],lsAccountName[1])
		[ ] 
		[+] if (iValidate==PASS)
			[ ] ReportStatus("Checking Account", iValidate, "Checking Account -  {lsAccountName[1]}  is created successfully")
			[ ] iValidate=AddBusinessAccount(lsBusAccType[2],lsAccountName[2])
			[+] if (iValidate==PASS)
				[ ] ReportStatus("Checking Account", iValidate, "Checking Account -  {lsAccountName[2]}  is created successfully")
			[+] else
				[ ] ReportStatus("Checking Account", iValidate, "Checking Account -  {lsAccountName[2]}  is not created")
			[ ] 
		[+] else
			[ ] ReportStatus("Checking Account", iValidate, "Checking Account -  {lsAccountName[1]}  is not created")
			[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_BILL)
		[ ] //Navigation
		[+] if(QuickenMainWindow.QWNavigator.AddReminder.Exists(5))
			[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
			[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(Replicate(KEY_DN, i)) 
			[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] //Verifying whether "Add Invoice Reminder" dialog exist with proper Caption.
			[+] if(DlgAddEditReminder.Exists(5))
				[ ] ReportStatus("Verify Add Invoice Reminder dialog exists", PASS , "Add Invoice Reminder Dialog is present")
				[ ] sCaption=DlgAddEditReminder.GetProperty("Caption")
				[+] if(sCaption=="Add Invoice Reminder")
					[ ] ReportStatus("Verify 'Add Invoice Reminder' Caption on dialog", PASS , "'Add Invoice Reminder' Caption is present on Add Invoice Reminder Dialog  ")
				[ ] 
				[ ] //verify UI controls on Add Invoice Reminder Dialog First Screen
				[ ] //Verifying Pay to TextField  is available on Add Invoice Reminder Dialog
				[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.Exists(5))
					[ ] ReportStatus("Verify Vendor/Customer TextField on Add Invoice Reminder Dialog", PASS , "Vendor/Customer TextField is present on Add Invoice Reminder Dialog")
				[+] else
					[ ] ReportStatus("Verify Vendor/Customer TextField on Add Invoice Reminder Dialog", FAIL , "Vendor/Customer TextField is not present on Add Invoice Reminder Dialog")
					[ ] 
				[ ] //Verifying Cancel Button is available on Add Invoice Reminder Dialog
				[+] if(DlgAddEditReminder.CancelButton.Exists(5))
					[ ] ReportStatus("Verify Cancel Button on Add Invoice Reminder Dialog", PASS , "Cancel button is present on Add Invoice Reminder Dialog")
				[+] else
					[ ] ReportStatus("Verify Cancel Button on Add Invoice Reminder Dialog", FAIL , "Cancel button is not present on Add Invoice Reminder Dialog")
				[ ] 
				[ ] //Verifying Next Button is available on Add Invoice Reminder Dialog
				[+] if(DlgAddEditReminder.NextButton.Exists(5))
					[ ] ReportStatus("Verify Next Button on Add Invoice Reminder Dialog", PASS , "Next button is present on Add Invoice Reminder Dialog")
				[+] else
					[ ] ReportStatus("Verify Next Buttonon Add Invoice Reminder Dialog", FAIL , "Next button is not present on Add Invoice Reminder Dialog")
				[ ] 
				[ ] //Verifying Help Button is available on Add Invoice Reminder Dialog
				[+] if(DlgAddEditReminder.HelpButton.Exists(5))
					[ ] ReportStatus("Verify Help Button on Add Invoice Reminder Dialog", PASS , "Help button is present on Add Invoice Reminder Dialog")
				[+] else
					[ ] ReportStatus("Verify Help Button on Add Invoice Reminder Dialog", FAIL , "Help button is not present on Add Invoice Reminder Dialog")
				[ ] 
				[ ] DlgAddEditReminder.Close()
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify 'Add Invoice Reminder' Caption on dialog", FAIL , "'Add Invoice Reminder' Caption is not present on Add Invoice Reminder Dialog  ")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Invoice Reminder dialog exists", FAIL , "Add Invoice Reminder Dialog is not present")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Data File ", FAIL, "Error during data file creation")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC95_InvoiceReminderSecondScreen() ##############################
	[ ] // **************************************************************************************
	[+] // testcase Name:	 TC95_InvoiceReminderSecondScreen()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify UI controls Present on Add Invoice Reminder second screen
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If UI controls are present on the Add Reminder Dialog
		[ ] //				        Fail		   If any of the UI control is not present
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 08, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC95_InvoiceReminderSecondScreen() appstate QuickenBaseState
	[+] // Variable declaration and definition
		[ ] sReminderType="Invoice"
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] //Navigation to Bills > Add Invoice > Enter payee > Click Next
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[ ] 
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //verifying whether all UI controls are present on Add Invoice Reminder on Second Screen
				[ ] 
				[+] //Verifying whether Type PopList is available on Add Invoice Reminder Dialog
					[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
						[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
					[+] else
						[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
				[ ] 
				[+] //Verifying whether Due Next On is available on Add Invoice Reminder Dialog
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.Exists(5))
						[ ] ReportStatus("Verify whether 'Due Next On TextField' on Add Invoice Reminder Dialog ", PASS , "Due Next On TextField is present on Add Invoice Reminder Dialog")
					[+] else
						[ ] ReportStatus("Verify 'Due Next On TextField' on Add Invoice Reminder Dialog", FAIL , "Due Next On TextField is not present on Add Invoice Reminder Dialog")
				[ ] 
				[+] //Verifying whether Due Date Change link is available on Add Invoice Reminder Dialog
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Exists(5))
						[ ] ReportStatus("Verify Due Date Change link on Add Invoice Reminder Dialog", PASS , "Change link is present on Add Invoice Reminder Dialog")
					[+] else
						[ ] ReportStatus("Verify Due Date Change link on Add Invoice Reminder Dialog", FAIL , "Change link is not present on Add Invoice Reminder Dialog")
				[ ] 
				[+] //Verifying whether Invoice Account TextField is available on Add Invoice Reminder Dialog
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.InvoiceAccount.Exists(5))
						[ ] ReportStatus("Verify Invoice Account TextField on Add Invoice Reminder Dialog", PASS , "Invoice Account TextField is present on Add Invoice Reminder Dialog")
					[+] else
						[ ] ReportStatus("Verify Invoice Account TextField  on Add Invoice Reminder Dialog", FAIL , "Invoice Account TextField is not present on Add Invoice Reminder Dialog")
				[ ] 
				[+] //Verifying whether To Customer TextField is available on Add Invoice Reminder Dialog
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.ToCustomer.Exists(5))
						[ ] ReportStatus("Verify To Customer TextField on Add Invoice Reminder Dialog", PASS , "To Customer TextField is present on Add Invoice Reminder Dialog")
					[+] else
						[ ] ReportStatus("Verify To Customer TextField on Add Invoice Reminder Dialog", FAIL , "To Customer TextField is not present on Add Invoice Reminder Dialog")
					[ ] 
				[ ] 
				[+] //Verifying whether From Details Text is available on Add Invoice Reminder Dialog
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.DetailsText.Exists(5))
						[ ] ReportStatus("Verify Details Text on Add Invoice Reminder Dialog", PASS , "Details  Text is present on Add Invoice Reminder Dialog")
					[+] else
						[ ] ReportStatus("Verify Details Text on Add Invoice Reminder Dialog", FAIL , "Details Text is not present on Add Invoice Reminder Dialog")
				[ ] 
				[+] //Verifying whether Add Invoice Details is available on Add Invoice Reminder Dialog
					[ ] DlgAddEditReminder.SetActive()
					[ ] DlgAddEditReminder.TextClick("Add invoice details")
					[+] if(DlgInvoice.Exists(3))
						[ ] DlgInvoice.SetActive()
						[ ] DlgInvoice.Close()
						[+] if(AlertMessage.Exists(3))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.Yes.Click()
						[ ] ReportStatus("Verify Add Invoice Details Panel on Add Invoice Reminder Dialog", PASS , "Add Invoice Details Panel  is present on Add Invoice Reminder Dialog")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Add Invoice Details Panel on Add Invoice Reminder Dialog", FAIL , "Add Invoice Details Panel  is not present on Add Invoice Reminder Dialog")
						[ ] 
				[ ] 
				[ ] // 
				[+] // // //Verifying whether Optional Settings Panel is available on Add Invoice Reminder Dialog
					[+] // // if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel2.Exists(5))
						[ ] // // ReportStatus("Verify OptionalSettings on Add Invoice Reminder Dialog", PASS , "OptionalSettings is present on Add Invoice Reminder Dialog")
					[+] // // else
						[ ] // // ReportStatus("Verify OptionalSettings on Add Invoice Reminder Dialog", FAIL , "OptionalSettings is not present on Add Invoice Reminder Dialog")
				[ ] // 
				[ ] 
				[+] //Verifying whether Back Button is available on Add Invoice Reminder Dialog
					[+] if(DlgAddEditReminder.BackButton.Exists(5))
						[ ] ReportStatus("Verify Back Button on Add Invoice Reminder Dialog", PASS , "Back Button is present on Add Invoice Reminder Dialog")
					[+] else
						[ ] ReportStatus("Verify Back Button on Add Invoice Reminder Dialog", FAIL , "Back Button is not present on Add Invoice Reminder Dialog")
						[ ] 
				[ ] 
				[+] //Verifying whether Done Button is available on Add Invoice Reminder Dialog
					[+] if(DlgAddEditReminder.DoneButton.Exists(5))
						[ ] ReportStatus("Verify Done Button on Add Invoice Reminder Dialog", PASS , "Done Button is present on Add Invoice Reminder Dialog")
					[+] else
						[ ] ReportStatus("Verify Done Button on Add Invoice Reminder Dialog", FAIL , "Done Button is not present on Add Invoice Reminder Dialog")
				[ ] 
				[+] //Verifying whether Cancel Button is available on Add Invoice Reminder Dialog
					[+] if(DlgAddEditReminder.CancelButton.Exists(5))
						[ ] ReportStatus("Verify Cancel Button on Add Invoice Reminder Dialog", PASS , "Cancel Button is present on Add Invoice Reminder Dialog")
					[+] else
						[ ] ReportStatus("Verify Cancel Button on Add Invoice Reminder Dialog", FAIL , "Cancel Button is not present on Add Invoice Reminder Dialog")
					[ ] 
				[ ] 
				[+] //Verifying whether Help Button is available on Add Invoice Reminder Dialog
					[+] if(DlgAddEditReminder.HelpButton.Exists(5))
						[ ] ReportStatus("Verify Help Button on Add Invoice Reminder Dialog", PASS , "Help Button is present on Add Invoice Reminder Dialog")
					[+] else
						[ ] ReportStatus("Verify Help Button on Add Invoice Reminder Dialog", FAIL , "Help Button is not present on Add Invoice Reminder Dialog")
					[ ] 
				[ ] 
			[+] else 
				[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
				[ ] 
			[ ] DlgAddEditReminder.Close()
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC96_InvoiceTypeDropdown() ##############################
	[ ] // **************************************************************************************
	[+] // testcase Name:	 TC96_InvoiceTypeDropdown()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify options present in Type dropdown for Invoice Reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If no error occurs
		[ ] //				        Fail		   If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 March 12, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC96_InvoiceTypeDropdown() appstate QuickenBaseState
	[+] // Variable declaration and definition
		[ ] list of STRING lsType = {"Invoice to Customer","Payment from Customer","Invoice from Vendor","Payment to Vendor"}
		[ ] sReminderType="Invoice"
		[ ] list of STRING lsCompare
	[ ] 
	[+] if(QuickenWindow.Exists(10))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] //Navigation to Bills > Add Invoice > Enter payee > Click Next
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[ ] 
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //verifying whether all UI controls are present on Add Invoice Reminder on Second Screen
				[ ] 
				[+] //Verifying whether Type PopList is available on Add Invoice Reminder Dialog
					[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
						[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
						[ ] 
						[ ] //Verifying whether Type PopList have the required contents
						[ ] lsCompare = DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.GetContents()
						[ ] 
						[+] for(i=1;i<=listCount(lsCompare);i++)
							[+] if(lsType[i]==lsCompare[i])
								[ ] ReportStatus("Verify the Contents of Type PopList",PASS,"As {lsType[i]} is same")
							[+] else
								[ ] ReportStatus("Verify the Contents of Type PopList",FAIL,"As {lsType[i]}, {lsCompare[i]} is not same")
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
				[ ] 
			[+] else 
				[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
				[ ] 
			[ ] DlgAddEditReminder.Close()
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC97_InvoiceTypeSelection() ##############################
	[ ] // **************************************************************************************
	[+] // testcase Name:	 TC97_InvoiceTypeSelection()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will  Verify that accounts should be populated according to "Type" selected
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If no error occurs
		[ ] //				        Fail		   If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 March 13, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC97_InvoiceTypeSelection() appstate QuickenBaseState
	[+] // Variable declaration and definition
		[ ] list of STRING lsAccountType = {"Customer Invoices","Vendor Invoices"}
		[ ] 
		[ ] sReminderType="Invoice"
		[ ] STRING sCompare
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigation to Bills > Add Invoice > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[ ] //verifying whether all UI controls are present on Add Invoice Reminder on Second Screen
			[ ] 
			[+] //Verifying whether Type PopList is available on Add Invoice Reminder Dialog
				[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
					[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
					[ ] 
					[ ] // Selected Invoice Type as "Invoice to Customer"
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#1")
					[ ] 
					[ ] sCompare = DlgAddEditReminder.Step2Panel.QWinChild1.InvoiceAccount.GetText()
					[ ] 
					[+] if(lsAccountType[1]==sCompare)
						[ ] ReportStatus("Verify whether Account Type is According to Invoice Type  ", PASS , "Account Type '{lsAccountType[1]}' is according to Invoice Type 'Invoice to Customer'")
					[+] else
						[ ] ReportStatus("Verify whether Account Type is According to Invoice Type  ", FAIL , "Account Type '{lsAccountType[1]}' is not according to Invoice Type 'Invoice to Customer'")
						[ ] 
					[ ] // Selected Invoice Type as "Payment from Customer"
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#2")
					[ ] 
					[ ] sCompare = DlgAddEditReminder.Step2Panel.QWinChild1.InvoiceAccount.GetText()
					[ ] 
					[+] if(lsAccountType[1]==sCompare)
						[ ] ReportStatus("Verify whether Account Type is According to Invoice Type  ", PASS , "Account Type '{lsAccountType[1]}' is according to Invoice Type 'Payment from Customer")
					[+] else
						[ ] ReportStatus("Verify whether Account Type is According to Invoice Type  ", FAIL , "Account Type '{lsAccountType[1]}' is not according to Invoice Type 'Payment from Customer'")
					[ ] 
					[ ] // Selected Invoice Type as "Invoice from Vendor"
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#3")
					[ ] 
					[ ] sCompare = DlgAddEditReminder.Step2Panel.QWinChild1.InvoiceAccount.GetText()
					[ ] 
					[+] if(lsAccountType[2]==sCompare)
						[ ] ReportStatus("Verify whether Account Type is According to Invoice Type  ", PASS , "Account Type '{lsAccountType[2]}' is according to Invoice Type 'Invoice from Vendor")
					[+] else
						[ ] ReportStatus("Verify whether Account Type is According to Invoice Type  ", FAIL , "Account Type '{lsAccountType[2]}' is not according to Invoice Type 'Invoice from Vendor'")
					[ ] 
					[ ] // Selected Invoice Type as "Payment to Vendor"
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#4")
					[ ] 
					[ ] sCompare = DlgAddEditReminder.Step2Panel.QWinChild1.InvoiceAccount.GetText()
					[ ] 
					[+] if(lsAccountType[2]==sCompare)
						[ ] ReportStatus("Verify whether Account Type is According to Invoice Type  ", PASS , "Account Type '{lsAccountType[2]}' is according to Invoice Type 'Payment to Vendor")
					[+] else
						[ ] ReportStatus("Verify whether Account Type is According to Invoice Type  ", FAIL , "Account Type '{lsAccountType[2]}' is not according to Invoice Type 'Payment to Vendor")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
			[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
			[ ] 
		[ ] DlgAddEditReminder.Close()
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC98_InvoiceTypeSelectionAPandAR() ##############################
	[ ] // **************************************************************************************
	[+] // testcase Name:	 TC98_InvoiceTypeSelectionAPandAR()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will  Verify that Type columns should contain choices according to A/P and A/R added.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If no error occurs
		[ ] //				        Fail		   If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 March 13, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC98_InvoiceTypeSelectionAPandAR() appstate QuickenBaseState
	[+] // Variable declaration and definition
		[ ] list of STRING lsAccountType = {"Customer Invoices","Vendor Invoices"}
		[ ] List of STRING lsAccountName = {"Vendor Invoices","Customer Invoices"}
		[ ] list of STRING lsType = {"Invoice to Customer","Payment from Customer","Invoice from Vendor","Payment to Vendor"}
		[ ] // list of STRING lsCustomerType = {"Invoice to Customer","Payment from Customer"}
		[ ] // list of STRING lsVendorType = {"Invoice from Vendor","Payment to Vendor"}
		[ ] integer iOpenAccountRegister
		[ ] STRING sAction = "Delete"
		[ ] ANYTYPE sWindow="MDI"
		[ ] STRING sAccountBType = "Business"
		[ ] sReminderType="Invoice"
		[ ] list of STRING  lsCompare
	[ ] 
	[ ] //Creating a Data file
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Create Data File
		[ ] iValidate = DataFileCreate(sFileName)
		[ ] //Report Staus If Data file Created successfully
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Validate Data File ", iValidate, "Data file -  {sDataFile} is created")
			[ ] 
			[ ] 
			[ ] iValidate=AddManualSpendingAccount(IsAddAccount[1],IsAddAccount[2],IsAddAccount[3],IsAddAccount[4])
			[ ] 
			[ ] //Creating Business Accounts-Vendor Invoices
			[ ] iValidate=AddBusinessAccount(lsBusAccType[1],lsAccountName[1])
			[ ] 
			[+] if (iValidate==PASS)
				[ ] ReportStatus("Checking Account", iValidate, "Checking Account -  {lsAccountName[1]}  is created successfully")
				[ ] 
				[ ] //Navigating Bills> Add Reminder > Invoice Reminder > Payee name > Next
				[ ] NavigateQuickenTab(sTAB_BILL)
				[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
				[ ] 
				[+] if(iValidate==PASS)
					[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
							[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
							[ ] 
							[ ] //Verifying whether Type PopList have the required contents
							[ ] lsCompare = DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.GetContents()
							[ ] 
							[ ] 
							[+] for(i=1,j=3;i<=listCount(lsCompare);i++,j++)
								[+] if(lsType[j]==lsCompare[i])
										[ ] ReportStatus("Verify the Contents of Type PopList",PASS,"As {lsType[j]} is according to {lsAccountName[1]} ")
								[+] else
									[ ] ReportStatus("Verify the Contents of Type PopList",FAIL,"As {lsType[j]}, {lsCompare[i]} is not according to {lsAccountName[1]}")
					[+] else
						[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
					[ ] 
					[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
			[+] else
				[ ] ReportStatus("Checking Account", iValidate, "Checking Account -  {lsAccountName[1]}  is not created")
				[ ] 
			[ ] 
			[ ] iOpenAccountRegister=AccountBarSelect(sAccountBType,2)
			[ ] 
			[ ] iValidate=ModifyAccount(sWindow, lsAccountName[2], sAction )
			[ ] 
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verify Deletion of Vendor Invoices Account  ", PASS , "Vendor  Invoices Account is Deleted")
			[+] else
				[ ] ReportStatus("Verify Deletion of Vendor Invoices Account  ", PASS , "Vendor  Invoices Account is not Deleted")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] //Creating Business Accounts-Customer Invoices
			[ ] iValidate=AddBusinessAccount(lsBusAccType[2],lsAccountName[2])
			[ ] 
			[+] if (iValidate==PASS)
				[ ] ReportStatus("Checking Account", iValidate, "Checking Account -  {lsAccountName[2]}  is created successfully")
				[ ] 
				[ ] //Navigating Bills> Add Reminder > Invoice Reminder > Payee name > Next
				[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
				[ ] 
				[+] if(iValidate==PASS)
					[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
							[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
							[ ] 
							[ ] //Verifying whether Type PopList have the required contents
							[ ] lsCompare = DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.GetContents()
							[ ] 
							[ ] 
							[+] for(i=1;i<=listCount(lsCompare);i++)
								[+] if(lsType[i]==lsCompare[i])
									[ ] ReportStatus("Verify the Contents of Type PopList",PASS,"As {lsType[i]} is according to {lsAccountName[2]}")
								[+] else
									[ ] ReportStatus("Verify the Contents of Type PopList",FAIL,"As {lsType[i]}, {lsCompare[i]} is not is according to {lsAccountName[2]}")
					[+] else
						[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
						[ ] 
					[ ] 
					[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
				[ ] 
			[+] else
				[ ] ReportStatus("Checking Account", iValidate, "Checking Account -  {lsAccountName[2]}  is not created")
				[ ] 
			[ ] //Creating Business Accounts-Vendor Invoices
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] iValidate=AddBusinessAccount(lsBusAccType[1],lsAccountName[1])
			[ ] 
			[+] if (iValidate==PASS)
				[ ] ReportStatus("Checking Account", iValidate, "Checking Account -  {lsAccountName[1]}  is created successfully")
				[ ] 
				[ ] 
				[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
				[ ] 
				[+] if(iValidate==PASS)
					[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
						[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
						[ ] 
						[ ] //Verifying whether Type PopList have the required contents
						[ ] lsCompare = DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.GetContents()
						[ ] 
						[+] for(i=1;i<=listCount(lsCompare);i++)
							[+] if(lsType[i]==lsCompare[i])
								[ ] ReportStatus("Verify the Contents of Type PopList",PASS,"As {lsType[i]} is same")
							[+] else
								[ ] ReportStatus("Verify the Contents of Type PopList",FAIL,"As {lsType[i]}, {lsCompare[i]} is not same")
						[ ] 
						[ ] 
						[ ] DlgAddEditReminder.Close()
					[+] else
						[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
				[ ] 
				[ ] 
				[+] else
					[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
			[+] else
				[ ] ReportStatus("Checking Account", iValidate, "Checking Account -  {lsAccountName[1]}  is not created")
				[ ] 
			[ ] 
			[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Validate Data File ", iValidate, "Error during data file creation")
	[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC99_FunctionalityInvoicePanelCustomerInvoiceNoData() ###############
	[ ] // **************************************************************************************
	[+] // testcase Name:	 TC99_FunctionalityInvoicePanelCustomerInvoiceNoData()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This test case will  Verify that -Functionality of invoice panel: data not entered for customer invoice
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	   If no error occurs
		[ ] // Fail		   If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // March 14, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC99_FunctionalityInvoicePanelCustomerInvoiceNoData() appstate QuickenBaseState
	[+] //Variable declaration and definition
		[ ] list of STRING lsAccountType = {"Customer Invoices","Vendor Invoices"}
		[ ] List of STRING lsAccountName = {"Vendor Invoices","Customer Invoices"}
		[ ] list of STRING lsLayout ={"Invoice Default", "<Customize>"}
		[ ] list of STRING lsTaxAccount ={"*Sales Tax*","<New>","<Edit>"}
		[ ] 
		[ ] integer iOpenAccountRegister,iValidate
		[ ] STRING sAction = "Delete"
		[ ] ANYTYPE sWindow="MDI"
		[ ] STRING sAccountBType = "Business"
		[ ] 
		[ ] sReminderType="Invoice"
		[ ] list of STRING  lsCompare
	[ ] 
	[ ] //Opening a Data file
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigating Bills> Add Reminder > Invoice Reminder > Payee name > Next
		[ ] NavigateQuickenTab(sTAB_BILL)
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] //This UI controls verification is for Invoice to Customer - Customer Invoices
			[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
					[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
					[ ] 
					[ ] //Select first type "Invoice to Customer" from dropdown
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#1")
					[ ] //Click on Add Invoice Details Panel
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Exists(5))
						[ ] ReportStatus("Verify whether 'Add Invoice Details' on Add Invoice Reminder Dialog ", PASS , "'Add Invoice Details' is present on Add Invoice Reminder Dialog")
						[ ] 
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Click()
						[ ] 
						[ ] 
						[+] //Verifying UI controls for the Add Customer Invoice Details on Add Invoice Reminder
							[ ] 
							[+] //Verify the Customer Text Field present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.CustomerTextField.Exists(5))
									[ ] ReportStatus("Verify Customer Text Field on Add Customer Invoice Details dialog ", PASS , " Customer Text Field is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify Customer Text Field on Add Customer Invoice Details dialog", FAIL , "Customer Text Field is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the  Project Job Text Field present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.ProjectJobTextField.Exists(5))
									[ ] ReportStatus("Verify  Project Job Text Field on Add Customer Invoice Details dialog ", PASS , "  Project Job Text Field is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify  Project Job Text Field on Add Customer Invoice Details dialog", FAIL , " Project Job Text Field is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the  Project Layout Popup List present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.LayoutPopupList.Exists(5))
									[ ] ReportStatus("Verify  Layout Popup List on Add Customer Invoice Details dialog ", PASS , "  Layout Popup List is present on Add Customer Invoice Details dialog")
									[ ] 
									[ ] lsCompare=DlgInvoice. LayoutPopupList.GetContents()
									[ ] 
									[+] for(i=1;i<=ListCount(lsCompare);i++)
										[+] if(lsLayout[i]==lsCompare[i])
											[ ] ReportStatus("Verify the Contents of How often List",PASS,"As {lsLayout[i]} is present in Layout Popup List")
										[+] else
											[ ] ReportStatus("Verify the Contents of How often List",FAIL,"As {lsLayout[i]}, {lsCompare[i]} is not present in Layout Popup List")
								[+] else
									[ ] ReportStatus("Verify  Layout Popup List on Add Customer Invoice Details dialog", FAIL , " Layout Popup List is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the  Business Tag TextField present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.BusinessTagTextField.Exists(5))
									[ ] ReportStatus("Verify  Business Tag TextField on Add Customer Invoice Details dialog ", PASS , "  Business Tag TextField is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify  Business Tag TextField on Add Customer Invoice Details dialog", FAIL , " Business Tag TextField is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the DATE TextField present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.DATETextField.Exists(5))
									[ ] ReportStatus("Verify  DATE Text Field on Add Customer Invoice Details dialog ", PASS , " DATE Text Field is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify  DATE Text Field on Add Customer Invoice Details dialog", FAIL , " DATE Text Field is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the INVOICE TextField present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.INVOICETextField.Exists(5))
									[ ] ReportStatus("Verify INVOICE TextField on Add Customer Invoice Details dialog ", PASS , " INVOICE TextField is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify INVOICE TextField on Add Customer Invoice Details dialog", FAIL , " INVOICE TextField is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the DUEDATE TextField present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.DUEDATETextField.Exists(5))
									[ ] ReportStatus("Verify DUEDATE TextField on Add Customer Invoice Details dialog ", PASS , "DUEDATE TextField is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify DUEDATE TextField on Add Customer Invoice Details dialog", FAIL , "DUEDATE TextField is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the PONUMBER TextField present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.PONUMBERTextField.Exists(5))
									[ ] ReportStatus("Verify PONUMBER TextField on Add Customer Invoice Details dialog ", PASS , "PONUMBER TextField is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify PONUMBER TextField on Add Customer Invoice Details dialog", FAIL , "PONUMBER TextField is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] // //Verify the Item List present on Add Customer Invoice Details dialog
								[+] // if(DlgInvoice.QWListViewerItem.ListBox.Exists(5))
									[ ] // ReportStatus("Verify Item List on Add Customer Invoice Details dialog ", PASS , "Item List is present on Add Customer Invoice Details dialog")
								[+] // else
									[ ] // ReportStatus("Verify Item List on Add Customer Invoice Details dialog", FAIL , "Item List is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the Add Lines Button present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.AddLinesButton.Exists(5))
									[ ] ReportStatus("Verify Add Lines Button on Add Customer Invoice Details dialog ", PASS , "Add Lines Button is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify Add Lines Button on Add Customer Invoice Details dialog", FAIL , "Add Lines Button is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the Tax TextField present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.TaxTextField.Exists(5))
									[ ] ReportStatus("Verify Tax TextField on Add Customer Invoice Details dialog ", PASS , "Tax TextField is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify Tax TextField on Add Customer Invoice Details dialog", FAIL , "Tax TextField is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the Customer Message TextField present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.CustomerMessageTextField.Exists(5))
									[ ] ReportStatus("Verify Customer Message TextField  on Add Customer Invoice Details dialog ", PASS , "Customer Message TextField  is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify Customer Message TextField  on Add Customer Invoice Details dialog", FAIL , "Customer Message TextField  is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the Memo TextField present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.MemoTextField.Exists(5))
									[ ] ReportStatus("Verify Memo TextField on Add Customer Invoice Details dialog ", PASS , "Memo TextField is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify Memo TextField on Add Customer Invoice Details dialog", FAIL , "Memo TextField is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the Tax Account PopupList present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.TaxAccountPopupList.Exists(5))
									[ ] ReportStatus("Verify Tax Account PopupList on Add Customer Invoice Details dialog ", PASS , "Tax Account PopupList is present on Add Customer Invoice Details dialog")
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
									[ ] ReportStatus("Verify Tax Account PopupList on Add Customer Invoice Details dialog", FAIL , "Tax Account PopupList is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the Receive Payment Button present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.ReceivePaymentButton.Exists(5))
									[ ] ReportStatus("Verify Receive Payment Button on Add Customer Invoice Details dialog ", PASS , "Receive Payment Button is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify Receive Payment Button on Add Customer Invoice Details dialog", FAIL , "Receive Payment Button is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the Payment History Button present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.PaymentHistoryButton.Exists(5))
									[ ] ReportStatus("Verify Payment History Button on Add Customer Invoice Details dialog ", PASS , "Payment History Button is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify Payment History Button on Add Customer Invoice Details dialog", FAIL , "Payment History Button is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the Expenses Button present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.ExpensesButton.Exists(5))
									[ ] ReportStatus("Verify Expenses Button on Add Customer Invoice Details dialog ", PASS , "Expenses Button is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify Expenses Button on Add Customer Invoice Details dialog", FAIL , "Expenses Button is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the EMail Send To Clipboard Button present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.EMailSendToClipboardButton.Exists(5))
									[ ] ReportStatus("Verify EMail Send To Clipboard Button on Add Customer Invoice Details dialog ", PASS , "EMail Send To Clipboard Button is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify EMail Send To Clipboard Button on Add Customer Invoice Details dialog", FAIL , "EMail Send To Clipboard Button is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the Save And New Button present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.SaveAndNewButton.Exists(5))
									[ ] ReportStatus("Verify Save And New Button on Add Customer Invoice Details dialog ", PASS , "Save And New Button is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify Save And New Button on Add Customer Invoice Details dialog", FAIL , "Save And New Button is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the Save And Done Button present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.SaveAndDoneButton.Exists(5))
									[ ] ReportStatus("Verify Save And Done Button on Add Customer Invoice Details dialog ", PASS , "Save And Done Button is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify Save And Done Button on Add Customer Invoice Details dialog", FAIL , "Save And Done Button is not present on Add Customer Invoice Details dialog")
							[ ] 
							[+] //Verify the Cancel Button present on Add Customer Invoice Details dialog
								[+] if(DlgInvoice.CancelButton.Exists(5))
									[ ] ReportStatus("Verify Cancel Button on Add Customer Invoice Details dialog ", PASS , "Cancel Button is present on Add Customer Invoice Details dialog")
								[+] else
									[ ] ReportStatus("Verify Cancel Button on Add Customer Invoice Details dialog", FAIL , "Cancel Button is present on Add Customer Invoice Details dialog")
						[ ] 
						[ ] DlgInvoice.SetActive()
						[ ] DlgInvoice.CancelButton.Click()
						[ ] 
						[+] if(AlertMessage.Exists(5))
							[ ] AlertMessage.Yes.Click()
						[ ] 
			[+] else
				[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
			[ ] 
			[ ] //This UI controls verification is for Payment from Customer
			[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
					[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
					[ ] 
					[ ] //Select first type "Invoice to Customer" from dropdown
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#2")
					[ ] //Click on Add Invoice Details Panel
					[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Exists(5))
						[ ] ReportStatus("Verify whether 'Add Invoice Details' on Add Invoice Reminder Dialog ", PASS , "'Add Invoice Details' is present on Add Invoice Reminder Dialog")
						[ ] 
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Click()
						[ ] 
						[+] //Verifying UI controls for the Add Customer Invoice Details on Add Invoice Reminder
							[ ] 
							[+] //Verify the Customer Text Field present on Add Customer Payment  Details dialog
								[+] if(DlgInvoice.CustomerTextField.Exists(5))
									[ ] ReportStatus("Verify Customer Text Field on Add Customer Payment Details dialog ", PASS , " Customer Text Field is present on Add Customer Payment Details dialog")
								[+] else
									[ ] ReportStatus("Verify Customer Text Field on Add Customer Payment Details dialog", FAIL , "Customer Text Field is not present on Add Customer Payment Details dialog")
							[ ] 
							[+] //Verify the DepositTo PopupList present on Add Customer Payment  Details dialog
								[+] if(DlgInvoice.DepositToPopupList.Exists(5))
									[ ] ReportStatus("Verify  DepositTo PopupList on Add Customer Payment Details dialog ", PASS , " DepositTo PopupList is present on Add Customer Payment Details dialog")
								[+] else
									[ ] ReportStatus("Verify  DepositTo PopupList on Add Customer Payment Details dialog ", FAIL , " DepositTo PopupList is present on Add Customer Payment Details dialog")
							[ ] 
							[+] //Verify the DATE TextField present on Add Customer Payment  Details dialog
								[+] if(DlgInvoice.DATETextField.Exists(5))
									[ ] ReportStatus("Verify  DATE Text Field on Add Customer Payment Details dialog ", PASS , " DATE Text Field is present on Add Customer Payment Details dialog")
								[+] else
									[ ] ReportStatus("Verify  DATE Text Field on Add Customer Payment Details dialog", FAIL , " DATE Text Field is not present on Add Customer Payment Details dialog")
							[ ] 
							[+] //Verify the CheckNumber TextField present on Add Customer Payment  Details dialog
								[+] if(DlgInvoice.CheckNumberTextField.Exists(5))
									[ ] ReportStatus("Verify  CheckNumber TextField on Add Customer Payment Details dialog ", PASS , " CheckNumber TextField is present on Add Customer Payment Details dialog")
								[+] else
									[ ] ReportStatus("Verify  CheckNumber TextField on Add Customer Payment Details dialog", FAIL , " CheckNumber TextField is not present on Add Customer Payment Details dialog")
							[ ] 
							[+] //Verify the Amount TextField present on Add Customer Payment  Details dialog
								[+] if(DlgInvoice.AmountTextField.Exists(5))
									[ ] ReportStatus("Verify  Amount TextField on Add Customer Payment Details dialog ", PASS , " Amount TextField is present on Add Customer Payment Details dialog")
								[+] else
									[ ] ReportStatus("Verify  Amount TextField on Add Customer Payment Details dialog", FAIL , " Amount TextField is not present on Add Customer Payment Details dialog")
							[ ] 
							[+] //Verify the Memo TextField present on Add Customer Payment  Details dialog
								[+] if(DlgInvoice.MemoTextField.Exists(5))
									[ ] ReportStatus("Verify Memo TextField on Add Customer Payment Details dialog ", PASS , "Memo TextField is present on Add Customer Payment Details dialog")
								[+] else
									[ ] ReportStatus("Verify Memo TextField on Add Customer Payment Details dialog", FAIL , "Memo TextField is not present on Add Customer Payment Details dialog")
							[ ] 
							[+] //Verify the Clear Payments Button present on Add Customer Payment  Details dialog
								[+] if(DlgInvoice.ClearPaymentsButton.Exists(5))
									[ ] ReportStatus("Verify Clear Payments Button on Add Customer Payment Details dialog ", PASS , "Clear Payments Button is present on Add Customer Payment Details dialog")
								[+] else
									[ ] ReportStatus("Verify Clear Payments Button on Add Customer Payment Details dialog", FAIL , "Clear Payments Button is not present on Add Customer Payment Details dialog")
							[ ] 
							[+] //Verify the OK Button present on Add Customer Payment  Details dialog
								[+] if(DlgInvoice.OK.Exists(5))
									[ ] ReportStatus("Verify OK Button on Add Customer Invoice Details dialog ", PASS , "OK Button is present on Add Customer Payment Details dialog")
								[+] else
									[ ] ReportStatus("Verify OK Button on Add Customer Invoice Details dialog", FAIL , "OK Button is not present on Add Customer Payment Details dialog")
							[ ] 
							[+] //Verify the Cancel Button present on Add Customer Payment  Details dialog
								[+] if(DlgInvoice.CancelButton.Exists(5))
									[ ] ReportStatus("Verify Cancel Button on Add Customer Payment Details dialog ", PASS , "Cancel Button is present on Add Customer Payment Details dialog")
								[+] else
									[ ] ReportStatus("Verify Cancel Button on Add Customer Payment Details dialog", FAIL , "Cancel Button is present on Add Customer Payment Details dialog")
						[ ] 
						[ ] DlgInvoice.SetActive()
						[ ] DlgInvoice.CancelButton.Click()
						[ ] 
						[+] if(AlertMessage.Yes.Exists(5))
							[ ] AlertMessage.Yes.Click()
						[ ] 
			[+] else
				[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
			[ ] 
			[ ] 
			[ ] DlgAddEditReminder.Close()
		[+] else
			[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
		[ ] 
		[ ] 
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC100_FunctionalityInvoicePanelVendorInvoiceNoData() ################
	[ ] //**************************************************************************************
	[+] // //testcase Name:	 TC100_FunctionalityInvoicePanelVendorInvoiceNoData()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This test case will  Verify that -Functionality of invoice panel: data not entered for Vendor invoice
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	   If no error occurs
		[ ] // Fail		   If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // March 14, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC100_FunctionalityInvoicePanelVendorInvoiceNoData() appstate QuickenBaseState
	[+] //Variable declaration and definition
		[ ] list of STRING lsAccountType = {"Customer Invoices","Vendor Invoices"}
		[ ] List of STRING lsAccountName = {"Vendor Invoices","Customer Invoices"}
		[ ] list of STRING lsLayout ={"Invoice Default", "<Customize>"}
		[ ] list of STRING lsTaxAccount ={"*Sales Tax*","<New>","<Edit>"}
		[ ] 
		[ ] integer iOpenAccountRegister,iValidate
		[ ] STRING sAction = "Delete"
		[ ] ANYTYPE sWindow="MDI"
		[ ] STRING sAccountBType = "Business"
		[ ] 
		[ ] sReminderType="Invoice"
		[ ] list of STRING  lsCompare
	[ ] 
	[ ] //Opening a Data file
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // iValidate = OpenDataFile(sFileName)
		[ ] // 
		[+] // if( iValidate==PASS)
			[ ] // ReportStatus("Validate Data File ",  iValidate, "Data file -  {sDataFile} is opened")
			[ ] 
			[+] // //Deleting the Exisitng Bussiness Accounts 
				[ ] // iOpenAccountRegister=AccountBarSelect(sAccountBType,2)
				[ ] // 
				[ ] // iValidate=ModifyAccount(sWindow, lsAccountName[1], sAction )
			[ ] 
			[ ] // //Creating Bussiness Accounts-Vendor Invoices
			[ ] // iValidate=AddBusinessAccount(lsBusAccType[1],lsAccountName[1])
			[ ] // 
			[+] // if (iValidate==PASS)
				[ ] // ReportStatus("Business Account", iValidate, "BusinessAccount -  {lsAccountName[1]}  is created successfully")
				[ ] 
				[ ] //Navigating Bills> Add Reminder > Invoice Reminder > Payee name > Next
				[ ] NavigateQuickenTab(sTAB_BILL)
				[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
				[ ] 
				[+] if(iValidate==PASS)
					[ ] //Verify whether Type Poplist is present on Add Invoice Reminder Dialog
					[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
							[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
							[ ] 
							[ ] //Select first type "Invoice from Vendor" from dropdown
							[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#3")
							[ ] 
							[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Exists(5))
								[ ] ReportStatus("Verify whether 'Add Invoice Details' on Add Invoice Reminder Dialog ", PASS , "'Add Invoice Details' is present on Add Invoice Reminder Dialog")
								[ ] //Click on Add Invoice Details Panel
								[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Click()
								[ ] 
								[+] //Verifying UI controls for the Add Vendor Invoice Details on Add Invoice Reminder
									[ ] 
									[+] //Verify the Vendor TextField present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.VendorTextField.Exists(5))
											[ ] ReportStatus("Verify Vendor TextField on Add Vendor Invoice Details dialog ", PASS , " Vendor Text Field is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify Vendor TextField on Add Vendor Invoice Details dialog", FAIL , "Vendor Text Field is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the Customer Text Field present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.CustomerTextField.Exists(5))
											[ ] ReportStatus("Verify Customer Text Field on Add Vendor Invoice Details dialog ", PASS , " Customer Text Field is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify Customer Text Field on Add Vendor Invoice Details dialog", FAIL , "Customer Text Field is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the  Project Job Text Field present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.ProjectJobTextField.Exists(5))
											[ ] ReportStatus("Verify  Project Job Text Field on Add Vendor Invoice Details dialog ", PASS , "  Project Job Text Field is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify  Project Job Text Field on Add Vendor Invoice Details dialog", FAIL , " Project Job Text Field is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the  Business Tag TextField present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.BusinessTagTextField.Exists(5))
											[ ] ReportStatus("Verify  Business Tag TextField on Add Vendor Invoice Details dialog ", PASS , "  Business Tag TextField is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify  Business Tag TextField on Add Vendor Invoice Details dialog", FAIL , " Business Tag TextField is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the Assign ProjectJob Button present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.AssignProjectJobButton.Exists(5))
											[ ] ReportStatus("Verify Assign ProjectJob Button on Add Vendor Invoice Details dialog ", PASS , " Assign ProjectJob Button is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify Assign ProjectJob Button on Add Vendor Invoice Details dialog", FAIL , " Assign ProjectJob Button is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the DATE TextField present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.DATETextField.Exists(5))
											[ ] ReportStatus("Verify  DATE Text Field on Add Vendor Invoice Details dialog ", PASS , " DATE Text Field is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify  DATE Text Field on Add Vendor Invoice Details dialog", FAIL , " DATE Text Field is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the BILLNO TextField present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.BILLNOTextField.Exists(5))
											[ ] ReportStatus("Verify BILLNO TextField on Add Vendor Invoice Details dialog ", PASS , "BILLNO TextField is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify BILLNO TextField on Add Vendor Invoice Details dialog", FAIL , " BILLNO TextField is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the DUEDATE TextField present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.DUEDATETextField.Exists(5))
											[ ] ReportStatus("Verify DUEDATE TextField on Add Vendor Invoice Details dialog ", PASS , "DUEDATE TextField is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify DUEDATE TextField on Add Vendor Invoice Details dialog", FAIL , "DUEDATE TextField is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the PONUMBER TextField present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.PONUMBERTextField.Exists(5))
											[ ] ReportStatus("Verify PONUMBER TextField on Add Vendor Invoice Details dialog ", PASS , "PONUMBER TextField is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify PONUMBER TextField on Add Vendor Invoice Details dialog", FAIL , "PONUMBER TextField is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the Category List present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.CategoryList.Exists(5))
											[ ] ReportStatus("Verify Category List on Add Vendor Invoice Details dialog ", PASS , "Category List is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify Category List on Add Vendor Invoice Details dialog", FAIL , "Category List is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the Add Lines Button present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.AddLinesButton.Exists(5))
											[ ] ReportStatus("Verify Add Lines Button on Add Vendor Invoice Details dialog ", PASS , "Add Lines Button is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify Add Lines Button on Add Vendor Invoice Details dialog", FAIL , "Add Lines Button is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the Memo TextField present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.MemoTextField.Exists(5))
											[ ] ReportStatus("Verify Memo TextField on Add Vendor Invoice Details dialog ", PASS , "Memo TextField is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify Memo TextField on Add Vendor Invoice Details dialog", FAIL , "Memo TextField is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the Create Payment Button present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.CreatePaymentButton.Exists(5))
											[ ] ReportStatus("Verify Create Payment Button on Add Vendor Invoice Details dialog ", PASS , "Create Payment Button is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify Create Payment Button on Add Vendor Invoice Details dialog", FAIL , "Create Payment Button is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the Payment History Button present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.PaymentHistoryButton.Exists(5))
											[ ] ReportStatus("Verify Payment History Button on Add Vendor Invoice Details dialog ", PASS , "Payment History Button is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify Payment History Button on Add Vendor Invoice Details dialog", FAIL , "Payment History Button is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the Save And New Button present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.SaveAndNewButton.Exists(5))
											[ ] ReportStatus("Verify Save And New Button on Add Vendor Invoice Details dialog ", PASS , "Save And New Button is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify Save And New Button on Add Vendor Invoice Details dialog", FAIL , "Save And New Button is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] // Verify the Save And Done Button present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.SaveAndDoneButton.Exists(5))
											[ ] ReportStatus("Verify Save And Done Button on Add Vendor Invoice Details dialog ", PASS , "Save And Done Button is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify Save And Done Button on Add Vendor Invoice Details dialog", FAIL , "Save And Done Button is not present on Add Vendor Invoice Details dialog")
									[ ] 
									[+] //Verify the Cancel Button present on Add Vendor Invoice Details dialog
										[+] if(DlgInvoice.CancelButton.Exists(5))
											[ ] ReportStatus("Verify Cancel Button on Add Vendor Invoice Details dialog ", PASS , "Cancel Button is present on Add Vendor Invoice Details dialog")
										[+] else
											[ ] ReportStatus("Verify Cancel Button on Add Vendor Invoice Details dialog", FAIL , "Cancel Button is present on Add Vendor Invoice Details dialog")
								[ ] 
								[ ] DlgInvoice.CancelButton.Click()
								[ ] 
								[+] if(AlertMessage.Yes.Exists(5))
									[ ] AlertMessage.Yes.Click()
								[ ] 
								[ ] 
								[ ] 
					[+] else
						[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
					[ ] 
					[ ] //This UI controls verification is for Payment to Vendor
					[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
							[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
							[ ] 
							[ ] //Select first type "Invoice to Customer" from dropdown
							[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#4")
							[ ] 
							[ ] //Click on Add Invoice Details Panel
							[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Exists(5))
								[ ] ReportStatus("Verify whether 'Add Invoice Details' on Add Invoice Reminder Dialog ", PASS , "'Add Invoice Details' is present on Add Invoice Reminder Dialog")
								[ ] 
								[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Click()
								[ ] 
								[ ] 
								[+] //Verifying UI controls for the Add Vendor Payment Details on Add Invoice Reminder
									[ ] 
									[+] //Verify the Vendor TextField present on Add Vendor Payment Details dialog
										[+] if(DlgInvoice.VendorTextField.Exists(5))
											[ ] ReportStatus("Verify Customer Text Field on Add Vendor Payment Details dialog ", PASS , " Customer Text Field is present on Add Vendor Payment Details dialog")
										[+] else
											[ ] ReportStatus("Verify Customer Text Field on Add Vendor Payment Details dialog", FAIL , "Customer Text Field is not present on Add Vendor Payment Details dialog")
									[ ] 
									[+] //Verify the WithdrawFrom PopupList present on AddVendor Payment Details dialog
										[+] if(DlgInvoice.WithdrawFromPopupList.Exists(5))
											[ ] ReportStatus("Verify  WithdrawFrom PopupList on Add Vendor Payment Details dialog ", PASS , " WithdrawFrom PopupList is present on Add Vendor Payment Details dialog")
										[+] else
											[ ] ReportStatus("Verify  WithdrawFrom PopupList on Add Vendor Payment Details dialog ", FAIL , " WithdrawFrom PopupList is present on Add Vendor Payment Details dialog")
									[ ] 
									[+] //Verify the DATE TextField present on Add Vendor Payment Details dialog
										[+] if(DlgInvoice.DATETextField.Exists(5))
											[ ] ReportStatus("Verify  DATE Text Field on Add Vendor Payment Details dialog ", PASS , " DATE Text Field is present on Add Vendor Payment Details dialog")
										[+] else
											[ ] ReportStatus("Verify  DATE Text Field on Add Vendor Payment Details dialog", FAIL , " DATE Text Field is not present on Add Vendor Payment Details dialog")
									[ ] 
									[+] //Verify the Memo TextField present on Add Vendor Payment Details dialog
										[+] if(DlgInvoice.MemoTextField.Exists(5))
											[ ] ReportStatus("Verify Memo TextField on Add Vendor Payment Details dialog ", PASS , "Memo TextField is present on Add Vendor Payment Details dialog")
										[+] else
											[ ] ReportStatus("Verify Memo TextField on Add Vendor Payment Details dialog", FAIL , "Memo TextField is not present on Add Vendor Payment Details dialog")
									[ ] 
									[+] //Verify the CheckNumber TextField present on  Add Vendor Payment Details dialog
										[+] if(DlgInvoice.VendorCheckNumberTextField.Exists(5))
											[ ] ReportStatus("Verify  CheckNumber TextField on Add Customer Payment Details dialog ", PASS , " CheckNumber TextField is present on Add Customer Payment Details dialog")
										[+] else
											[ ] ReportStatus("Verify  CheckNumber TextField on Add Customer Payment Details dialog", FAIL , " CheckNumber TextField is not present on Add Customer Payment Details dialog")
									[ ] 
									[+] //Verify the Amount TextField present on  Add Vendor Payment Details dialog
										[+] if(DlgInvoice.AmountTextField.Exists(5))
											[ ] ReportStatus("Verify  Amount TextField on Add Customer Payment Details dialog ", PASS , " Amount TextField is present on Add Customer Payment Details dialog")
										[+] else
											[ ] ReportStatus("Verify  Amount TextField on Add Customer Payment Details dialog", FAIL , " Amount TextField is not present on Add Customer Payment Details dialog")
									[ ] 
									[ ] 
									[+] //Verify the Clear Payments Button present on Add Vendor Payment Details dialog
										[+] if(DlgInvoice.ClearPaymentsButton.Exists(5))
											[ ] ReportStatus("Verify Clear Payments Button on Add Vendor Payment Details dialog ", PASS , "Clear Payments Button is present on Add Vendor Payment Details dialog")
										[+] else
											[ ] ReportStatus("Verify Clear Payments Button on Add Vendor Payment Details dialog", FAIL , "Clear Payments Button is not present on Add Vendor Payment Details dialog")
									[ ] 
									[+] //Verify the OKButton present on Add Vendor Payment Details dialog
										[+] if(DlgInvoice.OK.Exists(5))
											[ ] ReportStatus("Verify OK Button on Add Customer Invoice Details dialog ", PASS , "OK Button is present on Add Vendor Payment Details dialog")
										[+] else
											[ ] ReportStatus("Verify OK Button on Add Customer Invoice Details dialog", FAIL , "OK Button is not present on Add Vendor Payment Details dialog")
									[ ] 
									[+] //Verify the CancelButton present on Add Vendor Payment Details dialog
										[+] if(DlgInvoice.CancelButton.Exists(5))
											[ ] ReportStatus("Verify Cancel Button on Add Vendor Payment Details dialog ", PASS , "Cancel Button is present on Add Vendor Payment Details dialog")
										[+] else
											[ ] ReportStatus("Verify Cancel Button on Add Vendor Payment Details dialog", FAIL , "Cancel Button is present on Add Vendor Payment Details dialog")
								[ ] 
								[ ] DlgInvoice.CancelButton.Click()
								[ ] 
								[ ] 
								[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
					[ ] 
					[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
			[+] // else
				[ ] // ReportStatus("Business Account", iValidate, "BusinessAccount -  {lsAccountName[2]}  is not created")
			[ ] 
			[ ] // //Report Staus If Data file is not Opened
		[+] // else if( iValidate==FAIL)
			[ ] // ReportStatus("Validate Data File ",  iValidate, "Data file -  {sDataFile} is created but it is not Opened")
			[ ] // //Report Staus If Data file already exists
		[+] // else
			[ ] // ReportStatus("InValidate Data File ", iValidate, "File does not exists, Please change the Data File name")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC101_FunctionalityinvoicePanelCustomerInvoiceData() ################
	[ ] // **************************************************************************************
	[+] // testcase Name:	 TC101_FunctionalityinvoicePanelCustomerInvoiceData()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This test case will  Verify that Functionality of invoice panel: data entered for customer invoice
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	   If no error occurs
		[ ] // Fail		   If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // March 14, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC101_FunctionalityinvoicePanelCustomerInvoiceData() appstate QuickenBaseState
	[+] //Variable declaration and definition
		[ ] list of STRING lsAccountType = {"Customer Invoices","Vendor Invoices"}
		[ ] List of STRING lsAccountName = {"Vendor Invoices","Customer Invoices"}
		[ ] list of String lsContentsPayment = {"Checking 01 Account","Test Memo","CHK01","20.00"}
		[ ] list of String lsContents = {"JP01","IN01","PO-01","item 1","Descripition 1","2","20.00","Test Message","Test Memo"}
		[ ] integer iOpenAccountRegister,iValidate,i
		[ ] STRING sAction = "Delete"
		[ ] ANYTYPE sWindow="MDI"
		[ ] STRING sAccountBType = "Business",sCustomer
		[ ] 
		[ ] sReminderType="Invoice"
		[ ] list of STRING  lsCompare,lsCompContents
		[ ] 
	[ ] //Opening a Data file
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //Navigating Bills> Add Reminder > Invoice Reminder > Payee name > Next
		[ ] NavigateQuickenTab(sTAB_BILL)
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] // Verifying the Customer Invoice Form
			[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
					[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
					[ ] 
					[ ] //Select first type "Invoice to Customer" from dropdown
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#1")
					[ ] //Click on Add Invoice Details Panel
					[ ] DlgAddEditReminder.SetActive()
					[ ] DlgAddEditReminder.TextClick("Add invoice details")
					[+] if(DlgInvoice.Exists(3))
						[ ] ReportStatus("Verify whether 'Add Invoice Details' on Add Invoice Reminder Dialog ", PASS , "'Add Invoice Details' is present on Add Invoice Reminder Dialog")
						[ ] 
						[ ] //Verify the Customer Text Field present on Add Customer Invoice Details dialog
						[+] if(DlgInvoice.Exists(5))
							[ ] //Setting Data in all the Text fields of Forms
							[+] if(DlgInvoice.CustomerTextField.Exists(5))
								[ ] DlgInvoice.SetActive()
								[ ] DlgInvoice.CustomerTextField.SetText(sPayeeName)
								[ ] DlgInvoice.ProjectJobTextField.SetText(lsContents[1])
								[ ] DlgInvoice.INVOICETextField.SetText(lsContents[2])
								[ ] DlgInvoice.PONUMBERTextField.SetText(lsContents[3])
								[+] if(DlgInvoice.QWListViewerItem.Exists(5))
									[ ] DlgInvoice.QWListViewerItem.ListBox.Select("#1")
									[ ] DlgInvoice.PressKeys(KEY_SHIFT)
									[ ] DlgInvoice.TypeKeys(KEY_TAB)
									[ ] DlgInvoice.TypeKeys(KEY_TAB)
									[ ] DlgInvoice.ReleaseKeys(KEY_SHIFT)
									[ ] DlgInvoice.QWListViewerItem.ListBox.ItemNameTextField.TypeKeys(lsContents[4])
									[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
									[+] if(AlertMessage.Exists(5))
										[ ] AlertMessage.SetActive()
										[ ] AlertMessage.Yes.Click()
										[ ] DlgNewItem.OKButton.Click()
										[ ] 
									[+] // if(Quicken2012Popup.Exists(5))
										[ ] // Agent.SetOption(OPT_VERIFY_ENABLED,FALSE)
										[ ] // Quicken2012Popup.SetActive()
										[ ] // Quicken2012Popup.Yes.Click()
										[ ] // DlgNewItem.OKButton.Click()
										[ ] // Agent.SetOption(OPT_VERIFY_ENABLED,TRUE)
										[ ] // 
										[ ] // // NewProjectJobItem.OK.Click()
									[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
									[ ] DlgInvoice.QWListViewerItem.ListBox.DescriptionTextField.TypeKeys(lsContents[5])
									[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
									[ ] DlgInvoice.QWListViewerItem.ListBox.QuantityTextField.TypeKeys(lsContents[6])
									[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
									[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
									[ ] DlgInvoice.QWListViewerItem.ListBox.AmountTextField.TypeKeys(lsContents[7])
									[ ] DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_ENTER)
								[+] else
									[ ] ReportStatus("Verify Item List on Add Customer Invoice Details dialog", FAIL , "Item List is not present on Add Customer Invoice Details dialog")
								[ ] DlgInvoice.CustomerMessageTextField.SetText(lsContents[8])
								[ ] DlgInvoice.MemoTextField.SetText(lsContents[9])
								[ ] 
								[ ] DlgInvoice.SaveAndDoneButton.Click()
								[ ] 
								[+] // if(DlgNewProjectJob.Exists(5))
									[ ] // DlgNewProjectJob.SetActive()
									[ ] // Quicken2012Popup.Yes.Click()
									[ ] // DlgNewProjectJob.OKButton.Click()
								[+] // if(Quicken2013Popup.Exists(5))
									[ ] // Quicken2013Popup.SetActive()
									[ ] // Quicken2013Popup.YesButton.Click()
									[ ] // DlgNewProjectJob.OKButton.Click()
								[+] if (AlertMessage.Exists(5))
									[ ] AlertMessage.Yes.Click()
									[+] if (DlgNewProjectJob.Exists(5))
										[ ] DlgNewProjectJob.SetActive()
										[ ] DlgNewProjectJob.OKButton.Click()
										[ ] WaitForState(DlgNewProjectJob,FALSE,1)
									[+] else
										[ ] ReportStatus("Verify dialog New Project Job",FAIL,"Verify dialog New Project Job: Dialog New Project Job didn't appear.")
										[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] // DlgNewProjectJob.OKButton.Click()
								[ ] WaitForState(DlgAddEditReminder,TRUE,5)
								[ ] DlgAddEditReminder.SetActive()
								[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
								[ ] 
								[ ] 
								[+] if(DlgInvoice.Exists(5))
									[ ] //Retrieving Data in all the Text fields of Forms
									[+] if(DlgInvoice.CustomerTextField.Exists(5))
										[ ] DlgInvoice.SetActive()
										[ ] sCustomer=DlgInvoice.CustomerTextField.GetText()
										[ ] ListAppend(lsCompare,DlgInvoice.ProjectJobTextField.GetText())
										[ ] ListAppend(lsCompare,DlgInvoice.INVOICETextField.GetText())
										[ ] ListAppend(lsCompare,DlgInvoice.PONUMBERTextField.GetText())
										[ ] 
										[+] if(DlgInvoice.QWListViewerItem.Exists(5))
											[ ] //DlgInvoice.QWListViewerItem.ListBox.Select("#1")
											[ ] DlgInvoice.QWListViewerItem.ListBox.Select("#1")
											[ ] DlgInvoice.PressKeys(KEY_SHIFT)
											[ ] DlgInvoice.TypeKeys(KEY_TAB)
											[ ] DlgInvoice.TypeKeys(KEY_TAB)
											[ ] DlgInvoice.ReleaseKeys(KEY_SHIFT)
											[ ] 
											[ ] 
											[ ] 
											[ ] ListAppend(lsCompare,DlgInvoice.QWListViewerItem.ListBox.ItemNameTextField.GetText())
											[ ] 
											[ ] //DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
											[ ] //DlgInvoice.QWListViewerItem.ListBox.TypeKeys(KEY_TAB)
											[ ] DlgInvoice.TypeKeys(KEY_TAB)
											[ ] DlgInvoice.TypeKeys(KEY_TAB)
											[ ] ListAppend(lsCompare,DlgInvoice.QWListViewerItem.ListBox.DescriptionTextField.GetText())
											[ ] 
											[ ] //DlgInvoice.QWListViewerItem.ListBox.TextField1.TypeKeys(KEY_TAB)
											[ ] 
											[ ] DlgInvoice.TypeKeys(KEY_TAB)
											[ ] ListAppend(lsCompare,DlgInvoice.QWListViewerItem.ListBox.QuantityTextField.GetText())
											[ ] 
											[ ] //DlgInvoice.QWListViewerItem.ListBox.TextField1.TypeKeys(KEY_TAB)
											[ ] DlgInvoice.TypeKeys(KEY_TAB)
											[ ] DlgInvoice.TypeKeys(KEY_TAB)
											[ ] ListAppend(lsCompare,DlgInvoice.QWListViewerItem.ListBox.AmountTextField.GetText())
											[ ] 
											[ ] //DlgInvoice.QWListViewerItem.ListBox.TextField1.TypeKeys(KEY_ENTER)
											[ ] DlgInvoice.TypeKeys(KEY_ENTER)
											[ ] 
										[+] else
											[ ] ReportStatus("Verify Item List on Add Customer Invoice Details dialog", FAIL , "Item List is not present on Add Customer Invoice Details dialog")
										[ ] ListAppend(lsCompare,DlgInvoice.CustomerMessageTextField.GetText())
										[ ] ListAppend(lsCompare,DlgInvoice.MemoTextField.GetText())
										[ ] 
										[ ] //Comparing both the List retrieved data with entered data
										[ ] 
										[+] if(sPayeeName==sCustomer)
											[ ] ReportStatus("Verify Contents of Invoice form are same ", PASS ,"Contents : {sCustomer} are same as per entered in Invoice form for Customer Invoices")
										[+] else
											[ ] ReportStatus("Verify Contents of Invoice form are same ", FAIL , "Contents : {sCustomer},{sPayeeName} are not same as per entered in Invoice form for Customer Invoices")
										[ ] 
										[+] for(i=1;i<=listCount(lsCompare);i++)
											[ ] 
											[+] if(lsContents[i]==lsCompare[i])
												[ ] ReportStatus("Verify Contents of Invoice form are same ", PASS ,"Contents : {lsCompare[i]} are same as per entered in Invoice form for Customer Invoices")
											[+] else
												[ ] ReportStatus("Verify Contents of Invoice form are same ", FAIL , "Contents : {lsCompare[i]},{lsContents[i]} are not same as per entered in Invoice form for Customer Invoices")
										[ ] 
								[+] else
									[ ] ReportStatus("Verify Customer Invoice Form available on Add Invoice Reminder Dialog", FAIL , "Customer Invoice Form not available on Add Invoice Reminder Dialog")
									[ ] 
							[+] else
								[ ] ReportStatus("Verify Customer Invoice Form available on Add Invoice Reminder Dialog", FAIL , "Customer Invoice Form not available on Add Invoice Reminder Dialog")
						[ ] 
						[ ] DlgInvoice.Close()
					[ ] 
					[+] else
						[ ] ReportStatus("Verify whether 'Add Invoice Details' on Add Invoice Reminder Dialog ", FAIL , "'Add Invoice Details' is not present on Add Invoice Reminder Dialog")
				[ ] DlgAddEditReminder.Close()
			[+] else
				[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
		[ ] 
		[ ] NavigateQuickenTab(sTAB_BILL)
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[ ] //Verifying the Customer Payment Form
			[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
				[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
				[ ] 
				[ ] //Select first type "Payment from Customer" from dropdown
				[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#2")
				[ ] //Click on Add Invoice Details Panel
				[ ] DlgAddEditReminder.SetActive()
				[ ] DlgAddEditReminder.TextClick("Add payment details")
				[+] if(DlgInvoice.Exists(3))
					[ ] ReportStatus("Verify whether 'Add Invoice Details' on Add Invoice Reminder Dialog ", PASS , "'Add Invoice Details' is present on Add Invoice Reminder Dialog")
					[ ] 
					[ ] //Verify the Customer Text Field present on Add Customer Payment Details dialog
					[ ] //Setting Data in all the Text fields of Forms
					[+] if(DlgInvoice.CustomerTextField.Exists(5))
						[ ] DlgInvoice.SetActive()
						[ ] DlgInvoice.DepositToPopupList.Select("{lsContentsPayment[1]}")
						[ ] DlgInvoice.MemoTextField.SetText(lsContentsPayment[2])
						[ ] DlgInvoice.CheckNumberTextField.SetText(lsContentsPayment[3])
						[ ] DlgInvoice.AmountTextField.SetText(lsContentsPayment[4])
						[ ] 
						[ ] DlgInvoice.OK.Click()
						[ ] 
						[ ] DlgAddEditReminder.SetActive()
						[ ] DlgAddEditReminder.TextClick(lsContentsPayment[2])
						[+] if(DlgInvoice.Exists(5))
							[ ] //Retrieving Data in all the Text fields of Forms
							[+] if(DlgInvoice.CustomerTextField.Exists(5))
								[ ] DlgInvoice.SetActive()
								[ ] sCustomer=DlgInvoice.CustomerTextField.GetText()
								[ ] 
								[ ] ListAppend(lsCompContents,DlgInvoice.DepositToPopupList.GetText())
								[ ] ListAppend(lsCompContents,DlgInvoice.MemoTextField.GetText())
								[ ] ListAppend(lsCompContents,DlgInvoice.CheckNumberTextField.GetText())
								[ ] ListAppend(lsCompContents,DlgInvoice.AmountTextField.GetText())
								[ ] 
								[ ] //Comparing both the List retrieved data with entered data
								[ ] 
								[+] if(sPayeeName==sCustomer)
									[ ] ReportStatus("Verify Contents of Payment form are same ", PASS ,"Contents : {sCustomer} are same as per entered in Payment form for Customer Invoices")
								[+] else
									[ ] ReportStatus("Verify Contents of Invoice form are same ", FAIL , "Contents : {sCustomer},{sPayeeName} are not same as per entered in Invoice form for Customer Invoices")
								[ ] 
								[+] for(i=2;i<=listCount(lsCompContents);i++)
									[ ] 
									[+] if(lsContentsPayment[i]==lsCompContents[i])
										[ ] ReportStatus("Verify Contents of Payment form are same ", PASS ,"Contents : {lsCompContents[i]} are same as per entered in Payment form for Customer Invoices")
									[+] else
										[ ] ReportStatus("Verify Contents of Payment form are same ", FAIL , "Contents : {lsCompContents[i]},{lsContentsPayment[i]} are not same as per entered in Payment form for Customer Invoices")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Customer text field on Invoice dialog",FAIL,"Customer text field is not displayed on Invoice dialog")
							[ ] DlgInvoice.Close()
						[+] else
							[ ] ReportStatus("Verify Customer Payment Form available on Add Invoice Reminder Dialog", FAIL , "Customer Payment Form not available on Add Invoice Reminder Dialog")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify whether Payment from Customer on Add Invoice Reminder Dialog ", FAIL , "Payment from Customer is not present on Add Invoice Reminder Dialog")
						[ ] 
						[ ] 
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Customer Payment Form available on Add Invoice Reminder Dialog", FAIL , "Customer Payment Form not available on Add Invoice Reminder Dialog")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify whether 'Add Invoice Details' on Add Invoice Reminder Dialog ", FAIL , "'Add Invoice Details' is not present on Add Invoice Reminder Dialog")
			[ ] DlgAddEditReminder.Close()
			[ ] 
			[ ] // 
		[+] else
			[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC102_FunctionalityinvoicePanelVendorInvoiceData() ##################
	[ ] // **************************************************************************************
	[+] // testcase Name:	 TC102_FunctionalityinvoicePanelVendorInvoiceData()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This test case will  Verify that Functionality of invoice panel: data entered for Vendor invoice
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	   If no error occurs
		[ ] // Fail		   If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // March 18, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC102_FunctionalityinvoicePanelVendorInvoiceData() appstate QuickenBaseState
	[+] //Variable declaration and definition
		[ ] 
		[ ] list of STRING lsAccountType,lsAccountName,lsContents,lsContentsCompare,lsContentsPayment,lsCompare,lsCompContents,lsWithdraw,lsWithdrawCompare
		[ ] string sHandle,sActual,sAction
		[ ] Boolean bMatch
		[ ] integer iOpenAccountRegister,iValidate,i,iSetupAutoAPI
		[ ] ANYTYPE sWindow
		[ ] STRING sAccountBType,sCustomer
		[ ] 
		[ ] lsAccountType = {"Customer Invoices","Vendor Invoices"}
		[ ] lsAccountName = {"Vendor Invoices","Customer Invoices"}
		[ ] lsContents = {"BIL01","PO-01","Car & Truck (Business)","Description1","20.00","Test Memo"}
		[ ] lsContentsCompare = {"BIL01","PO-01","Car & Truck (Business)","Description1","-20.00","Test Memo"}
		[ ] lsContentsPayment = {"Test Memo","DEP","20.00"}
		[ ] lsWithdrawCompare ={"Checking"}
		[ ] sAction = "Delete"
		[ ] sWindow="MDI"
		[ ] sAccountBType = "Business"
		[ ] sReminderType="Invoice"
		[ ] 
		[ ] iSetupAutoAPI = SetUp_AutoApi()
		[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Navigating Bills> Add Reminder > Invoice Reminder > Payee name > Next
		[ ] NavigateQuickenTab(sTAB_BILL)
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] // Verifying the Vendor Invoice Form
			[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
				[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
				[ ] 
				[ ] //Select first type "Invoice to Vendor" from dropdown
				[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#3")
				[ ] 
				[ ] //Click on Add Invoice Details Panel
				[ ] DlgAddEditReminder.SetActive()
				[ ] DlgAddEditReminder.TextClick("Add invoice details")
				[ ] ReportStatus("Verify whether 'Add Invoice Details' on Add Invoice Reminder Dialog ", PASS , "'Add Invoice Details' is present on Add Invoice Reminder Dialog")
				[ ] 
				[ ] //Verify the Customer Text Field present on Add Vendor Invoice Details dialog
				[+] if(DlgInvoice.Exists(5))
					[ ] //Setting Data in all the Text fields of Forms
					[ ] DlgInvoice.SetActive()
					[ ] 
					[ ] DlgInvoice.AssignProjectJobButton.Click()
					[ ] 
					[ ] 
					[+] if(DlgInvoice.SelectProjectJob.QWListViewerProjectJob.ListBox1.Exists(5))
						[ ] // ReportStatus("Verify the Select Project Job dialog present",PASS , "Select Project Job dialog is present ")
						[ ] DlgInvoice.SelectProjectJob.QWListViewerProjectJob.ListBox1.Select(1)
						[ ] sHandle=Str(DlgInvoice.SelectProjectJob.QWListViewerProjectJob.ListBox1.GetHandle())
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
						[ ] bMatch = MatchStr("*{sPayeeName}*",sActual)
						[+] if(bMatch == TRUE)
							[ ] DlgInvoice.SelectProjectJob.OK.Click()
						[+] else
							[ ] ReportStatus("Verify the Row present in List", FAIL , "The required row is not present in the List")
						[ ] 
						[ ] 
						[ ] 
						[ ] // NewProjectJobItem.SelectProjectJob.ListBox1.Select ("#1")
						[ ] // sHandle = Str(NewProjectJobItem.SelectProjectJob.ListBox1.GetHandle())
						[ ] // sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
						[ ] // bMatch = MatchStr("*{sPayeeName}*",sActual)
						[+] // if(bMatch == TRUE)
							[ ] // NewProjectJobItem.OKButton.Click()
						[+] // else
							[ ] // ReportStatus("Verify the Row present in List", FAIL , "The required row is not present in the List")
						[ ] ////SelectProjectJob("Test","ProjectJobName")
					[+] else
						[ ] ReportStatus("Verify the Select Project Job dialog present", FAIL , "Select Project Job dialog is not present ")
					[ ] 
					[ ] DlgInvoice.BILLNOTextField.SetText(lsContents[1])
					[ ] DlgInvoice.PONUMBERTextField.SetText(lsContents[2])
					[ ] 
					[ ] //Inserting the Data in the Category table 
					[+] if(DlgInvoice.CategoryList.Exists(5))
						[ ] DlgInvoice.CategoryList.ListBox1.Select("#1")
						[ ] DlgInvoice.PressKeys(KEY_SHIFT)
						[ ] DlgInvoice.TypeKeys(KEY_TAB)
						[ ] DlgInvoice.ReleaseKeys(KEY_SHIFT)
						[ ] 
						[ ] 
						[ ] DlgInvoice.CategoryList.ListBox1.TypeKeys(lsContents[3])
						[ ] DlgInvoice.CategoryList.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[+] if(SetUpCategory.OK.Exists(5))
							[ ] SetUpCategory.OK.Click()
						[ ] 
						[ ] DlgInvoice.CategoryList.ListBox1.TypeKeys(lsContents[4])
						[ ] //DlgInvoice.CategoryList.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] //DlgInvoice.CategoryList.ListBox1.TextField1.TypeKeys(KEY_TAB)
						[ ] DlgInvoice.TypeKeys(KEY_TAB)
						[ ] DlgInvoice.TypeKeys(KEY_TAB)
						[ ] DlgInvoice.CategoryList.ListBox1.TypeKeys(lsContents[5])
					[+] else
						[ ] ReportStatus("Verify Category List on Add Vendor Invoice Details dialog", FAIL , "Item List is not present on Add Vendor Invoice Details dialog")
					[ ] 
					[ ] DlgInvoice.MemoTextField.SetText(lsContents[6])
					[ ] 
					[ ] DlgInvoice.SaveAndDoneButton.Click()
					[ ] 
					[ ] //Opening the form to retrieving the data
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
					[ ] 
					[+] if(DlgInvoice.Exists(5))
						[ ] //Retrieving Data in all the Text fields of Forms
						[ ] DlgInvoice.SetActive()
						[ ] 
						[ ] ListAppend(lsCompare,DlgInvoice.BILLNOTextField.GetText())
						[ ] ListAppend(lsCompare,DlgInvoice.PONUMBERTextField.GetText())
						[ ] 
						[+] if(DlgInvoice.CategoryList.Exists(5))
							[ ] DlgInvoice.CategoryList.ListBox1.Select("#1")
							[ ] DlgInvoice.PressKeys(KEY_SHIFT)
							[ ] DlgInvoice.TypeKeys(KEY_TAB)
							[ ] DlgInvoice.ReleaseKeys(KEY_SHIFT)
							[ ] ListAppend(lsCompare,DlgInvoice.CategoryList.ListBox1.TextField1.GetText())
							[ ] //DlgInvoice.CategoryList.ListBox1.TextField1.TypeKeys(KEY_TAB)
							[ ] DlgInvoice.TypeKeys(KEY_TAB)
							[ ] ListAppend(lsCompare,DlgInvoice.CategoryList.ListBox1.TextField12.GetText())
							[ ] //DlgInvoice.CategoryList.ListBox1.TextField1.TypeKeys(KEY_TAB)
							[ ] //DlgInvoice.CategoryList.ListBox1.TextField1.TypeKeys(KEY_TAB)
							[ ] DlgInvoice.TypeKeys(KEY_TAB)
							[ ] DlgInvoice.TypeKeys(KEY_TAB)
							[ ] ListAppend(lsCompare,DlgInvoice.CategoryList.ListBox1.TextField14.GetText())
						[+] else
							[ ] ReportStatus("Verify Item List on Add Vendor Invoice Details dialog", FAIL , "Item List is not present on Add Vendor Invoice Details dialog")
							[ ] ListAppend(lsCompare,DlgInvoice.MemoTextField.GetText())
							[ ] 
							[ ] 
						[ ] 
						[+] //Comparing both the List retrieved data with entered data
							[ ] 
							[+] for(i=1;i<=listCount(lsCompare);i++)
								[ ] 
								[+] if(lsContentsCompare[i]==lsCompare[i])
									[ ] ReportStatus("Verify Contents of Invoice form are same ", PASS ,"Contents : {lsCompare[i]} are same as per entered in Invoice form for Vendor Invoices")
								[+] else
									[ ] ReportStatus("Verify Contents of Invoice form are same ", FAIL , "Contents : {lsCompare[i]},{lsContentsCompare[i]} are not same as per entered in Invoice form for Vendor Invoices")
									[ ] 
						[ ] 
						[ ] DlgInvoice.CancelButton.Click()
						[+] if(AlertMessage.Yes.Exists(5))
							[ ] AlertMessage.Yes.Click()
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Vendor Invoice Form available on Add Invoice Reminder Dialog", FAIL , "Vendor Invoice Form not available on Add Invoice Reminder Dialog")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify Vendor Invoice Form available on Add Invoice Reminder Dialog", FAIL , "Vendor Invoice Form not available on Add Invoice Reminder Dialog")
				[ ] 
				[ ] 
				[ ] 
			[+] else
					[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
			[ ] DlgAddEditReminder.Close()
			[ ] 
			[ ] // 
		[+] else
			[ ] // ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
		[ ] 
		[ ] 
	[+] else
		[+] // ReportStatus("Business Account", iValidate, "BusinessAccount -  {lsAccountName[2]}  is not created")
			[ ] 
			[ ] // //Report Staus If Data file is not Opened
		[+] // else if( iValidate==FAIL)
			[ ] // ReportStatus("Validate Data File ",  iValidate, "Data file -  {sDataFile} is created but it is not Opened")
			[ ] // //Report Staus If Data file already exists
		[+] // else
			[ ] // ReportStatus("InValidate Data File ", iValidate, "File does not exists, Please change the Data File name")
			[ ] // 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC103_InvokingPointInvoiceReminder() ##############################
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC103_InvokingPointInvoiceReminder()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This test case will  Verify that form invoking point for invoice reminder
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	   If no error occurs
		[ ] // Fail		   If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // March 14, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC103_InvokingPointInvoiceReminder() appstate QuickenBaseState
	[+] //Variable declaration and definition
		[ ] list of STRING lsAccountType = {"Customer Invoices","Vendor Invoices"}
		[ ] List of STRING lsAccountName = {"Vendor Invoices","Customer Invoices"}
		[ ] list of STRING lsLayout ={"Invoice Default", "<Customize>"}
		[ ] list of STRING lsTaxAccount ={"*Sales Tax*","<New>","<Edit>"}
		[ ] List of String lsTitle = {"Invoice - Customer Invoices","Payment - Customer Invoices","Bill - Vendor Invoices","Payment - Vendor Invoices"}
		[ ] list of STRING lsType = {"Invoice to Customer","Payment from Customer","Invoice from Vendor","Payment to Vendor"}
		[ ] 
		[ ] integer iOpenAccountRegister,iValidate,iType
		[ ] STRING sAction = "Delete"
		[ ] ANYTYPE sWindow="MDI"
		[ ] STRING sAccountBType = "Business"
		[ ] String sCompareText 
		[ ] sReminderType="Invoice"
		[ ] list of STRING  lsCompare
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // //Creating Bussiness Accounts-Customer Invoices
		[ ] // iValidate=AddBusinessAccount(lsBusAccType[2],lsAccountName[2])
		[ ] 
		[ ] //Navigating to Second screen of Invocie Reminder
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] //Verify whether Type Poplist is present on Add Invoice Reminder Dialog
			[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
				[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
				[ ] //Storing the all the Type in one list variable for comparison
				[ ] lsCompare = DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.GetContents()
				[ ] 
				[ ] 
				[+] for(iType=1;iType<=listCount(lsCompare);iType++)
					[ ] //Select first type "Invoice to Customer" from dropdown
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#{iType}")
					[ ] 
					[+] if(iType%2==0)
						[ ] DlgAddEditReminder.TextClick("Add payment details")
					[+] else
						[ ] DlgAddEditReminder.TextClick("Add invoice details")
					[ ] 
					[ ] 
					[ ] //Getting Title of Form for verification and verifying it.
					[ ] sCompareText = DlgInvoice.GetCaption()
					[ ] //DlgInvoice.InvoiceCustomerTitles.GetText()
					[+] if(lsTitle[iType]==sCompareText)
						[ ] ReportStatus("Verify {lsType[iType]} -  {sCompareText} form invoke after Add Details is clicked", PASS , "'{lsType[iType]} -  {sCompareText} form invoke after Add Details Panel was clicked")
						[ ] 
						[ ] DlgInvoice.Close()
						[ ] 
						[+] if(AlertMessage.Exists(5))
							[ ] AlertMessage.Yes.Click()
					[+] else
						[ ] ReportStatus("Verify {lsType[iType]} -  {sCompareText} form invoke after Add Details is clicked", FAIL , "'{lsType[iType]} -  {sCompareText} form is not invoke after Add Details Panel was clicked")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
			[ ] 
			[ ] DlgAddEditReminder.Close()
		[+] else
			[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
			[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
[ ] //#############################################################################
[ ] 
[+] //###############TC104_DynamicLabelsInvoiceReminder() ############################
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC104_DynamicLabelsInvoiceReminder()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This test case will  Verify that dynamic labels for invoice reminder
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	   If no error occurs
		[ ] // Fail		   If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // March 14, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC104_DynamicLabelsInvoiceReminder() appstate QuickenBaseState
	[+] //Variable declaration and definition
		[ ] list of STRING lsAccountType = {"Customer Invoices","Vendor Invoices"}
		[ ] List of STRING lsAccountName = {"Vendor Invoices","Customer Invoices"}
		[ ] list of STRING lsTitle = {"Invoice to Customer","Payment from Customer","Invoice from Vendor","Payment to Vendor"}
		[ ] 
		[ ] integer iOpenAccountRegister,iValidate,iType
		[ ] String sCompareText 
		[ ] sReminderType="Invoice"
		[ ] list of STRING  lsCompare
	[ ] 
	[ ] //Opening a Data file
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // iValidate = OpenDataFile(sFileName)
		[ ] // 
		[+] // if( iValidate==PASS)
			[ ] // ReportStatus("Validate Data File ",  iValidate, "Data file -  {sDataFile} is opened")
			[ ] //Navigating to Second screen of Invocie Reminder
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[ ] 
			[+] if(iValidate==PASS)
				[ ] //Verify whether Type Poplist is present on Add Invoice Reminder Dialog
				[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
					[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
					[ ] //Storing the all the Type in one list variable for comparison
					[ ] lsCompare = DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.GetContents()
					[ ] 
					[+] for(iType=1;iType<=listCount(lsCompare);iType++)
						[ ] 
						[ ] //It will select one by one type from the dropdown
						[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#{iType}")
						[ ] 
						[ ] 
						[ ] 
						[ ] //Click on the Due Date Change Link to verify the dynamic label 
						[ ] 
						[ ] 
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
						[ ] 
						[ ] WaitForState(DlgOptionalSetting,TRUE,20)
						[ ] 
						[ ] //Get the dynamic label present on the frequency dialog and verifying it.
						[+] if(DlgOptionalSetting.DueNextOnOptionalSettingDialogTitle.Exists(5))
							[ ] ReportStatus("Verify Title on the Date Frequency dailog ", PASS , "Title is  present on the Date Frequency dailog ")
							[ ] 
							[ ] sCompareText = DlgOptionalSetting.DueNextOnOptionalSettingDialogTitle.GetText()
							[ ] 
							[ ] //Compare the retrieved content with available content
							[+] if(lsTitle[iType]==sCompareText)
								[ ] ReportStatus("Verify '{lsTitle[iType]}' invoke after DueDate Change Link is clicked", PASS , "'{sCompareText} invoke after DueDate Change Link was clicked")
							[+] else
								[ ] ReportStatus("Verify '{lsTitle[iType]}' invoke after DueDate Change Link is clicked", FAIL , "'{lsTitle[iType]} , {sCompareText} invoke after DueDate Change Link was clicked")
							[ ] 
							[ ] 
							[ ] //Close the dialog
							[ ] DlgOptionalSetting.CancelButton.Click()
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Title on the Date Frequency dailog ", FAIL , "Title is not present on the Date Frequency dailog ")
						[ ] 
						[ ] //Get the dynamic label present on the Remind Days dialog and verifying it
						[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
							[ ] SETTING :
							[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
								[ ] ReportStatus("Verify Remind Days Change Link under Optional Settings", PASS , "  Remind Days Change Link is present under Optional Settings")
								[ ] 
								[ ] 
								[ ] 
								[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
								[ ] 
								[ ] //Get the dynamic label present on the Remind Days dailog
								[+] if(DlgOptionalSetting.RemindMeOptionalSettingDialogTitle.Exists(5))
									[ ] ReportStatus("Verify Title on the Remind Days dailog ", PASS , "Title is present on the Remind Days dailog")
									[ ] sCompareText = DlgOptionalSetting.RemindMeOptionalSettingDialogTitle.GetText()
									[ ] //Compare the retrieved content with available content
									[+] if(lsTitle[iType]==sCompareText)
										[ ] ReportStatus("Verify '{lsTitle[iType]}' invoke after DueDate Change Link is clicked", PASS , "'{sCompareText} invoke after DueDate Change Link was clicked")
										[ ] 
									[+] else
										[ ] ReportStatus("Verify '{lsTitle[iType]}' invoke after Remind Days Change Link is clicked", FAIL, "'{lsTitle[iType]} , {sCompareText} invoke after Remind Days Change Link was clicked")
										[ ] 
										[ ] 
									[ ] 
									[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
									[ ] //Close the dialog
									[ ] DlgOptionalSetting.CancelButton.Click()
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Title on the Remind Days dailog ", FAIL , "Title is not present on the Remind Days dailog ")
								[ ] 
							[+] else
								[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
								[ ] goto SETTING
							[ ] 
						[+] else
							[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
						[ ] 
						[ ] 
						[ ] //Get the dynamic label present on the Website Add dialog and verifying it
						[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
							[ ] SETTING1:
							[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
								[ ] ReportStatus("Verify Website Add Link under Optional Settings", PASS , " Website Add Link is present under Optional Settings")
								[ ] 
								[ ] 
								[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Click()
								[ ] 
								[ ] //Get the dynamic label present on the Website Add dailog
								[+] if(DlgOptionalSetting.RemindMeOptionalSettingDialogTitle.Exists(5))
									[ ] ReportStatus("Verify Title on the Website Add dailog ", PASS , "Title is present on the Website Add dailog")
									[ ] sCompareText = DlgOptionalSetting.RemindMeOptionalSettingDialogTitle.GetText()
									[ ] //Compare the retrieved content with available content
									[+] if(lsTitle[iType]==sCompareText)
										[ ] ReportStatus("Verify '{lsTitle[iType]}' invoke after Website Add Link is clicked", PASS , "'{sCompareText} invoke after Website Add Link was clicked")
										[ ] 
									[+] else
										[ ] ReportStatus("Verify '{lsTitle[iType]}' invoke after Remind Days Change Link is clicked", FAIL , "'{lsTitle[iType]} , {sCompareText} invoke after Remind Days Change Link was clicked")
										[ ] 
										[ ] 
									[ ] 
									[ ] 
									[ ] //Close the dialog
									[ ] DlgOptionalSetting.CancelButton.Click()
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Title on the Remind Days dailog ", FAIL , "Title is not present on the Remind Days dailog ")
								[ ] 
							[+] else
								[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
								[ ] goto SETTING1
							[ ] 
						[+] else
							[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
				[ ] 
				[ ] DlgAddEditReminder.Close()
				[ ] 
			[+] else
				[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC105_HeaderLabelsInvoiceReminder()##############################
	[ ] // **************************************************************************************
	[+] // testcase Name:	TC105_HeaderLabelInvoiceReminder()
		[ ] // 
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify header label on model form for invoice reminder
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] // 
		[ ] // RETURNS:			Pass 	   If no error occurs
		[ ] // Fail		   If any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:
		[ ] // March 14, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC105_HeaderLabelInvoiceReminder() appstate QuickenBaseState
	[+] //Variable declaration and definition
		[ ] list of STRING lsAccountType = {"Customer Invoices","Vendor Invoices"}
		[ ] List of STRING lsAccountName = {"Vendor Invoices","Customer Invoices"}
		[ ] list of STRING lsLayout ={"Invoice Default", "<Customize>"}
		[ ] list of STRING lsTaxAccount ={"*Sales Tax*","<New>","<Edit>"}
		[ ] List of String lsTitle = {"Invoice - Customer Invoices","Payment - Customer Invoices","Bill - Vendor Invoices","Payment - Vendor Invoices"}
		[ ] list of STRING lsType = {"Invoice to Customer","Payment from Customer","Invoice from Vendor","Payment to Vendor"}
		[ ] 
		[ ] integer iOpenAccountRegister,iValidate,iType
		[ ] STRING sAction = "Delete"
		[ ] ANYTYPE sWindow="MDI"
		[ ] STRING sAccountBType = "Business"
		[ ] String sCompareText 
		[ ] sReminderType="Invoice"
		[ ] list of STRING  lsCompare
	[ ] 
	[ ] //Opening a Data file
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigating to Second screen of Invocie Reminder
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] //Verify whether Type Poplist is present on Add Invoice Reminder Dialog
			[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Exists(5))
				[ ] ReportStatus("Verify whether 'Type PopList' on Add Invoice Reminder Dialog ", PASS , "Type PopList is present on Add Invoice Reminder Dialog")
				[ ] //Storing the all the Type in one list variable for comparison
				[ ] lsCompare = DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.GetContents()
				[ ] 
				[ ] 
				[+] for(iType=1;iType<=listCount(lsCompare);iType++)
					[ ] //Select first type "Invoice to Customer" from dropdown
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.InvoiceType.Select("#{iType}")
					[ ] 
					[+] if(iType%2==0)
						[ ] DlgAddEditReminder.TextClick("Add payment details")
					[+] else
						[ ] DlgAddEditReminder.TextClick("Add invoice details")
					[ ] 
					[ ] //Getting Title of Form for verification and verifying it
					[ ] sCompareText = DlgInvoice.GetCaption()
					[+] if(lsTitle[iType]==sCompareText)
						[ ] ReportStatus("Verify For {lsType[iType]}  - ' {sCompareText}' as Header label on form after Add Details is clicked ", PASS , "' For {lsType[iType]} - '{sCompareText}' as Header label on form after Add Details is clicked")
						[ ] 
						[ ] DlgInvoice.Close()
						[ ] 
						[+] if(AlertMessage.Yes.Exists(5))
							[ ] AlertMessage.Yes.Click()
					[+] else
						[ ] ReportStatus("Verify For {lsType[iType]} -  '{sCompareText} 'as Header label on form after Add Details is clicked ", FAIL , "'For {lsType[iType]} -  '{sCompareText}' as Header label on form after Add Details is clicked")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Verify 'Type PopList' on Add Invoice Reminder Dialog", FAIL , "Type PopList is not present on Add Invoice Reminder Dialog")
			[ ] 
			[ ] DlgAddEditReminder.Close()
		[+] else
			[ ] ReportStatus("Navigate to Add {sReminderType} Reminder second screen", FAIL , "Navigation to Add {sReminderType} Reminder second screen failed")
			[ ] 
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //############# TC107_ManageReminderLaunchFromCalendar() ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 TC107_ManageReminderLaunchFromCalendar()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will verify different invoking points for manage reminder dialog.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Mar 05, 2013		Suyash Joshi	created
	[ ] // ********************************************************
[+] testcase TC107_ManageReminderLaunchFromCalendar() appstate QuickenBaseState
	[ ] 
	[+] //Variable Declaration and defination
		[ ] boolean bCheckStatus
		[ ] STRING iAmountDue = "5.15"
	[ ] //
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] QuickenWindow.SetActive()
		[+] //Verify that 'Manage Reminder' dialog will be launched from Upcoming -> Calendar view.
			[ ] 
			[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
			[ ] 
			[ ] sReminderType ="Bill"
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[ ] 
			[+] if(iValidate ==PASS)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(iAmountDue)
				[ ] DlgAddEditReminder.DoneButton.Click()
				[ ] MDIClient.Bills.ViewAsPopupList.Select(3)
				[ ] MDIClient.Bills.Calendar.Panel.PanelText1.PanelText2.ManageRemindersrButton.click()
				[ ] 
				[+] if (DlgManageReminders.Exists(5))
					[ ] iValidate=PASS
				[+] else
					[ ] iValidate=FAIL
				[ ] 
				[+] if(iValidate ==PASS)
					[ ] ReportStatus("Manage Reminder dialog  ", PASS, "Manage Reminder dialog is launched from upcoming tab -> Calendar View")
				[+] else
					[ ] ReportStatus("Manage Reminder dialog  ", FAIL, "Manage Reminder dialog is NOT launched from upcoming tab -> Calendar View")
				[ ] DlgManageReminders.Close()
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("NavigateReminderDetailsPage ", FAIL, "NavigateReminderDetailsPage failed")
				[ ] 
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Quicken Main Window", FAIL, "Quicken Main window is missing.")
[ ] //#############################################################################
[ ] 
[+] //###############TC108_BillUIEstimateAmountCreditCard()############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC108_BillUIEstimateAmountCreditCard()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify UI of Estimate amount for me (change) link window,  when 'Credit Card' account is selected as a category
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If all UI controls  Estimate amount for me (change) link window is correct
		[ ] //				        	Fail		   If all UI controls  Estimate amount for me (change) link window is not correct
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 08, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC108_BillUIEstimateAmountCreditCard() appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration and definition
		[ ] STRING sActualMessage,sExpectedMessage, sCategory
		[ ] List of List of STRING lsAccount
		[ ] List of ANYTYPE IsAddAccount2 = {"Credit Card", "Credit Card","500",sDateStamp,"Personal Transactions"}
		[ ] List of STRING lsEstimate
		[ ] lsEstimate = {"Fixed amount","Previous payments","Time of year", "Current credit card balance"}
		[ ] //sExpectedMessage = "No accounts exist. Please create an account before creating a reminder."
		[ ] sReminderType ="Bill"
		[ ] sCategory = "[Credit Card]"
	[ ] 
	[ ] // Report Staus If Data file Created successfully
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //Add a manual credit card account.
		[ ] iValidate=AddManualSpendingAccount(IsAddAccount2[1],IsAddAccount2[2],IsAddAccount2[3],IsAddAccount2[4])
		[+] if(iValidate == PASS)
			[ ] ReportStatus("Add Credit Card Account", PASS, "Credit Card account is added.")
			[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
			[ ] //Select 'Credit card account' as a category
			[+] if(DlgOptionalSetting.Exists(5))
				[ ] ReportStatus("Launch category, tag, memo dialog", PASS , "Category, tag, memo dialog is launched")
				[ ] 
				[ ] DlgOptionalSetting.CategoryTextField.SetText(sCategory)
				[ ] DlgOptionalSetting.TypeKeys(KEY_TAB)											
				[ ] DlgOptionalSetting.OKButton.Click()
				[ ] //DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
				[ ] 
				[ ] // Verify the 'Estimate for Me' dialog is present
				[ ] 
				[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
					[ ] 
				[ ] 
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
					[ ] 
					[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", PASS , "  Estimate Amount Change Link is present under Optional Settings")
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
					[ ] 
					[+] if(DlgOptionalSetting.Exists(5))
						[ ] ReportStatus("Verify  'Estimate for Me' dialog present", PASS , " 'Estimate for Me' dialog is present")
						[ ] //Verify the contents in Estimate Popup List on 'Estimate for Me' dialog
						[+] if(DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Exists(5))
							[ ] ReportStatus("Verify Estimate Popup List on 'Estimate for Me' dialog ", PASS , "Estimate Popup List is present on 'Estimate for Me' dialog")
							[ ] 
							[ ] //Get the contents of Quicken Can Help You Estimate PopupList
							[ ] lsCompare=DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.GetContents()
							[ ] 
							[ ] //Verify the contents in Estimate Popup List on 'Estimate for Me' dialog
							[+] for(j=1;j<=ListCount(lsEstimate);j++)
								[+] if(lsEstimate[j]==lsCompare[j])
									[ ] ReportStatus("Verify the Contents of Estimate Popup List",PASS,"As {lsCompare[j]} is same")
								[+] else
									[ ] ReportStatus("Verify the Contents of Estimate Popup List",FAIL,"As {lsEstimate[j]},{lsCompare[j]} is not same")
							[ ] 
							[ ] DlgOptionalSetting.CancelButton.Click()
						[+] else
							[ ] ReportStatus("Verify Estimate Popup List on 'Estimate for Me' dialog", FAIL , "Estimate Popup List is not present on 'Estimate for Me' dialog")
					[+] else
						[ ] ReportStatus("Verify  'Estimate for Me' dialog present", FAIL , " 'Estimate for Me' dialog is NOT present")
					[ ] 
					[ ] DlgAddEditReminder.CancelButton.Click()
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", FAIL , "  Estimate Amount Change Link is NOT present under Optional Settings")
				[ ] 
			[+] else
				[ ] ReportStatus("Launch category, tag, memo dialog", FAIL , "Category, tag, memo dialog is NOT launched")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Credit Card Account", FAIL, "Credit card account is NOT added.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC109_BillFunctionalityEstimateAmountCreditCard()###################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC109_BillFunctionalityEstimateAmountCreditCard()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality of option 'Current Credit Card Balance' Estimate amount for me (change) link window, 
		[ ] //when 'Credit Card' account is selected as a transfer category.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If all UI controls  Estimate amount for me (change) link window is correct
		[ ] //				        	Fail		   If all UI controls  Estimate amount for me (change) link window is not correct
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 08, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC109_BillFunctionalityEstimateAmountCreditCard() appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration and definition
		[ ] STRING sActualMessage,sExpectedMessage, sCategory
		[ ] List of List of STRING lsAccount
		[ ] List of STRING lsEstimate
		[ ] sReminderType ="Bill"
		[ ] sCategory = "[Credit Card]"
	[ ] 
	[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
	[ ] //Select 'Credit card account' as a category
	[+] if(DlgOptionalSetting.Exists(5))
		[ ] ReportStatus("Launch category, tag, memo dialog", PASS , "Category, tag, memo dialog is launched")
		[ ] 
		[ ] DlgOptionalSetting.CategoryTextField.SetText(sCategory)
		[ ] DlgOptionalSetting.TypeKeys(KEY_TAB)											
		[ ] DlgOptionalSetting.OKButton.Click()
		[ ] 
		[ ] // Verify the 'Estimate for Me' dialog is present
		[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Exists(5))
			[ ] 
			[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", PASS , "  Estimate Amount Change Link is present under Optional Settings")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.EstimateAmountChangeLink.Click()
			[ ] 
			[+] if(DlgOptionalSetting.Exists(5))
				[ ] ReportStatus("Verify  'Estimate for Me' dialog present", PASS , " 'Estimate for Me' dialog is present")
				[ ] DlgOptionalSetting.QuickenCanHelpYouEstimatePopupList.Select("#4")
				[ ] DlgOptionalSetting.OKButton.Click()
			[+] else
				[ ] ReportStatus("Verify  'Estimate for Me' dialog present", FAIL , " 'Estimate for Me' dialog is NOT present")
			[ ] DlgAddEditReminder.CancelButton.Click()
		[+] else
			[ ] ReportStatus("Verify Estimate Amount Change Link under Optional Settings", FAIL , "  Estimate Amount Change Link is NOT present under Optional Settings")
	[+] else
		[ ] ReportStatus("Launch category, tag, memo dialog", FAIL , "Category, tag, memo dialog is NOT launched")
	[ ] 
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC34_MemorizedPayeeWithBill()################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC34_MemorizedPayeeWithBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will If user enters a memorized payee while scheduling a bill reminder, then on second screen of bill reminder, 
		[ ] // all the details of memorized payee should be populated automatically
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If details of memorized payee populates correctly
		[ ] //        					Fail		   If details of memorized payee doesn't populate correctly or error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Mar 13, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC34_MemorizedPayeeWithBill() appstate QuickenBaseState 
	[+] //Variable Declaration and defination
		[ ] sReminderType ="Bill"
		[ ] sPayeeName = "Test"
		[ ] sCategoryName = "Bills & Utilities"
		[ ] sAmount = "5.00"
	[ ] 
	[ ] 
	[ ] // //Launch memorized payee list and add a memorized payee
	[ ] 
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_T)
	[+] if(MemorizedPayeeList.Exists(5))
		[ ] ReportStatus("Memorized Payee List", PASS, "Memorized Payee List dialog is launched")
		[ ] MemorizedPayeeList.NewPayee.Click()
		[+] if(CreateMemorizedPayee.Exists(5))
			[ ] ReportStatus("Create Memorized Payee", PASS, "Create Memorized Payee dialog is launched")
			[ ] CreateMemorizedPayee.CreateMemorizedPayeeTextField.SetText(sPayeeName)
			[ ] CreateMemorizedPayee.TypeOfTransactionPopupList.Select(1)
			[ ] CreateMemorizedPayee.CategoryTextField.SetText(sCategoryName)
			[ ] CreateMemorizedPayee.AmountTextField.SetText(sAmount)
			[ ] CreateMemorizedPayee.OKButton.Click()
			[ ] MemorizedPayeeList.Done.Click()
			[ ] ReportStatus("Create Memorized Payee", PASS, "Memorized Payee is created.")
			[ ] 
			[ ] // Navigate to Bills Tab
			[ ] NavigateQuickenTab(sTAB_BILL)
			[ ] 
			[ ] // Click on add Reminder button and select Reminder										  	 
			[+] if(QuickenMainWindow.QWNavigator.AddReminder.Exists(5))
				[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
				[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(Replicate(KEY_DN, 1)) 
				[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Add Reminder dialog opened																
				[+] if (DlgAddEditReminder.Exists(5))
					[ ] DlgAddEditReminder.SetActive()
					[ ] // Enter Payee name and go to next screen
					[ ] 
					[ ] //DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.SetText(sPayee)
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.TypeKeys(sPayeeName)
					[ ] 
					[ ] 
					[ ] sleep(2)
					[ ] DlgAddEditReminder.TypeKeys(KEY_TAB)
					[ ] sleep(2)											
					[ ] DlgAddEditReminder.NextButton.Click()
					[ ] 
					[ ] ReportStatus("Add a Bill Reminder", PASS, "Add a Bill Reminder dialog screen two is launched")
					[ ] sActual =DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.GetText()
					[ ] // print(sAmount)
					[ ] // print(sActual)
					[ ] 
					[+] if(sActual ==sAmount)
						[ ] 
						[ ] ReportStatus("Verify Amount Match",PASS, "Amount value is matched")
					[+] else
						[ ] ReportStatus("Verify Amount Match",FAIL, "Amount value is NOT matched")
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
					[ ] 
					[ ] //print(sCategoryName)
					[ ] // print(DlgOptionalSetting.CategoryTextField.GetText())
					[ ] 
					[ ] 
					[+] if(DlgOptionalSetting.CategoryTextField.GetText()==sCategoryName)
						[ ] ReportStatus("Verify Category Match",PASS, "Category entry is matched")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Category Match",FAIL, "Category entry is NOT matched")
					[ ] DlgOptionalSetting.CancelButton.Click()
					[ ] 
					[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Verify DlgAddEditReminder",FAIL,"DlgAddEditReminder is not displayed")
			[+] else
				[ ] ReportStatus("Add a Bill Reminder", FAIL, "Add a Bill Reminder dialog screen two is NOT launched")
			[ ] 
		[+] else
			[ ] ReportStatus("Create Memorized Payee", FAIL, "Create Memorized Payee dialog is NOT launched")
	[+] else
		[ ] ReportStatus("Memorized Payee List", FAIL, "Memorized Payee List dialog is NOT launched")
	[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[ ] 
[+] //###############TC65_MemorizedPayeeWithIncome()##############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC65_MemorizedPayeeWithIncome()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will If user enters a memorized payee while scheduling a bill reminder, then on second screen of income reminder, 
		[ ] // all the details of memorized payee should be populated automatically
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If details of memorized payee populates correctly
		[ ] //        					Fail		   If details of memorized payee doesn't populate correctly or error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Mar 14, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC65_MemorizedPayeeWithIncome() appstate QuickenBaseState 
	[+] //Variable Declaration and defination
		[ ] sReminderType ="Income"
		[ ] sPayeeName = "Test 2"
		[ ] sCategoryName = "Other Inc"
		[ ] sAmount = "10.00"
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] //Launch memorized payee list and add a memorized payee
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_T)
	[+] if(MemorizedPayeeList.Exists(5))
		[ ] ReportStatus("Memorized Payee List", PASS, "Memorized Payee List dialog is launched")
		[ ] MemorizedPayeeList.NewPayee.Click()
		[+] if(CreateMemorizedPayee.Exists(5))
			[ ] ReportStatus("Create Memorized Payee", PASS, "Create Memorized Payee dialog is launched")
			[ ] CreateMemorizedPayee.CreateMemorizedPayeeTextField.SetText(sPayeeName)
			[ ] CreateMemorizedPayee.CategoryTextField.SetText(sCategoryName)
			[ ] CreateMemorizedPayee.AmountTextField.SetText(sAmount)
			[ ] CreateMemorizedPayee.OKButton.Click()
			[ ] MemorizedPayeeList.Done.Click()
			[ ] ReportStatus("Create Memorized Payee", PASS, "Memorized Payee is created.")
			[ ] 
			[ ] // Navigate to Bills Tab
			[ ] NavigateQuickenTab(sTAB_BILL)
			[ ] 
			[ ] // Click on add Reminder button and select Reminder										  	 
			[+] if(QuickenMainWindow.QWNavigator.AddReminder.Exists(5))
				[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
				[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(Replicate(KEY_DN,2)) 
				[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Add Reminder dialog opened																
				[+] if (DlgAddEditReminder.Exists(5))
					[ ] DlgAddEditReminder.SetActive()
					[ ] // Enter Payee name and go to next screen
					[ ] 
					[ ] //DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.SetText(sPayee)
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.TypeKeys(sPayeeName)
					[ ] 
					[ ] 
					[ ] sleep(2)
					[ ] DlgAddEditReminder.TypeKeys(KEY_TAB)
					[ ] sleep(2)											
					[ ] DlgAddEditReminder.NextButton.Click()
					[ ] 
					[ ] ReportStatus("Add a Bill Reminder", PASS, "Add a Bill Reminder dialog screen two is launched")
					[ ] sActual =DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.GetText()
					[+] if(sActual ==sAmount)
						[ ] ReportStatus("Verify Amount Match",PASS, "Amount value is matched")
					[+] else
						[ ] ReportStatus("Verify Amount Match",FAIL, "Amount value is NOT matched")
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
					[ ] //AddCategoryTagMemoButton.Click()
					[+] if(DlgOptionalSetting.CategoryTextField.GetText()==sCategoryName)
							[ ] ReportStatus("Verify Category Match",PASS, "Category entry is matched")
					[+] else
						[ ] ReportStatus("Verify Category Match",FAIL, "Category entry is NOT matched")
					[ ] DlgOptionalSetting.CancelButton.Click()
					[ ] DlgAddEditReminder.Close()
				[+] else
					[ ] ReportStatus("Add a Bill Reminder", FAIL, "Add a Bill Reminder dialog screen two is NOT launched")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Click on add Reminder button and select Reminder	", FAIL, "Add Reminder button is not available on Quicken window")
				[ ] 
		[+] else
			[ ] ReportStatus("Create Memorized Payee", FAIL, "Create Memorized Payee dialog is NOT launched")
	[+] else
		[ ] ReportStatus("Memorized Payee List", FAIL, "Memorized Payee List dialog is NOT launched")
[ ] //############################################################################
[ ] 
[ ] 
[+] //###############TC87_MemorizedPayeeWithTransfer()##############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC87_MemorizedPayeeWithTransfer()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will If user enters a memorized payee while scheduling a bill reminder, then on second screen of Transfer reminder, 
		[ ] // all the details of memorized payee should be populated automatically
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If details of memorized payee populates correctly
		[ ] //        					Fail		   If details of memorized payee doesn't populate correctly or error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Mar 14, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC87_MemorizedPayeeWithTransfer() appstate QuickenBaseState 
	[+] //Variable Declaration and defination
		[ ] STRING sMemo
		[ ] sMemo = "Test Memo"
		[ ] sReminderType ="Transfer"
		[ ] sPayeeName = "Test 3"
		[ ] sCategoryName = "Auto & Transport:Gas & Fuel"
		[ ] sAmount = "12.55"
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_T)
	[+] if(MemorizedPayeeList.Exists(5))
		[ ] ReportStatus("Memorized Payee List", PASS, "Memorized Payee List dialog is launched")
		[ ] MemorizedPayeeList.NewPayee.Click()
		[+] if(CreateMemorizedPayee.Exists(5))
			[ ] ReportStatus("Create Memorized Payee", PASS, "Create Memorized Payee dialog is launched")
			[ ] CreateMemorizedPayee.CreateMemorizedPayeeTextField.SetText(sPayeeName)
			[ ] CreateMemorizedPayee.TypeOfTransactionPopupList.Select(1)
			[ ] CreateMemorizedPayee.CategoryTextField.SetText(sCategoryName)
			[ ] CreateMemorizedPayee.MemoTextField.SetText(sMemo)
			[ ] CreateMemorizedPayee.AmountTextField.SetText(sAmount)
			[ ] CreateMemorizedPayee.OKButton.Click()
			[ ] MemorizedPayeeList.Done.Click()
			[ ] ReportStatus("Create Memorized Payee", PASS, "Memorized Payee is created.")
			[ ] 
			[ ] 
			[ ] 
			[ ] // Navigate to Bills Tab
			[ ] NavigateQuickenTab(sTAB_BILL)
			[ ] 
			[ ] // Click on add Reminder button and select Reminder										  	 
			[+] if(QuickenMainWindow.QWNavigator.AddReminder.Exists(5))
				[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
				[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(Replicate(KEY_DN,3)) 
				[ ] QuickenMainWindow.QWNavigator.AddReminder.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] // Add Reminder dialog opened																
				[+] if (DlgAddEditReminder.Exists(5))
					[ ] DlgAddEditReminder.SetActive()
					[ ] // Enter Payee name and go to next screen
					[ ] 
					[ ] //DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.SetText(sPayee)
					[ ] DlgAddEditReminder.Step1Panel.HomeChildPanel.PayeeNameTextField.TypeKeys(sPayeeName)
					[ ] 
					[ ] 
					[ ] sleep(2)
					[ ] DlgAddEditReminder.TypeKeys(KEY_TAB)
					[ ] sleep(2)											
					[ ] DlgAddEditReminder.NextButton.Click()
					[ ] 
					[ ] 
					[ ] 
					[ ] ReportStatus("Add a Bill Reminder", PASS, "Add a Bill Reminder dialog screen two is launched")
					[ ] sActual =DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.GetText()
					[+] if(sActual ==sAmount)
						[ ] ReportStatus("Verify Amount Match",PASS, "Amount value is matched")
					[+] else
						[ ] ReportStatus("Verify Amount Match",FAIL, "Amount value is NOT matched")
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.ButtonAfterReminderAdded.Click()
					[+] if(DlgOptionalSetting.MemoTextField.GetText()==sMemo)
							[ ] ReportStatus("Verify Memo Match",PASS, "Memo entry is matched")
					[+] else
						[ ] ReportStatus("Verify Memo Match",FAIL, "Memo entry is NOT matched, Actual category")
					[ ] 
					[ ] DlgOptionalSetting.CancelButton.Click()
					[ ] 
					[ ] DlgAddEditReminder.Close()
			[+] else
				[ ] ReportStatus("Add a Bill Reminder", FAIL, "Add a Bill Reminder dialog screen two is NOT launched")
		[+] else
			[ ] ReportStatus("Create Memorized Payee", FAIL, "Create Memorized Payee dialog is NOT launched")
	[+] else
		[ ] ReportStatus("Memorized Payee List", FAIL, "Memorized Payee List dialog is NOT launched")
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC30_BillFunctionalityDoneButton()###############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC30_BillFunctionalityDoneButton()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // 
		[ ] // This test case will Verify functionality of Done button on "Add Bill Reminder" dialog
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If functionality of Cancel button is correct
		[ ] //        Fail		   If functionality of Cancel button is not working correctly
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  Feb 20, 2013		Anagha Bhandare created
	[ ] // **************************************************************************************
[+] testcase TC30_BillFunctionalityDoneButton()appstate QuickenBaseState 
	[+] //Variable Declaration and defination
		[ ] INTEGER iSetupAutoAPI 
		[ ] STRING sAmount,sAmountCompare
		[ ] List of ANYTYPE  lsReminderList
		[ ] 
		[ ] sAmount="500.00"
		[ ] sReminderType = "Bill"
		[ ] sPayeeName="DoneButtonPayee"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenMainWindow.VerifyEnabled(TRUE,20)
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] //Navigation to Bills > Add Bill > Enter payee > Click Next
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[ ] 
		[+] if(iValidate==PASS)
			[ ] //Set the Amount 
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sAmount)
			[ ] 
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[+] if(MDIClient.Bills.Exists(5))//Select List view 
				[ ] ReportStatus("Verify Bills tab window ", PASS, "Bills tab Window is present")
				[ ] MDIClient.Bills.ViewAsPopupList.Select("#2")
				[ ] //MDIClient.Bills.ViewAsPopupList.TypeKeys(KEY_ENTER)
				[ ] 
				[ ] //Retrieve the data from the 2nd Row
				[ ] sHandle = Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(0))
				[ ] bMatch = MatchStr("*{sPayeeName}*",sActual)
				[ ] 
				[ ] //verify whether it is present in the List
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify Validate Reminder in List view", PASS, "{sPayeeName}  is available in Bill Reminder in List view")
					[ ] 
					[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
					[+] if(iValidate==PASS)
						[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
					[+] else
						[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Validate Reminder in List view", FAIL, "{sPayeeName}  is not available in Bill Reminder in List view")
			[+] else
				[ ] ReportStatus("Verify Bills tab window ", PASS, "Bill tab Window is not present")
		[ ] 
		[+] else 
			[ ] ReportStatus("Navigate to {sReminderType} Details Page",FAIL,"Navigation to {sReminderType} Details page failed")
		[ ] 
	[+] else
			[ ] ReportStatus("Quicken Window", FAIL , "Quicken Window is closed")
	[ ] 
[ ] //###########################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[+] //###############TCSetup_ReminderFrequencyDataFile()###################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TCSetup_ReminderFrequencyDataFile()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will setup the data file required for frequency test cases with a checking, savings and credit card account.
		[ ] //
		[ ] // RETURNS:			Pass 	   If setup is completed successfully
		[ ] //				        	Fail		   If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TCSetup_ReminderFrequencyDataFile() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] // Create Data File
	[ ] iValidate = DataFileCreate(sFileName)
	[ ] // Report Staus If Data file Created successfully
	[+] if ( iValidate  == PASS)
		[ ] ReportStatus("Validate Data File ", iValidate, "Data file -  {sDataFile} is created")
		[ ] 
		[ ] 
		[ ] //Add a manual checking account.
		[ ] iValidate=AddManualSpendingAccount(IsAddAccount[1],IsAddAccount[2],IsAddAccount[3],IsAddAccount[4])
		[+] if(iValidate == PASS)
			[ ] ReportStatus("Add Checking Account", PASS, "Checking account is added.")
			[ ] 
			[ ] //Add a manual Savings account.
			[ ] iValidate=AddManualSpendingAccount(IsAddAccount1[1],IsAddAccount1[2],IsAddAccount1[3],IsAddAccount1[4])
			[+] if(iValidate == PASS)
				[ ] ReportStatus("Add Savings Accountt", PASS, "Savings account is added.")
				[ ] 
				[ ] //Add a manual credit card account.
				[ ] iValidate=AddManualSpendingAccount(IsAddAccount2[1],IsAddAccount2[2],IsAddAccount2[3],IsAddAccount2[4])
				[+] if(iValidate == PASS)
					[ ] ReportStatus("Add Credit Card Account", PASS, "Credit Card account is added.")
				[+] else
					[ ] ReportStatus("Add Credit Card Account", FAIL, "Credit card account is NOT added.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Add Savings Account", FAIL, "Savings account is NOT added.")
		[+] else
			[ ] ReportStatus("Add Checking Account", FAIL, "Checking account is NOT added.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", iValidate, "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC110_ScheduleMonthlyBill()######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC110_ScheduleMonthlyBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a monthly bill reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If monthly bill reminder is scheduled.
		[ ] //				       	Fail		If monthly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 18, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC110_ScheduleMonthlyBill() appstate none
	[ ] 
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "5.75"
		[ ] sHowOften = "Monthly"
		[ ] sTransactionType = "Payment"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sTransactionType,sHowOften}
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and how often
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
	[ ] 
	[ ] // //Delete Bill Reminder
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Bill Reminder", PASS, "Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC111_ScheduleEveryXMonthBill()###################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC111_ScheduleEveryXMonthBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a 'X' monthly bill reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	   If every 'X' monthly bill reminder is scheduled.
		[ ] //				       	Fail		   If every 'X' monthly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 18, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC111_ScheduleEveryXMonthBill() appstate none
	[ ] 
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sFrequency,sDaysOption
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "6.28"
		[ ] sFrequency = "2"
		[ ] sHowOften = "Every 2 Months"
		[ ] sTransactionType = "Payment"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sTransactionType,sHowOften}
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] // 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] //DlgOptionalSetting.EveryTwoWeekTextField.SetText(sFrequency)
			[ ] DlgOptionalSetting.EveryWeekTextField.SetText(sFrequency)
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] //Delete Bill Reminder
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Single Reminder not deleted")
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC112_ScheduleXthDayOfMonthBill()################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC112_ScheduleXthDayOfMonthBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a monthly bill reminder for 'X' th day of the Month .
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If every 'X' th day of the Month, bill reminder is scheduled.
		[ ] //				       	Fail		If every 'X' th day of the Month, bill reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 25, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC112_ScheduleXthDayOfMonthBill() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften,sDay,sMonth,sYear,sCompareDate
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] INTEGER iValidateDate,iMonth
		[ ] 
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "5.75"
		[ ] sHowOften = "Monthly"
		[ ] 
		[ ] 
		[ ] //Get date for Bill
		[ ] sDay=FormatDateTime(GetDateTime(), "d")
		[ ] iValidateDate=val(sDay)+1
		[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] sCompareDate=sMonth +"/"+"{iValidateDate}"+"/"+sYear
		[ ] 
		[ ] 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate}
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.MonthOnThePopupList.Select(iValidateDate)
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] //Delete Bill Reminder
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Single Reminder not deleted")
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC113_DayDropdownContentBill()##################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC113_DayDropdownContentBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify content of the 'Day' drop down box for bill reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If day drop down box contains {"Day","QCombo_Separator", "Sunday","Monday", "Tuesday", "Wednesday","Thursday","Friday", "Saturday"}
		[ ] //				       	Fail		If day dropdown box doesn't contain {"Day","QCombo_Separator", "Sunday","Monday", "Tuesday", "Wednesday","Thursday","Friday", "Saturday"} or if error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 26, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC113_DayDropdownContentBill() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification, lsDaysActual, lsDaysExpected
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "9.15"
		[ ] sDayOfMonth = "/05/20"
		[ ] sHowOften = "Every 2 Months"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sDayOfMonth}
		[ ] lsDaysExpected = {"Day","QCombo_Separator", "Sunday","Monday", "Tuesday", "Wednesday","Thursday","Friday", "Saturday"}
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] 
			[ ] //print(DlgOptionalSetting.MonthOnThePopupList.GetContents())
			[ ] 
			[ ] //DlgOptionalSetting.MonthOnThePopupList.Select("last")
			[ ] DlgOptionalSetting.MonthOnThePopupList.SetText("last")
			[ ] 
			[ ] lsDaysActual= DlgOptionalSetting.DayPopupList.GetContents()
			[+] if (lsDaysExpected == lsDaysActual)
				[ ] ReportStatus("Verify Day dropdown content", PASS, " Day drop down box content is verified")
			[+] else
				[ ] ReportStatus("Verify Day dropdown content", FAIL, " Day drop down box content is different. day dropdown contains = {lsDaysActual[i]}")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.CancelButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC114_ScheduleMonthlyBillForLastDayOfTheMonth()###############
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC114_ScheduleMonthlyBillForLastDayOfTheMonth()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a bill reminder for last day of the month
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If  bill reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC114_ScheduleMonthlyBillForLastDayOfTheMonth() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING  sHowOften,sCompareDate
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "6.55"
		[ ] sHowOften = "Monthly"
		[ ] sCompareDate=LastDateOfTheMonth()
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add a Bill Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] 
			[ ] //DlgOptionalSetting.MonthOnThePopupList.Select("Last")
			[ ] 
			[ ] DlgOptionalSetting.MonthOnThePopupList.SetText("Last")
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
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
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] //Delete Bill Reminder
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC115_ScheduleMonthlyBillForLastXXXDayOfTheMonth()###############
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC115_ScheduleMonthlyBillForLastXXXDayOfTheMonth()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a monthly bill for a certain day of the month
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If  bill reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC115_ScheduleMonthlyBillForLastXXXDayOfTheMonth() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING  sHowOften, sCompareDate,sMonth,sYear,sSelectDate,sSelectDay
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "6.55"
		[ ] sHowOften = "Monthly"
		[ ] 
		[ ] sSelectDate="last"
		[ ] sSelectDay="Fri"
		[ ] sCompareDate=LastFridayOfTheCurrentMonth()
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate} 
		[ ] 
		[ ] 
	[ ] 
	[ ] //Add a Bill Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.MonthOnThePopupList.TypeKeys(sSelectDate)
			[ ] DlgOptionalSetting.DayPopupList.TypeKeys(sSelectDay)
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
		[ ] sleep(2)
		[ ] 
		[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
		[+] if (DlgManageReminders.Exists(5))
			[ ] DlgManageReminders.AllBillsDepositsTab.Click()
			[ ] 
			[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
			[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
			[ ] 
			[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr("*{lsBillVerification[3]}*",sActual)
				[+] if (bMatch)
					[+] for(i=1; i<= Listcount(lsBillVerification); i++)
						[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
						[+] if(bResult==TRUE)
							[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
						[+] else
							[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
					[ ] break
			[+] if(bMatch == FALSE)
				[ ] ReportStatus("Verify Reminder in List view", FAIL, "Reminder {lsBillVerification}  is not available in Reminder in List view")
			[ ] 
			[ ] DlgManageReminders.Close()
			[ ] 
			[ ] 
			[ ] 
			[ ] //Delete Bill Reminder
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC116_ScheduleWeeklyBill()######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC116_ScheduleWeeklyBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a weekly bill reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weekly bill reminder is scheduled.
		[ ] //				       	Fail		      If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   March 28, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC116_ScheduleWeeklyBill() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Weekly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#1")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC117_ScheduleWeeklyBillForCertainWeeks()#########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC117_ScheduleWeeklyBillForCertainWeeks()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a weekly bill reminder for a certain every "X" 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weekly bill reminder is scheduled.
		[ ] //				       	Fail		If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 3, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC117_ScheduleWeeklyBillForCertainWeeks() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sEveryXWeeks,sWeeklyDurationText
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "4.60"
		[ ] sHowOften = "Weekly"
		[ ] 
		[ ] sEveryXWeeks="5"
		[ ] sWeeklyDurationText="Every 5 weeks"
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sWeeklyDurationText} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Add a Bill Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#1")
			[ ] DlgOptionalSetting.DaysInAdvanceTextField.SetText(sEveryXWeeks)
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] //Delete Bill Reminder
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC118_ScheduleWeeklyBillForCertainDayOfTheWeek()#################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC118_ScheduleWeeklyBillForCertainDayOfTheWeek()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a weekly bill reminder for a particular day of the week.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weekly bill reminder is scheduled.
		[ ] //				       	Fail		     If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 3, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC118_ScheduleWeeklyBillForCertainDayOfTheWeek() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING sToday,sDay,sMonth,sYear,sCompareDate
		[ ] INTEGER iDifference,iFridayOfTheWeek
		[ ] DATETIME dtDateTime
		[ ] 
		[ ] 
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "6.55"
		[ ] sHowOften = "Weekly"
		[ ] 
		[ ] 
		[ ] 
		[ ] // //Verify Day on which bill gets added
		[ ] // dtDateTime= GetDateTime ()
		[ ] // sDay = FormatDateTime(GetDateTime(), "w")  // display day of the week as a number between 1-7
		[ ] // sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] // sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] // 
		[ ] // iDifference = 6 - Val(sDay)
		[ ] // sToday = FormatDateTime(GetDateTime(),"d")//Get current day
		[ ] // iFridayOfTheWeek = Val(sToday) + iDifference
		[ ] // 
		[ ] // sCompareDate=sMonth +"/"+"{iFridayOfTheWeek}"+"/"+sYear
		[ ] 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] // print(lsBillVerification)
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add a Bill Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#1")
			[ ] DlgOptionalSetting.WeeksOnPopupList.Select("#6")
			[ ] 
			[ ] //Get Date for Bill 
			[ ] ListAppend(lsBillVerification,DlgOptionalSetting.StartDateTextField.GetText())
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] // 
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] //Delete Bill Reminder
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC119_ScheduleBiWeeklyBill()######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC119_ScheduleBiWeeklyBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a bi weekly bill reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If bi weekly bill reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC119_ScheduleBiWeeklyBill() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Every 2 Weeks"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#2")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC120_ScheduleBiWeeklyBillForCertainDayOfTheWeek()###############
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC120_ScheduleBiWeeklyBillForCertainDayOfTheWeek()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a bi weekly bill reminder for a particular day of the week.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weekly bill reminder is scheduled.
		[ ] //				       	Fail		     If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 4, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC120_ScheduleBiWeeklyBillForCertainDayOfTheWeek() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING sToday,sDay,sMonth,sYear,sCompareDate
		[ ] INTEGER iDifference,iFridayOfTheWeek
		[ ] DATETIME dtDateTime
		[ ] 
		[ ] 
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "6.55"
		[ ] sHowOften = "Every 2 Weeks"
		[ ] 
		[ ] 
		[ ] 
		[ ] // //Verify Day on which bill gets added
		[ ] // dtDateTime= GetDateTime ()
		[ ] // sDay = FormatDateTime(GetDateTime(), "w")  // display day of the week as a number between 1-7
		[ ] // sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] // sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] // 
		[ ] // iDifference = 6 - Val(sDay)
		[ ] // sToday = FormatDateTime(GetDateTime(),"d")//Get current day
		[ ] // iFridayOfTheWeek = Val(sToday) + iDifference
		[ ] // 
		[ ] // sCompareDate=sMonth +"/"+"{iFridayOfTheWeek}"+"/"+sYear
		[ ] // 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add a Bill Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#2")
			[ ] DlgOptionalSetting.EveryTwoWeeksOnPopupList.Select("#6")
			[ ] 
			[ ] //Get Date for Bill 
			[ ] ListAppend(lsBillVerification,DlgOptionalSetting.StartDateTextField.GetText())
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] //Delete Bill Reminder
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC121_ScheduleTwiceAMonthBill()#################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC121_ScheduleTwiceAMonthBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a  bill reminder twice a month..
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If bi weekly bill reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC121_ScheduleTwiceAMonthBill() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Twice a month"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#4")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC122_ScheduleTwiceAMonthBill()#################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC122_ScheduleTwiceAMonthBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a  bill reminder twice a month on two particular days.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If bi weekly bill reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC122_ScheduleTwiceAMonthBillB() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sCompareDate1,sCompareDate2,sMonth,sYear,sDay1,sDay2
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification1,lsBillVerification2
		[ ] INTEGER iDay1,iDay2,iMonth,iListCount ,iCount
		[ ] DATETIME dtDateTime
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Twice a month"
		[ ] 
		[ ] iDay1=5
		[ ] iDay2=19
		[ ] 
		[ ] dtDateTime= GetDateTime ()
		[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] iMonth=val(sMonth)+1
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] 
		[ ] sCompareDate1="{iMonth}" +"/"+"{iDay1}"+"/"+sYear
		[ ] sCompareDate2="{iMonth}" +"/"+"{iDay2}"+"/"+sYear
		[ ] 
		[ ] lsBillVerification1 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate1} 
		[ ] lsBillVerification2 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate2} 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Bill Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#4")
			[ ] DlgOptionalSetting.TwiceAMonthOnPopupList.Select(iDay1)
			[ ] DlgOptionalSetting.TwiceAMonthAndPopupList.Select(iDay2)
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] iValidate=NavigateQuickenTab(sTAB_BILL)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Navigate to Bills Tab",PASS,"Bills tab opened")
		[ ] 
		[ ] //Select List from View options
		[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
		[ ] 
		[ ] 
		[ ] //Select 90 days from duration dropdown
		[ ] MDIClient.Bills.DueWithinNextPopupList.Select(4)
		[ ] 
		[ ] //Get Handle of list
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] iListCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
		[ ] 
		[ ] //Verify Invoice Reminder for 1st date
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bResult = MatchStr("*{lsBillVerification1[4]}*",sActual)
			[+] if (bResult)
				[ ] 
				[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
				[+] for(i=1; i<= Listcount(lsBillVerification1); i++)
					[ ] bResult = MatchStr("*{lsBillVerification1[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification1[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification1[i]} is NOT added, sActual = {sActual}")
				[ ] 
				[ ] 
				[ ] break
				[ ] 
				[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] //Veirfy Invoice Reminder for 2nd date
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bResult = MatchStr("*{lsBillVerification2[4]}*",sActual)
			[+] if (bResult)
				[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
				[+] for(i=1; i<= Listcount(lsBillVerification2); i++)
					[ ] bResult = MatchStr("*{lsBillVerification2[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification2[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification2[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to Bills Tab",FAIL,"Bills tab not opened")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC123_ScheduleQuarterlyBill()######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC123_ScheduleQuarterlyBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a quaterly bill reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If quaterly bill reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC123_ScheduleQuarterlyBill() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "8.50"
		[ ] sHowOften = "Quarterly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] // 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#5")
			[ ] //DlgOptionalSetting.HowOftenPopupList.Select(sHowOften)
			[ ] //DlgOptionalSetting.HowOftenPopupList.SetText(sHowOften)
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC124_ScheduleYearlyBill()#######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC124_ScheduleYearlyBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a yearly bill reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If yearly bill reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC124_ScheduleYearlyBill() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "3.25"
		[ ] sHowOften = "Yearly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] // 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#6")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC125_ScheduleTwiceAYearBill()###################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC125_ScheduleTwiceAYearBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a bill reminder for twice a year.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If yearly bill reminder is scheduled twice a year.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC125_ScheduleTwiceAYearBill() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "12.25"
		[ ] sHowOften = "Twice a year"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#7")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC126_ScheduleBillTwiceAYearForTwoParticularDays()#################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC126_ScheduleBillTwiceAYearForTwoParticularDays()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a bill reminder for twice a year for two particular dates.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If yearly bill reminder is scheduled twice a year for two particular dates.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC126_ScheduleBillTwiceAYearForTwoParticularDays() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sCompareDate1,sCompareDate2
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification1,lsBillVerification2
		[ ] 
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "9.12"
		[ ] sHowOften = "Twice a year"
		[ ] 
		[ ] sCompareDate1=ModifyDate(2,"m/d/yyyy")
		[ ] sCompareDate2=ModifyDate(200,"m/d/yyyy")
		[ ] 
		[ ] lsBillVerification1 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate1} 
		[ ] lsBillVerification2 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate2} 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] // 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#7")
			[ ] DlgOptionalSetting.TwiceAYearOnTextField.SetText(sCompareDate1)
			[ ] DlgOptionalSetting.TwiceAYearAndTextField.SetText(sCompareDate2)
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] NavigateQuickenTab(sTAB_BILL)
	[+] if (MDIClient.Bills.Exists(5))
		[ ] 
		[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
		[ ] MDIClient.Bills.DueWithinNextPopupList.Select(5)
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] 
		[ ] 
		[ ] //Veirfy Bill Reminder for 1st date
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification1); i++)
			[ ] bResult = MatchStr("*{lsBillVerification1[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification1[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification1[i]} is NOT added, sActual = {sActual}")
		[ ] 
		[ ] 
		[ ] //Veirfy Bill Reminder for 2nd date
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(1))
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification2); i++)
			[ ] bResult = MatchStr("*{lsBillVerification2[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification2[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification2[i]} is NOT added, sActual = {sActual}")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill window is NOT open")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC127_ScheduleOnlyOnceBill()####################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC127_ScheduleOnlyOnceBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule an only once bill reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If bill reminder is scheduled for only once.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC127_ScheduleOnlyOnceBill() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "7.22"
		[ ] sHowOften = "Only Once"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#8")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] // //Delete Bills
	[ ] // NavigateQuickenTab(sTAB_BILL)
	[ ] // 
	[ ] // Bills.Panel.Panel1.QWinChild1.Edit.Click()
	[+] // if(DlgAddEditReminder.Exists(2))
		[ ] // ReportStatus("Navigate to Edit Bill Reminder dialog", PASS, " Edit Bill Reminder dialog is displayed")
		[ ] // 
		[ ] // DlgAddEditReminder.DeleteButton.Click()
		[+] // if(MessageBox.Exists(5))
			[ ] // MessageBox.OK1.Click()
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Delete Reminder", FAIL, " Delete Reminder confirmation dialog is not displayed")
			[ ] // 
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Navigate to Edit Bill Reminder dialog", FAIL, " Edit Bill Reminder dialog is not displayed")
		[ ] // 
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC129_VerifyEndOnOptionBillReminder()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC129_VerifyEndOnOptionBillReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality of  'End On' option for a bill reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If correct number of reminders are scheduled.
		[ ] //				       	Fail		      If any error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April  5, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC129_VerifyEndOnOptionBillReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sEndDate
		[ ] INTEGER iExpectedNumberOfReminders,iActualNumberOfReminders
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Monthly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] iExpectedNumberOfReminders=4
		[ ] 
		[ ] sEndDate=ModifyDate(100,"m/d/yyyy")
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#3")
			[ ] DlgOptionalSetting.EndDatePopupList.Select(2)
			[ ] DlgOptionalSetting.EndOnTextField.SetText(sEndDate)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify that correct number of Bill reminders are added
	[ ] //Select 12 Months from Due Within Next PopupList
	[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
	[ ] MDIClient.Bills.DueWithinNextPopupList.Select(5)
	[ ] iActualNumberOfReminders=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
	[+] if(iActualNumberOfReminders==iExpectedNumberOfReminders)
		[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Correct number of Bill Reminders added: {iExpectedNumberOfReminders}")
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Wrong number of Bill Reminders added: {iActualNumberOfReminders}")
	[ ] 
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] // //Delete Bills
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //##############################################################################
[ ] 
[+] //###############TC130_VerifyEndAfterOptionBillReminder()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC130_VerifyEndAfterOptionBillReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality of  'End after' option for a bill reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If correct number of reminders are scheduled.
		[ ] //				       	Fail		      If any error occurs..
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April  5, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC130_VerifyEndAfterOptionBillReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sEndAfter
		[ ] INTEGER iExpectedNumberOfReminders,iActualNumberOfReminders
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "7.22"
		[ ] sHowOften = "Monthly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] iExpectedNumberOfReminders=3
		[ ] 
		[ ] sEndAfter="3"
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#3")
			[ ] DlgOptionalSetting.EndDatePopupList.Select(3)
			[ ] DlgOptionalSetting.EndAfterTextField.SetText(sEndAfter)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify that correct number of Bill reminders are added
	[ ] //Select 12 Months from Due Within Next PopupList
	[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
	[ ] MDIClient.Bills.DueWithinNextPopupList.Select(5)
	[ ] iActualNumberOfReminders=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
	[+] if(iActualNumberOfReminders==iExpectedNumberOfReminders)
		[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Correct number of Bill Reminders added: {iExpectedNumberOfReminders}")
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Wrong number of Bill Reminders added: {iActualNumberOfReminders}")
	[ ] 
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] // //Delete Bills
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //##############################################################################
[ ] 
[+] //###############TC131_ScheduleMonthlyIncome()####################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC131_ScheduleMonthlyIncome()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify id user is able to schedule a monthly income reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If monthly income reminder is scheduled.
		[ ] //				       	Fail		If monthly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 21, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC131_ScheduleMonthlyIncome() appstate none
	[ ] 
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "5.75"
		[ ] sHowOften = "Monthly"
		[ ] sTransactionType = "Deposit"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sTransactionType,sHowOften}
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and how often
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
	[ ] 
	[ ] //Delete Income Reminder
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //###############TC132_ScheduleEveryXMonthIncome()################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC132_ScheduleEveryXMonthIncome()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a 'X' monthly income reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If every 'X' monthly income reminder is scheduled.
		[ ] //				       	Fail		If every 'X' monthly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 21, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC132_ScheduleEveryXMonthIncome() appstate none
	[ ] 
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sFrequency
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "5.75"
		[ ] sFrequency = "2"
		[ ] sHowOften = "Every 2 Months"
		[ ] sTransactionType= "Deposit"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sTransactionType, sHowOften}
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] // 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] //DlgOptionalSetting.EveryTwoWeekTextField.SetText(sFrequency)
			[ ] DlgOptionalSetting.EveryWeekTextField.SetText(sFrequency)
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] //Verify if monthly Income gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different Income parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Online Income Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Delete Income Reminder
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[+] //###############TC133_ScheduleXthDayOfMonthIncome()##############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC133_ScheduleXthDayOfMonthIncome()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a monthly income  reminder for 'X' th day of the Month.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If every 'X' th day of the Month, income reminder is scheduled.
		[ ] //				       	Fail		If every 'X' th day of the Month, income reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 25, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC133_ScheduleXthDayOfMonthIncome() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften,sDay,sMonth,sYear,sCompareDate
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] INTEGER iValidateDate,iMonth
		[ ] 
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "5.75"
		[ ] sHowOften = "Monthly"
		[ ] 
		[ ] 
		[ ] //Get date for Bill
		[ ] sDay=FormatDateTime(GetDateTime(), "d")
		[ ] iValidateDate=val(sDay)+1
		[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] sCompareDate=sMonth +"/"+"{iValidateDate}"+"/"+sYear
		[ ] 
		[ ] 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate}
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] // 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.MonthOnThePopupList.Select(iValidateDate)
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify if monthly Income gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different Income parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] //Delete Income Reminder
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[ ] 
[+] //###############TC134_DayDropdownContentIncome()#################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC113_DayDropdownContentBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify content of the 'Day' drop down box for Income Reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If day drop down box contains {"Day","QCombo_Separator", "Sunday","Monday", "Tuesday", "Wednesday","Thursday","Friday", "Saturday"}
		[ ] //				       	Fail		If day dropdown box doesn't contain {"Day","QCombo_Separator", "Sunday","Monday", "Tuesday", "Wednesday","Thursday","Friday", "Saturday"} or if error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 26, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC134_DayDropdownContentIncome() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification, lsDaysActual, lsDaysExpected
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "9.15"
		[ ] sDayOfMonth = "/05/20"
		[ ] sHowOften = "Every 2 Months"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sDayOfMonth}
		[ ] lsDaysExpected = {"Day","QCombo_Separator", "Sunday","Monday", "Tuesday", "Wednesday","Thursday","Friday", "Saturday"}
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] 
			[ ] //print(DlgOptionalSetting.MonthOnThePopupList.GetContents())
			[ ] 
			[ ] //DlgOptionalSetting.MonthOnThePopupList.Select("last")
			[ ] DlgOptionalSetting.MonthOnThePopupList.SetText("last")
			[ ] 
			[ ] lsDaysActual= DlgOptionalSetting.DayPopupList.GetContents()
			[+] if (lsDaysExpected == lsDaysActual)
				[ ] ReportStatus("Verify Day dropdown content", PASS, " Day drop down box content is verified")
			[+] else
				[ ] ReportStatus("Verify Day dropdown content", FAIL, " Day drop down box content is different. day dropdown contains = {lsDaysActual[i]}")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.CancelButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[ ] 
[+] //###############TC135_ScheduleMonthlyIncomeReminderForLastDayOfTheMonth()#########
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC135_ScheduleMonthlyIncomeReminderForLastDayOfTheMonth()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a income reminder for last day of the month
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If  income reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC135_ScheduleMonthlyIncomeReminderForLastDayOfTheMonth() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING  sHowOften,sCompareDate
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "6.55"
		[ ] sHowOften = "Monthly"
		[ ] sCompareDate=LastDateOfTheMonth()
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add an Income Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] 
			[ ] //DlgOptionalSetting.MonthOnThePopupList.Select("Last")
			[ ] 
			[ ] DlgOptionalSetting.MonthOnThePopupList.SetText("Last")
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] //Delete Income Reminder
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC136_ScheduleMonthlyIncomeForLastXXXDayOfTheMonth()###############
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC136_ScheduleMonthlyIncomeForLastXXXDayOfTheMonth()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a monthly income for last XXX day of the month
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If  income reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC136_ScheduleMonthlyIncomeForLastXXXDayOfTheMonth() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING  sHowOften, sCompareDate,sMonth,sYear,sSelectDate,sSelectDay
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] INTEGER iMonth
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "6.55"
		[ ] sHowOften = "Monthly"
		[ ] 
		[ ] sSelectDate="last"
		[ ] sSelectDay="Fri"
		[ ] sCompareDate=LastFridayOfTheCurrentMonth()
		[ ] 
		[ ] 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add an Income Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.MonthOnThePopupList.TypeKeys(sSelectDate)
			[ ] DlgOptionalSetting.DayPopupList.TypeKeys(sSelectDay)
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] //Delete Income Reminder
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC137_ScheduleWeeklyIncomeReminder()###############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC137_ScheduleWeeklyIncomeReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a weekly Income reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weekly Income reminder is scheduled.
		[ ] //				       	Fail		      If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   March 28, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC137_ScheduleWeeklyIncomeReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Weekly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] // if( iValidate==PASS)
		[ ] // ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] //  
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] // if(DlgOptionalSetting.Exists(5))
			[ ] // ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] // Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] // DlgOptionalSetting.HowOftenPopupList.Select("#1")
			[ ] // DlgOptionalSetting.OKButton.Click()
		[+] // else
			[ ] // ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] // DlgAddEditReminder.DoneButton.Click()
	[+] // else
		[ ] // ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] // DlgAddEditReminder.Close()
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#1")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[+] //###############TC138_ScheduleWeeklyIncomeReminderForCertainWeeks()#################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC138_ScheduleWeeklyIncomeReminderForCertainWeeks()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a weekly Income reminder for a certain every "X" 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weekly Income reminder is scheduled.
		[ ] //				       	Fail		If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 3, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC138_ScheduleWeeklyIncomeReminderForCertainWeeks() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sEveryXWeeks,sWeeklyDurationText
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "4.60"
		[ ] sHowOften = "Weekly"
		[ ] 
		[ ] sEveryXWeeks="5"
		[ ] sWeeklyDurationText="Every 5 weeks"
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sWeeklyDurationText} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Add a Income Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#1")
			[ ] DlgOptionalSetting.DaysInAdvanceTextField.SetText(sEveryXWeeks)
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] //Delete Income Reminder
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[ ] 
[+] //###############TC139_ScheduleWeeklyIncomeReminderForCertainDayOfTheWeek()#########
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC139_ScheduleWeeklyIncomeReminderForCertainDayOfTheWeek()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a weekly Income reminder for a particular day of the week.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weekly Income reminder is scheduled.
		[ ] //				       	Fail		     If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 3, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC139_ScheduleWeeklyIncomeReminderForCertainDayOfTheWeek() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING sToday,sDay,sMonth,sYear,sCompareDate
		[ ] INTEGER iDifference,iFridayOfTheWeek
		[ ] DATETIME dtDateTime
		[ ] 
		[ ] 
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "6.55"
		[ ] sHowOften = "Weekly"
		[ ] 
		[ ] 
		[ ] 
		[ ] // //Verify Day on which Income gets added
		[ ] // dtDateTime= GetDateTime ()
		[ ] // sDay = FormatDateTime(GetDateTime(), "w")  // display day of the week as a number between 1-7
		[ ] // sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] // sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] // 
		[ ] // iDifference = 6 - Val(sDay)
		[ ] // sToday = FormatDateTime(GetDateTime(),"d")//Get current day
		[ ] // iFridayOfTheWeek = Val(sToday) + iDifference
		[ ] // 
		[ ] // sCompareDate=sMonth +"/"+"{iFridayOfTheWeek}"+"/"+sYear
		[ ] 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add a Income Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#1")
			[ ] DlgOptionalSetting.WeeksOnPopupList.Select("#6")
			[ ] 
			[ ] //Get Date for Bill 
			[ ] ListAppend(lsBillVerification,DlgOptionalSetting.StartDateTextField.GetText())
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] //Delete Income Reminder
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC140_ScheduleBiWeeklyIncomeReminder()############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC140_ScheduleBiWeeklyIncomeReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a bi weekly Income reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If bi weekly Income reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC140_ScheduleBiWeeklyIncomeReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Every 2 Weeks"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#2")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC141_ScheduleBiWeeklyIncomeReminderForCertainDayOfTheWeek()######
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC141_ScheduleBiWeeklyIncomeReminderForCertainDayOfTheWeek()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a bi weekly Income reminder for a particular day of the week.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weekly Income reminder is scheduled.
		[ ] //				       	Fail		     If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 4, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC141_ScheduleBiWeeklyIncomeReminderForCertainDayOfTheWeek() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING sToday,sDay,sMonth,sYear,sCompareDate
		[ ] INTEGER iDifference,iFridayOfTheWeek
		[ ] DATETIME dtDateTime
		[ ] 
		[ ] 
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "6.55"
		[ ] sHowOften = "Every 2 Weeks"
		[ ] 
		[ ] 
		[ ] 
		[ ] // //Verify Day on which Income gets added
		[ ] // dtDateTime= GetDateTime ()
		[ ] // sDay = FormatDateTime(GetDateTime(), "w")  // display day of the week as a number between 1-7
		[ ] // sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] // sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] // 
		[ ] // iDifference = 6 - Val(sDay)
		[ ] // sToday = FormatDateTime(GetDateTime(),"d")//Get current day
		[ ] // iFridayOfTheWeek = Val(sToday) + iDifference
		[ ] // 
		[ ] // sCompareDate=sMonth +"/"+"{iFridayOfTheWeek}"+"/"+sYear
		[ ] 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add a Income Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#2")
			[ ] DlgOptionalSetting.EveryTwoWeeksOnPopupList.Select("#6")
			[ ] 
			[ ] //Get Date for Bill 
			[ ] ListAppend(lsBillVerification,DlgOptionalSetting.StartDateTextField.GetText())
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] //Delete Income Reminder
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC142_ScheduleTwiceAMonthIncomeReminder()########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC142_ScheduleTwiceAMonthIncomeReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a  Income reminder twice a month..
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If bi weekly Income reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC142_ScheduleTwiceAMonthIncomeReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Twice a month"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#4")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC143_ScheduleTwiceAMonthIncomeReminderB()########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC143_ScheduleTwiceAMonthIncomeReminderB()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a  Income reminder twice a month on two particular days.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If bi weekly Income reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC143_ScheduleTwiceAMonthIncomeReminderB() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sCompareDate1,sCompareDate2,sMonth,sYear,sDay1,sDay2
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification1,lsBillVerification2
		[ ] DATETIME dtDateTime
		[ ] INTEGER iDay1,iDay2,iMonth
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Twice a month"
		[ ] 
		[ ] iDay1=5
		[ ] iDay2=19
		[ ] 
		[ ] dtDateTime= GetDateTime ()
		[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] iMonth=val(sMonth)+1
		[ ] 
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] 
		[ ] sCompareDate1="{iMonth}" +"/"+"{iDay1}"+"/"+sYear
		[ ] sCompareDate2="{iMonth}" +"/"+"{iDay2}"+"/"+sYear
		[ ] 
		[ ] lsBillVerification1 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate1} 
		[ ] lsBillVerification2 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate2} 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#4")
			[ ] DlgOptionalSetting.TwiceAMonthOnPopupList.Select(iDay1)
			[ ] DlgOptionalSetting.TwiceAMonthAndPopupList.Select(iDay2)
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] // QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] // if (DlgManageReminders.Exists(5))
		[ ] // 
		[ ] // 
		[ ] // //Veirfy Income Reminder for 1st date
		[ ] // DlgManageReminders.MonthlyBillsDepositsTab.Click()
		[ ] // sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] // 
		[ ] // // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] // for(i=1; i<= Listcount(lsBillVerification1); i++)
			[ ] // bResult = MatchStr("*{lsBillVerification1[i]}*",sActual)
			[+] // if(bResult==TRUE)
				[ ] // ReportStatus("Verification of  added Income Reminder ", PASS, "Bill Reminder with '{lsBillVerification1[i]}' is added successfully")
			[+] // else
				[ ] // ReportStatus("Verification of  added Income Reminder ", FAIL, "Bill Reminder for {lsBillVerification1[i]} is NOT added, sActual = {sActual}")
		[ ] // 
		[ ] // 
		[ ] // //Veirfy Income Reminder for 2nd date
		[ ] // DlgManageReminders.MonthlyBillsDepositsTab.Click()
		[ ] // sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(1))
		[ ] // 
		[ ] // // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] // for(i=1; i<= Listcount(lsBillVerification2); i++)
			[ ] // bResult = MatchStr("*{lsBillVerification2[i]}*",sActual)
			[+] // if(bResult==TRUE)
				[ ] // ReportStatus("Verification of  added Income Reminder ", PASS, "Bill Reminder with '{lsBillVerification2[i]}' is added successfully")
			[+] // else
				[ ] // ReportStatus("Verification of  added Income Reminder ", FAIL, "Bill Reminder for {lsBillVerification2[i]} is NOT added, sActual = {sActual}")
		[ ] // 
		[ ] // DlgManageReminders.Close()
	[+] // else
		[ ] // ReportStatus("Verification of  added Income Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] iValidate=NULL
	[ ] iValidate=NavigateQuickenTab(sTAB_BILL)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Navigate to Bills Tab",PASS,"Bills tab opened")
		[ ] 
		[ ] //Select List from View options
		[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
		[ ] 
		[ ] //Select 90 days from duration dropdown
		[ ] MDIClient.Bills.DueWithinNextPopupList.Select(4)
		[ ] 
		[ ] //Get Handle of list
		[ ] 
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] iListCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
		[ ] //Verify Invoice Reminder for 1st date
		[ ] 
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bResult = MatchStr("*{lsBillVerification1[4]}*",sActual)
			[+] if (bResult)
				[ ] 
				[ ] 
				[ ] // Verify different Income parameters such as payee name, due date, bill amount and payment method
				[+] for(i=1; i<= Listcount(lsBillVerification1); i++)
					[ ] bResult = MatchStr("*{lsBillVerification1[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification1[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification1[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[ ] 
		[ ] //Veirfy Invoice Reminder for 2nd date
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bResult = MatchStr("*{lsBillVerification2[4]}*",sActual)
			[+] if (bResult)
				[ ] 
				[+] for(i=1; i<= Listcount(lsBillVerification2); i++)
					[ ] bResult = MatchStr("*{lsBillVerification2[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification2[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification2[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to Bills Tab",FAIL,"Bills tab not opened")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC144_ScheduleQuarterlyIncomeReminder()##############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC144_ScheduleQuarterlyIncomeReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a quaterly Income reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If quaterly Income reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC144_ScheduleQuarterlyIncomeReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "8.50"
		[ ] sHowOften = "Quarterly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#5")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC145_ScheduleYearlyIncomeReminder()#################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC145_ScheduleYearlyIncomeReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a yearly Income reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If yearly Income reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC145_ScheduleYearlyIncomeReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "3.25"
		[ ] sHowOften = "Yearly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] SetUp_AutoApi()
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#6")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC146_ScheduleTwiceAYearIncomeReminder()###################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC146_ScheduleTwiceAYearIncomeReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a Income reminder for twice a year.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If yearly Income reminder is scheduled twice a year.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC146_ScheduleTwiceAYearIncomeReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "12.25"
		[ ] sHowOften = "Twice a year"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#7")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC147_ScheduleIncomeReminderTwiceAYearForTwoParticularDays()#################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC147_ScheduleIncomeReminderTwiceAYearForTwoParticularDays()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a Income reminder for twice a year for two particular dates.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If yearly Income reminder is scheduled twice a year for two particular dates.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC147_ScheduleIncomeReminderTwiceAYearForTwoParticularDays() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sCompareDate1,sCompareDate2
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification1,lsBillVerification2
		[ ] 
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "9.12"
		[ ] sHowOften = "Twice a year"
		[ ] 
		[ ] sCompareDate1=ModifyDate(2,"m/d/yyyy")
		[ ] sCompareDate2=ModifyDate(200,"m/d/yyyy")
		[ ] 
		[ ] lsBillVerification1 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate1} 
		[ ] lsBillVerification2 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate2} 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] // if( iValidate==PASS)
		[ ] // ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] //  
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] // if(DlgOptionalSetting.Exists(5))
			[ ] // ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] // Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] // DlgOptionalSetting.HowOftenPopupList.Select("#8")
			[ ] // DlgOptionalSetting.TwiceAYearOnTextField.SetText(sCompareDate1)
			[ ] // DlgOptionalSetting.TwiceAYearAndTextField.SetText(sCompareDate2)
			[ ] // 
			[ ] // DlgOptionalSetting.OKButton.Click()
		[+] // else
			[ ] // ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] // DlgAddEditReminder.DoneButton.Click()
	[+] // else
		[ ] // ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] // DlgAddEditReminder.Close()
	[ ] 
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] // 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#7")
			[ ] DlgOptionalSetting.TwiceAYearOnTextField.SetText(sCompareDate1)
			[ ] DlgOptionalSetting.TwiceAYearAndTextField.SetText(sCompareDate2)
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] NavigateQuickenTab(sTAB_BILL)
	[+] if (MDIClient.Bills.Exists(5))
		[ ] 
		[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
		[ ] MDIClient.Bills.DueWithinNextPopupList.Select(5)
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] 
		[ ] 
		[ ] //Veirfy Income Reminder for 1st date
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification1); i++)
			[ ] bResult = MatchStr("*{lsBillVerification1[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification1[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification1[i]} is NOT added, sActual = {sActual}")
		[ ] 
		[ ] 
		[ ] //Veirfy Income Reminder for 2nd date
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(1))
		[ ] // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification2); i++)
			[ ] bResult = MatchStr("*{lsBillVerification2[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Bill Reminder with '{lsBillVerification2[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Bill Reminder for {lsBillVerification2[i]} is NOT added, sActual = {sActual}")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Bill window is NOT open")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC148_ScheduleOnlyOnceIncomeReminder()####################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC148_ScheduleOnlyOnceIncomeReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule an only once Income reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If Income reminder is scheduled for only once.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC148_ScheduleOnlyOnceIncomeReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "7.22"
		[ ] sHowOften = "Only Once"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#8")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] // //Delete Incomes
	[ ] // NavigateQuickenTab(sTAB_BILL)
	[ ] 
	[ ] // Bills.Panel.Panel1.QWinChild1.Edit.Click()
	[+] // if(DlgAddEditReminder.Exists(2))
		[ ] // ReportStatus("Navigate to Edit Income Reminder dialog", PASS, " Edit Income Reminder dialog is displayed")
		[ ] // 
		[ ] // DlgAddEditReminder.DeleteButton.Click()
		[+] // if(MessageBox.Exists(5))
			[ ] // MessageBox.OK1.Click()
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Delete Reminder", FAIL, " Delete Reminder confirmation dialog is not displayed")
			[ ] // 
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Navigate to Edit Income Reminder dialog", FAIL, " Edit Income Reminder dialog is not displayed")
		[ ] // 
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC150_VerifyEndOnOptionIncomeReminder()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC150_VerifyEndOnOptionIncomeReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality of  'End On' option for a Income reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If correct number of reminders are scheduled.
		[ ] //				       	Fail		      If any error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April  5, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC150_VerifyEndOnOptionIncomeReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sEndDate
		[ ] INTEGER iExpectedNumberOfReminders,iActualNumberOfReminders
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Monthly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] iExpectedNumberOfReminders=4
		[ ] 
		[ ] sEndDate=ModifyDate(100,"m/d/yyyy")
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#3")
			[ ] DlgOptionalSetting.EndDatePopupList.Select(2)
			[ ] DlgOptionalSetting.EndOnTextField.SetText(sEndDate)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify that correct number of Income reminders are added
	[ ] //Select 12 Months from Due Within Next PopupList
	[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
	[ ] MDIClient.Bills.DueWithinNextPopupList.Select(5)
	[ ] iActualNumberOfReminders=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
	[+] if(iActualNumberOfReminders==iExpectedNumberOfReminders)
		[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Correct number of Income Reminders added: {iExpectedNumberOfReminders}")
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Wrong number of Income Reminders added: {iActualNumberOfReminders}")
	[ ] 
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] // //Delete Incomes
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //##############################################################################
[ ] 
[ ] 
[ ] 
[+] //###############TC151_VerifyEndAfterOptionIncomeReminder()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC151_VerifyEndAfterOptionIncomeReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality of  'End after' option for a Income reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If correct number of reminders are scheduled.
		[ ] //				       	Fail		      If any error occurs..
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April  5, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC151_VerifyEndAfterOptionIncomeReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sEndAfter
		[ ] INTEGER iExpectedNumberOfReminders,iActualNumberOfReminders
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "7.22"
		[ ] sHowOften = "Monthly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] iExpectedNumberOfReminders=3
		[ ] 
		[ ] sEndAfter="3"
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#3")
			[ ] DlgOptionalSetting.EndDatePopupList.Select(3)
			[ ] DlgOptionalSetting.EndAfterTextField.SetText(sEndAfter)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify that correct number of Income reminders are added
	[ ] //Select 12 Months from Due Within Next PopupList
	[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
	[ ] MDIClient.Bills.DueWithinNextPopupList.Select(5)
	[ ] iActualNumberOfReminders=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
	[+] if(iActualNumberOfReminders==iExpectedNumberOfReminders)
		[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Correct number of Income Reminders added: {iExpectedNumberOfReminders}")
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Wrong number of Income Reminders added: {iActualNumberOfReminders}")
	[ ] 
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] // //Delete Incomes
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //##############################################################################
[ ] 
[ ] 
[+] //###############TC152_ScheduleMonthlyTransfer()####################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC152_ScheduleMonthlyTransfer()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a monthly transfer reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If monthly transfer reminder is scheduled.
		[ ] //				       	Fail		If monthly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 22, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC152_ScheduleMonthlyTransfer() appstate none
	[ ] 
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] INTEGER iValidate
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "5.75"
		[ ] sHowOften = "Monthly"
		[ ] sTransactionType = "Transfer"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sTransactionType,sHowOften}
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] // 
		[ ] //DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgAddEditReminder.Exists(2))
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and how often
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] // //Delete Incomes
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Transfer Reminder", PASS, "Single Transfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Transfer Reminder", FAIL, "Single Transfer Reminder not deleted")
	[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[ ] 
[+] //###############TC153_ScheduleEveryXMonthTransfer()################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC153_ScheduleEveryXMonthTransfer()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a monthly transfer reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If every 'X' monthly transfer reminder is scheduled.
		[ ] //				       	Fail		If every 'X' monthly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 22, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC153_ScheduleEveryXMonthTransfer() appstate none
	[ ] 
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sFrequency
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "5.75"
		[ ] sFrequency = "2"
		[ ] sHowOften = "Every 2 Months"
		[ ] sTransactionType= "Transfer"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sTransactionType, sHowOften}
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] // 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[ ] 
		[ ] 
		[ ] 
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.EveryWeekTextField.SetText(sFrequency)
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] // //Delete Incomes
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Transfer Reminder", PASS, "Single Transfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Transfer Reminder", FAIL, "Single Transfer Reminder not deleted")
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[ ] 
[+] //###############TC154_ScheduleXthDayOfMonthTransfer()##############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC154_ScheduleXthDayOfMonthTransfer()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a monthly transfer  reminder for 'X' th day of the Month.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If every 'X' th day of the Month, transfer reminder is scheduled.
		[ ] //				       	Fail		If every 'X' th day of the Month, transfer reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 25, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC154_ScheduleXthDayOfMonthTransfer() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften,sDay,sMonth,sYear,sCompareDate
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] INTEGER iValidateDate,iMonth
		[ ] 
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "5.75"
		[ ] sHowOften = "Monthly"
		[ ] 
		[ ] 
		[ ] //Get date for Bill
		[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] 
		[ ] sDay=FormatDateTime(GetDateTime(), "d")
		[ ] iValidateDate=val(sDay)+1
		[+] if(iValidateDate>30)
			[ ] iValidateDate=iValidateDate-4
			[ ] sMonth=Str(val(sMonth)+1)
		[ ] 
		[ ] sCompareDate=sMonth +"/"+"{iValidateDate}"+"/"+sYear
		[ ] 
		[ ] 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate}
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] // 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[ ] 
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[ ] 
		[+] if(DlgOptionalSetting.Exists(2))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.MonthOnThePopupList.Select(iValidateDate)
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] // //Delete Reminder
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Single Transfer Reminder", PASS, "Single Transfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Transfer Reminder", FAIL, "Single Transfer Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[ ] 
[+] //###############TC155_DayDropdownContentTransfer()#################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC155_DayDropdownContentTransfer()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify content of the 'Day' drop down box for Transfer Reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If day drop down box contains {"Day","QCombo_Separator", "Sunday","Monday", "Tuesday", "Wednesday","Thursday","Friday", "Saturday"}
		[ ] //				       	Fail		If day dropdown box doesn't contain {"Day","QCombo_Separator", "Sunday","Monday", "Tuesday", "Wednesday","Thursday","Friday", "Saturday"} or if error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  March 26, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC155_DayDropdownContentTransfer() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification, lsDaysActual, lsDaysExpected
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "9.15"
		[ ] sDayOfMonth = "/05/20"
		[ ] sHowOften = "Every 2 Months"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sDayOfMonth}
		[ ] lsDaysExpected = {"Day","QCombo_Separator", "Sunday","Monday", "Tuesday", "Wednesday","Thursday","Friday", "Saturday"}
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] // if( iValidate==PASS)
		[ ] // ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] // // 
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] // if(DlgOptionalSetting.Exists(5))
			[ ] // ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] // //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] // DlgOptionalSetting.MonthOnThePopupList.Select("#33")
			[ ] // lsDaysActual= DlgOptionalSetting.DayPopupList.GetContents()
			[+] // if (lsDaysExpected == lsDaysActual)
				[ ] // ReportStatus("Verify Day dropdown content", PASS, " Day drop down box content is verified")
			[+] // else
				[ ] // ReportStatus("Verify Day dropdown content", FAIL, " Day drop down box content is different. day dropdown contains = {lsDaysActual}")
			[ ] // DlgOptionalSetting.OKButton.Click()
		[+] // else
			[ ] // ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] // DlgAddEditReminder.CancelButton.Click()
	[+] // else
		[ ] // ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] // DlgAddEditReminder.Close()
	[ ] 
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] 
			[ ] //print(DlgOptionalSetting.MonthOnThePopupList.GetContents())
			[ ] 
			[ ] //DlgOptionalSetting.MonthOnThePopupList.Select("last")
			[ ] DlgOptionalSetting.MonthOnThePopupList.SetText("last")
			[ ] 
			[ ] lsDaysActual= DlgOptionalSetting.DayPopupList.GetContents()
			[+] if (lsDaysExpected == lsDaysActual)
				[ ] ReportStatus("Verify Day dropdown content", PASS, " Day drop down box content is verified")
			[+] else
				[ ] ReportStatus("Verify Day dropdown content", FAIL, " Day drop down box content is different. day dropdown contains = {lsDaysActual[i]}")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.CancelButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[ ] 
[+] //###############TC156_ScheduleMonthlyTransferReminderForLastDayOfTheMonth()###############
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC156_ScheduleMonthlyTransferReminderForLastDayOfTheMonth()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a income reminder for last day of the month
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If  income reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC156_ScheduleMonthlyTransferReminderForLastDayOfTheMonth() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING  sHowOften,sCompareDate
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "6.55"
		[ ] sHowOften = "Monthly"
		[ ] sCompareDate=LastDateOfTheMonth()
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add a Bill Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] // 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] 
			[ ] //DlgOptionalSetting.MonthOnThePopupList.Select("Last")
			[ ] 
			[ ] DlgOptionalSetting.MonthOnThePopupList.SetText("Last")
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] //Delete Bill Reminder
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete Single Transfer Reminder", PASS, "Single Transfer Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete Single Transfer Reminder", FAIL, "Single Transfer Reminder not deleted")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC157_ScheduleMonthlyTransferForCertainDayOfTheMonth()###############
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC157_ScheduleMonthlyTransferForCertainDayOfTheMonth()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a monthly income for a certain day of the month
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If  income reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC157_ScheduleMonthlyTransferForCertainDayOfTheMonth() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING  sHowOften, sCompareDate,sMonth,sYear,sSelectDate,sSelectDay
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "6.55"
		[ ] sHowOften = "Monthly"
		[ ] 
		[ ] 
		[ ] sSelectDate="last"
		[ ] sSelectDay="Fri"
		[ ] sCompareDate=LastFridayOfTheCurrentMonth()
		[ ] 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.MonthOnThePopupList.TypeKeys(sSelectDate)
			[ ] DlgOptionalSetting.DayPopupList.TypeKeys(sSelectDay)
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] //Delete Bill Reminder
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete Single Transfer Reminder", PASS, "Single Transfer Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete Single Transfer Reminder", FAIL, "Single Transfer Reminder not deleted")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[ ] 
[+] //###############TC158_ScheduleWeeklyTransferReminder()######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC158_ScheduleWeeklyTransferReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a weeklyTransfer reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weeklyTransfer reminder is scheduled.
		[ ] //				       	Fail		      If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   March 28, 2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC158_ScheduleWeeklyTransferReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Weekly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] SetUp_AutoApi()
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#1")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[ ] 
[+] //###############TC159_ScheduleWeeklyTransferReminderForCertainWeeks()#########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC159_ScheduleWeeklyTransferReminderForCertainWeeks()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a weeklyTransfer reminder for a certain every "X" 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weeklyTransfer reminder is scheduled.
		[ ] //				       	Fail		If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 3, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC159_ScheduleWeeklyTransferReminderForCertainWeeks() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sEveryXWeeks,sWeeklyDurationText
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "4.60"
		[ ] sHowOften = "Weekly"
		[ ] 
		[ ] sEveryXWeeks="5"
		[ ] sWeeklyDurationText="Every 5 weeks"
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sWeeklyDurationText} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] //Add aTransfer Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] // 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#1")
			[ ] //DlgOptionalSetting.WeeksOnPopupList.Select("#6")
			[ ] DlgOptionalSetting.LastTextField.SetText(sEveryXWeeks)
			[ ] 
			[ ] // //Get Date for Bill 
			[ ] // ListAppend(lsBillVerification,DlgOptionalSetting.StartDateTextField.GetText())
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not using Transfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] //DeleteTransfer Reminder
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[ ] 
[+] //###############TC160_ScheduleWeeklyTransferReminderForCertainDayOfTheWeek()#################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC160_ScheduleWeeklyTransferReminderForCertainDayOfTheWeek()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a weeklyTransfer reminder for a particular day of the week.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weeklyTransfer reminder is scheduled.
		[ ] //				       	Fail		     If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 3, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC160_ScheduleWeeklyTransferReminderForCertainDayOfTheWeek() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING sToday,sDay,sMonth,sYear,sCompareDate
		[ ] INTEGER iDifference,iFridayOfTheWeek
		[ ] DATETIME dtDateTime
		[ ] 
		[ ] 
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "6.55"
		[ ] sHowOften = "Weekly"
		[ ] 
		[ ] 
		[ ] 
		[ ] //Verify Day on whichTransfer gets added
		[ ] dtDateTime= GetDateTime ()
		[ ] sDay = FormatDateTime(GetDateTime(), "w")  // display day of the week as a number between 1-7
		[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] 
		[ ] iDifference = 6 - Val(sDay)
		[ ] sToday = FormatDateTime(GetDateTime(),"d")//Get current day
		[ ] iFridayOfTheWeek = Val(sToday) + iDifference
		[ ] 
		[ ] sCompareDate=sMonth +"/"+"{iFridayOfTheWeek}"+"/"+sYear
		[ ] 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add aTransfer Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] // 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#1")
			[ ] DlgOptionalSetting.WeeksOnPopupList.Select("#6")
			[ ] 
			[ ] //Get Date for Bill 
			[ ] ListAppend(lsBillVerification,DlgOptionalSetting.StartDateTextField.GetText())
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] //DeleteTransfer Reminder
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC161_ScheduleBiWeeklyTransferReminder()######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC161_ScheduleBiWeeklyTransferReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a bi weeklyTransfer reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If bi weeklyTransfer reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC161_ScheduleBiWeeklyTransferReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Every 2 Weeks"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] SetUp_AutoApi()
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#2")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC162_ScheduleBiWeeklyTransferReminderForCertainDayOfTheWeek()###############
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC162_ScheduleBiWeeklyTransferReminderForCertainDayOfTheWeek()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a bi weeklyTransfer reminder for a particular day of the week.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weeklyTransfer reminder is scheduled.
		[ ] //				       	Fail		     If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 4, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC162_ScheduleBiWeeklyTransferReminderForCertainDayOfTheWeek() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING sToday,sDay,sMonth,sYear,sCompareDate
		[ ] INTEGER iDifference,iFridayOfTheWeek
		[ ] DATETIME dtDateTime
		[ ] 
		[ ] 
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "6.55"
		[ ] sHowOften = "Every 2 Weeks"
		[ ] 
		[ ] 
		[ ] 
		[ ] // //Verify Day on whichTransfer gets added
		[ ] // dtDateTime= GetDateTime ()
		[ ] // sDay = FormatDateTime(GetDateTime(), "w")  // display day of the week as a number between 1-7
		[ ] // sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] // sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] // 
		[ ] // iDifference = 6 - Val(sDay)
		[ ] // sToday = FormatDateTime(GetDateTime(),"d")//Get current day
		[ ] // iFridayOfTheWeek = Val(sToday) + iDifference
		[ ] // 
		[ ] // sCompareDate=sMonth +"/"+"{iFridayOfTheWeek}"+"/"+sYear
		[ ] 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add aTransfer Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] // if( iValidate==PASS)
		[ ] // ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] //  
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] // if(!DlgOptionalSetting.Exists(2))
			[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[ ] // 
		[+] // if(DlgOptionalSetting.Exists(5))
			[ ] // ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] // Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] // DlgOptionalSetting.HowOftenPopupList.Select("#2")
			[ ] // ReminderDetails.MonthOnThe.Select("#6")
			[ ] // 
			[ ] // DlgOptionalSetting.OKButton.Click()
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] // DlgAddEditReminder.DoneButton.Click()
	[+] // else
		[ ] // ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] // DlgAddEditReminder.Close()
	[ ] 
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] // 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] //Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#2")
			[ ] DlgOptionalSetting.EveryTwoWeeksOnPopupList.Select("#6")
			[ ] 
			[ ] //Get Date for Bill 
			[ ] ListAppend(lsBillVerification,DlgOptionalSetting.StartDateTextField.GetText())
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] //DeleteTransfer Reminder
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC163_ScheduleTwiceAMonthTransferReminder()#################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC163_ScheduleTwiceAMonthTransferReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a Transfer reminder twice a month..
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If bi weeklyTransfer reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC163_ScheduleTwiceAMonthTransferReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Twice a month"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] SetUp_AutoApi()
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[ ] 
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#4")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC164_ScheduleTwiceAMonthTransferReminderB()#################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC164_ScheduleTwiceAMonthTransferReminderB()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a Transfer reminder twice a month on two particular days.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If bi weeklyTransfer reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC164_ScheduleTwiceAMonthTransferReminderB() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sCompareDate1,sCompareDate2,sMonth,sYear,sDay1,sDay2
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification1,lsBillVerification2
		[ ] DATETIME dtDateTime
		[ ] INTEGER iDay1,iDay2,iMonth
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Twice a month"
		[ ] 
		[ ] iDay1=5
		[ ] iDay2=19
		[ ] 
		[ ] dtDateTime= GetDateTime ()
		[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] iMonth=val(sMonth)+1
		[ ] 
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] 
		[ ] sCompareDate1="{iMonth}" +"/"+"{iDay1}"+"/"+sYear
		[ ] sCompareDate2="{iMonth}" +"/"+"{iDay2}"+"/"+sYear
		[ ] 
		[ ] lsBillVerification1 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate1} 
		[ ] lsBillVerification2 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate2} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[ ] 
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#4")
			[ ] DlgOptionalSetting.TwiceAMonthOnPopupList.Select(iDay1)
			[ ] DlgOptionalSetting.TwiceAMonthAndPopupList.Select(iDay2)
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] iValidate=NULL
	[ ] iValidate=NavigateQuickenTab(sTAB_BILL)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Navigate to Bills Tab",PASS,"Bills tab opened")
		[ ] 
		[ ] //Select List from View options
		[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
		[ ] 
		[ ] //Select 90 days from duration dropdown
		[ ] MDIClient.Bills.DueWithinNextPopupList.Select(4)
		[ ] 
		[ ] //Get Handle of list
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] iListCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
		[ ] //Verify Invoice Reminder for 1st date
		[ ] 
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification1[4]}*",sActual)
			[+] if (bMatch)
				[ ] //Verify Reminder for 1st date
				[+] for(i=1; i<= Listcount(lsBillVerification1); i++)
					[ ] bResult = MatchStr("*{lsBillVerification1[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification1[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification1[i]} is NOT added, sActual = {sActual}")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] break
				[ ] 
				[ ] 
			[ ] 
		[+] if(bMatch==FALSE)
			[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification1} is NOT added.")
		[ ] 
		[ ] 
		[ ] 
		[ ] //Veirfy Reminder for 2nd date
		[ ] 
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification2[4]}*",sActual)
			[+] if (bMatch)
				[ ] //Verify Reminder for 1st date
				[+] for(i=1; i<= Listcount(lsBillVerification2); i++)
					[ ] bResult = MatchStr("*{lsBillVerification2[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification2[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification2[i]} is NOT added, sActual = {sActual}")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] break
				[ ] 
				[ ] 
			[ ] 
		[+] if(bMatch==FALSE)
			[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification2[4]} is NOT added.")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to Bills Tab",FAIL,"Bills tab not opened")
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC165_ScheduleQuarterlyTransferReminder()######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC165_ScheduleQuarterlyTransferReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a quaterlyTransfer reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If quaterlyTransfer reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC165_ScheduleQuarterlyTransferReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "8.50"
		[ ] sHowOften = "Quarterly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[ ] 
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#5")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#######################################################################################
[ ] 
[ ] 
[+] //###############TC166_ScheduleYearlyTransferReminder()#######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC166_ScheduleYearlyTransferReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a yearlyTransfer reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If yearlyTransfer reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC166_ScheduleYearlyTransferReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "3.25"
		[ ] sHowOften = "Yearly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[ ] 
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#6")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#######################################################################################
[ ] 
[ ] 
[+] //###############TC167_ScheduleTwiceAYearTransferReminder()###################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC167_ScheduleTwiceAYearTransferReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule aTransfer reminder for twice a year.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If yearlyTransfer reminder is scheduled twice a year.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC167_ScheduleTwiceAYearTransferReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "12.25"
		[ ] sHowOften = "Twice a year"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[ ] 
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#7")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //####################################################################################
[ ] 
[ ] 
[+] //###############TC168_ScheduleTransferReminderTwiceAYearForTwoParticularDays()#################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC168_ScheduleTransferReminderTwiceAYearForTwoParticularDays()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule aTransfer reminder for twice a year for two particular dates.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If yearlyTransfer reminder is scheduled twice a year for two particular dates.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC168_ScheduleTransferReminderTwiceAYearForTwoParticularDays() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sCompareDate1,sCompareDate2
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification1,lsBillVerification2
		[ ] 
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "9.12"
		[ ] sHowOften = "Twice a year"
		[ ] 
		[ ] sCompareDate1=ModifyDate(2,"m/d/yyyy")
		[ ] sCompareDate2=ModifyDate(200,"m/d/yyyy")
		[ ] 
		[ ] lsBillVerification1 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate1} 
		[ ] lsBillVerification2 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate2} 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[ ] 
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#7")
			[ ] DlgOptionalSetting.TwiceAYearOnTextField.SetText(sCompareDate1)
			[ ] DlgOptionalSetting.TwiceAYearAndTextField.SetText(sCompareDate2)
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] NavigateQuickenTab(sTAB_BILL)
	[+] if (MDIClient.Bills.Exists(5))
		[ ] 
		[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
		[ ] MDIClient.Bills.DueWithinNextPopupList.Select(5)
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] 
		[ ] 
		[ ] //VeirfyTransfer Reminder for 1st date
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification1); i++)
			[ ] bResult = MatchStr("*{lsBillVerification1[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification1[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification1[i]} is NOT added, sActual = {sActual}")
		[ ] 
		[ ] 
		[ ] //VeirfyTransfer Reminder for 2nd date
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(1))
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification2); i++)
			[ ] bResult = MatchStr("*{lsBillVerification2[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification2[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification2[i]} is NOT added, sActual = {sActual}")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Bill window is NOT open")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //####################################################################################
[ ] 
[ ] 
[+] //###############TC169_ScheduleOnlyOnceTransferReminder()####################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC169_ScheduleOnlyOnceTransferReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule an only onceTransfer reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		IfTransfer reminder is scheduled for only once.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC169_ScheduleOnlyOnceTransferReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "7.22"
		[ ] sHowOften = "Only Once"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[ ] 
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#8")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] // //DeleteTransfers
	[ ] // NavigateQuickenTab(sTAB_BILL)
	[ ] // 
	[ ] // Bills.Panel.Panel1.QWinChild1.Edit.Click()
	[+] // if(DlgAddEditReminder.Exists(2))
		[ ] // ReportStatus("Navigate to EditTransfer Reminder dialog", PASS, " EditTransfer Reminder dialog is displayed")
		[ ] // 
		[ ] // DlgAddEditReminder.DeleteButton.Click()
		[+] // if(MessageBox.Exists(5))
			[ ] // MessageBox.OK1.Click()
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Delete Reminder", FAIL, " Delete Reminder confirmation dialog is not displayed")
			[ ] // 
		[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Navigate to EditTransfer Reminder dialog", FAIL, " EditTransfer Reminder dialog is not displayed")
		[ ] // 
	[ ] // 
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //####################################################################################
[ ] 
[ ] 
[+] //###############TC171_VerifyEndOnOptionTransferReminder()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC171_VerifyEndOnOptionTransferReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality of  'End On' option for aTransfer reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If correct number of reminders are scheduled.
		[ ] //				       	Fail		      If any error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April  5, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC171_VerifyEndOnOptionTransferReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sEndDate
		[ ] INTEGER iExpectedNumberOfReminders,iActualNumberOfReminders
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Monthly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] iExpectedNumberOfReminders=4
		[ ] 
		[ ] sEndDate=ModifyDate(100,"m/d/yyyy")
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[ ] 
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#3")
			[ ] DlgOptionalSetting.EndDatePopupList.Select(2)
			[ ] DlgOptionalSetting.EndOnTextField.SetText(sEndDate)
			[ ] 
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify that correct number ofTransfer reminders are added
	[ ] //Select 12 Months from Due Within Next PopupList
	[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
	[ ] MDIClient.Bills.DueWithinNextPopupList.Select(5)
	[ ] iActualNumberOfReminders=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
	[+] if(iActualNumberOfReminders==iExpectedNumberOfReminders)
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Correct number ofTransfer Reminders added: {iExpectedNumberOfReminders}")
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Wrong number ofTransfer Reminders added: {iActualNumberOfReminders}")
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
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] // //DeleteTransfers
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //###################################################################################
[ ] 
[ ] 
[+] //###############TC172_VerifyEndAfterOptionTransferReminder()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC172_VerifyEndAfterOptionTransferReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality of  'End after' option for a transfer reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If correct number of reminders are scheduled.
		[ ] //				       	Fail		      If any error occurs..
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April  5, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC172_VerifyEndAfterOptionTransferReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sEndAfter
		[ ] INTEGER iExpectedNumberOfReminders,iActualNumberOfReminders
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "7.22"
		[ ] sHowOften = "Monthly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] iExpectedNumberOfReminders=3
		[ ] 
		[ ] sEndAfter="3"
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[ ] 
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#3")
			[ ] 
			[ ] DlgOptionalSetting.EndDatePopupList.Select(3)
			[ ] DlgOptionalSetting.EndAfterTextField.SetText(sEndAfter)
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify that correct number ofTransfer reminders are added
	[ ] //Select 12 Months from Due Within Next PopupList
	[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
	[ ] MDIClient.Bills.DueWithinNextPopupList.Select(5)
	[ ] iActualNumberOfReminders=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
	[+] if(iActualNumberOfReminders==iExpectedNumberOfReminders)
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Correct number ofTransfer Reminders added: {iExpectedNumberOfReminders}")
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Wrong number ofTransfer Reminders added: {iActualNumberOfReminders}")
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
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] // //DeleteTransfers
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Single Transfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //###################################################################################
[ ] 
[ ] 
[ ] 
[+] //###############TCSetup_ReminderFrequencyDataFileInvoice()###################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TCSetup_ReminderFrequencyDataFileInvoice()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will setup the data file required for frequency test cases with a Checking, Customer Invoice and Vendor Invoice account
		[ ] //
		[ ] // RETURNS:			Pass 	   If setup is completed successfully
		[ ] //				        	Fail		   If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TCSetup_ReminderFrequencyDataFileInvoice() appstate none
	[ ] 
	[ ] 
	[ ] // Create Data File
	[ ] iValidate = DataFileCreate(sFileName)
	[ ] //Report Staus If Data file Created successfully
	[+] if ( iValidate  == PASS)
		[ ] ReportStatus("Validate Data File ", iValidate, "Data file -  {sDataFile} is created")
		[ ] 
		[ ] 
		[ ] //Add a manual checking account.
		[ ] iValidate=AddManualSpendingAccount(IsAddAccount[1],IsAddAccount[2],IsAddAccount[3],IsAddAccount[4])
		[+] if(iValidate == PASS)
			[ ] ReportStatus("Add Checking Account", PASS, "Checking account is added.")
			[ ] 
			[ ] 
			[ ] //Add accounts payable
			[ ] iValidate=AddBusinessAccount(lsAddAccount3[1],lsAddAccount3[2])
			[+] if(iValidate == PASS)
				[ ] ReportStatus("Add Vendor Invoices Accountt", PASS, "Vendor Invoices account is added.")
				[ ] 
				[ ] //Add a manual credit card account.
				[ ] iValidate=AddBusinessAccount(lsAddAccount4[1],lsAddAccount4[2])
				[+] if(iValidate == PASS)
					[ ] ReportStatus("Add Customer Invoices Accountt", PASS, "Customer Invoices account is added.")
				[+] else
					[ ] ReportStatus("Add Customer Invoices Account", FAIL, "Customer Invoices account is NOT added.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Add Vendor Invoices Account", FAIL, "Vendor Invoices account is NOT added.")
		[+] else
			[ ] ReportStatus("Add Checking Account", FAIL, "Checking account is NOT added.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", iValidate, "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC173_ScheduleMonthlyInvoiceReminder()####################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC173_ScheduleMonthlyInvoiceReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a monthly Invoice reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If monthly transfer reminder is scheduled.
		[ ] //				       	Fail		If monthly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC173_ScheduleMonthlyInvoiceReminder() appstate none
	[ ] 
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] INTEGER iValidate
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Monthly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sReminderType,sHowOften}
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType, sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] 
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and how often
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder is NOT added")
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[ ] 
[+] //###############TC174_ScheduleEveryXMonthInvoiceReminder()################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC174_ScheduleEveryXMonthInvoiceReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a monthly invoice reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If every 'X' monthly invoice reminder is scheduled.
		[ ] //				       	Fail		If every 'X' monthly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 8,2013		Suyash Joshi created
	[ ] // **************************************************************************************
[+] testcase TC174_ScheduleEveryXMonthInvoiceReminder() appstate none
	[ ] 
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sFrequency
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sFrequency = "2"
		[ ] sHowOften = "Every 2 Months"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sReminderType, sHowOften}
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Click()  
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.EveryWeekTextField.SetText(sFrequency)
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Reminder NOT deleted")
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[ ] 
[+] //###############TC175_ScheduleXthDayOfMonthInvoicer()##############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC175_ScheduleXthDayOfMonthInvoicer()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a monthly Invoice reminder for 'X' th day of the Month.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If every 'X' th day of the Month, reminder is scheduled.
		[ ] //				       	Fail		     If every 'X' th day of the Month, reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 8,2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC175_ScheduleXthDayOfMonthInvoicer() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften,sDay,sMonth,sYear,sCompareDate
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] INTEGER iValidateDate,iMonth
		[ ] 
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Monthly"
		[ ] 
		[ ] 
		[ ] //Get date for Bill
		[ ] sDay=FormatDateTime(GetDateTime(), "d")
		[ ] iValidateDate=val(sDay)+1
		[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] sCompareDate=sMonth +"/"+"{iValidateDate}"+"/"+sYear
		[ ] 
		[ ] 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate}
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Click()  
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[+] if(!DlgOptionalSetting.Exists(5))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click() 
		[ ] 
		[+] if(DlgOptionalSetting.Exists(2))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.MonthOnThePopupList.Select(iValidateDate)
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Reminder NOT deleted")
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[ ] 
[ ] 
[+] //###############TC176_DayDropdownContentInvoice()#################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC176_DayDropdownContentInvoice()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify content of the 'Day' drop down box for Invoice Reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass     If day drop down box contains {"Day","QCombo_Separator", "Sunday","Monday", "Tuesday", "Wednesday","Thursday","Friday", "Saturday"}
		[ ] //				       	Fail		If day dropdown box doesn't contain {"Day","QCombo_Separator", "Sunday","Monday", "Tuesday", "Wednesday","Thursday","Friday", "Saturday"} or if error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 8 , 2013 Dean Paes Created
	[ ] // **************************************************************************************
[+] testcase TC176_DayDropdownContentInvoice() appstate none //none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification, lsDaysActual, lsDaysExpected
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] lsDaysExpected = {"Day","QCombo_Separator", "Sunday","Monday", "Tuesday", "Wednesday","Thursday","Friday", "Saturday"}
		[ ] 
	[ ] 
	[ ] //QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] //DlgOptionalSetting.MonthOnThePopupList.Select("#33")
			[ ] DlgOptionalSetting.MonthOnThePopupList.SetText("last")
			[ ] 
			[ ] 
			[ ] lsDaysActual= DlgOptionalSetting.DayPopupList.GetContents()
			[ ] 
			[+] if (lsDaysExpected == lsDaysActual)
				[ ] ReportStatus("Verify Day dropdown content", PASS, " Day drop down box content is verified")
			[+] else
				[ ] ReportStatus("Verify Day dropdown content", FAIL, " Day drop down box content is different. day dropdown contains = {lsDaysActual}")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.CancelButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
[ ] //###############################################################################
[ ] 
[ ] 
[+] //###############TC177_ScheduleMonthlyInvoiceReminderForLastDayOfTheMonth()###############
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC177_ScheduleMonthlyInvoiceReminderForLastDayOfTheMonth()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a invoice reminder for last day of the month
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If  reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC177_ScheduleMonthlyInvoiceReminderForLastDayOfTheMonth() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING  sHowOften,sCompareDate
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Monthly"
		[ ] sCompareDate=LastDateOfTheMonth()
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] //////DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddCategoryTagMemoButton.Click()
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Click()  
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] //DlgOptionalSetting.MonthOnThe.Select("Last")
			[ ] DlgOptionalSetting.MonthOnThePopupList.SetText("Last")
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Invoice Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
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
		[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC178_ScheduleMonthlyInvoiceForCertainDayOfTheMonth()###############
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC178_ScheduleMonthlyInvoiceForCertainDayOfTheMonth()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a monthly invoice for a certain day of the month
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If  Invoice reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC178_ScheduleMonthlyInvoiceForCertainDayOfTheMonth() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING  sHowOften, sCompareDate,sMonth,sYear,sSelectDate,sSelectDay
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Monthly"
		[ ] 
		[ ] sSelectDate="last"
		[ ] sSelectDay="Fri"
		[ ] sCompareDate=LastFridayOfTheCurrentMonth()
		[ ] 
		[ ] 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Click()
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.MonthOnThePopupList.TypeKeys(sSelectDate)
			[ ] DlgOptionalSetting.DayPopupList.TypeKeys(sSelectDay)
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Invoice Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[4]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[+] if(bMatch == FALSE)
			[ ] ReportStatus("Verify Reminder in List view", FAIL, "Reminder {lsBillVerification}  is not available in Reminder in List view")
		[ ] 
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC179_ScheduleWeeklyInvoiceReminder()######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC179_ScheduleWeeklyInvoiceReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a weekly Invoice reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weeklyTransfer reminder is scheduled.
		[ ] //				       	Fail		      If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC179_ScheduleWeeklyInvoiceReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Weekly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] // DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Click()
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#1")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Invoice Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[ ] 
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[3]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[+] if(bMatch == FALSE)
			[ ] ReportStatus("Verify Reminder in List view", FAIL, "Reminder {lsBillVerification}  is not available in Reminder in List view")
		[ ] 
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC180_ScheduleWeeklyInvoiceReminderForCertainWeeks()#########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC180_ScheduleWeeklyInvoiceReminderForCertainWeeks()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a weekly Invoice reminder for a certain every "X" 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weekly invoice reminder is scheduled.
		[ ] //				       	Fail		      If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC180_ScheduleWeeklyInvoiceReminderForCertainWeeks() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sEveryXWeeks,sWeeklyDurationText
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Weekly"
		[ ] 
		[ ] sEveryXWeeks="5"
		[ ] sWeeklyDurationText="Every 5 weeks"
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sWeeklyDurationText} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] 
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#1")
			[ ] DlgOptionalSetting.LastTextField.SetText(sEveryXWeeks)
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] 
		[ ] 
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[3]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[+] if(bMatch == FALSE)
			[ ] ReportStatus("Verify Reminder in List view", FAIL, "Reminder {lsBillVerification}  is not available in Reminder in List view")
		[ ] 
		[ ] DlgManageReminders.Close()
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC181_ScheduleWeeklyInvoiceReminderForCertainDayOfTheWeek()#################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC181_ScheduleWeeklyInvoiceReminderForCertainDayOfTheWeek()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a weekly Invoice reminder for a particular day of the week.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weekly Invoice reminder is scheduled.
		[ ] //				       	Fail		     If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC181_ScheduleWeeklyInvoiceReminderForCertainDayOfTheWeek() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING sToday,sDay,sMonth,sYear,sCompareDate
		[ ] INTEGER iDifference,iFridayOfTheWeek
		[ ] DATETIME dtDateTime
		[ ] 
		[ ] 
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Weekly"
		[ ] 
		[ ] 
		[ ] 
		[ ] //Verify Day on whichTransfer gets added
		[ ] dtDateTime= GetDateTime ()
		[ ] sDay = FormatDateTime(GetDateTime(), "w")  // display day of the week as a number between 1-7
		[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] 
		[ ] iDifference = 6 - Val(sDay)
		[ ] sToday = FormatDateTime(GetDateTime(),"d")//Get current day
		[ ] iFridayOfTheWeek = Val(sToday) + iDifference
		[ ] 
		[ ] sCompareDate=sMonth +"/"+"{iFridayOfTheWeek}"+"/"+sYear
		[ ] 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate} 
		[ ] 
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] 
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] 
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#1")
			[ ] DlgOptionalSetting.WeeksOnPopupList.Select("#6")
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Invoice Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[ ] 
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[4]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[+] if(bMatch == FALSE)
			[ ] ReportStatus("Verify Reminder in List view", FAIL, "Reminder {lsBillVerification}  is not available in Reminder in List view")
		[ ] 
		[ ] 
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //Delete Invoices
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC182_ScheduleBiWeeklyInvoiceReminder()######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC182_ScheduleBiWeeklyInvoiceReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a bi weekly invoice reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If bi weekly Invoice reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 8, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC182_ScheduleBiWeeklyInvoiceReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Every 2 Weeks"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#2")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[ ] 
		[ ] 
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[3]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[+] if(bMatch == FALSE)
			[ ] ReportStatus("Verify Reminder in List view", FAIL, "Reminder {lsBillVerification}  is not available in Reminder in List view")
		[ ] 
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC162_ScheduleBiWeeklyTransferReminderForCertainDayOfTheWeek()###############
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC162_ScheduleBiWeeklyTransferReminderForCertainDayOfTheWeek()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a bi weeklyTransfer reminder for a particular day of the week.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weeklyTransfer reminder is scheduled.
		[ ] //				       	Fail		     If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	 April 4, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC183_ScheduleBiWeeklyInvoiceReminderForCertainDayOfTheWeek() appstate none
	[+] // Variable declaration and definition
		[ ] 
		[ ] STRING sToday,sDay,sMonth,sYear,sCompareDate
		[ ] INTEGER iDifference,iFridayOfTheWeek
		[ ] DATETIME dtDateTime
		[ ] 
		[ ] 
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Every 2 Weeks"
		[ ] 
		[ ] 
		[ ] // 
		[ ] // //Verify Day on whichTransfer gets added
		[ ] // dtDateTime= GetDateTime ()
		[ ] // sDay = FormatDateTime(GetDateTime(), "w")  // display day of the week as a number between 1-7
		[ ] // sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] // sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] // 
		[ ] // iDifference = 6 - Val(sDay)
		[ ] // sToday = FormatDateTime(GetDateTime(),"d")//Get current day
		[ ] // iFridayOfTheWeek = Val(sToday) + iDifference
		[ ] // 
		[ ] // sCompareDate=sMonth +"/"+"{iFridayOfTheWeek}"+"/"+sYear
		[ ] // 
		[ ] 
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //Add aTransfer Reminder
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#2")
			[ ] DlgOptionalSetting.EveryTwoWeeksOnPopupList.Select("#6")
			[ ] 
			[ ] //Get Date for Bill 
			[ ] ListAppend(lsBillVerification,DlgOptionalSetting.StartDateTextField.GetText())
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[4]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[+] if(bMatch == FALSE)
			[ ] ReportStatus("Verify Reminder in List view", FAIL, "Reminder {lsBillVerification}  is not available in Reminder in List view")
		[ ] 
		[ ] 
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] //Delete Invoices
		[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
		[+] else
			[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC184_ScheduleTwiceAMonthInvoiceReminder()#################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC184_ScheduleTwiceAMonthInvoiceReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a invoice reminder twice a month..
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If bi weekly Invoice reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April 8, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC184_ScheduleTwiceAMonthInvoiceReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Twice a month"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
	[ ] 
	[ ] // 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#4")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[3]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[+] if(bMatch == FALSE)
			[ ] ReportStatus("Verify Reminder in List view", FAIL, "Reminder {lsBillVerification}  is not available in Reminder in List view")
		[ ] 
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC185_ScheduleTwiceAMonthInvoiceB()#################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC185_ScheduleTwiceAMonthInvoiceB()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a  invoice reminder twice a month on two particular days.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If bi weekly reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April 9, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC185_ScheduleTwiceAMonthInvoiceB() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sCompareDate1,sCompareDate2,sMonth,sYear,sDay1,sDay2
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification1,lsBillVerification2
		[ ] DATETIME dtDateTime
		[ ] INTEGER iMonth,iDay1,iDay2
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Twice a month"
		[ ] 
		[ ] iDay1=5
		[ ] iDay2=19
		[ ] 
		[ ] dtDateTime= GetDateTime ()
		[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] iMonth=val(sMonth)+1
		[ ] 
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] 
		[ ] sCompareDate1="{iMonth}" +"/"+"{iDay1}"+"/"+sYear
		[ ] sCompareDate2="{iMonth}" +"/"+"{iDay2}"+"/"+sYear
		[ ] 
		[ ] lsBillVerification1 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate1,sReminderType} 
		[ ] lsBillVerification2 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate2,sReminderType} 
		[ ] 
		[ ] 
	[ ] 
	[ ] // 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] 
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#4")
			[ ] DlgOptionalSetting.TwiceAMonthOnPopupList.Select(iDay1)
			[ ] DlgOptionalSetting.TwiceAMonthAndPopupList.Select(iDay2)
			[ ] DlgOptionalSetting.OKButton.Click()
			[ ] 
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] iValidate=NULL
	[ ] iValidate=NavigateQuickenTab(sTAB_BILL)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Navigate to Bills Tab",PASS,"Bills tab opened")
		[ ] 
		[ ] //Select List from View options
		[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
		[ ] 
		[ ] //Select 90 days from duration dropdown
		[ ] MDIClient.Bills.DueWithinNextPopupList.Select(4)
		[ ] 
		[ ] //Get Handle of list
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] iListCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
		[ ] 
		[ ] //Verify Invoice Reminder for 1st date
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[ ] 
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification1[4]}*",sActual)
			[+] if (bMatch)
				[ ] //Verify Reminder for 1st date
				[+] for(i=1; i<= Listcount(lsBillVerification1); i++)
					[ ] bResult = MatchStr("*{lsBillVerification1[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification1[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification1[i]} is NOT added, sActual = {sActual}")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] break
				[ ] 
				[ ] 
			[ ] 
		[+] if(bMatch==FALSE)
			[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification2[4]} is NOT added.")
		[ ] 
		[ ] 
		[ ] //Veirfy Invoice Reminder for 2nd date
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[ ] 
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification2[4]}*",sActual)
			[+] if (bMatch)
				[ ] //Verify Reminder for 1st date
				[+] for(i=1; i<= Listcount(lsBillVerification2); i++)
					[ ] bResult = MatchStr("*{lsBillVerification2[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification2[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification2[i]} is NOT added, sActual = {sActual}")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] break
				[ ] 
				[ ] 
			[ ] 
		[+] if(bMatch==FALSE)
			[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification2[4]} is NOT added.")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to Bills Tab",FAIL,"Bills tab not opened")
		[ ] 
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC186_ScheduleQuarterlyInvoice()######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC186_ScheduleQuarterlyInvoice()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a quaterly invoice reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If quaterly invoice reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 9, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC186_ScheduleQuarterlyInvoice() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Quarterly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sReminderType} 
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#5")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] 
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] iListCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[ ] 
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[3]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC187_ScheduleYearlyInvoice()#######################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC187_ScheduleYearlyInvoice()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a yearly Invoice reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If yearly invoice reminder is scheduled.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 4, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC187_ScheduleYearlyInvoice() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Yearly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sReminderType} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#6")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] 
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] iListCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[ ] 
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[3]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[+] //###############TC188_ScheduleTwiceAYearInvoice()###################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC188_ScheduleTwiceAYearInvoice()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule a Invoice reminder for twice a year.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If yearly Invoice reminder is scheduled twice a year.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 9, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC188_ScheduleTwiceAYearInvoice() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Twice a year"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sReminderType} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#7")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] iListCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
		[ ] 
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[3]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[ ] 
		[ ] 
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] 
[+] //###############TC189_ScheduleInvoiceReminderTwiceAYearForTwoParticularDays()#################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC189_ScheduleInvoiceReminderTwiceAYearForTwoParticularDays()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule Invoice reminder for twice a year for two particular dates.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If yearly Invoice reminder is scheduled twice a year for two particular dates.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 9, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC189_ScheduleInvoiceReminderTwiceAYearForTwoParticularDays() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sCompareDate1,sCompareDate2
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification1,lsBillVerification2
		[ ] 
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Twice a year"
		[ ] 
		[ ] sCompareDate1=ModifyDate(2,"m/d/yyyy")
		[ ] sCompareDate2=ModifyDate(200,"m/d/yyyy")
		[ ] 
		[ ] lsBillVerification1 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate1,sReminderType} 
		[ ] lsBillVerification2 = {sPayeeName,sTransactionAmount,sHowOften,sCompareDate2,sReminderType} 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] // 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#7")
			[ ] DlgOptionalSetting.TwiceAYearOnTextField.SetText(sCompareDate1)
			[ ] DlgOptionalSetting.TwiceAYearAndTextField.SetText(sCompareDate2)
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] 
	[ ] NavigateQuickenTab(sTAB_BILL)
	[+] if (MDIClient.Bills.Exists(5))
		[ ] 
		[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
		[ ] MDIClient.Bills.DueWithinNextPopupList.Select(5)
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] iListCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
		[ ] 
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification1[4]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification1); i++)
					[ ] bResult = MatchStr("*{lsBillVerification1[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification1[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification1[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[+] if(bMatch==FALSE)
			[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification1} is NOT added.")
		[ ] 
		[ ] //VeirfyTransfer Reminder for 2nd date
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification2[4]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification2); i++)
					[ ] bResult = MatchStr("*{lsBillVerification2[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification2[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification2[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[+] if(bMatch==FALSE)
			[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification2[4]} is NOT added.")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Bill window is NOT open")
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //####################################################################################
[ ] 
[ ] 
[+] //###############TC190_ScheduleOnlyOnceInvoiceReminder()####################################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC190_ScheduleOnlyOnceInvoiceReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify if user is able to schedule an only once Invoice reminder.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If Invoice reminder is scheduled for only once.
		[ ] //				       	Fail		      If any error occurs 
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 9, 2013       Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC190_ScheduleOnlyOnceInvoiceReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Only Once"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften,sReminderType} 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#8")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] 
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] iListCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
		[ ] 
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[3]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //####################################################################################
[ ] 
[ ] 
[+] //###############TC192_VerifyEndOnOptionTransferReminder()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC192_VerifyEndOnOptionTransferReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality of  'End On' option for a Invoice reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If correct number of reminders are scheduled.
		[ ] //				       	Fail		      If any error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April  9, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC192_VerifyEndOnOptionTransferReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sEndDate
		[ ] INTEGER iExpectedNumberOfReminders,iActualNumberOfReminders
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Monthly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] iExpectedNumberOfReminders=4
		[ ] 
		[ ] sEndDate=ModifyDate(100,"m/d/yyyy")
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#3")
			[ ] DlgOptionalSetting.EndDatePopupList.Select(2)
			[ ] DlgOptionalSetting.EndOnTextField.SetText(sEndDate)
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify that correct number ofTransfer reminders are added
	[ ] //Select 12 Months from Due Within Next PopupList
	[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
	[ ] MDIClient.Bills.DueWithinNextPopupList.Select(5)
	[ ] iActualNumberOfReminders=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
	[+] if(iActualNumberOfReminders==iExpectedNumberOfReminders)
		[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Correct number of Invoice Reminders added: {iExpectedNumberOfReminders}")
	[+] else
		[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Wrong number of Invoice Reminders added: {iActualNumberOfReminders}")
	[ ] 
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] 
		[ ] 
		[ ] 
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] iListCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
		[ ] 
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[3]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //###################################################################################
[ ] 
[ ] 
[+] //###############TC193_VerifyEndAfterOptionTransferReminder()#############################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC193_VerifyEndAfterOptionTransferReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality of  'End after' option for a Invoice reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If correct number of reminders are scheduled.
		[ ] //				       	Fail		      If any error occurs..
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April  9, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC193_VerifyEndAfterOptionTransferReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sEndAfter
		[ ] INTEGER iExpectedNumberOfReminders,iActualNumberOfReminders
		[ ] BOOLEAN bResult
		[ ] LIST OF STRING lsBillVerification
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Monthly"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] iExpectedNumberOfReminders=3
		[ ] 
		[ ] sEndAfter="3"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] 
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#3")
			[ ] DlgOptionalSetting.EndDatePopupList.Select(3)
			[ ] DlgOptionalSetting.EndAfterTextField.SetText(sEndAfter)
			[ ] 
			[ ] 
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] //Verify that correct number ofTransfer reminders are added
	[ ] //Select 12 Months from Due Within Next PopupList
	[ ] MDIClient.Bills.ViewAsPopupList.Select(2)
	[ ] MDIClient.Bills.DueWithinNextPopupList.Select(5)
	[ ] iActualNumberOfReminders=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
	[+] if(iActualNumberOfReminders==iExpectedNumberOfReminders)
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Correct number ofTransfer Reminders added: {iExpectedNumberOfReminders}")
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Wrong number ofTransfer Reminders added: {iActualNumberOfReminders}")
	[ ] 
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] 
		[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
		[ ] iListCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
		[ ] 
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[3]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[ ] 
		[ ] DlgManageReminders.Close()
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //###################################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[+] //###############TCSetup_ReminderFrequencyEstimatedTaxReminders()###################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TCSetup_ReminderFrequencyEstimatedTaxReminders()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will setup the data file required for frequency test cases with a Checking,Savings, Customer Invoice and Vendor Invoice account
		[ ] //
		[ ] // RETURNS:			Pass 	   If setup is completed successfully
		[ ] //				        	Fail		   If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  April 8, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TCSetup_ReminderFrequencyEstimatedTaxReminders() appstate none
	[ ] 
	[ ] 
	[ ] // Create Data File
	[ ] iValidate = DataFileCreate(sFileName)
	[ ] // Report Staus If Data file Created successfully
	[+] if ( iValidate  == PASS)
		[ ] ReportStatus("Validate Data File ", iValidate, "Data file -  {sDataFile} is created")
		[ ] 
		[ ] 
		[ ] //Add a manual checking account.
		[ ] iValidate=AddManualSpendingAccount(IsAddAccount[1],IsAddAccount[2],IsAddAccount[3],IsAddAccount[4])
		[+] if(iValidate == PASS)
			[ ] ReportStatus("Add Checking Account", PASS, "Checking account is added.")
			[ ] 
			[ ] 
			[ ] //Add a manual savings account.
			[ ] iValidate=AddManualSpendingAccount(IsAddAccount1[1],IsAddAccount1[2],IsAddAccount1[3],IsAddAccount1[4])
			[+] if(iValidate == PASS)
				[ ] ReportStatus("Add Savings Account", PASS, "Savings account is added.")
				[ ] 
				[ ] //Add accounts payable
				[ ] iValidate=AddBusinessAccount(lsAddAccount3[1],lsAddAccount3[2])
				[+] if(iValidate == PASS)
					[ ] ReportStatus("Add Vendor Invoices Accountt", PASS, "Vendor Invoices account is added.")
					[ ] 
					[ ] //Add a accounts receivable
					[ ] iValidate=AddBusinessAccount(lsAddAccount4[1],lsAddAccount4[2])
					[+] if(iValidate == PASS)
						[ ] ReportStatus("Add Customer Invoices Accountt", PASS, "Customer Invoices account is added.")
					[+] else
						[ ] ReportStatus("Add Customer Invoices Account", FAIL, "Customer Invoices account is NOT added.")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Add Vendor Invoices Account", FAIL, "Vendor Invoices account is NOT added.")
			[ ] 
			[+] else
				[ ] ReportStatus("Add Savings Account", FAIL, "Savings account is NOT added.")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Checking Account", FAIL, "Checking account is NOT added.")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else 
		[ ] ReportStatus("Validate Data File ", iValidate, "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //###############TC128_ScheduleEstimatedTaxesReminder()###########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC128_ScheduleEstimatedTaxesReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality that user can schedule 'To Pay estimated taxes' bill reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weekly bill reminder is scheduled.
		[ ] //				       	Fail		      If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April  4, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC128_ScheduleEstimatedTaxesReminder() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sDate
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sDate=ModifyDate(0,"m/d/yyyy")
		[ ] sReminderType = "Bill"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Estimated Tax"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDate)
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#11")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly bill gets added or not using Bill and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different bill parameters such as payee name, due date, bill amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] // //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //##############################################################################
[ ] 
[+] //###############TC149_ScheduleEstimatedTaxesReminderIncome()###########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC149_ScheduleEstimatedTaxesReminderIncome()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality that user can schedule 'To Pay estimated taxes' Income reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weekly Income reminder is scheduled.
		[ ] //				       	Fail		      If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April  4, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC149_ScheduleEstimatedTaxesReminderIncome() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sDate
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sDate=ModifyDate(2,"m/d/yyyy")
		[ ] sReminderType = "Income"
		[ ] sTransactionAmount = "7.55"
		[ ] sHowOften = "Estimated Tax"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDate)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#11")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify different Income parameters such as payee name, due date, Income amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Bill Reminder is NOT added")
	[ ] 
	[ ] // //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //##############################################################################
[ ] 
[+] //###############TC170_ScheduleEstimatedTaxesReminderTransfer()###########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC170_ScheduleEstimatedTaxesReminderTransfer()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality that user can schedule 'To Pay estimated taxes'Transfer reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weeklyTransfer reminder is scheduled.
		[ ] //				       	Fail		      If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April  4, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC170_ScheduleEstimatedTaxesReminderTransfer() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sDate
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sDate=ModifyDate(4,"m/d/yyyy")
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "8.11"
		[ ] sHowOften = "Estimated Tax"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDate)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(!DlgOptionalSetting.Exists(2))
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
			[ ] 
		[ ] 
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#11")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[+] for(i=1; i<= Listcount(lsBillVerification); i++)
			[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
			[+] if(bResult==TRUE)
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
			[+] else
				[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
	[ ] 
	[ ] 
	[ ] // //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Reminder NOT deleted")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#################################################################################
[ ] 
[+] //###############TC191_ScheduleEstimatedTaxesReminderInvoice()###########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC191_ScheduleEstimatedTaxesReminderInvoice()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify functionality that user can schedule 'To Pay estimated taxes' Invoice reminder
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If weekly Invoice reminder is scheduled.
		[ ] //				       	Fail		      If weekly reminder is not scheduled or error occurs.
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   April  9, 2013		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC191_ScheduleEstimatedTaxesReminderInvoice() appstate none
	[+] // Variable declaration and definition
		[ ] STRING  sHowOften, sDayOfMonth,sDate
		[ ] boolean bResult
		[ ] List of STRING lsBillVerification
		[ ] 
		[ ] sDate=ModifyDate(6,"m/d/yyyy")
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Estimated Tax"
		[ ] lsBillVerification = {sPayeeName,sTransactionAmount,sHowOften} 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
	[+] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Invoice Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sDate)
		[ ] //Add Invoice Reminder
		[ ] DlgAddEditReminder.TextClick("Add invoice details")
		[ ] iValidate=NULL
		[ ] iValidate=AddBusinessInvoiceTransaction(sPayeeName,lsAddInvoice[2],lsAddInvoice[3],lsAddInvoice[4],lsAddInvoice[5],lsAddInvoice[6],lsAddInvoice[7],lsAddInvoice[8],lsAddInvoice[9],lsAddInvoice[10])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add details to Invoice Reminder form", PASS, " Data fields in Invoice Reminder form populated successfully.")
		[+] else
			[ ] ReportStatus("Add details to Invoice Reminder form", FAIL, " Data fields in Invoice Reminder form populated successfully.")
		[ ] 
		[ ] 
		[ ] 
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgOptionalSetting.Exists(5))
			[ ] ReportStatus("Setup how frequent", PASS, " Set up how frequent dialog is launched")
			[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
			[ ] DlgOptionalSetting.HowOftenPopupList.Select("#11")
			[ ] DlgOptionalSetting.OKButton.Click()
		[+] else
			[ ] ReportStatus("Setup how frequent", FAIL, " Set up how frequent dialog is NOT launched")
		[ ] DlgAddEditReminder.DoneButton.Click()
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] //Verify if weeklyTransfer gets added or not usingTransfer and Transfer Reminder List (CTRL+J)
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
	[+] if (DlgManageReminders.Exists(5))
		[ ] DlgManageReminders.AllBillsDepositsTab.Click()
		[ ] 
		[ ] // Verify differentTransfer parameters such as payee name, due date,Transfer amount and payment method
		[ ] 
		[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
		[ ] iListCount = DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
		[ ] 
		[+] for (iCount =0 ; iCount<=iListCount ; iCount++)
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
			[ ] bMatch = MatchStr("*{lsBillVerification[3]}*",sActual)
			[+] if (bMatch)
				[+] for(i=1; i<= Listcount(lsBillVerification); i++)
					[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
					[+] if(bResult==TRUE)
						[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
				[ ] break
		[+] if(bMatch == FALSE)
			[ ] ReportStatus("Verify Reminder in List view", FAIL, "Reminder {lsBillVerification}  is not available in Reminder in List view")
		[ ] 
		[ ] DlgManageReminders.Close()
	[+] else
		[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder is NOT added")
	[ ] 
	[ ] //Delete Invoices
	[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
	[+] else
		[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
	[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[ ] 
[+] //###############TC194_Verify_Enter_Functionality_For_Scheduled_Transaction_For_Defect_QW3066()###########################
	[ ] // **************************************************************************************
	[+] // TestCase Name:	TC194_Verify_Enter_Functionality_For_Scheduled_Transaction_For_Defect_QW3066()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This test case will Verify scenario for defect QW03066
		[ ] // Schedule a bill reminder with exactly same details of manual transaction
		[ ] // From 'Bills Tab -> Upcoming-> List View' , click 'Enter' button
		[ ] // Add one income reminder for today's date. 
		[ ] // Enter this reminder using 'Enter' button in front of this reminder on 'Bills Tab -> Upcoming-> List View'. 
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass		If Enter functionality works correctly
		[ ] //				       	Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	   March  6, 2014		Dean Paes created
	[ ] // **************************************************************************************
[+] testcase TC194_Verify_Enter_Functionality_For_Scheduled_Transaction_For_Defect_QW3066() appstate none
	[ ] 
	[+] // Variable Declaration
		[ ] 
		[ ] INTEGER iCount
		[ ] STRING sDate=ModifyDate(0,"m/d/yyyy")
		[ ] 
		[ ] STRING sEnterCommand="Enter"
		[ ] STRING sPaidText="Paid"
		[ ] STRING sReceivedText="Received"
		[ ] 
		[ ] 
		[ ] // --------------FOR BILL REMINDER---------------------
		[ ] STRING sReminderTypeBill,sPayeeNameBill,sTransactionAmountBill
		[ ] LIST OF STRING lsBillVerification,lsTransactionBill
		[ ] // Fetch ith row from the given sheet
		[ ] lsExcelData=ReadExcelTable(sExcelDataFile,sTransactionWorksheet)
		[ ] lsTransactionBill=lsExcelData[1]
		[ ] 
		[ ] // For Reminder
		[ ] sReminderTypeBill = lsTransactionBill[11]
		[ ] sPayeeNameBill=lsTransactionBill[6]
		[ ] sTransactionAmountBill = lsTransactionBill[3]
		[ ] 
		[ ] lsBillVerification = {sReminderTypeBill,sPayeeNameBill,sTransactionAmountBill} 
		[ ] 
		[ ] 
		[ ] //-------------------------------------------------------------------------
		[ ] //-------------------------------------------------------------------------
		[ ] 
		[ ] 
		[ ] 
		[ ] // ----------------FOR INCOME REMINDER--------------
		[ ] STRING sReminderTypeIncome,sPayeeNameIncome,sTransactionAmountIncome
		[ ] LIST OF STRING lsIncomeVerification,lsTransactionIncome
		[ ] 
		[ ] // Fetch ith row from the given sheet
		[ ] lsExcelData=ReadExcelTable(sExcelDataFile,sTransactionWorksheet)
		[ ] lsTransactionIncome=lsExcelData[2]
		[ ] 
		[ ] // For Reminder
		[ ] sReminderTypeIncome = lsTransactionIncome[11]
		[ ] sPayeeNameIncome=lsTransactionIncome[6]
		[ ] sTransactionAmountIncome = lsTransactionIncome[3]
		[ ] 
		[ ] lsIncomeVerification={sReminderTypeIncome,sPayeeNameIncome,sTransactionAmountIncome}
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] iValidate=SelectAccountFromAccountBar(IsAddAccount[2],ACCOUNT_BANKING)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Select Account From Account bar",PASS,"Account {IsAddAccount[2]} selected from account bar")
		[ ] 
		[ ] iValidate=AddCheckingTransaction(lsTransactionBill[1],lsTransactionBill[2],lsTransactionBill[3],sDate,lsTransactionBill[5],lsTransactionBill[6],lsTransactionBill[7],lsTransactionBill[8])
		[ ] 
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add Checking Transaction",PASS,"Transaction with Payee {lsTransactionBill[6]} added")
			[ ] 
			[ ] //Verify for bill reminder
			[ ] iValidate=NavigateReminderDetailsPage(sReminderTypeBill,sPayeeNameBill)
			[+] if(iValidate==PASS)
				[ ] 
				[ ] iValidate=AddReminderInDataFile(sReminderTypeBill,sPayeeNameBill,sTransactionAmountBill,sDate)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Add Bill Reminder in Data file",PASS,"Reminder with Payee {sPayeeNameBill} is added")
					[ ] 
					[ ] 
					[ ] 
					[ ] iValidate=BillsTabListViewOperations(sPayeeNameBill,sEnterCommand)
					[+] if(iValidate==PASS)
						[ ] 
						[ ] //check the paid checkbox
						[ ] NavigateQuickenTab(sTAB_BILL)
						[ ] MDIClient.Bills.IncludePaid.Check()
						[ ] 
						[ ] 
						[ ] //Verify if Bill Reminder is entered
						[ ] sHandle=Str(MDIClient.Bills.ListBox.GetHandle())
						[+] for(iCount=0;iCount<=MDIClient.Bills.ListBox.GetItemCount();iCount++)
							[ ] 
							[ ] 
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
							[ ] 
							[ ] bMatch=MatchStr("*{sPayeeNameBill}*{sPaidText}*",sActual)
							[+] if(bMatch==TRUE)
								[ ] break
							[ ] 
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify bill reminder is geeting displayed as paid in the list view of the Bill tab",PASS,"Bill Reminder with Payee {sPayeeNameBill} is entered and displayed as Paid in Bills tab listview.")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify bill reminder is geeting displayed as paid in the list view of the Bill tab",FAIL,"Bill Reminder with Payee {sPayeeNameBill} is entered but didn't display as Paid in Bills tab listview.")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Enter Bill Reminder",FAIL,"Bill Reminder with Payee {sPayeeNameBill} is NOT entered")
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Add Bill Reminder in Data file",FAIL,"Reminder with Payee {sPayeeNameBill} is NOT added")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Bill Reminder screen two is not displayed")
				[ ] 
			[ ] 
			[ ] 
			[ ] //Verify for income reminder
			[ ] iValidate=NavigateReminderDetailsPage(sReminderTypeIncome,sPayeeNameIncome)
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] iValidate=AddReminderInDataFile(sReminderTypeIncome,sPayeeNameIncome,sTransactionAmountIncome,sDate)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Add Income Reminder in Data file",PASS,"Reminder with Payee {sPayeeNameIncome} is added")
					[ ] 
					[ ] iValidate=BillsTabListViewOperations(sPayeeNameIncome,sEnterCommand)
					[+] if(iValidate==PASS)
						[ ] 
						[ ] NavigateQuickenTab(sTAB_BILL)
						[ ] MDIClient.Bills.IncludePaid.Check()
						[ ] 
						[ ] //Verify if Income Reminder is entered
						[ ] sHandle=Str(MDIClient.Bills.ListBox.GetHandle())
						[+] for(iCount=0;iCount<=MDIClient.Bills.ListBox.GetItemCount();iCount++)
							[ ] 
							[ ] 
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(iCount))
							[ ] 
							[ ] bMatch=MatchStr("*{sPayeeNameIncome}*{sReceivedText}*",sActual)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Enter Income Reminder",PASS,"Income Reminder with Payee {sPayeeNameIncome} is entered")
								[ ] break
							[ ] 
							[ ] 
							[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify income reminder is getting displayed as Recieved in the list view of the Bill tab",PASS,"Income Reminder with Payee {sPayeeNameIncome} is entered and displayed as Recieved in Bills tab listview.")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify bill reminder is getting displayed as Recieved in the list view of the Bill tab",FAIL,"Income Reminder with Payee {sPayeeNameIncome} is entered but didn't display as Recieved in Bills tab listview.")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Enter Income Reminder",FAIL,"Income Reminder with Payee {sPayeeNameIncome} is NOT entered")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Add Income Reminder in Data file",FAIL,"Reminder with Payee {sPayeeNameIncome} is NOT added")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Add Checking Transaction",FAIL,"Transaction with Payee {lsTransactionBill[6]} NOT added")
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Select Account From Account bar",FAIL,"Account {IsAddAccount[2]} NOT selected from account bar")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[ ] 
[ ] 
[ ] 
