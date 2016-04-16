[ ] // *********************************************************
[+] // FILE NAME:	<CurrencyList.t>
	[ ] //
	[ ] // DESCRIPTION:
	[ ] //   This script contains all Currency List test cases for Quicken Desktop : This will not include QM part and data verification on cloud
	[ ] //
	[ ] // DEPENDENCIES:	includes.inc
	[ ] //
	[ ] // DEVELOPED BY:	Abhishek
	[ ] //
	[ ] // Developed on: 		24/01/2014
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
	[ ] LIST OF ANYTYPE lsListBoxItems, lsCurrencyComboBox
	[ ] INTEGER iResult, iAddTransaction, iValidate, iAddAccount
	[ ] 
	[ ] public INTEGER iSetupAutoAPI ,iCounter,iSelect,iNavigate,  iCount
	[ ] BOOLEAN bMatch, bMatch1, bCheck
	[ ] STRING sMDIWindow = "MDI"
	[ ] 
	[ ] STRING sFileName="CURRENCYLIST_Test"
	[ ] public STRING sDataFile = AUT_DATAFILE_PATH + "\" + sFileName + ".QDF"
	[ ] 
	[ ] STRING sFileName1="CURRENCYLIST_Test2"
	[ ] public STRING sDataFile1 = AUT_DATAFILE_PATH + "\" + sFileName1 + ".QDF"
	[ ] 
	[ ] public STRING sCurrencyListData = "CurrencyList"
	[ ] public STRING sAccountWorksheet = "Account"
	[ ] public STRING sCurrencyWorksheet = "Currency"
	[ ] public STRING sCheckingTransactionWorksheet = "Checking Transaction"
	[ ] public STRING sCurrencyListWorksheet = "Currency List"
	[ ] 
	[ ] 
	[ ] 
	[ ] BOOLEAN bEnabled, bResult, bExist
	[ ] public STRING sActualErrorMsg ,sExpectedErrorMsg,sValidationText,hWnd,sExpected, sActual , sHandle 
	[ ] public STRING   sAccountIntent, sMsg
