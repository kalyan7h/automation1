[ ] // *********************************************************
[+] // FILE NAME:	<PortfolioRebalancer.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Portfolio Rebalancer test cases for Quicken Desktop : This will not include QM part and data verification on cloud
	[ ] //
	[ ] // DEPENDENCIES:	includes.inc
	[ ] //
	[ ] // DEVELOPED BY:	Abhishek
	[ ] //
	[ ] // Developed on: 		31/03/2015
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 April 08, 2014	  Created Abhishek
[ ] // *********************************************************
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] // Variable Declaration
	[ ] LIST OF ANYTYPE lsAddAccount, lsExcelData, lsAddProperty,lsAddCurrencyName,lsTransaction, lsActual, lsCurrency, lsTransactionData, lsActualCurrencyListIComboBoxtems
	[ ] LIST OF ANYTYPE lsListBoxItems, lsCurrencyComboBox, lsSecurityAvailable
	[ ] INTEGER iResult, iAddTransaction, iValidate, iAddAccount 
	[ ] 
	[ ] public INTEGER iSetupAutoAPI ,iCounter,iSelect,iNavigate,  iCount
	[ ] BOOLEAN bMatch, bMatch1, bCheck
	[ ] STRING sMDIWindow = "MDI"
	[ ] 
	[ ] STRING sFileName="PortfolioRebalancer"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] 
	[ ] public STRING sCurrencyListData = "CurrencyList"
	[ ] public STRING sAccountWorksheet = "Account"
	[ ] public STRING sCurrencyWorksheet = "Currency"
	[ ] public STRING sCheckingTransactionWorksheet = "Checking Transaction"
	[ ] public STRING sCurrencyListWorksheet = "Currency List"
	[ ] 
	[ ] 
	[ ] 
	[ ] BOOLEAN bEnabled, bResult, bExist, bMatch2
	[ ] public STRING sActualErrorMsg ,sExpectedErrorMsg,sValidationText,hWnd,sExpected, sActual , sHandle, sValidationText1
	[ ] public STRING   sAccountIntent, sMsg
[ ] 
[ ] 
[ ] 
[ ] //############# Portfolio Rebalancer  SetUp #################################################
[-] testcase PortfolioRebalanceSetup () appstate none
	[ ] 
	[ ] INTEGER iSetupAutoAPI,iOpenDataFile
	[ ] 
	[-] if(QuickenWindow.Exists())
		[ ] QuickenWindow.SetActive()
	[-] else
		[ ] QuickenWindow.Start (sCmdLine)
		[ ] 
	[-] if(FileExists(sTestCaseStatusFile))
		[ ] //DeleteFile(sTestCaseStatusFile)
	[ ] 
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
	[ ] // Create Data File
	[ ] iOpenDataFile = OpenDataFile(sFileName)
	[ ] // Report Staus If Data file Created successfully
	[-] if ( iOpenDataFile  == PASS)
		[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sDataFile} is open")
	[-] else
		[ ] ReportStatus("Validate Data File ", iOpenDataFile, "Data file -  {sDataFile} is not open")
		[ ] 
	[ ] iNavigate=NavigateQuickenTab(sTAB_INVESTING, sTAB_ALLOCATIONS)
	[-] if (iNavigate==PASS)
		[ ] ReportStatus("Navigate to {sTAB_INVESTING} > {sTAB_ALLOCATIONS} ", PASS, "Navigate to {sTAB_INVESTING} > {sTAB_ALLOCATIONS} displayed.") 
	[-] else
		[ ] ReportStatus("Navigate to {sTAB_INVESTING} > {sTAB_ALLOCATIONS} ", FAIL, "Navigate to {sTAB_INVESTING} > {sTAB_ALLOCATIONS} Not displayed") 
