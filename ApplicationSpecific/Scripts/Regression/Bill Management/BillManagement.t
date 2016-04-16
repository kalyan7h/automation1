﻿[ ] 
[ ] // *********************************************************
[+] // FILE NAME:	<BillManagement.t>
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
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[ ] 
[ ] 
[+] // Global variables 
	[ ] 
	[ ] 
	[ ] //--------------EXCEL DATA----------------
	[ ] // .xls file
	[ ] public STRING sBillManagementExcelSheet="BillManagement"
	[ ] //Excel Sheets
	[ ] public STRING sBankingAccountSheet="BankingAccounts"
	[ ] public STRING sBillReminderSheet="BillReminder"
	[ ] public STRING sBusinessAccountSheet="BusinessAccounts"
	[ ] public STRING sBillReminderSheet2="BillReminder2"
	[ ] public STRING sPaycheckSheet="Paycheck"
	[ ] 
	[ ] //----------STRING-------------------
	[ ] // public STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] public STRING sBillsFileName="BillManagementDataFile"
	[ ] public STRING sDateFormat="m/d/yyyy"
	[ ] public STRING sDate=ModifyDate(0,sDateFormat)
	[ ] public STRING sDelete="Delete"
	[ ] public STRING sSkip="Skip"
	[ ] public STRING sEnter="Enter"
	[ ] public STRING sMDIWindow="MDI"
	[ ] // public STRING sNoBillsReadLine="You don't have any scheduled bills or deposits due for this account"
	[ ] public STRING sNoBillsReadLine="You have no items due or pending in the next"
	[ ] 
	[ ] public STRING sMonthlyListOption,sListOption,sStackOption
	[ ] 
	[ ] 
	[ ] STRING sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
	[ ] 
	[ ] 
	[ ] //---------LIST OF STRING-----------
	[ ] LIST OF STRING lsAddAccount,lsReminderData,lsAddBill,lsAddAccount1,lsAddAccount2,lsReminderList
	[ ] 
	[ ] 
	[ ] //---------LIST OF ANYTYPE-----------
	[ ] LIST OF ANYTYPE lsExcelData
	[ ] 
	[ ] 
	[ ] //------------------INTEGER----------------
	[ ] public INTEGER iValidate,i,iDays,j,iCount ,iListCount ,iCounter
	[ ] 
	[ ] 
	[ ] //--------------BOOLEAN---------------
	[ ] public BOOLEAN bMatch
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[+] //Global Functions
	[+] public OpenManageReminders()
		[ ] NavigateQuickenTab(sTAB_BILL)
		[+] if (QuickenMainWindow.QWNavigator.ManageReminders.Exists())
			[ ] QuickenMainWindow.QWNavigator.ManageReminders.Click()
		[+] else
			[ ] QuickenWindow.TypeKeys(KEY_CTRL_J)
		[ ] 
		[+] if (DlgManageReminders.Exists(5))
			[ ] DlgManageReminders.SetActive()
			[ ] DlgManageReminders.Maximize()
		[+] else
			[ ] ReportStatus("Verify Manage Remiders dialog displayed",FAIL,"Manage Reminders dialog didn't display.")
[ ] 
[ ] 
[+] //########## Verify the Functionality of Bills tab by opening Bills page when no bills are set ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01A_No_Bills_Added_In_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the Functionality of  Bills tab by opening Bills page when no accounts are added and no bills are set.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Get Started button is displayed	on bills tab , Clicking on Get Started button opens Add An Account dialog					
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  22th  May 2013
		[ ] //
	[ ] // ********************************************************
[-] testcase Test01A_No_Bills_Added_In_Data_File() appstate QuickenBaseState
	[ ] 
	[+] //--------------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] //Location Co ordinates for mouse click on Get Started button on Zero data state screen
		[ ] INTEGER iGetStartedXCord,iGetStartedYCord
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] //------------Variable Declaration--------------
		[ ] 
		[ ] iGetStartedXCord=277
		[ ] iGetStartedYCord=360
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] iValidate=DataFileCreate(sBillsFileName)
	[+] if(iValidate==PASS)
		[ ] ReportStatus("Create Data File",PASS,"Data File created successfully")
		[ ] 
		[ ] 
		[ ] //----------Expand Account Bar--------------
		[ ] ExpandAccountBar()
		[ ] 
		[ ] //-------------Navigate to Bills tab----------------
		[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
		[ ] 
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Navigate to Bills Upcoming Tab",PASS,"Navigated to Bills Upcoming Tab successfully")
			[ ] //QuickenWindow.SetActive()
			[ ] //------------------Verify that "Get Started" button should be present if no account is added---------------------
			[+] if(GetStarted.Exists(5))
				[ ] 
				[ ] ReportStatus("Get Started button should be present",PASS,"Get Started button exists")
				[ ] 
				[ ] //----------------------------------Click on Get Started button and verify window -------------------------------
				[ ] GetStarted.Click()
				[ ] 
				[+] if(AddAnyAccount.Exists(LONG_SLEEP))
					[ ] ReportStatus("Verify Add an Account Dialogbox",PASS,"Add an Account Dialogbox opened successfully")
					[ ] AddAnyAccount.Close()
					[ ] WaitForState(AddAnyAccount,FALSE,SHORT_SLEEP)
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Add an Account Dialogbox",FAIL,"Add an account dialogbox didn't display")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Get Started button should be present",FAIL,"Get Started button does not exist if no accounts are added")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File not created")
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //########## Verify the Functionality of Bills tab by opening Bills page when no bills are set ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01B_No_Bills_Added_In_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the Functionality of  Bills tab by opening Bills page when accounts are added but no bills are set.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Get Started button is displayed	on bills tab , Clicking on Get Started button opens Stay on top of monthly bills dialog					
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  22th  May 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test01B_No_Bills_Added_In_Data_File() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] //Location Co ordinates for mouse click on Get Started button on Zero data state screen
		[ ] INTEGER iGetStartedXCord,iGetStartedYCord
		[ ] STRING sBackup
		[ ] 
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] iGetStartedXCord=282
		[ ] iGetStartedYCord=321
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] //Edit Date from Excel data
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] 
		[ ] sBackup="Backup"
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------------Disable Quicken Backup----------
		[ ] SelectPreferenceType(sBackup)
		[ ] Preferences.ManualBackupReminder.Uncheck()
		[ ] Preferences.OK.Click()
		[ ] WaitForState(Preferences,FALSE,SHORT_SLEEP)
		[ ] 
		[ ] 
		[ ] //----------Expand Account Bar--------------
		[ ] ExpandAccountBar()
		[ ] 
		[ ] 
		[ ] //----------------Add a Checking Account------------------
		[ ] iValidate=AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add A Checking Account",PASS,"Checking Account Added successfully")
			[ ] 
			[ ] 
			[ ] //-------------Navigate to Bills tab----------------
			[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Navigate to Bills Upcoming Tab",PASS,"Navigated to Bills Upcoming Tab successfully")
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] sleep(2)
				[ ] 
				[ ] //------------------Verify that "Get Started" button should be present if no account is added---------------------
				[+] if(GetStarted.Exists(5))
					[ ] ReportStatus("Get Started button should be present",PASS,"Get Started button exists")
					[ ] 
					[ ] sleep(2)
					[ ] 
					[ ] //----------------------------------Click on Get Started button and verify window -------------------------------
					[ ] GetStarted.DoubleClick()
					[ ] //Bills.Panel.QWMsHtmlVw1.ShellEmbedding1.ShellDocObjectView1.GetStartedBillsButton.Click(1,iGetStartedXCord,iGetStartedYCord)
					[ ] 
					[+] if(StayOnTopOfMonthlyBills.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify Stay On Top Of Monthly Bills Dialogbox",PASS,"Stay On Top Of Monthly Dialogbox opened successfully")
						[ ] StayOnTopOfMonthlyBills.Close()
						[ ] WaitForState(StayOnTopOfMonthlyBills,FALSE,SHORT_SLEEP)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Add an Account Dialogbox",FAIL,"Add an Account Dialogbox opened successfully")
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Get Started button should be present",FAIL,"Get Started button does not exist if no accounts are added")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
			[ ] 
		[+] else
			[ ] ReportStatus("Add A Checking Account",FAIL,"Checking Account not added")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //############# Verify the Functionality of Bills tab by opening Bills page when bills are set. ############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_Bills_Added_In_Data_File()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the Functionality of  Bills tab by opening Bills page when a bill reminder is set.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		if Upcoming tab displays the bill			
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  24th  May 2013
		[ ] //
	[ ] // ********************************************************
	[ ] 
	[ ] 
[+] testcase Test02_Bills_Added_In_Data_File() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] STRING sHomeTab,sReminderType
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] sHomeTab="#2"
		[ ] sReminderType="Bill"
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsReminderData=lsExcelData[1]
		[ ] lsReminderData[3]=sDate
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] //------------Select Preferences to make default tab Quicken opens to "Home" tab----------------
		[ ] QuickenWindow.Edit.Click()
		[ ] QuickenWindow.Edit.Preferences.Select()
		[ ] WaitForState(Preferences,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] Preferences.OnStartupOpenTo.Select(sHomeTab)
		[ ] Preferences.OK.Click()
		[ ] WaitForState(Preferences,FALSE,SHORT_SLEEP)
		[ ] //----------------------------------------------------------------------------------------------------------------------
		[ ] 
		[ ] //-------------Navigate to Bills tab----------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,lsReminderData[1])
		[ ] 
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // Click on add Reminder button and select Reminder
			[+] if(DlgAddEditReminder.Exists(5))
				[ ] //Set Bill Amount
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(lsReminderData[2])
				[ ] //Click on OK button
				[ ] DlgAddEditReminder.DoneButton.Click()
				[ ] 
				[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] WaitForState(DlgAddEditReminder,FALSE,SHORT_SLEEP)
				[ ] //Restart Quicken to handle bills >Get Started snapshot refresh issue
				[ ] 
				[ ] LaunchQuicken()
				[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
				[ ] 
				[ ] 
				[ ] //-------------Navigate to Bills tab----------------
				[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[ ] 
				[+] if(iValidate==PASS)
					[ ] MDIClient.Bills.ViewAsPopupList.Select("Stack")
					[ ] 
					[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.Enter.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify if Bill is displayed under Upcoming tab",PASS,"Bill is displayed under Upcoming tab")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under Upcoming tab",FAIL,"Bill is not displayed under Upcoming tab")
						[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Navigate to Add Bill Reminder Window",FAIL,"Add Reminder button not found")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //############# Verify the UI Controls present on Upcoming Tab under Bills ##########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_Upcoming_Tab_UI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that  Upcoming Tab should have following UI Controls  :
		[ ] // 1. View as : Stack, List ,Calendar , Monthly List
		[ ] // 2. Account : All Accounts ,Checking
		[ ] // 3. Due within Next : 14 days,7 days , 30 days
		[ ] // 4. Include Paid <checkbox>
		[ ] // 5.Add Reminder drop down
		[ ] // 6. Manage Reminders button
		[ ] //
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Upcoming Tab has all mentioned UI Controls	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  24th  May 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test05_Upcoming_Tab_UI() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] lsViewAsList={"Stack","List","Calendar","Monthly List"}
		[ ] lsAccountsList={"All Accounts","QCombo_Separator","Checking 01 Account"}
		[ ] lsDueWithinList={"7 days","14 days","30 days"}
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //-------------Navigate to Bills tab----------------
		[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
		[ ] 
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[ ] //Verify View As contents
			[+] if(MDIClient.Bills.ViewAsPopupList.Exists(SHORT_SLEEP))
				[ ] 
				[ ] lsActual=MDIClient.Bills.ViewAsPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] bMatch=MatchStr(lsActual[i],lsViewAsList[i])
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsViewAsList[i]} is present under View As PopUpList")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsViewAsList[i]} is missing from under View As PopUpList")
						[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify View As PopUpList ",FAIL,"View As PopUpList missing under Upcoming Tab")
				[ ] 
			[ ] 
			[ ] //Verify Account list contents
			[+] if(MDIClient.Bills.AccountPopupList.Exists(SHORT_SLEEP))
				[ ] 
				[ ] lsActual=MDIClient.Bills.AccountPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] 
					[ ] bMatch=MatchStr(lsActual[i],lsAccountsList[i])
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsAccountsList[i]} is present under Account list ")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsAccountsList[i]} is missing from under Account list")
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Account list contents ",FAIL,"Verify Account list contents missing under Upcoming Tab")
			[ ] 
			[ ] //Verify Due Within contents
			[+] if(MDIClient.Bills.DueWithinNextPopupList.Exists(5))
				[ ] 
				[ ] lsActual=MDIClient.Bills.DueWithinNextPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] 
					[ ] bMatch=MatchStr(lsActual[i],lsDueWithinList[i])
					[ ] 
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsDueWithinList[i]} is present under Due Within List")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsDueWithinList[i]} is missing from under Due Within List")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Due Within contents ",FAIL,"Verify Due Within contents missing under Upcoming Tab")
			[ ] 
			[ ] 
			[ ] //Verify Include Paid Checkbox
			[+] if(MDIClient.Bills.IncludePaid.Exists(5))
				[ ] ReportStatus("Verify Include Paid Checkbox",PASS,"Include Paid Checkbox is present under Upcoming Tab")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Include Paid Checkbox",FAIL,"Include Paid Checkbox is missing under Upcoming Tab")
			[ ] 
			[ ] 
			[ ] //Verify Add Reminder button
			[+] if(AddReminderButton.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Add Reminder button",PASS,"Add Reminder button is present under Upcoming Tab")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Add Reminder button",FAIL,"Add Reminder button is missing under Upcoming Tab")
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Manage Reminder button
			[+] if(ManageReminderButton.Exists(5))
				[ ] 
				[ ] ReportStatus("Verify Manage Reminder button",PASS,"Manage Reminder button is present under Upcoming Tab")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Manage Reminder button",FAIL,"Manage Reminder button is missing under Upcoming Tab")
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[+] //############# Verify Stack view on Upcoming Tab under Bills for Bill Reminder ######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_Stack_View_Upcoming_Tab_UI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills for Bill Reminder
		[ ] // 1. View as : Stack, List ,Calendar , Monthly List
		[ ] // 2. Account : All Accounts ,Checking
		[ ] // 3. Due within Next : 14 days,7 days , 30 days
		[ ] // 4. Include Paid <checkbox>
		[ ] // 5.Add Reminder drop down
		[ ] // 6. Manage Reminders button
		[ ] //
		[ ] // Stack View has :
		[ ] // 1.Due Date
		[ ] // 2. Amount
		[ ] // 3.Enter button
		[ ] // 4.Skip Button
		[ ] // 5.Status 
		[ ] // 6.Payment Method
		[ ] // 7.Edit Button
		[ ] // 8.Show History button
		[ ] // 9.PayeeName
		[ ] //   
		[ ] //
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Upcoming Tab has all mentioned UI Controls	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  29th  May 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test06_Stack_View_Upcoming_Tab_UI() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] lsViewAsList={"Stack","List","Calendar","Monthly List"}
		[ ] //lsAccountsList={"All Accounts","QCombo_Separator","Checking 01 Account"}
		[ ] lsDueWithinList={"7 days","14 days","30 days"}
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //-------------Navigate to Bills tab----------------
		[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
		[ ] 
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] //Navigate to Stack View on Upcoming tab
			[ ] MDIClient.Bills.ViewAsPopupList.Select(lsViewAsList[1])
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify View As contents
			[+] if(MDIClient.Bills.ViewAsPopupList.Exists(5))
				[ ] 
				[ ] lsActual=MDIClient.Bills.ViewAsPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] bMatch=MatchStr(lsActual[i],lsViewAsList[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsViewAsList[i]} is present under View As PopUpList")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsViewAsList[i]} is missing from under View As PopUpList")
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify View As PopUpList ",FAIL,"View As PopUpList missing un der Upcoming Tab")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Due Within contents
			[+] if(MDIClient.Bills.DueWithinNextPopupList.Exists(5))
				[ ] lsActual=MDIClient.Bills.DueWithinNextPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] bMatch=MatchStr(lsActual[i],lsDueWithinList[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsDueWithinList[i]} is present under Due Within List")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsDueWithinList[i]} is missing from under Due Within List")
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Due Within contents ",FAIL,"Verify Due Within contents missing un der Upcoming Tab")
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Edit button
			[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.Edit.Exists(5))
				[ ] ReportStatus("Verify Edit Button for Stack View under Upcoming Tab",PASS,"Edit button is present in Stack view")
			[+] else
				[ ] ReportStatus("Verify Edit Button for Stack View under Upcoming Tab",FAIL,"Edit button is present in Stack view")
			[ ] 
			[ ] 
			[ ] // Verify Enter button
			[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.Enter.Exists(5))
				[ ] ReportStatus("Verify Enter Button for Stack View under Upcoming Tab",PASS,"Enter button is present in Stack view")
			[+] else
				[ ] ReportStatus("Verify Enter Button for Stack View under Upcoming Tab",FAIL,"Enter button is present in Stack view")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] // Verify Show History button
			[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.ShowHistory.Exists(5))
				[ ] ReportStatus("Verify Show History Button for Stack View under Upcoming Tab",PASS,"Show History button is present in Stack view")
			[+] else
				[ ] ReportStatus("Verify Show History Button for Stack View under Upcoming Tab",FAIL,"Show History button is present in Stack view")
				[ ] 
				[ ] 
			[ ] // Verify Skip button
			[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.Skip.Exists(5))
				[ ] ReportStatus("Verify Skip Button for Stack View under Upcoming Tab",PASS,"Skip button is present in Stack view")
			[+] else
				[ ] ReportStatus("Verify Skip Button for Stack View under Upcoming Tab",FAIL,"Skip button is present in Stack view")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
		[ ] 