[ ] 
[ ] 
[+] //############# Curreny list Multicurrency Enable  SetUp #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test1_CurrencyListSetUp()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the  CurrencyList_Test.QDF if it exists. It will setup the necessary pre-requisite for CurrencyList_Test tests
		[ ] //and fnally check the multi currency 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  08, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test1_CurrencyListSetUp() appstate none
	[ ] sAccountIntent="CURRENCY"
	[ ] 
	[ ] 
	[ ] // Read data from excel sheet
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sAccountWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] 
	[+] if(FileExists(sTestCaseStatusFile))
		[ ] DeleteFile(sTestCaseStatusFile)
	[ ] // Load O/S specific paths
	[ ] LoadOSDependency()
	[+]  //########Launch Quicken and open CurrencyList_Test File######################//
		[ ] 
	[ ] iResult=DataFileCreate(sFileName)
	[+] if (iResult==PASS)
		[ ] 
		[ ] // //########Launched Quicken and opened CurrencyList_Test File######################//
		[ ] 
		[ ] ExpandAccountBar()
		[ ] 
		[ ] //############## Create New Checking Account #####################################
		[ ] // Quicken is launched then Add Checking Account
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] 
			[ ] // Add Checking Account
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],sAccountIntent)
			[ ] 
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
			[+] else
				[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
		[ ] // Report Status if Quicken is not launched
		[+] else
			[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] //Navigate to Edit > Preferences > Select Calender & Currency
		[ ] iValidate=SelectPreferenceType("Calendar and currency")
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify Preferences window is present", PASS, "Preferences window  found")
			[ ] //Verify the existing status of the Multicurrency support checkbox
			[ ] bCheck= Preferences.MulticurrencySupport.IsChecked()
			[+] if(bCheck ==FALSE)
				[ ] ReportStatus("Verify Multicurrency is not checked by default", PASS, "MultiCurrency Not enabled by default")
				[ ] //Check multi currency support checkbox and Hit OK
				[ ] Preferences.MulticurrencySupport.Check()
				[ ] Preferences.OK.Click()
				[ ] ReportStatus("Verify Preferences window is present", PASS, "MultiCurrency Enabled")
			[+] else
				[ ] ReportStatus("Verify Multicurrency is not checked by default", FAIL, "MultiCurrency is enabled by default--Please check")
			[ ] WaitForState(Preferences,FALSE,4)
		[+] else
			[ ] ReportStatus("Verify Preferences window is present", FAIL, "Navigation to preferences menu failed")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
		[ ] 
[ ] //############# Test-02 Verify the Currency list can be opened from Menu bar #################################################
[+] //############# Test-03 Verify the Closing of currency Currency list #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test2_CurrencyListOpenAndClose()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the if the Currency list window can be opened from Menu bar 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  10, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[ ] 
[+] testcase Test2_CurrencyListOpenAndClose() appstate CurrencyListBaseState 
	[+] // Variable Declaration
		[ ] 
	[ ] // Verify from Menu
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] QuickenWindow.Tools.click()
		[ ] QuickenWindow.Tools.CurrencyList.Select()
		[ ] //Verify Currency list exists when the multicurrency check is enabled
		[+] if(CurrencyList.Exists(10))
			[ ] WaitForState(CurrencyList,FALSE,5)
			[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", PASS, "Currency List Window opened through menu Tools > Currency List")
			[ ] CurrencyList.Close()
			[+] if(!CurrencyList.Exists(2))
				[ ] ReportStatus("Verify the Currency list can be Closed from Menu bar", PASS, "Currency List Window closed through menu Tools > Currency List")
		[+] else
			[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", FAIL, "Currency List Window Absent")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
	[ ] // Verify from short cut key
	[+] QuickenWindow.Typekeys(KEY_CTRL_Q)
		[+] if(CurrencyList.Exists(10))
			[ ] WaitForState(CurrencyList,FALSE,5)
			[ ] ReportStatus("Verify the Currency list can be opened through  Shortcut Keys", PASS, "Currency List Window opened through  Shortcut Keys")
			[ ] CurrencyList.Typekeys(KEY_ALT_F4)
			[+] if(!CurrencyList.Exists(2))
				[ ] ReportStatus("Verify the Currency list can be Closed through Shortcut Keys", PASS, "Currency List Window closed through  Shortcut Keys")
		[+] else
			[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", FAIL, "Currency List Window Absent")
	[ ] 
	[ ] 
[+] //############# Test-04 Verify US$ is the default home currency#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test3_DefaultHomeCurrency()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the if US$ is the default Home currency for a new Data file
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  10, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test3_DefaultHomeCurrency() appstate CurrencyListBaseState 
	[ ] // Variable Declaration
	[ ]  STRING sHome
	[ ] sHome = "OBJ=1"
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCurrencyWorksheet)
	[ ] // Fetch 2nd row from the given sheet
	[ ] lsCurrency=lsExcelData[2]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Navigate to Tools Mneu > Currency List
		[ ] QuickenWindow.Tools.click()
		[ ] QuickenWindow.Tools.CurrencyList.Select()
		[ ] 
		[+] if(CurrencyList.Exists(10))
			[ ] sHandle = Str(CurrencyList.ListBox.GetHandle ())			// get handle of list box
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, lsCurrency[2])
			[ ] //Check if US$ is the default home currency 
			[+] bMatch = MatchStr("*{sHome}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate US$ is the Home Currency in Currency List", PASS, "US$ is the home currency") 
				[+] else
					[ ] ReportStatus("Validate US$ is the Home Currency in Currency List", FAIL, "US$ is NOT the home currency") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", FAIL, "Currency List Window Absent")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
[ ] 
[ ] 
[ ] //############# Test5_Verify Canadian Dollar is set to Home currency#################################################
[ ] //############# Test_17_Verify home currency is reflected acroos all the reports #################################################
[+] 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test4_HighlightCurrency()	
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the if  Canadian Dollar is set to Home currency 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  14, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test4_HighlightCurrency() appstate CurrencyListBaseState 
	[ ] // Variable Declaration
	[ ]  STRING sHome
	[ ] sHome = "OBJ=1"
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCurrencyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsCurrency=lsExcelData[1]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Navigate to Tools Mneu > Currency List
		[ ] QuickenWindow.Tools.click()
		[ ] QuickenWindow.Tools.CurrencyList.Select()
		[ ] CurrencyList.SetActive()
		[+] if(CurrencyList.Exists(10))
			[ ] //Select CA$ from the currency list list box
			[ ] CurrencyList.ListBox.Select(VAL(lsCurrency[2])+1)
			[ ] CurrencyList.Home.Click()
			[ ] //Set CA$ as the home currency.
			[ ] CurrencyList.HomeSetConfirmation.OK.Click()
			[ ] sHandle = Str(CurrencyList.ListBox.GetHandle ())			// get handle of list box
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, lsCurrency[2])
			[ ] //Match if CA$ is the new home currency
			[+] bMatch = MatchStr("*{sHome}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate CA$ is selected as the Home Currency in Currency List", PASS, "{lsCurrency[1]} is the new home currency") 
				[+] else
					[ ] ReportStatus("Validate CA$ is selected as the Home Currency in Currency List", FAIL, "{lsCurrency[1]} could not be selected as the new home currency") 
			[ ] //Close Currency list window
			[ ] CurrencyList.Close()
			[ ] 
			[ ] //////////////////Verify Currency is reflected in networth report/////////////////////////////
			[ ] //Click reports menu
			[ ] QuickenWindow.Reports.Click()
			[ ] //Select Graph's submenu
			[ ] QuickenWindow.Reports.Graphs.Click()
			[ ] //Select Networth report
			[ ] QuickenWindow.Reports.Graphs.NetWorth.Click()
			[ ] sleep(2)
			[ ] bExist =NetWorthReports.Exists(5)
			[ ] // If Net Worth window is Opened
			[+] if(bExist == TRUE)
				[ ] // Set Activate Net Worth window
				[ ] NetWorthReports.SetActive()
				[+] do
					[ ] // Validate Currency in Networth report
					[ ] NetWorthReports.TextClick("in Canadian Dollars")
					[ ] ReportStatus("Validate Currency in Networth report", PASS, "Currency in networth report is correct- {lsCurrency[1]} ") 
					[ ] NetWorthReports.Close()
				[+] except
					[ ] ReportStatus("Validate Currency in Networth report", FAIL, "Currency in networth report is incorrect, should be {lsCurrency[1]} ") 
		[+] else
			[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", FAIL, "Currency List Window Absent")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
		[ ] 
[+] //############# Test6_Verify only one Home Currency can be selected at a time#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test5_SelectOnlyOneHomeCurrency()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase verifys if only one can be set as Home currency 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  14, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test5_SelectOnlyOneHomeCurrency() appstate CurrencyListBaseState 
	[ ] // Variable Declaration
	[ ] INTEGER iCounter, iCount
	[ ]  STRING sHome
	[ ] sHome = "OBJ=1"
	[ ] iCounter =0
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCurrencyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsCurrency=lsExcelData[1]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Navigate to Tools Mneu > Currency List
		[ ] QuickenWindow.Tools.click()
		[ ] QuickenWindow.Tools.CurrencyList.Select()
		[ ] CurrencyList.SetActive()
		[+] if(CurrencyList.Exists(10))
			[ ] LogException("Setting US$ as the home currency") 
			[ ] CurrencyList.ListBox.Select(36)
			[ ] CurrencyList.Home.Click()
			[ ] CurrencyList.HomeSetConfirmation.OK.Click()
			[ ] //Select CA$ from the drop down list
			[ ] CurrencyList.ListBox.Select(VAL(lsCurrency[2])+1)
			[ ] //Hit OK to set it as the home currency and confirm
			[ ] CurrencyList.Home.Click()
			[ ] CurrencyList.HomeSetConfirmation.OK.Click()
			[ ] 
			[+] for (iCount = 2; iCount <=CurrencyList.ListBox.GetItemCount() ; iCount++) 
				[ ] sHandle = Str(CurrencyList.ListBox.GetHandle ())			// get handle of list box
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, Str(iCount))
				[ ] bMatch = MatchStr("*{sHome}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] //Check only one currency is set as home currency 
					[ ] iCounter = iCounter+1
					[+] if(iCounter == 1)
						[ ] ReportStatus("Verify only one Home Currency can be selected at a time", PASS, "There is only one home currency which is {lsCurrency[1]}") 
					[+] else
						[ ] ReportStatus("Verify only one Home Currency can be selected at a time", FAIL, "More than 1 home currency- Please Check") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", FAIL, "Currency List Window Absent")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
		[ ] 
[ ] //############# Test7_Verify New currency can be added to the existing currency list#################################################
[+] //############# Test8_Verify Added currency can be deleted#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test6_CreateNewCurrency()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify New currency can be added to the existing currency list and deleted.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  14, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test6_CreateNewCurrency() appstate CurrencyListBaseState 
	[ ] // Variable Declaration
	[ ] INTEGER iCounter, icount
	[ ]  STRING sHome
	[ ] sHome = "OBJ=1"
	[ ] iCounter =0
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCurrencyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsCurrency=lsExcelData[3]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Navigate to Tools Mneu > Currency List
		[ ] QuickenWindow.Tools.click()
		[ ] QuickenWindow.Tools.CurrencyList.Select()
		[ ] 
		[ ] CurrencyList.SetActive()
		[+] if(CurrencyList.Exists(10))
			[ ] //Click New to create a new currency
			[ ] CurrencyList.New.Click()
			[ ] if(CurrencyList.SetUpNewCurrency.Exists(5))
			[+] //Set the name of the new currency
				[ ] CurrencyList.SetUpNewCurrency.CurrencyNameTextField.SetText(lsCurrency[1])
				[ ] //Set the currency symbol
				[ ] CurrencyList.SetUpNewCurrency.CurrencySymbolTextField.SetText(lsCurrency[3])
				[ ] //Set the currency code
				[ ] CurrencyList.SetUpNewCurrency.CurrencyCodeTextField.SetText(lsCurrency[4])
				[ ] //Set the Amount per dollar rate for the currency
				[ ] CurrencyList.SetUpNewCurrency.AmtPerTextField.SetText(lsCurrency[5])
				[ ] //Hit OK
				[ ] CurrencyList.SetUpNewCurrency.OK.Click()
			[ ] 
			[+] for (icount = 1; icount <=37 ; icount++) 
				[ ] sHandle = Str(CurrencyList.ListBox.GetHandle ())			// get handle of list box
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  Str(icount))
				[ ] //Check if the currency has been added
				[ ] bMatch = MatchStr("*{lsCurrency[1]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify New currency can be added to the existing currency list", PASS, "New custom currency added successfully")  
					[ ] //Select the added currency
					[ ] CurrencyList.ListBox.Select(icount+1)
					[ ] //Hit Delete button to delete the added currency
					[ ] CurrencyList.Delete.Click()
					[ ] CurrencyList.DeleteCurrencyConfirmation.OK.Click()
					[ ] ReportStatus("Verify Added currency can be deleted", PASS, "Deleted the created currency")  
					[ ] break
				[+] //else
					[ ] //ReportStatus("Verify New currency can be added to the existing currency list", FAIL, "Please Check") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", FAIL, "Currency List Window Absent")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
		[ ] 