[ ] 
[ ] 
[+] //############# Test1_Test2_Portfolio RebalancerLaunch###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_PortfolioRebalancerLaunch()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  1, 2015		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test01_PortfolioRebalancLerLaunch () appstate none
	[ ] 
	[ ] STRING sMsg = "What is rebalancing?"
	[ ] 
	[ ] iNavigate=NavigateQuickenTab(sTAB_INVESTING, sTAB_ALLOCATIONS)
	[+] if (iNavigate==PASS)
		[ ] ReportStatus("Navigate to {sTAB_INVESTING} > {sTAB_ALLOCATIONS} ", PASS, "Navigate to {sTAB_INVESTING} > {sTAB_ALLOCATIONS} displayed.") 
	[+] else
		[ ] ReportStatus("Navigate to {sTAB_INVESTING} > {sTAB_ALLOCATIONS} ", FAIL, "Navigate to {sTAB_INVESTING} > {sTAB_ALLOCATIONS} Not displayed") 
	[ ] 
	[ ] //QuickenMainWindow.MDIClient.Investing.AllocationTab.AssetAllocationSnapshot.Buttons.Buttons1.OptionsButton.click()
	[ ] 
	[ ] //*********************************************************Test 01*************************************************************************************************************
	[ ] // Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.
	[ ] //QuickenMainWindow.MDIClient1.AllocationTab.AssetAllocationSnapshot.Buttons.RebalancePortfolio.Click()
	[+] if(QuickenMainWindow.RebalancePortfolio.exists())
		[ ] ReportStatus("Check for rebalance portfolio button exist", PASS, "Rebalance portfolio button exists and clicked") 
		[ ] QuickenMainWindow.RebalancePortfolio.Click()
		[ ] 
		[+] if(PortfolioRebalancer.exists())
			[ ] sValidationText=PortfolioRebalancer.BrowserWindow.WhatIsRebalancing.GetText()
			[ ] bMatch1=MatchStr("*{sMsg}*" , sValidationText)
			[+] if (bMatch1)
				[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText} appeared as expected: {sMsg}") 
				[ ] PortfolioRebalancer.Close()
			[+] else
				[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText} didn't appear as expected: {sMsg}") 
			[ ] 
			[ ] ReportStatus("Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.", PASS, "'Portfolio Rebalancer' launched.") 
		[+] else
			[ ] ReportStatus("Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.", FAIL, "'Portfolio Rebalancer' NOT launched.") 
	[+] else
		[ ] ReportStatus("Check for rebalance portfolio button exist", FAIL, "Rebalance portfolio button does not exists") 
		[ ] 
	[ ] //***************************************************************Test 02*******************************************************************************************************
	[ ] // Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot on Investing-Allocation tab..
	[+] if(QuickenMainWindow.RebalancePortfolio.exists())
		[ ] QuickenMainWindow.OptionsButton.Click()
		[ ] QuickenMainWindow.OptionsButton.TypeKeys(Replicate (KEY_DN, 2))
		[ ] QuickenMainWindow.OptionsButton.TypeKeys(KEY_ENTER)
		[ ] ReportStatus("Check for rebalance portfolio button exist", PASS, "Rebalance portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot  exists and clicked") 
		[+] if(PortfolioRebalancer.exists())
			[ ] sValidationText=PortfolioRebalancer.BrowserWindow.WhatIsRebalancing.GetText()
			[ ] bMatch1=MatchStr("*{sMsg}*" , sValidationText)
			[+] if (bMatch1)
				[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText} appeared as expected: {sMsg}") 
			[+] else
				[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText} didn't appear as expected: {sMsg}") 
			[ ] 
			[ ] ReportStatus("Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.", PASS, "'Portfolio Rebalancer' launched  'Rebalance Portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot .") 
		[+] else
			[ ] ReportStatus("Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.", FAIL, "'Portfolio Rebalancer' NOT launched  'Rebalance Portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot .") 
	[+] else
		[ ] ReportStatus("Check for rebalance portfolio button exist", FAIL,  "Rebalance portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot  exists and clicked") 
	[ ] 
	[ ] 
	[ ] //***************************************************************Test 02*******************************************************************************************************
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test02_WhenShouldIRebalance###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test02_WhenShouldIRebalance()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify 'When should I rebalance my portfolio' text link functionality
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  1, 2015		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test02_WhenShouldIRebalance() appstate none
	[ ] 
	[ ] STRING sMsg = "When should I rebalance my portfolio?"
	[ ] STRING sMsg1 = "When should I rebalance?" 
	[+] if(PortfolioRebalancer.exists())
		[ ] ReportStatus("Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.", PASS, "'Portfolio Rebalancer' launched  'Rebalance Portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot .") 
	[+] else
		[ ] QuickenMainWindow.RebalancePortfolio.Click()
		[ ] 
	[ ] 
	[ ] sValidationText=PortfolioRebalancer.BrowserWindow.WhenShouldIRebala.GetText()
	[ ] bMatch1=MatchStr("*{sMsg}*" , sValidationText)
	[+] if (bMatch1)
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText} appeared as expected: {sMsg}") 
		[ ] PortfolioRebalancer.BrowserWindow.WhenShouldIRebala.Select()
		[ ] 
		[ ] sValidationText1=  QuickenHelp.BrowserWindow.WhenShouldIRebala.GetText()
		[ ] bMatch2=MatchStr("*{sMsg1}*" , sValidationText1)
		[+] if (bMatch2)
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText1} appeared as expected: {sMsg1}") 
		[+] else
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText1} didn't appear as expected: {sMsg1}") 
		[ ] QuickenHelp.Close()
	[+] else
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText1} didn't appear as expected: {sMsg}") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test03_WhatIfIHaveMutualFunds###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test03_WhatIfIHaveMutualFunds()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify 'What if I have Mutual Funds' text link functionality
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  1, 2015		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test03_WhatIfIHaveMutualFunds() appstate none
	[ ] 
	[ ] STRING sMsg = "What if I have mutual funds?"
	[ ] STRING sMsg1 = "What if I have mutual funds?" 
	[+] if(PortfolioRebalancer.exists())
		[ ] ReportStatus("Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.", PASS, "'Portfolio Rebalancer' launched  'Rebalance Portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot .") 
	[+] else
		[ ] QuickenMainWindow.RebalancePortfolio.Click()
		[ ] 
	[ ] 
	[ ] sValidationText=PortfolioRebalancer.BrowserWindow.WhatIfIHaveMutua.GetText()
	[ ] bMatch1=MatchStr("*{sMsg}*" , sValidationText)
	[+] if (bMatch1)
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText} appeared as expected: {sMsg}") 
		[ ] PortfolioRebalancer.BrowserWindow.WhatIfIHaveMutua.Select()
		[ ] 
		[ ] sValidationText1=  QuickenHelp.BrowserWindow.WhatIfIHaveMutua.GetText()
		[ ] bMatch2=MatchStr("*{sMsg1}*" , sValidationText1)
		[+] if (bMatch2)
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText1} appeared as expected: {sMsg1}") 
		[+] else
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText1} didn't appear as expected: {sMsg1}") 
		[ ] QuickenHelp.Close()
	[+] else
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText1} didn't appear as expected: {sMsg}") 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test04_ResearchText###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_ResearchText()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify 'Research' text link functionality
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  1, 2015		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test04_ResearchText() appstate none
	[ ] 
	[ ] STRING sMsg = "Search"
	[ ] STRING sMsg1 = "" 
	[+] if(PortfolioRebalancer.exists())
		[ ] ReportStatus("Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.", PASS, "'Portfolio Rebalancer' launched  'Rebalance Portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot .") 
	[+] else
		[ ] QuickenMainWindow.RebalancePortfolio.Click()
		[ ] 
	[ ] 
	[ ] sValidationText=PortfolioRebalancer.BrowserWindow.Search.GetText()
	[ ] bMatch1=MatchStr("*{sMsg}*" , sValidationText)
	[+] if (bMatch1)
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText} appeared as expected: {sMsg}") 
		[ ] PortfolioRebalancer.BrowserWindow.Search.Select()
		[ ] 
		[+] if ( InvestmentResearch.BrowserWindow.exists())
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Investment search window exist") 
		[+] else
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Investment search window does NOT exist") 
		[ ] InvestmentResearch.Close()
	[+] else
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText1} didn't appear as expected: {sMsg}") 
	[ ] 
	[ ] 
	[ ] 
	[ ] 
