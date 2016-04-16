[ ] 
[-] // *** DATA DRIVEN ASSISTANT Section (!! DO NOT REMOVE !!) ***
	[ ] use "datadrivetc.inc"
	[ ] use "SmokeQuicken.t"
	[ ] 
	[ ] // *** DSN ***
	[ ] STRING gsDSNConnect = "DSN=Silk DDA Excel;DBQ=D:\Quicken\ApplicationSpecific\Data\TestData\DataDrivenXLS\SmokeTestData.xls;UID=;PWD=;"
	[ ] //STRING gsDSNConnect = "DSN=Silk DDA Excel;DBQ=D:\Quicken\ApplicationSpecific\Data\TestData\DataDrivenXLS\BatData.xls;UID=;PWD=;"
	[ ] 
	[ ] // *** Global record for each testcase ***
	[ ] 
	[+] type REC_DATALIST_DD_Test37_CreateReminder is record
		[ ] REC_Reminder_ recReminder_  //Reminder$, 
	[ ] 
	[ ] // *** Global record for each Table ***
	[ ] 
	[+] type REC_Reminder_ is record
		[ ] STRING WindowName  //Window Name, 
		[ ] STRING Payee  //Payee, 
		[ ] REAL Amount  //Amount, 
		[ ] DATETIME xDate  //Date, 
		[ ] STRING Frequency  //Frequency, 
		[ ] STRING PayeeAccount  //PayeeAccount, 
		[ ] STRING Category  //Category, 
		[ ] STRING PayTo  //PayTo, 
		[ ] STRING ReminderType  //ReminderType, 
		[ ] ANYTYPE RowNo  //Row No, 
	[ ] 
	[ ] // *** Global record containing sample data for each table ***
	[ ] // *** Used when running a testcase with 'Use Sample Data from Script' checked ***
	[ ] 
	[+] // REC_Reminder_ grTest_Reminder_ = {...}
		[ ] // "name" // WindowName
		[ ] // NULL // Payee
		[ ] // NULL // Amount
		[ ] // NULL // xDate
		[ ] // NULL // Frequency
		[ ] // NULL // PayeeAccount
		[ ] // NULL // Category
		[ ] // NULL // PayTo
		[ ] // NULL // ReminderType
		[ ] // NULL // RowNo
	[ ] 
	[ ] // *** End of DATA DRIVEN ASSISTANT Section ***
	[ ] 
[-] testcase DD_Test37_CreateReminder (REC_DATALIST_DD_Test37_CreateReminder rData) appstate SmokeBaseState
	[ ] // Testcase Header
	[ ] WriteHeader()
	[ ] 
	[ ] // Variable Declaration
	[ ] BOOLEAN bPayee, bAmount, bState
	[ ] STRING sHandle, sActual, sWindowName
	[ ] INTEGER iAdd, iNavigate
	[ ] 
	[ ] STRING sDate = FormatDateTime(rData.recReminder_.xDate, "mm/dd/yyyy")
	[-] if(Quicken2011RentalPropertyM.Exists())
		[ ] Quicken2011RentalPropertyM.SetActive ()
		[ ] 
		[ ] iNavigate = NavigateQuickenTab("Bills")
		[-] if (iNavigate == PASS)
				[ ] 
				[ ] iAdd = AddReminder(rData.recReminder_.WindowName, rData.recReminder_.Payee , Str(rData.recReminder_.Amount, NULL, 2), sDate, rData.recReminder_.Frequency, rData.recReminder_.PayeeAccount, rData.recReminder_.Category, rData.recReminder_.PayTo, rData.recReminder_.ReminderType)
				[-] if (iAdd == PASS)
					[ ] ReportStatus("Create Income Reminder ", iAdd, "Income Reminder with Payee Name {rData.recReminder_.Payee} and amount {Str(rData.recReminder_.Amount, NULL, 2)} created")
					[ ] 
					[ ] iNavigate = NavigateQuickenTab(sHomeTab)
					[ ] Home.SetActive()
					[ ] sHandle= Str(Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.BILLANDINCOMEREMINDERSNE.QWListViewer.ListBox.GetHandle ())
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(rData.recReminder_.RowNo))
					[ ] bPayee = MatchStr("*{rData.recReminder_.Payee}*", sActual)
					[ ] bAmount = MatchStr("*{Str(rData.recReminder_.Amount, NULL, 2)}*", sActual)
					[-] if (bPayee == TRUE && bAmount == TRUE)
						[ ] ReportStatus("Validate Payee name and Amount ", PASS, "Bill is displayed on Home Tab with Payee - {rData.recReminder_.Payee} and Amount - {Str(rData.recReminder_.Amount, NULL, 2)}")
						[ ] 
					[-] else
						[ ]  ReportStatus("Validate Payee name and Amount ", FAIL, "Expected Value - {rData.recReminder_.Payee} of Payee and Expected Value - {Str(rData.recReminder_.Amount, NULL, 2)} of Amount, Actual Value -  {sActual}")
						[ ] 
				[-] else
					[ ] ReportStatus("Create Income Reminder ", iAdd, "Income Reminder is not created")
					[ ] 
				[ ] 
		[-] else
			[ ] ReportStatus("Validate Bills tab state", iNavigate, "Bills tab is not active") 
			[ ] 
	[-] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
	[ ] //Testcase Footer
	[ ] WriteFooter(CURRENT_TEST_STATUS)
