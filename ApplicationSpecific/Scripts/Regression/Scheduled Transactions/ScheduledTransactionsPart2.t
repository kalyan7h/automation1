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
[ ] // 
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
[-] testcase TCSetup_ReminderFrequencyDataFile() appstate QuickenBaseState
	[ ] 
	[ ] 
	[ ] //SkipRegistration
	[ ] SkipRegistration()
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
		[ ] CloseAddLinkBiller()
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
					[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
				[+] else
					[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsBillVerification} is NOT added, sActual = {sActual}")
			[ ] DlgManageReminders.Close()
			[ ] 
			[ ] // //Delete Bill Reminder
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Bill Reminder", PASS, "Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
			[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] //Delete Bill Reminder
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Single Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
			[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] //Delete Bill Reminder
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Single Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
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
		[ ] CloseAddLinkBiller()
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
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
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
		[ ] CloseAddLinkBiller()
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
			[ ] //Delete Bill Reminder
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
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
		[ ] CloseAddLinkBiller()
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
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] // 
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
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
		[ ] CloseAddLinkBiller()
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
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
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
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Bills Tab",FAIL,"Bills tab not opened")
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
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill window is NOT open")
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] // //Delete Bills
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] //Delete Income Reminder
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Online Income Reminder is NOT added")
		[ ] 
		[ ] 
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] 
			[ ] //Delete Income Reminder
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
				[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
		[ ] CloseAddLinkBiller()
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
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Bill Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
			[ ] //Delete Income Reminder
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] 
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] 
		[ ] CloseAddLinkBiller()
		[ ] 
		[ ] 
		[ ] //Verify if weekly Income gets added or not using Income and Income Reminder List (CTRL+J)
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Bills Tab",FAIL,"Bills tab not opened")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Bill window is NOT open")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
			[ ] // //Delete Incomes
			[ ] 
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Bill Reminder", PASS, " Bill Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Bill Reminder", FAIL, "Bill Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
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
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] // //Delete Incomes
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
			[ ] // //Delete Incomes
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Income Reminder", PASS, "Single Income Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Income Reminder", FAIL, "Single Income Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
	[-] if( iValidate==PASS)
		[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Transfer Reminder dialog second screen is displayed.")
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.ToAccountTextField.SetText(IsAddAccount1[2])
		[ ] 
		[ ] // 
		[ ] //DlgAddEditReminder.Step2Panel.QWinChild1.DueDateChangeLink.Click()
		[+] if(DlgAddEditReminder.Exists(2))
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] CloseAddLinkBiller()
			[ ] 
		[ ] //Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
		[-] if (DlgManageReminders.Exists(5))
			[ ] DlgManageReminders.AllBillsDepositsTab.Click()
			[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
			[ ] 
			[ ] // Verify different bill parameters such as payee name, due date, bill amount and how often
			[-] for(i=1; i<= Listcount(lsBillVerification); i++)
				[ ] bResult = MatchStr("*{lsBillVerification[i]}*",sActual)
				[-] if(bResult==TRUE)
					[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{lsBillVerification[i]}' is added successfully")
				[-] else
					[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification} is NOT added, sActual = {sActual}")
			[ ] DlgManageReminders.Close()
			[ ] 
			[ ] // //Delete Incomes
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Transfer Reminder", PASS, "Single Transfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Transfer Reminder", FAIL, "Single Transfer Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] 
			[ ] // //Delete Incomes
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Transfer Reminder", PASS, "Single Transfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Transfer Reminder", FAIL, "Single Transfer Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder is NOT added")
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
		[ ] CloseAddLinkBiller()
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
					[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
			[ ] DlgManageReminders.Close()
			[ ] 
			[ ] // //Delete Reminder
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Single Transfer Reminder", PASS, "Single Transfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Transfer Reminder", FAIL, "Single Transfer Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Bill Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
		[ ] CloseAddLinkBiller()
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
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] 
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
				[+] else
					[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
			[ ] DlgManageReminders.Close()
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
			[ ] //DeleteTransfer Reminder
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
				[+] else
					[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
			[ ] DlgManageReminders.Close()
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //#############################################################################
[ ] 
[ ] // 
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
		[ ] INTEGER iDay1,iDay2,iMonth ,iYear
		[ ] 
		[ ] sReminderType = "Transfer"
		[ ] sTransactionAmount = "3.12"
		[ ] sHowOften = "Twice a month"
		[ ] 
		[ ] iDay1=5
		[ ] iDay2=19
		[ ] 
		[ ] dtDateTime= GetDateTime ()
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] iMonth=val(sMonth)
		[+] if (iMonth==12)
			[ ] iMonth=1
			[ ] iYear=val(sYear) +1
			[ ] sYear= str(iYear)
		[+] else
			[ ] iMonth=iMonth+1
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
	[-] if( iValidate==PASS)
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Bills Tab",FAIL,"Bills tab not opened")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
				[+] else
					[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
			[ ] DlgManageReminders.Close()
			[ ] 
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
				[+] else
					[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
			[ ] DlgManageReminders.Close()
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] 
		[ ] CloseAddLinkBiller()
		[ ] 
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Bill window is NOT open")
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
		[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
			[ ] // //DeleteTransfers
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete SingleTransfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] // //DeleteTransfers
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete SingleTransfer Reminder", PASS, "SingleTransfer Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Single Transfer Reminder", FAIL, "SingleTransfer Reminder not deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] //###################################################################################
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
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] 
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Reminder NOT deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder is NOT added")
			[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Reminder NOT deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
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
		[ ] CloseAddLinkBiller()
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
					[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
			[ ] DlgManageReminders.Close()
			[ ] 
			[ ] 
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Reminder NOT deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AddCategoryTagMemoPanel1.AddDetails.Click()  
		[ ] // DlgAddEditReminder.TextClick("Add invoice details")
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
		[ ] 
		[ ] CloseAddLinkBiller()
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
					[ ] ReportStatus("Verification of  added Invoice Reminder ", PASS, "Invoice Reminder with '{lsBillVerification[i]}' is added successfully")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
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
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Invoice Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Invoice Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Invoice Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Invoice Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] INTEGER iMonth,iDay1,iDay2 ,iYear
		[ ] 
		[ ] sReminderType = "Invoice"
		[ ] sTransactionAmount = "75.00"
		[ ] sHowOften = "Twice a month"
		[ ] 
		[ ] iDay1=5
		[ ] iDay2=19
		[ ] 
		[ ] dtDateTime= GetDateTime ()
		[ ] sYear=FormatDateTime(GetDateTime(), "yyyy") //Get current year
		[ ] sMonth=FormatDateTime(GetDateTime(), "m") //Get current month
		[ ] iMonth=val(sMonth)
		[+] if (iMonth==12)
			[ ] iMonth=1
			[ ] iYear=val(sYear) +1
			[ ] sYear= str(iYear)
		[+] else
			[ ] iMonth=iMonth+1
		[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Bills Tab",FAIL,"Bills tab not opened")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
		[ ] 
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
		[ ] CloseAddLinkBiller()
		[ ] 
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
			[ ] 
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] CloseAddLinkBiller()
		[ ] 
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
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Bill window is NOT open")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
	[ ] 
	[ ] 
	[ ] //#############################################################################
[ ] // ####################################################################################
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
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
	[ ] 
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
		[ ] CloseAddLinkBiller()
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
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
			[ ] // //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Reminder NOT deleted")
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
		[ ] CloseAddLinkBiller()
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
					[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Bill Reminder with '{lsBillVerification[i]}' is added successfully")
				[+] else
					[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Bill Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
			[ ] DlgManageReminders.Close()
			[ ] 
			[ ] // //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Reminder NOT deleted")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Bill Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
				[+] else
					[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder for {lsBillVerification[i]} is NOT added, sActual = {sActual}")
			[ ] DlgManageReminders.Close()
			[ ] 
			[ ] // //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Reminder NOT deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  addedTransfer Reminder ", FAIL, "Transfer Reminder is NOT added")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
		[ ] CloseAddLinkBiller()
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
			[ ] 
			[ ] //Delete Invoices
			[ ] iValidate=ReminderOperations(sDeleteCommand,sPayeeName,sReminderType)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Delete Reminder", PASS, "Invoice Reminder deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Reminder", FAIL, "Invoice Reminder NOT deleted")
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Invoice Reminder ", FAIL, "Invoice Reminder is NOT added")
		[ ] 
	[+] else
		[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Transfer Reminder screen two is not displayed")
		[ ] DlgAddEditReminder.Close()
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