[ ] 
[+] //############# Test05_EvaluateText###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_EvaluateText()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify 'Evaluate' text link functionality
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  1, 2015		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test05_EvaluateText() appstate none
	[ ] 
	[ ] STRING sMsg = "evaluate"
	[ ] STRING sMsg1 = "" 
	[+] if(PortfolioRebalancer.exists())
		[ ] ReportStatus("Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.", PASS, "'Portfolio Rebalancer' launched  'Rebalance Portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot .") 
	[+] else
		[ ] QuickenMainWindow.RebalancePortfolio.Click()
		[ ] 
	[ ] 
	[ ] sValidationText=PortfolioRebalancer.BrowserWindow.Evaluate.GetText()
	[ ] bMatch1=MatchStr("*{sMsg}*" , sValidationText)
	[+] if (bMatch1)
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText} appeared as expected: {sMsg}") 
		[ ] PortfolioRebalancer.BrowserWindow.Evaluate.Select()
		[ ] 
		[+] if ( InvestmentResearch.BrowserWindow.MoneyManagement.exists(1000))
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Investment search- MoneyManagement window exist") 
		[+] else
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Investment search- MoneyManagement window does NOT exist") 
		[ ] InvestmentResearch.Close()
	[+] else
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText1} didn't appear as expected: {sMsg}") 
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
[+] //############# Test06_ColumnHeaders###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_ColumnHeaders()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify that clicking on column headers of the table on 'Portfolio Rebalancer' window launches appropriate help topics
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  1, 2015		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test06_ColumnHeaders() appstate none
	[ ] 
	[ ] 
	[ ] STRING sMsg = "Asset class"
	[ ] 
	[+] if(PortfolioRebalancer.exists())
		[ ] ReportStatus("Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.", PASS, "'Portfolio Rebalancer' launched  'Rebalance Portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot .") 
	[+] else
		[ ] QuickenMainWindow.RebalancePortfolio.Click()
		[ ] 
	[ ] 
	[ ] sValidationText=PortfolioRebalancer.BrowserWindow.AssetClass.GetText()
	[ ] bMatch1=MatchStr("*{sMsg}*" , sValidationText)
	[+] if (bMatch1)
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText} appeared as expected: {sMsg}") 
		[ ] PortfolioRebalancer.BrowserWindow.AssetClass.Select()
		[ ] 
		[ ] sValidationText1=  QuickenHelp.BrowserWindow.AssetClass.GetText()
		[ ] bMatch2=MatchStr("*{sMsg}*" , sValidationText1)
		[+] if (bMatch2)
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText1} appeared as expected: {sMsg}") 
		[+] else
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText1} didn't appear as expected: {sMsg}") 
		[ ] QuickenHelp.Close()
	[+] else
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText1} didn't appear as expected: {sMsg}") 
	[ ] //_____________________________________________________________________________________________________________________________________
	[ ] 
	[ ] STRING sMsg1 = "Current %" 
	[ ] 
	[ ] sValidationText=PortfolioRebalancer.BrowserWindow.Current.GetText()
	[ ] bMatch1=MatchStr("*{sMsg1}*" , sValidationText)
	[+] if (bMatch1)
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText} appeared as expected: {sMsg1}") 
		[ ] PortfolioRebalancer.BrowserWindow.Current.Select()
		[ ] 
		[ ] sValidationText1=  QuickenHelp.BrowserWindow.Current.GetText()
		[ ] bMatch2=MatchStr("*{sMsg1}*" , sValidationText1)
		[+] if (bMatch2)
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText1} appeared as expected: {sMsg1}") 
		[+] else
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText1} didn't appear as expected: {sMsg1}") 
		[ ] QuickenHelp.Close()
	[+] else
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText1} didn't appear as expected: {sMsg}") 
	[ ] 
	[ ] 
	[ ] //_____________________________________________________________________________________________________________________________________
	[ ] 
	[ ] STRING sMsg2 = "Current Value" 
	[ ] 
	[ ] sValidationText=PortfolioRebalancer.BrowserWindow.CurrentValue.GetText()
	[ ] bMatch1=MatchStr("*{sMsg2}*" , sValidationText)
	[+] if (bMatch1)
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText} appeared as expected: {sMsg2}") 
		[ ] PortfolioRebalancer.BrowserWindow.CurrentValue.Select()
		[ ] 
		[ ] sValidationText1=  QuickenHelp.BrowserWindow.CurrentValue.GetText()
		[ ] bMatch2=MatchStr("*{sMsg2}*" , sValidationText1)
		[+] if (bMatch2)
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText1} appeared as expected: {sMsg2}") 
		[+] else
			[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText1} didn't appear as expected: {sMsg2}") 
		[ ] QuickenHelp.Close()
	[+] else
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText1} didn't appear as expected: {sMsg2}") 
[ ] 
[+] //############# Test07_DownloadAssetClasses###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_DownloadAssetClasses()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify functionality of the 'Download Asset Class' text link
		[ ] //Verify functionality of the 'Mark All', 'Clear All','Help' icon and 'Cancel' button on 'Download Security Asset Classes' dialog
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  1, 2015		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test07_DownloadAssetClasses() appstate none
	[ ] 
	[ ] STRING sMsg = "Download Security Asset Classes"
	[ ] STRING sMsg1 = "OBJ=1" 
	[ ] STRING sMsg2 = "OBJ=0" 
	[ ] 
	[+] if(PortfolioRebalancer.exists())
		[ ] ReportStatus("Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.", PASS, "'Portfolio Rebalancer' launched  'Rebalance Portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot .") 
	[+] else
		[ ] QuickenMainWindow.RebalancePortfolio.Click()
		[ ] // //QuickenMainWindow.RebalancePortfolio.SetFocus()
		[ ] //QuickenMainWindow.RebalancePortfolio.Click()
		[ ] // //QuickenMainWindow.RebalancePortfolio.Click()
	[ ] PortfolioRebalancer.BrowserWindow.AssetAndTarget.textclick("Download Asset Classes")
	[ ] sValidationText=PortfolioRebalancer.DownloadSecurityAssetClasses.DownloadSecurityAssetClasses.gettext()
	[ ] bMatch1=MatchStr("*{sMsg}*" , sValidationText)
	[+] if (bMatch1)
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {sValidationText} appeared as expected: {sMsg}") 
		[ ] //Verify Funcationality of Mark all
		[ ] PortfolioRebalancer.DownloadSecurityAssetClasses.MarkAll.Click()
		[ ] lsSecurityAvailable= PortfolioRebalancer.DownloadSecurityAssetClasses.DownloadSecurityAssetClasses.ListBox.GetContents()
		[+] for (iCount = 1; iCount < 6 ; iCount++) 
			[ ] sHandle = Str(PortfolioRebalancer.DownloadSecurityAssetClasses.DownloadSecurityAssetClasses.ListBox.GetHandle ())			// get handle of list box
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(iCount))
			[ ] print("%%%%%%%%%%%%%%%%%%%", sActual)
			[ ] bMatch = MatchStr("*{sMsg1}*", "*{sActual}*")
			[+] if (bMatch==TRUE)
				[ ] ReportStatus("Verify Mark all button", PASS, " Only selected Asset account '{sActual}' is listed") 
			[+] else
				[ ] ReportStatus("Verify Only selected accounts listed in Selected Asset accounts snapshot.", FAIL, " Selected Asset account {sExpected} is NOT listed but shown as {sActual}") 
		[ ] 
		[ ] //Verify Funcationality of Mark all
		[ ] PortfolioRebalancer.DownloadSecurityAssetClasses.ClearAll.Click()
		[ ] lsSecurityAvailable= PortfolioRebalancer.DownloadSecurityAssetClasses.DownloadSecurityAssetClasses.ListBox.GetContents()
		[+] for (iCount = 1; iCount < ListCount(lsSecurityAvailable) ; iCount++) 
			[ ] sHandle = Str(PortfolioRebalancer.DownloadSecurityAssetClasses.DownloadSecurityAssetClasses.ListBox.GetHandle ())			// get handle of list box
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(iCount))
			[ ] print("%%%%%%%%%%%%%%%%%%%", sActual)
			[ ] bMatch = MatchStr("*{sMsg2}*", "*{sActual}*")
			[+] if (bMatch==TRUE)
				[ ] ReportStatus("Verify Only selected accounts listed in Selected Asset accounts snapshot.", PASS, " Only selected Asset account '{sActual}' is listed") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Only selected accounts listed in Selected Asset accounts snapshot.", FAIL, " Selected Asset account {sExpected} is NOT listed but shown as {sActual}") 
		[ ] 
		[ ] //Verify update now functionality
		[ ] PortfolioRebalancer.DownloadSecurityAssetClasses.DownloadSecurityAssetClasses.ListBox.Select(2)
		[ ] PortfolioRebalancer.DownloadSecurityAssetClasses.UpdateNow.Click()
		[+] if(OneStepUpdateSummary.exists(2000))
			[ ] OneStepUpdateSummary.close()
			[ ] ReportStatus("Verify update now functionality for downlad asset classes", PASS, " Update asset classes successful") 
		[+] else
			[ ] ReportStatus("Verify update now functionality for downlad asset classes", 	FAIL, " Update asset classes Unsuccessful") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {sValidationText} didn't appear as expected: {sMsg}") 
