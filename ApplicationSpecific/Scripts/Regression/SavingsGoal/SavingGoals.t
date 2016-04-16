[ ] // *********************************************************
[+] // FILE NAME:	<SavingGoals.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Saving Goals test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube	
	[ ] //
	[ ] // Developed on: 		13/06/2012
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 June 13, 2012	Udita Dube  Created
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "C:\automation\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[+] // Global variables
	[ ] public STRING sFileName = "Saving Goal"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public LIST OF ANYTYPE  lsExcelData,lsSavingGoalData,lsSavingGoalData2
	[ ] public STRING sActual,sHandle,sAccount,sWarningMsg,sActualWarningMsg
	[ ] public LIST OF STRING lsAddSavingGoal,lsEditSavingGoal
	[ ] public STRING sSavingGoals = "Saving Goal"
	[ ] public STRING sSavingGoalData = "SavingGoal"
	[ ] public INTEGER iSelect,iNavigate
	[ ] 
[ ] 
[+] //#############  SetUp #######################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 SavingGoalSetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the SavingGoal.QDF if it exists. It will setup the necessary pre-requisite for tests
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs while deleting and creating file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 	  June 20, 2012		Udita Dube	created
	[ ] // ********************************************************
	[ ] 
[-] testcase SetUp () appstate none
	[ ] 
	[ ] INTEGER iSetupAutoAPI,iCreateDataFile
	[ ] STRING sAccountType = "Checking"
	[ ] STRING sAccountName = "SavingGoalChecking"
	[ ] STRING sAccountBalance = "1000"
	[ ] STRING sCurrentDate
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
	[+] else
		[ ] QuickenWindow.Start (sCmdLine)
		[ ] 
	[ ] 
	[+] if(FileExists(sTestCaseStatusFile))
		[ ] DeleteFile(sTestCaseStatusFile)
	[ ] 
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] //SkipRegistration
	[ ] SkipRegistration()
	[ ] // Create Data File
	[ ] iCreateDataFile = DataFileCreate(sFileName)
	[ ] // Report Staus If Data file Created successfully
	[-] if ( iCreateDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
		[ ] Sleep(3)
		[ ] //Verify Get Started and Create manual Checking account - Added 20 May 2014 By Jayashree Nagaraja
		[ ] //Navigate to Planning -> Saving Goals
		[-] if (LowScreenResolution.Exists())
			[ ] LowScreenResolution.Dontshowthisagain.Check()
			[ ] LowScreenResolution.OK.Click()
			[ ] Sleep(3)
			[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window was closed")
		[-] else
			[ ] ReportStatus("Verify Low Screen Resolution Window Appears", PASS, "Low Screen Resolution window did not appear")
			[ ] 
		[ ] iNavigate=NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
		[-] if (GetStartedBrowserWindow.Exists())
			[ ] ReportStatus("Verify Get Started Page", PASS, "Get Started Page is available on Savings Goals Tab")
			[ ] GetStartedBrowserWindow.GetStarted.DomClick()
			[ ] 
			[+] if(AddAnyAccount.Exists(SHORT_SLEEP))
				[ ] AddAnyAccount.SetActive()
				[ ] AddAnyAccount.Cancel.Click()
				[ ] ReportStatus("Verify Add Account Page", PASS, "Get Started Page is prompting to add an account")
				[ ] 
				[ ] //Navigate to Home Tab
				[ ] iNavigate=NavigateQuickenTab(sTAB_HOME)
				[+] if (QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Exists())
					[ ] ReportStatus("Validate if  Account Bar is expanded", PASS, "Account Bar is expanded")
				[+] else
					[ ] QuickenMainWindow.QWNavigator.AccountExpand.Click()
				[ ] sCurrentDate = FormatDateTime(GetDateTime(), "mm/dd/yyyy")
				[ ] iSelect = AddManualSpendingAccount(sAccountType, sAccountName, sAccountBalance, sCurrentDate)
				[+] if (iSelect == PASS)
					[ ] ReportStatus("Validate Account Creation ", PASS, "Checking Account -  {sAccountName} is created")
					[ ] 
					[ ] //Verify Saving Goal Window
					[ ] iNavigate=NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
					[ ] sleep (3)
					[ ] GetStartedBrowserWindow.GetStarted.DomClick()
					[+] if(AddEditSavingsGoal.Exists(SHORT_SLEEP))
						[ ] AddEditSavingsGoal.SetActive ()
						[ ] AddEditSavingsGoal.Cancel.Click()
						[ ] ReportStatus("Verify Add Saving Goal Window", PASS, "Get Started Page is prompting to add a Saving Goal")
					[+] else
						[ ] ReportStatus("Verify Add Saving Goal Window", FAIL, "Get Started Page is not prompting to add a Saving Goal")
				[+] else
					[ ] ReportStatus("Validate Account Creation ", FAIL, "Checking Account -  {sAccountName} is not created")
			[+] else
				[ ] ReportStatus("Verify Add Account Page", FAIL, "Get Started Page is not prompting to add an account")
		[+] else
			[ ] ReportStatus("Verify Get Started Page", FAIL, "Get Started Page is not available on Savings Goals Tab")
	[+] else
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is not created")
	[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //########## View Saving Goal  #################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test_ViewSavingGoalTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify that a View is displayed under Planning tab that contains the Savings Goal
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  12 Jun, 2012  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test1_ViewSavingGoalTab() appstate none
	[+] // Variable declaration
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Navigate to Planning > Saving Goals
		[ ] iNavigate=NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
		[ ] ReportStatus("Navigate to {sTAB_PLANNING} > {sTAB_SAVING_GOALS} ", iNavigate, "Navigate to {sTAB_PLANNING} > {sTAB_SAVING_GOALS}") 
		[ ] 
		[ ] // Report Status if saving goal sub tab is available under planning tab
		[+] if(QuickenMainWindow.QWNavigator.SavingsGoals.Exists())
			[ ] ReportStatus("View Saving Goal from Planning Menu", PASS, "Savings Goal window is available under planning Tab")
		[+] else
			[ ] ReportStatus("View Saving Goal from Planning Menu", FAIL, "Savings Goal window is not available under planning Tab")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##########################################################################
[ ] 
[+] //########## View Saving Goal Menu  ############################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test2_ViewSavingGoalMenu()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify that an option for Savings Goal is displayed in Planning menu options on Classic Menu
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  27 Jun, 2012  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test2_ViewSavingGoalMenu() appstate none
	[+] // Variable declaration
		[ ] INTEGER iMode
		[ ] Boolean bPlanningMenuExist
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] // Select Classic menu
		[ ] iMode = SetViewMode(VIEW_CLASSIC_MENU)		
		[ ] ReportStatus("Set View to Classic View", iMode, "Classic menu select")
		[ ] 
		[ ] // checking menu items are present or not as classic menu is selected
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Planning.Click()
		[ ] 
		[ ] bPlanningMenuExist = QuickenWindow.Planning.SavingsGoals.Exists()
		[+] if (bPlanningMenuExist == TRUE)
			[ ] ReportStatus("Validate Saving Goal menu availability", PASS, "Saving Goal menu is displayed")
		[+] else
			[ ] ReportStatus("Validate Saving Goal menu availability", FAIL, "Saving Goal menu is displayed")
			[ ] 
		[ ] 
		[ ] // Report Status if saving goal window is available 
		[ ] 
		[ ] QuickenWindow.Planning.SavingsGoals.Select()
		[+] if(QuickenMainWindow.QWNavigator.SavingsGoals.Exists())
			[ ] ReportStatus("View Saving Goal from Planning Menu", PASS, "Saving Goal Tab  is available")
			[ ] 
		[+] else
			[ ] ReportStatus("View Saving Goal from Planning Menu", FAIL, "Saving Goal Tab  is not  available")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //########## VerifyZeroDataState Saving Goal  ######################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test3_VerifyZeroDataStateSavingGoal()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify that new Savings Goal cannot be added on clicking Cancel button on Create New Savings Goal window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  12 Jun, 2012  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test3_VerifyZeroDataStateSavingGoal() appstate none
	[+] // Variable declaration
		[ ] INTEGER iSwitchState,iResult
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsSavingGoalData=lsExcelData[2]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
			[ ] // Navigate to Planning > Saving Goals
			[ ] iResult = NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
			[+] if(iResult==PASS)
				[ ] iSwitchState = UsePopupRegister("OFF")	
				[+] if(iSwitchState == PASS)
					[ ] 
					[ ] //########Activate Planning#################//
					[+] if(GetStartedBrowserWindow.GetStarted.Exists(5))
						[ ] //########Click Get Started Button on Saving Goals Snapshot#################//
						[ ] GetStartedBrowserWindow.GetStarted.DomClick()
						[+] if(AddEditSavingsGoal.Exists(SHORT_SLEEP))
							[ ] AddEditSavingsGoal.SetActive ()
							[ ] AddEditSavingsGoal.Cancel.Click()
							[ ] ReportStatus("Verify Add Saving Goal Window", PASS, "New Savings Goal cannot be added on clicking Cancel button on Create New Savings Goal window")
							[ ] sleep(2)
							[+] if(QuickenMainWindow.Exists())
								[ ] sAccount = lsSavingGoalData[1]
								[+] if(!QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer6.ListBox.Exists(5))
									[ ] ReportStatus("Validate Saving Goal in Account Bar", PASS, "{lsSavingGoalData[1]} is not available in Account bar")
								[+] else
									[ ] ReportStatus("Validate Saving Goal in Account Bar", FAIL, "{lsSavingGoalData[1]} is available in Account bar")
							[+] else
								[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
						[+] else
							[ ] ReportStatus("Verify Add Saving Goal Window", FAIL, " Add Saving Goal Window is not displayed")
					[ ] 
					[+] else
						[ ] ReportStatus("Validate Get Started Browser Window", FAIL, "Get Started Browser Window is not available")
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Create New Savings Goal Window ", FAIL, "Create New Savings Goal window is not opened")
					[ ] 
			[+] else
				[ ] ReportStatus("Verification of navigation to Planning > Saving Goals", FAIL, "Saving Goals tab is not opened")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //########## Add Saving Goal  ###################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test4_AddSavingGoal()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add a saving goal
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  12 Jun, 2012  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test4_AddSavingGoal() appstate none
	[+] // Variable declaration
		[ ] INTEGER iAddSavingGoal
		[ ] 
	[+] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
		[ ] // Fetch 2nd row from the given sheet
		[ ] lsSavingGoalData=lsExcelData[1]
	[ ] 
	[+] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] // Add Saving Goal
		[ ] iAddSavingGoal=AddSavingGoal(lsSavingGoalData[1],lsSavingGoalData[2])
		[ ] 
		[ ] // Report Status if saving goal is added
		[+] if (iAddSavingGoal==PASS)
			[ ] NavigateQuickenTab(sTAB_HOME)
			[ ] //------------------Select the Savings Goals Account------------------
			[ ] sAccount = lsSavingGoalData[1]
			[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_SAVINGGOALS)
			[+] if(iSelect == PASS)
				[ ] ReportStatus("Validate Saving Goal in Account Bar", PASS, "{lsSavingGoalData[1]} is available in Account bar")
			[+] else
				[ ] ReportStatus("Validate Saving Goal in Account Bar", FAIL, "{lsSavingGoalData[1]} is not available in Account bar")
		[+] else
			[ ] ReportStatus("Add  Saving Goal", iAddSavingGoal, "Saving Goal-  {lsSavingGoalData[1]}  is not Added")
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Cancel Add Saving Goal  #############################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test5_CancelAddSavingGoal()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify that new Savings Goal cannot be added from on clicking Cancel button on Create New Savings Goal window
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  12 Jun, 2012  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test5_CancelAddSavingGoal() appstate none
	[+] // Variable declaration
		[ ] INTEGER iSwitchState,iResult
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsSavingGoalData=lsExcelData[2]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] iSelect = DeleteSavingGoalFromAccountBar()
		[+] if(iSelect==PASS)
			[ ] iSwitchState = UsePopupRegister("OFF")	
			[+] if(iSwitchState == PASS)
				[ ] 
				[ ] //########Acttivate Planning#################//
				[+] if(GetStartedBrowserWindow.GetStarted.Exists(5))
					[ ] //########Click Get Started Button on Saving Goals Snapshot#################//
					[ ] GetStartedBrowserWindow.GetStarted.DoubleClick()
					[ ] sleep(2)
					[ ] // Create new Saving Goal window should open
					[+] if(AddEditSavingsGoal.Exists(SHORT_SLEEP))
						[ ] AddEditSavingsGoal.SetActive ()
						[ ] // Enter test data in all fields
						[ ] AddEditSavingsGoal.GoalName.SetText(lsSavingGoalData[1])
						[ ] AddEditSavingsGoal.GoalAmount.SetText(lsSavingGoalData[2])
						[ ] //Cancel Add Savings Goals
						[ ] AddEditSavingsGoal.Cancel.Click()
						[+] if(QuickenMainWindow.Exists())
							[ ] sAccount = lsSavingGoalData[1]
							[+] if(!QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer6.ListBox.Exists(5))
								[ ] ReportStatus("Validate Saving Goal in Account Bar", PASS, "{lsSavingGoalData[1]} is not available in Account bar")
							[+] else
								[ ] ReportStatus("Validate Saving Goal in Account Bar", FAIL, "{lsSavingGoalData[1]} is available in Account bar")
						[+] else
							[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
					[+] else
						[ ] ReportStatus("Verification of Add Savings Goals Window", FAIL, "Add Savings Goals Window is not available")
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Get Started Browser Window", FAIL, "Get Started Browser Window is not available")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Create New Savings Goal Window ", FAIL, "Create New Savings Goal window is not opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Verification of navigation to Planning > Saving Goals", FAIL, "Saving Goals tab is not opened")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Cancel Edit Saving Goal  #############################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test6_CancelEditSavingGoal()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify that edited Saving Goal changes are not saved on clicking Cancel button on Edit Savings Goal window.
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  27 Jun, 2012  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test6_CancelEditSavingGoal() appstate none
	[+] // Variable declaration
		[ ] STRING sGoalAmount,sActualAmount,sActualFinishDate
		[ ] BOOLEAN bMatch
		[ ] STRING sCurrentDate, sNewDate, sEnteredDate
		[ ] INTEGER iCurrentDay, iCurrentMonth, iCurrentYear, iNewYear, iDay, iMonth, iYear
		[ ] DATETIME dtNewerDate, dtEnteredDate
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsSavingGoalData=lsExcelData[2]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] //QuickenMainWindow.SetActive()
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
			[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
			[ ] // Click on Edit Goal link
			[ ] Planning.PlanningSubTab.Panel.SavingsGoals.Panel.EditGoal.Click()
			[ ] // Edit Savings Goal window should open
			[+] if(AddEditSavingsGoal.Exists())
				[ ] AddEditSavingsGoal.SetActive ()
				[ ] // Form New date from current date
				[ ] sCurrentDate = FormatDateTime(GetDateTime(), "mm/dd/yyyy")
				[ ] iCurrentDay = Val(Substr (sCurrentDate, 4,2) )
				[ ] iCurrentMonth = Val(Substr (sCurrentDate, 1, 2) )
				[ ] iCurrentYear = Val(Substr (sCurrentDate, 7,4) )
				[ ] iNewYear = iCurrentYear + 2
				[ ] //Format today's date with which saving goal is added.
				[ ] iYear = iCurrentYear + 1
				[ ] dtEnteredDate = MakeDateTime(iYear, iCurrentMonth, iCurrentDay)
				[ ] sEnteredDate = FormatDateTime(dtEnteredDate, "mmm d yyyy")
				[ ] //Format future date to enter into Edit Goal dialog
				[ ] dtNewerDate = MakeDateTime(iNewYear, iCurrentMonth, iCurrentDay)
				[ ] sNewDate = FormatDateTime(dtNewerDate, "mm/dd/yyyy")
				[ ] // Enter test data in all fields
				[ ] // CreateNewSavingsGoal.GoalName.SetText(sGoalName)
				[ ] AddEditSavingsGoal.GoalAmount.SetText(lsSavingGoalData[2])
				[ ] AddEditSavingsGoal.FinishDate.SetText(sNewDate)
				[ ] sleep(3)
				[ ] AddEditSavingsGoal.Cancel.Click()
				[+] if(QuickenMainWindow.Exists())
					[ ] // Get Actual goal amount after edit operation
					[ ] sActualAmount=Planning.PlanningSubTab.Panel.SetupScreenHolder.Panel1.GoalAmount.GetText()
					[ ] sActualAmount = StrTran (sActualAmount, ",", "")
					[ ] // Making expected goal amount in formate of 00.00 or 000.00
					[ ] sGoalAmount=GetField (lsExcelData[1][2], ".", 1)
					[ ] sGoalAmount="{sGoalAmount}.00"
					[ ] // Matching expected with actual goal amount
					[ ] bMatch=MatchStr("${sGoalAmount}*",sActualAmount)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Validate cancellation of edit Goal amount", PASS, "{sActualAmount} is displayed as Goal amount is not edited") 
					[+] else
						[ ] ReportStatus("Validate cancellation of edit Goal amount", FAIL, "Expected Goal Amount - {sGoalAmount}  and Actual Goal Amount - {sActualAmount}") 
					[ ] 
					[ ] // Get Actual goal finish date after edit operation
					[ ] sActualFinishDate=Planning.PlanningSubTab.Panel.SetupScreenHolder.Panel1.FinishDate.GetText()
					[ ] bMatch = MatchStr("by {sEnteredDate}*", sActualFinishDate)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Validate cancellation of edit Finish Date", PASS, "{sEnteredDate} is displayed as Goal Finish Date and is not edited") 
					[+] else
						[ ] ReportStatus("Validate cancellation of edit Finish Date", FAIL, "Expected Finish Date - {sEnteredDate}  and Actual Finish Date - {sActualFinishDate}") 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Edit Savings Goal Window ", FAIL, "Edit Savings Goal window is not opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Validate if Saving Goal Pre Req is met", FAIL, "Savings Goal Pre Req is not successful")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Edit Saving Goal  ###################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test_EditSavingGoal()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will edit first saving goal
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  12 Jun, 2012  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test7_EditSavingGoal() appstate none
	[+] // Variable declaration
		[ ] INTEGER iEditSavingGoal
		[ ] STRING sCurrentDate, sNewDate
		[ ] INTEGER iCurrentDay, iCurrentMonth, iCurrentYear, iNewYear
		[ ] DATETIME dtNewerDate
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsSavingGoalData2=lsExcelData[2]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] //QuickenMainWindow.SetActive()
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
				[ ] // Form New date from current date
				[ ] sCurrentDate = FormatDateTime(GetDateTime(), "mm/dd/yyyy")
				[ ] iCurrentDay = Val(Substr (sCurrentDate, 4,2) )
				[ ] iCurrentMonth = Val(Substr (sCurrentDate, 1, 2) )
				[ ] iCurrentYear = Val(Substr (sCurrentDate, 7,4) )
				[ ] iNewYear = iCurrentYear + 2
				[ ] dtNewerDate = MakeDateTime(iNewYear, iCurrentMonth, iCurrentDay)
				[ ] sNewDate = FormatDateTime(dtNewerDate, "mm/dd/yyyy")
				[ ] 
				[ ] iEditSavingGoal=EditSavingGoal(lsSavingGoalData2[1],lsSavingGoalData2[2],sNewDate)
				[ ] // Report Status if saving goal is edited
				[+] if (iEditSavingGoal==PASS)
					[ ] ReportStatus("Edit Saving Goal", iEditSavingGoal, "Saving Goal -  {lsSavingGoalData2[1]} can be edited")
					[ ] MDIClient.Planning.PlanningSubTab.Panel.SetupScreenHolder.Panel1.SavingGoal.Click()
				[+] else
					[ ] ReportStatus("Edit Saving Goal", iEditSavingGoal, "Saving Goal-  {lsSavingGoalData2[1]}  cannot be edited")
		[+] else
			[ ] ReportStatus("Validate if Saving Goal Pre Req is met", FAIL, "Savings Goal Pre Req is not successful")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Delete Saving Goal  #################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test8_DeleteSavingGoal()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the first saving goal
		[ ] // 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  13 Jun, 2012  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test8_DeleteSavingGoal() appstate none
	[+] // Variable declaration
		[ ] INTEGER iDeleteSavingGoal
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsSavingGoalData=lsExcelData[2]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] //QuickenMainWindow.SetActive()
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
			[ ] // Delete Saving Goals
			[ ] iDeleteSavingGoal=DeleteSavingGoal(lsSavingGoalData[1])
			[ ] // Report Status if checking Account is created
			[+] if (iDeleteSavingGoal==PASS)
				[ ] ReportStatus("Delete Saving Goal", iDeleteSavingGoal, "Saving Goal -  {lsSavingGoalData[1]}  is deleted successfully")
			[+] else
				[ ] ReportStatus("Delete Saving Goal", iDeleteSavingGoal, "Saving Goal-  {lsSavingGoalData[1]}  is not deleted")
		[+] else
			[ ] ReportStatus("Validate if Saving Goal Pre Req is met", FAIL, "Savings Goal Pre Req is not successful")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Add Saving Goal from Goal Actions #####################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test9_AddSavingGoalFromGoalAction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add a saving goal
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  12 Jun, 2012  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test9_AddSavingGoalFromGoalAction() appstate none
	[+] // Variable declaration
		[ ] INTEGER iAddSavingGoal
		[ ] 
	[+] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
		[ ] // Fetch 2nd row from the given sheet
		[ ] lsSavingGoalData=lsExcelData[1]
		[ ] lsSavingGoalData2=lsExcelData[2]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] //QuickenMainWindow.SetActive()
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
			[ ] //Navigate to Savings Goals Tab and Add Saving Goal
			[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
			[ ] Planning.PlanningSubTab.Panel.GoalActions.Click()
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_DN, 1)) 
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
			[+] if(AddEditSavingsGoal.Exists())
				[ ] AddEditSavingsGoal.SetActive ()
				[ ] // Enter test data in all fields
				[ ] AddEditSavingsGoal.GoalAmount.SetText(lsSavingGoalData2[2])
				[ ] AddEditSavingsGoal.GoalName.SetText(lsSavingGoalData2[1])
				[ ] //AddEditSavingsGoal.FinishDate.SetText(lsSavingGoalData2[3])
				[ ] AddEditSavingsGoal.OK.Click()
				[ ] sAccount = lsSavingGoalData2[1]
				[ ] sleep (3)
				[ ] MDIClient.Planning.PlanningSubTab.Panel.SetupScreenHolder.Panel1.SavingGoal.Click()
				[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_SAVINGGOALS)
				[+] if(iSelect == PASS)
						[ ] ReportStatus("Validate Saving Goal in Account Bar", PASS, "{lsSavingGoalData2[1]} is available in Account bar")
						[ ] 
				[+] else
						[ ] ReportStatus("Validate Saving Goal in Account Bar", FAIL, "{lsSavingGoalData2[1]} is not available in Account bar")
						[ ] 
			[+] else
				[ ] ReportStatus("Add  Saving Goal", iAddSavingGoal, "Saving Goal-  {lsSavingGoalData2[1]}  is not Added")
				[ ] 
		[+] else
			[ ] ReportStatus("Validate if Saving Goal Pre Req is met", FAIL, "Savings Goal Pre Req is not successful")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Verify Warning Message on Add Savings Goal Screen  #####################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test3_AddSavingGoal()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add a saving goal
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  12 Jun, 2012  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test_10VerifyWarningMsgOnAddSavingsGoalScreen() appstate none
	[+] // Variable declaration
		[ ] INTEGER iAddSavingGoal
		[ ] boolean bMatch
		[ ] SetUp_AutoApi()
	[+] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
		[ ] // Fetch 2nd row from the given sheet
		[ ] lsSavingGoalData=lsExcelData[1]
		[ ] lsSavingGoalData2=lsExcelData[2]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] //QuickenMainWindow.SetActive()
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
			[ ] //Navigate to Savings Goals Tab and Add Saving Goal
			[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
			[ ] Planning.PlanningSubTab.Panel.GoalActions.Click()
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_DN, 1)) 
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
			[+] if(AddEditSavingsGoal.Exists())
				[ ] AddEditSavingsGoal.SetActive ()
				[ ] // Enter test data in all fields
				[ ] AddEditSavingsGoal.GoalAmount.SetText(sSavingGoalData[2])
				[ ] AddEditSavingsGoal.OK.Click()
				[+] if(AlertMessage.Exists())
					[ ] sWarningMsg = "This field may not be left blank."
					[ ] sActualWarningMsg = AlertMessage.MessageText.GetText()
					[ ] bMatch = MatchStr(sWarningMsg,sActualWarningMsg)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Warning Message", PASS, "Warning Message is present for not providing Savings Goals Name")
						[ ] AlertMessage.OK.Click()
						[ ] //AlertMessage.Close()
						[ ] AddEditSavingsGoal.Cancel.Click()
						[ ] sAccount = lsSavingGoalData2[1]
						[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_SAVINGGOALS)
						[+] if(iSelect == FAIL)
								[ ] ReportStatus("Validate Saving Goal in Account Bar", PASS, "{lsSavingGoalData2[1]} is not available in Account bar")
						[+] else
								[ ] ReportStatus("Validate Saving Goal in Account Bar", FAIL, "{lsSavingGoalData2[1]} is  available in Account bar")
					[+] else
						[ ] ReportStatus("Validate Warning Message", FAIL, "Warning Message is present for not providing Savings Goals Name")
					[ ] 
				[+] else
						[ ] ReportStatus("Validate Add Savings Goal Window", FAIL, "Add Savings Goal Window is not present")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Add Savings Goal Window", FAIL, "Add Savings Goal Window is not present")
		[+] else
			[ ] ReportStatus("Validate if Saving Goal Pre Req is met", FAIL, "Savings Goal Pre Req is not successful")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Verify Warning Message on Add Savings Goal Screen  #######################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test3_AddSavingGoal()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add a saving goal
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  12 Jun, 2012  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test_11VerifySavingsGoalNameLength() appstate none
	[+] // Variable declaration
		[ ] INTEGER iAddSavingGoal
		[ ] INTEGER iDeleteSavingGoal
		[ ] boolean bMatch
		[ ] STRING sCurrentDate
		[ ] STRING sSavingGoalName40Char = "abcdeabcdeabcdeabcdeabcdeabcdeabcdeabcde"
		[ ] STRING sSavingGoalName44Char = "abcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdezxzx"
		[ ] LIST OF STRING lsSavingGoal
		[ ] SetUp_AutoApi()
	[+] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
		[ ] // Fetch 2nd row from the given sheet
		[ ] lsSavingGoalData=lsExcelData[1]
		[ ] lsSavingGoalData2=lsExcelData[2]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
			[ ] //Navigate to Savings Goals Tab and Add Saving Goal
			[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
			[ ] Planning.PlanningSubTab.Panel.GoalActions.Click()
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_DN, 1)) 
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
			[+] if(AddEditSavingsGoal.Exists())
				[ ] AddEditSavingsGoal.SetActive ()
				[ ] // Enter test data in all fields
				[ ] AddEditSavingsGoal.GoalAmount.SetText(lsSavingGoalData2[2])
				[ ] AddEditSavingsGoal.GoalName.SetText(sSavingGoalName44Char)
				[ ] //AddEditSavingsGoal.FinishDate.SetText(sCurrentDate)
				[ ] AddEditSavingsGoal.OK.Click()
				[ ] sleep(3)
				[ ] sAccount = sSavingGoalName40Char
				[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_SAVINGGOALS)
				[+] if(iSelect == PASS)
					[ ] ReportStatus("Validate Saving Goal in Account Bar", PASS, "{sSavingGoalName40Char} is  available in Account bar with 40 Characters")
					[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
					[ ] 
					[ ] // Delete Saving Goals
					[ ] MDIClient.Planning.PlanningSubTab.Panel.SetupScreenHolder.Panel1.DeleteIcon.Click()
					[ ] sleep(SHORT_SLEEP)
					[ ] MDIClient.Planning.PlanningSubTab.Panel.SetupScreenHolder.Panel1.DeleteIcon.TypeKeys(Replicate(KEY_DN, 2)) 
					[ ] MDIClient.Planning.PlanningSubTab.Panel.SetupScreenHolder.Panel1.DeleteIcon.TypeKeys(KEY_ENTER)
					[ ] 
					[+] if(DeleteSavingsGoal.Exists(SHORT_SLEEP))
						[ ] DeleteSavingsGoal.SetActive ()
						[ ] // Enter test data in all fields
						[ ] DeleteSavingsGoal.OK.Click()
						[ ] ReportStatus("Delete Saving Goal", PASS, "Saving Goal -  {lsSavingGoalData[1]}  is deleted successfully")
					[+] else
						[ ] ReportStatus("Delete Saving Goal", FAIL, "Delete Saving Goal Window did not open")
						[ ] 
					[ ] integer i = Len(Planning.PlanningSubTab.Panel.SavingsGoals.Panel.SmokeSavingGoal.getCaption())
					[+] if (i == 40)
						[ ] ReportStatus("Saving Goal Name Lengh", PASS, "Saving Goal lenght is {i} ")
					[+] else
						[ ] ReportStatus("Saving Goal Name Lengh", FAIL, "Saving Goal lenght is greater than length of 40 and is {i} ")
						[ ] 
				[+] else
						[ ] ReportStatus("Validate Saving Goal in Account Bar", FAIL, "{sSavingGoalName40Char} is  not available in Account bar")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Add Savings Goal Window", FAIL, "Add Savings Goal Window is not present")
		[+] else
			[ ] ReportStatus("Validate if Saving Goal Pre Req is met", FAIL, "Savings Goal Pre Req is not successful")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Verify Finish Date Field Accepts Only Future Date ###########################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test12_FinishDateFieldAcceptsOnlyFutureDate()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify if the Finish Date field accepts only future date
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  24 Apr, 2014  Jayashree Nagaraja created
	[ ] //*********************************************************
[+] testcase Test_12VerifyFinishDateFieldAcceptsOnlyFutureDate() appstate none
	[+] // Variable declaration
		[ ] INTEGER iAddSavingGoal
		[ ] SetUp_AutoApi()
		[ ] STRING sCurrentDate, sPreviousDate
		[ ] BOOLEAN bMatch
		[ ] INTEGER iCurrentDay, iCurrentMonth, iCurrentYear, iPreviousYear
		[ ] DATETIME dtOlderDate
	[ ] 
	[+] // //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
		[ ] // // Fetch 2nd row from the given sheet
		[ ] lsSavingGoalData=lsExcelData[1]
		[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
			[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
			[ ] Planning.PlanningSubTab.Panel.GoalActions.Click()
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_DN, 1)) 
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
			[+] if(AddEditSavingsGoal.Exists())
				[ ] AddEditSavingsGoal.SetActive ()
				[ ] sCurrentDate = FormatDateTime(GetDateTime(), "mm/dd/yyyy")
				[ ] //Form Older date from current date
				[ ] iCurrentDay = Val(Substr (sCurrentDate, 4,2) )
				[ ] iCurrentMonth = Val(Substr (sCurrentDate, 1, 2) )
				[ ] iCurrentYear = Val(Substr (sCurrentDate, 7,4) )
				[ ] iPreviousYear = iCurrentYear - 1
				[ ] dtOlderDate = MakeDateTime(iPreviousYear, iCurrentMonth, iCurrentDay)
				[ ] sPreviousDate = FormatDateTime(dtOlderDate, "mm/dd/yyyy")
				[ ] //Enter test data in all fields
				[ ] AddEditSavingsGoal.GoalAmount.SetText(lsSavingGoalData[2])
				[ ] AddEditSavingsGoal.GoalName.SetText("Goal2")
				[ ] AddEditSavingsGoal.FinishDate.SetText(sPreviousDate)
				[ ] sleep(2)
				[ ] AddEditSavingsGoal.OK.Click()
				[ ] //Check if the Finish Date Warning window appears
				[+] if(FinishDateWarning.Exists())
					[ ] sWarningMsg = "Finish date must be after the start date."
					[ ] sActualWarningMsg = FinishDateWarning.FinishDateWarningText.GetText()
					[ ] bMatch = MatchStr(sWarningMsg,sActualWarningMsg)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus ("Validate if FinishDate Warning Dialog appears", PASS, "FinishDate Warning Window appears and shows appropriate message")
						[ ] FinishDateWarning.OK.Click()
						[ ] AddEditSavingsGoal.Cancel.Click()
					[+] else
							[ ] ReportStatus ("Validate FinishDate Warning Dialog appears", FAIL, "FinishDate Warning Window appears but does not show appropriate message")
				[+] else
					[ ] ReportStatus ("Validate if FinishDate Warning Dialog appears", FAIL, "FinishDate Warning Window does not appear")
			[+] else
				[ ] ReportStatus("Validate Add Savings Goal Window", FAIL, "Add Savings Goal Window is not present")
		[+] else
			[ ] ReportStatus("Validate if Saving Goal Pre Req is met", FAIL, "Savings Goal Pre Req is not successful")
	[+] else
			[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Verify if Saving Goal Can Be Deleted From Gear Icon #########################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test13_DeleteSavingGoalFromGearIcon()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify if the Saving goal can be deleted from the gear icon.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  9 May, 2014  Jayashree Nagaraja created
	[ ] //*********************************************************
[+] testcase Test_13DeleteSavingGoalFromGearIcon() appstate none
	[+] // Variable declaration
		[ ] SetUp_AutoApi()
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
			[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
			[ ] //Choose Delete Goal option from gear icon next to the goal name
			[ ] MDIClient.Planning.PlanningSubTab.Panel.SetupScreenHolder.Panel.QC_button2.Click()
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_DN, 2)) 
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
			[+] if (DeleteSavingsGoal.Exists())
				[ ] DeleteSavingsGoal.SetActive()
				[ ] DeleteSavingsGoal.AfterThatWhatShouldQuicke2.Click()
				[ ] DeleteSavingsGoal.OK.Click()
				[ ] sleep(2)
				[ ] //Verify if zero data state page is displayed in saving goal tab
				[+] if(GetStartedBrowserWindow.GetStarted.Exists(3))
					[ ] ReportStatus ("Verify if SavingGoal is deleted", PASS, "SavingGoal deleted succesfully from the gear icon")
				[+] else
					[ ] ReportStatus ("Verify if SavingGoal is deleted", FAIL, "Failed to delete SavingGoal from the gear icon")
			[+] else
				[ ] ReportStatus("Validate Delete Savings Goal Window", FAIL, "Delete Savings Goal Window is not present")
		[+] else
			[ ] ReportStatus("Validate if Saving Goal Pre Req is met", FAIL, "Savings Goal Pre Req is not successful")
	[+] else
			[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Verify if Saving Goal Can Be Deleted And Added As An Asset Account ############
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test14_DeleteSavingGoalAndAddAsAssetAccoun()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify if the Saving goal can be deleted from the gear icon but added as an asset account.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  9 May, 2014  Jayashree Nagaraja created
		[ ] //*********************************************************
	[ ] //*********************************************************
	[ ] 
[+] testcase Test_14DeleteSavingGoalAndAddAsAssetAccount() appstate none
	[+] // Variable declaration
		[ ] SetUp_AutoApi()
		[ ] 
	[+] // //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
		[ ] // // Fetch 2nd row from the given sheet
		[ ] lsSavingGoalData=lsExcelData[1]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
			[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
			[ ] MDIClient.Planning.PlanningSubTab.Panel.SetupScreenHolder.Panel.QC_button2.Click()
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_DN, 2)) 
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
			[+] if (DeleteSavingsGoal.Exists())
				[ ] DeleteSavingsGoal.SetActive()
				[ ] DeleteSavingsGoal.AfterThatWhatShouldQuicke4.Click()
				[ ] DeleteSavingsGoal.OK.Click()
				[ ] sleep(2)
				[+] if(GetStartedBrowserWindow.GetStarted.Exists(3))
					[ ] ReportStatus ("Verify if SavingGoal is deleted", PASS, "SavingGoal deleted succesfully from the SavingGoal tab")
					[ ] sAccount = lsSavingGoalData[1]
					[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_PROPERTYDEBT)
					[+] if(iSelect == PASS)
						[ ] ReportStatus("Validate Saving Goal under Property and Debt in Account Bar", PASS, "{lsSavingGoalData[1]} is available in Account bar under Property and Debt section")
						[ ] iSelect = DeleteAccount(ACCOUNT_PROPERTYDEBT, sAccount)
						[+] if (iSelect == PASS)
							[ ] ReportStatus ("Verify if Property and Debt is deleted", PASS, "Property and Debt account is deleted succesfully from Account bar")
						[+] else
							[ ] ReportStatus ("Verify if Property and Debt is deleted", FAIL, "Property and Debt account is not deleted from Account bar")
					[+] else
						[ ] ReportStatus("Validate Saving Goal under Property and Debt in Account Bar", FAIL, "{lsSavingGoalData[1]} is not available in Account bar under Property and Debt section")
				[+] else
					[ ] ReportStatus ("Verify if SavingGoal is deleted", FAIL, "Failed to delete SavingGoal from the gear icon")
			[+] else
				[ ] ReportStatus("Validate Delete Savings Goal Window", FAIL, "Delete Savings Goal Window is not present")
		[+] else
			[ ] ReportStatus("Validate if Saving Goal Pre Req is met", FAIL, "Savings Goal Pre Req is not successful")
	[+] else
			[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
[ ] //##############################################################################
[ ] 
[+] //########## Verify Saving Goal Is NOT Deleted When Clicked On Cancel Button ############
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test15_CancelDeleteSavingGoal()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify if the Saving goal cannot be deleted from the gear icon when cancel button is clicked.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  9 May, 2014  Jayashree Nagaraja created
	[ ] //*********************************************************
	[ ] 
[-] testcase Test_15CancelDeleteSavingGoal() appstate none
	[+] // Variable declaration
		[ ] SetUp_AutoApi()
		[ ] 
	[+] // //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
		[ ] // // Fetch 2nd row from the given sheet
		[ ] lsSavingGoalData=lsExcelData[1]
	[ ] 
	[-] if(QuickenMainWindow.Exists())
		[ ] iSelect = SavingGoalPreReq()
		[-] if (iSelect == PASS)
			[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
			[ ] MDIClient.Planning.PlanningSubTab.Panel.SetupScreenHolder.Panel.QC_button2.Click()
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_DN, 2)) 
			[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
			[-] if (DeleteSavingsGoal.Exists())
				[ ] DeleteSavingsGoal.SetActive()
				[ ] DeleteSavingsGoal.AfterThatWhatShouldQuicke2.Click()
				[ ] sleep(2)
				[ ] DeleteSavingsGoal.Cancel.Click()
				[ ] //Verify if account is existing in the Account Bar
				[ ] sAccount = lsSavingGoalData[1]
				[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_SAVINGGOALS)
				[-] if(iSelect == PASS)
					[ ] ReportStatus("Validate Saving Goal account in Account Bar", PASS, "{lsSavingGoalData[1]} is available in Account bar after testing for option1")
					[ ] 
					[ ] //Go to Planning -> Savings Goal tab to verify 2nd option
					[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
					[ ] MDIClient.Planning.PlanningSubTab.Panel.SetupScreenHolder.Panel.QC_button2.Click()
					[ ] QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_DN, 2)) 
					[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
					[+] if (DeleteSavingsGoal.Exists())
						[ ] DeleteSavingsGoal.SetActive()
						[ ] DeleteSavingsGoal.AfterThatWhatShouldQuicke4.Click()
						[ ] sleep(2)
						[ ] DeleteSavingsGoal.Cancel.Click()
						[ ] //Verify if account is existing in the Account Bar
						[ ] sAccount = lsSavingGoalData[1]
						[ ] iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_SAVINGGOALS)
						[+] if(iSelect == PASS)
							[ ] ReportStatus("Validate Saving Goal account in Account Bar for option2", PASS, "{lsSavingGoalData[1]} is available in Account bar after testing for option2")
						[+] else
							[ ] ReportStatus("Validate Saving Goal account in Account Bar for option2", FAIL, "{lsSavingGoalData[1]} is not available in Account bar after testing for option2")
					[+] else
						[ ] ReportStatus("Validate Delete Savings Goal Window for option2", FAIL, "Delete Savings Goal Window is not present to test option2")
				[+] else
					[ ] ReportStatus("Validate Saving Goal account in Account Bar for option 1", FAIL, "{lsSavingGoalData[1]} is not available in Account bar after testing for option1")
			[+] else
				[ ] ReportStatus("Validate Delete Savings Goal Window for option1", FAIL, "Delete Savings Goal Window is not present to test option1")
		[+] else
			[ ] ReportStatus("Validate if Saving Goal Pre Req is met", FAIL, "Savings Goal Pre Req is not successful")
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
[ ] //##############################################################################
[ ] 
[+] //#### Verify Current And Ending Balance Menu Option On Account Bar Without Savings Goals###
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test16_CurrentAndEndingBalanceMenuOptionWithoutSavingsGoals()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify if the Current and Ending balance options are available on account bar whenSaving goal is not added.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  13 May, 2014  Jayashree Nagaraja created
	[ ] //*********************************************************
[+] testcase Test_16CurrentAndEndingBalanceMenuOptionWithoutSavingsGoals() appstate none
	[+] //Variable declaration
		[ ] SetUp_AutoApi()
		[ ] STRING sMenuItem
		[ ] 
	[+] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
		[ ] print(lsExcelData)
		[ ] //Fetch 3rd and 4th row from the given sheet
		[ ] lsSavingGoalData=lsExcelData[3]
		[ ] lsSavingGoalData2=lsExcelData[4]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] 
		[ ] //Verify if Saving goal is existing.. Delete if existing
		[ ] iSelect = DeleteSavingGoalFromAccountBar()
		[+] if (iSelect == PASS)
			[ ] //Verify Current Balance menu item
			[ ] sMenuItem = lsSavingGoalData[1]
			[ ] iSelect = VerifyContextMenuItemOnAccountBar(sMenuItem)
			[+] if (iSelect == PASS)
				[ ] ReportStatus("Verify context menu item", PASS, "{sMenuItem} context menu item is available")
			[+] else
				[ ] ReportStatus("Verify context menu item", FAIL, "{sMenuItem} context menu item is not available")
				[ ] 
			[ ] //Verify Ending Balance menu item
			[ ] sMenuItem = lsSavingGoalData2[1]
			[ ] iSelect = VerifyContextMenuItemOnAccountBar(sMenuItem)
			[+] if (iSelect == PASS)
				[ ] ReportStatus("Verify context menu item", PASS, "{sMenuItem} context menu item is available")
			[+] else
				[ ] ReportStatus("Verify context menu item", FAIL, "{sMenuItem} context menu item is not available")
		[+] else
			[ ] ReportStatus("Deletion of Saving Goal", FAIL, "{sAccount} deletion failed")
		[ ] 
		[ ] 
