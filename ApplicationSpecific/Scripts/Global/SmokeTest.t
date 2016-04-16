[+] // FILE NAME:	<SmokeTest.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Smoke test cases for Quicken Desktop
	[ ] //
	[ ] // DEPENDENCIES:	include.inc
	[ ] //
	[ ] // DEVELOPED BY:	Udita Dube/ Mamta Jain	
	[ ] //
	[ ] // Developed on: 		21/12/2010
	[ ] //			
	[ ] // REVISION HISTORY:
	[ ] //	 Dec 21, 2010	Udita Dube  Created
	[ ] // *********************************************************
[ ] // *********************************************************
[ ] 
[-] // Global variables used for Smoke Test cases
	[ ] public STRING sFileName = "Smoke Test"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] public STRING sMFCUAccountId = "91058196"
	[ ] public STRING sCheckingAccount = "Checking XX9609"
	[ ] public STRING sSavingsAccount = "Savings XX9601"
	[ ] 
	[ ] public STRING sPopUpWindow = "PopUp"
	[ ] public STRING sMDIWindow = "MDI"
	[ ] 
	[ ] public STRING sCmdLine = "{QUICKEN_ROOT}\qw.exe"
	[ ] public LIST OF ANYTYPE  lsAccountData,lsExcelData
	[ ] public LIST OF STRING lsAddAccount, lsQuickenAttributes, lsReminderData, lsTransactionData,lsCategoryData
	[ ] //public STRING sSmokeData = "SmokeTestData"
	[ ] public STRING sAccountWorksheet = "Account"
	[ ] public STRING sBillWorksheet = "Bill"
	[ ] public STRING sCheckingTransactionWorksheet = "Checking Transaction"
	[ ] public STRING sOtherAccountSheet = "Other Accounts"
	[ ] public STRING sPaycheckSheet = "Paycheck Reminder"
	[ ] public STRING sInvestingTransactionWorksheet = "Investing Transaction"
	[ ] public STRING sCategoryWorksheet = "Category"
	[ ] public STRING sReminderSheet = "Reminder"
	[ ] public STRING sSmokeData=SYS_GetEnv("XlsPath")
	[ ] public STRING sSmokeQDF=SYS_GetEnv("var2")
	[ ] 
[ ] 
[ ] 
[ ] // ==========================================================
[+] // INCLUDED FILES
	[ ] use "..\..\FrameworkSpecific\FrameworkFiles\Includes.inc" 	
	[ ] 
[ ] // ==========================================================
[ ] 
[+] //############# Smoke SetUp #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 SmokeSetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the Smoke Test.QDF if it exists. It will setup the necessary pre-requisite for Smoke tests
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 6, 2010		Mamta Jain created	
		[ ] // 	  Jan 25, 2011		Udita Dube	updated
	[ ] // ********************************************************
	[ ] 
[-] testcase SmokeSetUp () appstate none
	[ ] 
	[ ] INTEGER iSetupAutoAPI
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] QuickenMainWindow.SetActive()
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] QuickenMainWindow.Exit()
	[ ] 
	[ ] sleep(MEDIUM_SLEEP)
	[ ] 
	[ ] 
	[+] if(FileExists(sTestCaseStatusFile))
		[ ] DeleteFile(sTestCaseStatusFile)
	[ ] 
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[ ] 
	[ ] iSetupAutoAPI = SetUp_AutoApi()
	[ ] ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] 
[ ] //###########################################################################
[ ] 
[+] //############# Create New Data file ##############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test01_NewDataFileCreation()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will create New Data File
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if data file is created without any errors						
		[ ] // 							Fail	if any error occurs
		[ ] //							Abort	if data file with same name already exists
		[ ] // 
		[ ] // REVISION HISTORY: 	21/12/2010  	Created By	Udita Dube
		[ ] // 
	[ ] // ********************************************************