[ ] 
[+] //############# Test08_ChangeTarget###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_ChangeTarget()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify functionality of the 'Change Target' text link
		[ ] //Verify that user is able to change 'Target Allocation' using 'Target Allocation' dialog
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  1, 2015		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test08_ChangeTarget() appstate none
	[ ] 
	[ ] STRING sMsg = "Change Target"
	[ ] STRING sMsg1 = "Target Allocation" 
	[ ] STRING sMsg2 = "OBJ=0" ,sFileNameExpected,sDataFileExpected
	[ ] 
	[+] if(PortfolioRebalancer.exists())
		[ ] ReportStatus("Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.", PASS, "'Portfolio Rebalancer' launched  'Rebalance Portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot .") 
	[+] else
		[ ] QuickenMainWindow.RebalancePortfolio.Click()
		[ ] //MDIClient.Investing.Panel.PortfolioCashBasisComparisionGraph.CaptureBitmap(sFileNameExpected)
		[ ] // //QuickenMainWindow.RebalancePortfolio.SetFocus()
		[ ] //QuickenMainWindow.RebalancePortfolio.Click()
		[ ] // //QuickenMainWindow.RebalancePortfolio.Click()
	[ ] PortfolioRebalancer.BrowserWindow.AssetAndTarget.textclick(sMsg)
	[ ] sValidationText=PortfolioRebalancer.TargetAllocation.TargetAllocation.gettext()
	[ ] bMatch1=MatchStr("*{sMsg1}*" , sValidationText)
	[+] if (bMatch1)
		[ ] ReportStatus(" Verify Targer Allocation title", PASS, "Validation message: {sValidationText} appeared as expected: {sMsg1}") 
	[+] else
		[ ] ReportStatus(" Verify Targetr Allocation title", FAIL, "Validation message: {sValidationText} didn't appear as expected: {sMsg}") 
	[ ] 
	[ ] //Set the target allocation
	[+] for (iCount = 1; iCount <= 3 ; iCount++) 
		[ ] PortfolioRebalancer.TargetAllocation.ListBox.Select(iCount)
		[ ] PortfolioRebalancer.TargetAllocation.TypeKeys("20")
		[ ] ReportStatus(" Verify that user is able to change 'Target Allocation' using 'Target Allocation' dialog", PASS, "User successfully could set the target allocation") 
	[ ] PortfolioRebalancer.TargetAllocation.OK.Click()