[ ] //########################################################################################################
[ ] 
[+] //################### Verify List view  on Upcoming Tab under Bills ################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_List_View_Upcoming_Tab_UI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills for Bill Reminder
		[ ] // 1. View as : Stack, List ,Calendar , Monthly List
		[ ] // 2. Account : All Accounts ,Checking
		[ ] // 3. Due within Next : 7 days,14 days,30 days,90 days,12 months
		[ ] //
		[ ] // List View has :
		[ ] // 1.Status 
		[ ] // 2.Due Date
		[ ] // 2. Amount
		[ ] // 3.Payto /From
		[ ] // 4.Actions : Edit,Enter,Skip
		[ ] // 5.Account Filter
		[ ] //   
		[ ] //
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Upcoming Tab has all mentioned UI Controls	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  29th  May 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test07_List_View_Upcoming_Tab_UI() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual,lsListButtons
		[ ] STRING sStatus,sListViewHandle,sListViewActual
		[ ] INTEGER iCount
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] lsViewAsList={"Stack","List","Calendar","Monthly List"}
		[ ] lsAccountsList={"All Accounts","QCombo_Separator","Checking 01 Account"}
		[ ] lsDueWithinList={"7 days","14 days","30 days","90 days","12 months"}
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsReminderData=lsExcelData[1]
		[ ] lsReminderData[3]=sDate
		[ ] 
		[ ] 
		[ ] lsListButtons={"Edit","Enter","Skip"}
		[ ] sStatus="Due"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //-------------Navigate to Bills tab----------------
		[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
		[ ] 
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] //Navigate to Stack View on Upcoming tab
			[ ] MDIClient.Bills.ViewAsPopupList.Select(lsViewAsList[2])
			[ ] 
			[ ] 
			[ ] //Verify View As contents
			[+] if(MDIClient.Bills.ViewAsPopupList.Exists(5))
				[ ] 
				[ ] lsActual=MDIClient.Bills.ViewAsPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] bMatch=MatchStr(lsActual[i],lsViewAsList[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsViewAsList[i]} is present under View As PopUpList")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsViewAsList[i]} is missing from under View As PopUpList")
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify View As PopUpList ",FAIL,"View As PopUpList missing un der Upcoming Tab")
				[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Account list contents
			[+] if(MDIClient.Bills.AccountPopupList.Exists(5))
				[ ] lsActual=MDIClient.Bills.AccountPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] bMatch=MatchStr(lsActual[i],lsAccountsList[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsAccountsList[i]} is present under Account list ")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsAccountsList[i]} is missing from under Account list")
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Account list contents ",FAIL,"Verify Account list contents missing under Upcoming Tab")
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Due Within contents
			[+] if(MDIClient.Bills.DueWithinNextPopupList.Exists(5))
				[ ] lsActual=MDIClient.Bills.DueWithinNextPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] bMatch=MatchStr(lsActual[i],lsDueWithinList[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsDueWithinList[i]} is present under Due Within List")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsDueWithinList[i]} is missing from under Due Within List")
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Due Within contents ",FAIL,"Verify Due Within contents missing un der Upcoming Tab")
			[ ] 
			[ ] 
			[ ] //---------------Match Content in all Rows with details---------------------------
			[ ] sListViewHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
			[ ] sListViewActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sListViewHandle,Str(0))
			[ ] 
			[ ] //Match Bill Details
			[ ] 
			[ ] 
			[ ] iCount=ListCount(lsReminderData)-4                 // Match the first 4 values of excel sheet row
			[+] for(i=1;i<=iCount;i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsReminderData[i]}*",sListViewActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match options with list columns",PASS,"{lsReminderData[i]} is matched to List View of Bills Upcoming tab")
					[ ] 
				[+] else
					[ ] 
					[ ] ReportStatus("Match options with list columns",FAIL,"{lsReminderData[i]} is not matched to List View of Bills Upcoming tab {sListViewActual}")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] //Match Status
			[ ] // bMatch=MatchStr("*{sStatus}*",sListViewActual)
			[+] // if(bMatch==TRUE)
				[ ] // 
				[ ] // 
			[+] // else
				[ ] // 
				[ ] // ReportStatus("Match options with list columns",FAIL,"{sStatus} is not matched to List View of Bills Upcoming tab {sListViewActual}")
				[ ] // 
			[ ] 
			[+] do
				[ ] MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.TextClick(sStatus)
				[ ] ReportStatus("Match options with list columns",PASS,"{sStatus} is matched to List View of Bills Upcoming tab")
				[ ] 
			[+] except
				[ ] ReportStatus("Match options with list columns",FAIL,"{sStatus} is not matched to List View of Bills Upcoming tab {sListViewActual}")
				[ ] 
			[ ] 
			[ ] 
			[ ] //Match List Buttons
			[+] for(i=1;i<=ListCount(lsListButtons);i++)
				[ ] 
				[ ] 
				[ ] bMatch=MatchStr("*{lsListButtons[i]}*",sListViewActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match options with list columns",PASS,"{lsListButtons[i]} is matched to List View of Bills Upcoming tab")
					[ ] 
				[+] else
					[ ] 
					[ ] ReportStatus("Match options with list columns",FAIL,"{lsListButtons[i]} is not matched to List View of Bills Upcoming tab {sListViewActual}")
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
			[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
		[ ] 
	[ ] 
[ ] //########################################################################################################
[ ] // 
[+] //############# Verify Monthly List view  on Upcoming Tab under Bills ################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_Monthly_List_Tab_UI()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Monthly List View has :
		[ ] // 1.View as
		[ ] // 2. Monthly timeline
		[ ] // 3. Actions : Edit,Enter,skip
		[ ] // 4. Add Reminder
		[ ] // 5.Manage reminders
		[ ] // 6. Account Filter
		[ ] //
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Monthly List View Tab has all mentioned UI Controls	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  24th  May 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test09_Monthly_List_Tab_UI() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual,lsListButtons
		[ ] STRING sStatus,sListViewHandle,sListViewActual,sMonthText
		[ ] INTEGER iCount
		[ ] //DATETIME sDateTime1,sDateTime2
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] lsViewAsList={"Stack","List","Calendar","Monthly List"}
		[ ] lsAccountsList={"All Accounts","QCombo_Separator","Checking 01 Account"}
		[ ] lsDueWithinList={"7 days","14 days","30 days","90 days","12 months"}
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsReminderData=lsExcelData[1]
		[ ] lsReminderData[3]=sDate
		[ ] 
		[ ] 
		[ ] lsListButtons={"Edit","Enter","Skip"}
		[ ] sStatus="Due"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //-------------Navigate to Bills tab----------------
		[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
		[ ] 
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] //Navigate to Stack View on Upcoming tab
			[ ] MDIClient.Bills.ViewAsPopupList.Select(lsViewAsList[4])
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify View As contents
			[+] if(MDIClient.Bills.ViewAsPopupList.Exists(5))
				[ ] 
				[ ] lsActual=MDIClient.Bills.ViewAsPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] bMatch=MatchStr(lsActual[i],lsViewAsList[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsViewAsList[i]} is present under View As PopUpList for Monthly List")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsViewAsList[i]} is missing from under View As PopUpList for Monthly List")
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify View As PopUpList ",FAIL,"View As PopUpList missing un der Upcoming Tab")
				[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Account list contents
			[+] if(MDIClient.Bills.AccountPopupList.Exists(5))
				[ ] lsActual=MDIClient.Bills.AccountPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] bMatch=MatchStr(lsActual[i],lsAccountsList[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsAccountsList[i]} is present under Account list ")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsAccountsList[i]} is missing from under Account list")
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Account list contents ",FAIL,"Verify Account list contents missing under Upcoming Tab")
			[ ] 
			[ ] 
			[ ] //Verify Month Selector
			[+] if(MDIClient.Bills.MonthSelectorText.Exists(5))
				[ ] sMonthText=MDIClient.Bills.MonthSelectorText.GetText()
				[ ] ReportStatus("Verify Month Selector under Upcoming Tab",PASS,"Month Selector is displayed")
				[ ] 
				[ ] // //Match Month to month selector text
				[ ] // sDate=ModifyDate(0,"mmm")  
				[ ] // bMatch=MatchStr("*{sDate}*",sMonthText)
				[+] // if(bMatch==TRUE)
					[ ] // ReportStatus("Verify Month Selector under Upcoming Tab",PASS,"{sDate} is matched to Month Selector text {sMonthText}")
				[+] // else
					[ ] // ReportStatus("Verify Month Selector under Upcoming Tab",FAIL,"{sDate} is not matched to Month Selector text {sMonthText}")
					[ ] // 
				[ ] 
				[ ] 
				[ ] //Match Year to month selector text
				[ ] sDate=ModifyDate(0,"yyyy")  
				[ ] bMatch=MatchStr("*{sDate}*",sMonthText)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Month Selector under Upcoming Tab",PASS,"{sDate} is matched to Month Selector text {sMonthText}")
				[+] else
					[ ] ReportStatus("Verify Month Selector under Upcoming Tab",FAIL,"{sDate} is not matched to Month Selector text {sMonthText}")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Month Selector under Upcoming Tab",FAIL,"Month Selector is not displayed")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] //Verify previous month button
			[+] if(MDIClient.Bills.PreviousMonth.Exists(5))
				[ ] ReportStatus("Verify Previous Month button is present on Month Selector under Upcoming Tab",PASS," Previous month is present in Month Selector text")
			[+] else
				[ ] ReportStatus("Verify Previous Month button is present on Month Selector under Upcoming Tab",FAIL," Previous month is not present in Month Selector text")
				[ ] 
			[ ] 
			[ ] 
			[ ] //Verify next month button
			[+] if(MDIClient.Bills.NextMonth.Exists(5))
				[ ] ReportStatus("Verify Next Month button is present on Month Selector under Upcoming Tab",PASS," Next month is present in Month Selector text")
			[+] else
				[ ] ReportStatus("Verify Next Month button is present on Month Selector under Upcoming Tab",FAIL," Next month is not present in Month Selector text")
				[ ] 
			[ ] //---------------Match Content in all Rows with details---------------------------
			[ ] sListViewHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
			[ ] sListViewActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sListViewHandle,Str(0))
			[ ] 
			[ ] //Match Bill Details
			[ ] iCount=ListCount(lsReminderData)-4                 // Match the first 4 values of excel sheet row
			[+] for(i=1;i<=iCount;i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsReminderData[i]}*",sListViewActual)
				[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match options with list columns",PASS,"{lsReminderData[i]} is matched to Monthly List View of Bills Upcoming tab")
				[+] else
					[ ] ReportStatus("Match options with list columns",FAIL,"{lsReminderData[i]} is not matched to Monthly List View of Bills Upcoming tab {sListViewActual}")
				[ ] 
			[ ] 
			[ ] 
			[+] do
				[ ] MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.TextClick(sStatus)
				[ ] ReportStatus("Match options with list columns",PASS,"{sStatus} is matched to List View of Bills Upcoming tab")
				[ ] 
			[+] except
				[ ] ReportStatus("Match options with list columns",FAIL,"{sStatus} is not matched to List View of Bills Upcoming tab {sListViewActual}")
				[ ] 
			[ ] 
			[ ] 
			[ ] //Match List Buttons
			[+] for(i=1;i<=ListCount(lsListButtons);i++)
				[ ] 
				[ ] 
				[ ] bMatch=MatchStr("*{lsListButtons[i]}*",sListViewActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match options with list columns",PASS,"{lsListButtons[i]} is matched to Monthly List View of Bills Upcoming tab")
					[ ] 
				[+] else
					[ ] 
					[ ] ReportStatus("Match options with list columns",FAIL,"{lsListButtons[i]} is not matched to Monthly List View of Bills Upcoming tab {sListViewActual}")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] sPayeeName=lsReminderData[1]
			[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
			[+] if(iValidate==PASS)									  	 
				[ ] 
				[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##########################################################################################################
[ ] 
[+] //################ Verify Stack view  on Upcoming Tab under Bills Due Within next 30 days for Bill Reminder #################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_Stack_View_Bills_Due_Within_Next_30_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills Due Within next 30 days for Bill Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Bill reminder with proper date, payee name , amount should NOT be displayed in stack.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  30th  May 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test10_Stack_View_Bills_Due_Within_Next_30_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] // LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] 
		[ ] LIST OF STRING lsAddBill,lsAddAccount
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Bill"
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(30,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="15"
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //---------------------Add a Bill----------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if( iValidate==PASS)
			[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sBillDate)
			[ ] 
			[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] //DlgOptionalSetting.SetActive()
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.RemindMeRadioList.Select ("Remind me")
					[ ] //.SetSelRange (1, 1, 1, 2)
					[ ] DlgOptionalSetting.DaysBeforeTheDueDateTextField.SetText(sDaysBefore)
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Reminder details window",FAIL,"Reminder Details window not displayed")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify change link",FAIL,"Change link not found")
			[ ] 
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
			[ ] CloseAddLinkBiller()
			[ ] //Restart Quicken to handle bills >Get Started snapshot refresh issue
			[ ] 
			[ ] // LaunchQuicken()
			[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
			[ ] 
			[ ] 
			[ ] //-------Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)-----------
			[ ] QuickenWindow.SetActive()
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] 
				[ ] // Verify different bill parameters such as payee name and bill amount
				[+] for(i=1; i<= 2; i++)
					[ ] bMatch = MatchStr("*{lsAddBill[i]}*",sActual)
					[ ] print(lsAddBill[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddBill[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddBill[i]} is NOT added, sActual = {sActual}")
				[ ] DlgManageReminders.Close()
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select Stack view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] sleep(3)
				[ ] //-------Verify content under Stack view on Bills Upcoming tab---------------
				[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Exists(5))
					[ ] 
					[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild.Edit.Exists(5))
						[ ] ReportStatus("Verify if Bill is displayed under stack view",PASS,"Bill is Not displayed under stack view")
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
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
[ ] //##########################################################################################################
[ ] 
[+] //###############Verify Stack view  on Upcoming Tab under Bills Due Within next for 30 days for Bill Reminder for future date  ###
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_Stack_View_Bills_Due_Within_Next_30_Days_Bill_Reminder_Future_Date()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills Due Within next for 30 days for Bill Reminder for future date
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Bill reminder with proper date, payee name , amount should be displayed in stack.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  30th  May 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test11_Stack_View_Bills_Due_Within_Next_30_Days_Bill_Reminder_Future_Date() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] // LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] 
		[ ] LIST OF STRING lsAddBill,lsAddAccount
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Bill"
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(30,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="32"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //---------------------Add a Bill----------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if( iValidate==PASS)
			[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sBillDate)
			[ ] 
			[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] //DlgOptionalSetting.SetActive()
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.RemindMeRadioList.Select ("Remind me")
					[ ] //.SetSelRange (1, 1, 1, 2)
					[ ] DlgOptionalSetting.DaysBeforeTheDueDateTextField.SetText(sDaysBefore)
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Reminder details window",FAIL,"Reminder Details window not displayed")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify change link",FAIL,"Change link not found")
			[ ] 
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
			[ ] CloseAddLinkBiller()
			[ ] //-------Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)-----------
			[ ] QuickenWindow.SetActive()
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] 
				[ ] // Verify different bill parameters such as payee name and bill amount
				[+] for(i=1; i<= 2; i++)
					[ ] bMatch = MatchStr("*{lsAddBill[i]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddBill[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddBill[i]} is NOT added, sActual = {sActual}")
				[ ] DlgManageReminders.Close()
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is displayed----------
				[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[+] if(iValidate==PASS)
					[ ] //Select Stack view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
					[ ] //-------Verify content under Stack view on Bills Upcoming tab---------------
					[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.Skip.Exists(5))
						[ ] 
						[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.Edit.Exists(5))
							[ ] ReportStatus("Verify if Bill is displayed under stack view",PASS,"Bill is displayed under stack view for {sDayFilter}")
						[+] else
							[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is Not displayed under stack view for {sDayFilter}")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is Not displayed under stack view")
				[+] else
					[ ] ReportStatus("Navigate to Bills tab",FAIL,"Bills tab not opened")
				[ ] 
				[ ] 
				[ ] //----------------Delete Bill Reminder--------------------------
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
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
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################################################
[ ] 
[+] //################ Verify Stack view  on Upcoming Tab under Bills Due Within next 14 days for Bill Reminder ##################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_Stack_View_Bills_Due_Within_Next_14_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills Due Within next 14 days for Bill Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Bill reminder with proper date, payee name , amount should NOT be displayed in stack.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  31st  May 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test12_Stack_View_Bills_Due_Within_Next_14_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] // LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] 
		[ ] LIST OF STRING lsAddBill,lsAddAccount
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Bill"
		[ ] sDayFilter="14 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(30,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="15"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //---------------------Add a Bill----------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if( iValidate==PASS)
			[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sBillDate)
			[ ] 
			[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] //DlgOptionalSetting.SetActive()
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.RemindMeRadioList.Select ("Remind me")
					[ ] //.SetSelRange (1, 1, 1, 2)
					[ ] DlgOptionalSetting.DaysBeforeTheDueDateTextField.SetText(sDaysBefore)
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Reminder details window",FAIL,"Reminder Details window not displayed")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify change link",FAIL,"Change link not found")
			[ ] 
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
			[+] if (LinkBiller.Exists(5))
				[ ] LinkBiller.SetActive()
				[ ] LinkBiller.btnClose.Click()
				[ ] sleep(1)
			[ ] 
			[ ] 
			[ ] //-------Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)-----------
			[ ] QuickenWindow.SetActive()
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] 
				[ ] // Verify different bill parameters such as payee name and bill amount
				[+] for(i=1; i<= 2; i++)
					[ ] bMatch = MatchStr("*{lsAddBill[i]}*",sActual)
					[ ] print(lsAddBill[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddBill[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddBill[i]} is NOT added, sActual = {sActual}")
				[ ] DlgManageReminders.Close()
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select Stack view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under Stack view on Bills Upcoming tab---------------
				[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Exists(5))
					[ ] 
					[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild.Edit.Exists(5))
						[ ] ReportStatus("Verify if Bill is displayed under stack view",PASS,"Bill is Not displayed under stack view")
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################################################
[ ] 
[+] //################ Verify Stack view  on Upcoming Tab under Bills Due Within next 7 days for Bill Reminder ###################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_Stack_View_Bills_Due_Within_Next_7_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills Due Within next 14 days for Bill Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Bill reminder with proper date, payee name , amount should NOT be displayed in stack.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  31st  May 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test13_Stack_View_Bills_Due_Within_Next_7_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] // LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] 
		[ ] LIST OF STRING lsAddBill,lsAddAccount
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Bill"
		[ ] sDayFilter="7 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(30,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="15"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //---------------------Add a Bill----------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if( iValidate==PASS)
			[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sBillDate)
			[ ] 
			[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] //DlgOptionalSetting.SetActive()
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.RemindMeRadioList.Select ("Remind me")
					[ ] //.SetSelRange (1, 1, 1, 2)
					[ ] DlgOptionalSetting.DaysBeforeTheDueDateTextField.SetText(sDaysBefore)
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Reminder details window",FAIL,"Reminder Details window not displayed")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify change link",FAIL,"Change link not found")
			[ ] 
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
			[ ] CloseAddLinkBiller()
			[ ] 
			[ ] //-------Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)-----------
			[ ] QuickenWindow.SetActive()
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] 
				[ ] // Verify different bill parameters such as payee name and bill amount
				[+] for(i=1; i<= 2; i++)
					[ ] bMatch = MatchStr("*{lsAddBill[i]}*",sActual)
					[ ] print(lsAddBill[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddBill[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddBill[i]} is NOT added, sActual = {sActual}")
				[ ] DlgManageReminders.Close()
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select Stack view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under Stack view on Bills Upcoming tab---------------
				[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Exists(5))
					[ ] 
					[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild.Edit.Exists(5))
						[ ] ReportStatus("Verify if Bill is displayed under stack view",PASS,"Bill is Not displayed under stack view")
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //###########################################################################################################
[ ] 
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 30 days for Bill Reminder ####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_List_View_Bills_Due_Within_Next_30_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 30 days for Bill Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Bill reminder with proper date, payee name , amount should NOT be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  3rd  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test14_List_View_Bills_Due_Within_Next_30_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter,sDelete
		[ ] 
		[ ] LIST OF STRING lsAddBill,lsAddAccount
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Bill"
		[ ] sDayFilter="30 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //---------------------Add a Bill----------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if( iValidate==PASS)
			[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sBillDate)
			[ ] 
			[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] //DlgOptionalSetting.SetActive()
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.RemindMeRadioList.Select ("Remind me")
					[ ] //.SetSelRange (1, 1, 1, 2)
					[ ] DlgOptionalSetting.DaysBeforeTheDueDateTextField.SetText(sDaysBefore)
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Reminder details window",FAIL,"Reminder Details window not displayed")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify change link",FAIL,"Change link not found")
			[ ] 
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
			[ ] CloseAddLinkBiller()
			[ ] 
			[ ] 
			[ ] 
			[ ] //-------Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)-----------
			[ ] QuickenWindow.SetActive()
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] 
				[ ] // Verify different bill parameters such as payee name and bill amount
				[+] for(i=1; i<= 2; i++)
					[ ] bMatch = MatchStr("*{lsAddBill[i]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddBill[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddBill[i]} is NOT added, sActual = {sActual}")
				[ ] DlgManageReminders.Close()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select Stack view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
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
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################################
[ ] 
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 90 days for Bill Reminder ####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_List_View_Bills_Due_Within_Next_90_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 90 days for Bill Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Bill reminder with proper date, payee name , amount should be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  3rd June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test15_List_View_Bills_Due_Within_Next_90_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] // LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter,sDelete
		[ ] 
		[ ] LIST OF STRING lsAddBill,lsAddAccount
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Bill"
		[ ] sDayFilter="90 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //---------------------Add a Bill----------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if( iValidate==PASS)
			[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sBillDate)
			[ ] 
			[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] //DlgOptionalSetting.SetActive()
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.RemindMeRadioList.Select ("Remind me")
					[ ] //.SetSelRange (1, 1, 1, 2)
					[ ] DlgOptionalSetting.DaysBeforeTheDueDateTextField.SetText(sDaysBefore)
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Reminder details window",FAIL,"Reminder Details window not displayed")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify change link",FAIL,"Change link not found")
			[ ] 
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[ ] 
			[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
			[ ] CloseAddLinkBiller()
			[ ] 
			[ ] 
			[ ] //-------Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)-----------
			[ ] QuickenWindow.SetActive()
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] 
				[ ] // Verify different bill parameters such as payee name and bill amount
				[+] for(i=1; i<= 2; i++)
					[ ] bMatch = MatchStr("*{lsAddBill[i]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddBill[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddBill[i]} is NOT added, sActual = {sActual}")
				[ ] DlgManageReminders.Close()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select Stack view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
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
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################################
[ ] 
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 12 months for Bill Reminder ##################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_List_View_Bills_Due_Within_Next_12_Months_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 12 months for Bill Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Bill reminder with proper date, payee name , amount should be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  3rd June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test16_List_View_Bills_Due_Within_Next_12_Months_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] // LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter,sDelete
		[ ] 
		[ ] LIST OF STRING lsAddBill,lsAddAccount
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Bill"
		[ ] sDayFilter="12 Months"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //---------------------Add a Bill----------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if( iValidate==PASS)
			[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sBillDate)
			[ ] 
			[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] //DlgOptionalSetting.SetActive()
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.RemindMeRadioList.Select ("Remind me")
					[ ] //.SetSelRange (1, 1, 1, 2)
					[ ] DlgOptionalSetting.DaysBeforeTheDueDateTextField.SetText(sDaysBefore)
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Reminder details window",FAIL,"Reminder Details window not displayed")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify change link",FAIL,"Change link not found")
			[ ] 
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[ ] 
			[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
			[ ] CloseAddLinkBiller()
			[ ] 
			[ ] 
			[ ] //-------Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)-----------
			[ ] QuickenWindow.SetActive()
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] 
				[ ] // Verify different bill parameters such as payee name and bill amount
				[+] for(i=1; i<= 2; i++)
					[ ] bMatch = MatchStr("*{lsAddBill[i]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddBill[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddBill[i]} is NOT added, sActual = {sActual}")
				[ ] DlgManageReminders.Close()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select Stack view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
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
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################################
[ ] 
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 14 days for Bill Reminder ####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_List_View_Bills_Due_Within_Next_14_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 14 days for Bill Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Bill reminder with proper date, payee name , amount should NOT be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  3rd  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test17_List_View_Bills_Due_Within_Next_14_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] // LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter,sDelete
		[ ] 
		[ ] LIST OF STRING lsAddBill,lsAddAccount
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Bill"
		[ ] sDayFilter="14 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //---------------------Add a Bill----------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if( iValidate==PASS)
			[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sBillDate)
			[ ] 
			[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] //DlgOptionalSetting.SetActive()
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.RemindMeRadioList.Select ("Remind me")
					[ ] //.SetSelRange (1, 1, 1, 2)
					[ ] DlgOptionalSetting.DaysBeforeTheDueDateTextField.SetText(sDaysBefore)
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Reminder details window",FAIL,"Reminder Details window not displayed")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify change link",FAIL,"Change link not found")
			[ ] 
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
			[ ] CloseAddLinkBiller()
			[ ] 
			[ ] 
			[ ] 
			[ ] //-------Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)-----------
			[ ] QuickenWindow.SetActive()
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] 
				[ ] // Verify different bill parameters such as payee name and bill amount
				[+] for(i=1; i<= 2; i++)
					[ ] bMatch = MatchStr("*{lsAddBill[i]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddBill[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddBill[i]} is NOT added, sActual = {sActual}")
				[ ] DlgManageReminders.Close()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select Stack view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
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
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################################
[ ] 
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 7 days for Bill Reminder #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test18_List_View_Bills_Due_Within_Next_7_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 7 days for Bill Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Bill reminder with proper date, payee name , amount should NOT be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  3rd  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test18_List_View_Bills_Due_Within_Next_7_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] // LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter,sDelete
		[ ] 
		[ ] LIST OF STRING lsAddBill,lsAddAccount
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Bill"
		[ ] sDayFilter="14 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //---------------------Add a Bill----------------------------------------
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if( iValidate==PASS)
			[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sBillDate)
			[ ] 
			[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] //DlgOptionalSetting.SetActive()
					[ ] Agent.SetOption(OPT_SCROLL_INTO_VIEW,FALSE)
					[ ] DlgOptionalSetting.RemindMeRadioList.Select ("Remind me")
					[ ] //.SetSelRange (1, 1, 1, 2)
					[ ] DlgOptionalSetting.DaysBeforeTheDueDateTextField.SetText(sDaysBefore)
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Reminder details window",FAIL,"Reminder Details window not displayed")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify change link",FAIL,"Change link not found")
			[ ] 
			[ ] DlgAddEditReminder.DoneButton.Click()
			[ ] 
			[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
			[ ] CloseAddLinkBiller()
			[ ] 
			[ ] 
			[ ] 
			[ ] //-------Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)-----------
			[ ] QuickenWindow.SetActive()
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] 
				[ ] // Verify different bill parameters such as payee name and bill amount
				[+] for(i=1; i<= 2; i++)
					[ ] bMatch = MatchStr("*{lsAddBill[i]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddBill[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddBill[i]} is NOT added, sActual = {sActual}")
				[ ] DlgManageReminders.Close()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select Stack view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
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
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################################################
[ ] 
[+] //################ Verify Monthly List View on Upcoming Tab for Bill Reminder ###########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test20_MonthlyList_View_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Monthlt List view  on Upcoming Tab  for Bill Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Bill reminders with proper date, payee name , amount should be displayed in monthly list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  4th June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test20_MonthlyList_View_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sListOption,sReminderTypeBill,sReminderTypeIncome,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter,sDelete
		[ ] STRING sDate1,sDate2,sDate3,sNewDate1,sNewDate2,sMonthName
		[ ] 
		[ ] LIST OF STRING lsAddBill,lsAddAccount,lsBillMonthText,lsBillsDate
		[ ] 
		[ ] DATE dDate
		[ ] 
		[ ] DATETIME dtDateTime
		[ ] 
		[ ] LIST OF ANYTYPE lsDateList
		[ ] 
		[ ] INTEGER iNewDate,j,k , iPreviousMonth ,iNextMonth
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] sListOption="Monthly List"
		[ ] sReminderTypeBill="Bill"
		[ ] sReminderTypeIncome="Income"
		[ ] 
		[ ] sDelete="Delete"
		[ ] 
		[ ] dtDateTime= GetDateTime ()
		[ ] 
		[ ] //---------Get current day, month and year-------
		[ ] sDate1=ModifyDate(0,"d")
		[ ] sDate2=ModifyDate(0,"m")
		[ ] sDate3=ModifyDate(0,"yyyy")
		[ ] 
		[ ] //---------Get previous and next months-----------
		[ ] iNewDate=val(sDate2)
		[ ] 
		[ ] 
		[+] if(iNewDate==12)
			[ ] iNextMonth=1
		[+] else
			[ ] iNextMonth=iNewDate+1
		[+] if(iNewDate==1)
			[ ] iPreviousMonth=12
		[+] else
			[ ] iPreviousMonth=iNewDate-1
		[ ] 
		[ ] lsDateList={iPreviousMonth,iNewDate,iNextMonth}
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //-------Create a list of date and Month name ------------
		[+] for(i=1;i<=ListCount(lsDateList);i++)
			[ ] 
			[ ] 
			[ ] sNewDate1=Str(lsDateList[i])+"/"+sDate1+"/"+sDate3
			[ ] print(sNewDate1)
			[ ] ListAppend(lsBillsDate,sNewDate1)
			[ ] sNewDate2=sDate3+"-"+Str(lsDateList[i])+"-"+sDate1
			[ ] 
			[ ] dDate=[DATE]sNewDate2
			[ ] sMonthName= FormatDateTime ([DATETIME]dDate,"mmm")
			[ ] ListAppend(lsBillMonthText,sMonthName)
			[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //For Bill Reminders
		[+] for(i=3;i<=ListCount(lsBillsDate);i++)
			[ ] //---------------------Add a Bill----------------------------------------
			[ ] 
			[ ] // Read bills data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
			[ ] lsAddBill=lsExcelData[1]
			[ ] sPayeeName=lsAddBill[1]+lsBillMonthText[i]
			[ ] sTransactionAmount=lsAddBill[2]
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] iValidate=NavigateReminderDetailsPage(sReminderTypeBill,sPayeeName)
			[+] if( iValidate==PASS)
				[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Bill Reminder dialog second screen is displayed.")
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(lsBillsDate[i])
				[ ] DlgAddEditReminder.DoneButton.Click()
				[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
				[ ] CloseAddLinkBiller()
				[ ] 
			[+] else
				[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Bill Reminder screen two is not displayed")
				[ ] DlgAddEditReminder.Close()
			[ ] 
			[ ] //-------Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)-----------
			[ ] QuickenWindow.SetActive()
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] 
				[ ] 
				[ ] bMatch = MatchStr("*{sPayeeName}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{sPayeeName}' is added successfully")
				[+] else
					[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {sPayeeName} is NOT added, sActual = {sActual}")
				[ ] DlgManageReminders.Close()
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
			[ ] 
			[ ] 
			[ ] //----------Verify that content is displayed----------
			[ ] //Select Monthly List view on bills tab
			[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
			[ ] 
			[ ] 
			[ ] // //Navigate to month in which bill is added
			[+] if(i==1)
				[ ] 
				[ ] MDIClient.Bills.PreviousMonth.Click()
			[+] if(i==2)
				[ ] 
				[ ] MDIClient.Bills.NextMonth.Click()
			[+] if(i==3)
				[ ] 
				[ ] MDIClient.Bills.NextMonth.Click()
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //-------Verify content under List view on Bills Upcoming tab---------------
			[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
			[+] for(j=0;j<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();j++)
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(j))
				[ ] 
				[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Bill Reminder is found under list view of Upcoming tab for date {lsBillsDate[i]} Monthly List for month of {lsBillMonthText[i]}")
					[ ] break
			[ ] 
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("Verify if reminder is found",FAIL,"Bill Reminder is not displayed under list view of Upcoming tab for date {lsBillsDate[i]} Monthly List for month of {lsBillMonthText[i]}")
				[ ] 
			[ ] 
			[ ] 
			[ ] // ReminderOperations(sDelete,sPayeeName)
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.TextClick(sPayeeName)
				[ ] DlgManageReminders.TypeKeys(KEY_ALT_L)
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.SetActive()
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage,FALSE,5)
					[ ] 
					[ ] DlgManageReminders.Close()
					[ ] WaitForState(DlgManageReminders,FALSE,SHORT_SLEEP)
					[ ] 
				[+] else
					[ ] ReportStatus("Delete Reminder Dialog",FAIL,"Delete Reminder Dialog does not appear")
					[ ] 
				[ ] 
				[ ] // Verify Bill has been deleted
				[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] 
					[+] if(GetStarted.Exists(5))
						[ ] ReportStatus("Verify Bill Deletion",PASS,"Bill deleted from data file")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Bill Deletion",FAIL,"Bill not deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
					[ ] 
			[+] else
				[ ] ReportStatus("Mange Reminders Dialog",FAIL,"Manage Reminders dialog is not displayed")
		[ ] 
		[ ] //For Income Reminders
		[+] for(i=1;i<=ListCount(lsBillsDate);i++)
			[ ] //---------------------Add an Income----------------------------------------
			[ ] 
			[ ] // Read Income data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
			[ ] lsAddBill=lsExcelData[2]
			[ ] sPayeeName=lsAddBill[1]+lsBillMonthText[i]
			[ ] sTransactionAmount=lsAddBill[2]
			[ ] 
			[ ] 
			[ ] print(i)
			[ ] print(lsBillsDate[i])
			[ ] 
			[ ] 
			[ ] QuickenWindow.SetActive()
			[ ] iValidate=NavigateReminderDetailsPage(sReminderTypeIncome,sPayeeName)
			[+] if( iValidate==PASS)
				[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(lsBillsDate[i])
				[ ] DlgAddEditReminder.DoneButton.Click()
				[ ] 
				[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
				[ ] CloseAddLinkBiller()
			[+] else
				[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
				[ ] DlgAddEditReminder.Close()
			[ ] 
			[ ] //-------Verify if monthly Income gets added or not using Bill and Income Reminder List (CTRL+J)-----------
			[ ] QuickenWindow.SetActive()
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] 
				[ ] 
				[ ] bMatch = MatchStr("*{sPayeeName}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{sPayeeName}' is added successfully")
				[+] else
					[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder for {sPayeeName} is NOT added, sActual = {sActual}")
				[ ] DlgManageReminders.Close()
			[+] else
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Online Income Reminder is NOT added")
			[ ] 
			[ ] 
			[ ] //----------Verify that content is displayed----------
			[ ] //Select Monthly List view on bills tab
			[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
			[ ] 
			[ ] 
			[ ] // //Navigate to month in which Income is added
			[+] if(i==1)
				[ ] MDIClient.Bills.PreviousMonth.Click()
				[ ] MDIClient.Bills.PreviousMonth.Click()
			[+] if(i==2)
				[ ] 
				[ ] MDIClient.Bills.NextMonth.Click()
			[+] if(i==3)
				[ ] 
				[ ] MDIClient.Bills.NextMonth.Click()
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //-------Verify content under List view on Bills Upcoming tab---------------
			[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
			[+] for(j=0;j<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();j++)
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(j))
				[ ] 
				[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if Income reminder is found",PASS,"Income Reminder is found under list view of Upcoming tab for date {lsBillsDate[i]} Monthly List for month of {lsBillMonthText[i]}")
					[ ] break
			[ ] 
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("Verify if Income reminder is found",FAIL,"Income Reminder is not displayed under list view of Upcoming tab for date {lsBillsDate[i]} Monthly List for month of {lsBillMonthText[i]}")
				[ ] 
			[ ] 
			[ ] 
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.TextClick(sPayeeName)
				[ ] DlgManageReminders.TypeKeys(KEY_ALT_L)
				[+] if(AlertMessage.Exists(5))
					[ ] AlertMessage.SetActive()
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState(AlertMessage,FALSE,5)
					[ ] 
					[ ] DlgManageReminders.Close()
					[ ] WaitForState(DlgManageReminders,FALSE,SHORT_SLEEP)
					[ ] 
				[+] else
					[ ] ReportStatus("Delete Reminder Dialog",FAIL,"Delete Reminder Dialog does not appear")
					[ ] 
				[ ] 
				[ ] // Verify Bill has been deleted
				[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] 
					[+] if(GetStarted.Exists(5))
						[ ] ReportStatus("Verify income reminder deleted.",PASS,"Income reminder deleted from data file")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify income reminder deleted.",FAIL,"Income reminder not deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
					[ ] 
			[+] else
				[ ] ReportStatus("Mange Reminders Dialog",FAIL,"Manage Reminders dialog is not displayed")
		[ ] 
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //######################################################################################################
[ ] 
[ ] 
[+] //############# Verify Stack view  on Upcoming Tab under Bills for Income Reminder #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test21_Stack_View_Upcoming_Tab_UI_Income_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills for Bill Reminder
		[ ] // 1. View as : Stack, List ,Calendar , Monthly List
		[ ] // 2. Account : All Accounts ,Checking
		[ ] // 3. Due within Next : 14 days,7 days , 30 days
		[ ] // 4. Include Paid <checkbox>
		[ ] // 5.Add Reminder drop down
		[ ] // 6. Manage Reminders button
		[ ] //
		[ ] // Stack View has :
		[ ] // 1.Due Date
		[ ] // 2. Amount
		[ ] // 3.Enter button
		[ ] // 4.Skip Button
		[ ] // 5.Status 
		[ ] // 6.Payment Method
		[ ] // 7.Edit Button
		[ ] // 8.Show History button
		[ ] // 9.PayeeName
		[ ] //   
		[ ] //
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Upcoming Tab has all mentioned UI Controls	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test21_Stack_View_Upcoming_Tab_UI_Income_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] sReminderType="Income"
		[ ] lsViewAsList={"Stack","List","Calendar","Monthly List"}
		[ ] //lsAccountsList={"All Accounts","QCombo_Separator","Checking 01 Account"}
		[ ] lsDueWithinList={"7 days","14 days","30 days"}
		[ ] 
		[ ] sListOption="Stack"
		[ ] 
		[ ] sDayFilter="7 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // // Read bills data from excel sheet
		[ ] // lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] // lsAddBill=lsExcelData[2]
		[ ] // sPayeeName=lsAddBill[2]
		[ ] // sReminderType=lsAddBill[1]
		[ ] // sTransactionAmount=lsAddBill[3]
		[ ] // sDaysBefore="15"
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if( iValidate==PASS)
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] //Navigate to Stack View on Upcoming tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(lsViewAsList[1])
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify View As contents
				[+] if(MDIClient.Bills.ViewAsPopupList.Exists(5))
					[ ] 
					[ ] lsActual=MDIClient.Bills.ViewAsPopupList.GetContents()
					[ ] 
					[+] for(i=1;i<=ListCount(lsActual);i++)
						[ ] bMatch=MatchStr(lsActual[i],lsViewAsList[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsViewAsList[i]} is present under View As PopUpList")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsViewAsList[i]} is missing from under View As PopUpList")
							[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify View As PopUpList ",FAIL,"View As PopUpList missing un der Upcoming Tab")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify Due Within contents
				[+] if(MDIClient.Bills.DueWithinNextPopupList.Exists(5))
					[ ] lsActual=MDIClient.Bills.DueWithinNextPopupList.GetContents()
					[ ] 
					[+] for(i=1;i<=ListCount(lsActual);i++)
						[ ] bMatch=MatchStr(lsActual[i],lsDueWithinList[i])
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsDueWithinList[i]} is present under Due Within List")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsDueWithinList[i]} is missing from under Due Within List")
							[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Due Within contents ",FAIL,"Verify Due Within contents missing un der Upcoming Tab")
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify Edit button
				[+] if(MDIClient.Bills.Panel.Panel1.QWinChild1.Edit.Exists(5))
					[ ] ReportStatus("Verify Edit Button for Stack View under Upcoming Tab",PASS,"Edit button is present in Stack view")
				[+] else
					[ ] ReportStatus("Verify Edit Button for Stack View under Upcoming Tab",FAIL,"Edit button is present in Stack view")
				[ ] 
				[ ] 
				[ ] // Verify Enter button
				[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.Enter.Exists(5))
					[ ] ReportStatus("Verify Enter Button for Stack View under Upcoming Tab",PASS,"Enter button is present in Stack view")
				[+] else
					[ ] ReportStatus("Verify Enter Button for Stack View under Upcoming Tab",FAIL,"Enter button is present in Stack view")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] // Verify Show History button
				[+] if(MDIClient.Bills.Panel.Panel1.QWinChild1.ShowHistory.Exists(5))
					[ ] ReportStatus("Verify Show History Button for Stack View under Upcoming Tab",PASS,"Show History button is present in Stack view")
				[+] else
					[ ] ReportStatus("Verify Show History Button for Stack View under Upcoming Tab",FAIL,"Show History button is present in Stack view")
					[ ] 
					[ ] 
				[ ] 
				[ ] // Verify Skip button
				[+] if(MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Exists(5))
					[ ] ReportStatus("Verify Skip Button for Stack View under Upcoming Tab",PASS,"Skip button is present in Stack view")
				[+] else
					[ ] ReportStatus("Verify Skip Button for Stack View under Upcoming Tab",FAIL,"Skip button is present in Stack view")
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
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################### Verify List view  on Upcoming Tab under Bills for Income Reminder ###################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test22_List_View_Upcoming_Tab_UI_Income_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills for Bill Reminder
		[ ] // 1. View as : Stack, List ,Calendar , Monthly List
		[ ] // 2. Account : All Accounts ,Checking
		[ ] // 3. Due within Next : 7 days,14 days,30 days,90 days,12 months
		[ ] //
		[ ] // List View has :
		[ ] // 1.Status 
		[ ] // 2.Due Date
		[ ] // 2. Amount
		[ ] // 3.Payto /From
		[ ] // 4.Actions : Edit,Enter,Skip
		[ ] // 5.Account Filter
		[ ] //   
		[ ] //
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Upcoming Tab has all mentioned UI Controls	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test22_List_View_Upcoming_Tab_UI_Income_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual,lsListButtons
		[ ] STRING sListViewHandle,sListViewActual
		[ ] INTEGER iCount
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] lsViewAsList={"Stack","List","Calendar","Monthly List"}
		[ ] lsAccountsList={"All Accounts","QCombo_Separator","Checking 01 Account"}
		[ ] lsDueWithinList={"7 days","14 days","30 days","90 days","12 months"}
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsReminderData=lsExcelData[2]
		[ ] lsReminderData[3]=sDate
		[ ] 
		[ ] 
		[ ] lsListButtons={"Edit","Enter","Skip"}
		[ ] //sStatus="Due Today"
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] //-------------Navigate to Bills tab----------------
		[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
		[ ] 
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[ ] //Navigate to Stack View on Upcoming tab
			[ ] MDIClient.Bills.ViewAsPopupList.Select(lsViewAsList[2])
			[ ] 
			[ ] 
			[ ] //Verify View As contents
			[+] if(MDIClient.Bills.ViewAsPopupList.Exists(5))
				[ ] 
				[ ] lsActual=MDIClient.Bills.ViewAsPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] bMatch=MatchStr(lsActual[i],lsViewAsList[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsViewAsList[i]} is present under View As PopUpList")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsViewAsList[i]} is missing from under View As PopUpList")
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify View As PopUpList ",FAIL,"View As PopUpList missing un der Upcoming Tab")
				[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Account list contents
			[+] if(MDIClient.Bills.AccountPopupList.Exists(5))
				[ ] lsActual=MDIClient.Bills.AccountPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] bMatch=MatchStr(lsActual[i],lsAccountsList[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsAccountsList[i]} is present under Account list ")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsAccountsList[i]} is missing from under Account list")
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Account list contents ",FAIL,"Verify Account list contents missing under Upcoming Tab")
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Due Within contents
			[+] if(MDIClient.Bills.DueWithinNextPopupList.Exists(5))
				[ ] lsActual=MDIClient.Bills.DueWithinNextPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] bMatch=MatchStr(lsActual[i],lsDueWithinList[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsDueWithinList[i]} is present under Due Within List")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsDueWithinList[i]} is missing from under Due Within List")
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Due Within contents ",FAIL,"Verify Due Within contents missing un der Upcoming Tab")
			[ ] 
			[ ] 
			[ ] //---------------Match Content in all Rows with details---------------------------
			[ ] sListViewHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
			[ ] sListViewActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sListViewHandle,Str(0))
			[ ] 
			[ ] //Match Bill Details
			[ ] 
			[ ] 
			[ ] iCount=ListCount(lsReminderData)-3                 // Match the first 4 values of excel sheet row
			[+] for(i=1;i<=iCount;i++)
				[ ] 
				[+] if(lsReminderData[i]!=NULL)
					[ ] bMatch=MatchStr("*{lsReminderData[i]}*",sListViewActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Match options with list columns",PASS,"{lsReminderData[i]} is matched to List View of Bills Upcoming tab")
						[ ] 
					[+] else
						[ ] 
						[ ] ReportStatus("Match options with list columns",FAIL,"{lsReminderData[i]} is not matched to List View of Bills Upcoming tab {sListViewActual}")
						[ ] 
						[ ] 
						[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] //Match List Buttons
			[+] for(i=1;i<=ListCount(lsListButtons);i++)
				[ ] 
				[ ] bMatch=MatchStr("*{lsListButtons[i]}*",sListViewActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match options with list columns",PASS,"{lsListButtons[i]} is matched to List View of Bills Upcoming tab")
					[ ] 
				[+] else
					[ ] 
					[ ] ReportStatus("Match options with list columns",FAIL,"{lsListButtons[i]} is not matched to List View of Bills Upcoming tab {sListViewActual}")
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
			[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //############# Verify Monthly List view  on Upcoming Tab under Bills for Income Reminder #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test24_Monthly_List_Tab_UI_Income_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Monthly List View has :
		[ ] // 1.View as
		[ ] // 2. Monthly timeline
		[ ] // 3. Actions : Edit,Enter,skip
		[ ] // 4. Add Reminder
		[ ] // 5.Manage reminders
		[ ] // 6. Account Filter
		[ ] //
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Monthly List View Tab has all mentioned UI Controls	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  7th June May 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test24_Monthly_List_Tab_UI_Income_Reminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual,lsListButtons
		[ ] STRING sStatus,sListViewHandle,sListViewActual,sMonthText
		[ ] INTEGER iCount
		[ ] //DATETIME sDateTime1,sDateTime2
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] lsViewAsList={"Stack","List","Calendar","Monthly List"}
		[ ] lsAccountsList={"All Accounts","QCombo_Separator","Checking 01 Account"}
		[ ] lsDueWithinList={"7 days","14 days","30 days","90 days","12 months"}
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsReminderData=lsExcelData[2]
		[ ] lsReminderData[3]=sDate
		[ ] 
		[ ] 
		[ ] lsListButtons={"Edit","Enter","Skip"}
		[ ] // sStatus="Due Today"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //-------------Navigate to Bills tab----------------
		[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
		[ ] 
		[ ] 
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] //Navigate to Stack View on Upcoming tab
			[ ] MDIClient.Bills.ViewAsPopupList.Select(lsViewAsList[4])
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify View As contents
			[+] if(MDIClient.Bills.ViewAsPopupList.Exists(5))
				[ ] 
				[ ] lsActual=MDIClient.Bills.ViewAsPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] bMatch=MatchStr(lsActual[i],lsViewAsList[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsViewAsList[i]} is present under View As PopUpList for Monthly List")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsViewAsList[i]} is missing from under View As PopUpList for Monthly List")
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify View As PopUpList ",FAIL,"View As PopUpList missing un der Upcoming Tab")
				[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Account list contents
			[+] if(MDIClient.Bills.AccountPopupList.Exists(5))
				[ ] lsActual=MDIClient.Bills.AccountPopupList.GetContents()
				[ ] 
				[+] for(i=1;i<=ListCount(lsActual);i++)
					[ ] bMatch=MatchStr(lsActual[i],lsAccountsList[i])
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsAccountsList[i]} is present under Account list ")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsAccountsList[i]} is missing from under Account list")
						[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Account list contents ",FAIL,"Verify Account list contents missing under Upcoming Tab")
			[ ] 
			[ ] 
			[ ] //Verify previous month button
			[+] if(MDIClient.Bills.PreviousMonth.Exists(5))
				[ ] ReportStatus("Verify Previous Month button is present on Month Selector under Upcoming Tab",PASS," Previous month is present in Month Selector text")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Previous Month button is present on Month Selector under Upcoming Tab",FAIL," Previous month is not present in Month Selector text")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] //Verify Month Selector
			[+] if(MDIClient.Bills.MonthSelectorText.Exists(5))
				[ ] sMonthText=MDIClient.Bills.MonthSelectorText.GetText()
				[ ] ReportStatus("Verify Month Selector under Upcoming Tab",PASS,"Month Selector is displayed")
				[ ] 
				[ ] //Match Month to month selector text
				[ ] sDate=ModifyDate(0,"mmm")  
				[ ] bMatch=MatchStr("*{sDate}*",sMonthText)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Month Selector under Upcoming Tab",PASS,"{sDate} is matched to Month Selector text {sMonthText}")
				[+] else
					[ ] ReportStatus("Verify Month Selector under Upcoming Tab",FAIL,"{sDate} is not matched to Month Selector text {sMonthText}")
					[ ] 
				[ ] 
				[ ] 
				[ ] //Match Year to month selector text
				[ ] sDate=ModifyDate(0,"yyyy")  
				[ ] bMatch=MatchStr("*{sDate}*",sMonthText)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify Month Selector under Upcoming Tab",PASS,"{sDate} is matched to Month Selector text {sMonthText}")
				[+] else
					[ ] ReportStatus("Verify Month Selector under Upcoming Tab",FAIL,"{sDate} is not matched to Month Selector text {sMonthText}")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Month Selector under Upcoming Tab",FAIL,"Month Selector is not displayed")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Verify next month button
			[+] if(MDIClient.Bills.NextMonth.Exists(5))
				[ ] ReportStatus("Verify Next Month button is present on Month Selector under Upcoming Tab",PASS," Next month is present in Month Selector text")
			[+] else
				[ ] ReportStatus("Verify Next Month button is present on Month Selector under Upcoming Tab",FAIL," Next month is not present in Month Selector text")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //---------------Match Content in all Rows with details---------------------------
			[ ] sListViewHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
			[ ] sListViewActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sListViewHandle,Str(0))
			[ ] 
			[ ] 
			[ ] //Match Bill Details
			[ ] iCount=ListCount(lsReminderData)-4                 // Match the first 4 values of excel sheet row
			[+] for(i=1;i<=iCount;i++)
				[ ] 
				[+] if(lsReminderData[i]!=NULL)
					[ ] bMatch=MatchStr("*{lsReminderData[i]}*",sListViewActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Match options with list columns",PASS,"{lsReminderData[i]} is matched to Monthly List View of Bills Upcoming tab")
					[+] else
						[ ] ReportStatus("Match options with list columns",FAIL,"{lsReminderData[i]} is not matched to Monthly List View of Bills Upcoming tab {sListViewActual}")
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //Match List Buttons
			[+] for(i=1;i<=ListCount(lsListButtons);i++)
				[ ] 
				[ ] 
				[ ] bMatch=MatchStr("*{lsListButtons[i]}*",sListViewActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Match options with list columns",PASS,"{lsListButtons[i]} is matched to Monthly List View of Bills Upcoming tab")
					[ ] 
				[+] else
					[ ] 
					[ ] ReportStatus("Match options with list columns",FAIL,"{lsListButtons[i]} is not matched to Monthly List View of Bills Upcoming tab {sListViewActual}")
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] sPayeeName=lsReminderData[1]
			[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
			[+] if(iValidate==PASS)									  	 
				[ ] 
				[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
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
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window  doesn't exist")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] //------------6th June----------------
[ ] 
[+] //################ Verify Stack view  on Upcoming Tab under Bills Due Within next 30 days for Income Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test25_Stack_View_Bills_Due_Within_Next_30_Days_Income_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills Due Within next 30 days for Income Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Income reminder with proper date, payee name , amount should NOT be displayed in stack.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  6th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test25_Stack_View_Bills_Due_Within_Next_30_Days_Income_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] // LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Income"
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(30,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="15"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] //Restart Quicken to handle bills >Get Started snapshot refresh issue
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select Stack view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under Stack view on Bills Upcoming tab---------------
				[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Exists(5))
					[ ] 
					[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild.Edit.Exists(5))
						[ ] ReportStatus("Verify if Bill is displayed under stack view",PASS,"Bill is Not displayed under stack view")
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of added Income Reminder ", FAIL, "Income Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify Stack view  on Upcoming Tab under Bills Due Within next for 30 days for Income Reminder for future date  ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test26_Stack_View_Bills_Due_Within_Next_30_Days_Income_Reminder_Future_Date()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills Due Within next for 30 days for Income Reminder for future date
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Income reminder with proper date, payee name , amount should be displayed in stack.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  6th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test26_Stack_View_Bills_Due_Within_Next_30_Days_Income_Reminder_Future_Date() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Income"
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(30,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="32"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Income Reminder ", PASS, "Income Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is displayed----------
				[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[+] if(iValidate==PASS)
					[ ] //Select Stack view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
					[ ] //-------Verify content under Stack view on Bills Upcoming tab---------------
					[+] if(MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Exists(5))
						[ ] 
						[+] if(MDIClient.Bills.Panel.Panel1.QWinChild1.Edit.Exists(5))
							[ ] ReportStatus("Verify if Bill is displayed under stack view",PASS,"Bill is displayed under stack view for {sDayFilter}")
						[+] else
							[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is Not displayed under stack view for {sDayFilter}")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is Not displayed under stack view")
				[+] else
					[ ] ReportStatus("Navigate to Bills tab",FAIL,"Bills tab not opened")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
				[ ] ReportStatus("Verification of  added Income Reminder ", FAIL, "Income Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window  doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify Stack view  on Upcoming Tab under Bills Due Within next 14 days for Income Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test27_Stack_View_Bills_Due_Within_Next_14_Days_Income_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills Due Within next 14 days for Income Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Income reminder with proper date, payee name , amount should NOT be displayed in stack.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  6th June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test27_Stack_View_Bills_Due_Within_Next_14_Days_Income_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] // LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Income"
		[ ] sDayFilter="14 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(30,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read Income data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="15"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] iValidate=NavigateQuickenTab(sTAB_BILL)
				[+] if(iValidate==PASS)
					[ ] //----------Verify that content is NOT displayed----------
					[ ] //Select Stack view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
					[ ] //-------Verify content under Stack view on Bills Upcoming tab---------------
					[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Exists(5))
						[ ] 
						[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild.Edit.Exists(5))
							[ ] ReportStatus("Verify if Bill is displayed under stack view",PASS,"Bill is Not displayed under stack view for {sDayFilter}")
						[+] else
							[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view for {sDayFilter}")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Navigate to Bills tab",FAIL,"Bills tab not opened")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify Stack view  on Upcoming Tab under Bills Due Within next 7 days for Income Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test28_Stack_View_Bills_Due_Within_Next_7_Days_Income_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills Due Within next 14 days for Income Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Income reminder with proper date, payee name , amount should NOT be displayed in stack.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  6th June  May 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test28_Stack_View_Bills_Due_Within_Next_7_Days_Income_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Income"
		[ ] sDayFilter="7 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(30,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="15"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[+] if(iValidate==PASS)
					[ ] //----------Verify that content is NOT displayed----------
					[ ] //Select Stack view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
					[ ] //-------Verify content under Stack view on Bills Upcoming tab---------------
					[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Exists(5))
						[ ] 
						[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild.Edit.Exists(5))
							[ ] ReportStatus("Verify if Bill is displayed under stack view",PASS,"Bill is Not displayed under stack view for {sDayFilter}")
						[+] else
							[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view for {sDayFilter}")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Navigate to Bills tab",FAIL,"Bills tab not opened")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
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
[ ] 
[ ] //------------7th June----------------
[ ] 
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 30 days for Income Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test29_List_View_Bills_Due_Within_Next_30_Days_Income_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 30 days for Income Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Income reminder with proper date, payee name , amount should NOT be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  7th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test29_List_View_Bills_Due_Within_Next_30_Days_Income_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Income"
		[ ] sDayFilter="30 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read Income data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
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
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 90 days for Income Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test30_List_View_Bills_Due_Within_Next_90_Days_Income_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 90 days for Income Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Income reminder with proper date, payee name , amount should be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  7th June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test30_List_View_Bills_Due_Within_Next_90_Days_Income_Reminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Income"
		[ ] sDayFilter="90 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
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
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 12 months for Income Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test31_List_View_Bills_Due_Within_Next_12_Months_Income_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 12 months for Income Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Income reminder with proper date, payee name , amount should be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  7th June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test31_List_View_Bills_Due_Within_Next_12_Months_Income_Reminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Income"
		[ ] sDayFilter="12 Months"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read Income data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 14 days for Income Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test32_List_View_Bills_Due_Within_Next_14_Days_Income_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 14 days for Income Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Income reminder with proper date, payee name , amount should NOT be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  7th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test32_List_View_Bills_Due_Within_Next_14_Days_Income_Reminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Income"
		[ ] sDayFilter="14 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read Income data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 7 days for Income Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test33_List_View_Bills_Due_Within_Next_7_Days_Income_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 7 days for Income Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If The Income reminder with proper date, payee name , amount should NOT be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  7th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test33_List_View_Bills_Due_Within_Next_7_Days_Income_Reminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Income"
		[ ] sDayFilter="14 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore)
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] //-------17th June 2013-------
[ ] 
[ ] 
[+] //############# Verify Stack view  on Upcoming Tab under Bills for Transfer Reminder #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test34_Stack_View_Upcoming_Tab_UI_Transfer_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills for Transfer Reminder
		[ ] // 1. View as : Stack, List ,Calendar , Monthly List
		[ ] // 2. Account : All Accounts ,Checking
		[ ] // 3. Due within Next : 14 days,7 days , 30 days
		[ ] // 4. Include Paid <checkbox>
		[ ] // 5.Add Reminder drop down
		[ ] // 6. Manage Reminders button
		[ ] //
		[ ] // Stack View has :
		[ ] // 1.Due Date
		[ ] // 2. Amount
		[ ] // 3.Enter button
		[ ] // 4.Skip Button
		[ ] // 5.Status 
		[ ] // 6.Payment Method
		[ ] // 7.Edit Button
		[ ] // 8.Show History button
		[ ] // 9.PayeeName
		[ ] //   
		[ ] //
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Upcoming Tab has all mentioned UI Controls	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test34_Stack_View_Upcoming_Tab_UI_Transfer_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] lsViewAsList={"Stack","List","Calendar","Monthly List"}
		[ ] //lsAccountsList={"All Accounts","QCombo_Separator","Checking 01 Account"}
		[ ] lsDueWithinList={"7 days","14 days","30 days"}
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Transfer"
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------First Savings account----------
		[ ] 
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[3]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="15"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] //----------------Add a Savings Account------------------
		[ ] iValidate=AddManualSpendingAccount(lsAddAccount2[1],lsAddAccount2[2],lsAddAccount2[3])
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Add a Savings Account",PASS,"Savings Account Added successfully")
			[ ] //--------------Add a Reminder---------------------
			[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
					[ ] 
					[ ] 
					[ ] 
					[ ] //-------------Navigate to Bills tab----------------
					[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
					[ ] 
					[ ] 
					[+] if(iValidate==PASS)
						[ ] 
						[ ] 
						[ ] //Navigate to Stack View on Upcoming tab
						[ ] MDIClient.Bills.ViewAsPopupList.Select(lsViewAsList[1])
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify View As contents
						[+] if(MDIClient.Bills.ViewAsPopupList.Exists(5))
							[ ] 
							[ ] lsActual=MDIClient.Bills.ViewAsPopupList.GetContents()
							[ ] 
							[+] for(i=1;i<=ListCount(lsActual);i++)
								[ ] bMatch=MatchStr(lsActual[i],lsViewAsList[i])
								[+] if(bMatch==TRUE)
									[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsViewAsList[i]} is present under View As PopUpList")
									[ ] 
								[+] else
									[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsViewAsList[i]} is missing from under View As PopUpList")
									[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify View As PopUpList ",FAIL,"View As PopUpList missing un der Upcoming Tab")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify Due Within contents
						[+] if(MDIClient.Bills.DueWithinNextPopupList.Exists(5))
							[ ] lsActual=MDIClient.Bills.DueWithinNextPopupList.GetContents()
							[ ] 
							[+] for(i=1;i<=ListCount(lsActual);i++)
								[ ] bMatch=MatchStr(lsActual[i],lsDueWithinList[i])
								[+] if(bMatch==TRUE)
									[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsDueWithinList[i]} is present under Due Within List")
									[ ] 
								[+] else
									[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsDueWithinList[i]} is missing from under Due Within List")
									[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Due Within contents ",FAIL,"Verify Due Within contents missing un der Upcoming Tab")
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify Edit button
						[+] if(MDIClient.Bills.Panel.Panel1.QWinChild1.Edit.Exists(5))
							[ ] ReportStatus("Verify Edit Button for Stack View under Upcoming Tab",PASS,"Edit button is present in Stack view")
						[+] else
							[ ] ReportStatus("Verify Edit Button for Stack View under Upcoming Tab",FAIL,"Edit button is present in Stack view")
						[ ] 
						[ ] 
						[ ] // Verify Enter button
						[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.Enter.Exists(5))
							[ ] ReportStatus("Verify Enter Button for Stack View under Upcoming Tab",PASS,"Enter button is present in Stack view")
						[+] else
							[ ] ReportStatus("Verify Enter Button for Stack View under Upcoming Tab",FAIL,"Enter button is present in Stack view")
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] // Verify Show History button
						[+] if(MDIClient.Bills.Panel.Panel1.QWinChild1.ShowHistory.Exists(5))
							[ ] ReportStatus("Verify Show History Button for Stack View under Upcoming Tab",PASS,"Show History button is present in Stack view")
						[+] else
							[ ] ReportStatus("Verify Show History Button for Stack View under Upcoming Tab",FAIL,"Show History button is present in Stack view")
							[ ] 
							[ ] 
						[ ] // Verify Skip button
						[+] if(MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Exists(5))
							[ ] ReportStatus("Verify Skip Button for Stack View under Upcoming Tab",PASS,"Skip button is present in Stack view")
						[+] else
							[ ] ReportStatus("Verify Skip Button for Stack View under Upcoming Tab",FAIL,"Skip button is present in Stack view")
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
					[+] if(iValidate==PASS)									  	 
						[ ] 
						[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
					[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
				[ ] DlgAddEditReminder.Close()
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
			[ ] ReportStatus("Add A Savings Account",FAIL,"Savings Account not added")
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
[ ] //-------18th June 2013-------
[ ] 
[+] //################### Verify List view  on Upcoming Tab under Bills for Transfer Reminder ###################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test35_List_View_Upcoming_Tab_UI_Transfer_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills for Transfer Reminder
		[ ] // 1. View as : Stack, List ,Calendar , Monthly List
		[ ] // 2. Account : All Accounts ,Checking
		[ ] // 3. Due within Next : 7 days,14 days,30 days,90 days,12 months
		[ ] //
		[ ] // List View has :
		[ ] // 1.Status 
		[ ] // 2.Due Date
		[ ] // 2. Amount
		[ ] // 3.Payto /From
		[ ] // 4.Actions : Edit,Enter,Skip
		[ ] // 5.Account Filter
		[ ] //   
		[ ] //
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Upcoming Tab has all mentioned UI Controls	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  8th June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test35_List_View_Upcoming_Tab_UI_Transfer_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual,lsListButtons
		[ ] STRING sStatus,sListViewHandle,sListViewActual
		[ ] INTEGER iCount
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] lsViewAsList={"Stack","List","Calendar","Monthly List"}
		[ ] lsAccountsList={"All Accounts","QCombo_Separator","Checking 01 Account"}
		[ ] lsDueWithinList={"7 days","14 days","30 days","90 days","12 months"}
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Transfer"
		[ ] sDayFilter="30 Days"
		[ ] lsListButtons={"Edit","Enter","Skip"}
		[ ] // sStatus="Due Today"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[3]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="15"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //-------------Navigate to Bills tab----------------
				[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[ ] 
				[ ] 
				[+] if(iValidate==PASS)
					[ ] 
					[ ] 
					[ ] //Navigate to Stack View on Upcoming tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(lsViewAsList[2])
					[ ] 
					[ ] 
					[ ] //Verify View As contents
					[+] if(MDIClient.Bills.ViewAsPopupList.Exists(5))
						[ ] 
						[ ] lsActual=MDIClient.Bills.ViewAsPopupList.GetContents()
						[ ] 
						[+] for(i=1;i<=ListCount(lsActual);i++)
							[ ] bMatch=MatchStr(lsActual[i],lsViewAsList[i])
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsViewAsList[i]} is present under View As PopUpList")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsViewAsList[i]} is missing from under View As PopUpList")
								[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify View As PopUpList ",FAIL,"View As PopUpList missing un der Upcoming Tab")
						[ ] 
					[ ] 
					[ ] 
					[ ] //Verify Account list contents
					[+] if(MDIClient.Bills.AccountPopupList.Exists(5))
						[ ] lsActual=MDIClient.Bills.AccountPopupList.GetContents()
						[ ] 
						[+] for(i=1;i<=ListCount(lsActual);i++)
							[ ] bMatch=MatchStr(lsActual[i],lsAccountsList[i])
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsAccountsList[i]} is present under Account list ")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsAccountsList[i]} is missing from under Account list")
								[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Account list contents ",FAIL,"Verify Account list contents missing under Upcoming Tab")
					[ ] 
					[ ] 
					[ ] 
					[ ] //Verify Due Within contents
					[+] if(MDIClient.Bills.DueWithinNextPopupList.Exists(5))
						[ ] lsActual=MDIClient.Bills.DueWithinNextPopupList.GetContents()
						[ ] 
						[+] for(i=1;i<=ListCount(lsActual);i++)
							[ ] bMatch=MatchStr(lsActual[i],lsDueWithinList[i])
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsDueWithinList[i]} is present under Due Within List")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsDueWithinList[i]} is missing from under Due Within List")
								[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Due Within contents ",FAIL,"Verify Due Within contents missing un der Upcoming Tab")
					[ ] 
					[ ] 
					[ ] //---------------Match Content in all Rows with details---------------------------
					[ ] sListViewHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
					[ ] sListViewActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sListViewHandle,Str(0))
					[ ] 
					[ ] 
					[ ] //Match Bill Details
					[ ] bMatch=MatchStr("*{sPayeeName}*",sListViewActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Match options with list columns",PASS,"Payee name {sPayee} is matched to List View of Bills Upcoming tab")
						[ ] 
					[+] else
						[ ] 
						[ ] ReportStatus("Match options with list columns",FAIL,"Payee name {sPayee} is not matched to List View of Bills Upcoming tab {sListViewActual}")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] bMatch=MatchStr("*{sTransactionAmount}*",sListViewActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Match options with list columns",PASS,"Transaction Amount {sTransactionAmount} is matched to List View of Bills Upcoming tab")
						[ ] 
					[+] else
						[ ] 
						[ ] ReportStatus("Match options with list columns",FAIL,"Transaction Amount {sTransactionAmount} is not matched to List View of Bills Upcoming tab {sListViewActual}")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] // //Match Status
					[ ] // bMatch=MatchStr("*{sStatus}*",sListViewActual)
					[+] // if(bMatch==TRUE)
						[ ] // ReportStatus("Match options with list columns",PASS,"{sStatus} is matched to List View of Bills Upcoming tab")
						[ ] // 
					[+] // else
						[ ] // 
						[ ] // ReportStatus("Match options with list columns",FAIL,"{sStatus} is not matched to List View of Bills Upcoming tab {sListViewActual}")
						[ ] // 
						[ ] // 
						[ ] // 
					[ ] 
					[ ] 
					[ ] 
					[ ] //Match List Buttons
					[+] for(i=1;i<=ListCount(lsListButtons);i++)
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{lsListButtons[i]}*",sListViewActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Match options with list columns",PASS,"{lsListButtons[i]} is matched to List View of Bills Upcoming tab")
							[ ] 
						[+] else
							[ ] 
							[ ] ReportStatus("Match options with list columns",FAIL,"{lsListButtons[i]} is not matched to List View of Bills Upcoming tab {sListViewActual}")
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
					[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //############# Verify Monthly List view  on Upcoming Tab under Bills for Transfer Reminder #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test37_Monthly_List_Tab_UI_Transfer_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Monthly List View Tranfer Reminder UI content:
		[ ] // 1.View as
		[ ] // 2. Monthly timeline
		[ ] // 3. Actions : Edit,Enter,skip
		[ ] // 4. Add Reminder
		[ ] // 5.Manage reminders
		[ ] // 6. Account Filter
		[ ] //
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Monthly List View Tab has all mentioned UI Controls	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  7th June May 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test37_Monthly_List_Tab_UI_Transfer_Reminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] LIST OF STRING lsViewAsList,lsAccountsList,lsDueWithinList,lsActual,lsListButtons
		[ ] STRING sStatus,sListViewHandle,sListViewActual,sMonthText
		[ ] INTEGER iCount
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] lsViewAsList={"Stack","List","Calendar","Monthly List"}
		[ ] lsAccountsList={"All Accounts","QCombo_Separator","Checking 01 Account"}
		[ ] lsDueWithinList={"7 days","14 days","30 days","90 days","12 months"}
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsReminderData=lsExcelData[3]
		[ ] lsReminderData[3]=sDate
		[ ] 
		[ ] 
		[ ] lsListButtons={"Edit","Enter","Skip"}
		[ ] // sStatus="Due Today"
		[ ] 
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Transfer"
		[ ] sDayFilter="30 Days"
		[ ] lsListButtons={"Edit","Enter","Skip"}
		[ ] sStatus="Due Today"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[3]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="15"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //-------------Navigate to Bills tab----------------
				[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[+] if(iValidate==PASS)
					[ ] 
					[ ] 
					[ ] //Navigate to Monthly List View on Upcoming tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(lsViewAsList[4])
					[ ] 
					[ ] 
					[ ] //Verify View As contents
					[+] if(MDIClient.Bills.ViewAsPopupList.Exists(5))
						[ ] 
						[ ] lsActual=MDIClient.Bills.ViewAsPopupList.GetContents()
						[ ] 
						[+] for(i=1;i<=ListCount(lsActual);i++)
							[ ] bMatch=MatchStr(lsActual[i],lsViewAsList[i])
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsViewAsList[i]} is present under View As PopUpList for Monthly List")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsViewAsList[i]} is missing from under View As PopUpList for Monthly List")
								[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify View As PopUpList ",FAIL,"View As PopUpList missing un der Upcoming Tab")
						[ ] 
					[ ] 
					[ ] 
					[ ] //Verify Account list contents
					[+] if(MDIClient.Bills.AccountPopupList.Exists(5))
						[ ] lsActual=MDIClient.Bills.AccountPopupList.GetContents()
						[ ] 
						[+] for(i=1;i<=ListCount(lsActual);i++)
							[ ] bMatch=MatchStr(lsActual[i],lsAccountsList[i])
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Verify options under View As PopupList",PASS,"Option {lsAccountsList[i]} is present under Account list ")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify options under View As PopupList",FAIL,"Option {lsAccountsList[i]} is missing from under Account list")
								[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Account list contents ",FAIL,"Verify Account list contents missing under Upcoming Tab")
					[ ] 
					[ ] 
					[ ] //Verify Month Selector
					[+] if(MDIClient.Bills.MonthSelectorText.Exists(5))
						[ ] sMonthText=MDIClient.Bills.MonthSelectorText.GetText()
						[ ] ReportStatus("Verify Month Selector under Upcoming Tab",PASS,"Month Selector is displayed")
						[ ] 
						[ ] //Match Month to month selector text
						[ ] sDate=ModifyDate(0,"mmm")  
						[ ] bMatch=MatchStr("*{sDate}*",sMonthText)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify Month Selector under Upcoming Tab",PASS,"{sDate} is matched to Month Selector text {sMonthText}")
						[+] else
							[ ] ReportStatus("Verify Month Selector under Upcoming Tab",FAIL,"{sDate} is not matched to Month Selector text {sMonthText}")
							[ ] 
						[ ] 
						[ ] 
						[ ] //Match Year to month selector text
						[ ] sDate=ModifyDate(0,"yyyy")  
						[ ] bMatch=MatchStr("*{sDate}*",sMonthText)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify Month Selector under Upcoming Tab",PASS,"{sDate} is matched to Month Selector text {sMonthText}")
						[+] else
							[ ] ReportStatus("Verify Month Selector under Upcoming Tab",FAIL,"{sDate} is not matched to Month Selector text {sMonthText}")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Month Selector under Upcoming Tab",FAIL,"Month Selector is not displayed")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] //Verify previous month button
					[+] if(MDIClient.Bills.PreviousMonth.Exists(5))
						[ ] ReportStatus("Verify Previous Month button is present on Month Selector under Upcoming Tab",PASS," Previous month is present in Month Selector text")
					[+] else
						[ ] ReportStatus("Verify Previous Month button is present on Month Selector under Upcoming Tab",FAIL," Previous month is not present in Month Selector text")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] //Verify next month button
					[+] if(MDIClient.Bills.NextMonth.Exists(5))
						[ ] ReportStatus("Verify Next Month button is present on Month Selector under Upcoming Tab",PASS," Next month is present in Month Selector text")
					[+] else
						[ ] ReportStatus("Verify Next Month button is present on Month Selector under Upcoming Tab",FAIL," Next month is not present in Month Selector text")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //---------------Match Content in all Rows with details---------------------------
					[ ] sListViewHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
					[ ] sListViewActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sListViewHandle,Str(0))
					[ ] 
					[ ] 
					[ ] //Match Bill Details
					[ ] iCount=ListCount(lsReminderData)-4                 // Match the first 4 values of excel sheet row
					[+] for(i=1;i<=iCount;i++)
						[ ] 
						[ ] bMatch=MatchStr("*{lsReminderData[i]}*",sListViewActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Match options with list columns",PASS,"{lsReminderData[i]} is matched to Monthly List View of Bills Upcoming tab")
						[+] else
							[ ] ReportStatus("Match options with list columns",FAIL,"{lsReminderData[i]} is not matched to Monthly List View of Bills Upcoming tab {sListViewActual}")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] // //Match Status
					[ ] // bMatch=MatchStr("*{sStatus}*",sListViewActual)
					[+] // if(bMatch==TRUE)
						[ ] // ReportStatus("Match options with list columns",PASS,"{sStatus} is matched to Monthly List View of Bills Upcoming tab")
						[ ] // 
					[+] // else
						[ ] // 
						[ ] // ReportStatus("Match options with list columns",FAIL,"{sStatus} is not matched to Monthly List View of Bills Upcoming tab {sListViewActual}")
						[ ] // 
						[ ] // 
						[ ] // 
					[ ] 
					[ ] 
					[ ] 
					[ ] //Match List Buttons
					[+] for(i=1;i<=ListCount(lsListButtons);i++)
						[ ] 
						[ ] 
						[ ] bMatch=MatchStr("*{lsListButtons[i]}*",sListViewActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Match options with list columns",PASS,"{lsListButtons[i]} is matched to Monthly List View of Bills Upcoming tab")
							[ ] 
						[+] else
							[ ] 
							[ ] ReportStatus("Match options with list columns",FAIL,"{lsListButtons[i]} is not matched to Monthly List View of Bills Upcoming tab {sListViewActual}")
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
					[ ] ReportStatus("Navigate to Bills Upcoming Tab",FAIL,"Error during Navigation to Bills Upcoming Tab")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] 
[ ] //-------12th June 2013-------
[ ] 
[+] //################ Verify Stack view  on Upcoming Tab under Bills Due Within next 30 days for Transfer Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test38_Stack_View_Bills_Due_Within_Next_30_Days_Transfer_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills Due Within next 30 days for Transfer Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If The Transfer reminder with proper date, payee name , amount should NOT be displayed in stack.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  12th June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test38_Stack_View_Bills_Due_Within_Next_30_Days_Transfer_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] 
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Transfer"
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(30,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[3]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="15"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(SHORT_SLEEP))
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] //Restart Quicken to handle bills >Get Started snapshot refresh issue
				[ ] 
				[ ] LaunchQuicken()
				[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select Stack view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under Stack view on Bills Upcoming tab---------------
				[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Exists(5))
					[ ] 
					[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild.Edit.Exists(5))
						[ ] ReportStatus("Verify if Bill is displayed under stack view",PASS,"Bill is Not displayed under stack view")
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
						[ ] 
				[+] else
					[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify Stack view  on Upcoming Tab under Bills Due Within next for 30 days for Transfer Reminder for future date  ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test39_Stack_View_Bills_Due_Within_Next_30_Days_Transfer_Reminder_Future_Date()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills Due Within next for 30 days for Transfer Reminder for future date
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If The Transfer reminder with proper date, payee name , amount should be displayed in stack.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  12th June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test39_Stack_View_Bills_Due_Within_Next_30_Days_Transfer_Reminder_Future_Date() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] 
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Transfer"
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(30,sDateFormat)
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] 
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[3]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="32"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[+] if(iValidate==PASS)
					[ ] //Select Stack view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
					[ ] //-------Verify content under Stack view on Bills Upcoming tab---------------
					[+] if(MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Exists(5))
						[ ] 
						[+] if(MDIClient.Bills.Panel.Panel1.QWinChild1.Edit.Exists(5))
							[ ] ReportStatus("Verify if Bill is displayed under stack view",PASS,"Bill is displayed under stack view for {sDayFilter}")
						[+] else
							[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is Not displayed under stack view for {sDayFilter}")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is Not displayed under stack view")
				[+] else
					[ ] ReportStatus("Navigate to Bills tab",FAIL,"Bills tab not opened")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] 