[+] testcase Test01_NewDataFileCreation () appstate QuickenBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iCreateDataFile,iRegistration
	[ ] 
	[ ] // Quicken is launched then create data file
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] 
		[ ] // Create Data File
		[ ] iCreateDataFile = DataFileCreate(sFileName)
		[ ] 
		[ ] // Report Staus If Data file Created successfully
		[+] if ( iCreateDataFile  == PASS)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created")
		[ ] // Report Staus If Data file is not Created 
		[-] else if ( iCreateDataFile ==FAIL)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sDataFile} is created but it is not Opened")
		[ ] // Report Staus If Data file already exists
		[+] else
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "File already exists, Please change the Data File name")
			[ ] 
		[ ] 
		[-] iRegistration=BypassRegistration()
			[ ] ReportStatus("Bypass Registration ", iRegistration, "Registration bypassed")
			[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[-] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //#############  Verify Quicken File Attributes ####################################### 
	[ ] // ********************************************************
	[+] // TestCase Name:	 		Test02_QuickenFileAttributes()
		[ ] //
		[ ] // Description: 				
		[ ] // This tescase will verify  File Attributes after launching Quicken.
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			      		Pass 	if verification is done successfully 							
		[ ] //							Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 21/12/2020  	Created By	Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test02_QuickenFileAttributes () appstate QuickenBaseState
	[ ] 
	[-] // Variable declaration
		[ ] LIST OF STRING lsActualFileAttribute, lsFileAttributes
		[ ] STRING sActualAboutQuicken,sExpectedAttribute, sCaption
		[ ] INTEGER i,iPos
		[ ] BOOLEAN bMatch
	[-] // Expected values of Quicken File Attributes
		[ ] lsFileAttributes = {"Accounts", "Categories", "Memorized Payee", "Securities", "Transactions" }
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sQuickenAttributesWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsQuickenAttributes=lsExcelData[1]
	[ ] 
	[ ] // Quicken is launched then Verify File Attributes
	[-]  if (QuickenMainWindow.Exists() == True)
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] 
		[ ] // Active Quicken Screen
		[ ] QuickenMainWindow.SetActive()
		[ ] // Maximize quicken window, if needed
		[ ] QuickenMainWindow.Maximize()
		[ ] 
		[+] // //About Quicken Window has been changed
			[ ] // // Navigate to Help > About Quicken
			[ ] // QuickenMainWindow.Help.AboutQuicken.Pick()
			[ ] // // Get Quicken's Actual Year information
			[ ] // sActualAboutQuicken= AboutQuicken2012.QuickenVersion.GetText()
			[ ] // // Verify that actual year information is correct
			[ ] // iPos= StrPos(sExpectedAboutQuicken, sActualAboutQuicken)
			[-] // if( iPos != 0)
				[ ] // ReportStatus("Validate About Quicken", PASS, "SKU and Year information - {sExpectedAboutQuicken} is correct") 
			[-] // else
				[ ] // ReportStatus("Validate About Quicken", FAIL, "Actual SKU and Year - {sActualAboutQuicken} is not matching with Expected  - {sExpectedAboutQuicken}") 
			[ ] // // Close About Quicken window
			[ ] // AboutQuicken2012.Close()
		[ ] 
		[ ] // Taking all File Attributes of Quicken
		[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
		[ ] 
		[ ] // Verification of Actual File Attributes
		[-] for (i=1;i<=ListCount(lsActualFileAttribute);i++)
			[ ] sExpectedAttribute=str(Val(lsQuickenAttributes[i]))
			[-] if(sExpectedAttribute == lsActualFileAttribute[i])
				[ ] ReportStatus("Validate {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i]}") 
			[-] else
				[ ] ReportStatus("Validate {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i]}")
				[ ] 
				[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############## Create New Checking Account #####################################
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test03_AddCheckingAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add Checking Account - Checking01.
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if checking account is added without any errors						
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	21/12/2020  	Created By	Udita Dube
		[ ] // 
	[ ] // ********************************************************
[+] testcase Test03_AddCheckingAccount () appstate SmokeBaseState
	[ ] 
	[-] //Variable declaration
		[ ] INTEGER  iAddAccount
		[ ] STRING sHandle,sActual
		[ ] BOOLEAN bMatch
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Quicken is launched then Add Checking Account
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is created successfully")
		[+] else
			[ ] ReportStatus("Checking Account", iAddAccount, "Checking Account -  {lsAddAccount[2]}  is not created")
		[ ] 
		[ ] //  Verify that Account is shown on account bar
		[+] if(iAddAccount==PASS)
				[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
				[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
				[-] if(bMatch == TRUE)
					[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
				[-] else
					[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
		[-] else
			[ ] ReportStatus("Verify Checking Account", FAIL, "Verification has not been done as Checking Account -  {lsAddAccount[2]}  is not created")
			[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# Stay on Top of Bill ################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test04_CreateBill()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add new bill and validate name and amount in Home tab
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while creating bill							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 22, 2010		Mamta Jain created	
		[ ] // 	  Apr  06, 2011		Udita Dube  updated
		[ ] //       Sep 23, 2011       Udita Dube  updated
	[ ] // ********************************************************
[+] testcase Test04_CreateBill () appstate SmokeBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] BOOLEAN bPayee, bAmount, bState
		[ ] STRING sHandle, sActual, sExpectedAmount
		[ ] INTEGER iAdd, iNavigate
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sBillWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsReminderData=lsExcelData[1]
	[ ] 
	[-] if(QuickenMainWindow.Exists())
		[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
		[-] if (iNavigate == PASS)
			[+] if (Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.GetStarted.Exists())
				[ ] Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.GetStarted.Click()
				[ ] StayOnTopOfMonthlyBills.SetActive ()
				[ ] StayOnTopOfMonthlyBills.AddABill.Click ()
				[ ] 
				[ ] iAdd = AddBill(lsReminderData[1],lsReminderData[2] , lsReminderData[3], lsReminderData[4], lsReminderData[5],lsReminderData[6], lsReminderData[7])
				[-] if (iAdd == PASS)
					[ ] 
					[ ] sExpectedAmount= Str(Val(lsReminderData[2]))
					[ ] 
					[ ] ReportStatus("Create new Bill ", iAdd, "New Bill with Payee Name {lsReminderData[1]} and amount {sExpectedAmount} created")
					[ ] 
					[+] if(AddAReminder.Exists(SHORT_SLEEP))
						[ ] AddAReminder.SetActive()
						[ ] AddAReminder.Cancel.Click()
						[ ] 
					[ ] 
					[ ] StayOnTopOfMonthlyBills.SetActive ()
					[ ] StayOnTopOfMonthlyBills.Next.Click ()
					[ ] StayOnTopOfMonthlyBills.Done.DoubleClick  ()
					[ ] sHandle = Str(Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.BILLANDINCOMEREMINDERSNE.QWListViewer.ListBox.GetHandle ())
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
					[ ] bPayee = MatchStr("*{lsReminderData[1]}*", sActual)
					[ ] bAmount = MatchStr("*{sExpectedAmount}*", sActual)
					[+] if (bPayee == TRUE && bAmount == TRUE)
						[ ] ReportStatus("Validate Payee name and Amount ", PASS, "Bill is displayed on Home Tab with Payee - {lsReminderData[1]} and Amount - {sExpectedAmount}")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Payee name and Amount ", FAIL, "Bill with Payee - {lsReminderData[1]} and Amount - {sExpectedAmount} is not displayed")
						[ ] 
				[+] else
					[ ] ReportStatus("Create new Bill ", iAdd, "New Bill is not created")
					[ ] 
			[+] else
				[ ] ReportStatus("Create new Bill ", FAIL, "Get Started button not found")
				[ ] 
		[+] else
			[ ] ReportStatus("Validate Home tab state", iNavigate, "Home tab is not active") 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Create Monthly Spending Goal  ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test05_TrackSpendingGoal()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will create Monthly spending goal for 5 categories
		[ ] // and validate spending goal in Home tab
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while creating Spending goal							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 27, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] // testcase Test05_TrackSpendingGoal() appstate SmokeBaseState
	[ ] // 
	[+] // //  Variable Declaration
		[ ] // BOOLEAN bMatch
		[ ] // STRING sHandle, sActual, sExpected,sSpendingAmount
		[ ] // INTEGER iNavigate, iCatgorySelect
		[ ] // sSpendingAmount = "20"
	[ ] // 
	[+] // if(QuickenMainWindow.Exists())
		[ ] // iNavigate = NavigateQuickenTab(sTAB_HOME)
		[+] // if(iNavigate == PASS)
			[ ] // Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Panel.GetStarted.Click()
			[+] // if(MonthlySpendingGoals.Exists())
				[ ] // MonthlySpendingGoals.SetActive()
				[ ] // MonthlySpendingGoals.StaticText.ListBox.Click(1, 120,80)
				[+] // if(SelectCategoriesToBudget.Exists())
					[ ] // SelectCategoriesToBudget.SetActive()
					[ ] // 
					[ ] // // #24, #39, "#84" refers to  Entertainment, Food & Dining, Shopping is selected by default
					[ ] // // #99, #100  refers to Shopping: Books and Shopping: Clothes
					[ ] // 
					[ ] // iCatgorySelect = SelectCategory({ "#99", "#100"})
					[ ] // ReportStatus("Validate Categories Selection ", iCatgorySelect, " Categories are Selected")
					[ ] // 
					[ ] // SelectCategoriesToBudget.OK.Click()
					[ ] // 
					[ ] // MonthlySpendingGoals.StaticText.ListBox.Select ("#2")
					[ ] // MonthlySpendingGoals.StaticText.ListBox.TextField.SetText (sSpendingAmount)
					[ ] // MonthlySpendingGoals.StaticText.ListBox.TextField.TypeKeys (KEY_TAB)
					[ ] // MonthlySpendingGoals.StaticText.ListBox.TextField.SetText (sSpendingAmount)
					[ ] // MonthlySpendingGoals.StaticText.ListBox.TextField.TypeKeys (KEY_TAB)
					[ ] // MonthlySpendingGoals.StaticText.ListBox.TextField.SetText (sSpendingAmount)
					[ ] // MonthlySpendingGoals.StaticText.ListBox.TextField.TypeKeys (KEY_TAB)
					[ ] // MonthlySpendingGoals.StaticText.ListBox.TextField.SetText (sSpendingAmount)
					[ ] // MonthlySpendingGoals.StaticText.ListBox.TextField.TypeKeys (KEY_TAB)
					[ ] // MonthlySpendingGoals.StaticText.ListBox.TextField.SetText (sSpendingAmount)
					[ ] // MonthlySpendingGoals.Done.Click ()
					[ ] // 
					[ ] // // ########Validate Total Spending Goal#######
					[ ] // sHandle = Str(Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Panel.QWinChild.MonthlyGoal.ListBox.GetHandle ())
					[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
					[ ] // sExpected = "@Total@@@@$100"
					[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
					[+] // if(bMatch == TRUE)
						[ ] // ReportStatus("Validate Spending Goal ", PASS, "Spending Goal of 100 is displayed")
						[ ] // 
					[+] // else
						[ ] // ReportStatus("Validate Spending Goal ", FAIL, "Spending Goal of 100 is not displayed")
						[ ] // 
				[+] // else
					[ ] // ReportStatus("Validate Choose Categories Window ", FAIL, "Choose Categories window is not opened")
					[ ] // 
			[+] // else
				[ ] // ReportStatus("Validate Monthly Spending Goal Window ", FAIL, "Monthly Spending Goal window is not opened")
				[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate Home tab state ", iNavigate, "Home tab is not active")
			[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] // 
	[ ] // 
[+] testcase Test05_TrackSpendingGoal() appstate SmokeBaseState
	[ ] 
	[+] //  Variable Declaration
		[ ] BOOLEAN bMatch
		[ ] STRING sHandle, sActual, sExpected,sAmount,sCategory,sBudget
		[ ] INTEGER iNavigate, iCatgorySelect
		[ ] sCategory="Entertainment"
		[ ] sAmount = "20"
		[ ] sBudget = "Test Budget"
	[ ] 
	[-] if(QuickenMainWindow.Exists())
		[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)
		[-] if(iNavigate == PASS)
			[ ] Home.QWStayOnTopOfMonthlyBills.StaticTextTSG.Panel.GetStarted.Click()
			[+] if(Budget.Exists())
				[ ] Budget.SetActive()
				[ ] Budget.Panel.QWMsHtmlVw1.ShellEmbedding1.ShellDocObjectView1.InternetExplorer_Server1.Click(1, 242,338)
				[+] if(CreateANewBudget.Exists())
					[ ] CreateANewBudget.SetActive()
					[ ] CreateANewBudget.BudgetName.SetText(sBudget)
					[ ] CreateANewBudget.OK.Click()
					[+] if(Budget.Exists())
						[ ] Budget.AddCategoryToBudget.Click()
						[+] if(AddABudgetCategory.Exists())
							[ ] AddABudgetCategory.Panel.QWinChild.SelectACategoryToBudget.SetText(sCategory)
							[ ] AddABudgetCategory.Panel.QWinChild.TypeKeys(KEY_TAB)
							[ ] AddABudgetCategory.Next.Click()
							[ ] AddABudgetCategory.Panel.QWinChild.Amount.SetText(sAmount)
							[ ] AddABudgetCategory.Done.Click()
							[ ] // // ########Validate Total Spending #######
							[ ] sActual= Budget.Panel.TotalSpending.GetText()
							[ ] sExpected = "$20"
							[ ] bMatch = MatchStr("*{sExpected}*", sActual)
							[+] if(bMatch == TRUE)
								[ ] ReportStatus("Validate Total Spending ", PASS, "Total Spending is 20")
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Total Spending ", FAIL, "Total Spending is {sActual} displayed")
								[ ] 
							[ ] 
						[+] else
							[ ] ReportStatus("Validate Add A Budget Category window", FAIL, "Add A Budget Category window is not available")
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Budget window", FAIL, "Budget window is not available")
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Creat a New Budget Window ", FAIL, "Creat a New Budget window is not opened")
					[ ] 
			[-] else
				[ ] ReportStatus("Validate Budget Window ", FAIL, "Budget window is not opened")
				[ ] 
		[+] else
			[ ] ReportStatus("Validate Home tab state ", iNavigate, "Home tab is not active")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############### Create Other Checking Account ####################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test06_AddOtherCheckingAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add another Checking Account - Checking02
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if checking account is added without any errors						
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	22/12/2020  	Created By	Udita Dube
		[ ] // 
	[ ] // ********************************************************
[+] testcase Test06_AddOtherCheckingAccount () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iAddAccount,iCount,i
		[ ] STRING sHandle,sActual
		[ ] BOOLEAN bMatch
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsAddAccount=lsExcelData[2]
	[ ] 
	[ ] // Quicken is launched then Add Checking Account
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] // Add Checking Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if checking Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Create Checking Account", PASS, "Checking Account -  {lsAddAccount[2]}  is created successfully")
		[+] else
			[ ] ReportStatus("Create Checking Account", FAIL, "Checking Account -  {lsAddAccount[2]}  is NOT created")
		[ ] 
		[ ] //  Verify that Account is shown on account bar
		[+] if(iAddAccount==PASS)
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"1")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
			[+] else
				[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
		[+] else
			[ ] ReportStatus("Verify Checking Account", FAIL, "Verification has not been done as Checking Account -  {lsAddAccount[2]}  is not created")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Open first checking register ############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test07_OpenFirstCheckingRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will turn on the pop up register mode and invoke first account from account bar
		[ ] // and check whether it is opened in new window.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking account							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 23, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test07_OpenFirstCheckingRegister () appstate SmokeBaseState
	[ ] 
	[+] //Variable Declaration
		[ ] INTEGER iSwitchState, iSelect
		[ ] BOOLEAN bExist, bAssert
		[ ] STRING sCaption
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[-] if(QuickenMainWindow.Exists())
		[ ] iSwitchState = UsePopupRegister("ON")			// Turning On pop up register mode
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[ ] QuickenMainWindow.SetActive ()
		[ ] 
		[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING,1)
		[ ] BankingPopUp.VerifyEnabled(TRUE, 20)
		[ ] bExist = BankingPopUp.Exists()
		[-] if(bExist == TRUE)
			[ ] ReportStatus("Invoke Account from account bar", PASS, "{lsAddAccount[2]} account invoked in New window")
			[ ] 
			[ ] BankingPopUp.SetActive ()
			[ ] sCaption = BankingPopUp.GetCaption ()
			[ ] BankingPopUp.Close ()
			[ ] 
			[ ] bAssert = AssertEquals(lsAddAccount[2], sCaption)
			[+] if (bAssert == TRUE)
				[ ] ReportStatus("Verify caption", PASS, "Caption - {lsAddAccount[2]} is displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify caption", FAIL, "Correct caption - {sCaption} does not matches with Expected - {lsAddAccount[2]}")
				[ ] 
		[+] else
			[ ] ReportStatus("Invoke Account from account bar", FAIL, "{lsAddAccount[2]} account is not invoked")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############### Add Payment Checking Transaction using Popup Register ON ##############
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test08_AddPaymentCheckingTransaction()
		[ ] //
		[ ] // Description: 				This Test Case is for adding payment transaction for Checking account with Popup Register mode ON
		[ ] // 
		[ ] // PARAMETERS:			none
		[ ] //
		[ ] // Returns:			        	Pass 		if payment transaction is added successfully and ending balance is correct						
		[ ] //						 	Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 27/12/2020  	Created By	Udita Dube
		[ ] //	  
	[ ] // ********************************************************
[+] testcase Test08_AddPaymentCheckingTransaction () appstate SmokeBaseState
	[+] // Variable declaration
		[ ] STRING sActual, sPayBalance
		[ ] INTEGER iSelect,iAddTransaction,iSwitchState
		[ ] BOOLEAN bBalanceCheck
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sCheckingTransactionWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransactionData=lsExcelData[1]
	[ ] 
	[ ] // Quicken is launched then add Payment transaction to Checking account
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] // Turn ON Popup mode
		[ ] iSwitchState = UsePopupRegister("ON")
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[ ] // This will click  first Banking account on AccountBar
		[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, 1)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", iSelect, "Account {lsTransactionData[10]} is selected") 
		[+] else
			[ ] ReportStatus("Select Account", iSelect, "Account {lsTransactionData[10]} is NOT selected") 
		[ ] 
		[ ] // Add Payment Transaction to Checking account
		[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
		[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
		[ ] 
		[+] if(BankingPopUp.Exists())
			[ ] BankingPopUp.SetActive()
			[ ] sActual = BankingPopUp.EndingBalance.EndingBalance.GetText()
			[ ] BankingPopUp.Close()
		[ ] sPayBalance=str(val(lsTransactionData[9]),NULL,2)
		[ ] sPayBalance=stuff(sPayBalance,2,0,",")
		[ ] // Verify Ending balance after transaction is added
		[+] if(iAddTransaction==PASS)
			[ ] bBalanceCheck = AssertEquals(sPayBalance, sActual)
			[+] if (bBalanceCheck == TRUE)
				[ ] ReportStatus("Validate Ending Balance", PASS, "Ending Balance -  {sActual} is correct") 
			[+] else
				[ ] ReportStatus("Validate Ending Balance", FAIL, "Actual -  {sActual} is not matching with Expected - {sPayBalance}") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Checking Transaction", FAIL, "Verification has not been done as Transaction -  {lsTransactionData[2]}  is not added")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Add New Transaction", FAIL, "Quicken is not available") 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Open second checking register ##########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test09_OpenSecondCheckingRegister()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will turn on the pop up register mode and invoke second account from account bar
		[ ] // and check whether it is opened in new window.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking account							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 24, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test09_OpenSecondCheckingRegister () appstate SmokeBaseState
	[ ] 
	[+] // Variable Declaration
		[ ] INTEGER iSwitchState, iSelect
		[ ] BOOLEAN bExist, bAssert
		[ ] STRING sCaption
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsAddAccount=lsExcelData[2]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] iSwitchState = UsePopupRegister("ON")			// turning on pop up register mode
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[ ] QuickenMainWindow.SetActive ()
		[ ] 
		[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, 2)
		[ ] BankingPopUp.VerifyEnabled(TRUE, 20)
		[ ] bExist = BankingPopUp.Exists()
		[+] if(bExist == TRUE)
			[ ] ReportStatus("Invoke Account from account bar", PASS, "{lsAddAccount[2]} account invoked")
			[ ] BankingPopUp.SetActive ()
			[ ] sCaption = BankingPopUp.GetCaption ()
			[ ] BankingPopUp.Close ()
			[ ] bAssert = AssertEquals(lsAddAccount[2], sCaption)
			[+] if (bAssert == TRUE)
				[ ] ReportStatus("Verify caption", PASS, "Correct caption - {lsAddAccount[2]} is displayed")
				[ ] 
			[+] else
				[ ] ReportStatus("Verify caption", FAIL, "Caption {sCaption} is not matching with Expected - {lsAddAccount[2]}")
				[ ] 
		[+] else
			[ ] ReportStatus("Invoke Account from account bar", FAIL, "{lsAddAccount[2]} account is not invoked")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //############### Add Deposit Checking Transaction using Popup Register ON ###############
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test10_AddDepositCheckingTransaction()
		[ ] //
		[ ] // Description: 				
		[ ] // This Test case is for adding deposit transaction for Checking account (with Popup Register mode ON)
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			        	Pass 		if deposit transaction is added successfully and ending balance is correct						
		[ ] //							Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 28/12/2020  	Created By	Udita Dube
		[ ] //	  
	[ ] //*********************************************************
[+] testcase Test10_AddDepositCheckingTransaction () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sActual, sExpectedEndingBalance
		[ ] INTEGER iSelect,iAddTransaction,iSwitchState
		[ ] BOOLEAN bBalanceCheck
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sCheckingTransactionWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsTransactionData=lsExcelData[2]
	[ ] 
	[ ] // Quicken is launched then add Deposit transaction to Checking account
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] // Turn ON Popup mode
		[ ] iSwitchState = UsePopupRegister("ON")
		[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn on Pop up register mode")
		[ ] 
		[ ] // This will click  second Banking account on AccountBar
		[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, 2)
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", iSelect, "Account {lsTransactionData[10]} is selected") 
		[+] else
			[ ] ReportStatus("Select Account", iSelect, "Account {lsTransactionData[10]} is NOT selected") 
		[ ] 
		[ ] // Add Deposit Transaction to Checking account
		[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
		[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
		[ ] 
		[+] if(BankingPopUp.Exists())
			[ ] sActual = BankingPopUp.EndingBalance.EndingBalance.GetText()
			[ ] BankingPopUp.Close()
		[ ] 
		[ ] // Verify Ending balance after transaction is added
		[ ] sExpectedEndingBalance=str((val(lsTransactionData[9])),7,2)
		[ ] sExpectedEndingBalance = Stuff (sExpectedEndingBalance, 2, 0, ",")
		[-] if(iAddTransaction==PASS)
			[ ] 
			[ ] bBalanceCheck = AssertEquals(sExpectedEndingBalance, sActual)
			[-] if (bBalanceCheck == TRUE)
				[ ] ReportStatus("Validate Ending Balance", PASS, "Ending Balance -  {sActual} is correct") 
			[+] else
				[ ] ReportStatus("Validate Ending Balance", FAIL, "Actual -  {sActual} is not matching with Expected - {sExpectedEndingBalance}") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify Add Checking Transaction", FAIL, "Verification has not been done as Transaction -  {lsTransactionData[2]}  is not added")
			[ ] 
	[+] else
		[ ] ReportStatus("Add New Transaction", FAIL, "Quicken is not available") 
	[ ] 
[ ] //###############################################################################
[ ] 
[+] //############### Create Investment Account ########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test11_AddBrokerageAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will add Investment (Brokerage) Account - Brokerage 01
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if brokerage account is added with correct Market vale						
		[ ] //							Fail		if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	22/12/2020  	Created By	Udita Dube
		[ ] // 											Updated by 	Mamta Jain
	[ ] //*********************************************************
[+] testcase Test11_AddBrokerageAccount () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount, iSwitchState
		[ ] BOOLEAN bMatch
		[ ] STRING sActual,sHandle
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 4th row from the given sheet
	[ ] lsAddAccount=lsExcelData[4]
	[ ] 
	[ ] // Quicken is launched then Add Brokerage Account
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] iSwitchState = UsePopupRegister("OFF")
		[ ] 
		[ ] // Add Investment Accounts
		[ ] iAddAccount = AddManualBrokerageAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],lsAddAccount[5],lsAddAccount[6])
		[ ] ReportStatus("Add Brokerage Account", iAddAccount, "Brokerage Account -  {lsAddAccount[2]} is created successfully")
		[ ] 
		[ ] //  Verify that Account is shown on account bar
		[+] if(iAddAccount==PASS)
			[ ] 
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer3.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
			[+] else
				[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "Actual -  {sActual} is not matching with Expected - {lsAddAccount[2]}") 
		[+] else
			[ ] ReportStatus("Verify Brokerage Account", FAIL, "Verification of account has not been done as Brokerage Account is not created")
			[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //############### Verify Download Transaction Tab for Brokerage Account #################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test12_VerifyDownloadTransactionTab()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Testcase verifies that "Download Transaction" Tab is available on Brokerage Account window
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if "Download Transaction" Tab is available on Brokerage Account window						
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	23/12/2020  	Created By	Udita Dube
		[ ] // 
	[ ] //*********************************************************
[+] testcase Test12_VerifyDownloadTransactionTab () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN bEnable
		[ ] INTEGER iSelect
		[ ] STRING sActualAccName
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 4th row from the given sheet
	[ ] lsAddAccount=lsExcelData[4]
	[ ] 
	[ ] // If Quicken is launched then verify Brokerage Account window
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] UsePopupRegister("OFF")
		[ ] 
		[ ] // This will click  first Investment account on AccountBar
		[ ] iSelect = AccountBarSelect(ACCOUNT_INVESTING, 1)	
		[ ] ReportStatus("Account select from account bar", iSelect, "Select Account {lsAddAccount[2]}") 
		[ ] 
		[ ] 
		[ ] // Verification for Account window Title
		[ ] sActualAccName=QuickenMainWindow.GetCaption()
		[ ] 
		[-] if( MatchStr("*{lsAddAccount[2]}*", sActualAccName))
			[ ] ReportStatus("Validate account window title", PASS, "Account window title  {lsAddAccount[2]} is correct") 
			[ ] 
			[ ] // Verify that Download Transaction tab is available
			[ ] BrokerageAccount.SetActive()
			[ ] bEnable=BrokerageAccount.wTransaction.DownloadTransactionsTab.Exists()
			[ ] // Report Status
			[+] if (bEnable == TRUE)
				[ ] ReportStatus("Verification of Download Transaction Tab", PASS, " Download Transaction Tab is present on Brokerage Account window") 
			[+] else
				[ ] ReportStatus("Verification of Download Transaction Tab", FAIL, " Download Transaction Tab is not available on Brokerage Account window") 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate account window title", FAIL, "Actual -  {sActualAccName} is not matching with Expected - {lsAddAccount[2]}") 
			[ ] 
		[ ] 
		[ ] 
	[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //############### Buy Transaction in Brokerage Account ###############################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test13_InvestmentBuyTransaction()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Testcase verifies "Cash Balance" after Buy transaction from Brokerage Account
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Cash Balance after Buy transaction is correct	
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	24/12/2020  	Created By	Udita Dube
		[ ] // 
	[ ] //*********************************************************
[+] testcase Test13_InvestmentBuyTransaction  () appstate SmokeBaseState
	[ ] 
	[-] // Variable declaration
		[ ] BOOLEAN bMatch
		[ ] INTEGER iAddTransaction, iSelect,iCount
		[ ] STRING sHandle,sActualCashBalance,sExpectedCashBalance,sActual
		[ ] LIST OF STRING lsRow
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sInvestingTransactionWorksheet)
	[ ] // Fetch 1th row from the given sheet
	[ ] lsTransactionData=lsExcelData[1]
	[ ] 
	[ ] // If Quicken is launched then verify Brokerage Account window
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] // This will click  first Investment account on AccountBar
		[ ] iSelect = AccountBarSelect(ACCOUNT_INVESTING, 1)	
		[ ] ReportStatus("Account select from account bar", iSelect, "Select Account {lsTransactionData[3]}") 
		[ ] 
		[ ] // Verify Brokerage Account window is available
		[+] if (BrokerageAccount.Exists())
			[ ] 
			[ ] //Buy Transaction with all data
			[ ] iAddTransaction= AddBrokerageTransaction(lsTransactionData)
			[ ] ReportStatus("Add Brokerage Transaction: {lsTransactionData[1]}", iAddTransaction, "{lsTransactionData[1]} Transaction is added") 
			[ ] 
		[ ] // Report Status if Brokerage Account window is not available
		[+] else
			[ ] iAddTransaction=FAIL
			[ ] ReportStatus("Verification of {lsTransactionData[3]} account window", FAIL, "{lsTransactionData[3]} account window not found") 
		[ ] 
		[ ] //  Verify that Cash Balance
		[-] if(iAddTransaction==PASS)
			[ ] iCount=BrokerageAccount.StaticText1.StaticText1.QWHtmlViewer.CashBalance.GetItemCount()
			[ ] sHandle = Str(BrokerageAccount.StaticText1.StaticText1.QWHtmlViewer.CashBalance.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount-2))
			[ ] lsRow=Split(sActual,"@")
			[ ] iCount=ListCount(lsRow)
			[ ] sActualCashBalance=lsRow[iCount]
			[-] if(sActualCashBalance=="")
				[ ] sActualCashBalance=lsRow[iCount-1]
				[ ] 
			[ ] sExpectedCashBalance=str(val(lsTransactionData[10]),NULL,2)
			[ ] sExpectedCashBalance=stuff(sExpectedCashBalance,2,0,",")
			[ ] bMatch = AssertEquals(sExpectedCashBalance,sActualCashBalance)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Cash Balance", PASS, "Cash Balance {sActualCashBalance} is correct")
			[+] else
				[ ] ReportStatus("Validate Cash Balance", FAIL, "Actual -  {sActualCashBalance} is not matching with Expected - {sExpectedCashBalance}")
		[+] else
			[ ] ReportStatus("Verify that Total Market Value", FAIL, "Verification has not been done as transaction - {lsTransactionData[1]} is not added ") 
			[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //############### Sell Transaction in Brokerage Account ################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test14_InvestmentSellTransaction()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Testcase verifies the Market Value after sell transaction from Brokerage Account
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Market Value after Sell transaction is correct					
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	24/12/2020  	Created By	Udita Dube
		[ ] // 
	[ ] //*********************************************************
[+] testcase Test14_InvestmentSellTransaction () appstate SmokeBaseState
	[+] //Variable declaration
		[ ] BOOLEAN bMatch
		[ ] INTEGER iAddTransaction, iSelect,iCount
		[ ] STRING sActualCashBalance,sExpectedCashBalance,sHandle,sActual
		[ ] LIST OF STRING lsRow
		[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sInvestingTransactionWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsTransactionData=lsExcelData[2]
	[ ] 
	[ ] // If Quicken is launched then verify Brokerage Account window
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] // This will click  first Investment account on AccountBar
		[ ] iSelect = AccountBarSelect(ACCOUNT_INVESTING, 1)	
		[ ] ReportStatus("Account select from account bar", iSelect, "Select Account {lsTransactionData[3]}") 
		[ ] 
		[ ] //Verify Brokerage Account window is available
		[+] if (BrokerageAccount.Exists())
			[ ] //Sell Transaction with all data
			[ ] iAddTransaction= AddBrokerageTransaction(lsTransactionData)
			[ ] ReportStatus("Add Brokerage Transaction: {lsTransactionData[1]}", iAddTransaction, "{lsTransactionData[1]} Transaction is added") 
			[ ] 
		[ ] //Report Status if Brokerage Account window is not available
		[+] else
			[ ] ReportStatus("Verification of {lsTransactionData[3]} account window", FAIL, "{lsTransactionData[3]} account window not found") 
		[ ] 
		[ ] //  Verify that Cash Balance
		[-] if(iAddTransaction==PASS)
			[ ] iCount=BrokerageAccount.StaticText1.StaticText1.QWHtmlViewer.CashBalance.GetItemCount()
			[ ] sHandle = Str(BrokerageAccount.StaticText1.StaticText1.QWHtmlViewer.CashBalance.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,str(iCount-1))
			[ ] lsRow=Split(sActual,"@")
			[ ] iCount=ListCount(lsRow)
			[ ] sActualCashBalance=lsRow[iCount]
			[-] if(sActualCashBalance=="")
				[ ] sActualCashBalance=lsRow[iCount-1]
				[ ] 
			[ ] sExpectedCashBalance=str(val(lsTransactionData[10]),NULL,2)
			[ ] sExpectedCashBalance=stuff(sExpectedCashBalance,2,0,",")
			[ ] bMatch = AssertEquals(sExpectedCashBalance,sActualCashBalance)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Cash Balance", PASS, "Cash Balance {sActualCashBalance} is correct")
			[-] else
				[ ] ReportStatus("Validate Cash Balance", FAIL, "Actual -  {sActualCashBalance} is not matching with Expected - {sExpectedCashBalance}")
		[+] else
			[ ] ReportStatus("Verify that Total Market Value", FAIL, "Verification has not been done as transaction - {lsTransactionData[1]} is not added ") 
			[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //############### Verify Quicken File Attributes #######################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test15_VerifyQuickenFileAttributes()
		[ ] //
		[ ] // Description: 				
		[ ] // This testcase will verify  File Attributes. Confirm the following - Accounts -3, Categories â 162, Memorized Payees â 2, Securities â 5 and Transactions â 7
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] //
		[ ] // Returns:			        	Pass 		if attributes verification is done successfully 							
		[ ] //							Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	 24/12/2020  	Created By	Udita Dube
		[ ] //	  
	[ ] //*********************************************************
[+] testcase Test15_VerifyQuickenFileAttributes () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] LIST OF STRING lsActualFileAttribute,lsFileAttributes
		[ ] INTEGER i
		[ ] STRING sExpectedAttribute
	[+] // Expected values of Quicken File Attributes
		[ ] lsFileAttributes = {"Accounts", "Categories", "Memorized Payee", "Securities", "Transactions" }
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sQuickenAttributesWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsQuickenAttributes=lsExcelData[2]
	[ ] 
	[ ] // Quicken is launched then Verify File Attributes
	[+] if (QuickenMainWindow.Exists() == True)
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] 
		[ ] // Active Quicken Screen
		[ ] QuickenMainWindow.SetActive()
		[ ] // Taking all File Attributes of Quicken
		[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
		[ ] 
		[ ] // Verification of Actual File Attributes
		[+] for (i=1;i<=ListCount(lsActualFileAttribute);i++)
			[ ] sExpectedAttribute=str(val(lsQuickenAttributes[i]))
			[+] if(sExpectedAttribute == lsActualFileAttribute[i])
				[ ] ReportStatus("Check File Attributes", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i]}") 
			[+] else
				[ ] ReportStatus("Check File Attributes", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i]}")
				[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //########## Turn OFF UI Navigation elements ######################################## 
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test16_UINavigationOff()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Uncheck navigation related elements and 
		[ ] // check their effects
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while navigation							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 23, 2010		Mamta Jain created	
	[ ] //*********************************************************
	[ ] 
[+] testcase Test16_UINavigationOff() appstate SmokeBaseState
	[ ] 
	[-] // Variable Declaration
		[ ] INTEGER iMode
		[ ] BOOLEAN bEnable, bPlanningMenuExist, bExist
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] iMode = SetViewMode(VIEW_STANDARD_MENU)		// Select standard menu
		[ ] ReportStatus("Set to Standard View", iMode, "Standard menu select")
		[ ] 
		[ ] iMode = UsePopupRegister("OFF")				// use pop up register mode is turned off
		[ ] ReportStatus("Disable Pop up", iMode, "Pop up register mode disabled")
		[ ] 
		[ ] iMode = ShowToolBar("OFF")						// show tool bar mode is turned off
		[ ] ReportStatus("Disable Show Tool bar", iMode, "Show tool bar menuitem disabled")
		[ ] 
		[ ] bEnable = QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.Exists()	// checking tool bar is displayed or not
		[+] if(bEnable == FALSE)
			[ ] ReportStatus("Validate Tool bar", PASS, "Tool bar is not displayed")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Tool bar", FAIL, "Tool bar is still displayed")
			[ ] 
		[ ] bPlanningMenuExist = QuickenMainWindow.Planning.Exists()		// checking menu items are present or not as standard menu is selected
		[ ] 
		[+] if (bPlanningMenuExist == FALSE)
			[ ] ReportStatus("Validate menus unavailability", PASS, "Planning Menu is not present")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate menus unavailability", FAIL, "Planning Menu is present")
			[ ] 
		[ ] 
		[ ] AccountBarSelect(ACCOUNT_BANKING,1)						// on clicking any account from account bar, check new window is opened or not
		[ ] bExist =  BankingPopUp.Exists()
		[+] if (bExist == FALSE)
			[ ] ReportStatus("Validate Pop up", PASS, "New window is not opened")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Pop up", FAIL, "New window is opened")
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Turn ON UI Navigation elements ##########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test17_UINavigationOn()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Check navigation related elements and
		[ ] // check their effect
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while navigation							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 23, 2010		Mamta Jain created	
	[ ] //*********************************************************
	[ ] 
[+] testcase Test17_UINavigationOn() appstate SmokeBaseState
	[+] // Variable Declaration
		[ ] INTEGER iMode
		[ ] BOOLEAN bEnable, bExist, bPlanningMenuExist
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] 
		[ ] iMode = SetViewMode(VIEW_CLASSIC_MENU)		// Select Classic menu
		[ ] ReportStatus("Set View to Classic View", iMode, "Classic menu select")
		[ ] 
		[ ] iMode = UsePopupRegister("ON")				// use pop up register mode is turned on
		[ ] ReportStatus("Enable Pop up register mode", iMode, "Pop up register mode enabled")
		[ ] 
		[ ] iMode = ShowToolBar("ON")						// show tool bar mode is turned off
		[ ] ReportStatus("Enable Show Tool Bar menuitem", iMode, "Show tool bar enabled")
		[ ] 
		[ ] bEnable = QuickenMainWindow.QWTOOLBAR.QW_MAIN_TOOLBAR.Exists()	// checking availability of Tool bar
		[+] if(bEnable == TRUE)
			[ ] ReportStatus("Validate Tool Bar Availability", PASS, "Tool bar is displayed")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Tool Bar Availability", FAIL, "Tool bar is not displayed")
			[ ] 
		[ ] bPlanningMenuExist = QuickenMainWindow.Planning.Exists()		// checking menu items are present or not as classic menu is selected
		[ ] 
		[+] if (bPlanningMenuExist == TRUE)
			[ ] ReportStatus("Validate menus availability", PASS, "Menus are displayed")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate menus availability", FAIL, "Menus are not displayed")
			[ ] 
		[ ] 
		[ ] AccountBarSelect(ACCOUNT_BANKING,1)						// on clicking any account from account bar, check new window is opened or not
		[ ] BankingPopUp.VerifyEnabled(TRUE, 20)
		[ ] bExist =  BankingPopUp.Exists()
		[ ] 
		[+] if (bExist == TRUE)
			[ ] ReportStatus("Validate Pop up", PASS, "New window is opened")
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Pop up", FAIL, "New window is not opened")
			[ ] 
			[ ] 
		[ ] BankingPopUp.Close()
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Manage Bill and Income reminders   ######################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test18_ShortcutKeyBillandIncomeReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Bill and Income Reminder window using short cut keys.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while opening window							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 23, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test18_ShortcutKeyBillandIncomeReminder() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] BOOLEAN bEnable
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] QuickenMainWindow.TypeKeys("<Ctrl-j>")
		[ ] bEnable = BillAndIncomeReminders.Exists()
		[+] if (bEnable == TRUE)
			[ ] BillAndIncomeReminders.Maximize()
			[ ] ReportStatus("Validate Shortcut key Ctrl-J", PASS, "Manage Bill and Income Reminder Window is displayed using Short cut Key") 
			[ ] BillAndIncomeReminders.Close()
		[+] else
			[ ] ReportStatus("Validate Shortcut key Ctrl-J", FAIL, "Manage Bill and Income Reminder Window is not displayed") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Open Account List from Tools Menu  ###################################### 
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test19_OpenAccountList()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Account list from Tools menu and check window title
		[ ] // Also check previously added accounts
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking account list							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 24, 2010		Mamta Jain created
		[ ] // 	  Jan 31, 2011		Udita Dube  updated
	[ ] //*********************************************************