[+] //############# Test9_Verify Home currency cannot be deleted #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test7_DeleteHomeCurrency()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the if US$ is the default Home currency for a new Data file
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  10, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test7_DeleteHomeCurrency() appstate CurrencyListBaseState 
	[ ] // Variable Declaration
	[+]  STRING sHome
		[ ] sHome = "OBJ=1"
		[ ] sMsg = "Cannot delete home currency."
		[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCurrencyWorksheet)
		[ ] // Fetch 1st row from the given sheet
		[ ] lsCurrency=lsExcelData[2]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Navigate to Tools Mneu > Currency List
		[ ] QuickenWindow.Tools.click()
		[ ] QuickenWindow.Tools.CurrencyList.Select()
		[+] if(CurrencyList.Exists(10))
				[ ] sHandle = Str(CurrencyList.ListBox.GetHandle ())			// get handle of list box
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, lsCurrency[2])
				[ ] bMatch = MatchStr("*{sHome}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate US$ is the Home Currency in Currency List", PASS, "US$ is the home currency") 
				[+] else
					[ ] LogException("Setting US$ as the home currency") 
					[ ] CurrencyList.ListBox.Select(36)
					[ ] CurrencyList.Home.Click()
					[ ] CurrencyList.HomeSetConfirmation.OK.Click()
				[ ] //Selct US$ from the currency list box 
				[ ] CurrencyList.ListBox.Select(36)
				[ ] //Delete the home currency
				[ ] CurrencyList.Delete.Click()
				[ ] CurrencyList.HomeSetConfirmation.OK.Click()
				[ ] //Validate the message that home currency cannot be deleted
				[ ] sValidationText= CurrencyList.CannotDeleteHomeCurrencyConfirmation.CannotDeleteHomeCurrency.GetText()
				[ ] bMatch1=MatchStr("*{sMsg}*" , sValidationText)
				[+] if (bMatch1)
					[ ] ReportStatus(" Verify Home currency cannot be deleted", PASS, "Validation message: {sValidationText} appeared as expected: {sMsg}") 
				[+] else
					[ ] ReportStatus(" Verify Home currency cannot be deleted", FAIL, "Validation message: {sValidationText} didn't appear as expected: {sMsg}") 
				[ ] CurrencyList.CannotDeleteHomeCurrencyConfirmation.OK.Click()
				[ ] 
				[ ] 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", FAIL, "Currency List Window Absent")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
		[ ] 