[+] //################ Verify Stack view  on Upcoming Tab under Bills Due Within next 14 days for Transfer Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test40_Stack_View_Bills_Due_Within_Next_14_Days_Transfer_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills Due Within next 14 days for Transfer Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If The Transfer reminder with proper date, payee name , amount should NOT be displayed in stack.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  12th June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test40_Stack_View_Bills_Due_Within_Next_14_Days_Transfer_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] 
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Transfer"
		[ ] sDayFilter="14 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(30,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[3]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="15"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[+] if(iValidate==PASS)
					[ ] //----------Verify that content is NOT displayed----------
					[ ] //Select Stack view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
					[ ] //-------Verify content under Stack view on Bills Upcoming tab---------------
					[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Exists(5))
						[ ] 
						[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild.Edit.Exists(5))
							[ ] ReportStatus("Verify if Bill is displayed under stack view",PASS,"Bill is Not displayed under stack view for {sDayFilter}")
						[+] else
							[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view for {sDayFilter}")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Navigate to Bills tab",FAIL,"Bills tab not opened")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[+] //################ Verify Stack view  on Upcoming Tab under Bills Due Within next 7 days for Transfer Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test41_Stack_View_Bills_Due_Within_Next_7_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Stack view  on Upcoming Tab under Bills Due Within next 14 days for Transfer Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If The Transfer reminder with proper date, payee name , amount should NOT be displayed in stack.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  31st  May 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test41_Stack_View_Bills_Due_Within_Next_7_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sListOption,sReminderType,sDaysBefore,sBillDate,sTransactionAmount,sPayeeName,sHandle,sActual,sDayFilter
		[ ] 
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Transfer"
		[ ] sDayFilter="7 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(30,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[3]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="15"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[+] if(iValidate==PASS)
					[ ] //----------Verify that content is NOT displayed----------
					[ ] //Select Stack view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
					[ ] //-------Verify content under Stack view on Bills Upcoming tab---------------
					[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild1.SkipButton.Exists(5))
						[ ] 
						[+] if(!MDIClient.Bills.Panel.Panel1.QWinChild.Edit.Exists(5))
							[ ] ReportStatus("Verify if Bill is displayed under stack view",PASS,"Bill is Not displayed under stack view for {sDayFilter}")
						[+] else
							[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view for {sDayFilter}")
							[ ] 
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is displayed under stack view")
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Navigate to Bills tab",FAIL,"Bills tab not opened")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
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
[ ] 
[ ] //-----------13th June----------------
[ ] 
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 30 days for Transfer Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test42_List_View_Bills_Due_Within_Next_30_Days_Transfer_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 30 days for Transfer Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If The Transfer reminder with proper date, payee name , amount should NOT be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  13th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test42_List_View_Bills_Due_Within_Next_30_Days_Transfer_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Transfer"
		[ ] sDayFilter="30 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] // Read Income data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[3]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 90 days for Transfer Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test43_List_View_Bills_Due_Within_Next_90_Days_Transfer_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 90 days for Transfer Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If The Transfer reminder with proper date, payee name , amount should be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  13th June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test43_List_View_Bills_Due_Within_Next_90_Days_Transfer_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Transfer"
		[ ] sDayFilter="90 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[3]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] // 
[ ] 
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 12 months for Transfer Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test44_List_View_Bills_Due_Within_Next_12_Months_Transfer_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 12 months for Transfer Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If The Transfer reminder with proper date, payee name , amount should be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  13th June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test44_List_View_Bills_Due_Within_Next_12_Months_Transfer_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Transfer"
		[ ] sDayFilter="12 Months"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] // Read Income data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[3]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] // // ---------------14th June------------