[+] testcase Test19_OpenAccountList() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] BOOLEAN bExist, bAssert, bMatch
		[ ] INTEGER iNavigate
		[ ] STRING sCaption, sHandle, sActual, sExpected
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
		[+] if(iNavigate == PASS)
			[ ] bExist = AccountList.Exists()
			[+] if(bExist== TRUE)
				[ ] AccountList.Maximize()
				[ ] sCaption = AccountList.GetCaption()
				[ ] bAssert = AssertEquals(TOOLS_ACCOUNT_LIST, sCaption)
				[+] if(bAssert == TRUE)
					[ ] ReportStatus("Validate window title", PASS, "Window title -  {sCaption} is correct") 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate window title", FAIL, "Window title -  {sCaption}is not correct")
					[ ] 
				[ ] 
				[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
				[ ] 
				[ ] // ####### Validate Accounts in Account List window #####################
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
				[ ] bMatch = MatchStr("*{lsExcelData[1][2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate First Account", PASS, "{lsExcelData[1][2]} account is present") 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate First Account", FAIL, "{lsExcelData[1][2]} account is not present") 
					[ ] 
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "4")
				[ ] bMatch = MatchStr("*{lsExcelData[2][2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate second Account", PASS, "{lsExcelData[2][2]} account is present") 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate second Account", FAIL, "{lsExcelData[2][2]} account is not present") 
					[ ] 
				[ ] 
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "8")
				[ ] bMatch = MatchStr("*{lsExcelData[4][2]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate third Account", PASS, "{lsExcelData[4][2]} account is present") 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate third Account", FAIL, "{lsExcelData[4][2]} account is not present") 
					[ ] 
				[ ] 
				[ ] AccountList.Close ()
			[+] else
				[ ] ReportStatus("Validate Account List window", FAIL, "Account List  window is not opened") 
		[+] else
			[ ] ReportStatus("Validate Account List Window", iNavigate, "Account List window is not invoked from Tools menu") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Open Category List from Tools Menu  #####################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test20_OpenCategoryList()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Category list from Tools menu and check window title
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking category list							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 24, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test20_OpenCategoryList() appstate SmokeBaseState
	[+] // Variable Declaration
		[ ] BOOLEAN bExist, bAssert
		[ ] INTEGER iNavigate
		[ ] STRING sCaption
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] iNavigate = NavigateQuickenTools(TOOLS_CATEGORY_LIST)
		[+] if(iNavigate == PASS)
			[ ] bExist = CategoryList.Exists()
			[+] if(bExist== TRUE)
				[ ] ReportStatus("Validate Category List window", PASS, "Category List window is opened") 
				[ ] 
				[ ] sCaption = CategoryList.GetCaption()
				[ ] bAssert = AssertEquals(TOOLS_CATEGORY_LIST, sCaption)
				[+] if(bAssert == TRUE)
					[ ] ReportStatus("Validate window title", PASS, "Window title-  {sCaption} is found") 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate window title", FAIL, "Window title -  {sCaption}is not matching with Expected - {TOOLS_CATEGORY_LIST}") 
					[ ] 
				[ ] CategoryList.Close ()
			[+] else
				[ ] ReportStatus("Validate Category List window", FAIL, "Category List window is not opened") 
				[ ] 
		[+] else
			[ ] ReportStatus("Validate Category List Window", iNavigate, "Category List window is not invoked from Tools menu") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Open Memorized Payee List from Tools Menu  ##############################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test21_OpenMemorizedPayeeList()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Memorized Payee List from Tools menu and check window title
		[ ] // Also check previously added payees.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking Memorized Payee List 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 24, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test21_OpenMemorizedPayeeList() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] BOOLEAN bExist, bAssert, bMatch
		[ ] INTEGER iNavigate, iCount
		[ ] STRING sCaption, sHandle, sActual, sExpected
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sCheckingTransactionWorksheet)
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] iNavigate = NavigateQuickenTools(TOOLS_MEMORIZE_PAYEE_LIST)
		[+] if(iNavigate == PASS)
			[ ] bExist = MemorizedPayeeList.Exists()
			[+] if(bExist == TRUE)
				[ ] sCaption = MemorizedPayeeList.GetCaption()
				[ ] bAssert = AssertEquals(TOOLS_MEMORIZE_PAYEE_LIST, sCaption)
				[+] if(bAssert == TRUE)
					[ ] ReportStatus("Validate Memorized Payee List window title", PASS, "Window title -  {sCaption} is correct") 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Memorized Payee List window title", FAIL, "Window title -  {sCaption}is not correct") 
					[ ] 
				[ ] 
				[ ] iCount = ListCount(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetContents())
				[+] if(iCount != 0)
					[ ] sHandle = Str(MemorizedPayeeList.MemorizedPayeeList.ListBox.GetHandle ())
					[ ] 
					[ ] // ####### Validate Payee in Payee List window #####################
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
					[ ] bMatch = MatchStr("*{lsExcelData[1][6]}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate First Payee", PASS, "Payee name - {lsExcelData[1][6]} is displayed") 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate First Payee", FAIL, "Actual Payee name - {sActual}, Expected Payee name - {lsExcelData[1][6]}") 
						[ ] 
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "1")
					[ ] bMatch = MatchStr("*{lsExcelData[2][6]}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate second Payee", PASS, "Payee name - {lsExcelData[2][6]} is displayed") 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate second Account", FAIL, "Actual Payee name - {sActual}, Expected Payee name - {lsExcelData[2][6]}") 
						[ ] 
				[+] else
					[ ] ReportStatus("Validate Count of Payees", PASS, "Count of Payees - {iCount}")
					[ ] 
				[ ] MemorizedPayeeList.Close ()
			[+] else
				[ ] ReportStatus("Validate Memorized Payee List window", FAIL, "Memorized Payee List window is not opened") 
				[ ] 
		[+] else
			[ ] ReportStatus("Validate Memorized Payee List Window", iNavigate, "Memorized Payee List window is not invoked from Tools menu") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //############### Run Net worth report ###############################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 		Test22_RunNetWorthReport()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Test Case  is to open graph report for Net Worth and verifies the window title
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Net Worth Report opens successfully with expected window title					
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	28/12/2020  	Created By	Udita Dube
		[ ] // 
	[ ] //*********************************************************
[+] testcase Test22_RunNetWorthReport () appstate SmokeBaseState
	[+] // Variable declaration
		[ ] BOOLEAN bWindowTitle
		[ ] INTEGER  iReportSelect
		[ ] STRING sActual
		[ ] STRING sExpWindowTitle= "Net Worth"
	[ ] 
	[ ] // If Quicken is launched then run Net Worth Report
	[+] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] // Set Activate main window
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] // Open Net Worth Report
		[ ] iReportSelect = OpenReport(lsReportCategory[10], sREPORT_NETWORTH)		// OpenReport("Graphs", "Net Worth")
		[ ] ReportStatus("Run {sREPORT_NETWORTH} Report", iReportSelect, "Run Report successful") 
		[ ] 
		[ ] // Verify Net Worth window is Opened
		[+] if (wReport.Exists())
			[ ] 
			[ ] // Set Activate Net Worth window
			[ ] wReport.SetActive()
			[ ] 
			[ ] // Maximize Net Worth Report window
			[ ] wReport.Maximize()
			[ ] 
			[ ] // Get window caption
			[ ] sActual = wReport.GetCaption()
			[ ] 
			[ ] // Verify window title
			[ ] bWindowTitle = AssertEquals(sExpWindowTitle, sActual)
			[ ] 
			[ ] // Report Status if window title is as expected
			[+] if (bWindowTitle == TRUE)
				[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
			[ ] // Report Status if window title is wrong
			[+] else
				[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title  -  {sActual} is not matching with Expected - {sExpWindowTitle}") 
			[ ] 
			[ ] // Close Net Worth Report window
			[ ] wReport.Close()
			[ ] 
		[ ] // Report Status if Net Worth window is not available
		[+] else
			[ ] ReportStatus("Verification of {sExpWindowTitle} window", FAIL, "{sExpWindowTitle} window not found") 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] //###############################################################################
[ ] 
[+] //############### Run Spending by Category report ######################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 		Test23_RunSpendingByCategoryReport()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This Tesecase is to open graph report for Spending By Category and verifies categories and its values
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 		if Spending By Category Report opens successfully with expected categories and  values					
		[ ] //							Fail		if any error occurs 
		[ ] // 
		[ ] // REVISION HISTORY:	28/12/2020  	Created By	Udita Dube
		[ ] // 
	[ ] //*********************************************************
[+] testcase Test23_RunSpendingByCategoryReport () appstate SmokeBaseState
	[ ] 
	[-] // Variable declaration
		[ ] BOOLEAN bWindowTitle,bMatch1,bMatch2
		[ ] INTEGER  iReportSelect
		[ ] STRING sActual,sHandle,sCategoryValue1,sCategoryValue2,sExpectedCategory1,sValue1,sValue2,sExpWindowTitle
	[-] // Expected values
		[ ] sExpWindowTitle= "Spending by Category"
		[ ] sExpectedCategory1="Financial"
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sCheckingTransactionWorksheet)
	[ ] 
	[ ] // If Quicken is launched then run Spending by Category Report
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] // Set Activate main window
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] // Open Spending by Category Report
		[ ] iReportSelect = OpenReport(lsReportCategory[5],sExpWindowTitle)			//OpenReport("Spending",sExpWindowTitle)
		[-] if (iReportSelect == PASS)
			[ ] ReportStatus("Run {sExpWindowTitle} Report", PASS, "Run Report {sExpWindowTitle} successful") 
		[-] else
			[ ] ReportStatus("Run {sExpWindowTitle} Report", FAIL, "Run Report {sExpWindowTitle} Failed") 
		[ ] 
		[ ] // Verify Spending by Category window is Opened
		[-] if (wReport.Exists())
			[ ] 
			[ ] // Set Activate Spending by Category window
			[ ] wReport.SetActive()
			[ ] 
			[ ] // Maximize Spending by Category Report window
			[ ] wReport.Maximize()
			[ ] 
			[ ] 
			[ ] // Get window caption
			[ ] sActual = wReport.GetCaption()
			[ ] 
			[ ] // Verify window title
			[ ] bWindowTitle = AssertEquals(sExpWindowTitle, sActual)
			[-] if (bWindowTitle == TRUE)
				[ ] ReportStatus("Validate Report Window Title", PASS, "Window Title -  {sActual} is correct") 
			[-] else
				[ ] ReportStatus("Validate Report Window Title", FAIL, "Window Title -  {sActual} is not matching with Expected - {sExpWindowTitle}") 
			[ ] 
			[ ] //Edited by sandeep
			[ ] //If data is more than 1 year old the default report setting is not populating records so changing it to Include all dates
			[ ] //BankingPopUp.CustomWin("[QWCustomizeBar]#1|$5000|@(431,94)").PopupList("#1|$1000|@(121,15)").selectlist("Year to date")
			[ ] // SpendingByCategory.QWCustomizeBar1.SelectDateRange.Select(1)
			[ ] sValue1=trim(str(val(lsExcelData[2][3]),7,2))
			[ ] //  Validate Report Data
			[ ] sHandle = Str(SpendingByCategory.QWListViewer1.ListBox1.GetHandle ())
			[ ] sCategoryValue1= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"1")
			[ ] bMatch1 = MatchStr("*{sExpectedCategory1}*{sValue1}*", sCategoryValue1)
			[-] if(bMatch1)
				[ ] ReportStatus("Validate Report Data", PASS, "Report data is correct: Category1= {sExpectedCategory1} with Value {sValue1}")
			[-] else
				[ ] ReportStatus("Validate Report Data", FAIL, "Actual report data - {sCategoryValue1} is not matching with Expected  - {sExpectedCategory1} {sValue1}")
				[ ] 
			[ ] 
			[ ] sValue2=trim(str(val(lsExcelData[1][3]),7,2))
			[ ] 
			[ ] sCategoryValue2= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"3")
			[ ] bMatch2 = MatchStr("*{lsExcelData[1][8]}*{sValue2}*", sCategoryValue2)
			[+] if(bMatch2)
				[ ] ReportStatus("Validate Report Data", PASS, "Report data is correct: Category2= {lsExcelData[1][8]} with Value {sValue2} ")
			[+] else
				[ ] ReportStatus("Validate Report Data", FAIL, "Actual report data - {sCategoryValue2} is not matching with Expected  - {lsExcelData[1][8]} {sValue2}")
				[ ] 
			[ ] // Close Spending by Category Report window
			[ ] wReport.Close()
			[ ] //check if save as report popup is displayed
			[-] if ReminderDetails.OK3.exists()
				[ ] ReminderDetails.OK3.click()
				[ ] sleep(3)
			[ ] 
		[ ] // Report Status if Spending by Category window is not available
		[+] else
			[ ] ReportStatus("Verification of {sExpWindowTitle} window", FAIL, "{sExpWindowTitle} window not found") 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
	[ ] 
[ ] //################################################################################
[ ] 
[+] //########## Open Spending Tab  #####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test24_OpenSpendingTab()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Spending tab and validate window title.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking spending tab							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 23, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test24_OpenSpendingTab() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] BOOLEAN bEnable, bMatch
		[ ] INTEGER iNavigate
		[ ] STRING sCaption
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] iNavigate = NavigateQuickenTab(sTAB_SPENDING)
		[+] if (iNavigate == PASS)
			[ ] ReportStatus("Validate tab navigation", iNavigate, "{sTAB_SPENDING} tab is invoked") 
			[ ] 
			[ ] sCaption = QuickenMainWindow.GetCaption()
			[ ] bMatch = Matchstr("*Spending*", sCaption)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Window Title", PASS, "Window Title - {sTAB_SPENDING} is correct") 
			[+] else
				[ ] ReportStatus("Validate Window Title", FAIL, "Window Title - {sTAB_SPENDING} is not correct") 
		[+] else
			[ ] ReportStatus("Validate tab navigation", iNavigate, "Spending tab is not invoked") 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[ ] // Comment Sandeep : Commenting this testcase as spending planner is removed from QW2012