[ ] //##############################################################################
[ ] 
[+] //### Verify Current And Ending Balance Menu Option On Account Bar With Savings Goals######
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test17_CurrentAndEndingBalanceMenuOptionWithSavingsGoals()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify if the Current and Ending balance options are available on account bar after adding Saving goal..
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  10 May, 2014  Jayashree Nagaraja created
	[ ] //*********************************************************
[+] testcase Test_17CurrentAndEndingBalanceMenuOptionWithSavingsGoals() appstate none
	[+] //Variable declaration
		[ ] SetUp_AutoApi()
		[ ] STRING sMenuItem
		[ ] BOOLEAN bSelect
		[ ] 
	[+] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
		[ ] //Fetch 3rd row from the given sheet
		[ ] lsSavingGoalData=lsExcelData[3]
		[ ] lsSavingGoalData2=lsExcelData[4]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] 
		[ ] //Verify if Saving goal is existing.. Delete if existing
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
			[ ] 
			[ ] //Verify Current Balance menu item
			[ ] sMenuItem = lsSavingGoalData[1]
			[ ] 
			[ ] iSelect = VerifyContextMenuItemOnAccountBar(sMenuItem)
			[+] if (iSelect == PASS)
				[ ] ReportStatus("Verify context menu item", PASS, "{sMenuItem} context menu item is available")
				[ ] //Verify if the menu item is Checked
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.Click(2)
				[ ] bSelect = QuickenMainWindow.QWNavigator.CurrentBalance.IsChecked()
				[+] if (bSelect == TRUE)
					[ ] ReportStatus("Verify context menu item is Checked", PASS, "{sMenuItem} context menu item is Checked")
				[+] else
					[ ] ReportStatus("Verify context menu item is Checked", FAIL, "{sMenuItem} context menu item is not Checked")
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.Click(1,26,285)
			[+] else
				[ ] ReportStatus("Verify context menu item", FAIL, "{sMenuItem} context menu item is not available")
				[ ] 
			[ ] //Verify Ending Balance menu item
			[ ] sMenuItem = lsSavingGoalData2[1]
			[ ] iSelect = VerifyContextMenuItemOnAccountBar(sMenuItem)
			[+] if (iSelect == PASS)
				[ ] ReportStatus("Verify context menu item", PASS, "{sMenuItem} context menu item is available")
				[ ] //Verify if the menu item is Checked
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.Click(2)
				[ ] bSelect = QuickenMainWindow.QWNavigator.EndingBalance.IsChecked()
				[+] if (bSelect == TRUE)
					[ ] ReportStatus("Verify context menu item is Checked", FAIL, "{sMenuItem} context menu item is Checked")
				[+] else
					[ ] ReportStatus("Verify context menu item is Checked", PASS, "{sMenuItem} context menu item is not Checked")
				[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.Click(1,26,285)
			[+] else
				[ ] ReportStatus("Verify context menu item", FAIL, "{sMenuItem} context menu item is not available")
		[+] else
			[ ] ReportStatus("Deletion of Saving Goal", FAIL, "{sAccount} deletion failed")
		[ ] 
		[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Verify Contribution To Savings Goals######################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test18_VerifyContributionToSavingsGoals()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will contribute to the savings goals and verify the balances of Saving Goal and Checking Account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  17 May, 2014  Jayashree Nagaraja created
	[ ] //*********************************************************
[+] testcase Test_18VerifyContributionToSavingsGoals() appstate none
	[+] //Variable declaration
		[ ] SetUp_AutoApi()
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] 
		[ ] //Verify if Saving goal is existing.. Delete if existing
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
			[ ] //Contribute function
			[ ] iSelect = ContributeToSavingGoal()
			[+] if (iSelect == PASS)
				[ ] ReportStatus("Verify Saving Goal Contribution and Verification", PASS, "Saving Goal Contribution and Verification are successful")
			[+] else
				[ ] ReportStatus("Verify Saving Goal Contribution and Verification", FAIL, "Saving Goal Contribution and Verification failed")
		[+] else
			[ ] ReportStatus("Verify Saving Goal Pre Req is Successful", FAIL, "Saving Goal Pre Req is unsuccessful")
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
[ ] //##############################################################################
[ ] 
[+] //########## Verify Withdrawal From Savings Goals#####################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test19_VerifyWithdrawalFromSavingsGoals()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will withdraw funds from the savings goals and verify the balances of Saving goal and Checking Account
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  19 May, 2014  Jayashree Nagaraja created
	[ ] //*********************************************************
[+] testcase Test_19VerifyWithdrawalFromSavingsGoals() appstate none
	[+] // Variable declaration
		[ ] Setup_AutoApi()
		[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] //Verify if Saving goal is existing.. Delete if existing
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
			[ ] //Withdraw function
			[ ] iSelect = WithdrawFromSavingGoal()
			[+] if (iSelect == PASS)
				[ ] ReportStatus("Verify Saving Goal Withdrawal and Verification", PASS, "Saving Goal Withdrawal and Verification are successful")
			[+] else
				[ ] ReportStatus("Verify Saving Goal Withdrawal and Verification", FAIL, "Saving Goal Withdrawal and Verification failed")
		[+] else
			[ ] ReportStatus("Verify Saving Goal Pre Req is Successful", FAIL, "Saving Goal Pre Req is unsuccessful")
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
		[ ] 
[ ] //###############################################################################
[ ] 
[+] //########## Verify Savings Goals Shows GetStarted Page################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test20_VerifySavingsGoalsShowsGetStartedPage()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete all the savings goals and verifies if GetStarted Page is shown on Savings Goal Tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  20 May, 2014  Jayashree Nagaraja created
	[ ] //*********************************************************
[+] testcase Test_20VerifySavingsGoalsShowsGetStartedPage() appstate none
	[+] // Variable declaration
		[ ] Setup_AutoApi()
		[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] //Verify if Saving goal is existing.. Delete if existing
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
			[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
			[ ] //Verify if Saving goal is existing.. Delete if existing
			[ ] iSelect = DeleteSavingGoalFromAccountBar()
			[+] if (iSelect == PASS)
				[+] if (GetStartedBrowserWindow.Exists())
					[ ] ReportStatus("Verify Get Started Page", PASS, "Get Started Page is available on Savings Goals Tab")
				[+] else
					[ ] ReportStatus("Verify Get Started Page", FAIL, "Get Started Page is not available on Savings Goals Tab")
			[+] else
				[ ] ReportStatus("Verify Saving Goal Deletion", FAIL, "All saving goals deletion successful")
		[+] else
			[ ] ReportStatus("Verify Saving Goal Pre Req is Successful", FAIL, "Saving Goal Pre Req is unsuccessful")
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
[ ] //################################################################################
[ ] 
[+] //########## Verify SavingsGoalsTransactionsInRegisterAndReports#########################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test21_VerifyDeletingSavingsGoalsShowsGetStartedPage()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete all the saving goal and verifies if Get Started Page is shown
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 	If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  20 May, 2014  Jayashree Nagaraja created
	[ ] //*********************************************************
[+] testcase Test_21VerifySavingsGoalsTransactionsInRegisterAndReports() appstate none
	[+] // Variable declaration
		[ ] Setup_AutoApi()
		[ ] STRING sAccount = "SavingGoalChecking", sMenuItem, sGoalActionsMenuItem, sAccountActionsMenuItem
		[ ] BOOLEAN bMatch
	[ ] 
	[+] //Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sSavingGoalData, sSavingGoals)
		[ ] //Fetch 5th row from the given sheet
		[ ] lsSavingGoalData=lsExcelData[5]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] //Verify if Saving goal is existing.. Delete if existing
		[ ] iSelect = SavingGoalPreReq()
		[+] if (iSelect == PASS)
			[ ] //Verify Savings Goal Register and Reports menu item in Account Bar
			[ ] sMenuItem = lsSavingGoalData[1]
			[ ] iSelect = VerifyContextMenuItemOnAccountBar(sMenuItem)
			[+] if (iSelect == PASS)
				[ ] ReportStatus("Verify SavingsGoal context menu on Account Bar", PASS, "SavingsGoal context menu is avaiable on Account Bar")
				[ ] 
				[ ] //Contribute to Saving Goal
				[ ] NavigateQuickenTab(sTAB_PLANNING,sTAB_SAVING_GOALS)
				[ ] Planning.PlanningSubTab.Panel.SetupScreenHolder.Panel1.ContributeButton.Click()
				[+] if (DlgContributeToGoal.Exists())
					[ ] ReportStatus("Verify Contribute To Goal Window", PASS, "Contribute To Goal Window is available")
					[ ] DlgContributeToGoal.SetActive()
					[ ] DlgContributeToGoal.FromAccountPopupList.Click()
					[ ] sleep(3)
					[ ] DlgContributeToGoal.FromAccountPopupList.TypeKeys(Replicate(KEY_DN, 1))
					[ ] DlgContributeToGoal.FromAccountPopupList.TypeKeys(KEY_ENTER)
					[ ] DlgContributeToGoal.OKButton.Click()
					[ ] 
					[ ] // Verify Savings Goal Register and Reports menu item in Goal Actions on Saving Goal Tab
					[ ] Planning.PlanningSubTab.Panel.GoalActions.Click()
					[ ] sleep (3)
					[ ] QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_DN, 2)) 
					[ ] QuickenMainWindow.QWNavigator.TypeKeys(KEY_ENTER)
					[ ] 
					[ ] // Verify if Balance is not shown on the Account Bar
					[ ] NavigateQuickenTab(sTAB_HOME)
					[+] do
						[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.SavingsGoals.TextClick("$")
						[ ] ReportStatus("Verify SavingsGoal context menu on Goal Actions", PASS, "SavingsGoal context menu is avaiable on Goal Actions")
						[ ] ReportStatus("Verify SavingsGoals in Account Bar shows the balance", FAIL, "SavingsGoals in Account Bar shows the balance")
					[+] except
						[ ] ReportStatus("Verify SavingsGoals in Account Bar shows the balance", PASS, "SavingsGoals in Account Bar does not show the balance")
					[ ] 
					[ ] //Verify Savings Goal Register and Reports menu item in Account Action on Checking Account
					[ ] iSelect = SelectAccountFromAccountBar(sAccount, ACCOUNT_BANKING)
					[+] if (iSelect == PASS)
						[ ] sleep(3)
						[ ] QuickenWindow.TypeKeys("<Ctrl-Shift-N>")
						[ ] QuickenWindow.TypeKeys(Replicate(KEY_DN, 16)) 
						[ ] sleep (3)
						[ ] //QuickenMainWindow.QWNavigator.TypeKeys(Replicate(KEY_UP, 5)) 
						[ ] QuickenWindow.TypeKeys(KEY_ENTER)
						[ ] 
						[ ] // Verify if Balance is shown on the Account Bar
						[+] do
							[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.SavingsGoals.TextClick("$")
							[ ] ReportStatus("Verify SavingsGoal context menu on Account Actions", PASS, "SavingsGoal context menu is avaiable on Account Actions")
							[ ] ReportStatus("Verify SavingsGoals in Account Bar shows the balance", PASS, "SavingsGoals in Account Bar shows the balance")
						[+] except
							[ ] ReportStatus("Verify SavingsGoals in Account Bar shows the balance", FAIL, "SavingsGoals in Account Bar does not show the balance")
					[+] else
						[ ] ReportStatus("Verify Checking account is selected", FAIL, "Checking account is not selected on account bar")
				[+] else
					[ ] ReportStatus("Verify if Contribute Dialog Exists", FAIL, "Contribute Dialog does not exist")
			[+] else
				[ ] ReportStatus("Verify SavingsGoal context menu on Account Bar", FAIL, "SavingsGoal context menu is not avaiable on Account Bar")
		[+] else
			[ ] ReportStatus("Verify Saving Goal Pre Req is Successful", FAIL, "Saving Goal Pre Req is unsuccessful")
	[+] else
		[ ] ReportStatus("Verify Quicken Main Window exists", FAIL, "Quicken Main Window does not exist")
[ ] //################################################################################
[ ] 