[ ] 
[+] //############# Test09_ActualTargetPieChartClick###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test09_ActualTargetPieChartClick()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] //Verify functionality of the 'Change Target' text link
		[ ] //Verify that user is able to change 'Target Allocation' using 'Target Allocation' dialog
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  1, 2015		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test09_ActualTargetPieChartClick() appstate none
	[ ] 
	[ ] STRING sMsg = "Change Target"
	[ ] STRING sMsg1 = "Target Allocation" 
	[ ] STRING sMsg2 = "OBJ=0" ,sFileNameExpected,sDataFileExpected
	[ ] 
	[+] if(PortfolioRebalancer.exists())
		[ ] ReportStatus("Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.", PASS, "'Portfolio Rebalancer' launched  'Rebalance Portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot .") 
	[+] else
		[ ] QuickenMainWindow.RebalancePortfolio.Click()
		[ ] //MDIClient.Investing.Panel.PortfolioCashBasisComparisionGraph.CaptureBitmap(sFileNameExpected)
		[ ] // //QuickenMainWindow.RebalancePortfolio.SetFocus()
		[ ] //QuickenMainWindow.RebalancePortfolio.Click()
		[ ] // //QuickenMainWindow.RebalancePortfolio.Click()
	[ ] PortfolioRebalancer.BrowserWindow.AssetAndTarget.click(1, 420,113)
	[ ] sValidationText=PortfolioRebalancer.TargetAllocation.TargetAllocation.gettext()
	[ ] bMatch1=MatchStr("*{sMsg1}*" , sValidationText)
	[+] if (bMatch1)
		[ ] ReportStatus(" Verify Targer Allocation title", PASS, "Validation message: {sValidationText} appeared as expected: {sMsg1}") 
	[+] else
		[ ] ReportStatus(" Verify Targetr Allocation title", FAIL, "Validation message: {sValidationText} didn't appear as expected: {sMsg}") 
	[ ] PortfolioRebalancer.TargetAllocation.Cancel.Click()
	[ ] 
	[ ] //Verify clicking on the Actual pie chart opens Asset allocation  report
	[ ] PortfolioRebalancer.BrowserWindow.AssetAndTarget.click(1, 200,113)
	[ ] //sValidationText=PortfolioRebalancer.TargetAllocation.TargetAllocation.gettext()
	[ ] //bMatch1=MatchStr("*{sMsg1}*" , sValidationText)
	[+] if (AssetAllocation.exists())
		[ ] ReportStatus(" Verify Asset allocation graph opens on hitting the Actual ", PASS, "Asset Allocation reports graph opened on clicking the Actual piechart") 
	[+] else
		[ ] ReportStatus(" Verify Targetr Allocation title", FAIL, "Asset Allocation reports graph did NOT open on clicking the Actual piechart") 
	[ ] AssetAllocation.Close()