[+] //########## Open Spending Planner  and Validate Spending Goals #########################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test25_OpenSpendingPlanner()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Planning center from Planning menu
		[ ] // and then select Spending Planner and validate previously added spending goals
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while invoking and validating 
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 28, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] // testcase Test25_OpenSpendingPlanner() appstate SmokeBaseState
	[+] // // Variable declaration
		[ ] // BOOLEAN bEnable, bMatch
		[ ] // INTEGER iNavigate
		[ ] // STRING sHandle, sActual, sExpected
    // 
	[-] // if(QuickenMainWindow.Exists())
		[ ] // QuickenMainWindow.SetActive()
		[ ] // QuickenMainWindow.Planning.GoToPlanning.Pick()
		[ ] // Planning.SetActive ()
		[ ] // QuickenMainWindow.QWNavigator.SpendingPlanner.Click ()
		[ ] // sHandle = Str(Planning.PlanningSubTab.SpendingPlanner.CategorizedSpending.MonthlySpendingSavingPlan.QWListViewer1.ListBox1.GetHandle())
		[ ] // 
		[ ] // // ############### Validate first category: Entertainment ###################
		[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "17")
		[ ] // sExpected = "Entertainment"
		[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
		[+] // if(bMatch == TRUE)
			[ ] // ReportStatus("Validate first category", PASS, "{sExpected} found") 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate first category", FAIL, "Actual Value - {sActual}, Expected Value - {sExpected}") 
			[ ] // 
		[ ] // 
		[ ] // // ############### Validate second category: Food & Dining ###################
		[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "20")
		[ ] // sExpected = "Food & Dining"
		[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
		[+] // if(bMatch == TRUE)
			[ ] // ReportStatus("Validate second category", PASS, "{sExpected} found") 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate second category", FAIL, "Actual Value - {sActual}, Expected Value - {sExpected}") 
			[ ] // 
		[ ] // 
    // // ############### Validate third category: Shopping ###################
		[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "23")
		[ ] // sExpected = "Shopping"
		[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
		[+] // if(bMatch == TRUE)
			[ ] // ReportStatus("Validate third category", PASS, "{sExpected} found") 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate third category", FAIL, "Actual Value - {sActual}, Expected Value - {sExpected}") 
			[ ] // 
		[ ] // 
		[ ] // // ############### Validate fourth category: Shopping:Books ###################
		[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "26")
		[ ] // sExpected = "Shopping:Books"
		[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
		[+] // if(bMatch == TRUE)
			[ ] // ReportStatus("Validate fourth category", PASS, "{sExpected} found") 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate fourth category", FAIL, "Actual Value - {sActual}, Expected Value - {sExpected}") 
			[ ] // 
		[ ] // 
		[ ] // // ############### Validate fifth category: Shopping:Clothing ###################
		[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "29")
		[ ] // sExpected = "Shopping:Clothing"
		[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
		[+] // if(bMatch == TRUE)
			[ ] // ReportStatus("Validate fifth category", PASS, "{sExpected} found") 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate fifth category", FAIL, "Actual Value - {sActual}, Expected Value - {sExpected}") 
			[ ] // 
		[ ] // 
		[ ] // // ############### Validate Total Spending goal: 100 ###################
		[ ] // sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "15")
		[ ] // sExpected = "$100"
		[ ] // bMatch = MatchStr("*{sExpected}*", sActual)
		[+] // if(bMatch == TRUE)
			[ ] // ReportStatus("Validate Total Spending Goal", PASS, "Total Spending Goal : $100") 
			[ ] // 
		[+] // else
			[ ] // ReportStatus("Validate Total Spending Goal", FAIL, "Actual value - {sActual}, Expected Value - {sExpected}") 
			[ ] // 
		[ ] // 
	[+] // else
		[ ] // ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] // 
	[ ] // 
[ ] //##############################################################################
[ ] 
[+] //########## Open Investing Center  #################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test26_OpenInvestingCenter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will navigate to Investing >Protfolio tab and verify total cost basis and 
		[ ] // Validate that Price history dialog for Intuit is invoked.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  10 Jan, 2011  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test26_OpenInvestingCenter() appstate SmokeBaseState
	[-] // Variable declaration
		[ ] BOOLEAN bMatch
		[ ] INTEGER iNavigate,i,iCount
		[ ] STRING sActual,sExpected,sHandle,sExpectedWindowTitle,sActualWindowTitle,sExpectedSecurity,sRow
    
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sInvestingTransactionWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsTransactionData=lsExcelData[2]
	[ ] 
	[ ] sExpectedWindowTitle= "Price History for: {lsTransactionData[5]}"
	[ ] 
	[-] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] // Menu bar > Go to Investing
		[ ] QuickenMainWindow.Investing.GoToInvesting.Pick()
		[ ] 
		[ ] // Navigate to Investing > Portfolio tab
		[ ] iNavigate=NavigateQuickenTab(sTAB_INVESTING,sTAB_PORTFOLIO)
		[ ] ReportStatus("Navigate to {sTAB_INVESTING} > {sTAB_PORTFOLIO} ", iNavigate, "Navigate to {sTAB_INVESTING} > {sTAB_PORTFOLIO}") 
		[ ] 
		[ ] sExpected=str(val(lsTransactionData[10]),NULL,2)
		[ ] sExpected=stuff(sExpected,2,0,",")
		[ ] 
		[ ] sHandle = Str(Investing.ShowValue.ListBox1.GetHandle())
		[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
		[ ] // Verify Total Cost Basis
		[ ] bMatch = MatchStr("*{sExpected}*", sActual)
		[-] if(bMatch == TRUE)
			[ ] ReportStatus("Verify Total Cost Basis", PASS, "Total Cost Basis {sExpected} is correctly displayed under {sTAB_INVESTING} > {sTAB_PORTFOLIO}  tab") 
			[ ] 
		[-] else
			[ ] ReportStatus("Verify Total Cost Basis", FAIL, "Expected Value - {sExpected} is not matching with Actual Value - {sTAB_PORTFOLIO}") 
			[ ] 
		[ ] 
		[ ] iCount=Investing.ShowValue.ListBox1.GetItemCount()
		[ ] 
		[-] for(i=0;i<=iCount;i++)
			[ ] 
			[ ] sHandle = Str(Investing.ShowValue.ListBox1.GetHandle())
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, str(i))
			[ ] bMatch = MatchStr("*{lsTransactionData[5]}*", sActual)
			[-] if(bMatch == TRUE)
				[ ] Investing.SetActive()
				[ ] sRow = QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, str(i))
				[-] if(sRow=="1")
					[ ] sleep(2)
					[ ] // Right Click and select Price History
					[ ] Investing.ShowValue.ListBox1.PopupSelect (40, 82, "Price History")
					[ ] 
					[+] if (PriceHistory.Exists(5))
						[ ] 
						[ ] sActualWindowTitle=PriceHistory.GetCaption()
						[ ] // Verify Window Title
						[ ] bMatch = MatchStr("*{sExpectedWindowTitle}*", sActualWindowTitle)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Verify Price History window title", PASS, "Window tile {sExpectedWindowTitle} is correct") 
							[ ] 
						[+] else
							[ ] ReportStatus("Verify Price History window title", FAIL, "Expected Value - {sExpectedWindowTitle} is not matching with Actual Value - {sActualWindowTitle}") 
							[ ] 
						[ ] 
						[ ] PriceHistory.Close()
						[ ] 
					[+] else
						[ ] ReportStatus("Verify Price History window", FAIL, "Window {sExpectedWindowTitle} is not invoked") 
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Row Selection", FAIL, "Row is not getting selected") 
				[ ] ReportStatus("Find Security under {sTAB_INVESTING} tab", PASS, "Security {lsTransactionData[4]} is displayed under {sTAB_INVESTING} tab") 
				[ ] break
			[+] else
				[ ] continue
				[ ] 
			[ ] 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //########## Invoke Lifetime Planner  ###############################################
	[ ] //*********************************************************
	[-] // TestCase Name:	 Test27_InvokeLifetimePlanner()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will navigate Planning > Lifetime Planner and 
		[ ] // Validate âChange Assumptionsâ button is present
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] // 11 Jan, 2011  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test27_InvokeLifetimePlanner() appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN  bMatch
		[ ] STRING sCaption
    
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] QuickenMainWindow.Planning.GoToPlanning.pick()
		[ ] QuickenMainWindow.Planning.LifetimePlanner.Pick()
		[ ] 
		[ ] QuickenMainWindow.SetActive()
		[ ] sCaption = QuickenMainWindow.GetCaption ()
		[ ] bMatch = MatchStr("*{sTAB_PLANNING}*", sCaption)
		[+] if (bMatch == TRUE)
			[ ] ReportStatus("Validate Planning tab", PASS, "{sTAB_PLANNING} tab is invoked") 
		[+] else
			[ ] ReportStatus("Validate Planning tab", FAIL, "{sTAB_PLANNING} tab is not invoked") 
		[ ] 
		[ ] Planning.SetActive()
		[ ] 
		[+] if(Planning.ChangeAssumptions.Exists(5))
			[ ] ReportStatus("Verify 'Change Assumptions' button", PASS, "Change Assumption button is present under {sTAB_PLANNING} > {sTAB_LIFETIME_PLANNER}") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify 'Change Assumptions' button", FAIL, "Change Assumption button is not present under {sTAB_PLANNING} > {sTAB_LIFETIME_PLANNER}") 
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //########## Invoke Tax Center  #################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test28_InvokeTaxCenter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Tax Center and 
		[ ] // Validate âAssign Tax Categoriesâ button is displayed
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  11 Jan, 2011  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test28_InvokeTaxCenter() appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iNavigate
		[ ] 
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] // Navigate to Planning > Tax Center tab
		[ ] iNavigate=NavigateQuickenTab(sTAB_PLANNING,sTAB_TAX_CENTER)
		[ ] ReportStatus("Navigate to {sTAB_PLANNING} > {sTAB_TAX_CENTER} ", iNavigate, "Navigate to {sTAB_PLANNING} > {sTAB_TAX_CENTER}") 
		[ ] 
		[ ] // Validate âAssign Tax Categoriesâ button is displayed
		[+] if(Planning.PlanningSubTab.TaxCenter.TaxRelatedExpensesYTD.AssignTaxCategories.Exists(5))
			[ ] ReportStatus("Verify 'Assign Tax Categories' button", PASS, "Assign Tax Categories button is present under {sTAB_PLANNING} > {sTAB_TAX_CENTER}") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify 'Assign Tax Categories' button", FAIL, "Assign Tax Categories button is not present under {sTAB_PLANNING} > {sTAB_TAX_CENTER}") 
			[ ] 
		[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //########## Open Tax Planner ####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test29_OpenTaxPlanner()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will invoke Tax Planner and 
		[ ] // Validate value of Short term gains and losses
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //  10 Feb, 2011  Udita Dube created
	[ ] //*********************************************************
[+] testcase Test29_OpenTaxPlanner() appstate SmokeBaseState
	[ ] 
	[-] // Variable declaration
		[ ] BOOLEAN bMatch
		[ ] STRING sActualShortGainsLosses, sExpectedShortGainsLosses
		[ ] sExpectedShortGainsLosses="150"
    
	[ ] 
	[-] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] // Check whether Planning is checked or not: View Menu > Tabs to Show > Planning
		[-] if(QuickenMainWindow.View.TabsToShow.Planning.IsChecked() == FALSE)	
			[ ] QuickenMainWindow.View.TabsToShow.Planning.Pick ()
		[ ] 
		[ ] // Menu item Planning > Tax Planner
		[ ] QuickenMainWindow.Planning.TaxPlanner.Pick()
		[ ] 
		[ ] // ICheck that Tax Planner window is opened
		[-] if(TaxPlanner.Exists(LONG_SLEEP))
			[ ] 
			[ ] TaxPlanner.SetActive()
			[ ] 
			[ ] // Click on Capital Gains
			[ ] TaxPlanner.QWBrowserContainer1.StaticText1.ShellEmbedding1.ShellDocObjectView1.InternetExplorer_Server1.Click(1,48, 178)
			[ ] 
			[ ] // Get value of "Short Term Gains and Losses"
			[ ] sActualShortGainsLosses=TaxPlanner.QWBrowserContainer1.StaticText1.ShellEmbedding1.ShellDocObjectView1.InternetExplorer_Server1.ATL048CB1801.StaticText1.DialogBox1.RegularTax1.GetText()
			[ ] 
			[ ] // Match the Actual and Expected values
			[ ] bMatch=AssertEquals(sExpectedShortGainsLosses,sActualShortGainsLosses)
			[+] if(bMatch==TRUE)
				[ ] ReportStatus("Validate short term Gains and Losses", PASS, "Short term Gains and Losses is displayed correctly i.e. {sActualShortGainsLosses}")
			[+] else
				[ ] ReportStatus("Validate short term Gains and Losses", FAIL, "Actual - {sActualShortGainsLosses} is not matching with Expected - {sExpectedShortGainsLosses}")
			[ ] 
			[ ] // Close Tax Planner window
			[+] if(TaxPlanner.Exists(SHORT_SLEEP))
				[ ] TaxPlanner.Close()
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Tax Planner window", FAIL, "Tax Planner window is not found")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //############# Open Business Center #############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test30_OpenBusinessCenter()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will open Business Center and Validate Window Title
		[ ] // also validate Total In and Total Out values
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while Opening and verifying							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 5, 2011		Mamta Jain created	
	[ ] // ********************************************************
[+] testcase Test30_OpenBusinessCenter() appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] STRING sActual, sExpected
		[ ] BOOLEAN bMatch
	[ ] 
	[+] if(SKU_TOBE_TESTED != "Premier")
		[+] if(QuickenMainWindow.Exists(MEDIUM_SLEEP))
			[ ] QuickenMainWindow.SetActive()
			[+] if(QuickenMainWindow.View.TabsToShow.Business.IsChecked() == FALSE)	// check whether Business tab is checked or not
				[ ] QuickenMainWindow.View.TabsToShow.Business.Pick ()
			[ ] NavigateQuickenTab(sTAB_BUSINESS)								// select Business tab
			[ ] 
			[ ] sActual = QuickenMainWindow.GetCaption()			// Verify Window title
			[ ] bMatch = MatchStr("*{sTAB_BUSINESS}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Window Title", PASS, "Window title is correct") 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Window Title", FAIL, "Actual value - {sActual}, Expected value - {sTAB_BUSINESS}") 
				[ ] 
			[ ] 
			[ ] sActual = Business.ProfitLossSnapshot.MonthPanel.TotalIn.GetText ()		// Verify Total In value
			[ ] sExpected = "$0.00"
			[ ] bMatch = AssertEquals(sExpected, sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Total In value", PASS, "Expected - {sExpected} matches with Actual - {sActual} Total In value") 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Total In value", FAIL, "Expected - {sExpected}, Actual - {sActual} Total In value") 
				[ ] 
			[ ] 
			[ ] 
			[ ] sActual = Business.ProfitLossSnapshot.MonthPanel.TotalOut.GetText ()	// Verify Total Out value
			[ ] sExpected = "$0.00"
			[ ] bMatch = AssertEquals(sExpected, sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Total Out value", PASS, "Expected - {sExpected} matches with Actual - {sActual} Total Out value") 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Total Out value", FAIL, "Expected - {sExpected}, Actual - {sActual} Total Out value") 
				[ ] 
		[+] else
			[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate testcase according to SKU", WARN, "This Testcase is not executed as this is not applicable for PREMIER SKU") 
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //############# Add, Edit And Delete Category ########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test31_AddEditDeleteCategory()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Add new category, then edit that category 
		[ ] // and then delete the editted category
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while Adding,Editting.Deleting category							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 4, 2011		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test31_AddEditDeleteCategory() appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER iAdd, iSearch, iEdit, iDelete
		[ ] LIST OF STRING lsEditCategory
		[ ] // CategoryRecord EditCategory = {"Edit US Government Interest", "", "Editted For Smoke Test"}
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sCategoryWorksheet)
	[ ] lsCategoryData=lsExcelData[1]
	[ ] lsEditCategory=lsExcelData[2]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] NavigateQuickenTab(sTAB_HOME)
		[ ] Home.VerifyEnabled(TRUE, 20)
		[ ] 
		[ ] iAdd = AddCategory(lsCategoryData[1], lsCategoryData[2], lsCategoryData[3])			// Add new category
		[ ] ReportStatus("Add Category", iAdd, "Category - {lsCategoryData[1]}, is added ") 
		[ ] 
		[ ] iSearch = SearchCategory(lsCategoryData[1])						// search added category
		[+] if(iSearch == PASS)	
			[ ] iEdit = EditCategory(lsExcelData[2])				// edit category
			[+] if(iEdit == PASS)
				[ ] ReportStatus("Edit Category", iEdit, "Category - {lsCategoryData[1]}, is editted ") 
				[ ] 
			[+] else
				[ ] ReportStatus("Edit Category", iEdit, "Category - {lsEditCategory[1]} is not editted ") 
				[ ] 
			[ ] iDelete = DeleteCategory(lsEditCategory[1])							// delete editted category
			[+] if (iDelete == PASS)
				[ ] ReportStatus("Delete Category", iDelete, "Category - {lsEditCategory[1]} is deleted ") 
				[ ] 
			[+] else
				[ ] ReportStatus("Delete Category", iDelete, "Category - {lsEditCategory[1]} is not deleted ") 
				[ ] 
			[ ] 
			[+] if(CategoryList.Exists())
				[ ] CategoryList.Close()
		[+] else
			[+] if(CategoryList.Exists())
				[ ] CategoryList.Close()
			[ ] 
			[ ] ReportStatus("Validate Category", iSearch, "Category - {lsCategoryData[1]} is not found ") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] //##############################################################################
