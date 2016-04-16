﻿[+] // FILE NAME:	<MenuNavigation.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Menu Navigation test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube
	[ ] //
	[ ] // Developed on: 		21/2/2011
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Feb 21, 2011	Udita Dube  Created
	[ ] // *********************************************************
[ ] // *********************************************************
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] // Global variables
	[ ] public LIST OF ANYTYPE  lsExcelData
	[ ] INTEGER i,iCount,iPos,iSelect
	[ ] public LIST OF STRING lsTestData
	[ ] public STRING sCaption
	[ ] public BOOLEAN bMatch
	[ ] // public string sBrowser="$C:\Program Files\Internet Explorer\iexplore.exe"
	[ ] public string sBrowser="$C:\Program Files (x86)\Internet Explorer\iexplore.exe"
	[ ] 
	[ ] public string sStartQuicken = "{QUICKEN_ROOT}\qw.exe"
	[ ] public STRING sFileName = "Navigation"
	[ ] public STRING sMainWindow="/WPFWindow[@caption='Quicken 20*']"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sFileWorksheet = "_File"
	[ ] public STRING sEditWorksheet = "_Edit"
	[ ] public STRING sToolsWorksheet = "_Tools"
	[ ] public STRING sReportsWorksheet = "_Reports"
	[ ] public STRING sHomeWorksheet = "H_ome"
	[ ] public STRING sBillWorksheet = "_Bills"
	[ ] public STRING sSpendingWorksheet = "_Spending"
	[ ] public STRING sInvestingWorksheet = "_Investing"
	[ ] public STRING sPropertyDebtWorksheet = "Property & _Debt"
	[ ] public STRING sTipsTutorialWorksheet = "Tips & Tutoria_ls"
	[ ] public STRING sPlanningWorksheet = "_Planning"
	[ ] public STRING sBusinessWorksheet = "B_usiness"
	[ ] public STRING sViewWorksheet = "_View"
	[ ] public STRING sRentalPropertyWorksheet = "Re_ntal Property"
	[ ] public STRING sHelpWorksheet = "_Help"
	[ ] public STRING sAccount = "Checking 01 Account"
	[ ] public STRING sPath = XLS_DATAFILE_PATH + "\Navigation\"
	[ ] 
[ ] 
[+] public INTEGER VerifyMenuItemExistence(STRING sMenuName)
	[ ] 
	[ ] INTEGER iFunctionResult
	[ ] 
	[+] do 
		[ ] QuickenWindow.SetActive()
		[+] if(Desktop.Find("/WPFWindow[@caption='Quicken 201*']//WPFMenuItem[@automationId={sMenuName}]").Exists())
			[ ] iFunctionResult=PASS
		[+] else
			[ ] iFunctionResult=FAIL
	[+] except
		[ ] iFunctionResult=FAIL
	[ ] 
	[ ] return iFunctionResult
[+] public VOID VerifyInternetExplorerCaption(STRING sExpectedCaption)
	[ ] 
	[+] do
		[ ] // For synchronization, as browser takes time to load
		[ ] sleep(EXTRA_LONG_SLEEP)
		[+] if(InternetExplorer.DlgInternetSettings.Exists(SHORT_SLEEP))
			[ ] InternetExplorer.DlgInternetSettings.SetActive()
			[ ] InternetExplorer.DlgInternetSettings.Close()
		[+] if(InternetExplorer.BrowserWindow.Alert.Exists(SHORT_SLEEP))
			[ ] InternetExplorer.SetActive()
			[ ] InternetExplorer.BrowserWindow.Alert.Close.DomClick()
		[ ] 
		[ ] InternetExplorer.SetActive()
		[ ] sCaption=InternetExplorer.GetCaption()
		[ ] 
		[ ] bMatch = MatchStr("*{sExpectedCaption}*", sCaption)
		[+] if(bMatch == TRUE)
			[ ] ReportStatus("Validate {sExpectedCaption} option", PASS, "{sExpectedCaption} page is opened in Browser")
		[+] else
			[ ] ReportStatus("Validate {sExpectedCaption} option", FAIL, "{sExpectedCaption} page is not opened in Browser, Actual: {sCaption}")
		[ ] 
		[ ] InternetExplorer.Close()
		[ ] 
	[+] except
		[ ] ExceptLog()