[+] //############# Test10_Verify existing currency can be edited#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test8_EditExistingCurrency()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the if US$ is the default Home currency for a new Data file
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  10, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test8_EditExistingCurrency() appstate CurrencyListBaseState 
	[ ] // Variable Declaration
	[ ]  STRING sHome
	[ ] INTEGER icount
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCurrencyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsCurrency=lsExcelData[4]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Navigate to Tools Mneu > Currency List
		[ ] QuickenWindow.Tools.click()
		[ ] QuickenWindow.Tools.CurrencyList.Select()
		[ ] CurrencyList.SetActive()
		[ ] 
		[+] if(CurrencyList.Exists(10))
			[ ] //Select/Highlight the currency
			[ ] CurrencyList.ListBox.Select(VAL(lsCurrency[2])+1)
			[ ] //Hit edit currency button
			[ ] CurrencyList.Edit.Click()
			[+] if(CurrencyList.EditCurrency.Exists(5))
				[ ] //Edit the currency name
				[ ] CurrencyList.EditCurrency.CurrencyNameTextField.SetText(lsCurrency[1])
				[ ] //Edit the Currency Symbol
				[ ] CurrencyList.EditCurrency.CurrencySymbolTextField.SetText(lsCurrency[3])
				[ ] //Edit the Amount per currency text field
				[ ] CurrencyList.EditCurrency.AmtPerTextField.SetText(lsCurrency[5])
				[ ] //Hit OK
				[ ] CurrencyList.EditCurrency.OK.Click()
				[ ] //for (icount = 1;  icount <=5 ; icount++) 
				[ ] sHandle = Str(CurrencyList.ListBox.GetHandle ())			// get handle of list box
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  lsCurrency[2])
				[ ] //Match the edited fields and verify the details are edited successfully
				[ ] bMatch = MatchStr("*{lsCurrency[1]}*{lsCurrency[3]}*{lsCurrency[4]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify the existing currency list can be successfully edited", PASS, "Existing currency can be edited")  
				[+] else
					[ ] ReportStatus("Verify the existing currency list can be successfully edited", FAIL, "Existing currency Cannot  be edited  Actual: {sActual}, Expected: {lsCurrency[1]} {lsCurrency[3]} {lsCurrency[4]}") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", FAIL, "Currency List Window Absent")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
		[ ] 