[ ] // 
[+] //############# Impact of modifying transactions on report #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test32_ModifyTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Edit transaction, check the transaction report
		[ ] // and then delete the editted transaction and check the transaction report
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while Editting.Deleting and verifying transaction							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 6, 2011		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test32_ModifyTransaction() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER iValidate, iSelect, iEdit, iDelete
		[ ] STRING sWindowType, sHandle, sActual, sExpected, sOutFlow
		[ ] LIST OF STRING lsEditTransaction
		[ ] BOOLEAN bMatch
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sSmokeData, sCheckingTransactionWorksheet)
	[ ] lsTransactionData=lsExcelData[1]
	[ ] lsEditTransaction=lsExcelData[3]
	[ ] 
	[+] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive()
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[+] if(QuickenMainWindow.View.UsePopUpRegisters.IsChecked() == TRUE)		// checking the window type
			[ ] sWindowType = sPopUpWindow
		[+] else
			[ ] sWindowType = sMDIWindow
		[ ] 
		[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, 1)		// Select first checking account
		[+] if(iSelect==PASS)
			[ ] ReportStatus("Select Account", iSelect, "Account {lsTransactionData[10]} is selected") 
			[ ] 
			[ ] iValidate = FindTransaction(sWindowType, lsTransactionData[6])		// find transaction
			[+] if(iValidate == PASS)
				[ ] ReportStatus("Validate Transaction", iValidate, "Transaction with Input - {lsTransactionData[6]} is found") 
				[ ] 
				[ ] iEdit = 	EditCheckingTransaction(sWindowType, lsEditTransaction) 		// edit transaction
				[+] if (iEdit == PASS)
					[ ] ReportStatus("Edit Transaction", iEdit, "Transaction with Input - {lsTransactionData[6]} is editted successfully")
					[ ] 
					[ ] iValidate = OpenReport(lsReportCategory[1], sREPORT_TRANSACTION)				//OpenReport("Banking", "Transaction")
					[+] if(Transaction.Exists() == TRUE)
						[ ] Transaction.SetActive ()
						[ ] sHandle = Str(Transaction.QWListViewer1.ListBox1.GetHandle ())
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "15")		// Verify that editted transaction is reflected in report
						[ ] sOutFlow=str(val(lsEditTransaction[3]),NULL,2)
						[ ] sExpected = "@@TOTAL OUTFLOWS@-{sOutFlow}"
						[ ] Transaction.Close()
						[ ] bMatch = MatchStr("*{sExpected}*", sActual)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Validate Changes", PASS, "Changes are reflected in Transaction Report") 
							[ ] 
						[+] else
							[ ] ReportStatus("Validate Changes", FAIL, "Changes are not reflected in Transaction Report, Expected value - {sExpected}, Actual Value - {sActual}") 
							[ ] 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Transaction Window", FAIL, "Transaction window doesn't exists") 
						[ ] 
				[+] else
					[ ] ReportStatus("Edit Transaction", iEdit, "Transaction with Input - {lsTransactionData[6]} is not editted")
					[ ] 
				[ ] 
				[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, 1)	// select first checking account
				[+] if(iSelect==PASS)
					[ ] ReportStatus("Select Account", iSelect, "Account {lsTransactionData[10]} is selected") 
					[ ] 
					[ ] iDelete = DeleteTransaction(lsEditTransaction[1],lsEditTransaction[6])		// delete transaction
					[+] if (iDelete == PASS)
						[ ] ReportStatus("Delete Transaction", iDelete, "Transaction with Input - {lsEditTransaction[6]} is deleted successfully") 
						[ ] 
						[ ] iValidate = OpenReport(lsReportCategory[1], sREPORT_TRANSACTION)				//OpenReport("Banking", "Transaction")
						[+] if(Transaction.Exists() == TRUE)
							[ ] Transaction.SetActive ()
							[ ] sHandle = Str(Transaction.QWListViewer1.ListBox1.GetHandle ())
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "14")		// Check the report for deleted transaction
							[ ] sExpected = "@@TOTAL OUTFLOWS@0.00"
							[ ] Transaction.Close()
							[ ] bMatch = MatchStr("*{sExpected}*", sActual)
							[+] if(bMatch == TRUE)
								[ ] ReportStatus("Validate Changes", PASS, "Changes are reflected in {sREPORT_TRANSACTION} Report") 
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Changes", FAIL, "Changes are not reflected in Transaction Report, Expected value - {sExpected}, Actual Value - {sActual}") 
								[ ] 
						[+] else
							[ ] ReportStatus("Validate Transaction Window", FAIL, "Transaction window doesn't exists") 
							[ ] 
					[+] else
						[ ] ReportStatus("Delete Transaction", iDelete, "Transaction with Input - {lsEditTransaction[6]} is not deleted") 
						[ ] 
				[+] else
					[ ] ReportStatus("Select Account", iSelect, "Account {lsEditTransaction[10]} is not selected") 
					[ ] 
			[+] else
				[ ] ReportStatus("Validate Transaction", iValidate, "Transaction with Input - {lsTransactionData[6]} is not found") 
			[ ] 
		[+] else
			[ ] ReportStatus("Select Account", iSelect, "Account {lsTransactionData[10]} is NOT selected") 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############## Create New Saving Account #######################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test33_AddSavingAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will add Saving Account - Smoke Savings 
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if saving account is added without any errors						
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 05/01/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test33_AddSavingAccount () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount
		[ ] STRING sHandle,sActual
		[ ] BOOLEAN bMatch
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // Fetch 3rd row 
	[ ] lsAddAccount=lsExcelData[3]
	[ ] 
	[ ] // Quicken is launched then Add Checking Account
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] // Add Saving Account
		[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
		[ ] // Report Status if Saving Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Add Saving Account", iAddAccount, "Saving Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Saving Account", iAddAccount, "Saving Account -  {lsAddAccount[2]}  is not created")
			[ ] 
		[ ] 
		[ ] //  Verify that Account is shown on account bar
		[+] if(iAddAccount==PASS)
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"3")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsAddAccount[1]} Account", FAIL, "Verification has not been done as {lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
			[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
[ ] //############################################################################
[ ] 
[+] //############## Create New Asset Account #########################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test34_AddAssetAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will add Asset Account (House) - Smoke Asset
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if asset account is added without any errors						
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 05/01/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test34_AddAssetAccount () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount
		[ ] STRING sHandle,sActual
		[ ] BOOLEAN bMatch
	[ ] 
	[ ] // read excel table
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sOtherAccountSheet)
	[ ] // fetch 1st row
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[ ] // Quicken is launched then Add Checking Account
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] // Add Asset Account (House)
		[ ] iAddAccount = AddPropertyAccount(lsAddAccount[1],  lsAddAccount[2], lsAddAccount[3], lsAddAccount[4], lsAddAccount[5])
		[ ] // Report Status if Asset Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Add Asset Account", iAddAccount, "Asset Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Asset Account", iAddAccount, "Asset Account -  {lsAddAccount[2]}  is not created")
			[ ] 
		[ ] 
		[ ] //  Verify that Account is shown on account bar
		[+] if(iAddAccount==PASS)
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
				[ ] 
		[+] else
			[ ] ReportStatus("Verify {lsAddAccount[1]} Asset Account", FAIL, "Verification has not been done as {lsAddAccount[1]} Asset Account -  {lsAddAccount[2]} is not created")
			[ ] 
		[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############## Create New Other Liability Account ##################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test35_AddOtherLiabilityAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will add Other Liability account - Smoke Liability
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if other liability account is added without any errors						
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 05/01/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test35_AddOtherLiabilityAccount () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount
		[ ] STRING sHandle,sActual
		[ ] BOOLEAN bMatch
	[ ] 
	[ ] // read excel table
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sOtherAccountSheet)
	[ ] // fecth 2nd row 
	[ ] lsAddAccount=lsExcelData[2]
	[ ] 
	[ ] // Quicken is launched then Add Checking Account
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] // Add Other Liability Account 
		[ ] iAddAccount = AddOtherLiabilityAccount(lsAddAccount[1],  lsAddAccount[2], lsAddAccount[3],lsAddAccount[6])
		[ ] // Report Status if Other Liability Account is created
		[+] if (iAddAccount==PASS)
			[ ] ReportStatus("Add Asset Account", iAddAccount, "Asset Account -  {lsAddAccount[2]}  is created successfully")
			[ ] 
		[+] else
			[ ] ReportStatus("Add Asset Account", iAddAccount, "Asset Account -  {lsAddAccount[2]}  is not created")
			[ ] 
		[ ] 
		[ ] //  Verify that Account is shown on account bar
		[+] if(iAddAccount==PASS)
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer5.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"2")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
			[+] else
				[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
		[+] else
			[ ] ReportStatus("Verify Other Liability Account", FAIL, "Verification has not been done as Other Liability Account -  {lsAddAccount[2]} is not created")
			[ ] 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############## Create New Business Account ######################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test36_AddBusinessAccount()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will add two Business accounts - âSmoke Vendor Invoiceâ and âSmoke Customer Invoiceâ
		[ ] // 
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if Business account is added without any errors						
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 06/01/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test36_AddBusinessAccount () appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER  iAddAccount
		[ ] STRING sHandle,sActual
		[ ] BOOLEAN bMatch
	[ ] 
	[+] if(SKU_TOBE_TESTED != "Premier")
		[ ] // Read excel table
		[ ] lsExcelData = ReadExcelTable(sSmokeData, sOtherAccountSheet)
		[ ] // Fetch 3rd row
		[ ] lsAddAccount=lsExcelData[3]
		[ ] 
		[ ] // Quicken is launched then Add Business Account
		[+] if (QuickenMainWindow.Exists() == True)
			[ ] 
			[ ] // ***************Add Business Account (Accounts Payable)****************************************************
			[ ] iAddAccount = AddBusinessAccount(lsAddAccount[1], lsAddAccount[2])
			[ ] // Report Status if Business Account (Accounts Payable)  is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Add Business Account", iAddAccount, "Business Account -  {lsAddAccount[1]}  is created successfully")
				[ ] 
			[+] else
				[ ] ReportStatus("Add Business Account", iAddAccount, "Business Account -  {lsAddAccount[1]}  is not created")
				[ ] 
			[ ] 
			[ ] //  Verify that Business Account (Accounts Payable) is shown on account bar
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer2.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
				[ ] 
			[ ] 
			[ ] // fetch 4th row
			[ ] lsAddAccount=lsExcelData[4]
			[ ] 
			[ ] // ***************Add Business Account (Accounts Receivable)****************************************************
			[ ] iAddAccount = AddBusinessAccount(lsAddAccount[1], lsAddAccount[2])
			[ ] // Report Status if Business Account (Accounts Receivable)  is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("Add Business Account", iAddAccount, "Business Account -  {lsAddAccount[1]}  is created successfully")
				[ ] 
			[+] else
				[ ] ReportStatus("Add Business Account", iAddAccount, "Business Account -  {lsAddAccount[1]}  is not created")
				[ ] 
			[ ] 
			[ ] //  Verify that Business Account (Accounts Receivable) is shown on account bar
			[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer2.ListBox.GetHandle())
			[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
			[ ] bMatch = MatchStr("*{lsAddAccount[2]}*", sActual)
			[+] if(bMatch == TRUE)
				[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{lsAddAccount[2]} account is available in Account bar")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{lsAddAccount[2]} account is not available in Account bar")
				[ ] 
			[ ] 
		[ ] // Report Status if Quicken is not launched
		[+] else
			[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate testcase according to SKU", WARN, "This Testcase is not executed as this is not applicable for PREMIER SKU") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Create Reminder  ####################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test37_CreateReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will add reminder and validate it in home tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while creating reminder							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 10, 2011		Mamta Jain created	
	[ ] // ********************************************************
[+] testcase Test37A_CreateReminder () appstate SmokeBaseState
	[+] // Variable Declaration
		[ ] BOOLEAN bPayee, bAmount, bState
		[ ] STRING sHandle, sActual, sWindowName
		[ ] INTEGER iAdd, iNavigate, i, iCount, j
	[ ] 
	[ ] // Read excel table
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sReminderSheet)
	[ ] iCount = ListCount (lsExcelData) 		// get row count
	[ ] 
	[-] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive ()
		[ ] 
		[-] for(i = 1; i<=iCount; i++)
			[ ] lsReminderData = lsExcelData[i]				// get contents from i th row
			[ ] iNavigate = NavigateQuickenTab(sTAB_BILL)		// Navigate to Bills Tab
			[-] if (iNavigate == PASS)
					[ ] 
					[ ] iAdd = AddIncomeTransferReminder(lsReminderData)
					[+] if (iAdd == PASS)
						[ ] ReportStatus("Create {lsReminderData[1]} ", iAdd, "{lsReminderData[1]} with Payee Name {lsReminderData[2]} and amount {lsReminderData[7]} created")
						[ ] 
						[+] if(AddReminder.Exists(SHORT_SLEEP))
							[ ] AddReminder.SetActive()
							[ ] AddReminder.Cancel.Click()
							[ ] 
						[ ] 
						[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)	// Navigate to Home tab
						[ ] Home.SetActive()
						[ ] sHandle= Str(Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.BILLANDINCOMEREMINDERSNE.QWListViewer.ListBox.GetHandle ())
						[ ] 
						[+] for(j= 1; j<=5; j++)
							[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(j))
							[ ] bPayee = MatchStr("*{lsReminderData[2]}*", sActual)
							[ ] bAmount = MatchStr("*{Str(Val(lsReminderData[7]), NULL, 2)}*", sActual)
							[+] if (bPayee == TRUE && bAmount == TRUE)
								[ ] ReportStatus("Validate Payee name and Amount ", PASS, "Bill is displayed on Home Tab with Payee - {lsReminderData[2]} and Amount - {Str(Val(lsReminderData[7]), NULL, 2)}")
								[ ] break
							[+] else
								[+] if(j==5)
									[ ] ReportStatus("Validate Payee name and Amount ", FAIL, "Expected Value - {lsReminderData[2]} of Payee and Expected Value - {lsReminderData[7]} of Amount, Actual Value -  {sActual}")
									[ ] 
								[+] else
									[ ] continue
					[+] else
						[ ] ReportStatus("Create Income Reminder ", iAdd, "Income Reminder is not created")
						[ ] 
					[ ] 
			[+] else
				[ ] ReportStatus("Validate Bills tab state", iNavigate, "Bills tab is not active") 
				[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Create Income and Transfer Reminder  ###################################
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test37_CreateReminder()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will create Income and Transfer Reminder and validate it in Home tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while creating Income and Transfer reminder							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Feb 02, 2011		Mamta Jain created	
	[ ] // ********************************************************
[-] testcase Test37B_CreatePayCheckReminder() appstate SmokeBaseState
	[+] // Variable Declaration
		[ ] BOOLEAN bCompany, bAmount, bState, bExists, bFlag
		[ ] STRING sHandle, sActual,sAmount
		[ ] INTEGER iAdd, iNavigate, i
	[ ] 
	[ ] // Variable Defination
	[ ] bFlag = FALSE
	[ ] 
	[ ] // Read excel table
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sPaycheckSheet)
	[ ] // fetch 1st row
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[-] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive ()
		[ ] 
		[ ] iNavigate = NavigateQuickenTab(sTAB_BILL)			// Select Bills tab
		[-] if (iNavigate == PASS)
			[ ] 
			[ ] QuickenMainWindow.Bills.AddReminder.PaycheckReminder.Pick()
			[ ] 
			[-] if(PayCheckSetup.Exists() == TRUE)
				[ ] PayCheckSetup.SetActive ()
				[ ] PayCheckSetup.HowMuchPaycheck.Select("Gross Amount")
				[ ] PayCheckSetup.Next.Click ()
				[ ] PayCheckSetup.CompanyName.SetPosition (1, 1)
				[ ] PayCheckSetup.CompanyName.SetText (lsAddAccount[1])
				[ ] PayCheckSetup.MemoOptional.SetPosition (1, 1)
				[ ] PayCheckSetup.MemoOptional.SetText (lsAddAccount[2])
				[ ] PayCheckSetup.Next.Click ()
				[ ] bExists = PayCheckError.Exists()
				[+] if(bExists == TRUE)						// check for error message
					[ ] PayCheckError.OK.Click()
					[ ] PayCheckSetup.Close()
					[ ] bFlag = TRUE							// set flag to True - states that error message exists
				[-] else
					[ ] PayCheckSetup.SetActive ()
					[ ] PayCheckSetup.Account.Select (lsAddAccount[3])
					[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, FALSE)
					[ ] PayCheckSetup.QWSnapHolder.AcceptClearenceTransaction.TransactionFrame.AddEarning.Click()
					[ ] PayCheckSetup.QWSnapHolder.AcceptClearenceTransaction.TransactionFrame.AddEarning.TypeKeys(Replicate(KEY_DN, 1)) 
					[ ] PayCheckSetup.QWSnapHolder.AcceptClearenceTransaction.TransactionFrame.AddEarning.TypeKeys(KEY_ENTER)
					[+] if(InvestingTransactionPopup.Exists())
						[ ] InvestingTransactionPopup.SetActive ()
						[ ] ReminderDetails.Memo.SetText (lsAddAccount[4])
						[ ] DialogBox1.OK1.Click (1, 40, 8)
						[ ] 
					[+] else
						[ ] ReminderDetails.Memo.SetText (lsAddAccount[4])
						[ ] DialogBox1.OK1.Click (1, 40, 8)
						[ ] 
					[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, TRUE)
					[ ] PayCheckSetup.StartOn.SetText(lsAddAccount[5])
					[ ] PayCheckSetup.Frequency.Select (lsAddAccount[6])
					[ ] PayCheckSetup.Done.Click ()
					[+] if(EnterYearToDateInformation.Exists())
						[ ] EnterYearToDateInformation.OK.Click()
						[+] if(PaycheckYearToDateAmounts.Exists())
							[ ] PaycheckYearToDateAmounts.Enter.Click()
			[+] else
				[ ] ReportStatus("Validate PayCheck Window", FAIL, "PayCheck window doesn't exists") 
				[ ] 
			[ ] 
			[+] if(bFlag == FALSE)					// if flag is false then continue creating Paycheck reminder
				[ ] iNavigate = NavigateQuickenTab(sTAB_HOME)		// Select Home tab
				[ ] Home.SetActive()
				[ ] 
				[ ] sHandle= Str(Home.QWStayOnTopOfMonthlyBills.StaticTextSMB.Panel.BILLANDINCOMEREMINDERSNE.QWListViewer.ListBox.GetHandle ())
				[ ] 
				[+] for(i = 1; i<=5; i++)
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
					[ ] bCompany = MatchStr("*{lsAddAccount[1]}*", sActual)
					[ ] sAmount=str(val(lsAddAccount[4]),NULL,2)
					[ ] bAmount = MatchStr("*{sAmount}*", sActual)
					[+] if (bCompany == TRUE && bAmount == TRUE)
						[ ] ReportStatus("Validate Company name and Amount ", PASS, "Paycheck is displayed on Home Tab with Company - {lsAddAccount[1]} and Amount - {sAmount}")
						[ ] break
					[+] else
						[+] if(i == 5)
							[ ] ReportStatus("Validate Company name and Amount ", FAIL, "Expected Company - {lsAddAccount[1]} and Amount - {sAmount}, Actual Value - {sActual}")
							[ ] 
						[+] else
							[ ] continue
						[ ] 
			[+] else
				[ ] ReportStatus("Validate Company", FAIL, "Company Name - {lsAddAccount[1]} already exists") 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Bills tab state", iNavigate, "Bills tab is not selected") 
			[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# Check shutdown ##################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test38_ValidateQuickenShutdown()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will close Quicken Main Window
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs closing							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 4, 2011		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test38_ValidateQuickenShutdown() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER iValidate
	[ ] 
	[ ] iValidate = CloseQuicken()
	[ ] ReportStatus("Validate Quicken Main Window", iValidate, "Quicken Main Window Close") 
	[ ] 
[ ] //##############################################################################
[ ] 
[+] //#############  Re-launch Quicken and Verify File Attributes #############################
	[ ] // ********************************************************
	[+] // TestCase Name:	 	Test39_ReLaunchQuicken()
		[ ] //
		[ ] // Description: 				
		[ ] // This testcase will Launch Quicken and Verify File Attributesn.
		[ ] // 
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // Returns:			      	Pass 	if verification is done successfully 							
		[ ] //						Fail	if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:	
		[ ] //	Jan 10, 2011  		Mamta Jain created	  
	[ ] // ********************************************************
[+] testcase Test39_ReLaunchQuicken() appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] LIST OF STRING lsActualFileAttribute, lsExpectedFileAttribute, lsFileAttributes
		[ ] STRING sActualAboutQuicken,sExpectedAttribute
		[ ] INTEGER i,iPos
	[+] // Expected values of Quicken File Attributes
		[ ] lsFileAttributes = {"Accounts", "Categories", "Memorized Payee", "Securities", "Transactions" }
	[ ] 
	[ ] // Read excel table
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sQuickenAttributesWorksheet)
	[ ] // fetch 1st row
	[ ] lsQuickenAttributes = lsExcelData[3]
	[ ] 
	[+] if (QuickenMainWindow.Exists() == True)
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)		// Get all File Attributes of Quicken
		[ ] 
		[ ] // Verification of Actual File Attributes
		[+] for (i=1;i<=ListCount(lsActualFileAttribute);i++)
			[ ] sExpectedAttribute=str(Val(lsQuickenAttributes[i]))
			[+] if(sExpectedAttribute == lsActualFileAttribute[i])
				[ ] ReportStatus("Validate {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is matching with Actual {lsActualFileAttribute[i]}") 
			[+] else
				[ ] ReportStatus("Validate {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {sExpectedAttribute} is not matching with Actual {lsActualFileAttribute[i]}")
				[ ] 
				[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //#############################################################################
[ ] 
[+] //############## Validate Data File  ##############################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test40_ValidateDataFile()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will perform validate data file operation using âValidate and Repairâ menu item under File menu 
		[ ] //  And verifies that âDATA_LOG.txtâ  file is created in log folder
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if file operation âValidate and Repairâ successful 			
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 06/01/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test40_ValidateDataFile () appstate SmokeBaseState
	[ ] 
	[+] // Variable declaration
		[ ] BOOLEAN bNotepad,bExists,bMatch
		[ ] STRING sDataLogPath,sExpectedOutputFile,sActualOutputFile,sNoError
		[ ] HFILE hFile
		[ ] STRING sLine
		[ ] 
	[+] // Expected Values
		[ ] //sExpectedOutputFile = "DATA_LOG.TXT - Notepad"
		[ ] sExpectedOutputFile = "DATA_LOG"
		[ ] sDataLogPath = USERPROFILE + "\Application Data\Intuit\Quicken\Log\DATA_LOG.TXT"
		[ ] sNoError="No errors."
	[ ] 
	[ ] // Quicken is launched then validate data log
	[+] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] // Navigate to File > File Operations > Validate and Repair
		[ ] QuickenMainWindow.File.FileOperations.ValidateAndRepair.Pick()
		[ ] 
		[ ] // Verify that "Validate and repair your Quicken file" window exists
		[+] if(ValidateAndRepair.Exists(5))
			[ ] 
			[ ] ValidateAndRepair.SetActive()
			[+] if(ValidateAndRepair.OK.IsEnabled())
				[ ] ValidateAndRepair.OK.Click()
				[ ] 
			[+] else
				[+] if(!ValidateAndRepair.ValidateFile.IsChecked())
					[ ] ValidateAndRepair.ValidateFile.Check()
				[+] if(!ValidateAndRepair.RebuildInvestingLots.IsChecked())
					[ ] ValidateAndRepair.RebuildInvestingLots.Check()
				[ ] ValidateAndRepair.OK.Click()
			[ ] 
			[ ] sleep(25)
			[ ] Notepad.VerifyEnabled(TRUE, 20)
			[ ] 
			[ ] // Verify that output file (data log text file) is opened
			[+] if(Notepad.Exists(SHORT_SLEEP))
				[ ] 
				[ ] Notepad.SetActive()
				[ ] // Verify window title for output file
				[ ] sActualOutputFile=Notepad.GetCaption()
				[ ] bMatch = MatchStr("*{sExpectedOutputFile}*",sActualOutputFile)
				[+] if (bMatch == TRUE)
					[ ] ReportStatus("Validate Output File", PASS, "Output file {sExpectedOutputFile} is created")
				[+] else
					[ ]  ReportStatus("Validate Output File", FAIL, "Output file {sExpectedOutputFile} is not matching with {sActualOutputFile}")
				[ ] // Close Notepad
				[ ] Notepad.SetActive()
				[ ] Notepad.Exit()
				[ ] 
				[ ] // Read File
				[ ] hFile = FileOpen (sDataLogPath, FM_READ) 
				[+] while (FileReadLine (hFile, sLine))
					[ ] bMatch = MatchStr("*{sNoError}*", sLine)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Data log", PASS, "{sNoError} message is displayed in {sExpectedOutputFile} file")
						[ ] break
					[+] else
						[ ] continue
					[ ] 
				[+] if(bMatch==FALSE)
					[ ] ReportStatus("Validate Data log", FAIL, "{sNoError} message is not displayed in {sExpectedOutputFile} file")
					[ ] 
				[ ] FileClose (hFile)
				[ ] 
				[ ] 
				[ ] // Verify the path of output file i.e. Notepad
				[ ] bNotepad= SYS_FileExists(sDataLogPath)
				[ ] bExists =  AssertTrue(bNotepad)
				[+] if (bExists == TRUE)
					[ ] ReportStatus("Validate Output File", PASS, "Output file {sExpectedOutputFile} is found at {sDataLogPath}") 
				[+] else
					[ ] ReportStatus("Validate Output File", FAIL, "Output file {sExpectedOutputFile} is not found at {sDataLogPath}") 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Data Log Notepad", FAIL, "Notepad is not opened") 
		[+] else
			[ ] ReportStatus("Validate ValidateAndRepair Window", FAIL, "ValidateAndRepair window is not found") 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## Confirm account changes on Account List  ##################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test41_ValidateAccountChanges()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will edit/delete account and validate changes are reflected in Account List
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while edit/delete and verification 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 11, 2011		Mamta Jain created	
	[ ] // ********************************************************