[ ] 
[ ] 
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 14 days for Transfer Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test45_List_View_Bills_Due_Within_Next_14_Days_Transfer_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 14 days for Transfer Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If The Transfer reminder with proper date, payee name , amount should NOT be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  13th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test45_List_View_Bills_Due_Within_Next_14_Days_Transfer_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Transfer"
		[ ] sDayFilter="14 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] // Read Income data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[3]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
			[ ] DlgAddEditReminder.Close()
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
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
[+] //################ Verify List View on Upcoming Tab under Bills Due Within next 7 days for Transfer Reminder ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test46_List_View_Bills_Due_Within_Next_7_Days_Transfer_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify List view  on Upcoming Tab under Bills Due Within next 7 days for Transfer Reminder
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If The Transfer reminder with proper date, payee name , amount should NOT be displayed in list.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  13th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test46_List_View_Bills_Due_Within_Next_7_Days_Transfer_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] 
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="List"
		[ ] sReminderType="Transfer"
		[ ] sDayFilter="14 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(32,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[3]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] sDaysBefore="31"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(sReminderType,sPayeeName,sTransactionAmount,sBillDate,sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Verification of  added Transfer Reminder ", PASS, "Transfer Reminder with '{sPayeeName}' is added successfully")
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that content is NOT displayed----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] 
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is found under list view of Upcoming tab for filter {sDayFilter}")
						[ ] break
				[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is not displayed under list view of Upcoming tab for filter {sDayFilter}")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists",FAIL,"Quicken does not Exist")
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
[ ] 
[ ] //---------------19th June-------------------
[ ] 
[ ] 
[+] //############################## Verify Edit Transaction- Single Instance ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test47_Verify_Edit_Transaction_Single_Instance()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Transaction- Single Instance
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Single instance of Reminder is edited 
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test47_Verify_Edit_Transaction_Single_Instance() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sVerificationOption,sNewAmount,sVerificationFilter
		[ ] INTEGER iCount
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Bill"
		[ ] sDayFilter="30 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] sVerificationOption="List"
		[ ] sVerificationFilter="90 Days"
		[ ] sNewAmount="17.33"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] 
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
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[+] if( iValidate==PASS)
				[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sBillDate)
				[ ] 
				[ ] DlgAddEditReminder.DoneButton.Click()
				[ ] 
				[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] //-----------------Edit Single instance on Bills tab -------------------------
				[ ] //Select Stack view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //Click on Edit button
				[ ] MDIClient.Bills.Panel.Panel1.QWinChild1.Edit.Click()
				[ ] //Select option
				[ ] MDIClient.Bills.Panel.Panel1.QWinChild1.Edit.EditSingleInstance.Click()
				[ ] 
				[ ] 
				[ ] 
				[+] if(EditReminder.Exists(5))
					[ ] EditReminder.SetActive()
					[ ] EditReminder.AmountTextField.SetText(sNewAmount)
					[ ] EditReminder.OK.Click()
					[ ] 
					[ ] 
					[ ] // -------------Verify new bill amount is changed only for first Bill from list view---------------
					[ ] //Select Stack view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sVerificationOption)
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sVerificationFilter)
					[ ] 
					[+] if(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.Exists(5))
						[ ] iCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
						[ ] 
						[ ] // -------------Verify new bill amount ------------
						[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
						[+] for(i=0; i< iCount; i++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
							[ ] 
							[+] if(i==0)
								[ ] bMatch = MatchStr("*{lsAddBill[1]}*{sNewAmount}*",sActual)
								[+] if(bMatch==TRUE)
									[ ] ReportStatus("Verify if Single instance of Bill Reminder is edited", PASS, "Bill Reminder with '{lsAddBill[1]}' is edited successfully with amount {sNewAmount}")
								[+] else
									[ ] ReportStatus("Verify if Single instance of Bill Reminder is edited", FAIL, "Bill Reminder for {lsAddBill[1]} is NOT edited, sActual = {sActual}")
							[ ] 
							[+] if(i>0)
								[ ] bMatch = MatchStr("*{lsAddBill[1]}*{lsAddBill[2]}*",sActual)
								[+] if(bMatch==TRUE)
									[ ] ReportStatus("Verify if Multiple instances of Bill Reminder is not edited", PASS, "Future Bill Reminder with payee '{lsAddBill[1]}' is not edited")
								[+] else
									[ ] ReportStatus("Verify if Multiple instances of Bill Reminder is not edited ", FAIL, "Future Bill Reminder for {lsAddBill[1]} is edited, sActual = {sActual}")
								[ ] 
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] // Delete Reminder after operation
						[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
						[+] if(iValidate==PASS)									  	 
							[ ] 
							[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify List view of Bill Reminder",FAIL,"List view of Bill reminder is not displayed")
						[ ] 
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Edit Reminder opened",FAIL,"Edit Reminder window for single instance is not opened")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists",FAIL,"Quicken does not Exist")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists",FAIL,"Quicken does not Exist")
		[ ] 
		[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //############################## Verify Edit Transaction- Multiple Instance ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test48_Verify_Edit_Transaction_Multiple_Instance()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Edit Transaction- Multiple Instance
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Multiple instance of Reminder is edited succesfully
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  19th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test48_Verify_Edit_Transaction_Multiple_Instance() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sVerificationOption,sNewAmount,sVerificationFilter
		[ ] INTEGER iCount
		[ ] 
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] sReminderType="Bill"
		[ ] sDayFilter="30 Days"
		[ ] sDelete="Delete"
		[ ] 
		[ ] sVerificationOption="List"
		[ ] sVerificationFilter="90 Days"
		[ ] sNewAmount="12.25"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[2]
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[+] if( iValidate==PASS)
				[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sBillDate)
				[ ] 
				[ ] DlgAddEditReminder.DoneButton.Click()
				[ ] 
				[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
				[ ] CloseAddLinkBiller()
				[ ] //-----------------Edit Multiple instances on Bills tab -------------------------
				[ ] //Select Stack view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select 30 days filter on Stack view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] //Click on Edit button
				[ ] MDIClient.Bills.Panel.Panel1.QWinChild1.Edit.Click()
				[ ] //Select option
				[ ] MDIClient.Bills.Panel.Panel1.QWinChild1.Edit.EditMultipleInstance.Click()
				[ ] 
				[ ] 
				[+] if(DlgAddEditReminder.Exists(5))
					[ ] DlgAddEditReminder.SetActive()
					[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sNewAmount)
					[ ] DlgAddEditReminder.DoneButton.Click()
					[ ] 
					[ ] 
					[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
					[ ] CloseAddLinkBiller()
					[ ] // -------------Verify new bill amount is changed only for first Bill from list view---------------
					[ ] //Select Stack view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sVerificationOption)
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sVerificationFilter)
					[ ] 
					[+] if(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.Exists(5))
						[ ] iCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
						[ ] 
						[ ] // -------------Verify new bill amount ------------
						[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
						[+] for(i=0; i< iCount; i++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
							[ ] 
							[+] if(i==0)
								[ ] bMatch = MatchStr("*{lsAddBill[1]}*{sNewAmount}*",sActual)
								[+] if(bMatch==TRUE)
									[ ] ReportStatus("Verify if Single instance of Bill Reminder is edited", PASS, "Bill Reminder with payee name '{lsAddBill[1]}' is edited successfully with amount {sNewAmount}")
								[+] else
									[ ] ReportStatus("Verify if Single instance of Bill Reminder is edited", FAIL, "Bill Reminder for {lsAddBill[1]} is NOT edited, sActual = {sActual}")
							[ ] 
							[+] if(i>0)
								[ ] bMatch = MatchStr("*{lsAddBill[1]}*{sNewAmount}*",sActual)
								[+] if(bMatch==TRUE)
									[ ] ReportStatus("Verify if Multiple instances of Bill Reminder is not edited", PASS, "Future Bill Reminder with payee name '{lsAddBill[1]}' is edited successfully with amount {sNewAmount}")
								[+] else
									[ ] ReportStatus("Verify if Multiple instances of Bill Reminder is not edited ", FAIL, "Future Bill Reminder for {lsAddBill[1]} is NOT edited, sActual = {sActual}")
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
						[ ] // Delete Reminder after operation
						[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
						[+] if(iValidate==PASS)									  	 
							[ ] 
							[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify List view of Bill Reminder",FAIL,"List view of Bill reminder is not displayed")
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
					[ ] ReportStatus("Verify Edit Reminder opened",FAIL,"Edit Reminder window for single instance is not opened")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Transfer Reminder ", FAIL, "Transfer Reminder with '{sPayeeName}' is not added")
				[ ] 
			[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists",FAIL,"Quicken does not Exist")
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
		[ ] ReportStatus("Verify Quicken Exists",FAIL,"Quicken does not Exist")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] // 
[ ] // 
[ ] //----------------20th & 21st June -----------------------
[ ] 
[+] //############################## Verify Add Reminder Drop Down ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test49_53_Verify_Add_Reminder_Drop_Down()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Add Reminder Drop Down for following options:
		[ ] //1.Bill Reminder
		[ ] //2.Income Reminder
		[ ] //3.Transfer Reminder
		[ ] //4.Invoice Reminder
		[ ] //
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Add Reminder content is verified correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  20th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test49_53_Verify_Add_Reminder_Drop_Down() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sVerificationOption,sWindowCaption
		[ ] LIST OF STRING lsAddAccount1,lsAddAccount2,lsAddAccount3,lsReminderCaptionList
		[ ] 
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] //--------Business Account-----------------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBusinessAccountSheet)
		[ ] lsAddAccount3=lsExcelData[1]
		[ ] 
		[ ] 
		[ ] lsReminderCaptionList={"Bill","Income","Transfer","Invoice"}
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] iValidate=DataFileCreate(sBillsFileName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] // ----------------Add a Checking Account------------------
			[ ] iValidate=AddManualSpendingAccount(lsAddAccount1[1],lsAddAccount1[2],lsAddAccount1[3])
			[+] if(iValidate==PASS)
				[ ] ReportStatus("Add A Checking Account",PASS,"Checking Account Added successfully")
				[ ] 
				[ ] 
				[ ] //-----Verify Add Reminder dropdown when only banking account is added------
				[ ] NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[+] for(i=1;i<=3;i++)
					[ ] QuickenWindow.SetActive()
					[ ] QuickenMainWindow.QWNavigator.AddReminder.DoubleClick()
					[ ] QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_DN,i))
					[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
					[ ] 
					[ ] 
					[ ] //Verify window captions for the first three options
					[+] if(i<=2)
						[ ] 
						[+] if (DlgAddEditReminder.Exists(5))
							[ ] sWindowCaption=DlgAddEditReminder.GetCaption()
							[+] if(DlgAddEditReminder.Exists(5))
								[ ] 
								[ ] bMatch=MatchStr("*Add {lsReminderCaptionList[i]} Reminder*",sWindowCaption)
								[+] if(bMatch==TRUE)
									[ ] ReportStatus("Verify caption of reminder dialog window",PASS,"Correct window opened for {lsReminderCaptionList[i]} reminder when a single banking account is added in data file")
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify caption of reminder dialog window",FAIL,"Wrong window opened for {lsReminderCaptionList[i]} reminder when a single banking account is added in data file")
									[ ] 
									[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if reminder dialog window is opened",FAIL,"Reminder dialog window did not open")
							[ ] 
							[ ] DlgAddEditReminder.Close()
							[ ] WaitForState(DlgAddEditReminder,FALSE,5)
						[+] else
							[ ] ReportStatus("Verify if reminder dialog window is opened",FAIL,"Reminder dialog window did not open")
						[ ] 
					[ ] // If second account does not exists then transfer reminder option is not present and Add Bill Reminder should open on using down key for the 4th time
					[+] if(i==3)
						[ ] 
						[ ] 
						[+] if (AddBiller.Exists(5))
							[ ] AddBiller.SetActive()
							[+] sWindowCaption=AddBiller.GetCaption()
								[ ] bMatch=MatchStr("*Add Bill*",sWindowCaption)
								[+] if(bMatch==TRUE)
									[ ] ReportStatus("Verify caption of reminder dialog window",PASS,"Option for Add online bill  window is displayed when a single banking account is added in data file")
								[+] else 
									[ ] 
									[ ] ReportStatus("Verify caption of reminder dialog window",FAIL,"Wrong window opened")
									[ ] 
								[ ] 
							[ ] 
							[ ] AddBiller.Close()
							[ ] WaitForState(AddBiller,FALSE,5)
						[+] else
							[ ] ReportStatus("Verify if reminder dialog window is opened",FAIL,"Reminder dialog window did not open")
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
				[ ] //----------------Add a second Checking Account------------------
				[ ] iValidate=AddManualSpendingAccount(lsAddAccount2[1],lsAddAccount2[2],lsAddAccount2[3])
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Add A Checking Account",PASS,"Checking Account Added successfully")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //-----Verify Add Reminder dropdown when two banking accounts are added------
					[+] for(i=1;i<=ListCount(lsReminderCaptionList);i++)
						[ ] QuickenWindow.SetActive()
						[ ] NavigateQuickenTab(sTAB_BILL, "Upcoming")
						[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
						[ ] QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_DN,i))
						[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
						[ ] sleep(3)
						[ ] 
						[ ] //Verify window captions for the first three options
						[+] if(i<=3)
							[ ] sWindowCaption=DlgAddEditReminder.GetCaption()
							[ ] bMatch=MatchStr("*Add {lsReminderCaptionList[i]} Reminder*",sWindowCaption)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Verify caption of reminder dialog window",PASS,"Correct window opened for {lsReminderCaptionList[i]} reminder when two accounts are added in data file")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify caption of reminder dialog window",FAIL,"Wrong window opened for {lsReminderCaptionList[i]} reminder when two accounts are added in data file")
								[ ] 
								[ ] 
							[ ] DlgAddEditReminder.Close()
							[ ] WaitForState(DlgAddEditReminder,FALSE,5)
						[ ] 
						[ ] 
						[ ] // If business account does not exists then invoice reminder option is not present and Add Bill Reminder should open on using down key for the 4th time
						[+] if(i==4)
							[ ] 
							[ ] 
							[+] if (AddBiller.Exists(5))
								[ ] AddBiller.SetActive()
								[+] sWindowCaption=AddBiller.GetCaption()
									[ ] bMatch=MatchStr("*Add Bill*",sWindowCaption)
									[+] if(bMatch==TRUE)
										[ ] ReportStatus("Verify caption of reminder dialog window",PASS,"Option for Add online bill  window is displayed when a single banking account is added in data file")
									[+] else 
										[ ] 
										[ ] ReportStatus("Verify caption of reminder dialog window",FAIL,"Wrong window opened")
										[ ] 
									[ ] 
								[ ] 
								[ ] AddBiller.Close()
								[ ] WaitForState(AddBiller,FALSE,5)
							[+] else
								[ ] ReportStatus("Verify if reminder dialog window is opened",FAIL,"Reminder dialog window did not open")
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
					[ ] //----------Add an Invoice Account----------------
					[ ] QuickenWindow.SetActive()
					[ ] iValidate=AddBusinessAccount(lsAddAccount3[1],lsAddAccount3[2])
					[+] if(iValidate==PASS)
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] //-----Verify Add Reminder dropdown when two banking and one business accounts are added------
						[+] for(i=1;i<=ListCount(lsReminderCaptionList);i++)
							[ ] QuickenWindow.SetActive()
							[ ] NavigateQuickenTab(sTAB_BILL, "Upcoming")
							[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
							[ ] QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_DN,i))
							[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
							[ ] sleep(3)
							[+] if(i<=4)
								[ ] sWindowCaption=DlgAddEditReminder.GetCaption()
								[ ] bMatch=MatchStr("*Add {lsReminderCaptionList[i]} Reminder*",sWindowCaption)
								[+] if(bMatch==TRUE)
									[ ] ReportStatus("Verify caption of reminder dialog window",PASS,"Correct window opened for {lsReminderCaptionList[i]} reminder when two accounts are added in data file")
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify caption of reminder dialog window",FAIL,"Wrong window opened for {lsReminderCaptionList[i]} reminder when two accounts are added in data file")
									[ ] 
									[ ] 
								[ ] DlgAddEditReminder.Close()
								[ ] WaitForState(DlgAddEditReminder,FALSE,5)
							[+] if(i==5)
								[+] if (AddBiller.Exists(5))
									[ ] AddBiller.SetActive()
									[+] sWindowCaption=AddBiller.GetCaption()
										[ ] bMatch=MatchStr("*Add Bill*",sWindowCaption)
										[+] if(bMatch==TRUE)
											[ ] ReportStatus("Verify caption of reminder dialog window",PASS,"Option for Add online bill  window is displayed when a single banking account is added in data file")
										[+] else 
											[ ] 
											[ ] ReportStatus("Verify caption of reminder dialog window",FAIL,"Wrong window opened")
											[ ] 
										[ ] 
									[ ] 
									[ ] AddBiller.Close()
									[ ] WaitForState(AddBiller,FALSE,5)
								[+] else
									[ ] ReportStatus("Verify if reminder dialog window is opened",FAIL,"Reminder dialog window did not open")
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
						[ ] ReportStatus("Verify if account is added",FAIL,"Error while adding business account")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Add A Checking Account",FAIL,"Checking Account {lsAddAccount2[2]} not added")
			[+] else
				[ ] ReportStatus("Add A Checking Account",FAIL,"Checking Account {lsAddAccount1[2]} not added")
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
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] // 
[ ] 
[ ] 
[ ] //------------------ 24th June ----------------
[ ] 
[+] //############################## Verify Enter Reminder Button from stack view ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test55_Verify_Enter_Reminder_Button_From_Stack_View()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter reminder functionality from stack view
		[ ] // 1.Reminder appears as Received in List View
		[ ] // 2.Reminder is entered in register
		[ ] //
		[ ] // 
		[ ] //PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Add Reminder content is verified correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  24th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test55_Verify_Enter_Reminder_Button_From_Stack_View() appstate none
	[ ] 
	[ ] 
	[+] //---------Variable Definition----------
		[ ] 
		[ ] STRING sListOption1,sListOption2,sReceivedText,sExpectedNumberOfTransactions,sDayFilter1,sDayFilter2
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption1="Stack"
		[ ] sListOption2="List"
		[ ] 
		[ ] sDayFilter1="30 Days"
		[ ] sDayFilter2="90 Days"
		[ ] 
		[ ] sReceivedText="Received"
		[ ] 
		[ ] sExpectedNumberOfTransactions="1"
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //Restart Quicken to handle bills >Get Started snapshot refresh issue
				[ ] 
				[ ] LaunchQuicken()
				[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
				[ ] 
				[ ] //------Navigate to Stack View-----------
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption1)
				[ ] //--------Click on Enter button in Stack view-----
				[ ] MDIClient.Bills.Panel.Panel1.QWinChild1.EnterButton.Click()
				[+] if(EnterExpenseIncomeTxn.Exists(5))
					[ ] ReportStatus("Verify if enter transaction window is open",PASS,"Enter Transaction window is opened")
					[ ] EnterExpenseIncomeTxn.EnterTransactionButton.Click()
					[ ] 
					[ ] 
					[ ] //--------------Verify if Reminder is entered ---------------
					[ ] //Select Stack view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption2)
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter2)
					[ ] //-------Verify content under List view on Bills Upcoming tab---------------
					[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
					[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
						[ ] 
						[ ] bMatch=MatchStr("*{sPayeeName}*{sTransactionAmount}*{sReceivedText}*",sActual)
						[ ] print(sPayeeName)
						[ ] print(sTransactionAmount)
						[ ] print(sReceivedText)
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is entered")
							[ ] 
							[ ] //iValidate=SelectAccountFromAccountBar(lsAddAccount[2],ACCOUNT_BANKING)
							[ ] 
							[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption1)
							[ ] //Select 30 days filter on Stack view
							[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter1)
							[ ] 
							[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Exists(SHORT_SLEEP))
								[ ] //-------Click on Go to Register button---------
								[ ] MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Click()
								[ ] 
								[ ] iValidate=VerifyTransactionInAccountRegister(sPayeeName,sExpectedNumberOfTransactions)
								[+] if(iValidate==PASS)
									[ ] iValidate=DeleteTransaction(sMDIWindow,sPayeeName)
									[+] if(iValidate==PASS)
										[ ] ReportStatus("Verify that account is displayed in account register",PASS,"Account is displayed in the account register")
										[ ] 
										[ ] 
										[ ] 
										[ ] // Delete Reminder after operation
										[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
										[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
										[+] if(iValidate==PASS)									  	 
											[ ] 
											[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
											[ ] 
										[+] else
											[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
											[ ] 
											[ ] 
										[ ] break
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify if transaction is deleted",FAIL,"Transaction is not deleted")
									[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify that account is displayed in account register",FAIL,"Account is NOT displayed in the account register")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that account has been selected",FAIL,"Account has not been selected from account bar")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
					[ ] 
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is NOT entered")
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
					[ ] ReportStatus("Verify if enter transaction window is open",FAIL,"Enter Transaction window is not opened")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added to Quicken",PASS,"Reminder not added to Quicken")
				[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] 
[+] //############################## Verify Skip Reminder Button from stack view ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test56_Verify_Skip_Reminder_Button_From_Stack_View()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Skip reminder functionality from stack view
		[ ] // 1.Reminder does not show in list view
		[ ] //
		[ ] // 
		[ ] //PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Add Reminder content is verified correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  24th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test56_Verify_Skip_Reminder_Button_From_Stack_View() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sDayFilter="90 Days"
		[ ] 
		[ ] sListOption="List"
		[ ] 
		[ ] //sReceivedText="Received"
		[ ] 
		[ ] // sExpectedNumberOfTransactions="1"
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sSkip,sPayeeName)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if skip dialog window is open",PASS,"Skip dialog window is opened")
					[ ] 
					[ ] 
					[ ] //--------------Verify if Reminder is skiped ---------------
					[ ] QuickenWindow.SetActive()
					[ ] //Select List view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
					[ ] //Select 90 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
					[ ] 
					[ ] 
					[ ] //-------Verify content under List view on Bills Upcoming tab---------------
					[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
					[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
						[ ] 
						[ ] bMatch=FALSE
						[ ] bMatch=MatchStr("*{sPayeeName}*{sBillDate}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is NOT skipped and in displayed in list view")
							[ ] break
							[ ] 
					[ ] 
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is skipped and not displayed in list view")
						[ ] 
					[ ] 
					[ ] // Delete Reminder after operation
					[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
					[+] if(iValidate==PASS)									  	 
						[ ] 
						[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if skip dialog window is open",FAIL,"Skip dialog window is not opened")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added to Quicken",PASS,"Reminder not added to Quicken")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] //------------------ 25th June ----------------
[ ] 
[+] //############################## Verify Paid Income Reminder ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test57_Verify_Paid_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Changes for received Income Reminder
		[ ] // 1.Reminder appears as Paid in List View
		[ ] // 2.Reminder appears as Paid in Monthly List View
		[ ] // 3.Got to register button is displayed in stack view
		[ ] //4.Reminder is entered in register
		[ ] //
		[ ] // 
		[ ] //PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Changes for received Income Reminder is verified correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test57_Verify_Paid_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //---------Variable Definition----------
		[ ] 
		[ ] STRING sPaidText,sExpectedNumberOfTransactions,sDayFilter1,sDayFilter2,sGoToRegisterButton
		[ ] LIST OF STRING lsListOption
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] lsListOption={"List","Monthly List","Stack"}
		[ ] 
		[ ] sDayFilter1="30 Days"
		[ ] sDayFilter2="90 Days"
		[ ] 
		[ ] sPaidText="Paid"
		[ ] sGoToRegisterButton="Go to Register"
		[ ] 
		[ ] sExpectedNumberOfTransactions="1"
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //------Navigate to Stack View-----------
				[ ] MDIClient.Bills.ViewAsPopupList.Select(lsListOption[3])
				[ ] //--------Click on Enter button in Stack view-----
				[ ] MDIClient.Bills.Panel.Panel1.QWinChild1.EnterButton.Click()
				[+] if(EnterExpenseIncomeTxn.Exists(5))
					[ ] ReportStatus("Verify if enter transaction window is open",PASS,"Enter Transaction window is opened")
					[ ] EnterExpenseIncomeTxn.EnterTransactionButton.Click()
					[ ] 
					[ ] 
					[ ] //--------------Verify if Reminder is entered in list view ---------------
					[ ] //Select List view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(lsListOption[1])
					[ ] //Select 90 days filter on List view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter1)
					[ ] //-------Verify content under List view on Bills Upcoming tab---------------
					[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
					[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
						[ ] 
						[ ] bMatch=MatchStr("*{sPayeeName}*{sPaidText}*{sGoToRegisterButton}*",sActual)
						[ ] 
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if reminder is displayed correctly in list view",PASS,"Reminder is displayed correctly in list view")
							[ ] break
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is NOT entered in list view")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //--------------Verify if Reminder is entered in Monthly list view ---------------
					[ ] //Select Monthly list view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(lsListOption[2])
					[ ] 
					[ ] //-------Verify content under List view on Bills Upcoming tab---------------
					[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
					[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
						[ ] 
						[ ] bMatch=MatchStr("*{sPayeeName}*{sPaidText}*{sGoToRegisterButton}*",sActual)
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if reminder is displayed correctly in list view",PASS,"Reminder is displayed correctly in Monthly list view")
							[ ] break
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is NOT entered in Monthly list view")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //----------Verify if Reminder is entered in Stack View and Account Register------------------
					[ ] MDIClient.Bills.ViewAsPopupList.Select(lsListOption[3])
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter1)
					[ ] 
					[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Exists(SHORT_SLEEP))
						[ ] ReportStatus("Verify that Go to register button exists",PASS,"Go to register button exists")
						[ ] //-------Click on Go to Register button---------
						[ ] MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Click()
						[ ] 
						[ ] iValidate=VerifyTransactionInAccountRegister(sPayeeName,sExpectedNumberOfTransactions)
						[+] if(iValidate==PASS)
							[ ] iValidate=DeleteTransaction(sMDIWindow,sPayeeName)
							[+] if(iValidate==PASS)
								[ ] ReportStatus("Verify that account is displayed in account register",PASS,"Account is displayed in the account register")
								[ ] 
								[ ] // Delete Reminder after operation
								[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
								[+] if(iValidate==PASS)									  	 
									[ ] 
									[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
									[ ] 
									[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if transaction is deleted",FAIL,"Transaction is not deleted")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that account is displayed in account register",FAIL,"Account is NOT displayed in the account register")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that Go to register button exists",FAIL,"Go to register button does not exist")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if enter transaction window is open",FAIL,"Enter Transaction window is not opened")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added to Quicken",FAIL,"Reminder not added to Quicken")
				[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //############################## Verify Received Income Reminder ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test58_Verify_Received_Income_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Changes for received Income Reminder
		[ ] // 1.Reminder appears as Received in List View
		[ ] // 2.Reminder appears as Received in Monthly List View
		[ ] // 3.Got to register button is displayed in stack view
		[ ] //4.Reminder is entered in register
		[ ] //
		[ ] // 
		[ ] //PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Changes for received Income Reminder is verified correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test58_Verify_Received_Income_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //---------Variable Definition----------
		[ ] 
		[ ] STRING sReceivedText,sExpectedNumberOfTransactions,sDayFilter1,sDayFilter2,sGoToRegisterButton
		[ ] LIST OF STRING lsListOption
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] lsListOption={"List","Monthly List","Stack"}
		[ ] 
		[ ] sDayFilter1="30 Days"
		[ ] sDayFilter2="90 Days"
		[ ] 
		[ ] sReceivedText="Received"
		[ ] sGoToRegisterButton="Go to Register"
		[ ] 
		[ ] sExpectedNumberOfTransactions="1"
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] //------Navigate to Stack View-----------
				[ ] MDIClient.Bills.ViewAsPopupList.Select(lsListOption[3])
				[ ] //--------Click on Enter button in Stack view-----
				[ ] MDIClient.Bills.Panel.Panel1.QWinChild1.EnterButton.Click()
				[+] if(EnterExpenseIncomeTxn.Exists(5))
					[ ] ReportStatus("Verify if enter transaction window is open",PASS,"Enter Transaction window is opened")
					[ ] EnterExpenseIncomeTxn.EnterTransactionButton.Click()
					[ ] 
					[ ] 
					[ ] //--------------Verify if Reminder is entered in list view ---------------
					[ ] //Select List view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(lsListOption[1])
					[ ] //Select 90 days filter on List view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter1)
					[ ] //-------Verify content under List view on Bills Upcoming tab---------------
					[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
					[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
						[ ] 
						[ ] bMatch=MatchStr("*{sPayeeName}*{sReceivedText}*{sGoToRegisterButton}*",sActual)
						[ ] 
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if reminder is displayed correctly in list view",PASS,"Reminder is displayed correctly in list view")
							[ ] break
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is NOT entered in list view")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //--------------Verify if Reminder is entered in Monthly list view ---------------
					[ ] //Select Monthly list view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(lsListOption[2])
					[ ] 
					[ ] //-------Verify content under List view on Bills Upcoming tab---------------
					[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
					[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
						[ ] 
						[ ] bMatch=MatchStr("*{sPayeeName}*{sReceivedText}*{sGoToRegisterButton}*",sActual)
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if reminder is displayed correctly in list view",PASS,"Reminder is displayed correctly in Monthly list view")
							[ ] break
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is NOT entered in Monthly list view")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //----------Verify if Reminder is entered in Stack View------------------
					[ ] MDIClient.Bills.ViewAsPopupList.Select(lsListOption[3])
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter1)
					[ ] 
					[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Exists(SHORT_SLEEP))
						[ ] //-------Click on Go to Register button---------
						[ ] MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Click()
						[ ] 
						[ ] iValidate=VerifyTransactionInAccountRegister(sPayeeName,sExpectedNumberOfTransactions)
						[+] if(iValidate==PASS)
							[ ] iValidate=DeleteTransaction(sMDIWindow,sPayeeName)
							[+] if(iValidate==PASS)
								[ ] ReportStatus("Verify that account is displayed in account register",PASS,"Account is displayed in the account register")
								[ ] 
								[ ] // Delete Reminder after operation
								[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
								[+] if(iValidate==PASS)									  	 
									[ ] 
									[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
									[ ] 
									[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if transaction is deleted",FAIL,"Transaction is not deleted")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that account is displayed in account register",FAIL,"Account is NOT displayed in the account register")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that account has been selected",FAIL,"Account has not been selected from account bar")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if enter transaction window is open",FAIL,"Enter Transaction window is not opened")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added to Quicken",FAIL,"Reminder not added to Quicken")
				[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //############################## Verify Completed Transfer Reminder ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test59_Verify_Completed_Transfer_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Changes for Completed Transfer Reminder
		[ ] // 1.Reminder appears as Completed in List View
		[ ] // 2.Reminder appears as Completed in Monthly List View
		[ ] // 3.Got to register button is displayed in stack view
		[ ] //4.Reminder is entered in register
		[ ] //
		[ ] // 
		[ ] //PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Changes for Completed Transfer Reminder is verified correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  25th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test59_Verify_Completed_Transfer_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //---------Variable Definition----------
		[ ] 
		[ ] STRING sCompletedText,sExpectedNumberOfTransactions,sDayFilter1,sDayFilter2,sGoToRegisterButton
		[ ] LIST OF STRING lsListOption
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] lsListOption={"List","Monthly List","Stack"}
		[ ] 
		[ ] sDayFilter1="30 Days"
		[ ] sDayFilter2="90 Days"
		[ ] 
		[ ] sCompletedText="Completed"
		[ ] sGoToRegisterButton="Go to Register"
		[ ] 
		[ ] sExpectedNumberOfTransactions="1"
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[3]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4],lsAddBill[5],NULL,lsAddBill[7])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] //------Navigate to Stack View-----------
				[ ] MDIClient.Bills.ViewAsPopupList.Select(lsListOption[3])
				[ ] //--------Click on Enter button in Stack view-----
				[ ] MDIClient.Bills.Panel.Panel1.QWinChild1.EnterButton.Click()
				[+] if(EnterExpenseIncomeTxn.Exists(5))
					[ ] ReportStatus("Verify if enter transaction window is open",PASS,"Enter Transaction window is opened")
					[ ] EnterExpenseIncomeTxn.EnterTransactionButton.Click()
					[ ] 
					[ ] 
					[ ] //--------------Verify if Reminder is entered in list view ---------------
					[ ] //Select List view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(lsListOption[1])
					[ ] //Select 90 days filter on List view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter1)
					[ ] //-------Verify content under List view on Bills Upcoming tab---------------
					[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
					[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
						[ ] 
						[ ] bMatch=MatchStr("*{sPayeeName}*{sCompletedText}*{sGoToRegisterButton}*",sActual)
						[ ] 
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if reminder is displayed correctly in list view",PASS,"Reminder is displayed correctly in list view")
							[ ] break
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is NOT entered in list view")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //--------------Verify if Reminder is entered in Monthly list view ---------------
					[ ] //Select Monthly list view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(lsListOption[2])
					[ ] 
					[ ] //-------Verify content under List view on Bills Upcoming tab---------------
					[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
					[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
						[ ] 
						[ ] bMatch=MatchStr("*{sPayeeName}*{sCompletedText}*{sGoToRegisterButton}*",sActual)
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if reminder is displayed correctly in list view",PASS,"Reminder is displayed correctly in Monthly list view")
							[ ] break
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[ ] 
						[ ] 
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is NOT entered in Monthly list view")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //----------Verify if Reminder is entered in Stack View------------------
					[ ] MDIClient.Bills.ViewAsPopupList.Select(lsListOption[3])
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter1)
					[ ] 
					[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Exists(SHORT_SLEEP))
						[ ] //-------Click on Go to Register button---------
						[ ] MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Click()
						[ ] 
						[ ] iValidate=VerifyTransactionInAccountRegister(sPayeeName,sExpectedNumberOfTransactions)
						[+] if(iValidate==PASS)
							[ ] iValidate=DeleteTransaction(sMDIWindow,sPayeeName)
							[+] if(iValidate==PASS)
								[ ] ReportStatus("Verify that account is displayed in account register",PASS,"Account is displayed in the account register") 
								[ ] 
								[ ] 
								[ ] // Delete Reminder after operation
								[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
								[+] if(iValidate==PASS)									  	 
									[ ] 
									[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
									[ ] 
									[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if transaction is deleted",FAIL,"Transaction is not deleted")
							[ ] 
							[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that account is displayed in account register",FAIL,"Account is NOT displayed in the account register")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that account has been selected",FAIL,"Account has not been selected from account bar")
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if enter transaction window is open",FAIL,"Enter Transaction window is not opened")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added to Quicken",FAIL,"Reminder not added to Quicken")
				[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] //--------------26th June--------------------
[ ] 
[ ] 
[+] //############################## Verify Show Full Calendar ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test61_Verify_Show_Full_Calendar()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Show Full Calendar button for a bill reminder
		[ ] //
		[ ] // 
		[ ] //PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Show Full Calendar button for a bill reminder is verified correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  26th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test61_Verify_Show_Full_Calendar() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Calendar"
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] //------Navigate to Calendar View-----------
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] 
				[ ] //--------Click on Show Full Calendar button in Calendar view-----
				[+] if(MDIClient.Bills.Calendar.Exists(5))
					[ ] MDIClient.Bills.Calendar.ShowFullCalendarButton.Click()
					[ ] 
					[+] if(CalendarPopUpWindow.Exists(5))
						[ ] ReportStatus("Verify if calendar pop up window is displayed",PASS,"Calendar pop up window is displayed")
						[ ] CalendarPopUpWindow.Close()
						[ ] WaitForState(CalendarPopUpWindow,FALSE,5)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if calendar pop up window is displayed",FAIL,"Calendar is not opened in pop up window mode")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if calendar view is displayed",FAIL,"Calendar view is NOT displayed")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // Delete Reminder after operation
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
				[ ] ReportStatus("Verify if Reminder is added to Quicken",FAIL,"Reminder not added to Quicken")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] 
[+] //############################## Verify Manage Reminders Button ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test62_Verify_Manage_Reminders_Button()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Show Full Calendar button for a bill reminder
		[ ] //
		[ ] // 
		[ ] //PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Show Full Calendar button for a bill reminder is verified correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  26th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test62_Verify_Manage_Reminders_Button() appstate none
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption="Stack"
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] //------Navigate to Stack View-----------
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] 
				[ ] //-----------Click on Manage Reminders button--------
				[+] if(QuickenMainWindow.QWNavigator.ManageReminders.Exists(5))
					[ ] //Bills.Calendar.ShowFullCalendarButton.Click()
					[ ] QuickenMainWindow.QWNavigator.ManageReminders.Click()
					[+] if(DlgManageReminders.Exists(5))
						[ ] ReportStatus("Verify if manage reminders dialog is open",PASS,"Manage Reminders dialog is open")
						[ ] 
						[ ] 
						[ ] //------Verify QW_MDI_TOOLBAR objects----------
						[ ] //Blocked due to Qwatuo related Quicken crash
						[ ] //-------------------------------------------------------------------
						[ ] 
						[ ] 
						[+] if(DlgManageReminders.MonthlyBillsDepositsTab.Exists(5))
							[ ] ReportStatus("Verify if Monthly Bills Deposits Tab exists",PASS,"Monthly Bills Deposits Tab exists")
						[+] else
							[ ] ReportStatus("Verify if Monthly Bills Deposits Tab exists",FAIL,"Monthly Bills Deposits Tab is not found")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[+] if(DlgManageReminders.AllBillsDepositsTab.Exists(5))
							[ ] ReportStatus("Verify if All Bills Deposits Tab exists",PASS,"All Bills Deposits Tab exists")
						[+] else
							[ ] ReportStatus("Verify if All Bills Deposits Tab exists",FAIL,"All Bills Deposits Tab is not found")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if manage reminders dialog is open",FAIL,"Manage Reminders dialog is not open")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if calendar view is displayed",FAIL,"Calendar view is NOT displayed")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // Delete Reminder after operation
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
				[ ] ReportStatus("Verify if Reminder is added to Quicken",FAIL,"Reminder not added to Quicken")
				[ ] 
		[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify No Bills Due Within next 7 days for Bill Reminder on Stack View ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test63_Stack_View_No_Bills_Due_Within_Next_7_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify No Bills Due Within next 7 days for Bill Reminder on Stack View
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Bill reminder is not displayed under filter
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  26th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test63_Stack_View_No_Bills_Due_Within_Next_7_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] iDays=8
		[ ] sListOption="Stack"
		[ ] sDayFilter="7 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(iDays,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that message is displayed under list view ----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select filter on List view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] 
				[ ] //-------Verify content under Stack view on Bills tab---------------
				[+] if(!Bills.Panel.Panel1.QWinChild1.EnterButton.Exists(3))
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder added {iDays} days later is not displayed under stack view for filter {sDayFilter} for Bills tab")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder added {iDays} days later is displayed under stack view for filter {sDayFilter} for Bills tab")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Delete Reminder after operation
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Create a new data file",FAIL,"Error during data file creation")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify No Bills Due Within next 14 days for Bill Reminder on Stack View ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test65_Stack_View_No_Bills_Due_Within_Next_14_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify No Bills Due Within next 7 days for Bill Reminder on Stack View
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Bill reminder is not displayed under filter
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  26th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test65_Stack_View_No_Bills_Due_Within_Next_7_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] iDays=15
		[ ] sListOption="Stack"
		[ ] sDayFilter="14 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(iDays,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------Verify that message is displayed under list view ----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select filter on List view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] 
				[ ] //-------Verify content under Stack view on Bills tab---------------
				[+] if(!Bills.Panel.Panel1.QWinChild1.EnterButton.Exists(3))
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder added {iDays} days later is not displayed under stack view for filter {sDayFilter} for Bills tab")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder added {iDays} days later is displayed under stack view for filter {sDayFilter} for Bills tab")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] // Delete Reminder after operation
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify No Bills Due Within next 30 days for Bill Reminder on Stack View ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test67_Stack_View_No_Bills_Due_Within_Next_30_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify No Bills Due Within next 30 days for Bill Reminder on Stack View
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Bill reminder is not displayed under filter
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  26th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test67_Stack_View_No_Bills_Due_Within_Next_30_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] iDays=31
		[ ] sListOption="Stack"
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(iDays,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //Close Add/Link biller dialog
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] 
				[ ] //----------Verify that message is displayed under list view ----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select filter on List view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] 
				[ ] //-------Verify content under Stack view on Bills tab---------------
				[+] if(!Bills.Panel.Panel1.QWinChild1.EnterButton.Exists(3))
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder added {iDays} days later is not displayed under stack view for filter {sDayFilter} for Bills tab")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder added {iDays} days later is displayed under stack view for filter {sDayFilter} for Bills tab")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Delete Reminder after operation
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] 
[+] //################ Verify No Bills Due Within next 7 days for Bill Reminder on List View ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test64_List_View_No_Bills_Due_Within_Next_7_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify No Bills Due Within next 7 days for Bill Reminder on List View
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Bill reminder is not displayed under filter and message You don't have any scheduled bills or deposits due for this account is displayed.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  26th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test64_List_View_No_Bills_Due_Within_Next_7_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] iDays=8
		[ ] sListOption="List"
		[ ] sDayFilter="7 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(iDays,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //Close Add/Link biller dialog
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] //----------Verify that message is displayed under list view ----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select filter on List view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] 
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(0))
				[ ] bMatch=MatchStr("*{sNoBillsReadLine}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder added {iDays} days later is not displayed under list view for filter {sDayFilter} for Bills tab")
				[+] else
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder added {iDays} days later is displayed under list view for filter {sDayFilter} for Bills tab")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Delete Reminder after operation
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify No Bills Due Within next 14 days for Bill Reminder on List View ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test66_List_View_No_Bills_Due_Within_Next_14_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify No Bills Due Within next 14 days for Bill Reminder on List View
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Bill reminder is not displayed under filter and message You don't have any scheduled bills or deposits due for this account is displayed.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  26th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test66_List_View_No_Bills_Due_Within_Next_14_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] iDays=15
		[ ] sListOption="List"
		[ ] sDayFilter="14 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(iDays,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] //Close Add/Link biller dialog
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] //----------Verify that message is displayed under list view ----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select filter on List view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] 
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(0))
				[ ] bMatch=MatchStr("*{sNoBillsReadLine}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder added {iDays} days later is not displayed under list view for filter {sDayFilter} for Bills tab")
				[+] else
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder added {iDays} days later is displayed under list view for filter {sDayFilter} for Bills tab")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Delete Reminder after operation
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
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
[+] //################ Verify No Bills Due Within next 30 days for Bill Reminder on List View ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test68_List_View_No_Bills_Due_Within_Next_30_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify No Bills Due Within next 30 days for Bill Reminder on List View
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Bill reminder is not displayed under filter and message You don't have any scheduled bills or deposits due for this account is displayed.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  26th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test68_List_View_No_Bills_Due_Within_Next_30_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] iDays=31
		[ ] sListOption="List"
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(iDays,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] //Close Add/Link biller dialog
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] //----------Verify that message is displayed under list view ----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select filter on List view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] 
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(0))
				[ ] bMatch=MatchStr("*{sNoBillsReadLine}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder added {iDays} days later is not displayed under list view for filter {sDayFilter} for Bills tab")
				[+] else
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder added {iDays} days later is displayed under list view for filter {sDayFilter} for Bills tab")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Delete Reminder after operation
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify No Bills Due Within next 90 days for Bill Reminder on List View ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test69_List_View_No_Bills_Due_Within_Next_90_Days_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify No Bills Due Within next 90 days for Bill Reminder on List View
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Bill reminder is not displayed under filter and message You don't have any scheduled bills or deposits due for this account is displayed.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  26th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test69_List_View_No_Bills_Due_Within_Next_90_Days_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] iDays=91
		[ ] sListOption="List"
		[ ] sDayFilter="90 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(iDays,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //Close Add/Link biller dialog
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] 
				[ ] //----------Verify that message is displayed under list view ----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select filter on List view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] 
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(0))
				[ ] bMatch=MatchStr("*{sNoBillsReadLine}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder added {iDays} days later is not displayed under list view for filter {sDayFilter} for Bills tab")
				[+] else
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder added {iDays} days later is displayed under list view for filter {sDayFilter} for Bills tab")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Delete Reminder after operation
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify No Bills Due Within next 7 days for Bill Reminder on List View ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test70_List_View_No_Bills_Due_Within_Next_12_Months_Bill_Reminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify No Bills Due Within next 7 days for Bill Reminder on List View
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Bill reminder is not displayed under filter and message You don't have any scheduled bills or deposits due for this account is displayed.	
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  26th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test70_List_View_No_Bills_Due_Within_Next_12_Months_Bill_Reminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] iDays=367
		[ ] sListOption="List"
		[ ] sDayFilter="12 Months"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(iDays,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[ ] //Close Add/Link biller dialog
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] //----------Verify that message is displayed under list view ----------
				[ ] //Select List view on bills tab
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select filter on List view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] 
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(0))
				[ ] bMatch=MatchStr("*{sNoBillsReadLine}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder added {iDays} days later is not displayed under list view for filter {sDayFilter} for Bills tab")
				[+] else
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder added {iDays} days later is displayed under list view for filter {sDayFilter} for Bills tab")
					[ ] 
				[ ] 
				[ ] 
				[ ] // Delete Reminder after operation
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] 
[+] //#####################################  Verify Payee Website #################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test71_Verify_Payee_Website()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify following for Payee Website:
		[ ] // 1. "Add" link should convert in to "Change" link in on Add Reminder dialog
		[ ] // 2. Go to Website" link should be present on "Add Bill Reminder" main window
		[ ] // 3. "Go" link under Web column in Manage Reminders dialog
		[ ] // 4.  Website should be displayed in Enter Transaction dialog
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If all verification points are displayed correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  5th  Sept 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test71_Verify_Payee_Website() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] STRING sStackOption="Stack"
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
		[ ] 
		[ ] STRING sWebsiteName="www.google.com"
		[ ] //String Go appears under website column in Mange Reminders dialog
		[ ] STRING sGoText="Go"
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if( iValidate==PASS)
			[ ] ReportStatus("Navigate to reminder details second screen", PASS, " Add Income Reminder dialog second screen is displayed.")
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sTransactionAmount)
			[ ] DlgAddEditReminder.Step2Panel.QWinChild1.DueNextOnTextField.SetText(sBillDate)
			[ ] 
			[+] if(!DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RemindDaysInAdvanceChangeLink.Exists(5))
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.Panel2.OptionalSettingsButton.Click()
			[ ] 
			[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Exists(5))
				[ ] 
				[ ] DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteAddLink.Click()
				[ ] 
				[+] if(DlgOptionalSetting.Exists(5))
					[ ] 
					[ ] DlgOptionalSetting.WebsiteTextField.SetText(sWebsiteName)
					[ ] DlgOptionalSetting.OKButton.Click()
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Verify changes in reminder after Adding link
				[+] if(DlgAddEditReminder.Step2Panel.QWinChild1.OptionalSettingsPanel3.RelatedWebsiteChangeLink.Exists(5))
					[ ] ReportStatus("Verify if Add link becomes Change link in reminder details second screen", PASS, " Add link becomes Change link in reminder details second screen.")
					[ ] 
				[ ] 
				[+] if(DlgAddEditReminder.Step1Panel.HomeChildPanel.GoToWebsite.Exists(5))
					[ ] ReportStatus("Verify if Go to website link appears on reminder details second screen", PASS, " Go to website link appears on reminder details second screen")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] DlgAddEditReminder.DoneButton.Click()
				[ ] 
				[ ] 
				[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
				[ ] CloseAddLinkBiller()
			[+] else
				[ ] ReportStatus("Verify change link",FAIL,"Change link not found")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] //-------Verify if monthly bill gets added or not using Bill and Income Reminder List (CTRL+J)-----------
			[ ] QuickenWindow.SetActive()
			[ ] OpenManageReminders()
			[+] if (DlgManageReminders.Exists(5))
				[ ] DlgManageReminders.AllBillsDepositsTab.Click()
				[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(0))
				[ ] 
				[ ] // Verify different bill parameters such as payee name and bill amount
				[+] for(i=1; i<= 2; i++)
					[ ] bMatch = MatchStr("*{lsAddBill[i]}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Verification of  added Bill Reminder ", PASS, "Bill Reminder with '{lsAddBill[i]}' is added successfully")
					[+] else
						[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Bill Reminder for {lsAddBill[i]} is NOT added, sActual = {sActual}")
				[ ] 
				[ ] //Match Go Text to Rmeinder details in Manage Reminder dialog
				[ ] bMatch = MatchStr("*{sGoText}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verification of  added Website ", PASS, "Go link is displayed in the Manage Reminder dialog")
				[+] else
					[ ] ReportStatus("Verification of  added Website ", PASS, "Go link is NOT displayed in the Manage Reminder dialog, sActual = {sActual}")
				[ ] 
				[ ] 
				[ ] 
				[ ] DlgManageReminders.Close()
				[ ] 
				[ ] 
				[ ] //Enter Bill
				[ ] //----------Verify that content is displayed----------
				[ ] iValidate=NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[+] if(iValidate==PASS)
					[ ] //Select Stack view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sStackOption)
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
					[ ] //-------Verify content under Stack view on Bills Upcoming tab---------------
					[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.Enter.Exists(5))
						[ ] 
						[ ] MDIClient.Bills.Panel.Panel1.QWinChild.Enter.Click()
						[ ] 
						[+] if(EnterExpenseIncomeTxn.Exists(5))
							[ ] ReportStatus("Verify if Bill is displayed under stack view",PASS,"Bill is displayed under stack view for {sDayFilter}")
							[ ] 
							[+] if(EnterExpenseIncomeTxn.LearnMore.Exists(5))
								[ ] ReportStatus("Verify Website link on Enter Transaction dialog",PASS,"Website link is present in the Enter Transaction dialog")
								[ ] 
								[ ] // bMatch=MatchStr("*{sWebsiteName}*",sActualText)
								[+] // if(bMatch==TRUE)
									[ ] // ReportStatus("Verify Website link on Enter Transaction dialog",PASS,"Website link expected{sWebsiteName} matches with actual {sActualText} in the Enter Transaction dialog")
									[ ] // 
									[ ] // 
								[+] // else
									[ ] // ReportStatus("Verify Website link on Enter Transaction dialog",PASS,"Website link expected{sWebsiteName} does not match with actual {sActualText} in the Enter Transaction dialog")
									[ ] // 
									[ ] // 
									[ ] // 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Website link on Enter Transaction dialog",FAIL,"Website link is not found in the Enter Transaction dialog")
								[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] EnterExpenseIncomeTxn.Close()
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Bill is displayed under stack view",FAIL,"Bill is Not displayed under stack view")
				[+] else
					[ ] ReportStatus("Navigate to Bills tab",FAIL,"Bills tab not opened")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //----------------Delete Bill Reminder--------------------------
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verification of  added Bill Reminder ", FAIL, "Online Bill Reminder is NOT added")
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
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################ Verify Account Filters depending on reminders on List and Monthly list view  ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test74_75_Verify_Account_Filters_For_Reminders_In_List_And_Monthly_View()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Account Filters depending on reminders on List view and Monthly List view
		[ ] //  i.e. only reminders associated with the account selected from filter should be displayed
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If only reminders associated with the account selected from filter should be displayed
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  5th  Sept 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test74_75_Verify_Account_Filters_For_Reminders_In_List_And_Monthly_View() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sVerificationOption,sWindowCaption
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] sListOption="List"
		[ ] sMonthlyListOption="Monthly List"
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] sDaysBefore=NULL
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] 
		[ ] //-------------Add Reminders----------------------
		[ ] 
		[ ] 
		[ ] 
		[ ] // 
		[+] // //------------------Transfer Reminder--------------------
			[ ] // // Read bills data from excel sheet
			[ ] // lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
			[ ] // lsAddBill=lsExcelData[3]
			[ ] // lsAddBill[4]=sBillDate
			[ ] // 
			[ ] // ListAppend(lsReminderList1,lsAddBill[2])
			[ ] // ListAppend(lsReminderList2,lsAddBill[2])
			[ ] // 
			[ ] // 
			[ ] // iValidate=NavigateReminderDetailsPage(lsAddBill[1],lsAddBill[2])
			[+] // if( iValidate==PASS)
				[ ] // iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4],sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
				[+] // if(iValidate==PASS)
					[ ] // ReportStatus("Verify if Reminder added",PASS,"{lsAddBill[1]} Reminder {lsAddBill[2]} added successfully")
					[ ] // 
					[ ] // 
				[+] // else
					[ ] // ReportStatus("Verify if Reminder added",FAIL,"{lsAddBill[1]} Reminder {lsAddBill[2]} not added")
					[ ] // 
					[ ] // 
			[+] // else
				[ ] // ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
			[ ] // 
			[ ] // 
		[ ] // 
		[ ] 
		[+] //--------------------Bills Reminder----------------------
			[ ] 
			[ ] // Read bills data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
			[ ] lsAddBill=lsExcelData[1]
			[ ] lsAddBill[4]=sBillDate
			[ ] 
			[ ] ListAppend(lsReminderList,lsAddBill[2])
			[ ] 
			[ ] iValidate=NavigateReminderDetailsPage(lsAddBill[1],lsAddBill[2])
			[+] if( iValidate==PASS)
				[ ] 
				[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4],sDaysBefore,lsAddAccount2[2])
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if Reminder added",PASS,"{lsAddBill[1]} Reminder {lsAddBill[2]} added successfully")
					[ ] //Restart Quicken to handle bills >Get Started snapshot refresh issue
					[ ] //Close Add/Link biller dialog
					[ ] CloseAddLinkBiller()
					[ ] 
					[ ] LaunchQuicken()
					[ ] NavigateQuickenTab(sTAB_BILL,sTAB_UPCOMING)
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Reminder added",FAIL,"{lsAddBill[1]} Reminder {lsAddBill[2]} not added")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[+] //-----------------Income Reminder----------------------
			[ ] 
			[ ] // Read bills data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
			[ ] lsAddBill=lsExcelData[2]
			[ ] lsAddBill[4]=sBillDate
			[ ] 
			[ ] ListAppend(lsReminderList,lsAddBill[2])
			[ ] 
			[ ] 
			[ ] iValidate=NavigateReminderDetailsPage(lsAddBill[1],lsAddBill[2])
			[+] if( iValidate==PASS)
				[ ] 
				[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4],sDaysBefore,NULL,lsAddAccount1[2])
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if Reminder added",PASS,"{lsAddBill[1]} Reminder {lsAddBill[2]} added successfully")
					[ ] //Close Add/Link biller dialog
					[ ] CloseAddLinkBiller()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Reminder added",FAIL,"{lsAddBill[1]} Reminder {lsAddBill[2]} not added")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
			[ ] 
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] //Verify Account Filter Functionality for List View
			[ ] 
			[ ] //Navigate to list view
			[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
			[ ] //Select filter on List view
			[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
			[ ] 
			[ ] 
			[ ] //Select First checking account from filter
			[ ] MDIClient.Bills.AccountPopupList.Select(lsAddAccount2[2])
			[+] if(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()==1)
				[ ] 
				[ ] //Search accounts in List
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(0))
				[ ] bMatch=MatchStr("*{lsReminderList[1]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder {lsReminderList[1]} shown under correct filter : {lsAddAccount2[2]} account for {sListOption} view on Bills tab")
				[+] else
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder {lsReminderList[1]} not shown under correct filter : {lsAddAccount2[2]} account for {sListOption} view on Bills tab")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] //Select Second checking account from filter
			[ ] MDIClient.Bills.AccountPopupList.Select(lsAddAccount1[2])
			[+] if(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()==1)
				[ ] 
				[ ] //Search accounts in List
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(0))
				[ ] bMatch=MatchStr("*{lsReminderList[2]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder {lsReminderList[2]} shown under correct filter : {lsAddAccount1[2]} account for {sListOption} view on Bills tab")
				[+] else
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder {lsReminderList[2]} not shown under correct filter : {lsAddAccount1[2]} account for {sListOption} view on Bills tab")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[ ] 
		[ ] 
		[+] //Verify Account Filter Functionality for Monthly List View
			[ ] 
			[ ] //Navigate to list view
			[ ] MDIClient.Bills.ViewAsPopupList.Select(sMonthlyListOption)
			[ ] 
			[ ] 
			[ ] //Select First checking account from filter
			[ ] MDIClient.Bills.AccountPopupList.Select(lsAddAccount2[2])
			[+] if(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()==1)
				[ ] 
				[ ] //Search accounts in List
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(0))
				[ ] bMatch=MatchStr("*{lsReminderList[1]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder {lsReminderList[1]} shown under correct filter : {lsAddAccount2[2]} account for {sMonthlyListOption} view  on Bills tab")
				[+] else
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder {lsReminderList[1]} not shown under correct filter : {lsAddAccount2[2]} account for {sMonthlyListOption} view on Bills tab")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[ ] 
			[ ] 
			[ ] //Select Second checking account from filter
			[ ] MDIClient.Bills.AccountPopupList.Select(lsAddAccount1[2])
			[+] if(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()==1)
				[ ] 
				[ ] //Search accounts in List
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(0))
				[ ] bMatch=MatchStr("*{lsReminderList[2]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder {lsReminderList[2]} shown under correct filter : {lsAddAccount1[2]} account for {sMonthlyListOption} view on Bills tab")
				[+] else
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder {lsReminderList[2]} not shown under correct filter : {lsAddAccount1[2]} account for {sMonthlyListOption} view on Bills tab")
					[ ] 
					[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //Delete all reminders
		[+] for(i=1;i<=ListCount(lsReminderList);i++)
			[ ] 
			[ ] //----------------Delete Bill Reminder--------------------------
			[ ] iValidate=ReminderOperations(sDelete,lsReminderList[i])
			[+] if(iValidate==PASS)									  	 
				[ ] 
				[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
				[ ] 
				[ ] 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window not found")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] // 
[+] //################ Verify functionality for All and Monthly Bills & Deposits Tab on Manage Reminder Dialog  ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test77_78_Verify_Functionality_For_All_And_Monthly_Bills_And_Deposits_Tab_On_Manage_Reminder_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify 
		[ ] // 1. Functionality for Monthly Bills & Deposits Tab on Manage Reminder Dialog
		[ ] // 2. Functionality for All Bills & Deposits Tab on Manage Reminder Dialog
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If only bills for current month are displayed on Monthly Bills & Deposits Tab on Manage Reminder Dialog
		[ ] //                                                    If all bills are displayed on All Bills & Deposits Tab on Manage Reminder Dialog
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  6th  Sept 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test77_78_Verify_Functionality_For_All_And_Monthly_Bills_And_Deposits_Tab_On_Manage_Reminder_Dialog() appstate none
	[ ] 
	[+] //---------Variable Definniton----------
		[ ] 
		[ ] INTEGER iCount,iCounter
		[ ] LIST OF STRING lsReminderList
		[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] iDays=91
		[ ] sListOption="List"
		[ ] sDayFilter="90 Days"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(iDays,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] sDaysBefore=NULL
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //Current Date
		[+] //------------------Transfer Reminder--------------------
			[ ] // Read bills data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
			[ ] lsAddBill=lsExcelData[3]
			[ ] lsAddBill[4]=ModifyDate(0,sDateFormat)
			[ ] 
			[ ] ListAppend(lsReminderList,lsAddBill[2])
			[ ] 
			[ ] iValidate=NavigateReminderDetailsPage(lsAddBill[1],lsAddBill[2])
			[+] if( iValidate==PASS)
				[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4],sDaysBefore,lsAddAccount1[2],lsAddAccount2[2])
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if Reminder added",PASS,"{lsAddBill[1]} Reminder {lsAddBill[2]} added successfully")
					[ ] //Close Add/Link biller dialog
					[ ] CloseAddLinkBiller()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Reminder added",FAIL,"{lsAddBill[1]} Reminder {lsAddBill[2]} not added")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
			[ ] 
		[ ] 
		[ ] 
		[+] //--------------------Bills Reminder----------------------
			[ ] 
			[ ] // Read bills data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
			[ ] lsAddBill=lsExcelData[1]
			[ ] lsAddBill[4]=ModifyDate(0,sDateFormat)
			[ ] 
			[ ] ListAppend(lsReminderList,lsAddBill[2])
			[ ] 
			[ ] iValidate=NavigateReminderDetailsPage(lsAddBill[1],lsAddBill[2])
			[+] if( iValidate==PASS)
				[ ] 
				[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4],sDaysBefore,lsAddAccount2[2])
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if Reminder added",PASS,"{lsAddBill[1]} Reminder {lsAddBill[2]} added successfully")
					[ ] //Close Add/Link biller dialog
					[ ] CloseAddLinkBiller()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Reminder added",FAIL,"{lsAddBill[1]} Reminder {lsAddBill[2]} not added")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
			[ ] 
		[ ] 
		[ ] 
		[ ] //Future Date
		[+] //-----------------Income Reminder----------------------
			[ ] 
			[ ] // Read bills data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
			[ ] lsAddBill=lsExcelData[2]
			[ ] lsAddBill[4]=ModifyDate(31,sDateFormat)
			[ ] 
			[ ] ListAppend(lsReminderList,lsAddBill[2])
			[ ] 
			[ ] iValidate=NavigateReminderDetailsPage(lsAddBill[1],lsAddBill[2])
			[+] if( iValidate==PASS)
				[ ] 
				[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4],sDaysBefore,NULL,lsAddAccount1[2])
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if Reminder added",PASS,"{lsAddBill[1]} Reminder {lsAddBill[2]} added successfully")
					[ ] //Close Add/Link biller dialog
					[ ] CloseAddLinkBiller()
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Reminder added",FAIL,"{lsAddBill[1]} Reminder {lsAddBill[2]} not added")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] //-------Verify if reminder of current month is displayed in Monthly Bills tab of  Manage Reminder List (CTRL+J)-----------
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_BILL, "Upcoming")
		[ ] OpenManageReminders()
		[+] if (DlgManageReminders.Exists(5))
			[ ] DlgManageReminders.MonthlyBillsDepositsTab.Click()
			[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
			[ ] iCount=DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()-1
			[ ] 
			[ ] 
			[ ] 
			[ ] //For Transfer Reminder  -  Should match
			[+] for(iCounter=0; iCounter<=iCount ; iCounter++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
				[ ] 
				[ ] // Verify different parameters such as payee name and Income amount
				[ ] bMatch = MatchStr("*{lsReminderList[1]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verification of  added Reminder ", PASS, "{lsReminderList[1]} Reminder for current month is displayed under Monthly Bills Deposits Tab")
					[ ] break
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("Verification of  added Reminder ", FAIL, "{lsReminderList[1]} Reminder for current month is NOT displayed under Monthly Bills Deposits Tab")
				[ ] 
			[ ] 
			[ ] 
			[ ] //For Bill Reminder -  Should match
			[+] for(iCounter=0; iCounter<=iCount ; iCounter++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
				[ ] 
				[ ] // Verify different parameters such as payee name and Income amount
				[ ] bMatch = MatchStr("*{lsReminderList[2]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verification of  added Reminder ", PASS, "{lsReminderList[2]} Reminder for current month is displayed under Monthly Bills Deposits Tab")
					[ ] break
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("Verification of  added Reminder ", FAIL, "{lsReminderList[2]} Reminder for current month is NOT displayed under Monthly Bills Deposits Tab")
				[ ] 
			[ ] 
			[ ] 
			[ ] //For Income Reminder -    Should not match
			[+] for(iCounter=0; iCounter<=iCount ; iCounter++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
				[ ] 
				[ ] // Verify different parameters such as payee name and Income amount
				[ ] bMatch = MatchStr("*{lsReminderList[3]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verification of  added Reminder ", FAIL, "{lsReminderList[3]} Reminder for current month is displayed under Monthly Bills Deposits Tab")
					[ ] break
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("Verification of  added Reminder ", PASS, "{lsReminderList[3]} Reminder for next month is not displayed under Monthly Bills Deposits Tab")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] DlgManageReminders.Close()
			[ ] WaitForState(DlgManageReminders,FALSE,5)
			[ ] 
		[+] else
			[ ] ReportStatus("Verification of  added Reminder ", FAIL, "Reminder is NOT added")
			[ ] iFunctionResult=FAIL
		[ ] 
		[ ] 
		[ ] 
		[ ] //-------Verify if reminder of current month is displayed in Monthly Bills tab of  Manage Reminder List (CTRL+J)-----------
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_BILL, "Upcoming")
		[ ] OpenManageReminders()
		[+] if (DlgManageReminders.Exists(5))
			[ ] DlgManageReminders.AllBillsDepositsTab.Click()
			[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
			[ ] iCount=DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()-1
			[ ] 
			[ ] 
			[ ] //For Transfer Reminder  -  Should match
			[+] for(iCounter=0; iCounter<=iCount ; iCounter++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
				[ ] 
				[ ] // Verify different parameters such as payee name and Income amount
				[ ] bMatch = MatchStr("*{lsReminderList[1]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verification of  added Reminder ", PASS, "{lsReminderList[1]} Reminder for current month is displayed under All Bills Deposits Tab")
					[ ] break
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("Verification of  added Reminder ", FAIL, "{lsReminderList[1]} Reminder for current month is NOT displayed under All Bills Deposits Tab")
				[ ] 
			[ ] 
			[ ] 
			[ ] //For Bill Reminder -  Should match
			[+] for(iCounter=0; iCounter<=iCount ; iCounter++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
				[ ] 
				[ ] // Verify different parameters such as payee name and Income amount
				[ ] bMatch = MatchStr("*{lsReminderList[2]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verification of  added Reminder ", PASS, "{lsReminderList[2]} Reminder for current month is displayed under All Bills Deposits Tab")
					[ ] break
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("Verification of  added Reminder ", FAIL, "{lsReminderList[2]} Reminder for current month is NOT displayed under All Bills Deposits Tab")
				[ ] 
			[ ] 
			[ ] 
			[ ] //For Income Reminder -    Should not match
			[+] for(iCounter=0; iCounter<=iCount ; iCounter++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
				[ ] 
				[ ] // Verify different parameters such as payee name and Income amount
				[ ] bMatch = MatchStr("*{lsReminderList[3]}*",sActual)
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verification of  added Reminder ", PASS, "{lsReminderList[3]} Reminder for current month is displayed under All Bills Deposits Tab")
					[ ] break
			[+] if(bMatch==FALSE)
				[ ] ReportStatus("Verification of  added Reminder ", FAIL, "{lsReminderList[3]} Reminder for next month is not displayed under All Bills Deposits Tab")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] DlgManageReminders.Close()
			[ ] WaitForState(DlgManageReminders,FALSE,5)
			[ ] 
			[ ] 
			[ ] //Delete all reminders
			[+] for(i=1;i<=ListCount(lsReminderList);i++)
				[ ] 
				[ ] //----------------Delete Bill Reminder--------------------------
				[ ] iValidate=ReminderOperations(sDelete,lsReminderList[i])
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
			[ ] ReportStatus("Verification of  added Reminder ", FAIL, "Reminder is NOT added")
			[ ] iFunctionResult=FAIL
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################### Verify functionality for Show Graph and Show Calendar on Manage Reminder Dialog ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test79_80_Verify_Show_Graph_Show_Calendar_Manage_Reminder_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality for Show Graph and Show Calendar on Manage Reminder Dialog
		[ ] // Show Graph checkbox: 
		[ ] // 1.Graph is displayed when checkbox is checked
		[ ] // 2.Graph is not displayed/hidden when checkbox is checked
		[ ] //
		[ ] // Show Calendar checkbox: 
		[ ] // 1.Calendar is displayed when checkbox is checked
		[ ] // 2.Calendar is not displayed/hidden when checkbox is checked
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If all verification points have passed
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  6th  Sept 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test79_80_Verify_Show_Graph_Show_Calendar_Manage_Reminder_Dialog() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // // Read account data from excel sheet
		[ ] // lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] // lsAddAccount=lsExcelData[1]
		[ ] // lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
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
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //Close Add/Link biller dialog
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] 
				[ ] 
				[ ] //-------Verify if reminder is added or not using Bill and Income Reminder List (CTRL+J)-----------
				[ ] QuickenWindow.SetActive()
				[ ] NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[ ] OpenManageReminders()
				[+] if (DlgManageReminders.Exists(10))
					[ ] 
					[ ] 
					[ ] // ------------- Graph -------------
					[ ] DlgManageReminders.StaticText1.AllBillsDepositsText.ShowgraphCheckBox.Uncheck()
					[+] if(!DlgManageReminders.StaticText1.AllBillsDepositsText.ReminderGraph.Exists(5))
						[ ] ReportStatus("Verify if Graph is displayed",PASS,"Graph is not displayed")
					[+] else
						[ ] ReportStatus("Verify if Graph is displayed",FAIL,"Graph is displayed")
					[ ] 
					[ ] DlgManageReminders.StaticText1.AllBillsDepositsText.ShowgraphCheckBox.Check()
					[+] if(DlgManageReminders.StaticText1.AllBillsDepositsText.ReminderGraph.Exists(5))
						[ ] ReportStatus("Verify if Graph is displayed",PASS,"Graph is displayed")
					[+] else
						[ ] ReportStatus("Verify if Graph is displayed",FAIL,"Graph is not displayed")
					[ ] 
					[ ] 
					[ ] // // -------------Calendar--------------
					[ ] // DlgManageReminders.StaticText1.AllBillsDepositsText.ShowcalendarCheckBox.Uncheck()
					[+] // if(!DlgManageReminders.StaticText1.CalendarText.CalendarMonthLabel.Exists(5))
						[ ] // ReportStatus("Verify if Calendar is displayed",PASS,"Calendar is not displayed")
					[+] // else
						[ ] // ReportStatus("Verify if Calendar is displayed",FAIL,"Calendar is displayed")
					[ ] // 
					[ ] // 
					[ ] // DlgManageReminders.StaticText1.AllBillsDepositsText.ShowcalendarCheckBox.Check()
					[+] // if(DlgManageReminders.StaticText1.CalendarText.CalendarMonthLabel.Exists(5))
						[ ] // ReportStatus("Verify if Calendar is displayed",PASS,"Calendar is displayed")
					[+] // else
						[ ] // ReportStatus("Verify if Calendar is displayed",FAIL,"Calendar is not displayed")
					[ ] 
					[ ] 
					[ ] 
					[ ] DlgManageReminders.Close()
					[ ] WaitForState(DlgManageReminders,FALSE,5)
					[ ] 
				[+] else
					[ ] ReportStatus("Verification of  added Reminder ", FAIL, "Reminder is NOT added")
					[ ] iFunctionResult=FAIL
				[ ] 
				[ ] 
				[ ] // Delete Reminder after operation
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)									  	 
					[ ] 
					[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
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
[+] //################### Verify functionality for Enter on Manage Reminder Dialog ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test82_Verify_Functionality_For_Enter_On_Manage_Reminder_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality for Enter on Manage Reminder Dialog
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Bill reminder is entered
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  6th  Sept 2013
	[ ] // ********************************************************
[+] testcase Test82_Verify_Functionality_For_Enter_On_Manage_Reminder_Dialog() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
		[ ] STRING sEnter="Enter"
		[ ] STRING sStack="Stack"
		[ ] STRING sDayFilter="30 Days"
		[ ] STRING sExpectedNumberOfTransactions="1"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //Close Add/Link biller dialog
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] 
				[ ] 
				[ ] //-------Verify if reminder is added or not using Bill and Income Reminder List (CTRL+J)-----------
				[ ] QuickenWindow.SetActive()
				[ ] NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[ ] OpenManageReminders()
				[ ] 
				[+] if(DlgManageReminders.Exists(10))
					[ ] 
					[ ] 
					[ ] 
					[ ] // Enter Reminder
					[ ] iValidate=ReminderOperations(sEnter,sPayeeName)
					[+] if(iValidate==PASS)									  	 
						[ ] 
						[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
						[ ] 
						[ ] 
						[ ] 
						[ ] //----------Verify if Reminder is entered in Stack View and Account Register------------------
						[ ] MDIClient.Bills.ViewAsPopupList.Select(sStack)
						[ ] //Select 30 days filter on Stack view
						[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
						[ ] 
						[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Exists(SHORT_SLEEP))
							[ ] ReportStatus("Verify that Go to register button exists",PASS,"Go to register button exists")
							[ ] //-------Click on Go to Register button---------
							[ ] MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Click()
							[ ] 
							[ ] iValidate=VerifyTransactionInAccountRegister(sPayeeName,sExpectedNumberOfTransactions)
							[+] if(iValidate==PASS)
								[ ] iValidate=DeleteTransaction(sMDIWindow,sPayeeName)
								[+] if(iValidate==PASS)
									[ ] ReportStatus("Verify that account is displayed in account register",PASS,"Account is displayed in the account register")
									[ ] 
									[ ] // Delete Reminder after operation
									[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
									[+] if(iValidate==PASS)									  	 
										[ ] 
										[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
										[ ] 
										[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if transaction is deleted",FAIL,"Transaction is not deleted")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that account is displayed in account register",FAIL,"Account is NOT displayed in the account register")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that Go to register button exists",FAIL,"Go to register button does not exist")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
						[ ] 
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verification of  added Reminder ", FAIL, "Reminder is NOT added")
					[ ] iFunctionResult=FAIL
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
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
[+] //################### Verify functionality for Skip on Manage Reminder Dialog ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test83_Verify_Functionality_For_Skip_On_Manage_Reminder_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality for Skip on Manage Reminder Dialog
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If reminder is skipped
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  6th  Sept 2013
	[ ] // ********************************************************
[+] testcase Test83_Verify_Functionality_For_Skip_On_Manage_Reminder_Dialog() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
		[ ] STRING sSkip="Skip"
		[ ] STRING sListOption="List"
		[ ] STRING sDayFilter="90 Days"
		[ ] STRING sExpectedNumberOfTransactions="1"
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //Close Add/Link biller dialog
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] // //-------Verify if reminder is skipped -----------
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sSkip,sPayeeName)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if skip dialog window is open",PASS,"Skip dialog window is opened")
					[ ] 
					[ ] 
					[ ] //--------------Verify if Reminder is skiped ---------------
					[ ] QuickenWindow.SetActive()
					[ ] //Select List view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
					[ ] //Select 90 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
					[ ] 
					[ ] 
					[ ] //-------Verify content under List view on Bills Upcoming tab---------------
					[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
					[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
						[ ] 
						[ ] bMatch=FALSE
						[ ] bMatch=MatchStr("*{sPayeeName}*{sBillDate}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is NOT skipped and in displayed in list view")
							[ ] break
							[ ] 
					[ ] 
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is skipped and not displayed in list view")
						[ ] 
					[ ] 
					[ ] // Delete Reminder after operation
					[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
					[+] if(iValidate==PASS)									  	 
						[ ] 
						[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if skip dialog window is open",FAIL,"Skip dialog window is not opened")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
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
[+] //################### Verify functionality for Edit action on Manage Reminder Dialog ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test84_Verify_Functionality_For_Edit_On_Manage_Reminder_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality for Edit action on Manage Reminder Dialog
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If reminder is edited
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  6th  Sept 2013
	[ ] // ********************************************************
[+] testcase Test84_Verify_Functionality_For_Edit_On_Manage_Reminder_Dialog() appstate none
	[ ] 
	[ ] 
	[ ] //---------Variable Definition----------
	[ ] 
	[ ] STRING sEdit,sVerificationOption,sVerificationFilter,sNewAmount
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] sEdit="Edit Multiple"
		[ ] 
		[ ] sVerificationOption="List"
		[ ] sVerificationFilter="90 Days"
		[ ] sNewAmount="12.25"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] //Close Add/Link biller dialog
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] 
				[ ] // //-------Verify if reminder is skipped -----------
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] 
				[ ] iValidate=ReminderOperations(sEdit,sPayeeName)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if Edit dialog window is open",PASS,"Edit dialog window is opened")
					[ ] 
					[ ] 
					[ ] 
					[+] if(DlgAddEditReminder.Exists(10))
						[ ] DlgAddEditReminder.SetActive()
						[ ] DlgAddEditReminder.Step2Panel.QWinChild1.AmountDueTextField.SetText(sNewAmount)
						[ ] DlgAddEditReminder.DoneButton.Click()
						[ ] 
						[ ] // 08-09-2015 KalyanG: added the condition to dismiss add biller dialog, ref build 25.0.0.395
						[ ] CloseAddLinkBiller()
						[ ] 
						[+] if(DlgManageReminders.Exists(5))
							[ ] DlgManageReminders.Close()
							[ ] WaitForState(DlgManageReminders,FALSE,SHORT_SLEEP)
						[ ] 
						[ ] 
						[ ] // -------------Verify new bill amount is changed only for first Bill from list view---------------
						[ ] //Select Stack view on bills tab
						[ ] MDIClient.Bills.ViewAsPopupList.Select(sVerificationOption)
						[ ] //Select 30 days filter on Stack view
						[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sVerificationFilter)
						[ ] 
						[+] if(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.Exists(5))
							[ ] iCount=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount()
							[ ] 
							[ ] // -------------Verify new bill amount ------------
							[ ] sHandle=str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
							[+] for(i=0; i< iCount; i++)
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
								[ ] 
								[+] if(i==0)
									[ ] bMatch = MatchStr("*{lsAddBill[1]}*{sNewAmount}*",sActual)
									[+] if(bMatch==TRUE)
										[ ] ReportStatus("Verify if Single instance of Bill Reminder is edited", PASS, "Bill Reminder with payee name '{lsAddBill[1]}' is edited successfully with amount {sNewAmount}")
									[+] else
										[ ] ReportStatus("Verify if Single instance of Bill Reminder is edited", FAIL, "Bill Reminder for {lsAddBill[1]} is NOT edited, sActual = {sActual}")
								[ ] 
								[+] if(i>0)
									[ ] bMatch = MatchStr("*{lsAddBill[1]}*{sNewAmount}*",sActual)
									[+] if(bMatch==TRUE)
										[ ] ReportStatus("Verify if Multiple instances of Bill Reminder is not edited", PASS, "Future Bill Reminder with payee name '{lsAddBill[1]}' is edited successfully with amount {sNewAmount}")
									[+] else
										[ ] ReportStatus("Verify if Multiple instances of Bill Reminder is not edited ", FAIL, "Future Bill Reminder for {lsAddBill[1]} is NOT edited, sActual = {sActual}")
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
							[ ] // Delete Reminder after operation
							[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
							[+] if(iValidate==PASS)									  	 
								[ ] 
								[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
								[ ] 
								[ ] 
							[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify List view of Bill Reminder",FAIL,"List view of Bill reminder is not displayed")
							[ ] 
							[ ] 
							[ ] 
					[+] else
						[ ] ReportStatus("Verify Edit Reminder opened",FAIL,"Edit Reminder window for single instance is not opened")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Edit dialog window is open",FAIL,"Edit dialog window is not opened")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
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
[+] //################### Verify functionality for Delete on Manage Reminder Dialog ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test85_Verify_Functionality_For_Delete_On_Manage_Reminder_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality for Delete on Manage Reminder Dialog
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If reminder is skipped
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  11th  Sept 2013
	[ ] // ********************************************************
[+] testcase Test85_Verify_Functionality_For_Delete_On_Manage_Reminder_Dialog() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] sDayFilter="30 Days"
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
		[ ] STRING sMatchText1="Set up"
		[ ] STRING sMatchText2="a scheduled bill or deposit"
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] //Close Add/Link biller dialog
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] 
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if Delete reminder operation is complete",PASS,"Reminder delete operation completed")
					[ ] 
					[ ] 
					[ ] //-------Verify content under manage Reminder dialog view on Bills Upcoming tab---------------
					[ ] QuickenWindow.SetActive()
					[ ] OpenManageReminders()
					[+] if (DlgManageReminders.Exists(5))
						[ ] 
						[ ] sHandle=Str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(0))
						[ ] 
						[ ] bMatch=MatchStr("*{sMatchText1}*{sMatchText2}*",sActual)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from Manage Reminder dialog")
						[+] else
							[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder NOT deleted from Manage Reminder dialog")
						[ ] 
						[ ] DlgManageReminders.Close()
						[ ] WaitForState(DlgManageReminders,FALSE,5)
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if skip dialog window is open",FAIL,"Skip dialog window is not opened")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Main window exists",FAIL,"Quicken Main window doesn't exist")
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
[+] //################ Verify functionality Include paid check box on Bills > Upcoming tab for List View  ###############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test88_Verify_Include_Paid_CheckBox_Reminders_In_List_View()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify functionality Include paid check box on Bills > Upcoming tab for List View
		[ ] //  i.e. reminders that have been paid should be displayed in the list
		[ ] //
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If only reminders that have been paid are displayed
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  23rd  Sept 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test88_Verify_Include_Paid_CheckBox_Reminders_In_List_View() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sEnter,sExpectedNumberOfTransactions
		[ ] LIST OF STRING lsReminderList
		[ ] 
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] sListOption="List"
		[ ] sDayFilter="30 Days"
		[ ] sEnter="Enter"
		[ ] sExpectedNumberOfTransactions="1"
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] //------Second checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount2=lsExcelData[2]
		[ ] lsAddAccount2[4]=sDate
		[ ] 
		[ ] sDaysBefore=NULL
		[ ] 
		[ ] 
		[ ] 
	[ ] 
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
		[ ] //-------------Add Reminders----------------------
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[+] //--------------------Bills Reminder----------------------
			[ ] 
			[ ] // Read bills data from excel sheet
			[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
			[ ] lsAddBill=lsExcelData[1]
			[ ] lsAddBill[4]=sBillDate
			[ ] 
			[ ] ListAppend(lsReminderList,lsAddBill[2])
			[ ] 
			[ ] iValidate=NavigateReminderDetailsPage(lsAddBill[1],lsAddBill[2])
			[+] if( iValidate==PASS)
				[ ] 
				[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4],sDaysBefore,lsAddAccount2[2])
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if Reminder added",PASS,"{lsAddBill[1]} Reminder {lsAddBill[2]} added successfully")
					[ ] //Close Add/Link biller dialog
					[ ] CloseAddLinkBiller()
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
					[+] //-----------------Income Reminder----------------------
						[ ] 
						[ ] // Read bills data from excel sheet
						[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
						[ ] lsAddBill=lsExcelData[2]
						[ ] lsAddBill[4]=sBillDate
						[ ] 
						[ ] ListAppend(lsReminderList,lsAddBill[2])
						[ ] 
						[ ] 
						[ ] iValidate=NavigateReminderDetailsPage(lsAddBill[1],lsAddBill[2])
						[+] if( iValidate==PASS)
							[ ] 
							[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4],sDaysBefore,NULL,lsAddAccount1[2])
							[+] if(iValidate==PASS)
								[ ] ReportStatus("Verify if Reminder added",PASS,"{lsAddBill[1]} Reminder {lsAddBill[2]} added successfully")
								[ ] //Close Add/Link biller dialog
								[ ] CloseAddLinkBiller()
								[ ] 
								[ ] 
								[ ] 
								[ ] //Enter Bill Reminder
								[ ] sPayeeName=lsReminderList[1]
								[ ] iValidate=ReminderOperations(sEnter,sPayeeName)
								[+] if(iValidate==PASS)									  	 
									[ ] ReportStatus("Verify Enter Reminder",PASS,"Reminder entered")
									[ ] 
									[ ] 
									[ ] 
									[ ] //Verify Include Paid Functionality for List View 
									[+] // When checkbox is checked
										[ ] 
										[ ] //Select Include Paid Checkbox
										[ ] MDIClient.Bills.IncludePaid.Check()
										[ ] //Navigate to list view
										[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
										[ ] //Select filter on List view
										[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
										[ ] 
										[ ] 
										[ ] //Search that Bill reminder should be displayed in List
										[ ] //-------Verify content under List view on Bills Upcoming tab---------------
										[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
										[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
											[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
											[ ] bMatch=MatchStr("*{lsReminderList[1]}*",sActual)
											[+] if(bMatch==TRUE)
												[ ] break
											[ ] 
										[+] if(bMatch==TRUE)
											[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder {lsReminderList[1]} is displayed when Checkbox Include Paid is selected in {sListOption} view on Bills tab")
										[+] else
											[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder {lsReminderList[1]} is not displayed when Checkbox Include Paid is selected in {sListOption} view on Bills tab")
											[ ] 
											[ ] 
										[ ] 
										[ ] 
										[ ] //Search that Income reminder should be displayed in List
										[ ] //-------Verify content under List view on Bills Upcoming tab---------------
										[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
										[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
											[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
											[ ] bMatch=MatchStr("*{lsReminderList[2]}*",sActual)
											[+] if(bMatch==TRUE)
												[ ] break
											[ ] 
											[ ] 
										[+] if(bMatch==TRUE)
											[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder {lsReminderList[1]} is displayed when Checkbox Include Paid is selected in {sListOption} view on Bills tab")
										[+] else
											[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder {lsReminderList[1]} is not displayed when Checkbox Include Paid is selected in {sListOption} view on Bills tab")
											[ ] 
											[ ] 
										[ ] 
										[ ] 
										[ ] 
										[ ] 
										[ ] 
									[ ] 
									[+] // When checkbox is unchecked
										[ ] 
										[ ] //Select Include Paid Checkbox
										[ ] MDIClient.Bills.IncludePaid.Uncheck()
										[ ] //Navigate to list view
										[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
										[ ] //Select filter on List view
										[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
										[ ] 
										[ ] 
										[ ] //Search that Bill reminder should be displayed in List
										[ ] //-------Verify content under List view on Bills Upcoming tab---------------
										[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
										[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
											[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
											[ ] bMatch=MatchStr("*{lsReminderList[1]}*",sActual)
											[+] if(bMatch==TRUE)
												[ ] break
											[ ] 
											[ ] 
										[+] if(bMatch==FALSE)
											[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder {lsReminderList[1]} is not displayed when Checkbox Include Paid is unchecked in {sListOption} view on Bills tab")
										[+] else
											[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder {lsReminderList[1]} is displayed when Checkbox Include Paid is checked in {sListOption} view on Bills tab")
											[ ] 
											[ ] 
											[ ] 
										[ ] 
										[ ] 
										[ ] //Search that Income reminder should be displayed in List
										[ ] //-------Verify content under List view on Bills Upcoming tab---------------
										[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
										[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
											[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
											[ ] bMatch=MatchStr("*{lsReminderList[2]}*",sActual)
											[+] if(bMatch==TRUE)
												[ ] break
											[ ] 
										[+] if(bMatch==TRUE)
											[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder {lsReminderList[2]} is displayed when Checkbox Include Paid is selected in {sListOption} view on Bills tab")
										[+] else
											[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder {lsReminderList[2]} is not displayed when Checkbox Include Paid is selected in {sListOption} view on Bills tab")
											[ ] 
											[ ] 
										[ ] 
										[ ] 
										[ ] 
										[ ] 
										[ ] 
									[ ] 
									[ ] 
									[ ] SelectAccountFromAccountBar(lsAddAccount2[2],ACCOUNT_BANKING)
									[ ] iValidate=VerifyTransactionInAccountRegister(sPayeeName,sExpectedNumberOfTransactions)
									[+] if(iValidate==PASS)
										[ ] iValidate=DeleteTransaction(sMDIWindow,sPayeeName)
										[+] if(iValidate==PASS)
											[ ] ReportStatus("Verify that account is displayed in account register",PASS,"Account is displayed in the account register")
											[ ] 
											[ ] 
											[ ] //Delete all reminders
											[+] for(i=1;i<=2;i++)
												[ ] 
												[ ] //----------------Delete Bill Reminder--------------------------
												[ ] iValidate=ReminderOperations(sDelete,lsReminderList[i])
												[+] if(iValidate==PASS)									  	 
													[ ] 
													[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
													[ ] 
												[+] else
													[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
													[ ] 
													[ ] 
												[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Verify if transaction is deleted",FAIL,"Transaction is not deleted")
									[+] else
										[ ] ReportStatus("Verify Transaction count in register",FAIL,"Transaction count in register does not match")
										[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
									[ ] 
									[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify if Reminder added",FAIL,"{lsAddBill[1]} Reminder {lsAddBill[2]} not added")
								[ ] 
								[ ] 
						[+] else
							[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Reminder added",FAIL,"{lsAddBill[1]} Reminder {lsAddBill[2]} not added")
					[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Income Reminder screen two is not displayed")
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
		[ ] ReportStatus("Verify if Quicken exists",FAIL,"Quicken window not found")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################### Verify functionality of  Double click launches enter transaction dialog on list view  ########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test92_Verify_Double_Click_Functionality_For_Reminder_On_List_View()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if  Double click launches enter transaction dialog on list view 
		[ ] //
		[ ] // PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Enter Transaction dialog is displayed
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  23rd  Sept 2013
	[ ] // ********************************************************
[+] testcase Test92_Verify_Double_Click_Functionality_For_Reminder_On_List_View() appstate none
	[ ] 
	[ ] 
	[+] //Variable Definition
		[ ] INTEGER iXpos,iYpos,iButton
		[ ] STRING sPaidText,sGoToRegisterButton,sExpectedNumberOfTransactions
		[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] STRING sStack="Stack"
		[ ] 
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] //--------First checking account----------
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount1=lsExcelData[1]
		[ ] lsAddAccount1[4]=sDate
		[ ] 
		[ ] 
		[ ] sListOption="List"
		[ ] sDayFilter="30 Days"
		[ ] sPaidText="Paid"
		[ ] sGoToRegisterButton="Go to Register"
		[ ] sExpectedNumberOfTransactions="1"
		[ ] 
		[ ] iButton=1
		[ ] iXpos=459
		[ ] iYpos=12
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] //Close Add/Link biller dialog
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] 
				[ ] 
				[ ] 
				[ ] //Navigate to list view
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
				[ ] //Select filter on List view
				[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
				[ ] 
				[ ] 
				[ ] //Search that Bill reminder should be displayed in List
				[ ] //-------Verify content under List view on Bills Upcoming tab---------------
				[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
				[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
					[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
					[ ] bMatch=MatchStr("*{sPayeeName}*",sActual)
					[+] if(bMatch==TRUE)
						[ ] break
					[ ] 
					[ ] 
				[+] if(bMatch==TRUE)
					[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder displayed")
					[ ] 
					[ ] 
					[ ] 
					[ ] MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.DoubleClick (iButton, iXpos, iYpos)
					[ ] 
					[+] if(EnterExpenseIncomeTxn.Exists(5))
						[ ] EnterExpenseIncomeTxn.SetActive()
						[ ] EnterExpenseIncomeTxn.EnterTransactionButton.Click()
						[ ] 
						[ ] 
						[ ] 
						[ ] //--------------Verify if Reminder is entered in list view ---------------
						[ ] MDIClient.Bills.IncludePaid.Check()
						[ ] //Select List view on bills tab
						[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption)
						[ ] //Select 30 days filter on List view
						[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
						[ ] //-------Verify content under List view on Bills Upcoming tab---------------
						[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
						[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
							[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
							[ ] 
							[ ] bMatch=MatchStr("*{sPayeeName}*{sPaidText}*{sGoToRegisterButton}*",sActual)
							[ ] 
							[ ] 
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Verify if reminder is displayed correctly in list view",PASS,"Reminder is displayed correctly in list view")
								[ ] break
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[ ] 
							[ ] 
						[+] if(bMatch==FALSE)
							[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is NOT entered in list view")
							[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] SelectAccountFromAccountBar(lsAddAccount1[2],ACCOUNT_BANKING)
						[ ] iValidate=VerifyTransactionInAccountRegister(sPayeeName,sExpectedNumberOfTransactions)
						[+] if(iValidate==PASS)
							[ ] iValidate=DeleteTransaction(sMDIWindow,sPayeeName)
							[+] if(iValidate==PASS)
								[ ] ReportStatus("Verify that account is displayed in account register",PASS,"Account is displayed in the account register")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that account is displayed in account register",FAIL,"Account is not displayed in the account register")
						[+] else
							[ ] ReportStatus("Verify if transaction is deleted",FAIL,"Transaction is not deleted")
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Enter Transaction window",FAIL,"Enter Transaction window not open")
						[ ] iFunctionResult=FAIL
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
					[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is not displayed")
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
				[ ] //-------Verify if reminder is added or not using Bill and Income Reminder List (CTRL+J)-----------
				[ ] QuickenWindow.SetActive()
				[ ] NavigateQuickenTab(sTAB_BILL, "Upcoming")
				[ ] OpenManageReminders()
				[ ] 
				[+] if(DlgManageReminders.Exists(10))
					[ ] 
					[ ] 
					[ ] 
					[ ] // Enter Reminder
					[ ] iValidate=ReminderOperations(sEnter,sPayeeName)
					[+] if(iValidate==PASS)									  	 
						[ ] 
						[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
						[ ] 
						[ ] 
						[ ] 
						[ ] //----------Verify if Reminder is entered in Stack View and Account Register------------------
						[ ] MDIClient.Bills.ViewAsPopupList.Select(sStack)
						[ ] //Select 30 days filter on Stack view
						[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter)
						[ ] 
						[+] if(MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Exists(SHORT_SLEEP))
							[ ] ReportStatus("Verify that Go to register button exists",PASS,"Go to register button exists")
							[ ] //-------Click on Go to Register button---------
							[ ] MDIClient.Bills.Panel.Panel1.QWinChild.GoToRegisterButton.Click()
							[ ] 
							[ ] iValidate=VerifyTransactionInAccountRegister(sPayeeName,sExpectedNumberOfTransactions)
							[+] if(iValidate==PASS)
								[ ] iValidate=DeleteTransaction(sMDIWindow,sPayeeName)
								[+] if(iValidate==PASS)
									[ ] ReportStatus("Verify that account is displayed in account register",PASS,"Account is displayed in the account register")
									[ ] 
									[ ] // Delete Reminder after operation
									[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
									[+] if(iValidate==PASS)									  	 
										[ ] 
										[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
										[ ] 
									[+] else
										[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
										[ ] 
										[ ] 
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify if transaction is deleted",FAIL,"Transaction is not deleted")
								[ ] 
								[ ] 
								[ ] 
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that account is displayed in account register",FAIL,"Account is NOT displayed in the account register")
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify that Go to register button exists",FAIL,"Go to register button does not exist")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
						[ ] 
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verification of  added Reminder ", FAIL, "Reminder is NOT added")
					[ ] iFunctionResult=FAIL
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window not found")
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] // 
[ ] 
[ ] 
[ ] // ------ 13th March 2014 -------------
[ ] 
[ ] 
[+] //############################## Verify Enter Reminder Button from stack view ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test54_Verify_Enter_Reminder_Button_From_List_View()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Enter reminder functionality from list view
		[ ] // 1.Reminder appears as Received in List View
		[ ] // 2.Reminder is entered in register
		[ ] //
		[ ] // 
		[ ] //PARAMETERS:		none
		[ ] //
		[ ] // RETURNS:			Pass 		If Add Reminder content is verified correctly
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  24th  June 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test54_Verify_Enter_Reminder_Button_From_List_View() appstate none
	[ ] 
	[ ] 
	[+] //---------Variable Definition----------
		[ ] 
		[ ] STRING sListOption1,sReceivedText,sExpectedNumberOfTransactions,sDayFilter1,sDayFilter2,Register
		[ ] STRING sGoToRegister
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] SetUp_AutoApi()
		[ ] 
		[ ] sListOption1="List"
		[ ] 
		[ ] sDayFilter1="30 Days"
		[ ] sDayFilter2="90 Days"
		[ ] 
		[ ] sReceivedText="Received"
		[ ] 
		[ ] sExpectedNumberOfTransactions="1"
		[ ] 
		[ ] sGoToRegister="Go to Register"
		[ ] 
		[ ] 
		[ ] sBillDate=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[1]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=sBillDate
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] //--------------Add a Reminder---------------------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] //Close Add/Link biller dialog
				[ ] CloseAddLinkBiller()
				[ ] 
				[ ] 
				[ ] //------Navigate to Stack View-----------
				[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption1)
				[ ] //--------Click on Enter button in Stack view-----
				[ ] 
				[ ] iValidate=BillsTabListViewOperations(lsAddBill[2],sEnter)
				[+] if(iValidate==PASS)
					[ ] ReportStatus("Verify if enter transaction window is open",PASS,"Enter Transaction window is opened")
					[ ] 
					[ ] 
					[ ] //--------------Verify if Reminder is entered ---------------
					[ ] //Select Stack view on bills tab
					[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption1)
					[ ] //Select 30 days filter on Stack view
					[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter2)
					[ ] //-------Verify content under List view on Bills Upcoming tab---------------
					[ ] sHandle=Str(MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetHandle())
					[+] for(i=0;i<=MDIClient.Bills.ViewAs2TextStaticText.ViewAsSubTextStaticText.ViewAsQWListViewer.ReminderListBox.GetItemCount();i++)
						[ ] sActual=QwAutoExecuteCommand("LISTBOX_GETFULLROW",sHandle,Str(i))
						[ ] 
						[ ] bMatch=MatchStr("*{sPayeeName}*{sTransactionAmount}*{sReceivedText}*",sActual)
						[ ] 
						[ ] 
						[ ] 
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Verify if reminder is found",PASS,"Reminder is entered")
							[ ] 
							[ ] 
							[ ] MDIClient.Bills.ViewAsPopupList.Select(sListOption1)
							[ ] //Select 30 days filter on Stack view
							[ ] MDIClient.Bills.DueWithinNextPopupList.Select(sDayFilter1)
							[ ] 
							[ ] ////-------Click on Go to Register button---------
							[ ] iValidate=BillsTabListViewOperations(lsAddBill[2],sGoToRegister)
							[+] if(iValidate==PASS)
								[ ] 
								[ ] iValidate=VerifyTransactionInAccountRegister(sPayeeName,sExpectedNumberOfTransactions)
								[+] if(iValidate==PASS)
									[ ] 
									[ ] iValidate=DeleteTransaction(sMDIWindow,sPayeeName)
									[+] if(iValidate==PASS)
										[ ] ReportStatus("Verify that account is displayed in account register",PASS,"Account is displayed in the account register")
										[ ] 
										[ ] 
										[ ] 
										[ ] // Delete Reminder after operation
										[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
										[+] if(iValidate==PASS)									  	 
											[ ] 
											[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
											[ ] 
										[+] else
											[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
											[ ] 
											[ ] 
										[ ] break
										[ ] 
										[ ] 
									[+] else
										[ ] ReportStatus("Verify if transaction is deleted",FAIL,"Transaction is not deleted")
									[ ] 
									[ ] 
								[+] else
									[ ] ReportStatus("Verify that account is displayed in account register",FAIL,"Account is NOT displayed in the account register")
								[ ] 
								[ ] 
							[+] else
								[ ] ReportStatus("Verify that account has been selected",FAIL,"Account has not been selected from account bar")
							[ ] 
							[ ] 
					[ ] 
					[+] if(bMatch==FALSE)
						[ ] ReportStatus("Verify if reminder is found",FAIL,"Reminder is NOT entered")
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
					[ ] ReportStatus("Verify if enter transaction window is open",FAIL,"Enter Transaction window is not opened")
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added to Quicken",PASS,"Reminder not added to Quicken")
				[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window not found")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //#################################### Verify Manage Reminder dialog #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test62_76_Verify_Manage_Reminder_Dialog()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify Manage Reminder dialog contents
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Manage Reminder dialog contents are displayed
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  13th March 2014
	[ ] // ********************************************************
[+] testcase Test62_76_81_Verify_Manage_Reminder_Dialog() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] LIST OF STRING lsToolbarOptions={"Enter","Skip","Create New","Edit","Delete","Options","Print","How Do I?"}
		[ ] LIST OF STRING lsReminderType={"Bill","Income","Transfer","Invoice"}
		[ ] 
		[ ] INTEGER iCount,jCount
		[ ] sDateFormat="m/d/yyyy"
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[1]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] sTransactionAmount=lsAddBill[3]
		[ ] lsAddBill[4]=ModifyDate(0,sDateFormat)
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] 
		[ ] //-----------Add a Reminder----------
		[ ] iValidate=NavigateReminderDetailsPage(sReminderType,sPayeeName)
		[+] if(iValidate==PASS)
			[ ] 
			[ ] 
			[ ] 
			[ ] iValidate=AddReminderInDataFile(lsAddBill[1],lsAddBill[2],lsAddBill[3],lsAddBill[4])
			[+] if(iValidate==PASS)
				[ ] 
				[ ] 
				[+] if( !DlgAddEditReminder.Exists(3))
					[ ] 
					[ ] QuickenWindow.SetActive()
					[ ] 
					[ ] // Verify functionality of objects on Manage Reminders dialog
					[ ] OpenManageReminders()
					[ ] 
					[ ] sleep(2)
					[+] if(DlgManageReminders.Exists(10))
						[ ] DlgManageReminders.SetActive()
						[ ] 
						[ ] 
						[ ] 
						[ ] //Verify Manage Reminder dialog contents
						[ ] 
						[+] if(DlgManageReminders.AllBillsDepositsTab.Exists(5))
							[ ] ReportStatus("Verify Manage Reminder dialog content",PASS,"AllBillsDepositsTab exists")
						[+] else
							[ ] ReportStatus("Verify Manage Reminder dialog content",FAIL,"AllBillsDepositsTab exists")
						[ ] 
						[ ] 
						[+] if(DlgManageReminders.MonthlyBillsDepositsTab.Exists(5))
							[ ] ReportStatus("Verify Manage Reminder dialog content",PASS,"MonthlyBillsDepositsTab exists")
						[+] else
							[ ] ReportStatus("Verify Manage Reminder dialog content",FAIL,"MonthlyBillsDepositsTab exists")
						[ ] 
						[ ] 
						[+] if(DlgManageReminders.ShowcalendarCheckBox.Exists(5))
							[ ] ReportStatus("Verify Manage Reminder dialog content",PASS,"ShowcalendarCheckBox exists")
						[+] else
							[ ] ReportStatus("Verify Manage Reminder dialog content",FAIL,"ShowcalendarCheckBox exists")
						[ ] 
						[ ] 
						[+] if(DlgManageReminders.ShowgraphCheckBox.Exists(5))
							[ ] ReportStatus("Verify Manage Reminder dialog content",PASS,"ShowgraphCheckBox exists")
						[+] else
							[ ] ReportStatus("Verify Manage Reminder dialog content",FAIL,"ShowgraphCheckBox exists")
						[ ] 
						[ ] 
						[+] if(DlgManageReminders.CalendarMonthButton.Exists(5))
							[ ] ReportStatus("Verify Manage Reminder dialog content",PASS,"CalendarMonthButton exists")
						[+] else
							[ ] ReportStatus("Verify Manage Reminder dialog content",FAIL,"CalendarMonthButton exists")
						[ ] 
						[+] if(DlgManageReminders.CalendarPreviousButton.Exists(5))
							[ ] ReportStatus("Verify Manage Reminder dialog content",PASS,"CalendarPreviousButton exists")
						[+] else
							[ ] ReportStatus("Verify Manage Reminder dialog content",FAIL,"CalendarPreviousButton exists")
						[ ] 
						[+] if(DlgManageReminders.CalendarPreviousButton.Exists(5))
							[ ] ReportStatus("Verify Manage Reminder dialog content",PASS,"CalendarNextButton exists")
						[+] else
							[ ] ReportStatus("Verify Manage Reminder dialog content",FAIL,"CalendarNextButton exists")
						[ ] 
						[ ] sHandle= Str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
						[ ] iListCount=DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()
						[+] for(iCounter=0; iCounter<=iListCount ; iCounter++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
							[ ] bMatch = MatchStr("*{sPayeeName}*",sActual)
							[+] if(bMatch==TRUE)
								[ ] break
						[+] if(bMatch==FALSE)
							[ ] ReportStatus("Verification of  added Reminder ", FAIL, "{sPayeeName} Reminder for current month is NOT displayed under All Bills Deposits Tab")
							[ ] 
						[+] else
							[ ] //Verify Toolbar contents
							[ ] 
							[+] for(iCount=1;iCount<=ListCount(lsToolbarOptions);iCount++)
								[ ] DlgManageReminders.SetActive()
								[ ] sleep(2)
								[ ] // Select first bill in the Manage Reminders dialog to enable Enter and Skip buttons
								[ ] DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.TextClick(sPayeeName)
								[ ] sleep(2)
								[ ] 
								[ ] DlgManageReminders.QW_MDI_TOOLBAR1.TextClick(lsToolbarOptions[iCount])
								[ ] 
								[+] switch(lsToolbarOptions[iCount])
									[ ] 
									[ ] 
									[+] case "Enter"
										[ ] 
										[+] if(EnterExpenseIncomeTxn.Exists(5))
											[ ] EnterExpenseIncomeTxn.SetActive()
											[ ] ReportStatus("Enter Transaction window",PASS,"Enter Transaction window open")
											[ ] EnterExpenseIncomeTxn.SetActive()
											[ ] EnterExpenseIncomeTxn.Close()
											[ ] WaitForState(EnterExpenseIncomeTxn,FALSE,5)
											[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Enter Transaction window",FAIL,"Enter Transaction window not open")
											[ ] 
											[ ] 
										[ ] 
										[ ] 
										[ ] 
										[ ] 
									[+] case "Skip"
										[ ] 
										[+] if(DlgAddEditReminder.SkipConfirmButton.Exists(SHORT_SLEEP))
											[ ] ReportStatus("Skip Transaction dialog",PASS,"Skip Transaction dialog open")
											[ ] DlgAddEditReminder.SetActive()
											[ ] DlgAddEditReminder.Close()
											[ ] WaitForState(DlgAddEditReminder,FALSE,5)
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Skip Transaction dialog",FAIL,"Skip Transaction dialog not open")
											[ ] 
											[ ] 
										[ ] 
										[ ] 
										[ ] 
										[ ] 
									[+] case "Create New"
										[ ] 
										[ ] 
										[+] for(jCount=1;jCount<=4;jCount++)
											[ ] 
											[ ] DlgManageReminders.QW_MDI_TOOLBAR1.TextClick(lsToolbarOptions[3])
											[ ] DlgManageReminders.TypeKeys(Replicate(KEY_DN,jCount))
											[ ] DlgManageReminders.TypeKeys(KEY_ENTER)
											[ ] 
											[+] if(jCount<5)
												[ ] 
												[+] if(DlgAddEditReminder.Exists(5))
													[ ] ReportStatus("Verify if Reminder dialog exists",PASS,"Reminder dialog exists for {lsReminderType[jCount]} Reminder")
													[ ] DlgAddEditReminder.SetActive()
													[ ] DlgAddEditReminder.Close()
													[ ] WaitForState(DlgAddEditReminder,FALSE,5)
													[ ] 
												[+] else
													[ ] ReportStatus("Verify if Reminder dialog exists",FAIL,"Reminder dialog does not exist for {lsReminderType[jCount]} Reminder")
													[ ] 
													[ ] 
													[ ] 
												[ ] 
												[ ] 
											[+] if(jCount==5)
												[ ] 
												[+] if(CreateTransactionGroup.Exists(5))
													[ ] ReportStatus("Verify if Create Transaction Group dialog exists",PASS,"Create Transaction Group dialog exists")
													[ ] CreateTransactionGroup.SetActive()
													[ ] CreateTransactionGroup.Close()
													[ ] WaitForState(CreateTransactionGroup,FALSE,5)
													[ ] 
													[ ] 
												[+] else
													[ ] ReportStatus("Verify if Create Transaction Group dialog exists",FAIL,"Create Transaction Group dialog does NOT exist")
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
									[+] case "Edit"
										[ ] 
										[+] if(DlgAddEditReminder.Exists(SHORT_SLEEP))
											[ ] ReportStatus("Edit Reminder dialog",PASS,"Edit Reminder dialog open")
											[ ] DlgAddEditReminder.SetActive()
											[ ] DlgAddEditReminder.Close()
											[ ] 
										[+] else
											[ ] ReportStatus("Edit Reminder dialog",FAIL,"Edit Reminder dialog NOT open")
											[ ] 
											[ ] 
										[ ] 
										[ ] 
									[+] case "Delete"
										[ ] 
										[+] if(AlertMessage.Exists(5))
											[ ] ReportStatus("Delete Reminder Dialog",PASS,"Delete Reminder Dialog appears")
											[ ] AlertMessage.SetActive()
											[ ] AlertMessage.Close()
											[ ] WaitForState(AlertMessage,FALSE,5)
											[ ] 
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Delete Reminder Dialog",FAIL,"Delete Reminder Dialog does not appear")
											[ ] 
										[ ] 
										[ ] 
									[+] case "Print"
										[+] if(DlgPrint.Exists(5))
											[ ] ReportStatus("Verify if Print Dialog exists",PASS,"Print Dialog exists")
											[ ] DlgPrint.SetActive()
											[ ] DlgPrint.Close()
											[ ] WaitForState(DlgPrint,FALSE,5)
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Verify if Print Dialog exists",FAIL,"Print Dialog does NOT exist")
											[ ] 
											[ ] 
											[ ] 
										[ ] 
									[+] case "How Do I?"
										[ ] 
										[+] if(QuickenHelp.Exists(5))
											[ ] ReportStatus("Verify if Quicken Help Dialog exists",PASS,"Quicken Help Dialog exists")
											[ ] QuickenHelp.SetActive()
											[ ] QuickenHelp.Close()
											[ ] WaitForState(QuickenHelp,FALSE,5)
											[ ] 
											[ ] 
										[+] else
											[ ] ReportStatus("Verify if Quicken Help Dialog exists",FAIL,"Quicken Help Dialog does NOT exist")
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
							[ ] // Delete Reminder after operation
							[ ] iValidate=ReminderOperations(sDelete,sPayeeName)
							[+] if(iValidate==PASS)									  	 
								[ ] 
								[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
								[ ] 
							[+] else
								[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
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
						[ ] ReportStatus("Verify if Manage Reminder window exists",FAIL,"Manage Reminder window does NOT exist")
					[ ] 
					[+] if (DlgManageReminders.Exists(5))
						[ ] DlgManageReminders.SetActive()
						[ ] DlgManageReminders.Close()
						[ ] sleep(2)
				[+] else
					[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
					[+] if( DlgAddEditReminder.Exists(5))
						[ ] DlgAddEditReminder.SetActive()
						[ ] DlgAddEditReminder.Close()
						[ ] WaitForState(DlgAddEditReminder, FALSE , 5)
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder is added",FAIL,"Error while adding reminder")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details second screen", FAIL, " Add Reminder screen two is not displayed")
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window not found")
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
[ ] //------- 23rd  Sept 2013 --------
[ ] 
[+] //#################################### Verify Add Paycheck Reminder  #######################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test92_Verify_Double_Click_Functionality_For_Reminder_On_List_View()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if  Double click launches enter transaction dialog on list view 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If Enter Transaction dialog is displayed
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  23rd  Sept 2013
	[ ] // ********************************************************
[+] testcase Test93_Verify_Add_Paycheck_Reminder() appstate none
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] STRING sPaycheckText="Paycheck Setup wizard"
		[ ] STRING sEditText="Edit"
		[ ] STRING sDate=ModifyDate(0,"m/d/yyyy")
		[ ] LIST OF STRING lsPaycheckDetails
		[ ] INTEGER iCounter
		[ ] 
		[ ] // Read bills data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBillReminderSheet2)
		[ ] lsAddBill=lsExcelData[2]
		[ ] sPayeeName=lsAddBill[2]
		[ ] sReminderType=lsAddBill[2]
		[ ] 
		[ ] // Read account data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sPaycheckSheet)
		[ ] lsPaycheckDetails=lsExcelData[1]
		[ ] sPayeeName=lsPaycheckDetails[1]
		[ ] sReminderType="Paycheque"
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] 
		[ ] NavigateQuickenTab(sTAB_BILL, "Upcoming")
		[ ] 
		[ ] //-----------Add a Reminder----------
		[+] if(QuickenMainWindow.QWNavigator.AddReminder.Exists(5))
			[ ] QuickenMainWindow.QWNavigator.AddReminder.Click()
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_DN,2)) 
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
			[ ] 
			[ ] 
			[+] if(DlgAddEditReminder.Exists(5))
				[ ] DlgAddEditReminder.PaycheckSetupText.TextClick(sPaycheckText)
				[ ] ReportStatus("Verify if Reminder window exists",PASS,"Reminder window exists")
				[ ] 
				[ ] // Add A Gross Paycheck
				[+] if(PayCheckSetup.Exists(5))
					[ ] ReportStatus("Verify if Paycheck window exists",PASS,"Paycheck window exists")
					[ ] 
					[ ] PayCheckSetup.GrossPaycheckTypeRadioList.Select(2)
					[ ] PayCheckSetup.Next.Click()
					[ ] PayCheckSetup.CompanyName.SetText(lsPaycheckDetails[1])
					[ ] PayCheckSetup.Next.Click()
					[ ] 
					[ ] sleep(2)
					[ ] 
					[ ] PayCheckSetup.Account.Select(lsPaycheckDetails[2])
					[ ] PayCheckSetup.MemoOptional.SetText(lsPaycheckDetails[3])
					[ ] PayCheckSetup.StartOn.SetText(sDate)
					[ ] PayCheckSetup.Frequency.Select(lsPaycheckDetails[4])
					[ ] 
					[ ] 
					[ ] PayCheckSetup.QWSnapHolder.AcceptClearenceTransaction.ListViewer.TextClick(sEditText)
					[+] if(EditEarning.Exists(5))
						[ ] 
						[ ] EditEarning.AmountTextField.SetText(lsPaycheckDetails[5])
						[ ] EditEarning.OKButton.Click()
						[ ] WaitForState(EditEarning,FALSE,5)
						[ ] 
					[+] else
						[ ] ReportStatus("Verify if Edit Earning window exists",FAIL,"Edit Earning window does NOT exist")
						[ ] 
					[ ] 
					[ ] PayCheckSetup.Done.Click()
					[ ] WaitForState(PayCheckSetup,FALSE,5)
					[ ] 
					[+] if(EnterYearToDateInformation.Exists(5))
						[ ] EnterYearToDateInformation.QuickenWillUseTheYearToD2.Select(2)
						[ ] EnterYearToDateInformation.OK.Click()
						[ ] WaitForState(EnterYearToDateInformation,FALSE,5)
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] //Verify if Paycheck is added
					[ ] //-------Verify if reminder of current month is displayed in Monthly Bills tab of  Manage Reminder List (CTRL+J)-----------
					[ ] QuickenWindow.SetActive()
					[ ] NavigateQuickenTab(sTAB_BILL, "Upcoming")
					[ ] OpenManageReminders()
					[+] if (DlgManageReminders.Exists(5))
						[ ] DlgManageReminders.AllBillsDepositsTab.Click()
						[ ] sHandle=str(DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetHandle())
						[ ] iCount=DlgManageReminders.StaticText2.ManageRemindersListViewer.ListBox1.GetItemCount()-1
						[ ] 
						[ ] //For Paycheck Reminder
						[+] for(iCounter=0; iCounter<=iCount ; iCounter++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter))
							[ ] //print(sActual)
							[ ] // Verify different parameters such as payee name and Income amount
							[ ] bMatch = MatchStr("*{lsPaycheckDetails[1]}*",sActual)
							[+] if(bMatch==TRUE)
								[ ] ReportStatus("Verification of  added Reminder ", PASS, "{lsPaycheckDetails[1]} Reminder for current month is displayed under All Bills Deposits Tab {sActual}")
								[ ] break
						[+] if(bMatch==FALSE)
							[ ] ReportStatus("Verification of  added Reminder ", FAIL, "{lsPaycheckDetails[1]} Reminder for current month is NOT displayed under All Bills Deposits Tab")
							[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verification of  added Reminder ", FAIL, "Reminder is NOT added")
					[ ] 
					[ ] 
					[ ] DlgManageReminders.Close()
					[ ] WaitForState(DlgManageReminders,FALSE,5)
					[ ] 
					[ ] 
					[ ] // Delete Reminder after operation
					[ ] iValidate=ReminderOperations(sDelete,sPayeeName ,sReminderType)
					[+] if(iValidate==PASS)									  	 
						[ ] 
						[ ] ReportStatus("Verify Reminder Deletion",PASS,"Reminder deleted from data file")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Reminder Deletion",FAIL,"Reminder not deleted from data file")
						[ ] 
						[ ] 
					[ ] 
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify if Paycheck window exists",FAIL,"Paycheck window does NOT exist")
					[ ] 
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify if Reminder window exists",FAIL,"Reminder window does NOT exist")
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Navigate to reminder details first screen", FAIL, "Add Reminder screen one is not displayed")
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify if Quicken Window exists",FAIL,"Quicken Window not found")
		[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[+] //################# Verify Bills-> Upcoming tab as Default by changing preferences ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_Default_Preferences_Upcoming_Tab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Upcoming tab is set as Default by changing preferences
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		if Upcoming tab is set as Default by changing preferences				
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  23rd  May 2013
		[ ] //
	[ ] // ********************************************************
	[ ] 
	[ ] 
[+] testcase Test03_Default_Preferences_Upcoming_Tab() appstate none
	[ ] 
	[ ] 
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sStartUp,sUpcomingTab
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] sStartUp="Startup"
		[ ] 
		[ ] //Object not identifiable hence using #3
		[ ] sUpcomingTab="#5"
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] //Edit Date from Excel data
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] 
		[ ] //----------Expand Account Bar--------------
		[ ] ExpandAccountBar()
		[ ] 
		[ ] 
		[ ] //------------Select Preferences----------------
		[ ] QuickenWindow.Edit.Click()
		[ ] QuickenWindow.Edit.Preferences.Select()
		[ ] Waitforstate(Preferences,TRUE,SHORT_SLEEP)
		[ ] 
		[ ] 
		[ ] 
		[+] if(Preferences.Exists(SHORT_SLEEP))
			[ ] Preferences.SetActive()
			[ ] ReportStatus("Naviigate to Preferences",PASS,"Preference {sStartUp} selected")
			[ ] 
			[ ] 
			[ ] //-----------Change on Startup open to "Upcoming"-------------------------
			[ ] Preferences.OnStartupOpenTo.Select(sUpcomingTab)
			[ ] sleep(3)
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,SHORT_SLEEP)
			[ ] 
			[ ] CloseQuicken()
			[ ] //--------------Reopen Quicken--------------------
			[ ] App_Start(sCmdLine)
			[ ] WaitForState(QuickenWindow,TRUE,LONG_SLEEP)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] 
			[ ] //------------------Verify that "Get Started" button should be present on Startup---------------------
			[+] if(GetStarted.Exists(5))
				[ ] ReportStatus("Quicken opens to Upcoming tab",PASS,"Quicken opens on Upcoming tab and Get Started button exists")
				[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Quicken opens to Upcoming tab",FAIL,"Quicken does not open on Upcoming tab")
				[ ] 
				[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Naviigate to Preferences",FAIL,"Preference {sStartUp} not selected")
			[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
[ ] //#######################################################################################################
[ ] 
[+] //#######################Verify Bills tab as Default by setting it as "Start Quicken on Bills" ###########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_Default_Preferences_Bills_Tab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify if Bills tab is set as Default by changing preferences
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		if Bills tab is set as Default by changing preferences				
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Dean Paes created  23rd  May 2013
		[ ] //
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test04_Default_Preferences_Bills_Tab() appstate none
	[+] //--------Variable Definition--------------
		[ ] 
		[ ] STRING sStartUp,sBillsTab
		[ ] STRING sBackup
		[ ] 
		[ ] 
	[ ] 
	[+] //---------Variable Declaration----------
		[ ] 
		[ ] 
		[ ] sStartUp="Startup"
		[ ] 
		[ ] //Object not identifiable hence using #3
		[ ] sBillsTab="#3"
		[ ] 
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sBillManagementExcelSheet,sBankingAccountSheet)
		[ ] lsAddAccount=lsExcelData[1]
		[ ] //Edit Date from Excel data
		[ ] lsAddAccount[4]=sDate
		[ ] 
		[ ] sBackup="Backup"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(10))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //----------------Disable Quicken Backup----------
		[ ] SelectPreferenceType(sBackup)
		[ ] Preferences.ManualBackupReminder.Uncheck()
		[ ] Preferences.OK.Click()
		[ ] WaitForState(Preferences,FALSE,SHORT_SLEEP)
		[ ] 
		[ ] //----------Expand Account Bar--------------
		[ ] ExpandAccountBar()
		[ ] 
		[ ] //------------Select Preferences----------------
		[ ] QuickenWindow.Edit.Click()
		[ ] QuickenWindow.Edit.Preferences.Select()
		[ ] WaitForState(Preferences,TRUE,SHORT_SLEEP)
		[ ] 
		[+] if(Preferences.Exists(SHORT_SLEEP))
			[ ] ReportStatus("Naviigate to Preferences",PASS,"Preference {sStartUp} selected")
			[ ] 
			[ ] 
			[ ] //-----------Change on Startup open to "Bills"-------------------------
			[ ] Preferences.OnStartupOpenTo.Select(sBillsTab)
			[ ] sleep(3)
			[ ] Preferences.OK.Click()
			[ ] WaitForState(Preferences,FALSE,SHORT_SLEEP)
			[ ] 
			[ ] 
			[ ] //--------------Close Quicken-----------------------
			[ ] QuickenWindow.Close()
			[ ] WaitForState(QuickenWindow,FALSE,LONG_SLEEP)
			[ ] sleep(5)
			[ ] 
			[ ] 
			[ ] //--------------Reopen Quicken--------------------
			[ ] App_Start(sCmdLine)
			[ ] WaitForState(QuickenWindow,TRUE,LONG_SLEEP)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // sleep(2)
			[ ] // //----------Restarrt to handle identification issue
			[ ] // QuickenWindow.Kill()
			[ ] // WaitForState(QuickenWindow,FALSE,LONG_SLEEP)
			[ ] // App_Start(sCmdLine)
			[ ] // WaitForState(QuickenWindow,TRUE,LONG_SLEEP)
			[ ] 
			[ ] 
			[ ] //------------------Verify that "Add Reminder" button should be present on Startup---------------------
			[+] if(AddReminderButton.Exists(LONG_SLEEP))
				[ ] 
				[ ] ReportStatus("Quicken opens to Upcoming tab",PASS,"Quicken opens on Bills tab and Get Started button exists")
				[ ] 
			[+] else
				[ ] ReportStatus("Quicken opens to Upcoming tab",FAIL,"Quicken does not open on Bills tab")
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
			[ ] ReportStatus("Naviigate to Preferences",FAIL,"Preference {sStartUp} not selected")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
	[ ] 
[ ] //#######################################################################################################
[ ] 
[ ] 
[ ] 
[ ] 
[ ] 
[ ] // 
[ ] // 
[ ] // 
[ ] // 
[ ] // 
[ ] // 
[ ] // 