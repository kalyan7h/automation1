﻿[ ] // *********************************************************
[+] // FILE NAME:	<HomeTab.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Home tabtest cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	  Mukesh
	[ ] //
	[ ] // Developed on: 
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Feb 21, 2014	Dean Paes  Created
[ ] // *********************************************************
[ ] 
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] // Global variables 
	[ ] 
	[ ] 
	[ ] //----------STRING-------------------
	[ ] 
	[ ] STRING sAccountName ,sActualMessage ,sExpectedMessage ,sHandle ,sActual , sViewName 
	[ ] public STRING sHomeTabExcelsheet="HomeTabTestData"
	[ ] public STRING sAccountWorksheet = "Account"
	[ ] 
	[ ] public STRING sHomeTabFileName="HomeTabDataFile"
	[ ] 
	[ ] public STRING sDateFormat="m/d/yyyy"
	[ ] public STRING sDate=ModifyDate(0,sDateFormat)
	[ ] 
	[ ] public STRING sMDIWindow="MDI"
	[ ] 
	[ ] public STRING  sHomeTabDataFile = AUT_DATAFILE_PATH + "\" + sHomeTabFileName + ".QDF"
	[ ] 
	[ ] STRING  sHomeTabDataFileSource = AUT_DATAFILE_PATH + "\DataFile\" + sHomeTabFileName + ".QDF"
	[ ] 
	[ ] 
	[ ] 
	[ ] 
	[ ] STRING sGetStarted ="Get Started"
	[ ] 
	[ ] 
	[ ] //------------------INTEGER----------------
	[ ] public INTEGER iResult , iCount ,iCounter ,iListCount
	[ ] 
	[ ] //--------------BOOLEAN---------------
	[ ] public BOOLEAN bMatch 
	[ ] 
	[ ] //--------------Lists---------------
	[ ] LIST OF ANYTYPE lsExcelData ,lsAddAccount
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //##########Test 10 - Verify that 'View Guidance' button gets displayed on Home page after account is added in new data file #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_VerifyThatViewGuidanceButtonGetsDisplayedOnHomePageAfterAccountAddedInNewDataFile
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'View Guidance' button gets displayed on Home page after account is added in new data file
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If 'View Guidance' button gets displayed on Home page after account is added in new data file
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 21 2013
		[ ] //
	[ ] // ********************************************************