[-] testcase Test41_ValidateAccountChanges() appstate SmokeBaseState
	[ ] 
	[-] // Variable Declaration
		[ ] BOOLEAN bExist, bMatch
		[ ] STRING sHandle, sActual, sWindowType, sExpected, sEditAccount
		[ ] INTEGER iSelect, iAction, iNavigate, i
	[+] // Variable Defination
		[ ] sEditAccount = "Checking 01 Edit"
	[ ] 
	[ ] // read excel table
	[ ] lsExcelData = ReadExcelTable(sSmokeData, sAccountWorksheet)
	[ ] // fetch 1st row
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[-] if(QuickenMainWindow.Exists())
		[ ] QuickenMainWindow.SetActive ()
		[ ] 
		[+] if(QuickenMainWindow.View.UsePopUpRegisters.IsChecked() == TRUE)
			[ ] sWindowType = sPopUpWindow
		[+] else
			[ ] sWindowType = sMDIWindow
		[ ] 
		[ ] // Edit Checking Account and verify in Account List
		[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, 1)			// Select first checking account
		[-] if (iSelect == PASS)
			[ ] iAction = ModifyAccount(sWindowType, sEditAccount, "Edit")	// Edit account name
			[+] if(iAction == PASS)
				[ ] ReportStatus("Validate Account Action", iAction, "{lsAddAccount[2]} Account editted successfully")
				[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Validate Account Action", iAction, "{lsAddAccount[2]} Account is not editted")
				[ ] 
			[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)
			[+] if(iNavigate == PASS)
				[ ] bExist = AccountList.Exists()
				[+] if(bExist== TRUE)
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())
					[+] for(i = 1; i<=5; i++)			// check existence of account name
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
						[ ] bMatch = MatchStr("*{sEditAccount}*", sActual)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Validate Account Name", PASS, "{lsAddAccount[2]} account is editted to {sEditAccount}") 
							[ ] break
						[+] else
							[+] if(i == 5)
								[ ] ReportStatus("Validate Account Name", FAIL, "Expected Value - {sEditAccount}, Actual Value - {sActual}") 
								[ ] 
							[+] else
								[ ] continue
							[ ] 
					[ ] 
					[ ] AccountList.Maximize()
					[ ] AccountList.Close ()
				[ ] 
				[+] else
					[ ] ReportStatus("Validate Account List Window", FAIL, "Account List Window is not available")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Selection", iNavigate, "Account List is not selected")
				[ ] 
		[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "First Banking Account is not selected from Account bar")
			[ ] 
		[ ] 
		[ ] // Delete Savings Account and verify in Account List
		[ ] 
		[ ] // fetch 3rd row
		[ ] lsAddAccount=lsExcelData[3]
		[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, 3)			// Select Saving account
		[-] if (iSelect == PASS)
			[ ] iAction = ModifyAccount(sWindowType, lsAddAccount[2], "Delete")		// Delete Smoke Savings account
			[+] if(iAction == PASS)
				[ ] ReportStatus("Validate Account Action", iAction, "{lsAddAccount[2]} Account deleted successfully")
				[ ] 
			[ ] 
			[+] else
				[ ] ReportStatus("Validate Account Action", iAction, "{lsAddAccount[2]} Account is not deleted")
				[ ] 
			[ ] 
			[ ] iNavigate = NavigateQuickenTools(TOOLS_ACCOUNT_LIST)		// Open Account List for verification
			[+] if(iNavigate == PASS)
				[ ] bExist = AccountList.Exists()
				[+] if(bExist== TRUE)
					[ ] sHandle = Str(AccountList.QWinChild.Order.ListBox.GetHandle ())			// get handle of list box
					[ ] 
					[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "8")
					[ ] bMatch = MatchStr("*{lsAddAccount[2]}*",  sActual)					// check that savings account is not present
					[+] if(bMatch == FALSE)
						[ ] ReportStatus("Validate Account Deletion", PASS, "Changes are reflected in Account List, {lsAddAccount[2]} account is not present") 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Account Deletion", FAIL, "Expected Value - {lsAddAccount[2]}, Actual Value - {sActual}, {lsAddAccount[2]} account is not deleted") 
						[ ] 
					[ ] 
				[+] else
					[ ] ReportStatus("Validate Account List Window", FAIL, "Account List Window is not available")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate Selection", iNavigate, "Account List is not selected")
				[ ] 
			[ ] AccountList.Maximize()
			[ ] AccountList.Close ()
		[ ] 
		[+] else
			[ ] ReportStatus("Validate Account selection", iSelect, "Account List is not selected")
			[ ] 
		[ ] 
	[+] else
		[ ] ReportStatus("Validate Quicken Main Window", FAIL, "Quicken Main Window is not available")
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# CrerateOnlineAccount #############################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test42_CrerateOnlineAccount()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will create Online account for Mission Federal Credit Union. This will create a new data file and add Checking and Saving account for MFCU 
		[ ] // Using Localfile Testing mechansim.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while creating online account for MFCU 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 28, 2010		Chandan Abhyankar	created
		[ ] //       Oct  21, 2011       Udita Dube             updated (made it supported for Premier SKU))	
	[ ] //*********************************************************