[+] //############# Test11_Verify currency exchange rates can be updated #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test10_UpdateCurrencyExchangeRates()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the if  Canadian Dollar is set to Home currency 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  14, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test10_UpdateCurrencyExchangeRates() appstate CurrencyListBaseState 
	[ ] // Variable Declaration
	[ ] INTEGER iCounter, icount
	[ ]  STRING sHome
	[ ] sMsg = "Currency exchange rates updated"
	[ ] iCounter =0
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCurrencyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsCurrency=lsExcelData[3]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Navigate to Tools Mneu > Currency List
		[ ] QuickenWindow.Tools.click()
		[ ] QuickenWindow.Tools.CurrencyList.Select()
		[ ] CurrencyList.SetActive()
		[+] if(CurrencyList.Exists(10))
			[ ] //Click Update Button
			[ ] CurrencyList.Update.Click()
			[+] if(OneStepUpdateSummary.Exists(20))
				[ ] //Verify the currency rates are updated
				[ ] OneStepUpdateSummary.SetActive()
				[ ] sHandle = Str(OneStepUpdateSummary.ListBox.GetHandle ())			// get handle of list box
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, "3")
				[ ] bMatch = MatchStr("*{sMsg}*", sActual)
				[ ] 
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify currency exchange rates can be updated", PASS, "Currency exchange rates updated successfully")  
				[+] else
					[ ] ReportStatus("Verify currency exchange rates can be updated", FAIL, "Currency exchange rates NOT updated--Please check") 
				[ ] OneStepUpdateSummary.Close.Click()
		[+] else
			[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", FAIL, "Currency List Window Absent")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
[ ] 
[ ] //#############Test12_Verify 'use' functionality of Multicurrency#################################################
[ ] //############# Test_16_Verify the set Currency is reflected in Spendings tab#################################################
[+] 
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test11_UseCurrency()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will delete the  CurrencyList_Test.QDF if it exists. It will setup the necessary pre-requisite for CurrencyList_Test tests
		[ ] //and fnally check the Use currency functionality and Verify the set Currency is reflected in Spendings tab
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If no error occurs while deleting file							
		[ ] //						Fail		If any error occurs
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  08, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
		[ ] // ********************************************************
		[ ] 
	[ ] 
[+] testcase Test11_UseCurrency() appstate none
	[ ] //INTEGER iSetupAutoAPI
	[ ] sAccountIntent="CURRENCY"
	[ ] // Read data from Account Worksheet
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sAccountWorksheet)
	[ ] // Fetch 1st row from the gven sheet
	[ ] lsAddAccount=lsExcelData[1]
	[ ] // Read data from Checking Transactions worksheet 
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCheckingTransactionWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsTransactionData=lsExcelData[1]
	[ ] // Read data from Currency worksheet 
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCurrencyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsCurrency=lsExcelData[1]
	[ ] 
	[+] // if(FileExists(sFileName1))
		[ ] // DeleteFile(sFileName)
	[+]  //########Launch Quicken and open CurrencyList_Test File######################//
		[ ] 
	[ ] iResult=DataFileCreate(sFileName1)
	[+] if (iResult==PASS)
		[ ] 
		[ ] // //########Launched Quicken and opened CurrencyList_Test File######################//
		[ ] ExpandAccountBar()
		[ ] 
		[ ] //############## Create New Checking Account #####################################
		[ ] // Quicken is launched then Add Checking Account
		[+] if (QuickenWindow.Exists(5))
			[ ] QuickenWindow.SetActive()
			[ ] QuickenWindow.Edit.Click()
			[ ] QuickenWindow.Edit.Preferences.Select()
			[+] if(Preferences.Exists(4))
				[ ] Preferences.SelectPreferenceType1.ListBox.Select(4)
				[ ] ReportStatus("Verify Preferences window is present", PASS, "Preferences window  found")
				[ ] Preferences.MulticurrencySupport.Check()
				[ ] Preferences.OK.Click()
				[ ] ReportStatus("Verify Preferences window is present", PASS, "MultiCurrency Enabled")
			[ ] 
			[ ] // Add Checking Account
			[ ] iAddAccount = AddManualSpendingAccount(lsAddAccount[1], lsAddAccount[2], lsAddAccount[3], lsAddAccount[4],sAccountIntent)
			[ ] 
			[ ] // Report Status if checking Account is created
			[+] if (iAddAccount==PASS)
				[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is created successfully")
				[ ] iSelect = AccountBarSelect(ACCOUNT_BANKING, 1)
				[+] if(iSelect==PASS)
					[ ] ReportStatus("Select Account", PASS, "Account {lsTransactionData[10]} is selected") 
				[+] else
					[ ] ReportStatus("Select Account", FAIL, "Account {lsTransactionData[10]} is NOT selected") 
				[ ] 
				[ ] //Add a Transation to the account
				[ ] iAddTransaction= AddCheckingTransaction(lsTransactionData[1],lsTransactionData[2], lsTransactionData[3], lsTransactionData[4],lsTransactionData[5],lsTransactionData[6],lsTransactionData[7],lsTransactionData[8])
				[+] if(iAddTransaction==PASS)
					[ ] ReportStatus("Add Transaction", iAddTransaction, "{lsTransactionData[2]} Transaction of Amount {lsTransactionData[3]} is added") 
					[ ] //Select the added transatction
					[ ] MDIClient.AccountRegister.TxList.SetFocus()
					[ ] MDIClient.AccountRegister.SearchWindow.SetText(lsTransactionData[6])
					[ ] MDIClient.AccountRegister.TxList.TypeKeys(KEY_UP)
					[ ] //Navigate to Tools Mneu > Currency List
					[ ] QuickenWindow.Tools.click()
					[ ] QuickenWindow.Tools.CurrencyList.Select()
					[+] if(CurrencyList.Exists(10))
						[ ] //Select CA$ from the currency list list box
						[ ] CurrencyList.ListBox.Select(VAL(lsCurrency[2])+1)
						[ ] CurrencyList.Home.Click()
						[ ] //Set CA$ as the home currency.
						[ ] CurrencyList.HomeSetConfirmation.OK.Click()
						[ ] //Select the currency to be used
						[ ] CurrencyList.ListBox.Select(15)
						[ ] //Hit 'Use' Button
						[ ] CurrencyList.Use.Click()
						[ ] //Find the transaction with the currency changed and validate
						[ ] iValidate = FindTransaction("MDI", lsTransactionData[11])		// find transaction
						[+] if(iValidate == PASS)
							[ ] ReportStatus("Validate Transaction to check if the currency is converted", iValidate, "Transaction with Input - {lsTransactionData[11]} is found") 
						[+] else
							[ ] ReportStatus("Validate Transaction to check if the currency is converted", iValidate, "Transaction with Input - {lsTransactionData[11]} is not found") 
						[ ] //////////////////Verify Currency reflected in networth report/////////////////////////////
						[ ] iNavigate = NavigateQuickenTab(sTAB_SPENDING)
						[+] do
							[ ] // Validate Currency onSpendings tab
							[ ] MDIClientSpending.SpendingWindow.ExamineYourSpending.Panel.TextClick("C$")
							[ ] ReportStatus("Verify the set Currency is reflected in Spendings tab", PASS, "	Currency is same as Home currency which is {lsCurrency[1]} ") 
						[+] except
							[ ] ReportStatus("Verify the set Currency is reflected in Spendings tab", FAIL, "Currency is NOT same as Home currency, Should be {lsCurrency[1]} ") 
						[+] iNavigate = NavigateQuickenTab(sTAB_HOME)
										[ ] 
						[ ] 
						[ ] 
			[+] else
				[ ] ReportStatus("{lsAddAccount[1]} Account", iAddAccount, "{lsAddAccount[1]} Account -  {lsAddAccount[2]}  is not created")
				[ ] 
		[ ] // Report Status if Quicken is not launched
		[+] else
			[ ] ReportStatus("Validate Quicken Window", FAIL, "Quicken is not available") 
		[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
		[ ] 
[+] //############# Test_13_Verify 'Cancel' and 'Help' button functionality on Set Home Currency confirmation dialog #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test12_CancelAndHelpHomeCurrency()	
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify the if  Canadian Dollar is set to Home currency 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  14, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test12_CancelAndHelpHomeCurrency() appstate CurrencyListBaseState 
	[ ] // Variable Declaration
	[ ]  STRING sHome
	[ ] sHome = "OBJ=1"
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCurrencyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsCurrency=lsExcelData[1]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Navigate to Tools Mneu > Currency List
		[ ] QuickenWindow.Tools.click()
		[ ] QuickenWindow.Tools.CurrencyList.Select()
		[ ] CurrencyList.SetActive()
		[ ] LogException("Setting US$ as the home currency") 
		[ ] CurrencyList.ListBox.Select(36)
		[ ] CurrencyList.Home.Click()
		[ ] CurrencyList.HomeSetConfirmation.OK.Click()
		[+] if(CurrencyList.Exists(10))
			[ ] //Select CA$ from the currency list list box
			[ ] CurrencyList.ListBox.Select(VAL(lsCurrency[2])+1)
			[ ] CurrencyList.Home.Click()
			[ ] //Set CA$ as the home currency.
			[+] if(CurrencyList.HomeSetConfirmation.Exists(5))
				[ ] ReportStatus("Set Home currency confirmation dialog", PASS, "Set Home currency confirmation dialog Present")
				[ ] CurrencyList.HomeSetConfirmation.Help.Click()
				[ ] //Verify if Quicken Help window appeared
				[+] if (QuickenHelp.Exists(10))
					[ ] ReportStatus("Verify Quicken Help menu", PASS, "Help menu opened.")
					[ ] //Close Help Menu=========================================================================
					[ ] QuickenHelp.Close()
					[ ] WaitForState(QuickenHelp,FALSE,5)
				[+] else
					[ ] ReportStatus("Verify Quicken Help menu", PASS, "Help menu Did not open.")
				[ ] //Hit on Cancel button on the set home currency confirmation dialog
				[ ] CurrencyList.HomeSetConfirmation.Cancel.Click()
				[ ] sHandle = Str(CurrencyList.ListBox.GetHandle ())			// get handle of list box
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, lsCurrency[2])
				[ ] //Match if CA$ is the new home currency
				[+] bMatch = MatchStr("*{sHome}*", sActual)
					[+] if(bMatch == FALSE)
						[ ] ReportStatus("Validate CA$ is not selected as the new Home Currency in Currency List", PASS, "{lsCurrency[1]} has not been set as the new home currency") 
					[+] else
						[ ] ReportStatus("Validate CA$ is selected as the Home Currency in Currency List", FAIL, "{lsCurrency[1]} has been set as the new home currency, which is n ot expected") 
			[+] else
				[ ] ReportStatus("Set Home currency confirmation dialog", FAIL, "Set Home currency confirmation dialog absent")
		[+] else
			[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", FAIL, "Currency List Window Absent")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
		[ ] 
[ ] 
[+] //############# Test_14_Verify Multicurrency support cannot be unchecked when home currency is not US$ #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test13_MultiCurrencySupportUncheck()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify if the Multicurrency support cannot be unchecked when US$ is not the home currency.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  29, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test13_MultiCurrencySupportUncheck() appstate CurrencyListBaseState 
	[ ] // Variable Declaration
	[ ]  STRING sHome
	[ ] sHome = "OBJ=1"
	[ ] sMsg = "Please delete all foreign accounts and securities"
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCurrencyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsCurrency=lsExcelData[1]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Navigate to Tools Mneu > Currency List
		[ ] QuickenWindow.Tools.click()
		[ ] QuickenWindow.Tools.CurrencyList.Select()
		[ ] CurrencyList.SetActive()
		[+] if(CurrencyList.Exists(10))
			[ ] //Select CA$ from the currency list list box
			[ ] CurrencyList.ListBox.Select(VAL(lsCurrency[2])+1)
			[ ] CurrencyList.Home.Click()
			[ ] //Set CA$ as the home currency.
			[ ] CurrencyList.HomeSetConfirmation.OK.Click()
			[ ] 
			[ ] sHandle = Str(CurrencyList.ListBox.GetHandle ())			// get handle of list box
			[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle, lsCurrency[2])
			[ ] //Match if CA$ is the new home currency
			[+] bMatch = MatchStr("*{sHome}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Validate CA$ is selected as the Home Currency in Currency List", PASS, "{lsCurrency[1]} is the new home currency")
					[ ] CurrencyList.Close()
				[+] else
					[ ] ReportStatus("Validate CA$ is selected as the Home Currency in Currency List", FAIL, "{lsCurrency[1]} could not be selected as the new home currency") 
		[+] else
			[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", FAIL, "Currency List Window Absent")
		[ ] //Navigate to Edit > Preferences > Select Calender & Currency
		[ ] iValidate=SelectPreferenceType("Calendar and currency")
		[+] if(iValidate==PASS)
			[ ] ReportStatus("Verify Preferences window is present", PASS, "Preferences window  found")
			[ ] //Verify the existing status of the Multicurrency support checkbox
			[ ] bCheck= Preferences.MulticurrencySupport.IsChecked()
			[+] if(bCheck ==TRUE)
				[ ] ReportStatus("Verify Multicurrency is not checked by default", PASS, "MultiCurrency Not enabled by default")
				[ ] //Check multi currency support checkbox and Hit OK
				[ ] Preferences.MulticurrencySupport.Click()
				[ ] Preferences.OK.Click()
				[ ] ReportStatus("Verify Preferences window is present", PASS, "MultiCurrency Disabled")
			[+] if (AlertMessage.Exists(5))
				[ ] AlertMessage.SetActive()
				[ ] //Validate the message that home currency cannot be deleted
				[ ] sValidationText= AlertMessage.MessageText.GetText()
				[ ] bMatch1=MatchStr("*{sMsg}*" , sValidationText)
				[+] if (bMatch1)
					[ ] ReportStatus(" Verify Multicurrency support cannot be unchecked when home currency is not US$", PASS, "Validation message: {sValidationText} is appearing as expected: {sMsg}") 
					[ ] AlertMessage.OK.Click()
					[ ] QuickenWindow.Tools.click()
					[ ] QuickenWindow.Tools.CurrencyList.Select()
					[ ] //Verify Currency list exists when the multicurrency check is enabled
					[+] if(CurrencyList.Exists(10))
						[ ] WaitForState(CurrencyList,FALSE,5)
						[ ] ReportStatus("Verify the Currency list is still available after attempting to uncheck", PASS, "Currency List Window is available through menu Tools > Currency List")
					[+] else
						[ ] ReportStatus("Verify the Currency list is still available after attempting to uncheck", FAIL, "Currency List Window is not available through menu Tools > Currency List, Looks like MultiCurrency support is unchecked though US$ is not the home currency")
					[ ] 
				[+] else
					[ ] ReportStatus(" Verify Multicurrency support cannot be unchecked when home currency is not US$", FAIL, "Validation message: {sValidationText} didn't appear as expected: {sMsg}") 
				[ ] 
			[+] else
				[ ] ReportStatus("Verify Multicurrency is not checked by default", FAIL, "MultiCurrency is enabled by default--Please check")
			[ ] WaitForState(Preferences,FALSE,4)
		[+] else
			[ ] ReportStatus("Verify Preferences window is present", FAIL, "Navigation to preferences menu failed")
			[ ] 
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
		[ ] 
[+] //#############Test_15_Verify currency dropdown on Add Account window #################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test14_CurrencyDropDownAccountCreation()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will verify if Verify currency dropdown on Add Account window 
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  29, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[-] testcase Test14_CurrencyDropDownAccountCreation() appstate QuickenBaseState 
	[ ] // Variable Declaration
	[ ]  STRING sHome
	[ ] INTEGER i, icount, icount1
	[ ] sHome = "OBJ=1"
	[ ] sMsg = "Please delete all foreign accounts and securities"
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCurrencyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsCurrency=lsExcelData[1]
	[ ] 
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCurrencyListWorksheet)
	[ ] lsCurrencyComboBox=lsExcelData[1]
	[ ] 
	[+] 
		[ ] //############## Create New Checking Account #####################################
		[ ] // Quicken is launched then Add Checking Account
	[-] if (QuickenWindow.Exists(5))
		[ ] ExpandAccountBar()
		[ ] QuickenWindow.SetActive()
		[ ] ExpandAccountBar()
		[ ] QuickenWindow.SetActive()
		[ ] QuickenMainWindow.QWNavigator.QWNavBtnTray.AddAnAccount.DoubleClick()
		[ ] 
		[-] if (AddAccount.Exists(30))
			[ ] AddAccount.SetActive()
			[ ] //Select Chrcking for Account type
			[ ] AddAccount.Checking.Click()
			[ ] WaitForState(AddAnyAccount.Panel.QWHtmlView1,TRUE,700)
			[-] if(AddAnyAccount.Exists(SHORT_SLEEP) && AddAnyAccount.IsEnabled())
				[ ] ADDACC:
				[ ] AddAnyAccount.SetActive()
				[ ] AddAnyAccount.Panel.QWHtmlView1.Click (1, 62, 5)
				[ ] //Select "I want to enter my transactions manually" radio button
				[ ] AddAnyAccount.AddCheckingAccount.Select("I want to enter my transactions manually")
				[ ] WaitForState(AddAnyAccount.Next,true,2)
				[ ] //Hit next
				[ ] AddAnyAccount.Next.Click()
				[ ] //Verify the Currency drop down has all the currencies specified
				[ ] lsActualCurrencyListIComboBoxtems= AddAnyAccount.WhatCurrencyWouldYouLikeToUseForThisAccountComboBox.GetContents()
				[+] for (icount= 1; icount <= listCount(lsCurrencyComboBox); icount++) 
					[ ] bMatch= MatchStr("*{(lsCurrencyComboBox[icount])}*", lsActualCurrencyListIComboBoxtems[icount])
					[+] if (bMatch==TRUE)
						[ ] ReportStatus("Verify currency dropdown on Add Account window", PASS, "{lsActualCurrencyListIComboBoxtems[icount]} Expected currency values are available in Currency List combobox..{lsCurrencyComboBox[icount]} ") 
					[+] else
						[ ] ReportStatus("Verify currency dropdown on Add Account window", FAIL, "  {lsActualCurrencyListIComboBoxtems[icount]} Expected currency values are option is not available in Currency List combobox..{lsCurrencyComboBox[icount]} ") 
				[ ] //Hit next and finish to create an account
				[ ] AddAnyAccount.Next.Click()
				[ ] AddAnyAccount.Next.Click()
				[ ] AddAnyAccount.close()
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
		[ ] 
[+] //############# Test_18_Verify New, Edit and Delete functionality using right click menus#################################################
	[ ] // ********************************************************
	[+] // TestCase Name:	 Test15_CurrencyRightClickMenus()
		[ ] //
		[ ] // DESCRIPTION:
		[ ] // This testcase will Verify New currency can be added to the existing currency list and deleted using rightclick menu.
		[ ] //
		[ ] // PARAMETERS:		None
		[ ] //
		[ ] // RETURNS:			Pass 		If returns the existence of options true						
		[ ] //						Fail		If returns the existence of options false	
		[ ] //
		[ ] // REVISION HISTORY:
		[ ] //Date                             April  14, 2014		
		[ ] //Author                          Abhishek 	
		[ ] 
	[ ] // ********************************************************
[+] testcase Test15_CurrencyRightClickMenus() appstate CurrencyListBaseState 
	[ ] // Variable Declaration
	[ ] INTEGER iCounter, icount
	[ ] BOOLEAN bSelect
	[ ]  STRING sHome
	[ ] sHome = "OBJ=1"
	[ ] iCounter =0
	[ ] lsExcelData=ReadExcelTable(sCurrencyListData, sCurrencyWorksheet)
	[ ] // Fetch 1st row from the given sheet
	[ ] lsCurrency=lsExcelData[3]
	[ ] 
	[+] if(QuickenWindow.Exists(5))
		[ ] QuickenWindow.SetActive()
		[ ] //Navigate to Tools Mneu > Currency List
		[ ] QuickenWindow.Tools.click()
		[ ] QuickenWindow.Tools.CurrencyList.Select()
		[ ] 
		[ ] CurrencyList.SetActive()
		[+] if(CurrencyList.Exists(10))
			[ ] //#######################Click New to create a new currency using right click menu######################################
			[ ] CurrencyList.ListBox.Select(1)
			[ ] Sleep(3)
			[ ] //Right Click on the Currency list 
			[ ] CurrencyList.ListBox.Click(2)
			[ ] Sleep(3)
			[ ] //Click 'New' from the Menu obtained
			[ ] //CurrencyList.ListBox.New.Click()
			[ ] CurrencyList.ListBox.Click(2,50,132)
			[ ] 
			[ ] if(CurrencyList.SetUpNewCurrency.Exists(5))
			[+] //Set the name of the new currency
				[ ] CurrencyList.SetUpNewCurrency.CurrencyNameTextField.SetText(lsCurrency[1])
				[ ] //Set the currency symbol
				[ ] CurrencyList.SetUpNewCurrency.CurrencySymbolTextField.SetText(lsCurrency[3])
				[ ] //Set the currency code
				[ ] CurrencyList.SetUpNewCurrency.CurrencyCodeTextField.SetText(lsCurrency[4])
				[ ] //Set the Amount per dollar rate for the currency
				[ ] CurrencyList.SetUpNewCurrency.AmtPerTextField.SetText(lsCurrency[5])
				[ ] //Hit OK
				[ ] CurrencyList.SetUpNewCurrency.OK.Click()
			[ ] 
			[+] for (icount = 1; icount <=37 ; icount++) 
				[ ] sHandle = Str(CurrencyList.ListBox.GetHandle ())			// get handle of list box
				[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  Str(icount))
				[ ] //Check if the currency has been added
				[ ] bMatch = MatchStr("*{lsCurrency[1]}*", sActual)
				[+] if(bMatch == TRUE)
					[ ] ReportStatus("Verify New currency can be added to the existing currency list", PASS, "New custom currency added successfully through right click menu")  
					[ ] 
					[ ] //###########################Edit currency using right click menu####################3##############
					[ ] //Select/Highlight the currency
					[ ] //Hit edit currency button
					[ ] Sleep(3)
					[ ] //Right Click on the Currency list 
					[ ] //CurrencyList.ListBox.TextClick("{lsCurrency[1]}")
					[ ] CurrencyList.ListBox.Click(2,50,132)
					[ ] Sleep(3)
					[ ] CurrencyList.ListBox.Edit.Click(1)
					[+] if(CurrencyList.EditCurrency.Exists(5))
						[ ] //Edit the currency name
						[ ] CurrencyList.EditCurrency.CurrencyNameTextField.SetText(lsCurrency[1])
						[ ] //Edit the Currency Symbol
						[ ] CurrencyList.EditCurrency.CurrencySymbolTextField.SetText(lsCurrency[3])
						[ ] //Edit the Amount per currency text field
						[ ] CurrencyList.EditCurrency.AmtPerTextField.SetText(lsCurrency[5])
						[ ] //Hit OK
						[ ] CurrencyList.EditCurrency.OK.Click()
						[ ] 
						[ ] sHandle = Str(CurrencyList.ListBox.GetHandle ())			// get handle of list box
						[ ] sActual = QwAutoExecuteCommand("LISTBOX_GETFULLROW", sHandle,  lsCurrency[2])
						[ ] //Match the edited fields and verify the details are edited successfully
						[ ] bMatch = MatchStr("*{lsCurrency[1]}*{lsCurrency[3]}*{lsCurrency[4]}", sActual)
						[+] if(bMatch == TRUE)
							[ ] ReportStatus("Verify the existing currency list can be successfully edited", PASS, "Existing currency can be edited through right click menu")  
						[+] else
							[ ] ReportStatus("Verify the existing currency list can be successfully edited", FAIL, "Existing currency Cannot  be edited  Actual: {sActual}, Expected: {lsCurrency[1]} {lsCurrency[3]} {lsCurrency[4]}") 
				[+] 
					[ ] //#############################################
					[ ] //Select Highlight the currency
					[ ] //Hit Delete currency button
					[ ] Sleep(3)
					[ ] //Right Click on the Currency list 
					[ ] //CurrencyList.ListBox.TextClick("{lsCurrency[1]}")
					[ ] CurrencyList.ListBox.Click(2,50,132)
					[ ] Sleep(3)
					[ ] CurrencyList.ListBox.Delete.Click(1)
					[ ] CurrencyList.DeleteCurrencyConfirmation.OK.Click()
					[ ] ReportStatus("Verify Added currency can be deleted", PASS, "Deleted the created currency")  
					[ ] break
				[+] //else
					[ ] //ReportStatus("Verify New currency can be added to the existing currency list", FAIL, "Please Check") 
			[ ] 
		[+] else
			[ ] ReportStatus("Verify the Currency list can be opened from Menu bar", FAIL, "Currency List Window Absent")
	[+] else
		[ ] ReportStatus("Verify datafile {sFileName} created ", FAIL, "Verify datafile {sFileName} created: Datafile {sFileName} couldn't be created ") 
		[ ] 