[-] testcase Test10_VerifyThatViewGuidanceButtonGetsDisplayedOnHomePageAfterAccountAddedInNewDataFile() appstate QuickenBaseState
		[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] sHomeTabFileName ="HomeTabDataFileNew"
		[ ] lsAddAccount={"Checking","Checking 01 Account","100"}
		[ ] sAccountName = lsAddAccount[2]
	[ ] SkipRegistration()
	[ ] iResult=DataFileCreate(sHomeTabFileName)
	[+] if (iResult==PASS)
		[ ] ReportStatus("Create Data File", PASS ,"Data File: {sHomeTabFileName} created.")
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] iResult =AddManualSpendingAccount(lsAddAccount[1],lsAddAccount[2],lsAddAccount[3])
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify account: {sAccountName} gets created.", PASS, "Account: {sAccountName} has been created.")
				[ ] 
				[+] if (QuickenMainWindow.ViewGuidanceButton.Exists(3))
					[ ] ReportStatus(" Verify that 'View Guidance' button gets displayed on Home page after account is added in new data file.", PASS, "View Guidance' button displayed on Home page after account is added in new data file.")
					[ ] 
				[+] else
					[ ] ReportStatus(" Verify that 'View Guidance' button gets displayed on Home page after account is added in new data file.", FAIL, "View Guidance' button didn't display on Home page after account is added in a new data file.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify account: {sAccountName} gets created.", FAIL, "Account: {sAccountName} couldn't be created.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[+] else
		[ ] ReportStatus("Create Data File",FAIL,"Data File: {sHomeTabFileName} couldn't be created.")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[ ] 
[+] //##########Test 7 - Verify that by default Home page is displayed after installing Quicken RPM SKU #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test7_VerifyThatByDefaultHomePageIsDisplayedAfterInstallingQuickenRPMSKU
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that by default Home page is displayed after installing Quicken RPM SKU.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If by default Home page is displayed after installing Quicken RPM SKU
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  March 04 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test7_VerifyThatByDefaultHomePageIsDisplayedAfterInstallingQuickenRPMSKU() appstate NavigateToHomeTab
		[ ] 
	[ ] //--------------Variable Declaration-------------
	[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] ////Verify that See Where Your Money Goes Snapshot has been displayed on home page by default
		[ ] 
		[+] if (MDIClient.Home.ExamineYourSpendingButton.Exists(2))
			[ ] ReportStatus("Verify that by default Home page is displayed after installing Quicken RPM SKU." , PASS , "The See Where Your Money Goes Snapshot has been displayed on home page by default.")
		[+] else
			[ ] ReportStatus("Verify that by default Home page is displayed after installing Quicken RPM SKU." , FAIL , "The See Where Your Money Goes Snapshot didn't display on home page by default.")
		[ ] 
		[ ] ////Verify that Stay On Top of Monthly Bills Snapshot has been displayed on home page by default
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] MDIClient.Home.VScrollBar.ScrollToMax()
		[ ] MDIClient.Home.TextClick(sGetStarted ,1)
		[+] if (StayOnTopOfMonthlyBills.Exists(3))
			[ ] StayOnTopOfMonthlyBills.SetActive()
			[ ] StayOnTopOfMonthlyBills.Cancel.Click()
			[ ] WaitForState(StayOnTopOfMonthlyBills , false ,5)
			[ ] ReportStatus("Verify that by default Home page is displayed after installing Quicken RPM SKU." , PASS , "The Stay On Top of Monthly Bills Snapshot has been displayed on home page by default.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify that by default Home page is displayed after installing Quicken RPM SKU." , FAIL , "The Stay On Top of Monthly Bills Snapshot didn't display on home page by default.")
			[+] if (CreateANewBudget.Exists(3))
				[ ] CreateANewBudget.SetActive()
				[ ] CreateANewBudget.Cancel.Click()
				[ ] WaitForState(CreateANewBudget , false ,5)
		[ ] 
		[ ] ////Verify that Budget Snapshot has been displayed on home page by default
		[ ] QuickenWindow.SetActive()
		[ ] MDIClient.Home.VScrollBar.ScrollToMax()
		[ ] MDIClient.Home.TextClick(sGetStarted ,2)
		[+] if (CreateANewBudget.Exists(3))
			[ ] CreateANewBudget.SetActive()
			[ ] CreateANewBudget.Cancel.Click()
			[ ] WaitForState(CreateANewBudget , false ,5)
			[ ] ReportStatus("Verify that by default Home page is displayed after installing Quicken RPM SKU." , PASS , "The budget Snapshot has been displayed on home page by default.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify that by default Home page is displayed after installing Quicken RPM SKU." , FAIL , "The budget Snapshot didn't display on home page by default.")
			[+] if (StayOnTopOfMonthlyBills.Exists(3))
				[ ] StayOnTopOfMonthlyBills.SetActive()
				[ ] StayOnTopOfMonthlyBills.Cancel.Click()
				[ ] WaitForState(StayOnTopOfMonthlyBills , false ,5)
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
[+] //##########Test19 -Verify that user is able to move up snapshot for any view. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test19_VerifyThatUserIsAbleToMoveUpSnapshotForAnyView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to move up snapshot for any view.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to move up snapshot for any view.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 28 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test19_VerifyThatUserIsAbleToMoveUpSnapshotForAnyView() appstate NavigateToHomeTab
	[+] //--------------Variable Declaration-------------
		[ ] STRING sBudgetSnapShot 
		[ ] sBudgetSnapShot="Budget"
		[ ] 
		[ ] 
		[ ] 
	[ ] ///Move the budget Snapshot up
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] QuickenMainWindow.Customize.Click()
		[+] if (CustomizeView.Exists(3))
			[ ] CustomizeView.SetActive()
			[ ] sHandle= Str(CustomizeView.ChosenItemsListBox.GetHandle())
			[ ] iListCount= CustomizeView.ChosenItemsListBox.GetItemCount() +1
			[ ] 
			[+] for(iCount= 0; iCount <= iListCount;  iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr("*{sBudgetSnapShot}*", sActual)
				[+] if (bMatch)
					[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(iCount))
					[ ] 
					[ ] break
			[+] if (bMatch)
				[ ] CustomizeView.SetActive()
				[ ] CustomizeView.MoveUp.Click()
				[ ] CustomizeView.OK.Click()
				[ ] WaitForState(CustomizeView , false ,5)
				[ ] //Verify that budget Snapshot has been moved up
				[ ] MDIClient.Home.VScrollBar.ScrollToMax()
				[ ] QuickenWindow.SetActive()
				[ ] MDIClient.Home.TextClick(sGetStarted ,1)
				[+] if (CreateANewBudget.Exists(3))
					[ ] CreateANewBudget.SetActive()
					[ ] CreateANewBudget.Cancel.Click()
					[ ] WaitForState(CreateANewBudget , false ,5)
					[ ] ReportStatus("Verify that user is able to move up snapshot for any view." , PASS , "The budget Snapshot has been moved up.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that user is able to move up snapshot for any view." , FAIL , "The budget Snapshot didn't move up.")
					[+] if (StayOnTopOfMonthlyBills.Exists(3))
						[ ] StayOnTopOfMonthlyBills.SetActive()
						[ ] StayOnTopOfMonthlyBills.Cancel.Click()
						[ ] WaitForState(StayOnTopOfMonthlyBills , false ,5)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify snapshot is available on Customize View > Available items", FAIL , " {sBudgetSnapShot}: is not available on Customize View > Available items")
				[ ] 
			[+] if (CustomizeView.Exists(3))
				[ ] CustomizeView.SetActive()
				[ ] CustomizeView.OK.Click()
				[ ] WaitForState(CustomizeView , false ,5)
		[+] else
			[ ] ReportStatus("Verify Customize View dialog." , FAIL , "Customize View dialog didn't appear.")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test20 -Verify that user is able to move down snapshot for any view. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test20_VerifyThatUserIsAbleToMoveDownSnapshotForAnyView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to move down snapshot for any view.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to move down snapshot for any view.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 28 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test20_VerifyThatUserIsAbleToMoveDownSnapshotForAnyView() appstate NavigateToHomeTab
	[+] //--------------Variable Declaration-------------
		[ ] STRING sBudgetSnapShot ,sGetStarted
		[ ] sBudgetSnapShot="Budget"
		[ ] sGetStarted ="Get Started"
		[ ] 
		[ ] 
	[ ] ///Move the budget Snapshot up
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.Customize.Click()
		[+] if (CustomizeView.Exists(3))
			[ ] CustomizeView.SetActive()
			[ ] sHandle= Str(CustomizeView.ChosenItemsListBox.GetHandle())
			[ ] iListCount= CustomizeView.ChosenItemsListBox.GetItemCount() +1
			[ ] 
			[+] for(iCount= 0; iCount <= iListCount;  iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr("*{sBudgetSnapShot}*", sActual)
				[+] if (bMatch)
					[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(iCount))
					[ ] 
					[ ] break
			[+] if (bMatch)
				[ ] CustomizeView.SetActive()
				[ ] CustomizeView.MoveDown.Click()
				[ ] CustomizeView.OK.Click()
				[ ] WaitForState(CustomizeView , false ,5)
				[ ] //Verify that budget Snapshot has been moved up
				[ ] QuickenWindow.SetActive()
				[ ] MDIClient.Home.VScrollBar.ScrollToMax()
				[ ] sleep(1)
				[ ] MDIClient.Home.TextClick(sGetStarted ,2)
				[+] if (CreateANewBudget.Exists(3))
					[ ] CreateANewBudget.SetActive()
					[ ] CreateANewBudget.Cancel.Click()
					[ ] WaitForState(CreateANewBudget , false ,5)
					[ ] ReportStatus("Verify that user is able to move down snapshot for any view." , PASS , "The budget Snapshot has been moved down.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify that user is able to move down snapshot for any view." , FAIL , "The budget Snapshot didn't move down.")
					[+] if (StayOnTopOfMonthlyBills.Exists(3))
						[ ] StayOnTopOfMonthlyBills.SetActive()
						[ ] StayOnTopOfMonthlyBills.Cancel.Click()
						[ ] WaitForState(StayOnTopOfMonthlyBills , false ,5)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify snapshot is available on Customize View > Available items", FAIL , " {sBudgetSnapShot}: is not available on Customize View > Available items")
				[ ] 
			[+] if (CustomizeView.Exists(3))
				[ ] CustomizeView.SetActive()
				[ ] CustomizeView.OK.Click()
				[ ] WaitForState(CustomizeView , false ,5)
		[+] else
			[ ] ReportStatus("Verify Customize View dialog." , FAIL , "Customize View dialog didn't appear.")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test23 - Verify that user is able to rename any view. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_VerifyThatUserIsAbleToRenameAnyView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to rename any view.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to rename any view.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 28 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test23_VerifyThatUserIsAbleToRenameAnyView() appstate NavigateToHomeTab
	[+] //--------------Variable Declaration-------------
		[ ] STRING sViewName
		[ ] sViewName= "Test View"
		[ ] 
	[ ] ///Move the budget Snapshot up
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] QuickenMainWindow.Customize.Click()
		[+] if (CustomizeView.Exists(3))
			[ ] CustomizeView.SetActive()
			[ ] CustomizeView.ViewName.SetText(sViewName)
			[ ] CustomizeView.OK.Click()
			[ ] WaitForState( CustomizeView , False , 3)
			[ ] QuickenWindow.SetActive()
			[ ] 
			[+] do
				[ ] QuickenMainWindow.TextClick(sViewName)
				[ ] ReportStatus("Verify that user is able to rename any view." , PASS , "The View has been renamed to: {sViewName}.")
			[+] except
				[ ] ReportStatus("Verify that user is able to rename any view." , FAIL , "The View couldn't be renamed to: {sViewName}")
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Customize View dialog." , FAIL , "Customize View dialog didn't appear.")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test 26 - Verify the access points for the Home page. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test26_VerifyTheAccessPointsForTheHomePage
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify the access points for the Home page.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to navigate any view using menu Home menu -> Select any view.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Mar 01 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test26_VerifyTheAccessPointsForTheHomePage() appstate NavigateToHomeTab
	[+] //--------------Variable Declaration-------------
		[ ] STRING sHomeMenu ,sActualView , sViewMenu
		[ ] sViewName= "ViewTest"
		[ ] sHomeMenu= "H_ome"
		[ ] sViewMenu ="*ViewTest"
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] ////Enable the Classic menu view mode
		[ ] iResult= SetViewMode(VIEW_CLASSIC_MENU)
		[+] if (iResult==PASS)
			[ ] ///Add one view
			[ ] iResult= AddView(sViewName)
			[+] if (iResult==PASS)
				[ ] ////
				[ ] NavigateQuickenTab(sTAB_BILL)
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.Home.Click()
				[+] do
					[ ] QuickenWindow.MainMenu.Select("/H_ome/{sViewMenu}")
				[+] except
					[ ] QuickenWindow.MainMenu.Select("/H_ome/    _ViewTest")
				[ ] sleep(1)
				[ ] QuickenWindow.SetActive()
				[ ] QuickenMainWindow.Customize.DoubleClick()
				[+] if (CustomizeView.Exists(3))
					[ ] CustomizeView.SetActive()
					[ ] sActualView =CustomizeView.ViewName.GetText()
					[ ] CustomizeView.OK.Click()
					[ ] WaitForState( CustomizeView , False , 3)
					[+] if (sActualView==sViewName)
						[ ] ReportStatus("Verify the access points for the Home page." , PASS , "User navigated view: {sViewName} using menu: {sHomeMenu} ->{sViewMenu}.")
					[+] else
						[ ] ReportStatus("Verify the access points for the Home page." , FAIL , "User couldn't navigate to view: {sViewName} using menu: {sHomeMenu} ->{sViewMenu}.")
				[+] else
					[ ] ReportStatus("Verify the access points for the Home page." , FAIL , "Customize View dialog didn't appear. [**Check Jira QW-5051**]")
			[+] else
				[ ] ReportStatus("Verify veiw has been added." , FAIL , "View: {sViewName} couldn't be added successfully.")
		[+] else
			[ ] ReportStatus("Verify that Classic menu view mode has been enabled." , FAIL , "Classic menu view mode couldn't be enabled.")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test 27 - Verify that user is able to delete any view from menu item. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test27_VerifyThatUserIsAbleToDeleteAnyViewUsingDeleteThisViewMenuItem
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to delete any view from menu item.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to delete any view using menu item Home menu -> Delete this view...
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Mar 01 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test27_VerifyThatUserIsAbleToDeleteAnyViewUsingDeleteThisViewMenuItem() appstate NavigateToHomeTab
	[+] //--------------Variable Declaration-------------
		[ ] STRING sHomeMenu ,sActualView , sViewMenu
		[ ] sViewName= "ViewTest"
		[ ] sHomeMenu= "H_ome"
		[ ] sViewMenu ="    _ViewTest"
		[ ] sExpectedMessage="Are you sure you want to delete this view?"
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] ////Navigate to view to be deleted
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.TextClick(sViewName)
		[ ] 
		[ ] ///Navigate to Home menu -> Delete this view...
		[ ] QuickenWindow.MainMenu.Select("/H_ome/Delete this view...")
		[+] if (AlertMessage.Exists(2))
			[ ] AlertMessage.SetActive()
			[ ] sActualMessage = AlertMessage.MessageText.GetText()
			[ ] AlertMessage.Yes.Click()
			[ ] WaitForState(AlertMessage , false ,2)
			[ ] ReportStatus("Verify user is able to delete any view using menu item Home menu -> Delete this view...." , PASS , "View delete confirmation appeared..")
			[+] if (sActualMessage==sExpectedMessage)
				[ ] ReportStatus("Verify user is able to delete any view using menu item Home menu -> Delete this view...." , PASS , "The validation message is as expected: {sActualMessage}.")
				[+] do
					[ ] QuickenWindow.SetActive()
					[ ] QuickenMainWindow.TextClick(sViewName)
					[ ] ReportStatus("Verify user is able to delete any view using menu item Home menu -> Delete this view...." , FAIL , "The view: {sViewName}  couldn't be deleted as user is still able to navigate to it.")
					[ ] 
					[ ] 
				[+] except
					[ ] ReportStatus("Verify user is able to delete any view using menu item Home menu -> Delete this view...." , PASS , "The view: {sViewName} has successfully been deleted.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify user is able to delete any view using menu item Home menu -> Delete this view...." , FAIL , "The validation message: {sActualMessage} is NOT as expected: {sExpectedMessage}.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify user is able to delete any view using menu item Home menu -> Delete this view...." , FAIL , "View delete confirmation didn't appear.")
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
[+] //##########Test 28 - Verify that 'Customize view' dialog gets launched from menu item. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test28_VerifyThatCustomizeViewDialogGetsLaunchedFromCustomizeThisViewMenuItem
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'customize view' dialog gets launched from menu item.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If Customize view dialog gets launched from menu item Home menu ->Customize this view...
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 28 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test28_VerifyThatCustomizeViewDialogGetsLaunchedFromCustomizeThisViewMenuItem() appstate NavigateToHomeTab
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Home.Click()
		[ ] QuickenWindow.Home.CustomizeThisView.Select()
		[+] if (CustomizeView.Exists(3))
			[ ] CustomizeView.SetActive()
			[ ] CustomizeView.Cancel.Click()
			[ ] ReportStatus("Verify that Customize view dialog gets launched from menu item." , PASS , "Customize View dialog appeared from menu item Home menu ->Customize this view....")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify that Customize view dialog gets launched from menu item." , FAIL , "Customize View dialog didn't appear from menu item Home menu ->Customize this view....")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test 29 - Verify that 'Add view' dialog gets launched from menu item. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test29_VerifyThatCustomizeViewDialogGetsLaunchedFromAddACustomizeViewMenuItem
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Add view' dialog gets launched from menu item.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If Add view dialog gets launched from menu item Home menu ->Add a custom view...
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 28 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test29_VerifyThatCustomizeViewDialogGetsLaunchedFromAddACustomizeViewMenuItem() appstate NavigateToHomeTab
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Home.Click()
		[ ] QuickenWindow.Home.AddACustomView.Select()
		[+] if (CustomizeView.Exists(3))
			[ ] CustomizeView.SetActive()
			[ ] CustomizeView.Cancel.Click()
			[ ] ReportStatus("Verify that Customize view dialog gets launched from menu item Add a custom view...." , PASS , "Customize View dialog appeared from menu item Home menu -> Add a custom view...")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify that Customize view dialog gets launched from menu item Add a custom view...." , FAIL , "Customize View dialog didn't appear from menu item Home menu ->Add a custom view...")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test21 - Verify that user is allowed to add 12 views. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test23_VerifyThatUserIsAbleToRenameAnyView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is allowed to add 12 views.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to add 12 views.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 28 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test21_VerifyThatUserIsAbleToAdd12Views() appstate NavigateToHomeTab
	[+] //--------------Variable Declaration-------------
		[ ] STRING sViewName ,sView
		[ ] sView= "View"
		[ ] 
		[ ] 
	[ ] ///Move the budget Snapshot up
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] ///Add 12 views
		[+] for (iCount=1; iCount <12 ; iCount++)
			[ ] sViewName =sView+ Str(iCount)
			[ ] iResult= AddView(sViewName)
			[+] if (iResult==PASS)
				[ ] 
				[+] do
					[ ] QuickenMainWindow.TextClick(sViewName)
					[ ] ReportStatus("Verify that user is able to navigate to created view." , PASS , "The user is able to navigate to created view: {sViewName}.")
				[+] except
					[ ] ReportStatus("Verify that user is able to navigate to created view." , FAIL , "The user couldn't navigate to created view: {sViewName}.")
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify veiw has been added." , FAIL , "View: {sViewName} couldn't be added successfully.")
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test22 - Verify that user is not allowed to add more than 12 views. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test22_VerifyThatUserIsNotAllowedToAddMoreThan12Views
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is not allowed to add more than 12 views.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is not allowed to add more than 12 views.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 28 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test22_VerifyThatUserIsNotAllowedToAddMoreThan12Views() appstate NavigateToHomeTab
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] sExpectedMessage ="You have reached the maximum number of views. Delete an existing view before creating a new one."
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] ///Verify that user is not allowed to add more than 12 views
		[ ] QuickenMainWindow.AddViewButton.Click()
		[+] if (AlertMessage.Exists(5))
			[ ] AlertMessage.SetActive()
			[ ] sActualMessage=AlertMessage.MessageText.GetText()
			[ ] AlertMessage.SetActive()
			[ ] AlertMessage.OK.DoubleClick()
			[ ] WaitForState(AlertMessage , False ,2)
			[+] if (sActualMessage==sExpectedMessage)
				[ ] ReportStatus("Verify that user is not allowed to add more than 12 views" , PASS , "Validation message: {sActualMessage} appeard as expected: {sExpectedMessage} while adding the13th view.")
			[+] else
				[ ] ReportStatus("Verify that user is not allowed to add more than 12 views" , FAIL , "Validation message: {sActualMessage} didn't appear as expected: {sExpectedMessage} while adding the13th view.")
		[+] else
			[ ] ReportStatus("Verify that user is not allowed to add more than 12 views" , FAIL , "Validation message didn't appear while adding the 13th view.")
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //##########Test 8 - Verify that Customize view dialog gets launched when clicked on Customize view button. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test8_VerifyThatCustomizeViewDialogGetsLaunchedWhenClickedOnCustomizeViewButton
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Customize view dialog gets launched when clicked on Customize view button.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If Customize view dialog gets launched when clicked on Customize view button.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 21 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test8_VerifyThatCustomizeViewDialogGetsLaunchedWhenClickedOnCustomizeViewButton() appstate NavigateToHomeTab
	[ ] 
	[ ] sHomeTabFileName="HomeTabDataFile"
	[+] if(FileExists(sHomeTabDataFile))
		[ ] DeleteFile(sHomeTabDataFile)
		[ ] sleep(3)
	[ ] SYS_CopyFile (sHomeTabDataFileSource , sHomeTabDataFile)
	[ ] sleep(3)
	[ ] QuickenWindow.SetActive()
	[ ] iResult=OpenDataFile(sHomeTabFileName)
	[+] if (iResult==PASS)
		[+] if(QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.Customize.Click()
			[+] if (CustomizeView.Exists(3))
				[ ] CustomizeView.SetActive()
				[ ] CustomizeView.Cancel.Click()
				[ ] ReportStatus("Verify that Customize view dialog gets launched when clicked on Customize button." , PASS , "Customize View dialog appeared on clicking Customize button.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify that Customize view dialog gets launched when clicked on Customize button." , FAIL , "Customize View dialog didn't appear on clicking Customize button.")
		[+] else
			[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[+] else
		[ ] ReportStatus("Open Data File",FAIL,"Data File: {sHomeTabFileName} couldn't be opened.")
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test 9 - Verify that Customize view dialog gets launched when clicked on Add view button. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test9_VerifyThatCustomizeViewDialogGetsLaunchedWhenClickedOnAddViewButton
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that Customize view dialog gets launched when clicked on Add view button.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If Customize view dialog gets launched when clicked on Add view button.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 21 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test9_VerifyThatCustomizeViewDialogGetsLaunchedWhenClickedOnAddViewButton() appstate NavigateToHomeTab
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.AddViewButton.Click()
		[+] if (CustomizeView.Exists(3))
			[ ] CustomizeView.SetActive()
			[ ] CustomizeView.Cancel.Click()
			[ ] ReportStatus("Verify that Customize view dialog gets launched when clicked on Add view button." , PASS , "Customize View dialog appeared on clicking Add view button.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify that Customize view dialog gets launched when clicked on Add view button." , FAIL , "Customize View dialog didn't appear on clicking Add view button.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test 30 - Verify that after data file conversion, Home page data and settings are not affected.. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test30_VerifyThatAfterDataFileConversionHomePageDataAndSettingsAreNotChanged
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that after data file conversion, Home page data and settings are not affected.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If  after data file conversion, Home page data and settings are not affected.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 30 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test30_VerifyThatAfterDataFileConversionHomePageDataAndSettingsAreNotChanged() appstate NavigateToHomeTab
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] LIST OF ANYTYPE lsMoneyView , lsView1View ,lsFirstViewView , lsTabs ,lsView
		[ ] LIST OF LIST OF ANYTYPE lslsViews
		[ ] STRING sMoneyView , sView1View ,sFirstViewView , sHomeView
		[ ] sMoneyView="Money" 
		[ ] sView1View ="View 1"
		[ ] sFirstViewView ="First Page"
		[ ] sHomeView ="Home"
		[ ] 
		[ ] lsTabs ={sMoneyView ,sView1View ,sFirstViewView}
		[ ] 
		[ ] lsMoneyView = {"See Where Your Money Goes", "Stay On Top of Monthly Bills" , "Budget"}
		[ ] lsView1View = { "Alerts" , "All Accounts" ,"Bill and Income Reminders" , "Watch List" , "Online Updates"}
		[ ] lsFirstViewView ={"Expenses" , "Income vs. Expenses" ,"Net Worth" , "Portfolio Value Graph" , "Alerts", "Budget"}
		[ ] 
		[ ] lslsViews = {lsMoneyView , lsView1View ,lsFirstViewView}
		[ ] 
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] ///Verify the First three views
		[+] for (iCount = 1 ; iCount <ListCount(lslsViews) +1 ; ++iCount)
			[ ] lsView = lslsViews[iCount]
			[ ] iListCount = ListCount (lsView) +1
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.TextClick(lsTabs[iCount])
			[ ] sleep(2)
			[ ] QuickenWindow.SetActive()
			[ ] QuickenMainWindow.Customize.Click()
			[+] if (CustomizeView.Exists(3))
				[ ] CustomizeView.SetActive()
				[ ] sHandle= Str(CustomizeView.ChosenItemsListBox.GetHandle())
				[ ] 
				[+] for(iCounter= 1; iCounter < iListCount;  iCounter++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter-1))
					[ ] bMatch = MatchStr("*{lsView[iCounter]}*", sActual)
					[ ] 
					[ ] 
					[+] if (bMatch)
						[ ] ReportStatus(" Verify that after data file conversion, Home page data and settings are not affected" , PASS , "Snapshot: {lsView[iCounter]} is as expected on View: {lsTabs[iCount]}.")
					[+] else
						[ ] ReportStatus(" Verify that after data file conversion, Home page data and settings are not affected" , FAIL , "Snapshot: {lsView[iCounter]} is NOT as expected on View: {lsTabs[iCount]}.")
				[ ] CustomizeView.SetActive()
				[ ] CustomizeView.OK.Click()
				[ ] WaitForState(CustomizeView , false ,5)
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Customize View dialog." , FAIL , "Customize View dialog didn't appear.")
				[ ] 
			[ ] 
			[ ] 
			[ ] 
			[ ] 
		[ ] 
		[ ] ///Verify the Last view with no snapshot
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.TextClick(sHomeView , 2)
		[ ] sleep(2)
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.Customize.Click()
		[+] if (CustomizeView.Exists(3))
			[ ] CustomizeView.SetActive()
			[ ] sHandle= Str(CustomizeView.ChosenItemsListBox.GetHandle())
			[ ] iListCount = CustomizeView.ChosenItemsListBox.GetItemCount()
			[ ] 
			[ ] 
			[+] if (iListCount==0)
				[ ] ReportStatus(" Verify that after data file conversion, Home page data and settings are not affected" , PASS , "View :{sHomeView} is empty post conversion as expected.")
			[+] else
				[ ] ReportStatus(" Verify that after data file conversion, Home page data and settings are not affected" , FAIL , "Some snapshot/s has been added to the View :{sHomeView}, it is NOT empty post conversion.")
			[ ] CustomizeView.SetActive()
			[ ] CustomizeView.OK.Click()
			[ ] WaitForState(CustomizeView , false ,5)
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Customize View dialog." , FAIL , "Customize View dialog didn't appear.")
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
[ ] 
[+] //##########Test 25 - Verify that changes done for any view does not reflect on other view. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test25_VerifyThatChangesDoneForAnyViewDoesNotReflectOnOtherView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that changes done for any view does not reflect on other view.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If changes done for any view does not reflect on other view.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 28 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test25_VerifyThatChangesDoneForAnyViewDoesNotReflectOnOtherView() appstate NavigateToHomeTab
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] LIST OF ANYTYPE lsMoneyView , lsView1View ,lsFirstViewView , lsTabs ,lsView
		[ ] LIST OF LIST OF ANYTYPE lslsViews
		[ ] STRING sMoneyView , sView1View ,sFirstViewView , sHomeView ,sMyWebLinksSnapshot ,sSeeWhereYourMoneyGoesSnapshot ,sAlerts
		[ ] sMoneyView="Money" 
		[ ] sView1View ="View 1"
		[ ] sFirstViewView ="First Page"
		[ ] sHomeView ="Home"
		[ ] sMyWebLinksSnapshot ="My Web Links"
		[ ] sSeeWhereYourMoneyGoesSnapshot ="See Where Your Money Goes"
		[ ] sAlerts ="Alerts"
		[ ] 
		[ ] lsTabs ={sMoneyView ,sView1View ,sFirstViewView}
		[ ] 
		[ ] lsMoneyView = {"My Web Links", "See Where Your Money Goes", "Stay On Top of Monthly Bills" , "Budget"}
		[ ] lsView1View = { "Alerts" , "All Accounts" ,"Bill and Income Reminders" , "Watch List" , "Online Updates"}
		[ ] lsFirstViewView ={"Expenses" , "Income vs. Expenses" ,"Net Worth" , "Portfolio Value Graph" , "Alerts", "Budget"}
		[ ] 
		[ ] lslsViews = {lsMoneyView , lsView1View ,lsFirstViewView}
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] ///Add snapshot to view Money View
		[ ] QuickenMainWindow.TextClick(sMoneyView )
		[ ] sleep(2)
		[ ] QuickenWindow.SetActive()
		[ ] SelectCustomizeViewItems(sAlerts)
		[ ] iResult=SelectCustomizeViewItems(sMyWebLinksSnapshot)
		[+] if (iResult==PASS)
			[ ] ReportStatus("Verify Snapshot has been added." , PASS , "Snapshot: {sMyWebLinksSnapshot}  has been added as expected to the: {sMoneyView}.")
			[ ] 
			[ ] ///Now Remove the "See Where Your Money Goes" snapshot from Money view
			[ ] QuickenWindow.SetActive()
			[ ] iResult= RemoveSnapShotFromView(sAlerts)
			[+] if (iResult==PASS)
				[ ] ReportStatus("Verify Snapshot has been added." , PASS , "Snapshot: {sSeeWhereYourMoneyGoesSnapshot} has been removed from the: {sMoneyView}.")
				[ ] ///Verify the First three views
				[+] for (iCount = 1 ; iCount <ListCount(lslsViews) +1 ; ++iCount)
					[ ] lsView = lslsViews[iCount]
					[ ] iListCount = ListCount (lsView) +1
					[ ] QuickenWindow.SetActive()
					[ ] QuickenMainWindow.TextClick(lsTabs[iCount])
					[ ] sleep(2)
					[ ] QuickenWindow.SetActive()
					[ ] QuickenMainWindow.Customize.Click()
					[+] if (CustomizeView.Exists(3))
						[ ] CustomizeView.SetActive()
						[ ] sHandle= Str(CustomizeView.ChosenItemsListBox.GetHandle())
						[ ] 
						[+] for(iCounter= 1; iCounter < iListCount;  iCounter++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCounter-1))
							[ ] bMatch = MatchStr("*{lsView[iCounter]}*", sActual)
							[ ] 
							[ ] 
							[+] if (bMatch)
								[ ] ReportStatus(" Verify that changes done for any view does not reflect on other view" , PASS , "Snapshot: {lsView[iCounter]} is as expected on View: {lsTabs[iCount]}.")
							[+] else
								[ ] ReportStatus("  Verify that changes done for any view does not reflect on other view" , FAIL , "Snapshot: {lsView[iCounter]} is NOT as expected on View: {lsTabs[iCount]}.")
						[ ] CustomizeView.SetActive()
						[ ] CustomizeView.OK.Click()
						[ ] WaitForState(CustomizeView , false ,5)
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Customize View dialog." , FAIL , "Customize View dialog didn't appear.")
						[ ] 
					[ ] 
					[ ] 
					[ ] 
					[ ] 
				[ ] 
				[ ] ///Verify the Last view with no snapshot
				[ ] QuickenWindow.SetActive()
				[ ] QuickenMainWindow.TextClick(sHomeView , 2)
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive()
				[ ] QuickenMainWindow.Customize.Click()
				[+] if (CustomizeView.Exists(3))
					[ ] CustomizeView.SetActive()
					[ ] sHandle= Str(CustomizeView.ChosenItemsListBox.GetHandle())
					[ ] iListCount = CustomizeView.ChosenItemsListBox.GetItemCount()
					[ ] 
					[ ] 
					[+] if (iListCount==0)
						[ ] ReportStatus("Verify that changes done for any view does not reflect on other view" , PASS , "View :{sHomeView} is empty post conversion as expected.")
					[+] else
						[ ] ReportStatus(" Verify that changes done for any view does not reflect on other view" , FAIL , "Some snapshot/s has been added to the View :{sHomeView}, it is NOT empty post conversion.")
					[ ] CustomizeView.SetActive()
					[ ] CustomizeView.OK.Click()
					[ ] WaitForState(CustomizeView , false ,5)
					[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Customize View dialog." , FAIL , "Customize View dialog didn't appear.")
					[ ] 
				[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Snapshot has been added." , FAIL , "Snapshot: {sSeeWhereYourMoneyGoesSnapshot} couldn't be removed from the: {sMoneyView}.")
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Snapshot has been added." , FAIL , "Snapshot: {sMyWebLinksSnapshot}  couldn't be added as expected to the: {sMoneyView}.")
		[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
		[ ] 
	[ ] 
[ ] 
[+] //##########Test 11 - Verify that user is able to add more views on Home page. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_VerifyThatUserIsAbleToAddMoreViewsOnHomePage
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to add more views on Home page
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to add more views on Home page
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 24 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test11_VerifyThatUserIsAbleToAddMoreViewsOnHomePage() appstate NavigateToHomeTab
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sViewName
		[ ] sViewName = "TestView"
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.AddViewButton.Click()
		[+] if (CustomizeView.Exists(3))
			[ ] CustomizeView.SetActive()
			[ ] CustomizeView.ViewName.SetText(sViewName)
			[ ] CustomizeView.OK.Click()
			[ ] WaitForState(CustomizeView , False , 2)
			[ ] SelectCustomizeViewItems("Alerts")
			[+] if (QuickenMainWindow.ShowAllAlertsButton.Exists(3))
				[ ] ReportStatus("Verify that user is able to add more views on Home page." , PASS , "New View having Alerts snapshot has been added.")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify that user is able to add more views on Home page." , FAIL , "New View having Alerts snapshot couldn't be added.")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify that Customize view dialog gets launched when clicked on Add view button." , FAIL , "Customize View dialog didn't appear on clicking Add view button.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test 12 - Verify that 'Delete this view' button is disabled on 'Customize view' dialog if only one view is present. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_VerifyThatDeleteThisViewButtonIsDisabledOnCustomizeViewDialogIfOnlyOneViewIsPresent
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Delete this view' button is disabled on 'Customize view' dialog if only one view is present.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If 'Delete this view' button is disabled on 'Customize view' dialog if only one view is present.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 24 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test12_VerifyThatDeleteThisViewButtonIsDisabledOnCustomizeViewDialogIfOnlyOneViewIsPresent() appstate NavigateToHomeTab
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sViewName
		[ ] sViewName = "TestView"
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Delete all the view until there is only one left
		[+] for (iCount =0 ; iCount <=3 ; ++iCount)
			[ ] DeleteView()
			[ ] 
			[ ] 
		[ ] ////Verify that 'Delete this view' button is disabled on 'Customize view' dialog if only one view is present
		[ ] QuickenWindow.SetActive()
		[+] if (QuickenMainWindow.Customize.Exists(2))
			[ ] QuickenMainWindow.Customize.Click()
			[+] if (CustomizeView.Exists(3))
				[ ] CustomizeView.SetActive()
				[+] if (CustomizeView.DeleteThisView.IsEnabled())
					[ ] ReportStatus("Verify Delete This View button is disabled on Customize View dialog when there is only one view." , FAIL , " Delete This View button is enabled on Customize View dialog when there is only one view.")
				[+] else
					[ ] ReportStatus("Verify Delete This View button is disabled on Customize View dialog when there is only one view." , PASS , " Delete This View button is disabled on Customize View dialog when there is only one view.")
					[ ] 
				[ ] CustomizeView.OK.Click()
				[ ] WaitForState( CustomizeView , False , 3)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Customize View dialog." , FAIL , "Customize View dialog didn't appear.")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Customize button exists on Home tab." , FAIL , "Customize button doesn't exist on Home tab.")
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
[+] //##########Test 13 - Verify that 'Delete this view' button is enable on 'Customize view' dialog if more than one view present. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_VerifyThatDeleteThisViewButtonIsEnabledOnCustomizeViewDialogIfMoreThaNavigateToHomeTabViewsArePresent
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that 'Delete this view' button is enable on 'Customize view' dialog if more than one view present
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If 'Delete this view' button is enable on 'Customize view' dialog if more than one view present
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 25 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test13_VerifyThatDeleteThisViewButtonIsEnabledOnCustomizeViewDialogIfMoreThaNavigateToHomeTabViewIsPresent() appstate NavigateToHomeTab
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sViewName
		[ ] sViewName = "SecondView"
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Add one more view
		[ ] iResult =AddView( sViewName)
		[+] if (iResult==PASS)
			[ ] ReportStatus("Verify veiw has been added." , PASS , "View has been added as expected: {sViewName}.")
			[ ] 
			[ ] ////Verify that 'Delete this view' button is enable on 'Customize view' dialog if more than one view is present.
			[ ] QuickenWindow.SetActive()
			[+] if (QuickenMainWindow.Customize.Exists(2))
				[ ] QuickenMainWindow.Customize.Click()
				[+] if (CustomizeView.Exists(3))
					[ ] CustomizeView.SetActive()
					[+] if (CustomizeView.DeleteThisView.IsEnabled())
						[ ] ReportStatus("Verify Delete This View button is enabled on Customize View dialog when there is more than one view." , PASS , " Delete This View button is enabled on Customize View dialog when there is more than one view.")
					[+] else
						[ ] ReportStatus("Verify Delete This View button is enabled on Customize View dialog when there is more than one view" , PASS , " Delete This View button is disabled on Customize View dialog when there is more than one view.")
						[ ] 
					[ ] CustomizeView.OK.Click()
					[ ] WaitForState( CustomizeView , False , 3)
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Customize View dialog." , FAIL , "Customize View dialog didn't appear.")
					[ ] 
			[+] else
				[ ] ReportStatus("Verify Customize button exists on Home tab." , FAIL , "Customize button doesn't exist on Home tab.")
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify veiw has been added." , FAIL , "View couldn't be added as expected: {sViewName}.")
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[ ] 
[+] //##########Test 14 - Verify that user is not able more than 16 snapshot for one view. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_VerifyThatUserIsNotAbleMoreThan16SnapshotForOneView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is not able more than 16 snapshot for one view
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is not able more than 16 snapshot for one view
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 25 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test14_VerifyThatUserIsNotAbleMoreThan16SnapshotForOneView() appstate NavigateToHomeTab
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sViewName
		[ ] sViewName = "SecondView"
		[ ] sExpectedMessage ="This view already contains the maximum number of items. Delete one and try again."
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] ////Verify that user is not able more than 16 snapshot for one view.
		[ ] QuickenWindow.SetActive()
		[+] if (QuickenMainWindow.Customize.Exists(2))
			[ ] QuickenMainWindow.Customize.Click()
			[+] if (CustomizeView.Exists(3))
				[ ] CustomizeView.SetActive()
				[ ] //Add 16 snapshots
				[+] for (iCount =1 ; iCount <=16 ; ++iCount)
					[ ] CustomizeView.SetActive()
					[ ] CustomizeView.AvailableItemsListBox.TypeKeys(KEY_DN)
					[ ] CustomizeView.Add.Click()
					[ ] 
				[ ] 
				[ ] ////Add 17th snapshot and Verify that user is not able more than 16 snapshot for one view.
				[ ] CustomizeView.SetActive()
				[ ] CustomizeView.AvailableItemsListBox.TypeKeys(KEY_DN)
				[ ] CustomizeView.Add.Click()
				[+] if (AlertMessage.Exists(2))
					[ ] AlertMessage.SetActive()
					[ ] ReportStatus("Verify that user is not able more than 16 snapshot for one view" , PASS , "The 17th snapshot didn't add to the customize view.")
					[ ] sActualMessage = AlertMessage.MessageText.GetText()
					[+] if (sActualMessage==sExpectedMessage)
						[ ] ReportStatus("Verify that user is not able more than 16 snapshot for one view" , PASS , "The validation message is as expected: {sActualMessage}.")
						[ ] 
					[+] else
						[ ] ReportStatus("Verify that user is not able more than 16 snapshot for one view" , FAIL , "The validation message: {sActualMessage} is NOT as expected: {sExpectedMessage}.")
					[ ] AlertMessage.OK.Click()
					[ ] WaitForState( AlertMessage , False , 3)
				[+] else
					[ ] ReportStatus("Verify that user is not able more than 16 snapshot for one view" , FAIL , "The 17th snapshot got added to the customize view.")
				[ ] CustomizeView.Cancel.Click()
				[ ] WaitForState( CustomizeView , False , 3)
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Customize View dialog." , FAIL , "Customize View dialog didn't appear.")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify Customize button exists on Home tab." , FAIL , "Customize button doesn't exist on Home tab.")
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
[+] //##########Test 15 - Verify that user is able to launch help from 'Add view' dialog. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_VerifyThatUserIsAbleToLaunchHelpFromAddViewDialog
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to launch help from 'Add view' dialog.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to launch help from 'Add view' dialog.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 25 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test15_VerifyThatUserIsAbleToLaunchHelpFromAddViewDialog() appstate NavigateToHomeTab
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.AddViewButton.Click()
		[+] if (CustomizeView.Exists(3))
			[ ] CustomizeView.SetActive()
			[ ] CustomizeView.HelpButton.Click()
			[+] if (QuickenHelp.Exists(3))
				[ ] sleep(2)
				[ ] ReportStatus("Verify that user is able to launch help from Add view dialog." , PASS , "Help launched from Add view dialog.")
				[ ] QuickenHelp.SetActive()
				[+] do
					[ ] QuickenHelp.TextClick("Customize the Home tab")
					[ ] ReportStatus("Verify that user is able to launch help from Add view dialog." , PASS , "Customize the Home tab content is displayed on Help window")
				[+] except
					[ ] ReportStatus("Verify that user is able to launch help from Add view dialog." , FAIL , "Customize the Home tab content is not displayed on Help window")
					[ ] goto CLOSE
					[ ] 
				[ ] 
				[ ] CLOSE:
				[ ] QuickenHelp.Close()
				[ ] WaitForState( QuickenHelp , False ,3)
			[+] else
				[ ] ReportStatus("Verify that user is able to launch help from Add view dialog." , FAIL , "Help didn't launch from Add view dialog.")
			[ ] 
			[ ] CustomizeView.SetActive()
			[ ] CustomizeView.Cancel.Click()
			[ ] WaitForState( CustomizeView , False ,3)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify that Customize view dialog gets launched when clicked on Add view button." , FAIL , "Customize View dialog didn't appear on clicking Add view button.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test 16 - Verify that user is able to launch help from 'Customize view' dialog. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test16_VerifyThatUserIsAbleToLaunchHelpFromCustomizeViewDialog
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to launch help from 'Customize view' dialog.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to launch help from 'Customize view' dialog.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 25 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test16_VerifyThatUserIsAbleToLaunchHelpFromCustomizeViewDialog() appstate NavigateToHomeTab
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.Customize.Click()
		[+] if (CustomizeView.Exists(3))
			[ ] CustomizeView.SetActive()
			[ ] CustomizeView.HelpButton.Click()
			[+] if (QuickenHelp.Exists(3))
				[ ] sleep(2)
				[ ] QuickenHelp.SetActive()
				[+] do
					[ ] QuickenHelp.TextClick("Customize the Home tab")
					[ ] ReportStatus("Verify that user is able to launch help from Customize view dialog." , PASS , "Customize the Home tab content is displayed on Help window")
				[+] except
					[ ] ReportStatus("Verify that user is able to launch help from Customize view dialog." , FAIL , "Customize the Home tab content is not displayed on Help window")
					[ ] goto CLOSE
					[ ] 
				[ ] 
				[ ] CLOSE:
				[ ] QuickenHelp.Close()
				[ ] WaitForState( QuickenHelp , False ,3)
			[+] else
				[ ] ReportStatus("Verify that user is able to launch help from Customize view dialog." , FAIL , "Help didn't launch from Customize view dialog.")
			[ ] 
			[ ] CustomizeView.SetActive()
			[ ] CustomizeView.Cancel.Click()
			[ ] WaitForState( CustomizeView , False ,3)
			[ ] 
		[+] else
			[ ] ReportStatus("Verify that Customize view dialog gets launched when clicked on Customize view button." , FAIL , "Customize View dialog didn't appear on clicking Customize view button.")
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //##########Test 17 -Verify that user is able to add snapshot for any view. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test17_VerifyThatUserIsAbleToAddSnapshotForAnyView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to add snapshot for any view.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to add snapshot for any view.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 26 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test17_VerifyThatUserIsAbleToAddSnapshotForAnyView() appstate NavigateToHomeTab
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sSubtotal , sSubTotalAmount
		[ ] sSubtotal = "Subtotal"
		[ ] sSubTotalAmount = "17,100.08"
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[+] //Verify Alerts snapshot has been added to the view
			[ ] iResult =SelectCustomizeViewItems("Alerts")
			[ ] QuickenWindow.SetActive()
			[+] if (MDIClient.Home.ShowAllAlertsButton.Exists(3))
				[ ] ReportStatus("Verify Alerts snapshot has been added to the view." , PASS , "Alerts snapshot has been added to the view.")
			[+] else
				[ ] ReportStatus("Verify Alerts snapshot has been added to the view." , FAIL , "Alerts snapshot couldn't be added to the view.")
		[+] //Verify All Accounts snapshot has been added to the view
			[ ] QuickenWindow.SetActive()
			[ ] SelectCustomizeViewItems("All Accounts")
			[ ] QuickenWindow.SetActive()
			[ ] sHandle= Str(MDIClient.Home.ListBox1.GetHandle())
			[ ] iListCount= MDIClient.Home.ListBox1.GetItemCount() +1
			[+] for(iCount= 0; iCount <= iListCount;  iCount++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr("*{sSubtotal}*{sSubTotalAmount}*", sActual)
				[ ] 
				[+] if(bMatch)
					[ ] break
			[ ] 
			[+] if (bMatch)
				[ ] ReportStatus("Verify All Accounts snapshot has been added to the view." , PASS , "All Accounts snapshot has been added to the view as Spending accounts amount is as expected: {sActual}.")
			[+] else
				[ ] ReportStatus("Verify All Accounts snapshot has been added to the view." , FAIL , "All Accounts snapshot has been added to the view NOT as expected as Spending accounts amount is:  {sActual} NOT as expected: {sSubtotal}, {sSubTotalAmount}.")
		[+] //Verify Calendar snapshot has been added to the view
			[ ] QuickenWindow.SetActive()
			[ ] iResult =SelectCustomizeViewItems("Calendar")
			[ ] QuickenWindow.SetActive()
			[+] if (MDIClient.Home.GoButton.Exists(3))
				[ ] ReportStatus("Verify Calendar snapshot has been added to the view." , PASS , "Calendar snapshot has been added to the view.")
			[+] else
				[ ] ReportStatus("Verify Calendar snapshot has been added to the view." , FAIL , "Calendar snapshot couldn't be added to the view.")
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
[+] //##########Test 18 -Verify that user is able to remove snapshot for any view. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test18_VerifyThatUserIsAbleToRemoveSnapshotFromAnyView
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to add snapshot from any view.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to remove snapshot from any view.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 26 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test18_VerifyThatUserIsAbleToRemoveSnapshotFromAnyView() appstate NavigateToHomeTab
	[ ] 
	[ ] 
	[ ] 
	[+] //--------------Variable Declaration-------------
		[ ] STRING sSubtotal , sSubTotalAmount
		[ ] sSubtotal = "Subtotal"
		[ ] sSubTotalAmount = "17,100.08"
		[ ] 
		[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Remove all the snapshots 
		[ ] DeSelectCustomizeViewItems()
		[+] //Verify Alerts snapshot has been removed from the view
			[ ] QuickenWindow.SetActive()
			[+] if (MDIClient.Home.ShowAllAlertsButton.Exists(3))
				[ ] ReportStatus("Verify that user is able to remove snapshot from any view." , FAIL , "Alerts snapshot couldn't be removed to the view.")
			[+] else
				[ ] ReportStatus("Verify that user is able to remove snapshot from any view." , PASS , "Alerts snapshot has been removed from the view.")
		[+] //Verify All Accounts snapshot has been removed from the view
			[ ] QuickenWindow.SetActive()
			[ ] 
			[+] if ( MDIClient.Home.ListBox1.Exists(2))
				[ ] ReportStatus("Verify that user is able to remove snapshot from any view." , FAIL , "All Accounts snapshot couldn't be removed to the view.")
			[+] else
				[ ] ReportStatus("Verify that user is able to remove snapshot from any view." , PASS , "All Accounts snapshot has been removed from the view.")
		[+] //Verify Calendar snapshot has been removed from the view
			[ ] QuickenWindow.SetActive()
			[+] if (MDIClient.Home.GoButton.Exists(3))
				[ ] ReportStatus("Verify that user is able to remove snapshot from any view." , FAIL , "Calendar snapshot couldn't be removed to the view.")
			[+] else
				[ ] ReportStatus("Verify that user is able to remove snapshot from any view." , PASS , "Calendar snapshot has been removed from the view.")
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
[+] //##########Test 24 - Verify that user is able to delete any view from customize dialog. #####################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test24_VerifyThatUserIsAbleToDeleteAnyViewFromCustomizeDialog
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify that user is able to delete any view from customize dialog.
		[ ] //
		[ ] // PARAMETERS:		NavigateToHomeTab
		[ ] //
		[ ] // RETURNS:			Pass 		If user is able to delete any view from customize dialog.
		[ ] //						Fail		      If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // Mukesh created  Feb 28 2013
		[ ] //
	[ ] // ********************************************************
[+] testcase Test24_VerifyThatUserIsAbleToDeleteAnyViewFromCustomizeDialog() appstate NavigateToHomeTab
	[+] //--------------Variable Declaration-------------
		[ ] 
		[ ] sViewName= "ViewToBeDeleted"
		[ ] 
		[ ] 
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] ///Add one view
		[ ] iResult= AddView(sViewName)
		[+] if (iResult==PASS)
			[ ] 
			[+] do
				[ ] QuickenMainWindow.TextClick(sViewName)
				[ ] ReportStatus("Verify that user is able to navigate to created view." , PASS , "The user is able to navigate to created view: {sViewName}.")
				[ ] sleep(2)
				[ ] QuickenWindow.SetActive()
				[ ] QuickenMainWindow.Customize.Click()
				[+] if (CustomizeView.Exists(3))
					[ ] CustomizeView.SetActive()
					[+] if (CustomizeView.DeleteThisView.IsEnabled())
						[ ] CustomizeView.DeleteThisView.Click()
						[+] if (AlertMessage.Exists(2))
							[ ] AlertMessage.SetActive()
							[ ] AlertMessage.Yes.Click()
							[ ] WaitForState(AlertMessage , false ,5)
							[+] do
								[ ] QuickenMainWindow.TextClick(sViewName)
								[ ] ReportStatus("Verify that user is able to navigate to created view." , FAIL , "The view: {sViewName}  couldn't be deleted as user is still able to navigate to it.")
								[ ] 
								[ ] 
							[+] except
								[ ] ReportStatus("Verify that user is able to navigate to created view." , PASS , "The view: {sViewName} has successfully been deleted.")
						[+] else
							[ ] ReportStatus("Verify View delete confirmation appeared." , FAIL , "View delete confirmation didn't appear.")
					[+] else
						[ ] ReportStatus("Verify Delete This View button is enabled on Customize View dialog." , FAIL , " Delete This View button is disabled on Customize View dialog.")
					[ ] 
				[+] else
					[ ] ReportStatus("Verify Customize View dialog." , FAIL , "Customize View dialog didn't appear.")
					[ ] 
				[ ] 
				[ ] 
				[ ] 
			[+] except
				[ ] ReportStatus("Verify that user is able to navigate to created view." , FAIL , "The user couldn't navigate to created view: {sViewName}.")
			[ ] 
			[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify veiw has been added." , FAIL , "View: {sViewName} couldn't be added successfully.")
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify Quicken Exists. ", FAIL , "Quicken does not exist.") 
	[ ] 
	[ ] 