[+] testcase Test42_CrerateOnlineAccount () appstate QuickenBaseState
	[ ] 
	[ ] STRING hWnd, sActualOutput
	[ ] BOOLEAN bMatchStatus
	[ ] INTEGER iCreateDataFile, iLocalFileSetup, iIntuonlConfigure, iResponseStatus,iAddAccount
	[ ] STRING sOnlieAccountFileName = "Online"
	[ ] STRING sOnlieAccountFilePath = AUT_DATAFILE_PATH + "\" + sOnlieAccountFileName + ".QDF"
	[ ] 
	[ ] // Respose files for Local File Testing
	[ ] STRING sBrandingResponse = AUT_DATAFILE_PATH + "\Response_Files\1_brand_resp.dat"
	[ ] STRING sProfileResponse = AUT_DATAFILE_PATH + "\Response_Files\2_prof_resp.dat"
	[ ] STRING sAccountInfoResponse = AUT_DATAFILE_PATH + "\Response_Files\3_acct_info.dat"
	[ ] STRING sPaymentSyncResponse = AUT_DATAFILE_PATH + "\Response_Files\4_payment_sync.dat"
	[ ] STRING sStatementResponse = AUT_DATAFILE_PATH + "\Response_Files\5_stmt_resp.dat"
	[ ] 
	[-] // Pre-Requisite
		[ ] // Close Quicken
		[-] if (QuickenMainWindow.Exists() == TRUE)
			[ ] QuickenMainWindow.Exit()
		[ ] sleep(10)
		[ ] DeleteFile(sOnlieAccountFilePath)
		[ ] 
		[ ] // Setup LocalFile Testing mechanism
		[ ] iLocalFileSetup = SetUpLocalFile()
		[ ] ReportStatus("LocalFile Setup", iLocalFileSetup, "LocalFile Testing Setup is performed") 
		[ ] 
		[ ] // // Configure Intu_onl.ini file
		[ ] // iIntuonlConfigure = ConfigureIntuonl("1", "0", "0", "0", "0", "0")
		[ ] // ReportStatus("Configure Intu_onl.ini", iIntuonlConfigure, "Configuration of Intu_onl.ini is performed")
		[ ] 
		[ ] // Lauch Quicken
		[+] if (!QuickenMainWindow.Exists ())
			[ ] QuickenMainWindow.Start ("{QUICKEN_ROOT}" + "\qw.exe")
			[ ] 
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 120)
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] // Create a new data file for Online account
		[-] if (QuickenMainWindow.Exists() == True)
			[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
			[ ] iCreateDataFile = DataFileCreate(sOnlieAccountFileName)
			[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sOnlieAccountFileName} is created")
			[ ] 
			[+] if(ProductRegistration.Exists())
				[ ] ProductRegistration.Close()
			[ ] 
			[+] if(SKU_TOBE_TESTED == "Premier" || SKU_TOBE_TESTED == "Deluxe" || SKU_TOBE_TESTED == "QNUE")
				[ ] // Read data from excel sheet
				[ ] lsExcelData = ReadExcelTable(sSmokeData, sAccountWorksheet)
				[ ] // Fetch 3rd row 
				[ ] lsAddAccount=lsExcelData[3]
				[ ] 
				[ ] // Add Saving Account
				[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4])
				[ ] // Report Status if Saving Account is created
				[+] if (iAddAccount==PASS)
					[ ] ReportStatus("Add Saving Account", iAddAccount, "Saving Account -  {lsAddAccount[2]}  is created successfully")
					[ ] 
				[+] else
					[ ] ReportStatus("Add Saving Account", iAddAccount, "Saving Account -  {lsAddAccount[2]}  is not created")
					[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
			[ ] 
	[ ] 
	[ ] 
	[ ] // Add Online Account
	[ ] ExpandAccountBar()
	[ ] 
	[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.Click()
	[ ] AddAccount.CustomWin("Checking").Click()
	[ ] 
	[ ] AddCheckingAccount.VerifyEnabled(TRUE, 500)
	[ ] AddCheckingAccount.SetActive()
	[ ] AddCheckingAccount.EnterTheNameOfYourBank.SetText("Mission Federal Credit Unioin")
	[ ] AddCheckingAccount.Next.Click()
	[ ] 
	[ ] // Provide different DAT files for Local file responses
	[-] if (FakeResponse.Exists(15) == TRUE)
		[ ] 
		[ ] iResponseStatus = EnterFakeResponseFile(sBrandingResponse)
		[ ] ReportStatus("Branding Response", iResponseStatus, "Fake Response - {sBrandingResponse} is entered")
		[ ] 
	[+] else
		[ ] ReportStatus("Fake Respose Window", WARN, "Branding Response is not asked") 
		[ ] 
	[-] if (AddCheckingAccount.Exists(15) == TRUE)
		[ ] AddCheckingAccount.SetActive()
		[ ] AddCheckingAccount.TextField("MFCU Member Number|$1231").SetText(sMFCUAccountId)
		[ ] AddCheckingAccount.TextField("MFCU Password|$1233").SetText("12345")			// Any random passord is OK
		[ ] AddCheckingAccount.Next.Click()
		[ ] 
		[-] if (FakeResponse.Exists(15) == TRUE)
			[ ] iResponseStatus = EnterFakeResponseFile(sProfileResponse)
			[ ] ReportStatus("Profile Response", iResponseStatus, "Fake Response - {sProfileResponse} is entered")
			[ ] 
			[ ] iResponseStatus = EnterFakeResponseFile(sAccountInfoResponse)
			[ ] ReportStatus("Account Info Response", iResponseStatus, "Fake Response - {sAccountInfoResponse} is entered")
			[ ] 
			[+] if (AddCheckingAccount.Exists(15) == TRUE)
				[ ] AddCheckingAccount.SetActive()
				[ ] AddCheckingAccount.Next.Click()
				[ ] 
				[+] if (FakeResponse.Exists(15) == TRUE)
					[ ] iResponseStatus = EnterFakeResponseFile(sPaymentSyncResponse)
					[ ] ReportStatus("Payment Sync Response", iResponseStatus, "Fake Response - {sPaymentSyncResponse} is entered")
					[ ] 
					[ ] iResponseStatus = EnterFakeResponseFile(sStatementResponse)
					[ ] ReportStatus("Statement Response", iResponseStatus, "Fake Response - {sStatementResponse} is entered")
					[ ] 
					[+] if (BankingPopUp.FileDlg("Quicken Update Status").FileDlg("Local Web Request").Exists() == TRUE)
						[ ] BankingPopUp.FileDlg("Quicken Update Status").FileDlg("Local Web Request").VerifyEnabled(TRUE, 120)
						[ ] BankingPopUp.FileDlg("Quicken Update Status").FileDlg("Local Web Request").SetActive()
						[ ] BankingPopUp.FileDlg("Quicken Update Status").FileDlg("Local Web Request").Click(1, 380,540)
						[ ] //QuickenMainWindow.FileDlg("Quicken Update Status").FileDlg("Local Web Request").FailRequest.Click()
						[ ] 
						[ ] // Complete the process by clicking on Finish button
						[ ] QuickenMainWindow.FileDlg("Accounts Added").VerifyEnabled(TRUE, 150)
						[ ] QuickenMainWindow.FileDlg("Accounts Added").Close()
						[ ] 
					[+] else
						[ ] ReportStatus("ACE Request", FAIL, "ACE Request window is not available") 
						[ ] 
				[+] else
					[ ] ReportStatus("Fake Respose Window", FAIL, "Fake Respose window is not available") 
					[ ] 
			[+] else
				[ ] ReportStatus("Checking Account Window", FAIL, "Checking Account window is not available") 
			[ ] 
		[+] else
			[ ] ReportStatus("Fake Respose Window", FAIL, "Fake Respose window is not available") 
			[ ] 
	[+] else
		[ ] ReportStatus("Checking Account Window", FAIL, "Checking Account window is not available") 
		[ ] 
	[ ] 
	[ ] // Verify Accounts are displayed on Account Bar
	[ ] QuickenMainWindow.SetActive()
	[ ] hWnd = str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
	[ ] 
	[ ] // Verify Checking account on AccountBar
	[ ] sActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "0")
	[ ] bMatchStatus = MatchStr("*{sCheckingAccount}*", sActualOutput)
	[+] if (bMatchStatus == TRUE)
		[ ] ReportStatus("Validate Checking Account", PASS, "Checking Account -  {sCheckingAccount} is present in Account Bar") 
	[+] else
		[ ] ReportStatus("Validate Checking Account", FAIL, "Actual -  {sActualOutput} is not matching with Expected - {sCheckingAccount}") 
		[ ] 
	[ ] // Verify Savings account on AccountBar
	[ ] sActualOutput = QwAutoExecuteCommand("LISTBOX_GETFULLROW", hWnd,  "2")
	[ ] bMatchStatus = MatchStr("*{sSavingsAccount}*", sActualOutput)
	[+] if (bMatchStatus == TRUE)
		[ ] ReportStatus("Validate Savings Account", PASS, "Savings Account -  {sSavingsAccount} is present in Account Bar") 
	[+] else
		[ ] ReportStatus("Validate Checking Account", FAIL, "Actual -  {sActualOutput} is not matching with Expected - {sSavingsAccount}") 
		[ ] 
		[ ] // 
	[+] // Cleanup
		[ ] // Close Quicken
		[ ] QuickenMainWindow.Exit()
		[ ] 
		[ ] // Delete qa_acc32.dll
		[ ] DeleteFile(sAccDllDestinationPath)
		[ ] 
		[ ] DeleteFile(sDestinationonliniFile)
		[ ] 
		[ ] // Delete file intu_onl.ini located in WIndows directory
		[ ] // DeleteFile(SYS_GetEnv("WINDIR") + "\\intu_onl.ini")
		[ ] 
[ ] //############################################################################
[ ] 
[+] //############# C2R Functionality (Banking) ########################################
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test43_C2RFunctionalityBanking()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will disable âAutomatically add downloaded transactions to Registersâ checkbox in Quicken Preferences.
		[ ] // Import Banking web connect file and Confirm that transactions are displayed in C2R UI and after accepting all,
		[ ] // transactions are diplayed in register.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 21, 2011	      Mamta Jain 	Created	
	[ ] //*********************************************************
[+]  testcase Test43A_C2RFunctionalityBanking() appstate SmokeBaseState 
	[-] // Variable declaration
		[ ] INTEGER iCreateDataFile,iAccount, i
		[ ] BOOLEAN bMatch,bFlag
		[ ] STRING sOnlineTransactionDataFile, sFilePath,sFileName,sAccount,sAccountName,sHandle,sActual,sEndingBalance,sIndex1,sIndex2, sCaption, sEndingBalance1, sExpected
	[ ] 
	[-] // Expected Values
		[ ] sFileName = "WellsFargo_Checking.qfx"
		[ ] sFilePath = AUT_DATAFILE_PATH + "\WebConnect_Files\" + sFileName
		[ ] sOnlineTransactionDataFile= "OnlineTransactionFile"
		[ ] sAccountName="Checking at Wells Fargo"
		[ ] sEndingBalance="20"
		[ ] sEndingBalance1= "130"
		[ ] sIndex1="#12"
		[ ] sIndex2= "#14"
		[ ] bFlag = FALSE
	[ ] 
	[-] // Pre-requisite
		[ ] // Delete qa_acc32.dll
		[-] if(FileExists (sAccDllDestinationPath))
			[ ] DeleteFile(sAccDllDestinationPath)
		[ ] // Delete file intu_onl.ini located in WIndows directory
		[-] if(FileExists (sDestinationonliniFile))
			[ ] DeleteFile(sDestinationonliniFile)
		[ ] 
		[ ] // // Delete file intu_onl.ini located in WIndows directory
		[-] // if(FileExists (SYS_GetEnv("WINDIR") + "\\intu_onl.ini"))
			[ ] // DeleteFile(SYS_GetEnv("WINDIR") + "\\intu_onl.ini")
		[ ] 
		[-] if(FileExists(AUT_DATAFILE_PATH + "\" + "{sOnlineTransactionDataFile}.QDF"))
			[ ] DeleteFile(AUT_DATAFILE_PATH + "\" +  "{sOnlineTransactionDataFile}.QDF")
	[ ] 
	[ ] //Create a new data file for Online transaction download
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] iCreateDataFile = DataFileCreate(sOnlineTransactionDataFile)
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sOnlineTransactionDataFile} is created")
		[ ] 
		[-] if(ProductRegistration.Exists())
			[ ] ProductRegistration.Close()
		[ ] // 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] // Check if Quicken is launched
	[-] if (QuickenMainWindow.Exists())
		[ ] // Navigate to Edit > Preferences
		[ ] QuickenMainWindow.Edit.Preferences.Pick()
		[ ] 
		[+] if(Preferences.Exists(2))
			[ ] 
			[ ] sHandle = Str(Preferences.SelectPreferenceType.ListBox.GetHandle())
			[ ] sExpected = "Downloaded Transactions"
			[ ] // find the Dowloaded Transaction option in Prefernces window
			[+] for( i = 10; i<=15; i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
				[ ] bMatch = MatchStr("*{sExpected}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] bFlag=TRUE
					[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(i))		// Select Download Transactions option
					[ ] break
				[+] else
					[ ] bFlag = FALSE
					[+] if(i==15)
						[ ] ReportStatus("Validate Download Transaction option'", FAIL, "Download Transaction option is not available") 
					[+] else
						[ ] continue
					[ ] 
			[ ] 
			[ ] // Check the avalability of the checkbox
			[+] if(bFlag== TRUE)
				[+] if(Preferences.AutomaticallyAddDownloadedT.Exists(5))
					[ ] // Check the checkbox if it is unchecked
					[+] if(Preferences.AutomaticallyAddDownloadedT.IsChecked())
						[ ] Preferences.AutomaticallyAddDownloadedT.Uncheck()
						[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Checkbox is unchecked") 
						[ ] 
					[+] else
						[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Checkbox is already unchecked") 
						[ ] 
					[ ] Preferences.OK.Click()
				[+] else
					[ ] ReportStatus("Validate checkbox for Automatic Transaction entry'", FAIL, "Checkbox is not available") 
					[ ] 
			[+] else
				[ ] Preferences.Close()
			[ ] 
		[+] else
			[ ] bFlag = FALSE
		[ ] 
		[-] if( bFlag == TRUE)
			[ ] // Navigate to File > File Import > Web Connect File
			[ ] QuickenMainWindow.File.FileImport.WebConnectFile.Pick()
			[ ] 
			[ ] // Import web connect file
			[-] if(CreateQuickenFile.Exists(SHORT_SLEEP))
				[ ] CreateQuickenFile.SetActive()
				[ ] CreateQuickenFile.FileName.SetText(sFilePath)
				[ ] CreateQuickenFile.OK.Click()
			[+] else
				[ ] ReportStatus("Validate 'Import Web Connect File' Window", FAIL, "'Import Web Connect File' Window is not available") 
				[ ] 
			[ ] 
			[ ] // Messages are displayed then close all dialog boxes
			[-] if (FakeResponse.Exists(MEDIUM_SLEEP))
				[ ] FakeResponse.Close()
				[ ] LogError("Pre-requisite is failed for Automatic Download Transaction")
			[-] if(MessageBox.OK.Exists())
				[ ] MessageBox.OK.Click()
			[-] if(MessageForWindows.OK.Exists())
				[ ] MessageForWindows.OK.Click()
			[-] if(MessageBox.OK.Exists())
				[ ] MessageBox.OK.Click()
			[-] if(MessageForWindows.OK.Exists())
				[ ] MessageForWindows.OK.Click()
			[-] if(OneStepUpdateSummary.Close.Exists())
				[ ] OneStepUpdateSummary.Close.Click()
				[ ] 
			[ ] // 
			[-] if(ImportDownloadedTransactions.Exists(120))
				[ ] ImportDownloadedTransactions.SetActive()
				[ ] // Check if default Account name is not displayed, enter account name in text field
				[ ] sAccount=ImportDownloadedTransactions.Panel2.TextField.GetText()
				[-] if(sAccount=="")
					[ ] ImportDownloadedTransactions.Panel2.TextField.SetText(sAccountName)
				[ ] // Click on Import
				[ ] ImportDownloadedTransactions.Import.Click()
				[ ] 
				[+] if(OneStepUpdateSummary.Exists(20))
					[ ] OneStepUpdateSummary.SetActive()
					[ ] OneStepUpdateSummary.Close()
				[+] if(FreeUpdateToQuicken.Exists(2))
					[ ] FreeUpdateToQuicken.SetActive()
					[ ] FreeUpdateToQuicken.UpdateLater.Click()
				[ ] 
				[ ] //  Verify that Account is shown on account bar
				[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
				[ ] bMatch = MatchStr("*{sAccountName}*{sEndingBalance}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{sAccountName} account is available with ending balance - {sEndingBalance}")
					[ ] 
				[-] else
					[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{sActual} account is not available in Account bar")
					[ ] 
				[ ] 
				[-] if(CheckingAtWellsFargo.StaticText1.C2RHeader.DownloadedTransactions.Exists ())
					[ ] sCaption = CheckingAtWellsFargo.StaticText1.C2RHeader.DownloadedTransactions.GetCaption ()
					[ ] sExpected = "5"
					[ ] bMatch = MatchStr("*{sExpected}*", sCaption)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate No. of Transactions", PASS, "No. of Transactions = {sExpected}")
						[ ] 
					[ ] 
					[+] else
						[ ] ReportStatus("Validate No. of Transactions", FAIL, "Expected no. of Transaction - {sExpected}, Actual no. of Transaction - {sCaption}")
						[ ] 
					[ ] 
					[ ] CheckingAtWellsFargo.SetActive ()
					[ ] CheckingAtWellsFargo.QWSnapHolder1.StaticText1.StaticText2.AcceptAll.Click ()
					[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
					[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
					[ ] bMatch = MatchStr("*{sEndingBalance1}*", sActual)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate Ending Balance in Account Bar", PASS, "Ending balance - {sEndingBalance1} is displayed")
						[ ] 
					[+] else
						[ ] ReportStatus("Validate Ending Balance in Account Bar", FAIL, "Expected ending Balance - {sEndingBalance1}, Actual ending Balance - {sActual}")
						[ ] 
				[ ] 
				[+] else
					[ ] ReportStatus("Validate DownloadedTransactions tab", FAIL, "DownloadedTransactions tab is not available")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate ImportDownloadedTransactions Window", FAIL, "ImportDownloadedTransactions window is not available") 
		[+] else
			[ ] ReportStatus("Validate Preferences window'", FAIL, "Preferences window is not found") 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# C2R Functionality (Investing) #######################################
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test43_C2RFunctionalityInvesting()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will disable âAutomatically add downloaded transactions to Registersâ checkbox in Quicken Preferences.
		[ ] // Import Investing web connect file and Confirm that transactions are displayed in C2R UI and after accepting all,
		[ ] // transactions are diplayed in register.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 24, 2011	      Mamta Jain 	Created	
	[ ] //*********************************************************
[+] testcase Test43B_C2RFunctionalityInvesting() appstate SmokeBaseState 
	[-] // Variable declaration
		[ ] INTEGER iCreateDataFile,iAccount, iBrokerage,i
		[ ] BOOLEAN bMatch,bFlag
		[ ] STRING sOnlineTransactionDataFile,sFilePath,sFileName,sHandle,sActual,sIndex1,sIndex2, sCaption, sEndingBalance, sExpected, sBrokerageAccountType, sCash,sBrokerageAccount,sStatementEndingDate
	[ ] // Expected Values
	[-] 
		[ ] sFileName = "Vanguard_Investing.qfx"
		[ ] sFilePath = AUT_DATAFILE_PATH + "\WebConnect_Files\" + sFileName
		[ ] sOnlineTransactionDataFile= "OnlineTransactionFile"
		[ ] sEndingBalance = "6,589"
		[ ] sIndex1="#12"
		[ ] sIndex2= "#14"
		[ ] bFlag = TRUE
		[ ] sBrokerageAccountType = "Brokerage"
		[ ] sBrokerageAccount= "Brokerage 01"
		[ ] sStatementEndingDate = "01/01/2011"
		[ ] sCash = "6,575.75"
	[ ] 
	[+] // Pre-requisite
		[ ] // Delete qa_acc32.dll
		[+] if(FileExists (sAccDllDestinationPath))
			[ ] DeleteFile(sAccDllDestinationPath)
		[ ] 
		[ ] //Delete file intu_onl.ini located in WIndows directory
		[+] if(FileExists (SYS_GetEnv("WINDIR") + "\\intu_onl.ini"))
			[ ] DeleteFile(SYS_GetEnv("WINDIR") + "\\intu_onl.ini")
		[ ] 
		[+] if(FileExists(AUT_DATAFILE_PATH + "\" + "{sOnlineTransactionDataFile}.QDF"))
			[ ] DeleteFile(AUT_DATAFILE_PATH + "\" +  "{sOnlineTransactionDataFile}.QDF")
	[ ] 
	[ ] //Create a new data file for Online transaction download
	[-] if (QuickenMainWindow.Exists() == True)
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] iCreateDataFile = DataFileCreate(sOnlineTransactionDataFile)
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sOnlineTransactionDataFile} is created")
		[ ] 
		[-] if(ProductRegistration.Exists())
			[ ] ProductRegistration.Close()
		[ ] // 
	[-] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] // Check if Quicken is launched
	[-] if (QuickenMainWindow.Exists())
		[ ] // Navigate to Edit > Preferences
		[ ] QuickenMainWindow.Edit.Preferences.Pick()
		[ ] 
		[-] if(Preferences.Exists(2))
			[ ] 
			[ ] sHandle = Str(Preferences.SelectPreferenceType.ListBox.GetHandle())
			[ ] sExpected = "Downloaded Transactions"
			[ ] // find the Dowloaded Transaction option in Prefernces window
			[+] for( i = 10; i<=15; i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
				[ ] bMatch = MatchStr("*{sExpected}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] bFlag=TRUE
					[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(i))		// Select Download Transactions option
					[ ] break
				[+] else
					[ ] bFlag = FALSE
					[+] if(i==15)
						[ ] ReportStatus("Validate Download Transaction option'", FAIL, "Download Transaction option is not available") 
					[+] else
						[ ] continue
					[ ] 
			[ ] 
			[ ] // Check the avalability of the checkbox
			[-] if(bFlag== TRUE)
				[-] if(Preferences.AutomaticallyAddDownloadedT.Exists(5))
					[ ] // Check the checkbox if it is unchecked
					[-] if(Preferences.AutomaticallyAddDownloadedT.IsChecked())
						[ ] Preferences.AutomaticallyAddDownloadedT.Uncheck()
						[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Checkbox is unchecked") 
						[ ] 
					[-] else
						[ ] ReportStatus("Disable 'Automatically add downloaded transactions'", PASS, "Checkbox is already unchecked") 
						[ ] 
					[ ] Preferences.OK.Click()
				[-] else
					[ ] ReportStatus("Validate checkbox for Automatic Transaction entry'", FAIL, "Checkbox is not available") 
					[ ] 
			[-] else
				[ ] Preferences.Close()
			[ ] 
		[-] else
			[ ] bFlag = FALSE
			[ ] 
		[ ] 
		[-] if(bFlag == TRUE)
			[ ] // Create Brokerage Account
			[ ] iBrokerage = AddManualBrokerageAccount(sBrokerageAccountType, sBrokerageAccount, sCash, sStatementEndingDate) 
			[ ] ReportStatus("Add Brokerage Account", iBrokerage, "BrokerageAccount -  {sBrokerageAccount} is created")
			[ ] 
			[ ] // Navigate to File > File Import > Web Connect File
			[ ] QuickenMainWindow.File.FileImport.WebConnectFile.Pick()
			[ ] 
			[ ] // Import web connect file
			[-] if(CreateQuickenFile.Exists(3))
				[ ] CreateQuickenFile.SetActive()
				[ ] CreateQuickenFile.FileName.SetText(sFilePath)
				[ ] CreateQuickenFile.OK.Click()
			[-] else
				[ ] ReportStatus("Validate 'Import Web Connect File' Window", FAIL, "'Import Web Connect File' Window is not available") 
				[ ] 
			[ ] 
			[ ] // Messages are displayed then close all dialog boxes
			[+] if (FakeResponse.Exists(15))
				[ ] FakeResponse.Close()
				[ ] LogError("Pre-requisite is failed for Automatic Download Transaction")
			[-] // if(MessageBox.OK.Exists())
				[ ] // MessageBox.OK.Click()
			[-] // if(MessageForWindows.OK.Exists())
				[ ] // MessageForWindows.OK.Click()
			[-] // if(MessageBox.OK.Exists())
				[ ] // MessageBox.OK.Click()
			[-] // if(MessageForWindows.OK.Exists())
				[ ] // MessageForWindows.OK.Click()
			[-] // if(OneStepUpdateSummary.Close.Exists())
				[ ] // OneStepUpdateSummary.Close.Click()
				[ ] 
			[ ] 
			[-] if(ImportDownloadedTransactions.Exists(40))
				[ ] ImportDownloadedTransactions.SetActive()
				[ ] // Select Existing account
				[ ] ImportDownloadedTransactions.Panel2.LinkToAnExistingAccount.Click()
				[ ] // Click on Import
				[ ] ImportDownloadedTransactions.Import.Click()
				[ ] 
				[+] if(OneStepUpdateSummary.Exists(20))
					[ ] OneStepUpdateSummary.SetActive()
					[ ] OneStepUpdateSummary.Close()
				[+] if(FreeUpdateToQuicken.Exists(2))
					[ ] FreeUpdateToQuicken.SetActive()
					[ ] FreeUpdateToQuicken.UpdateLater.Click()
				[ ] 
				[-] if(NewDataDownload.Exists())
					[ ] NewDataDownload.SetActive()
					[ ] NewDataDownload.DownloadedTransactionOptions.Select ("#1")		// Select "Review first" option
					[ ] NewDataDownload.Next.Click()
				[ ] 
				[-] if(BrokerageAccount.wTransaction.DownloadTransactionsTab.Exists ())
					[ ] sCaption = BrokerageAccount.wTransaction.DownloadTransactionsTab.GetCaption ()
					[ ] sExpected = "0"
					[ ] bMatch = MatchStr("*{sExpected}*", sCaption)
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate No. of Transactions", PASS, "No. of Transactions = {sExpected}")
						[ ] 
					[ ] 
					[-] else
						[ ] ReportStatus("Validate No. of Transactions", FAIL, "Expected no. of Transaction - {sExpected}, Actual no. of Transaction - {sCaption}")
						[ ] 
					[ ] 
					[ ] BrokerageAccount.SetActive ()
					[-] if BrokerageAccount.QWSnapHolder1.StaticText1.StaticText2.AcceptAll.Exists()
						[ ] BrokerageAccount.QWSnapHolder1.StaticText1.StaticText2.AcceptAll.Click ()
						[ ] 
						[-] if(AcceptTransaction.Exists(15))
							[ ] AcceptTransaction.SetActive ()
							[ ] sExpected = "Quicken has detected transactions that require additional information before they can be accepted into your account."
							[ ] sActual = AcceptTransaction.Message.GetText()
							[ ] bMatch = MatchStr("*{sExpected}*", sActual)
							[+] if(bMatch == TRUE)
								[ ] ReportStatus("Validate Message", PASS, "Correct message is displayed")
								[ ] 
							[+] else
								[ ] ReportStatus("Validate Message", FAIL, "Expected message - {sExpected}, Actual message - {sActual}")
								[ ] 
							[ ] AcceptTransaction.OK.Click ()
						[-] else
							[ ] ReportStatus("Validate Message box", FAIL, "Message box is not available")
							[ ] 
						[ ] 
						[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
						[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
						[ ] bMatch = MatchStr("*{sEndingBalance}*", sActual)
						[-] if(bMatch == TRUE)
							[ ] ReportStatus("Validate Ending Balance in Account Bar", PASS, "Ending balance - {sEndingBalance} is displayed")
							[ ] 
						[+] else
							[ ] ReportStatus("Validate Ending Balance in Account Bar", FAIL, "Expected ending Balance - {sEndingBalance}, Actual ending Balance - {sActual}")
							[ ] 
				[ ] 
				[+] else
					[ ] ReportStatus("Validate DownloadedTransactions tab", FAIL, "DownloadedTransactions tab is not available")
					[ ] 
				[ ] 
			[+] else
				[ ] ReportStatus("Validate ImportDownloadedTransactions Window", FAIL, "ImportDownloadedTransactions window is not available") 
		[+] else
			[ ] ReportStatus("Validate Preferences window'", FAIL, "Preferences window is not found") 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# Automatically adding Download transactions ###########################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test44_AutomaticAddDownloadTransaction()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Enable âAutomatically add downloaded transactions to Registersâ checkbox in Quicken Preferences.
		[ ] // Import Banking web connect file and Confirm that transactions are directly displayed in Register 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs						
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 19, 2011	      Udita Dube 	Created	
	[ ] //*********************************************************
[+] testcase Test44_AutomaticAddDownloadTransaction() appstate SmokeBaseState
	[-] // Variable declaration
		[ ] INTEGER iCreateDataFile,iAccount, i
		[ ] BOOLEAN bMatch,bFlag
		[ ] STRING sOnlineTransactionDataFile,sFilePath,sFileName,sAccount,sAccountName,sHandle,sActual,sEndingBalance,sIndex1,sIndex2,sDataFilePath, sExpected
	[-] // Expected Values
		[ ] sFileName = "WellsFargo_Checking.qfx"
		[ ] sOnlineTransactionDataFile= "OnlineTransactionFile"
		[ ] sDataFilePath = AUT_DATAFILE_PATH + "\" + sOnlineTransactionDataFile + ".QDF"
		[ ] sFilePath = AUT_DATAFILE_PATH + "\WebConnect_Files\" + sFileName
		[ ] sAccountName="Checking at Wells Fargo"
		[ ] sEndingBalance="130"
		[ ] sIndex1="#12"
		[ ] sIndex2= "#14"
		[ ] 
	[ ] 
	[+] // Pre-requisite
		[ ] // Delete qa_acc32.dll
		[+] if(FileExists (sAccDllDestinationPath))
			[ ] DeleteFile(sAccDllDestinationPath)
		[ ] // Delete file intu_onl.ini located in WIndows directory
		[+] if(FileExists (sDestinationonliniFile))
			[ ] DeleteFile(sDestinationonliniFile)
		[+] // if(FileExists (SYS_GetEnv("WINDIR") + "\\intu_onl.ini"))
			[ ] // DeleteFile(SYS_GetEnv("WINDIR") + "\\intu_onl.ini")
		[ ] // Delete data file if exists
		[+] if(FileExists (sDataFilePath))
			[ ] DeleteFile(sDataFilePath)
	[ ] 
	[ ] //Create a new data file for Online transaction download
	[+] if (QuickenMainWindow.Exists() == True)
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] iCreateDataFile = DataFileCreate(sOnlineTransactionDataFile)
		[ ] ReportStatus("Validate Data File ", iCreateDataFile, "Data file -  {sOnlineTransactionDataFile} is created")
		[ ] 
		[+] if(ProductRegistration.Exists())
			[ ] ProductRegistration.Close()
		[ ] // 
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] // Check if Quicken is launched
	[-] if (QuickenMainWindow.Exists())
		[ ] // Navigate to Edit > Preferences
		[ ] QuickenMainWindow.Edit.Preferences.Pick()
		[ ] 
		[+] if(Preferences.Exists(2))
			[ ] sHandle = Str(Preferences.SelectPreferenceType.ListBox.GetHandle())
			[ ] sExpected = "Downloaded Transactions"
			[ ] // find the Dowloaded Transaction option in Prefernces window
			[+] for( i = 10; i<=15; i++)
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(i))
				[ ] bMatch = MatchStr("*{sExpected}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] bFlag=TRUE
					[ ] QwAutoExecuteCommand("LISTBOX_SELECTROW", sHandle, Str(i))		// Select Download Transactions option
					[ ] break
				[+] else
					[ ] bFlag = FALSE
					[+] if(i==15)
						[ ] ReportStatus("Validate Download Transaction option'", FAIL, "Download Transaction option is not available") 
					[+] else
						[ ] continue
					[ ] 
			[ ] 
			[ ] // Check the avalability of the checkbox
			[+] if(bFlag== TRUE)
				[+] if(Preferences.AutomaticallyAddDownloadedT.Exists(5))
					[ ] // Check the checkbox if it is unchecked
					[+] if(!Preferences.AutomaticallyAddDownloadedT.IsChecked())
						[ ] Preferences.AutomaticallyAddDownloadedT.Check ()
						[ ] ReportStatus("Enable 'Automatically add downloaded transactions'", PASS, "Checkbox is checked") 
					[+] else
						[ ] ReportStatus("Enable 'Automatically add downloaded transactions'", PASS, "Checkbox is already checked") 
					[ ] Preferences.OK.Click()
				[+] else
					[ ] ReportStatus("Validate checkbox for Automatic Transaction entery'", FAIL, "Checkbox is not available") 
			[+] else
				[ ] Preferences.Close()
			[ ] 
		[+] else
			[ ] bFlag= FALSE
		[ ] 
		[-] if(bFlag!= FALSE)
			[ ] // Navigate to File > File Import > Web Connect File
			[ ] QuickenMainWindow.File.FileImport.WebConnectFile.Pick()
			[ ] 
			[ ] // Import web connect file
			[+] if(CreateQuickenFile.Exists(3))
				[ ] CreateQuickenFile.SetActive()
				[ ] CreateQuickenFile.FileName.SetText(sFilePath)
				[ ] CreateQuickenFile.OK.Click()
			[+] else
				[ ] ReportStatus("Validate 'Import Web Connect File' Window", FAIL, "'Import Web Connect File' Window is not available") 
				[ ] 
			[ ] 
			[ ] // Messages are displayed then close all dialog boxes
			[+] if (FakeResponse.Exists(5))
				[ ] FakeResponse.Close()
				[ ] LogError("Pre-requisite is failed for Automatic Download Transaction")
			[+] if(AlertWellsFargoBank.Exists(5))
				[ ] AlertWellsFargoBank.OK.Click()
				[-] if(AlertMessageBox.Exists())
					[ ] AlertMessageBox.OK.Click()
			[+] if(MessageForWindows.Exists(5))
				[ ] MessageForWindows.OK.Click()
				[+] if(OneStepUpdateSummary.Exists())
					[ ] OneStepUpdateSummary.Close.Click()
				[ ] 
			[-] if(MessageBox.OK.Exists(5))
				[ ] MessageBox.OK.Click()
			[-] if(MessageForWindows.OK.Exists())
				[ ] MessageForWindows.OK.Click()
			[-] if(OneStepUpdateSummary.Close.Exists())
				[ ] OneStepUpdateSummary.Close.Click()
				[ ] 
			[ ] 
			[-] if(ImportDownloadedTransactions.Exists(120))
				[ ] ImportDownloadedTransactions.SetActive()
				[ ] // Check if default Account name is not displayed, enter account name in text field
				[ ] sAccount=ImportDownloadedTransactions.Panel2.TextField.GetText()
				[+] if(sAccount=="")
					[ ] ImportDownloadedTransactions.Panel2.TextField.SetText(sAccountName)
				[ ] // Click on Import
				[ ] ImportDownloadedTransactions.Import.Click()
				[ ] 
				[+] if(OneStepUpdateSummary.Exists(20))
					[ ] OneStepUpdateSummary.SetActive()
					[ ] OneStepUpdateSummary.Close()
				[+] if(FreeUpdateToQuicken.Exists(2))
					[ ] FreeUpdateToQuicken.SetActive()
					[ ] FreeUpdateToQuicken.UpdateLater.Click()
				[ ] 
				[ ] //  Verify that Account is shown on account bar
				[ ] sHandle = Str(QuickenMainWindow.QWNavigator.QWNavBtnTray.QWAcctBarHolder.QWListViewer1.ListBox.GetHandle())
				[ ] sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"0")
				[ ] bMatch = MatchStr("*{sAccountName}*{sEndingBalance}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate Accounts in Account Bar", PASS, "{sAccountName} account is available with ending balance - {sEndingBalance}")
				[-] else
					[ ] ReportStatus("Validate Accounts in Account Bar", FAIL, "{sAccountName} account is not available in Account bar")
				[ ] 
			[+] else
				[ ] ReportStatus("Validate ImportDownloadedTransactions Window", FAIL, "ImportDownloadedTransactions window is not available") 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Preferences window'", FAIL, "Preferences window is not found") 
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############## File Backup  ####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test45_FileBackup()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will take a Backup and validate data file backed up successfully message is displayed
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if File backeup is taken successfully			
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 06/01/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test45_FileBackup () appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER iBackupStatus
		[ ] STRING sFilePath,sFileName
	[+] // Expected Values
		[ ] sFileName = "Smoke File.QDF-backup"
		[ ] sFilePath = BACKUP_PATH + "\"                         //BACKUP_PATH is defined in Globals.inc
	[ ] 
	[ ] // Quicken is launched then take the backup of data file
	[+] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] iBackupStatus = QuickenBackup(sFilePath,sFileName)
		[ ] // Report Status after taking file backup
		[+] if (iBackupStatus==PASS)
			[ ] ReportStatus("Validate Quicken Backup ", iBackupStatus, "File -  {sFileName}  is backed up successfully")
		[+] else
			[ ] ReportStatus("Validate Quicken Backup ", iBackupStatus, "File Backup is failed ")
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############## File Restore  ####################################################
	[ ] //*********************************************************
	[+] // TestCase Name:	 Test46_FileRestore()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] // This testcase will restore a backup file and validate that file is restored successfully
		[ ] //
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if File restored successfully			
		[ ] //							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY:	
		[ ] // 06/01/2011  	Created By	Udita Dube
	[ ] //*********************************************************
[+] testcase Test46_FileRestore () appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER iRestoreStatus
		[ ] STRING sFilePath,sFileName
	[+] // Expected Values
		[ ] sFileName = "Smoke File"
		[ ] sFilePath = BACKUP_PATH + "\"                       
	[ ] 
	[ ] // Quicken is launched then restore the backup file
	[+] if (QuickenMainWindow.Exists() == True)
		[ ] 
		[ ] iRestoreStatus = QuickenRestore(sFilePath,sFileName)
		[ ] // Report Status after taking file backup
		[+] if (iRestoreStatus==PASS)
			[ ] ReportStatus("Validate Quicken Backup Restore", iRestoreStatus, "File -  {sFileName}  is restored successfully")
		[+] else
			[ ] ReportStatus("Validate Quicken Backup Restore", iRestoreStatus, "Restore from Backup file is failed ")
		[ ] 
	[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //########## One Step Update  ###################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test47_OneStepUpdate()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify status of One step update operation
		[ ] // and also verify 5 Quotes updated message is displayed in One Step Update summary dialog
    //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while verification 							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 20, 2011		Mamta Jain created	
	[ ] // ********************************************************
[+] testcase Test47_OneStepUpdate() appstate SmokeBaseState
	[+] // Variable declaration
		[ ] INTEGER iNavigate
		[ ] STRING sActual, sExpected, sHandle
		[ ] BOOLEAN bMatch
	[+] // Expected Values
		[ ] sExpected = "5 quotes updated"
	[ ] 
	[ ] // Quicken is launched then restore the backup file
	[+] if (QuickenMainWindow.Exists() == True)
		[ ] QuickenMainWindow.SetActive ()
		[ ] iNavigate = NavigateQuickenTools(TOOLS_ONE_STEP_UPDATE)
		[+] if(iNavigate == PASS)
			[+] if(OneStepUpdate.Exists(20))
				[ ] OneStepUpdate.SetActive ()
				[ ] OneStepUpdate.UpdateNow.Click ()		// click on Update button
				[ ] 
				[+] if(OneStepUpdateSummary.Exists(180))
					[ ] ReportStatus("Validate Window", PASS, "{TOOLS_ONE_STEP_UPDATE} Summary window is displayed") 
					[ ] 
					[ ] // verify 5 quotes update message
					[ ] sHandle = Str(OneStepUpdateSummary.OneStepUpdateSummary1.ListBox1.GetHandle ())
					[ ] sActual = QWAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "0")
					[ ] bMatch = MatchStr("*{sExpected}*", sActual)
					[ ] 
					[+] if(bMatch == TRUE)
						[ ] ReportStatus("Validate message", PASS, "One Step Update message is displayed correctly") 
						[ ] 
					[+] else
						[ ] ReportStatus("Validate message", FAIL, "Expected Message- {sExpected}, is not matching with Actual Message- {sActual}") 
						[ ] 
					[ ] 
					[ ] OneStepUpdateSummary.Close.Click (1, 36, 12)
				[+] else
					[ ] ReportStatus("Validate Window", FAIL, "One Step Update Summary window is not available") 
			[+] else
				[ ] ReportStatus("Validate Window", FAIL, "One Step Update window is not available") 
				[ ] 
		[+] else
			[ ] ReportStatus("Validate Navigation", FAIL, "Some problem occured while navigating to One Step Window") 
			[ ] 
		[ ] 
		[ ] // Report Status if Quicken is not launched
	[+] else
		[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# Verify data conversion ##############################################
	[ ] // ********************************************************
	[-] // TestCase Name:	 Test48_VerifyDataConversion()
		[ ] // 
		[ ] // DESCRIPTION:			
		[ ] //This testcase will validate data conversion and 
		[ ] // Validates net worth balance and file attributes
		[ ] //  
		[ ] // PARAMETERS:			None
		[ ] // 
		[ ] // RETURNS:				Pass 	if old data file coverted and launched without any error					
		[ ] // 							Fail	if any error occurs
		[ ] // 
		[ ] // REVISION HISTORY: 	
		[ ] //  12 Jan, 2011  Udita Dube created
	[ ] // ********************************************************
[+] testcase Test48_VerifyDataConversion() appstate SmokeBaseState
	[-] // Variable declaration
		[ ] BOOLEAN bMatch, sFlag, bSource
		[ ] LIST OF STRING lsActualFileAttribute, lsExpectedFileAttribute, lsFileAttributes
		[ ] INTEGER iCreateDataFile,iRegistration,i,iNavigate,iSwitchState
		[ ] STRING sFileWithPath, sFileName,sExpectedWindow,sCaption,sHandle,sActual,sNetWorth,sNetWorthValue,sTab,sSource,sQuicken2010Source,sQuicken2010File, sMessageCaption
		[ ] 
	[-] // Expected values
		[ ] sFileName= "Gold Master Quicken 2010"
		[ ] //sFileWithPath = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] bSource= FALSE
		[ ] sQuicken2010Source = AUT_DATAFILE_PATH + "\2010_Data\" + sFileName + ".QDF"
		[ ] sQuicken2010File = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
		[ ] sExpectedWindow ="Convert Your Data"
		[ ] sNetWorth ="Net Worth"
		[ ] sNetWorthValue = "549.09"
		[-] if (SKU_TOBE_TESTED == "RPM")
			[ ] lsExpectedFileAttribute = { "2", "81", "2", "4", "5"}
		[+] else
			[ ] lsExpectedFileAttribute = { "2", "80", "2", "4", "5"}
			[ ] 
		[ ] lsFileAttributes = {"Accounts", "Categories", "Memorized Payee", "Securities", "Transactions" }
		[ ] sTab="Property & Debt"
		[ ] //sSource = AUT_DATAFILE_PATH + "\Q10Files\" + sFileName + ".QDF"
		[ ] 
	[ ] 
	[ ] // Pre requisit for the test case
	[-] if(SYS_FileExists(sQuicken2010File))
		[ ] // Delete existing file, if exists
		[ ] DeleteFile(sQuicken2010File)
	[ ] 
	[ ] // Copy last year's data file at given location
	[-] if(SYS_FileExists(sQuicken2010Source))
		[ ] SYS_Execute("attrib -r  {sQuicken2010Source} ")
		[ ] CopyFile(sQuicken2010Source, sQuicken2010File)
		[ ] bSource=TRUE
	[ ] 
	[ ] // Quicken is launched then open Quicken 2010 data file
	[-] if (QuickenMainWindow.Exists() == True && bSource==TRUE)
		[ ] 
		[ ] QuickenMainWindow.SetActive()
		[ ] 
		[ ] // Open Data File
		[-] do
			[ ] QuickenMainWindow.File.OpenQuickenFile.Pick()
		[+] except
			[ ] QuickenMainWindow.TypeKeys("<Ctrl-o>")
		[ ] 
		[ ] CreateQuickenFile.VerifyEnabled(TRUE, 20)
		[ ] CreateQuickenFile.SetActive()
		[ ] CreateQuickenFile.FileName.SetText(sQuicken2010File)
		[ ] CreateQuickenFile.OK.Click()
		[ ] 
		[ ] // If Data Conversion Wizard exists then start conversion
		[-] if(DataConversionWizard.Exists(15))
			[ ] 
			[ ] DataConversionWizard.SetActive()
			[ ] 
			[ ] // Verify window title
			[ ] sCaption=DataConversionWizard.GetCaption()
			[-] if(sCaption==sExpectedWindow)
				[ ] ReportStatus("Validate window title ", PASS, "Window title -  {sExpectedWindow} is correct")
			[+] else
				[ ] ReportStatus("Validate window title ", FAIL, "Actual - {sCaption} is not matching with Expected window title - {sExpectedWindow}")
				[ ] 
			[ ] 
			[ ] // Start file conversion
			[ ] DataConversionWizard.ConvertFile.Click()
			[ ] 
			[ ] sleep (LONG_SLEEP)
			[ ] 
			[-] if(MessageBox.Exists(5))
				[ ] MessageBox.SetActive()
				[ ] sMessageCaption = MessageBox.GetProperty("Caption")
				[-] if(MatchStr("*Adding Features*", sMessageCaption) == TRUE)
					[ ] MessageBox.Close()
					[ ] sFlag=TRUE
				[-] else
					[ ] MessageBox.Yes.Click()
					[ ] sFlag=TRUE
			[ ] sFlag=TRUE
			[ ] 
		[+] else 
			[ ] sFlag=FALSE
			[ ] ReportStatus("Validate Data Conversion wizard ", FAIL, "Data Conversion wizard not found")
		[ ] 
		[ ] QuickenMainWindow.VerifyEnabled(TRUE, 20)
		[ ] 
		[ ] // Verification part will be escaped if Data Conversion wizard has not been found
		[-] if(sFlag!=FALSE)
			[ ] 
			[ ] // Verify converted file is launched
			[ ] sCaption = QuickenMainWindow.GetCaption ()
			[ ] bMatch = MatchStr("*{sExpectedAboutQuicken}*{sFileName}*", sCaption)
			[-] if (bMatch == TRUE)
				[ ] ReportStatus("Verify converted file launched ", PASS, "Converted file is launched successfully") 
			[+] else
				[ ] ReportStatus("Verify that converted file launched ", FAIL, "Actual - {sCaption} is not matching with Expected  - {sExpectedAboutQuicken} {sFileName}") 
			[ ] 
			[ ] QuickenMainWindow.SetActive()
			[+] if(!QuickenMainWindow.View.TabsToShow.PropertyDebt.IsChecked())
				[ ] QuickenMainWindow.View.TabsToShow.PropertyDebt.Pick()
			[ ] 
			[ ] // Turn OFF Popup mode
			[ ] iSwitchState = UsePopupRegister("OFF")
			[ ] ReportStatus("Validate Pop Up", iSwitchState, "Turn off Pop up register mode")
			[ ] 
			[ ] 
			[ ] // Navigate to Property & Debt
			[ ] iNavigate=NavigateQuickenTab(sTab)
			[ ] ReportStatus("Navigate to {sTab} ", iNavigate, "Navigate to {sTab}") 
			[ ] 
			[ ] // Click on Net Worth button
			[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, FALSE)
			[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.NetWorth.Click()
			[ ] Agent.SetOption (OPT_VERIFY_ACTIVE, TRUE)
			[ ] 
			[ ] // Verification for net worth balance
			[ ] // sHandle = Str(PropertyDebt.QWSnapHolder1.NetWorthSnap.QWListViewer1.ListBox1.GetHandle())
			[ ] // sActual= QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,"2")
			[ ] // bMatch = MatchStr("{sNetWorth}*{sNetWorthValue}*", sActual)
			[+] // if(bMatch == TRUE)
				[ ] // ReportStatus("Validate Net Worth Balance", PASS, "{sNetWorth} balance {sNetWorthValue} is correctly displayed")
			[+] // else
				[ ] // ReportStatus("Validate Net Worth Balance", FAIL, "Actual - {sActual} is not matching with Expected {sNetWorth} balance  - {sNetWorthValue}")
			[ ] 
			[ ] // Taking all File Attributes
			[ ] lsActualFileAttribute= QuickenFileAttributes(lsActualFileAttribute)
			[ ] 
			[ ] // Verification of Actual File Attributes
			[+] for (i=1;i<=ListCount(lsActualFileAttribute);i++)
				[ ] 
				[+] if(lsExpectedFileAttribute[i] == lsActualFileAttribute[i])
					[ ] ReportStatus("Validate {lsFileAttributes[i]} count", PASS, "{lsFileAttributes[i]} : Expected - {lsExpectedFileAttribute[i]} is matching with Actual {lsActualFileAttribute[i]}") 
				[+] else
					[ ] ReportStatus("Validate {lsFileAttributes[i]} count", FAIL, "{lsFileAttributes[i]} : Expected - {lsExpectedFileAttribute[i]} is not matching with Actual {lsActualFileAttribute[i]}")
					[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Validate Converted data  file ", FAIL, "Verification not done as converted file is not launched")
			[ ] 
		[ ] 
	[ ] // Report Status 
	[+] else
		[ ] ReportStatus("Validate Quicken Window and 2010 Quicken data file", FAIL, "Either Quicken window Or 2010 Quicken data file is not available") 
		[ ] 
	[ ] 
	[ ] 
[ ] //############################################################################
[ ] 
[+] //############# Check shutdown ##################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test49_ValidateQuickenShutdown()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will close Quicken Main Window
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs closing							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Jan 10, 2011		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase Test49_ValidateQuickenShutdown() appstate SmokeBaseState
	[ ] // Variable declaration
	[ ] INTEGER iValidate
	[ ] 
	[ ] iValidate = CloseQuicken()
	[ ] ReportStatus("Validate Quicken Main Window", iValidate, "Quicken Main Window Close") 
	[ ] 
[ ] //##############################################################################
[ ] 
[ ] //Sandeep: Commenting this testcase as there is no installation setup available on autolab VM.
[ ] //Because of this the testcase was failing when run on autolab.
[+] //############# Checking Re-install scenario #########################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test50_ReinstallQuicken()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will re-install quicken over existing quicken.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while re-installing							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Feb 10, 2011		Mamta Jain created	
	[ ] //*********************************************************
[+] // testcase Test50_ReinstallQuicken() appstate SmokeBaseState
	[ ] // 
	[ ] // // Variable declaration
	[ ] // INTEGER iValidate
	[ ] // STRING sLatest, sSource
	[ ] // BOOLEAN bExists, bActual
	[ ] // INTEGER iSetupAutoAPI
	[ ] // 
	[ ] // sLatest = GetLatestBuild() 								// get latest Build from Source
	[ ] // sSource = INSTALL_BUILD_PATH + "\" + sLatest + "\{SKU_TOBE_TESTED}\DISK1\Setup.exe"
	[ ] // SYS_Execute(sSource + " /s")			// command for installing quicken
	[ ] // 
	[ ] // // Load O/S specific Paths and Variables
	[ ] // LoadOSDependency()
	[ ] // 
	[ ] // sQuickenIniPath=SYS_GetEnv("QuickenIniPath")
	[ ] // sInstallerDirPath=SYS_GetEnv ("InstallerDirPath")
	[ ] // 
	[ ] // // ##### Verify Directories/Files in Quicken Folder
	[ ] // 
	[ ] // bActual = SYS_FileExists(sQuickenIniPath)
	[ ] // bExists =  AssertTrue(bActual)
	[+] // if (bExists == TRUE)
		[ ] // ReportStatus("Validate Quicken.ini", PASS, "Quicken.ini is found in {sQuickenIniPath}") 
	[+] // else
		[ ] // ReportStatus("Validate Quicken.ini", FAIL, "Quicken.ini is not found in {sQuickenIniPath}") 
	[ ] // 
	[ ] // bActual = SYS_DirExists(sInstallerDirPath)
	[ ] // bExists =  AssertTrue(bActual)
	[+] // if (bExists == TRUE)
		[ ] // ReportStatus("Validate Installer Directory", PASS, "Directory - {sInstallerDirPath} is found") 
	[+] // else
		[ ] // ReportStatus("Validate Installer Directory", FAIL, "Directory - {sInstallerDirPath} is not found") 
	[ ] // 
	[ ] // bActual = SYS_FileExists(sQwLogPath)
	[ ] // bExists =  AssertTrue(bActual)
	[+] // if (bExists == TRUE)
		[ ] // ReportStatus("Validate qw.log", PASS, "qw.log file is found at {sQwLogPath}") 
	[+] // else
		[ ] // ReportStatus("Validate qw.log", FAIL, "qw.log file is not found at {sQwLogPath}") 
	[ ] // 
	[ ] // bActual = SYS_FileExists(sExe)
	[ ] // bExists =  AssertTrue(bActual)
	[+] // if (bExists == TRUE)
		[ ] // ReportStatus("Validate qw.exe", PASS, "qw.exe is found at {sExe}") 
	[+] // else
		[ ] // ReportStatus("Validate qw.exe", FAIL, "qw.exe is not found at {sExe}") 
	[ ] // 
	[ ] // bActual = SYS_DirExists(sQsapiDirPath)
	[ ] // bExists =  AssertTrue(bActual)
	[+] // if (bExists == TRUE)
		[ ] // ReportStatus("Validate Qsapi folder", PASS, "Qsapi folder is found at {sQsapiDirPath}") 
	[+] // else
		[ ] // ReportStatus("Validate Qsapi folder", FAIL, "Qsapi folder is not found at {sQsapiDirPath}") 
	[ ] // 
	[ ] // bActual = SYS_FileExists(sSplashPngPath)
	[ ] // bExists =  AssertTrue(bActual)
	[+] // if (bExists == TRUE)
		[ ] // ReportStatus("Validate splash.png", PASS, "splash.png is found at {sSplashPngPath}") 
	[+] // else
		[ ] // ReportStatus("Validate splash.png", FAIL, "splash.png is found at {sSplashPngPath}") 
	[ ] // 
	[ ] // bActual = SYS_FileExists(sQwmainDllPath)
	[ ] // bExists =  AssertTrue(bActual)
	[+] // if (bExists == TRUE)
		[ ] // ReportStatus("Validate qwmain.dl", PASS, "qwmain.dl file is found at {sQwmainDllPath}") 
	[+] // else
		[ ] // ReportStatus("Validate qwmain.dl", FAIL, "qwmain.dl file is not found at {sQwmainDllPath}") 
	[ ] // 
	[ ] // iSetupAutoAPI = SetUp_AutoApi()
	[ ] // ReportStatus("AutoAPI Setup", iSetupAutoAPI, "AutoAPI Setup is completed") 
	[ ] // 
	[ ] // 
[ ] //##############################################################################
[ ] 
[+] //############# Smoke Clean Up##################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 SmokeClean()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will close Quicken, QwAuto window if open.
		[ ] //
		[ ] // PARAMETERS:	none
		[ ] //
		[ ] // RETURNS:			Pass 		if no error occurs while closing the window							
		[ ] //						Fail		if any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //	  Dec 10, 2010		Mamta Jain created	
	[ ] //*********************************************************
[+] testcase SmokeClean() appstate none
	[ ] 
	[-] if(QuickenAutomationInterface.Exists() == TRUE)
		[ ] QuickenAutomationInterface.Close()
	[ ] 
	[-] if(QuickenMainWindow.Exists() == TRUE)
		[ ] QuickenMainWindow.Exit()
[ ] //#############################################################################
[ ] 
[ ] 