[ ] 
[+] //############# Test10_AdjustmentToReachTarget###############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_AdjustmentToReachTarget()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // Verify calculation for 'Adjustment to reach Target' column
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  1, 2015		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test10_AdjustmentToReachTarget() appstate none
	[ ] 
	[ ] 
	[ ] STRING sMsg = "Asset class"
	[ ] STRING iAmountTotal, iTarget, iCurrentValue, iValidationText, iExpectedAmount
	[ ] 
	[+] if(PortfolioRebalancer.exists())
		[ ] ReportStatus("Verify that 'Portfolio Rebalancer' can be launched using 'Rebalance Portfolio' button on Investing-Allocation tab.", PASS, "'Portfolio Rebalancer' launched  'Rebalance Portfolio' menu item under 'Options' menu in 'Asset Allocation' snap shot .") 
	[+] else
		[ ] QuickenMainWindow.RebalancePortfolio.Click()
		[ ] 
	[ ] 
	[ ] iAmountTotal=StrTran(StrTran(PortfolioRebalancer.BrowserWindow.IdAmountTotal.GetText(), ",", ""), "$ ", "")
	[ ] iTarget=PortfolioRebalancer.BrowserWindow.IdTarg3.GetText()
	[ ] iCurrentValue=StrTran(StrTran(PortfolioRebalancer.BrowserWindow.Right13.GetText(), ",", ""), "$ ", "")
	[ ] 
	[ ] iValidationText= str(val(iCurrentValue) -((val(iAmountTotal)*val(iTarget))/100))
	[ ] iExpectedAmount= StrTran(StrTran(PortfolioRebalancer.BrowserWindow.Right15.GetText(), ",", ""), "$ ", "")
	[ ] 
	[ ] 
	[ ] print("&&&&&&&&&&&&&&&&&", iAmountTotal, iTarget, iCurrentValue, iValidationText, iExpectedAmount)
	[ ] bMatch1=MatchStr("*{iValidationText}*", iExpectedAmount)
	[+] if (bMatch1)
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", PASS, "Validation message: {iValidationText} appeared as expected: {iExpectedAmount}") 
	[+] else
		[ ] ReportStatus(" Verify Portfolio Rebalancer title", FAIL, "Validation message: {iValidationText} didn't appear as expected: {iExpectedAmount}") 
[ ] 