[+] public VOID verifyStandardMenus()
	[ ] 
	[ ] BOOLEAN bCheck
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.View.Click()
	[ ] 
	[ ] bCheck = QuickenWindow.View.StandardMenusRecommended.IsChecked
	[ ] 
	[+] if (!bCheck)
		[ ] QuickenWindow.MainMenu.Select("/_view/_Standard Menus (recommended)")
	[+] else
		[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
	[ ] 
	[+] if (QuickenWindow.Business.Exists())
		[ ] ReportStatus("Standard Menus is Checked", FAIL, "Business Menu should not present if standard menus is checked")
	[+] else
		[ ] ReportStatus("Standard Menus is Checked", PASS, "Business Menu not present if standard menus is checked")
		[ ] 
	[ ] 
	[ ] 
[+] public VOID verifyClassicMenus()
	[ ] 
	[+] LIST OF WINDOW lwMenus = {...}
		[ ] QuickenWindow.Home
		[ ] QuickenWindow.Bills
		[ ] QuickenWindow.Business
	[ ] INTEGER iCount
	[ ] 
	[ ] 
	[ ] BOOLEAN bCheck
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.View.Click()
	[ ] 
	[+] if (!QuickenWindow.View.ClassicMenus.IsChecked)
		[ ] QuickenWindow.MainMenu.Select("/_view/_Classic Menus")
		[ ] sleep(2)
	[+] else
		[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
	[ ] 
	[+] for iCount = 1 to ListCount (lwMenus)
		[+] if (lwMenus[iCount].Exists(2))
			[ ] ReportStatus("Classic Menu is Checked", PASS, "Classic menu is checked, {lwMenus[iCount].getProperty("caption")} Menu is present")
		[+] else
			[ ] ReportStatus("Classic Menu is Checked", FAIL, "Classic menu is checked, {lwMenus[iCount].getProperty("caption")} Menu not present")
			[ ] 
		[ ] 
	[ ] 
	[ ] 
[+] public VOID usePopupRegisters(STRING accountName, STRING accountType)
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] UsePopupRegister("ON")
	[ ] 
	[ ] SelectAccountFromAccountBar(accountName,accountType)
	[ ] sleep(4)
	[ ] 
	[ ] BOOLEAN bExist = BankingPopUp.Exists(SHORT_SLEEP)
	[+] if(bExist == TRUE)
		[ ] ReportStatus("Popup register window", PASS, "Popup register window is displayed") 
		[ ] BankingPopUp.SetActive ()
		[ ] BankingPopUp.Close ()
	[+] else
		[ ] ReportStatus("Popup register window", FAIL, "Popup register window is not displayed") 
	[ ] 
	[ ] UsePopupRegister("OFF")
	[ ] 
	[ ] SelectAccountFromAccountBar(accountName,accountType)
	[ ] 
	[ ] sleep(4)
	[ ] bExist = BankingPopUp.Exists(SHORT_SLEEP)
	[+] if(bExist != TRUE)
		[ ] ReportStatus("Popup register window", PASS, "Popup register window not displayed") 
	[+] else
		[ ] ReportStatus("Popup register window", FAIL, "Popup register window is displayed") 
	[ ] 
[+] public VOID verifyShowTabs()
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.View.Click()
	[ ] 
	[+] if (!QuickenWindow.View.ShowTabs.IsChecked)
		[ ] QuickenWindow.MainMenu.Select("/_view/Show _Tabs")
		[ ] sleep(2)
	[+] else
		[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
	[ ] 
	[+] if(QuickenMainWindow.QWNavigator.Home.Exists(SHORT_SLEEP))
		[ ] ReportStatus("Validate View > ShowTabs Option", PASS, "View > ShowTabs is checked, Home tab is displayed") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate View > ShowTabs Option", FAIL, "View > ShowTabs is checked, Home tab is not displayed") 
	[ ] 
	[ ] // uncheck the option
	[ ] QuickenWindow.MainMenu.Select("/_view/Show _Tabs")
	[ ] sleep(2)
	[ ] 
	[+] if(QuickenMainWindow.QWNavigator.Home.Exists(SHORT_SLEEP))
		[ ] ReportStatus("Validate View > ShowTabs Option", FAIL, "View > ShowTabs is not checked, but Home tab is displayed") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate View > ShowTabs Option", PASS, "View > ShowTabs is Unchecked, Home tab is not displayed") 
	[ ] 
[+] public VOID verifyShowToolBar()
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.View.Click()
	[ ] 
	[+] if (!QuickenWindow.View.ShowToolBar.IsChecked)
		[ ] QuickenWindow.MainMenu.Select("/_view/Show T_oolbar")
		[ ] sleep(2)
	[+] else
		[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
	[ ] 
	[ ] 
	[+] if(QuickenMainWindow.ToolBar.Exists(SHORT_SLEEP))
		[ ] ReportStatus("Validate View > ShowToolBar Option", PASS, "View > ShowToolBar is checked, ToolBar is displayed") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate View > ShowToolBar Option", FAIL, "View > ShowToolBar is checked, ToolBar is not displayed") 
	[ ] 
	[ ] 
	[ ] QuickenWindow.MainMenu.Select("/_view/Show T_oolbar")
	[ ] sleep(2)
	[ ] 
	[+] if(!QuickenMainWindow.ToolBar.Exists(SHORT_SLEEP))
		[ ] ReportStatus("Validate View > ShowToolBar Option", PASS, "View > ShowToolBar is Unchecked, ToolBar is not displayed") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate View > ShowToolBar Option", FAIL, "View > ShowToolBar is Unchecked, ToolBar is displayed") 
	[ ] 
[+] public VOID verifyAccountBar()
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.View.Click()
	[ ] QuickenWindow.View.AccountBar.Click()
	[ ] 
	[ ] // uncheck the option
	[+] if (!Desktop.Find("//WPFMenuItem[@caption='_Dock Account Bar']").IsChecked)
		[ ] QuickenWindow.MainMenu.Select("/_View/Account _Bar/_Dock Account Bar")
		[ ] sleep(2)
	[+] else
		[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
		[ ] sleep(1)
	[ ] 
	[+] if(QuickenMainWindow.QWNavigator.Accounts.IsEnabled())
		[ ] ReportStatus("Validate AccountBar Option", PASS, "Dock Accountbar option is unchecked,Account bar is not expanded") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate AccountBar Option", FAIL, "Dock Accountbar option is unchecked,Account bar found expanded") 
	[ ] 
	[ ] // Uncheck the option
	[ ] QuickenWindow.MainMenu.Select("/_View/Account _Bar/_Dock Account Bar")
	[ ] sleep(2)
	[+] if(! QuickenMainWindow.QWNavigator.Accounts.IsEnabled())
		[ ] ReportStatus("Validate AccountBar Option", PASS, "Dock Accountbar option is checked,Account bar is expanded") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate AccountBar Option", FAIL, "Dock Accountbar option is checked,Account bar found not expanded") 
	[ ] 
	[ ] // check the option
	[ ] QuickenWindow.MainMenu.Select("/_View/Account _Bar/_Dock Account Bar")
	[ ] sleep(2)
	[ ] 
	[ ] // select on left
	[ ] QuickenWindow.View.Click()
	[ ] sleep(1)
	[ ] QuickenWindow.View.AccountBar.Click()
	[ ] sleep(1)
	[ ] Desktop.Find("//WPFMenuItem[@caption='On _Left']").Click()
	[ ] sleep(1)
	[ ] 
	[ ] QuickenWindow.SetActive ()
	[ ] QuickenWindow.Maximize()      
	[ ] ExpandAccountBar()
	[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.DoubleClick()
	[+] if(AddAccount.Exists(SHORT_SLEEP))
		[ ] AddAccount.Close()
		[ ] ReportStatus("Validate AccountBar > On left Option", PASS, "AccountBar > On left checked, 'Add Account' window is displayed") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate AccountBar > On left Option", PASS, "AccountBar > On left checked, 'Add Account' window not displayed") 
	[ ] 
	[ ] 
[+] public VOID dockHelpBar()
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.View.Click()
	[ ] 
	[ ] // check the option
	[+] if (!QuickenWindow.View.DockHelpAndToDoBar.IsChecked)
		[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
		[ ] sleep(1)
		[ ] QuickenWindow.View.Click()
		[ ] sleep(1)
		[ ] QuickenWindow.View.DockHelpAndToDoBar.Click()
		[ ] sleep(2)
	[+] else
		[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
	[ ] 
	[+] if(QuickenMainWindow.ViewReminders.Exists(MEDIUM_SLEEP))
		[ ] ReportStatus("Validate 'View > DockHelpAndToDoBar' Option", PASS, "'View > DockHelpAndToDoBar' checked, 'View Reminders' button is displayed") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate 'View > DockHelpAndToDoBar' Option", FAIL, "'View > DockHelpAndToDoBar' checked but 'View Reminders' button not displayed") 
	[ ] 
	[ ] // unchekc the option
	[ ] QuickenWindow.View.Click()
	[ ] sleep(1)
	[ ] QuickenWindow.View.DockHelpAndToDoBar.Click()
	[ ] sleep(2)
	[+] if(!QuickenMainWindow.QWNavigator.QSideBar.QWPanel.OneStepUpdate.Exists(SHORT_SLEEP))
		[ ] ReportStatus("Validate 'View > DockHelpAndToDoBar' Option", PASS, "'View > DockHelpAndToDoBar' Unchecked, 'OSU' button is not displayed") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate 'View > DockHelpAndToDoBar' Option", FAIL, "'View > DockHelpAndToDoBar' Unchecked, 'OSU' button is displayed") 
	[ ] 
[+] public VOID verifyViewTabsToShow()
	[ ] INTEGER iCount
	[+] LIST OF STRING lsTabsToShow = <text>
		[ ] _Spending
		[ ] _Bills
		[ ] _Planning
		[ ] _Rental Property
		[ ] _Investing 
		[ ] Property & _Debt
		[ ] _Mobile & Alerts
		[ ] Tips & Tutoria_ls
		[ ] B_usiness
	[+] LIST OF WINDOW lwTabs = {...}
		[ ] QuickenMainWindow.QWNavigator.Spending
		[ ] QuickenMainWindow.QWNavigator.Bills
		[ ] QuickenMainWindow.QWNavigator.Planning
		[ ] QuickenMainWindow.QWNavigator.RentalProperty
		[ ] QuickenMainWindow.QWNavigator.Investing
		[ ] QuickenMainWindow.QWNavigator.PropertyDebt
		[ ] QuickenMainWindow.QWNavigator.MobileAlerts
		[ ] QuickenMainWindow.QWNavigator.TipsTutorials
		[ ] QuickenWindow.Business
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.View.Click()
	[+] if (!QuickenWindow.View.ShowTabs.IsChecked)
		[ ] QuickenWindow.MainMenu.Select("/_view/Show _Tabs")
		[ ] sleep(2)
	[ ] 
	[ ] // uncheck tab and verify
	[+] for iCount = 1 to ListCount(lsTabsToShow)
		[ ] uncheckTabsToShow(lsTabsToShow[iCount])
		[ ] 
		[+] if (iCount == ListCount(lsTabsToShow))
			[+] if (QuickenWindow.Business.getProperty("ActualWidth") != 0.0 )
				[ ] ReportStatus("'UnCheck View > Tabs to show > {lsTabsToShow[iCount]}' Option", FAIL, "'UnChecked 'View > Tabs to show > {lsTabsToShow[iCount]}' Option, Tab {lsTabsToShow[iCount]} exists") 
			[+] else
				[ ] ReportStatus("'UnCheck View > Tabs to show > {lsTabsToShow[iCount]}' Option", PASS, "'UnChecked 'View > Tabs to show > {lsTabsToShow[iCount]}' Option, Tab {lsTabsToShow[iCount]} not exists") 
			[ ] continue
		[ ] 
		[+] if (! lwTabs[iCount].Exists())
			[ ] ReportStatus("'UnCheck View > Tabs to show > {lsTabsToShow[iCount]}' Option", PASS, "'UnCheck View > Tabs to show > {lsTabsToShow[iCount]}' Option, Tab {lsTabsToShow[iCount]} is not displayed") 
		[+] else
			[+] if (lwTabs[iCount].getProperty("Caption") == "B_usiness")
				[ ] ReportStatus("'UnCheck View > Tabs to show > {lsTabsToShow[iCount]}' Option", FAIL, "'UnChecked 'View > Tabs to show > {lsTabsToShow[iCount]}' Option, Tab {lsTabsToShow[iCount]} exists") 
			[ ] 
	[ ] 
	[ ] // check tab and verify
	[+] for iCount = 1 to ListCount(lsTabsToShow)
		[ ] checkTabsToShow(lsTabsToShow[iCount])
		[ ] 
		[+] if (iCount == ListCount(lsTabsToShow))
			[+] if (QuickenWindow.Business.getProperty("ActualWidth") == 0.0 )
				[ ] ReportStatus("'Check View > Tabs to show > {lsTabsToShow[iCount]}' Option", FAIL, "'Checked 'View > Tabs to show > {lsTabsToShow[iCount]}' Option, Tab {lsTabsToShow[iCount]} does not exists") 
			[+] else
				[ ] ReportStatus("'Checked View > Tabs to show > {lsTabsToShow[iCount]}' Option", PASS, "'Checked 'View > Tabs to show > {lsTabsToShow[iCount]}' Option, Tab {lsTabsToShow[iCount]} exists") 
			[ ] continue
		[ ] 
		[+] if (lwTabs[iCount].Exists())
			[ ] ReportStatus("'Check View > Tabs to show > {lsTabsToShow[iCount]}' Option", PASS, "'Checked View > Tabs to show > {lsTabsToShow[iCount]}' Option, Tab {lsTabsToShow[iCount]} is displayed") 
		[+] else
			[ ] ReportStatus("'Check View > Tabs to show > {lsTabsToShow[iCount]}' Option", FAIL, "'Checked 'View > Tabs to show > {lsTabsToShow[iCount]}' Option, Tab {lsTabsToShow[iCount]} not exists") 
			[ ] 
	[ ] 
[+] public VOID checkTabsToShow (STRING sTab)
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
	[ ] QuickenWindow.View.Click()
	[ ] sleep(1)
	[ ] QuickenWindow.View.TabsToShow.Click()
	[ ] 
	[+] if (! Desktop.Find("//WPFMenuItem[@caption='{trim(sTab)}']").IsChecked)
		[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
		[ ] sleep(1)
		[ ] QuickenWindow.View.Click()
		[ ] sleep(1)
		[ ] QuickenWindow.View.TabsToShow.Click()
		[ ] sleep(1)
		[ ] Desktop.Find("//WPFMenuItem[@caption='{trim(sTab)}']").Click()
		[ ] sleep(2)
[+] public VOID uncheckTabsToShow (STRING sTab)
	[ ] 
	[ ] 
	[ ] QuickenWindow.SetActive()
	[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
	[ ] QuickenWindow.View.Click()
	[ ] sleep(1)
	[ ] QuickenWindow.View.TabsToShow.Click()
	[ ] 
	[ ] 
	[+] if (Desktop.Find("//WPFMenuItem[@caption='{trim(sTab)}']").IsChecked)
		[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
		[ ] sleep(1)
		[ ] QuickenWindow.View.Click()
		[ ] sleep(1)
		[ ] QuickenWindow.View.TabsToShow.Click()
		[ ] sleep(1)
		[ ] Desktop.Find("//WPFMenuItem[@caption='{trim(sTab)}']").Click()
		[ ] sleep(2)
[+] public VOID SelectAnAccountOfType (STRING sAccountType)
	[ ] 
	[+] //Variable Declaration
		[ ] STRING sHandle,sActual
		[ ] INTEGER iRow,iCount,i
		[ ] INTEGER iXCords=38
		[ ] INTEGER iYCords=5
		[ ] STRING sPattern="^^@@@"
		[ ] INTEGER iIncrement1=21  //Increment for Account
		[ ] INTEGER iIncrement2=1   //Increment for Pattern
		[ ] INTEGER iDecriment=15
		[ ] INTEGER iAccountNotFound
		[ ] 
	[ ] 
	[+] do
		[ ] 
		[ ] QuickenWindow.SetActive()
		[ ] 
		[ ] 
		[ ] //Get Handle and List count from specific account type on Account Bar
		[+] switch(sAccountType)
			[+] case "Banking"
				[ ] iCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetItemCount()
			[ ] 
			[+] case "Rental Property"
				[ ] iCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer2.ListBox.GetItemCount()
			[ ] 
			[+] case "Business"
				[ ] iCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.GetItemCount()
			[ ] 
			[+] case "Investing"
				[ ] iCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer4.ListBox.GetItemCount()
			[ ] 
			[+] case "Property & Debt"
				[ ] iCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.GetItemCount()
			[ ] 
			[+] case "Savings Goals"
				[ ] iCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer6.ListBox.GetItemCount()
			[ ] 
			[+] case "Separate"
				[ ] iCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer7.ListBox.GetItemCount()
			[ ] 
			[+] case "Business Banking"
				[ ] iCount=QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.GetItemCount()
			[ ] 
			[-] default
				[ ] raise -1, "Invalid account type [{sAccountType}]"
		[ ] 
		[ ] 
		[+] if(iCount > 0)
			[ ] 
			[ ] 
			[+] switch(sAccountType)
				[-] case "Banking"
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.Click(1,iXCords,iYCords)
				[-] case "Business Banking"
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.Click(1,iXCords,iYCords)
				[-] case "Rental Property"
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer2.ListBox.Click(1,iXCords,iYCords)
				[-] case "Business"
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.Click(1,iXCords,iYCords)
				[-] case "Investing"
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer4.ListBox.Click(1,iXCords,iYCords)
				[-] case "Property & Debt"
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.Click(1,iXCords,iYCords)
				[-] case "Savings Goals"
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer6.ListBox.Click(1,iXCords,iYCords)
				[-] case "Separate"
					[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer7.ListBox.Click(1,iXCords,iYCords)
			[ ] 
			[ ] CloseRegisterReminderInfoPopup()
			[ ] 
			[ ] 
		[+] else
				[ ] raise -1, "No accounts present for account type [{sAccountType}]"
		[ ] 
	[+] except
		[ ] Exceptlog()
	[ ] sleep(2)
	[ ] 
[ ] 
[ ] 
[+] //#############  Verify Quicken File Menu Navigation ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:Test01_FileMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken File Menu 
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY: 21/2/2011  Created By	Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[-] testcase Test01_FileMenuNavigation () appstate NavigationBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iSetupAutoAPI
		[ ] STRING sExpectedWindowTitle,sActualWindowTitle
		[ ] WINDOW wDialogBox
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sNavigationData, sFileWorksheet,sPath)
	[ ] 
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] SetViewMode(VIEW_CLASSIC_MENU)
	[ ] iSetupAutoAPI = SetUp_AutoApi()			// copy qwautoap.dll to Quicken folder in Program files
	[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
	[+] for(i=1;i<=iCount;i++)
		[ ] 
		[+] do
			[+] if (QuickenWindow.Exists() == True)
				[ ] 
				[ ] // Active Quicken Screen
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ] // Check for multiple navigation
				[ ] iPos= StrPos(">",lsExcelData[i][1])
				[+] if(trim(lsExcelData[i][2]) == "TestData")
					[ ] sleep(SHORT_SLEEP)
					[ ] Desktop.Find("{sMainWindow}//WPFMenuItem[@caption='_File']//WPFMenuItem[@caption='Show this file on _my computer']").Select()
					[+] // if(TestDataLocalDrive.Exists(SHORT_SLEEP))
						[ ] // ReportStatus("Validate {lsExcelData[i][1]} window", PASS, "{lsExcelData[i][1]} window is displayed") 
						[ ] // TestDataLocalDrive.SetActive()
						[ ] // TestDataLocalDrive.Close()
					[+] // else
						[ ] // ReportStatus("Validate {lsExcelData[i][1]} window", FAIL, "{lsExcelData[i][1]} window is not displayed") 
						[ ] // 
				[+] else if( iPos != 0)
					[ ] lsTestData=split(lsExcelData[i][1],">")
					[ ] 
					[+] if(StrPos("/",lsTestData[2]) > 0)
						[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
						[ ] lsTestData[2]=trim(lsTestData[2])
						[ ] lsTestData[1]=trim(lsTestData[1])
					[ ] sleep(SHORT_SLEEP)
					[ ] // Select menu item
					[ ] QuickenWindow.MainMenu.Select("/{trim(sFileWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
					[ ] sleep(SHORT_SLEEP)
				[+] else
					[ ] QuickenWindow.SetActive()
					[ ] // Select menu item
					[ ] // QuickenWindow.WPFMenuItem(sFileWorksheet).WPFMenuItem(lsExcelData[i][1]).Select()
					[ ] // Desktop.Find("{sMainWindow}//WPFMenuItem[@caption='{sFileWorksheet}']//WPFMenuItem[@caption='{lsExcelData[i][1]}']").Select()
					[ ] lsExcelData[i][1]=trim(lsExcelData[i][1])
					[ ] QuickenWindow.MainMenu.Select("/{trim(sFileWorksheet)}/{lsExcelData[i][1]}*")
					[ ] sleep(SHORT_SLEEP)
				[ ] 
				[+] if(lsExcelData[i][3] == "Other")
					[ ] sExpectedWindowTitle = "Create Tax Export File"
					[ ] 
					[ ] 
					[+] if (TaxDlg.Exists())
						[ ] TaxDlg.SetFocus()
						[ ] wDialogBox=Desktop.Find("//DialogBox") //TaxDlg.Getparent()
						[ ] sActualWindowTitle=wDialogBox.getproperty("caption")
						[+] if(sActualWindowTitle==sExpectedWindowTitle)
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
							[ ] TaxDlg.TypeKeys(KEY_EXIT)
						[+] else
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
				[ ] // If Popup window then check window caption and close popup
				[+] if(lsExcelData[i][3] == "Popup")
					[ ] // if(QuickenMainWindow.FileDlg(lsExcelData[i][2]).Exists(5))
					[+] if(lsExcelData[i][2]=="Import RPM Data File ")
						[+] if(Desktop.Find("/{sMainWindow}//{lsExcelData[i][4]}[@caption='{lsExcelData[i][2]}']").Exists())
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
							[ ] // QuickenMainWindow.FileDlg(lsExcelData[i][2]).SetActive()
							[ ] // QuickenMainWindow.FileDlg(lsExcelData[i][2]).Close()
							[ ] Desktop.Find("/{sMainWindow}//{lsExcelData[i][4]}[@caption='{lsExcelData[i][2]}']").SetActive()
							[ ] Desktop.Find("/{sMainWindow}//{lsExcelData[i][4]}[@caption='{lsExcelData[i][2]}']").Close()
							[ ] 
						[ ] 
					[+] else if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists())
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
						[ ] 
					[+] else if (trim(lsTestData[2])=="_Addresses")
						[ ] sCaption=ImportAddressRecords.GetCaption()
						[+] if(lsExcelData[i][2]==sCaption)
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, " Expected - {lsExcelData[i][2]} window title is displayed")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
							[ ] 
						[+] if(ImportAddressRecords.Exists())
							[ ] ImportAddressRecords.Close ()
						[+] if(AddressBookAllGroups.Exists())
							[ ] AddressBookAllGroups.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
					[ ] 
					[+] if(AddressBookAllGroups.Exists())
						[ ] AddressBookAllGroups.Close()
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] 
			[ ] 
			[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] // QuickenMainWindow.kill()
			[ ] // Sleep(3)
			[ ] // QuickenMainWindow.Start (sStartQuicken)
			[ ] // continue
		[ ] 
		[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[+] //############# Verify Quicken Home Menu  Navigation ###################################
	[ ] // ********************************************************
	[+] // TestCase Name: Test05_HomeMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken Home menu
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 23/2/2011  Created By Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test05_HomeMenuNavigation () appstate NavigationBaseState
	[ ] 
	[+] // Variable declaration
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sNavigationData, sHomeWorksheet,sPath)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[+] for(i=1;i<=iCount;i++)
		[ ] 
		[+] do
			[+]  if (QuickenWindow.Exists() == True)
				[ ] 
				[ ] // Active Quicken Screen
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
				[ ] 
				[ ]  // Check for multiple navigation
				[ ] iPos= StrPos(">",lsExcelData[i][1])
				[+] if( iPos != 0)
					[ ] lsTestData=split(lsExcelData[i][1],">")
					[ ] 
					[+] if(StrPos("/",lsTestData[2]) > 0)
						[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
					[ ] sleep(SHORT_SLEEP)
					[ ] // Select menu item
					[ ] QuickenWindow.MainMenu.Select("/{trim(sHomeWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}")
					[ ] sleep(1)
					[ ] 
				[+] else
					[+] if(StrPos("/",lsExcelData[i][1]) > 0)
						[ ] lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
					[ ] // Select menu item
					[ ] QuickenWindow.MainMenu.Select("/{trim(sHomeWorksheet)}/{trim(lsExcelData[i][1])}*")
					[ ] sleep(1)
				[ ] 
				[ ] // If Popup window then check window caption and close popup
				[+] if(lsExcelData[i][3] == "Popup")
					[ ] 
					[+] if(StrPos("/",lsExcelData[i][2]) > 0)
						[ ] lsExcelData[i][2] = StrTran (lsExcelData[i][2], "/", "?")
					[+] if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists())
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] sleep(SHORT_SLEEP)
						[ ] 
						[ ] // Close Popup window
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
						[ ] sleep(1)
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
				[ ] // If window Type is MDI, verify main window title
				[+] else
					[ ] sCaption=QuickenMainWindow.GetCaption()
					[ ] bMatch=MatchStr("*{lsExcelData[i][2]}*",sCaption)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, "{lsExcelData[i][2]} window is not displayed") 
						[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] continue
		[ ] 
		[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[+] //############# Verify Quicken Spending Menu  Navigation ###############################
	[ ] // ********************************************************
	[+] // TestCase Name: Test07_SpendingMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken Spending menu
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 23/2/2011  Created By Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test07_SpendingMenuNavigation () appstate NavigationBaseState
	[ ] 
	[+] // Variable declaration
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sNavigationData, sSpendingWorksheet,sPath)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[+] for(i=1;i<=iCount;i++)
		[ ] 
		[+] do
			[+]  if (QuickenWindow.Exists() == True)
				[ ] 
				[ ] // Active Quicken Screen
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
				[ ] 
				[ ]  // Check for multiple navigation
				[ ] iPos= StrPos(">",lsExcelData[i][1])
				[+] if( iPos != 0)
					[ ] lsTestData=split(lsExcelData[i][1],">")
					[ ] 
					[+] if(StrPos("/",lsTestData[2]) > 0)
						[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
					[ ] sleep(SHORT_SLEEP)
					[ ] // Select menu item
					[ ] QuickenWindow.MainMenu.Select("/{trim(sSpendingWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
					[ ] sleep(1)
					[ ] 
				[+] else
					[+] if(StrPos("/",lsExcelData[i][1]) > 0)
						[ ] lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
					[ ] // Select menu item
					[ ] QuickenWindow.MainMenu.Select("/{trim(sSpendingWorksheet)}/{lsExcelData[i][1]}")
					[ ] sleep(1)
				[ ] 
				[ ] // If Popup window then check window caption and close popup
				[+] if(lsExcelData[i][3] == "Popup")
					[ ] 
					[+] if(StrPos("/",lsExcelData[i][2]) > 0)
						[ ] lsExcelData[i][2] = StrTran (lsExcelData[i][2], "/", "?")
					[ ] 
					[+] if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists())
						[ ] sleep(SHORT_SLEEP)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] sleep(SHORT_SLEEP)
						[ ] // Close Popup window
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
						[ ] sleep(1)
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
				[ ] // Verify window title if window type is MDI
				[+] else
					[ ] sleep(2)
					[ ] sCaption=QuickenWindow.GetCaption()
					[ ] bMatch=MatchStr("*{lsExcelData[i][2]}*",sCaption)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, "{lsExcelData[i][2]} window is not displayed") 
						[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] 
		[+] except
			[ ] QuickenMainWindow.kill()
			[ ] Sleep(3)
			[ ] QuickenMainWindow.Start (sStartQuicken)
			[ ] continue
		[ ] 
		[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[+] //#############  Verify Quicken Edit Menu Navigation ####################################
	[ ] // ********************************************************
	[+] // TestCase Name: Test02_EditMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken Edit Menu
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 22/2/2011  	Created By	Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test02_EditMenuNavigation () appstate NavigationBaseState
	[ ] 
	[ ] BOOLEAN bFlag
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sNavigationData, sEditWorksheet,sPath)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[ ] // Select an account
	[ ]  AccountBarSelect(ACCOUNT_BANKING,1)
	[ ] 
	[+] for(i=1;i<=iCount;i++)
		[ ] 
		[+] do
			[+]  if (QuickenWindow.Exists() == True)
				[ ] 
				[ ] // Active Quicken Screen
				[ ] QuickenWindow.SetActive()
				[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
				[ ] 
				[ ]  // Check for multiple navigation
				[ ] iPos= StrPos(">",lsExcelData[i][1])
				[+] if( iPos != 0)
					[ ] lsTestData=split(lsExcelData[i][1],">")
					[ ] 
					[+] if(StrPos("/",lsTestData[2]) > 0)
						[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
					[ ] sleep(SHORT_SLEEP)
					[ ] // Select menu item
					[+] QuickenWindow.MainMenu.Select("/{trim(sEditWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
						[ ] // bFlag=TRUE
					[ ] sleep(1)
				[+] else
					[+] if(StrPos("/",lsExcelData[i][1]) > 0)
						[ ] lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
					[ ] // Select menu item
					[ ] QuickenWindow.SetActive()
					[ ] 
					[+] QuickenWindow.MainMenu.Select("/{trim(sEditWorksheet)}/{trim(lsExcelData[i][1])}*")
						[ ] // bFlag=TRUE
						[ ] 
					[ ] sleep(1)
					[ ] 
				[ ] 
				[ ] // If Popup window then check window caption and close popup
				[+] if(lsExcelData[i][3] == "Popup")
					[ ] 
					[+] if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists())
						[ ] sleep(SHORT_SLEEP)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] sleep(SHORT_SLEEP)
						[ ] // Close Popup window
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] // QuickenMainWindow.kill()
			[ ] // Sleep(3)
			[ ] // QuickenMainWindow.Start (sStartQuicken)
			[ ] // iSelect = AccountBarSelect(ACCOUNT_BANKING,1)
			[ ] // continue
		[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[+] //############# Verify Quicken Reports Menu  Navigation #################################
	[ ] // ********************************************************
	[+] // TestCase Name: Test04_ReportsMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken Reports Menu
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 23/2/2011  Created By Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test04_ReportsMenuNavigation () appstate NavigationBaseState
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sNavigationData, sReportsWorksheet,sPath)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[ ] // Select an account
	[ ] AccountBarSelect(ACCOUNT_BANKING,1)
	[ ] 
	[+] for(i=1;i<=iCount;i++)
		[ ] 
		[+] do
			[+]  if (QuickenWindow.Exists() == True)
				[ ] 
				[ ] // Active Quicken Screen
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ]  // Check for multiple navigation
				[ ] iPos= StrPos(">",lsExcelData[i][1])
				[+] if( iPos != 0)
					[ ] lsTestData=split(lsExcelData[i][1],">")
					[ ] 
					[+] if(StrPos("/",lsTestData[2]) > 0)
						[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
					[ ] sleep(SHORT_SLEEP)
					[ ] // Select menu item
					[ ] // QuickenWindow.Menu(sReportsWorksheet).MenuItem(lsTestData[1]).MenuItem(lsTestData[2]).Pick()
					[ ] QuickenWindow.MainMenu.Select("/{trim(sReportsWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
					[ ] sleep(1)
					[ ] 
				[+] else
					[+] if(StrPos("/",lsExcelData[i][1]) > 0)
						[ ] lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
					[ ] // Select menu item
					[ ] // QuickenWindow.Menu(sReportsWorksheet).MenuItem(lsExcelData[i][1]).Pick()
					[ ] QuickenWindow.MainMenu.Select("/{trim(sReportsWorksheet)}/{lsExcelData[i][1]}")
					[ ] sleep(1)
				[ ] 
				[ ] // If Popup window then check window caption and close popup
				[+] if(lsExcelData[i][3] == "Popup")
					[ ] 
					[+] if(StrPos("/",lsExcelData[i][2]) > 0)
						[ ] lsExcelData[i][2] = StrTran (lsExcelData[i][2], "/", "?")
					[ ] 
					[+] // if(QuickenMainWindow.FileDlg(lsExcelData[i][2]).Exists(5))
						[ ] // ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] // 
						[ ] // QuickenMainWindow.FileDlg(lsExcelData[i][2]).Close()
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] // 
					[+] if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists())
						[ ] sleep(SHORT_SLEEP)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] sleep(SHORT_SLEEP)
						[ ] // Close Popup window
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
						[ ] sleep(1)
						[+] if(AlertMessage.Exists())
							[ ] AlertMessage.Yes.Click()
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] // QuickenMainWindow.kill()
			[ ] // sleep(3)
			[ ] // QuickenMainWindow.Start (sStartQuicken)
			[ ] continue
		[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[+] //############# Verify Quicken Propert & Debt Menu  Navigation ###########################
	[ ] // ********************************************************
	[+] // TestCase Name:Test09_PropertyDebtMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken Propert & Debt menu
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 8/3/2011  Created By Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test09_PropertyDebtMenuNavigation () appstate NavigationBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sNetWorthWindow,sHandle,sActual
		[ ] sNetWorthWindow="Net Worth"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sNavigationData, sPropertyDebtWorksheet,sPath)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[+] for(i=1;i<=iCount;i++)
		[ ] 
		[+] do
			[+]  if (QuickenWindow.Exists() == True)
				[ ] 
				[ ] // Active Quicken Screen
				[ ] QuickenWindow.SetActive()
				[ ] 
				[+]  if (lsExcelData[i][3] != "Tab")
					[ ]  // Check for multiple navigation
					[ ] iPos= StrPos(">",lsExcelData[i][1])
					[+] if( iPos != 0)
						[ ] lsTestData=split(lsExcelData[i][1],">")
						[ ] 
						[+] if(StrPos("/",lsTestData[2]) > 0)
							[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
						[ ] sleep(SHORT_SLEEP)
						[ ] // Select menu item
						[ ] //QuickenWindow.Menu(sPropertyDebtWorksheet).MenuItem(lsTestData[1]).MenuItem(lsTestData[2]).Pick()
						[ ] QuickenWindow.MainMenu.Select("/{trim(sPropertyDebtWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
						[ ] sleep(1)
					[+] else
						[+] if(StrPos("/",lsExcelData[i][1]) > 0)
							[ ] lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
						[ ] 
						[ ] // Select menu item
						[ ] // QuickenWindow.Menu(sPropertyDebtWorksheet).MenuItem(lsExcelData[i][1]).Pick()
						[ ] QuickenWindow.MainMenu.Select("/{sPropertyDebtWorksheet}/{lsExcelData[i][1]}*")
						[ ] sleep(1)
				[ ] 
				[ ] // If Popup window then check window caption and close popup
				[+] if(lsExcelData[i][3] == "Popup")
					[ ] 
					[+] if(StrPos("/",lsExcelData[i][2]) > 0)
						[ ] lsExcelData[i][2] = StrTran (lsExcelData[i][2], "/", "?")
					[ ] 
					[+] // if(QuickenMainWindow.FileDlg(lsExcelData[i][2]).Exists(5))
						[ ] // ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] // 
						[ ] // QuickenMainWindow.FileDlg(lsExcelData[i][2]).Close()
						[ ] // 
						[+] // if(AlertMessage.Exists())
							[ ] // AlertMessage.Yes.Click()
							[ ] // 
						[ ] //  
						[ ] // 
						[ ] // 
					[+] if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists(SHORT_SLEEP))
						[ ] sleep(SHORT_SLEEP)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] sleep(SHORT_SLEEP)
						[ ] // Close Popup window
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
						[ ] sleep(1)
						[+] if(AlertMessage.Exists())
							[ ] AlertMessage.Yes.Click()
							[ ] 
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
				[ ] // Verify sub tabs
				[+] else if (lsExcelData[i][3] == "Tab")
					[+] switch(lsExcelData[i][2])
						[ ] 
						[+] case "Net Worth"
							[ ] QuickenWindow.SetActive()
							[+] do
								[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
								[ ] sleep(1)
								[ ] QuickenWindow.PropertyDebt.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.PropertyDebt.NetWorth.Select()
								[ ] sleep(1)
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/Property & _Debt/*_Net Worth")
								[ ] sleep(1)
							[ ] // Check for Net Worth Summary Report button
							[+] if(QuickenMainWindow.MDIClient.PropertyAndDebt.QWSnapHolder.StaticText1.StaticText2.NetWorthSummaryReport.Exists(SHORT_SLEEP))
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'Net Worth Summary Report' button is not found")
							[ ] 
						[ ] 
						[+] case "Property"
							[ ] QuickenWindow.SetActive()
							[+] do
								[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
								[ ] sleep(1)
								[ ] QuickenWindow.PropertyDebt.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.PropertyDebt.Property.Select()
								[ ] sleep(1)
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/Property & _Debt/*_Property")
								[ ] sleep(1)
							[+] if(QuickenMainWindow.MDIClient.PropertyAndDebt.PropertyOptions.Exists(SHORT_SLEEP))
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'Property Options' button is not found")
							[ ] 
						[ ] 
						[+] case "Debt"
							[ ] QuickenWindow.SetActive()
							[+] do
								[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
								[ ] sleep(1)
								[ ] QuickenWindow.PropertyDebt.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.PropertyDebt.Debt.Select()
								[ ] sleep(1)
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/Property & _Debt/*_Debt")
								[ ] sleep(1)
							[+] if(QuickenMainWindow.MDIClient.PropertyAndDebt.LoanAndDebtOptions.Exists(SHORT_SLEEP))
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'Loan And Debt Options' button is not found")
							[ ] 
						[ ] 
						[+] case "Debt Reduction"
							[ ] QuickenWindow.SetActive()
							[+] do
								[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
								[ ] sleep(1)
								[ ] QuickenWindow.PropertyDebt.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.PropertyDebt.DebtReductionPlanner.Select()
								[ ] sleep(1)
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/Property & _Debt/_Debt Reduction Planner")
								[ ] sleep(1)
							[ ] 
							[+] if(QuickenMainWindow.MDIClient.Planning.QWSnapHolder.Panel.PlanActions.Exists(SHORT_SLEEP))
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed as Plan Actions button is available") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'Plan Actions' button is not found")
							[ ] 
						[ ] 
						[+] default
							[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab title is not available")
				[ ] // Verify window title if window type is MDI
				[+] else
					[ ] sleep(2)
					[ ] sCaption=QuickenMainWindow.GetCaption()
					[ ] bMatch=MatchStr("*{lsExcelData[i][2]}*",sCaption)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, "{lsExcelData[i][2]} window is not displayed") 
						[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] // QuickenMainWindow.kill()
			[ ] // Sleep(3)
			[ ] // QuickenMainWindow.Start (sStartQuicken)
			[ ] continue
		[ ] 
		[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[+] //############# Verify Quicken Bills Menu  Navigation ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:Test06_BillMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken Bills  menu
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 8/3/2011  Created By Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test06_BillMenuNavigation () appstate NavigationBaseState
	[ ] 
	[+] // Variable declaration
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sNavigationData, sBillWorksheet,sPath)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] // ShowQuickenTab(sTAB_BILL,TRUE)
	[ ] 
	[+] for(i=1;i<=iCount;i++)
		[ ] 
		[+] do
			[+]  if (QuickenWindow.Exists() == True)
				[ ] 
				[ ] // Active Quicken Screen
				[ ] QuickenWindow.SetActive()
				[ ] 
				[+]  if (lsExcelData[i][3] != "Tab")
					[ ]  // Check for multiple navigation
					[ ] iPos= StrPos(">",lsExcelData[i][1])
					[+] if( iPos != 0)
						[ ] lsTestData=split(lsExcelData[i][1],">")
						[ ] 
						[+] if(StrPos("/",lsTestData[2]) > 0)
							[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
						[ ] sleep(SHORT_SLEEP)
						[ ] // Select menu item
						[ ] QuickenWindow.MainMenu.Select("/{trim(sBillWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
						[ ] sleep(1)
						[ ] 
					[+] else
						[+] if(StrPos("/",lsExcelData[i][1]) > 0)
							[ ] lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
						[ ] // Select menu item
						[ ] QuickenWindow.MainMenu.Select("/{trim(sBillWorksheet)}/{lsExcelData[i][1]}")
						[ ] sleep(1)
				[ ] 
				[ ] // If Popup window then check window caption and close popup
				[+] if(lsExcelData[i][3] == "Popup")
					[ ] 
					[+] if(StrPos("/",lsExcelData[i][2]) > 0)
						[ ] lsExcelData[i][2] = StrTran (lsExcelData[i][2], "/", "?")
					[ ] 
					[+] if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists())
						[ ] sleep(SHORT_SLEEP)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] sleep(SHORT_SLEEP)
						[ ] // Close Popup window
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
						[ ] sleep(1)
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
				[ ] // Verify sub tabs
				[+] else if (lsExcelData[i][3] == "Tab")
					[ ] 
					[+] switch(lsExcelData[i][2])
						[ ] 
						[+] case "Upcoming"
							[ ] QuickenWindow.SetActive()
							[+] do
								[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
								[ ] sleep(1)
								[ ] QuickenWindow.Bills.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.Bills.Upcoming.Select()
								[ ] sleep(1)
								[ ] //QuickenWindow.MainMenu.Select("/_Bills/* _Upcoming")
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/_Bills/    _Upcoming")
								[ ] sleep(1)
							[+] if(QuickenMainWindow.MDIClient.Bills.IncludePaid.Exists(SHORT_SLEEP))
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'Include Paid' checkbox is not found")
							[ ] 
						[ ] 
						[+] case "Projected Balances"
							[ ] QuickenWindow.SetActive()
							[+] do
								[ ] // QuickenWindow.MainMenu.Select("/_Bills/*_Projected Balances")
								[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
								[ ] sleep(1)
								[ ] QuickenWindow.Bills.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.Bills.ProjectedBalances.Select()
								[ ] sleep(1)
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/_Bills/    _Projected Balances")
								[ ] sleep(1)
							[ ] 
							[+] if(QuickenMainWindow.MDIClient.Bills.TimeRange.Exists())
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, "{lsExcelData[i][2]} Tab is not displayed") 
								[ ] 
							[ ] 
						[ ] 
						[+] default
							[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab title is not available")
					[ ] 
					[ ] 
				[ ] // Verify window title if window type is MDI
				[+] else
					[ ] sleep(1)
					[ ] sCaption=QuickenMainWindow.GetCaption()
					[ ] print(sCaption)
					[ ] bMatch=MatchStr("*{lsExcelData[i][2]}*",sCaption)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, "{lsExcelData[i][2]} window is not displayed") 
						[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] continue
		[ ] 
		[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[+] //############# Verify Quicken Rental Property Menu Navigation ###########################
	[ ] // ********************************************************
	[+] // TestCase Name:Test14_RentalPropertyMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken Rental Property menu
		[ ] // 
		[ ] // PARAMETERS:			None,
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 23/3/2011  Created By Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test14_RentalPropertyMenuNavigation () appstate NavigationBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sHandle,sActual
		[ ] 
	[ ] 
	[+] if(SKU_TOBE_TESTED == "RPM")
		[ ] 
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sNavigationData, sRentalPropertyWorksheet,sPath)
		[ ] // Get row counts
		[ ] iCount=ListCount(lsExcelData)
		[ ] 
		[+] for(i=1;i<=iCount;i++)
			[ ] 
			[+] do
				[+]  if (QuickenWindow.Exists() == True)
					[ ] 
					[ ] // Active Quicken Screen
					[ ] QuickenWindow.SetActive()
					[ ] 
					[+]  if (lsExcelData[i][3] != "Tab")
						[ ]  // Check for multiple navigation
						[ ] iPos= StrPos(">",lsExcelData[i][1])
						[+] if( iPos != 0)
							[ ] lsTestData=split(lsExcelData[i][1],">")
							[ ] 
							[+] if(StrPos("/",lsTestData[2]) > 0)
								[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
							[ ] sleep(SHORT_SLEEP)
							[ ] // Select menu item
							[ ] // QuickenWindow.Menu(sRentalPropertyWorksheet).MenuItem(lsTestData[1]).MenuItem(lsTestData[2]).Pick()
							[ ] QuickenWindow.MainMenu.Select("/{trim(sRentalPropertyWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
							[ ] sleep(1)
							[ ] 
						[+] else
							[+] if(StrPos("/",lsExcelData[i][1]) > 0)
								[ ] lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
							[ ] // Select menu item
							[ ] // QuickenWindow.Menu(sRentalPropertyWorksheet).MenuItem(lsExcelData[i][1]).Pick()
							[ ] QuickenWindow.MainMenu.Select("/{trim(sRentalPropertyWorksheet)}/{lsExcelData[i][1]}")
							[ ] sleep(1)
							[ ] 
					[ ] 
					[ ] // If Popup window then check window caption and close popup
					[+] if(lsExcelData[i][3] == "Popup")
						[ ] 
						[+] if(StrPos("/",lsExcelData[i][2]) > 0)
							[ ] lsExcelData[i][2] = StrTran (lsExcelData[i][2], "/", "?")
						[ ] 
						[+] if(AlertMessage.Exists(SHORT_SLEEP))
							[ ] AlertMessage.Close()
							[ ] sleep(1)
						[ ] 
						[+] // if(QuickenMainWindow.FileDlg(lsExcelData[i][2]).Exists(EXTRA_LONG_SLEEP))
							[ ] // ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
							[ ] // 
							[ ] // QuickenMainWindow.FileDlg(lsExcelData[i][2]).Close()
							[ ] // 
						[+] // else
							[ ] // ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
							[ ] // 
						[+] if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists())
							[ ] sleep(SHORT_SLEEP)
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
							[ ] sleep(SHORT_SLEEP)
							[ ] // Close Popup window
							[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
							[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
							[ ] sleep(1)
							[+] if(AlertMessage.Exists())
								[ ] AlertMessage.Yes.Click()
								[ ] 
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
							[ ] 
						[ ] 
						[ ] 
					[ ] // Verify sub tabs
					[+] else if (lsExcelData[i][3] == "Tab")
						[+] switch(lsExcelData[i][5])
							[ ] 
							[+] case "Rent Center"
								[ ] QuickenWindow.SetActive()
								[+] do
									[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
									[ ] sleep(1)
									[ ] QuickenWindow.RentalProperty.Click()
									[ ] sleep(1)
									[ ] QuickenWindow.RentalProperty.RentCenter.Select()
									[ ] sleep(1)
								[+] except
									[ ] QuickenWindow.MainMenu.Select("/Re_ntal Property/*_Rent Center")
									[ ] sleep(1)
								[ ] 
								[+] if(QuickenMainWindow.MDIClient.RentalProperty.RentalPropertiesComboBox.Exists(SHORT_SLEEP))
									[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
									[ ] 
								[+] else
									[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as Rental Properties ComboBox is not found")
								[ ] 
							[ ] 
							[+] case "Profit?Loss"
								[ ] QuickenWindow.SetActive()
								[+] do
									[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
									[ ] sleep(1)
									[ ] QuickenWindow.RentalProperty.Click()
									[ ] sleep(1)
									[ ] QuickenWindow.RentalProperty.ProfitLoss.Select()
									[ ] sleep(1)
								[+] except
									[ ] QuickenWindow.MainMenu.Select("/Re_ntal Property/*_Profit?Loss")
									[ ] sleep(1)
								[ ] 
								[+] if(QuickenMainWindow.MDIClient.RentalProperty.ProfitLossDetails.Exists(SHORT_SLEEP))
									[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
									[ ] 
								[+] else
									[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'Profit/Loss Details button is not found")
								[ ] 
							[ ] 
							[+] case "Account Overview"
								[ ] QuickenWindow.SetActive ()
								[+] do
									[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
									[ ] sleep(1)
									[ ] QuickenWindow.RentalProperty.Click()
									[ ] sleep(1)
									[ ] QuickenWindow.RentalProperty.AccountOverview.Select()
									[ ] sleep(1)
								[+] except
									[ ] QuickenWindow.MainMenu.Select("/Re_ntal Property/*_Account Overview")
									[ ] sleep(1)
								[ ] 
								[ ] sHandle= str(QuickenMainWindow.MDIClient.RentalProperty.QWSnapHolder.RentalSpendingAccount.RentalPropertyAndDebtAccount.ListViewer.ListBox.GetHandle())
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
								[ ] bMatch = MatchStr("*{lsExcelData[i][2]}*", sActual)
								[+] if(bMatch == TRUE)
									[ ] ReportStatus("Validate {lsExcelData[i][5]} Tab", PASS, "{lsExcelData[i][5]} Tab is displayed") 
								[+] else
									[ ] ReportStatus("Validate {lsExcelData[i][5]} Tab", FAIL, " Expected - {lsExcelData[i][5]} Tab is not available as '{lsExcelData[i][2]}' text is not found")
								[ ] 
								[ ] 
							[ ] 
							[+] default
								[ ] ReportStatus("Validate {lsExcelData[i][1]} Tab", FAIL, " Expected - {lsExcelData[i][1]} Tab title is not available")
					[ ] // Verify window title if window type is MDI
					[+] else
						[ ] sCaption=QuickenMainWindow.GetCaption()
						[ ] bMatch=MatchStr("*{lsExcelData[i][2]}*",sCaption)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Validate {lsExcelData[i][2]} page", PASS, "{lsExcelData[i][2]} page is displayed") 
						[+] else
							[ ] ReportStatus("Validate {lsExcelData[i][2]} page", FAIL, "{lsExcelData[i][2]} page is not displayed") 
							[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
					[ ] 
			[+] except
				[ ] ExceptLog()
				[ ] // QuickenMainWindow.kill()
				[ ] // Sleep(3)
				[ ] // QuickenMainWindow.Start (sStartQuicken)
				[ ] continue
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate testcase according to SKU", WARN, "This Testcase is not executed as this is specific to RPM SKU") 
		[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[+] //############# Verify Quicken Planning Menu  Navigation ################################
	[ ] // ********************************************************
	[+] // TestCase Name:Test10_PlanningMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken Planning menu
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 8/3/2011  Created By Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test10_PlanningMenuNavigation () appstate NavigationBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sExpectedWindowTitle,sActualWindowTitle
		[ ] WINDOW wDialogBox
		[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sNavigationData, sPlanningWorksheet,sPath)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[+] for(i=1;i<=iCount;i++)
		[ ] 
		[+] do
			[+]  if (QuickenWindow.Exists() == True)
				[ ] sleep(2)
				[ ] // Active Quicken Screen
				[ ] QuickenWindow.SetActive()
				[ ] 
				[+]  if (lsExcelData[i][3] != "Tab")
					[ ]  // Check for multiple navigation
					[ ] iPos= StrPos(">",lsExcelData[i][1])
					[+] if( iPos != 0)
						[ ] lsTestData=split(lsExcelData[i][1],">")
						[ ] 
						[+] if(StrPos("/",lsTestData[2]) > 0)
							[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
						[ ] sleep(SHORT_SLEEP)
						[ ] // Select menu item
						[ ] //QuickenWindow.Menu(sPlanningWorksheet).MenuItem(lsTestData[1]).MenuItem(lsTestData[2]).Pick()
						[ ] QuickenWindow.MainMenu.Select("/{trim(sPlanningWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
						[ ] sleep(1)
						[ ] 
					[+] else
						[+] if(StrPos("/",lsExcelData[i][1]) > 0)
							[ ] lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
						[ ] // Select menu item
						[ ] //QuickenWindow.Menu(sPlanningWorksheet).MenuItem(lsExcelData[i][1]).Pick()
						[ ] QuickenWindow.MainMenu.Select("/{trim(sPlanningWorksheet)}/{lsExcelData[i][1]}")
						[ ] 
				[ ] 
				[+] if(lsExcelData[i][3] == "Other")
					[ ] sExpectedWindowTitle = "Create Tax Export File"
					[ ] 
					[+] if (TaxDlg.Exists())
						[ ] TaxDlg.SetFocus()
						[ ] // wDialogBox=TaxDlg.Getparent()
						[ ] sActualWindowTitle=CreateTaxExportFile.getproperty("caption")
						[+] if(sActualWindowTitle==sExpectedWindowTitle)
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
							[ ] TaxDlg.TypeKeys(KEY_EXIT)
							[ ] sleep(1)
						[+] else
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
							[ ] Desktop.TypeKeys(KEY_EXIT)
							[ ] sleep(1)
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
				[ ] // If Popup window then check window caption and close popup
				[+] else if(lsExcelData[i][3] == "Popup")
					[ ] 
					[+] if(StrPos("/",lsExcelData[i][2]) > 0)
						[ ] lsExcelData[i][2] = StrTran (lsExcelData[i][2], "/", "?")
					[ ] 
					[+] if(AlertMessage.Exists(SHORT_SLEEP))
						[ ] AlertMessage.Close()
						[ ] sleep(1)
					[ ] 
					[+] // if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists())
						[ ] // ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] // 
						[ ] // QuickenMainWindow.FileDlg(lsExcelData[i][2]).Close()
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] // 
					[ ] sleep(5)
					[+] if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists(30))
						[ ] sleep(SHORT_SLEEP)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] sleep(SHORT_SLEEP)
						[ ] // Close Popup window
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
						[ ] sleep(1)
						[+] if(AlertMessage.Exists(5))
							[ ] AlertMessage.Yes.Click()
							[ ] sleep(1)
						[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
					[ ] 
				[ ] // Verify sub tabs
				[+] else if (lsExcelData[i][3] == "Tab")
					[+] switch(lsExcelData[i][2])
						[ ] 
						[+] case "Budgets"
							[ ] QuickenWindow.SetActive()
							[+] do
								[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
								[ ] sleep(1)
								[ ] QuickenWindow.Planning.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.Planning.Budget.Select()
								[ ] sleep(SHORT_SLEEP)
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/_Planning/*_Budgets")
								[ ] sleep(1)
							[+] if(QuickenMainWindow.MDIClient.Planning.BudgetActions.Exists(LONG_SLEEP))
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'Budget Actions' button is not found")
							[ ] 
						[ ] 
						[+] case "Debt Reduction"
							[ ] QuickenWindow.SetActive()
							[+] do
								[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
								[ ] sleep(1)
								[ ] QuickenWindow.Planning.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.Planning.DebtReductionPlanner.Select()
								[ ] sleep(SHORT_SLEEP)
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/_Planning/*_Debt Reduction")
							[+] if(QuickenMainWindow.MDIClient.Planning.QWSnapHolder.Panel.PlanActions.Exists(SHORT_SLEEP))
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'Loan And Debt Options' button is not found")
							[ ] 
						[ ] 
						[+] case "Lifetime Planner"
							[ ] QuickenWindow.SetActive()
							[+] do
								[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
								[ ] sleep(1)
								[ ] QuickenWindow.Planning.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.Planning.LifetimePlanner.Select()
								[ ] sleep(SHORT_SLEEP)
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/_Planning/*_Lifetime Planner")
							[+] if(QuickenMainWindow.MDIClient.Planning.ChangeAssumptions.Exists(LONG_SLEEP))
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'Change Assumptions' button is not found")
							[ ] 
						[ ] 
						[+] case "Tax Center"
							[ ] QuickenWindow.SetActive()
							[+] do
								[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
								[ ] sleep(1)
								[ ] 
								[ ] QuickenWindow.Planning.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.Planning.TaxCenter.Select()
								[ ] sleep(SHORT_SLEEP)
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/_Planning/*_Tax Center")
							[+] if(QuickenMainWindow.MDIClient.Planning.ShowTaxPlanner.Exists(LONG_SLEEP))
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'Assign Tax Categories' button is not found")
							[ ] 
						[ ] 
						[+] case "Savings Goals"
							[ ] QuickenWindow.SetActive()
							[+] do
								[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
								[ ] sleep(1)
								[ ] QuickenWindow.Planning.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.Planning.SavingsGoals.Select()
								[ ] sleep(SHORT_SLEEP)
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/_Planning/*_Savings Goals")
								[ ] sleep(1)
							[+] if(QuickenMainWindow.MDIClient.Planning.QWSnapHolder.Panel.GoalActions.Exists(LONG_SLEEP))
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'Goal Actions' button is not found")
							[ ] 
						[ ] 
						[+] default
							[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab title is not available")
				[ ] // Verify Browser for online options
				[+] else if(lsExcelData[i][3] == "Browser") 
					[ ] VerifyInternetExplorerCaption(lsExcelData[i][2])
				[ ] // Verify window title if window type is MDI
				[+] else
					[ ] sCaption=QuickenMainWindow.GetCaption()
					[ ] bMatch=MatchStr("*{lsExcelData[i][2]}*",sCaption)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} page", PASS, "{lsExcelData[i][2]} page is displayed") 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} page", FAIL, "{lsExcelData[i][2]} page is not displayed") 
						[ ] 
				[ ] 
				[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
			[+] else
				[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] continue
		[ ] 
		[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[+] //############# Verify Quicken Business Menu  Navigation ################################
	[ ] // ********************************************************
	[+] // TestCase Name: Test11_BusinessMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken Business menu
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 9/3/2011  Created By Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test11_BusinessMenuNavigation () appstate NavigationBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sCustomerParentWindow,sProjectParentWindow,sEstimateParentWindow,sVendorParentWindow,sHandle,sActual
		[ ] sCustomerParentWindow= "Address Book : <Customers>"
		[ ] sProjectParentWindow= "Project?Job List"
		[ ] sEstimateParentWindow="Estimate List"
		[ ] sVendorParentWindow= "Address Book : <Vendors>"
		[ ] 
	[+] if(SKU_TOBE_TESTED != "PREMIER")
		[ ] // Read data from excel sheet
		[ ] lsExcelData=ReadExcelTable(sNavigationData, sBusinessWorksheet,sPath)
		[ ] // Get row counts
		[ ] iCount=ListCount(lsExcelData)
		[ ] 
		[+] for(i=1;i<=iCount;i++)
			[ ] 
			[+] do
				[+]  if (QuickenWindow.Exists() == True)
					[ ] 
					[ ] // Active Quicken Screen
					[ ] QuickenWindow.SetActive()
					[ ] 
					[+]  if (lsExcelData[i][3] != "Tab")
						[ ]  // Check for multiple navigation
						[ ] iPos= StrPos(">",lsExcelData[i][1])
						[+] if( iPos != 0)
							[ ] lsTestData=split(lsExcelData[i][1],">")
							[ ] 
							[+] if(StrPos("/",lsTestData[2]) > 0)
								[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
							[ ] sleep(SHORT_SLEEP)
							[ ] // Select menu item
							[ ] // QuickenWindow.Menu(sBusinessWorksheet).MenuItem(lsTestData[1]).MenuItem(lsTestData[2]).Pick()
							[ ] QuickenWindow.MainMenu.Select("/{trim(sBusinessWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
							[ ] sleep(1)
						[+] else
							[+] if(StrPos("/",lsExcelData[i][1]) > 0)
								[ ] lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
							[ ] // Select menu item
							[ ] // QuickenWindow.Menu(sBusinessWorksheet).MenuItem(lsExcelData[i][1]).Pick()
							[ ] QuickenWindow.MainMenu.Select("/{sBusinessWorksheet}/{lsExcelData[i][1]}*")
							[ ] 
							[ ] 
							[ ] 
					[ ] 
					[ ] // If Popup window then check window caption and close popup
					[+] if(lsExcelData[i][3] == "Popup")
						[ ] 
						[+] if(StrPos("/",lsExcelData[i][2]) > 0)
							[ ] lsExcelData[i][2] = StrTran (lsExcelData[i][2], "/", "?")
						[ ] 
						[+] // if(QuickenMainWindow.FileDlg(lsExcelData[i][2]).Exists(EXTRA_LONG_SLEEP))
							[ ] // ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
							[ ] // 
							[ ] // QuickenMainWindow.FileDlg(lsExcelData[i][2]).TypeKeys("<Alt-F4>")
							[ ] // 
							[+] // if(AlertMessage.Exists(SHORT_SLEEP))
								[ ] // AlertMessage.Yes.Click()
								[ ] // 
							[ ] // 
						[+] if(lsExcelData[i][2]=="Manage Business Information")
							[+]  if(Desktop.Find("/{sMainWindow}//{lsExcelData[i][4]}[@caption='{lsExcelData[i][2]}']").Exists())
								[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
								[ ] Desktop.Find("/{sMainWindow}//{lsExcelData[i][4]}[@caption='{lsExcelData[i][2]}']").SetActive()
								[ ] Desktop.Find("/{sMainWindow}//{lsExcelData[i][4]}[@caption='{lsExcelData[i][2]}']").Close()
								[ ] sleep(1)
							[ ] 
						[+] else if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists(EXTRA_LONG_SLEEP))
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
							[ ] sleep(SHORT_SLEEP)
							[ ] // Close Popup window
							[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
							[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
							[ ] sleep(1)
							[+] if(AlertMessage.Exists())
								[ ] AlertMessage.Yes.Click()
								[ ] sleep(1)
							[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
							[ ] 
						[+] switch(trim(lsTestData[2]))
							[ ] 
							[+] case "Add _Customer"
								[ ] 
								[+] if(Desktop.Find("//MainWin[@caption='{sCustomerParentWindow}']").Exists(SHORT_SLEEP))
									[ ] Desktop.Find("//MainWin[@caption='{sCustomerParentWindow}']").SetActive()
									[ ] Desktop.Find("//MainWin[@caption='{sCustomerParentWindow}']").Close()
									[ ] sleep(1)
									[ ] 
								[ ] 
							[ ] 
							[+] case "Create Project?Job"
								[ ] 
								[+] if(Desktop.Find("//MainWin[@caption='{sProjectParentWindow}']").Exists(SHORT_SLEEP))
									[ ] Desktop.Find("//MainWin[@caption='{sProjectParentWindow}']").SetActive()
									[ ] Desktop.Find("//MainWin[@caption='{sProjectParentWindow}']").Close()
									[ ] sleep(1)
									[ ] 
								[ ] 
							[ ] 
							[+] case "Create _Estimate"
								[ ] 
								[+] if(Desktop.Find("//MainWin[@caption='{sEstimateParentWindow}']").Exists(SHORT_SLEEP))
									[ ] 
									[ ] Desktop.Find("//MainWin[@caption='{sEstimateParentWindow}']").SetActive()
									[ ] Desktop.Find("//MainWin[@caption='{sEstimateParentWindow}']").Close()
									[ ] sleep(1)
									[+] if(AlertMessage.Exists(SHORT_SLEEP))
										[ ] AlertMessage.Yes.Click()
										[ ] sleep(1)
									[+] else
										[ ] print("Alert message not found")
									[ ] 
								[ ] 
							[ ] 
							[+] case "Add a _Vendor"
								[ ] 
								[+] if(Desktop.Find("//MainWin[@caption='{sVendorParentWindow}']").Exists(SHORT_SLEEP))
									[ ] Desktop.Find("//MainWin[@caption='{sVendorParentWindow}']").SetActive()
									[ ] Desktop.Find("//MainWin[@caption='{sVendorParentWindow}']").Close()
									[ ] sleep(1)
									[ ] 
								[ ] 
							[ ] 
						[ ] 
						[ ] 
						[ ] 
					[ ] // Verify sub tabs
					[+] else if (lsExcelData[i][3] == "Tab")
						[+] if(StrPos("/",lsExcelData[i][2]) > 0)
							[ ] lsExcelData[i][2] = StrTran (lsExcelData[i][2], "/", "?")
						[ ] 
						[+] switch(lsExcelData[i][2])
							[ ] 
							[+] case "Profit?Loss"
								[ ] QuickenWindow.SetActive()
								[+] do
									[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
									[ ] sleep(1)
									[ ] QuickenWindow.Business.Click()
									[ ] sleep(1)
									[ ] QuickenWindow.Business.ProfitLoss.Select()
									[ ] sleep(1)
								[+] except
									[ ] QuickenWindow.MainMenu.Select("/B_usiness/*_Profit?Loss")
									[ ] sleep(1)
								[ ] 
								[+] if(QuickenMainWindow.MDIClient.Business.ProfitLossDetails.Exists(SHORT_SLEEP))
									[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
									[ ] 
								[+] else
									[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'Profit/Loss Details button is not found")
								[ ] 
							[ ] 
							[+] case "Account Overview"
								[ ] QuickenWindow.SetActive()
								[+] do
									[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
									[ ] sleep(1)
									[ ] QuickenWindow.Business.Click()
									[ ] sleep(1)
									[ ] QuickenWindow.Business.AccountOverview.Select()
									[ ] sleep(1)
								[+] except
									[ ] QuickenWindow.MainMenu.Select("/B_usiness/*_Account Overview")
									[ ] sleep(1)
								[ ] 
								[ ] sHandle = Str(QuickenMainWindow.MDIClient.Business.QWSnapHolder.StaticText1.Business1.ListBox.GetHandle())
								[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
								[ ] bMatch = MatchStr("*A/R Accounts*", sActual)
								[+] if(bMatch == TRUE)
									[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
								[+] else
									[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'A/R Accounts' text is not found")
								[ ] 	
							[ ] 
							[+] default
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab title is not available")
					[ ] // Verify Browser for online options
					[+] else if(lsExcelData[i][3] == "Browser") 
						[ ] VerifyInternetExplorerCaption(lsExcelData[i][2])
					[ ] // Verify window title if window type is MDI
					[+] else
						[ ] QuickenWindow.SetActive()
						[ ] sCaption=QuickenMainWindow.GetCaption()
						[ ] bMatch=MatchStr("*{lsExcelData[i][2]}*",sCaption)
						[+] if(bMatch==TRUE)
							[ ] ReportStatus("Validate {lsExcelData[i][2]} page", PASS, "{lsExcelData[i][2]} page is displayed") 
						[+] else
							[ ] ReportStatus("Validate {lsExcelData[i][2]} page", FAIL, "{lsExcelData[i][2]} page is not displayed") 
							[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
					[ ] 
			[+] except
				[ ] ExceptLog()
				[ ] continue
			[ ] 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate testcase according to SKU", WARN, "This Testcase is not executed as this is not applicable for PREMIER SKU") 
		[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[+] //############# Verify Quicken Investing Menu  Navigation ################################
	[ ] // ********************************************************
	[+] // TestCase Name:Test08_InvestingMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken Investing menu
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 8/3/2011  Created By Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test08_InvestingMenuNavigation () appstate NavigationBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sPerformanceWindow
		[ ] sPerformanceWindow="Security Performance"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sNavigationData, sInvestingWorksheet,sPath)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[ ] UsePopupRegister("OFF")
	[ ] 
	[+] for(i=1;i<=iCount;i++)
		[ ] 
		[+] do
			[+]  if (QuickenWindow.Exists() == True)
				[ ] 
				[ ] // Active Quicken Screen
				[ ] QuickenWindow.SetActive()
				[ ] 
				[+]  if (lsExcelData[i][3] != "Tab")
					[ ]  // Check for multiple navigation
					[ ] iPos= StrPos(">",lsExcelData[i][1])
					[+] if( iPos != 0)
						[ ] lsTestData=split(lsExcelData[i][1],">")
						[ ] 
						[+] if(StrPos("/",lsTestData[2]) > 0)
							[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
						[ ] sleep(SHORT_SLEEP)
						[ ] // Select menu item
						[ ] //QuickenWindow.Menu(sInvestingWorksheet).MenuItem(lsTestData[1]).MenuItem(lsTestData[2]).Pick()
						[ ] QuickenWindow.MainMenu.Select("/{trim(sInvestingWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
						[ ] sleep(1)
						[ ] 
					[+] else
						[+] if(StrPos("/",lsExcelData[i][1]) > 0)
							[ ] lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
						[ ] // Select menu item
						[ ] // QuickenWindow.Menu(sInvestingWorksheet).MenuItem(lsExcelData[i][1]).Pick()
						[ ] QuickenWindow.MainMenu.Select("/{trim(sInvestingWorksheet)}/{lsExcelData[i][1]}")
						[ ] sleep(1)
				[ ] 
				[ ] // If Popup window then check window caption and close popup
				[+] if(lsExcelData[i][3] == "Popup")
					[ ] UsePopUpRegister("ON")
					[ ] 
					[+] if(StrPos("/",lsExcelData[i][2]) > 0)
						[ ] lsExcelData[i][2] = StrTran (lsExcelData[i][2], "/", "?")
					[ ] 
					[+] if(AlertMessage.Exists())
						[ ] AlertMessage.SetActive()
						[+] if(AlertMessage.Yes.Exists())
							[ ] AlertMessage.Yes.Click()
						[+] if(AlertMessage.OK.Exists())
							[ ] AlertMessage.OK.Click()
					[ ] 
					[ ] sleep(MEDIUM_SLEEP)
					[ ] 
					[+] if(lsExcelData[i][2]=="Quicken Update Status")
						[ ] // Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
						[ ] sleep(SHORT_SLEEP)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] sleep(SHORT_SLEEP)
						[ ] 
					[+] else if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists())
						[ ] sleep(SHORT_SLEEP)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] sleep(SHORT_SLEEP)
						[ ] // Close Popup window
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
						[ ] sleep(1)
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
				[ ] // Verify sub tabs
				[+] else if (lsExcelData[i][3] == "Tab")
					[+] switch(lsExcelData[i][2])
						[ ] 
						[+] case "Portfolio"
							[ ] QuickenWindow.SetActive()
							[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
							[ ] sleep(1)
							[ ] 
							[+] do
								[ ] QuickenWindow.Investing.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.Investing.Portfolio.Select()
								[ ] sleep(1)
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/_Investing/*_Portfolio")
								[ ] sleep(1)
							[+] if(QuickenMainWindow.MDIClient.Investing.PortfolioOptionsButton.Exists(SHORT_SLEEP))
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'Option' menu is not found")
							[ ] 
						[ ] 
						[+] case "Performance"
							[ ] QuickenWindow.SetActive()
							[+] do
								[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
								[ ] sleep(1)
								[ ] QuickenWindow.Investing.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.Investing.Performance.Select()
								[ ] sleep(1)
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/_Investing/*_Performance")
								[ ] sleep(1)
							[+] if(QuickenMainWindow.MDIClient.Investing.TimeFrequency.Exists(SHORT_SLEEP))
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", PASS, "{lsExcelData[i][2]} Tab is displayed") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab is not available as 'TimeFrequency' combo box is not found")
							[ ] 
						[ ] 
						[+] case "Allocations"
							[ ] QuickenWindow.SetActive()
							[+] do
								[ ] QuickenWindow.TypeKeys(KEY_ESCAPE)
								[ ] sleep(1)
								[ ] QuickenWindow.Investing.Click()
								[ ] sleep(1)
								[ ] QuickenWindow.Investing.Allocations.Select()
								[ ] sleep(1)
							[+] except
								[ ] QuickenWindow.MainMenu.Select("/_Investing/*_Allocations")
								[ ] sleep(1)
							[+] if(QuickenMainWindow.MDIClient.Investing.ShowAllocationGuide.Exists(SHORT_SLEEP))
								[ ] ReportStatus("Validate {lsExcelData[i][1]} Tab", PASS, "{lsExcelData[i][1]} Tab is displayed") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate {lsExcelData[i][1]} Tab", FAIL, " Expected - {lsExcelData[i][1]} Tab is not available as 'Show Allocation Guide' button is not found")
							[ ] 
						[ ] 
						[+] default
							[ ] ReportStatus("Validate {lsExcelData[i][2]} Tab", FAIL, " Expected - {lsExcelData[i][2]} Tab title is not available")
					[ ] 
				[ ] // Verify Browser for online options
				[+] else if(lsExcelData[i][3] == "Browser") 
					[ ] VerifyInternetExplorerCaption(lsExcelData[i][2])
				[ ] // Verify window title if window type is MDI
				[+] else
					[ ] UsePopupRegister("OFF")
					[ ] sCaption=QuickenMainWindow.GetCaption()
					[ ] bMatch=MatchStr("*{lsExcelData[i][2]}*",sCaption)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, "{lsExcelData[i][2]} window is not displayed") 
						[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] continue
[ ] //#################################################################################
[ ] 
[+] //############# Verify Quicken Help Menu Navigation ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:Test15_HelpMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken Help menu
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 28/9/2011  Created By Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test15_HelpMenuNavigation () appstate NavigationBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sActual,sTest
		[ ] BOOLEAN bExist,bCheck
		[ ] INTEGER iSelect
		[ ] 
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sNavigationData, sHelpWorksheet,sPath)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[+] for(i=1;i<=iCount;i++)
		[ ] 
		[+] do
			[+]  if (QuickenWindow.Exists() == True)
				[ ] 
				[ ] // Active Quicken Screen
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ]  // Check for multiple navigation
				[ ] iPos= StrPos(">",lsExcelData[i][1])
				[+] if( iPos != 0)
					[ ] lsTestData=split(lsExcelData[i][1],">")
					[ ] 
					[+] if(StrPos("/",lsTestData[2]) > 0)
						[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
					[ ] sleep(SHORT_SLEEP)
					[ ] // Select menu item
					[ ] QuickenWindow.MainMenu.Select("/{trim(sHelpWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
					[ ] sleep(1)
					[ ] 
				[+] else
					[+] if(StrPos("/",lsExcelData[i][1]) > 0)
						[ ] lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
					[ ] // Select menu item
					[ ] QuickenWindow.MainMenu.Select("/{trim(sHelpWorksheet)}/{trim(lsExcelData[i][1])}*")
					[ ] sleep(1)
					[ ] 
				[ ] 
				[ ] // If Popup window then check window caption and close popup
				[+] if(lsExcelData[i][3] == "Popup")
					[ ] 
					[+] if(StrPos("/",lsExcelData[i][2]) > 0)
						[ ] lsExcelData[i][2] = StrTran (lsExcelData[i][2], "/", "?")
					[ ] 
					[+] if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists())
						[ ] sleep(SHORT_SLEEP)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] // Close Popup window
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
						[ ] sleep(1)
						[ ] 
					[+] // else if(FileDlg(lsExcelData[i][2]).Exists(5))
						[ ] // ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] // // Close Pop-up window
						[ ] // FileDlg(lsExcelData[i][2]).Close()
						[ ] // 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
					[ ] 
				[ ] // Verify Browser for online options
				[+] else if(lsExcelData[i][3] == "Browser") 
					[ ] VerifyInternetExplorerCaption(lsExcelData[i][2])
				[ ] 
				[+] else if(lsExcelData[i][3] == "Other")
					[ ] 
					[+] if(PopUpCalloutHolder.Exists())
						[ ] PopUpCalloutHolder.TypeKeys(KEY_ESCAPE)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
					[ ] 
				[ ] // Verify window title if window type is MDI
				[+] else
					[ ] sCaption=QuickenMainWindow.GetCaption()
					[ ] bMatch=MatchStr("*{lsExcelData[i][2]}*",sCaption)
					[+] if(bMatch==TRUE)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} page", PASS, "{lsExcelData[i][2]} page is displayed") 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} page", FAIL, "{lsExcelData[i][2]} page is not displayed") 
						[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] continue
		[ ] 
		[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[+] //#############  Verify Quicken Tools Menu Navigation ###################################
	[ ] // ********************************************************
	[+] // TestCase Name:Test03_ToolsMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken Tools Menu
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 22/12/2011  Created By Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test03_ToolsMenuNavigation () appstate NavigationBaseState
	[ ] // Variable Declaration
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sNavigationData, sToolsWorksheet,sPath)
	[ ] // Get row counts
	[ ] iCount=ListCount(lsExcelData)
	[ ] 
	[ ] // Select an account
	[ ] AccountBarSelect(ACCOUNT_BANKING,1)
	[ ] 
	[+] for(i=1;i<=iCount;i++)
		[ ] 
		[+] do
			[+]  if (QuickenWindow.Exists() == True)
				[ ] 
				[ ] // Active Quicken Screen
				[ ] QuickenWindow.SetActive()
				[ ] 
				[ ]  // Check for multiple navigation
				[ ] iPos= StrPos(">",lsExcelData[i][1])
				[+] if( iPos != 0)
					[ ] lsTestData=split(lsExcelData[i][1],">")
					[ ] 
					[+] if(StrPos("/",lsTestData[2]) > 0)
						[ ] lsTestData[2] = StrTran (lsTestData[2], "/", "?")
					[ ] sleep(SHORT_SLEEP)
					[ ] // Select menu item
					[ ] QuickenWindow.MainMenu.Select("/{trim(sToolsWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
					[ ] sleep(1)
					[ ] 
				[+] else
					[+] if(StrPos("/",lsExcelData[i][1]) > 0)
						[ ] lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
					[ ] // Select menu item
					[ ] QuickenWindow.MainMenu.Select("/{trim(sToolsWorksheet)}/{trim(lsExcelData[i][1])}*")
					[ ] sleep(1)
				[ ] 
				[ ] // If Popup window then check window caption and close popup
				[+] if(lsExcelData[i][3] == "Popup")
					[ ] 
					[ ] SignInQuickenConnectedServices()
					[+] if(lsExcelData[i][2]=="Add Account")
						[ ] WaitForState(AddAccount,TRUE,5)
					[+] if(lsExcelData[i][2]=="One Step Update Settings")
						[+] if(EnterIntuitPassword.Exists(5))
							[ ] EnterIntuitPassword.SetActive()
							[ ] EnterIntuitPassword.Close()
						[ ] WaitForState(OneStepUpdate,TRUE,8)
					[+] if(Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Exists())
						[ ] sleep(SHORT_SLEEP)
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
						[ ] sleep(SHORT_SLEEP)
						[ ] // Close Popup window
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").SetActive()
						[ ] Desktop.Find("//{lsExcelData[i][4]}[@caption='{trim(lsExcelData[i][2])}']").Close()
						[ ] sleep(1)
						[ ] 
					[+] else
						[ ] ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] 
					[ ] 
				[ ] // Verify Browser for online options
				[+] else if(lsExcelData[i][3] == "Browser")
					[ ] 
					[ ] VerifyInternetExplorerCaption(lsExcelData[i][2])
			[+] else
				[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] 
		[+] except
			[ ] ExceptLog()
			[ ] continue
		[ ] 
		[ ] 
	[ ] 
[ ] //#################################################################################
[ ] 
[+] // //############# Verify Quicken Tips & Tutorials Menu  Navigation ###########################
	[ ] // // ********************************************************
	[+] // // TestCase Name:Test12_TipsTutorialsMenuNavigation()
		[ ] // //
		[ ] // // Description: 				
		[ ] // // This tescase will verify navigation for Quicken Tips & Tutorials menu
		[ ] // // 
		[ ] // // PARAMETERS:			None
		[ ] // //
		[ ] // // Returns:			      		Pass 	if verification is done successfully 							
		[ ] // //							Fail	if any error occurs
		[ ] // //
		[ ] // // REVISION HISTORY:	 17/3/2011  Created By Udita Dube
		[ ] // //	  
	[ ] // // ********************************************************
[+] // testcase Test12_TipsTutorialsMenuNavigation () appstate none // NavigationBaseState
	[ ] // 
	[ ] // // Variable declaration
	[ ] // 
	[ ] // // Read data from excel sheet
	[ ] // lsExcelData=ReadExcelTable(sNavigationData, sTipsTutorialWorksheet,sPath)
	[ ] // // Get row counts
	[ ] // iCount=ListCount(lsExcelData)
	[ ] // 
	[+] // for(i=1;i<=iCount;i++)
		[ ] // 
		[+] // do
			[+] //  if (QuickenWindow.Exists() == True)
				[ ] // 
				[ ] // // Active Quicken Screen
				[ ] // QuickenWindow.SetActive()
				[ ] // 
				[+] // if(lsExcelData[i][3] != "Tab")
					[ ] // // Check for multiple navigation
					[ ] // iPos= StrPos(">",lsExcelData[i][1])
					[+] // if( iPos != 0)
						[ ] // lsTestData=split(lsExcelData[i][1],">")
						[ ] // 
						[+] // if(StrPos("/",lsTestData[2]) > 0)
							[ ] // lsTestData[2] = StrTran (lsTestData[2], "/", "?")
						[ ] // sleep(SHORT_SLEEP)
						[ ] // // Select menu item
						[ ] // //QuickenWindow.Menu(sTipsTutorialWorksheet).MenuItem(lsTestData[1]).MenuItem(lsTestData[2]).Pick()
						[ ] // QuickenWindow.MainMenu.Select("/{trim(sTipsTutorialWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
						[ ] // 
						[ ] // 
					[+] // else
						[+] // if(StrPos("/",lsExcelData[i][1]) > 0)
							[ ] // lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
						[ ] // 
						[ ] // // Select menu item
						[ ] // //QuickenWindow.Menu(sTipsTutorialWorksheet).MenuItem(lsExcelData[i][1]).Pick()
						[ ] // QuickenWindow.MainMenu.Select("/{sTipsTutorialWorksheet}/*{lsExcelData[i][1]}")
						[ ] // 
				[ ] // 
				[ ] // // Verify sub tabs
				[+] // if (lsExcelData[i][3] == "Tab")
					[ ] // sleep(EXTRA_LONG_SLEEP)
					[ ] // QuickenWindow.SetActive()
					[ ] // 
					[+] // switch(lsExcelData[i][4])
						[ ] // 
						[+] // case "Using Quicken"
							[ ] // 
							[ ] // QuickenWindow.MainMenu.Select("/Tips & Tutoria_ls/    _Using Quicken")
							[ ] // sleep(3)
							[+] // do
								[ ] // BrowserWindow1.TextClick(lsExcelData[i][2])
								[ ] // ReportStatus("Validate {lsExcelData[i][4]} tab", PASS, "{lsExcelData[i][4]} tab is displayed") 
							[+] // except
								[ ] // ReportStatus("Validate {lsExcelData[i][4]} tab", FAIL, "{lsExcelData[i][4]} tab is not displayed") 
							[ ] // 
							[ ] // 
						[+] // case "Quicken Services"
							[ ] // 
							[ ] // QuickenWindow.MainMenu.Select("/Tips & Tutoria_ls/    _Quicken Services")
							[ ] // sleep(3)
							[+] // do
								[ ] // BrowserWindow1.TextClick(lsExcelData[i][2])
								[ ] // ReportStatus("Validate {lsExcelData[i][4]} tab", PASS, "{lsExcelData[i][4]} tab is displayed") 
							[+] // except
								[ ] // ReportStatus("Validate {lsExcelData[i][4]} tab", FAIL, "{lsExcelData[i][4]} tab is not displayed") 
								[ ] // 
							[ ] // 
							[ ] // 
						[ ] // 
					[ ] // 
					[ ] // 
				[ ] // // Verify window title if window type is MDI
				[+] // else
					[ ] // sCaption=QuickenMainWindow.GetCaption()
					[ ] // bMatch=MatchStr("*{lsExcelData[i][2]}*",sCaption)
					[+] // if(bMatch==TRUE)
						[ ] // ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][2]} window is displayed") 
					[+] // else
						[ ] // ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, "{lsExcelData[i][2]} window is not displayed") 
						[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] // 
		[+] // except
			[ ] // ExceptLog()
			[ ] // // QuickenMainWindow.kill()
			[ ] // // Sleep(3)
			[ ] // // QuickenMainWindow.Start (sStartQuicken)
			[ ] // continue
		[ ] // 
		[ ] // 
	[ ] // 
[ ] // //#################################################################################
[ ] 
[ ] // 05/28/2015 Kalyan: Commented the TC as it is too complex to fix hence re-scripted
[+] //############# Verify Quicken View Menu  Navigation ###################################
	[ ] // ********************************************************
	[+] // TestCase Name: Test13_ViewMenuNavigation()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify navigation for Quicken View menu
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 14/3/2011  Created By Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] // testcase Test13_ViewMenuNavigation () appstate NavigationBaseState
	[ ] // 
	[+] // // Variable declaration
		[ ] // STRING sActual,sTest
		[ ] // BOOLEAN bExist,bCheck
		[ ] // INTEGER iSelect
		[ ] // 
		[ ] // 
	[ ] // print("checking")
	[ ] // // Read data from excel sheet
	[ ] // lsExcelData=ReadExcelTable(sNavigationData, sViewWorksheet,sPath)
	[ ] // // Get row counts
	[ ] // iCount=ListCount(lsExcelData)
	[ ] // 
	[+] // for(i=1;i<=iCount;i++)
		[ ] // 
		[+] // do
			[+] //  if (QuickenWindow.Exists() == True)
				[ ] // QuickenWindow.Maximize()
				[ ] // // Active Quicken Screen
				[ ] // QuickenWindow.SetActive()
				[ ] //  // Check for multiple navigation
				[ ] // 
				[ ] // iPos= StrPos(">",lsExcelData[i][1])
				[+] // if( iPos != 0)
					[ ] // lsTestData=split(lsExcelData[i][1],">")
					[ ] // 
					[+] // if(StrPos("/",lsTestData[2]) > 0)
						[ ] // lsTestData[2] = StrTran (lsTestData[2], "/", "?")
					[ ] // 
					[ ] // // Select menu item
					[ ] // Desktop.Find("//WPFMenuItem[@caption='{sViewWorksheet}']").Click()
					[ ] // Desktop.Find("//WPFMenuItem[@caption='{trim(lsTestData[1])}']").Click()
					[ ] // bCheck=Desktop.Find("//WPFMenuItem[@caption='{trim(lsTestData[2])}']").IsChecked
					[+] // if(lsExcelData[i][2]=="Checked" && bCheck==False)
						[ ] // QuickenWindow.MainMenu.Select("/{trim(sViewWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
					[+] // if(lsExcelData[i][2]=="Unchecked" && bCheck==True)
						[ ] // QuickenWindow.MainMenu.Select("/{trim(sViewWorksheet)}/{trim(lsTestData[1])}/{trim(lsTestData[2])}*")
				[+] // else
					[ ] // lsTestData={"",""}
					[+] // if(StrPos("/",lsExcelData[i][1]) > 0)
						[ ] // lsExcelData[i][1] = StrTran (lsExcelData[i][1], "/", "?")
					[ ] // //bCheck=QuickenWindow.Menu(sViewWorksheet).MenuItem(lsExcelData[i][1]).IsChecked()
					[ ] // Desktop.Find("//WPFMenuItem[@caption='{sViewWorksheet}']").Click()
					[ ] // bCheck=Desktop.Find("//WPFMenuItem[@caption='{lsExcelData[i][1]}']").IsChecked
					[ ] // // Select menu item
					[+] // if(lsExcelData[i][2]=="Checked" && bCheck==False)
						[ ] // //QuickenWindow.Menu(sViewWorksheet).MenuItem(lsExcelData[i][1]).Pick()
						[ ] // QuickenWindow.MainMenu.Select("/{trim(sViewWorksheet)}/{lsExcelData[i][1]}*")
					[ ] // 
					[+] // else if(lsExcelData[i][2]=="Unchecked" && bCheck==TRUE)
						[ ] // sleep(SHORT_SLEEP)
						[ ] // //QuickenWindow.Menu(sViewWorksheet).MenuItem(lsExcelData[i][1]).Pick()
						[ ] // QuickenWindow.MainMenu.Select("/{trim(sViewWorksheet)}/{lsExcelData[i][1]}*")
					[+] // else
						[+] // if(lsExcelData[i][2]!="Unchecked" && lsExcelData[i][2]!="Checked" && bCheck==FALSE)
							[ ] // //QuickenWindow.Menu(sViewWorksheet).MenuItem(lsExcelData[i][1]).Pick()
							[ ] // QuickenWindow.MainMenu.Select("/{trim(sViewWorksheet)}/{lsExcelData[i][1]}*")
						[ ] // 
					[ ] // 
				[ ] // 
				[+] // // if(lsTestData[2]!="")
					[ ] // // sTest=lsTestData[2]
					[ ] // // 
				[+] // // else
					[ ] // // sTest=lsExcelData[i][1]
				[ ] // sTest=lsExcelData[i][4]
				[ ] // 
				[+] // if(lsExcelData[i][3] == "Popup" && lsExcelData[i][2] == "Checked")
					[ ] // 
					[+] // if(StrPos("/",lsExcelData[i][2]) > 0)
						[ ] // lsExcelData[i][2] = StrTran (lsExcelData[i][2], "/", "?")
					[ ] // 
					[ ] // iSelect = SelectAccountFromAccountBar(sAccount,ACCOUNT_BANKING)
					[ ] // sleep(4)
					[ ] // bExist = BankingPopUp.Exists(SHORT_SLEEP)
					[+] // if(bExist == TRUE)
						[ ] // ReportStatus("Validate {lsExcelData[i][2]} window", PASS, "{lsExcelData[i][3]} window is displayed") 
						[ ] // BankingPopUp.SetActive ()
						[ ] // BankingPopUp.Close ()
					[+] // else
						[ ] // ReportStatus("Validate {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][2]} window title is not available")
						[ ] // 
						[ ] // 
					[ ] // 
				[+] // else if (lsExcelData[i][2] == "Checked")
					[+] // switch(trim(sTest))
						[ ] // 
						[+] // case "Use Large Fonts"
							[ ] // 
							[+] // // if(QuickenMainWindow.QWNavigator.Home.
								[ ] // // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as Home tab is displayed") 
								[ ] // // 
							[+] // // else
								[ ] // // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as 'Home tab is not found")
						[ ] // 
						[+] // case "Show Tabs"
							[ ] // 
							[+] // if(QuickenMainWindow.QWNavigator.Home.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as Home tab is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as 'Home tab is not found")
						[ ] // 
						[+] // case "Show Tool Bar"
							[ ] // 
							[+] // if(QuickenMainWindow.ToolBar.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as toolbar is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as toolbar is not found")
							[ ] // 
						[ ] // 
						[+] // case "Dock Account Bar"
							[ ] // 
							[+] // if(!QuickenMainWindow.QWNavigator.Accounts.IsEnabled())
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as Account bar is expanded") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as Account bar is not expanded")
							[ ] // 
						[ ] // 
						[+] // case "On Left"
							[ ] // sleep(SHORT_SLEEP)
							[ ] // QuickenWindow.SetActive ()
							[ ] // QuickenWindow.Maximize()      
							[ ] // ExpandAccountBar()
							[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.DoubleClick()
							[+] // if(AddAccount.Exists(SHORT_SLEEP))
								[ ] // AddAccount.Close()
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as 'Add Account' window is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as 'Add Account' window is not displayed")
								[ ] // 
							[ ] // 
						[ ] // 
						[+] // case "On Right"
							[ ] // sleep(SHORT_SLEEP)
							[ ] // QuickenWindow.SetActive ()      
							[ ] // ExpandAccountBar()
							[ ] // QuickenMainWindow.QWNavigator.QWNavBtnTray.Click (MB_LEFT,58,12)
							[ ] // sCaption=QuickenMainWindow.GetCaption()
							[ ] // bMatch=MatchStr("*All Transactions*",sCaption)
							[+] // if(bMatch==TRUE)
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as 'Add Account' window is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as 'Add Account' window is not displayed")
								[ ] // 
							[ ] // 
						[ ] // 
						[+] // case "Dock Help and To Do Bar"
							[ ] // sleep(MEDIUM_SLEEP)
							[+] // if(QuickenMainWindow.ViewReminders.Exists(MEDIUM_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as 'View Reminders' button is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as 'View Reminders' button is not displayed")
							[ ] // 
						[ ] // 
						[+] // case "Spending"
							[+] // if(QuickenMainWindow.QWNavigator.Spending.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is not found")
							[ ] //  
						[+] // case "Bills"
							[+] // if(QuickenMainWindow.QWNavigator.Bills.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is not found")
							[ ] //  
						[+] // case "Planning"
							[+] // if(QuickenMainWindow.QWNavigator.Planning.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is not found")
							[ ] //  
						[+] // case "Investing"
							[+] // if(QuickenMainWindow.QWNavigator.Investing.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is not found")
							[ ] //  
						[+] // case "Property & Debt"
							[+] // if(QuickenMainWindow.QWNavigator.PropertyDebt.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is not found")
							[ ] //  
						[+] // case "Business"
							[+] // if(QuickenMainWindow.QWNavigator.Business.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is not found")
							[ ] //  
						[+] // case "Rental Property"
							[+] // if(QuickenMainWindow.QWNavigator.RentalProperty.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is not found")
							[ ] //  
						[+] // case "Tips & Tutorials"
							[+] // if(QuickenMainWindow.QWNavigator.TipsTutorials.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is not found")
							[ ] //  
						[+] // case "Mobile & Alerts"
							[ ] // QuickenWindow.Maximize()
							[+] // if(QuickenMainWindow.QWNavigator.MobileAlerts.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is not found")
							[ ] //  
						[+] // case "Full Screen"
							[+] // if(!QuickenMainWindow.QWNavigator.Accounts.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as Account Bar is not displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as Account Bar is displayed")
							[ ] //  
						[+] // case "Home"
							[ ] // QuickenMainWindow.QWNavigator.Home.DoubleClick ()
							[+] // if(QuickenMainWindow.QWNavigator.AddView.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as Add View button is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as Add View button is not found")
							[ ] //  
						[ ] // 
						[+] // default
							[ ] // ReportStatus("Validate {lsExcelData[i][1]} menu option", FAIL, " Expected - {lsExcelData[i][1]} is not available")
				[+] // else if(lsExcelData[i][2] == "Unchecked")
					[+] // switch(trim(sTest))
						[ ] // 
						[+] // case "Use Pop-up Registers"
							[ ] // iSelect = AccountBarSelect(ACCOUNT_BANKING,1)
							[ ] // bExist = BankingPopUp.Exists(SHORT_SLEEP)
							[+] // if(bExist == FALSE)
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} > {lsExcelData[i][2]} option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]}") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} > {lsExcelData[i][2]} window", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]}")
								[ ] // 
							[ ] // 
							[ ] // 
						[ ] // 
						[+] // case "Use Large Fonts"
							[ ] // 
							[+] // // if(QuickenMainWindow.QWNavigator.Home.
								[ ] // // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as Home tab is displayed") 
								[ ] // // 
							[+] // // else
								[ ] // // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as 'Home tab is not found")
						[ ] // 
						[+] // case "Show Tabs"
							[ ] // 
							[+] // if(!QuickenMainWindow.QWNavigator.Home.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as Home tab is not displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as 'Home tab is found")
						[ ] // 
						[+] // case "Show Tool Bar"
							[ ] // 
							[+] // if(!QuickenMainWindow.ToolBar.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as toolbar is not displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as toolbar is found")
							[ ] // 
						[ ] // 
						[+] // case "Dock Account Bar"
							[ ] // 
							[+] // if(QuickenMainWindow.QWNavigator.Accounts.IsEnabled())
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as Account bar is not expanded") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as Account bar is expanded")
							[ ] // 
						[ ] // 
						[+] // case "Dock Help and To Do Bar"
							[+] // if(!QuickenMainWindow.QWNavigator.QSideBar.QWPanel.OneStepUpdate.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as 'One Step Update' button is not displayed")
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as 'One Step Update' button is displayed") 
							[ ] // 
						[ ] // 
						[+] // case "Spending"
							[+] // if(!QuickenMainWindow.QWNavigator.Spending.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is not displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is found")
							[ ] //  
						[+] // case "Bills"
							[+] // if(!QuickenMainWindow.QWNavigator.Bills.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is not displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is found")
							[ ] //  
						[+] // case "Planning"
							[+] // if(!QuickenMainWindow.QWNavigator.Planning.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is not displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is found")
							[ ] //  
						[+] // case "Investing"
							[+] // if(!QuickenMainWindow.QWNavigator.Investing.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is not displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is found")
							[ ] //  
						[+] // case "Property & Debt"
							[+] // if(!QuickenMainWindow.QWNavigator.PropertyDebt.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is not displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is found")
							[ ] //  
						[+] // case "Rental Property"
							[+] // if(!QuickenMainWindow.QWNavigator.RentalProperty.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is not displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is found")
							[ ] //  
						[+] // case "Business"
							[+] // if(QuickenWindow.Business.Exists(3))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is found")
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is not displayed") 
								[ ] // 
							[ ] //  
						[+] // case "Tips & Tutorials"
							[+] // if(!QuickenMainWindow.QWNavigator.TipsTutorials.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is not displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is found")
							[ ] //  
						[+] // case "Mobile & Alerts"
							[+] // if(!QuickenMainWindow.QWNavigator.MobileAlerts.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as {lsTestData[2]} tab is not displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as {lsTestData[2]} tab is found")
							[ ] //  
						[+] // case "Full Screen"
							[+] // if(QuickenMainWindow.QWNavigator.Accounts.Exists(SHORT_SLEEP))
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", PASS, "{lsExcelData[i][1]} is {lsExcelData[i][2]} as Account Bar is displayed") 
								[ ] // 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} {lsExcelData[i][2]} Option", FAIL, " Expected - {lsExcelData[i][1]} is not {lsExcelData[i][2]} as Account Bar is not displayed, QW-2849")
							[ ] //  
						[ ] // 
						[ ] // 
						[+] // default
							[ ] // ReportStatus("Validate {lsExcelData[i][1]} menu option", FAIL, " Expected - {lsExcelData[i][1]} is not available")
					[ ] // 
				[+] // else
					[+] // switch(lsExcelData[i][4])
						[ ] // 
						[+] // case "Standard Menus (recommended)"
							[ ] // 
							[+] // if(VerifyMenuItemExistence("B_usiness")==FAIL)
								[ ] // ReportStatus("Validate {lsExcelData[i][4]} View", PASS, "{lsExcelData[i][4]} Menu is selected") 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][4]} View", FAIL, "{lsExcelData[i][4]} Menu is not selected as {lsExcelData[i][2]} menu is available") 
								[ ] // 
							[ ] // 
						[+] // case "Classic Menus"
							[ ] // 
							[+] // if(VerifyMenuItemExistence("B_usiness")==PASS)
								[ ] // ReportStatus("Validate {lsExcelData[i][4]} View", PASS, "{lsExcelData[i][4]} Menu is selected") 
							[+] // else
								[ ] // ReportStatus("Validate {lsExcelData[i][1]} View", FAIL, "{lsExcelData[i][4]} Menu is not selected as {lsExcelData[i][2]} menu is not available") 
								[ ] // 
							[ ] // 
							[ ] // 
						[ ] // 
					[ ] // 
				[ ] // 
			[+] // else
				[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
				[ ] // 
		[+] // except
			[ ] // ExceptLog()
			[ ] // // QuickenMainWindow.kill()
			[ ] // // Sleep(3)
			[ ] // // QuickenMainWindow.Start (sStartQuicken)
			[ ] // continue
		[ ] // 
		[ ] // 
	[ ] // 
[ ] //#################################################################################
[+] testcase Test13_ViewMenuNavigationForBankingAccount () appstate NavigationBaseState
	[ ] 
	[ ] SelectAnAccountOfType (ACCOUNT_BANKING)
	[ ] verifyStandardMenus()
	[ ] verifyClassicMenus()
	[ ] usePopupRegisters(sAccount, ACCOUNT_BANKING)
	[ ] verifyShowTabs()
	[ ] verifyShowToolBar()
	[ ] dockHelpBar()
	[ ] verifyViewTabsToShow()
[+] testcase Test13_ViewMenuNavigationForInvestingAccount () appstate NavigationBaseState
	[ ] 
	[ ] // 26-June: TC verifies menu navigations for investing account
	[ ] SelectAnAccountOfType (ACCOUNT_INVESTING)
	[ ] verifyStandardMenus()
	[ ] verifyClassicMenus()
	[ ] usePopupRegisters("Brokerage 01 Account", ACCOUNT_INVESTING)
	[ ] verifyShowTabs()
	[ ] verifyShowToolBar()
	[ ] dockHelpBar()
	[ ] verifyViewTabsToShow()
[ ] 
